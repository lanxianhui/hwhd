﻿/**
 * myApp： 封装首页所有全局变量;
 */
var myApp = {
		playByThis	:	null,     				//  背景流信息  
		playType	:	null,     				//  背景流类型 
		levelOne	:	[],						//	封装一级导航栏信息
		levelTwo	:	[],						//	封装二级导航栏信息
		recommend	:	[],						//	封装推荐位信息
		areaFlag	:	null,					//	焦点框位置标识符; 0:一级菜单; 1:二级菜单; 2:推荐位;
		col0_P		:	null,					//	一级菜单位置标识符
		col1_P		:	null,					//	二级菜单位置标识符
		rec_P		:	null,					//	推荐位标位置识符
		fitLength	:	null,					//	首页二级菜单背景宽度
		col1_start	:	0,						//	二级菜单其开始位置
		col1_info	:	[],						//	封装二级菜单分类
		col1_size	:	0,						//	二级菜单分类总长度
		col1_end	:	0,						//	二级菜单结束位置,最大不超过10
		startP		:	0,						//	二级菜单光标停留位置
		isAppeare	:	true,					//	推荐位消失标识符; true 为显示; false为消失
		isDelay		:	false,					//	?
		dispearTime	:	10000,					//	时间配置参数
		keyTime		:	300,					//	连续两次按键时长
		backUrl		:	null,					//	上一个URL
};

/**
 * 功能：在一定时间内用户为执行任意操作，隐藏除一级导航栏的类目
 * @return
 */
function disappeare() {
	myApp.isAppeare = false;		
	if (myApp.areaFlag == 2) {
		$("rec").style.left += 900;
		$("recfocus").style.webkitTransitionDuration = "600ms";
		$("recfocus").style.opacity = 0;
	} else {
		disappeareBar();
		disappeareHalfRec();
	}
}

/**
 * 功能：隐藏一级导航栏
 * @return
 */
function disappeareBar() {
	$("col1").style.overflow = "visible";
	$("col1").style.left = $("col1").style.left - 600;
	$("col1focus").style.left = $("col1focus").style.left - 600;
	$("part1").style.webkitTransitionDuration = "600ms";
	$("part1").style.left = 0;
	$("part1").style.opacity = 0;
	$("part2").style.webkitTransitionDuration = "600ms";
	$("part2").style.left = 113;
	$("part2").style.opacity = 0;
	$("part3").style.webkitTransitionDuration = "600ms";
	$("part3").style.left = $("part3").style.left;
	$("part3").style.opacity = 0;
	$("col1focus").style.webkitTransitionDuration = "600ms";
	$("col1focus").style.left = 5;
	for ( var i = 0; i < 12; i++) {
		$("col1" + i).style.webkitTransitionDuration = "600ms";
		$("col1" + i).style.left = 0;
		$("col1" + i).style.opacity = 0;
	}
	$("up").style.left = $("up").style.left;
	$("down").style.left = $("down").style.left;
}

/**
 * 功能：定位推荐位显示位置
 * @return
 */
function disappeareHalfRec() {
	$("rec").style.left += (myApp.areaFlag == 2) ? (myArray.length > 1 ? 0 : 600) :  (myApp.isAppeare ? 600 : 1200);
	setTimeout(function () {
		if ($("rec").style.left < 450)
		$("rec").style.left += 600;
	}, 10);
	$("recfocus").style.webkitTransitionDuration = "0ms";
	$("recfocus").style.opacity = 0;
}

/**
 * 功能：显示推荐位、二级导航栏
 * @return
 */
function appeare() {
	myApp.isAppeare = true;
	if (myApp.areaFlag == 2) {
		$("rec").style.left -=  ($("rec").style.left > 1500) ? 1200 : 900;
		if ($("rec").style.left < 300)  $("rec").style.left += 300;
		$("recfocus").style.webkitTransitionDuration = "1ms";
		$("recfocus").style.opacity = 1;
	} else {
		appeareBar();
		appeareHalfRec();
	}
}

/**
 * 功能：显示二级导航栏
 * @return
 */
function appeareBar() {
	if ($("col1").style.left < 200)
		$("col1").style.left = $("col1").style.left + 600; // bug修复，现象（当光标停留在推荐栏目，消失，左移时，二级栏目背景错位
	$("part1").style.left = 0;
	$("part2").style.left = 113;
	
	if (myApp.col0_P == 7) {
		$("part1").style.opacity = 0;
		$("part2").style.opacity = 0;
		$("part3").style.opacity = 0;
	} else {
		$("part1").style.opacity = 0.9;
		$("part2").style.opacity = 0.9;
		$("part3").style.opacity = 0.9;
	}
	$("col1focus").style.webkitTransitionDuration = "600ms";
	$("col1focus").style.left = 5;
	for ( var i = 0; i < 12; i++) {
		$("col1" + i).style.left 	= 0;
		$("col1" + i).style.opacity = 1;
	}
	$("up").style.left 		= $("up").style.left;
	$("down").style.left 	= $("down").style.left;
}

/**
 * 功能：显示推荐位
 * @return
 */
