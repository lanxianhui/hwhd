<%-- Copyright (C), Bestv --%>
<%-- Author:caiyuhong --%>
<%-- CreateAt:20080604 --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.net.URLEncoder"%>
<jsp:directive.page import="com.huawei.iptvmw.epg.bean.info.UserProfile" />
<%@ include file="HD_memToVas.jsp" %>

<head>
<meta name="designer" content="bestv" />
<meta name="page-view-size" content="640*526" />
</head>

<%
  UserProfile userInfo = new UserProfile(request);
 
    String isFromKanba = request.getParameter("fromKanba"); 
		String itemKanba = request.getParameter("item");
		
		
		
		 if(isFromKanba != null && "1".equals(isFromKanba))
     {
       session.setAttribute("fromKanba", isFromKanba);
       session.setAttribute("item", itemKanba);
     }
 
 
  String third_url = "";
	String tmp = request.getParameter("url").toLowerCase();
	if(tmp.startsWith("http:")) {
		third_url = new String(request.getQueryString().getBytes("iso8859-1"),"GBK");
        int third_url_length = third_url.lastIndexOf("http");
        third_url = third_url.substring(third_url_length);

		String str = getEpgInfo(request);

		str = URLEncoder.encode(str);
		if(third_url.indexOf("?") == -1) third_url = third_url + "?epg_info=" + str;
	    else third_url = third_url + "&epg_info=" + str;
	}
	third_url = third_url + "&user_name=" +String.valueOf(userInfo.getAreaId());
//	System.out.println("third:::::::::::::::::"+third_url);
	response.sendRedirect(third_url);	
%>