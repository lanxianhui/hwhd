<%@ include file="HD_preFocusElement.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="designer" content="chris"  />
<meta name="page-view-size" content="1280*720" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>帮助播放</title>
<script src="js/mini.js" type="text/javascript"></script>
<style type="text/css">
	body {
		background-color:transparent;
		left:0px;
		top:0px;
		margin-left:px;
		margin-top:0px;
		overflow:hidden;
	}
</style>
<script>

var list	=	[];
var playNum	=	null;
// 获取频道列表信息
function getListData(__xmlhttp){
	var temp		= eval(__xmlhttp.responseText);
	list	=	temp[0].sub;
	mp.setVideoDisplayMode(1);
	mp.setAllowTrickmodeFlag(0);
	mp.refreshVideoDisplay();
	mp.setSingleMedia(list[playNum].url);
	mp.setCycleFlag(1);
	mp.setRandomFlag(1);
	mp.playFromStart();
}

// 发起AJAX请求，获取频道信息
function reqDataList(){
	var requestUrl = "HD_helpDate.jsp";
	var ajaxObj = new AJAX_OBJ(requestUrl, getListData);
	ajaxObj.requestData();
}

// 首次加载时，运行此函数
function init(){
	var params = window.location.search.substring(1).split("&");
	for(var i = 0; i < params.length; i++) {
		if(params[i].indexOf("current") > -1) playNum = params[i].split("=")[1];
	}
	reqDataList();
}

function exit() {
	mp.stop();
	mp.releaseMediaPlayer(NativePlayerInstanceID);
}


function eventHandler(obj) {
	switch(obj.code){
		case "KEY_EXIT":
			exit();
			window.location = backUrl;
			return 0;
			break;
		case "KEY_BACK":
		  	exit();
		  	window.location = backUrl;
			break;
}
</script>
</head>
<body onload="init();" onunload="exit();">
</body>
</html>

