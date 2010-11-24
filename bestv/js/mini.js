document.writeln("<script src='js/tool.js' type='text/javascript'></script>");
document.onkeypress = grabEvent;
document.onirkeypress = grabEvent;
document.onsystemevent = grabEvent;
var tipsFlag = 0;
var goPage	=	null;
var channelValue="";
var chanelValueTimer=-1;
var forChannelNum=false;
function grabEvent(event) {
	var obj = {code:"", value:0, type:0};
	var keycode = event.which;
	iPanel.debug("xinsw-------------------keycode="+keycode);
	var code = "";
	var value = event.which;
	var type = 0;
	var modifiers=0;
	if(keycode > 47 && keycode < 58) {
		code = "KEY_NUMERIC";
		value = keycode - 48;
		if(channelValue.length<3){
				channelValue=channelValue+value;
		}		
		var urlstr=window.location.href;
		if(urlstr.indexOf("play.jsp")<=-1&&urlstr.indexOf("HD_playTvodControl.jsp")<=-1&&urlstr.indexOf("HD_search.jsp")<=-1){			
			iPanel.overlayFrame.location="ChannelNum.html?"+channelValue;
			iPanel.overlayFrame.moveTo(900,39);
			iPanel.overlayFrame.resizeTo(347,100);			
			channelValue="";
		}
	} else {
		switch(keycode) {
			case 4:
			case 39://右
				code = "KEY_RIGHT";
					if (tipsFlag == 1) {
						document.getElementById("tipSelect").style.backgroundImage = "url(images/channel/tipSelect.png)";
						document.getElementById("tipReturn").style.backgroundImage = "url(images/channel/tipReturnFoucs.png)";
						tipsFlag	=	2;
					}
				break;
			case 2:
			case 40://下
				code = "KEY_DOWN";
				break;
			case 3:
			case 37://左
				code = "KEY_LEFT";
				if (tipsFlag == 2) {
						document.getElementById("tipSelect").style.backgroundImage = "url(images/channel/tipSelectFoucs.png)";
						document.getElementById("tipReturn").style.backgroundImage = "url(images/channel/tipReturn.png)";
						tipsFlag	=	1;
					}
				break;
			case 1:
			case 38://上
				code = "KEY_UP";
				break;
			case 13://确认
				code = "KEY_SELECT";
					if (tipsFlag == 1) {
						window.location.href = "HD_channelPortal.jsp";
					} else if (tipsFlag == 2) {
						document.getElementById("tipSelect").style.webkitTransform = "scale(0)";
					}
				break;
			case 339://exit
				code = "KEY_EXIT";
				break;
			case 8:
			case 340://返回
				code = "KEY_BACK";
				//history.back();
				break;
			case 33://上页
				code = "KEY_PAGE_UP";
				break;
			case 34://下页
				code = "KEY_PAGE_DOWN";
				break;
			case 42:// * 键
				code = "KEY_*";
				break;
			case 263://暂停 播放键
				code = "KEY_PAUSEPLAY";
				break;
			case 264://快进
				code = "KEY_FAST_FORWARD";
				break;
			case 265://快退
				code = "KEY_FAST_REWIND";
				break;
			case 270:
				code = "KEY_STOPPLAY";
				break;
			case 105://
				break;
			case 1108://频道
				code = "KEY_EPG";	
			 	var strurl=window.location.href;
				 if(strurl.indexOf("HD_playliveControl.jsp")>-1) return;
				 else if(strurl.indexOf("HD_playliveControl.jsp")>-1||strurl.indexOf("HD_playTvodControl.jsp")>-1||strurl.indexOf("HD_portal.jsp")>-1||strurl.indexOf("play.jsp")>-1){
						iPanel.overlayFrame.location="promit.html?0";
						iPanel.overlayFrame.resizeTo(748,220);
						iPanel.overlayFrame.moveTo(274,250);
				}else{
						//alert(iPanel.eventFrame.ccp);
						if(typeof(iPanel.eventFrame.ccp)=="undefined"||iPanel.eventFrame.ccp=="") window.location.href="HD_channelPortal.jsp?";
						else {
							if(iPanel.eventFrame.cs=="hd") {
									iPanel.mainFrame.location="HD_playliveControl.jsp?source=hd&currentNum="+iPanel.eventFrame.ccp;
							}
							else iPanel.mainFrame.location="HD_playliveControl.jsp?currentNum="+iPanel.eventFrame.ccp;
						}
				}	
			
				break;
			case 517://VOD
				break;
			case 1113://回看
				code = "KEY_TVOD";
					var strurl=window.location.href;
					if(strurl.indexOf("HD_playTvodControl.jsp")>-1) return;
				    else if(strurl.indexOf("HD_playliveControl.jsp")>-1||strurl.indexOf("play.jsp")>-1||strurl.indexOf("HD_portal.jsp")>-1){
						//	goPage	=	"HD_channelPortal.jsp?CHANNELID=001";
						//	displayTips("您确认要跳转到回看页面吗?");
						iPanel.overlayFrame.location="promit.html?2";
						iPanel.overlayFrame.resizeTo(748,220);
						iPanel.overlayFrame.moveTo(274,250);
					}else{
						window.location.href="HD_channelPortal.jsp?CHANNELID=001";
					}	
				break;


			case 1110:// 点播
				code = "KEY_VOD";
					var strurl=window.location.href;
					if(strurl.indexOf("play.jsp")>-1) return;
				    else if(strurl.indexOf("HD_playliveControl.jsp")>-1||strurl.indexOf("HD_playTvodControl")>-1||strurl.indexOf("HD_portal.jsp")>-1){
						//	goPage	=	"HD_channelPortal.jsp?CHANNELID=001";
						//	displayTips("您确认要跳转到回看页面吗?");
						iPanel.overlayFrame.location="promit.html?1";
						iPanel.overlayFrame.resizeTo(748,220);
						iPanel.overlayFrame.moveTo(274,250);
					}else{
						window.location.href="HD_vod.jsp";
					}	
				break;
			case 519:
				code= "KEY_SET_UP";//设置
				break;	
			case 5919:
				code="KEY_CHANNEL";//声道
				var urlstr=window.location.href;
				if(urlstr.indexOf("play.jsp")>-1||urlstr.indexOf("HD_playliveControl")>-1||urlstr.indexOf("HD_playTvodControl")>-1||urlstr.indexOf("HD_portal.jsp")>-1){
						changeMode();
				}		
				break;	
			case 560://#键
				code = "KEY_#";
				break;
			case 561:
				code = "KEY_IME";
				break;
			case 562:
				code = "KEY_BROADCAST";
				break;
			case 563://tv
				code = "KEY_TV";
				break;
			case 564://audio
				code = "KEY_AUDIO";
				break;
			case 268://信息
				code = "KEY_INFO";
				break;
			case 570://
				code = "KEY_FAVORITE";
				break;
			case 259:
				code="KEY_VOLUME_UP";
				showVolume();
				break;
			case 260:
				code="KEY_VOLUME_DOWN";
				showVolume();
				break;
			case 261: //静音
				code = "KEY_MUTE";
				var urlstr=window.location.href;
				if(urlstr.indexOf("play.jsp")>-1||urlstr.indexOf("HD_playliveControl.jsp")>-1||urlstr.indexOf("HD_playTvodControl.jsp")>-1||urlstr.indexOf("HD_portal.jsp")>-1||urlstr.indexOf("HD_MyMemory")>-1||urlstr.indexOf("HD_channelPortal.jsp")>-1||urlstr.indexOf("HD_channelHDPortal.jsp")>-1){
					if($("muteDiv")==null||typeof($("muteDiv"))=="undefined"){
						creatMuteDiv();
					}	
					$("muteDiv").style.webkitTransitionDuration="0ms";
					if(urlstr.indexOf("HD_portal.jsp")>-1){
						$("muteDiv").style.backgroundImage="url(images/vod/mute0.png)";
						$("muteDiv").style.width="65px";
						$("muteDiv").style.height="65px";
						$("muteDiv").style.left="800px";
					}
					else if(urlstr.indexOf("HD_channelPortal.jsp")>-1||urlstr.indexOf("HD_channelHDPortal.jsp")>-1){
						$("muteDiv").style.width="62px";
						$("muteDiv").style.height="62px";
						$("muteDiv").style.backgroundImage="url(images/vod/mute2.png)"; 
						$("muteDiv").style.left="20px";
						$("muteDiv").style.top="590px";
					}
					else{
						$("muteDiv").style.width="62px";
						$("muteDiv").style.height="62px";
						$("muteDiv").style.backgroundImage="url(images/vod/mute2.png)"; 
						$("muteDiv").style.left="50px";
						$("muteDiv").style.top="800px";
					}
					$("muteDiv").style.webkitTransitionDuration="300ms";
						setMute();
				}
				break;
			case 286:
				code = "KEY_VOLUMNE";
				break;
			case 275://红键
				code = "KEY_RED";
				window.location.reload();
				return 0;
				break;
			case 768:
			//	switchAndDelMessage();
				code = "KEY_SYSTEM";
				break;
			case 276://绿键
				code = "KEY_GREEN";
				break;
			case 277://黄键
				code = "KEY_YELLOW";
				break;
			case 278://蓝键
				code = "KEY_BLUE";
				break;
			case 512:
			case 613://首页
				code = "KEY_HOMEPAGE";
					iPanel.overlayFrame.close();
					var volumePage=iPanel.pageWidgets.getByName("volumePage");
					volumePage.close();
				break;
			case 1111://通信
				code = "KEY_MESSAGE";
				break;
			case 1112://切换
					code ="KEY_SWITCH";
				break;
			case 5202:
				code = "EIS_VOD_CONNECT_SUCCESS";
				break;
			case 5203:
				code = "EIS_VOD_CONNECT_FAILED";
				break;
			case 5205:
				code ="EIS_VOD_PLAY_SUCCESS";
				break; 
			case 5206:
				code = "EIS_VOD_PLAY_FAILED";
				break;
			case 5209:
				code = "EIS_VOD_PROGRAM_BEGIN";
				break;
			case 5210:
				code="EIS_VOD_PROGRAM_END";
				break;
			case 5502:
				code="EIS_IP_NETWORK_READY";
				break;
			case 5974:
					code = "EIS_MISC_HTML_OPEN_FINISHED";
					event.type = 1;
					break;
			case 8888:
				break;
			case 6001://USB检测
				code = "EIS_DEVICE_USB_INSERT";
					//showPrompt(0);
					iPanel.overlayFrame.location="usbPromit.html?1";
					iPanel.overlayFrame.moveTo(350,304);
					iPanel.overlayFrame.resizeTo(576,241);
				break;
			case 6002://USB驱动安装
				code = "EIS_DEVICE_USB_INSTALL";
					searchUSBFile();
					if(typeof(iPanel.eventFrame.hasUSB)=="undefined"){
						iPanel.eventFrame.eval("var hasUSB = ''");
					}
						iPanel.eventFrame.hasUSB=true;
				break;
			case 6003://USB删除
				code = "EIS_DEVICE_USB_DELETE";
					 iPanel.overlayFrame.location="usbPromit.html?2";
					 iPanel.overlayFrame.moveTo(350,304);
				   	 iPanel.overlayFrame.resizeTo(576,241);
					 iPanel.eventFrame.USBData=[];
					 iPanel.eventFrame.USBIsReady=false;
					 var strurl=window.location.href//.split("/")[4];
					 iPanel.eventFrame.hasUSB=false;
					 if(strurl.indexOf("HD_MyMemory.jsp")>-1){
					 		setTimeout(window.location = "Category.jsp",3000);
					 }			 
				break;
			case 6104:
					code = "EIS_USB_SEARCH_FILE";
					modifiers = event.modifiers;
					for(var m=0;m<drivesLength;m++){
						if(searchId[m]==modifiers){
							searchResult(modifiers,m,0);
						}
					}
					break;
			case 6105:
					code = "EIS_USB_SEARCH_FILE_FINISH";//搜索完成
					modifiers = event.modifiers;
					for(var m=0;m<drivesLength;m++){
						if(searchId[m]==modifiers){
							searchResult(modifiers,m,1);
						}
					}
			    	break;	
			}
		}
	obj.code = code;
	obj.value = value;
	obj.type = type;
	obj.modifiers=modifiers;
	if(eventHandler) eventHandler(obj);
}
function $(id) {
	return document.getElementById(id);
}

