package com.application.servlet;

import java.io.*;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static com.application.servlet.ProcessServlet.cookieVector;
import static com.application.servlet.ProcessServlet.deleteDirectory;
import static java.io.File.separator;

public class DownloadFileServlet extends HttpServlet {


    /** Deleting Unused zip file more than one day **/
    private void deleteUnwantedZip() {
        int vectorItr = 0;
        while(vectorItr<cookieVector.size()) {
            Cookie cookie = cookieVector.get(vectorItr);
            if( (new Date().getTime()- Long.valueOf(cookie.getValue()) ) > 86400000 ) {
                deleteDirectory(new File(new File(System.getProperty("user.dir")).getParent()+separator+"webapps"+separator+"TestEnumerator"+separator+"conf"+separator+"outputZip"+separator+cookie.getValue()+separator));
                deleteDirectory(new File(new File(System.getProperty("user.dir")).getParent()+separator+"webapps"+separator+"TestEnumerator"+separator+"conf"+separator+"inputJSON"+separator+cookie.getValue()+separator));
                cookieVector.remove(cookie);
                cookie.setMaxAge(0);
            }
            else {
                vectorItr++;
            }
        }

    }

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response) throws ServletException, IOException {

        Cookie[] cookie = request.getCookies();
        String timeMilli = null;
        for(int i=0;i<cookie.length;i++) {
            if(cookie[i].getName().contentEquals("time")) {
                timeMilli = cookie[i].getValue();
                cookieVector.remove(cookie[i]);
                cookie[i].setMaxAge(0);
                break;
            }
        }


        String filePath = new File(System.getProperty("user.dir")).getParent()+separator+"webapps"+separator+"TestEnumerator"+separator+"conf"+separator+"outputZip"+separator+timeMilli+separator+"out.zip";
        File downloadFile = new File(filePath);
        if(!downloadFile.exists()) {
            downloadFile.createNewFile();
        }
        FileInputStream inStream = new FileInputStream(downloadFile);
        ServletContext context = getServletContext();

        // gets MIME type of the file
        String mimeType = context.getMimeType(filePath);
        if (mimeType == null) {
            // set to binary type if MIME mapping not found
            mimeType = "application/octet-stream";
        }

        // modifies response
        response.setContentType(mimeType);
        response.setContentLength((int) downloadFile.length());

        // forces download
        String headerKey = "Content-Disposition";
        String headerValue = String.format("attachment; filename=\"%s\"", downloadFile.getName());
        response.setHeader(headerKey, headerValue);

        // obtains response's output stream
        OutputStream outStream = response.getOutputStream();

        byte[] buffer = new byte[4096];
        int bytesRead = -1;

        while ((bytesRead = inStream.read(buffer)) != -1) {
            outStream.write(buffer, 0, bytesRead);
        }

        inStream.close();
        outStream.close();
        deleteDirectory(new File(new File(System.getProperty("user.dir")).getParent()+separator+"webapps"+separator+"TestEnumerator"+separator+"conf"+separator+"outputZip"+separator+timeMilli+separator));
        deleteUnwantedZip();
    }
}