function appeareHalfRec() {
	$("rec").style.left -= ($("rec").style.left > 1500) ? 1200 : ($("rec").style.left > 1000 ? 600 : 300);
	if ($("rec").style.left < 300) $("rec").style.left += 300;
}



/**
 * 功能：离开一级菜单,设置一级菜单背景
 * @return
 */
function leaveArea0() {
	if (myApp.col0_P == 7) $("recname").style.color = "#393939";
	$("col0focus").style.background = (myApp.col0_P == 1) ? "url(images/portal/levelOne_choose1.png)" : ((myApp.col0_P == 7) ? "" : "url(images/portal/levelOne_choose.png)");
}

/**
 * 功能：光标定位至一级菜单
 * @return
 */
function toArea0() {
	myApp.areaFlag = 0;
	$("recfocus").style.webkitTransitionDuration = "0ms";
	$("recfocus").style.opacity = 0;
	
	if (myApp.col0_P == 7) {
		$("part1").style.opacity = 0;
		$("part2").style.opacity = 0;
		$("part3").style.opacity = 0;
		$("recname").style.color = "#FFFFFF";
	}
	$("col0focus").style.background = "url(images/portal/" + ((myApp.col0_P == 1) ? "levelOne_focus1" : ((myApp.col0_P == 7) ? "recbutton_focus" : "levelOne_focus")) + ".png)";
}

/**
 * 功能：离开二级菜单,设置二级菜单背景
 * @return
 */
function leaveArea1() {
	$("col1focus").style.opacity = 0;
	$("col1" + (myApp.startP + myApp.col1_P) % 12).style.color = "#B3B3B3";
}

/**
 * 功能：光标定位至二级菜单
 * @return
 */
function toArea1() {
	myApp.areaFlag = 1;
	$("recfocus").style.webkitTransitionDuration = "0ms";
	$("recfocus").style.opacity = 0;
	if (myApp.areaFlag == 0) {
		$("col1focus").style.webkitTransitionDuration = "0ms";
	}
	if (myApp.areaFlag == 2) {
		$("col1focus").style.webkitTransitionDuration = "600ms";
	}
	$("col1focus").style.opacity = 1;
	$("col1focus").style.top = 34 + 60 * myApp.col1_P;
	$("col1" + (myApp.startP + myApp.col1_P) % 12).style.color = "#FFFFFF";
}

/**
 * 功能：离开推荐区域
 * @return
 */
function leaveArea2() {
	appeareBar();
	disappeareHalfRec();
}

/**
 * 功能：光标定位至推荐区域
 * @return
 */
function toArea2() {
	myApp.areaFlag = 2;
	if (myApp.rec_P == -1) {
		myApp.rec_P = 0;
	}
	focusPosition(myApp.rec_P);
	appeareHalfRec();
	disappeareBar();
	setTimeout("$('recfocus').style.opacity = 1;", 800);
	setTimeout("$('col1').style.overflow='hidden';", 10);
}

/**
 * 功能：选择焦点框
 * @return
 */
function doSelect() {
	var toUrl = "";
	switch(myApp.areaFlag) {
		case 0 : 
				if( myApp.col0_P == 7 ) {
					leaveArea0();
					setTimeout("toArea2()", "200ms");
				} else {
					toUrl = myApp.levelOne[myApp.col0_P].TURNURL;
					if (toUrl == "")  return;
					$("col0focus").style.webkitTransitionDuration = "250ms";
					$("col0focus").style.webkitTransform = "scale(1)";
					$("col0focus").style.opacity = 0;
				}
			break;
		case 1 :
				toUrl = myApp.col1_info[myApp.col1_start + myApp.col1_P].TURNURL;
				if (toUrl == "setting") {
					Utility.startLocalCfg();
					return;
				}
				if (toUrl == "")  return;
				if ((myApp.col1_start + myApp.col1_P) == 2 && myApp.col0_P == 5) {
					if (iPanel.eventFrame.hasUSB == false || typeof (iPanel.eventFrame.hasUSB) == "undefined") {
						// $("content").innerText ="未检测到移动设备";
						iPanel.overlayFrame.location = "usbPromit.html?0";
						iPanel.overlayFrame.moveTo(350, 304);
						iPanel.overlayFrame.resizeTo(576, 241);
						return;
					}
					if (iPanel.eventFrame.USBIsReady == false || typeof (iPanel.eventFrame.USBIsReady) == "undefined") {
						if (iPanel.eventFrame.hasUSB == true) {
							iPanel.overlayFrame.location = "usbPromit.html?3";
							iPanel.overlayFrame.moveTo(350, 304);
							iPanel.overlayFrame.resizeTo(576, 241);
						}
						return;
					}
				}
				$("col1focus").style.webkitTransitionDuration = "250ms";
				$("col1focus").style.webkitTransform = "scale(1)";
				$("col1focus").style.opacity = 0;
			break;
		case 2 :
			toUrl = myApp.recommend[myApp.rec_P].TURNURL;
			if (toUrl == "") return;
			$("recfocus").style.webkitTransitionDuration = "250ms";
			$("recfocus").style.webkitTransform = "scale(1)";
			$("recfocus").style.opacity = 0;
		break;
	}
	
	if (myApp.levelTwo[4] == null && toUrl == "HD_KanBar.jsp") {
		toUrl = "HD_infoDisplay.jsp?ERROR_ID=137";
	} else {
		if (toUrl.indexOf("hwConfigAdapter.jsp")> -1 || toUrl.indexOf("HD_DXDispatch.jsp") > -1) {
			toUrl = "HD_URLDispatch.jsp?dispatch=" + toUrl;
		}
	}
	
	if (toUrl.indexOf("vasroot") > -1) {
		if (typeof (iPanel.eventFrame.vasHistory) === "undefined" )
			iPanel.eventFrame.eval("var vasHistory = ''");
		iPanel.eventFrame.vasHistory = myApp.areaFlag + "," + myApp.col0_P + "," + myApp.col1_P + "," + myApp.rec_P;
	}
	
	//	记忆焦点,并执行跳转功能
	document.location = "HD_saveCurrFocus.jsp?currFocus=" + myApp.areaFlag + "," + myApp.col0_P + "," + myApp.col1_P + "," + myApp.rec_P + "&url=" + toUrl;
}

