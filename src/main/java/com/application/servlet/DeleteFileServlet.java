package com.application.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static java.io.File.separator;

public class DeleteFileServlet extends HttpServlet {

    private boolean deleteDirectory(File dir)
    {
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

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response) throws ServletException, IOException {
        String zipDir = new File(System.getProperty("user.dir")).getParent()+separator+"webapps"+separator+"TestEnumeratorXml"+separator+"out"+separator;
        response.getWriter().println("It is deleting" + deleteDirectory(new File(zipDir)));
        //deleteDirectory(new File(zipDir));
        response.sendRedirect("");

    }
}
