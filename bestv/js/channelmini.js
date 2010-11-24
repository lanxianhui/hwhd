
document.onkeypress = grabEvent;
document.onirkeypress = grabEvent;
document.onsystemevent = grabEvent;

function grabEvent(event) {
	var obj = {code:"", value:0, type:0};
	var keycode = event.which;
	//iPanel.debug("[meifk]keycode === " + keycode);
	var code = "";
	var value = 0;
	var type = 0;
	if(keycode > 47 && keycode < 58) {
		code = "KEY_NUMERIC";
		value = keycode - 48;
	} else {
		switch(keycode) {
			case 4://up
			case 39://up
				code = "KEY_RIGHT";
				break;
			case 2://down
			case 40://down
				code = "KEY_DOWN";
				break;
			case 3://left
			case 37://left
				code = "KEY_LEFT";
				break;
			case 1://right
			case 38://right
				code = "KEY_UP";
				break;
			case 13://enter
				code = "KEY_SELECT";
				break;
			case 339://exit
				code = "KEY_EXIT";
				break;
			case 340://back
			case 8://back
				code = "KEY_BACK";
				break;
			case 33://page up
				code = "KEY_PAGE_UP";
				break;
			case 34://page down
				code = "KEY_PAGE_DOWN";
				break;
			case 512:
				code = "KEY_HOMEPAGE";
				break;
			case 263:
				code = "KEY_PAUSEPLAY";
				break;
			case 264:
				code = "KEY_FAST_FORWARD";
				break;
			case 265:
				code = "KEY_FAST_REWIND";
				break;
			case 270:
				code = "KEY_STOPPLAY";
				break;
			case 105://EPG
				code = "KEY_EPG";
				break;
			case 517://VOD
				code = "KEY_VOD";
				break;
			case 561://????
				code = "KEY_IME";
				break;
			case 562://???
				code = "KEY_BROADCAST";
				break;
			case 563://tv
				code = "KEY_TV";
				break;
			case 564://audio
				code = "KEY_AUDIO";
				break;
			case 268://info
				code = "KEY_INFO";
				break;
			case 570://?????
				code = "KEY_FAVORITE";
				break;
			case 259:
				//case 595:
				//case 5916://??+
				code="KEY_VOLUME_UP";
				showVolume();
				break;
			case 260:
				//case 596:
				//case 5917://??-
				code="KEY_VOLUME_DOWN";
				showVolume();
				break;
			case 261:
				code = "KEY_MUTE";
				setMute();
				break;
			case 286://???
				code = "KEY_VOLUMNE";
				break;
			case 275://red
				code = "KEY_RED";
				break;
			case 276://green
				code = "KEY_GREEN";
				break;
			case 277://yellow
				code = "KEY_YELLOW";
				break;
			case 278://blue
				code = "KEY_BLUE";
				break;
			case 613://menu
				code = "KEY_MENU";
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
			case 8888://?л???
				iPanel.mainFrame.location.href = "changeUI.htm";
				//iPanel.mainFrame.widget_index.minimize();
				break;
		}
	}
	obj.code = code;
	obj.value = value;
	obj.type = type;
	if(eventHandler) eventHandler(obj);
}
function $(id) {
	return document.getElementById(id);
}
function showVolume() {
	iPanel.eventFrame.widget_volume.show();
	iPanel.eventFrame.widget_volume.checkVolumeTimer();
}
function setMute() {
	showVolume();
	widget_volume.setMute();
}
<!-- 	Div Slip	--> 
function showSlip(focusDiv, topPos, leftPos) {
	//iPanel.debug("this.focusDiv="+focusDiv);
	//iPanel.debug("typeof(focusDiv)="+typeof(focusDiv));
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
		this.focusDiv.style.top = this.currTop + "px";
		this.focusDiv.style.left = this.currLeft + "px";
	};
	this.clearTransition = function () {
		this.focusDiv.style.webkitTransitionDuration = "0s";
	};
	this.cssSlip = function(topMove, leftMove, duration, fun, moveDelay) {
		//duration = duration || 0.5;
		duration = 0.2;
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
	
	this.changeFocus = function(n, slipType,duration) { 
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
			this.focusSlip[slipType + "Slip"](n * this.topMoveSize, n * this.leftMoveSize,0.2);
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
 * AJAX??????
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