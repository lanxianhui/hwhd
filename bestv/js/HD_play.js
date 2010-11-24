var progId = null;
var fatherId = null;
var typeId = null;
var progNum = null;
var mediaEnd=false;
var program = {};

var statIcon = {
					play:"images/play/vod_play.png",
					pause:"images/play/vod_pause.png",
					backward:"images/play/vod_t0.png",
					forward:"images/play/vod_k0.png"
				};
var shortcutIcon = ["images/play/vod_fastseek0.png", "images/play/vod_fastseek1.png"];
var seeknumIcon = ["images/play/btn_bg_02.gif", "images/play/btn_bg_01.gif"];
var exitImage = [["images/play/pre0.png","images/play/pre1.png"],["images/play/bookmark0.png","images/play/bookmark1.png"],["images/play/over0.png","images/play/over1.png"],["images/play/continue0.png","images/play/continue1.png"],["images/play/next0.png","images/play/next1.png"]];

var introductionShowTime = 30000;						// information show time
var menuAutoHideTime = 5000;								// menu auto hide
															// time
var maxProgressLength = 552;								// progress line max
															// length px
var maxShortProgressLength = 175;           // shortprogress line max length px
var menuTimer = null;

var flag = 0;																// 0.none
																			// 1.play
																			// 2.pause
																			// 3.backward
																			// 4.forward
var introductonFlag = true;									// flag of
															// information

var seekFlag = 1;
var seekPos = 0;
var inputFlag = false;
var inputTimer = null;
var seekNumber = [0, 0];
var maxSeekNumber = [0, 0];
var timeinfoTimer = null;

var speed = 0;


// var progressSlip;
var progressButtonPos = 0;
var progressButtonMaxPos = 24;
var progressFocusTop = -8;
var progressFocusLeft = 46;
var progressFocusMoveSize = 22;
var keysafeFlag = false;
var keysafeTime = 1000;

