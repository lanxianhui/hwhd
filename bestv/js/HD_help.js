var openWindowFlag = false;
var backgroundFlag = false;
var flagPosition = 0;
var tvod_back_flag = false;

var total = null;
var totalPage = null;
var nowPage = null;
var subPos = 0;
var shown = 0;

var tObj = [];
var iconup = null;
var icondown = null;
var page = null;
var channelNum = 8;
var main = null;
var backObj = null;
var displaydouration = "200";
var backTop = [ 105, 168, 234, 299, 365, 431, 497, 563 ];
var help = null;
var initFlag = false;

// 播放trailer
function playTrail() {
	mp.setVideoDisplayMode(0);
	mp.setVideoDisplayArea(642, 46, 596, 471);
	mp.refreshVideoDisplay();
	mp.setSingleMedia(list[shown + subPos].url);
	mp.playFromStart();
}

// 退出
function exit() {
	mp.stop();
	mp.releaseMediaPlayer(NativePlayerInstanceID);
}

// -----------------------------------------
// 频道JS---------------------------------------------------------

function doSelect() {
	if ($("flag").value == 1 || $("flag").value == 3) {
		document.location = "HD_saveCurrFocus.jsp?currFocus=" + nowPage + ","
				+ subPos + "&url=HD_helpplay.jsp?current=" + (shown + subPos);
	} else {
		document.location = "HD_saveCurrFocus.jsp?currFocus=" + nowPage + ","
				+ subPos + "&url=HD_upgradeNotice.jsp";
	}
}
// 频道光标上下移动
function changeListFocusUD(num) {
	channelPageFlag = false;
	var temp = Math.min(channelNum, limit);
	if (subPos == 0) {
		if (num == -1) {
			turnPage(num, true);
		} else {
			subPos += num;
			if (tObj[subPos].innerText.length == 1) {
				turnPage(num, true);
			} else {
				selectItem();
			}
		}
	} else if (subPos == (temp - 1)) {
		if (num == 1) {
			turnPage(num, true);
		} else {
			subPos += num;
			if (tObj[subPos].innerText.length == 1) {
				turnPage(num, true);
			} else {
				selectItem();
			}
		}
	} else {
		subPos += num;
		if (tObj[subPos].innerText.length == 1) {
			turnPage(num, true);
		} else {
			selectItem();
		}
	}
}

// 频道列表翻页
function turnPage(num, source) {

	channelPageFlag = true;
	nowPage += num;
	if (nowPage > totalPage) {
		nowPage = 1;
	}
	if (nowPage < 1) {
		nowPage = totalPage;
	}

	page.innerText = "" + nowPage + "/" + totalPage + "页";
	shown = (nowPage - 1) * channelNum;
	var rest = total - shown;
	limit = Math.min(channelNum, rest);

	if (source) {
		if (num >= 0) {
			subPos = 0;
		} else {
			subPos = Math.min(channelNum, limit) - 1;
		}
	} else {
		subPos = 0;
	}
	if (limit == channelNum) {
		for ( var i = 0; i < channelNum; i++) {
			tObj[i].innerText = list[i].name.slice(0, 20);
		}
	} else {
		for ( var i = 0; i < limit; i++) {
			tObj[i].innerText = list[i].name.slice(0, 20);
		}
		for ( var i = limit; i < channelNum; i++) {
			tObj[i].innerText = "";
		}
	}
	selectItem(subPos);
}

// 更换频道字体
function changeFontColor() {
	tObj[subPos].style.color = "#434343";
	tObj[subPos].style.fontSize = "30px";
	tObj[subPos].style.fontWeight = "bold";
}

// 响应右方向键
function keyRight() {
	backObj.style.backgroundImage = "url(images/help/back_no_focus.png)";
	$("introduce").style.backgroundImage = "url(images/help/introduce_focus.png)";
	$("flag").value = 2;
}

// 响应左方向键
function keyLeft() {
	backObj.style.backgroundImage = "url(images/help/back_focus.png)";
	$("introduce").style.backgroundImage = "url(images/help/introduce_no_focus.png)";
	$("flag").value = 1;
}

