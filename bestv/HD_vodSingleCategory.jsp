<%@ include file="HD_preFocusElement.jsp" %>
<html>
<head>
<meta name="designer" content="wangzhib" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Page-Enter" content="blendTrans(Duration=2.0)">
<title></title>
<script src="js/mini.js" type="text/javascript"></script>
<style type="text/css">
	body{background-color:transparent; width:1280px; height:720px; left:0px; top:0px; overflow:hidden; background-image:url(images/vod/g_bg.jpg)}
	#menu1{position:absolute; top:25; left:0px; height:684px; width:233; background-image:url(images/vod/vodMenu1.png); background-repeat:no-repeat; background-position:center; z-index:4;  -webkit-transition-duration:10ms;}
	#menu1 #menuFocus1{ position:absolute; text-align:right; top:54px; left:-10px; height:78px; width:211px; background-image:url(images/vod/focus11.png); font-size:35px; color:#ffffff; line-height:78px; padding-right:15px; z-index:5;}
	#listDiv{ position:absolute; top:95px; left:330px; height:552px; width:888px; -webkit-transition-duration:200ms; z-index:1;}
	#listDiv .style3{width:162px; height:162px; -webkit-transition-duration:200ms; z-index:0; visibility:hidden;}
	#listDiv #list0{position:absolute; top:0px; left:0px;}
	#listDiv #list1{position:absolute; top:0px; left:242px;}
	#listDiv #list2{position:absolute; top:0px; left:484px;}
	#listDiv #list3{position:absolute; top:0px; left:726px;}
	#listDiv #list4{position:absolute; top:194px; left:0px;}
	#listDiv #list5{position:absolute; top:194px; left:242px;}
	#listDiv #list6{position:absolute; top:194px; left:484px;}
	#listDiv #list7{position:absolute; top:194px; left:726px;}
	#listDiv #list8{position:absolute; top:388px; left:0px;}
	#listDiv #list9{position:absolute; top:388px; left:242px;}
	#listDiv #list10{position:absolute; top:388px; left:484px;}
	#listDiv #list11{position:absolute; top:388px; left:726px;}
	#listDiv .img{position:absolute; left:20px; top:18px; height: 100px; width: 121px;}
	#listDiv .text{position:absolute; top:120px; left:8px; width:146px; height:34px; text-align:center; line-height:34px; font-size:22px; color:#393939;}
	#listDiv #listFocus{position:absolute; background-image:url(images/vod/movieFocus.png); width:214px; height:216px; left: -26px; top: -27px; -webkit-transition-duration:200ms; opacity:0; z-index:1;}
	#upSign{position:absolute; left:750px; top:49px; height:26px; width:48px; background-image:url(images/vod/up.png);}
	#downSign{position:absolute; left:751px; top:664px; height:26px; width:48px; background-image:url(images/vod/down.png);}
	#title{ position:absolute; top:16px; left:303px; width:553px; height:40px; line-height:40px; font-size:30px; color:#FFFFFF;}
	#page{ position:absolute; top:36px; left:1155px; width:100px; height:40px; line-height:40px; font-size:24px; color:#FFFFFF; text-align:right;}
	
</style>
<script type="text/javascript">
var menuList = [];
var listPos = 0;//内容列表位置

var textObj = [];
var imgObj = [];
var listCurrPage = 0;
var listSumPage = 0;
var listLength = 0;

var keyFlag = false;

