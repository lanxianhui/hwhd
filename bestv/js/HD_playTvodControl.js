var program = {}; // 0.none 1.play 2.pause 3.forward 4.backword
var startTime = 0;
var endTime = 0;
var continueFlag = false;
var requestParams = null;
var infobar = null;
var tip = null;
var CHANNELID = null;
var PROGID = null;
var programList = [];
var date = [];
var tvod = [];
var programIndex = null;
var tvodList = [];
var initDate = null;

var tvod_total = 0;
var tvod_pagenum = 6;
var tvod_totalPage = 1 + Math.floor((tvod_total - 1) / tvod_pagenum);
var tvod_nowPage = null;
var tvod_shown = null;
var tvod_subPos = null;
var tvod_limit = null;
var playTime = [];

// -------------------------------------------------回看日期列表--------------------------------------------

// 显示进度条和回看节目单列表
var hiddenMenuAndTvodID = null;
var menuHiddenDuration = "5000";
function displayTvodMenus() {

	if($("date_back").style.backgroundImage.indexOf("date_no_focus") > -1) {
		$("flag").value = 2;
	} else { 
		$("flag").value = 1;
	}
	
	showMenuAndTvod();
}

function showMenuAndTvod() {
	$("tvod_main").style.webkitTransitionDuration = "200";
	$("tvod_main").style.visibility = "visible";
	$("infobar").style.visibility = "visible";
	clearTimeout(hiddenMenuAndTvodID);
	hiddenMenuAndTvodID = setTimeout("hiddenMenuAndTvod()", menuHiddenDuration);
}

function clearHiddenMenuAndTvod() {
	clearTimeout(hiddenMenuAndTvodID);
	hiddenMenuAndTvodID = setTimeout("hiddenMenuAndTvod()", menuHiddenDuration);
}

function hiddenMenuAndTvod() {

	if($("flag").value != 9 )
		$("flag").value = 0;
	$("tvod_main").style.visibility = "hidden";
	$("infobar").style.visibility = "hidden";
	$("tvod_main").style.left = "-10px";
	$("infobar").style.left = "176px";
}

// 获取回看节目单数据
function getTvodData(__xmlhttp) {
	programList = eval(__xmlhttp.responseText);
	initTvodParams();
	displayDate();
}

// 初始化回看节目单参数
function initTvodParams() {
	for ( var i = 0; i < tvod_pagenum; i++) {
		date[i] = $("date" + i);
		tvod[i] = $("list" + i);
	}
}

function initTvodData() {
	for ( var i = 0; i < tvod_pagenum; i++) {
		date[i].style.fontSize = "28px";
		date[i].style.color = "#393939";
	}
}

// 显示日期列表
function displayDate() {
	initTvodData();
	if (programIndex == null) {
		for ( var i = 0; i < tvod_pagenum; i++) {
			date[i].innerText = dealDateTime(programList[i].day);
			if (initDate == programList[i].day) {
				programIndex = i;
			}
		}
		$("date_back").style.webkitTransitionDuration = "0";
	} else {
		$("date_back").style.webkitTransitionDuration = "200";
	}

	var indexTop = date[programIndex].style.top;
	$("date_back").style.top = indexTop - 25 + "px";
	setTimeout(function() {
		date[programIndex].style.fontSize = "30px";
		date[programIndex].style.color = "#FFFFFF";
	}, "200");
	tvodList = programList[programIndex].info;

	initTvod();
}

// 设置回当前日期背景图片并显示日期列表
function selectDate(num) {

	if (num == 1) { // 向上
		if (programIndex == 5) {
			programIndex = 0;
			$("date_back").style.webkitTransitionDuration = "0";
		} else {
			programIndex += num;
			$("date_back").style.webkitTransitionDuration = "200";
		}
	}

	if (num == -1) { // 向下
		if (programIndex == 0) {
			programIndex = 5;
			$("date_back").style.webkitTransitionDuration = "0";
		} else {
			programIndex += num;
			$("date_back").style.webkitTransitionDuration = "200";
		}
	}

	displayDate();
}

// -----------------------------------------------日期/回看列表切换函数--------------------------------------------

function keyRight() {
	$("flag").value = 2;
	$("date_back").style.backgroundImage = "url(images/tvod/date_no_focus.png)";
	$("tvod_back").style.backgroundImage = "url(images/tvod/tvod_focus.png)";
}

function returnDate() {
	$("flag").value = 1;
	$("date_back").style.backgroundImage = "url(images/tvod/date_focus.png)";
	$("tvod_back").style.backgroundImage = "url(images/tvod/tvod_no_focus.png)";
}

// -------------------------------------------------回看节目单列表--------------------------------------------

// 初始化回看列表参数
function initTvod() {
	var tvod_index = 0;
	tvod_total = tvodList.length;
	for ( var i = tvod_total-1 ; i >= 0; i--) {
		if (program.PROGBEGIN.indexOf(tvodList[i].startTime) > -1) {
			tvod_index = i;
			break;
		}
	}

	tvod_totalPage = 1 + Math.floor((tvod_total - 1) / tvod_pagenum);
	tvod_nowPage = 1 + Math.floor((tvod_index) / tvod_pagenum);
	tvod_shown = (tvod_nowPage - 1) * tvod_pagenum;
	tvod_subPos = tvod_index % tvod_pagenum;
	tvod_limit = Math.min((tvod_total - tvod_shown), tvod_pagenum);

	displayProgramList(); // 选择选中日期的回看节目单
}

