<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ page import="com.bestv.epg.util.MessageUtil" %>
<%@ page import="com.bestv.epg.ui.BaseUI" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ taglib uri="http://epg.bestv.com/tags" prefix="bestv" %>
<%@ include file="HD_common.jsp" %>
<%@ include file="HD_preFocusElement.jsp" %>
<html>
<head>
<meta name="designer" content="iPanel R&D - meifk" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="page-view-size" content="1280*720" />
<!--<meta http-equiv="Page-Enter" content="blendTrans(Duration=2.0)">-->
<!--<meta http-equiv="Page-Exit" content="blendTrans(Duration=2.0)">-->
<title>portal</title>
<script src="mini.js" type="text/javascript"></script>
<style type="text/css">
*{margin:0; padding:0;}
body{background-color:transparent; width:1280px; height:720px; overflow:hidden;}
#menu{position:absolute; top:0; left:0; width:226px; height:720px; background:url(images/portal/main_bg.png) no-repeat; overflow:hidden; -webkit-transition-duration:1ms;}
#menu div.mn{position:absolute; left:40px; width:150px; height:40px; text-align:center; line-height:40px;}
#menu #menu0{top:30px; font-size:14px; color:#90DEFF ; -webkit-transition-duration:300ms; opacity:0.2}
#menu #menu1{top:80px; font-size:16px; color:#90DEFF ; -webkit-transition-duration:300ms; opacity:0.3;}
#menu #menu2{top:130px; font-size:18px; color:#90DEFF ; -webkit-transition-duration:300ms; opacity:0.4;}
#menu #menu3{top:180px; font-size:20px; color:#90DEFF ; -webkit-transition-duration:300ms; opacity:0.5;}
#menu #menu4{top:230px; font-size:22px; color:#90DEFF ; -webkit-transition-duration:300ms; opacity:0.6;}
#menu #menu5{top:280px; font-size:24px; color:#90DEFF ; -webkit-transition-duration:300ms; opacity:0.7;}
#menu #menu6{top:330px; font-size:26px; color:#90DEFF ; -webkit-transition-duration:300ms; opacity:0.8;}
#menu #menu7{top:380px; font-size:28px; color:#90DEFF ; -webkit-transition-duration:300ms; opacity:0.9;}
#menu #menu8{top:495px; font-size:26px; color:#90DEFF ; -webkit-transition-duration:300ms; opacity:0;}
#menu #menu9{top:616px; font-size:24px; color:#90DEFF ; -webkit-transition-duration:300ms; opacity:0.9;}
#menu #menu10{top:666px; font-size:22px; color:#90DEFF ; -webkit-transition-duration:300ms; opacity:0.8;}
#menu #menu11{top:720px; font-size:20px; color:#90DEFF ; -webkit-transition-duration:300ms;}

#list{position:absolute; top:399px; left:223px; width:1054px; height:239px; background:url(images/portal/sub_bg2.png) no-repeat; -webkit-transition-duration:1ms;}
#list #submenu0{position:absolute; top:25px; left:64px; width:900px; height:156px; -webkit-transition-duration:1ms; opacity:0;}
#list #submenu1{position:absolute; top:25px; left:64px; width:900px; height:156px; -webkit-transition-duration:1ms; opacity:0;}
#list #submenu2{position:absolute; top:25px; left:64px; width:900px; height:156px; -webkit-transition-duration:1ms; opacity:0;}

#list #submenu0 div.submenu0{position:absolute; top:0; left:0; width:120px; height:156px; -webkit-transition-duration:0.3s;}
#list #submenu0 div.submenu0 div.tip0{width:120px; height:33px; text-align:right;}
#list #submenu0 div.submenu0 div.pic0{width:120px; height:99px;}
#list #submenu0 div.submenu0 div.pic0 img{width:120px; height:99px; border-radius:6px; /*-webkit-box-shadow:10px 10px 10px #000; */}
#list #submenu0 div.submenu0 div.name0{width:140px; height:24px; margin-left:-10px; text-align:center; color:white; font-size:18px; line-height:30px;}
#list #submenu0 #list00{left:0;}
#list #submenu0 #list01{left:155px;}
#list #submenu0 #list02{left:310px;}
#list #submenu0 #list03{left:465px;}
#list #submenu0 #list04{left:620px;}
#list #submenu0 #list05{left:775px;}
#list #listfocus0{position:absolute; top:10px; left:-16px; width:151px; height:128px; background:url(images/portal/focus1.png) no-repeat; -webkit-transition-duration:0.3s; opacity:0; z-index:4;}

#list #submenu1 div.submenu1{position:absolute; top:-18px; left:0; width:120px; height:175px; -webkit-transition-duration:0.3s; -webkit-transform:scale(1);}
#list #submenu1 div.submenu1 div.tip1{width:120px; height:33px; text-align:right;}
#list #submenu1 div.submenu1 div.pic1{width:120px; height:118px; padding-left:20px;}
#list #submenu1 div.submenu1 div.pic1 img{width:80px; height:118px; border-radius:6px;  /*-webkit-box-shadow:10px 10px 10px #000;*/ }
#list #submenu1 div.submenu1 div.name1{width:120px; height:24px; text-align:center; color:white; font-size:18px; line-height:30px;}
#list #submenu1 #list10{left:0;}
#list #submenu1 #list11{left:155px;}
#list #submenu1 #list12{left:310px;}
#list #submenu1 #list13{left:465px;}
#list #submenu1 #list14{left:620px;}
#list #submenu1 #list15{left:775px;}
#list #listfocus1{position:absolute; top:-1px; left:5px;  width:126px; height:178px; background:url(images/portal/focus2.png) no-repeat; -webkit-transition-duration:0.3s; opacity:0; z-index:4;}

