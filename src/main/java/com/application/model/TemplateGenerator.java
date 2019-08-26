package com.application.model;

import org.json.XML;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import java.io.*;
import java.util.*;

import static java.io.File.separator;

public class TemplateGenerator {

    private String filePath;
    private String outputDir;
    private String outputFiles;
    private long timeMilli;

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getOutputDir() {
        return outputDir;
    }

    public void setOutputDir(String outputDir) {
        this.outputDir = outputDir;
    }

    public String getOutputFiles() {
        return outputFiles;
    }

    public void setOutputFiles(String outputFiles) {
        this.outputFiles = outputFiles;
    }

    public long getTimeMilli() {
        return timeMilli;
    }

    public void setTimeMilli(long timeMilli) {
        this.timeMilli = timeMilli;
    }


    /** This function used to convert xml to string **/
    private String Xml2String(String filePath) {
        String XmlData="";
        try {
            File file = new File(filePath);
            Reader fileReader = new FileReader(file);

            BufferedReader bufReader = new BufferedReader(fileReader);
            StringBuilder stringBuilder = new StringBuilder();
            String line = bufReader.readLine();

            while( line != null)  {
                stringBuilder.append(line).append("\n");
                line = bufReader.readLine();
            }

            bufReader.close();
            XmlData = stringBuilder.toString();

        }
        catch (Exception error) {
            error.printStackTrace();
        }
        return XmlData;

    }

    /** This function is used to check whether input in JSONArray else it typecast to JSONArray **/
    private JSONArray checkJsonArray(Object tempObj) {
        if(tempObj instanceof JSONObject) {
            JSONArray temp = new JSONArray();
            temp.add(tempObj);
            return temp;
        }
        return (JSONArray)tempObj;
    }

    /** This function create key-value pair like "jsonTemplate name"--"key in jsonTemplate"  :: Refer the jsoninputObj**/
    private Map<String,JSONArray> getJsonFromTemplate(JSONObject inputObj) {
        JSONArray jsonTemplate = (JSONArray) ( (JSONObject) ( (JSONObject) inputObj.get("security") ).get("jsontemplates") ).get("jsontemplate");
        Map<String,JSONArray> template = new HashMap();
        for(int itr=0; itr<jsonTemplate.size(); itr++) {
            JSONObject tempObj = (JSONObject) jsonTemplate.get(itr);
            template.put((String) tempObj.get("name"), checkJsonArray(tempObj.get("key"))  );
        }
        return template;
    }

    /** It is used to update the template object using JsonTemplate Map object generated from "getJsonFromTemplate" function **/
    private void updateTemplateJsonTemplate(String streamTemplate, Map<String,JSONArray> jsonTemplate, JSONObject template) {
        JSONArray key = jsonTemplate.get(streamTemplate);
        for(int itr=0; itr<key.size(); itr++) {
            JSONObject keyObj = (JSONObject)key.get(itr);
            String type = (String) keyObj.get("type");
            if(type==null) {
                template.put(keyObj.get("name"), keyObj.get("regex"));
                //tempSet.add((String) keyObj.get("regex"));
            }
            else if(type.contentEquals("JSONArray") || type.contentEquals("JSONObject")) {
                updateTemplateJsonTemplate((String) keyObj.get("template"), jsonTemplate, template);
            }
            else {
                template.put(keyObj.get("name"), type);
                //tempSet.add(type);
            }
        }
    }

    /** It is used to update the template object for param attributes **/
    private void updateTemplateParam( JSONObject template, JSONArray param) {
        for(int itr=0; itr<param.size(); itr++) {
            String key = (String) ( (JSONObject) param.get(itr) ).get("name");
            String value;
            value = (String) ( (JSONObject) param.get(itr) ).get("type");
            if(value==null) {
                value = (String) ( (JSONObject) param.get(itr) ).get("regex");
            }
            template.put(key,value);
            //tempSet.add(value);
        }
    }

