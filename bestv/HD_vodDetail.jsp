<%@ include file="HD_preFocusElement.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>teleplayDetail</title>
<meta http-equiv="Page-Enter" content="blendTrans(Duration=1.0)">
<meta name="page-view-size" content="1280*720" />
<!--<meta http-equiv="Page-Exit" content="blendTrans(Duration=2.0)">-->
<style>
body{ position:absolute; width:1280px; height:720px; top:0px; left:0px; overflow:hidden;}
.bg td {
	background:center no-repeat;
	font-size:22px;
	color:#ffffff;
	padding-top:8px;
	padding-left:3px;
}
.num td {
	font-size:25px;
	color:#393939;
	text-align:center;
}
#readTips {
	-webkit-transition-duration:300ms;
	-webkit-transform:scale(0);
	z-index:5;
}
div.btn{
	position:absolute;
	top:240px;
	left:0;
	width:144px;
	height:142px;
	-webkit-transition-duration:0.2s;
}
div.btn0{
	position:absolute;
	top:240px;
	left:0;
	width:144px;
	height:142px;
}
/*#btnsd0,*/ #btnsd1, #btnsd2{
	-webkit-transition-duration:0.2s;
}
#movieListArea{position:absolute; left: 74px; top: 488px; height: 197px; width: 1128px; overflow:hidden; -webkit-transition-duration:200ms;}
#movieListArea .style3{ position:absolute;width:162px; height:162px; -webkit-transition-duration:200ms; z-index:0;}
#movieListArea .img{position:absolute; left:20px; top:18px; height: 100px; width: 121px;}
#movieListArea .text{position:absolute; top:120px; left:8px; width:146px; height:34px; text-align:center; line-height:34px; font-size:22px; color:#393939;}
#movieListArea #img_div0{position:absolute; top:24px; left:18px;}
#movieListArea #img_div1{position:absolute; top:24px; left:250px;}
#movieListArea #img_div2{position:absolute; top:24px; left:482px;}
#movieListArea #img_div3{position:absolute; top:24px; left:714px;}
#movieListArea #img_div4{position:absolute; top:24px; left:946px;}
#movieListArea #img_div5{position:absolute; top:24px; left:1178px;}
/*#movieListArea #img_div6{position:absolute; top:24px; left:1132px;}*/
#upSign{position:absolute; left:37px; top:581px; height:34px; width:19px; background-image:url(images/vod/left.png);}
#downSign{position:absolute; left:1220px; top:573px; height:34px; width:19px; background-image:url(images/vod/right.png);}
</style>
<script src="js/mini.js" type="text/javascript"></script>
<script language="javascript">
var movie_list = [];
var params = [];
var dataInfo = {
	idArr:["img_div0", "img_div1", "img_div2", "img_div3", "img_div4", "img_div5"],
	firstPos:"18px",
	endPos:"946px",
	firstStatus:"-214px",
	lastStatus:"1178px"

};

var btnArr=[["images/vod/icon_play_0.png", "images/vod/icon_play_1.png"],
						["images/vod/icon_bm_0.png", "images/vod/icon_bm_1.png", "images/vod/icon_bm_gray.png"],
						["images/vod/icon_fav_del_0.png", "images/vod/icon_fav_del_1.png"],
						["images/vod/icon_fav_0.png", "images/vod/icon_fav_1.png"],
						["images/vod/icon_js_bg_0.png", "images/vod/icon_js_bg_1.png"]];

var focus_area = 0;///~ 0: 上面 1:下面 
var focus_pos = 0;
var movie_length = 0;

