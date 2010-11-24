var channelPos = null;// 当前频道
var preNum = null;// 上一频道
var playList = [];
var infobar = null;
var tip = null;
var channelNum = 6;
var name = [];
var back = null;

var total = 0;
var totalPage = 0;
var nowPage = 0;
var shown = 0;
var subPos = 0;
var limit = 0;
var flag = 0;
var source = null;
var pausePlayTime = "5000";

var timePer = 0.0; // 每秒钟所占进度条长度
var perTime = 0.0; // 每毫米所占时间
var timeLength = null; // 获取时移频道总时长
var fastScheduleTime = 0.0;
var fastForwardId = null;
var volumePageTimer = -1;
var volumePage = null;
var ispltv = false;
var newbackUrl="";

getMediaDuration();
function getMediaDuration() {
	var temp = setInterval(function() {
		if (timeLength < (mp.getCurrentPlayTime() / 1000)) {
			timeLength = mp.getMediaDuration();
			timePer = 545 / timeLength;
			perTime = timeLength / 552;
			ispltv = (mp.getMediaDuration() < 1) ? false : true; // 是否是支持时移
		}
	}, "100");

	setTimeout("clearInterval(temp)", "2000");
}

// 初始化函数数
function init() {
	requestParams = window.location.search; // 获取回看节目页面传递过来的参数列表
	var params = window.location.search.substring(1).split("&");
	var channelNUM = null;
	if(backUrl.indexOf("HD_backToVis.jsp")>-1){
		newbackUrl="HD_backToDispatch.jsp?^^"+backUrl;
	}else{
		newbackUrl=backUrl;
	}
	
	for ( var i = 0; i < params.length; i++) {

		//FLAG为1,源：VIS看吧;否则，源:EPG;
		if (params[i].indexOf("flag")> -1) {
		
			for ( var i = 0; i < params.length; i++) {
				if (params[i].indexOf("currentNum") > -1) {
					channelNUM = params[i].split("=")[1];
					break;
				}
			}
			
			for(var i=0;i < iPanel.eventFrame.channelInfo.length ; i++) {
				if(channelNUM == iPanel.eventFrame.channelInfo[i].ChannelID)
				{	
					channelPos  = i;
					break;
				}
			}

			if(channelPos  == null) {
				for(var i=0;i < iPanel.eventFrame.channelInfo.length ; i++) {
					if(channelNUM == iPanel.eventFrame.HDchannelInfo[i].ChannelID)
					{	
						channelPos  = i;
						break;
					}
				}
			}
		} else {
			if (params[i].indexOf("currentNum") > -1)
				channelPos = params[i].split("=")[1];
		}

		if (params[i].indexOf("source") > -1)
			source = params[i].split("=")[1];
		if (params[i].indexOf("pre") > -1)
			preNum = params[i].split("=")[1];
	}

	volumePage = iPanel.pageWidgets.getByName("volumePage");
	volumePage.moveTo(437, 163);
	volumePage.resizeTo(800, 800);

	initEPG();
	initChannelList();
	requestInforbar();
	setTimeout("hiddenChannelList()", "1000");
	selectItem();

	if (mp.getMuteFlag() == 1) {
		if ($("muteDiv") == null || typeof ($("muteDiv")) == "undefined") {
			creatMuteDiv();
		}
		$("muteDiv").style.webkitTransitionDuration = "0ms";
		$("muteDiv").style.visibility = "visible";
		$("muteDiv").style.backgroundImage = "url(images/vod/mute2.png)";
		$("muteDiv").style.width = "62px";
		$("muteDiv").style.height = "62px";
		$("muteDiv").style.left = "50px";
		$("muteDiv").style.top = "620px";
		$("muteDiv").style.webkitTransitionDuration = "300ms";
	}
	if (mp.getChannelNum() == -1)
		return;
	iPanel.overlayFrame.location = "channelNumber.html?" + mp.getChannelNum();
	iPanel.overlayFrame.moveTo(900, 39);
	iPanel.overlayFrame.resizeTo(347, 100);
	
}