// 显示当前日期的节目单
function displayProgramList() {

	if (tvod_total == 0) {

		for ( var i = 1; i < tvod_pagenum; i++) {
			tvod[i].innerText = "";
		}

		$("tvod_back").style.webkitTransitionDuration = "0";
		tvod[0].style.fontSize = "26px";
		tvod[0].style.color = "#333333";
		tvod[0].innerText = "暂无回看节目单.";
		$("tvod_tag").style.top = (date[0].style.top + 7) + "px";
		$("tvod_tag").innerText = "";
		$("tvod_back").style.top = (date[0].style.top - 22) + "px";
	} else {
		if (tvod_limit == tvod_pagenum) {
			for ( var i = 0; i < tvod_pagenum; i++) {
				if (tvodList[i + tvod_shown].nowState == "now"
						|| tvodList[i + tvod_shown].nowState == "after") {
					tvod[i].style.color = "#707070";
				}
				tvod[i].innerHTML = processTime(tvodList[i + tvod_shown].startTime)
						+ " &nbsp;&nbsp;"
						+ tvodList[i + tvod_shown].name.cutString(9);
			}
		} else {
			for ( var i = 0; i < tvod_limit; i++) {
				if (tvodList[i + tvod_shown].nowState == "now"
						|| tvodList[i + tvod_shown].nowState == "after") {
					tvod[i].style.color = "#707070";
				}
				tvod[i].innerHTML = processTime(tvodList[i + tvod_shown].startTime)
						+ " &nbsp;&nbsp;"
						+ tvodList[i + tvod_shown].name.cutString(9);
			}
			for ( var i = tvod_limit; i < tvod_pagenum; i++) {
				tvod[i].innerText = "";
			}
		}
		selectTvod();
	}
}

function showTvodStatus(state) {
	var temp = "";
	switch (state) {
	case "ago":
		temp = "回看";
		break;
	case "now":
		temp = "直播";
		break;
	case "after":
		temp = "将看";
		break;
	}

	return temp;
}

// 选中当前正在播放的回看节目
function selectTvod() {

	for ( var i = 0; i < Math.min(tvod_limit, tvod_pagenum); i++) {
		if (i == tvod_subPos) {
			var tvod_top = tvod[tvod_subPos].style.top;
			$("tvod_back").style.top = tvod_top - 22 + "px";
			$("tvod_tag").style.top = tvod_top + 7 + "px";
			setTimeout(
					function() {
						tvod[tvod_subPos].style.fontSize = "26px";
						tvod[tvod_subPos].style.color = "#333333";

						if (tvodList[tvod_subPos + tvod_shown].name.length > 9) {
							tvod[tvod_subPos].innerHTML = processTime(tvodList[tvod_subPos
									+ tvod_shown].startTime)
									+ " &nbsp;&nbsp;"
									+ tvodList[tvod_subPos + tvod_shown].name
											.cutString(7);
						}

					}, "200");

			if (tvodList[i + tvod_shown].name == program.PROGNAME) {
				$("tvod_tag").innerText = "正播";
			} else {
				$("tvod_tag").innerText = showTvodStatus(tvodList[i
						+ tvod_shown].nowState);
			}

		} else {
			tvod[i].style.fontSize = "24px";
			tvod[i].style.color = "#FFFFFF";
			tvod[i].innerHTML = processTime(tvodList[i + tvod_shown].startTime)
					+ " &nbsp;&nbsp;"
					+ tvodList[i + tvod_shown].name.cutString(9);
		}
	}
}

var moveFlag = false;
function changeTvodFocusUD(num) {
	moveFlag = true;
	if (tvod_subPos == 0) {
		if (num == -1) {
			turnTvodPage(num);
		} else {
			tvod_subPos += num;
			if (tvod[tvod_subPos].innerText.length == 1) {
				turnTvodPage(num);
			} else {
				$("tvod_back").style.webkitTransitionDuration = "200";
				$("tvod_tag").style.webkitTransitionDuration = "200";
				selectTvod();
			}
		}
	} else if (tvod_subPos == 5) {
		if (num == 1) {
			turnTvodPage(num);
		} else {
			tvod_subPos += num;
			if (tvod[tvod_subPos].innerText.length == 1) {
				turnTvodPage(num);
			} else {
				$("tvod_back").style.webkitTransitionDuration = "200";
				$("tvod_tag").style.webkitTransitionDuration = "200";
				selectTvod();
			}
		}
	} else {
		tvod_subPos += num;
		if (tvod[tvod_subPos].innerText.length == 1) {
			turnTvodPage(num);
		} else {
			$("tvod_back").style.webkitTransitionDuration = "200";
			$("tvod_tag").style.webkitTransitionDuration = "200";
			selectTvod();
		}
	}
}

function turnTvodPage(num) {

	tvod_nowPage += num;
	if (tvod_nowPage > tvod_totalPage) {
		tvod_nowPage = 1;
	}
	if (tvod_nowPage < 1) {
		tvod_nowPage = tvod_totalPage;
	}

	tvod_shown = (tvod_nowPage - 1) * tvod_pagenum;
	var rest = tvod_total - tvod_shown;
	tvod_limit = Math.min(tvod_pagenum, rest);

	if (num >= 0) {
		tvod_subPos = 0;
	} else {
		tvod_subPos = tvod_limit - 1;
	}

	$("tvod_back").style.webkitTransitionDuration = "0";
	$("tvod_tag").style.webkitTransitionDuration = "0";
	displayProgramList();
	selectTvod();
}

function doSelect() {
//	if (tvodList[tvod_subPos + tvod_shown].nowState == "ago" || tvodList[tvod_subPos + tvod_shown].nowState == "now") {
	if (tvodList[tvod_subPos + tvod_shown].nowState == "ago") {
		exit();
		window.location.href = tvodList[tvod_subPos + tvod_shown].turnUrl;
	}
}

