<%@ include file="HD_preFocusElement.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page import="com.bestv.epg.util.MessageUtil" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="java.util.*" %>
<%@ include file="HD_common.jsp" %>
<head>
	<meta name="designer" content="hwhd" />
	<meta http-equiv="Page-Enter" content="blendTrans(Duration=1.0)">
	<meta name="page-view-size" content="1280*720" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>upgrade notice</title>
<script src="js/mini.js" type="text/javascript"></script>

<style type="text/css">
body {
	background-color:transparent;
	width:1280px;
	height:720px;
	left:0px;
	top:0px;
	margin-left:0px;
	margin-top:0px;
	overflow:hidden;
	background:url("images/help/upgrade.jpg") no-repeat;
}

#title {
	position:absolute;
	top:30px; 
	height:30px; 
	font-size:30px; 
	width:626px; 
	left:82px;
	color:#FFFFFF;
}

#logo {
	position:absolute;
	top:23px; 
	left:28px; 
	width:48px; 
	height:48px; 
	background:url("images/help/logo.png") no-repeat;
}

#return {
	position:absolute;
	top:600px; 
	left:580px; 
	width:155px; 
	height:70px; 
	background:url("images/help/return_focus.png") no-repeat;
}

#introduce_string {
	position:absolute; 
	left:0px; 
	top:112px; 
	height:50px; 
	width:1280px; 
	font-size:40px; 
    TEXT-ALIGN:center;
	color:#FFFFFF;
	z-index:3;
}

#tips {
	position:absolute; 
	left:127px; 
	top:238px; 
	height:450px; 
	width:1019px; 
	font-size:30px; 
	color:#FFFFFF;
	line-height:50px;
	text-align:left;
	z-index:3;
}
</style>

<script type="text/javascript">

function init() {
	
	var requestUrl = "HD_helpDate.jsp";
	var ajaxObj = new AJAX_OBJ(requestUrl, getListData);
	ajaxObj.requestData();
}

function getListData(__xmlhttp){
	var temp		= eval(__xmlhttp.responseText);
	$("introduce_string").innerText	=	temp[0].title.slice(0,250);
	
	var  infomation  =  "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + temp[0].info;
	$("tips").innerText	=	getProgramName(infomation,250);
}

function getProgramName(name,num)
{
	var tempName = name;
	var nameLength = tempName.length;
	if (nameLength < num ) {
		var temp 	=	num - nameLength;
		for (var i=0 ; i<temp ; i++)
			tempName = tempName + "&nbsp;&nbsp;";
	} else {
		tempName = tempName.slice(0,num) + "...";
	}
	
	return tempName;
}

function eventHandler(obj) {
	switch(obj.code){
		case "KEY_EXIT":
			window.location = backUrl;
			break;
		case "KEY_SELECT":
			window.location = backUrl;
			break;
		case "KEY_BACK":
		  	window.location = backUrl;
			break;
	}
}
</script>
</head>

<body onload="init();">

	<div id="logo"></div>
	<div id="title">IPTV操作指南&nbsp;&nbsp;&nbsp;&nbsp;客户服务电话：10000</div>
	<div id="introduce_string" ></div>
	<div id="tips">
	</div>
	<div id="return"></div>
</body>
</html> 