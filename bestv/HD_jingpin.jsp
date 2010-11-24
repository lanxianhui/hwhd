<%@ include file="HD_preFocusElement.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page import="com.bestv.epg.util.MessageUtil" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="java.util.*" %>
<%@ include file="HD_common.jsp" %>
<%
    String jingpin_count=MessageUtil.getMessage(session, "jingpin_count");
    ArrayList jinpin_name = new ArrayList();
    ArrayList jinpin_url = new ArrayList();
    ArrayList jinpin_imgUrl = new ArrayList();
    
    if ((null == (jingpin_count)) || (("".equals(jingpin_count))) || ("null"==jingpin_count))
	{
		jingpin_count	=	"0";
	}
    	 for(int i=0;i<(Integer.parseInt(jingpin_count));i++)
	     {
	  	    String tep_jingpin_name=MessageUtil.getMessage(session, "jingpin_"+(i+1));
	  	    String tep_jingpin_url=MessageUtil.getMessage(session, "jingpin_"+(i+1)+"_url");
	  	    String tep_jingpin_imgurl=MessageUtil.getMessage(session, "jingpin_"+(i+1)+"_img_url");
	  	    jinpin_name.add(tep_jingpin_name); 
	  	    jinpin_url.add(tep_jingpin_url); 
	  	    jinpin_imgUrl.add(jinpin_imgUrl);
	  	 }
       String temp_name = "";

  if ((null != jinpin_name)&&(jinpin_name.size()>0))
	{
		  temp_name = (String)jinpin_name.get(0);
	}
