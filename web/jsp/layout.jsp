<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="s" %>
<%@ page import="com.me.commonutil.server.DemoUtil" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <link rel='shortcut icon' type='image/x-icon' href='images/tool.png'/>
        <title><tiles:getAsString name="title" ignore="true"/></title>
    </head>
    <body>
        <table class="col-md-12" border="0">
            <tr>
                <td height="20%">
                    <tiles:insert attribute="header" ignore="false"/>
                </td>
            </tr>
            <tr>
                <td height="20%">
                    <tiles:insert attribute="menu"/>
                </td>
            </tr>
            <tr>
                <td>
                    <tiles:insert attribute="body"/>
                </td>
            </tr>
        </table>
        <input type="hidden" name="demo-mode" id="demo-mode" value="<s:out value="${DemoUtil.isDemoMode()}"/>"/>
        <input type="hidden" name="demo-mode-msg" id="demo-mode-msg" value="<s:out value="${DemoUtil.getDemoModeMessage()}"/>"/>
        <script type="text/javascript">
            function isDemoMode() {
                var demoMode = document.getElementById('demo-mode').value;
                return (demoMode.includes("true"));
            }
            function getDemoModeMessage() {
                var demoModeMsg = document.getElementById('demo-mode-msg').value;
                return demoModeMsg;
            }
        </script>
    </body>
</html>
