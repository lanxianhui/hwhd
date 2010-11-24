<%@ include file="HD_preFocusElement.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="designer" content="meifk" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"  />
<meta name="page-view-size" content="1280*720">
<!--<meta http-equiv="Page-Enter" content="revealTrans(Duration=1.0,Transition=9)">-->
<!--水平百页窗特效-->
<meta http-equiv="Page-Enter" content="blendTrans(Duration=2.0)" />
<!--<meta http-equiv="Page-Exit" content="blendTrans(Duration=2.0)">-->
<title>myPhoto</title>
<script src="js/mini.js" type="text/javascript"></script>
<style type="text/css">
*{margin:0; padding:0;}
.bodybg{position:absolute; left:0px; top:0px; ;width:1280px;height:720px;}
#menutiltle{position:absolute; left:235px; top:15px; width:auto; height:59px; };
#capability{position:absolute;left:310px;width:356px;height:67px;color:#FFFFFF;font-family:黑体;font-size:30px;line-height:67px;top:11px;};
#menu{position:absolute; top:37px; left:-4px; width:222px; height:665px; overflow:hidden; background-image:url(images/mymemory/menu_bg.png);z-index:1; }
#menu div.menu{position:absolute; top:0; left:6px; width:212px; height:65px; color:#747474; font-family:黑体; font-size:32px;text-align:center; z-index:3;-webkit-transition-duration:0.3s;}
#menu div.focusbg{position:absolute; top:55px; left:5px; width:218px; height:186px; background:url(images/mymemory/menu_focus1.png) no-repeat; z-index:2}
#menu #menu0{top:77px;}
#menu #menu1{top:161px;}
#menu #menu2{top:245px;}

#submenu{position:absolute; top:149px; left:222px; width:253px; height:464px;}
#submenu .submenuDiv{position:absolute; left:0px; height:58px; line-height:58px; width:253px;}
#submenu .submenuDiv .subimgDiv{position:absolute; left:0px; height:58px; line-height:58px; width:30px; padding-top:11px; overflow:hidden}
#submenu .submenuDiv .submenuName{position:absolute; left:31px; height:58px; line-height:58px; width:223px;font-family:黑体 ; font-size:24px ; color:#393939; overflow:hidden}
#submenu #submenufocus{position:absolute; top:-10px; left:-6px; width:267px; height:72px; background-image:url(images/mymemory/focus.png); background-repeat: no-repeat; background-position:center;-webkit-transition-duration:0.3s; z-index:15; visibility:hidden}
#listlength{position:absolute; top:651px; left:241px; width:80px; height:30px; line-height:30px; color:#ffffff; font-family:黑体; font-size:24px}
#content{position:absolute; top:80px; left:480px; width:760px; height:520px;}
#content div.head{position:relative; width:760px; height:40px; color:white;}
#content div.head td{font-size:26px; font-family:黑体}
#content div.body{position:relative; width:760px; height:480px;}
#content #jindu{position:absolute; top:460px; left:53px; width:633px; height:22px; background:url(images/mymemory/progress_bg.png) no-repeat; opacity:0; -webkit-transition-duration:0.3s; z-index:120;}
#content #jindu #jindu_left{position:absolute; top:5px; left:5px; width:5px; height:22px; background:url(images/mymemory/leftpro.png) no-repeat;}
#content #jindu #jindu_mid{position:absolute; top:5px; left:10px; width:0px; height:12px; background:url(images/mymemory/progess.png) repeat-x;}
#content #jindu #jindu_right{position:absolute; top:5px; left:10px; width:6px; height:12px; background:url(images/mymemory/rightpro.png) no-repeat;}
#photoin, #photoout{position:absolute; top:49px; left:1px; width:760px; height:480px; -webkit-transition-duration:0.3s; z-index:100;}

