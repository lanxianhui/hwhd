<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ include file="HD_preFocusElement.jsp" %>

<% 
   String typeId = (String)request.getParameter("TYPE_ID"); 
   String position = (String)request.getParameter("POSITION");
   if("".equals(position)||position==null){ position = "1"; }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="page-view-size" content="1280*720" />
<meta http-equiv="Page-Enter" content="blendTrans(Duration=2.0)">
<title></title>
<script src="js/mini.js" type="text/javascript"></script>
<style type="text/css">
	body{background:url(images/HD/bg_HD.jpg)}
	#row0{position:absolute; text-align:center; font-size:30; color:#B3B3B3; top:15; left:0; width:233; height:684; background:url(images/HD/Menu.png);}
	.r0{position:absolute; height:69; z-index:1; -webkit-transition-duration:400ms;width:233;}
	#bgRec{position:absolute; top:-10; left:35; width:160; height:69; background:url(images/HD/HDchannel.png); }
	#row00{color:#393939; top:10;} #row01{top:100;} #row02{top:180;} #row03{top:260;} #row04{top:340;} #row05{top:420;}	
	#col0focus{position:absolute; left:0; top:73; width:214; height:80; background:url(images/HD/choose_focus.png); -webkit-transition-duration:200ms; }

	#title{position:absolute; top:10; left:250; width:400; height:90;}
	#text{ position:absolute; top:10; left:60; font-size:30; color:#FFFFFF;}

	#listDiv{ position:absolute; top:95px; left:310px; height:552px; width:888px; z-index:1;}
	#listDiv .style3{position:absolute; width:162px; height:162px; -webkit-transition-duration:10ms; opacity:0; z-index:0; }
	#listDiv #list0{top:0px; left:0px;}
	#listDiv #list1{top:0px; left:242px;}
	#listDiv #list2{top:0px; left:484px;}
	#listDiv #list3{top:0px; left:726px;}
	#listDiv #list4{top:194px; left:0px;}
	#listDiv #list5{top:194px; left:242px;}
	#listDiv #list6{top:194px; left:484px;}
	#listDiv #list7{top:194px; left:726px;}
	#listDiv #list8{top:388px; left:0px;}
	#listDiv #list9{top:388px; left:242px;}
	#listDiv #list10{top:388px; left:484px;}
	#listDiv #list11{top:388px; left:726px;}
	#listDiv .img{position:absolute; left:20px; top:18px; height: 100px; width: 121px;}
	#listDiv .text{position:absolute; top:120px; left:8px; width:146px; height:34px; text-align:center; line-height:34px; font-size:22px; color:#393939; overflow:hidden}
	#listDiv #listFocus{position:absolute; background-image:url(images/vod/movieFocus.png); width:214px; height:216px; left: -26px; top: -25px; -webkit-transition-duration:200ms; opacity:0; z-index:1;}

	#page{position:absolute; top:665px; left:280px; width:300px; height:34px;  font-size:22px; color:#FFFFFF;}
	#up{position:absolute; top:40px; left:720px; width:48px; height:26px; background-image:url(images/HD/up.png); -webkit-transition-duration:200ms; opacity:0;}
	#down{position:absolute; top:665px; left:720px; width:48px; height:26px; background-image:url(images/HD/down.png); -webkit-transition-duration:200ms; opacity:0;}