var listSize = 5;
var movie_pos = 0;
var currPos = 0;	
var direct_flag = false;
var firse_flag = true;
var show_info_timer = -1;
var idPos = 0;
var btnPos = 0;
var readBtnPos = 0;
var readFlag = false;
var jishuPos = 0;
var tipsArr = ["机顶盒空间已满,请外接硬盘!","是否添加收藏？"];
var jishuFlag = false;
var responseFlag = false;
var dataNoReady=true;
function eventHandler(obj) {
	if(dataNoReady) return;
	switch(obj.code){
		case "KEY_UP":
			if(bookchoose) return;
			if(focus_area == 1){
				$("focus_div").style.opacity = 0;
				$("bgPic"+idPos).src = "images/vod/movie0.png";
				$("moviename"+idPos).style.color = "#393939";
				$("img_div"+idPos).style.webkitTransform = "scale(1)";
				if(movie_list[movie_pos].ISSITCOM == 0){
					if(btnPos == 2) $("btn2").style.backgroundImage = "url("+btnArr[movie_list[movie_pos].ISFAVO == 1 ? 2 : 3][1]+")";
					else {
						if(btnPos==1&&movie_list[movie_pos].HASBOOKMARK==0){
							btnPos=0;
						}
						$("btn"+btnPos).style.backgroundImage = btnArr[btnPos][1];
					}	
					$("btn"+btnPos).style.top = "220px";
					$("btnsd"+btnPos).style.webkitTransform = "scale(0.8)";
				}else{
					 btnPos=2;
					 $("btn0").style.backgroundImage = "url("+btnArr[movie_list[movie_pos].ISFAVO == 1 ? 2 : 3][1]+")";
					 $("btn0").style.top = "220px";
					 $("btnsd0").style.webkitTransform = "scale(0.8)";
				}	
				focus_area = 0;
			}
			else if(focus_area == 2){
				changeJishuUDFocus(-1);
			}
			break;
		case "KEY_DOWN":
			if(bookchoose) return;
			if(focus_area == 0 && !readFlag){
				$("focus_div").style.opacity = 1;
				$("bgPic"+idPos).src = "images/vod/movie1.png";
				$("moviename"+idPos).style.color = "#ffffff";
				$("img_div"+idPos).style.webkitTransform = "scale(1.15)";
				if(movie_list[movie_pos].ISSITCOM == 0){
					if(btnPos == 2) $("btn2").style.backgroundImage = "url("+btnArr[movie_list[movie_pos].ISFAVO == 1 ? 2 : 3][0]+")";
					else $("btn"+btnPos).style.backgroundImage = btnArr[btnPos][0];
					$("btn"+btnPos).style.top = "240px";
					$("btnsd"+btnPos).style.webkitTransform = "scale(1)";
				}
				else{
					 btnPos=2;
					 $("btn0").style.backgroundImage = "url("+btnArr[movie_list[movie_pos].ISFAVO == 1 ? 2 : 3][0]+")";
					 $("btn0").style.top = "240px";
					 $("btnsd0").style.webkitTransform = "scale(1)";
				}	
				focus_area = 1;
			}
			else if(focus_area == 2){
				changeJishuUDFocus(1);
			}
			break;
		case "KEY_RIGHT":
		if(bookchoose){
			if(bookfocus==0){
				$("bookfocus").style.backgroundImage="url(images/vod/book_focus1.png)";
				$("playfocus").style.backgroundImage="url(images/vod/play_focus0.png)";
				bookfocus=1;
			}	
		}else{
			if(focus_area == 1){
					if(movie_pos != movie_length-1) move_action(1);
			}
			else if(focus_area == 0){
				if(!readFlag){				
					changeBtnFocus(1);
				}	
				else{
					changeReadFocus();
				}	
			}
			else{
				changeJishuLRFocus(1);		
			}
		}	
			return 0;
			break;
		case "KEY_LEFT":
			if(bookchoose){
				if(bookfocus==1){
					$("bookfocus").style.backgroundImage="url(images/vod/book_focus0.png)";
					$("playfocus").style.backgroundImage="url(images/vod/play_focus1.png)";
					bookfocus=0;
				}	
			}else{
				if(focus_area == 1){
					if(movie_pos != 0) move_action(-1);
				}
				else if(focus_area == 0){
					if(!readFlag)
						changeBtnFocus(-1);
					else
						changeReadFocus();
				}
				else{
					changeJishuLRFocus(-1);	
				}
			}	
				return 0;
			break;
		case "KEY_SELECT":
			if(bookchoose){
				markPlay();
				return ;
			}
			if(focus_area == 1)
				gotoPlay();
			else if(focus_area == 0){
				var isFav = movie_list[movie_pos].ISFAVO;
				if(!readFlag){
					if(btnPos == 2){	
					
						readFlag = true;
						
						if(isFav == 1) {
							//$("content").innerText = "正在删除收藏...";
							var url = "HD_favoAction.jsp?ACTION=delete&PROGID=" + movie_list[movie_pos].PROGID + "&PROGTYPE="+movie_list[movie_pos].PROGTYPE;	//删除收藏
							var aj = new AJAX_OBJ(url, function(r){
					
								var f="";
								var xml=r.responseXML.getElementsByTagName("subnum");
						  		for(var m=0;m<xml.length;m++){
									 f=xml[m].firstChild.nodeValue;
								}//2收 3删
								responseFlag = true;
								if(f == 0 || f == "0") {
									if(movie_list[movie_pos].ISSITCOM == 0) $("btn2").style.backgroundImage = "url("+btnArr[movie_list[movie_pos].ISFAVO == 1 ? 3 : 2][1]+")";									
									else $("btn0").style.backgroundImage = "url("+btnArr[movie_list[movie_pos].ISFAVO == 1 ? 3 : 2][1]+")";	
									movie_list[movie_pos].ISFAVO = 0; 
								}
								$("content").innerText = getResponseTip(f);
								$("readTips").style.webkitTransform = "scale(1)";
								setTimeout('$("readTips").style.webkitTransform = "scale(0)";readFlag = false;',2000);
								});
							aj.requestData();
						} else {
							//$("content").innerText = "正在添加收藏...";
							var url = "HD_favoAction.jsp?ACTION=insert&PROGID=" + movie_list[movie_pos].PROGID + "&PROGTYPE="+movie_list[movie_pos].PROGTYPE+"&FLAG=0";; //添加收藏
							var aj = new AJAX_OBJ(url, function(r){
								 	var f = "" //r.responseText;	 	
									responseFlag = true;
									var xml=r.responseXML.getElementsByTagName("subnum");
									if(typeof(xml)=="undefined"){
										f = r.responseText;	 
									}else{	
							  		 for(var m=0;m<xml.length;m++){
											  f=xml[m].firstChild.nodeValue;
										 }
									}	
									if(f == 0 || f == "0") {
									
											if(movie_list[movie_pos].ISSITCOM == 0) $("btn2").style.backgroundImage = "url("+btnArr[movie_list[movie_pos].ISFAVO == 0 ? 2 : 3][1]+")";
											else $("btn0").style.backgroundImage = "url("+btnArr[movie_list[movie_pos].ISFAVO == 0 ? 2 : 3][1]+")";
											movie_list[movie_pos].ISFAVO = 1;

									}
									$("content").innerText =getResponseTip(f);
									$("readTips").style.webkitTransform = "scale(1)";
									setTimeout('$("readTips").style.webkitTransform = "scale(0)";readFlag = false;',2000);		
								});													
							aj.requestData();
					
						}
						
						
					}
					else{
						gotoPlay();
					}
				}
				
			}else{
				gotoPlay();
			}
			break;
		case "KEY_BACK":
			goBack();
			break;	
	}
}

function getResponseTip(r) {
	r = parseInt(r);
	var tipsinfo = ["操作成功","ACTION 缺失","PROGID,PROGTYPE缺失","收藏夹已满","后台读写数据失败","无法获取收藏夹列表"];
	if(isNaN(r)){
		return tipsinfo[4];
	}
	return tipsinfo[r];
}


function goBack(){
	if(bookchoose){
		$("bookmarkDiv").style.webkitTransform = "scale(0)";
		$("mark").style.visibility="visible";
		//bookchoose=false;
		setTimeout(function (){ bookchoose = false},100);
		return;
	}
	window.document.location = backUrl;	
}