#list #submenu2 div.submenu2{position:absolute; top:0; left:0; width:120px; height:156px; -webkit-transition-duration:0.3s; -webkit-transform:scale(1);}
#list #submenu2 div.submenu2 div.tip2{width:120px; height:33px; text-align:right;}
#list #submenu2 div.submenu2 div.pic2{width:120px; height:99px;}
#list #submenu2 div.submenu2 div.pic2 img{width:120px; height:99px; border-radius:6px; }
#list #submenu2 div.submenu2 div.name2{width:140px; height:24px; margin-left:-10px; text-align:center; color:white; font-size:18px; line-height:30px;}
#list #submenu2 #list20{left:0;}
#list #submenu2 #list21{left:155px;}
#list #submenu2 #list22{left:310px;}
#list #submenu2 #list23{left:465px;}
#list #submenu2 #list24{left:620px;}
#list #submenu2 #list25{left:775px;}
#list #listfocus2{position:absolute; top:14px; left:-24px; width:166px; height:140px; background:url(images/portal/focus3.png) no-repeat; -webkit-transition-duration:0.3s; opacity:0; z-index:4;}

#disk{position:absolute; top:642px; left:633px; width:647px; height:78px; background:url(images/portal/index_disk_bg.png) no-repeat; -webkit-transition-duration:200ms; opacity:0;}
#disk div.disk_info{position:absolute; top:10px; left:0; width:570px; height:54px; line-height:27px; text-align:right; color:white;}
#disk div.disk_icon{position:absolute; top:12px; left:580px; width:52px; height:52px; background:url(images/portal/disk_icon.png) no-repeat;}

#widgets{position:absolute; top:40px; left:1280; width:120px; height:330px; -webkit-transition-duration:0.3s; }

#focus0{position:absolute;	left:37px;	top:-28px; height:12px;	width:70px; -webkit-transition-duration:250ms; opacity:0;}
#focus1{position:absolute;	left:2px;	top:64px; height:55px;	width:140px; -webkit-transition-duration:250ms; opacity:1;}
#focus2{position:absolute;	left:37px;	top:172px; height:12px;	width:70px; -webkit-transition-duration:250ms; opacity:0;}

#readTips{ -webkit-transition-duration:300ms; -webkit-transform:scale(0); z-index:5;}
</style>

<%
  //System.out.println("this is a test....."+MessageUtil.getMessage(session, "portal_headline_1"));
   ArrayList portal_rightline = new ArrayList();
   ArrayList portal_rightline_typeId = new ArrayList();
  for(int i=1;i<16;i++)
  {
  	String tep_headline=MessageUtil.getMessage(session, "portal_rightline_"+i);
  	String tep_headline_typeId=MessageUtil.getMessage(session, "portal_rightline_"+i+"_typeid");
  	//System.out.println("this is a test"+i+"::::::"+tep_headline);
  	portal_rightline.add(tep_headline); 
  	portal_rightline_typeId.add(tep_headline_typeId);
  	}

  //System.out.println("this is a test..11111111..."+(String)portal_rightline.get(12));
%>

<script type="text/javascript">
if(typeof(iPanel.eventFrame.channelInfo) == "undefined"){
	iPanel.eventFrame.eval("var channelInfo = []");
	reqChannelInfo();
}
function getChannelInfo(__xmlhttp){
	var data = eval(__xmlhttp.responseText);
	iPanel.eventFrame.channelInfo = data;
}
function reqChannelInfo(){
	  var requestUrl = "HD_channelInfo.jsp";
	  var ajaxObj = new AJAX_OBJ(requestUrl, getChannelInfo);
	  ajaxObj.requestData();
}

if(iPanel.eventFrame.chanList.length == 0) iPanel.eventFrame.initChanList();
var recordPos = [{id:0, pos:[]},   //搜索页面
								 {id:1, pos:[]},
								 {id:2, pos:[]},
								 {id:3, pos:[]},
								 {id:4, pos:[]},
								 {id:5, pos:[]},
								 {id:6, pos:[]}];
if(typeof(iPanel.eventFrame.RPT) == "undefined"){
	iPanel.eventFrame.eval("var RPT = " + recordPos);
}

network.setNTPServer("192.168.22.60");
network.NTPUpdate();//同步NTP时间