#tips{position:absolute; top:614px; left:479px; width:760px; height:60px; color:white; z-index:5}
#tip0{width:70px; background:url(images/mymemory/sure.png) no-repeat center;}
#tip1{width:60px;font-size:26px; font-family:黑体}
#tip2{width:60px; background:url(images/mymemory/tm.gif) no-repeat center;}
#tip3{width:270px;}
#tip4{width:60px;background:url(images/mymemory/arrow.png) no-repeat center;}
#tip5{width:100px;font-size:26px; font-family:黑体}
#tip6{width:60px; background:url(images/mymemory/play.png) no-repeat center;}
#tip7{width:140px; font-size:26px; font-family:黑体}

#directIconUp{position:absolute; top:86px; left:319px; width:55px; height:40px; background:url(images/mymemory/up.png) no-repeat;}
#directIconDw{position:absolute; top:647px; left:327px; width:55px; height:40px; background:url(images/mymemory/down.png) no-repeat;}
</style>
<script type="text/javascript">
/*
var menu = [{name:"我的音乐", icon:["images/mymemory/music0.png", "images/mymemory/music1.png"], defaultIcon:"images/mymemory/mymusic_bg.png",
						 submenu:[]},
						{name:"我的图片", icon:["images/mymemory/picture0.png", "images/mymemory/picture0.png"], defaultIcon:"",
						 submenu:[]},
						{name:"我的视频", icon:["images/index_menu16_1.png", "images/index_menu16.png"], defaultIcon:"images/mymemory/tm.gif",
						 submenu:[]}						 
						];*/
var bground = ["images/mymemory/music_bg.jpg", "images/mymemory/video_bg.gif"];
var menuFocus = ["images/mymemory/menu_focus.png", "images/mymemory/menu_focus1.png"];
var subimgBg=["images/mymemory/music.png", "images/mymemory/picture.png","images/mymemory/video.png"];
var subimgBg1=["images/mymemory/music1.png", "images/mymemory/picture1.png","images/mymemory/video1.png"];
var menuPos = 0;
var imgPos = 0;
var duration = "0.3s";
var imgObj = [];
var imgSide;
var moveFlag = false;
var top = [66, 186, 306];
var opc = [0.5, 1, 0.5];
var size = [[119, 28], [140, 55]];
var topSep = 120;

var flag = 0;
//var submenuFlag = 0;
var subMenuDelay = 300;			//子菜单刷新最小时间间隔

var submenu = [];
var submenuPos = 0;
var submenuImgPos = 0;
var submenuImgObj = [];
var submenuObj = [];
var submenuDivTitleObj = [];
var submenuSidePos;
var submenuShowFlag = false;
var submenuTop = [0, 166, 332,498];
var submenuFocTop = [10, 170, 330];
var submenuOpc = [0.5, 1, 0.5];
var submenuTopSep = 160;
var submenuImgFocus;
var subimgObj=[];
var submenuDivObj=[];
var submenuMoveFlag = false;
var photoIn, photoOut;
var photoSize = [[760, 480],[1280, 720]];
var photoPos = [[49, 1],[-80, -480]];
var fullFlag = false;
var autoPlayTimer = null;
var mediaPause = false;
var mediaFast = false;


mp.setVideoDisplayMode(0)
mp.setAllowTrickmodeFlag(0);
mp.setCycleFlag(1);
mp.setNativeUIFlag(0)
mp.setVideoDisplayArea(520, 126, 607, 455);
mp.refreshVideoDisplay();

var jinduMaxLength = 613;
var jinduDuration = 0;
var jinduCurrTime = 0;
var progressTimer = null;

var safeFlag = false;
var safeTime = 1000;
var keyBackTime=false;
var havaDataTrue=false;

