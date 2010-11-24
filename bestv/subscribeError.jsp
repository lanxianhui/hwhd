<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page errorPage="ShowException.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@page pageEncoding="UTF-8"%>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="css/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<%
    TurnPage turnPage = new TurnPage(request);
//    System.out.println("this is jump");
%>

<body background="images/subscribe/subscribeError.jpg">

<div style="position:absolute; left:160px; top:204px">
    <font color="white" style="font-size:24px">订购结果：产品订购失败</font>
</div>
<div style="position:absolute; left:160px; top:239px">
    <font color="white" style="font-size:24px">失败原因：余额不足</font>
</div>
<div style="position:absolute; left:160px; top:274px">
    <font color="white" style="font-size:24px">错误代码：01020201</font>
</div>

<div style="position:absolute; left:277px; top:340px">
    <a href="<%=turnPage.go(0)%>"><img src="images/subscribe/back_button.gif" alt="" /></a>
</div>

</body>
</html>