function eventHandler(obj) {
	switch(obj.code){
		case "KEY_NUMERIC":
			gotoWidgets(obj.value);
			break;
		case "KEY_UP":
			if(openWindowFlag) return;
			if(flag == 1){
				$("listfocus" + listCssType).style.opacity = 0;
				list[listCssType][listPos].style.webkitTransform = "scale(1)";
				$("iconup").src="images/portal/up.png";
				$("icondown").src="images/portal/down.png";
				$("coverDiv").style.backgroundImage = "url(images/portal/2.png)";
				listPos = 0;
				flag = 0;
			} 
			changeMenuFocus(-1);
			break;
		case "KEY_DOWN":
			if(openWindowFlag) return;
			if(flag == 1){
				$("listfocus" + listCssType).style.opacity = 0;
				list[listCssType][listPos].style.webkitTransform = "scale(1)";
				$("iconup").src="images/portal/up.png";
				$("icondown").src="images/portal/down.png";
				$("coverDiv").style.backgroundImage = "url(images/portal/2.png)";
				listPos = 0;
				flag = 0;
			} 
			changeMenuFocus(1);
			break;
		case "KEY_LEFT":
			if(openWindowFlag) return;
			if(flag == 1) {
				if(listPos == 0) changeFlag(0);
				else changeFocus(-1);
			}
			break;
		case "KEY_RIGHT":
			if(openWindowFlag) return;
			if(flag == 0){ if(subMenuFlag) changeFlag(1);}
			else if(flag == 1){
				if(listPos == menu[(initPos+8)%menu.length].submenu.length-1){
					$("listfocus" + listCssType).style.opacity = 0;
					list[listCssType][listPos].style.webkitTransform = "scale(1)";
					$("iconup").src="images/portal/up.png";
					$("icondown").src="images/portal/down.png";
					$("coverDiv").style.backgroundImage = "url(images/portal/2.png)";
					listPos = 0;
					flag = 0;
				}
				else
					changeFocus(1);
			}
			break;
		case "KEY_SELECT":
			if(openWindowFlag){
				openWindowFlag = false;
				$("readTips").style.webkitTransform = "scale(0)";
			}
			else
				doSelect();
			break;
		case "KEY_MENU":
		case "KEY_EXIT":
			if(openWindowFlag){
				openWindowFlag = false;
				$("readTips").style.webkitTransform = "scale(0)";
			}else{
				iPanel.mainFrame.location.href = "ui://index.htm";
			}
			return 0;
			break;
		case "KEY_NUMERIC":
			iPanel.debug(obj.value);
			if(obj.value >= 1 && obj.value <= 3){
				if(widgetData.length > 0 && widgetData[obj.value - 1].url){
					iPanel.debug("widgetData["+(obj.value - 1)+"].url="+widgetData[obj.value - 1].url);
					iPanel.mainFrame.location.href = widgetData[obj.value - 1].url;
				}else{
				}
			}
			return 0;
			break;
		case "EIS_VOD_CONNECT_SUCCESS":
			media.AV.play();
			break;
		case "EIS_DEVICE_USB_INSERT":
			$("disk_progress").innerText = "硬盘正在扫描中...";
			$("disk_content").innerText = "";
			$("disk").style.opacity = 1;
			break;
		case "EIS_DEVICE_USB_INSTALL":
			showDiskInfo();
			break;
		case "EIS_DEVICE_USB_DELETE":
			$("disk").style.opacity = 0;
			break;
	}
	return 0;
}

var mp = new MediaPlayer();
var NativePlayerInstanceID = mp.getNativePlayerInstanceID();
var usbTipsTimeout = -1;
var listCssType = 0; 
var diskText = ["硬盘扫描完成", "共找到128张图片，16个视频，32个音频"];
var menu_ico = [];
var menu = [{id:0, type:3, css:0, name:"<%=(String)portal_rightline.get(13)%>", url:"", ico:"images/portal/kandapian.png",color:"#90DEFF",
																							 submenu:[]},
			{id:1, type:3, css:0, name:"<%=(String)portal_rightline.get(9)%>", url:"HD_vodSingleCategory.jsp?TYPE_ID="+"<%=(String)portal_rightline_typeId.get(9)%>",  ico:"images/portal/shouying.png",color:"#90DEFF",
																							 submenu:[]},
			{id:2, type:3, css:0, name:"<%=(String)portal_rightline.get(10)%>", url:"HD_VodCategory.jsp",  ico:"images/portal/dianbo.png",color:"#90DEFF",
																							 submenu:[]},	
			{id:3, type:3, css:1, name:"<%=(String)portal_rightline.get(11)%>", url:"HD_KanBar.jsp",  ico:"images/portal/kanba.png",color:"#90DEFF",
																							 submenu:[]},																 
			{id:4, type:3, css:0, name:"<%=(String)portal_rightline.get(12)%>", url:"HD_catchupPortal.jsp",  ico:"images/portal/huikan.png", color:"#90DEFF",
																							 submenu:[]},
			{id:5, type:2, css:0, name:"<%=(String)portal_rightline.get(7)%>", url:"HD_channelPortal.jsp",  ico:"images/portal/zbpindao.png",color:"#90DEFF",
																									 submenu:[]},
			{id:6, type:2, css:0, name:"<%=(String)portal_rightline.get(6)%>", url:"",  ico:"images/portal/gqyule.png",color:"#90DEFF",
																									 submenu:[]},
			{id:7, type:2, css:0, name:"<%=(String)portal_rightline.get(8)%>", url:"hd_channel.htm", ico:"images/portal/gqpingdao.png",color:"#90DEFF",
																									 submenu:[]},
			{id:8, type:0, css:0, name:"<%=(String)portal_rightline.get(0)%>", url:"", ico:"images/portal/tuijian.png",color:"#90DEFF",
																									 submenu:[]},
			{id:9, type:1, css:2, name:"<%=(String)portal_rightline.get(1)%>", url:"",  ico:"images/portal/myduqu.png",color:"#90DEFF",
																									 submenu:[]},
			{id:10, type:1, css:2, name:"<%=(String)portal_rightline.get(2)%>", url:"myPhoto.htm",  ico:"images/portal/mycunchu.png",color:"#90DEFF",
																									 submenu:[{id:0, name:"这是什么鱼儿", pic:"http://10.50.103.10:33200/EPG/MediaService/hwhd/images/storage/photo/pic1.jpg", url:"myPhoto.htm"}, 
				 {id:1, name:"像贝壳儿", pic:"http://10.50.103.10:33200/EPG/MediaService/hwhd/images/storage/photo/pic8.jpg", url:"myPhoto.htm"},
				 {id:2, name:"东方购物", pic:"http://10.50.103.10:33200/EPG/MediaService/hwhd/images/storage/video/video.png", url:"myPhoto.htm"},
				 {id:3, name:"东方购物", pic:"http://10.50.103.10:33200/EPG/MediaService/hwhd/images/storage/video/video.png", url:"myPhoto.htm"},
				 {id:4, name:"可惜不是你", pic:"http://10.50.103.10:33200/EPG/MediaService/hwhd/images/storage/audio/audio.jpg", url:"myPhoto.htm"},
				 {id:5, name:"偏爱", pic:"http://10.50.103.10:33200/EPG/MediaService/hwhd/images/storage/audio/audio.jpg", url:"myPhoto.htm"}]},
			{id:11, type:1, css:2, name:"<%=(String)portal_rightline.get(3)%>", url:"myPhoto.htm",  ico:"images/portal/myfav.png",color:"#90DEFF",
																									 submenu:[]},
			{id:12, type:1, css:2, name:"<%=(String)portal_rightline.get(4)%>", url:"HD_search.jsp?TYPE_ID=00000100000000090000000000001048",  ico:"images/portal/search.png",color:"#90DEFF",
																									 submenu:[]},	
			{id:13, type:1, css:2, name:"<%=(String)portal_rightline.get(5)%>", url:"myPhoto.htm",  ico:"images/portal/set.png",color:"#90DEFF",
																									 submenu:[]},
			{id:14, type:1, css:2, name:"<%=(String)portal_rightline.get(14)%>", url:"myPhoto.htm",  ico:"images/portal/shibo.png",color:"#90DEFF",
																									 submenu:[]}];