window.onload = init;
function eventHandler(obj) {
	if(safetimeToCanying) return ;
	switch(obj.code) {
		case "KEY_UP":
			if(flag == 0) changeMenu(-1);
			else if(flag == 1) changeSubMenu(-1);
			break;
		case "KEY_DOWN":
			if(flag == 0) changeMenu(1);
			else if(flag == 1) changeSubMenu(1);
			break;
		case "KEY_LEFT":
			if(flag == 1) changeFlag(0);
			break;
		case "KEY_RIGHT":
			if(flag == 0) changeFlag(1);
			break;
		case "KEY_SELECT":
			if(menuPos==2){
				fullMedia();
			}	
			if(menuPos==1&&flag==1){
				fullPhoto();
			}
			break;
		case "KEY_PAUSEPLAY":
			doSelect();
			break;
		case "KEY_FAST_FORWARD":
			//if(flag == 1 && !fullFlag && menuPos != 1) mediaActFast(1);
			break;
		case "KEY_FAST_REWIND":
		//if(flag == 1 && !fullFlag && menuPos != 1) mediaActFast(-1);
			break;
		case "KEY_BACK":
			if(keyBackTime) return;
			if(fullFlag){		
				fullPhoto();
				keyBackTime=true;
				setTimeout(function (){keyBackTime=false},300);
				return;
			}
			window.location.href=backUrl;	
			return 0;
			break;
		case "KEY_EXIT":
			window.location.href=backUrl;
			// window.location.href="../index.html";
			//iPanel.back();
			break;	
		case "KEY_SYSTEM":
			eval("var data = " + Utility.getEvent());		
			code =data.type;
			if(code=="EVENT_MEDIA_END"){
				if(flag==0){
						changeFlag(1);
				}
				if(submenuPos<menu[menuPos].submenu.length-1){			
					 changeSubMenu(1); 
					 //alert("??????");
				}else{
					submenuObj[submenuPos%8].style.fontSize = "24px";
					submenuObj[submenuPos%8].style.color = "#393939";
					subimgObj[submenuPos%8].src=subimgBg[menuPos];
					showSubMenu();
					submenuObj[submenuPos%8].style.fontSize = "26px";
					submenuObj[submenuPos%8].style.color = "#ffffff";
					subimgObj[submenuPos%8].src=subimgBg1[menuPos];
				}	 
			}
			break;	
	}
}
var menu=[];
var safetimeToCanying=true;
function init() {
	menu=iPanel.eventFrame.USBData;
	menu[0].name="我的音乐";
	menu[1].name="我的图片";
	menu[2].name="我的视频"
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
	setTimeout("safetimeToCanying=false",2000);
	
	initObj();
}

function initObj(){
	for(var i = 0; i < 4; i++) {
		imgObj[i] = $("menu" + i);
	}
	for(var i = 0; i < 8; i++){
		submenuObj[i] = $("submenu" + i);
		subimgObj[i]=$("subimg"+i);	
		submenuDivObj[i]=$("submenuDiv"+i);
	}
	submenuImgFocus = $("submenufocus");
	photoIn = $("photoin");
	photoOut = $("photoout");
	$("menu0").style.color="#ffffff"
	showMenu();
	showSubMenu();
}

var dataReady=false;//数据是否OK
function changeFlag(n) {
	if(fullFlag) return;
	if(moveFlag) return;
	if(!dataReady) return ;
	if(submenu.length==0) return;
	moveFlag = true;
	setTimeout(function(){moveFlag = false; }, "300ms");
	flag = n;
	var i= submenuPos%8;
	$("focusbg").style.webkitTransitionDuration = "0s";
	switch(flag) {
		case 0:
			$("focusbg").style.backgroundImage = "url(" + menuFocus[1] + ")";
			$("focusbg").style.left="5px";
			submenuImgFocus.style.visibility = "hidden";
			submenuObj[i].style.fontSize = "24px";
			submenuObj[i].style.color="#393939";
			subimgObj[i].src=subimgBg[menuPos];
			break;
		case 1:
			$("focusbg").style.backgroundImage = "url(" + menuFocus[0] + ")";
			$("focusbg").style.left="-2px";
			submenuImgFocus.style.visibility = "visible";
			submenuObj[i].style.fontSize = "26px";
			submenuObj[i].style.color="#ffffff";
			subimgObj[i].src=subimgBg1[menuPos];
			//autoPlay();
			break;
	}
}
function showMenu() {
	var len = menu.length;
	for(var i = 0; i < 2; i++) {
		imgObj[i].innerText=menu[i].name;
	}
	$("capability").innerText="功能-我的储存-"+menu[0].name;
	
}

