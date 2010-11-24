<%-- Created By Caiyuhong 2010-04-14--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="java.io.*" %>
<%@ include file="HD_kanBarFunction.jsp" %>

<%
    ArrayList json = readKanbaDataFromVAS(request);
    JSONArray jsonObject = JSONArray.fromObject(json); 
//    System.out.println("kanba::::::::::::"+jsonObject.toString());  						
	  out.write(jsonObject.toString());
%>