//var widgetData = [/*{id:0,url:"",pic:""},{id:1,url:"",pic:""},{id:2,url:"",pic:""}*/];
var widgetData = [];
var flag = 0;

var subMenu;
var listPos = 0;
var subMenuDiv = [];
var list = [];
var list_left = [0, 155, 310, 465, 620, 775];
var list_tip = [];
var list_pic = [];
var list_name = [];
var list_focus_pos = [[19, -15], [-1, 5], [14, -24]];
var list_focus_bg = ["focus1.png", "focus2.png", "focus3.png"];
var listSlip;
var list_scale_rate = [1.175, 1.175, 1.175];

var div_arr = ["menu0","menu1","menu2","menu3","menu4","menu5","menu6","menu7","menu8","menu9","menu10","menu11"];
var focus_arr = ["focus0","focus1","focus2"];
var mainPos = 8;	//记住焦点的位置
var currPos = 0;	//记当前的位置
var recodePos = mainPos;	//记住mainPos没变化之前的位置	
var typeSize = menu.length;
var picPos = 7;	//记图片开始位置
var	currPicPos = 8;//记图片当前的位置
var focusPos = 0;//记录焦点处第一个位置
var focusMainPos = 1;

var initPos = 0;//记录背景字的移动初始位置
var subMenuTimeout = -1;
var keyFlag = false;
var openWindowFlag = false;

function getSubMenuData(da){
	var te = da;
	eval("var data = " + te);
	for(var i=0; i<menu.length; i++){
		if(i!=10) menu[i].submenu = data[i];
		iPanel.debug("wangzhib menu["+i+"].submenu.length = " + menu[i].submenu.length);
	}
	//$("test").innerText = te.length;
	showSubMenu();
}
function getWidgetData(__xmlhttp){
	widgetData = eval(__xmlhttp.responseText);
	showWidgetArea();
}
function ajaxRequest(){
	var url = "HD_Category_data.jsp";
	var ajaxObj = new AJAX("GET", url, true, getSubMenuData);
	ajaxObj.send();
}
function ajaxRequestWidget(){
	var requestUrl = "HD_Category_data.jsp?flag=3";
	var ajaxObj = new AJAX_OBJ(requestUrl, getWidgetData);
	ajaxObj.requestData();
}
function init() {
	//$("test").innerText = myArray[0] + "/" + backUrl;
	playAV();
	ajaxRequest();
	ajaxRequestWidget();
	initPage();
	window.setTimeout("showSubMenu()", 700);
	//playVideo();
}
function playAV() {
	mp.setVideoDisplayMode(1);
	mp.refreshVideoDisplay();
	mp.setSingleOrPlaylistMode(0);
	mp.joinChannel(16);
}
function showWidgetArea(){
	for(var i=0; i<widgetData.length; i++){
		$("widgetspic"+i).src=widgetData[i].pic;
		$("widgetsname"+i).innerText = widgetData[i].name;
	}
	///if(widgetData.length > 0)
	setTimeout("showWidgets()", 500);
}
function gotoWidgets(n) {
	if(n > 0 && n < 4)
		window.location = widgetData[n-1].url;
}