var list = [];
function getListData(__xmlhttp) {
	var temp = eval(__xmlhttp.responseText);
	list = temp[0].sub;

	total = list.length;
	totalPage = 1 + Math.floor((total - 1) / channelNum);

	if (myArray.length > 0) {
		nowPage = parseInt(myArray[0]);
		subPos = parseInt(myArray[1]);
		shown = (nowPage - 1) * channelNum;
		var rest = total - shown;
		limit = Math.min(channelNum, rest);
	} else {
		nowPage = 1;
		shown = (nowPage - 1) * channelNum;
		subPos = 0;
		limit = total;
	}

	for ( var i = 0; i < Math.min(channelNum, total); i++) {
		tObj[i].innerText = list[i].name.slice(0, 20);
	}
	if (temp[0].info.length > 70)
		$("tips").innerText = temp[0].info.slice(0, 70) + "...";
	else
		$("tips").innerText = temp[0].info;

	$("introduce_string").innerText = temp[0].title.slice(0, 25);
	page.innerText = "" + nowPage + "/" + totalPage + "页";

	selectItem();
	setTimeout(function() {
		$("back").style.visibility = "visible";
	}, 200);
}

// 发起AJAX请求，获取频道信息
function reqDataList(InnerChannelID) {
	var requestUrl = "HD_helpDate.jsp";
	var ajaxObj = new AJAX_OBJ(requestUrl, getListData);
	ajaxObj.requestData();
}

// 选中频道
function selectItem() {
	setTimeout("playTrail(subPos)", "500");
	page.innerText = "" + nowPage + "/" + totalPage + "页";
	for ( var i = 0; i < Math.min(channelNum, total); i++) {
		if (i == subPos) {

			if (initFlag) {
				initFlag = false;
				backObj.style.webkitTransitionDuration = "0";
			} else {
				backObj.style.webkitTransitionDuration = "200";
			}

			backObj.style.top = backTop[subPos] + "px";
			setTimeout("changeFontColor()", "200");
		} else {
			tObj[i].style.fontWeight = "normal";
			tObj[i].style.fontSize = "28px";
			tObj[i].style.color = "#FFFFFF";
		}
	}
}

// 首次加载时，运行此函数
function init() {

	iconup = $("iconup");
	icondown = $("icondown");
	page = $("page");
	main = $("main");
	backObj = $("back");
	logo = $("logo");
	title = $("title");
	initFlag = true;

	reqDataList();
	for ( var i = 0; i < channelNum; i++) {
		tObj[i] = $("t" + i);
	}

	$("back").style.visibility = "hidden";

}
var continueFlag = true;
function eventHandler(obj) {
	if (($("flag").value) == 1) {
		switch (obj.code) {
		case "KEY_UP":
			if (continueFlag)
				changeListFocusUD(-1);
			break;
		case "KEY_DOWN":
			if (continueFlag)
				changeListFocusUD(1);
			break;
		case "KEY_SELECT":
			doSelect();
			break;
		case "KEY_RIGHT":
			keyRight();
			break;
		case "KEY_PAGE_UP":
			turnPage(-1);
			break;
		case "KEY_PAGE_DOWN":
			turnPage(1);
			break;
		case "KEY_EXIT":
			exit();
			window.location = backUrl;
			return 0;
			break;
		case "KEY_BACK":
			exit();
			window.location = backUrl;
			break;
		}
	} else if (($("flag").value) == 2) {
		switch (obj.code) {
		case "KEY_SELECT":
			doSelect();
			break;
		case "KEY_LEFT":
			keyLeft();
			break;
		case "KEY_UP":
			$("trailerFocus").style.visibility = "visible";
			$("introduce").style.backgroundImage = "url(images/help/introduce_no_focus.png)";
			$("flag").value = 3;
			break;
		case "KEY_EXIT":
			exit();
			window.location = backUrl;
			return 0;
			break;
		case "KEY_BACK":
			exit();
			window.location = backUrl;
			break;
		}
	} else if (($("flag").value) == 3) {
		switch (obj.code) {
		case "KEY_SELECT":
			doSelect();
			break;
		case "KEY_LEFT":
			keyLeft();
			break;
		case "KEY_DOWN":
			$("trailerFocus").style.visibility = "hidden";
			$("introduce").style.backgroundImage = "url(images/help/introduce_focus.png)";
			$("flag").value = 2;
			break;
		case "KEY_EXIT":
			exit();
			window.location = backUrl;
			return 0;
			break;
		case "KEY_BACK":
			exit();
			window.location = backUrl;
			break;
		}
	}
	if (continueFlag) {
		continueFlag = false;
		setTimeout("continueFlag = true;", 200);
	}
}