// -------------------------------------------------回看播控页面公用函数--------------------------------------------
function processTime(time) {

	var timegroup = time.split(":");
	if ((timegroup[0].substring(0, 1) == 0))
		timegroup[0] = timegroup[0].replace("0", "&nbsp;&nbsp;");

	if (timegroup[0].length == 1)
		timegroup[0] = "&nbsp;&nbsp;" + timegroup[0];

	return timegroup[0] + ":" + timegroup[1];
}

function showTip(str) {
	tip.innerText = str;
	tip.style.visibility = "visible";
}

function hideTip() {
	tip.innerText = "";
	tip.style.visibility = "hidden";
}

function playVod() {

	mp.setVideoDisplayMode(0);
	mp.setAllowTrickmodeFlag(0);
	mp.setSingleMedia(program.PLAYJSON);
	mp.setCycleFlag(1);
	mp.setRandomFlag(1);
	mp.playFromStart();
}

function exit() {
	mutePage.minimize();
	mp.stop();
	mp.releaseMediaPlayer(NativePlayerInstanceID);

	volumePage.minimize();
	var mutePage = iPanel.pageWidgets.getByName("mutePage");
	if (typeof ($("muteDiv")) != "undefined") {
		$("muteDiv").style.visibility = "hidden";
	}
	
	iPanel.eventFrame.tvodBackUrl == "";
}

function dealDateTime(date) {

	var timegroup = date.split("月");

	if (timegroup[0].substring(0, 1) == 0)
		timegroup[0] = timegroup[0].replace(/0/g, "&nbsp;&nbsp;");

	if (timegroup[1].substring(0, 1) == 0)
		timegroup[1] = timegroup[1].replace(/0/g, "&nbsp;&nbsp;");

	return timegroup[0] + "月" + timegroup[1];
}

// 换算时间
function timeChange(temp) {
	// 时间换算h:m:s为妙
	var timegroup = temp.split(":");
	var newtime = parseInt(timegroup[0] * 3600) + parseInt(timegroup[1] * 60)
			+ parseInt(timegroup[2]);
	return newtime;
}

// -------------------------------------------------当前流时间处理

function fastTime() {
	var fastCurrentTime = timeChange($("fastCurrentTime").innerText);
	var tempTime = null;
	if ($("flag").value == "3")
		tempTime = fastCurrentTime + parseInt($("fastNum").value);
	if ($("flag").value == "4")
		tempTime = fastCurrentTime + parseInt($("rewindNum").value);
	if ($("flag").value == "5")
		tempTime = fastCurrentTime + 1;
	if ($("flag").value == "6")
		tempTime = fastCurrentTime;

	if (Math.floor((tempTime % 3600) / 60) < 10) {
		if (tempTime % 60 < 10) {
			var currentTime = Math.floor(tempTime / 3600) + ":0"
					+ Math.floor((tempTime % 3600) / 60) + ":0" + tempTime % 60;
		} else {
			var currentTime = Math.floor(tempTime / 3600) + ":0"
					+ Math.floor((tempTime % 3600) / 60) + ":" + tempTime % 60;
		}
	} else {
		if (tempTime % 60 < 10) {
			var currentTime = Math.floor(tempTime / 3600) + ":"
					+ Math.floor((tempTime % 3600) / 60) + ":0" + tempTime % 60;
		} else {
			var currentTime = Math.floor(tempTime / 3600) + ":"
					+ Math.floor((tempTime % 3600) / 60) + ":" + tempTime % 60;
		}
	}

	if (tempTime > timeChange(program.PROGEND)) {
		$("fastCurrentTime").innerText = program.PROGEND;
	} else if (tempTime < timeChange(program.PROGBEGIN))
		$("fastCurrentTime").innerText = program.PROGBEGIN;
	else
		$("fastCurrentTime").innerText = currentTime;
}

var currentStanTime = null

/**
 * 功能：显示当前播放时间
 * @return
 */
function getCurrentTime() {
	var fastCurrentTime = timeChange(program.PROGBEGIN);
	if (mp.getCurrentPlayTime <= 0) {
		tempTime = fastCurrentTime;
	} else {
		var tempTime = parseInt(fastCurrentTime)
				+ parseInt(mp.getCurrentPlayTime());
	}

	if (Math.floor((tempTime % 3600) / 60) < 10) {
		if (tempTime % 60 < 10) {
			currentStanTime = Math.floor(tempTime / 3600) + ":0"
					+ Math.floor((tempTime % 3600) / 60) + ":0" + tempTime % 60;
		} else {
			currentStanTime = Math.floor(tempTime / 3600) + ":0"
					+ Math.floor((tempTime % 3600) / 60) + ":" + tempTime % 60;
		}
	} else {
		if (tempTime % 60 < 10) {
			currentStanTime = Math.floor(tempTime / 3600) + ":"
					+ Math.floor((tempTime % 3600) / 60) + ":0" + tempTime % 60;
		} else {
			currentStanTime = Math.floor(tempTime / 3600) + ":"
					+ Math.floor((tempTime % 3600) / 60) + ":" + tempTime % 60;
		}
	}

	$("fastCurrentTime").innerText = currentStanTime;
}

// -------------------------------------------------快进、快退、暂停函数----------------------------------

/**
 * 功能：暂停流播放
 * 触发事件：按暂停
 */
function pause() {
	$("flag").value = 6;	//暂停标识符
	initForwardRewind();
	clearTimeout(hiddenPlayBarTimeout);
	clearInterval(fastForwardId);
	moveNum = Math.floor(mp.getCurrentPlayTime() / timeLength * 24);
	changeFastTimeBar();
	changeCurrentTime();
	leaveTimeEnterArea();
	mp.pause();
	seekNumber[0] = playTime['BEGINHOUR'];
	seekNumber[1] = playTime['BEGINMINU'];
}