var exitFlag = false;
var exitPos = 1;// 记录退出窗口中5个焦点的位置.0为上一集，1为记录书签，2为结束观看，3为继续观看，4为下一集
var exitPos1= 2;
var exitMidPos = 1;// 记录之前中间的位置
var exitTrue = false;
// var volumePageTimer=-1;
function eventHandler(obj) {
	if(exitTrue) return;
	switch(obj.code) {
		case "KEY_NUMERIC":
			if(flag == 2) inputSeekNum(obj.value);
			else forChannel();
			return 0;
		case "KEY_UP":
			// if(flag == 2) changeSeekFlag(0);
			if(exitFlag){
				if(backUrl.indexOf("HD_backToVis.jsp")>-1){
					if(exitPos1==3) {
						$("exitItem0"+exitPos1).style.backgroundImage = "url("+exitImage[exitPos1][0]+")";
						exitPos1=2;
						$("exitItem0"+exitPos1).style.backgroundImage = "url("+exitImage[exitPos1][1]+")";
					}
				}
				else{
					if(exitPos > 1 && exitPos < 4){
						$("exitItem"+exitPos).style.backgroundImage = "url("+exitImage[exitPos][0]+")";
						exitPos --;
						$("exitItem"+exitPos).style.backgroundImage = "url("+exitImage[exitPos][1]+")";
						exitMidPos = exitPos;
					}
				}
			}
			else{
				if(flag == 2) {
					if(seekFlag == 0){
						$("seek_" + seekPos).style.backgroundImage = "url(" + seeknumIcon[0] + ")";
						$("progressfocus").style.backgroundImage = "url(images/play/vod_seek_td_focus.png)";
						seekFlag = 1;
					}
				}
			}
			break;
		case "KEY_DOWN":
			if(exitFlag){
				if(backUrl.indexOf("HD_backToVis.jsp")>-1){
					if(exitPos1==2) {
						$("exitItem0"+exitPos1).style.backgroundImage = "url("+exitImage[exitPos1][0]+")";
						exitPos1=3;
						$("exitItem0"+exitPos1).style.backgroundImage = "url("+exitImage[exitPos1][1]+")";
					}
				}else{
					if(exitPos > 0 && exitPos < 3){
						$("exitItem"+exitPos).style.backgroundImage = "url("+exitImage[exitPos][0]+")";
						exitPos ++;
						$("exitItem"+exitPos).style.backgroundImage = "url("+exitImage[exitPos][1]+")";
						exitMidPos = exitPos;
					}
				}
			}
			else{
				if(flag == 2) {
					if(seekFlag == 1){
						$("progressfocus").style.backgroundImage = "url(images/play/vod_seek_td_focus1.png)";
						seekFlag = 0;
						seekPos = 0;
						$("seek_" + seekPos).style.backgroundImage = "url(" + seeknumIcon[1] + ")";
					}
				}
			}
			break;
		case "KEY_LEFT":
			if (seriesFlag) {
				$("seresFocus").style.left	=	"69px";
				seriesPosition	=	1;
			} else {
				if(exitFlag){
					if(program.ISSITCOM == 0) return;// 电影没有上一集、下一集
					if(exitPos > 0 && exitPos < 4){
						$("exitItem"+exitPos).style.backgroundImage = "url("+exitImage[exitPos][0]+")";
						exitPos = 0;
						$("exitItem"+exitPos).style.backgroundImage = "url("+exitImage[exitPos][1]+")";
					}
					else if(exitPos == 4){
						$("exitItem"+exitPos).style.backgroundImage = "url("+exitImage[exitPos][0]+")";
						// exitPos = 0;
						exitPos =exitMidPos;
						$("exitItem"+exitPos).style.backgroundImage = "url("+exitImage[exitPos][1]+")";
					}
				}
				else{
					if(flag == 2) {
						if(seekFlag == 0) {changeSeekNum(-1);}// 移动输入时间跳转
						else if(seekFlag == 1) changeSeekButton(-1);// 滑动进度条的回看
					}
					else {
						if(!isMute){
							hiddenInfor();
							volumePage.show();
							hiddenVolume();
						}	
					}
				}
			}
			break;
		case "KEY_RIGHT":
			if (seriesFlag) {
				$("seresFocus").style.left	=	"357px";
				seriesPosition	=	2;
			} else {
				if(exitFlag){
					if(program.ISSITCOM == 0) return;// 电影没有上一集、下一集
					if(exitPos > 0 && exitPos < 4){
						$("exitItem"+exitPos).style.backgroundImage = "url("+exitImage[exitPos][0]+")";
						exitPos = 4;
						$("exitItem"+exitPos).style.backgroundImage = "url("+exitImage[exitPos][1]+")";
					}
					else if(exitPos == 0){
						$("exitItem"+exitPos).style.backgroundImage = "url("+exitImage[exitPos][0]+")";
						// exitPos = 0;
						exitPos =exitMidPos;
						$("exitItem"+exitPos).style.backgroundImage = "url("+exitImage[exitPos][1]+")";
					}
				}
				else{
					if(flag == 2) {
						if(seekFlag == 0) { changeSeekNum(1);}
						else if(seekFlag == 1) changeSeekButton(1);
					}
					else{
						if(!isMute){
							 hiddenInfor();
					  		 volumePage.show();
							 hiddenVolume();
						}	 
					}
				}
			}
			break;
		case "KEY_PAUSEPLAY":	
			if(!exitFlag) doPause();
			break;
		case "KEY_SELECT":
			if (seriesFlag) {
				if(backUrl.indexOf("HD_vodDetail.jsp")>-1) returnUrl = backUrl;
				else returnUrl = iPanel.eventFrame.detailBackUrl;
				
				if(typeof(program.NEXTEPIS) != "undefined" && program.NEXTEPIS.length !=0) returnUrl = program.NEXTEPISURL;
				
				if (seriesPosition == 1) 
					window.location.href	=	returnUrl;
				else {
					if(backUrl.indexOf("HD_vodDetail.jsp")>-1) window.location.href = backUrl;
					else window.location.href = iPanel.eventFrame.detailBackUrl;
				}
			} else {
				if(exitFlag){
					if(backUrl.indexOf("HD_backToVis.jsp")>-1){
						switch(exitPos1){
							case 2://结束观看
								var newbackUrl="HD_backToDispatch.jsp?^^"+backUrl;
								window.location.href = newbackUrl;
							 	break;
							case 3://继续观看
								exitFlag = false;
								$("exitWindow1").style.webkitTransform = "scale(0)";
								if(mediaEnd) {
									playEnd();
									return;
								}	
								if(flag==2){
									$("menu").style.opacity = 1;
									showMenu(0);
									$("playstatus").style.visibility="visible";
									showPlayStatus();
									showSeek();
									$("seek").style.visibility = "visible";
									clearTimeout(timeinfoTimer);
								}else{
									$("menu").style.opacity = 1;
									$("playstatus").style.visibility="visible";
									flag=3;
									doPause();
								}	
								break;
						}
					}else{
						switch(exitPos){
							case 0:// 上一集
								window.location.href = program.PREEPISURL;
								break;
							case 1:// 记录书签并退出
								var url = "HD_bookMarkAction.jsp?ACTION=insert&PROGID=" + program.PROGID + "&BEGINTIME="+mp.getCurrentPlayTime()+"&ENDTIME="+mp.getMediaDuration()+"&SUPVODID="+fatherId; // 添加书签
							var aj = new AJAX_OBJ(url, function(r){
										var f = "";// r.responseText;
										var xml=r.responseXML.getElementsByTagName("subnum");		
										if(typeof(xml)=="undefined"){
											   f = r.responseText;	 
										}else{	
											for(var m=0;m<xml.length;m++){
													  f=xml[m].firstChild.nodeValue;
												}
											}	
										if(f==0 ||f=="0") {
												window.location.href = backUrl;
										}
										$("content").innerText = getResponseTip(Math.abs(f));
										$("readTips").style.webkitTransform = "scale(1)";
										setTimeout('$("readTips").style.webkitTransform = "scale(0)";readFlag = false;',2000);
										});																
									aj.requestData();
									break;
							case 2:// 结束观看
								if(backUrl.indexOf("HD_vodDetail.jsp")>-1) window.location.href = backUrl;
								else if(backUrl.indexOf("HD_backToVis.jsp")>-1) {
									var newbackUrl="HD_backToDispatch.jsp?^^"+backUrl;
									window.location.href = newbackUrl;
								}
								else window.location.href = iPanel.eventFrame.detailBackUrl;
								break;
							case 3:// 继续观看
								exitFlag = false;
								$("exitWindow").style.webkitTransform = "scale(0)";
								if(mediaEnd) {
									playEnd();
									return;
								}	
								if(flag==2){
									$("menu").style.opacity = 1;
									showMenu(0);
									$("playstatus").style.visibility="visible";
									showPlayStatus();
									showSeek();
									$("seek").style.visibility = "visible";
									clearTimeout(timeinfoTimer);
								}else{
									$("menu").style.opacity = 1;
									$("playstatus").style.visibility="visible";
									flag=3;
									doPause();
								}	
								break;
							case 4:// 下一集
								window.location.href = program.NEXTEPISURL;
								break;
						}
					}
				}
				else
					if($("menu").style.opacity==0){
						doSelect();
					}
					else if(showInforTrue){
						doSelect();
					}
					else{
						doPause();
					}	
			}
			break;
		case "KEY_FAST_FORWARD":
			if(exitFlag) return;
		 	$("menu").style.opacity=1;
		 	forForwordAndBack();
			mediaForward();
			break;
		case "KEY_FAST_REWIND":
			if(exitFlag) return;
			$("menu").style.opacity=1;
			forForwordAndBack();
			mediaBackward();
			break;			
		case "KEY_EXIT":
		case "KEY_BACK":
			if(!exitFlag){
				volumePage.minimize();
				exitFlag = true;
				$("menu").style.opacity=0;
				$("playstatus").style.visibility="hidden";
				mp.pause();
				if(backUrl.indexOf("HD_backToVis.jsp")>-1){
					$("exitWindow1").style.webkitTransform = "scale(1)";
				}
				else{
					$("exitWindow").style.webkitTransform = "scale(1)";				
					if(program.PREEPIS==null||typeof(program.PREEPIS)=="undefined"||program.PREEPIS==""){
						 $("preNum").style.visibility="hidden";
						 $("exitItem0").style.visibility="hidden";	 
					}		 
					if(program.NEXTEPIS==null||typeof(program.NEXTEPIS)=="undefined"||program.NEXTEPIS==""){
						 $("nextNum").style.visibility="hidden";
						 $("exitItem4").style.visibility="hidden";	
					}	
				}
			}
			break;	
		case "KEY_PAGE_UP":
			if(program.ISSITCOM == 0) return;
			if(program.PREEPIS==null||typeof(program.PREEPIS)=="undefined"||program.PREEPIS==""){
				iPanel.overlayFrame.location="promit.html?6";
			}else{
				iPanel.overlayFrame.location="promit.html?4?nextTVUrl="+program.PREEPISURL;
			}
			iPanel.overlayFrame.resizeTo(748,220);
			iPanel.overlayFrame.moveTo(274,250);
			break;
		case "KEY_PAGE_DOWN":
			if(program.ISSITCOM == 0) return;
			if(program.NEXTEPIS==null||typeof(program.NEXTEPIS)=="undefined"||program.NEXTEPIS==""){
				iPanel.overlayFrame.location="promit.html?7";
			}else{
				iPanel.overlayFrame.location="promit.html?5?nextTVUrl="+program.NEXTEPISURL;	
			}
			iPanel.overlayFrame.resizeTo(748,220);
			iPanel.overlayFrame.moveTo(274,250);
			break;
		case "KEY_SYSTEM":
			eval("var data = " + Utility.getEvent());		
			code =data.type;
			if(code=="EVENT_MEDIA_END"){
				if(program.ISSITCOM == 1){
					seriesPlayEnd();
				}else{
					playEnd();
				}	
			}
			if(code=="EVENT_MEDIA_BEGINING"){
					showMenu(6000);
					$("playstatus").style.backgroundImage = "url("+statIcon["play"]+")";
					showPlaySign();
			}
			break;
		
	}
}

