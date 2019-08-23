package com.application.model;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;

public class Downloader {
    private File downloadFile;
    private FileInputStream inStream;
    private OutputStream outStream;

    public File getDownloadFile() {
        return downloadFile;
    }

    public void setDownloadFile(File downloadFile) {
        this.downloadFile = downloadFile;
    }

    public FileInputStream getInStream() {
        return inStream;
    }

    public void setInStream(FileInputStream inStream) {
        this.inStream = inStream;
    }

    public OutputStream getOutStream() {
        return outStream;
    }

    public void setOutStream(OutputStream outStream) {
        this.outStream = outStream;
    }
}
