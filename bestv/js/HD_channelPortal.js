var flagPosition		= 0;
var backTop				= [89,145,200,255,310,364,418,473,530,583];
var tObj 				= [];
var programInfo			= [];
var channelList			= [];

var programList 		= [];
var channelNum 			= 10;		// 每页频道显示个数
var tvod_pagenum		= 9;		// 回看页面回看节目单每页显示个数
var sourceTemp			= "";		// 临时中间变量
window.config();					// 参数初始化时，调用config()函数

var dateObj				= [];									//	封装日期
var listObj				= [];									//	封装频道信息
var programData			= [];									//	封装当前日期下的回看数据
var tvod_backTop		= [95,155,215,275,335,395,455,515,575];
var date_top			= [95,155,215,275,335,395,455,515,575];
var currentNum 			= 0;

/**
 * myApp： 封装标清频道、回看页面所有参数;
 */
var myApp = {
		initFlag	:	false,     				// 首页二级菜单选频道进入频道回看页面, 频道全屏播放页面返回至频道回看页面,置myApp.initFlag为true;
		source		:	sourceTemp,				// source 为空,展示标清页面；source为hd，展示高清页面
		total		:	channelList.length,     // 频道总个数
		totalPage	:	1+Math.floor((channelList.length-1)/channelNum),     // 频道总页数
		nowPage		:	1,      				// 当前频道所在页面
		subPos		:	0,      				// 当前频道所在当前页的位置
		shown		:	0,      				// 频道总个数
		chanBack	:	true,					// 频道、回看页面标识符,chanBack为true,展示频道页面;否则,展示回看页面
		channID		:	null,					// 当前频道内部ID
		dateNum		:	0,						// 回看页面日期数量
		dateIndex	:	0,						// 回看页面，当前日期（日期状态为NOW）标识符
		tvodTotal	:	0,						// 回看列表总数
		tvodTotalPage	:	0,					// 回看列表总页数
		tvodNowPage	:	1,						// 回看列表当前页标识符
		tvodShown	:	0,						// 回看列表页中当前页以前页面中显示的回看节目单总个数
		tvodSubPos	:	0,						// 回看列表页中当前页面焦点位置
		tvodLimit	:	0,						// 回看列表中当前光标之后的回看节目单总个数
		turnPageFlag:	false,					// 翻页标识符
		tvodFLag	:	false,					// 当回看日期下有回看数据时tvodFlag为false；否则为true
		backChannel	:	false,					// 如果从直播页面返回置backChannel为true
};

/**
 * 功能：初始化chanenlist,初始化标清、高清标识符
 * @return
 */
function config() {
	if (window.location.href.indexOf("source=hd") > -1)  {
		channelList			=	iPanel.eventFrame.HDchannelInfo;
		sourceTemp			=	"_hd";
	} else {
		channelList			=	iPanel.eventFrame.channelInfo;
	}
}

myApp.source	=	sourceTemp;

/**
 * 播放频道trailer
 * 触发事件：切换频道
 * @return
 */
function playTrail(){
	$("trailer").style.visibility	= "hidden";
	mp.leaveChannel();
	mp.setVideoDisplayMode(0);
	mp.setVideoDisplayArea(642,46,594,466);
	mp.refreshVideoDisplay();
	mp.joinChannel(channelList[myApp.subPos+myApp.shown].ChannelID);
}

/**
 * 释放播放频道时占用的系统资源
 * 触发事件：离开频道页面;进入回看页面;全屏播放频道
 * @return
 */
function exit() {
	mp.leaveChannel();
	mp.releaseMediaPlayer(NativePlayerInstanceID);
}


/**
 * 功能：响应确认按键事件
 * @return
 */
function doSelect(){  
	//  flag == 1 : 光标停留在频道直播页面；否则光标停留在频道回看页面
	if (1 == $("flag").value) {
		exit();
		toUrl = (myApp.source == "" ? "HD_playliveControl.jsp?isFirst=1&currentNum=" : "HD_playliveControl.jsp?isFirst=1&source=hd&currentNum=") + (myApp.subPos+myApp.shown);
		document.location="HD_saveCurrFocus.jsp?currFocus="+","+myApp.nowPage+","+myApp.subPos+",channelBack&url=" + toUrl;
	} else {
		document.location="HD_saveCurrFocus.jsp?currFocus="+(channelList[myApp.subPos+myApp.shown].InnerChannelID)+","+myApp.nowPage +","+myApp.subPos+",back"+"&url="+ programData[myApp.tvodSubPos+myApp.tvodShown].turnUrl + (myApp.source == "" ? "":"&source=hd");
	}
}

/**
 * 功能：响应频道列表上下移动按键
 * 触发事件：上下选择频道
 * 参数说明：num = -1,上移;num = 1,下移;
 * @return
 */
