<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ include file="HD_preFocusElement.jsp" %>

<% String positionCode = (String)request.getParameter("POSITIONCODE"); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="page-view-size" content="1280*720" />
<title></title>
<script src="js/mini.js" type="text/javascript"></script>
<style type="text/css">
	body{background:url(images/album/bg_album.jpg)}
	
	#title{position:absolute; top:20; left:55; width:400; height:90;}
	#text{ position:absolute; top:10; left:60; font-size:30; color:#FFFFFF;}
	
	#listDiv{ position:absolute; top:95px; left:80px; height:552px; width:1200px; z-index:1;}
	#listDiv .style3{position:absolute; width:162px; height:162px; -webkit-transition-duration:10ms; opacity:0; z-index:0;}
	#listDiv #list0{top:0px; left:0px;}
	#listDiv #list1{top:0px; left:242px;}
	#listDiv #list2{top:0px; left:484px;}
	#listDiv #list3{top:0px; left:726px;}
	#listDiv #list4{top:0px; left:968px;}
	#listDiv #list5{top:194px; left:0px;}
	#listDiv #list6{top:194px; left:242px;}
	#listDiv #list7{top:194px; left:484px;}
	#listDiv #list8{top:194px; left:726px;}
	#listDiv #list9{top:194px; left:968px;}
	#listDiv #list10{top:388px; left:0px;}
	#listDiv #list11{top:388px; left:242px;}
	#listDiv #list12{top:388px; left:484px;}
	#listDiv #list13{top:388px; left:726px;}
	#listDiv #list14{top:388px; left:968px;}
	#listDiv .img{position:absolute; left:20px; top:18px; height: 100px; width: 121px;}
	#listDiv .text{position:absolute; top:120px; left:8px; width:146px; height:34px; text-align:center; line-height:34px; font-size:22px; color:#393939;}
	#listDiv #listFocus{position:absolute; background-image:url(images/vod/movieFocus.png); width:214px; height:216px; left: -26px; top: -25px; -webkit-transition-duration:200ms; z-index:1;}

	#page{position:absolute; top:665px; left:60px; width:300px; height:34px;  font-size:22px; color:#FFFFFF;}
	#up{position:absolute; top:40px; left:600px; width:48px; height:26px; background-image:url(images/album/up.png); -webkit-transition-duration:200ms; opacity:0;}
	#down{position:absolute; top:665px; left:600px; width:48px; height:26px; background-image:url(images/album/down.png); opacity:0;}
</style>
<script>
	var col0_P;
	var nowPage;
	var totalPage;
	var total;
	var index_pro;
	function eventHandler(obj) {
	  switch(obj.code) {
		  case "KEY_UP":
		    changeFocusUD(1);
			  break;
		  case "KEY_DOWN":
		    changeFocusUD(-1);
			  break;
		  case "KEY_LEFT":
		    changeFocusLR(-1);
			  break;
		  case "KEY_RIGHT":
		    changeFocusLR(1);
			  break;
		  case "KEY_PAGE_UP":    
			  break;
		  case "KEY_PAGE_DOWN":
			  break;
			case "KEY_SELECT":
			  var toUrl =program[col0_P+index_pro].SUBJECTURL;
			  $("listFocus").style.webkitTransitionDuration="250ms";
		    $("listFocus").style.webkitTransform = "scale(1)";
		    $("listFocus").style.opacity = 0;
			  document.location="HD_saveCurrFocus.jsp?currFocus="+col0_P+","+nowPage+"&url=" + toUrl;
			  break;
			case "KEY_BACK":
			  document.location = backUrl;
			  break;
	  }
  }

  var program;
  
  function Move_Focus(from,to){
  	album_blur(from);
  	album_focus(to);
  }
  function changeFocusLR(num){
  	if(num>0){
  		if(col0_P%5==4||(index_pro+col0_P+1)>=total){ return;}
  		col0_P++;
  	}
  	if(num<0){
  		if(col0_P%5==0){ return;}
  		col0_P--;
  	}
  	Move_Focus(col0_P-num,col0_P);
  }
  function changeFocusUD(num){
  	if(num>0){
  		if(col0_P<5){
  			if(index_pro!=0){ turnPage(1); }
  			return;
  		}
  		col0_P-=5;
  	}
  	if(num<0){
  		if((index_pro+col0_P+6)>total){ return; }
  		if(col0_P>9){
  			if((index_pro+15)<=total){ turnPage(-1);}
  			return;
  		}
  		col0_P+=5;
  	}
  	Move_Focus(col0_P+num*5,col0_P);
  }
  function turnPage(num){
  	album_blur(col0_P);
  	col0_P=0;
  	if(num>0){
  		nowPage--;
  		index_pro-=15; 
  	}
  	if(num<0){ 
  		nowPage++;
  		index_pro+=15;  		
  	}
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
  	showProgram();
  }
  function album_focus(num){
  	$("listFocus").style.top = -25+194*Math.floor(num/5);
		$("listFocus").style.left = -26+242*(num%5);
  	$("list"+num).style.webkitTransform = "scale(1.15)";
		$("bgPic"+num).src = "images/album/movie1.png";
		$("text"+num).style.color = "#ffffff";
  }
  function album_blur(num){
  	$("list"+num).style.webkitTransform = "scale(1)";
		$("bgPic"+num).src = "images/album/movie0.png";
		$("text"+num).style.color = "#393939";
  }
  function showProgram(){
  	for(var i=0;i<15;i++){
  		if((index_pro+i+1)>total){ 
  			$("list"+i).style.opacity = 0;
  			continue;
  		}
  		$("list"+i).style.opacity = 1;
  		$("img"+i).src = program[i+index_pro].SUBJECTPIC;
  		$("text"+i).innerText = program[i+index_pro].SUBJECTNAME.substring(0,6);
    }
  	album_focus(col0_P);
  }
  function getProgramInfo(__xmlhttp){
  	var data = eval(__xmlhttp.responseText);
    program = data;
    total = program.length;
    totalPage = Math.floor((total-1)/15+1);
	  $("page").innerText = nowPage+"/"+totalPage+"页";
	  if(nowPage!=1){ $("up").style.opacity = 1;}
	  if(nowPage!=totalPage){ $("down").style.opacity = 1;}
	  showProgram();
  }
  function reqProgramInfo(code){
  	var url = "HD_subjectData.jsp?POSITIONCODE="+code;
	  var ajax = new AJAX_OBJ(url, getProgramInfo);
	  ajax.requestData();
  }
  function initProgram(){ reqProgramInfo("<%=positionCode%>"); }
  function initTitle(){
  	$("album").src="images/album/album.png";
  	$("text").innerText = "专辑";
  }
  function init(){
  	if(myArray[0]==null){
  	  col0_P = 0;
  	  nowPage = 1;
  	}else{
  	  col0_P = parseInt(myArray[0]);
  	  nowPage = parseInt(myArray[1]);
    }
  	index_pro = 15*(nowPage-1);
  	initTitle();
  	initProgram();
  }