function initPage() {
	for(var i=0; i<3; i++){
		subMenuDiv[i] = $("submenu" + i);
		list[i] = [];
		list_tip[i] = [];
		list_pic[i] = [];
		list_name[i] = [];
		for(var j=0; j<6; j++) {
			list[i][j] = $("list" + i + j);
			list_tip[i][j] = $("tip" + i + j);
			list_pic[i][j] = $("pic" + i + j);
			list_name[i][j] = $("name" + i + j);
		}
	}
}
function showDiskInfo() {
	$("disk_progress").innerText = diskText[0];
	$("disk_content").innerText = diskText[1];
}
function showWidgets() {	$("widgets").style.left = "1060px";}
function changeFlag(n) {
	iPanel.debug("mainPos = "+mainPos+",initPos="+initPos);
	iPanel.debug("menu[mainPos].submenu.length = "+menu[mainPos].submenu.length);
	if(menu[(initPos+8)%menu.length].submenu.length > 0){
		flag = n;
		if(n==0){
			$("listfocus" + listCssType).style.opacity = 0;
			list[listCssType][0].style.webkitTransform = "scale(1)";
			//$("iconright").style.webkitTransform = "rotateY(0deg)";
			$("iconup").src="images/portal/up.png";
			$("icondown").src="images/portal/down.png";
			$("coverDiv").style.backgroundImage = "url(images/portal/2.png)";
			
		} else {
			$("listfocus" + listCssType).style.webkitTransitionDuration = "0ms";
			listSlip = new showSlip("listfocus" + listCssType, list_focus_pos[listCssType][0], list_focus_pos[listCssType][1]);

			setTimeout('$("listfocus" + listCssType).style.opacity = 1',10);
			$("iconup").src="images/portal/up1.png";
			$("icondown").src="images/portal/down1.png";
			$("coverDiv").style.backgroundImage = "url(images/portal/1.png)";
			//$("iconright").style.webkitTransform = "rotateY(180deg)";
			changeFocus(0);
		}
	}
}
var subMenuFlag = true;//表示可以向右移动的标识
var setDurationFlag = false;
function changeMenuFocus(num) {
	if(!keyFlag){
		keyFlag = true;
		subMenuFlag = false;
		setTimeout("keyFlag = false;",150);
		
		var len  = div_arr.length;
		initPos = ((initPos + num)%typeSize + typeSize)%typeSize;	//记数据个数的初始值位置
		picPos = ((picPos + num)%typeSize + typeSize)%typeSize;	//记焦点位置
		currPicPos = ((currPicPos + num)%typeSize + typeSize)%typeSize;	//记焦点位置
		recodePos = mainPos;	//用recodePos 记住mainPos交换之前的位置
		currPos = ((currPos + num)%len + len)%len;	//记当前位置	
		mainPos = ((mainPos + num)%len + len)%len;	//记焦点位置
		focusPos = ((focusPos + num)%3 + 3)%3;	//记当前位置	
		focusMainPos = ((focusMainPos + num)%3 + 3)%3;	//记焦点位置
		if(num < 0){	//down
			$(div_arr[currPos]).style.webkitTransitionDuration = "0s";	//先把第一个元素duration 设成0，改变它的position,这样CSS就不会动
			$(div_arr[currPos]).style.top = "-40px";
			$(div_arr[currPos]).innerText = menu[initPos%typeSize].name;
			$(div_arr[currPos]).style.color = menu[initPos%typeSize].color;
			$(div_arr[currPos]).style.fontSize = "14px";
			setTimeout("changePre()", 10);								//过10MS 之后把它的duration 重新设成 1S
			for(var i = currPos+1; i<currPos + len; i++){		//改变它的left 值
				$(div_arr[i%len]).style.top = $(div_arr[(i+1)%len]).style.top;
				$(div_arr[i%len]).style.fontSize = $(div_arr[(i+1)%len]).style.fontSize;
				$(div_arr[i%len]).style.opacity = $(div_arr[(i+1)%len]).style.opacity/100;
			}
			$(div_arr[(currPos + 11)%len]).style.top = "720px";
			$(div_arr[(currPos + 11)%len]).style.opacity = "0.5";
			$(div_arr[(currPos + 11)%len]).style.fontSize = "20px";
			
		}else{	//up
			$(div_arr[(currPos + 10)%len]).style.webkitTransitionDuration = "0s";
			$(div_arr[(currPos + 10)%len]).style.top = "720px";
			$(div_arr[(currPos + 10)%len]).innerText = menu[(initPos + 10)%typeSize].name;
			$(div_arr[(currPos + 10)%len]).style.color = menu[(initPos + 10)%typeSize].color;
			$(div_arr[(currPos + 10)%len]).style.fontSize = "22px";
			setTimeout("changeNext()", 10);
			
			for(var i = currPos + 9; i > currPos - 1; i--){
				$(div_arr[i%len]).style.top = $(div_arr[(i-1+len)%len]).style.top;
				$(div_arr[i%len]).style.fontSize = $(div_arr[(i-1+len)%len]).style.fontSize;
				$(div_arr[i%len]).style.opacity = $(div_arr[(i-1+len)%len]).style.opacity/100;
			}
			$(div_arr[(currPos - 1+len)%len]).style.top = "-40px";
			$(div_arr[(currPos - 1+len)%len]).style.opacity = "0.1";
			$(div_arr[(currPos - 1+len)%len]).style.fontSize = "12px";
		}
		changeFocusPos(num);
		clearTimeout(subMenuTimeout);
		subMenuTimeout = window.setTimeout("clearList();showSubMenu();", 500);
	}
}
function changePre(){
	$(div_arr[currPos]).style.webkitTransitionDuration = "300ms";
	$(div_arr[currPos]).style.top = "30px";
	$(div_arr[currPos]).style.opacity = "0.2";
}

