
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="themes/css/bootstrap.css"/>
    </head>
    <style>
        body
        {
            font-family:"Trebuchet MS",Helvetica,sans-serif;
            overflow:hidden;
        }
        #error
        {
            color:red;
        }
        #success
        {
            color:green;
        }
        .btn.btn-info:disabled
        {
            background: linear-gradient(180deg,#979797,white);
            color: black;
            border-color: #f2f2f2;
        }
        a.btn.btn-info[disabled="disabled"] 
        {
            background: linear-gradient(180deg,#979797,white);
            color: black;
            border-color: #f2f2f2;
        }
    </style>
    <script type="text/javascript">
        function loading()
        {
            var loadingDiv=document.getElementById("loadingDiv");
            loadingDiv.style.display="inline";            
            var getDiffBtn=document.getElementById("getDiffBtn");
            getDiffBtn.setAttribute("disabled", "disabled");
            var outputTime=document.getElementById("outputTime");
            outputTime.InnerHTML="";
        }
        function stopLoading()
        {
            var loadingDiv=document.getElementById("loadingDiv");
            loadingDiv.style.display="none";
            var getDiffBtn=document.getElementById("getDiffBtn");
            getDiffBtn.removeAttribute("disabled");            
        }
    </script>
    <body>
       <div class="container-fluid">
    <div class="row">
            <div class="col-md-10 col-md-offset-1">
            <br/>
            <div class="row">
                <div id="loadingDiv" style="display:none">
                    <div class="col-md-1 col-md-offset-2"><img alt="Looading..."  id="loader" class="img-circle" src="images/loading.gif"/></div>
                    <div class="col-md-7"><p id="notification" style="color:red">This may take a few moments to generate Testcase...Please Wait...</p></div>
                </div>
                        <div id="status" class="col-sm-offset-2 form-group">
                            <div class="col-sm-9">
                                    <div id="error" class="col-sm-offset-3">
                                            <img src="images/error_icon.png" style="float:left;padding-right:1%;padding-top:1%;"/>
                                            <p></p>
                                    </div>
                                    <div id="success" class="col-sm-offset-1">
                                            <img src="images/success_icon.png" style="float:left;margin-left:5%;padding-right:1%;padding-top:0.5%;"/>
                                            <p></p>
                                    </div>
                            </div>
                        </div>
            </div>

            <br/>
             <div style="background-color:#f5f5f5;background-size:100% 50%;padding-top:3%;border-radius:6px;width:65%;"class="col-sm-offset-2">

                    <div class="row" style="padding-left:0%">
                            <div id="formDiv">
                                    <br/>
                                    <form  method='post' enctype='multipart/form-data' id='fileForm' target='uploader_iframe' class='form-horizontal col-sm-12' role='form'>
                                        <div id='file_form'>
                                                <div class='col-sm-offset-1'>
                                                    <div class='form-group col-sm-12'>
                                                        <label class='col-sm-2 control-label'>Input file:</label>
                                                        <div>
                                                            <input type='file' id='file1' name='file1' style='display:none'/>
                                                            <button type='button' style='float:left;' class='col-sm-offset-1 btn btn-info btn-sm' id='fileBtn1'>Browse</button>
                                                            &nbsp&nbsp&nbsp<label id='filePath1' style='width:50%;height:50%;color:#6D7B8D;'>Browse Your File Here...</label>
                                                            <label id='error1'/>
                                                        </div>
                                                    </div>
                                            </div>
                                            <div class='form-group'>
                                                <div class='col-md-offset-4 col-md-8'>
                                                    <button type='submit' style='float:left;' class='btn btn-info btn-sm active' id='getDiffBtn'>Generate TestCase</button>
                                                    <div class='resultBtns'>
                                                        <button disabled style='margin-left:2%'type='button' class='btn btn-info btn-sm active' id='diffBtn'>Download Zip</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                            </div>
                    </div>
        </div>
            <!-- <div class="modal fade" id="mailAlert" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-sm">
                            <div class="modal-content">
                                    <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                            <h4 class="modal-title" id="myModalLabel">Mail Status</h4>
                                    </div>
                                    <div class="modal-body">
                                            <p id="mailStatus"></p>
                                    </div>
                                     <div class="modal-footer">
                                            <button type="button" class="btn btn-info" data-dismiss="modal">Close</button>
                                            <button type="button" class="btn btn-info" data-dismiss="modal" id="BackToForm">Back To Form</button>
                                    </div>
                            </div>
                    </div>
            </div>        -->                               
            <div class="modal fade" id="mailForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
                    <div class="modal-dialog">
                            <div class="modal-content">
                                    <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                            <h4 class="modal-title" id="myModalLabel">E-Mail Statement</h4>
                                    </div>
                                    <div class="modal-body">
                                            <label id="outputTime" style="display:none"></label>
                                            <br/>
                                            <div class="form-group row col-sm-offset-1">
                                                            <label class="col-sm-2 control-label">To:</label>
                                                            <div class="col-sm-8">
                                                                            <input type="text"  class="form-control" id="recipient" placeholder="Reciepient Mail Id">
                                                            </div>
                                            </div>
                                            <div class="form-group row col-sm-offset-1">
                                                            <label class="col-sm-2 control-label">Subject:</label>
                                                            <div class="col-sm-8">
                                                              <input type="text"  class="form-control" id="subject" placeholder="Subject">
                                                            </div>
                                            </div>
                                    </div>
                                    <div class="modal-footer">
                                            <button type="button" class="btn btn-info" data-dismiss="modal">Close</button>
                                            <button type="button" class="btn btn-info" data-dismiss="modal" id="mailSendBtn">Send</button>
                                    </div>
                            </div>
                    </div>
            </div>
            <br/>
            <div style="background-color:#f5f5f5;background-size:100% 50%;padding-top:3%;border-radius:6px;width:65%;"class="col-sm-offset-2">
                    <div class="row">
                            <ol style="margin-left:1%">
                                    <li>Browse the input file</li>
                                    <li>Click ' Generate TestCase ' Button</li>
                                    <li>Wait for some time</li>
                                    <li>Click on ' Download Zip ' Button to download output zip</li>
                            </ol>
                    </div>
            </div>
            <iframe id="uploader_iframe" name="uploader_iframe" style="display: none;"></iframe>
        </div>
        </div>
        
    </div>
    </body>
 <script  src="js/jquery-1.11.0.min.js"></script>
    <script src="js/bootstrap.js"></script>
    
    <script>
            function displayForm()
            {
                if($('#file').is(':checked'))
                {
                    var formContent="<br/><form method='post' enctype='multipart/form-data' id='fileForm' target='uploader_iframe' class='form-horizontal col-sm-12' role='form'><div id='file_form'><div class='col-sm-offset-1'><div class='form-group col-sm-12'><label class='col-sm-2 control-label'>File 1:</label><div>\n\
            <input type='file' id='file1' name='file1' style='display:none'/>\n\
            <button type='button' style='float:left;' class='col-sm-offset-1 btn btn-info btn-sm' id='fileBtn1'>Browse</button>\n\
       &nbsp&nbsp&nbsp<label id='filePath1' style='width:50%;height:50%;color:#6D7B8D;'>Browse Your File Here...<\label><label id='error1'/>\n\
 </div></div>\n\
        <div class='form-group col-sm-12'><label class='col-sm-2 control-label'>File 2:</label><div>\n\
        <input type='file' id='file2' name='file2' style='display:none'/><button type='button' style='float:left;' class='col-md-offset-1 btn btn-info btn-sm' id='fileBtn2'>Browse</button>\n\
&nbsp&nbsp&nbsp<label id='filePath2' style='width:50%;height:50%;color:#6D7B8D;'>Browse Your File Here...<\label>\n\
<label id='error2'/>\n\
</div></div></div><div class='form-group'><div class='col-md-offset-4 col-md-8'><button type='submit' style='float:left;' class='btn btn-info btn-sm active' id='getDiffBtn'>Get Diff</button><div class='resultBtns'><button disabled style='margin-left:2%'type='button' class='btn btn-info btn-sm active' id='diffBtn'>View Diff</button></div></div></div></form>";
                    $("#formDiv").html(formContent);
                }
                hideResult();
            }
            $(document).on("click","#fileBtn1",function(){
                $("#file1").trigger("click");
            });

            $(document).on("change","#file1",function(){
                            document.getElementById("filePath1").style.color = "#6D7B8D";
                document.getElementById('filePath1').innerHTML = ($('#file1').val());
                                hideResult();
                                
            });
                        
            function hideResult()
            {
               
                $("#success").hide();
                $("#error").hide();
                $("#status").hide();
                // $("#emailDiffBtn").attr('disabled','disabled');
                // $("#exportDiffBtn").attr('disabled','disabled');
                //                 $("#exportDiffBtn1").attr('disabled','disabled');
                // $("#diffBtn").attr('disabled','disabled');
                               
                               
            }

            function setBack()
            {
                
                 document.getElementById("url1").className = "form-control";
            }


            if(typeof String.prototype.trim !== 'function')
            {
                String.prototype.trim = function() {
                    return this.replace(/^\s+|\s+$/g, '');
                };
            }

            $(document).ready(function() {
                    hideResult();
            });           

            $(document).on("click", "#getDiffBtn", function()
            {
                    var option=$("input[type='radio'][name='option']:checked").val();
                    hideResult();
                    loading();
                    

                    var isFirefox = typeof InstallTrigger !== 'undefined';
                    var isIE = false || !!document.documentMode;
                    if(!isIE&&!isFirefox)//isChrome !== null && isChrome !== undefined && vendorName === "Google Inc.")
                    {
                            $('#fileForm').submit();
                    }
                
            });
                
            $(document).on("submit",'#fileForm',function(e)
            {

                    var value1=$('#file1').val();
                    var type = value1.substring(value1.length - 3);
                    
                    if(value1 == null || value1 == "")
                    {

                        stopLoading();
                            var sameURL="";
                            document.getElementById("filePath1").style.color = "red";
                            document.getElementById('filePath1').innerHTML = "Field Should not be empty";
                            $('#error p').html(sameURL);
                          
                            $('#status').show();
                    }
                    else if(type != "xml" )
                    {
                        
                        stopLoading();
                       document.getElementById("filePath1").style.color = "red";
                      
                            var sameURL="Enter a Xml File...";
                            $('#error p').html(sameURL);
                            $('#error').show();
                            $('#status').show();
                    }
                    

                  else
                    {

                            $.ajax({
                              type: 'POST',
                              data: new FormData( this ),
                              url: 'Process',
                              mimeType:'multipart/form-data',
                              processData: false,
                              contentType: false,
                              cache: false,
                              success:function(data)
                              {
                                    stopLoading();
                                    document.getElementById("getDiffBtn").setAttribute("disabled","disabled");
                                    document.getElementById("diffBtn").removeAttribute("disabled");
                                }
                            });

                    }
            });

            $(document).on("click","#diffBtn",function()
            {
        
                stopLoading();
                document.getElementById("diffBtn").setAttribute("disabled","disabled");
                window.location = "DownloadFileServlet";
                 
            });



    </script>
</html>
<!-- $Id$ -->