/**
 * 功能：响应一级菜单光标上下移动
 * @param from   起始位置
 * @param to	 目标位置
 * @return
 */
function levelOne_move(from, to) {
	if (from == 7) {
		$("recname").style.color = "#393939";
		setTimeout(function() {
			$("col0" + to).style.color = '#FFFFFF';
		}, 150);
	} else if (to == 7) {
		$("col0" + from).style.color = "#393939";
		setTimeout(function() {
			$("recname").style.color = '#FFFFFF';
		}, 150);
		$("img0" + from).style.background = "url(images/portal/i0" + from + ".png)";
	} else {
		$("col0" + from).style.color = "#393939";
		setTimeout(function() {
			$("col0" + to).style.color = '#FFFFFF';
		}, 300);
		$("img0" + from).style.background = "url(images/portal/i0" + from + ".png)";
	}
	myApp.isDelay = true;
	initLevelOne(to, 0);
}

/**
 * 功能：变更一级菜单焦点框位置
 */
var keyFlag0 = true;
function changeCol0Focus(num) {
	if (keyFlag0) {
		keyFlag0 = false;
		setTimeout("keyFlag0 = true;", myApp.keyTime);
		if (num > 0) {
			myApp.col0_P--;
			if (myApp.col0_P < 0) {
				myApp.col0_P = 7;
				levelOne_move(0, myApp.col0_P);
				return;
			}
		}
		if (num < 0) {
			if (myApp.col0_P == 7) {
				myApp.col0_P = 0;
				levelOne_move(7, myApp.col0_P);
				return;
			}
			myApp.col0_P++;
		}
		levelOne_move(myApp.col0_P + num, myApp.col0_P);
	}
}

/**
 * 功能：当光标移动至一级菜单时,改变菜单位置
 * @param num
 * @return
 */
function changeCol1Show(num) {
	for ( var i = 0; i < 12; i++)
		$("col1" + i).style.webkitTransitionDuration = "200ms";

	if (num > 0) {
		myApp.startP = (myApp.startP - 1 + 12) % 12;
		myApp.col1_start--;
		myApp.col1_end--;
		$("col1" + (myApp.startP + 1) % 12).style.color = "#B3B3B3";
		$("col1" + myApp.startP).style.color = "#FFFFFF";
		$("col1" + myApp.startP).innerText = myApp.col1_info[myApp.col1_start].NAME;
		$("col1" + (myApp.startP - 1 + 12) % 12).innerText = "";
		for ( var i = 0; i < 11; i++) {
			$("col1" + (myApp.startP + i) % 12).style.top = $("col1" + (myApp.startP + i + 1) % 12).style.top;
		}
		$("col1" + (myApp.startP - 1) % 12).style.top = -100;
	}
	
	if (num < 0) {
		myApp.startP = (myApp.startP + 1) % 12;
		myApp.col1_start++;
		myApp.col1_end++;
		$("col1" + (myApp.startP + 8) % 12).style.color = "#B3B3B3";
		$("col1" + (myApp.startP + 9) % 12).style.color = "#FFFFFF";
		$("col1" + (myApp.startP + 9) % 12).innerText = myApp.col1_info[myApp.col1_end - 1].NAME;
		$("col1" + (myApp.startP - 1 + 12) % 12).innerText = "";
		for ( var i = 0; i < 11; i++) {
			$("col1" + (myApp.startP + 9 - i + 12) % 12).style.top = $("col1"
					+ (myApp.startP + 9 - i - 1 + 12) % 12).style.top;
		}
		$("col1" + (myApp.startP - 1 + 12) % 12).style.top = 685;
	}
}

/**
 * 功能：处理二级菜单上下移动按键
 * @param from
 * @param to
 * @return
 */
function levelTwo_move(from, to) {
	$("col1" + (myApp.startP + from) % 12).style.color = "#B3B3B3";
	setTimeout(function() {
		$("col1" + (myApp.startP + to) % 12).style.color = '#FFFFFF';
	}, 250);
	$("col1focus").style.webkitTransitionDuration = "200ms";
	$("col1focus").style.top = 34 + 60 * to;
	$("f").style.width = 190 - 30 * Math.min((5 - myApp.fitLength), 3) + 30;
	$("f").style.height = 78;
}

