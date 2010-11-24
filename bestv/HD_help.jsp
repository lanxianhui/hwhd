<%@ include file="HD_preFocusElement.jsp" %>
<% String channelID = (String)request.getParameter("CHANNELID"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta name="designer" content="hwhd" />
	<meta name="page-view-size" content="1280*720" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="Page-Enter" content="blendTrans(Duration=0.5)">
<title>Channel</title>
<link href="css/default/HD_help.css" rel="stylesheet" type="text/css" />
<script src="js/mini.js" type="text/javascript"></script>
<script src="js/HD_help.js" type="text/javascript"></script>
</head>

<body onload="init();" id="body_id" onunload="exit();"  scroll="no">

	<div id="logo"></div>
	<div id="title">IPTV操作指南&nbsp;&nbsp;&nbsp;&nbsp;客户服务电话：10000</div>
	
	<div id="main">
		<div class="subTextTr" id="t0" ></div>
		<div class="subTextTr" id="t1"></div>
		<div class="subTextTr" id="t2"></div>
		<div class="subTextTr" id="t3"></div>
		<div class="subTextTr" id="t4"></div>
		<div class="subTextTr" id="t5"></div>
		<div class="subTextTr" id="t6"></div>
		<div class="subTextTr" id="t7"></div>
	</div>

	<div id="back" ></div>
	<div id="page"></div>
	<div id="iconup"></div>
	<div id="icondown"></div>
    <div id="trailerFocus"></div>
	
	<div id="introduce"></div>
	<div id="introduce_string"></div>
	<div id="tips"></div>
	
<input type="hidden" name="flag" id="flag" value="1">
</body>
</html> 