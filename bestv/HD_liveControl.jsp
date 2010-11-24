<%@ page contentType="text/html;charset=utf-8" language="java" %>

<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.bestv.epg.util.MessageUtil" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ include file="HD_preFocusElement.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="designer" content="chris"  />
<meta name="page-view-size" content="1280*720" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>直播</title>
<script src="js/mini.js" type="text/javascript"></script>
<link href="css/default/HD_playliveControl.css" rel="stylesheet" type="text/css" />
<script src="js/HD_playliveControl.js" type="text/javascript"></script>
</head>

<body onload="init();" onunload="exit();">

<div id="main" >
	<div id="up"></div>
	<div id="back" ></div>
	<div id="name">
		<div class="name" id="name0"></div>
		<div class="name" id="name1"></div>
		<div class="name" id="name2"></div>
		<div class="name" id="name3"></div>
		<div class="name" id="name4"></div>
		<div class="name" id="name5"></div>
		<div class="name" id="name6"></div>
	</div>
	<div id="down"></div>
</div>

<div id="infobar">
	<div id="inforbarBack"></div>
	<div id="nameBackground"></div>
	<div id="title"></div>
	<div id="time"></div>
	<div id="timeBar"></div>
	<div id="scheduleTime"></div>
	<div id="lastProgram">上一节目</div>
	<div id="lastProgramName"></div>
	<div id="programBar"></div>
	<div id="nextProgram">下一节目</div>
	<div id="nextProgramName"></div>
	<div id="infortips"> </div>
</div>

<div id="fastForward">
	<div id="fastCurrentTime"> </div>
	<div id="startTime"> </div>
	<div id="fastBackground"> </div>
	<div id="fastTimeBar"> </div>
	<div id="endTime"> </div>
</div>

<div id="forwardTips"></div>
<div id="channelPrompg" style="overflow:hidden; position:absolute; left:350px; top:240px; text-align:center; background-image:url(images/vod/tck_bg2.png); background-repeat:no-repeat; z-index:110;-webkit-transition-duration:1ms;-webkit-transform:scale(0)">
	<table width='576' border='0' cellspacing='0' cellpadding='0' >
		<tr>
			<td height='120' colspan='2' align='center' style='font-size:40px; color:#f6ff00;' vaglin='bottom' id='channelPrompgText'></td>
		</tr>
		<tr>
			<td height='120' colspan='2' valign='top' align='center' style='font-size:40px; color:#f6ff00;' >请切换到其他频道观看</td>
		</tr>
	</table>
</div>

</body>
</html>