window.onload = init;
window.onunload = exit;

var showInforTrue=false;

// 初始化操作
function init() {
	progressSlip = new showSlip($("progressfocus"), progressFocusTop, progressFocusLeft);
	volumePage=iPanel.pageWidgets.getByName("volumePage");
	volumePage.moveTo(437,163);
	volumePage.resizeTo(800,800);
	getVodParam();
	showShortTimeInfo();
}


var playSignFlag=0;//表示隐藏;
function hiddenInfor(){
	$("menu").style.opacity=0;
	clearTimeout(menuTimer);
	if($("playstatus").style.visibility == "visible"){
		clearTimeout(playSignTimeout);
		playSignFlag=1;
	}else{
		playSignFlag=0;
	}
}

function showHiddenInfor(){
	switch(flag){
		case 3:
		case 4:
			$("menu").style.opacity=1;
			break
		case 1:
			$("menu").style.opacity=1;
			if(playSignFlag==1) {
				showPlaySign();
				setTimeout(function (){$("menu").style.opacity=0},6000);
			}else{
				setTimeout(function (){$("menu").style.opacity=0},30000);
			}
			break;
	}
}

function getResponseTip(r) {
	r = r * 1;
	var tipsinfo = ["书签操作成功","ACTION 缺失","基本参数缺失","用户书签已满","书签操作失败","获取书签列表失败"];
	if(isNaN(r)){
		return tipsinfo[4];
	}
	return tipsinfo[r];	
}