function eventHandler(obj) {
	switch(obj.code) {
		case "KEY_UP":
			if(!keyFlag){
				keyFlag = true;
				setTimeout("keyFlag = false;",150);
				changeListFocusUD(-1);
			}
			break;
		case "KEY_DOWN":
			if(!keyFlag){
				keyFlag = true;
				setTimeout("keyFlag = false;",150);
				changeListFocusUD(1);
			}
			break;
		case "KEY_LEFT":
			changeListFocusLR(-1);
			break;
		case "KEY_RIGHT":
			changeListFocusLR(1);
			break;
		case "KEY_SELECT":
			window.location.href = menuList[0].sub[listPos+listCurrPage*12].url;
			break;
		case "KEY_PAGE_UP":
			changeListPage(-1);
			break;
		case "KEY_PAGE_DOWN":
			changeListPage(1);
			break;
		case "KEY_EXIT":
		case "KEY_BACK":
			window.location.href = backUrl;
			break;
	}
}
//左右按键
function changeListFocusLR(num){
	if((listPos+num+listCurrPage*12)>listLength-1) return;
	if((listPos+1)%4 == 0 && num > 0) return;
	else if(listPos%4 == 0 && num<0) return;
	$("bgPic"+listPos).src = "images/vod/movie0.png";
	$("list"+listPos).style.webkitTransform = "scale(1)";
	$("text"+listPos).style.color = "#393939";
	listPos += num;
	$("listFocus").style.left = -26+242*(listPos%4)+"px";
	$("bgPic"+listPos).src = "images/vod/movie1.png";
	$("list"+listPos).style.webkitTransform = "scale(1.15)";
	$("text"+listPos).style.color = "#ffffff";
}

//上下按键
function changeListFocusUD(num){
	if((listPos >= 8 && num > 0)||(listPos<4 && num<0) ||(listPos+num*4+listCurrPage*12)>listLength-1){//翻页
		if(listSumPage > 1){
			$("listFocus").style.webkitTransitionDuration = "0ms";
			$("listFocus").style.opacity = 0;
			for(var i=0; i<12; i++){
				$("list"+i).style.webkitTransitionDuration = "0ms";
				$("list"+i).style.opacity = 0;
			}
			
			if(listPos != 0){
				$("listFocus").style.top = "-27px";
				$("listFocus").style.left = "-26px";
				
				$("bgPic"+listPos).src = "images/vod/movie0.png";
				$("list"+listPos).style.webkitTransform = "scale(1)";
				$("text"+listPos).style.color = "#393939";
				listPos = 0;
				$("list"+listPos).style.webkitTransform = "scale(1.15)";
				$("bgPic"+listPos).src = "images/vod/movie1.png";
				$("text"+listPos).style.color = "#ffffff";
			}
			setTimeout("resetListFocus()",10);
			changeListPage(num);
		}
	}else{
		$("bgPic"+listPos).src = "images/vod/movie0.png";
		$("list"+listPos).style.webkitTransform = "scale(1)";
		$("text"+listPos).style.color = "#393939";	
		listPos += num*4;
		$("listFocus").style.top = (-27+194*Math.floor(listPos/4))+"px";
		$("bgPic"+listPos).src = "images/vod/movie1.png";
		$("list"+listPos).style.webkitTransform = "scale(1.15)";
		$("text"+listPos).style.color = "#ffffff";
	}
}
function resetListFocus(){
	for(var i=0; i<12; i++){
		$("list"+i).style.webkitTransitionDuration = "200ms";
		$("list"+i).style.opacity = 1;
	}
	$("listFocus").style.webkitTransitionDuration = "200ms";
	$("listFocus").style.opacity = 1;
}

function changeListPage(num){
	listCurrPage += num;
	if(listCurrPage > listSumPage-1)
		listCurrPage = 0;
	else if(listCurrPage < 0)
		listCurrPage = listSumPage-1;
	showMovieList();
		
}
var params = [];

function init(){
	params = window.location.search.substring(1).split("&");
	var typeId = params[0].split("=")[1];
	getMovieListData(typeId,0);
	initIdObj();
}