var keyFlag1 = true;	//	按键保护

/**
 * 功能：响应二级菜单上下移动按键
 * @param num	1 下移； 0 上移
 * @return
 */
function changeCol1Focus(num) {
	if (keyFlag1) {
		keyFlag1 = false;
		setTimeout("keyFlag1 = true;", myApp.keyTime);
		if (num > 0) {
			myApp.col1_P--;
			if (myApp.col1_P < 0) {
				myApp.col1_P = 0;
				if (myApp.col1_start != 0) {
					changeCol1Show(1);
				}
				upDownControl();
				return;
			}
		}
		if (num < 0) {
			myApp.col1_P++;
			if (myApp.col1_P > Math.min(9, (myApp.col1_size - 1))) {
				myApp.col1_P = Math.min(9, (myApp.col1_size - 1));
				if (myApp.col1_end < myApp.col1_size) {
					changeCol1Show(-1);
				}
				upDownControl();
				return;
			}
		}
		levelTwo_move(myApp.col1_P + num, myApp.col1_P);
	}
	upDownControl();
}

/**
 * 功能：离开推荐位，推荐位失去焦点
 * @param num
 * @return
 */
function leavePosition(num) {
	switch (num) {
		case 0:
		case 1:
			$("bp" + num).src = "images/portal/rec.png";
			$("bp" + num).style.width = 160;
			$("bp" + num).style.height = 134;
			$("bp" + num).style.left = 0;
			$("bp" + num).style.top = 0;
			$("img" + num).style.width = 140;
			$("img" + num).style.height = 116;
			break;
		case 2:
		case 3:
		case 4:
			$("text" + (num - 2)).style.fontSize = 24;
			break;
		case 5:
		case 6:
		case 7:
			$("bigP" + (num - 5)).style.width = 330;
			$("bigP" + (num - 5)).style.height = 150;
			$("middle" + (num - 5)).style.left = 255;
			break;
		case 8:
		case 9:
		case 10:
		case 11:
		case 12:
		case 13:
		case 14:
		case 15:
		case 16:
		case 17:
			$("right" + (num - 8)).style.color = "#8d8d8d";
			break;
		case 18:
		case 19:
		case 20:
		case 21:
		case 22:
		case 23:
		case 24:
		default :
			break;
	}
}

/**
 * 功能函数：处理推荐位焦点框移动
 * @param from
 * @param to
 * @return
 */
function rec_move(from, to) {
	$("recfocus").style.webkitTransitionDuration = "200ms";
	leavePosition(from);
	focusPosition(to);
}

/**
 * 功能：响应推荐位焦点框上下移动
 * @param num
 * @return
 */
function changeRecFocusUD(num) {
	if (num > 0) {
		switch (myApp.rec_P) {
			case 1:
			case 2:
			case 3:
			case 4:
			case 6:
			case 7:
			case 9:
			case 10:
			case 11:
			case 12:
			case 13:
			case 14:
			case 15:
			case 16:
			case 17:
				rec_move(myApp.rec_P, --myApp.rec_P);
				break;
			case 18:
			case 19:
				rec_move(myApp.rec_P, 4);
				myApp.rec_P = 4;
				break;
			case 20:
			case 21:
			case 22:
				rec_move(myApp.rec_P, 7);
				myApp.rec_P = 7;
				break;
			case 23:
			case 24:
				rec_move(myApp.rec_P, 17);
				myApp.rec_P = 17;
			break;
		}
	}
	if (num < 0) {
		switch (myApp.rec_P) {
			case 0:
			case 1:
			case 2:
			case 3:
				rec_move(myApp.rec_P, ++myApp.rec_P);
				break;
			case 4:
				rec_move(myApp.rec_P, 18);
				myApp.rec_P = 18;
				break;
			case 5:
			case 6:
				rec_move(myApp.rec_P, ++myApp.rec_P);
				break;
			case 7:
				rec_move(myApp.rec_P, 20);
				myApp.rec_P = 20;
				break;
			case 8:
			case 9:
			case 10:
			case 11:
			case 12:
			case 13:
			case 14:
			case 15:
			case 16:
				rec_move(myApp.rec_P, ++myApp.rec_P);
				break;
			case 17:
				rec_move(myApp.rec_P, 23);
				myApp.rec_P = 23;
			break;
		}
	}
}

/**
 * 功能：响应推荐位左右移动
 * @param num
 * @return
 */
