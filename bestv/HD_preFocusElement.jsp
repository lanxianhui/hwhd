<%--Created by Caiyuhong 2010-04-27--%>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page buffer="16kb" %>
<%!
    public boolean isAddToTurnpage(TurnPage turnPage) {
        if(turnPage.getLast().indexOf("HD_playTvodControl") != -1 || turnPage.getLast().indexOf("play.jsp") != -1 || turnPage.getLast().indexOf("HD_portal") != -1) 
        {
//        	System.out.println("this is wrong to remove");  
        	turnPage.removeLast(); 
        	return false;
        }
        else if(turnPage.getLast().indexOf("HD_playliveControl") != -1) 
        {
//	        System.out.println("this is right to remove");
	        turnPage.removeLast(); 
	        turnPage.addUrl(); 
        	return false;
        }
        else {
//        	System.out.println("this is right to add");
        	return true;
        	}   
    }
%>
<html>
<script>
	  var myArray = new Array();
<%
    TurnPage turnPage = new TurnPage(request);
    //取出当前页面的焦点
    String focusElmId = "";
    String[] focusMemory = turnPage.getPreFoucs();
    if (focusMemory != null && focusMemory.length > 1) {
        for(int i = 0; i < focusMemory.length; i++) {
%>
            myArray[<%=i%>] = "<%=focusMemory[i]%>";
<%
        }
    }
    
    if(isAddToTurnpage(turnPage)) turnPage.addUrl(); 
//    turnPage.addUrl(); 
    ArrayList al = turnPage.getTurnList();
    for(int j = 0; j < al.size() ; j ++) {
        System.out.println(j + "\t:" + al.get(j));
    }
    
    
   String   visUrl = (String) session.getAttribute("vas_back_url");
    String  backurl="";
      	if ((visUrl == null) || "".equals(visUrl))
	{
       backurl = turnPage.go(-1);
    }
    else
    {
      backurl = "HD_backToVis.jsp";
    }
    
%>
    var backUrl = "<%=backurl%>";
</script>