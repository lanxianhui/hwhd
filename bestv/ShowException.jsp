<%--
  Copyright (C), 2004-2005, Huawei Tech. Co., Ltd.
  File name:     showException.jsp
  Description:   用于捕获没有处理的异常。 
--%>

<%@ page isErrorPage="true"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGSysParam"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@include file = "../../keyboard/keydefine.jsp"%>

<%
  //页面跳转
    TurnPage turnPage = new TurnPage(request);
    String desc = "服务器内部出错！";
    //String resolve = "请稍候重试，如果问题依然存在，联系服务提供商！";  
    int iErrorID = 0;
%>


<html>
<script>
<!--
    document.onkeypress = keyevent;
    document.onirkeypress = keyevent ;
    function keyevent()
    {
            var val = (event.keyCode == undefined) ? event.which:event.keyCode;
        return keypress(val);
    }
    
    /**
     *返回到上一级页面
     */
    function goBack()
    {
        window.location.href = "<%=turnPage.go(-1)%>";
    }    
    
    function keypress(keyval)
    {    
        switch(keyval)
        {
            case <%=KEY_BACKSPACE%>://回退键和返回键同样处理        
            case <%=KEY_RETURN%>:
                goBack();
                return 0;//返回0机定盒不处理  
            default:
               break;
        }
        return 1;
    }     
	
	function setFocus()
	{
		document.getElementById("back").focus();
	}  
 
-->


</script>
<style type="text/css">
<!--
.STYLE1 {font-size: 20px; color: #2a80cd}
-->
</style>
<head>
<title>showException</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" class="unnamed1" background="images/vod20/ui_error.jpg">
<% exception.printStackTrace();%>

<div id="back" style="position:absolute;left:241px;top:258px;width:158px;height:54px;"><a href="javascript:goBack()" class="style1"><img src="images/link-dot.jpg" width="158" height="54" /></a></div>

<div id="info" style="position:absolute;left:22px;top:461px;width:610px;height:34px" class="STYLE1">错误信息：<%=desc%></div>
<div id="code" style="position:absolute;left:22px;top:491px;width:610px;height:34px" class="STYLE1">错误代码：<%=iErrorID%></div>

       
       
</body>
</html>

