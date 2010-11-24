<%@ include file="HD_preFocusElement.jsp" %>
<% String channelID = (String)request.getParameter("CHANNELID"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta name="designer" content="hwhd" />
	<meta http-equiv="Page-Enter" content="blendTrans(Duration=1.0)">
	<meta name="page-view-size" content="1280*720" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>pay</title>
<link href="css/default/HD_payOrder.css" rel="stylesheet" type="text/css" />
<script src="js/mini.js" type="text/javascript"></script>
<script src="js/HD_payOrder.js" type="text/javascript"></script>
</head>
<body onload="init();">
	<div id="record"></div>
	<div id="affirmance"></div>
	<div id="return"></div>
	
	<div id="information">
		<div id="program">产品名称：</div>
		<div id="program_name">新春贺岁大礼包</div>
		<div id="description">产品描述：</div>
		<div id="description_value">这里是产品描述这里是产品描述这里是产品描述这里是产品描述这里是产品描述这里是产品描述这里是产品描述</div>
	</div>
	
	<div id="detail">
		<div id="valide">有效期：</div>
		<div id="valide_name">截至2010年6月</div>
		<div id="pay">付费方式：</div>
		<div id="pay_name">每月付费随账单付费</div>
		<div id="sales">促销：</div>
		<div id="sales_name">XXXXXXXXXXX</div>
		<div id="price">指导价格：</div>
		<div id="price_name">XXXXXXXXXXX</div>
		<div id="little">您的优惠价格：</div>
		<div id="little_name">XXXXXXXXXXX</div>
	</div>
</body>
</html> 