function requestInforbar() {
	var url = "HD_channelMiniInfo.jsp?CHANNUM="
			+ playList[channelPos].ChannelID;
	var ajaxObj = new AJAX_OBJ(url, getInfoBarInfo);
	ajaxObj.requestData();
}

var program = {};
function getInfoBarInfo(__xmlhttp) {
	var data = eval(__xmlhttp.responseText);
	program = data[0];
	initInforBar();
}

function noChannel(channelNumber) {
	$("channelPrompg").style.webkitTransitionDuration = "500ms";
	$("channelPrompg").style.webkitTransform = "scale(1)";
	$("channelPrompgText").innerText = "频道<" + channelNumber + ">不存在";
	setTimeout('$("channelPrompg").style.webkitTransform= "scale(0)"', 4000);
}

function initInforBar() {
	if (program.CHANNELNAME == "") {
		if (program.PROGNAME == "")
			$("title").innerHTML = "";
		else
			$("title").innerHTML = "<font color='#00A8FF'>"
					+ program.CHANNELNAME + "</font>"
	} else {
		$("title").innerHTML = "<font color='#00A8FF'>" + program.CHANNELNAME
				+ "</font>" + ":&nbsp;" + program.PROGNAME.substr(0, 14);
	}

	if (program.PROGTIMEEND == "") {
		if (program.PROGTIMEBEGIN == "")
			$("time").innerText = "";
		else
			$("time").innerText = program.PROGTIMEBEGIN.substr(0, 5)
	} else {
		$("time").innerText = program.PROGTIMEBEGIN.substr(0, 5) + "-"
				+ program.PROGTIMEEND.substr(0, 5);
	}

	$("lastProgramName").innerText = program.PREPROGNAME.substr(0, 20);
	$("nextProgramName").innerText = program.NEXTPROGNAME.substr(0, 20);

	if (mp.getCurrentPlayTime() > 0) {
		setInterval(function() {
			var nowtime = Math.floor(mp.getCurrentPlayTime() / 1000);
			$("scheduleTime").style.width = ((nowtime / timeLength) * 176)
					+ "px";
		}, "1000");
	} else {
		$("scheduleTime").style.width = "177px";
	}
}

// 换算时间
function timeChange(temp) {
	// 时间换算h:m:s为妙
	var timegroup = temp.split(":");
	var newtime = parseInt(timegroup[0] * 3600) + parseInt(timegroup[1] * 60)
			+ parseInt(timegroup[2]);
	return newtime;
}

function initChannelList() {
	initParameters();
	displayChannelList();
}

// 显示频道列表
function displayChannelList() {
	if (limit == channelNum) {
		for ( var i = 0; i < channelNum; i++) {
			name[i].innerText = playList[i + shown].ChannelID + " "
					+ playList[i + shown].ChannelName.substring(0, 8);
		}
	} else {
		for ( var i = 0; i < limit; i++) {
			name[i].innerText = playList[i + shown].ChannelID + " "
					+ playList[i + shown].ChannelName.substring(0, 8);
		}
		for ( var i = limit; i < channelNum; i++) {
			name[i].innerText = "";
		}
	}
}

// 初始化页面参数

function initParameters() {
	for ( var i = 0; i < channelNum; i++) {
		name[i] = $("name" + i);
	}

	back = $("back");
	total = playList.length;
	totalPage = 1 + Math.floor((total - 1) / channelNum);

	nowPage = 1 + Math.floor(channelPos / channelNum);
	shown = (nowPage - 1) * channelNum;
	subPos = channelPos % channelNum;
	var rest = total - shown;
	limit = Math.min(channelNum, rest);
	turnPageFlag = true;
	selectItem();
	$("channelNumber").innerText = playList[shown + subPos].ChannelID;
}