function changeListFocusUD(num){
	myApp.turnPageFlag    =    false;
	if (myApp.subPos == 0) {   			//光标停留在当前页第一个位置
		if (-1 == num)					//向上翻页
		{
			myApp.subPos = (myApp.totalPage == (myApp.nowPage+num)) ? (myApp.total % channelNum - 1) : (channelNum - 1);
			turnPage(num,true);
		} else {
			myApp.subPos += num;
			if( tObj[myApp.subPos].innerText.length <= 1 ){
				myApp.subPos = 0;
				turnPage(num,true);
			} else {
				myApp.chanBack ? selectItem(myApp.subPos) : selectBackItem(myApp.subPos);
			}
		}
	} else if( myApp.subPos == 9) {     // 光标停留在当前页最后一个位置上
		if (num == 1) {     			// 向下翻页
			myApp.subPos	=	0;
			turnPage(num,true);
		} else {
			myApp.subPos += num;
			if(tObj[myApp.subPos].innerText.length <= 1){
				myApp.subPos = (myApp.totalPage == (myApp.nowPage+num)) ? (myApp.total % channelNum - 1) : (channelNum - 1);
				turnPage(num,true);
			} else {
				myApp.chanBack ? selectItem(myApp.subPos) : selectBackItem(myApp.subPos);
			}
		}
	} else {
		myApp.subPos += num;
		if(tObj[myApp.subPos].innerText.length <= 1){
			myApp.subPos	=	0;
			turnPage(num,true);
		} else {
			myApp.chanBack ? selectItem(myApp.subPos) : selectBackItem(myApp.subPos);
		}
  }
}

/**
 * 功能：频道列表翻页
 * @param num ： -1 向上翻页; +1 向下翻页
 * @param source
 * @return
 */
function turnPage(num,source){

	myApp.turnPageFlag    =    true;
	myApp.nowPage += num;
	if(myApp.nowPage>myApp.totalPage) 	myApp.nowPage = 1;
	if(myApp.nowPage<1)  				myApp.nowPage = myApp.totalPage;
	
	$("page").innerText 	= ""+ myApp.nowPage + "/" + myApp.totalPage + "页";
	myApp.shown 			= (myApp.nowPage-1)*channelNum;
	var rest 				= myApp.total-myApp.shown;
	limit 					= Math.min(channelNum,rest);
	if(myApp.subPos >= rest) myApp.subPos = rest-1;
	
	myApp.chanBack ? selectItem(myApp.subPos) : selectBackItem(myApp.subPos);   // myAPp.chanBack 为TRUE：光标停留在频道直播页面；为FALSE：停留在频道回看频道上
	
	//翻页后显示频道列表信息
	if(limit == channelNum) {
		for(var i=0;i<channelNum; i++)
		  	tObj[i].innerText = channelList[i+myApp.shown].ChannelID+" "+channelList[i+myApp.shown].ChannelName.slice(0,9);
	} else {
		for(var i=0;i<limit; i++)
		  	tObj[i].innerText = channelList[i+myApp.shown].ChannelID+" "+channelList[i+myApp.shown].ChannelName.slice(0,9);
		for(var i=limit;i<channelNum; i++)
		  	tObj[i].innerText = "";
	}
}

/**
 * 功能：选中频道后更换频道字体属性
 * @return
 */
function changeFontColor() {
	tObj[myApp.subPos].style.color 			= "#393939";
	tObj[myApp.subPos].style.fontSize 		= "32px";
	tObj[myApp.subPos].style.fontWeight 	= "bold";
}

/**
 * 功能：页面首次加载时，初始化页面参数
 * @return
 */
function initParam(){

	for(var i = 0; i < channelNum; i++)  tObj[i] =  $("t" + i);
  	
	if (myApp.channID != null && !myApp.backChannel) {
		var nowNum = 0;
		for(var i=0; i<myApp.total; i++){
			if(channelList[i].InnerChannelID == myApp.channID) {	
				nowNum = i;
				break;
			}	
		}
		
		myApp.nowPage			= 1 + Math.floor(nowNum/channelNum);
		myApp.shown 			= (myApp.nowPage-1)*channelNum;
		myApp.subPos 			= nowNum - myApp.shown;
		limit 					= Math.min(channelNum,(myApp.total-myApp.shown));
		$("flag").value 		= 5;
		keyRight();
	} else {
		if (myArray.length < 1) {				//无焦点信息
		  	myApp.nowPage 		= 	1;
		  	myApp.shown 		= 	(myApp.nowPage-1)*channelNum;
		  	myApp.subPos 		= 	0;
		  	limit 				= 	channelNum;
		} else {   								//记忆焦点
		  	myApp.nowPage 		= 	parseInt(myArray[1]);
		  	myApp.subPos 		= 	parseInt(myArray[2]);
		  	myApp.shown 		= 	(myApp.nowPage-1)*channelNum;
			var rest 			= 	myApp.total-myApp.shown;
			limit 				= 	Math.min(channelNum,rest);
		}
		
		myApp.turnPageFlag		=	true;
	}
	
	selectItem(myApp.subPos);
}

/**
 * 显示正在播放和将要播放的节目信息
 * @return
 */
function displayProgram() {
	if(myApp.chanBack) {
		$("currprogram").innerText 		= "正在播出:  " +  ((typeof(programInfo[4]) == "undefined" || programInfo[4].length == 0) ? "暂无当前节目单." : programInfo[4].cutString(13));
		$("nextprogram_one").innerText 	= "即将播出:  " +  ((typeof(programInfo[5]) == "undefined" || programInfo[5].length == 0) ? "暂无未播节目单." : programInfo[5].cutString(13));
		$("nextprogram_two").innerText 	= (typeof(programInfo[6]) == "undefined" || programInfo[6].length == 0) ? "暂无未播节目单." : programInfo[6].cutString(13);
	}
}

