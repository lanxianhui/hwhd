<%@ include file="HD_preFocusElement.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="designer" content="meifk"  />
<meta name="page-view-size" content="1280*720" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>vod collect</title>
<style>
	*{margin:0; padding:0; font-size:20px;}
	body{background-color:transparent; background-image: url(images/vod/g_bg.jpg)}
    table{border-collapse:collapse;}
#menu{ background-image:url(images/vod/vodMenu1.png); background-repeat:no-repeat; height:684px; width:233px}
#menu div.menu{position:absolute; top:0; left:6px; width:212px; height:65px; color:#747474; font-family:黑体; font-size:32px;text-align:center; z-index:3;-webkit-transition-duration:0.3s;}
#menu div.focusbg{position:absolute; top:55px; left:-4px; width:220px; height:75px; background:url(images/collect/focus01.png) no-repeat; z-index:2}
#menu #menu0{top:77px;}
#menu #menu1{top:161px;}
#menutiltle{position:absolute; left:235px; top:15px; width:auto; height:59px; };
#capability{position:absolute;left:287px;width:356px;height:67px;color:#FFFFFF;font-family:黑体;font-size:30px;line-height:67px;top:11px;};
#information{ position:absolute; left:215px; top:80px; height:620px; width:1065px;}
#toppart{position:absolute; left:0px; width:1065px; height:35px; top:0px}
#toppart td{font-size:30px; color:#ffffff; font-family:黑体; height:35px}
#centerpart{ position:absolute; top:35px; height:550px; left:0px; width:1065px; overflow:hidden;visibility:hidden; }
#centerpart #centerBgimg{position:absolute; top:0px; height:110px; left:0px; width:1065px; z-index:0; background-image:url(images/collect/focusbg.png); background-repeat:no-repeat;-webkit-transition-duration:300ms; opacity:0}
#centerpart #centerFocus{position:absolute; top:0px; height:110px; left:0px; width:1065px; z-index:4; -webkit-transition-duration:300ms; visibility:hidden;}
#centerpart #centerFocus #imgfocus{position:absolute; top:10px; height:120px; left:38px; width:132px; background-image:url(images/collect/focus.png); background-repeat:no-repeat; }
#centerpart #centerFocus #focus1{position:absolute; top:3px; height:112px; left:788px; width:132px; background-image:url(images/collect/round.png); background-repeat:no-repeat; visibility:hidden; background-position:top}
#centerpart #centerFocus #focus2{position:absolute; top:3px; height:112px; left:870px; width:132px; background-image:url(images/collect/round.png); background-repeat:no-repeat; visibility:hidden; background-position:top }
#centerpart div{ font-family:黑体; font-size:30px; color:#393939}
#centerpart .proname{position:absolute; height:110px; left:180px; width:500px; text-align:left; z-index:3; line-height:110px; -webkit-transition-duration:300ms; visibility:hidden;}
#centerpart .play{position:absolute; height:110px; left:680px; width:170px; text-align:center; z-index:3;line-height:110px;-webkit-transition-duration:300ms;}
#centerpart .delete{position:absolute; height:110px; left:769px; width:170px; text-align:center; z-index:3;line-height:110px;-webkit-transition-duration:300ms; visibility:hidden;}
#centerpart #pic0{ position:absolute; top:0px; height:110px; left:0px; width:180px; z-index:3; text-align:center; padding-top:25px;background-image:url(images/collect/picture.png); background-position:47px 19px;background-repeat:no-repeat; visibility:hidden}
#centerpart #pic1{ position:absolute; top:110px; height:110px; left:0px; width:180px; z-index:3; text-align:center;padding-top:25px;background-image:url(images/collect/picture.png); background-position:47px 19px; background-repeat:no-repeat;visibility:hidden}
#centerpart #pic2{ position:absolute;top:220px;height:110px;left:0px; width:180px; z-index:3; text-align:center;padding-top:25px;background-image:url(images/collect/picture.png); background-position:47px 19px; background-repeat:no-repeat;visibility:hidden}
#centerpart #pic3{ position:absolute; top:330px; height:110px; left:0px; width:180px; z-index:3; text-align:center;padding-top:25px;background-image:url(images/collect/picture.png); background-position:47px 19px; background-repeat:no-repeat;visibility:hidden}
#centerpart #pic4{ position:absolute; top:440px; height:110px; left:0px; width:180px; z-index:3; text-align:center;padding-top:25px;background-image:url(images/collect/picture.png); background-position:47px 19px; background-repeat:no-repeat;visibility:hidden}
#centerpart #pic5{ position:absolute; top:550px; height:110px; left:0px; width:180px; z-index:3; text-align:center;padding-top:25px;background-image:url(images/collect/picture.png); background-position:47px 19px; background-repeat:no-repeat;visibility:hidden}
#downpart{position:absolute; left:0px; width:1065px; height:35px; top:585px};
#downpart td{font-size:20px;color:#FFFFFF; height:35px}
.td0{width:180px;text-align:center;  }
.td1{width:500px;text-align:left; }
.td3{width:340px;text-align:center; }
#readTips {-webkit-transform:scale(0);-webkit-transition-duration:300ms;z-index:5;}
#tip{position:absolute; top:120px; left:900px; width:180px; height:40px; color:white; background-color:blue; line-height:40px; font-size:24px; visibility:hidden; text-align:center;}
</style>
<script src="js/mini.js" type="text/javascript"></script>
<script type="text/javascript">
var flag=1;// 0 焦点左边菜单， 1 焦点在节目图片，2 焦点在播放，3 焦点在删除
var menuPos=0;
var inforPos=0;
var type=0;
var keysafeFlag=false;
var noData=true;
var menuSafeFlag=false;
function eventHandler(obj) {
	if(keysafeFlag) return;
	keysafeFlag = true;
	setTimeout(function(){keysafeFlag = false;}, 400);
	switch(obj.code) {
		case "KEY_UP":
			if(flag==0){
				if(menuPos==1){
					menuPos=0;
					changeMenufocus(-1);
					menuSafeFlag=true;		
				}	
			}else{
				changeInfor(-1);
			}
			break;
		case "KEY_DOWN":
			if(flag==0){
				if(menuPos==0){
					menuPos=1;
					menuSafeFlag=true;
					changeMenufocus(1);
				}	
			}else{
				changeInfor(1);
			}
			break;
		case "KEY_LEFT":
			if(menuSafeFlag) return;
			if(flag>0){
				flag--;
			}
			if(flag==0){
				$("menufocus").style.backgroundImage="url('images/collect/focus02.png')";
				$("imgfocus").style.backgroundImage="url()";
				picObj[inforPos%5].style.backgroundImage= "url(images/collect/picture.png)";
				$("pic"+inforPos%5).style.webkitTransform = "scale(1)";
				$("programname"+inforPos%5).style.color="#393939";
			    $("programname"+inforPos%5).style.fontSize="30px";
			}
			if(flag==1){
				$("imgfocus").style.backgroundImage="url('images/collect/focus.png')";
				//$("play"+inforPos%5).src="images/collect/play0.png";
				$("focus1").style.visibility="hidden";
				deleteObj[inforPos%5].style.webkitTransform = "scale(1)";
			}
			/*
			if(flag==1){
				//$("play"+inforPos%5).src="images/collect/play1.png";
				//$("delete"+inforPos%5).src="images/collect/delete0.png";
				$("focus1").style.visibility="visible";
				$("focus2").style.visibility="hidden";
				deleteObj[inforPos%5].style.webkitTransform = "scale(1)";
				playObj[inforPos%5].style.webkitTransform = "scale(1.25)";
			}
			*/
			break;
		case "KEY_RIGHT":
			if(menuSafeFlag) return;
			if(noData) return;
			if(flag<2){
				flag++;
			}
			if(flag==1){
				$("menufocus").style.backgroundImage="images/collect/focus01.png";
				$("imgfocus").style.backgroundImage="url('images/collect/focus.png')";
				picObj[inforPos%5].style.backgroundImage= "url()";
				$("pic"+inforPos%5).style.webkitTransform = "scale(1.25)"
				$("programname"+inforPos%5).style.color="#ffffff";
			    $("programname"+inforPos%5).style.fontSize="35px";
			}
			if(flag==2){
				//$("play"+inforPos%5).src="images/collect/play1.png";
				$("focus1").style.visibility="visible";
				$("imgfocus").style.backgroundImage="url()";
				deleteObj[inforPos%5].style.webkitTransform = "scale(1.25)";
			}
			/*
			if(flag==3){
				//$("play"+inforPos%5).src="images/collect/play0.png";
				//$("delete"+inforPos%5).src="images/collect/delete1.png";
				$("focus1").style.visibility="hidden";
				$("focus2").style.visibility="visible";
				playObj[inforPos%5].style.webkitTransform = "scale(1)";
				deleteObj[inforPos%5].style.webkitTransform = "scale(1.25)";

			}*/	
			break;
		case "KEY_SELECT":
			if(flag==1) gotoDetail();
			//if(flag==2)	gotoPlay();	
			if(flag==2) doDelete();
			break;
		case "KEY_PAGE_UP":
			changePage(-1);
			break;
		case "KEY_PAGE_DOWN":
			changePage(1);
			break;		
		case "KEY_GREEN":
			  showInfor();
			break;			
		case "KEY_EXIT":
		case "KEY_BACK":
			window.location.href=backUrl;
			//window.location.href="HD_vodCollect.jsp";
			break;	
		/*	
		case "EIS_MISC_HTML_OPEN_FINISHED":
			$("centerpart").style.visibility="visible";
			break;
		*/		
	}
}