function changeNext(){
	var len = div_arr.length;
	$(div_arr[(currPos + 10)%len]).style.webkitTransitionDuration = "300ms";
	$(div_arr[(currPos + 10)%len]).style.top = "666px";
	$(div_arr[(currPos + 10)%len]).style.opacity = "0.8";
}
function changeFocusPos(num){
	if(num < 0){
		for(var i = focusPos+1; i<focusPos + 3; i++){		//改变它的left 值
				$(focus_arr[i%3]).style.webkitTransitionDuration = "250ms";
				$(focus_arr[i%3]).style.top = $(focus_arr[(i+1)%3]).style.top;
				$(focus_arr[i%3]).style.left = $(focus_arr[(i+1)%3]).style.left;
				$(focus_arr[i%3]).style.width = $(focus_arr[(i+1)%3]).style.width;
				$(focus_arr[i%3]).style.height = $(focus_arr[(i+1)%3]).style.height;
				$(focus_arr[i%3]).style.opacity = $(focus_arr[(i+1)%3]).style.opacity/100;
		}
			
		$(focus_arr[focusPos]).style.webkitTransitionDuration = "0s";
		$(focus_arr[focusPos]).style.top = "-28px";
		$(focus_arr[focusPos]).style.opacity = "0";
		setTimeout("changeFocusFirstPic()",10);	
	}
	else{
		for(var i = focusPos + 1; i > focusPos - 1; i--){
			$(focus_arr[i%3]).style.top = $(focus_arr[(i-1+3)%3]).style.top;
			$(focus_arr[i%3]).style.left = $(focus_arr[(i-1+3)%3]).style.left;
			$(focus_arr[i%3]).style.width = $(focus_arr[(i-1+3)%3]).style.width;
			$(focus_arr[i%3]).style.height = $(focus_arr[(i-1+3)%3]).style.height;
			$(focus_arr[i%3]).style.opacity = $(focus_arr[(i-1+3)%3]).style.opacity/100;
		}
		$(focus_arr[(focusPos + 2)%3]).style.webkitTransitionDuration = "0s";
		$(focus_arr[(focusPos + 2)%3]).style.top = "172px";
		$(focus_arr[(focusPos + 2)%3]).style.opacity = "0";
		setTimeout("changeFocusEndPic()", 10);
	}
}
function changeFocusFirstPic(){
	$(focus_arr[focusPos]).src=menu[picPos].ico;
	$(focus_arr[focusPos]).style.webkitTransitionDuration = "250ms";
}
function changeFocusEndPic(){
	$(focus_arr[(focusPos + 2)%3]).src=menu[(picPos + 2)%typeSize].ico;
	$(focus_arr[(focusPos + 2)%3]).style.webkitTransitionDuration = "250ms";
}
function showSubMenu() {
		subMenuFlag = true;
		subMenu = menu[(initPos+8)%menu.length].submenu;
		listCssType = menu[(initPos+8)%menu.length].css;
		if(subMenu.length == 0)
			clearList();
		else {
			for(var i=0; i<6; i++){
				if(menu[(initPos+8)%menu.length].css == 2)
					list_tip[listCssType][i].src="images/portal/tm.gif";
				else
					list_tip[listCssType][i].src=subMenu[i].tip;
				list_pic[listCssType][i].src=subMenu[i].pic;
				list_name[listCssType][i].innerText = subMenu[i].name.substr(0, 7);
			}
			$("listfocus" + listCssType).style.backgroundImage = "url(images/portal/" +list_focus_bg[listCssType] + ")";
			$("listfocus" + listCssType).style.opacity = 0;
			subMenuDiv[listCssType].style.opacity = 1;
			listSlip = new showSlip("listfocus" + listCssType, list_focus_pos[listCssType][0], list_focus_pos[listCssType][1]);
		}
}
function rotateImg(obj, delay) {
	this.obj = obj || [];
	this.length = obj.length;
	this.delay = delay || 100;
	this.times = 0;
	var self = this;
	this.act = function (deg) {
		var deg = deg || 0;
		if(this.times < this.length) {
			obj[this.times].style.webkitTransform = "rotateY(" + deg + "deg)";
			this.times ++ ;
			window.setTimeout(function(){self.act(deg);}, this.delay);
		}
	}
}
function clearList() {
	for(var i=0; i<6; i++){
		list_tip[listCssType][i].src="images/portal/tm.gif";
		list_pic[listCssType][i].src="images/portal/tm.gif";
		list_name[listCssType][i].innerText = "";
	}
}
function changeFocus(n){
	if((n>0&&listPos!=5)||(n<0&&listPos!=0)) list[listCssType][listPos].style.webkitTransform = "scale(1)";
	listPos += n;
	if(listPos < 0) {listPos = 0; return;}
	if(listPos > 5) {listPos = 5; return;}
	listSlip.cssSlip(0, 155 * n, 0.2);
	var scaleValue = list_scale_rate[listCssType];
	list[listCssType][listPos].style.webkitTransform = "scale(" + scaleValue + ")";
	
}
function doSelect() {
	if(flag == 0){
		var url = menu[(initPos+8)%menu.length].url;
		if(url){
			iPanel.mainFrame.location.href = "HD_saveCurrFocus.jsp?currFocus=" + "dogcai,meifengkui" + "&url=" + url;
		}else{
			openWindowFlag = true;
			$("readTips").style.webkitTransform = "scale(1)";	
		}
	}else{
		var enterType = menu[(initPos+8)%menu.length].css;
		subMenu = menu[(initPos+8)%menu.length].submenu;
		id = menu[(initPos+8)%menu.length].id;
		if(id == 0 || id == 1 || id == 2 || id == 3 || id == 4 || id == 5 || id == 8 || id == 10){
			if(id == 5) window.location = "liveTV.htm";
			else window.location = subMenu[listPos].url;
		}
	}
}
function exitPage(){	mp.leaveChannel();}
</script>
</head>
<body topmargin="0" leftmargin="0" onLoad="init()" onUnload="exitPage()">
<div id="menu">
 <div id="menu0" class="mn">看大片</div>
 <div id="menu1" class="mn">首映专区</div>
 <div id="menu2" class="mn">点播片库</div>
 <div id="menu3" class="mn">精彩看吧</div>
 <div id="menu4" class="mn">回看频道</div>
 <div id="menu5" class="mn">直播频道</div>
 <div id="menu6" class="mn">高清娱乐</div>
 <div id="menu7" class="mn">高清频道</div>
 <div id="menu8" class="mn">今日推荐</div>
 <div id="menu9" class="mn">我的读取</div>
 <div id="menu10" class="mn">我的存储</div>
 <div id="menu11" class="mn">我的收藏</div>