/**
 * 返回请求结果数据
 * @param __xmlhttp
 * @return
 */
function getListData(__xmlhttp){
	var data		= eval(__xmlhttp.responseText);
	programInfo 	= data;
  	displayProgram();
}

/**
 * 请求频道正在播放信息和将要播放的信息
 * @param InnerChannelID
 * @return
 */
function reqTvodList(InnerChannelID){
	var requestUrl = "HD_channelSchedula.jsp?CHANNELID="+InnerChannelID;
	var ajaxObj = new AJAX_OBJ(requestUrl, getListData);
	ajaxObj.requestData();
}

var timeTimeout	=	null;
/**
 * 功能：选中频道
 * @param position
 * @return
 */
function selectItem(position)
{
	
	// 切换频道时，加载频道并显示相关播放信息
	clearTimeout(timeTimeout);
	timeTimeout = setTimeout(function () {
		if (myApp.chanBack == true) 
		{ 
			playTrail();
			$("logo").src = channelList[position+myApp.shown].PICS_PATH;
		}
		reqTvodList(channelList[myApp.subPos+myApp.shown].InnerChannelID);
	}, "1000");
	
	var channLess = Math.min(channelNum,myApp.total);
  	for(var i=0 ; i < channLess ; i++) {
  		if( i == position ){
  			if (myApp.turnPageFlag || myApp.initFlag) {
  				$("back").style.webkitTransitionDuration		=	"0";
  				myApp.turnPageFlag		=	false;
  			} else {
  				$("back").style.webkitTransitionDuration		=	"200";
  			}
  			
  			if(myApp.source == "_hd") $("back").style.backgroundImage	= "url(images/channel/back" + myApp.source + ".png)";
  			$("back").style.top = backTop[position] + "px";
  			setTimeout("changeFontColor()", "200");
  		}
  		else{
  			tObj[i].style.fontWeight 	= "normal";
  			tObj[i].style.fontSize 		= "30px";
  			tObj[i].style.color 		= "#FFFFFF";
  		}
  	}
}


/**
 * 来源：选择首页二级频道,频道全屏播放返回
 * @param channelID  
 * @return
 */
function initTestId(channelID) {
	/**
	 * 记忆频道号
	 * myApp.channID:被选频道标识符
	 * channID为空，页面定位在频道列表播放页面;否则,页面定位在频道回看页面
	 */
	if (window.location.search.substring(1).indexOf(",back") > -1) {
		myApp.channID = myArray[0];
		myApp.backChannel = false;
	}
	
	if (window.location.href.indexOf("CHANNELID=") > -1) {
		myApp.channID = parseInt(window.location.search.substring(1).split("&")[0].split("CHANNELID=")[1]);
		if (window.location.search.substring(1).indexOf("channelBack") > -1)
			myApp.backChannel = true;
	}
	
	if (myApp.channID != null && !myApp.backChannel) {
		myApp.initFlag		=	true;
		changePagePosition();
		$("trailer_bg").style.visibility 			= "hidden";
		$("trailer").style.visibility 				= "visible";
		$("logo").style.opacity 					= "0";
		$("title").style.opacity 					= "0";
		setTimeout(function () { $("trailer_bg").style.visibility = "visible";}, "3000");
	}
}

/**
 * 初始化页面参数、变量
 * @return
 */
function init(){
		initParam();
		var displayNum = Math.min(channelNum,myApp.total);
		for(var i=0; i<displayNum; i++){
			tObj[i].innerText = channelList[i+myApp.shown].ChannelID+" "+channelList[i+myApp.shown].ChannelName.slice(0,9);	
		}

		$("page").innerText = ""+ myApp.nowPage + "/" + myApp.totalPage + "页";
		if (myApp.source == "")  $("title").innerText = "标清频道"; else  $("title").innerText = "高清频道";
		
		changeFontColor();
		
		// mp.getMuteFlag()==1 ： 静音；否则：未静音
		if(mp.getMuteFlag()==1){							// 显示静音按钮
			if($("muteDiv")==null||typeof($("muteDiv"))=="undefined"){
				creatMuteDiv();
			}
			$("muteDiv").style.webkitTransitionDuration="0ms";
			$("muteDiv").style.visibility="visible";
			$("muteDiv").style.backgroundImage="url(images/vod/mute2.png)";
			$("muteDiv").style.width="62px";
			$("muteDiv").style.height="62px";
			$("muteDiv").style.left="20px";
			$("muteDiv").style.top="590px";
			$("muteDiv").style.webkitTransitionDuration="300ms";
		}
}

/**
 * 触发事件：频道切换到回看页面;
 * 功能：请求当前频道所有回看数据
 */
function keyRight() {
	myApp.chanBack				=		false;
	myApp.channID				=		channelList[myApp.subPos+myApp.shown].InnerChannelID;
	reqProgramList(myApp.channID);	
	changePagePosition();
}

/**
 * AJAX请求当前频道回看数据
 * @param InnerChannelID  内部频道号
 * @return
 */
function reqProgramList(InnerChannelID){
	var requestUrl 	= "HD_channelProgInfo.jsp?CHANNELID=" + InnerChannelID;
	var ajaxObj 	= new AJAX_OBJ(requestUrl, getProgramData);
	ajaxObj.requestData();
}