var program=[];
var inforBox=new Object();
var favpageNum=1;
var bookpageNum=1;
var favPos=0;
var bookPos=0;
var pageSum=0;
function init(){
	var params = window.location.search.substring(1);
	$("centerpart").style.visibility="visible";
	if(params.indexOf("TYPE") > -1){ type = params.split("=")[1]}
	if(myArray.length!=0){
		type=myArray[0];
		favPos=myArray[1];
		bookPos=myArray[2];
	}
	initInforObj();
	initmenufocusWhere();
	getData();
	
}

var imgObj=[];
var nameObj=[];
var picObj=[];
var playObj=[];
var deleteObj=[];
function initInforObj(){
	for(var i=0;i<6;i++){
		imgObj[i]=$("propicture"+i);
		nameObj[i]=$("programname"+i);
		picObj[i]=$("pic"+i);
		deleteObj[i]=$("deleteDiv"+i);
		playObj[i]=$("playDiv"+i);
	}
}

function showInforData(n){
	for(var i=5*n;i<5+5*n;i++){
		if(i>program.length-1){
			picObj[i%5].style.visibility="hidden";
			deleteObj[i%5].style.visibility="hidden";
			playObj[i%5].style.visibility="hidden";
			nameObj[i%5].style.visibility="hidden";
		}else{
			picObj[i%5].style.visibility="visible";
			deleteObj[i%5].style.visibility="visible";
			playObj[i%5].style.visibility="visible";
			nameObj[i%5].style.visibility="visible";
			imgObj[i%5].src=program[i].SMALLPIC;
			nameObj[i%5].innerText=program[i].PROGNAME.substr(0,14);
		}	
	}	
}

