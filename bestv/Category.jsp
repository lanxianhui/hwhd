<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ include file="HD_preFocusElement.jsp" %>
<%@ page import="com.bestv.epg.util.MessageUtil" %>
<%
session.removeAttribute("vas_back_url");
%>
<html>
<head>
<title>portal</title>
	<script src="js/mini.js" type="text/javascript"></script>
	<script src="js/registerGlobalKey.js" type="text/javascript"></script>
	<script type="text/javascript">
		if (iPanel.eventFrame.channelInfo.length > 0 || 
			typeof(iPanel.eventFrame.channelInfo) != "undefined" || 
			iPanel.eventFrame.channelInfo != null ||
			iPanel.eventFrame.HDchannelInfo.length > 0 || 
			typeof(iPanel.eventFrame.HDchannelInfo) != "undefined" || 
			iPanel.eventFrame.HDchannelInfo != null
		) {				
			var temp = "";
			for (var i=0; i< myArray.length ; i++) 
				temp = temp + "focus" + i + "=" + myArray[i] + "&";
			window.location="HD_portal.jsp?" + temp;
		} else {
			if(iPanel.eventFrame.chanList.length == 0) iPanel.eventFrame.initChanList();
			reqChannelInfo();
		}
		
	    function getChannelInfo(__xmlhttp){
	    	var data = eval(__xmlhttp.responseText);
	    	iPanel.eventFrame.channelInfo 	= data[0];
	    	iPanel.eventFrame.HDchannelInfo = data[1];
	    	window.location.href = "HD_portal.jsp";
	    }
	    function reqChannelInfo(){
			//在iPanel.eventFrame层新建变量
			iPanel.eventFrame.eval("var channelInfo = []");
			iPanel.eventFrame.eval("var HDchannelInfo = []");
		    var requestUrl = "HD_channelInfo.jsp";
		    var ajaxObj = new AJAX_OBJ(requestUrl, getChannelInfo);
		    ajaxObj.requestData();
	    }
	</script>
</head>
<body bgcolor="transparent"></body>
</html>