/**
 * 封装请求得到的所有频道数据
 * @param __xmlhttp  AJAX返回的数据封装器
 * @return
 */
function getProgramData(__xmlhttp){
	
	programList 					= 	eval(__xmlhttp.responseText);
	myApp.dateNum					= 	(programList.length < 9 ) ? programList.length : 9;
	
	for(var i=(programList.length-1);i>=0;i--){
		if( (programList[i].state == "now")) { 
			myApp.dateIndex = i;
			break;
		}
	}

	if(myApp.initFlag) changePagePosition();
	
	$("flag").value = 5;	//光标停留在回看频道上
    setTimeout(function (){
		$("trailer").style.visibility =	"visible";
		exit();
    },"200");
    $("logo").style.opacity = 0;
    tvodDisplay();
}

/**
 * 功能：显示回看日期、节目单列表信息
 * 触发事件：切换回看频道
 * @return
 */
function tvodDisplay() {
	
	for(var i = 0; i < myApp.dateNum; i++){
		dateObj[i]  			=  	$("date" + i);
		dateObj[i].innerText 	=	(typeof programList[i].day == "undefined") ? "" : programList[i].day.dealDate();
	}
	
	for(var i = 0; i < tvod_pagenum; i++)
		listObj[i]  =  $("list" + i);
	
	selectDate(0);
	displayLiveBack();
}

/**
 * 功能：改变频道列表等光标位置;
 * 
 * 触发事件：选择首页频道回看二级频道，进入频道回看页面; 在频道列表页面按右键进入频道回看页面
 * 	
 */
function changePagePosition() {
	var webkitTrans	= myApp.initFlag ? "0" : "500";
	myFunc.setWebkitTransitionDuration([
	              					{name : $("main"), value:webkitTrans},
	            					{name : $("iconup"), value:webkitTrans},
	            					{name : $("icondown"), value:webkitTrans}
	            			]);

	myFunc.setOpacity($("logo"), 1);
	if(myApp.source == "")  myFunc.setLeft($("main"), 210); else myFunc.setLeft($("main"), 265);
	myFunc.setLeft([{name : $("iconup"), value:"354px"},{name : $("icondown"), value:"354px"},]);
	
	myFunc.setBackgroundImage($("back"), "url(images/channel/channel_focus" + myApp.source +".png)");
	if (!myApp.tvodFLag)
		myFunc.setBackgroundImage($("tvod_back"), "url(images/channel/tvod_no_focus.png)");
	$("date_back").style.backgroundImage 	= 	"url(images/channel/date_no_focus.png)";
}


/**
 * 返回至频道播放页面
 * @return
 */
function returnChannel() {
	
	myApp.chanBack	=	true;
	$("trailer").style.visibility			=	"hidden";
	$("logoDiv").style.visibility			=	"visible";
	$("tvod_title").style.left				=	"-711px";
	$("tvod_log").style.left				=	"-790px";
	$("tvod_main").style.left 				= 	"1400px";
	$("tvod_date").style.left				=	"1400px";
	$("tvod_list").style.left				=	"1800px";
	$("tvod_iconup").style.left 			= 	"1662px";
	$("tvod_icondown").style.left 			= 	"1662px";
	
	$("date_back").style.webkitTransitionDuration		=	"500";
	$("tvod_tag").style.webkitTransitionDuration		=	"500";
	$("tvod_back").style.webkitTransitionDuration		=	"500";
	
	$("tvod_back").style.left			=	"1720px";
	$("date_back").style.left			=	"1900px";
	$("tvod_tag").style.left			=	"1580px";
	$("back").style.backgroundImage 	= 	"url(images/channel/back" + myApp.source +".png)";
	$("main").style.webkitTransitionDuration				  		=	"500";
	$("iconup").style.webkitTransitionDuration				  		=	"500";
	$("icondown").style.webkitTransitionDuration				  	=	"500";
	
	$("main").style.left				  		=	"80px";
	$("iconup").style.left				  		=	"214px";
	$("icondown").style.left				  	=	"214px";
	
	setTimeout(function () {
		myApp.channID 						= 	null;
		$("logo").style.visibility			=	"visible";
		$("logo").style.opacity				=	1;
		$("trailer").style.visibility		=	"hidden";
		displayProgram();
		$("tvod_title").innerText			=	"";
		$("tvod_log").style.opacity			=	0;
		$("title").style.opacity			=	1;
		$("flag").value 					=	1;	
		$("channellog").style.opacity		=	1;
		$("channellog").style.left			= "10px";
		playTrail();
	},"500");
	
	reqTvodList(channelList[myApp.subPos+myApp.shown].InnerChannelID);
}

/**
 * 功能：选中日期，显示该日期下所有回看节目单数据
 * 触发事件：切换日期;选中日期
 * @param n
 * @return
 */