function changeRecFocusLR(num) {
	if (num > 0) {
		switch (myApp.rec_P) {
			case 0:
				rec_move(myApp.rec_P, 5);
				myApp.rec_P = 5;
				break;
			case 1:
				rec_move(myApp.rec_P, 6);
				myApp.rec_P = 6;
				break;
			case 2:
			case 3:
			case 4:
				rec_move(myApp.rec_P, 7);
				myApp.rec_P = 7;
				break;
			case 5:
				rec_move(myApp.rec_P, 8);
				myApp.rec_P = 8;
				break;
			case 6:
				rec_move(myApp.rec_P, 11);
				myApp.rec_P = 11;
				break;
			case 7:
				rec_move(myApp.rec_P, 15);
				myApp.rec_P = 15;
				break;
			case 18:
			case 19:
			case 20:
			case 21:
			case 22:
			case 23:
				rec_move(myApp.rec_P, ++myApp.rec_P);
			break;
		}
	}
	if (num < 0) {
		switch (myApp.rec_P) {
			case 0:
			case 1:
			case 2:
			case 3:
			case 4:
			case 18:
				leaveArea2();
				(myApp.col0_P == 7) ? toArea0() : toArea1();
			case 5:
				rec_move(myApp.rec_P, 0);
				myApp.rec_P = 0;
				break;
			case 6:
				rec_move(myApp.rec_P, 1);
				myApp.rec_P = 1;
				break;
			case 7:
				rec_move(myApp.rec_P, 2);
				myApp.rec_P = 2;
				break;
			case 8:
			case 9:
			case 10:
				rec_move(myApp.rec_P, 5);
				myApp.rec_P = 5;
				break;
			case 11:
			case 12:
			case 13:
			case 14:
				rec_move(myApp.rec_P, 6);
				myApp.rec_P = 6;
				break;
			case 15:
			case 16:
			case 17:
				rec_move(myApp.rec_P, 7);
				myApp.rec_P = 7;
				break;
			case 19:
			case 20:
			case 21:
			case 22:
			case 23:
			case 24:
				rec_move(myApp.rec_P, --myApp.rec_P);
			break;
		}
	}
}

/**
 * 播放频道信息
 * @param num ： 频道号码
 * @return
 */
function playChannel(num) {
	mp.setVideoDisplayMode(1);
	mp.refreshVideoDisplay();
	mp.setSingleOrPlaylistMode(0);
	mp.joinChannel(num);
}

/**
 * 循环播放VOD
 * @param rtsp ： 媒体流信息
 * @return
 */
function playVod(rtsp) {
	mp.setVideoDisplayMode(0);
	mp.setAllowTrickmodeFlag(0);
	mp.setSingleMedia(rtsp);
	mp.setCycleFlag(1);
	mp.setRandomFlag(1);
	mp.playFromStart();
	clearTimeout(playTimer);
	setTimeout (function () {
		playTimer = setTimeout("playVod(rtsp)",(mp.getMediaDuration() - 5)*1000);
	}, 5000);
}

/**
 * 初始化并封装首页数据变量
 * 
 * @param __xmlhttp
 * @return
 */