var bookchoose=false;
var bookfocus=0;
function gotoPlay() {
	var url1="";
	var url="";
if(movie_list[movie_pos].ISSITCOM == 0){
	if(movie_list[movie_pos].HASBOOKMARK==1&&btnPos==1){
		url1=movie_list[movie_pos].BOOKMARKURL;
	}else{
		url1=movie_list[movie_pos].PLAYURL;
	}
	  url = "HD_saveCurrFocus.jsp?currFocus="+focus_area+","+movie_pos+","+jishuPos+","+listBox.currPosition+","+focus_pos+","+btnPos+"&url=" + url1;
}else{
	url1=movie_list[movie_pos].PLAYURL;
	

	if(markArray[jishuPos].value==1) {
		$("bookmarkDiv").style.webkitTransform = "scale(1)";
		$("mark").style.visibility="hidden";
		bookchoose=true;
		bookfocus=0;
		return;
	}else{
		url= "HD_saveCurrFocus.jsp?currFocus="+focus_area+","+movie_pos+","+jishuPos+","+listBox.currPosition+","+focus_pos+","+btnPos+"&url=" + url1;	
		url=url +(jishuPos)+"&CHILDID=" + movie_list[movie_pos].CHILDID[jishuPos];
	}	
}		
	window.location.href = url;
}

var markClick=false;
var markClickSafeTime=-1;
function markPlay(){
	if(markClick) return;
	markClick=true;
	clearTimeout(markClickSafeTime);
	markClickSafeTime=setTimeout("markClick=false",1000);
	var url1="";
	if(bookfocus==0) url1=markArray[jishuPos].url;	
	else url1= movie_list[movie_pos].PLAYURL;
	url= "HD_saveCurrFocus.jsp?currFocus="+focus_area+","+movie_pos+","+jishuPos+","+listBox.currPosition+","+focus_pos+","+btnPos+"&url=" + url1;	
	url=url +(jishuPos)+"&CHILDID=" + movie_list[movie_pos].CHILDID[jishuPos]; 
	window.location.href = url;
}

function changeReadFocus(){
	if(readBtnPos == 0){
		$("readBtn0").style.backgroundImage = "url(images/vod/button0_bg0.gif)";
		$("readBtn1").style.backgroundImage = "url(images/vod/button0_bg1.gif)";
		readBtnPos = 1;
	}
	else{
		$("readBtn0").style.backgroundImage = "url(images/vod/button0_bg1.gif)";
		$("readBtn1").style.backgroundImage = "url(images/vod/button0_bg0.gif)";
		readBtnPos = 0;
	}

}

function changeBtnFocus(num){
	if(movie_list[movie_pos].ISSITCOM == 1) {
		if(btnPos == 2 && num>0){
			if(!jishuFlag) return;
			$("btn0").style.top = "240px";
			$("btn0").style.backgroundImage = "url("+btnArr[movie_list[movie_pos].ISFAVO == 1 ? 2 : 3][0]+")";
			$("btnsd0"+btnPos).style.webkitTransform = "scale(1)";
			focus_area = 2;
		
			$("dsjFocus").style.backgroundImage = btnArr[4][1];
			$("dsjFocus").style.color = "white";
			$("marktd"+jishuPos).style.color = "black";
			if(markArray[jishuPos].value==1) $("mark").style.visibility="visible";
			else $("mark").style.visibility="hidden";
			return;
		}
	}else{
		if(btnPos == 0 && num < 0) return;
		if(btnPos == 2 && num>0) return;
		if(btnPos == 2) {
			if(num<0 && movie_list[movie_pos].HASBOOKMARK == 0 && jishuFlag) return;
			$("btn2").style.backgroundImage = "url("+btnArr[movie_list[movie_pos].ISFAVO == 1 ? 2 : 3][0]+")";
		} else{
			if(btnPos == 1 && num<0 && jishuFlag) return;
			$("btn"+btnPos).style.backgroundImage = btnArr[btnPos][0];
		}
		$("btn"+btnPos).style.top = "240px";
		$("btnsd"+btnPos).style.webkitTransform = "scale(1)";
		btnPos += num;
		if(btnPos < 0)
			btnPos = 0;
		if(movie_list[movie_pos].HASBOOKMARK == 0 && btnPos == 1) {
			if(num > 0) btnPos = 2;
			else btnPos = 0;
			
		}
		if(btnPos == 2) {
			$("btn2").style.backgroundImage = "url("+btnArr[movie_list[movie_pos].ISFAVO == 1 ? 2 : 3][1]+")";
		} else $("btn"+btnPos).style.backgroundImage = btnArr[btnPos][1];
		
		$("btn"+btnPos).style.top = "220px";
		$("btnsd"+btnPos).style.webkitTransform = "scale(0.8)";
	}
}

function changeJishuLRFocus(num){
	if(!jishuFlag) return;
	if(jishuPos%7 == 0 && num<0){
		focus_area = 0;
	
		$("dsjFocus").style.backgroundImage = "url(images/vod/global_tm.gif)";
		$("mark").style.visibility="hidden";
		$("marktd"+jishuPos).style.color = "blue";
		$("btn0").style.backgroundImage = "url("+btnArr[movie_list[movie_pos].ISFAVO == 1 ? 2 : 3][1]+")";
		$("btn0").style.top = "220px";
		$("btnsd0").style.webkitTransform = "scale(0.8)";
		btnPos=2;
		return;	
	}
	else if((jishuPos+1)%7 == 0 && num > 0) return;
	
	if(jishuPos+1 >= movie_list[movie_pos].SITCOMNUM && num >0) return;//保证不能越界
	
	jishuPos += num;
	$("dsjFocus").innerText = jishuPos+1;
	$("dsjFocus").style.left = -13+58*(jishuPos%7)+"px";
	$("mark").style.left=-13+58*(jishuPos%7)+59+"px";
	$("pageInfo").innerText = jishuPos+1+"/"+sumNum+"集";	
	$("scrollBar").style.top = (-3+Math.floor((jishuPos)/(sumNum-1)*126))+"px";
	if(markArray[jishuPos].value==1) $("mark").style.visibility="visible";
	else $("mark").style.visibility="hidden";
}