function forchangeChannel(channelNumer){
	var data0=iPanel.eventFrame.channelInfo;
	var data1=iPanel.eventFrame.HDchannelInfo;
	var data0AreTrue=false;//是否在标清存在该频道,false表示不存在
	var data1AreTrue=false;//是否在高清存在该频道,false表示不存在
	var urlstr=window.location.href;
	if(channelNumer.length==1) channelNumer="00"+channelNumer;
	if(channelNumer.length==2) channelNumer="0"+channelNumer;	
	for(var m=0;m<data0.length;m++){
				//	alert(data0[m].ChannelID);
		if(data0[m].ChannelID==channelNumer){
			data0AreTrue=true;	
			forChannelNum=false;
			//alert("aaa"+data0AreTrue);
		}	
	}				
	for(var m=0;m<data1.length;m++){
		if(data1[m].ChannelID==urlstr){
			data1AreTrue=true;
			forChannelNum=false;
		}
	}	
	if(data0AreTrue==false&&data1AreTrue==false){
		if(urlstr.indexOf("play.jsp")>-1||urlstr.indexOf("HD_playliveControl")>-1||urlstr.indexOf("HD_playTvodControl")>-1){
			forChannelNum=true;	
		}else{
			forChannelNum=false;
		}
	}
}

function forChannel(){
	iPanel.overlayFrame.location="ChannelNum.html?"+channelValue;
	iPanel.overlayFrame.moveTo(900,39);
	iPanel.overlayFrame.resizeTo(347,100);			
	channelValue="";
}

