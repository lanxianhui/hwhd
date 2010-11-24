<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ include file="HD_preFocusElement.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page import="com.bestv.epg.util.MessageUtil" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="java.util.*" %>
<head>
	<meta name="designer" content="hwhd" />
	<meta http-equiv="Page-Enter" content="blendTrans(Duration=0.0)">
	<meta name="page-view-size" content="1280*720" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>upgrade notice</title>
<script src="js/mini.js" type="text/javascript"></script>

<style type="text/css">
body {
	background-color:transparent;
	width:1280px;
	height:720px;
	left:0px;
	top:0px;
	margin-left:0px;
	margin-top:0px;
	overflow:hidden;
	background:url("images/default/common.jpg") no-repeat;
}

#title {
	position:absolute;
	top:40px; 
	height:30px; 
	font-size:30px; 
	width:626px; 
	left:107px;
	color:#FFFFFF;
}

#logo {
	position:absolute;
	top:31px; 
	left:49px; 
	width:48px; 
	height:48px; 
	background:url("images/summary/logo.png") no-repeat;
}

#main {
	position:absolute; 
	top: 172px;
	left: 225px;
	width:830px; 
	height:400px;
}

.line1{	
	position:absolute;
	width:176px;
	height:176px;
	top: 5px;
}

.line2{	
	position:absolute;
	width:176px;
	height:176px;
	top: 200px;
}
#focus  {position:absolute;left:0px;top:0px;width:190px;height:190px;background:url("images/summary/focus.png") no-repeat; -webkit-transition-duration:200ms;}
#t0,#t4 {left:10px;}
#t1,#t5 {left:231px;}
#t2,#t6 {left:446px;}
#t3,#t7 {left:655px;}
</style>

<script type="text/javascript">

var total 				= null;
var totalPage 			= null;
var nowPage 			= null;
var subPos 				= 0 ;
var shown 				= 0;

var tObj 				= [];
var channelNum 			= 8;
var main				= null;
var focus				= null;
var menu				= [];
var m					= 0;
function init() {
	<%
	    String summary_count=MessageUtil.getMessage(session, "summary_count");
	    ArrayList summary_url = new ArrayList();
	    ArrayList summary_img = new ArrayList();
	 
          
 if ((null == (summary_count)) || (("".equals(summary_count))) || ("null"==summary_count))
	{
		summary_count	=	"0";
	}

		for(int i=0;i<(Integer.parseInt(summary_count));i++)
		{
			    String tep_summary_url=MessageUtil.getMessage(session, "summary_"+(i+1)+"_url");
			    String tep_summary_img=MessageUtil.getMessage(session, "summary_"+(i+1)+"_img");
	%>
			var temp		=	{};
			temp.TURNURL	=	"<%=tep_summary_url%>";
			temp.ITEMICON	=	"<%=tep_summary_img%>";
			menu[m++]		=	temp;
	<%}%>
	main				=	$("main");
	focus				=	$("focus");
	var number			=	Math.min(channelNum,menu.length);
	for(var i = 0; i < number ; i++){
		tObj[i] =  $("t" + i);
		tObj[i].style.backgroundImage 	= 	"url(" + menu[i].ITEMICON +")";   
	}
	
  	total 		= menu.length;
  	totalPage 	= 1+Math.floor((total-1)/channelNum);
  	if (myArray[0]==null) {
  		nowPage 	= 1;
  	}else {
  		nowPage 	= 	parseInt(myArray[0]);
  		subPos		=	parseInt(myArray[1]);
  	}
	
	shown 		= (nowPage-1)*channelNum;
	limit 		= channelNum;
	selectItem(subPos);
}

//选中功能项目
function selectItem(position)
{
  	for(var i=0 ; i < channelNum ; i++){
  		if( i == position ){
  			focus.style.left	=	tObj[position].style.left - 8;
  			focus.style.top		=	tObj[position].style.top - 6;
  		}
  	}
}

function doSelect() {
	if (menu[shown+subPos].TURNURL.indexOf("setting")>-1) {
		window.location = Utility.startLocalCfg();
	} else if (menu[shown+subPos].TURNURL.indexOf("HD_MyMemory.jsp")>-1) {
		  if(iPanel.eventFrame.hasUSB==false||typeof(iPanel.eventFrame.hasUSB)=="undefined"){
				  document.location="HD_saveCurrFocus.jsp?currFocus="+nowPage+","+subPos+"&url=HD_infoDisplay.jsp?ERROR_ID=150";
				  return;			
			  }
			  if(iPanel.eventFrame.USBIsReady==false||typeof(iPanel.eventFrame.USBIsReady)=="undefined"){
				  if(iPanel.eventFrame.hasUSB==true){
					  document.location="HD_saveCurrFocus.jsp?currFocus="+nowPage+","+subPos+"&url=HD_infoDisplay.jsp?ERROR_ID=151";
				  }			
				  return;
			  }
		document.location="HD_saveCurrFocus.jsp?currFocus="+nowPage+","+subPos+"&url=" + menu[shown+subPos].TURNURL;	  
	} else {
		document.location="HD_saveCurrFocus.jsp?currFocus="+nowPage+","+subPos+"&url=" + menu[shown+subPos].TURNURL;
	}
}

//移动光标
function move(num) {
	subPos = subPos + num;
	
	var temp	=	 Math.min(channelNum,(total-shown));
	
	if(subPos < 0) {
		subPos =0;
	} else if (subPos >= temp) 
	{
		subPos	=	temp-1;
	}
	selectItem(subPos);
}

//翻页
function turnPage(num) {
	nowPage 	= nowPage + num;
	
	if (nowPage == 0 ) {
		nowPage = totalPage - 1;
	} 
	if (nowPage == totalPage ) {
		nowPage = 0;
	}
	shown 		= 	(nowPage-1)*channelNum;
	limit 		= 	channelNum;
	subPos		=	0;
	selectItem(subPos);
}

function eventHandler(obj) {
	switch(obj.code){
		case "KEY_UP":
			move(-4);
			break;
		case "KEY_DOWN":
			move(4);
			break;
		case "KEY_SELECT":
			doSelect();
			break;
		case "KEY_RIGHT" :
			move(1);
			break;
		case "KEY_LEFT" :
			move(-1);
			break;
		case "KEY_PAGE_UP":
			turnPage(-1);
			break;
		case "KEY_PAGE_DOWN":
			turnPage(1);
		    break;
		case "KEY_EXIT":
			//exit();
			window.location = backUrl;
			return 0;
			break;
		case "KEY_BACK":
			iPanel.debug("xinsw----back");
		  	//exit();
		  	window.location = backUrl;
			break;
	}
}
</script>
</head>
<body onload="init();" scroll="no">
<div id="logo"></div>
<div id="title">功能</div>

<div id="main">
	<div id="focus"></div>
	<div class="line1" id="t0"></div>
	<div class="line1" id="t1"></div>
	<div class="line1" id="t2"></div>
	<div class="line1" id="t3"></div>
	<div class="line2" id="t4"></div>
	<div class="line2" id="t5"></div>
	<div class="line2" id="t6"></div>
	<div class="line2" id="t7"></div>
</div>
</body>
</html> 