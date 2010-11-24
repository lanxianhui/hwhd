<%@ include file="HD_preFocusElement.jsp" %>
<% String channelID = (String)request.getParameter("CHANNELID"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta name="designer" content="hwhd" />
	<meta name="page-view-size" content="1280*720" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="Page-Enter" content="blendTrans(Duration=1.0)">
<title>Channel</title>
<link href="css/default/HD_channelPortal.css" rel="stylesheet" type="text/css" />
<script src="js/mini.js" type="text/javascript"></script>
<script src="js/HD_channelPortal.js" type="text/javascript"></script>
</head>

<body onload="initTestId("<%=channelID%>");init();" id="body_id" onunload="exit();" scroll="no">


	<div id="channellog"></div>
	<div id="title"></div>
	
	<div id="main">
		<div class="subTextTr" id="t0" ></div>
		<div class="subTextTr" id="t1"></div>
		<div class="subTextTr" id="t2"></div>
		<div class="subTextTr" id="t3"></div>
		<div class="subTextTr" id="t4"></div>
		<div class="subTextTr" id="t5"></div>
		<div class="subTextTr" id="t6"></div>
		<div class="subTextTr" id="t7"></div>
		<div class="subTextTr" id="t8"></div>
		<div class="subTextTr" id="t9"></div>
	</div>

	<div id="back" ></div>
	<div id="page"></div>
	
	<div id="iconup"></div>
	<div id="icondown"></div>
	
	<div id="trailer_bg" ></div>
	<div id="trailer" ></div>
	<div id="logoDiv" > <img id="logo"/> </div>
	<div id="currprogram"> </div>
	<div id="nextprogram_one"> </div>
	<div id="nextprogram_two"> </div>
	
	<!-- 这里是回看页面自定义参数  -->
	

	<div id="tvod_main" >
		<div id="tvod_date">
			<div class="date" id="date0"></div>
			<div class="date" id="date1"></div>
			<div class="date" id="date2"></div>
			<div class="date" id="date3"></div>
			<div class="date" id="date4"></div>
			<div class="date" id="date5"></div>
			<div class="date" id="date6"></div>
			<div class="date" id="date7"></div>
			<div class="date" id="date8"></div>
		</div>
		
		<div id="tvod_tag" > </div>
		<div id="tvod_list">
			<div class="list" id="list0"></div>
			<div class="list" id="list1"></div>
			<div class="list" id="list2"></div>
			<div class="list" id="list3"></div>
			<div class="list" id="list4"></div>
			<div class="list" id="list5"></div>
			<div class="list" id="list6"></div>
			<div class="list" id="list7"></div>
			<div class="list" id="list8"></div>
		</div>
	</div>
	
	<div id="date_back" ></div>
	<div id="tvod_back" ></div>
	
	<div id="tvod_title" > </div>
	<div id="tvod_log"></div>
	<div id="tvod_iconup"></div>
	<div id="tvod_icondown"></div>
	<div id="readTips" >该频道无法回看,请稍后尝试!</div>
	
<input type="hidden" name="flag" id="flag" value="1">
</body>
</html> 