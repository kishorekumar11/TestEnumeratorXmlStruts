<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles" %>
<%@ page import="com.me.commonutil.server.alert.AlertValidation" %>
<%@ page import="com.me.commonutil.server.DemoUtil" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <script src="js/jquery-1.11.0.js"></script>
        <script src="js/jquery-1.11.0.min.js"></script>
        <script src="js/bootstrap.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <link rel="stylesheet" type="text/css" href="themes/css/bootstrap.css"/>
        <style>
            .dropbtn {
                background-color: #ffffff;
                color: white;
                font-size: 16px;
                cursor: pointer;
            }
            .dropbtn:focus,
            .dropbtn:hover {
                background-color: #eeeeee;
            }
            .dropdown {
                position: relative;
                display: inline-block;
            }
            .dropdown-content {
                display: none;
                position: absolute;
                background-color: #fffeee;
                font: Serif;
                width: 1000px;
                font-size: 15px;
                z-index: 1;
            }
            .dropdown-content li {
                color: black;
                padding: 4px;
                text-decoration: none;
                display: block;
                position: relative;
            }
            .show {
                display: block;
            }
            .hide {
                display: none;
            }
        </style>

        <script type="text/javascript">
            function showDropDown() {
                document.getElementById("myDropdown").classList.toggle("show"); //No I18N
            }

            // Close the dropdown if the user clicks outside of it
            window.onclick = function (event) {
                if (!event.target.matches('.dropbtn') && event.target.id == "") { //No I18N
                    document.getElementById("myDropdown").style.display = "none";
                    document.getElementById("myDropdown").classList.remove("show");
                }
            }
        </script>
    </head>
    <body>
        <div class="container-fluid">
            <div class="dropdown" id="dropDownMenu">

                <button onclick="showDropDown()" class="dropbtn btn" id="dropbtn"><img src="/images/menu-list.jpg" height="40" width="40" id="menu"/></button>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="/" title="Home Page"><img src="/images/logo.png"/></a>

                <div id="myDropdown" class="dropdown-content">
                    <table class="table table-striped" id="dropTable">
                        <tr class="success" id="head">
                            <td align="center" id="test" colspan="3" style="width:100%">
                                <h4 align="center" id="test1">DC TOOLS</h4>
                            </td>
                        </tr>
                        <tr>
                          <td id="heading">
                              <ol>
                                  <li id="li1">
                                      <button class="btn" style="background-color:#fffeee" onclick="location.href = '/DuplicateClassTool'"><img src="/images/tools.ico" height="30" width="30"/>&nbsp;&nbsp;DUPLICATE CLASS FINDER</button>
                                  </li>
                                  <li id="li2">
                                      <button class="btn" style="background-color:#fffeee" onclick="location.href = '/SigCheckTool'"><img src="/images/systemmanager.png" height="30" width="30"/>&nbsp;&nbsp;SIGN CHECK</button>
                                  </li>
                                  <li id="li3">
                                      <button class="btn" style="background-color:#fffeee" onclick="location.href = '/dbvisualizer'"><img src="/images/visualize.png" height="30" width="30"/>&nbsp;&nbsp;DBVISUALIZER</button>
                                  </li>
                                  <li id="li4">
                                      <button class="btn" style="background-color:#fffeee" onclick="location.href = '/PPMAutomationTool'"><img src="/images/ppmauto.png" height="30" width="30"/>&nbsp;&nbsp;PPM Automation Tool</button>
                                  </li>
                                  <li id="li5">
                                      <button class="btn" style="background-color:#fffeee" onclick="location.href = '/WarrantyChecker'"><img src="/images/warranty.png" height="30" width="30"/>&nbsp;&nbsp;WARRANTY CHECKER TOOL</button>
                                  </li>
                              </ol>
                          </td>
                            <td id="heading">
                                <ol>
							         <li id="li6">
                                        <button class="btn" style="background-color:#fffeee" onclick="location.href = '/CrashFileAnalysis'"><img src="/images/CrashFileAnalysis.png" height="30" width="30"/>&nbsp;&nbsp;Crash File Analysis</button>
                                    </li>

									<li id="li7">
                                        <button class="btn" style="background-color:#fffeee" onclick="location.href = '/AWSImageCreation'"><img src="/images/aws.png" height="30" width="30"/>&nbsp;&nbsp;AWS ImageCreation</button>
                                    </li>
                                    <li id="li8">
                                        <button class="btn" style="background-color:#fffeee" onclick="location.href = '/DDDiff'"><img src="/images/dddiff.png" height="30" width="30"/>&nbsp;&nbsp;DD Difference Finder</button>
                                    </li>
                                    <li id="li9">
                                        <button class="btn" style="background-color:#fffeee" onclick="location.href = '/KeyDifferences'"><img src="/images/key.png" height="30" width="30"/>&nbsp;&nbsp;KEY DIFFERENCES TOOL</button>
                                    </li>
                                    <li id="li10">
                                        <button class="btn" style="background-color:#fffeee" onclick="location.href = '/ImageAnalysis'"><img src="/images/image-analysis.png" height="30" width="30"/>&nbsp;&nbsp;IMAGE ANALYSIS TOOL</button>

                                    </li>
                                </ol>
                            </td>
                            <td id="heading">
                                <ol>

                                    <li id="li11">
                                        <button class="btn" style="background-color:#fffeee" onclick="location.href = '/RadTool'"><img src="/images/rad.png" height="30" width="30"/>&nbsp;&nbsp;RAD TOOL</button>
                                    </li>

									<li id="li12">
									<button class="btn" style="background-color:#fffeee" onclick="location.href = '/LogDownloader'"><img src="/images/download.png" height="30" width="30"/>&nbsp;&nbsp;Log Downloader</button>
									</li>

									<li id="li13">
									<button class="btn" style="background-color:#fffeee" onclick="location.href = '/LogParser'"><img src="/images/LogParser.png" height="30" width="30"/>&nbsp;&nbsp;Postgres Log Parser</button>
									</li>

									<li id="li14">
										<button class="btn" style="background-color:#fffeee" onclick="location.href = '/JarTrackerTool'"><img src="/images/tools.ico" height="30" width="30"/>&nbsp;&nbsp;Jar Tracker Tool</button>
									</li>

                                    <li id="li15">
										<button class="btn" style="background-color:#fffeee" onclick="location.href = '/ApiTestingToolJs'"><img src="images/visualize.png" height="30" width="30"/>&nbsp;&nbsp;REST API and Util method Testing tool</button>
									</li>
                                </ol>
                            </td>
                            <td id="heading">
                                <ol>
                                    <li id="li16">
                                        <button class="btn" style="background-color:#fffeee" onclick="location.href = '/TestEnumerator'"><img src="/images/TestEnumerator.png" height="30" width="30"/>&nbsp;&nbsp;Test Enumerator</button>
                                    </li>
                                
                                </ol>
                            </td>
                        </tr>
                    </table>
                </div>
                <div style="float:right;margin-top:5px;margin-left:110px;background-color:white;border-width:2px;display:inline" id="alertdiv" class="alert alert-warning alert-dismissible fade in" role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <img src="/images\info_new.png" />  Configure your mail settings here <strong><server_home>\conf\smtpCredentials.properties</strong>.
                </div>
            </div>
        </div>
    </body>
    <script>
        if (${DemoUtil.isDemoMode()} == false) {
            var validConf = "${AlertValidation().validation()}";
            if (validConf == "false")
            {
                //alert(document.getElementById("alertdiv").class);
                document.getElementById("alertdiv").style.display = "none";
            }
            else
            {
                document.getElementById("alertdiv").style.display = "show";
            }
        }
        else
        {
            document.getElementById("alertdiv").style.display = "none";
        }
    </script>
</html>