</style>
<script>
	var areaFlag;
	var col0_P;
    var keyFlag0 = true;

	var menu;
	var program;
	var showType = [-1,1,1,1,1,1];
	
	var col1_P;
	var index_col1;
	var total_col1;
	var nowPage;
	var totalPage;
	function eventHandler(obj) {
	  switch(obj.code) {
		  case "KEY_UP":
		    if(areaFlag==0){
		    	changeMenuFocus(1);
		    }else if(areaFlag==1){
		    	if(showType[col0_P]==0){
		      }else if(showType[col0_P]==1){
		      	changeFocus1UD(1);
		      }
		    }
			  break;
		  case "KEY_DOWN":
		    if(areaFlag==0){
		    	changeMenuFocus(-1);
		    }else if(areaFlag==1){
		    	if(showType[col0_P]==0){

		      }else if(showType[col0_P]==1){
		      	changeFocus1UD(-1);    	
		      }
		    }
			  break;
		  case "KEY_LEFT":
		    if(areaFlag==1){
		    	if(showType[col0_P]==0){
		    		leaveArea1_type0();
		    		toArea0();
		      }else if(showType[col0_P]==1){
		      	changeFocus1LR(-1);
		      }
		    }
			  break;
		  case "KEY_RIGHT":
		    if(areaFlag==0){
		    	if(showType[col0_P]==-1){ break; }
		    	if (program[0].count > 0){
		    		leaveArea0();
		    		if(showType[col0_P]==0){
		    			toArea1_type0();
		    		}else if(showType[col0_P]==1){
		    			toArea1_type1();
		    		}
		    	}
		    }else if(areaFlag==1){
		    	changeFocus1LR(1);
		    }
			  break;
		  case "KEY_PAGE_UP":
			  turnPage(1);
			  break;
		  case "KEY_PAGE_DOWN":
			  turnPage(-1);
			  break;
			case "KEY_BACK":
			  document.location = backUrl;
			  break;
			case "KEY_SELECT":
			  var toUrl;
			  if(areaFlag == 0&&col0_P == 0){
			  	toUrl = "HD_channelPortal.jsp?source=hd";
			  	$("col0focus").style.webkitTransitionDuration="250ms";
		        $("col0focus").style.webkitTransform = "scale(1)";
		        $("col0focus").style.opacity = 0; 
		        document.location="HD_saveCurrFocus.jsp?currFocus="+areaFlag+","+col0_P+","+col1_P+","+nowPage+"&url=" + toUrl;
			  }else if(areaFlag == 1){
			  	  toUrl = program[0].sub[col1_P+index_col1].url;
			  	  $("listFocus").style.webkitTransitionDuration="250ms";
		         $("listFocus").style.webkitTransform = "scale(1)";
		         $("listFocus").style.opacity = 0;
//		         alert(toUrl);
			      document.location="HD_saveCurrFocus.jsp?currFocus="+areaFlag+","+col0_P+","+col1_P+","+nowPage+"&url=" + toUrl;
			  }
			  break;
	  }
	}
	function leaveArea0(){
		$("col0focus").style.background="url(images/HD/choose.png)";
	}
	function toArea0(){
	  	areaFlag=0;
	  	$("col0focus").style.background="url(images/HD/choose_focus.png)";
  	}
  	function leaveArea1_type0(){}
  
  	function toArea1_type0(){
  		areaFlag=1;
  	}
  	
  	function leaveArea1_type1(){
	  	$("listFocus").style.opacity = 0;
	  	area11_blur(col1_P);
  	}
  	
  	function toArea1_type1(){
	  	areaFlag=1;
	  	col1_P=0;
	  	$("listFocus").style.opacity = 1;
	  	area11_focus(col1_P);
  	}
  
  /***********************************************************************/
	 function Move_Focus1(from,to){
		 area11_blur(from);
		 area11_focus(to);
	 }
  
  	//右侧左右按键事件处理
  	function changeFocus1LR(num){
	  	if(num>0){
	  		if(col1_P%4==3||(index_col1+col1_P+1)>=total_col1){ return;}
	  		col1_P++;
	  	}
	  	if(num<0){
	  		if(col1_P%4==0){
	  			leaveArea1_type1();
	  			toArea0();
	  			return;
	  		}
	  		col1_P--;
	  	}
	  	Move_Focus1(col1_P-num,col1_P);
  	}
  
  	//右侧上下翻页事件处理
  	function turnPage(num){
  		
  		if(totalPage > 1) {
		  	if(num>0){
		  		if (nowPage == 1) 
		  		{
		  			nowPage = totalPage;
		  			index_col1	=	(nowPage-1)*12;
		  		} else {
		  			nowPage--;
		  			index_col1-=12;
		  		}
		  		if((index_col1+1)%72){ //发新请求
		  		}
		  		$("text"+col1_P).innerText = program[0].sub[col1_P].name.substring(0,6);		  		
		  		col1_P=0;
		  		
		  		$("page").innerText = nowPage+"/"+totalPage+"页";
		  		if(totalPage!=1){ 
		  			$("up").style.opacity = 1;
		  		  	$("down").style.opacity = 1;
		  		}else{
		  			$("up").style.opacity = 0;
		  		  	$("down").style.opacity = 0;
		  		}
		  		for(var i=0;i<12;i++){
		  			if(program[0].sub.length<(i+1+index_col1)){
		  			  $("list"+i).style.opacity = 0;
		  			  continue;
		  			}
					$("bgPic"+i).src = "images/HD/movie0.png";
		  			$("list"+i).style.opacity = 1;
		  			$("img"+i).src = program[0].sub[index_col1+i].pic;
					$("list"+i).style.webkitTransform = "scale(1)";
					$("text"+i).style.color = "#393939";
					$("text"+i).style.top="120px";
					$("text"+i).innerText = program[0].sub[index_col1+i].name.substring(0,6);
		  		}
				Move_Focus1(col1_P,0);
		  	}
		  	if(num<0){
		  		if(nowPage == totalPage) {
		  			nowPage  =  1;
		  			index_col1	=	(nowPage-1)*12;
		  		} else {
		  			nowPage++;
		  			index_col1+=12;
		  		}
		  		if((index_col1+1)%72){ //发新请求
		  		}
				$("text"+col1_P).innerText = program[0].sub[col1_P].name.substring(0,6);	
		  		col1_P=0;
		  		
		  		$("page").innerText = nowPage+"/"+totalPage+"页";
		  		if(totalPage!=1){ 
		  			$("up").style.opacity = 1;
		  			$("down").style.opacity = 1;
		  		}else{
		  			$("up").style.opacity = 0;
		  			$("down").style.opacity = 0;
		  	  	}
		  		for(var i=0;i<12;i++){
		  			if(program[0].sub.length<(i+1+index_col1)){
		  			  $("list"+i).style.opacity = 0;
		  			  continue;
		  			}
					$("bgPic"+i).src = "images/HD/movie0.png";
		  			$("list"+i).style.opacity = 1;
		  			$("img"+i).src = program[0].sub[index_col1+i].pic;
					$("list"+i).style.webkitTransform = "scale(1)";
					$("text"+i).style.color = "#393939";
					$("text"+i).style.top="120px";
					$("text"+i).innerText = program[0].sub[index_col1+i].name.substring(0,6);
					
		  		}
				Move_Focus1(col1_P,0);
		  	}
  		}
  	}
    //右侧上下按钮事件处理
  	function changeFocus1UD(num){
	  	if(num>0){
	  		if(col1_P<4){
	  			if(index_col1!=0){ turnPage(1); }
	  			return;
	  		}
	  		col1_P-=4;
	  	}
	  	if(num<0){
	  		if((index_col1+col1_P+5)>total_col1){ return; }
	  		if(col1_P>7){
	  			if((index_col1+12)<=total_col1){ turnPage(-1);}
	  			return;
	  		}
	  		col1_P+=4;
	  	}
	  	Move_Focus1(col1_P+num*4,col1_P);
  	}
  	
  	/***********************************************************************/
  	//当光标移动到左侧分类时请求数据
  	function Menu_move(from,to){
	  	if(to==0){
	  		$("col0focus").style.background="url(images/HD/HDchannel_focus.png)";
	  		$("col0focus").style.left = 35;
	  		$("col0focus").style.top = -5;
	  		$("col0focus").style.width = 160;
	  		$("col0focus").style.height = 69;
	  	}else{
	  		if(from==0){
	  			$("col0focus").style.background="url(images/HD/choose_focus.png)";
	  			$("col0focus").style.left = 0;
	  		  $("col0focus").style.width = 214;
	  		  $("col0focus").style.height = 80;
	  		  $("row0"+from).style.color="#393939";
	  		}
	  		$("col0focus").style.top = 73+(to-1)*80;
	  	}
	  	if(from!=0) { $("row0"+from).style.color="#B3B3B3"; }
	  	setTimeout(function(){$("row0"+to).style.color="#FFFFFF";},250);
	  	col1_P = 0;
	  	nowPage = 1;
	  	initTitle(to);
	  	reqProgram(menu[0].VALUE[to].CATEGORYID);
  	}
  
  	//上下移动菜单栏光标
  	function changeMenuFocus(num){
	  	if(keyFlag0){
	  		keyFlag0 = false;
	  		setTimeout("keyFlag0 = true;",300);
	  	  if(num>0){
	  	  	if(col0_P == 0){ return;}
	  		  col0_P--;
	  		  if(col0_P<0){ 
	  			  col0_P = 0;
	  			  return;
	  		  }
	  	  }
	      if(num<0){
	      	if(col0_P==5){ return;}
	    	  col0_P++;
	  		  if(col0_P>5){
	  			  col0_P = 5;
	  			  return;
	  		  }
	      }
	      Menu_move(col0_P+num,col0_P);
	    }
  	}

    //高亮右边光标
  	function area11_focus(num){
	  	$("listFocus").style.top = -25+194*Math.floor(num/4);
		$("listFocus").style.left = -26+242*(num%4);
//	  	$("list"+num).style.webkitTransform = "scale(1.15)";
	  	setTimeout(function () {
	  		$("list"+num).style.webkitTransform = "scale(1.15)";
	  		$("bgPic"+num).src = "images/HD/movie1.png";
	  	}, "100");
		
		$("text"+num).style.color = "#ffffff";
		$("text"+num).innerText=program[0].sub[index_col1 + num].name.substr(0,6);
		if (program[0].sub[num].name.length > 6) {
			$("text"+num).style.top="127px";
			$("text"+num).innerHTML="<marquee>"+program[0].sub[index_col1 + num].name+"</marquee>";
		}
	}
  	
  	//灰掉右边光标
  	function area11_blur(num){
	  	$("list"+num).style.webkitTransform = "scale(1)";
		$("bgPic"+num).src = "images/HD/movie0.png";
		$("text"+num).style.color = "#393939";
		$("text"+num).style.top="120px";
		$("text"+num).innerText=program[0].sub[index_col1 + num].name.substr(0,6);
	}
  	//初始化右侧分类数据
  	function initProgram(){
	  	index_col1=(nowPage-1)*12;
	  	total_col1= program[0].count;
	  	if (total_col1 > 1) totalPage = 1+Math.floor((total_col1-1)/12);
	  	else totalPage	=	1;
	  	
	  	$("page").innerText = nowPage+"/"+totalPage+"页";
	  	if(nowPage!=1){ 
	  		$("up").style.opacity = 1;
	  	}else{
	  		$("up").style.opacity = 0;
	  	}
	  	
	  	if(nowPage!=totalPage){ 
	  		$("down").style.opacity = 1;
	  	}else{
	  		$("down").style.opacity = 0;
	  	}

  		for(var i=0;i<12;i++){
  			if(program[0].sub.length<(index_col1+i+1)){
  			  $("list"+i).style.opacity = 0;
  			  continue;
  			}
  			$("list"+i).style.opacity = 1;
  			$("img"+i).src = program[0].sub[i+index_col1].pic;
  			$("text"+i).innerText = program[0].sub[i+index_col1].name.substring(0,6);
  		}
	  	if(areaFlag==1){
	  		$("listFocus").style.opacity = 1;
	  		area11_focus(col1_P);
	  	}
  	}
  
  	//请求当前分类下数据
  	function getProgramInfo(__xmlhttp){
  		var data = eval(__xmlhttp.responseText);
  		program = data;
  		initProgram();
  	}

  	//初始化当前分类下数据
	function reqProgram(typeId){
	    var url;
	    if (col0_P >= 1) {
		  	if(showType[col0_P]==0){
		  		url = "HD_vodCategoryData.jsp?TYPE_ID="+typeId+"&DISPLAY=0";
		  	}else if(showType[col0_P]==1){
		  		url = "HD_vodCategoryData.jsp?TYPE_ID="+typeId+"&DISPLAY=1";
		  	}
		  	else if(showType[col0_P]==-1){
		  		url = "HD_vodCategoryData.jsp?TYPE_ID="+typeId+"&DISPLAY=1";
		  	}
		  	
			var ajax = new AJAX_OBJ(url, getProgramInfo);
			ajax.requestData();
	    }
	}
  
  	//显示左侧导航
  	function initMenu(num){
	  	for(var i=0;i<6;i++){
	  		if(i==num){ $("row0"+i).style.color="#FFFFFF"; }
	  		$("row0"+i).innerText = menu[0].VALUE[i].CATEGORYNAME;
	  	}
	  	if(areaFlag==0){
	  		if (col0_P == 0){
	  	  		$("col0focus").style.background="url(images/HD/HDchannel_focus.png)";
	  	  		$("col0focus").style.left = 35;
	  	  		$("col0focus").style.top = -5;
	  	  		$("col0focus").style.width = 160;
	  	  		$("col0focus").style.height = 69;
	  		} else {
	  			$("col0focus").style.background="url(images/HD/choose_focus.png)";
	  		}
	  	}else{
	  		$("col0focus").style.background="url(images/HD/choose.png)";
	  	}
	  	
	  	$("col0focus").style.top = 73+(num-1)*80;
	}

  	//显示栏目logo和名称
	function initTitle(num){
		$("HD").src="images/HD/HD.png";
		$("text").innerText = "高清-"+menu[0].VALUE[num].CATEGORYFULLNAME;
	}
  
    //加载菜单数据
    function getMenuInfo(__xmlhttp){
	  	var data = eval(__xmlhttp.responseText);
	    menu = data;
	    initMenu(col0_P);
	    initTitle(col0_P);
	    reqProgram(menu[0].VALUE[col0_P].CATEGORYID);
    }
  
    //请求页面参数
    function reqMenuInfo(typeId){
	  	var url = "HD_vodAction.jsp?TYPE_ID="+typeId;
		var ajax = new AJAX_OBJ(url, getMenuInfo);
		ajax.requestData();
    }
  
    //加载页面参数
    function initPage(num){	reqMenuInfo("<%=typeId%>"); }
 
    //初始化页面数据参数
    function init(){
      if(myArray[0]==null){
  		  areaFlag = 0;
  		  col0_P = parseInt("<%=position%>");
  		  col1_P = 0;
  		  nowPage = 1;
  	  }else{
  		  areaFlag = parseInt(myArray[0]);
  		  col0_P = parseInt(myArray[1]);
  		  col1_P = parseInt(myArray[2]);
  		  nowPage = parseInt(myArray[3]);
      }
  	  initPage();
    }
