<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ include file="HD_preFocusElement.jsp" %>

<%
  String childId = (String)request.getParameter("CHILD_ID"); 
  if(childId == null){ childId = ""; }
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Page-Enter" content="blendTrans(Duration=2.0)">
<meta name="page-view-size" content="1280*720">
<title></title>
<script src="js/mini.js" type="text/javascript"></script>
<style type="text/css">
	body{background-color:transparent; width:1280px; height:720px; left:0px; top:0px; overflow:hidden;}
	#bodybackground{ width:1280px; height:720px; left:0px; top:0px; overflow:hidden; background-image:url(images/vod/g_bg.jpg); }
	#menu0{position:absolute; top:18px; left:-42px; height:684px; width:231; background-repeat:no-repeat; background-position:center; background-image:url(images/vod/vodMenu0.png); visibility:hidden; z-index:4;}
    #content0{ position:absolute; top:52px; left:-268px; height:624px; width:452px;z-index:6}
	#line0{ position:absolute; top:110px; left:0px; height:489px; width:231px;}
	#content0 .style0{text-align:right; font-size:35px; color:#393939; padding-right:26px;height:78px;width:231px; line-height:78px; z-index:6}
	#menu0 #line0 .style1{background-image:url(images/vod/line.png); background-repeat:repeat; background-position:center; width:231px}
	#menuFocus0{ position:absolute; top:54px; left:-210px; height:75px; width:223px; background-image:url(images/vod/focus00.png); background-position:right; z-index:5;}
	#menu0 #up0{position:absolute; left:105px; top:5px; height:22px; width:41px; background-image:url(images/vod/vodUp0.png);}
	#menu0 #down0{position:absolute; left:105px; top:657px; height:22px; width:41px; background-image:url(images/vod/vodDown0.png);}

	#menu1{position:absolute; top:18; left:185px; height:684px; width:233; background-repeat:no-repeat; background-position:center;background-image:url(images/vod/vodMenu1.png); visibility:visible;z-index:4;}
	#content1{ position:absolute; top:78px; left:-51px; height:567px; width:452px; z-index:6}
	#content1 .style2{text-align:right; font-size:32px; color:#B3B3B3; padding-right:20px; z-index:6; width:233px}
	#menuFocus1{ position:absolute; top:78px; left:14px; height:78px; width:211px; background-image:url(images/vod/focus11.png); z-index:5;}
	#menu1 #up1{position:absolute; left:88px; top:24px; height:22px; width:41px; background-image:url(images/vod/vodUp1.png);}
	#menu1 #down1{position:absolute; left:88px; top:627px; height:22px; width:41px; background-image:url(images/vod/vodDown1.png);}
	#listDiv{ position:absolute; top:95px; left:310px; height:552px; width:888px; -webkit-transition-duration:200ms; opacity:0; z-index:1;}
	#listDiv .style3{width:162px; height:162px; z-index:0;}
	#listDiv #list0{position:absolute; top:0px; left:0px; opacity:0}
	#listDiv #list1{position:absolute; top:0px; left:242px; opacity:0}
	#listDiv #list2{position:absolute; top:0px; left:484px; opacity:0}
	#listDiv #list3{position:absolute; top:0px; left:726px; opacity:0}
	#listDiv #list4{position:absolute; top:194px; left:0px; opacity:0}
	#listDiv #list5{position:absolute; top:194px; left:242px; opacity:0}
	#listDiv #list6{position:absolute; top:194px; left:484px; opacity:0}
	#listDiv #list7{position:absolute; top:194px; left:726px; opacity:0}
	#listDiv #list8{position:absolute; top:388px; left:0px; opacity:0}
	#listDiv #list9{position:absolute; top:388px; left:242px; opacity:0}
	#listDiv #list10{position:absolute; top:388px; left:484px; opacity:0}
	#listDiv #list11{position:absolute; top:388px; left:726px; opacity:0}
	#listDiv .img{position:absolute; left:20px; top:18px; height: 100px; width: 121px;}
	#listDiv .text{position:absolute; top:120px; left:8px; width:146px; height:34px; text-align:center; line-height:34px; font-size:22px; color:#393939; overflow: hidden}
	#listDiv #listFocus{position:absolute; background-image:url(images/vod/movieFocus.png); width:214px; height:216px; left: -26px; top: -25px; -webkit-transition-duration:200ms; opacity:0; z-index:1;}
	#midDiv{ position:absolute; top:0px; left:1px; width:1280px; height:720px;  background-image:url(images/vod/vod_opacity.png);  z-index:3;visibility:hidden}
	#upSign{position:absolute; left:730px; top:49px; height:26px; width:48px; background-image:url(images/vod/up.png);}
	#downSign{position:absolute; left:730px; top:664px; height:26px; width:48px; background-image:url(images/vod/down.png);}
	#icon{ position:absolute; top:17px; left:294px; width:48px; height:48px; background-image:url(images/vod/if03.png);}
	#title{ position:absolute; top:20px; left:355px; width:553px; height:40px; line-height:40px; font-size:30px; color:#FFFFFF; }
	#page{ position:absolute; top:36px; left:1155px; width:100px; height:40px; line-height:40px; font-size:24px; color:#FFFFFF; text-align:right;}
