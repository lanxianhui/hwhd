<%@ include file="HD_preFocusElement.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="designer" content="chris"  />
<meta name="page-view-size" content="1280*720" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>回看播控</title>
<script src="js/mini.js" type="text/javascript"></script>
<link href="css/default/HD_playTvodControl.css" rel="stylesheet" type="text/css" />
<script src="js/HD_playTvodControl.js" type="text/javascript"></script>
</head>

<body onload="init();" onunload="exit();">

<div id="tvod_main" >
	<div id="up" ></div>
	<div id="date_back" ></div>
	<div id="tvod_date">
		<div class="date" id="date0"></div>
		<div class="date" id="date1"></div>
		<div class="date" id="date2"></div>
		<div class="date" id="date3"></div>
		<div class="date" id="date4"></div>
		<div class="date" id="date5"></div>
	</div>
	<div id="tvod_back" ></div>
	<div id="tvod_tag" > </div>
	<div id="tvod_list">
		<div class="list" id="list0"></div>
		<div class="list" id="list1"></div>
		<div class="list" id="list2"></div>
		<div class="list" id="list3"></div>
		<div class="list" id="list4"></div>
		<div class="list" id="list5"></div>
	</div>
	<div id="down"></div>
</div>

<div id="infobar">
	<div id="inforbarBack"></div>
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
	<div id="fastName"> </div>
	<div id="fastCurrentTime"> </div>
	<div id="startTime"> </div>
	<div id="fastBackground"> </div>
	<div id="fastTimeBar"> </div>
	<div id="pauseFastBar"> </div>
	<div id="pauseBar"> </div>
	<div id="pauseTime"> </div>
	<div id="endTime"> </div>
	<div id="enterTime"> 
		<div id="pauseStartTime">请输入节目开始时间</div>
		<div id="pauseHourInputImage"></div>
		<div id="hourInput"></div>
		<div id="pauseHour">时</div>
		<div id="pauseMinuteInputImage"></div>
		<div id="minuteInput"></div>
		<div id="pauseMinute">分</div>
		<div id="goto"></div>
		<div id="inputTips"></div>
	</div>
</div>

<div id="btn_exit">
	<div id="btn_continue"></div>
	<div id="btn_return"></div>
</div>


<div id="return" >
</div>

<div id="forwardTips">
</div>

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

<div style="position: absolute;left: 950;top: 10;width: 308;height: 45;"><img src="images/portal/logo.png" /></div>

<div id="tip"></div>
<input type="hidden" name="flag" id="flag" value="0">
<input type="hidden" name="fastNum" id="fastNum" value="0">
<input type="hidden" name="rewindNum" id="rewindNum" value="0">
<input type="hidden" name="playNum" id="playNum" value="0">
</body>
</html>