var timer=new Object();
function changeMenu(n) {
	if(menuPos != 1) {
		mp.stop();
	}	
	if(moveFlag) return;
	moveFlag = true;
	setTimeout(function(){moveFlag = false; }, "200ms");
	dataReady=false;
	var len = menu.length;
	$("focusbg").style.webkitTransitionDuration="200ms";
	if(n<0){
		if(menuPos<1){
			return;
		}
		menuPos+=n;
		$("menu"+menuPos).style.color="#ffffff";
		$("menu"+(menuPos-n)).style.color="#747474";
		$("focusbg").style.top-=83;
	}
	else{
		if(menuPos>0){
			return;
		}
		menuPos+=n;
		$("menu"+menuPos).style.color="#ffffff";
		$("menu"+(menuPos-n)).style.color="#747474";
		$("focusbg").style.top+=83;
	}
	
	$("capability").innerText="功能-我的储存-"+menu[menuPos].name
	clearTimeout(timer);
	if(menuPos == 2) {
		$("bodybg").src= bground[1];
	}else{
		$("bodybg").src = bground[0];
	}

	timer=setTimeout(function (){
		for(var m=0;m<8;m++){
			subimgObj[m].src=subimgBg[menuPos];
		}
		showSubMenu()
		dataReady=true;
	},500);
}

function showSubMenu() {	
	submenu = menu[menuPos].submenu;
	dataReady=true;
	resetSubmenu();
	showSubData(0);
	showListLengthTip()
	if(menuPos!=1){
		photoIn.src = menu[menuPos].defaultIcon;
		photoOut.src = menu[menuPos].defaultIcon;
		photoIn.style.opacity = 1;
		$("title").innerText = submenu[submenuPos].name;
		if(menuPos == 0) {
			$("jindu").style.opacity = 1;
			$("tip3").innerText = submenu[submenuPos].name;
			$("tip2").style.backgroundImage = "url(images/mymemory/tip_icon1.png)";
			mediaPlay(submenu[submenuPos].path);
		}else{
			$("jindu").style.opacity = 0;
			$("tip2").style.backgroundImage = "url(images/mymemory/tm.gif)";
			$("tip3").innerText = "";
			mediaPlay(submenu[submenuPos].path);
		}
	}	
	else{
		photoIn.src = submenu[submenuPos].path;
		photoOut.src = submenu[submenuPos].path;
		photoIn.style.opacity = 1;
		$("jindu").style.opacity = 0;
		$("title").innerText = submenu[submenuPos].name;
		$("tip2").style.backgroundImage = "url(images/mymemory/tm.gif)";
		$("tip3").innerText = "";
	}	
	if(submenu.length==0) $("title").innerText="";
}


function resetSubmenu() {
	submenuPos = 0;
	submenuImgPos = 0;
	jinduCurrTime = 0;
	mediaPause = false;
	subfocusPos=0;
	submenuImgFocus.style.top=-10;
	var len = 0;
	$("jindu_mid").style.width = len + "px";
	$("jindu_right").style.left = (len + 10) + "px";
	if(menuPos == 0) {
		$("tip0").style.backgroundImage = "url(images/mymemory/tm.gif)";
		$("tip1").innerText = "";
	} else {
		$("tip0").style.backgroundImage = "url(images/mymemory/sure.png)";
		$("tip1").innerText = "全屏";
	}
	window.clearTimeout(progressTimer);
}
function showListLengthTip() {
	if(submenu.length==0) $("listlength").innerText ="";
	else $("listlength").innerText = (submenuPos+1) + "/" + (submenu.length);
}

