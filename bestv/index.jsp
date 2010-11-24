<%@ page contentType="text/html;charset=utf-8" language="java" %>

<html>
<head>
<title>portal</title>
	<meta name="page-view-size" content="1280*720" />
  <script src="js/mini.js" type="text/javascript"></script>
  <script type="text/javascript">
  	//if(typeof(iPanel.eventFrame.channelInfo) == "undefined"){
  		iPanel.eventFrame.eval("var channelInfo = []");
  		reqChannelInfo();
  		if(iPanel.eventFrame.chanList.length == 0) iPanel.eventFrame.initChanList();
    //}
    function getChannelInfo(__xmlhttp){
    	var data = eval(__xmlhttp.responseText);
    	iPanel.eventFrame.channelInfo = data;
    	document.location="HD_portal.jsp"
    }
    function reqChannelInfo(){
	    var requestUrl = "HD_channelInfo.jsp";
	    var ajaxObj = new AJAX_OBJ(requestUrl, getChannelInfo);
	    ajaxObj.requestData();
    }
	</script>
</head>
<body bgcolor="transparent">
</body>
</html>