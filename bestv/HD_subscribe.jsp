<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ include file="HD_preFocusElement.jsp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.bestv.epg.util.MessageUtil" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta name="designer" content="hwhd" />
	<meta http-equiv="Page-Enter" content="blendTrans(Duration=1.0)">
	<meta name="page-view-size" content="1280*720" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>pay</title>
<link href="css/default/HD_subscribe.css" rel="stylesheet" type="text/css" />
<script src="js/mini.js" type="text/javascript"></script>
<script src="js/HD_subscribe.js" type="text/javascript"></script>
</head>
<body  id="body" onload="init();" >

<div id="protection">
	<div id="name"></div>
	<div id="logo"></div>
	<div id="cover"></div>
	<div id="icon_post"></div>
	<div id="buy"></div>
	<div id="return"></div>
	
	<div id="ppv">
		<div id="tariff">资费: </div>
		<div id="tariff_money"></div>
		<div id="expires">有效期: </div>
		<div id="expression"></div>
	</div>
	
	<div id="recommend">
		<div id="recommend_buy"></div>
		<div id="recommend_1"></div>
		<div id="recommend_2"></div>
		<div id="recommend_3"></div>
	</div>
	<div id="recommend_money">
		<div id="price">
			<div id="price_0"></div>
			<div id="price_1"></div>
			<div id="price_2"></div>
			<div id="price_3"></div>
		</div>
	</div>
	<div id="popularity">
		<div id="popularity_buy"></div>
		<div id="popularity_1"></div>
		<div id="popularity_2"></div>
		<div id="popularity_3"></div>
	</div>
	<div id="popularity_money">
		<div id="money_0"></div>
		<div id="money_1"></div>
		<div id="money_2"></div>
		<div id="money_3"></div>
	</div>
	
	<div id="buy_tips">
		<div id="tips">定购提示：</div>
		<div id="tipString"></div>
		<div id="warning">本节目不提供单片定购.</div>
	</div>
</div>
</body>
</html> 