function setMute() {
	if(mp.getMuteFlag()==0){
		mp.setMuteFlag(1);
		$("muteDiv").style.visibility="visible";
	}		 
	else{
		mp.setMuteFlag(0);
		$("muteDiv").style.visibility="hidden";
	}		

}

var modeTimer=-1;
var modePos=0;
function changeMode(){
		if($("channelNumber")==null||typeof($("channelNumber"))=="undefined"){
				creatChannelNumDiv();
		}
		var modeStr="";
		var modeType="";
		$("channelNumText").style.fontSize="60px";
		if(media.sound.mode=="stereo"){modeStr="立体音";modePos=0;}
		if(media.sound.mode=="left"){modeStr="左声道";modePos=1;}
		if(media.sound.mode=="right"){modeStr="右声道";modePos=2;}
		if($("channelNumber").style.visibility=="hidden"){
				$("channelNumber").style.visibility="visible";
				$("channelNumText").innerText=modeStr;
				clearTimeout(modeTimer);
				modeTimer=setTimeout("setMode()",2000);
				return;
		}	
		else{
				modePos+=1;
				if(modePos>2) modePos=0;
				if(modePos==0){ modeStr="立体音";modeType="stereo" }
				if(modePos==1){ modeStr="左声道";modeType="left" }
				if(modePos==2){ modeStr="右声道";modeType="right" }
				$("channelNumText").innerText=modeStr;
				media.sound.mode=modeType;
		}	
	

}	