// 选中频道
function selectItem() {
	var indexTop = null;
	if (turnPageFlag) {
		back.style.webkitTransitionDuration = "0";
		turnPageFlag = false;
		indexTop = name[0].style.top;
	} else {
		back.style.webkitTransitionDuration = "200";
		indexTop = name[subPos].style.top;
	}

	for ( var i = 0; i < channelNum; i++) {
		name[i].style.fontSize = "30px";
		name[i].style.color = "#FFFFFF";
	}

	back.style.top = indexTop - 32 + "px";
	setTimeout(function() {
		name[subPos].style.fontSize = "32px";
		name[subPos].style.color = "#393939";
	}, "200");

	clearTimeout(visibleChannelListID);
	visibleChannelListID = setTimeout(function() {
		flag = 0;
		hiddenChannelList();
	}, menuHiddenDuration);
}

function initEPG() {
	mp.leaveChannel();
	mp.setVideoDisplayMode(1);
	mp.refreshVideoDisplay();
	mp.setSingleOrPlaylistMode(0);
	channelLength = playList.length;
	if (source == "hd") {
		playList = iPanel.eventFrame.HDchannelInfo;
		channelLength = playList.length;
		var temp = playList[channelPos].ChannelID;
		mp.joinChannel(temp);
	} else {
		playList = iPanel.eventFrame.channelInfo;
		channelLength = playList.length;
		var temp = playList[channelPos].ChannelID;
		mp.joinChannel(temp);
	}
}

function exit() {
	if (typeof (iPanel.eventFrame.ccp) == "undefined") {
		iPanel.eventFrame.eval("var ccp = null");
	}
	if (typeof (iPanel.eventFrame.cs) == "undefined") {
		iPanel.eventFrame.eval("var cs = null");
	}
	iPanel.eventFrame.ccp = channelPos;
	var typestr = "";
	source == "hd" ? typestr = "hd" : typestr = "";
	iPanel.eventFrame.cs = typestr;
	mp.leaveChannel();
	iPanel.overlayFrame.close();
	mp.releaseMediaPlayer(NativePlayerInstanceID);
	muteExit();
	
	clearTimeout(visibleChannelListID);
	clearTimeout(playTimeoutID);
	clearTimeout(volumePageTimer);
}

function muteExit() {
	if (typeof ($("muteDiv")) != "undefined") {
		$("muteDiv").style.visibility = "hidden";
	}

	volumePage.minimize();
	var mutePage = iPanel.pageWidgets.getByName("mutePage");
	mutePage.minimize();
}

var visibleChannelListID = null;
var menuHiddenDuration = "10000";

// 显示频道列表
function visibleChannelList() {
	flag = 1;
	$("main").style.visibility = "visible";
	$("infobar").style.visibility = "visible";
	$("channelNumber").style.visibility = "visible";
	$("fastForward").style.visibility = "hidden";
	$("forwardTips").style.visibility = "hidden";

	clearTimeout(visibleChannelListID);
	visibleChannelListID = setTimeout(function() {
		flag = 0;
		hiddenChannelList();
	}, menuHiddenDuration);
}

// 隐藏频道列表
function hiddenChannelList() {
	flag = 0;
	$("channelNumber").style.visibility = "hidden";
//	speed = 1;
	$("main").style.left = "20px";
	$("infobar").style.left = "176px";
	$("main").style.visibility = "hidden";
	$("infobar").style.visibility = "hidden";
}

function doSelect() {
	exit();
	var temp = subPos + shown;
	if (source == "hd") {
		toUrl = "HD_playliveControl.jsp?source=hd&pre=" + channelPos
				+ "&currentNum=" + temp;
		document.location = "HD_saveCurrFocus.jsp?currFocus=" + nowPage + ","
				+ subPos + "&url=" + toUrl;
	} else {
		toUrl = "HD_playliveControl.jsp?pre=" + channelPos + "&currentNum="
				+ temp;
		document.location = "HD_saveCurrFocus.jsp?currFocus=" + nowPage + ","
				+ subPos + "&url=" + toUrl;
	}
}