var hiddenPlayBarTimeout = null;  //五秒后消失播放进度条
function play() {
	// 播放
	mp.resume();
	speed = 1;
	$("flag").value = 5;
	initForwardRewind();
	fastScheduleTime = timePer * (mp.getCurrentPlayTime());
	displayFRBar();
	fastForwardId = setInterval("fastAndRewindBar()", 1000);
	hiddenPlayBarTimeout = setTimeout(function () {
    	hiddenForwardTips();
    	clearInterval(fastForwardId);
    }, pausePlayTime);
    
}

function hiddenForwardTips() {
	// 隐藏快进、快退
	if ($("flag").value !== 9) 
		$("flag").value = 0;
	
	$("rewindNum").value = 0;
	$("fastNum").value = 0;
	$("fastForward").style.visibility = "hidden";
	$("forwardTips").style.visibility = "hidden";
	$("pauseBar").style.visibility = "hidden";
	$("pauseTime").style.visibility = "hidden";
}

var timeLength = 0;
var timePer = 0.0;
var fastScheduleTime = 0.0;
var fastForwardId = null;

function noChannel(channelNumber) {
	$("channelPrompg").style.webkitTransitionDuration = "500ms";
	$("channelPrompg").style.webkitTransform = "scale(1)";
	$("channelPrompgText").innerText = "频道<" + channelNumber + ">不存在";
	setTimeout('$("channelPrompg").style.webkitTransform= "scale(0)"', 4000);
}

/**
 * 函数功能：显示暂停、快进、快退进度条
 * @return
 */
function changeFastTimeBar() {
	if ($("flag").value == 6) { // 暂停
		$("flag").value = 7;
		$("enterTime").style.visibility 		= "visible";
		$("fastBackground").style.visibility 	= "hidden";
		$("fastTimeBar").style.visibility 		= "hidden";
		$("pauseFastBar").style.visibility 		= "visible";
		$("pauseBar").style.visibility 			= "visible";
		$("pauseBar").style.left				= 152 + Math.floor(timePer * (mp.getCurrentPlayTime())) + "px";
		$("pauseTime").style.visibility 		= "visible";
		$("pauseTime").style.left 				= 135 + Math.floor(timePer * (mp.getCurrentPlayTime())) + "px";
		$("pauseTime").innerText 				= currentStanTime;
	} else {
		displayFRBar();
	}
	
	fastAndRewindBar();
}

/**
 * 功能：显示当前快进、快退条
 * @return
 */
function displayFRBar() {
	$("enterTime").style.visibility 		= "hidden";
	$("fastBackground").style.visibility 	= "visible";
	$("fastTimeBar").style.visibility 		= "visible";
	$("pauseFastBar").style.visibility 		= "hidden";
	$("pauseBar").style.visibility 			= "hidden";
	$("pauseTime").style.visibility 		= "hidden";
}

/**
 * 功能：跟新进度条并显示当前时间
 * @return
 */
function fastAndRewindBar() {
	fastScheduleTime = timePer * (mp.getCurrentPlayTime());
	$("fastTimeBar").style.width = fastScheduleTime + "px";
	getCurrentTime();
}

/**
 * 功能：初始化快进、快退显示页面
 * 触发事件：按快进、快退、暂停
 * @return
 */
function initForwardRewind() {
	$("tvod_main").style.visibility = "hidden";   	//隐藏回看日期、回看列表
	$("infobar").style.visibility 	= "hidden";		//隐藏信息条
	if (program.CHANNELNAME != "undefined") $("fastName").innerText 	= program.CHANNELNAME + ":&nbsp;" + program.PROGNAME.cutString(14);
	if (program.PROGBEGIN != "undefined") 	$("startTime").innerText 	= program.PROGBEGIN;
	if (program.PROGEND != "undefined") 	$("endTime").innerText 		= program.PROGEND;
	
	// 显示快进、快退
	$("fastForward").style.visibility 	= 	"visible";
	$("forwardTips").style.visibility 	= 	"visible";
	$("enterTime").style.visibility		=	($("flag").value == 6) ? "visible" : "hidden";
	
	// 屏幕右上角提示按钮
	switch ($("flag").value) {
		case "3": $("forwardTips").style.backgroundImage = "url(images/tvod/forward_" + speed + ".png)"; break; // 快进
		case "4": $("forwardTips").style.backgroundImage = "url(images/tvod/rewind_"+ speed + ".png)"; break; 	// 快退
		case "5": $("forwardTips").style.backgroundImage = "url(images/tvod/play.png)"; break; 					// 播放
		case "6": $("forwardTips").style.backgroundImage = "url(images/tvod/pause.png)"; break; 				// 暂停
	}
}

var speed = 1;

function mediaBackward() {
	clearTimeout(hiddenPlayBarTimeout);
	if (speed > 0)
		speed = -2;
	else
		speed = speed * 4;
	if (speed < -32) {
		play();
	} else {
		mp.fastRewind(speed);
		showPlayStatus();
	}
}

function mediaForward() {
	clearTimeout(hiddenPlayBarTimeout);
	$("flag").value = 3;
	if (speed < 0 || speed == 1)
		speed = 2;
	else
		speed = speed * 4;
	if (speed > 32) {
		play();
	} else {
		mp.fastForward(speed);
		showPlayStatus();
	}
}

function showPlayStatus() {
	// 快进
	initForwardRewind();
	clearInterval(fastForwardId);
	displayFRBar();
	fastForwardId = setInterval("fastAndRewindBar()", "1000");
}

// -------------------------------------------------暂停、输入时间----------------------------------------
var inputFlag = false;
var seekNumber = [];
var enterPosition = "";