function  selectDate(n) {
	myApp.dateIndex += n;
	if (myApp.dateIndex < 0 ) myApp.dateIndex = myApp.dateNum-1;
	if (myApp.dateIndex > (myApp.dateNum-1)) myApp.dateIndex = 0;

  	for(var i=0 ; i < myApp.dateNum ; i++){
  		if( i == myApp.dateIndex ) {
  			$("date_back").style.webkitTransitionDuration			=	"200";
  			$("date_back").style.top								= 	date_top[i] - 10 + "px";
  			$("tvod_back").style.visibility 						= 	"visible";
  			if ( $("flag").value == 2 ) {	
  				$("date_back").style.backgroundImage 				= 	"url(images/channel/date_focus.png)";
  				$("back").style.backgroundImage 					= 	"url(images/channel/channel_no_focus" + myApp.source +".png)";
  			} else if( $("flag").value == 5 ) {
  				$("tvod_back").style.webkitTransitionDuration		=	"500";
  				$("back").style.backgroundImage 					= 	"url(images/channel/channel_focus" + myApp.source +".png)";
  				$("date_back").style.backgroundImage 				= 	"url(images/channel/date_no_focus.png)";
  			}
  			
  			$("tvod_back").style.backgroundImage 				= 	"url(images/channel/tvod_no_focus.png)";
  			dateObj[i].style.color  			=  "#FFFFFF";
  		}
  		else{
  			dateObj[i].style.color  			=  "#393939";
  		}
  	}
  	
  	programData 				= 	programList[myApp.dateIndex].info;
  	myApp.tvodTotal 	   		= 	programData.length;
  	
  	var  tvod_index = i0
	for(var i=myApp.tvodTotal;i>=0;i--){
		if( (programData[i].nowState == "ago" ) ) { 
			tvod_index = i;
			break;
		} 
	}
	
  	myApp.tvodTotalPage 				= 	1+Math.floor((myApp.tvodTotal-1)/tvod_pagenum) ;
  	myApp.tvodNowPage 					= 	1 + Math.floor((tvod_index)/tvod_pagenum) ;
  	myApp.tvodShown 					= 	(myApp.tvodNowPage-1)*tvod_pagenum;
  	myApp.tvodSubPos					=	tvod_index%tvod_pagenum;
  	myApp.tvodLimit						=   Math.min((myApp.tvodTotal-myApp.tvodShown),tvod_pagenum);
  	
	if (programData[tvod_index].nowState == "after" || programData[tvod_index].nowState == "now" || programData.length == 0) {	
		myApp.tvodFLag = true; 
		$("flag").value == 2;
	} else {
		myApp.tvodFLag = false;
	}

  	displayProgramList();
}

/**
 * 功能：选中日期，并显示此日期下的所有回看节目单
 * @return
 */
function displayProgramList() {
	
	if ( programData.length == 0 ) {
		
		for(var i=1;i<tvod_pagenum; i++) listObj[i].innerText = "";
		$("tvod_back").style.webkitTransitionDuration		= 	"0";
		listObj[0].style.color 								= 	"#FFFFFF";
		listObj[0].innerText 								= 	"您查看的日期暂无回看节目单.";
		$("tvod_tag").innerText								= 	"";
		$("tvod_back").style.top							= 	(tvod_backTop[0] - 15) + "px";
	} else {
		selectProgram();
	}
}

/**
 * 功能：选中回看列表中指定的回看节目单
 * @param 
 * @return
 */