function changeJishuUDFocus(num){
	if(!jishuFlag) return;
	
	if((jishuPos+7 >= sumNum && num >0)|(jishuPos<7 && num<0)) return;//保证不能越界
	
	
	jishuPos += num*7;
		
	$("dsjFocus").innerText = jishuPos+1;
	$("pageInfo").innerText = jishuPos+1+"/"+sumNum+"集";
	$("data").style.top = $("data").style.top-56*num;
	$("scrollBar").style.top = (-3+Math.floor(jishuPos/(sumNum-1)*126))+"px";
	if(markArray[jishuPos].value==1) $("mark").style.visibility="visible";
	else $("mark").style.visibility="hidden";

}

function changePage(num){
	if(!jishuFlag) return;
	currPage += num;
	if(currPage > sumPage-1)
		currPage = 0;
	else if(currPage < 0)
		currPage = sumPage-1;
	showDSJInfo();
	var pos = 0;
	if(num < 0) jishuPos = jishuPos + 2*5;
	else jishuPos = jishuPos - 2*5;
	pos = currPage*pageSize+ jishuPos;
	if(pos > sumNum - 1) {
		pos = sumNum - 1;
		pos = sumNum -currPage*pageSize - 1;
	}
	$("dsjFocus").style.top = -17+56*Math.floor(jishuPos/7)+"px";
	$("mark").style.top = -15+56*Math.floor(jishuPos/7)+"px";
	if(markArray[jishuPos]==1) $("mark").style.visibility="visible";
	else $("mark").style.visibility="hidden";
	$("dsjFocus").style.left = -13+58*(jishuPos%7)+"px";
	$("dsjFocus").innerText = pos+1;
	$("pageInfo").innerText = pos+1+"/"+sumNum+"集";
	$("scrollBar").style.top = (-3+Math.floor((pos)/(sumNum-1)*126))+"px";
}
var sumPage = 0;
var currPage = 0;
var pageSize = 15;
var sumNum=0;
function initDSJNumber(){
	if(focus_area != 2){
		jishuPos = 0;
	}
	sumNum = movie_list[movie_pos].SITCOMNUM;
	var tempData = '<table border="0" cellspacing="0" cellpadding="0" class="num">';
	for(var i=0; i<sumNum/7; i++){
		tempData += '<tr>';
		for(var j=0; j<7; j++){
			if(i*7+j < sumNum){
				tempData += '<td width="58" height="56" id="'+("marktd"+(i*7+j))+'" style="background-image:url(images/vod/mark.png);background-repeat:no-repeat;background-position:top right;">'+(i*7+j+1)+'</td>';
			}else{
				tempData += '<td width="58" height="56"></td>';
			}
		}
		tempData += '</tr>';
	}
	tempData += '</table>';
//	alert(jishuPos);
	$("data").style.webkitTransitionDuration="0ms"; 
	$("data").style.top = -56*(Math.floor(jishuPos/7)-1)+"px";//初始化电视剧记忆焦点的位置
		$("data").style.webkitTransitionDuration="200ms"; 
	$("data").innerHTML = tempData;
	 	$("scrollBar").style.webkitTransitionDuration="0ms"; 
	$("scrollBar").style.top = (-3+Math.floor((jishuPos)/(sumNum-1)*126))+"px";
	 	$("scrollBar").style.webkitTransitionDuration="200ms"; 
	sumPage = 1+Math.floor((sumNum-1)/pageSize);
	$("pageInfo").innerText = jishuPos+1+"/"+sumNum+"集";
}
function showDSJInfo(){
	
}

function init(){
	params = window.location.search.substring(1).split("&");
	var url = "HD_VODDetailInfo.jsp?PROGID=" + params[0].split("=")[1];
	var ajax = new AJAX_OBJ(url, getDefaultData);
	ajax.requestData();	

}
var currPosition=0;
function getList(){
    for(var i=0;i<6;i++){
	 $("img_div"+i).style.webkitTransitionDuration="0ms"; 
	}
    $("img_div"+idPos).style.left=18+232*focus_pos;
	if(movie_list[movie_pos].SMALLPIC){
		$("img"+idPos).src = movie_list[movie_pos].SMALLPIC;	    
		$("moviename"+idPos).innerText = movie_list[movie_pos].VODNAME.substring(0,6);
	}
	var h=idPos;
	var g=idPos;
	var m1=movie_pos;
	var m2=movie_pos;
    for(var i=focus_pos-1;i>-1;i--){
		  h-=1;
		  h=h<0?5:h;
		  $("img_div"+h).style.left=18+232*i;
		  m1-=1;
		  if(movie_list[m1].SMALLPIC){
			  $("img"+h).src =movie_list[m1].SMALLPIC;	    
			  $("moviename"+h).innerText = movie_list[m1].VODNAME.substring(0,6);
		  }
	}
	for(var i=focus_pos+1;i<=5;i++){
	   	g+=1;
	  	g=g>5?0:g;
	   	m2+=1;
	    $("img_div"+g).style.left=18+232*i; 
		if(movie_list[m2].SMALLPIC){
			$("img"+g).src = movie_list[m2].SMALLPIC;	    
			$("moviename"+g).innerText = movie_list[m2].VODNAME.substring(0,6);
		}
	}
	for(var i=0;i<6;i++){
	  $("img_div"+i).style.webkitTransitionDuration="200ms";
	}
	 $("focus_div").style.webkitTransitionDuration="0ms";
	 $("focus_div").style.left=66+focus_pos*232;
	$("focus_div").style.webkitTransitionDuration="200ms";
}
function getDefaultData(xmlHttp){
	eval("movie_list=" + xmlHttp.responseText);
	movie_length = movie_list.length;
	initPreFocus();
	if(focus_area ==0){ 
		$("btn0").style.backgroundImage = "url(" + btnArr[0][0] + ")";
		$("btn"+btnPos).style.top = "220px";
		$("btnsd"+btnPos).style.webkitTransform = "scale(0.8)";
	}
	else if(focus_area ==1){
		$("focus_div").style.opacity =1;
		$("bgPic"+idPos).src ="images/vod/movie1.png";
		$("moviename"+idPos).style.color = "#ffffff";
		$("img_div"+idPos).style.webkitTransform = "scale(1.15)";
	
		
	}
	if(myArray.length==0){
		if(movie_list[movie_pos].ISSITCOM == 1)	focus_area = 2;//判断是否是电视剧还是电影
	}	
	show_movie_info();
	initListBox();
	getList();
	$("btn0").style.webkitTransitionDuration="200";
	$("btnsd0").style.webkitTransitionDuration="200";
	$("dsjFocus").style.webkitTransitionDuration="100";
	$("mark").style.webkitTransitionDuration="100";
	dataNoReady=false;
}