function setMode(){
	$("channelNumber").style.visibility="hidden";
}	

<!-- 	Div Slip	--> 
function showSlip(focusDiv, topPos, leftPos) {
	this.focusDiv = typeof(focusDiv) == "object" ? focusDiv  : $(focusDiv);
	this.topPos = topPos || 0;
	this.leftPos = leftPos || 0;
	this.currTop = this.topPos;
	this.currLeft = this.leftPos;
	this.endTop = this.currTop;
	this.endLeft = this.currLeft;
	this.topMoveSize = 0;
	this.leftMoveSize = 0;
	this.step = 6;
	this.moveStep = 0;
	this.delay = 20;
	this.moveTimer = null;
	this.callback = function(){};
	
	var self = this;
	
	this.init = function () {
		this.focusDiv.style.webkitTransitionDuration = "0s";
		this.focusDiv.style.top = this.currTop + "px";
		this.focusDiv.style.left = this.currLeft + "px";
	};
	this.clearTransition = function () {
		this.focusDiv.style.webkitTransitionDuration = "0s";
	};
	this.cssSlip = function(topMove, leftMove, duration, fun, moveDelay) {
		if(typeof duration == "undefined") duration = 0.2;
		fun = fun || "ease";
		moveDelay = moveDelay || 0;
		this.endTop += topMove;
		this.endLeft += leftMove;
		this.currTop = this.endTop;
		this.currLeft = this.endLeft;
		this.focusDiv.style.webkitTransitionDuration = duration + "s";
		//this.focusDiv.style.webkitTransitionTimingFunction = fun;
		//this.focusDiv.style.webkitTransitionDelay = moveDelay + "s";
		this.focusDiv.style.top = this.currTop + "px";
		this.focusDiv.style.left = this.currLeft + "px";
	};
	this.jsSlip = function (topMove, leftMove) {
		this.endTop += topMove;
		this.endLeft += leftMove;
		this.topMoveSize = this.endTop - this.currTop;
		this.leftMoveSize = this.endLeft - this.currLeft;
		this.moveStep = 0;
		this.move();
	};
	this.move = function() {
		if(this.moveTimer != null) window.clearTimeout(this.moveTimer);
		if(this.moveStep == this.step - 1) {
			this.currTop = this.endTop;
			this.currLeft = this.endLeft;
			this.focusDiv.style.top = this.currTop + "px";
			this.focusDiv.style.left = this.currLeft + "px";
			this.callback();
		} else {
			this.moveStep++;
			var x = (Math.sin((Math.PI / 2) * (this.moveStep / this.step)) - Math.sin((Math.PI / 2) * ((this.moveStep - 1) / this.step)));
			this.currTop += this.topMoveSize * x;
			this.currLeft += this.leftMoveSize * x;
			this.focusDiv.style.top = this.currTop + "px";
			this.focusDiv.style.left = this.currLeft + "px";
			this.moveTimer = window.setTimeout(function () {self.move();}, this.delay);
		}	
	};
	this.init();
}
<!-- 	List Show	--> 
function showList(dataList, divList) { 
	this.dataList = dataList;
	this.dataLength = dataList.length;
	this.divList = divList;
	this.divLength = divList.length;
	this.listPos = 0;
	this.divPos = 0;
	this.topMoveSize = 0;
	this.leftMoveSize = 0;
	this.focusSlip = null;
	
	this.focusInit = function(focusDiv, topPos, leftPos, topMove, leftMove) { 
		this.topMoveSize = topMove;
		this.leftMoveSize = leftMove;
		this.focusSlip = new showSlip(focusDiv, topPos, leftPos);
		this.focusWriteData(this.listPos);
	};

	this.showData = function(firstPos) {
		this.clearData();
		firstPos = firstPos || 0;
		this.listPos = firstPos;
		var n = this.dataLength - firstPos > this.divLength ? this.divLength : this.dataLength - firstPos;
		for(var i = 0; i < n; i ++) this.writeData(i, firstPos + i);
	};
	
	this.changeFocus = function(n, slipType, duration) { 
		if(typeof(this.focusSlip) == "undefined") return;
		if(slipType != "css") slipType = "js";
		var flag = 0;
		this.listPos += n;
		if(this.listPos < 0) { this.listPos = 0; return;}
		else if(this.listPos > this.dataLength - 1) { this.listPos = this.dataLength - 1; return; }
		this.divPos += n;
		if(this.divPos > this.divLength - 1 && n > 0) { this.divPos = this.divPos - 1; flag = 1; }
		if(this.divPos < 0 && n < 0) { this.divPos = 0; flag = -1; }
		this.focusWriteData(this.listPos);
		if(flag == 0) {
			this.focusSlip[slipType + "Slip"](n * this.topMoveSize, n * this.leftMoveSize, duration);
		} else if(flag == 1) { 
			for(var i = 0; i  <  this.divLength; i ++) this.writeData(i, this.listPos - this.divLength + 1 + i);
		} else if(flag == -1) { 
			for(var i = 0; i  <  this.divLength; i ++) this.writeData(i, this.listPos + i);
		}
	};
	
	this.changePage = function(n, slipType) { 
		if(this.dataLength <= this.divLength) return;
		if(( this.listPos == 0 && n < 0)||(this.listPos == this.dataLength - 1 && n > 0)) return;
		if(slipType != "css") slipType = "js";
		this.listPos += n * this.divLength;
		if(this.listPos - this.divPos < 0) { 
			this.listPos = 0;
			for(var i = 0; i  <  this.divLength; i ++) this.writeData(i, this.listPos + i);
			this.focusSlip[slipType + "Slip"](-1 * this.divPos * this.topMoveSize, -1 * this.divPos * this.leftMoveSize);
			this.divPos = 0;
		} else if(this.listPos + this.divLength - this.divPos > this.dataLength - 1) { 
			this.listPos = this.dataLength - 1;
			for(var i = 0; i  <  this.divLength; i ++) this.writeData(i, this.dataLength - this.divLength + i);
			this.focusSlip[slipType + "Slip"]((this.divLength - 1 - this.divPos) * this.topMoveSize,
																				(this.divLength - 1 - this.divPos) * this.leftMoveSize);
			this.divPos = this.divLength - 1;
		} else { 
			for(var i = 0; i  <  this.divLength; i ++) this.writeData(i, this.listPos - this.divPos + i);
		}
		this.focusWriteData(this.listPos);
	};
	
	this.havaData = function(dp, lp) { 
		this.divList[dp].innerHTML = this.dataList[lp];
	};
	this.noneData = function() { 
		for(var i = 0; i  <  this.divLength; i ++) this.divList[i].innerHTML = "";
	};
	this.focusData = function() { 
		this.focusSlip.focusDiv.innerHTML = this.dataList[this.listPos];
	};
	
	this.focusWriteData = this.focusData || function() {};
	this.writeData = this.havaData || function() {};
	this.clearData = this.noneData || function() {};
}
function menuSlip(menuA, menuB, menuAId, menuBId, menuWidth, menuMoveSize, moveTime) { 
	this.menuA = typeof(menuA)== "object" ? menuA : $(menuA);
	this.menuB = typeof(menuB)== "object" ? menuB : $(menuB);
	this.menuLength = menu.length;
	this.menuAId = menuAId;
	this.menuBId = menuBId;
	this.menuWidth = menuWidth;
	this.menuMoveSize = menuMoveSize;
	this.menuASlip = null;
	this.menuBSlip = null;
	this.focusNum = 0;
	this.focusFlag = 1;
	this.focusIn = null;
	this.focusOut = null;
	this.moveTime = moveTime || 300;
	this.moveFlag = 0;
	this.moveFocusSwitch = 0;
	this.moveFocusIn = function() {};
	this.moveFocusOut = function() {};
	
	var self = this;
	
	this.init = function(moveFocusSwitch, focusNum, moveFocusIn, moveFocusOut) { 
		this.moveFocusSwitch = moveFocusSwitch || this.moveFocusSwitch;
		this.focusNum = focusNum || this.focusNum;
		this.moveFocusIn = moveFocusIn || null;
		this.moveFocusOut = moveFocusOut || null;
		
		this.focusIn = this.menuBId[this.focusNum];
		this.focusOut = this.focusIn;
		if(this.moveFocusSwitch) this.moveFocusIn(this.focusIn);
		this.menuASlip = new showSlip(this.menuA, 15, -1 * this.menuWidth);
		this.menuBSlip = new showSlip(this.menuB, 15, 0);
	};
	
	this.slip = function(n, slipType, callback) { 
		slipType = slipType || "js";
		if(this.moveFlag == 1) return;
		this.moveFlag = 1;
		window.setTimeout(function() { self.moveFlag = 0; }, this.moveTime);
		if(n > 0 && this.menuASlip.currLeft == 0 && this.menuBSlip.currLeft == this.menuWidth) { 
			this.menuBSlip.currLeft =  -1 * this.menuWidth;
			this.menuBSlip.endLeft =  -1 * this.menuWidth;
			this.menuBSlip.clearTransition();
			this.menuB.style.left =  -1 * this.menuWidth + "px";
		} else if(n > 0 && this.menuBSlip.currLeft == 0 && this.menuASlip.currLeft == this.menuWidth) { 
			this.menuASlip.currLeft =  -1 * this.menuWidth;
			this.menuASlip.endLeft =  -1 * this.menuWidth;
			this.menuASlip.clearTransition();
			this.menuA.style.left =  -1 * this.menuWidth + "px";
		} else if(n < 0 && this.menuASlip.currLeft == 0 && this.menuBSlip.currLeft ==(-1 * this.menuWidth)) { 
			this.menuBSlip.currLeft = this.menuWidth;
			this.menuBSlip.endLeft = this.menuWidth;
			this.menuBSlip.clearTransition();
			this.menuB.style.left = this.menuWidth + "px";
		} else if(n < 0 && this.menuBSlip.currLeft == 0 && this.menuASlip.currLeft ==(-1 * this.menuWidth)) { 
			this.menuASlip.currLeft = this.menuWidth;
			this.menuASlip.endLeft = this.menuWidth;
			this.menuASlip.clearTransition();
			this.menuA.style.left = this.menuWidth + "px";
		}
		this.focusIn.style.webkitTransition = "";
		this.focusOut.style.webkitTransition = "";
		window.setTimeout(function() { self.move(n, slipType, callback); }, 10);
	};
	
	this.move = function(n, slipType, callback) {
		if(this.moveFocusSwitch) { 
			this.focusOut = this.focusIn;
			this.moveFocusOut(this.focusOut);
			this.focusNum +=  -1 * n;
			if(this.focusNum < 0) { this.changeFocusFlag(); this.focusNum = this.menuLength - 1; }
			if(this.focusNum > this.menuLength - 1) { this.changeFocusFlag(); this.focusNum = 0; }
			if(this.focusFlag == 1) this.focusIn = this.menuBId[this.focusNum];
			else this.focusIn = this.menuAId[this.focusNum];
			this.moveFocusIn(this.focusIn);
		}
		if(callback) callback(this.focusNum);
		this.menuASlip[slipType + "Slip"](0, n * this.menuMoveSize);
		this.menuBSlip[slipType + "Slip"](0, n * this.menuMoveSize);
	};
	
	this.changeFocusFlag = function() { 
		if(this.focusFlag == 1) this.focusFlag = 0;
		else this.focusFlag = 1;
	};
}