</style>
<script type="text/javascript">
/****************2D滑动对象******************/
function showList_2D(args){
	this.dataLength = args.dataLength;		// 数据的长度
	this.listSize = args.listSize;		// 列表的长度
	this.dataPos = args.dataPos || 0;		// 数据焦点的位置
	this.focusDiv = args.focusDiv;		// 焦点的div名称
	this.startPlace = args.startPlace;	// 焦点的位置
	this.focusDivObj = null;	// 焦点div的Dom 表现
	this.listHigh = args.listHigh;		// 焦点移动的距离
	this.arrayList = [];		// 列表中每一列的Id
	this.listDom = [];		// 列表id的Dom表现
	this.f = args.f || window;		// 当前窗体
	this.viewSize = this.listSize + 1;	// 可见列表的长度， 一般比this.listSize 大于1
	this.showFlag = args.showFlag || 0;	// 标记列表是上下移动还是左右移动，this.showFlag:1
										// 表示上下，this.showFlag:0 表示左右
	this.duration = args.duration || "200ms";
	this.tempSize = this.dataLength < this.listSize?this.dataLength:this.listSize;

	this.posInfo = {
		firstPos:{top:"", left:""},// 第一个位置, 第一个参数为它的top， 第二个为left 值
		lastPos:{top:"", left:""},	// 最后一个位置
		firstStatus:{top:"", left:""},	// 第一个之前的状态位置
		endStatus:{top:"", left:""}			// 最后一个之后的位置
	}
	this.focusPosition = function(){// 计算焦点位置的函数
		if((this.dataPos+1)>this.dataLength){ return this.tempSize; }
		return (this.dataPos+1)>this.tempSize?this.tempSize:this.dataPos;
	}
	this.focusPos = this.focusPosition();			// 焦点的位置
	this.listPos = this.focusPos;	// 循环ID的位置
	this.haveData = function(){};
	this.noData = function(){};

	// 开始显示
	this.startShow = function(){
		this.setDocumentGlobal();
		this.showFocusPlace();
		this.showList();
	}

	// 设置全局的DOM对象
	this.setDocumentGlobal = function(){
		for(var i = 0; i < this.viewSize; i++){
			this.listDom[i] = this.$(this.arrayList[i]);
			this.listDom[i].style.webkitTransitionDuration = this.duration;
		}
		this.focusDivObj = this.$(this.focusDiv);
	}

	this.showFocusPlace = function(){
		this.focusDivObj.style.webkitTransitionDuration = "0s";
		if(this.showFlag == 1) this.focusDivObj.style.top = this.startPlace + this.listHigh*this.focusPos + "px";
		else this.focusDivObj.style.left = this.startPlace + this.listHigh*this.focusPos + "px";
		this.focusDivObj.style.webkitTransitionDuration = this.duration;
	}

	// 移动焦点
	this.changeList = function(_num){
		if(this.dataPos + _num < 0 || this.dataPos + _num == this.dataLength) return;
		if(this.focusPos == 0 && _num < 0){// 列表向下或向右移动
			this.showDownOrRightEffect();
		}else if(this.focusPos == this.listSize-1 && _num > 0){		// 列表向上或向左移动
			this.showUpOrLeftEffect();
		}else{	// 焦点在列表中，焦点滑动
			if(this.showFlag == 1) this.focusDivObj.style.top = parseInt(this.focusDivObj.style.top) + this.listHigh*_num + "px";
			else this.focusDivObj.style.left = parseInt(this.focusDivObj.style.left) + this.listHigh*_num + "px";
		}
		this.changePos(_num);	// 位置的运算
	}
	
	// 向下或是向右移动
	this.showDownOrRightEffect = function(){
		// 用两变量记住将要滑进来的数据的位置
		var tempPos = (this.listPos - 1 + this.viewSize)%this.viewSize;
		var tempDataPos = (this.dataPos - 1 + this.dataLength)%this.dataLength;
		// 改变滑进来的list的状态值－－－－－start
		this.listDom[tempPos].style.webkitTransitionDuration = "0s";
		this.haveData({idPos:tempPos, dataPos:tempDataPos});	// 填数据
		if(this.showFlag == 1) this.listDom[tempPos].style.top = this.posInfo.firstStatus.top;	
		else this.listDom[tempPos].style.left = this.posInfo.firstStatus.left;
		this.listDom[tempPos].style.webkitTransitionDuration = this.duration;
		if(this.showFlag == 1) this.listDom[tempPos].style.top = this.posInfo.firstPos.top;
		else this.listDom[tempPos].style.left = this.posInfo.firstPos.left;
		// 改变滑进来的list的状态值－－－－－end
		for(var i = this.listPos; i < this.listPos + this.listSize - 1; i ++){	// 将上一个状态值附给下一个
			this.listDom[i%this.viewSize].style.webkitTransitionDuration = this.duration;
			if(this.showFlag == 1) this.listDom[i%this.viewSize].style.top = this.listDom[(i + 1)%this.viewSize].style.top;	
			else this.listDom[i%this.viewSize].style.left = this.listDom[(i + 1)%this.viewSize].style.left;	 
		}
		// 做切出的动作
		this.listDom[(this.listPos + this.listSize - 1)%this.viewSize].style.webkitTransitionDuration = this.duration;
		if(this.showFlag == 1) this.listDom[(this.listPos + this.listSize - 1)%this.viewSize].style.top = this.posInfo.endStatus.top;
		else this.listDom[(this.listPos + this.listSize - 1)%this.viewSize].style.left = this.posInfo.endStatus.left;
	}
	
	// 向上或向左移动
	this.showUpOrLeftEffect = function(){
		// 用两变量记住将要滑进来的数据的位置
		var tempPos = (this.listPos + 1)%this.viewSize;
		var tempDataPos = (this.dataPos + 1)%this.dataLength;
		// 改变滑进来的list的状态值－－－－－start
		this.listDom[tempPos].style.webkitTransitionDuration = "0s";
		this.haveData({idPos:tempPos, dataPos:tempDataPos});	// 填数据
		if(this.showFlag == 1) this.listDom[tempPos].style.top = this.posInfo.endStatus.top;
		else this.listDom[tempPos].style.left = posInfo.endStatus.left;
		this.listDom[tempPos].style.webkitTransitionDuration = this.duration;
		if(this.showFlag == 1) this.listDom[tempPos].style.top = this.posInfo.lastPos.top;
		else this.listDom[tempPos].style.left = this.posInfo.lastPos.left;
		// 改变滑进来的list的状态值－－－－－end
		for(var i = this.listPos; i > this.listPos - this.listSize + 1; i --){	// 将下一个状态值附给上一个
			this.listDom[(i + this.viewSize)%this.viewSize].style.webkitTransitionDuration = this.duration;
			if(this.showFlag == 1) this.listDom[(i + this.viewSize)%this.viewSize].style.top = this.listDom[(i - 1 + this.viewSize)%this.viewSize].style.top;	
			else this.listDom[(i + this.viewSize)%this.viewSize].style.left = this.listDom[(i - 1 + this.viewSize)%this.viewSize].style.left;	
		}
		// 做切出动作
		this.listDom[(this.listPos - this.listSize + 1 + this.viewSize)%this.viewSize].style.webkitTransitionDuration = this.duration;
		if(this.showFlag == 1) this.listDom[(this.listPos - this.listSize + 1 + this.viewSize)%this.viewSize].style.top = this.posInfo.firstStatus.top;
		else this.listDom[(this.listPos - this.listSize + 1 + this.viewSize)%this.viewSize].style.left = this.posInfo.firstStatus.left;
	}
	
	// 设定位置
	this.changePos = function(_num){
		this.dataPos = ((this.dataPos + _num)%this.dataLength + this.dataLength)%this.dataLength;
		this.listPos = ((this.listPos + _num)%this.viewSize + this.viewSize)%this.viewSize;
		this.focusPos = this.focusPos + _num;
		if(this.focusPos < 0) this.focusPos = 0;
		else if(this.focusPos == this.listSize) this.focusPos = this.listSize-1;
	}
	
	// 显示列表
	this.showList = function(){
		var tempPos = this.dataPos - this.focusPos;
		for(var i = tempPos; i < tempPos + this.viewSize; i++){
			if(i < this.dataLength){
				this.haveData({idPos:i - tempPos, dataPos:i});
			}else{
				this.noData({idPos:i - tempPos, dataPos:i});
			}
		}
	}

	// 简写
	this.$= function(id) {
		if(typeof(this.f) == "object"){
			return this.f.document.getElementById(id);
		}else{
			return document.getElementById(id);
		}
	}
}

var menuList;
var areaFlag = 0;// 0表示一级菜单，1表示二级菜单，2表示内容列表。
var menuPos = 0;// 一级菜单位置
var dataPos = 0;// 一级菜单数据位置
var subPos = 0;// 二级菜单位置
var subDataPos = 0;// 二级菜单数据位置
var listPos = 0;// 内容列表位置

var menuObj = [];
var subObj = [];
var listObj = [];
var subBox = new Object();
var menu0Box = new Object();
var textObj = [];
var imgObj = [];
var listCurrPage = 0;
var listSumPage = 0;
var subCurrPage = 0;
var subSumPage = 0;
var subMenuLength = 0;
var listLength = 0;