function showMarkTd(movie_pos){
	for(var m=0;m<markArray.length;m++){
		if(markArray[m].value==0){
			$("marktd"+m).style.backgroundImage="url(images/vod/global_tm.gif)";
		}else{
			$("marktd"+m).style.backgroundImage="url(images/vod/mark.png)";
		}
	}
}

function initHasMark(movie_pos){
	for(var m=0;m<movie_list[movie_pos].BOOKMARKINFO.length;m++){
		markArray[parseInt(movie_list[movie_pos].BOOKMARKINFO[m][0])-1].value=1;
		markArray[parseInt(movie_list[movie_pos].BOOKMARKINFO[m][0])-1].url=movie_list[movie_pos].BOOKMARKINFO[m][1];
	}
}

var markArray=[];
function initMarkArray(movie_pos){
	for(var m= 0;m<parseInt(movie_list[movie_pos].SITCOMNUM);m++){
		markArray[m]={value:0,url:""};
	}
}

function initPreFocus(){
	if(myArray[0])
		focus_area = Math.floor(myArray[0]);
	if(myArray[1])
		movie_pos = Math.floor(myArray[1]);
	  idPos=(movie_pos+1)%6==0?5:(movie_pos+1)%6-1;
	if(myArray[2])
		jishuPos = Math.floor(myArray[2]);
	if(myArray[3])	
	   currPosition=Math.floor(myArray[3]);  
	if(myArray[4])
	   focus_pos=Math.floor(myArray[4]);
	if(myArray[5])
		 btnPos= Math.floor(myArray[5]); 
}
function initListBox(){
	listBox = new loopList(listSize,movie_pos,currPosition,"300ms", dataInfo.idArr, window, 1);
	listBox.firstPos.left = dataInfo.firstPos;
	listBox.firstStatus.left = dataInfo.firstStatus;
	listBox.endStatus.left = dataInfo.lastStatus;
	listBox.lastPos.left = dataInfo.endPos;
	listBox.loadFirstPic = changeFirstPic;
	listBox.loadLastPic = changeLastPic;
}
function showList(){
   for(var i=0; i< dataInfo.idArr.length; i++){
		if(movie_list[i].VODNAME){
			$("img"+i).src = movie_list[i].SMALLPIC;
			$("moviename"+i).innerText = movie_list[i].VODNAME.substring(0,6);
		}
		else{
			$("img"+i).src = "";
			$("moviename"+i).innerText = "";
		}
	} 
} 
function changeFirstPic(){	
	
	if(movie_list[movie_pos].SMALLPIC){
		$("img"+idPos).src = movie_list[movie_pos].SMALLPIC;
		$("moviename"+idPos).innerText = movie_list[movie_pos].VODNAME.substring(0,6);
	}
}

function changeLastPic(){
	
	if(movie_list[movie_pos].SMALLPIC){
		$("img"+idPos).src = movie_list[movie_pos].SMALLPIC;
		$("moviename"+idPos).innerText = movie_list[movie_pos].VODNAME.substring(0,6);
	}
}

function move_action(__num){
	movie_pos += __num;
	$("bgPic"+idPos).src = "images/vod/movie0.png";
	$("moviename"+idPos).style.color = "#393939";
	$(dataInfo.idArr[idPos]).style.webkitTransform = "scale(1)";
	idPos += __num;
	if(idPos > 5)
		idPos = 0;
	else if(idPos < 0)
		idPos = 5;
	$("bgPic"+idPos).src = "images/vod/movie1.png";
	$("moviename"+idPos).style.color = "#ffffff";
	$(dataInfo.idArr[idPos]).style.webkitTransform = "scale(1.15)";
	move_focus(__num);
	clearTimeout(show_info_timer);
	show_info_timer = setTimeout("show_movie_info()",100);
}

function move_focus(__direct){
	if(focus_pos == 4&& __direct > 0){
		listBox.changeList(__direct);
		return;
	}else if(focus_pos == 0&&__direct<0){
		listBox.changeList(__direct);
		return;
	}
	listBox.position += __direct;
	listBox.focusPos = ((listBox.focusPos + __direct)%listSize + listSize)%listSize;
	focus_pos += __direct;
	$("focus_div").style.left += __direct*232;

}