function selectProgram() {
	if ($("flag").value == 3) {
		$("back").style.backgroundImage 		= 	"url(images/channel/channel_no_focus" + myApp.source +".png)";
		$("tvod_back").style.backgroundImage	=	(listObj[i].innerText.length == 0 ? "" : "url(images/channel/tvod_focus.png)");
		$("date_back").style.backgroundImage 	= 	"url(images/channel/date_no_focus.png)";
	}
	
	if(myApp.tvodLimit >= tvod_pagenum) {
		for(var i=0;i<tvod_pagenum; i++)
			listObj[i].innerHTML = programData[i+myApp.tvodShown].startTime.processTime() + " &nbsp;&nbsp;" + programData[i+myApp.tvodShown].name.cutString(15);
	} else {
		for(var i=0;i<myApp.tvodLimit; i++)
			listObj[i].innerHTML = programData[i+myApp.tvodShown].startTime.processTime() + " &nbsp;&nbsp;" + programData[i+myApp.tvodShown].name.cutString(15);
		for(var i = myApp.tvodLimit;i<tvod_pagenum; i++)
			listObj[i].innerText = "";
	}
	
	var tempTvodNum = Math.min(tvod_pagenum,myApp.tvodLimit);
  	for(var i=0 ; i < tempTvodNum ; i++){
  		if( i == myApp.tvodSubPos ){
			listObj[i].innerHTML = programData[i+myApp.tvodShown].startTime.processTime() + " &nbsp;&nbsp;" + programData[i+myApp.tvodShown].name.cutString(10);
  			if (myApp.tvodFLag) {
  				if ($("flag").value == 5) {
  	  				$("back").style.backgroundImage 		= 	"url(images/channel/channel_focus" + myApp.source +".png)";
  	  				$("tvod_back").style.backgroundImage 	= 	"";
  	  				$("date_back").style.backgroundImage 	= 	"url(images/channel/date_no_focus.png)";
  				} else {
  	  				$("back").style.backgroundImage 		= 	"url(images/channel/channel_no_focus" + myApp.source +".png)";
  	  				$("tvod_back").style.backgroundImage 	= 	"";
  	  				$("date_back").style.backgroundImage 	= 	"url(images/channel/date_focus.png)";
  				}
	  			listObj[i].style.color 						= 	"#707070";
	  			$("tvod_tag").style.visibility				=	"hidden";
  			} else {
  				if ($("flag").value != 3) 
  				{
  					$("tvod_back").style.webkitTransitionDuration		=	"0";
  					$("tvod_tag").style.webkitTransitionDuration		=	"0";
  				} else {
  					$("tvod_back").style.webkitTransitionDuration		=	"200";
  					$("tvod_tag").style.webkitTransitionDuration		=	"200";
  				}

	  			$("tvod_back").style.top							= 	(tvod_backTop[i] - 9) + "px";
	  			$("tvod_tag").style.visibility						=	"hidden";	
	  			$("tvod_tag").style.top								= 	(tvod_backTop[i]-15) + "px";
	  			
	  			switch(programData[myApp.tvodSubPos+myApp.tvodShown].nowState) {
		  			case "now" : $("tvod_tag").innerText = "正播"; break;
		  			case "ago" : $("tvod_tag").innerText = "回看"; break;
		  			default	   : $("tvod_tag").innerText = ""; break;
	  			};

	  			setTimeout(function () {
	  				if (programData[myApp.tvodSubPos+myApp.tvodShown].name.length > 8 && $("flag").value == 3)
	  					listObj[myApp.tvodSubPos].innerHTML =  "<marquee SCROLLAMOUNT=7 class='marqueetext'>" + programData[myApp.tvodSubPos+myApp.tvodShown].startTime.processTime() + " &nbsp;&nbsp;" + programData[myApp.tvodSubPos+myApp.tvodShown].name + "</marquee>";
	  					
	  				listObj[myApp.tvodSubPos].style.fontSize 		=	"26px";
	  				listObj[myApp.tvodSubPos].style.color			=	"#393939";
	  				$("tvod_tag").style.visibility					=	"visible";
	  			}, "200");
  			}
  		} else{
			listObj[i].style.visibility 			= 	"visible";
  			listObj[i].style.fontSize 				=	"24px";
  			
  			if (programData[i+myApp.tvodShown].nowState == "after" || programData[i+myApp.tvodShown].nowState == "now")  
  				listObj[i].style.color 				= 	"#707070";
  			else 
  				listObj[i].style.color				=	"#FFFFFF";
  		}
  	}
}


/**
 * 定位回看页面中日期、回看节目单列表
 * @return
 */
function displayLiveBack() {
	
	if ($("flag").value != 5) {
		$("back").style.webkitTransitionDuration			=	"0";
		$("tvod_back").style.webkitTransitionDuration		=	"0";
		$("date_back").style.webkitTransitionDuration		=	"0";
		$("back").style.backgroundImage 		= 	"url(images/channel/channel_no_focus" + myApp.source +".png)";
		$("tvod_back").style.backgroundImage 	= 	"url(images/channel/tvod_no_focus.png)";
		$("date_back").style.backgroundImage 	= 	"url(images/channel/date_focus.png)";
		$("channellog").style.left	=	"-790px";
	}
	
	if (myApp.initFlag) {
		$("date_back").style.webkitTransitionDuration		=	"0";
		$("tvod_tag").style.webkitTransitionDuration		=	"0";
		$("tvod_back").style.webkitTransitionDuration		=	"0";
		$("timeInfo").style.webkitTransitionDuration		=	"0";
		$("channellog").style.webkitTransitionDuration 		= 	"0";
		$("tvod_main").style.webkitTransitionDuration 		= 	"0";
		$("tvod_date").style.webkitTransitionDuration		=	"0";
		$("tvod_list").style.webkitTransitionDuration		=	"0";
		$("tvod_iconup").style.webkitTransitionDuration 	= 	"0";
		$("tvod_icondown").style.webkitTransitionDuration 	= 	"0";
		$("title").style.webkitTransitionDuration			=	"0";
		$("tvod_title").style.webkitTransitionDuration		=	"0";
		$("tvod_log").style.webkitTransitionDuration		=	"0";
	} else {
		$("date_back").style.webkitTransitionDuration		=	"555";
		$("tvod_tag").style.webkitTransitionDuration		=	"500";
		$("tvod_back").style.webkitTransitionDuration		=	"500";
		$("timeInfo").style.webkitTransitionDuration		=	"500";
		$("channellog").style.webkitTransitionDuration 		= 	"500";
		$("tvod_main").style.webkitTransitionDuration 		= 	"500";
		$("tvod_date").style.webkitTransitionDuration		=	"500";
		$("tvod_list").style.webkitTransitionDuration		=	"500";
		$("tvod_iconup").style.webkitTransitionDuration 	= 	"500";
		$("tvod_icondown").style.webkitTransitionDuration 	= 	"500";
		$("title").style.webkitTransitionDuration			=	"500";
		$("tvod_title").style.webkitTransitionDuration		=	"500";
		$("tvod_log").style.webkitTransitionDuration		=	"500";
	}
	
	$("channellog").style.opacity		=	0;
	$("tvod_title").innerText			=	"回看—" + channelList[myApp.subPos+myApp.shown].ChannelName;
	$("tvod_log").style.opacity			=	1;
	$("title").style.opacity			=	0;
	$("tvod_title").style.left			=	"89px";
	$("tvod_log").style.left			=	"10px";
	$("tvod_iconup").style.left 		= 	"1057px";
	$("tvod_icondown").style.left 		= 	"1057px";
	$("tvod_main").style.left 			= 	"600px";
	$("tvod_date").style.left			=	"40px";
	$("tvod_list").style.left			=	"180px";
	$("tvod_tag").style.left			=	"570px";
	$("tvod_back").style.left			=	"830px";
	$("date_back").style.left			=	"642px";
	$("channellog").style.left			=	"10px";
	$("timeInfo").style.left			=	"915px";
	
  	/**
  	 * myApp.initFlag:
  	 * 
  	 * 首页二级菜单选频道进入频道回看页面, 频道全屏播放页面返回至频道回看页面,置myApp.initFlag为true;
  	 * 
  	 * 页面初始化完毕，置myApp.initFlag为false;
  	 */
  	if(myApp.initFlag) myApp.initFlag = false;
}