    /** This function is used to update the template object for inputstream attributers **/
    private void updateTemplateInputStream(JSONObject template, JSONArray inputStream, Map<String,JSONArray> jsonTemplate) {

        for(int itr=0; itr<inputStream.size(); itr++) {
            String streamTemplate = (String) ( (JSONObject) inputStream.get(itr) ).get("template");
            String type = (String) ( (JSONObject) inputStream.get(itr) ).get("type");
            updateTemplateJsonTemplate(streamTemplate, jsonTemplate, template);
        }
    }

    /** This is the main function to update the template object **/
    private void updateTemplate(String key, JSONObject template, JSONObject urlArrayObj, Map<String,JSONArray> jsonTemplate) {
        try {
            Object obj = urlArrayObj.get(key);     /** It will result in error if the key is not available **/
            if(key=="param") {
                JSONArray param = checkJsonArray(urlArrayObj.get(key));
                updateTemplateParam(template,param);
            }
            else if(key=="inputstream") {
                JSONArray inputStream = checkJsonArray(urlArrayObj.get(key));
                updateTemplateInputStream(template,inputStream,jsonTemplate);
            }
        }
        catch (Exception e) {
        }
    }

    /** The main execution starts from this function **/
    private void createCases(JSONObject inputObj, String outputDir) {

        /** If there is only one "urls" then it will be JSONObject instead of JSONArray so we need to convert it**/
        JSONArray urls = checkJsonArray( ( (JSONObject) inputObj.get("security") ).get("urls") );

        // Set<String> tempSet = new HashSet();

        /** Iterating main url **/
        for (int urlsItr = 0; urlsItr < urls.size(); urlsItr++) {
            JSONObject urlsObj = (JSONObject) urls.get(urlsItr);

            /** Storing urlsObj key-value pair **/
            String prefix = (String) urlsObj.get("prefix");
            prefix = prefix.replaceAll("/","_");
            new File(outputDir+separator+prefix).mkdirs();

            /** Similarly if there is only one "url" then it will be JSONObject we need to convert it into JSONArray **/
            JSONArray urlArray = checkJsonArray( urlsObj.get("url") );

            /** Iterating sub url with info **/
            for (int urlArrayItr = 0; urlArrayItr < urlArray.size(); urlArrayItr++) {
                LinkedHashMap jo = new LinkedHashMap();
                JSONObject urlArrayObj = (JSONObject) urlArray.get(urlArrayItr);

                /** Storing urlArrayObj key-value pair **/
                String path = (String) urlArrayObj.get("path");
                String method = (String) urlArrayObj.get("method");

                /** Creating template for all parameters **/
                JSONObject template = new JSONObject();

                Map<String,JSONArray> jsonTemplate = getJsonFromTemplate(inputObj);
                updateTemplate("param",template,urlArrayObj,jsonTemplate);
                updateTemplate("inputstream",template,urlArrayObj,jsonTemplate);
                if(template.size()!=0) {
                    jo.put("Link", path);
                    jo.put("Template", template);
                    jo.put("TestCases", new JSONArray());
                    TestCaseGenerator testCaseGenerator = new TestCaseGenerator();
                    testCaseGenerator.setNewObject(true);
                    testCaseGenerator.createTestCases(jo,path,outputDir+separator+prefix,method);
                }
            }
        }
    }

    public void generate(String fileName) {

        String inputDirLocation = this.getFilePath();
        String outputDirLocation = this.getOutputFiles() + "outputJSON" + separator;
        String inputXmlPath = inputDirLocation + fileName;

        /** Converting input XML file to JSON **/
        String xml_data = Xml2String(inputXmlPath);
        String jsonString = XML.toJSONObject(xml_data).toString();
        JSONObject inputObj = new JSONObject();
        try {
            JSONParser parser = new JSONParser();
            inputObj = (JSONObject) parser.parse(jsonString);
        } catch (Exception e) {
            e.printStackTrace();
        }

        //clearDirectory(outputDir);
        createCases(inputObj, outputDirLocation);
    }
}