// 频道切换
function goPreChannel() {
	var temp = subPos + shown;
	if (preNum != null) {
		if (source == "hd") {
			toUrl = "HD_playliveControl.jsp?source=hd&pre=" + temp
					+ "&currentNum=" + preNum;
			document.location = "HD_saveCurrFocus.jsp?currFocus=" + nowPage
					+ "," + subPos + "&url=" + toUrl;
		} else {
			toUrl = "HD_playliveControl.jsp?pre=" + temp + "&currentNum="
					+ preNum;
			document.location = "HD_saveCurrFocus.jsp?currFocus=" + nowPage
					+ "," + subPos + "&url=" + toUrl;
		}
	} else {
		doSelect();
	}
}

var moveFlag = false;
// 设置回当前日期背景图片并显示日期列表
function moveChannel(num) {
	moveFlag = true;
	if (subPos == 0) {
		if (num == -1) {
			turnPage(num);
		} else {
			subPos += num;
			if (name[subPos].innerText.length == 1) {
				turnPage(num);
			} else {
				selectItem();
			}
		}
	} else if (subPos == 5) {
		if (num == 1) {
			turnPage(num);
		} else {
			subPos += num;
			if (name[subPos].innerText.length == 1) {
				turnPage(num);
			} else {
				selectItem();
			}
		}
	} else {
		subPos += num;
		if (name[subPos].innerText.length == 1) {
			turnPage(num);
		} else {
			selectItem();
		}
	}
}

var turnPageFlag = false;

// 频道列表翻页
function turnPage(num) {

	nowPage += num;
	turnPageFlag = true;
	if (nowPage > totalPage) {
		nowPage = 1;
	}
	if (nowPage < 1) {
		nowPage = totalPage;
	}

	shown = (nowPage - 1) * channelNum;
	var rest = total - shown;
	limit = Math.min(channelNum, rest);
	subPos = 0;
	displayChannelList();
	selectItem();
}

function displayInfoBar() {
	$("startTime").innerText = program.PROGTIMEBEGIN;
	$("endTime").innerText = program.PROGEND;
}

function changeChannel(num) {
	exit();
	var temp = subPos + shown + num;
	if(temp < 0)  temp  =  total-1;
	if(temp >= total) temp	= 0;
	if (source == "hd") {
		toUrl = "HD_playliveControl.jsp?source=hd&pre=" + channelPos
				+ "&currentNum=" + temp;
		document.location = "HD_saveCurrFocus.jsp?currFocus=" + nowPage + ","
				+ subPos + "&url=" + toUrl;
	} else {
		toUrl = "HD_playliveControl.jsp?pre=" + channelPos + "&currentNum="
				+ temp;
		document.location = "HD_saveCurrFocus.jsp?currFocus=" + nowPage + ","
				+ subPos + "&url=" + toUrl;
	}
}

var tipsFlag = 0; // 频道、回看、点播、通信按键跳转提示页面
function initForwardRewind() {

	$("main").style.visibility = "hidden";
	$("infobar").style.visibility = "hidden";
	var fastCurrentTime = timeChange(Date().split(" ")[4]);
	var startTime = parseInt(fastCurrentTime) - parseInt(timeLength);
	var tempTime = parseInt(startTime)
			+ parseInt((mp.getCurrentPlayTime() / 1000));
	$("endTime").innerText = Date().split(" ")[4].slice(0, 5);
	$("startTime").innerText = dealTime(startTime);

	displayForwardTips();
	displayButton();
}

// 显示提示框和inforbar
function displayForwardTips() {
	$("fastForward").style.visibility = "visible";
	$("forwardTips").style.visibility = "visible";
}

// 隐藏提示框和inforbar
function hiddenForwardTips() {
	flag = 0;
	$("fastForward").style.visibility = "hidden";
	$("forwardTips").style.visibility = "hidden";
}

