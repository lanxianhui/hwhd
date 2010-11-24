<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ include file="HD_preFocusElement.jsp" %>
<%@ page import="com.bestv.epg.util.MessageUtil" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ include file="HD_common.jsp" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="page-view-size" content="1280*720" />
<title></title>
<link href="css/default/HD_portal.css" rel="stylesheet" type="text/css" />
<script src="js/mini.js" type="text/javascript"></script>
<%

  	ServiceHelp serviceHelp = new ServiceHelp(request);
  	MetaData metaData = new MetaData(request);
  	String playType=MessageUtil.getMessage(session, "playType");
  	String playCode=MessageUtil.getMessage(session, "playCode");
  	String playByThis="";

  
  	if("CHAN".equals(playType)){
	    playByThis=playCode;
  	}else{

	    int vodId = 0;
	    String hexCode = EPGUtil.transMediaCode4Vas(playCode, 0);
	    Map entityMap = metaData.getContentDetailInfoByForeignSN(hexCode, 0);  
	             
	    if (entityMap != null){
	    	vodId = ((Integer)entityMap.get("VODID")).intValue();
	    	String playUrl = serviceHelp.getTriggerPlayUrl(1, vodId, "0");
	    	int st=playUrl.indexOf("rtsp");       
	    	String playUrlTmp = (st != -1 ? playUrl.substring(st,playUrl.length()) : "");
	    	playByThis ="{mediaUrl:'"+playUrlTmp;
	    	playByThis += "',mediaCode: 'jsoncode1',mediaType:2,audioType:1,videoType:1,streamType:1,drmType:1,fingerPrint:0,copyProtection:1,allowTrickmode:0,startTime:0,endTime:10000.3,entryID:'jsonentry1'}";
  		}
  	}
%>
<script src="js/HD_portal.js" type="text/javascript"></script>
</head>
<body margin="0" onLoad="reqInfo("<%=playByThis%>","<%=playType%>", "<%=request.getHeader("referer")%>")" onUnload="exitPage()" scroll="no">
	<div id="hidden"></div>
	<div id="col0">
		<div id="col00" class="c0"></div>
		<div id="col01" class="c0"></div>
		<div id="col02" class="c0"></div>
		<div id="col03" class="c0"></div>
		<div id="col04" class="c0"></div>
		<div id="col05" class="c0"></div>
		<div id="col06" class="c0"></div>
		<div id="recname">推荐</div>
		<div id="col0focus"></div>
		<div id="img00" class="i0"></div>
		<div id="img01" class="i0"></div>
		<div id="img02" class="i0"></div>
		<div id="img03" class="i0"></div>
		<div id="img04" class="i0"></div>
		<div id="img05" class="i0"></div>
		<div id="img06" class="i0"></div>
	</div>
	<div id="col1">
		<div id="part1"></div>
		<div id="part2"></div>
		<div id="part3"></div>
		<div id="col1focus"><img id="f" src="images/portal/levelTwo_focus.png"/></div>
		<div id="col10" class="c1"></div>
		<div id="col11" class="c1"></div>
		<div id="col12" class="c1"></div>
		<div id="col13" class="c1"></div>
		<div id="col14" class="c1"></div>
		<div id="col15" class="c1"></div>
		<div id="col16" class="c1"></div>
		<div id="col17" class="c1"></div>
		<div id="col18" class="c1"></div>
	  	<div id="col19" class="c1"></div>
	  	<div id="col110" class="c1"></div>
	  	<div id="col111" class="c1"></div>
	  	<div id="up"></div>
	  	<div id="down"></div>
	</div>
	<div id="overborder">
	<div id="rec">
		  <div id="left0" class="lefts"><img id="bp0" class="bimg" /><img id="img0" class="img" /></div>
		  <div id="left1" class="lefts"><img id="bp1" class="bimg" /><img id="img1" class="img" /></div>
		  <div id="text0" class="text"></div>
		  <div id="text1" class="text"></div>
		  <div id="text2" class="text"></div>
		  <div id="middle0" class="middles"><img id="bigP0"  class="mimg" /></div>
		  <div id="middle1" class="middles"><img id="bigP1"  class="mimg" /></div>
		  <div id="middle2" class="middles"><img id="bigP2"  class="mimg" /></div>
		  <div id="right0" class="rights"></div>
		  <div id="right1" class="rights"></div>
		  <div id="right2" class="rights"></div> 
		  <div id="right3" class="rights"></div>
		  <div id="right4" class="rights"></div>
		  <div id="right5" class="rights"></div>
		  <div id="right6" class="rights"></div>
		  <div id="right7" class="rights"></div>
		  <div id="right8" class="rights"></div>
		  <div id="right9" class="rights"></div>
		  <div id="buttom0" class="buttoms"></div>
		  <div id="buttom1" class="buttoms"></div>
		  <div id="buttom2" class="buttoms"></div>
		  <div id="buttom3" class="buttoms"></div>
		  <div id="buttom4" class="buttoms"></div>
		  <div id="buttom5" class="buttoms"></div>
		  <div id="buttom6" class="buttoms"></div>
		  <div id="recfocus"></div>
	</div>
</div>
<div id="readTips" style="position:absolute; left:350px; top:208px; height:122px; width:539px; background-image: url(images/vod/tck_bg1.png); text-align:center; visibility:visible">
 	<table width="430" border="0" cellspacing="0" cellpadding="0" class="bg">
 		<tr>
 			<td height="120" colspan="2" align="center" style="font-size:28px; color:#f6ff00;" id="content"></td>
 		</tr>
 	</table>
</div>
<div id="logo"><img src="images/portal/logo.png" /></div>
</body>
</html>