</div>

<div id="coverDiv" style="position:absolute; left:0px; top:433px; height:172px; width:226px; background-image:url(images/portal/2.png); -webkit-transition-duration:1ms; z-index:4;"></div>
<div id="menuDiv1" style="position:absolute; left:43px; top:433px; height:172px; width:144px; overflow:hidden; -webkit-transition-duration:1ms; z-index:5;">
<img id="focus0" src="images/portal/index_menu1.png" width="140" height="55" />
<img id="focus1" src="images/portal/index_menu0.png" width="140" height="55" />
<img id="focus2" src="images/portal/index_menu9.png" width="140" height="55" />
</div>
<div id="list">
 <div id="submenu0">
  <div id="list00" class="submenu0">
   <div class="tip0"><img id="tip00" src="images/portal/tm.gif" /></div>
   <div class="pic0"><img id="pic00" src="images/portal/tm.gif" /></div>
   <div class="name0" id="name00"></div>
  </div>
  <div id="list01" class="submenu0">
   <div class="tip0"><img id="tip01" src="images/portal/tm.gif" /></div>
   <div class="pic0"><img id="pic01" src="images/portal/tm.gif" /></div>
   <div class="name0" id="name01"></div>
  </div>
  <div id="list02" class="submenu0">
   <div class="tip0"><img id="tip02" src="images/portal/tm.gif" /></div>
   <div class="pic0"><img id="pic02" src="images/portal/tm.gif" /></div>
   <div class="name0" id="name02"></div>
  </div>
  <div id="list03" class="submenu0">
   <div class="tip0"><img id="tip03" src="images/portal/tm.gif" /></div>
   <div class="pic0"><img id="pic03" src="images/portal/tm.gif" /></div>
   <div class="name0" id="name03"></div>
  </div>
  <div id="list04" class="submenu0">
   <div class="tip0"><img id="tip04" src="images/portal/tm.gif" /></div>
   <div class="pic0"><img id="pic04" src="images/portal/tm.gif" /></div>
   <div class="name0" id="name04"></div>
  </div>
  <div id="list05" class="submenu0">
   <div class="tip0"><img id="tip05" src="images/portal/tm.gif" /></div>
   <div class="pic0"><img id="pic05" src="images/portal/tm.gif" /></div>
   <div class="name0" id="name05"></div>
  </div>
  <div id="listfocus0"></div>
 </div>
 <div id="submenu1">
  <div id="list10" class="submenu1">
   <div class="tip1"><img id="tip10" src="images/portal/tm.gif" /></div>
   <div class="pic1"><img id="pic10" src="images/portal/tm.gif" /></div>
   <div class="name1" id="name10"></div>
  </div>
  <div id="list11" class="submenu1">
   <div class="tip1"><img id="tip11" src="images/portal/tm.gif" /></div>
   <div class="pic1"><img id="pic11" src="images/portal/tm.gif" /></div>
   <div class="name1" id="name11"></div>
  </div>
  <div id="list12" class="submenu1">
   <div class="tip1"><img id="tip12" src="images/portal/tm.gif" /></div>
   <div class="pic1"><img id="pic12" src="images/portal/tm.gif" /></div>
   <div class="name1" id="name12"></div>
  </div>
  <div id="list13" class="submenu1">
   <div class="tip1"><img id="tip13" src="images/portal/tm.gif" /></div>
   <div class="pic1"><img id="pic13" src="images/portal/tm.gif" /></div>
   <div class="name1" id="name13"></div>
  </div>
  <div id="list14" class="submenu1">
   <div class="tip1"><img id="tip14" src="images/portal/tm.gif" /></div>
   <div class="pic1"><img id="pic14" src="images/portal/tm.gif" /></div>
   <div class="name1" id="name14"></div>
  </div>
  <div id="list15" class="submenu1">
   <div class="tip1"><img id="tip15" src="images/portal/tm.gif" /></div>
   <div class="pic1"><img id="pic15" src="images/portal/tm.gif" /></div>
   <div class="name1" id="name15"></div>
  </div>
  <div id="listfocus1"></div>
 </div>
 <div id="submenu2">
  <div id="list20" class="submenu2">
   <div class="tip2"><img id="tip20" src="images/portal/tm.gif" /></div>
   <div class="pic2"><img id="pic20" src="images/portal/tm.gif" /></div>
   <div class="name2" id="name20"></div>
  </div>
  <div id="list21" class="submenu2">
   <div class="tip2"><img id="tip21" src="images/portal/tm.gif" /></div>
   <div class="pic2"><img id="pic21" src="images/portal/tm.gif" /></div>
   <div class="name2" id="name21"></div>
  </div>
  <div id="list22" class="submenu2">
   <div class="tip2"><img id="tip22" src="images/portal/tm.gif" /></div>
   <div class="pic2"><img id="pic22" src="images/portal/tm.gif" /></div>
   <div class="name2" id="name22"></div>
  </div>
  <div id="list23" class="submenu2">
   <div class="tip2"><img id="tip23" src="images/portal/tm.gif" /></div>
   <div class="pic2"><img id="pic23" src="images/portal/tm.gif" /></div>
   <div class="name2" id="name23"></div>
  </div>
  <div id="list24" class="submenu2">
   <div class="tip2"><img id="tip24" src="images/portal/tm.gif" /></div>
   <div class="pic2"><img id="pic24" src="images/portal/tm.gif" /></div>
   <div class="name2" id="name24"></div>
  </div>
  <div id="list25" class="submenu2">
   <div class="tip2"><img id="tip25" src="images/portal/tm.gif" /></div>
   <div class="pic2"><img id="pic25" src="images/portal/tm.gif" /></div>
   <div class="name2" id="name25"></div>
  </div>
  <div id="listfocus2"></div>
 </div>