function changeMenufocus(n){
	$("menufocus").style.webkitTransitionDuration="300ms";
	if(n>0){
		 $("menufocus").style.top="139px";
		 $("menu1").style.color="#ffffff";$("menu0").style.color="#747474";
		 $("capability").innerText="功能-我的书签";
		 getData();
	 }
	else{ 
		$("menufocus").style.top="55px";$("menu0").style.color="#ffffff";
		$("menu1").style.color="#747474";
		$("capability").innerText="功能-我的收藏";
		getData();
	}
}

function initmenufocusWhere(){
	if(type==0){
		$("menufocus").style.top="55px";
		$("menu0").style.color="#ffffff";
		$("capability").innerText="功能-我的收藏";
		$("curpage").innerText=favpageNum+"/"+pageSum+"页";
		menuPos=0;
		inforPos=favPos;
	}
	if(type==1){
		$("menufocus").style.top="139px";
		$("menu1").style.color="#ffffff";
		$("capability").innerText="功能-我的书签";
		$("curpage").innerText=bookpageNum+"/"+pageSum+"页";
		menuPos=1;
    	inforPos=bookPos;	
	}
	picObj[inforPos%5].style.webkitTransitionDuration="300ms";
	picObj[inforPos%5].style.webkitTransform = "scale(1.25)"
	picObj[inforPos%5].style.backgroundImage = "url()";
	$("programname"+inforPos%5).style.color="#ffffff";
	$("programname"+inforPos%5).style.fontSize="35px";
}