var bookTime=-1;
function getVodParam() {
	showTip("影片加载中...");
	var params = window.location.search.substring(1).split("&");
// iPanel.debug("xinsw-------------"+params);
	for(var i = 0; i < params.length; i++) {
		if(params[i].indexOf("PROGID") > -1) progId = params[i].split("=")[1];
		if(params[i].indexOf("PROGNUM") > -1) progNum = params[i].split("=")[1];
		if(params[i].indexOf("FATHERID") > -1) fatherId = params[i].split("=")[1];
		if(params[i].indexOf("TYPE_ID") > -1) typeId = params[i].split("=")[1];
		if(params[i].indexOf("BOOKMARKTIME")>-1) bookTime=params[i].split("=")[1];
	}
	var url = "HD_vodPlayData.jsp?PROGID=" + progId+"&PROGNUM="+progNum+"&FATHERID="+fatherId+"&TYPE_ID="+typeId;
	var ajaxObj = new AJAX("GET",url, true, vodSuccess);
	ajaxObj.onError = vodError;
	ajaxObj.send();
}

function vodSuccess(R) {
	eval("var data = " + R);
	if(typeof data == "undefined") showTip("请求数据为空！");
	else {
		hideTip();
		iPanel.debug("xinsw-------------"+R);
		program = data[0];
		playVod();
		showInfomation();
		if(mp.getMuteFlag()==1){
			if($("muteDiv")==null||typeof($("muteDiv"))=="undefined"){
				creatMuteDiv();
			}
			$("muteDiv").style.webkitTransitionDuration="0ms";
			$("muteDiv").style.visibility="visible";
			$("muteDiv").style.backgroundImage="url(images/vod/mute2.png)";
			$("muteDiv").style.width="62px";
			$("muteDiv").style.height="62px";
			$("muteDiv").style.left="50px";
			$("muteDiv").style.top="620px";
			$("muteDiv").style.webkitTransitionDuration="300ms";
		}
		hideInfomation();
		if(program.ISSITCOM == 0){
			$("exitItem0").style.backgroundImage = "url()";
			$("exitItem4").style.backgroundImage = "url()";
		}
		else{
			$("preNum").innerText = "第"+program.PREEPIS+"集";
			$("nextNum").innerText = "第"+program.NEXTEPIS+"集";
			if(typeof(iPanel.eventFrame.detailBackUrl)=="undefined"){
				iPanel.eventFrame.eval("var detailBackUrl = ''");
			}
			if(backUrl.indexOf("HD_vodDetail.jsp?PROGID")>-1) iPanel.eventFrame.detailBackUrl=backUrl;
		}
	}
}
function vodError(T) {
	showTip("未指定影片");
}
function showTip(str){
	$("tip").innerText = str;
	$("tip").style.visibility = "visible";
}