function enterHour() {

	if (playTime['ENDHOUR'] == playTime['BEGINHOUR']) {
		enterPosition = "MINUTE";
		setStyle($("pauseMinuteInputImage"), "97px", "37px", "12px", "360px",
				"url(images/tvod/imageFlag.png)");
		$("goto").style.backgroundImage = "url(images/tvod/goto.png)";
	} else {
		enterPosition = "HOUR";
		setStyle($("pauseHourInputImage"), "97px", "37px", "12px", "240px",
				"url(images/tvod/imageFlag.png)");
		setStyle($("pauseMinuteInputImage"), "86px", "27px", "16px", "370px",
				"url(images/tvod/pauseInput.png)");
	}
}

function enterMinute() {
	enterPosition = "MINUTE";
	setStyle($("pauseMinuteInputImage"), "97px", "37px", "12px", "360px",
			"url(images/tvod/imageFlag.png)");
	setStyle($("pauseHourInputImage"), "86px", "27px", "16px", "250px",
			"url(images/tvod/pauseInput.png)");
	$("goto").style.backgroundImage = "url(images/tvod/goto.png)";
}

function timeTips() {
	$("inputTips").innerText = "超越范围!请重新输入!";
}

function goToTime() {
	setStyle($("pauseMinuteInputImage"), "86px", "27px", "16px", "370px",
			"url(images/tvod/pauseInput.png)");
	$("goto").style.backgroundImage = "url(images/tvod/gotoFlag.png)";
	enterPosition = "GOTO";
}

function leaveTimeEnterArea() {
	setStyle($("pauseMinuteInputImage"), "86px", "27px", "16px", "370px",
			"url(images/tvod/pauseInput.png)");
	setStyle($("pauseHourInputImage"), "86px", "27px", "16px", "250px",
			"url(images/tvod/pauseInput.png)");
	$("goto").style.backgroundImage = "url(images/tvod/goto.png)";
}

function setStyle(imageObj, width, height, top, left, image) {
	imageObj.style.width = width;
	imageObj.style.height = height;
	imageObj.style.top = top;
	imageObj.style.left = left;
	imageObj.style.backgroundImage = image;
}

function inputSeekNum(n) {

	$("inputTips").innerText = "";
	if (enterPosition == "HOUR") {
		if (inputFlag) {
			seekNumber[0] = seekNumber[0] * 10 + n;
			if ((parseInt(playTime['BEGINHOUR']) <= seekNumber[0]) && (parseInt(playTime['ENDHOUR']) >= seekNumber[0])) {
				$("hourInput").innerText = seekNumber[0] < 10 ? ("0" + seekNumber[0]) : seekNumber[0];
				inputFlag = false;
				if(seekNumber[0] == parseInt(playTime['ENDHOUR'])) seekNumber[1] = 0;
				enterMinute();
			} else {
				timeTips();
				$("hourInput").innerText = playTime['BEGINHOUR'];
				inputFlag = false;
				seekNumber[0] = playTime['BEGINHOUR'];
			}
		} else {
			inputFlag = true;
			seekNumber[0] = n;
		}
	} else if (enterPosition == "MINUTE") {

		if (inputFlag) {
			seekNumber[1] = seekNumber[1] * 10 + n;
			var temp = seekNumber[0] * 3600 + seekNumber[1] * 60;
			if ((timeChange(program.PROGBEGIN) <= temp) && (temp <= timeChange(program.PROGEND)) && (seekNumber[1] < 60)) {
				$("minuteInput").innerText = seekNumber[1] < 10 ? ("0" + seekNumber[1]) : seekNumber[1];
				inputFlag = false;
				goToTime();
			} else {
				timeTips();
				$("minuteInput").innerText = playTime['BEGINMINU'];
				inputFlag = false;
				return;
			}
		} else {
			inputFlag = true;
			seekNumber[1] = n;
		}
	}

	if (enterPosition == "HOUR")
		$("hourInput").innerText = seekNumber[0] < 10 ? ("0" + seekNumber[0]) : seekNumber[0];

	if (enterPosition == "MINUTE")
		$("minuteInput").innerText = seekNumber[1] < 10 ? ("0" + seekNumber[1]) : seekNumber[1];
}

function gotoSeek(t) {
	var type = 1; // "Normal Play Time", "Absolute Time";
	var time = t; // seconds
	mp.playByTime(type, time);
}

function playBySeek() {

	if ($("flag").value == 6) {
		var temp = (seekNumber[0] * 3600 + (seekNumber[1] * 60))
				- timeChange(program.PROGBEGIN);
		gotoSeek(temp);
		hiddenForwardTips();
	}
}

function pauseByTimePlay() {
	setPauseVisible();
	var temp = timeChange($("pauseTime").innerText)
			- timeChange(program.PROGBEGIN);
	gotoSeek(temp);
	hiddenForwardTips();
}

function pausePlay() {
	setPauseVisible();
	play();
}

function setPauseVisible() {
	setVisible($("pauseFastBar"), "hidden");
	setVisible($("pauseBar"), "hidden");
	setVisible($("pauseTime"), "hidden");
	setVisible($("fastBackground"), "visible");
	setVisible($("fastTimeBar"), "visible");
}

function setVisible(visibleObject, param) {
	visibleObject.style.visibility = param;
}

function timeRight() {
	seekNumber[0] = playTime['BEGINHOUR'];
	seekNumber[1] = playTime['BEGINMINU'];
	if (enterPosition == "") {
		enterHour();
	} else if (enterPosition == "HOUR") {
		enterMinute();
	} else if (enterPosition == "MINUTE") {
		goToTime();
	}
}