var datatimer=new Object();
function getData(){
	var url="";
	if(menuPos==0){
		$("playtype").innerText="播放";
		$("deletetype").innerText="取消收藏";	
		url = "HD_favoData.jsp";
	}
	if(menuPos==1){
		$("playtype").innerText="书签处播放";
		$("deletetype").innerText="删除书签";
		url ="HD_bookMarkData.jsp";
	}
	clearTimeout(datatimer);
	datatimer=setTimeout(function (){
	var ajaxObj = new AJAX("GET",url, true, vodSuccess);
	ajaxObj.onError = vodError;
	ajaxObj.send();}
	,500);
}


function vodSuccess(R){
	var data="";
	data =eval(R);
	if(typeof data == "undefined") {
		//showTip("请求数据为空！");
		showNoData();
	}
	else {	
		program=[];
		$("tip").style.visibility="hidden";
		program = data;
		pageSum=Math.ceil(program.length/5);
		if(program.length!=0){
			noData=false;
			$("centerpart").style.visibility="visible";
			menuPos==0?$("curpage").innerText=favpageNum+"/"+pageSum+"页":$("curpage").innerText=bookpageNum+"/"+pageSum+"页";
		}else{
			showNoData();
		}
		toInitData();	
		$("centerFocus").style.visibility="visible";
		$("centerBgimg").style.opacity=1;
	}
	menuSafeFlag=false;
}

function showNoData(){
	$("curpage").innerText="0/0页";
	$("menufocus").style.backgroundImage="url('images/collect/focus02.png')";
	$("imgfocus").style.backgroundImage="url()";
	program=[];
	flag=0;
	noData=true;
	$("centerpart").style.visibility="hidden";
	showInforData(0);
}

function toInitData(){
	if(menuPos==0){
		favpageNum=Math.floor(favPos/5)+1;
		showInforData(favpageNum-1);
		inforPos=favPos;
	}
	if(menuPos==1){
		bookpageNum=Math.floor(bookPos/5)+1;
		showInforData(bookpageNum-1);
		inforPos=bookPos;
	}
	
	$("centerFocus").style.webkitTransitionDuration="0ms";
	$("centerBgimg").style.webkitTransitionDuration="0ms";
	/*if(inforPos>program.length-1){
		$("centerFocus").style.top=(program.length-1)%5*110+"px";
		$("centerBgimg").style.top=(program.length-1)%5*110+"px";
	}else{*/
		$("centerFocus").style.top=inforPos%5*110+"px";
		$("centerBgimg").style.top=inforPos%5*110+"px";
	//}	
	$("centerFocus").style.webkitTransitionDuration="300ms";
	$("centerBgimg").style.webkitTransitionDuration="300ms";
	
}

function vodError(){
	showTip("未找到数据");
	showNoData();
}

function showTip(str){
	$("tip").innerText = str;
	$("tip").style.visibility = "visible";
}

