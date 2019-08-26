<%-- 
    Document   : tools
    Created on : 11 Feb, 2015, 12:06:58 PM
    Author     : siva-pt516
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles" %>
<tiles:insert page="/jsp/layout.jsp" flush="true">
    <tiles:put name="title" value="Test Enumerator" />
    <tiles:put name="header" value="/jsp/header.jsp" />
    <tiles:put name="menu" value="/jsp/menu.jsp" />
    <tiles:put name="body" value="/jsp/test-enumerator.jsp" />   
</tiles:insert>
<!-- $Id$ -->