function getListData(__xmlhttp) {
	var data = eval(__xmlhttp.responseText);
//	data[1][4] = [
//				   {"TURNURL":"HD_URLDispatch.jsp?dispatch=HD_encapsulaUrl.jsp?url=http://61.8.168.194/vasroot/apps/APP_HQ_MTP/",
//					   "NAME":"三屏社区",
//					   "ITEMICON":"images/kanba/logo/yule.png"},
//			   	     {"TURNURL":"HD_encapsulaUrl.jsp?url=http://125.88.96.19/vasroot/frame/php4bestv/portal/biz_hq_10011633/1",
//		        	    	"NAME":"娱乐看吧",
//			        	    "ITEMICON":"images/kanba/logo/yule.png"},
//	        	     {"TURNURL":"HD_encapsulaUrl.jsp?url=http://125.88.96.19/vasroot/frame/php4bestv/portal/biz_hq_10031626/1",
//	        	    		"NAME":"新闻中心",
//	        	    		"ITEMICON":"images/kanba/logo/xinwenzhongxin.png"},
//	   	        	 {"TURNURL":"HD_encapsulaUrl.jsp?url=http://125.88.96.19/vasroot/frame/php4bestv/portal/biz_hq_10061805/1",
//	        	    		"NAME":"超级体育",
//		        	    	"ITEMICON":"images/kanba/logo/chaojitiyu.png"},	        	    		
//	                 {"TURNURL":"HD_encapsulaUrl.jsp?url=http://125.88.96.19/vasroot/frame/php4bestv/portal/biz_hq_10026383/1",
//        	    		 "NAME":"财经看吧",
//        	    		 "ITEMICON":"images/kanba/logo/caijing.jpg"},	   
//			   	     {"TURNURL":"HD_encapsulaUrl.jsp?url=http://125.88.96.19/vasroot/frame/php4bestv/portal/biz_hq_10001262/1",
//			        	    "NAME":"法制看吧",
//			        	    "ITEMICON":"images/kanba/logo/fazhi.png"},				        	    	
//	        	     {"TURNURL":"HD_encapsulaUrl.jsp?url=http://125.88.96.19/vasroot/frame/php4bestv/portal/biz_hq_10008070/1",
//			        	    "NAME":"纪实看吧",
//        	    			"ITEMICON":"images/kanba/logo/jishi.png"},  	    	
//   	        	     {"TURNURL":"HD_encapsulaUrl.jsp?url=http://125.88.96.19/vasroot/frame/php4bestv/portal/biz_hq_10008070/1",
//			        	    "NAME":"风尚看吧",
//        	    			"ITEMICON":"images/kanba/logo/fengshang.png"},  
//	        	     {"TURNURL":"HD_encapsulaUrl.jsp?url=http://125.88.96.19/vasroot/frame/php4bestv/portal/biz_GD_10000347/1",
//	        	    		"NAME":"粤精彩",
//	        	    		"ITEMICON":"images/kanba/logo/yuejingcai.jpg"},
//  	        	     {"TURNURL":"HD_encapsulaUrl.jsp?url=http://125.88.96.19/vasroot/frame/php4bestv/portal/biz_hq_10047367/1",
//	        	    		"NAME":"哈哈乐园",
//	        	    		"ITEMICON":"images/kanba/logo/default.png"},         	    			
// 	        	     {"TURNURL":"HD_encapsulaUrl.jsp?url=http://125.88.96.19/vasroot/apps/APP_HQ_USERCLUB0322/",
//	        	    		"NAME":"世博寻宝",
//	        	    		"ITEMICON":"images/kanba/logo/default.png"},
//	        	     {"TURNURL":"HD_encapsulaUrl.jsp?url=http://125.88.96.19/vasroot/frame/php4bestv/portal/biz_hq_10074628/1",
//	        	    		"NAME":"看天下",
//	        	    		"ITEMICON":"images/kanba/logo/default.png"}
//	        	    		
//	        	    ];
	
	myApp.levelOne 	= data[0];
	myApp.levelTwo 	= data[1];
	myApp.recommend = data[2];
	
	// 静音按钮初始化
	if (mp.getMuteFlag() == 1) {
		if ($("muteDiv") == null || typeof ($("muteDiv")) == "undefined") {
			creatMuteDiv();
		}
		$("muteDiv").style.webkitTransitionDuration = "0ms";
		$("muteDiv").style.visibility = "visible";
		$("muteDiv").style.backgroundImage = "url(images/vod/mute0.png)";
		$("muteDiv").style.width = "65px";
		$("muteDiv").style.height = "65px";
		$("muteDiv").style.left = "880px";
		$("muteDiv").style.webkitTransitionDuration = "300ms";
	}

	iPanel.overlayFrame.close();
	
	for ( var i = 0; i < 12; i++)
		$("col1" + i).style.height = "60px";
	
	// 获取并初始化首页焦点参数
	if (myApp.backUrl.indexOf("HD_vasToMemA2") > -1) {
		var params = iPanel.eventFrame.vasHistory.split(",");
		for ( var i = 0; i < params.length; i++)
			myArray[i] = params[i];
	} else {
		var params = window.location.search.substring(1).split("&");
		for ( var i = 0; i < params.length; i++)
			myArray[i] = params[i].split("=")[1];
	}
		
	if (myArray[0] == null) {			//  无焦点记忆
		myApp.areaFlag 	= 0;			//	一级区域标识符
		myApp.col0_P 	= 7;			//	光标定位在推荐按钮上
		myApp.col1_P 	= 0;			
		myApp.rec_P 	= -1;
	} else {							//	有焦点记忆
		myApp.areaFlag = parseInt(myArray[0]);
		myApp.col0_P = parseInt(myArray[1]);
		myApp.col1_P = parseInt(myArray[2]);
		myApp.rec_P = parseInt(myArray[3]);
	}
	
	myApp.fitLength = 0;
	initLevelOne(myApp.col0_P, myApp.col1_P);
	initRec(myApp.rec_P);
	if (myApp.areaFlag == 1) {
		$("col0focus").style.background = "url(images/portal/levelOne_choose.png)";
		toArea1();
	} else if (myApp.areaFlag == 2) {
		leaveArea0();
		setTimeout("toArea2()", "200ms");
	}
}

/**
 * 功能：初始化一级菜单、二级菜单,定位焦点框
 * @param num
 * @param num1
 * @return
 */
function initLevelOne(num, num1) {

	var temp = myApp.levelOne.length;
	for ( var i = 0; i < (temp + 1); i++) {
		if (i != 7) {
			$("col0" + i).innerText =  (typeof myApp.levelOne[i].NAME) == "undefined" ? "" : myApp.levelOne[i].NAME;
		}
		if (i == num) {
			if (num == 1) {
				$("img0" + myApp.col0_P).style.background = "url(images/portal/if0" + myApp.col0_P + ".png)";
				$("col0focus").style.background = "url(images/portal/levelOne_focus1.png)";
				$("col0focus").style.left = 5;
				$("col0focus").style.height = 115;
				$("col0focus").style.top = 150;
				$("col0focus").style.width = 223;
				$("recname").style.color = "#393939";
			} else if (num == 7) {
				$("recname").style.color = "#FFFFFF";
				$("col0focus").style.background = "url(images/portal/recbutton_focus.png)";
				$("col0focus").style.left = 50;
				$("col0focus").style.height = 69;
				$("col0focus").style.top = 0;
				$("col0focus").style.width = 133;
			} else {
				$("img0" + myApp.col0_P).style.background = "url(images/portal/if0" + myApp.col0_P + ".png)";
				$("col0focus").style.top = 70 + 80 * num + 35 * Math.min(1, num);
				$("col0focus").style.background = "url(images/portal/levelOne_focus.png)";
				$("col0focus").style.left = 5;
				$("col0focus").style.height = 80;
				$("col0focus").style.width = 223;
				$("recname").style.color = "#393939";
			}
			if (!myApp.isDelay) {
				$("col0" + i).style.color = "#FFFFFF";
				myApp.isDelay = false;
			}
		}
	}
	
	myApp.col1_P 		= num1;
	myApp.col1_start 	= 0;
	myApp.col1_info 	= myApp.levelTwo[num];
	myApp.col1_size 	= myApp.col1_info.length;
	myApp.col1_end		= Math.min(myApp.col1_size, 10);
	initLevelTwo(myApp.col1_P);
	upDownControl();
}