function changeInfor(n){
	inforPos=parseInt(inforPos);
	if((inforPos<1&&n<0)||(inforPos>program.length-2&&n>0)){
		return;
	}
	if(inforPos%5==4&&n>0||inforPos%5==0&&n<0){
		if(menuPos==0){
			favpageNum+=n;
			showInforData(favpageNum-1);
			$("curpage").innerText=favpageNum+"/"+pageSum+"页";
		}		
		picObj[inforPos%5].style.webkitTransform = "scale(1.25)";
		picObj[(inforPos-1)%5].style.webkitTransform = "scale(1)";
		$("programname"+inforPos%5).style.color="#ffffff";
		$("programname"+inforPos%5).style.fontSize="35px";
		if(menuPos==1){
			bookpageNum+=n;
			showInforData(bookpageNum-1);
			$("curpage").innerText=bookpageNum+"/"+pageSum+"页";
		}			
		$("centerFocus").style.webkitTransitionDuration = "0ms";
		$("centerBgimg").style.webkitTransitionDuration = "0ms";
		$("centerFocus").style.top="0px";
		$("centerBgimg").style.top="0px";
		n>0?inforPos++:inforPos-=5;
		getScale(n);
		menuPos==0?favPos=inforPos:bookPos=inforPos;
		return;
	}
	inforPos+=n;
	menuPos==0?favPos=inforPos:bookPos=inforPos;
	getScale(n);
	$("centerFocus").style.webkitTransitionDuration = "300ms";
	$("centerBgimg").style.webkitTransitionDuration = "300ms";
	$("centerFocus").style.top+=n*110;	
	$("centerBgimg").style.top+=n*110;	
}

function getScale(n){
	picObj[inforPos%5].style.webkitTransitionDuration="300ms";
	deleteObj[inforPos%5].style.webkitTransitionDuration="300ms";
	playObj[inforPos%5].style.webkitTransitionDuration="300ms";
	picObj[inforPos%5].style.webkitTransform = "scale(1.25)";
	if(flag==2) deleteObj[inforPos%5].style.webkitTransform = "scale(1.25)";
	//if(flag==3)deleteObj[inforPos%5].style.webkitTransform = "scale(1.25)";
	picObj[inforPos%5].style.backgroundImage="url()";
	if(n>0){	
		picObj[(inforPos-1)%5].style.webkitTransform = "scale(1)";
		//flag==2?deleteObj[(inforPos-1)%5].style.webkitTransform = "scale(1)":playObj[(inforPos-1)%5].style.webkitTransform = "scale(1)";
		deleteObj[(inforPos-1)%5].style.webkitTransform = "scale(1)";
		picObj[(inforPos-1)%5].style.backgroundImage= "url(images/collect/picture.png)";
		$("programname"+inforPos%5).style.color="#ffffff";
		$("programname"+inforPos%5).style.fontSize="35px";
		$("programname"+(inforPos-1)%5).style.color="#393939";
		$("programname"+(inforPos-1)%5).style.fontSize="30px";
		
	}else{
		picObj[(inforPos+1)%5].style.webkitTransform = "scale(1)";
	//	flag==3?deleteObj[(inforPos+1)%5].style.webkitTransform = "scale(1)":playObj[(inforPos+1)%5].style.webkitTransform = "scale(1)";
		deleteObj[(inforPos+1)%5].style.webkitTransform = "scale(1)"
		picObj[(inforPos+1)%5].style.backgroundImage= "url(images/collect/picture.png)";
		$("programname"+inforPos%5).style.color="#ffffff";
		$("programname"+inforPos%5).style.fontSize="35px";
		$("programname"+(inforPos+1)%5).style.color="#393939";
		$("programname"+(inforPos+1)%5).style.fontSize="30px";
	}	
}

