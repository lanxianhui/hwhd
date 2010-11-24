<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@page pageEncoding="UTF-8"%>

<%
    String fatherId = request.getParameter("PROGID");
    if(null == fatherId || "".equals(fatherId)) return;

    String progID = request.getParameter("CHILDID");
    String progNum= request.getParameter("CHILDNUM");
    String typeId = request.getParameter("TYPE_ID");    

   //连续剧对父集认证，只要购买一集其他就能观看，这里可以直接播放。这样比较节省性能
    String pageName = "play.jsp?PROGID=" + progID + "&PROGNUM=" + progNum + "&FATHERID=" + fatherId + "&TYPE_ID=" + typeId; 
   // System.out.println("pageName:::::::::"+pageName);
%>
<script>
	window.location.href = "<%= pageName %>";
</script>