</script>
</head>
<body margin="0" onLoad="init()" scroll="no">
	<div id="row0">
		<div id="bgRec"></div>
		<div id="row00" class="r0"></div>
		  <div id="row01" class="r0"></div>
		  <div id="row02" class="r0"></div>
		  <div id="row03" class="r0"></div>
		  <div id="row04" class="r0"></div>
		  <div id="row05" class="r0"></div>
	  <div id="col0focus"></div>
	</div>
	<div id="title"><img id="HD"/><div id="text"></div></div>
	<div id="listDiv">
	  <div id="list0" class="style3"><img id="bgPic0" src="images/HD/movie0.png" width="162" height="162" /><img id="img0" class="img"/><div id="text0" class="text"></div></div>
	  <div id="list1" class="style3"><img id="bgPic1" src="images/HD/movie0.png" width="162" height="162" /><img id="img1" class="img"/><div id="text1" class="text"></div></div>
	  <div id="list2" class="style3"><img id="bgPic2" src="images/HD/movie0.png" width="162" height="162" /><img id="img2" class="img"/><div id="text2" class="text"></div></div>
	  <div id="list3" class="style3"><img id="bgPic3" src="images/HD/movie0.png" width="162" height="162" /><img id="img3" class="img"/><div id="text3" class="text"></div></div>
	  <div id="list4" class="style3"><img id="bgPic4" src="images/HD/movie0.png" width="162" height="162" /><img id="img4" class="img"/><div id="text4" class="text"></div></div>
	  <div id="list5" class="style3"><img id="bgPic5" src="images/HD/movie0.png" width="162" height="162" /><img id="img5" class="img"/><div id="text5" class="text"></div></div>
	  <div id="list6" class="style3"><img id="bgPic6" src="images/HD/movie0.png" width="162" height="162" /><img id="img6" class="img"/><div id="text6" class="text"></div></div>
	  <div id="list7" class="style3"><img id="bgPic7" src="images/HD/movie0.png" width="162" height="162" /><img id="img7" class="img"/><div id="text7" class="text"></div></div>
	  <div id="list8" class="style3"><img id="bgPic8" src="images/HD/movie0.png" width="162" height="162" /><img id="img8" class="img"/><div id="text8" class="text"></div></div>
	  <div id="list9" class="style3"><img id="bgPic9" src="images/HD/movie0.png" width="162" height="162" /><img id="img9" class="img"/><div id="text9" class="text"></div></div>
	  <div id="list10" class="style3"><img id="bgPic10" src="images/HD/movie0.png" width="162" height="162" /><img id="img10" class="img"/><div id="text10" class="text"></div></div>
	  <div id="list11" class="style3"><img id="bgPic11" src="images/HD/movie0.png" width="162" height="162" /><img id="img11" class="img"/><div id="text11" class="text"></div></div>
	  <div id="listFocus"></div>
  </div>
  <div id="page"></div>
  <div id="up"></div>
  <div id="down"></div>
</body>
</html>