var deletesafeFlag=false;
function doDelete(){
	//$("propicture"+inforPos%5).style.webkitTransform="";
	if(deletesafeFlag) return;
	deletesafeFlag = true;
	var url="";
	if(menuPos==1){
		 url = program[inforPos].DELETEURL;			
	}
	if(menuPos==0){
		 url =program[inforPos].PROGDELETEURL; //删除书签
	}

	var aj = new AJAX_OBJ(url, function(r){
			var f = "" //r.responseText;	 	
			var xml=r.responseXML.getElementsByTagName("subnum");
			if(typeof(xml)=="undefined"){
						f = r.responseText;	 
			}else{	
					 for(var m=0;m<xml.length;m++){
								f=xml[m].firstChild.nodeValue;
						}
			}
		if(f == 0 || f == "0") {
			picObj[inforPos%5].style.visibility="hidden";
			deleteObj[inforPos%5].style.visibility="hidden";
			playObj[inforPos%5].style.visibility="hidden";
			nameObj[inforPos%5].style.visibility="hidden";
			if(inforPos==program.length-1){
				if(inforPos%5!=0){
					$("centerFocus").style.webkitTransitionDuration="300ms";
					$("centerBgimg").style.webkitTransitionDuration="300ms";
					$("centerFocus").style.top-=110;
					$("centerBgimg").style.top-=110;
				}else{
					if(inforPos==0&&program.length==1){	 
						$("centerpart").style.visibility="hidden";	
						$("menufocus").style.backgroundImage="url('images/collect/focus02.png')";
						flag=0;
						noData=true;
						program=[];
						$("focus1").style.visibility="hidden";
						$("focus2").style.visibility="hidden";
						deleteObj[inforPos%5].style.webkitTransform = "scale(1)";
						$("curpage").innerText="0/0页";
						$("content").innerText = getResponseTip(f);
						$("readTips").style.webkitTransform = "scale(1)";
						setTimeout('$("readTips").style.webkitTransform = "scale(0)";readFlag = false;deletesafeFlag = false;',1000);
						return;
					}else{
						$("centerFocus").style.webkitTransitionDuration="300ms";
						$("centerBgimg").style.webkitTransitionDuration="300ms";
						$("centerFocus").style.top=440;	
						$("centerBgimg").style.top=440;	
					}	
				}		
			}else{
				if(program[inforPos+(5-inforPos%5)]!=null){
				   imgObj[5].src=program[inforPos+(5-inforPos%5)].HUGEPIC;
				   nameObj[5].innerText=program[inforPos+(5-inforPos%5)].VODNAME.substr(0,14);
				}else{
					 picObj[5].style.visibility="hidden";
					 deleteObj[5].style.visibility="hidden";
					 playObj[5].style.visibility="hidden";
					 nameObj[5].style.visibility="hidden";
				}
				for(var m=inforPos%5+1;m<6;m++){
					picObj[m].style.webkitTransitionDuration="300ms";
					deleteObj[m].style.webkitTransitionDuration="300ms";
					playObj[m].style.webkitTransitionDuration="300ms";
					nameObj[m].style.webkitTransitionDuration="300ms";
					deleteObj[m].style.top-=110;
					nameObj[m].style.top-=110;
					picObj[m].style.top-=110;
					playObj[m].style.top-=110;
				//	alert(playObj[m].id);
				}
			}	
			initProgram();
		}
		$("content").innerText = getResponseTip(f);
		$("readTips").style.webkitTransform = "scale(1)";
		setTimeout('$("readTips").style.webkitTransform = "scale(0)";readFlag = false;deletesafeFlag = false;',1000);
		});
	aj.requestData();
	
}

var divtimer=new Object();
function initProgram(){
	program.splice(inforPos,1);
	if(inforPos==program.length){
		inforPos--;
		getScale(-1);
	}
	pageSum=Math.ceil(program.length/5);	
	if(menuPos==0){
		favpageNum=Math.floor(inforPos/5)+1;
		$("curpage").innerText=favpageNum+"/"+pageSum+"页";
	}
	if(menuPos==1){
		bookpageNum=Math.floor(inforPos/5)+1;
		$("curpage").innerText=bookpageNum+"/"+pageSum+"页";
	}
	clearTimeout(divtimer);	
	divtimer=setTimeout(initDiv,300);
}