function displayButton() {
	// 屏幕右上角提示button
	switch (flag) {
	case 3:
		$("forwardTips").style.backgroundImage = "url(images/tvod/forward_"
				+ speed + ".png)";
		break; // 快进
	case 4:
		$("forwardTips").style.backgroundImage = "url(images/tvod/rewind_"
				+ speed + ".png)";
		break; // 快退
	case 5:
		$("forwardTips").style.backgroundImage = "url(images/tvod/play.png)";
		break; // 播放
	case 6:
		$("forwardTips").style.backgroundImage = "url(images/tvod/pause.png)";
		break; // 暂停
	}
}

function play() {
	// 播放
	flag = 5; // play
	speed = 1; // 当签播放速度
	mp.resume();

	// 在指定时间内隐藏inforbar
	clearTimeout(playTimeoutID);
	playTimeoutID = setTimeout("hiddenForwardTips()", pausePlayTime);
}

function pause() {
	// 暂停
	flag = 6;
	mp.pause();
	initForwardRewind();
	changeFastTimeBar();
	clearInterval(fastForwardId);
}

var speed = 1; // 播放速度

function mediaForward() {
	// 快进
	flag = 3;
	if (speed < 0 || speed == 1)
		speed = 2;
	else
		speed = speed * 4;
	if (speed > 32) {
		play();
	} else {
		mp.fastForward(speed);
	}
	showPlayStatus();
}

function mediaBackward() {
	// 快退
	flag = 4;

	if (speed > 0)
		speed = -2;
	else
		speed = speed * 4;
	if (speed < -32) {
		play();
	} else {
		mp.fastRewind(speed);
	}
	showPlayStatus();
}

function showPlayStatus() {
	// 快进
	initForwardRewind();
	changeFastTimeBar();
	clearInterval(fastForwardId);
	fastForwardId = setInterval("changeFastTimeBar()", "1000");
}

// 改变显示进度
function changeFastTimeBar() {
	fastScheduleTime = timePer * (mp.getCurrentPlayTime() / 1000);
	
	if (fastScheduleTime > 545) fastScheduleTime = 545;
	$("fastTimeBar").style.width = fastScheduleTime + "px";
	$("fastCurrentTime").style.left = 140 + fastScheduleTime + "px";
	getCurrentTime();
}

// 换算时间
function timeChange(temp) {
	// 时间换算h:m:s为妙
	var timegroup = temp.split(":");
	var newtime = parseInt(timegroup[0] * 3600) + parseInt(timegroup[1] * 60)
			+ parseInt(timegroup[2]);
	return newtime;
}

function dealTime(tempTime) {
	var currentStanTime = null;

	if (Math.floor((tempTime % 3600) / 60) < 10) {
		if (tempTime % 60 < 10) {
			currentStanTime = Math.floor(tempTime / 3600) + ":0"
					+ Math.floor((tempTime % 3600) / 60);
		} else {
			currentStanTime = Math.floor(tempTime / 3600) + ":0"
					+ Math.floor((tempTime % 3600) / 60);
		}
	} else {
		if (tempTime % 60 < 10) {
			currentStanTime = Math.floor(tempTime / 3600) + ":"
					+ Math.floor((tempTime % 3600) / 60);
		} else {
			currentStanTime = Math.floor(tempTime / 3600) + ":"
					+ Math.floor((tempTime % 3600) / 60);
		}
	}

	return currentStanTime;
}

function getCurrentTime() {
	var fastCurrentTime = timeChange(Date().split(" ")[4]);
	var startTime = parseInt(fastCurrentTime) - parseInt(timeLength);
	var tempTime = parseInt(startTime)
			+ parseInt((mp.getCurrentPlayTime() / 1000));
	$("fastCurrentTime").innerText = dealTime(tempTime);
}

// 显示音频控制页面
function volum() {
	volumePage.show();
	hiddenVolume();
}

function hiddenVolume() {
	clearTimeout(volumePageTimer);
	volumePageTimer = setTimeout(function() {
		volumePage.minimize()
	}, 3000);
}