function show_movie_info(){
	var temp_movie = movie_list[movie_pos];
	$("movie_name").innerText = temp_movie.VODNAME ;
	$("movie_type").innerText = typeof temp_movie.FILMTYPE == "undefined" ? "未知" : temp_movie.FILMTYPE;
	$("movie_duration").innerHTML = temp_movie.ISSITCOM == 1 ? ("<span style='color:#F8D73C'>集数:</span>" + temp_movie.INFORMATION ) : ("<span style='color:#F8D73C'>片长:</span>" + temp_movie.ELAPSETIME + "分钟");
	var desc = temp_movie.INTRODUCE;
	if(desc.length > 51)
		$("desc").innerText = desc.substr(0, 49)+"...";
	else
		$("desc").innerText = desc.substr(0, 51);
	var str = "";
	var regExp = new RegExp(" ","g")
	for(var i=0; i<temp_movie.ACTOR.length; i++){
		 temp_movie.ACTOR[i]=temp_movie.ACTOR[i].replace(regExp , "");
		 str = str+temp_movie.ACTOR[i]+" ";
	}	 
	$("stardom").innerText = str.substr(0, 12);
	var str1 = "";
	for(var i=0; i<temp_movie.DIRECTOR.length; i++){
		 temp_movie.DIRECTOR[i]=temp_movie.DIRECTOR[i].replace(regExp , "");
		 str1 =str1+temp_movie.DIRECTOR[i] + " ";
	}	 
	$("director").innerText = str1.substr(0,12);
	$("poster_img").style.webkitTransitionDuration = "300ms";
	$("poster_img").src = movie_list[movie_pos].HUGEPIC;
	
	
	if(temp_movie.ISSITCOM == 1){
		 $("btn0").style.backgroundImage = "url("+btnArr[temp_movie.ISFAVO == 1 ? 2 : 3][0]+")";
		 $("btn1").style.backgroundImage = "url(images/vod/global_tm.gif)";	
		 $("btn2").style.backgroundImage = "url(images/vod/global_tm.gif)";	
		 $("btnsd1").style.backgroundImage = "url(images/vod/global_tm.gif)";
		 $("btnsd2").style.backgroundImage = "url(images/vod/global_tm.gif)";
	}	 
	else {
		$("btn1").style.backgroundImage = "url("+btnArr[1][temp_movie.HASBOOKMARK == 1 ? 0 : 2]+")";
		$("btn2").style.backgroundImage = "url("+btnArr[temp_movie.ISFAVO == 1 ? 2 : 3][0]+")";
		$("btnsd1").style.backgroundImage = "url(images/vod/icon_button_sd.png)";
		$("btnsd2").style.backgroundImage = "url(images/vod/icon_button_sd.png)";
	}	
	showJishuInfo(movie_pos);
	initMarkArray(movie_pos);
	initHasMark(movie_pos);
	showMarkTd(movie_pos);
	if(markArray[jishuPos].value==1&&focus_area == 2) $("mark").style.visibility="visible";
	else $("mark").style.visibility="hidden";
}

function $(__id){
	return document.getElementById(__id);

}

function showJishuInfo(n) {
	jishuFlag = movie_list[n].ISSITCOM == 1 ? true : false;
	if(jishuFlag) {
		$("btn0").style.top = "240px";		
		$("btnsd0").style.webkitTransform = "scale(1)";
		if(focus_area == 1){
			$("dsjFocus").style.backgroundImage = "url(images/vod/global_tm.gif)";
			$("dsjFocus").style.color = "blue";
		}
		else{
			$("dsjFocus").style.backgroundImage = "url("+btnArr[4][1]+")";
			$("dsjFocus").style.color = "white";
		}
		initDSJNumber();
		if(movie_list[movie_pos].HASBOOKMARK == 1) btnPos = 1;
		else btnPos = 2;
		$("dsjDiv").style.visibility = "visible";
		$("dsjFocus").style.opacity = 1;
	} else {
		$("btnsd0").style.backgroundImage = "url(images/vod/icon_button_sd.png)";
		if(focus_area == 1)
			$("btn0").style.backgroundImage = "url("+btnArr[0][0]+")";
		else
		$("btn"+btnPos).style.backgroundImage = "url("+btnArr[btnPos][1]+")";
		$("dsjFocus").style.backgroundImage = "url(images/vod/global_tm.gif)";
		$("dsjFocus").style.color = "blue";
		
		$("dsjDiv").style.visibility = "hidden";
		$("dsjFocus").style.opacity = 0;
	}
	$("dsjFocus").innerText = jishuPos+1;
	$("dsjFocus").style.top = "39px";
	$("mark").style.top ="41px";
	$("dsjFocus").style.left = -13+58*(jishuPos%7)+"px";
	$("mark").style.left = 46+58*(jishuPos%7)+"px";
	$("scrollBar").style.top = (-3+Math.floor((jishuPos)/(sumNum-1)*126))+"px";
	if(sumNum<4) $("scrollLen").style.height = 30+"px";
	else	$("scrollLen").style.height = (126/sumNum)+"px";
	if(markArray[jishuPos].value==1) $("mark").style.visibility="visible";
	else $("mark").style.visibility="hidden";
}
/*loopList 这个适用于div的overFlow嵌套的滑动(CSS2D)

*@_listSize(number) 列表的长度

*@_position(number) 用于记住焦点的位置

*@_direction(number)	移动的方向，0表示上下移动，1表现左右滑动

*@_duration(string)	 移动的时间为字符号，如：“700ms”, "1s"

*@_arrayList(string)	要移动的div的数组名,或是img的数组名

*@_listFlag(number) 		表示列表的长度是否与数据的长度一到， 如果一到为“1”， 否为“0”， 默认为 0

*@f (object) 当前窗体

*/

