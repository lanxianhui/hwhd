<%--Created by Caiyuhong 2010-04-27--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="java.util.*" %>
<html>
<link href="css/stylesheet.css" rel="stylesheet" type="text/css">
<%    
    String preFoucs = request.getParameter("currFocus");
	
    String url = "";
    String strurl =(String)request.getQueryString();

    if(strurl!=null)
    {
        if(strurl.indexOf("url")!=-1)
        {
            url = strurl.substring(strurl.indexOf("url")+4);
        }
    }

    TurnPage turnPage = new TurnPage(request);
//    System.out.println("Save Focus..");
    ArrayList al = turnPage.getTurnList();
    for(int j = 0; j < al.size() ; j ++) {
//        System.out.println(j + "\t:" + al.get(j));
    }
    
    
    //修改当前URL队列的最后一个URL，增加currFocus参数
    if(preFoucs != null)
    {
        turnPage.savcCurrFoucs(preFoucs);
    }  
      
    String strCondition = (String) request.getParameter("CONDITION");
    /**
     *如果url中带有中文时,要用window.location.href方式跳转，
     *使用<jsp:forward page=""/>方式跳转会出现乱码
     *
     */
    if((null != strCondition && !"".equals(strCondition)) 
        || url.startsWith("zxjy/index.jsp")
        || url.startsWith("./HotSpecial/")
        || url.startsWith("HotSpecial/"))
    {        
        response.sendRedirect(url);
    }
else
    {
	      response.sendRedirect(url);
    }
%>
  