function timeLeft() {
	seekNumber[0] = playTime['BEGINHOUR'];
	seekNumber[1] = playTime['BEGINMINU'];
	if (enterPosition == "GOTO") {
		enterMinute();
	} else if (enterPosition == "MINUTE") {
		enterHour();
	}
}

// 暂停时间瞬移

var moveNum = 0;
function pauseTimeRight() {

	if (moveNum < 23) {
		var temp = 0;
		if (moveNum % 2 == 0)
			temp = 23;
		else
			temp = 22;
		setLeft($("pauseBar"), temp, "ADD");
		setLeft($("pauseTime"), temp, "ADD");
		moveNum = moveNum + 1;
		changeCurrentTime("ADD");
	}
}

function changeCurrentTime(operation) {

	var pauseTime = timeChange(program.PROGBEGIN);
	var timeMove = Math.floor(perTime * 24 * moveNum);
	var tempTime = pauseTime + timeMove;

	if (Math.floor((tempTime % 3600) / 60) < 10) {
		if (tempTime % 60 < 10) {
			currentStanTime = Math.floor(tempTime / 3600) + ":0"
					+ Math.floor((tempTime % 3600) / 60) + ":0" + tempTime % 60;
		} else {
			currentStanTime = Math.floor(tempTime / 3600) + ":0"
					+ Math.floor((tempTime % 3600) / 60) + ":" + tempTime % 60;
		}
	} else {
		if (tempTime % 60 < 10) {
			currentStanTime = Math.floor(tempTime / 3600) + ":"
					+ Math.floor((tempTime % 3600) / 60) + ":0" + tempTime % 60;
		} else {
			currentStanTime = Math.floor(tempTime / 3600) + ":"
					+ Math.floor((tempTime % 3600) / 60) + ":" + tempTime % 60;
		}
	}

	$("pauseTime").innerText = currentStanTime;

}

function pauseTimeLeft() {
	if (moveNum > 0) {
		var temp = 0;
		if (moveNum % 2 == 0)
			temp = 23;
		else
			temp = 22;
		setLeft($("pauseBar"), temp, "SUB");
		setLeft($("pauseTime"), temp, "SUB");
		moveNum = moveNum - 1;
		changeCurrentTime("ADD");
	}
}

function setLeft(itemObject, left, operation) {
	if (operation == "SUB") {
		itemObject.style.left = itemObject.style.left - left + "px";
	}

	if (operation == "ADD") {
		itemObject.style.left = itemObject.style.left + left + "px";
	}
}

function getLeft(itemObject) {
	return itemObject.style.left;
}

// -------------------------------------------------初始化函数--------------------------------------------
var scheduleTime = 0.0;
var perTime = 0.0;
function initInforBar() {
	if (program.CHANNELNAME != "undefined")
		$("title").innerHTML = "<font color='#00A8FF'>"
				+ program.CHANNELNAME + "</font>" + ":&nbsp;"
				+ program.PROGNAME.cutString(12);
	$("time").innerText = program.PROGBEGIN.substr(0, 5) + "-"
			+ program.PROGEND.substr(0, 5);

	var startime = timeChange(program.PROGBEGIN);
	var endtime = timeChange(program.PROGEND);
	var timeLength = endtime - startime;
	var timePer = 182 / timeLength;

	// 显示时间进度条
	setInterval(function() {
		if (scheduleTime < 182) {
			scheduleTime = timePer * (mp.getCurrentPlayTime());
			$("scheduleTime").style.width = scheduleTime + "px";
		}
	}, "1000");
	if (program.PREPROGNAME != "undefined")
		$("lastProgramName").innerText = program.PREPROGNAME.substr(0, 14);
	if (program.NEXTPROGNAME != "undefined")
		$("nextProgramName").innerText = program.NEXTPROGNAME.substr(0, 14);
	initDate = program.PROGDATE;
	reqChannelTvodList(CHANNELID);
}

// Json请求
function reqChannelTvodList(InnerChannelID) {
	var requestUrl = "HD_channelProgInfo.jsp?CHANNELID=" + InnerChannelID;
	var ajaxObj = new AJAX_OBJ(requestUrl, getTvodData);
	ajaxObj.requestData();
}

// 请求TVOD详细信息
function getTvodParam() {

	var url = "HD_tvodPlayData.jsp" + requestParams;
	var ajaxObj = new AJAX_OBJ(url, vodSuccess);
	ajaxObj.requestData();
}

function vodSuccess(__xmlhttp) {
	var data = eval(__xmlhttp.responseText);

	if (typeof data == "undefined")
		showTip("请求数据为空！");
	else {
		hideTip();
		program = data[0];
		playVod();

		var temp = setInterval(function() {
			timeLength = mp.getMediaDuration();
			timePer = 545 / timeLength;
			perTime = timeLength / 552;
		}, "100");

		setTimeout(function() {
			clearInterval(temp);
			timeLength = mp.getMediaDuration();
			timePer = 545 / timeLength;
			perTime = timeLength / 552;
		}, "2000");

		var end = program.PROGEND.split(":");
		playTime['ENDHOUR'] = end[0];
		playTime['ENDMINU'] = end[1];
		var start = program.PROGBEGIN.split(":");
		playTime['BEGINHOUR'] = start[0];
		playTime['BEGINMINU'] = start[1];

		$("hourInput").innerText = playTime['BEGINHOUR'];
		$("minuteInput").innerText = playTime['BEGINMINU'];

		initInforBar();
	}
}

// 隐藏所有div层
function hiddenAllDIV() {
	$("tvod_main").style.visibility = "hidden";
	$("infobar").style.visibility = "hidden";
	$("fastForward").style.visibility = "hidden";
	$("forwardTips").style.visibility = "hidden";
	$("tip").style.visibility = "hidden";
}