/**
 * AJAX?￡?éμ?·a×°
 */
var objPool = [];
objPool[0] = createXMLHttpRequest();

function createXMLHttpRequest(){
	var xmlh = null;
	if(window.XMLHttpRequest){
		xmlh = new XMLHttpRequest();
	}else if(window.ActiveXObject){
		xmlh = new ActiveXObject("Microsoft.XMLHTTP");
	}
	return xmlh;
}

function AJAX_OBJ(url, callback){
	this.xmlHttp = null;
	this.url = url;
	this.callback = callback;
}

AJAX_OBJ.prototype.requestData = function(){
	this.xmlHttp = this.getInstance();
	var request_url = this.url;
	var self = this;
	this.xmlHttp.onreadystatechange = function(){
		self.stateChanged();
	};
	this.xmlHttp.open("GET", request_url, true);
	this.xmlHttp.send(null);
}

AJAX_OBJ.prototype.getInstance = function(){
	for (var i = 0; i < objPool.length; i ++)
	{
		if ( objPool[i].readyState == 4||objPool[i].readyState == 0)
		{
			return objPool[i];
		}
	}
	objPool[objPool.length] = createXMLHttpRequest();
	return objPool[objPool.length - 1];
}

AJAX_OBJ.prototype.stateChanged = function()
{
	iPanel.debug("this.xmlHttp.readyState="+this.xmlHttp.readyState )
	if(this.xmlHttp.readyState == 4)
	{
		iPanel.debug("this.xmlHttp.status="+this.xmlHttp.status )
		if(this.xmlHttp.status == 200)
		{
			iPanel.debug("ok,come back")
			this.callback(this.xmlHttp);
		}
		else//error handling
		{
			iPanel.debug("get date error and this.xmlHttp.status="+this.xmlHttp.status);
		}
	}
}