function showSubData(n){
	for(var i=8*n;i<8+8*n;i++){
		if(i>submenu.length-1){
			submenuDivObj[i%8].style.visibility="hidden";
		}else{
			submenuDivObj[i%8].style.visibility="visible";
			submenuObj[i%8].innerText=menu[menuPos].submenu[i].name;
		}	
	}	
}

var subtimer=new Object();

var mediaTime=new Object();

function changeSubMenu(n) {
	if(submenuMoveFlag || submenu.length == 0) return;
		if(((submenuPos==submenu.length-1)&&n>0)||(submenuPos==0&&n<0)){
			return ;
		}
		if((submenuPos%8==7&&n>0)||(submenuPos%8==0&&n<0)){
			if(submenuPos%8==7){
				submenuImgFocus.style.top=-10;	
				submenuImgFocus.style.webkitTransitionDuration="0ms";
				submenuPos+=n;
				showSubData(Math.ceil(submenuPos/8));
			}else{
				submenuPos-=8;
				showSubData(Math.ceil(submenuPos/8));
			}	
			
			getFocusColor(n);	
			showListLengthTip();
			showScreen();	
			return
		}
		else{	
			submenuImgFocus.style.webkitTransitionDuration="200ms";		
			submenuImgFocus.style.top+=n*59;
		}
		submenuPos+=n;
		getFocusColor(n);
		showListLengthTip();
		//autoPlay();
		clearTimeout(mediaTime);
		mediaTime=setTimeout("showScreen()",500);

}

function showScreen(){
	if(menuPos == 1) {
		if(!fullFlag) photoOut.style.opacity = 0;
		photoIn.src = submenu[submenuPos].path;
		photoIn.style.opacity = 1;
		photoOut.src = submenu[submenuPos].path;
		photoOut.style.opacity = 0;
		//var temp = photoIn;
		//photoIn = photoOut;
		//photoOut = temp;
		$("title").innerText = submenu[submenuPos].name;
		if(submenuPos==submenu.length-1) setTimeout("fullPhoto()",3000);	 
		return ;
	} else {
		$("title").innerText = submenu[submenuPos].name;
		mediaPlay(submenu[submenuPos].path);
	}
}

function getFocusColor(n){
	submenuObj[submenuPos%8].style.fontSize = "26px";
	submenuObj[submenuPos%8].style.color = "#ffffff";
	subimgObj[submenuPos%8].src=subimgBg1[menuPos];
	submenuObj[(submenuPos-n)%8].style.fontSize = "24px";
	submenuObj[(submenuPos-n)%8].style.color = "#393939";
	subimgObj[(submenuPos-n)%8].src=subimgBg[menuPos];
}

function doSelect() {
	if(flag == 1) {
		mediaActPause();
	}
}
function fullPhoto() {
	if(fullFlag) {
		fullFlag = false;
		photoIn.style.width = photoSize[0][0] + "px";
		photoIn.style.height = photoSize[0][1] + "px";
		photoIn.style.top = photoPos[0][0] + "px";
		photoIn.style.left = photoPos[0][1] + "px";
		photoOut.style.width = photoSize[0][0] + "px";
		photoOut.style.height = photoSize[0][1] + "px";
		photoOut.style.top = photoPos[0][0] + "px";
		photoOut.style.left = photoPos[0][1] + "px";
		stopPlay();
	} else {
		fullFlag = true;
		photoIn.style.width = photoSize[1][0] + "px";
		photoIn.style.height = photoSize[1][1] + "px";
		photoIn.style.top = photoPos[1][0] + "px";
		photoIn.style.left = photoPos[1][1] + "px";
		photoOut.style.width = photoSize[1][0] + "px";
		photoOut.style.height = photoSize[1][1] + "px";
		photoOut.style.top = photoPos[1][0] + "px";
		photoOut.style.left = photoPos[1][1] + "px";
		autoPlay();
	}
}
function fullMedia() {
	if(fullFlag) {
		fullFlag = false;
		showAll();
		mp.setVideoDisplayArea(520, 126, 607, 455);
		mp.refreshVideoDisplay();
	} else {
		mp.setVideoDisplayArea(0, 0, 1280, 720);
		mp.refreshVideoDisplay();
		fullFlag = true;
		hiddenAll();
	}
}