// 影片播放结束时，事件处理机制
function playEnd() {
	hiddenAllDIV();
	document.body.style.backgroundImage = "url(images/play/thanks.jpg)";
	
	var current	= tvod_shown + tvod_subPos;
	var returnUrl = '';
	if ( tvod_total == current ) {
		var dayNext	= programIndex + 1;
		if (typeof(programList[dayNext].info) != undefined) {
			if (programList[dayNext].info[0].nowState == "ago") 
				returnUrl = tvodList[next].turnUrl;
		}
	} else {
		var next = current + 1;
		if (tvodList[next].nowState == "ago" ) {
			returnUrl = tvodList[next].turnUrl;
		}
	}
	
	if (returnUrl == '') {
		$("flag").value = 8;
		setTimeout(function() {
			window.location.href = iPanel.eventFrame.tvodBackUrl;
		}, 5000);
	} else {
		window.location.href = returnUrl;
	}
}

// 影片倒退到开始时，事件处理机制
function playBegining() {
	hiddenAllDIV();
	$("flag").value = 0;
}

// 显示音频控制页面
var volumFlag = false;
var volumePageTimer = -1;
function volum() {
	hiddenAllDIV();
	volumePage.show();
	hiddenVolume();
	volumFlag = true;
}

function hiddenVolume() {
	clearTimeout(volumePageTimer);
	volumePageTimer = setTimeout(function() {
		volumePage.minimize()
	}, 3000);
}

function init() {
	infobar = $("infobar");
	tip = $("tip");
	requestParams = window.location.search; // 获取回看节目页面传递过来的参数列表
	var params = window.location.search.substring(1).split("&");
	for ( var i = 0; i < params.length; i++) {
		if (params[i].indexOf("CHANNELID") > -1)
			CHANNELID = params[i].split("=")[1];
		if (params[i].indexOf("PROGID") > -1)
			PROGID = params[i].split("=")[1];
	}
	getTvodParam();
	setTimeout("hiddenMenuAndTvod()", "1000");

	// 加载声音控制widgets
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

	volumePage = iPanel.pageWidgets.getByName("volumePage");
	volumePage.moveTo(437, 163);
	volumePage.resizeTo(800, 800);

	// 记录返回URL
	
	if (typeof (iPanel.eventFrame.tvodBackUrl) == "undefined" || iPanel.eventFrame.tvodBackUrl == "" || 
		iPanel.eventFrame.tvodBackUrl != backUrl) {
		iPanel.eventFrame.eval("var tvodBackUrl = ''");
		iPanel.eventFrame.tvodBackUrl = backUrl;
	}
}

function keyBack() {
	volumePage.minimize();
	mp.pause();
	$("flag").value = 9;
	$("btn_exit").style.opacity	= "1";
//	window.location = iPanel.eventFrame.tvodBackUrl;
}