/**
 * 选中频道
 * @return
 */
function selectChannel() {
	$("flag").value = 5;
	$("back").style.backgroundImage 			= 	"url(images/channel/channel_focus" + myApp.source +".png)";
	if(!myApp.tvodFLag) $("tvod_back").style.backgroundImage 	= 	"url(images/channel/tvod_no_focus.png)";
	$("date_back").style.backgroundImage 		= 	"url(images/channel/date_no_focus.png)";
	displayProgram();
}

/**
 * 选中回看频道
 * @param position
 * @return
 */
function selectBackItem(position)
{
	myApp.channID						=	channelList[position].InnerChannelID;
	$("channelname").value 				= 	channelList[myApp.subPos+myApp.shown].ChannelID+" "+channelList[myApp.subPos+myApp.shown].ChannelName;
	$("page").innerText 				= 	""+ myApp.nowPage + "/" + myApp.totalPage + "页";

	$("logoDiv").style.visibility		=	"hidden";
	$("logo").style.opacity				=	"0";
	$("logo").src 						= 	channelList[myApp.subPos+myApp.shown].PICS_PATH;

	var channLess = Math.min(channelNum,myApp.total);
	for(var i=0 ; i < channLess ; i++) {
		if( i == position ){
			if (myApp.turnPageFlag) {
				$("back").style.webkitTransitionDuration		=	"0";
			} else {
				$("back").style.webkitTransitionDuration		=	"200";
			}
			
			$("back").style.top = backTop[position] + "px";
			setTimeout("changeFontColor()", "200");
		}
		else{
			tObj[i].style.fontWeight 	= "normal";
			tObj[i].style.fontSize 		= "30px";
			tObj[i].style.color 		= "#FFFFFF";
		}
	}

	keyRight();
}

/**
 * 功能：回看节目单上下移动
 * @param num : num == -1 上移; num == 1 下移
 * @return
 */
function changeProgramFocusUD(num) {
	myApp.tvodSubPos += num;
	if (programData[myApp.tvodSubPos+myApp.tvodShown].nowState == "after" || programData[myApp.tvodSubPos+myApp.tvodShown].nowState == "now" || typeof(programData[myApp.tvodSubPos+myApp.tvodShown].nowState) == "undefined") {
		var i = myApp.tvodSubPos+myApp.tvodShown;
		//规避在回看节目单中有未录制好的节目单
		if (num < 0) {
			for ( ; i >=0  ; i--)
				if (programData[i].nowState === "ago") break;
		} else {
			for ( ; i < myApp.tvodTotal ; i++)
				if (programData[i].nowState === "ago") break;
		}
		
		if (i == (myApp.tvodTotal-1) || (i == 0) ) {
			myApp.tvodSubPos -= num;
			return;
		} else {
		  	myApp.tvodNowPage 					= 	1 + Math.floor((i)/tvod_pagenum) ;
		  	myApp.tvodShown 					= 	(myApp.tvodNowPage-1)*tvod_pagenum;
		  	myApp.tvodSubPos					=	i%tvod_pagenum;
		  	myApp.tvodLimit						=   Math.min((myApp.tvodTotal-myApp.tvodShown),tvod_pagenum);
		}
	}
	
	myApp.tvodSubPos -= num;
//	if ( (myApp.tvodSubPos+myApp.tvodShown) == 0 && (programData[myApp.tvodSubPos+myApp.tvodShown].nowState == "after" || programData[myApp.tvodSubPos+myApp.tvodShown].nowState == "now" || typeof(programData[myApp.tvodSubPos+myApp.tvodShown].nowState) == "undefined")) { 
//		selectDate(0); 
//		break; 
//	}

	if (myApp.tvodSubPos == 0) {				
		if (num == -1) {						// 向上翻页
			turnProgramPage(num);				
		} else {
			myApp.tvodSubPos += num;
			if( listObj[myApp.tvodSubPos].innerText.length <= 1 ){
				turnProgramPage(num);
			} else {
				selectProgram();
			}
		}
	} else if( myApp.tvodSubPos == 8) {
		if (num == 1) {							//	向下翻页
			turnProgramPage(num);
		} else {
			myApp.tvodSubPos += num;
			if(listObj[myApp.tvodSubPos].innerText.length <= 1){
				turnProgramPage(num);
			} else {
				selectProgram();
			}
		}
	} else {
		myApp.tvodSubPos += num;
		if(listObj[myApp.tvodSubPos].innerText.length <= 1){
			turnProgramPage(num);
		} else {
			selectProgram();
		}
	}
}