/**
 * 初始化二级导航栏上下移动按钮
 * @return
 */
function upDownControl() {
	$("down").style.left 	= 22 * Math.max(2, myApp.fitLength);
	$("up").style.left 		= $("down").style.left;
	$("down").style.opacity = ((myApp.col1_size - myApp.col1_start) > 10) ? 1 : 0;
	$("up").style.opacity 	= (myApp.col1_start > 0) ? 1 : 0;
}

/**
 * 功能：初始化二级菜单
 * @param num
 * @return
 */
function initLevelTwo(num) {
	if (myApp.col0_P == 7) {	//光标停留在推荐按钮上，无二级导航栏，
		$("part1").style.opacity = 0;
		$("part2").style.opacity = 0;
		$("part3").style.opacity = 0;
		for ( var i = 0; i < 12; i++) {
			$("col1" + i).innerText = "";
		}
		return;
	} else {
		$("part1").style.opacity = 0.9;
		$("part2").style.opacity = 0.9;
		$("part3").style.opacity = 0.9;
	}
	
	myApp.fitLength = 0;
	for ( var i = 0; i < 10; i++) {
		if ((myApp.col1_start + i) > (myApp.col1_size - 1)) {
			$("col1" + (myApp.startP + i) % 12).innerText = "";
			continue;
		}
		myApp.fitLength = Math.max(myApp.fitLength, myApp.col1_info[myApp.col1_start + i].NAME.length);
		if (typeof (myApp.col1_info[myApp.col1_start + i].NAME) == "string")
			$("col1" + (myApp.startP + i) % 12).innerText = myApp.col1_info[myApp.col1_start + i].NAME;
		else
			$("col1" + (myApp.startP + i) % 12).innerText = "";
	}

	// 初始化二级导航栏背景图、光标等信息
	var changeLength = Math.max(0, 30 * (myApp.fitLength - 2));
	$("part1").style.webkitTransitionDuration = "10ms";
	$("part2").style.webkitTransitionDuration = "10ms";
	$("part3").style.webkitTransitionDuration = "10ms";
	$("col1").style.width = 225 - 30 * Math.min((5 - myApp.fitLength), 3);
	$("f").style.width = 190 - 30 * Math.min((5 - myApp.fitLength), 3) + 30;
	$("f").style.height = 78;
	$("part2").style.width = Math.max(changeLength, 1);
	$("part3").style.left = 113 + changeLength;
}

/**
 * 初始化推荐位
 * @param num
 * @return
 */
function initRec(num) {
	
	//初始化今日看点推荐位图片
	$("img0").src	= myApp.recommend[0].IMGURL;
	$("bp0").src 	= "images/portal/rec.png";
	$("img1").src 	= myApp.recommend[1].IMGURL;
	$("bp1").src 	= "images/portal/rec.png";
	
	//初始化精彩推荐、今日看点推荐位
	for ( var i = 0; i < 3; i++) {
		$("text" + i).innerText = (typeof (myApp.recommend[2 + i].NAME) == "undefined") ? "" : myApp.recommend[2 + i].NAME;
		$("bigP" + i).src = (typeof (myApp.recommend[5 + i].NAME) == "undefined") ? "" : myApp.recommend[5 + i].IMGURL;
	}

	//初始化影视排行
	for ( var j = 0; j < 10; j++)
		$("right" + j).innerText = (typeof (myApp.recommend[8 + j].NAME) == "undefined") ? "" : myApp.recommend[8 + j].NAME;
	
	//初始化推荐位底端导航栏
	for ( var k = 0; k < 7; k++)
		$("buttom" + k).innerText = (typeof (myApp.recommend[18 + k].NAME) == "undefined") ? "" : myApp.recommend[18 + k].NAME;

	disappeareHalfRec();
	focusPosition(num);
}

/**
 * 功能：定位推荐位焦点位置
 * @param num
 * @return
 */
