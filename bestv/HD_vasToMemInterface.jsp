<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page buffer="16kb" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
     String query = request.getParameter("vas_info");
     session.setAttribute("vas_info", query);
     
     String isFromKanba = (String) session.getAttribute("fromKanba");
     
      System.out.println("isFromKanba_inter::::::::::::::"+isFromKanba);
 
     if(isFromKanba != null && "1".equals(isFromKanba))
     {
     String itemKanba = (String) session.getAttribute("item");
      	response.sendRedirect("HD_KanBar.jsp?item="+itemKanba);
     }
     else
     {
     	response.sendRedirect("HD_vasToMemA2.jsp");
     }
    
%>
<script>
/*
 window.location.href = "HD_vasToMemA2.jsp";
   function redirect() {
	   var navappcodename = navigator.appCodeName;
	   var newver = "EIS iPanel";
	   
	   if(navappcodename.toLowerCase() == newver.toLowerCase())
	   {
		   window.location.href = "HD_vasToMemA2.jsp";
	   }
   }
  // redirect();
  */
</script>