</div>
<div id="disk">
 <div class="disk_info">
  <p id="disk_progress"></p>
  <p id="disk_content"></p>
 </div>
 <div class="disk_icon"></div>
</div>
<div id="widgets">
  <div id="widgets0" style="position:absolute; top:-5px; left:-7px; width:133px; height:110px; background:url(images/portal/widgets_bg.png) no-repeat">
  	<div style="position:absolute; top:5px; left:7px; width:120px; height:99px"><img src="" width="120" height="99" id="widgetspic0"  /></div>
    <div style="position:absolute; top:4px; left:4px; width:27px; height:27px"><img src="images/portal/nu1.png" width="27" height="27" /></div>
    <div id="widgetsname0" style="position:absolute; top:80px; height:30px; text-align:center; line-height:30px; overflow:hidden; color:white; background:url(images/portal/widgets_wzbg.png) no-repeat center"></div>
  </div>
  <div id="widgets1" style="position:absolute; top:130px; left:-7px; width:133px; height:110px; background:url(images/portal/widgets_bg.png) no-repeat"">
  	<div style="position:absolute; top:5px; left:7px; width:120px; height:99px"><img src="" width="120" height="99" id="widgetspic1"  /></div>
    <div style="position:absolute; top:4px; left:4px; width:27px; height:27px"><img src="images/portal/nu2.png" width="27" height="27" /></div>
    <div id="widgetsname1" style="position:absolute; top:80px; height:30px; text-align:center; line-height:30px; overflow:hidden; color:white;background:url(images/portal/widgets_wzbg.png) no-repeat center"></div>
  </div>
  <div id="widgets2" style="position:absolute; top:265px; left:-7px; width:133px; height:110px; background:url(images/portal/widgets_bg.png) no-repeat"">
  	<div style="position:absolute; top:5px; left:7px; width:120px; height:99px"><img src="" width="120" height="99" id="widgetspic2"  /></div>
    <div style="position:absolute; top:4px; left:4px; width:27px; height:27px"><img src="images/portal/nu3.png" width="27" height="27" /></div>
    <div id="widgetsname2" style="position:absolute; top:80px; height:30px; text-align:center; line-height:30px; overflow:hidden; color:white;background:url(images/portal/widgets_wzbg.png) no-repeat center"></div>
  </div>
</div>
<img id="iconup" style="position:absolute; top:423px; left:90px; -webkit-transition-duration:1ms; z-index:8;" src="images/portal/up.png" width="55" height="40"/>
<img id="icondown" style="position:absolute; top:572px; left:90px; -webkit-transition-duration:1ms; z-index:8;" src="images/portal/down.png" width="55" height="40"/>
<img id="iconright" style="position:absolute; top:489px; left:187px; -webkit-transition-duration:1ms; z-index:8;" src="images/portal/right1.png" width="40" height="55"/>

<div style=" position:absolute; top:660px; left:1140px; width:140px; height:55px; -webkit-transition-duration:1ms; -webkit-transform:scale(0); opacity:0; visibility:hidden;">
<img src="images/portal/index_menu0.png" width="140" height="55" style=" position:absolute; top:0px; left:0px;"/>
<img src="images/portal/index_menu1.png" width="140" height="55" style=" position:absolute; top:0px; left:0px;"/>
<img src="images/portal/index_menu2.png" width="140" height="55" style=" position:absolute; top:0px; left:0px;"/>
<img src="images/portal/index_menu3.png" width="140" height="55" style=" position:absolute; top:0px; left:0px;"/>
<img src="images/portal/index_menu4.png" width="140" height="55" style=" position:absolute; top:0px; left:0px;"/>
<img src="images/portal/index_menu5.png" width="140" height="55" style=" position:absolute; top:0px; left:0px;"/>
<img src="images/portal/index_menu6.png" width="140" height="55" style=" position:absolute; top:0px; left:0px;"/>
<img src="images/portal/index_menu7.png" width="140" height="55" style=" position:absolute; top:0px; left:0px;"/>
<img src="images/portal/index_menu8.png" width="140" height="55" style=" position:absolute; top:0px; left:0px;"/>
<img src="images/portal/index_menu9.png" width="140" height="55" style=" position:absolute; top:0px; left:0px;"/>
<img src="images/portal/index_menu10.png" width="140" height="55" style=" position:absolute; top:0px; left:0px;"/>
<img src="images/portal/wdcc1.png" width="140" height="55" style=" position:absolute; top:0px; left:0px;"/>
</div>
<div id="readTips" style="position:absolute; left:370px; top:208px; height:233px; width:568px; background-image: url(images/portal/tck_bg.png); text-align:center;">
    <table width="430" border="0" cellspacing="0" cellpadding="0" style=" color:#FFF">
      <tr>
        <td height="120" align="center" style="font-size:36px;" id="content">栏目正在建设中...</td>
      </tr>
      <tr>
        <td width="215" height="100" align="center" background="images/portal/button0_bg1.gif" style="background-position:center; background-repeat:no-repeat; font-size:24px;">确定</td>
      </tr>
    </table>
</div>

<!--<div id="test" style="position:absolute; top:200px; left:500px; background-color:white; color:blue; width:200px; height:100px; font-size:32px;"></div>-->
</body>
</html>