function loopList(_listSize,_position,_currPosition,_duration, _arrayList, f, _listFlag){
	this.listSize = _listSize;	//列表长度
	this.position = _position;	//数据的指定位置	
	this.duration = _duration;
	this.arrayList = _arrayList;
	this.dataSize = this.arrayList.length;	//数据长度
	this.currPosition = _currPosition;
	this.recodePos = 0;
	this.preFun = function(){};	//焦点还原之前的状态
	this.backFun = function(){};	//形成焦点之后的状态
	this.f = f;
	this.listFlag = typeof _listFlag == "undefined" ? 0:_listFlag;
	this.focusPos = this.position;
	this.recodeFocusPos = 0;
	
	this.firstPos = {top:"", left:""};		//第一个位置, 第一个参数为它的top， 第二个为left 值
	this.lastPos = {top:"", left:""};		//最后一个位置
	this.firstStatus = {top:"", left:""};	//第一个之前的状态位置
	this.endStatus = {top:"", left:""};	//最后一个之后的位置
	
	this.loadFirstPic = function(){};
	this.loadLastPic = function(){};
	
	this.changeList = function(_num){
		//if((this.position == this.dataSize - 1 && _num > 0)||(this.position == 0 && _num < 0)) return;
		this.recodePos = this.position;	//记住焦点移动之前的位置
		this.currPosition = ((this.currPosition + _num)%this.dataSize + this.dataSize)%this.dataSize;	//记一个初使的第一个位置
		this.position = ((this.position + _num)%this.dataSize + this.dataSize)%this.dataSize;	//记焦点的位置
		if(this.listFlag == 1){
			this.recodeFocusPos = this.focusPos;
			this.focusPos = ((this.focusPos + _num)%this.listSize + this.listSize)%this.listSize;
		}
		if(_num < 0){	//right or down
			
			this.$(this.arrayList[this.currPosition]).style.webkitTransitionDuration = "0s";	//将要切入的图片放置到初使位置
			if(this.listFlag == 1) this.loadFirstPic();	//this.listSize == this.dataSize 的时候，加载将要切入的图片
			//this.$(this.arrayList[this.currPosition]).style.top = this.firstStatus.top;
			this.$(this.arrayList[this.currPosition]).style.left = this.firstStatus.left;
			this.$(this.arrayList[this.currPosition]).style.webkitTransitionDuration = this.duration;//做切入的动作
			//this.$(this.arrayList[this.currPosition]).style.top = this.firstPos.top;
			this.$(this.arrayList[this.currPosition]).style.left = this.firstPos.left;
			for(var i = this.currPosition + 1; i < this.currPosition + this.listSize; i++){	//其它的赋值
				if(i%this.dataSize == this.recodePos) this.preFun();	//失去焦点之后的动作
				else if(i%this.dataSize == this.position) this.backFun();		//获得焦点的动作
				this.$(this.arrayList[i%this.dataSize]).style.webkitTransitionDuration = this.duration;
				this.$(this.arrayList[i%this.dataSize]).style.top = this.$(this.arrayList[(i + 1)%this.dataSize]).style.top;
				this.$(this.arrayList[i%this.dataSize]).style.left = this.$(this.arrayList[(i + 1)%this.dataSize]).style.left;
			}
			this.$(this.arrayList[(this.currPosition + this.listSize)%this.dataSize]).style.webkitTransitionDuration = this.duration;
			//this.$(this.arrayList[(this.currPosition + this.listSize)%this.dataSize]).style.top =  this.endStatus.top;	//切出的动作
			this.$(this.arrayList[(this.currPosition + this.listSize)%this.dataSize]).style.left =  this.endStatus.left;
		}else if(_num > 0){	//left	or up
			for(var i = this.currPosition + this.listSize - 2; i > this.currPosition - 1; i--){	//其它的赋值
				if(i%this.dataSize == this.recodePos) this.preFun();	//失去焦点之后的动作
				else if(i%this.dataSize == this.position) this.backFun();	//获得焦点的动作
				this.$(this.arrayList[i%this.dataSize]).style.webkitTransitionDuration = this.duration;
				this.$(this.arrayList[i%this.dataSize]).style.top = this.$(this.arrayList[(i - 1 + this.dataSize)%this.dataSize]).style.top;
				this.$(this.arrayList[i%this.dataSize]).style.left = this.$(this.arrayList[(i - 1 + this.dataSize)%this.dataSize]).style.left;
			}
			this.$(this.arrayList[(this.currPosition - 1 + this.dataSize)%this.dataSize]).style.webkitTransitionDuration = this.duration;
			//this.$(this.arrayList[(this.currPosition - 1 + this.dataSize)%this.dataSize]).style.top = this.firstStatus.top;	//切出的动作
			this.$(this.arrayList[(this.currPosition - 1 + this.dataSize)%this.dataSize]).style.left = this.firstStatus.left;
			
			this.$(this.arrayList[(this.currPosition + this.listSize - 1)%this.dataSize]).style.webkitTransitionDuration = "0s";//将要切入的图片放置到最末位置
			if(this.listFlag == 1) this.loadLastPic();		//this.listSize == this.dataSize 的时候，加载将要切入的图片
			//this.$(this.arrayList[(this.currPosition + this.listSize - 1)%this.dataSize]).style.top = this.endStatus.top;
			this.$(this.arrayList[(this.currPosition + this.listSize - 1)%this.dataSize]).style.left = this.endStatus.left;
			this.$(this.arrayList[(this.currPosition + this.listSize - 1)%this.dataSize]).style.webkitTransitionDuration = this.duration;//做切入动作
			//this.$(this.arrayList[(this.currPosition + this.listSize - 1)%this.dataSize]).style.top = this.lastPos.top;	
			this.$(this.arrayList[(this.currPosition + this.listSize - 1)%this.dataSize]).style.left = this.lastPos.left;
		}
	}
	
	this.$= function(id) {
		if(typeof(this.f) == "object"){
			return this.f.document.getElementById(id);
		}
		else{
			return document.getElementById(id);
		}
	}

}



</script>
</head>
<body background="images/vod/g_bg1.jpg" leftmargin="0" topmargin="0" onLoad="init()" scroll="no">
<div style="position:absolute; left:91px; top:54px; height:355px; width:246px;">
<img id="poster_img" src="" width="235" height="348" style="-webkit-transition-duration:300ms; border-radius:5px;"/>
<div style="position:absolute; left:-14px; top:-14px; height:376px; width:264px; background-image: url(images/vod/post_cover.png); background:no-repeat;"></div>
<div style="position:absolute; top:360px; left:-15px; width:263px; height:46px; background:url(images/vod/icon_post_sd.png) no-repeat"></div>
</div>
<div style="position:absolute; left:365px; top:37px; height:225px; width:840px;">
  <table width="100%" height="215" border="0" cellpadding="0" cellspacing="0" style="font-size:24px; color:#ffffff;">
    <tr>
      <td height="63" colspan="4" id="movie_name" style="font-size:50px;"></td>
    </tr>
    <tr>
      <td width="24%" height="38"><font color="#F8D73C">类型：</font> <span id="movie_type"></span></td>
      <td width="19%" id="movie_duration"></td>
      <td width="2%" rowspan="2" >&nbsp;</td>
      <td width="54%" rowspan="3" valign="top" style="line-height:40px; overflow:hidden"><font color="#F8D73C">简介：</font> <span id="desc"></span></td>
    </tr>
    <tr>
      <td height="38" colspan="2"><font color="#F8D73C">导演：</font> <span id="director"></span></td>
    </tr>
    <tr>
      <td height="76" colspan="2" valign="top" style="line-height:38px;"><font color="#F8D73C">主演：</font><span id="stardom"></span></td>
    </tr>
  </table>
  <div id="btn0" class="btn0" style="left:-2px; top:240px"></div>
 <div id="btn1" class="btn" style="left:147px;"><div id="shuqian" align="center" style="position:absolute; font-size:32px; color:#393939; width:102px; height:56px; left: 20px; top: 43px;"><span style="font-size:22px;"></span><br /></div></div>
 <div id="btn2" class="btn" style="left:296px"></div>