function getMovieListData(typeId,page){
	var url = "HD_vodCategoryData.jsp?TYPE_ID="+typeId+"&PAGE="+page;
	var ajax = new AJAX_OBJ(url, getListData);
	ajax.requestData();	
}
function getListData(xmlHttp){
	eval("menuList=" + xmlHttp.responseText);
//	iPanel.debug("wangzhib,---menuList[0].sub.length="+menuList[0].sub.length);
	if(menuList.length > 0)
		if(menuList[0].sub.length > 0)
			initMovieList();
}
function initMovieList(){
	$("menuFocus1").innerText = menuList[0].typename.slice(0,5);
	$("listFocus").style.opacity = 1;
	$("bgPic"+listPos).src = "images/vod/movie1.png";
	$("list"+listPos).style.webkitTransform = "scale(1.15)";
	$("text"+listPos).style.color = "#ffffff";
	listLength = menuList[0].sub.length;
	listSumPage = Math.floor((listLength-1)/12)+1;
	listCurrPage = 0;
	$("title").innerText = "共搜索到"+menuList[0].count+"个节目";
	showMovieList();
	
}
function showMovieList(){
	$("page").innerText = (listCurrPage+1)+"/"+listSumPage+"页";
	for(var i=listCurrPage*12; i<(listCurrPage+1)*12; i++){
		if(i < listLength){
			imgObj[i%12].src = menuList[0].sub[i].pic;
			textObj[i%12].innerText = menuList[0].sub[i].name.substring(0,6);
			$("list" + i).style.visibility = "visible";  //当有节目内容时，显示背景图片，默认隐藏
		}
		else{
			imgObj[i%12].src = "images/vod/noProgram.jpg";
			textObj[i%12].innerText = "&nbsp;";
			$("list" + (i%12)).style.visibility = "hidden";//翻页时，如果无数据则隐藏背景图片
		}
	}
}
function initIdObj(){
	for(var i=0; i<12; i++){
		imgObj[i] = $("img"+i);
		textObj[i] = $("text"+i);
	}
}
</script>
</head>
<body topmargin="0" leftmargin="0" onLoad="init()">
<div id="menu1">
	<div id="part1"></div>
	<div id="part2"></div>
	<div id="part3"></div>
	<div id="menuFocus1"></div>
</div>
<div id="midDiv"></div>
<div id="listDiv">
	<div id="list0" class="style3"><img id="bgPic0" src="images/vod/movie0.png" width="162" height="162" class="bigImage"/><img id="img0" class="img" src="" /><div id="text0" class="text"></div></div>
	<div id="list1" class="style3"><img id="bgPic1" src="images/vod/movie0.png" width="162" height="162" class="bigImage"/><img id="img1" class="img" src="" /><div id="text1" class="text"></div></div>
	<div id="list2" class="style3"><img id="bgPic2" src="images/vod/movie0.png" width="162" height="162" class="bigImage"/><img id="img2" class="img" src="" /><div id="text2" class="text"></div></div>
	<div id="list3" class="style3"><img id="bgPic3" src="images/vod/movie0.png" width="162" height="162" class="bigImage"/><img id="img3" class="img" src="" /><div id="text3" class="text"></div></div>
	<div id="list4" class="style3"><img id="bgPic4" src="images/vod/movie0.png" width="162" height="162" class="bigImage"/><img id="img4" class="img" src="" /><div id="text4" class="text"></div></div>
	<div id="list5" class="style3"><img id="bgPic5" src="images/vod/movie0.png" width="162" height="162" class="bigImage"/><img id="img5" class="img" src="" /><div id="text5" class="text"></div></div>
	<div id="list6" class="style3"><img id="bgPic6" src="images/vod/movie0.png" width="162" height="162" class="bigImage"/><img id="img6" class="img" src="" /><div id="text6" class="text"></div></div>
	<div id="list7" class="style3"><img id="bgPic7" src="images/vod/movie0.png" width="162" height="162" class="bigImage"/><img id="img7" class="img" src="" /><div id="text7" class="text"></div></div>
	<div id="list8" class="style3"><img id="bgPic8" src="images/vod/movie0.png" width="162" height="162" class="bigImage"/><img id="img8" class="img" src="" /><div id="text8" class="text"></div></div>
	<div id="list9" class="style3"><img id="bgPic9" src="images/vod/movie0.png" width="162" height="162" class="bigImage"/><img id="img9" class="img" src="" /><div id="text9" class="text"></div></div>
	<div id="list10" class="style3"><img id="bgPic10" src="images/vod/movie0.png" width="162" height="162" class="bigImage"/><img id="img10" class="img" src="" /><div id="text10" class="text"></div></div>
	<div id="list11" class="style3"><img id="bgPic11" src="images/vod/movie0.png" width="162" height="162" class="bigImage"/><img id="img11" class="img" src="" /><div id="text11" class="text"></div></div>
	<div id="listFocus"></div>
</div>
<div id="upSign"></div>
<div id="downSign"></div>
<div id="title"></div>
<div id="page"></div>
</body>
</html>