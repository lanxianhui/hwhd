<%@ include file="HD_preFocusElement.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="designer" content="meifk"  />
<meta name="page-view-size" content="1280*720" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>liveTV player</title>
<style type="text/css">
*{margin:0; padding:0; font-size:20px;}
body{background-color:transparent;}
table{border-collapse:collapse;}

#menu{position:absolute; top:450px; left:191px; width:903px; height:154px; opacity:0; -webkit-transition-duration:0.2s; -webkit-transform:scale(0.8);}
#title{position:absolute; top:0; left:69px; width:765px; height:51px; background:url(images/play/live_menu_title.png) no-repeat; z-index:2;}
#shortcuts{position:absolute; top:3px; left:780px; width:99px; height:45px; background-repeat:no-repeat; z-index:2; visibility:hidden;}
#panel{position:absolute; top:25px; left:0; width:903px; height:107px; background:url(images/play/live_menu.png) no-repeat;}

#title table{width:765px; height:51px; line-height:51px;}
#title #tvtime{width:180px; text-align:center; color:#0C3C70;}
#title #currtime{width:80px; color:#90DEFF;}
#title #programname{width:345px; color:white; font-size:22px;}
#title #channelname{width:180px; text-align:center; color:#0C3C70;}

#panel #information{position:absolute; top:30px; left:20px; width:860px; height:60px; color:#BFE4E6; visibility:visible;}
#panel #information div.tb{position:absolute; top:0px; left:0; width:860px; height:60px;}
#panel #information table{border:0px; width:860px; height:60px; line-height:30px;}
#panel #information #infosep{position:absolute; top:1px; left:430px; width:2px; height:64px; background:url(images/play/live_sep.png) no-repeat;}
#panel #seekprogress{position:absolute; top:40px; left:40px; width:820px; height:30px; color:#BFE4E6; visibility:hidden;}
#panel #seekprogress #progressline{position:absolute; top:4px; left:60px; width:708px; height:22px; background:url(images/play/vod_progress.png) no-repeat; visibility:visible;}
#panel #seekprogress #progressline #progresslinetd{position:absolute; top:3px; left:2px; width:0px; height:20px; background:url(images/play/vod_progress_bg.jpg) repeat-x;}

#tip{position:absolute; top:120px; left:900px; width:180px; height:40px; color:white; background-color:blue; line-height:40px; font-size:24px; visibility:hidden; text-align:center;}

</style>
<script src="js/mini.js" type="text/javascript"></script>
<script type="text/javascript">
var program = {
								//.INFORMATION		--duration
								//.PLAYJSON				--playmMediaJson
								//.DIRECTOR				--directors
								//.ELAPSETIME			--current play time
								//.VODNAME				--program name
								//.INTRODUCE			--introduction
								//.ACTOR					--actors
								//.ISFAVO					--favorite flag
								//.BACKURL				--back url
								//.BOOKMARKURL		--bookmark url
								//.HASBOOKMARK		--bookmark flag
								//.OFFLINE				--online flag
								//.ISSITCOM				--tv flag
								//.PARENTID				--part id
								//.PICPATH				--post src
							};
var pfInfo = {};
<!--[{"PROGNAME":"","PROGTIMEEND":"16:23","PROGTIMEBEGIN":"16:11","NEXTPROGNAME":"","PREPROGNAME":"","CHANNELNAME":""}]-->

var menuAutoHideTime = 8000;								//menu auto hide time
var maxProgressLength = 700;								//progress line max length px
var menuTimer = null;

var flag = 0;																//0.none 1.play 2.progress
var channelLength = 0;
var playList = [];
var channelPos = window.location.search.substring(1).split("=")[1] || 0;

var MP = new MediaPlayer();
var NativePlayerInstanceID = MP.getNativePlayerInstanceID();

function eventHandler(obj) {
	switch(obj.code) {
		case "KEY_UP":
			changeChannel(1);
			break;
		case "KEY_DOWN":
			changeChannel(-1);
			break;
		case "KEY_SELECT":
			doSelect();
			break;
		case "KEY_BACK":
			window.location = backUrl;
			break;
		case "KEY_EXIT":
			window.location = backUrl;
			break;
	}
}

window.onload = init;
window.onunload = exit;