function hideTip() {
	$("tip").innerText = "";
	$("tip").style.visibility = "hidden";
}

function playVod() {
	mp.setVideoDisplayMode(0);
	mp.setAllowTrickmodeFlag(0);
	mp.setSingleMedia(program.PLAYJSON);
	mp.setCycleFlag(1);
	mp.setRandomFlag(1);
	mp.refreshVideoDisplay();
	mp.playFromStart();
	if(!isNaN(bookTime)&&bookTime!=""&&bookTime>0) {
		setTimeout(mp.playByTime(1, bookTime),50);
	}	
}
function showInfomation() {
	$("programname").innerText = program.VODNAME.substr(0, 12);
	var str = "";
	var regExp = new RegExp(" ","g")
	for(var i = 0; i < program.DIRECTOR.length; i++){
			program.DIRECTOR[i]=program.DIRECTOR[i].replace(regExp , "");
		  str =str+ program.DIRECTOR[i] + " ";
	}		 
	$("director").innerText =str.substr(0, 13);
	var str1 = "";
	for(var i = 0; i < program.ACTOR.length; i++){
		 program.ACTOR[i]=program.ACTOR[i].replace(regExp , "");
		 str1 =str1+ program.ACTOR[i] + " ";
	}	 
	$("actor").innerText = str1.substr(0, 13);
	$("programtime").innerText = program.INFORMATION.substr(0,6);
	$("introduction").innerText = program.INTRODUCE.substr(0, 27) + "...";
	$("starttime").innerText = "00:00:00";
	setTimeout(function(){
		showTimeInfo();
		var t = getFormatTime(mp.getMediaDuration());
		maxSeekNumber[0] = parseInt(t.split(":")[0], 10);
		maxSeekNumber[1] = parseInt(t.split(":")[1], 10);
		$("playstatus").style.backgroundImage = "url("+statIcon["play"]+")";
		// showPlaySign();
		$("endtime").innerText = getFormatTime(mp.getMediaDuration());
		$("playcurrtime").innerText = getFormatTime(mp.getCurrentPlayTime());}, 1000);
}

function showShortTimeInfo(){
	$("shortprogresslinetd").style.width = Math.round(maxShortProgressLength * mp.getCurrentPlayTime() / mp.getMediaDuration()) + "px";
	if(introductonFlag){
		setTimeout(showShortTimeInfo,1000);	
	}
}

function showTimeInfo() {
	$("playcurrtime").innerText = getFormatTime(mp.getCurrentPlayTime());
// $("playcurrtime").innerText =
// getFormatTime(iPanel.ioctlRead("CurrentPlayTime"));
	// alert(getFormatTime(mp.getCurrentPlayTime()));
	$("progresslinetd").style.width = Math.round(maxProgressLength * mp.getCurrentPlayTime() / mp.getMediaDuration()) + "px";
	$("progresstime").innerText = getFormatTime(mp.getCurrentPlayTime());
	showSeekProgressButton();
	timeinfoTimer = setTimeout("showTimeInfo()", 1000);
}

var volumePageTimer=-1;
function hiddenVolume(){
	clearTimeout(volumePageTimer);
	volumePageTimer=setTimeout(function (){
		volumePage.minimize();
		showHiddenInfor();
	},3000);
}

function hideInfomation() {
	setTimeout(function(){
		if(introductonFlag) {
			changeMenu();
		}}, introductionShowTime);
}

