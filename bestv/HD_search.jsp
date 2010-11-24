<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ include file="HD_preFocusElement.jsp" %>
<%  String typeId = (String)request.getParameter("TYPE_ID"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="Page-Enter" content="blendTrans(Duration=0.5)">
<meta name="page-view-size" content="1280*720" />
<title>search</title>
<link href="css/default/HD_search.css" rel="stylesheet" type="text/css" />
<script src="js/mini.js" type="text/javascript"></script>
<script src="js/input.js" type="text/javascript"></script>
<script src="js/HD_search.js" type="text/javascript"></script>
</head>
<body  onLoad="init('<%=typeId%>')" id="bodyDiv" scroll="no">
	<div id="searchlog"></div>
	<div id="title">功能-搜索</div>
	<div id="hidden"></div>
	<div id="dialog">
	  <div id="DName"></div>
		<div id="close"></div>
		<div id="rail"></div>
		<div id="circleUp"></div>
		<div id="circleMiddle"></div>
		<div id="circleDown"></div>
		<div id="subFocus"></div>
		<div id="col0" class="two"></div>
		<div id="col1" class="two"></div>
		<div id="col2" class="two"></div>
		<div id="col3" class="two"></div>
		<div id="col4" class="two"></div>
		<div id="col5" class="two"></div>
		<div id="col6" class="two"></div>
		<div id="subpage"></div>
	</div>
	<div id="program">按节目名搜</div>
	<div id="name">按人名搜</div>
	<div id="text"></div>
	<div id="cursor"></div>
	<div id="tips">(请使用遥控器输入数字)</div>
	<div id="textImg"></div>
	<div id="search"><img src="images/search/magnifier.png" width="54" height="55" style="position:absolute; top:15px; left:10px;" /><img id="btn" src="images/search/btn_S.png" width="99" height="62" style="position:absolute; top:10px; left:280px;" /></div>
	<div id="keyboard">
		<div id="k0" class="K">A</div>
		<div id="k1" class="K">B</div>
		<div id="k2" class="K">C</div>
		<div id="k4" class="K" style="width:150px; background-image: url(images/search/btn_space.png);">删除</div>	
		<div id="k5" class="K">D</div>
		<div id="k6" class="K">E</div>
		<div id="k7" class="K">F</div>
		<div id="k9" class="K" style="width:150px; background-image: url(images/search/btn_space.png);">空格</div>
		<div id="k10" class="K" >G</div>		
		<div id="k11" class="K">H</div>
		<div id="k12" class="K">I</div>
		<div id="k13" class="K">J</div>	
		<div id="k14" class="K">K</div>	
		<div id="k15" class="K">L</div>
		<div id="k16" class="K">M</div>
		<div id="k17" class="K">N</div>
		<div id="k18" class="K">O</div>
		<div id="k19" class="K">P</div>	
		<div id="k20" class="K">Q</div>
		<div id="k21" class="K">R</div>
		<div id="k22" class="K">S</div>
		<div id="k23" class="K">T</div>
		<div id="k24" class="K">U</div>		
		<div id="k25" class="K">V</div>
		<div id="k26" class="K">W</div>
		<div id="k27" class="K">X</div>
		<div id="k28" class="K">Y</div>
		<div id="k29" class="K">Z</div>
	</div>
  <div id="column1">
    <div id="l0" class="one"></div>
    <div id="l1" class="one"></div>
    <div id="l2" class="one"></div>
    <div id="l3" class="one"></div>
    <div id="l4" class="one"></div>
    <div id="l5" class="one"></div>
    <div id="l6" class="one"></div>
    <div id="l7" class="one"></div>
    <div id="l8" class="one"></div>
    <div id="l9" class="one"></div>
    <div id="l10" class="one"></div>
    <div id="l11" class="one"></div>
    <div id="l12" class="one"></div>
    <div id="l13" class="one"></div>
  </div>
  <div id="page"></div>
  <div id="focus"></div>
  <div style="position:absolute; left:400px; top:35px; height:40px; width:55px;"><img id="up" src="images/search/up1.png" width="55" height="40" /></div>
  <div style="position:absolute; left:400px; top:665px; height:40px; width:55px;"><img id="down" src="images/search/down1.png" width="55" height="40" /></div>
</body>
</html>