function focusPosition(num) {
	switch (num) {
		case 0:
		case 1:
			$("bp" + num).src = "images/portal/recFocus.png";
			$("bp" + num).style.width = 189;
			$("bp" + num).style.height = 163;
			$("bp" + num).style.left = -10;
			$("bp" + num).style.top = -10;
			$("img" + num).style.width = 146;
			$("img" + num).style.height = 121;
			$("recfocus").style.left = 45;
			$("recfocus").style.top = 65 + 165 * num;
			$("recfocus").style.width = 189;
			$("recfocus").style.height = 163;
			$("recfocus").style.background = "images/portal/recFocus1.png";
			break;
		case 2:
		case 3:
		case 4:
			$("text" + (num - 2)).style.fontSize = 26;
			$("recfocus").style.left = 33;
			$("recfocus").style.top = 385 + 55 * (num - 2);
			$("recfocus").style.width = 208;
			$("recfocus").style.height = 66;
			$("recfocus").style.background = "images/portal/recFocus2.png";
			$("recfocus").style.zIndex = -1;
			break;
		case 5:
		case 6:
		case 7:
			$("bigP" + (num - 5)).style.width = 342;
			$("bigP" + (num - 5)).style.height = 155;
			$("middle" + (num - 5)).style.left = 250;
			$("recfocus").style.left = 235;
			$("recfocus").style.top = 52 + 169 * (num - 5);
			$("recfocus").style.width = 370;
			$("recfocus").style.height = 184;
			$("recfocus").style.background = "images/portal/recFocus5.png";
			break;
		case 8:
		case 9:
		case 10:
		case 11:
		case 12:
		case 13:
		case 14:
		case 15:
		case 16:
		case 17:
			$("right" + (num - 8)).style.color = "#FFFFFF";
			$("recfocus").style.left = 600;
			$("recfocus").style.top = 71 + 48 * (num - 8);
			$("recfocus").style.width = 231;
			$("recfocus").style.height = 62;
			$("recfocus").style.background = "images/portal/recFocus6.png";
			break;
		case 18:
		case 19:
		case 20:
		case 21:
		case 22:
		case 23:
		case 24:
			$("recfocus").style.left = 10 + 115 * (num - 18);
			$("recfocus").style.top = 575;
			$("recfocus").style.width = 133;
			$("recfocus").style.height = 68;
			$("recfocus").style.background = "images/portal/recFocus7.png";
			break;
	}
}

var t = setTimeout("disappeare()", myApp.dispearTime);
var keyFlag = true;											//	按键保护标识符, 相邻按键时常不能超过{myApp.keyTime}	
function eventHandler(obj) {
		switch (obj.code) {
			case "KEY_UP":
				var upORdown = 1;
			case "KEY_DOWN":
				if(typeof upORdown == "undefined" )  var upORdown =	-1;
				(myApp.areaFlag == 0) ? changeCol0Focus(upORdown) : ((myApp.areaFlag == 1) ? changeCol1Focus(upORdown) : changeRecFocusUD(upORdown));
				doSomething();
			break;
			case "KEY_LEFT":
				if (keyFlag) {
					if (myApp.areaFlag == 1) {
						leaveArea1();
						toArea0();
					} else if (myApp.areaFlag == 2) {
						changeRecFocusLR(-1);
					}
					doSomething();
				}
			break;
			case "KEY_RIGHT":
				if (myApp.areaFlag == 0) {
					leaveArea0();
					if (myApp.col0_P == 7) {
						if (keyFlag) {
							toArea2();
						}
					} else {
						setTimeout(" toArea1()", 200);
					}
				} else if (myApp.areaFlag == 1) {
					if (keyFlag) {
						leaveArea1();
						setTimeout("toArea2()", "200ms");
					}
				} else if (myApp.areaFlag == 2) {
					changeRecFocusLR(1);
				}
				doSomething();
			break;
			case "KEY_SELECT":
				doSelect();
				doSomething();
			break;
			case "KEY_SYSTEM":
				eval("var data = " + Utility.getEvent());
				code = data.type;
				if (code == "EVENT_MEDIA_END") {
					playVod(myApp.playByThis);
				}
				doSomething();
			break;
		}
		
		if (keyFlag) {
			keyFlag = false;
			setTimeout("keyFlag = true;", myApp.keyTime);
		}
}

/**
 * 按键响应后初始化页面显示框
 * @return
 */
function doSomething() {
	clearTimeout(t);
	t = setTimeout("disappeare()", myApp.dispearTime);
	if (!myApp.isAppeare) {
		appeare();
		setTimeout("$('col1').style.overflow='hidden';", 10);
		return;
	}
}

/**
 * 功能：首页JS入口
 * @param playThis	频道号或者流信息
 * @param playType  类型:CHAN or VOD
 * @return
 */
function reqInfo(playThis, playType, backUrl) {
	myApp.playByThis = playThis;
	myApp.playType = playType;
	myApp.backUrl = backUrl;
	var url	= "HD_categoryData.jsp";
	var ajaxObj = new AJAX_OBJ(url, getListData);
	ajaxObj.requestData();
	
	(myApp.playType == "CHAN") ? playChannel(myApp.playByThis) : playVod(myApp.playByThis);
	
	//加载声音控制page widgets
	var volumePage = iPanel.pageWidgets.getByName("volumePage");
	if (typeof (volumePage) == "undefined" || volumePage == null) {
		iPanel.pageWidgets.create("volumePage", "volume.html");
	}
}

/**
 * 离开页面,释放资源
 * @return
 */
function exitPage() {
	if ("CHAN".equals(myApp.playType)) {
		mp.leaveChannel();
	} else {
		mp.stop();
		mp.releaseMediaPlayer(NativePlayerInstanceID);
	}
	
	var volumePage = iPanel.pageWidgets.getByName("volumePage");
	volumePage.minimize();
	var mutePage = iPanel.pageWidgets.getByName("mutePage");
	mutePage.minimize();
}