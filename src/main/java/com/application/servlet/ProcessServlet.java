package com.application.servlet;

import java.io.*;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.application.model.TemplateGenerator;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.zeroturnaround.zip.ZipUtil;

import static java.io.File.separator;

public class ProcessServlet extends HttpServlet {

    private static int MAXFILESIZE = 500* 1024;
    private static int MAXMEMSIZE = 500* 1024;
    public static Vector<Cookie> cookieVector = new Vector<Cookie>();

    private static void clearDirectory(String outputDir){
        File file = new File(outputDir);
        String[] myFiles;
        if(file.isDirectory()){
            myFiles = file.list();
            for (int i=0; i<myFiles.length; i++) {
                File myFile = new File(file, myFiles[i]);
                myFile.delete();
            }
        }
    }

    private static void zipFolder(String zipDir,String outputDir) {
        ZipUtil.pack(new File(zipDir), new File(outputDir+"out.zip"));
    }

    public static boolean deleteDirectory(File dir) {
        if(!dir.exists()) {
            return true;
        }
        if (dir.isDirectory()) {
            File[] children = dir.listFiles();
            for (int i = 0; i < children.length; i++) {
                boolean success = deleteDirectory(children[i]);
                if (!success) {
                    return false;
                }
            }
        }
        return dir.delete();
    }

    private String uploadInputFile(String filePath,HttpServletRequest request, HttpServletResponse response) {
        new File(filePath).mkdirs();
        response.setContentType("text/html");
        DiskFileItemFactory factory = new DiskFileItemFactory();
        /** maximum size that will be stored in memory **/
        factory.setSizeThreshold(MAXMEMSIZE);
        // Location to save data that is larger than MAXMEMSIZE.
        //factory.setRepository(new File(new File(System.getProperty("user.dir")).getParent()+separator+"webapps"+separator+"TestEnumerator"+separator+"conf"+separator+"excess"));
        /** Create a new file upload handler **/
        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setSizeMax(MAXFILESIZE);

        File file ;
        try {
            List fileItems = upload.parseRequest(request);
            Iterator i = fileItems.iterator();
            String fileName = "";
            while (i.hasNext()) {
                FileItem fi = (FileItem) i.next();
                if (!fi.isFormField()) {
                    fileName = fi.getName();
                    if (fileName.lastIndexOf("\\") >= 0) {
                        file = new File(filePath + fileName.substring(fileName.lastIndexOf("\\")));
                    } else {
                        file = new File(filePath + fileName.substring(fileName.lastIndexOf("\\") + 1));
                    }
                    fi.write(file);
                }
            }
            return fileName;
        }
        catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }

    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) {

        /** Creating Object for Generator Class **/
        TemplateGenerator templateGenerator = new TemplateGenerator();

        /** Setting the variables in generator object **/
        templateGenerator.setTimeMilli(new Date().getTime());
        templateGenerator.setFilePath(new File(System.getProperty("user.dir")).getParent() + separator + "webapps" + separator + "TestEnumerator" + separator + "conf" + separator + "inputJSON" + separator + templateGenerator.getTimeMilli() + separator);
        templateGenerator.setOutputDir(new File(System.getProperty("user.dir")).getParent() + separator + "webapps" + separator + "TestEnumerator" + separator + "conf" + separator + "outputZip" + separator + templateGenerator.getTimeMilli() +separator);
        templateGenerator.setOutputFiles(new File(System.getProperty("user.dir")).getParent() + separator + "webapps" + separator + "TestEnumerator" + separator + "conf" + separator + "out" + separator + templateGenerator.getTimeMilli() + separator);

        /** Creating Cookies which expires after two days**/
        Cookie cookie = new Cookie("time",String.valueOf(templateGenerator.getTimeMilli()));
        cookie.setMaxAge(2 * 24 * 3600);
        response.addCookie(cookie);
        cookieVector.add(cookie);

        /** Calling the main function of Generator Class **/
        /** uploadInputFile returns the name of input file **/
        templateGenerator.generate(uploadInputFile(templateGenerator.getFilePath(),request,response));

        /** Creating the directory where output zip file will be stored **/
        new File(templateGenerator.getOutputDir()).mkdirs();

        /** Zipping the output file from outputFiles and storing the zip in outputDir directory **/
        zipFolder(templateGenerator.getOutputFiles(), templateGenerator.getOutputDir());

        /** Deleting the input file directory and output files stored directory **/
        deleteDirectory(new File(templateGenerator.getOutputFiles()));
        deleteDirectory(new File(templateGenerator.getFilePath()));

    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, java.io.IOException {

    }
}