function eventHandler(obj) {
	// lag 0： 页面无任何提示信息；1：显示Menu；3：快进；4：快退；6：暂停；5：播放
	
	if (flag == 0) {
		if (((obj.code.length > 0)) || (obj.code == "KEY_BACK")
				|| (obj.code == "KEY_DOWN") || (obj.code == "KEY_LEFT")) {
			switch (obj.code) {
			case "KEY_BACK":
				window.location.href = newbackUrl;
				break;
			case "KEY_UP":
				changeChannel(1);
				break;
			case "KEY_DOWN":
				changeChannel(-1);
				break;
			case "KEY_PAUSEPLAY":
				if (ispltv)
					pause();
				break;
			case "KEY_LEFT":
				volum();
				break;
			case "KEY_RIGHT":
				volum();
				break;
			case "KEY_SWITCH":
				goPreChannel();
				break;
			case "KEY_FAST_FORWARD":
				if (ispltv
						&& ((mp.getCurrentPlayTime() / 1000) != mp
								.getMediaDuration()))
					mediaForward();
				break;
			case "KEY_FAST_REWIND":
				if (ispltv)
					mediaBackward();
				break;
			case "KEY_SELECT":
				visibleChannelList();
				break;
			}
		}
	} else if (flag == 1) {
		switch (obj.code) {
		case "KEY_UP":
			moveChannel(-1);
			break;
		case "KEY_DOWN":
			moveChannel(1);
			break;
		case "KEY_PAGE_UP":
			turnPage(-1);
			break;
		case "KEY_PAGE_DOWN":
			turnPage(1);
			break;
		case "KEY_SWITCH":
			goPreChannel();
			break;
		case "KEY_SELECT":
			if (moveFlag)
				doSelect();
			else
				hiddenChannelList();
			break;
		case "KEY_BACK":
			window.location.href = newbackUrl;
			break;
		}
	} else if (flag == 3) { // 快进
		switch (obj.code) {
		case "KEY_FAST_FORWARD":
			mediaForward();
			break;
		case "KEY_FAST_REWIND":
			mediaBackward();
			break;
		case "KEY_PAUSEPLAY":
			play();
			break;
		case "KEY_BACK":
			window.location = newbackUrl;
			break;
		case "KEY_SELECT":
			play();
			break;
		}
	} else if (flag == 4) { // 快退
		switch (obj.code) {
		case "KEY_FAST_FORWARD":
			mediaForward();
			break;
		case "KEY_FAST_REWIND":
			mediaBackward();
			break;
		case "KEY_SELECT":
			play();
			break;
		case "KEY_PAUSEPLAY":
			play();
			break;
		case "KEY_BACK":
			window.location = newbackUrl;
			break;
		}
	} else if (flag == 5) { // 播放
		switch (obj.code) {
		case "KEY_FAST_FORWARD":
			mediaForward();
			break;
		case "KEY_FAST_REWIND":
			mediaBackward();
			break;
		case "KEY_SELECT":
			hiddenForwardTips();
			break;
		case "KEY_PAUSEPLAY":
			pause();
			break;
		case "KEY_BACK":
			window.location.href = newbackUrl;
			break;
		case "KEY_SWITCH":
			goPreChannel();
			break;
		}
	} else if (flag == 6) { // 暂停
		switch (obj.code) {
		case "KEY_FAST_FORWARD":
			mediaForward();
			break;
		case "KEY_FAST_REWIND":
			mediaBackward();
			break;
		case "KEY_SELECT":
			play();
			break;
		case "KEY_PAUSEPLAY":
			play();
			break;
		case "KEY_BACK":
			window.location.href = newbackUrl;
			break;
		}
	}

	// 显示播放结束后的响应页面
	switch (obj.code) {
	case "KEY_SYSTEM":
		clearTimeout(playTimeoutID);
		eval("var data = " + Utility.getEvent());
		if (data.type == "EVENT_PLAYMODE_CHANGE") {
			var temp = data.new_play_mode;
			if (temp == 2) {
				flag = 0;
				$("fastForward").style.visibility = "hidden";
				$("forwardTips").style.visibility = "hidden";
			}
		}
		break;
	}
}