var playTimeoutID = null;
var pauseTimeoutID = null;
var pausePlayTime = "5000";
var continueFlag = true;
function eventHandler(obj) {
	// 显示播放结束后的响应页面
	switch (obj.code) {
	case "KEY_SYSTEM":
		clearTimeout(playTimeoutID);
		eval("var data = " + Utility.getEvent());
		code = data.type;
		if (code == "EVENT_MEDIA_END") {
			playEnd();
		}
		if (code == "EVENT_MEDIA_BEGINING") {
			playBegining();
		}
		break;
	}

	// FLAG,0---全屏播放；1---infobar; 2-- ; 3---快进;4---快退;6---暂停；
	if (($("flag").value) == 0) {
		if ((obj.code.length > 0)) {
			switch (obj.code) {
			case "KEY_BACK":
					keyBack();
				break;
			case "KEY_PAUSEPLAY":
				pause();
				break;
			case "KEY_FAST_FORWARD":
				mediaForward();
				break;
			case "KEY_FAST_REWIND":
				$("flag").value = 4; // rewind
				mediaBackward();
				break;
			case "KEY_LEFT":
				if (!isMute)
					volum();
				break;
			case "KEY_RIGHT":
				if (!isMute)
					volum();
				break;
			case "KEY_NUMERIC":
				forChannel();
				break;
			case "KEY_SELECT":
				if (volumFlag) {
					volumePage.minimize();
					volumFlag = false;
				} else
					displayTvodMenus();
				break;
			}
		} else {
			switch (obj.code) {
			case "KEY_BACK":
				keyBack();
				break;
			}
		}
	} else if (($("flag").value) == 1) {
		switch (obj.code) {
		case "KEY_UP":
			selectDate(-1);
			clearHiddenMenuAndTvod();
			break;
		case "KEY_DOWN":
			selectDate(1);
			clearHiddenMenuAndTvod();
			break;
		case "KEY_RIGHT":
			keyRight();
			break;
		case "KEY_NUMERIC":
			forChannel();
			break;
		case "KEY_BACK":
			keyBack();
			break;
		case "KEY_PAUSEPLAY":
			pause();
			break;
		case "KEY_FAST_FORWARD":
			mediaForward();
			break;
		case "KEY_FAST_REWIND":
			$("flag").value = 4; // rewind
			mediaBackward();
			break;
		}
	} else if (($("flag").value) == 2) {

		switch (obj.code) {
		case "KEY_UP":
			changeTvodFocusUD(-1);
			clearHiddenMenuAndTvod();
			break;
		case "KEY_DOWN":
			changeTvodFocusUD(1);
			clearHiddenMenuAndTvod();
			break;
		case "KEY_NUMERIC":
			forChannel();
			break;
		case "KEY_SELECT":
			if (moveFlag)
				doSelect();
			else
				hiddenMenuAndTvod();
			break;
		case "KEY_PAGE_UP":
			turnTvodPage(-1);
			clearHiddenMenuAndTvod();
			break;
		case "KEY_PAGE_DOWN":
			turnTvodPage(1);
			clearHiddenMenuAndTvod();
			break;
		case "KEY_LEFT":
			returnDate();
			clearHiddenMenuAndTvod();
			break;
		case "KEY_PAUSEPLAY":
			pause();
			break;
		case "KEY_FAST_FORWARD":
			mediaForward();
			break;
		case "KEY_FAST_REWIND":
			$("flag").value = 4; // rewind
			mediaBackward();
			break;
		case "KEY_BACK":
			keyBack();
			break;
		}
	} else if (($("flag").value) == 3) { // fastword
		switch (obj.code) {
		case "KEY_FAST_FORWARD":
			mediaForward();
			break;
		case "KEY_FAST_REWIND":
			$("flag").value = 4;
			mediaBackward();
			break;
		case "KEY_PAUSEPLAY":
			play();
			break;
		case "KEY_NUMERIC":
			forChannel();
			break;
		case "KEY_SELECT":
			play();
			break;
		case "KEY_BACK":
			keyBack();
			break;
		}
	} else if (($("flag").value) == 4) { // rewind
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
		case "KEY_NUMERIC":
			forChannel();
		case "KEY_SELECT":
			play();
			break;
		case "KEY_BACK":
			keyBack();
			break;
		}
	} else if (($("flag").value) == 5) { // play
		switch (obj.code) {
		case "KEY_FAST_FORWARD":
			mediaForward();
			break;
		case "KEY_FAST_REWIND":
			$("flag").value = 4;
			mediaBackward();
			break;
		case "KEY_PAUSEPLAY":
			clearTimeout(hiddenPlayBarTimeout);
			pause();
			break;
		case "KEY_NUMERIC":
			forChannel();
			break;
		case "KEY_LEFT":
			if (!isMute)
				volum();
			break;
		case "KEY_RIGHT":
			if (!isMute)
				volum();
			break;
		case "KEY_SELECT":
			hiddenForwardTips();
			break;
		case "KEY_BACK":
			keyBack();
			break;
		}
	} else if (($("flag").value) == 6) { // 暂停时光标停留在时间输入框
		switch (obj.code) {
		case "KEY_FAST_FORWARD":
			mediaForward();
			break;
		case "KEY_FAST_REWIND":
			$("flag").value = 4;
			mediaBackward();
			break;
		case "KEY_UP":
			$("flag").value = 7;
			$("pauseBar").style.backgroundImage = "url(images/tvod/vod_seek_td_focus.png)";
			leaveTimeEnterArea();
			break;
		case "KEY_RIGHT":
			timeRight();
			break;
		case "KEY_LEFT":
			timeLeft();
			break;
		case "KEY_DOWN":
			enterHour();
			break;
		case "KEY_SELECT":
			if (enterPosition == "GOTO") {
				$("goto").style.backgroundImage = "url(images/tvod/goto.png)";
				playBySeek();
			} else {
				play();
			}
			break;
		case "KEY_PAUSEPLAY":
			play();
			break;
		case "KEY_NUMERIC":
			inputSeekNum(obj.value);
			break;
		case "KEY_BACK":
			keyBack();
			break;
		}
	} else if (($("flag").value) == 7) { // 光标停留在进度条上 暂停
		switch (obj.code) {
		case "KEY_FAST_FORWARD":
			mediaForward();
			break;
		case "KEY_FAST_REWIND":
			$("flag").value = 4;
			mediaBackward();
			break;
		case "KEY_UP":
			break;
		case "KEY_NUMERIC":
			forChannel();
			break;
		case "KEY_PAUSEPLAY":
			pauseByTimePlay();
			$("flag").value = 5;
			break;
		case "KEY_RIGHT":
			if (continueFlag)
				pauseTimeRight();
			break;
		case "KEY_LEFT":
			if (continueFlag)
				pauseTimeLeft();
			break;
		case "KEY_DOWN":
			$("flag").value = 6;
			$("pauseBar").style.backgroundImage = "url(images/tvod/vod_seek_td_focus1.png)";
			enterHour();
			break;
		case "KEY_SELECT":
			pauseByTimePlay();
			$("flag").value = 5;
			break;
		case "KEY_BACK":
			keyBack();
			break;
		}
	} else if (($("flag").value) == 8) { // 播放完毕显示页面
		switch (obj.code) {
		case "KEY_EXIT":
			keyBack();
			break;
		case "KEY_NUMERIC":
			forChannel();
			break;
		case "KEY_BACK":
			keyBack();
			break;
		}
	} else if (($("flag").value) == 9) { // 响应返回按键
		hiddenAllDIV();
		switch (obj.code) {
			case "KEY_DOWN":
				$("btn_return").style.background = "url(images/tvod/over0.png)";
				$("btn_continue").style.background = "url(images/tvod/continue1.png)";
				break;
			case "KEY_UP":
				$("btn_return").style.background = "url(images/tvod/over1.png)";
				$("btn_continue").style.background = "url(images/tvod/continue0.png)";
				break;
			case "KEY_SELECT":
				if($("btn_return").style.background == "url(images/tvod/over1.png)") {
					//exit
					if (backUrl.indexOf("HD_backToVis.jsp")>-1)
						window.location = backUrl;
					else
						window.location = iPanel.eventFrame.tvodBackUrl;
				} else {
					//continue
					$("btn_exit").style.opacity	= "0";
					$("flag").value	=	0;
					mp.resume();
				}
				break;
		}
	}

	if (continueFlag) {
		continueFlag = false;
		setTimeout("continueFlag = true;", 200);
	}
}