var keyFlag = false;
var focusFlag = false;
function eventHandler(obj) {
	switch(obj.code) {
		case "KEY_UP":
// showMenuUpOrDown();
// showSubMenuUpOrDown();
			if(!keyFlag){
				keyFlag = true;
				setTimeout("keyFlag = false;",150);
				if(areaFlag == 0)
					changeMenu(-1);
				else if(areaFlag == 1)
					changeSubMenu(-1);
				else
					changeListFocusUD(-1);
			}
			break;
		case "KEY_DOWN":
			if(!keyFlag){
				keyFlag = true;
				setTimeout("keyFlag = false;",150);
				if(areaFlag == 0)
					changeMenu(1);
				else if(areaFlag == 1)
					changeSubMenu(1);
				else
					changeListFocusUD(1);
			}
			break;
		case "KEY_LEFT":
			if(noSubmenu==true&&areaFlag<2) return ;
			if(areaFlag == 2)
				changeListFocusLR(-1);
			else
				changeArea(-1);
			break;
		case "KEY_RIGHT":
			if(areaFlag == 2)
				changeListFocusLR(1);
			else
				changeArea(1);
			break;
		case "KEY_SELECT":
			if(areaFlag == 2){
				var toUrl = menuList[dataPos].CHILDINFO[subDataPos].CATEGORYDATA[0].sub[listPos+listCurrPage*12].url;
				if (menuList[dataPos].CHILDINFO[subDataPos].LEVEL == 2)
					document.location="HD_saveCurrFocus.jsp?currFocus="+areaFlag+","+dataPos+","+subDataPos+","+listPos+","+listCurrPage+",2,"+menuPos + "&url=" + toUrl;
				else 
					document.location="HD_saveCurrFocus.jsp?currFocus="+areaFlag+","+dataPos+","+subDataPos+","+listPos+","+listCurrPage+",3,"+menuPos + "&url=" + toUrl;
			}
			
			break;
		case "KEY_PAGE_UP":
			if(areaFlag==2){
			 changeListPage(-1)
			} 
			break;
		case "KEY_PAGE_DOWN":
			if(areaFlag==2){
			 changeListPage(1);
			} 
			break;
		case "KEY_EXIT":
			iPanel.mainFrame.location.href="HD_vod.jsp";
			break;
		case "KEY_BACK":
			document.location = backUrl;
			break;
	}
}
function changeListFocusLR(num){// 左右按键
	if((listPos+num+listCurrPage*12)>listLength-1) return;
	if((listPos+1)%4 == 0 && num > 0) return;
	else if(listPos%4 == 0 && num<0){ 
		changeArea(-1);
		return;
	}
	$("text"+listPos).innerText=menuList[dataPos].CHILDINFO[subDataPos].CATEGORYDATA[0].sub[listCurrPage*12+listPos].name.substr(0,6);
	$("text"+listPos).style.paddingTop="0px";
	$("bgPic"+listPos).src = "images/vod/movie0.png";
	$("list"+listPos).style.webkitTransform = "scale(1)";
	$("text"+listPos).style.color = "#393939";
	listPos += num;
	$("listFocus").style.left = -26+242*(listPos%4)+"px";
	$("bgPic"+listPos).src = "images/vod/movie1.png";
	$("list"+listPos).style.webkitTransform = "scale(1.15)";
	$("text"+listPos).style.color = "#ffffff";
	$("text"+listPos).style.paddingTop="18px";
	// $("text"+listPos).innerHTML="<marquee>"+menuList[dataPos].CHILDINFO[subDataPos].CATEGORYDATA[0].sub[listCurrPage*12+listPos].name+"</marquee>";
	if(menuList[dataPos].CHILDINFO[subDataPos].CATEGORYDATA[0].sub[listCurrPage*12+listPos].name.length>6){
		$("text"+listPos).innerHTML="<marquee>"+menuList[dataPos].CHILDINFO[subDataPos].CATEGORYDATA[0].sub[listCurrPage*12+listPos].name+"</marquee>";
	}else{
		$("text"+listPos).style.paddingTop="0px";
		$("text"+listPos).innerText=menuList[dataPos].CHILDINFO[subDataPos].CATEGORYDATA[0].sub[listCurrPage*12+listPos].name.substr(0,6);
	}	
}