function autoPlay() {
	if(autoPlayTimer != -1)	
	//alert("GO一下");
		if(submenuPos==submenu.length-1){
			 setTimeout("fullPhoto()",3000);	
		}else{
		autoPlayTimer = setTimeout(function (){
			 changeSubMenu(1);
			 autoPlay();
			 }, 3000);
		}	 
	}
function stopPlay() {
	clearTimeout(autoPlayTimer);
	autoPlayTimer = null;
}


function mediaPlay(url) {
	mp.stop();
	jinduCurrTime = 0;
	if(progressTimer != null) window.clearTimeout(progressTimer);
	var url1="file://"+url;
	mp.setSingleMedia(toJson(url1));
	mp.playFromStart();
	setTimeout("showProgress()", 1000);
}
function mediaActPause() {
	if(mediaFast) {
		mp.resume();
		mediaFast = false;
		showProgress();
		return;
	}
	if(mediaPause) {
		mp.resume();
		mediaPause = false;
		showProgress();
	} else {
		mp.pause();
		mediaPause = true;
		$("tip3").innerText = "暂停中...";
		window.clearTimeout(progressTimer);
	}
}
function mediaActFast(n) {
	if(menuPos != 1) {
		mediaFast = true;
		$("tip3").innerText = n < 0 ? "快退中..." : "快进中...";
		clearTimeout(progressTimer);
		if(n < 0) mp.fastRewind(-4);
		else mp.fastForward(4);
	}
}
function mediaStop() {
	mp.stop();
}

function toJson(url){ 
	return '[{mediaUrl:"'+url
		+'",mediaCode: "jsoncode1",'
		+'"mediaType:2,'
		+'"audioType:1,'
		+'"videoType:1,'
		+'"streamType:1,'
		+'"drmType:1,'
		+'"fingerPrint:0,'
		+'"copyProtection:1,'
		+'"allowTrickmode:1,'
		+'"startTime:0,'
		+'"endTime:500,'
		+'"entryID:"jsonentry1"}]';	
}

function showProgress() {
	jinduCurrTime = mp.getCurrentPlayTime();
//	if(jinduCurrTime > jinduDuration) jinduCurrTime = jinduDuration;
	var len = Math.floor(jinduMaxLength * jinduCurrTime / mp.getMediaDuration());
	$("jindu_mid").style.width = len + "px";
	$("jindu_right").style.left = (len + 10) + "px";
	if(menuPos!=1){
		$("tip3").innerText = getFormatTime(jinduCurrTime);
	}	
	progressTimer = setTimeout("showProgress()", 100);
}

function getFormatTime(seconds) {
	var m = Math.floor(seconds / 60);
	var s = seconds - 60 * m;
	return (m < 10 ? ("0" + m) : m) + ":" + (s < 10 ? ("0" + s) : s);
}

function exit() {
	mp.setVideoDisplayArea(0, 0, 1280, 720);
	mp.refreshVideoDisplay();
	mp.stop();
	mp.releaseMediaPlayer(NativePlayerInstanceID);
}

function hiddenAll(){
	$("menutiltle").style.visibility="hidden";
	$("capability").style.visibility="hidden";
	$("menu").style.visibility="hidden";
	$("submenu").style.visibility="hidden";
	$("listlength").style.visibility="hidden";
	$("content").style.visibility="hidden";
	$("tips").style.visibility="hidden";
	$("directIconUp").style.visibility="hidden";
	$("directIconDw").style.visibility="hidden";
	$("submenufocus").style.visibility="hidden";
	$("bodybackground").style.visibility="hidden";
}