function showInfor(){
	introductonFlag = true;
	$("information").style.visibility = "visible";	
	$("shortprogress").style.visibility = "visible"; 
	$("programtime").style.visibility = "visible";
	$("playcurrtime").style.visibility = "hidden";
	$("seekprogress").style.visibility = "hidden";
	$("seek").style.visibility = "visible";
	$("seektip").style.visibility = "visible";
	$("seektime").style.visibility = "hidden";
	for(var i = 0; i < 3; i++)
		$("seek_" + i).style.backgroundImage = "url(" + seeknumIcon[0] + ")";
	// $("seek_" + seekPos).style.backgroundImage = "url(" + seeknumIcon[1] +
	// ")";
	$("seek_info").innerText = "输入不合理会自动纠正";
	showShortTimeInfo();
	clearTimeout(menuTimer);
	flag=0;
	showMenu(30000);
}

function changeMenu() {
	introductonFlag = false;
	$("information").style.visibility = "hidden";
	$("shortprogress").style.visibility = "hidden"; 
	$("programtime").style.visibility = "hidden";
	$("playcurrtime").style.visibility = "visible";
	$("seekprogress").style.visibility = "visible";
	$("seektip").style.visibility = "hidden";
	$("seek").style.visibility = "hidden";
	$("seektime").style.visibility = "visible";
	for(var i = 0; i < 3; i++)
		$("seek_" + i).style.backgroundImage = "url(" + seeknumIcon[0] + ")";
	// $("seek_" + seekPos).style.backgroundImage = "url(" + seeknumIcon[1] +
	// ")";
	$("seek_info").innerText = "输入不合理会自动纠正";
}

function changeSeekFlag(n) {
	seekFlag = n;
	if(seekFlag == 0) {
		$("shortcuts").style.backgroundImage = "url(" + shortcutIcon[1] + ")";

	} else {
		$("shortcuts").style.backgroundImage = "url(" + shortcutIcon[0] + ")";
	}
}

function changeSeekNum(n) {
	$("seek_" + seekPos).style.backgroundImage = "url(" + seeknumIcon[0] + ")";
	seekPos += n;
	if(seekPos < 0) seekPos = 0;
	if(seekPos > 2) seekPos = 2;
	$("seek_" + seekPos).style.backgroundImage = "url(" + seeknumIcon[1] + ")";
}

function showMenu(delay) {
	if(flag != 0) {
		clearTimeout(menuTimer);
	} else {
		flag = 1;
		// $("menu").style.visibility = "visible";
		$("menu").style.opacity = 1;
		// $("menu").style.webkitTransform = "scale(1)";
	}
	hideMenu(delay);
}

function hideMenu(delay) {
	if(delay == 0) return;
	menuTimer = setTimeout(function(){
		flag = 0;
		// $("menu").style.visibility = "hidden";
		$("menu").style.opacity = 0;
		}, delay);
}

function showSeekProgressButton() {
	var ct = mp.getCurrentPlayTime();
	var t = mp.getMediaDuration();
	progressButtonPos = Math.round(progressButtonMaxPos * ct / t);
	nowTime=Math.round(mp.getMediaDuration() * progressButtonPos / progressButtonMaxPos);
	$("progressfocus").style.left = (progressFocusLeft + progressFocusMoveSize * progressButtonPos) + "px";
}

var nowTime=0;
function changeSeekButton(n) {
// if(keysafeFlag) return;
// keysafeFlag = true;
// setTimeout(function(){keysafeFlag = false;}, keysafeTime);
	progressButtonPos += n;
	if(progressButtonPos < 0){ progressButtonPos = 0; return;};
	if(progressButtonPos > progressButtonMaxPos){ progressButtonPos = progressButtonMaxPos; return;}
	var time = Math.round(mp.getMediaDuration() * progressButtonPos / progressButtonMaxPos);
	$("progresstime").innerText = getFormatTime(time);
	// progressSlip.init();
	// progressSlip.jsSlip(0, n * progressFocusMoveSize);
	/*
	 * $("progressfocus").style.left+=progressFocusMoveSize *n;
	 */
	nowTime=time;
	// $("progressfocus").style.webkitTransitionDuration="300ms"
	$("progressfocus").style.left = (progressFocusLeft + progressFocusMoveSize * progressButtonPos) + "px";
}

var forwardTimer=-1
function mediaBackward() {
	if(introductonFlag) {
		changeMenu();
	}
	showMenu(0);
	flag = 3;
	if(speed >= 0) speed = -2;
	else speed = speed * 4;
	mp.fastRewind(speed);
	if(speed <- 32){
		 speed = 0;
		 mp.resume();
		 showMenu(6000);
	}
	showPlayStatus();
}