function changeListFocusUD(num){// 上下按键
	if((listPos >= 8 && num > 0)||(listPos<4 && num<0) ||(listPos+num*4+listCurrPage*12)>listLength-1){// 翻页
		if(listSumPage > 1){
			$("listFocus").style.webkitTransitionDuration = "0ms";
			$("listFocus").style.opacity = 0;
			for(var i=0; i<12; i++){
				$("list"+i).style.webkitTransitionDuration = "0ms";
				$("list"+i).style.opacity = 0;
			}
			$("text"+listPos).innerText=menuList[dataPos].CHILDINFO[subDataPos].CATEGORYDATA[0].sub[listCurrPage*12+listPos].name.substr(0,6);
			$("text"+listPos).style.paddingTop="0px";	
			if(listPos != 0){
				$("listFocus").style.top = "-25px";
				$("listFocus").style.left = "-26px";

				$("bgPic"+listPos).src = "images/vod/movie0.png";
				$("list"+listPos).style.webkitTransform = "scale(1)";
				$("text"+listPos).style.color = "#393939";
				listPos = 0;

				$("list"+listPos).style.webkitTransform = "scale(1.15)";
				$("bgPic"+listPos).src = "images/vod/movie1.png";
				$("text"+listPos).style.color = "#ffffff";
			}
			changeListPage(num);
		}
		}else{
			$("bgPic"+listPos).src = "images/vod/movie0.png";
			$("list"+listPos).style.webkitTransform = "scale(1)";
			$("text"+listPos).style.color = "#393939";
			$("text"+listPos).style.paddingTop="0px";
			$("text"+listPos).innerText=menuList[dataPos].CHILDINFO[subDataPos].CATEGORYDATA[0].sub[listCurrPage*12+listPos].name.substr(0,6);
			listPos += num*4;
			$("listFocus").style.top = (-25+194*Math.floor(listPos/4))+"px";
			$("bgPic"+listPos).src = "images/vod/movie1.png";
			$("list"+listPos).style.webkitTransform = "scale(1.15)";
			$("text"+listPos).style.color = "#ffffff";
		// var textstr=$("text"+listPos).innerText;
			$("text"+listPos).style.paddingTop="18px";
			if(menuList[dataPos].CHILDINFO[subDataPos].CATEGORYDATA[0].sub[listCurrPage*12+listPos].name.length>6){
				$("text"+listPos).innerHTML="<marquee>"+menuList[dataPos].CHILDINFO[subDataPos].CATEGORYDATA[0].sub[listCurrPage*12+listPos].name+"</marquee>";
			}else{
				$("text"+listPos).style.paddingTop="0px";
				$("text"+listPos).innerText=menuList[dataPos].CHILDINFO[subDataPos].CATEGORYDATA[0].sub[listCurrPage*12+listPos].name.substr(0,6);
			}	
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

	if (((typeof menuList[dataPos].CHILDINFO[subDataPos].CATEGORYDATA[0].sub[listCurrPage*12+1]) == "undefined")) {
		requestData(listCurrPage);
	} else {
		showMovieList();
	}
}

var pageNumber	=	5;
function requestData(listCurrPage) {
	var temp = Math.floor(parseInt(listCurrPage/pageNumber));
	var url = "HD_vodCategoryData.jsp?TYPE_ID="+menuList[dataPos].CHILDINFO[subDataPos].CATEGORYID+"&PAGE="+ temp;
	var ajax = new AJAX_OBJ(url, appendData);
	ajax.requestData();	
}

function appendData(xmlHttp) {
	var appdata = 	eval(xmlHttp.responseText);
	var length	=	appdata[0].sub.length;
	var temp_flag = Math.floor(parseInt(listCurrPage/pageNumber));
	var temp_shown = temp_flag*pageNumber*12;
	
	for(var i=0;i<length; i++) {
		menuList[dataPos].CHILDINFO[subDataPos].CATEGORYDATA[0].sub[temp_shown+i]	 = appdata[0].sub[i];
	}
	
	if(listCurrPage > listSumPage-1)
		listCurrPage = 0;
	else if(listCurrPage < 0)
		listCurrPage = listSumPage-1;
	showMovieList();
}


function changeArea(num){
	if(areaFlag == 0 && num > 0 && menuList[dataPos].CHILDINFO.length > 0 && menuList[dataPos].CHILDINFO[subDataPos].LEVEL != 2){
		
		// 更替二级分类和三级分类光标
		$("menuFocus0").style.webkitTransitionDuration = "300ms";
		$("menuFocus1").style.webkitTransitionDuration = "300ms";
		$("menuFocus0").style.backgroundImage = "url(images/vod/focus01.png)";
		areaFlag = 1;
		$("menuFocus1").style.backgroundImage = "url(images/vod/focus10.png)";
		$("menu0").style.left = "-214px";
		$("content0").style.left = "-211px";
		var notes1=$("content0").childNodes;
		for(var m=0;m<notes1.length;m++){
			notes1[m].style.webkitTransitionDuration = "300ms";
			notes1[m].style.left = "-5px";
		}
		$("menuFocus0").style.left = "-210px";
		$("menu1").style.left = "13px";
		$("content1").style.left = "13px";
		var notes=$("content1").childNodes;
		for(var m=0;m<notes.length;m++){
			notes[m].style.webkitTransitionDuration = "300ms";
			notes[m].style.left = "-12px";
		}
		$("menuFocus1").style.left = "14px";
		$("tubiao").src = "images/vod/left.png";
		clearTimeout(movieListTimeout);
		movieListTimeout = setTimeout("getListTimeout()",150);
	}else if((areaFlag == 1 || menuList[dataPos].CHILDINFO[subDataPos].LEVEL == 2 ) && (areaFlag != 2)){
		if(num > 0){
			if(menuList[dataPos].CHILDINFO[subDataPos].CATEGORYDATA.length > 0){
					focusFlag = true;
					if(menuList[dataPos].CHILDINFO[subDataPos].CATEGORYDATA[0].sub.length > 0){
							if(menuList[dataPos].CHILDINFO[subDataPos].LEVEL == 2)
								$("menuFocus0").style.backgroundImage = "url(images/vod/focus01.png)";
							else 
								$("menuFocus1").style.backgroundImage = "url(images/vod/focus11.png)";
							areaFlag = 2;
							$("listFocus").style.opacity = 1;
							$("bgPic"+listPos).src = "images/vod/movie1.png";
							$("list"+listPos).style.webkitTransform = "scale(1.15)";
							$("text"+listPos).style.color = "#ffffff";
							$("text"+listPos).style.paddingTop="18px";
							// $("text"+listPos).innerHTML="<marquee>"+menuList[dataPos].CHILDINFO[subDataPos].CATEGORYDATA[0].sub[listCurrPage*12+listPos].name+"</marquee>";
							if(menuList[dataPos].CHILDINFO[subDataPos].CATEGORYDATA[0].sub[listCurrPage*12+listPos].name.length>6){
								$("text"+listPos).innerHTML="<marquee>"+menuList[dataPos].CHILDINFO[subDataPos].CATEGORYDATA[0].sub[listCurrPage*12+listPos].name+"</marquee>";
							}else{
								$("text"+listPos).style.paddingTop="0px";
								$("text"+listPos).innerText=menuList[dataPos].CHILDINFO[subDataPos].CATEGORYDATA[0].sub[listCurrPage*12+listPos].name.substr(0,6);
							}		
						}
			}else{
					getMovieListData(menuList[dataPos].CHILDINFO[subDataPos].CATEGORYID,0);
				// $("menuFocus1").style.left="-218px";
			}
		}else{
			$("menuFocus0").style.left = "-34px";
			$("menuFocus1").style.left = "187px";
			$("menuFocus0").style.webkitTransitionDuration = "300ms";
			$("menuFocus1").style.webkitTransitionDuration = "300ms";
			$("menuFocus1").style.backgroundImage = "url(images/vod/focus11.png)";
			areaFlag = 0;
			$("menuFocus0").style.backgroundImage = "url(images/vod/focus00.png)";
			$("menu0").style.left = "-42px";
			$("content0").style.left = "-268px";
			var notes1=$("content0").childNodes;
			for(var m=0;m<notes1.length;m++){
				notes1[m].style.webkitTransitionDuration = "300ms";
				// notes1[m].style.left = "0px";
				notes1[m].style.left = "221px";
			}
			$("menuFocus0").style.left = "-34px";
			$("menu1").style.left = "185px";
			$("menuFocus1").style.left = "187px";
			$("content1").style.left = "-52px";
			var notes=$("content1").childNodes;
			for(var m=0;m<notes.length;m++){
				notes[m].style.webkitTransitionDuration = "300ms";
				// notes[m].style.left = "0px";
				notes[m].style.left = "221px";
			}
			$("tubiao").src = "images/vod/global_tm.gif";
		}
	}else if(areaFlag == 2 && num < 0){
		if(menuList[dataPos].CHILDINFO[subDataPos].LEVEL == 2) {
			areaFlag = 0;
			$("menuFocus0").style.backgroundImage = "url(images/vod/focus00.png)";
		}else { 
			areaFlag = 1;
			$("menuFocus1").style.backgroundImage = "url(images/vod/focus10.png)";
		}
		$("listFocus").style.opacity = 0;
		$("bgPic"+listPos).src = "images/vod/movie0.png";
		$("list"+listPos).style.webkitTransform = "scale(1)";
		$("text"+listPos).style.paddingTop="0px";
		$("text"+listPos).innerText=menuList[dataPos].CHILDINFO[subDataPos].CATEGORYDATA[0].sub[listCurrPage*12+listPos].name.substr(0,6);
		$("text"+listPos).style.color = "#393939";
	}
	
	$("midDiv").style.webkitTransitionDuration = "300ms";
	if(areaFlag == 0 && menuList[dataPos].CHILDINFO[subDataPos].LEVEL != 2){
		$("midDiv").style.visibility = "visible";
	}else{
		$("midDiv").style.visibility = "hidden";
	}
}

// 响应二级导航栏上下光标移动
function changeMenu(num){
	if((menu0Box.dataPos == menuList.length-1 && num > 0)||(menu0Box.dataPos == 0 && num < 0)) return;
	//$("menuFocus0").style.webkitTransitionDuration = "200ms";
	menu0Box.duration = "200ms";
	menu0Box.changeList(num);
	dataPos=menu0Box.dataPos;
	menuPos=menu0Box.focusPos;
	var menuWhere = Math.floor(dataPos%9);// 记录焦点在哪个DIV上
	menuObj[menuWhere].style.color = "#393939";
	if(num>0){
		menuWhere==0?$("menu08").style.color = "#393939":$("menu0"+(menuWhere-1)).style.color = "#393939";
	}else{
		menuWhere==8?$("menu00").style.color = "#393939":$("menu0"+(menuWhere+1)).style.color = "#393939";
	}
	$("menu0"+menuWhere).style.color = "#ffffff";
	$("menuFocus1").style.webkitTransitionDuration = "0ms";
	clearTimeout(subMenuTimeout);
	subMenuTimeout = setTimeout("refreshSubMenuList()",400);
	showMenuUpOrDown();
	listCurrPage=0;
	initSubMenuDiv();
}

function showMenuUpOrDown(){
	if(menu0Box.dataPos==0){
		 $("up0").style.visibility="hidden";
		 $("down0").style.visibility="visible";			
	}	
	else if(menu0Box.dataPos== menuList.length-1){
		 $("down0").style.visibility="hidden";
		 $("up0").style.visibility="visible";
	}	
	else{
		$("up0").style.visibility="visible";
		 $("down0").style.visibility="visible";
	}	
	if(menuList.length<8) {
	   $("down0").style.visibility="hidden";
	}
}	

// 显示三级导航栏上下翻页按钮
function showSubMenuUpOrDown(){
	if(subBox.dataPos==0){
		$("up1").style.visibility="hidden";
		$("down1").style.visibility="visible";			
	}	
	else if(subBox.dataPos== menuList[dataPos].CHILDINFO.length-1 ){
		$("down1").style.visibility="hidden";
		$("up1").style.visibility="visible";
	}	
	else{
		$("up1").style.visibility="visible";
		$("down1").style.visibility="visible";
	}	
	if(menuList[menu0Box.dataPos].CHILDINFO.length<8) {
	   $("down1").style.visibility="hidden";
	}
}

function initSubMenuDiv(){// 初始化二级菜单的位置
	for(var m=0;m<9;m++){
		$("menu1"+m).style.webkitTransitionDuration = "0ms";
		$("menu1"+m).style.top=20+m*70;
	}
}
function refreshSubMenuList(){
	var menu1Where=Math.floor(subBox.dataPos%9);// 记录焦点在哪个DIV上
	if(menu1Where != 0){ $("menu1"+menu1Where).style.color = "#B3B3B3"; }
	subDataPos = 0;
	initSubMenuData();
	$("menu1"+subBox.focusPos).style.color = "#ffffff";
	$("menuFocus1").style.top = (78+subPos*70)+"px";	
}
function changeSubMenu(num){
	if((subBox.dataPos==menuList[dataPos].CHILDINFO.length-1 && num>0)||(subBox.dataPos==0 && num<0)) return;
	$("menuFocus1").style.webkitTransitionDuration = "200ms";
	subBox.duration = "200ms";
	subBox.changeList(num);
	subDataPos=subBox.dataPos;
	subPos=subBox.focusPos;
	var menu1Where=Math.floor(subBox.dataPos%9);// 记录焦点在哪个DIV上
	if(num>0){
		menu1Where==0?$("menu18").style.color = "#B3B3B3":$("menu1"+(menu1Where-1)).style.color = "#B3B3B3";
	}else{
		menu1Where==8?$("menu10").style.color = "#B3B3B3":$("menu1"+(menu1Where+1)).style.color = "#B3B3B3";
	}
	$("menu1"+menu1Where).style.color = "#ffffff";
	clearTimeout(movieListTimeout);
	listCurrPage=0;
	movieListTimeout = setTimeout("getListTimeout()",250);
}
var params = [];
var categorylevel	=	3;

function init(){
	var childId = "<%=childId%>";
	if(myArray[0]==null){
	    areaFlag = 0;
		if(childId != ""){ areaFlag = 1;}
	  	dataPos = 0;
	  	subDataPos = 0;
	  	listPos = 0;
	  	listCurrPage = 0;
	}else{
	  	areaFlag = parseInt(myArray[0]);
	  	dataPos = parseInt(myArray[1]);
	  	subDataPos = parseInt(myArray[2]);
	  	listPos = parseInt(myArray[3]);
	  	listCurrPage = parseInt(myArray[4]);
	  	categorylevel = parseInt(myArray[5]);
		menuFocusPos = parseInt(myArray[6]);
	}
	/*规避残影问题*/
	$("menuFocus0").style.left = "-34px";
	if(areaFlag==0){
		//$("midDiv").style.visibility = "visible";
		$("menu0").style.visibility="visible";
		$("menuFocus1").style.left = "187px";
	}else{
		//$("menuFocus0").style.left = "-210px";
		$("menuFocus0").style.visibility = "hidden";
		$("menuFocus1").style.left = "14px";
	}
	params = window.location.search.substring(1).split("&");
	var url = "HD_vodCategoryTreeData.jsp?TYPE_ID=" + params[0].split("=")[1]+"&METHOD=config";
	var ajax = new AJAX_OBJ(url, getMenuData);
	ajax.requestData();	
	initPosition();
}

function initPosition(){
	if (categorylevel == 2) {
		$("midDiv").style.visibility = "hidden";
		$("menu0").style.left = "-42px";
		$("menu1").style.visibility = "hidden";
		$("content0").style.left = "-34px";
		$("menuFocus0").style.left = "-34px";
		$("menuFocus0").style.visibility = "hidden";
		$("menuFocus1").style.visibility = "hidden";
	} else {
		if(areaFlag != 0){
			$("midDiv").style.visibility = "hidden";
			$("menu1").style.visibility="hidden";
			$("content1").style.visibility="hidden";
			$("menuFocus1").style.visibility = "hidden";
			$("menu0").style.left = "-42px";
		}
		if(params.length == 2){
			for(var i=0; i<8; i++){
				if(menuList[i].CATEGORYID == params[1].split("=")[1]){
					menuPos = i;
					break;
				}
			}
			$("tubiao").src = "images/vod/left.png";
		}
		if(areaFlag==2){
			$("menu0").style.left = "-214px";
			$("menu1").style.left = "13px";
		}
	}
	
}

function initState(){
	var childId = "<%=childId%>";
	if(childId == ""){return "0";}
	for(var i=0;i<menuList.length;i++){
		if(childId == menuList[i].CATEGORYID) { return i.toString();}
	}
	return "0";
}

// 请求所有点播数据
function getMenuData(xmlHttp){
	eval("menuList=" + xmlHttp.responseText);
	initIdObj();
	if(areaFlag == 1) {dataPos = parseInt(initState());}
	//inPosition();
	if(menuList[dataPos].CHILDINFO[subDataPos].LEVEL != 2&&areaFlag==1){
		$("menu0").style.left = "-214px";
		$("menu1").style.left = "13px";
	}	
	initMenu();
	initSubMenuData();
	initMenuPosition();
	getListTimeout();
}

function getListTimeout(){
	if(menuList[dataPos].CHILDINFO[subDataPos].CATEGORYDATA.length <= 0) {
		getMovieListData(menuList[dataPos].CHILDINFO[subDataPos].CATEGORYID,0);
	} else if (menuList[dataPos].CHILDINFO.length == 0) {
		menuList[dataPos].CHILDINFO[subDataPos]	= {"CATEGORYDATA":[]};
		menuList[dataPos].CHILDINFO[subDataPos]	= {"LEVEL":2};
		getMovieListData(menuList[dataPos].CATEGORYID,0);
	} else { 
		initMovieList();
	}
}

// 请求三级分类下的所有vod数据
function getMovieListData(typeId,page){
	var url = "HD_vodCategoryData.jsp?TYPE_ID="+typeId+"&PAGE="+page;
	var ajax = new AJAX_OBJ(url, getListData);
	ajax.requestData();	
}

// 装在三级分类至CATEGORYDATA;
function getListData(xmlHttp){
	menuList[dataPos].CHILDINFO[subDataPos].CATEGORYDATA = eval(xmlHttp.responseText);
	initMovieList();
}

// 初始化点播数据
function initMovieList(){
	if (menuList[dataPos].CHILDINFO[subDataPos].LEVEL == 2) 
		$("title").innerText = "点播—"+menuList[dataPos].CATEGORYFULLNAME;
	else
		$("title").innerText = "点播—"+menuList[dataPos].CATEGORYFULLNAME+"—"+menuList[dataPos].CHILDINFO[subDataPos].CATEGORYFULLNAME;
	
	if(listPos != 0&&focusFlag){
		focusFlag = false;
		listPos = 0;
		$("listFocus").style.top = "-25px";
	}
	listLength = menuList[dataPos].CHILDINFO[subDataPos].CATEGORYDATA[0].count;
	listSumPage = Math.floor((listLength-1)/12)+1;
	showMovieList();
}

// 显示点播vod列表
function showMovieList(){
	if(listSumPage<2){
			$("page").innerText ="1/1页";
			$("upSign").style.visibility="hidden";
			$("downSign").style.visibility="hidden";
	}else{	
			$("upSign").style.visibility="visible";
			$("downSign").style.visibility="visible";
			$("page").innerText = (listCurrPage+1)+"/"+listSumPage+"页";
	}
	showSubMenuUpOrDown();
	$("listFocus").style.webkitTransitionDuration = "200ms";
	if(areaFlag == 2) $("listFocus").style.opacity = 1;
	for(var i=listCurrPage*12; i<(listCurrPage+1)*12; i++){
		if(i < listLength){
			$("list"+i%12).style.webkitTransitionDuration = "0ms";
			$("list"+i%12).style.opacity = 1;
			imgObj[i%12].src = menuList[dataPos].CHILDINFO[subDataPos].CATEGORYDATA[0].sub[i].pic;
			textObj[i%12].innerText = menuList[dataPos].CHILDINFO[subDataPos].CATEGORYDATA[0].sub[i].name.substr(0,6);
			$("list"+i%12).style.webkitTransitionDuration = "300ms";
		}else{
			$("list"+i%12).style.webkitTransitionDuration = "0ms";
			$("list"+i%12).style.opacity = 0;
			$("list"+i%12).style.webkitTransitionDuration = "300ms";
		}
	}
	
	if(areaFlag==2) {
		$("text"+listPos).style.paddingTop="18px";
		if(menuList[dataPos].CHILDINFO[subDataPos].CATEGORYDATA[0].sub[listCurrPage*12+listPos].name.length>6){
			$("text"+listPos).innerHTML="<marquee>"+menuList[dataPos].CHILDINFO[subDataPos].CATEGORYDATA[0].sub[listCurrPage*12+listPos].name+"</marquee>";
		}else{
			$("text"+listPos).style.paddingTop="0px";
			$("text"+listPos).innerText=menuList[dataPos].CHILDINFO[subDataPos].CATEGORYDATA[0].sub[listCurrPage*12+listPos].name.substr(0,6);
		}	
	}
}

var menu1High = 70;
var menu1Size = 8;
var duration = "0ms";
var startPlace = 78;
var menu1Info = {
	firstPos:{top:"20px", left:"221px"},// 第一个位置, 第一个参数为它的top， 第二个为left 值
	lastPos:{top:"510px", left:"221px"},	// 最后一个位置
	firstStatus:{top:"-50px", left:"221px"},	// 第一个之前的状态位置
	endStatus:{top:"580px", left:"221px"}			// 最后一个之后的位置
};
var menu1=["menu10","menu11","menu12","menu13","menu14","menu15","menu16","menu17","menu18"];

var noSubmenu=false;
function initSubMenuData(){
	subMenuLength = menuList[dataPos].CHILDINFO.length;
	if (subMenuLength > 0 &&  menuList[dataPos].CHILDINFO[subDataPos].LEVEL != 2 ) {
		noSubmenu=false;
		$("menu1").style.visibility		=	"visible";
		$("content1").style.visibility="visible";
		$("menuFocus1").style.visibility="visible";
		$("menuFocus1").style.left = "187px";
		$("content1").style.left="-52px";
		var notes=$("content1").childNodes;
		for(var m=0;m<notes.length;m++){
			notes[m].style.webkitTransitionDuration = "0ms";
			notes[m].style.left = "221px";
		}
		$("content0").style.left="-268px";
		var notes1=$("content0").childNodes;
		for(var m=0;m<notes.length;m++){
			notes1[m].style.webkitTransitionDuration = "0ms";
			notes1[m].style.left = "221px";
		}
		if(areaFlag == 0)
			$("midDiv").style.visibility 	= 	"visible";
		subSumPage = Math.floor((subMenuLength-1)/menu1Size)+1;
		var args={dataLength:subMenuLength, listSize:menu1Size, listHigh:menu1High, showFlag:1, duration:duration, startPlace:startPlace, dataPos:subDataPos};
		subBox =new showList_2D(args);	
		subBox.posInfo = menu1Info;	// 记住四个状态值
		subBox.focusDiv = "menuFocus1";		// 焦点的名称
		subBox.arrayList = menu1;		// 列表的ID
		subBox.haveData = showListData;	
		subBox.noData = clearListData;
		subBox.startShow();
		subPos = subBox.focusPos;
	} else {
		$("menu0").style.left = "-42px";
		$("menu1").style.visibility		=	"hidden";
		$("content1").style.visibility="hidden";
		$("midDiv").style.visibility 	= 	"hidden";
		$("menuFocus1").style.visibility="hidden";
		//$("content0").style.left="-268px";
		noSubmenu=true;
		getListTimeout();
	}
	showSubMenuUpOrDown();
}
function showListData(List){ subObj[List.idPos].innerText = menuList[dataPos].CHILDINFO[List.dataPos].CATEGORYFULLNAME.substr(0,5); }
function clearListData(List){	subObj[List.idPos].innerText = "";}

// 初始化参数对象
function initIdObj(){
	for(var i=0; i<12; i++){
		if(i<9){
			menuObj[i] = $("menu0"+i);
			subObj[i] = $("menu1"+i);
		}
		imgObj[i] = $("img"+i);
		textObj[i] = $("text"+i);
	}
}

var listHigh = 78;
var listSize = 8;
var startPlace1 = 54;
var menu0Info = {
	firstPos:{top:"0px", left:"221px"},// 第一个位置, 第一个参数为它的top， 第二个为left 值
	lastPos:{top:"546px", left:"221px"},	// 最后一个位置
	firstStatus:{top:"-78px", left:"221px"},	// 第一个之前的状态位置
	endStatus:{top:"624px", left:"221px"}			// 最后一个之后的位置
};
var menu0=["menu00","menu01","menu02","menu03","menu04","menu05","menu06","menu07","menu08"];

function initMenu(){
	var menuLength=menuList.length;
	var args={dataLength:menuLength, listSize:listSize, listHigh:listHigh, showFlag:1, duration:duration, startPlace:startPlace1, dataPos:0};
	menu0Box =new showList_2D(args);	
	menu0Box.posInfo = menu0Info;	// 记住四个状态值
	menu0Box.focusDiv = "menuFocus0";		// 焦点的名称
	menu0Box.arrayList = menu0;		// 列表的ID
	menu0Box.haveData = showMenu0Data;	
	menu0Box.noData = clearMenu0Data;
	menu0Box.startShow();
	if(areaFlag==1){
		for(var i=0;i<dataPos;i++){
			menu0Box.changeList(1);
			//dataPos=menu0Box.dataPos;
		}
	}	
	if(areaFlag==2){
		if(dataPos!=menuFocusPos){
			dataPos=dataPos+7-menuFocusPos;
			for(var i=0;i<dataPos;i++){
				menu0Box.changeList(1);
			}
			if(menuFocusPos<7){
				for(var i=0;i<7-menuFocusPos;i++){
					menu0Box.changeList(-1);
				}
			}
		}else{
			for(var i=0;i<dataPos;i++){
				menu0Box.changeList(1);
			}
		}	
		
		//}	
	}	
	dataPos=menu0Box.dataPos;
	menuPos=menu0Box.focusPos;
	//$("menu0"+menuPos).style.color = "#ffffff";
   
}

function showMenu0Data(List){	
	menuObj[List.idPos].innerText=menuList[List.dataPos].CATEGORYNAME;
 }
function clearMenu0Data(List){ menuObj[List.idPos].innerText="";}
function initMenuPosition(){
	$("menu0").style.visibility = "visible";
	if(areaFlag == 0){
		$("midDiv").style.webkitTransitionDuration="300ms";
		$("midDiv").style.visibility = "visible";
		$("menuFocus1").style.top = (78+subPos*70)+"px";
		$("menuFocus0").style.left = "-34px";
		$("menuFocus1").style.left = "187px";
		menuObj[menuPos].style.color = "#ffffff";
		subObj[subPos].style.color = "#ffffff";
	}else if(areaFlag == 1){
		//$("menuFocus0").style.top = (54+menuPos*78)+"px";
		$("menuFocus1").style.top = (78+subPos*70)+"px";
		$("menuFocus0").style.visibility="visible";
		if(noSubmenu){
			 $("menuFocus0").style.backgroundImage = "url(images/vod/focus10.png)";
			 $("content0").style.left = "-268px";
			 $("menuFocus0").style.webkitTransitionDuration = "0ms";
			 $("menuFocus0").style.left = "-34px";
			 $("menu1").style.left="185px";
			 areaFlag=0;
		}	 
		else{
			 $("menu1").style.visibility="visible";
			 $("content1").style.visibility="visible";
			 $("content0").style.left = "-211px";
			 $("menuFocus0").style.left = "-210px";
			 $("menuFocus0").style.backgroundImage = "url(images/vod/focus01.png)";
			 $("menuFocus1").style.backgroundImage = "url(images/vod/focus10.png)";
			  areaFlag=1;
		}	 
		$("menuFocus1").style.left = "14px";
		var notes1=$("content0").childNodes;
		for(var m=0;m<notes1.length;m++){
			notes1[m].style.webkitTransitionDuration = "0ms";
			if(noSubmenu) notes1[m].style.left = "211px";	
			else notes1[m].style.left = "-5px";	
		}
		$("content1").style.left = "13px";
		var notes=$("content1").childNodes;
		for(var m=0;m<notes.length;m++){
			notes[m].style.webkitTransitionDuration = "0ms";
			notes[m].style.left = "-12px";
		}
		if(dataPos>7)  menuObj[dataPos%9].style.color = "#ffffff";
		else menuObj[menuPos].style.color = "#ffffff";
		subObj[subPos].style.color = "#ffffff";
	}else if(areaFlag == 2){
		$("menuFocus0").style.backgroundImage = "url(images/vod/focus01.png)";
		//$("menuFocus0").style.top = (54+menuPos*78)+"px";
		$("menuFocus1").style.top = (78+subPos*70)+"px";
		 menuObj[dataPos%9].style.color = "#ffffff";
		//else menuObj[menuPos].style.color = "#ffffff";
		subObj[subPos].style.color = "#ffffff";
		$("bgPic"+listPos).src = "images/vod/movie1.png";
		$("text"+listPos).style.color = "#ffffff";
		$("content1").style.left = "13px";
		$("menuFocus1").style.left = "14px";
		$("menuFocus0").style.visibility = "visible";
		if(categorylevel == 2){
			$("content0").style.left = "-34px";
			$("menuFocus0").style.left = "-34px";	
			$("menu1").style.left="185px";	
		}	
		else{
			$("content0").style.left = "-221px";
			$("menuFocus0").style.left = "-210px";
			$("menu1").style.visibility="visible";
			$("content1").style.visibility="visible";
		}
		var notes1=$("content0").childNodes;
		for(var m=0;m<notes1.length;m++){
			notes1[m].style.left = "-5px";
		}
		var notes=$("content1").childNodes;
		for(var m=0;m<notes.length;m++){
			notes[m].style.left = "-12px";
		}
		$("list"+listPos).style.webkitTransform = "scale(1.15)";
		$("listFocus").style.opacity = 1;
		$("listFocus").style.left = -26+242*(listPos%4)+"px";
		$("listFocus").style.top = (-25+194*Math.floor(listPos/4))+"px";
	}
	 showMenuUpOrDown();
	$("menu0").style.webkitTransitionDuration = "300ms";
	$("menu1").style.webkitTransitionDuration = "300ms";
	//$("content0").style.webkitTransitionDuration = "300ms";
	//$("content1").style.webkitTransitionDuration = "300ms";
	//duration="200ms";
	var notes=$("content1").childNodes;
	for(var m=0;m<notes.length;m++){
		notes[m].style.webkitTransitionDuration = "300ms";
	}
	var notes1=$("content0").childNodes;
	for(var m=0;m<notes1.length;m++){
		notes1[m].style.webkitTransitionDuration = "300ms";
	}
	$("menuFocus0").style.webkitTransitionDuration = "300ms";	
	$("menuFocus1").style.webkitTransitionDuration = "300ms";
	$("listDiv").style.webkitTransitionDuration = "200ms";
	$("midDiv").style.webkitTransitionDuration = "300ms";
	for(var i=0; i<12; i++)
	$("list"+i).style.webkitTransitionDuration = "200ms";
}
</script>
</head>
<body topmargin="0" leftmargin="0" onLoad="init()" scroll="no">
<div id="bodybackground"></div>
<div id="menu0">
	<div id="line0">
	<table height="471" width="231" border="0" cellpadding="0" cellspacing="0">
	 <tr height="3"><td class="style1"></td></tr><tr height="75"><td ></td></tr> 
	 <tr height="3"><td class="style1"></td></tr><tr height="75"><td></td></tr>
	 <tr height="3"><td class="style1"></td></tr><tr height="75"><td></td></tr>
	 <tr height="3"><td class="style1"></td></tr><tr height="75"><td></td></tr>
	 <tr height="3"><td class="style1"></td></tr><tr height="75"><td></td></tr>
	 <tr height="3"><td class="style1"></td></tr><tr height="75"><td></td></tr>
	 <tr height="3"><td class="style1"></td></tr>
	</table>
	</div>
	<div id="up0"></div>
	<div id="down0"></div>
</div>	
	<div id="content0" style="overflow:hidden">
		<div id="menu00" style="position:absolute;left:221px;top:0px;" class="style0"></div>
		<div id="menu01" style="position:absolute;left:221px;top:78px;" class="style0"></div>
		<div id="menu02" style="position:absolute;left:221px;top:156px;" class="style0"></div>
		<div id="menu03" style="position:absolute;left:221px;top:234px;" class="style0"></div>
		<div id="menu04" style="position:absolute;left:221px;top:312px;" class="style0"></div>
		<div id="menu05" style="position:absolute;left:221px;top:390px;" class="style0"></div>
		<div id="menu06" style="position:absolute;left:221px;top:468px;" class="style0"></div>
		<div id="menu07" style="position:absolute;left:221px;top:546px;" class="style0"></div>
		<div id="menu08" style="position:absolute;left:221px;top:624px;" class="style0"></div> 
  </div>
  <div id="menuFocus0"></div>

<div id="menu1" >
	<div id="up1"></div>
	<div id="down1"></div>
</div>	
	<div id="content1"  style="overflow:hidden">
		<div id="menu10" style="position:absolute;left:221px;top:20px;height:70px;" class="style2"></div>
		<div id="menu11" style="position:absolute;left:221px;top:90px;height:70px;" class="style2"></div>
		<div id="menu12" style="position:absolute;left:221px;top:160px;height:70px;" class="style2"></div>
		<div id="menu13" style="position:absolute;left:221px;top:230px;height:70px;" class="style2"></div>
		<div id="menu14" style="position:absolute;left:221px;top:300px;height:70px;" class="style2"></div>
		<div id="menu15" style="position:absolute;left:221px;top:370px;height:70px;" class="style2"></div>
		<div id="menu16" style="position:absolute;left:221px;top:440px;height:70px;" class="style2"></div>
		<div id="menu17" style="position:absolute;left:221px;top:510px;height:70px;" class="style2"></div>
		<div id="menu18" style="position:absolute;left:221px;top:580px;height:70px;" class="style2"></div> 
</div>
	<div id="menuFocus1"><img id="tubiao" style="position:absolute; left: 4px; top: 19px;" src="images/vod/global_tm.gif" height="34" width="19" /></div>
<div id="midDiv"></div>
<div id="listDiv">
	<div id="list0" class="style3"><img id="bgPic0" src="images/vod/movie0.png" width="162" height="162" /><img id="img0" class="img" src="" /><div class="text"><table width="100%" height="100%"><tr><td id="text0"style="text-align:center; line-height:34px; font-size:22px; color:#393939;overflow:hidden";  width="100%" height="100%" valign="middle"></td></tr></table></div></div>
	<div id="list1" class="style3"><img id="bgPic1" src="images/vod/movie0.png" width="162" height="162" /><img id="img1" class="img" src="" /><div class="text"><table width="100%" height="100%"><tr><td id="text1"style="text-align:center; line-height:34px; font-size:22px; color:#393939;overflow:hidden";  width="100%" height="100%" valign="middle"></td></tr></table></div></div>
	<div id="list2" class="style3"><img id="bgPic2" src="images/vod/movie0.png" width="162" height="162" /><img id="img2" class="img" src="" /><div class="text"><table width="100%" height="100%"><tr><td id="text2" style="text-align:center; line-height:34px; font-size:22px; color:#393939;overflow:hidden";  width="100%" height="100%" valign="middle"></td></tr></table></div></div>
	<div id="list3" class="style3"><img id="bgPic3" src="images/vod/movie0.png" width="162" height="162" /><img id="img3" class="img" src="" /><div class="text"><table width="100%" height="100%"><tr><td id="text3" style="text-align:center; line-height:34px; font-size:22px; color:#393939;overflow:hidden";  width="100%" height="100%" valign="middle"></td></tr></table></div></div>
	<div id="list4" class="style3"><img id="bgPic4" src="images/vod/movie0.png" width="162" height="162" /><img id="img4" class="img" src="" /><div class="text"><table width="100%" height="100%"><tr><td id="text4" style="text-align:center; line-height:34px; font-size:22px; color:#393939;overflow:hidden";  width="100%" height="100%" valign="middle"></td></tr></table></div></div>
	<div id="list5" class="style3"><img id="bgPic5" src="images/vod/movie0.png" width="162" height="162" /><img id="img5" class="img" src="" /><div class="text"><table width="100%" height="100%"><tr><td id="text5" style="text-align:center; line-height:34px; font-size:22px; color:#393939;overflow:hidden";  width="100%" height="100%" valign="middle"></td></tr></table></div></div>
	<div id="list6" class="style3"><img id="bgPic6" src="images/vod/movie0.png" width="162" height="162" /><img id="img6" class="img" src="" /><div class="text"><table width="100%" height="100%"><tr><td id="text6" style="text-align:center; line-height:34px; font-size:22px; color:#393939;overflow:hidden";  width="100%" height="100%" valign="middle"></td></tr></table></div></div>
	<div id="list7" class="style3"><img id="bgPic7" src="images/vod/movie0.png" width="162" height="162" /><img id="img7" class="img" src="" /><div class="text"><table width="100%" height="100%"><tr><td id="text7" style="text-align:center; line-height:34px; font-size:22px; color:#393939;overflow:hidden";  width="100%" height="100%" valign="middle"></td></tr></table></div></div>
	<div id="list8" class="style3"><img id="bgPic8" src="images/vod/movie0.png" width="162" height="162" /><img id="img8" class="img" src="" /><div class="text"><table width="100%" height="100%"><tr><td id="text8" style="text-align:center; line-height:34px; font-size:22px; color:#393939;overflow:hidden";  width="100%" height="100%" valign="middle"></td></tr></table></div></div>
	<div id="list9" class="style3"><img id="bgPic9" src="images/vod/movie0.png" width="162" height="162" /><img id="img9" class="img" src="" /><div class="text"><table width="100%" height="100%"><tr><td id="text9" style="text-align:center; line-height:34px; font-size:22px; color:#393939;overflow:hidden";  width="100%" height="100%" valign="middle"></td></tr></table></div></div>
	<div id="list10" class="style3"><img id="bgPic10" src="images/vod/movie0.png" width="162" height="162" /><img id="img10" class="img" src="" /><div class="text"><table width="100%" height="100%"><tr><td id="text10" style="text-align:center; line-height:34px; font-size:22px; color:#393939;overflow:hidden";  width="100%" height="100%" valign="middle"></td></tr></table></div></div>
	<div id="list11" class="style3"><img id="bgPic11" src="images/vod/movie0.png" width="162" height="162" /><img id="img11" class="img" src="" /><div class="text"><table width="100%" height="100%"><tr><td id="text11" style="text-align:center; line-height:34px; font-size:22px; color:#393939; overflow:hidden";  width="100%" height="100%" valign="middle"></td></tr></table></div></div>
	<div id="listFocus"></div>
</div>
<div id="upSign"></div>
<div id="downSign"></div>
<div id="icon"></div>
<div id="title"></div>
<div id="page"></div>
</body>
</html>
