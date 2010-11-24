var list				=	[];
var total 				= 	0;
var totalPage 			= 	0;
var nowPage 			= 	0;
var subPos 				= 	0;
var shown 				= 	0;
var pageNum				=	15;

var contentList 		= 	new Array();
var DownLoad 			= 	new DownLoad();
var willList 			= 	new Array();
var ingList 			= 	new Array();
var stopList 			= 	new Array();
var okDivRight 			=	new Array();// 权限数组
var downloadLength		=	0;

// 获取下载列表信息
function getListData(__xmlhttp){
	var data		= 		eval(__xmlhttp.responseText);
// var data =
// [{"sub":[{"vodId":1,"name":"beijing","pic":"images/vod/default.jpg","url":"HD_vodDetail.jsp?PROGID=8"},{"vodId":2,"name":"千手观音","pic":"images
// od/default.jpg","url":"HD_vodDetail.jsp?PROGID=9"},{"vodId":3,"name":"宝贝宝贝宝贝宝贝宝贝","pic":"images
// od/default.jpg","url":"HD_vodDetail.jsp?PROGID=10"},{"vodId":4,"name":"诺基京","pic":"images
// od/default.jpg","url":"HD_vodDetail.jsp?PROGID=12"},{"vodId":5,"name":"paly","pic":"images
// od/default.jpg","url":"HD_vodDetail.jsp?PROGID=22"},{"vodId":6,"name":"car","pic":"images
// od/default.jpg","url":"HD_vodDetail.jsp?PROGID=42"},{"vodId":7,"name":"高清paly","pic":"images
// od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":8,"name":"高清paly","pic":"images
// od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":9,"name":"高清paly","pic":"images
// od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":10,"name":"高清paly","pic":"images
// od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":11,"name":"高清paly","pic":"images
// od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":12,"name":"高清paly","pic":"images
// od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":13,"name":"高清paly","pic":"images
// od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":14,"name":"高清paly","pic":"images
// od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":15,"name":"高清paly","pic":"images
// od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":16,"name":"高清paly","pic":"images
// od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":17,"name":"高清paly","pic":"images
// od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":18,"name":"高清paly","pic":"images
// od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":19,"name":"高清paly","pic":"images
// od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":20,"name":"高清paly","pic":"images
// od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":21,"name":"高清paly","pic":"images
// od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":22,"name":"高清paly","pic":"images
// od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":23,"name":"高清paly","pic":"images
// od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":24,"name":"高清paly","pic":"images
// od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":25,"name":"高清paly","pic":"images
// od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":26,"name":"高清paly","pic":"images
// od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":27,"name":"高清paly","pic":"images
// od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":28,"name":"高清paly","pic":"images
// od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":29,"name":"高清paly","pic":"images
// od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":30,"name":"高清paly","pic":"images
// od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"}],"count":30,"typename":"","pathname":""}];
	list = data[0].sub;
	total			=	list.length;
	totalPage 		= 	1 +	Math.floor((total-1)/pageNum);
	nowPage 		= 	1;
  	shown 			= 	(nowPage-1)*pageNum;
	var rest 		= 	total-shown;
	limit 			= 	Math.min(pageNum,rest);
	displayList();
}

// 发起AJAX请求
function requestList(){
	var requestUrl = "HD_downLoadData.jsp";
	var ajaxObj = new AJAX_OBJ(requestUrl, getListData);
	ajaxObj.requestData();
}


function init(){
	requestList();
	download();
}

function download() {
	playUrl	=	"rtsp://10.10.10.31/88888888/16/20100511/268435471/ssd.ts?rrsip=10.10.10.31&icpid=&accounttype=1&limitflux=-1&limitdur=-1&accountinfo=qqVd0GouFta+BpXUXus0mtRtQ8AGrY8buEY0bt/WAsM68OfIfU7miLqzrYE2YJQBQELozTGOPQKiQeb97p/z9Gkly4X0CxnYtnVJ6KkPZtO091NZrCb/w/jcofOxEapqiQVNuPisLDXgNFRN6UcKIw==:20100719154102,688,10.10.8.116,20100719154102,00000100000000010000000000000034,44AE898192D1FA37635EEF9F8BBDD3D7,,1,,,0,1,,,,1,END";
	DownLoad.Ctrl.createDownLoad("10","宝贝宝贝宝贝宝贝宝贝",playUrl,"00000100000000020000000000000039");    // 启动下载任务
	getLocalList();
}

function getLocalList() {
	contentList[0]  =  DownLoad.Info.getAchieveList(0);		// 0 下载完成
	contentList[1]  =  DownLoad.Info.getAchieveList(1);		// 1 正在下载
	contentList[2]  =  DownLoad.Info.getAchieveList(2);		// 2 等待下载
	contentList[3]  =  DownLoad.Info.getAchieveList(3);		// 3 下载未完成
	contentList[4]  =  DownLoad.Info.getAchieveList(4);		// 4 下载失败
	contentList[5]  =  DownLoad.Info.getAchieveList(5);		// 5 下载暂停
	
	for (var i=0; i<6; i++)
	{
		var num	=	contentList[i].length;
		for (var j=0; j<num; j++)
			downloadLength = temp +1;
	}
}

function goUtility()
{
	eval("eventJson = " + Utility.getEvent());
	var typeStr = eventJson.event_id;
	var channelNum =eventJson.Channel_no;
	var message;
	var type =eventJson.type;
	if(type == "EVENT_DOWNLOAD_EVENT")
	{
		switch(typeStr)
		{
			case "0":
				 message ="任务下载完毕！";
				 alert(message);
				 break;
			case "1":
				 message ="任务下载开始！";
				 alert(message);
				 break;	  
			case "2":
				 message ="任务下载失败！";
				 alert(message);
				 break;
			default :
				 break;
		}
	}
	return true;
}

function displayList() {
	for(var i=0; i<Math.min(pageNum,total); i++){
		$("poster_"+i)..style.backgroundImage = "url(" + list[i].pic +")";
		$("name_"+i).innerText = cutName(list[i].name);
	}
	
	$("page_num").innerText	=	nowPage + "/" + totalPage + "页";
}

function cutName(name)
{
	var tempName = name;
	var nameLength = tempName.length;
	if (nameLength >= 6 ) {
		tempName = tempName.slice(0,6);
	}
	
	return tempName;
}

var startTime	=	0;
var endTime		=	0;
var continueFlag	=	false;
	
function eventHandler(obj) {
	
	// 按键保护在200ms内
	var myDate 		= 	new Date();
	if ((endTime == 0) && (startTime == 0) ) {
		startTime	=	myDate.getTime();
	} else {
		endTime		=	myDate.getTime();
	}
	
	if ((endTime - startTime) > 200)  {
		continueFlag	=	true;
		startTime		=	endTime;
		endTime			=	0;
	} else {
		if(endTime == 0) {
			continueFlag	=	true;
		} else {
			continueFlag	=	false;
		}
		endTime			=	myDate.getTime();
	}
	
	switch(obj.code){
	
		case "KEY_SYSTEM" :
				alert("EVENT_DOWNLOAD_EVENT");
				goUtility();
			break;
		case "KEY_UP":
			if ( continueFlag )
				changeListFocusUD(-1);
			break;
		case "KEY_DOWN":
			if ( continueFlag )
				changeListFocusUD(1);
			break;
		case "KEY_SELECT":
// download();
			break;
		case "KEY_RIGHT" :
			keyRight();
			break;
		case "KEY_PAGE_UP":
			turnPage(-1);
			break;
		case "KEY_PAGE_DOWN":
			turnPage(1);
		    break;
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
}