function initDiv(){
	for(var m=0;m<6;m++){
		picObj[m].style.webkitTransitionDuration="0ms";
		deleteObj[m].style.webkitTransitionDuration="0ms";
		nameObj[m].style.webkitTransitionDuration="0ms";
		playObj[m].style.webkitTransitionDuration="0ms";
		picObj[m].style.top=m*110+"px";
		deleteObj[m].style.top=m*110+"px";
		nameObj[m].style.top=m*110+"px";
		playObj[m].style.top=m*110+"px";
		picObj[m].style.webkitTransitionDuration="300ms";
		deleteObj[m].style.webkitTransitionDuration="300ms";
		nameObj[m].style.webkitTransitionDuration="300ms";
		playObj[m].style.webkitTransitionDuration="300ms";
	}
	showInforData(Math.floor(inforPos/5));	
}

function gotoPlay(){
	var url1 = "HD_vodDetail.jsp?PROGID="+ program[inforPos].PROGID;
	var url = "HD_saveCurrFocus.jsp?currFocus="+menuPos+","+favPos+","+bookPos+"&url="+url1;
	window.location.href = url;
}

function changePage(num){
	if(menuPos==0){
		if((favpageNum==1&&num<0)||favpageNum==pageSum&&num>0) return;
		favpageNum+=num;
		showInforData(favpageNum-1);	
		initChangePage();
		inforPos=(favpageNum-1)*5;
		$("curpage").innerText=favpageNum+"/"+pageSum+"页";
	}else{
		if((bookpageNum==1&&num<0)||bookpageNum==pageSum&&num>0) return;
		bookpageNum+=num;
		showInforData(bookpageNum-1);
		initChangePage();
		inforPos=(bookpageNum-1)*5;
		$("curpage").innerText=bookpageNum+"/"+pageSum+"页";
	}
	
}

function initChangePage(){
	if(flag>0){
			picObj[inforPos%5].style.webkitTransform = "scale(1)";	 
			picObj[inforPos%5].style.backgroundImage= "url(images/collect/picture.png)";
			if(flag==2) deleteObj[inforPos%5].style.webkitTransform = "scale(1)";
			$("programname"+inforPos%5).style.color="#393939";
			$("programname"+inforPos%5).style.fontSize="30px";
			$("centerFocus").style.webkitTransitionDuration="300ms";
			$("centerBgimg").style.webkitTransitionDuration="300ms";
			$("centerFocus").style.top=0;	
			$("centerBgimg").style.top=0;	
		    picObj[0].style.webkitTransform = "scale(1.25)";		 
			if(flag==2)	deleteObj[0].style.webkitTransform = "scale(1.25)";
			picObj[0].style.backgroundImage= "url()";
			$("programname0").style.color="#ffffff";
			$("programname0").style.fontSize="35px";	 
 
	} 

}

function gotoDetail(){
	var url = "HD_vodDetail.jsp?PROGID="+ program[inforPos].PROGID;
	var url1="HD_saveCurrFocus.jsp?currFocus="+menuPos+","+favPos+","+bookPos+"&url="+url;
	window.location.href = url1;
}
			
function getResponseTip(r) {
	r = Math.abs(parseInt(r));
	var tipsinfo = "";
	if(menuPos==0){
		tipsinfo = ["操作成功","ACTION 缺失","PROGID,PROGTYPE缺失","收藏夹已满","后台读写数据失败","无法获取收藏夹列表"];	
	}else{
		tipsinfo=["书签操作成功","ACTION 缺失","基本参数缺失","用户书签已满","书签操作失败","获取书签列表失败"];
	}	
	if(isNaN(r)){
		return tipsinfo[4];
	}
	return tipsinfo[r];
}


</script>
</head>
	