function mediaForward() {
	if(introductonFlag) {
		changeMenu();	
	}
	showMenu(0);
	flag = 4;
	if(speed < 2) speed = 2;
	else speed = speed * 4;
	mp.fastForward(speed);
	if(speed > 32){
		 speed = 0;
		 mp.resume();
		 showMenu(6000);
	}
	showPlayStatus();
}

function showPlayStatus() {
	setTimeout(function(){
		eval("var stat = " + mp.getPlaybackMode().replace("x", ""));
		switch(stat.PlayMode){
			case "Normal Play":
				$("playstatus").style.backgroundImage = "url("+statIcon["play"]+")";
				showPlaySign();
				break;
			case "Pause":
				$("playstatus").style.backgroundImage = "url("+statIcon["pause"]+")";
				clearTimeout(playSignTimeout);
				$("playstatus").style.visibility = "visible";
				break;
			case "Trickmode":
				if(stat.Speed > 0)
					$("playstatus").style.backgroundImage = "url(images/play/vod_k"+stat.Speed+".png)";
				else{
					var temp = stat.Speed*-1;
					$("playstatus").style.backgroundImage = "url(images/play/vod_t"+temp+".png)";
				}
				clearTimeout(playSignTimeout);
				$("playstatus").style.visibility = "visible";
				break;
		}}, 500);
}

function getFormatTime(s) {
	var mini = Math.floor(s/60);
	if(mini<0) mini = 0;
	var h = Math.floor(mini/60);
	if(h<0) h = 0;
	var m = Math.floor(mini - h * 60);
	if(m<0) m = 0;
	var sec = Math.floor(s - h*60*60 - m * 60);
	if(sec<0) sec = 0;
	if(h < 10) h = "0" + h;
	if(m < 10) m = "0" + m;
	if(sec < 10) sec = "0" + sec;
	return h + ":" + m + ":" + sec;
}

function forForwordAndBack(){
		$("progressline").style.visibility = "visible";
		$("progresslinetable").style.visibility = "hidden";
		$("seek").style.visibility = "hidden";
		$("progressfocus").style.visibility = "hidden";	
		// flag = 1;
		clearTimeout(timeinfoTimer);
		showTimeInfo();
		// showTimeInfo();
}

function doPause(){
	$("menu").style.opacity=1;
	if(introductonFlag) {
		changeMenu();
		showMenu(menuAutoHideTime);
		showPlaySign();
		// return;
	}
	if(flag == 0) {
	// showMenu(menuAutoHideTime);
		flag=1;
	}
	if(flag == 1) {
			showMenu(0);
			flag = 2;
			mp.pause();
			showPlayStatus();
			showSeek();
			$("seek").style.visibility = "visible";
			clearTimeout(timeinfoTimer);
			// $("seektime").style.visibility = "hidden";
	}
	else if(flag == 2) {
			showMenu(0);
			if(seekFlag == 0) {// 快速跳转，输入时间区域
				if(seekPos == 2) {
					seekFlag = 1;
					$("seek").style.visibility = "hidden";
					gotoSeek(seekNumber[0] * 3600 + seekNumber[1] * 60);
					$("progressline").style.visibility = "visible";
					$("progresslinetable").style.visibility = "hidden";
					$("progressfocus").style.visibility = "hidden";
					flag = 1;
					$("playstatus").style.backgroundImage = "url("+statIcon["play"]+")";
					showPlaySign();
					$("progressfocus").style.backgroundImage = "url(images/play/vod_seek_td_focus.png)";
					showMenu(menuAutoHideTime);
					for(var i = 0; i < 3; i++)
					$("seek_" + i).style.backgroundImage = "url(" + seeknumIcon[0] + ")";
				}
			} else {// 滑动进度调跳转区域
				$("progressline").style.visibility = "visible";
				$("progresslinetable").style.visibility = "hidden";
				$("seek").style.visibility = "hidden";
				$("progressfocus").style.visibility = "hidden";	
				flag = 1;
				mp.resume();
				$("playstatus").style.backgroundImage = "url("+statIcon["play"]+")";
				showPlaySign();
				showMenu(menuAutoHideTime);
				gotoSeek(nowTime);
			}
		} 
	else {
		flag = 1;
		mp.resume();
		speed = 1;
		showPlayStatus();
		showMenu(6000);
	}
}

function doSelect() {
	if($("menu").style.opacity == 0){
		 showInfor();
		 showInforTrue=true;
	}else{
		 	$("menu").style.opacity=0;
			$("playstatus").style.visibility="hidden";
			showInforTrue=false;
	}
	// introductonFlag=false;
}