<div id="btnsd0" style="position:absolute; top:383px; left:20px; width:101px; height:35px; background:url(images/vod/icon_button_sd.png) no-repeat"></div>
 <div id="btnsd1" style="position:absolute; top:382px; left:167px; width:101px; height:35px; background:url(images/vod/icon_button_sd.png) no-repeat"></div>
 <div id="btnsd2" style="position:absolute; top:382px; left:319px; width:101px; height:35px; background:url(images/vod/icon_button_sd.png) no-repeat"></div>
</div>
<div id="movieListArea">
	<div id="img_div0" class="style3"><img id="bgPic0" src="images/vod/movie0.png" width="162" height="162" /><img id="img0" class="img" src="" /><div id="moviename0" class="text"></div></div>
  <div id="img_div1" class="style3"><img id="bgPic1" src="images/vod/movie0.png" width="162" height="162" /><img id="img1" class="img" src="" /><div id="moviename1" class="text"></div></div>
  <div id="img_div2" class="style3"><img id="bgPic2" src="images/vod/movie0.png" width="162" height="162" /><img id="img2" class="img" src="" /><div id="moviename2" class="text"></div></div>
  <div id="img_div3" class="style3"><img id="bgPic3" src="images/vod/movie0.png" width="162" height="162" /><img id="img3" class="img" src="" /><div id="moviename3" class="text"></div></div>
  <div id="img_div4" class="style3"><img id="bgPic4" src="images/vod/movie0.png" width="162" height="162" /><img id="img4" class="img" src="" /><div id="moviename4" class="text"></div></div>
  <div id="img_div5" class="style3"><img id="bgPic5" src="images/vod/movie0.png" width="162" height="162" /><img id="img5" class="img" src="" /><div id="moviename5" class="text"></div></div>
</div>
<div id="upSign"></div>
<div id="downSign"></div>
<div id="focus_div" style="position:absolute; width:214px; height:216px; top:486px; left:66px; background:url(images/vod/movieFocus.png) no-repeat; -webkit-transition-duration:300ms; opacity:0; z-index:3;"></div>
<div id="dsjDiv" style="position:absolute;  left:716px; top:268px; height:169px; width:292px; visibility:hidden; z-index:1">
 <div style="position:absolute; left:421px; top:-1px; height:166px; width:28px; background-image: url(images/vod/bar_bg1.png);"></div>

 <div id="scrollBar" style="position:absolute; left:416px; top:-2px; height:39px; width:39px; -webkit-transition-duration:100ms;">
 <img src="images/vod/g_up.png" width="39" height="20" /><img id="scrollLen" src="images/vod/g_middle.png" width="39" height="1" /><img src="images/vod/g_down.png" width="39" height="20" /></div>
 <div id="pageInfo" align="right" style="position:absolute; left:353px; top:183px; height:31px; width:109px; font-size:20px; color:#FFF; line-height:31px;"></div>
 
 <div id="content0" style="position:absolute; left:0px; top:0px; height:169px; width:402px; background-image:url(images/vod/jishubg1.png); background-position:center; background-repeat:no-repeat; z-index:1; overflow:hidden;">
 	
  <div id="data" style="position:absolute; left:0px; top:0px; height:169px; width:292px; -webkit-transition-duration:100ms;">
</div></div>
 <div id="dsjFocus" style="position:absolute; left:-13px; top:39px; height:88px; width:88px; text-align:center; font-size:25px; color:blue; line-height:85px; background-repeat:no-repeat; background-position:center; z-index:10; opacity:1; background-image:url(images/vod/icon_js_bg_1.png); z-index:2">
 </div>
<div id="mark" style="position:absolute; top:41px; left:46px ; width:27px; height:24px; background-image:url(images/vod/mark.png); background-repeat:no-repeat; background-position:right; z-index:11; visibility:hidden"></div>
</div>
<div id="readTips" style="position:absolute; left:350px; top:208px; height:122px; width:539px; background-image: url(images/vod/tck_bg1.png); text-align:center;">
 <table width="430" border="0" cellspacing="0" cellpadding="0" class="bg">
  <tr>
   <td height="120" colspan="2" align="center" style="font-size:28px; color:#f6ff00;" id="content">是否添加收藏？</td>
  </tr>

 </table>
</div>
<div style="position:absolute; left:75px; top:463px; height:29px; width:171px; font-family:黑体; font-size:26px; color:#FFFFFF">同类节目推荐</div>
<div id="bookmarkDiv" style="position:absolute; left:333px; top:233px; height:216px; width:725px; text-align:center; font-size:25px; color:blue; line-height:85px; background-repeat:no-repeat; background-position:center; z-index:10; opacity:1; background-image:url(images/vod/bookmarkbg.png);-webkit-transition-duration:300ms;-webkit-transform:scale(0) ">
	<div id="bookfocus" style="position:absolute; left:82px; top:69px;width:243px; height:75px; background-image:url(images/vod/book_focus0.png); background-position:center; background-repeat:no-repeat; "></div>
	<div id="playfocus" style="position:absolute; left:395px; top:69px;width:243px; height:75px; background-image:url(images/vod/play_focus1.png); background-position:center; background-repeat:no-repeat; "></div>
</div>
</body>
</html>