%>
<head>
<meta name="designer" content="meifk" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Page-Enter" content="blendTrans(Duration=1.0)">
<meta name="page-view-size" content="1280*720" />
<title>精品</title><style type="text/css">
*{margin:0; padding:0;}
body{background-color:transparent; width:1280px; height:720px; overflow:hidden; background:url(images/default/common.jpg) no-repeat;}
div.menu{position:absolute; top:150px; left:0px; width:1280px; height:570px;}
#icon_left{position:absolute; top:150px; left:20px; width:40px; height:55px; background:url(images/kanba/left1.png) no-repeat;visibility:hidden;}
#icon_right{position:absolute; top:150px; left:1220px; width:40px; height:55px; background:url(images/kanba/right1.png) no-repeat;visibility:hidden;}
#background{position:absolute; top:2px; left:502px;  width:284px; height:395px; background:url(images/kanba/select.png) no-repeat; -webkit-transition-duration:0.3s;z-index:5;}
#cursor{position:absolute; top:3px; left:502px;  width:277px; height:389px; background:url(images/kanba/cursor.png) no-repeat; -webkit-transition-duration:0.3s;z-index:5;}
#round{position:absolute; top:20px; left:522px;   width:237px; height351px; background:url(images/kanba/round.png) no-repeat; -webkit-transition-duration:0.3s; z-index:5;}
#list{position:absolute; top:100px; left:0px; width:1280px; height:470px; overflow:hidden; }
.img{position:absolute; top:20px; left:0px;  height:351px; -webkit-transition-duration:0.3s;border-radius:8px;}
.shadow{position:absolute;left:0px;width:height:46px; align:center; -webkit-transition-duration:0.3s;}
.name {position:absolute;left:0px; height:40px; color:#FFFFFF; text-align:center;-webkit-transition-duration:0.3s;}

#img0{top:110px;left:54px;width: 80px;height:118px;}
#img1{top:80px;left:150px;width: 110px;height:163px;}
#img2{top:50px;left:280px;width: 190px;height:258px;}
#img3{top:20px;left:522px;width: 237px;height:351px;}
#img4{top:50px;left:811px;width:190px;height:258px;}
#img5{top:80px;left:1021px;width:110px;height:163px;}
#img6{top:110px;left:1145px;width:80px;height:118px;}
#img7{width:80px;height:118px;}

#name0{top:265px;left:46px;width:  240px;}
#name1{top:280px;left:140px;width: 240px;}
#name2{top:365px;left:270px;width: 240px;}
#name3{top:450px;left:510px;width: 240px;}
#name4{top:365px;left:800px;width:240px;}
#name5{top:280px;left:1015px;width:240px;}
#name6{top:265px;left:1140px;width:240px;}
#name7{width:240px;}

#shadow0{top:235px;left:40px;width: 263px;height:46px;}
#shadow1{top:252px;left:140px;width: 263px;height:46px;}
#shadow2{top:325px;left:270px;width: 210px;height:46px;}
#shadow3{top:400px;left:510px;width: 263px;height:46px;}
#shadow4{top:325px;left:800px;width:210px;height:46px;}
#shadow5{top:252px;left:1015px;width:122px;height:46px;}
#shadow6{top:230px;left:1140px;width:89px;height:46px;}
#shadow7{width:89px;height:46px;}

#title {position:absolute;top:33px;height:40px;font-size:30px;width:300px;left:85px;color:#FFFFFF;}
#logo {position:absolute;top:20px;left:25px;width:60px;height:57px;background:url("images/jingpin/logo.png") no-repeat;}
</style>

<script src="js/mini.js" type="text/javascript"></script>

<script type="text/javascript">

//模拟数据
var menu = [];

//看吧左右翻页按钮
var icon = [["images/kanba/left1.png", "images/kanba/left.png"], ["images/kanba/right1.png", "images/kanba/right.png"]];

//海报图背景效果图，光标图，圆角图
var placard = [["images/kanba/background.png"], ["images/kanba/cursor.png"],["images/kanba/round.png"]];


//图片自定义
var opc 			= [0.4,0.6, 0.8, 1, 0.8, 0.6,0.4];
var image_left 		= [54, 150, 280, 522, 811, 1021, 1145];
var image_top 		= [110, 80, 50, 20, 50, 80, 110];
var image_width 	= [80, 110, 190, 237, 190, 110, 80];
var image_height 	= [118, 163, 258, 351, 258, 163, 118];

var main_left 		= [0, 150, 280, 522, 811, 1021, 1145];

//倒影自定义
var shadowtop 		= [260,280, 330, 400, 330, 280, 260];
var shadow_left	 	= [46, 140, 270, 510, 800, 1015, 1140];
var shadow_top 		= [235, 250, 320, 400, 320, 250, 235];
var shadow_width 	= [80, 122, 210, 263, 210, 122, 80];
var shadow_height 	= [16, 21, 37, 46, 37, 21, 16];

//看吧名称自定义
var name_top 	= [262,280, 365, 450, 365, 280, 262];
var name_left 	= [50, 140, 270, 510, 800, 1015, 1145];
var name_width 	= [80, 122, 210, 263, 210, 122, 80];
var name_size 	= [18, 22, 30, 40, 30,22,18];

//定义翻页光标参数
var background_left 	= 498;
var background_top 		= 0;
var background_width 	= 284;
var background_height 	= 391;

var cursor_left 	= 502;
var cursor_top 		= 3;
var cursor_width 	= 277;
var cursor_height 	= 389;

var round_left 		= 522;
var round_top		= 22;
var round_width 	= 237;
var round_height 	= 351;

//每张图片左偏移量
var leftSep 		= 400;

//当前光标所在位置
var menuPos 		= 0;

//当前图片所在位置
var imgPos 			= 0;

//平滑效果时间
var duration 		= "0.3s";

//左右翻页键对象
var iconLeft, iconRight;

//隐藏的图片、名称、阴影对象
var imgSide;
var nameSide;
var shadowSide;

//移动光标后者图片，标志位
var moveFlag 				= false;

//当flag为0时，定义初始化参数
var backgroundfirst 		= 50;
var focus_space 			= 180;
var cursorfirst 			= 53;
var roundfirst 				= 73;

var init_image_first 		= 73;
var init_image_width 		= 132;
var init_image_height 		= 196;
var init_image_big_width 	= 237;
var init_image_big_height 	= 351;
var init_image_big_top 		= 20;
var init_image_big_small 	= 0;
var init_image_top 			= 120;
var init_image_space 		= 180;
var init_image_start 		= 190;

var init_name_first 		= 73;
var init_name_small_top 	= 350;
var init_name_big_top 		= 450;
var init_name_space 		= 180;
var init_name_start 		= 135;
var init_name_big_size  	= 30;
var init_name_small_size  	= 20;
var init_name_small_big  	= 65;

var init_shadow_first 		= 60;
var init_shadow_top 		= 320;
var init_shadow_bottom 		= 400;
var init_shadow_width 		= 132;
var init_shadow_height 		= 23;
var init_shadow_big_width 	= 263;
var init_shadow_big_height 	= 46;
var init_shadow_space 		= 180;
var init_shadow_start 		= 187;

//海报阴影
var shadowname = "images/kanba/reflection.png";

//定义大海报图背景对象
var background, cursor, round;

//海报图片、名称对象
var imgObj 			= [];
var nameObj 		= [];
var shadowObj 		= [];

//是否翻页变量
var flag ;

window.onload = init;

function eventHandler(obj) {

	switch(obj.code) {
		case "KEY_LEFT":
			changeImg(-1);
			break;
		case "KEY_RIGHT":
			changeImg(1);
			break;
		case "KEY_SELECT":
			doSelect();
			break;
		case "KEY_EXIT":
		case "KEY_BACK":
			window.location = backUrl;
			break;
	}
}

//进入看吧
function doSelect(){
	window.location =  "HD_URLDispatch.jsp?dispatch=" + menu[menuPos].TURNURL;
}


var count	=	<%=jingpin_count%>;
var num_add	=	null;
var menu	=	[];
var m = 0;



//获取json数据
function getSubMenuData(){	
	<%
	for(int i=0;i<(Integer.parseInt(jingpin_count));i++)
	{
		    String tep_jingpin_name=MessageUtil.getMessage(session, "jingpin_"+(i+1));
		    String tep_jingpin_url=MessageUtil.getMessage(session, "jingpin_"+(i+1)+"_url");
		    String tep_jingpin_imgurl=MessageUtil.getMessage(session, "jingpin_"+(i+1)+"_img_url");
	%>
			var temp		=	{};
			temp.ITEMICON	=	"<%=tep_jingpin_imgurl%>";
			temp.NAME		=	"<%=tep_jingpin_name%>";
			temp.TURNURL	=	"<%=tep_jingpin_url%>";
			menu[m++]		=	temp;
	<%}%>
	
	flag = (count<=7) ? 0 : 1;
	num_add		=	3 - Math.floor(count/2);
	if( num_add<0 ) 	num_add = 0;
	showImgList();
}
//初始化操作
function init() {

	//获取对象
	iconLeft 	= 	$("icon_left");
	iconRight 	= 	$("icon_right");
	background 	= 	$("background");
	cursor 		= 	$("cursor");
	round 		= 	$("round");
	
	for(var i = 0; i < 8; i++){
		imgObj[i] = $("img" + i);
		nameObj[i] = $("name" + i);
		shadowObj[i] = $("shadow" + i);
	}
	getSubMenuData();
}

function showImgList() {
	
$("main").style.left	=	main_left[num_add] + "px";

//当前看吧列表不足一页
if(flag == 0) {

	for(var i = 0; i < count; i++) {
		if(i == 0) {
			background.style.left = backgroundfirst + "px";
			cursor.style.left = cursorfirst + "px";
			round.style.left = roundfirst + "px";
			
			imgObj[i].src = menu[i].ITEMICON;
			imgObj[i].style.left = init_image_first + "px";
			imgObj[i].style.top = init_image_big_top + "px";
			imgObj[i].style.width = init_image_big_width + "px";
			imgObj[i].style.height = init_image_big_height + "px";
			
			nameObj[i].style.fontSize = init_name_big_size + "px";
			nameObj[i].innerText = menu[i].NAME;
			nameObj[i].style.left = init_name_first + "px";
			nameObj[i].style.top = init_name_big_top + "px";
			
			shadowObj[i].src = shadowname;
			shadowObj[i].style.top = init_shadow_bottom + "px";
			shadowObj[i].style.left = init_shadow_first + "px";
		} else {
			imgObj[i].src = menu[i].ITEMICON;
			imgObj[i].style.left = init_image_start + (init_image_space*(i)) + "px";
			imgObj[i].style.top = init_image_top + "px";
			imgObj[i].style.width = init_image_width + "px";
			imgObj[i].style.height = init_image_height + "px";

			nameObj[i].style.fontSize = init_name_small_size + "px";
			nameObj[i].innerText = menu[i].NAME;
			nameObj[i].style.left = init_name_start + (init_name_space*(i)) + "px";
			nameObj[i].style.top = init_name_small_top + "px";
			
			shadowObj[i].src = shadowname;
			shadowObj[i].style.top = init_shadow_top + "px";
			shadowObj[i].style.left = init_shadow_start + (init_shadow_space*(i)) + "px";
			shadowObj[i].style.width = init_shadow_width + "px";
			shadowObj[i].style.height = init_shadow_height + "px";
		}
	}
} else {
	iconLeft.style.visibility="visible";
	iconRight.style.visibility="visible";
	
	var len = menu.length;
	
	for(var i=3 ; i>=0 ; i--)
	{
		if (i==3){
			imgObj[i].src = menu[(i + len - 3)%len].ITEMICON;
			imgObj[i].style.top = image_top[i] + "px";
			imgObj[i].style.left = image_left[i] + "px";
			imgObj[i].style.width = image_width[i] + "px";
			imgObj[i].style.height = image_height[i] + "px";

			nameObj[i].innerText = menu[(i + len - 3)%len].NAME;
			nameObj[i].style.fontSize = name_size[i] + "px";
			nameObj[i].style.left = name_left[i] + "px";
			nameObj[i].style.width = name_width[i] + "px";
			nameObj[i].style.top = name_top[i] + "px";
			
			$("title").innerText = menu[(i + len - 3)%len].NAME;

			shadowObj[i].src = shadowname;
			shadowObj[i].style.top = shadow_top[i] + "px";
			shadowObj[i].style.left = shadow_left[i] + "px";
			shadowObj[i].style.width = shadow_width[i] + "px";
			shadowObj[i].style.height = shadow_height[i] + "px";

		} else {
			
			imgObj[i].src = menu[(i + len - 3)%len].ITEMICON;
			imgObj[i].style.top = image_top[i] + "px";
			imgObj[i].style.left = image_left[i] + "px";
			imgObj[i].style.width = image_width[i] + "px";
			imgObj[i].style.height = image_height[i] + "px";
			
			nameObj[i].innerText = menu[(i + len - 3)%len].NAME;
			nameObj[i].style.fontSize = name_size[i] + "px";
			nameObj[i].style.left = name_left[i] + "px";
			nameObj[i].style.width = name_width[i] + "px";
			nameObj[i].style.top = name_top[i] + "px";

			shadowObj[i].src = shadowname;
			shadowObj[i].style.top = shadow_top[i] + "px";
			shadowObj[i].style.left = shadow_left[i] + "px";
			shadowObj[i].style.width = shadow_width[i] + "px";
			shadowObj[i].style.height = shadow_height[i] + "px";
			
			imgObj[6-i].src = menu[(3 + len - i)%len].ITEMICON;
			imgObj[6-i].style.top = image_top[6-i] + "px";
			imgObj[6-i].style.left = image_left[6-i] + "px";
			imgObj[6-i].style.width = image_width[6-i] + "px";
			imgObj[6-i].style.height = image_height[6-i] + "px";
			
			nameObj[6-i].innerText = menu[(3-i + len)%len].NAME;
			nameObj[6-i].style.fontSize = name_size[6-i] + "px";
			nameObj[6-i].style.left = name_left[6-i] + "px";
			nameObj[6-i].style.width = name_width[6-i] + "px";
			nameObj[6-i].style.top = name_top[6-i] + "px";
			
			shadowObj[6-i].src = shadowname;
			shadowObj[6-i].style.top = shadow_top[6-i] + "px";
			shadowObj[6-i].style.left = shadow_left[6-i] + "px";
			shadowObj[6-i].style.width = shadow_width[6-i] + "px";
			shadowObj[6-i].style.height = shadow_height[6-i] + "px";
		}
	}

	imgSide = imgObj[7];
	nameSide = nameObj[7];
	shadowSide = shadowObj[7];
	}
}

function changeImg(n) {	
	if(moveFlag) return;
	moveFlag = true;
	setTimeout(function(){moveFlag = false; }, 300);
	if(flag == 0) {
		if(menuPos == 0 && n < 0) return;
		if(menuPos == (menu.length - 1) && n > 0) return;
		
		if(n == 1) {
			imgObj[menuPos].style.top = init_image_top + "px";
			imgObj[menuPos].style.width = init_image_width + "px";
			imgObj[menuPos].style.height = init_image_height + "px";
			
			nameObj[menuPos].style.fontSize = init_name_small_size;
			nameObj[menuPos].style.top = init_name_small_top + "px";
			nameObj[menuPos].style.left = init_name_first + (init_name_space*(menuPos)-init_name_small_big) + "px";;
			
			shadowObj[menuPos].style.top = init_shadow_top + "px";
			shadowObj[menuPos].style.width = init_shadow_width + "px";
			shadowObj[menuPos].style.height = init_shadow_height + "px";
			
			menuPos += n;
			
			background.style.left = backgroundfirst + (focus_space*menuPos-init_image_big_small) + "px";
			
			imgObj[menuPos].style.top = init_image_big_top;
			imgObj[menuPos].style.left = init_image_first + (focus_space*menuPos-init_image_big_small) + "px";
			imgObj[menuPos].style.width = init_image_big_width + "px";
			imgObj[menuPos].style.height = init_image_big_height + "px";
			
			cursor.style.left = cursorfirst + (focus_space*menuPos-init_image_big_small) + "px";
			round.style.left = roundfirst + (focus_space*menuPos-init_image_big_small) + "px";
			
			nameObj[menuPos].style.fontSize = init_name_big_size + "px";
			nameObj[menuPos].style.left = init_name_first  + (init_name_space*menuPos-init_image_big_small) + "px";
			nameObj[menuPos].style.top = init_name_big_top + "px";
			
			shadowObj[menuPos].style.top = init_shadow_bottom + "px";
			shadowObj[menuPos].style.left = init_shadow_first + (init_shadow_space*menuPos-init_image_big_small)  + "px";
			shadowObj[menuPos].style.width = init_shadow_big_width + "px";
			shadowObj[menuPos].style.height = init_shadow_big_height + "px";
		}
		
		if(n == -1) {
			
			imgObj[menuPos].style.top = init_image_top + "px";
			imgObj[menuPos].style.width = init_image_width + "px";
			imgObj[menuPos].style.height = init_image_height + "px";
			imgObj[menuPos].style.left = init_image_start + (init_image_space*menuPos) + "px";
			
			nameObj[menuPos].style.fontSize = init_name_small_size;
			nameObj[menuPos].style.top = init_name_small_top + "px";
			nameObj[menuPos].style.left = init_name_first + (init_name_space*(menuPos)+init_name_small_big) + "px";;
			
			shadowObj[menuPos].style.top = init_shadow_top + "px";
			shadowObj[menuPos].style.width = init_shadow_width + "px";
			shadowObj[menuPos].style.height = init_shadow_height + "px";
			shadowObj[menuPos].style.left = init_shadow_start + (init_shadow_space*menuPos) + "px";
			
			menuPos += n;
			
			background.style.left = backgroundfirst + (focus_space*menuPos-init_image_big_small) + "px";
			
			imgObj[menuPos].style.top = init_image_big_top;
			imgObj[menuPos].style.left = init_image_first + (focus_space*menuPos-init_image_big_small) + "px";
			imgObj[menuPos].style.width = init_image_big_width + "px";
			imgObj[menuPos].style.height = init_image_big_height + "px";
			
			cursor.style.left = cursorfirst + (focus_space*menuPos-init_image_big_small) + "px";
			round.style.left = roundfirst + (focus_space*menuPos-init_image_big_small) + "px";
			
			nameObj[menuPos].style.fontSize = init_name_big_size + "px";
			nameObj[menuPos].style.left = init_name_first  + (init_name_space*menuPos-init_image_big_small) + "px";
			nameObj[menuPos].style.top = init_name_big_top + "px";
			
			shadowObj[menuPos].style.top = init_shadow_bottom + "px";
			shadowObj[menuPos].style.left = init_shadow_first + (init_shadow_space*menuPos-init_image_big_small)  + "px";
			shadowObj[menuPos].style.width = init_shadow_big_width + "px";
			shadowObj[menuPos].style.height = init_shadow_big_height + "px";
			
		}
		return;
	} else {
		
		var imgLen = image_left.length + 1;
		var len = menu.length;
		var pos = n < 0 ? ((menuPos + 4) % len) : ((menuPos - 4 + len) % len);
	
	
		window.setTimeout(function(){
			menuPos = (menuPos - n + len) % len;
			imgPos = (imgPos - n + imgLen) % imgLen;
			
			imgSide.style.webkitTransitionDuration = "0s";
			nameSide.style.webkitTransitionDuration = "0s";
			shadowSide.style.webkitTransitionDuration = "0s";
	
			imgSide.style.left = ((n < 0) ? (image_left[6] + leftSep) : (image_left[0] - leftSep)) + "px";
			nameSide.style.left = ((n < 0) ? (name_left[6] + leftSep) : (name_left[0] - leftSep)) + "px";
			shadowSide.style.left = ((n < 0) ? (shadow_left[6] + leftSep) : (shadow_left[0] - leftSep)) + "px";
		
			
			imgSide.src = menu[pos].ITEMICON;
			nameSide.innerText = menu[pos].NAME;
			shadowSide.src = shadowname;
	//		nameSide.style.visibility = "visible";
	
			
			imgSide.style.webkitTransitionDuration = duration;
			shadowSide.style.webkitTransitionDuration = duration;
			nameSide.style.webkitTransitionDuration = duration;
			
			for(var i = 0; i < 7; i++) {
	
				imgObj[(i + imgPos) % imgLen].style.top = image_top[i] + "px";
				imgObj[(i + imgPos) % imgLen].style.left = image_left[i] + "px";
				imgObj[(i + imgPos) % imgLen].style.width = image_width[i] + "px";
				imgObj[(i + imgPos) % imgLen].style.height = image_height[i] + "px";
	
				shadowObj[(i + imgPos) % imgLen].style.top = shadow_top[i] + "px";
				shadowObj[(i + imgPos) % imgLen].style.left = shadow_left[i] + "px";
				shadowObj[(i + imgPos) % imgLen].style.width = shadow_width[i] + "px";
				shadowObj[(i + imgPos) % imgLen].style.height = shadow_height[i] + "px";
				
				nameObj[(i + imgPos) % imgLen].style.top = name_top[i] + "px";
				nameObj[(i + imgPos) % imgLen].style.left = name_left[i] + "px";
				nameObj[(i + imgPos) % imgLen].style.width = name_width[i] + "px";
				nameObj[(i + imgPos) % imgLen].style.fontSize = name_size[i] + "px";
			}
	
			if (imgPos == 0)
			{
				imgSide = (n > 0) ? imgObj[(7 + imgPos) % imgLen] : imgObj[(7 + imgPos) % imgLen];
				nameSide = (n > 0) ? nameObj[(7 + imgPos) % imgLen] : nameObj[(7 + imgPos) % imgLen];
				shadowSide = (n > 0) ? shadowObj[(7 + imgPos) % imgLen] : shadowObj[(7 + imgPos) % imgLen];
			} else {
				imgSide = (n > 0) ? imgObj[(7 + imgPos) % imgLen] : imgObj[(-1 + imgPos) % imgLen];
				nameSide = (n > 0) ? nameObj[(7 + imgPos) % imgLen] : nameObj[(-1 + imgPos) % imgLen];
				shadowSide = (n > 0) ? shadowObj[(7 + imgPos) % imgLen] : shadowObj[(-1 + imgPos) % imgLen];
			}
			
			imgSide.style.left = ((n < 0) ? (image_left[6] + leftSep) : (image_left[0] - leftSep)) + "px";
			nameSide.style.left = ((n < 0) ? (name_left[6] + leftSep) : (name_left[0] - leftSep)) + "px";
			shadowSide.style.left = ((n < 0) ? (shadow_left[6] + leftSep) : (shadow_left[0] - leftSep)) + "px";
			
			if(n<0)
				$("title").innerText = menu[(pos-3+len)%len].NAME;
			else
				$("title").innerText = menu[(pos+3+len)%len].NAME;
		}, 50);
	}
}
</script>
</head>

<body>

<div id="logo"></div>
<div id="title">精品</div>

<div class="menu" id="main">
	<div id="icon_left"></div>
	<div id="background"></div>
	<div id="list">
		<img id="img0" class="img" src="" />
		<img id="shadow0" class="shadow" src=""  />
		<div class="name" id="name0"></div>
		
		<img id="img1" class="img" src="" />
		<div class="name" id="name1"></div>
		<img id="shadow1" class="shadow" src="" />
		
		<img id="img2" class="img" src="" />
		<div class="name" id="name2"></div>
		<img id="shadow2" class="shadow" src="" />
		
		<img id="img3" class="img" src="" />
		<div class="name" id="name3" ></div>
		<img id="shadow3" class="shadow" src="" />
		
		<img id="img4" class="img" src="" />
		<div class="name" id="name4" ></div>
		<img id="shadow4" class="shadow" src="" />
		
		<img id="img5" class="img" src="" />
		<div class="name" id="name5"></div>
		<img id="shadow5" class="shadow" src="" />
		
		<img id="img6" class="img" src="" />
		<div class="name" id="name6"></div>
		<img id="shadow6" class="shadow" src="" />
		
		<img id="img7" class="img" src=""/>
		<div class="name" id="name7"></div>
		<img id="shadow7" class="shadow" src=""/>
	</div>
	<div id="round"></div>
	<div id="icon_right"></div>
</div>
</body>
</html>