function showSeek() {
	$("progressline").style.visibility = "hidden";
	$("progresslinetable").style.visibility = "visible";
	$("progressfocus").style.visibility = "visible";
	$("shortcuts").style.backgroundImage = "url(" + shortcutIcon[0] + ")";
	$("shortcuts").style.visibility = "visible";
}

function inputSeekNum(n) {
	if(seekFlag == 1) return;
	if(seekPos < 2) {
		if(inputFlag) {
			window.clearTimeout(inputTimer);
			seekNumber[seekPos] = seekNumber[seekPos] * 10 + n;
		}else{
			inputFlag = true;
			seekNumber[seekPos] = n;
		}
		if(seekNumber[seekPos] > maxSeekNumber[seekPos]) seekNumber[seekPos] = maxSeekNumber[seekPos];
		$("seek_" + seekPos).innerText = seekNumber[seekPos] < 10 ? ("0" + seekNumber[seekPos]) : seekNumber[seekPos];
		inputTimer = setTimeout(function(){inputFlag = false;}, 600);
	}
}

function gotoSeek(t) {
	var type = 1; // "Normal Play Time", "Absolute Time";
	var time = t; // seconds
	$("playstatus").style.backgroundImage = "url("+statIcon["play"]+")";
	showPlaySign();
	mp.playByTime(type, time);
	if(seekFlag == 0){
		clearTimeout(timeinfoTimer);
		showTimeInfo();
	}
	else{
		clearTimeout(timeinfoTimer);
		showTimeInfo();
	}
	
}
var playSignTimeout = -1;
function hidePlaySign(){
	$("playstatus").style.visibility = "hidden";
}
function showPlaySign(){
	$("playstatus").style.visibility = "visible";
	clearTimeout(playSignTimeout);
	playSignTimeout = setTimeout("hidePlaySign()",3000);
}
function exit() {
	volumePage.minimize();
	// var mutePage=iPanel.pageWidgets.getByName("mutePage");
	// mutePage.minimize();
	mp.stop();
	mp.releaseMediaPlayer(NativePlayerInstanceID);
	if(typeof($("muteDiv"))!="undefined"){
		$("muteDiv").style.visibility="hidden";
	}
}

function playEnd(){
	exitTrue=true;
	$("menu").style.opacity=0;
	$("playstatus").style.opacity=0;
	$("progresslinetd").style.width=maxProgressLength;
	document.body.style.backgroundImage="url(images/play/thanks.jpg)";
	var returnUrl = backUrl;
	if(typeof(program.NEXTEPIS) != "undefined" && program.NEXTEPIS.length !=0 ) returnUrl = program.NEXTEPISURL;    // 实现电视剧连播功能
	setTimeout(function (){window.location.href = returnUrl;},5000);
}

var seriesFlag	=	false;   // false:连续剧聚集未播放完毕; true：播放完毕显示自动跳转框
var seriesPosition	=	1;   //1:left;2:right;
function seriesPlayEnd() {
	
	if(typeof(program.NEXTEPIS) != "undefined" && program.NEXTEPIS.length !=0) {
		exitFlag = true;
		seriesFlag	=	true;
		setTimeout(function () {$("seriesTips").style.visibility= "visible"}, 200);
		$("menu").style.visibility="hidden";
		$("playstatus").style.visibility="hidden";
		mediaEnd=true;
		document.body.style.backgroundImage="url(images/play/series.jpg)";
		$("seresName").innerText		=	"您刚才观看的是" + program.VODNAME.slice(0,30);
		var waitSecond	=	5;
		$("seresSecond").innerHTML	= waitSecond + "秒";
		var tempInterval = setInterval(function () {
			$("seresSecond").innerHTML	= (--waitSecond) + "秒";
		}, 1000);
		
		var returnUrl = backUrl;
		if(typeof(program.NEXTEPIS) != "undefined" && program.NEXTEPIS.length !=0) returnUrl = program.NEXTEPISURL;    // 实现电视剧连播功能

		setTimeout(function () {
			clearInterval(tempInterval);
			window.location.href = returnUrl;
		}, 5000);
	} else {
		playEnd();
	}
}

function noChannel(channelNumber){
	$("channelPrompg").style.webkitTransitionDuration="500ms";
	$("channelPrompg").style.webkitTransform= "scale(1)";
	$("channelPrompgText").innerText="频道<"+channelNumber+">不存在";
	setTimeout('$("channelPrompg").style.webkitTransform= "scale(0)"',4000);
}