/**
 * 回看节目单翻页
 * @param num -1向上翻页; 1 向下翻页
 * @return
 */
function turnProgramPage(num) {

	currentNum = num;
	myApp.tvodNowPage += num;
	if(myApp.tvodNowPage > myApp.tvodTotalPage){ myApp.tvodNowPage = 1;}
	if(myApp.tvodNowPage < 1){ myApp.tvodNowPage = myApp.tvodTotalPage;}
	
	myApp.tvodShown 				= (myApp.tvodNowPage-1)*tvod_pagenum;
	var rest 						= myApp.tvodTotal - myApp.tvodShown;
	myApp.tvodLimit 				= Math.min(tvod_pagenum,rest);
	myApp.tvodSubPos = 0;
	
	//规避在回看节目单中有未录制好的节目单
	var i = myApp.tvodSubPos+myApp.tvodShown;
	if (num < 0) {
		for (i = (tvod_pagenum+myApp.tvodShown-1); i >=0  ; i--)
			if (programData[i].nowState === "ago") break;
	} else {
		for ( ; i < myApp.tvodTotal ; i++)
			if (programData[i].nowState === "ago") break;
	}
	
	if ( programData[i].nowState !== "ago" ) {
		$("flag").value = 2;
		$("tvod_back").style.backgroundImage	=	"url(images/channel/tvod_no_focus.png)";
		$("date_back").style.backgroundImage 	= 	"url(images/channel/date_focus.png)";
	}	else {
	  	myApp.tvodNowPage 					= 	1 + Math.floor((i)/tvod_pagenum) ;
	  	myApp.tvodShown 					= 	(myApp.tvodNowPage-1)*tvod_pagenum;
	  	myApp.tvodSubPos					=	i%tvod_pagenum;
	  	myApp.tvodLimit						=   Math.min((myApp.tvodTotal-myApp.tvodShown),tvod_pagenum);
	}
	
	displayProgramList();
}


// flag == 1 光标停留在高清频道
// flag == 5 光标停留在高清回看频道
// flag == 2 光标停留在回看日期上
// flag == 3 光标停留在回看节上
var continueFlag	=	true;
function eventHandler(obj) {
	if(	($("flag").value) == 1 ) {
		switch(obj.code){
			case "KEY_UP":
				if ( continueFlag )
					changeListFocusUD(-1);
				break;
			case "KEY_DOWN":
				if ( continueFlag )
					changeListFocusUD(1);
				break;
			case "KEY_SELECT":
				doSelect();
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
				window.location.href = backUrl;
				return 0;
				break;
			case "KEY_BACK":
			  	exit();
			  	window.location.href = backUrl;
				break;
		}
	} else if(($("flag").value) == 2){ 
		switch(obj.code){
			case "KEY_UP":
				if ( continueFlag )
					selectDate(-1);
				break;
			case "KEY_DOWN":
				if ( continueFlag )
					selectDate(1);
				break;
			case "KEY_RIGHT":
				if (!myApp.tvodFLag) { 		
					$("flag").value = 3;
					changeProgramFocusUD(0);
				}
				break;
			case "KEY_LEFT" :
				selectChannel();
				break;
			case "KEY_PAGE_UP":
				turnProgramPage(-1);
				break;
			case "KEY_PAGE_DOWN":
				turnProgramPage(1);
				break;
			case "KEY_BACK":
				window.location.href = backUrl;
				break;
		}
	} else if(($("flag").value) == 5){ 
		switch(obj.code) {
			case "KEY_UP":
				if ( continueFlag )
					changeListFocusUD(-1);
				break;
			case "KEY_DOWN":
				if ( continueFlag )
					changeListFocusUD(1);
				break;
			case "KEY_RIGHT" :
				if ( continueFlag )	{		
					$("flag").value = 2;
					selectDate(0);
				}
				break;
			case "KEY_LEFT" :
				if(continueFlag) 
					setTimeout("returnChannel()","500");
				break;
			case "KEY_PAGE_UP":
				turnPage(-1);
				break;
			case "KEY_PAGE_DOWN":
				turnPage(1);
			    break;
			case "KEY_BACK":
				window.location.href = backUrl;
				break;
		}
	} else {
		switch(obj.code){
			case "KEY_UP":
				if ( continueFlag )
					changeProgramFocusUD(-1);
				break;
			case "KEY_DOWN":
				if ( continueFlag )
					changeProgramFocusUD(1);
				break;
			case "KEY_SELECT":
				doSelect();
				break;
			case "KEY_PAGE_UP":
				turnProgramPage(-1);
				break;
			case "KEY_PAGE_DOWN":
				turnProgramPage(1);
				break;
			case "KEY_LEFT" :
			  	$("flag").value = 2;
			  	selectDate(0);
				break;
			case "KEY_EXIT":
			case "KEY_BACK":
			  	$("flag").value = 2;
			  	selectDate(0);
				break;
		}
	}
  	if(continueFlag){
  		continueFlag = false;
  		setTimeout("continueFlag = true;",300);
	}
}