function showAll(){
	$("menutiltle").style.visibility="visible";
	$("menu").style.visibility="visible";
	$("submenu").style.visibility="visible";
	$("listlength").style.visibility="visible";
	$("content").style.visibility="visible";
	$("tips").style.visibility="visible";
	$("directIconUp").style.visibility="visible";
	$("directIconDw").style.visibility="visible";
	$("submenufocus").style.visibility="visible";
	$("capability").style.visibility="visible";
	$("bodybackground").style.visibility="visible";
}

</script>
</head>
<body onUnload="exit()" style="background-color:transparent;" scroll="no">
<div class="bodybg" id="bodybackground" ><img id="bodybg" src="images/mymemory/music_bg.jpg" width=1280px height=720px /></div>
<div id="menutiltle"><img src="images/mymemory/if05.png"/></div> <div id="capability"></div>
<div id="menu">
  <div id="menu0" class="menu"></div>
  <div id="menu1" class="menu"></div>
  <div id="menu2" class="menu"></div>
  <div id="menu3" class="menu" ></div>
  <div class="focusbg" id="focusbg"></div>
</div>

<div id="submenu">
	<div id="submenuDiv0" class="submenuDiv" style="top:0px "><div class="subimgDiv"><img id="subimg0" src="images/mymemory/music.png"/></div><div id="submenu0" class="submenuName" ></div></div>
	<div id="submenuDiv1" class="submenuDiv" style="top:58px"><div class="subimgDiv"><img id="subimg1" src="images/mymemory/music.png"/></div><div id="submenu1" class="submenuName" ></div></div>
	<div id="submenuDiv2" class="submenuDiv" style="top:116px"><div class="subimgDiv"><img id="subimg2" src="images/mymemory/music.png"/></div><div id="submenu2" class="submenuName" ></div></div>
	<div id="submenuDiv3" class="submenuDiv" style="top:174px"><div class="subimgDiv"><img id="subimg3" src="images/mymemory/music.png"/></div><div id="submenu3" class="submenuName" ></div></div>
	<div id="submenuDiv4" class="submenuDiv" style="top:232px"><div class="subimgDiv"><img id="subimg4" src="images/mymemory/music.png"/></div><div id="submenu4" class="submenuName" ></div></div>
	<div id="submenuDiv5" class="submenuDiv" style="top:290px"><div class="subimgDiv"><img id="subimg5" src="images/mymemory/music.png"/></div><div id="submenu5" class="submenuName" ></div></div>
	<div id="submenuDiv6" class="submenuDiv" style="top:348px"><div class="subimgDiv"><img id="subimg6" src="images/mymemory/music.png"/></div><div id="submenu6" class="submenuName" ></div></div>
	<div id="submenuDiv7" class="submenuDiv" style="top:406px"><div class="subimgDiv"><img id="subimg7" src="images/mymemory/music.png"/></div><div id="submenu7" class="submenuName" ></div></div>
	<div id="submenufocus"  ></div>	
</div>

<div id="listlength"></div>

<div id="content">
	<div class="head">
  	<table width="100%" height="100%">
    	<tr><td width="400" height="39" id="title" valign="middle"></td>
    	<td id="title1" width="150" valign="middle"></td><td id="title2" valign="middle"></td></tr>
    </table>
  </div>
  <div class="body">
  	<img id="photoin" src="images/mymemory/tm.gif" />
    <img id="photoout" src="images/mymemory/tm.gif" />  </div>
  <div id="jindu">
  	<div id="jindu_left"></div>
    <div id="jindu_mid"></div>
    <div id="jindu_right"></div>
  </div>
</div>

<div id="tips">
	<table width="100%" height="100%">
  	<tr>
      <td id="tip0"></td>
      <td id="tip1">全屏</td>
      <td id="tip2"></td>
      <td id="tip3"></td>
      <td id="tip4"></td>
	  <td id="tip5">选择</td>
	  <td id="tip6"></td>
      <td id="tip7">播放/暂停</td>
    </tr>
  </table>
</div>

<div id="directIconUp"></div>
<div id="directIconDw"></div>
<!--<div id="directIconRg"></div>-->
</body>
</html>