<!-- meifk add another ajax object -->
function AJAX(type, url, asyn, onSuccess, timeout){
	this.type = type || "GET";
	this.url = url;
	this.asyn = asyn || false;
	this.timeout = timeout || 5000;
	this.content = "";
	this.response = null;
	this.onSuccess = onSuccess || function (data) {this.responseData = data;};
	this.onError = function (err) {};

	this.send = function () {
		var self = this;
		var requestDone = false;
		var xml = new XMLHttpRequest();
		if(!xml) {
			self.onError("create httpRequest failed");
			return false;
		}
		
		xml.open(self.type, self.url, self.asyn);
		setTimeout(function(){requestDone = true; }, self.timeout);
		if(self.type == "POST"){
			xml.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		}
		if(self.asyn){
			xml.onreadystatechange = function () {
				if(requestDone){
					self.onError("request timeout!");
					return false;
				}
				if(xml.readyState == 4) {
					if(httpSuccess(xml)) self.onSuccess(httpData(xml, self.type)); 
					else self.onError("request failed!");
					xml = null;
					return true;
				}
				return false;
			};
		}
		xml.send(self.content);
		if(!self.asyn) {
			if(requestDone){
				self.onError("request timeout!");
				return false;
			}
			if(httpSuccess(xml)) self.responseData = httpData(xml, self.type); 
			else self.onError("request failed!");
			xml = null;
			return true;
		}	
		function httpSuccess(r) {
			try{ 
					return (!r.status && location.protocol == "file:") ||
								 (r.status >= 200 && r.status < 300) ||
								 (r.status == 304) ||
								 (navigator.userAgent.indexOf("Safari") >= 0 && typeof r.status == "undefined");
			} catch(e) {}
			return false;
    }
		function httpData(r, type) {
			var ct = r.getResponseHeader("content-type");
			var data = !type && ct && ct.indexOf("xml") >= 0;
			data = (type == "xml") || (data ? r.responseXML : r.responseText);
			if(type == "script")
					eval.call(window, data);
			return data;
    }
	}
}