<body onLoad="init()" onUnload="exit()" scroll="no">
	<div id="menutiltle"><img src="images/portal/if05.png"/></div> <div id="capability"></div>
	<div id="menu">
	  <div id="menu0" class="menu">我的收藏</div>
  	  <div id="menu1" class="menu">我的书签</div>
 	  <div class="focusbg" id="menufocus"></div>
	</div>
	<div id="information">
		<div id="toppart">
			<table><tr>
				<td class="td0" valign="middle"><img src="images/default/up.png" /></td>
				<td class="td1" valign="middle">节目名</td>
				<!--<td id="playtype" valign="middle" class="td2"></td>-->
				<td id="deletetype" valign="middle" class="td3"></td>
			</tr></table>
	  </div>
	  <div id="centerpart">
	  		<div id="centerFocus"><div id="imgfocus"></div><div id="focus1"></div><!--<div id="focus2"></div>--></div>
			<div id="centerBgimg"></div>
	  		<div id="pic0"><img id="propicture0"  src="" height="61" width="74"/></div>
			<div id="programname0" class="proname" style="top:0px"></div>
			<!--<div id="playDiv0" class="play" style="top:0px"><img id="play0" src="images/collect/play0.png" /></div>-->
			<div id="deleteDiv0" class="delete" style="top:0px"><img id="delete0" src="images/collect/delete0.png" /></div>
			<div id="pic1"><img id="propicture1" src="" height="61" width="74"/></div>
			<div id="programname1" class="proname" style="top:110px"></div>
			<!--<div id="playDiv1" class="play" style="top:110px"><img id="play0" src="images/collect/play0.png" /></div>-->
			<div id="deleteDiv1" class="delete" style="top:110px"><img id="delete0" src="images/collect/delete0.png" /></div>
			<div id="pic2"><img id="propicture2" src="" height="61" width="74"/></div>
			<div id="programname2" class="proname" style="top:220px"></div>
			<!--<div id="playDiv2" class="play" style="top:220px"><img id="play0" src="images/collect/play0.png" /></div>-->
			<div id="deleteDiv2" class="delete" style="top:220px"><img id="delete0" src="images/collect/delete0.png" /></div>
			<div id="pic3"><img id="propicture3" src="" height="61" width="74"/></div>
			<div id="programname3" class="proname" style="top:330px"></div>
			<!--<div id="playDiv3" class="play" style="top:330px"><img id="play0" src="images/collect/play0.png" /></div>-->
			<div id="deleteDiv3" class="delete" style="top:330px"><img id="delete0" src="images/collect/delete0.png" /></div>
			<div id="pic4"><img id="propicture4" src="" height="61" width="74"/></div>
			<div id="programname4" class="proname" style="top:440px"></div>
			<!--<div id="playDiv4" class="play" style="top:440px"><img id="play0" src="images/collect/play0.png" /></div>-->
			<div id="deleteDiv4" class="delete" style="top:440px"><img id="delete0" src="images/collect/delete0.png" /></div>
			<div id="pic5"><img id="propicture5" src="" height="61" width="74"/></div>
			<div id="programname5" class="proname" style="top:550px"></div>
			<!--<div id="playDiv5" class="play" style="top:550px"><img id="play0" src="images/collect/play0.png" /></div>-->
			<div id="deleteDiv5" class="delete" style="top:550px"><img id="delete0" src="images/collect/delete0.png" /></div>
      </div>		 
	  <div id="downpart">
			<table><tr>
				<td class="td0"  valign="middle"><img src="images/default/down.png" /></td>
				<td class="td1" id="curpage" valign="middle"></td>
				<!--<td class="td2" valign="middle"></td>-->
				<td class="td3" valign="middle"></td>
			</tr></table>
	  </div>
	</div>
	<div id="tip"></div>
	<div id="readTips" style="position:absolute; left:350px; top:208px; height:122px; width:539px; background-image: url(images/vod/tck_bg1.png); text-align:center; ">
 <table width="430" border="0" cellspacing="0" cellpadding="0" class="bg">
  <tr>
   <td height="120" colspan="2" align="center" style="font-size:28px; color:#f6ff00;" id="content">是否添加收藏？</td>
  </tr>
  <!--<tr>
   <td width="215" height="100" align="center" background="images/vod/button0_bg1.gif" id="readBtn0">确定</td>
   <td width="215" align="center" background="images/vod/button0_bg0.gif" id="readBtn1">取消</td>
  </tr>-->
 </table>
</div>
</body>
</html>