</script>
</head>
<body margin="0" onLoad="init()" >
  <div id="listDiv">
	  <div id="list0" class="style3"><img id="bgPic0" src="images/album/movie0.png" width="162" height="162" /><img id="img0" class="img"/><div id="text0" class="text"></div></div>
	  <div id="list1" class="style3"><img id="bgPic1" src="images/album/movie0.png" width="162" height="162" /><img id="img1" class="img"/><div id="text1" class="text"></div></div>
	  <div id="list2" class="style3"><img id="bgPic2" src="images/album/movie0.png" width="162" height="162" /><img id="img2" class="img"/><div id="text2" class="text"></div></div>
	  <div id="list3" class="style3"><img id="bgPic3" src="images/album/movie0.png" width="162" height="162" /><img id="img3" class="img"/><div id="text3" class="text"></div></div>
	  <div id="list4" class="style3"><img id="bgPic4" src="images/album/movie0.png" width="162" height="162" /><img id="img4" class="img"/><div id="text4" class="text"></div></div>
	  <div id="list5" class="style3"><img id="bgPic5" src="images/album/movie0.png" width="162" height="162" /><img id="img5" class="img"/><div id="text5" class="text"></div></div>
	  <div id="list6" class="style3"><img id="bgPic6" src="images/album/movie0.png" width="162" height="162" /><img id="img6" class="img"/><div id="text6" class="text"></div></div>
	  <div id="list7" class="style3"><img id="bgPic7" src="images/album/movie0.png" width="162" height="162" /><img id="img7" class="img"/><div id="text7" class="text"></div></div>
	  <div id="list8" class="style3"><img id="bgPic8" src="images/album/movie0.png" width="162" height="162" /><img id="img8" class="img"/><div id="text8" class="text"></div></div>
	  <div id="list9" class="style3"><img id="bgPic9" src="images/album/movie0.png" width="162" height="162" /><img id="img9" class="img"/><div id="text9" class="text"></div></div>
	  <div id="list10" class="style3"><img id="bgPic10" src="images/album/movie0.png" width="162" height="162" /><img id="img10" class="img"/><div id="text10" class="text"></div></div>
	  <div id="list11" class="style3"><img id="bgPic11" src="images/album/movie0.png" width="162" height="162" /><img id="img11" class="img"/><div id="text11" class="text"></div></div>
	  <div id="list12" class="style3"><img id="bgPic12" src="images/album/movie0.png" width="162" height="162" /><img id="img12" class="img"/><div id="text12" class="text"></div></div>
	  <div id="list13" class="style3"><img id="bgPic13" src="images/album/movie0.png" width="162" height="162" /><img id="img13" class="img"/><div id="text13" class="text"></div></div>
	  <div id="list14" class="style3"><img id="bgPic14" src="images/album/movie0.png" width="162" height="162" /><img id="img14" class="img"/><div id="text14" class="text"></div></div>
	  <div id="listFocus"></div>
  </div>
  <div id="title"><img id="album"/><div id="text"></div></div>
  <div id="page"></div>
  <div id="up"></div>
  <div id="down"></div>
</body>
</html>