function creatChannelNumDiv(){
		var mydiv = document.createElement("div"); 
		mydiv.setAttribute("id","channelNumber"); 
		mydiv.style.overflow="hidden"; 
		mydiv.style.height="100px"; 
		mydiv.style.width="347px"; 
		mydiv.style.position="absolute"; 
		mydiv.style.zIndex=110; 
		mydiv.style.left="860px"; 
		mydiv.style.top="39px"; 
		mydiv.style.color="#00AC0C";
		mydiv.style.fontSize="100px";
		mydiv.style.visibility="hidden";
		mydiv.style.webkitTransitionDuration="300ms";
		mydiv.innerHTML="<table width='347' border='0' cellspacing='0' cellpadding='0' ><tr><td height='100'  colspan='2' align='right' style='font-size:100px; color:#00AC0C;' id='channelNumText'></td></tr></table>";
		document.body.appendChild(mydiv);
}


function creatChannelPrompg(){
		var mydiv = document.createElement("div"); 
		mydiv.setAttribute("id","ChannelPrompg"); 
		mydiv.style.overflow="hidden"; 
		mydiv.style.height="241px"; 
		mydiv.style.width="576px"; 
		mydiv.style.backgroundRepeat="no-repeat"; 
		mydiv.style.backgroundImage="url(images/vod/tck_bg2.png)"; 
		mydiv.style.position="absolute"; 
		mydiv.style.zIndex=105; 
		mydiv.style.left="350px"; 
		mydiv.style.top="240px"; 
		mydiv.style.textAlign="center";
		mydiv.style.webkitTransitionDuration="0ms";
		mydiv.style.webkitTransform = "scale(0)";
		mydiv.innerHTML="<table width='576' border='0' cellspacing='0' cellpadding='0' ><tr><td height='120' colspan='2' align='center' style='font-size:40px; color:#f6ff00;' vaglin='bottom' id='channelPrompgText'></td></tr><tr><td height='120' colspan='2' valign='top' align='center' style='font-size:40px; color:#f6ff00;' >请切换到其他频道观看</td></tr></table>";
		document.body.appendChild(mydiv);
}

function creatMuteDiv(){
		var mydiv = document.createElement("div"); 
		mydiv.setAttribute("id","muteDiv"); 
		mydiv.style.overflow="hidden"; 
		mydiv.style.height="65px"; 
		mydiv.style.width="65px"; 
		mydiv.style.backgroundRepeat="no-repeat"; 
		mydiv.style.backgroundImage="url(images/vod/mute0.png)"; 
		mydiv.style.position="absolute"; 
		mydiv.style.zIndex=102; 
		mydiv.style.left="800px"; 
		mydiv.style.top="10px"; 
		mydiv.style.textAlign="left";
		mydiv.style.webkitTransitionDuration="300ms";
		document.body.appendChild(mydiv);
}

var searchId=[];
var folder =[];
var drivesLength=0
function searchUSBFile(){
	var drives = FileSystemObject.drives;
	drivesLength = drives.length;
	if(drivesLength>0){
		for(var x=0; x<drivesLength;x++){
		    var drive = drives[x];
			folder[x]=FileSystemObject.getFolder(drive.driveLetter + ":/");
			//searchId[x]=folder[x].search("mp3|wma|jpg|bmp|gif|png|avi|mpg|ts","suffix","all",-1);
			//MP3，ac3，wav
			searchId[x]=folder[x].search("mp3|ac3|wav|bmp|gif|png|jpg","suffix","all",-1);
		}		
	}
}

var USBMenuData = [{name:"",defaultIcon:"images/mymemory/mymusic_bg.png",submenu:[]},
				   {name:"",defaultIcon:"", submenu:[]},
				   {name:"",  defaultIcon:"images/mymemory/tm.gif", submenu:[]}						 
				  ];

var howtimes=0//被查询完了几次，通常这个变量等于了driveLength即表示已搜索完所以存储设备。
function searchResult(modifiers,m,x){
		var resultId=folder[m].getSearchedResultID(modifiers);
   		var files=folder[m].getSearchedFiles(modifiers, resultId);
		while(typeof(files)!="undefined"&&files.atEnd()==false){	
				var fileNode = files.getFile();
				//iPanel.misc
				var rightName=fileNode.Name.split(".")[0];
				rightName=iPanel.misc.getUserCharsetStr(rightName,"utf-8");
				var  rightPath=fileNode.Path;
				rightPath=iPanel.misc.getUserCharsetStr(rightPath,"utf-8");
				var Obj=new fileObj(rightName,rightPath);
				type=fileNode.Name.split(".")[1].toLowerCase();
				if(type=="mp3"||type=="ac3"||type=="wav"){
					USBMenuData[0].submenu.push(Obj);
				}
				else if(type=="jpg"||type=="bmp"||type=="gif"||type=="png"){
					USBMenuData[1].submenu.push(Obj);
				}
				/*
				else if(type=="avi"||type=="mpg"||type=="ts"){
					USBMenuData[2].submenu.push(Obj);
				}*/
				files.moveNext();
		}
		if(x==1){
			howtimes++;
			if(howtimes==drivesLength){
				if(typeof(iPanel.eventFrame.USBData) == "undefined"){
					iPanel.eventFrame.eval("var USBData = []");
				}
				if(typeof(iPanel.eventFrame.USBIsReady) == "undefined"){
					iPanel.eventFrame.eval("var USBIsReady = []");
				}
					iPanel.eventFrame.USBData=USBMenuData;
					iPanel.eventFrame.USBIsReady=true;
			}
		}
				
}