function init() {
	initEPG();
	setTimeout(function(){showMenu(menuAutoHideTime)}, 1000);
}
function initEPG() {
	MP.setVideoDisplayMode(1);
	MP.refreshVideoDisplay();
	playList = iPanel.eventFrame.HDchannelInfo;
	channelLength = playList.length;
	MP.joinChannel(iPanel.eventFrame.HDchannelInfo[channelPos].InnerChannelID);
	showTime();
	showPfInfo();
}
function showPfInfo() {
	var url = "HD_channelMiniInfo.jsp?CHANNUM=" + playList[channelPos].InnerChannelID;
	var ajaxobj = new AJAX("GET", url, true, getPfInfo);
	ajaxobj.send();
}
function showTime() {
	var d = new Date();
	var h = d.getHours();
	var m = d.getMinutes();
	h = h < 10 ? ("0" + h) : h;
	m = m < 10 ? ("0" + m) : m;
	$("currtime").innerText = h + ":" + m;
	setTimeout("showTime()", 60000);
}
function getPfInfo(data) {
	eval("var d = " + data);
	pfInfo = d[0];
	$("tvtime").innerText = pfInfo.PROGTIMEEND.substr(0, 5) + " - " + pfInfo.PROGTIMEBEGIN.substr(0, 5);
	$("programname").innerText = pfInfo.PROGNAME;
	$("channelname").innerText = pfInfo.CHANNELNAME;
	$("preprogram").innerText = pfInfo.PREPROGNAME;
	$("nextprogram").innerText = pfInfo.NEXTPROGNAME;
}
function changeChannel(n) {
	channelPos  = (channelPos + n + channelLength ) % channelLength;
	MP.joinChannel(playList[channelPos].InnerChannelID);
	showPfInfo();
}
function showInfomation() {
	$("programname").innerText = program.VODNAME.substr(0, 14);
	var str = "";
	for(var i = 0; i < program.DIRECTOR.length; i++) str += program.DIRECTOR[i] + " ";
	$("director").innerText = "导演：" + str.substr(0, 15);
	str = "";
	for(var i = 0; i < program.ACTOR.length; i++) str += program.ACTOR[i] + " ";
	$("actor").innerText = "主演：" + str.substr(0, 15);
	$("duration").innerText = "片长：" + program.INFORMATION;
	$("introduction").innerText = "介绍：" + program.INTRODUCE.substr(0, 38) + "...";
	$("starttime").innerText = "00:00";
	setTimeout(function(){
		showTimeInfo();
		var t = getFormatTime(MP.getMediaDuration());
		maxSeekNumber[0] = parseInt(t.split(":")[0], 10);
		maxSeekNumber[1] = parseInt(t.split(":")[1], 10);
		$("playstatus").innerHTML = statIcon["play"];
		$("endtime").innerText = getFormatTime(MP.getMediaDuration());
		$("playcurrtime").innerText = getFormatTime(MP.getCurrentPlayTime());}, 1000);
}

function showTimeInfo() {
	$("playcurrtime").innerText = getFormatTime(MP.getCurrentPlayTime());
	$("progresslinetd").style.width = Math.round(maxProgressLength * MP.getCurrentPlayTime() / MP.getMediaDuration()) + "px";
	$("progresstime").innerText = getFormatTime(MP.getCurrentPlayTime());
	showSeekProgressButton();
	timeinfoTimer = setTimeout("showTimeInfo()", 10000);
}

function showMenu(delay) {
	if(flag != 0) {
		clearTimeout(menuTimer);
	} else {
		flag = 1;
		$("menu").style.opacity = 1;
		$("menu").style.webkitTransform = "scale(1)";
	}
	hideMenu(delay);
}

function hideMenu(delay) {
	if(delay == 0) return;
	menuTimer = setTimeout(function(){
		flag = 0;
		$("menu").style.opacity = 0;
		$("menu").style.webkitTransform = "scale(0.8)";}, delay);
}

function doSelect() {
	if(flag == 0) showMenu(menuAutoHideTime);
	else if(flag == 1) changeMenuPanel(2);
	else if(flag == 2) changeMenuPanel(1);
}

function changeMenuPanel(n) {
	flag = n;
	if(n == 1) {
		$("information").style.visibility = "visible";
		$("seekprogress").style.visibility = "hidden";
	} else {
		$("information").style.visibility = "hidden";
		$("seekprogress").style.visibility = "visible";
	}
	showMenu(menuAutoHideTime);
}

function exit() {
	MP.leaveChannel();
	MP.releaseMediaPlayer(NativePlayerInstanceID);
}
</script>

</head>

<body onunload="exit()">
<div id="menu">
	<div id="title">
  	<table>
    	<tr>
      	<td id="tvtime"></td>
        <td id="currtime"></td>
        <td id="programname"></td>
        <td id="channelname"></td>
      </tr>
    </table>
  </div>

  <div id="shortcuts"></div>

  <div id="panel">
  	<div id="information">
    	<div class="tb">
        <table>
          <tr><td width="400">上一节目</td><td width="60">&nbsp;</td><td>下一节目</td></tr>
          <tr><td id="preprogram"><td width="60">&nbsp;</td><td id="nextprogram"></td></td></tr>
        </table>
      </div>
      <div id="infosep"></div>
    </div>

    <div id="seekprogress">
      <div id="progressline"><div id="progresslinetd"></div></div>
    </div>

  </div>
  
</div>

</body>

</html>