function fileObj(name,path){
	this.name=name;	
	this.path=path;
}
function fileObj(name,path){
	this.name=name;	
	this.path=path;
}

var mp = new MediaPlayer();
var NativePlayerInstanceID = mp.getNativePlayerInstanceID();
mp.setNativeUIFlag(0);
mp.setMuteUIFlag(0);
mp.setAudioVolumeUIFlag(0);
mp.setAudioTrackUIFlag(0);
mp.setProgressBarUIFlag(0);
mp.setChannelNoUIFlag(0);




function switchAndDelMessage()
{
	var eventJson = "";
	eval("eventJson = " + Utility.getEvent());
	var typeStr = eventJson.type; 
	switch(typeStr)
	{
		case "EVENT_TVMS": 
			TVMS.delMessage(eventJson);
		return 0;
	}
}


/**
 * TVMS对象(暂时只验证最简单的滚动字幕消息,待扩展)
 */ 

function TVMS()
{
    this.rollWidgetName = "roll";     //滚动消息widget的name
    
	this.msgCode;
	this.msgPriority;
	this.msgDisplayURL;
	this.confirmFlag;
	this.isCurrWinImmediate;  //当前正在展示的窗口是否是紧急消息

	/**
	 * 显示消息
	 * @param {string} type : TVMS消息的类型 ""
	 */
    this.delMessage = function(eventJson)
    {
		this.msgCode = eventJson.msgTaskCode;
        this.msgPriority = eventJson.priority;
		this.msgDisplayURL =  eventJson.tvmsURL; //eventJson.tvmsURL;
        this.confirmFlag = eventJson.confirmFlag;
		
		if(this.isFreeToShow())  //如果可以显示
		{  
			//创建widget
			iPanel.pageWidgets.create(this.rollWidgetName, this.msgDisplayURL, 3, 0);
			//检测并显示widget
			this.checkAndShowWidget(0);
		}
		else
		{ 
			this.sendMsgToSTB(0);	
		}
    }
	
	/**
	 * 检测widget是否创建成功,500ms检测一次,若检测10次依然没有创建成功,则打开网页失败,通知机顶盒删除消息

	 * @param {int} num : 检测的次数
	 */
	this.checkAndShowWidget = function(num)
	{ 
		var self = this;
		var widgetObj = iPanel.pageWidgets.getByName(this.rollWidgetName); 
		if(null != widgetObj)  //创建成功则显示widget
		{ 
			widgetObj.discardEvent = 1;  //不捕获事件
			widgetObj.withoutFocus = 1;  //没有焦点
			widgetObj.zIndex = 10;   //tvms消息始终在最上层
			widgetObj.show();
			this.sendMsgToSTB(1);

			//设置当前窗口的紧急状态 
			if(10 == this.msgPriority && 1 == this.confirmFlag) this.isCurrWinImmediate = 1;
			else this.isCurrWinImmediate = 0; 
		}
		else if(num > 10)   //10次检测后仍然没有创建成,发消息给机顶盒删除消息 
		{ 
			iPanel.pageWidgets.destroy(this.rollWidgetName);  //销毁这个wideget
			this.sendMsgToSTB(0);
		}
		else
		{ 
			num++;
			setTimeout(function(){self.checkAndShowWidget(num)},500);	
		}
	}
	
	/**
	 * 
	 * @param {Object} type
	 * @return bool
	 */
	this.isFreeToShow = function()
	{ 
		var widgetObj = iPanel.pageWidgets.getByName(this.rollWidgetName); 
		if(null == widgetObj)  //如果当前没有消息在展示，则可以展示
		{
			return true;
		}
		else
		{
			//将要展示消息的紧急标识
			var tempWinImmediateFlag = 0;
			if(10 == this.msgPriority && 1 == this.confirmFlag) tempWinImmediateFlag = 1;
			 
			//如果将要展示的消息是紧急的,而当前正在展示的是不紧急的消息，则关闭当前消息，直接展示紧急消息
			if( (1 == tempWinImmediateFlag) && (0 == this.isCurrWinImmediate) ) 
			{ 
				return true;
			}
			else
			{ 
				return false;
			}
		}
	}
	
	/**
	 * 发送消息处理结果给机顶盒

	 * @param {string} status : 0:页面不展示消息  1:页面展示消息
	 */
	this.sendMsgToSTB = function(status)
	{
		var result = ""; 
		if(1 == status)
		{
			result = "SUCCESS";
		}
		else
		{
			result = (1 == this.confirmFlag) ? "DELAY" : "NOSHOW";
		} 
		var returnXml = "<ShowMsgNotify><MsgCode>"+this.msgCode+"</MsgCode><STATUS>" + result + "</STATUS></ShowMsgNotify>"; 
		Utility.sendVendorSpecificCommand(returnXml);
	}
}

var TVMS = new TVMS();
iPanel.registerGlobalObject("TVMS", TVMS);
