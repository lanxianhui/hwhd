var flag = 0;
var webkit = 1.3;
var programInfo = [];
var progID = null;
var length = null; // 数据长度
var urlFlag = false; // 是否可以定购PPV, false为可以定购, true为不可定购

function init() {
	$("buy").style.backgroundImage = "url(images/pay/buy_focus.png)";
	reqTvodList();
}

// 显示页面数据
function displayProgram() {

	$("recommend").style.left = "843px";
	$("recommend").style.top = "63px";
	$("recommend").style.visibility = "visible";

	$("recommend_money").style.left = "1077px";
	$("recommend_money").style.top = "20px";
	$("recommend_money").style.visibility = "visible";

	$("recommend_1").innerText = programInfo[2][0].prodNameFull.slice(0, 10);
	if (parseFloat(programInfo[2][0].prodPrice) < 1)
	{
		$("price_0").style.backgroundImage = "url(images/pay/0.png)";
		$("price_1").style.fontSize = "30px";
		$("price_1").style.color = "#FFFFFF";
		$("price_1").innerText = ".";
		var price = programInfo[2][0].prodPrice.split(".");
		var temp = price[1].split("");
		var length = temp.length;
		for ( var i = 0; i < length; i++) {
			$("price_" + (i + 3 - length)).style.backgroundImage = "url(images/pay/"
					+ temp[i] + ".png)";
		}

	} else {
		var price = programInfo[2][0].prodPrice.split(".");
		var temp = price[0].split("");
		var length = temp.length;
		for ( var i = 0; i < length; i++) {
			$("price_" + (i + 3 - length)).style.backgroundImage = "url(images/pay/"
					+ temp[i] + ".png)";
		}
	}

	$("popularity").style.left = "843px";
	$("popularity").style.top = "400px";
	$("popularity").style.visibility = "visible";

	$("popularity_money").style.left = "1077px";
	$("popularity_money").style.top = "357px";
	$("popularity_money").style.visibility = "visible";

	$("popularity_1").innerText = programInfo[2][1].prodNameFull.slice(0, 10);
	
	if (parseFloat(programInfo[2][1].prodPrice) < 1)
	{
		$("money_0").style.backgroundImage = "url(images/pay/0.png)";
		$("money_1").style.fontSize = "30px";
		$("money_1").style.color = "#FFFFFF";
		$("money_1").innerText = ".";
		var price = programInfo[2][1].prodPrice.split(".");
		var temp = price[1].split("");
		var length = temp.length;
		for ( var i = 0; i < length; i++) {
			$("money_" + (i + 3 - length)).style.backgroundImage = "url(images/pay/"
					+ temp[i] + ".png)";
		}
	} else {
		var price = programInfo[2][1].prodPrice.split(".");
		var temp = price[0].split("");
		var length = temp.length;
		for ( var i = 0; i < length; i++) {
			$("money_" + (i + 3 - length)).style.backgroundImage = "url(images/pay/"
					+ temp[i] + ".png)";
		}
	}
}

function setParam(obj, param, value) {
	obj.style.param = value;
}

function displayVOD() {
	$("recommend").style.left = "841px";
	$("recommend").style.top = "216px";
	$("recommend").style.visibility = "visible";

	$("recommend_money").style.left = "1072px";
	$("recommend_money").style.top = "173px";
	$("recommend_money").style.visibility = "visible";

	$("recommend_1").innerText = programInfo[2][0].prodNameFull.slice(0, 10);
	
	if (parseFloat(programInfo[2][0].prodPrice) < 1)
	{
		$("price_0").style.backgroundImage = "url(images/pay/0.png)";
		$("price_1").style.backgroundImage = "url(images/pay/0.png)";
		$("price_2").style.backgroundImage = "url(images/pay/0.png)";
	} else {
		var price = programInfo[2][0].prodPrice.split(".");
		var temp = price[0].split("");
		var length = temp.length;
		for ( var i = 0; i < length; i++) {
			$("price_" + (i + 3 - length)).style.backgroundImage = "url(images/pay/"
					+ temp[i] + ".png)";
		}
	}
}

function displayPPV() {

	$("body").style.backgroundImage = "url(images/pay/payOne.jpg)";
	$("name").style.left = "322px";
	$("name").style.top = "96px";
	$("name").innerText = programInfo[0][0].VodName.slice(0, 20);

	$("logo").style.left = "340px";
	$("logo").style.top = "177px";
	$("cover").style.left = "328px";
	$("cover").style.top = "166px";
	$("icon_post").style.left = "330px";
	$("icon_post").style.top = "549px";
	$("logo").style.backgroundImage = "url(" + programInfo[0][0].HUGEPIC + ")";

	$("buy").style.left = "674px";
	$("buy").style.top = "265px";

	$("return").style.left = "847px";
	$("return").style.top = "264px";

	$("tariff").style.left = "678px";
	$("tariff").style.top = "399px";

	$("tariff_money").style.left = "755px";
	$("tariff_money").style.top = "400px";
	$("tariff_money").innerText = programInfo[1][0].prodPrice + "元";

	$("expires").style.left = "679px";
	$("expires").style.top = "447px";

	$("expression").style.left = "787px";
	$("expression").style.top = "446px";
	$("expression").innerText = programInfo[1][0].tempProdEndTime.slice(0, -3);
}

function displayNOURL() {
	$("body").style.backgroundImage = "url(images/pay/bestv.jpg)";
	
	$("buy").style.display = "none";
	$("ppv").style.display	= "none";
	
	$("buy_tips").style.visibility = "visible";
	$("name").style.left = "212px";
	$("name").style.top = "52px";
	$("name").innerText = programInfo[0][0].VodName.slice(0, 20);

	$("logo").style.left = "278px";
	$("logo").style.top = "122px";
	$("cover").style.left = "266px";
	$("cover").style.top = "113px";
	$("icon_post").style.left = "260px";
	$("icon_post").style.top = "497px";
	$("logo").style.backgroundImage = "url(" + programInfo[0][0].HUGEPIC + ")";

	$("return").style.left = "310px";
	$("return").style.top = "549px";
	$("return").style.backgroundImage = "url(images/pay/return_focus.png)";
	flag = 1;
	$("tipString").innerHTML = "请选择右侧<font color='#B8B8B8'>"
			+ programInfo[2][0].prodName.slice(0, 20) + "</font>定购收看.";
}

function displayURL() {
	$("body").style.backgroundImage = "url(images/pay/index.jpg)";
	$("name").style.left = "62px";
	$("name").style.top = "92px";
	$("name").innerText = programInfo[0][0].VodName.slice(0, 20);

	$("logo").style.left = "70px";
	$("logo").style.top = "177px";
	$("cover").style.left = "58px";
	$("cover").style.top = "164px";
	$("icon_post").style.left = "55px";
	$("icon_post").style.top = "547px";
	$("logo").style.backgroundImage = "url(" + programInfo[0][0].HUGEPIC + ")";

	$("buy").style.left = "367px";
	$("buy").style.top = "265px";

	$("return").style.left = "540px";
	$("return").style.top = "265px";

	$("tariff").style.left = "348px";
	$("tariff").style.top = "399px";

	$("tariff_money").style.left = "426px";
	$("tariff_money").style.top = "400px";
	$("tariff_money").innerText = programInfo[1][0].prodPrice + "元";

	$("expires").style.left = "348px";
	$("expires").style.top = "447px";

	$("expression").style.left = "456px";
	$("expression").style.top = "446px";
	$("expression").innerText = programInfo[1][0].tempProdEndTime.slice(0, -3);
}

// 获取频道列表信息
function getListData(__xmlhttp) {
	var data = eval(__xmlhttp.responseText);
	// data =
	// [[{"VodName":"HDPrisonBreak2","VodID":322135,"HUGEPIC":"images/vod/default.jpg"}],[{"ppvUrl":"HD_payDetail.jsp?prodName=PPV&prodPrice=33.0&prodEndTime=3300&prodDesc=&url=HD_EnsureSubscribeResult.jsp?PRODID=222&PROGID=322135&PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&BOOKMARKTIME=&ORDERPPV=ppv&SUPVODID=null","prodName":"PPV","tempProdEndTime":"2010-08-19
	// 12:06:52","prodDesc":"","prodNameFull":"PPV","prodPrice":"33.0"}],[{"prodName":"WYYmix欧足","tempProdEndTime":"2010-09-19","prodDesc":"","svodUrl":"HD_payDetail.jsp?prodName=WYYmix欧足&prodPrice=100.0&prodEndTime=10000&prodDesc=&url=HD_EnsureSubscribeResult.jsp?PRODID=8888&PROGID=322135&PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&BOOKMARKTIME=&SUPVODID=null","prodNameFull":"WYYmix欧足","prodPrice":"100.0"}]];
	programInfo = data;
	length = programInfo[2].length;
	if ((typeof (programInfo[1][0].ppvUrl) == "undefined")
			|| (programInfo[1][0].ppvUrl == '')
			|| (programInfo[1][0].ppvUrl == null))
		urlFlag = true;

	if (length == 0) {
		displayPPV();
	}
	if (length == 1) {
		if (urlFlag)
			displayNOURL();
		else
			displayURL();
		displayVOD();
	}
	if (length >= 2) {
		if (urlFlag)
			displayNOURL();
		else
			displayURL();
		displayProgram();
	}
	$("body").style.visibility	=	"visible";
	$("protection").style.visibility	=	"visible";
}

// 发起AJAX请求，获取频道信息
function reqTvodList() {
	var requestUrl = "HD_SubscribeSelect.jsp?"
			+ window.location.search.substring(1); // 数据请求

	var params = requestUrl.split("&");
	for ( var i = 0; i < params.length; i++) {
		if (params[i].indexOf("PROGID") > -1)
			progID = params[i].split("=")[1];
		if (params[i].indexOf("FATHERID") > -1)
			progID = params[i].split("=")[1];
	}

	var ajaxObj = new AJAX_OBJ(requestUrl, getListData);
	ajaxObj.requestData();
}

function doSelect() {
	switch (flag) {
	case 0:
		var ppv = programInfo[1];
		window.location = ppv[0].ppvUrl;
		break;
	case 2:
		window.location = programInfo[2][0].svodUrl;
		break;
	case 3:
		window.location = programInfo[2][1].svodUrl;
		break;
	case 1:
		// window.location.href= "HD_vodDetail.jsp?PROGID=" + progID +
		// "&PREFOUCS=0,0,0,0,0";
		window.location.href = backUrl;
		break;
	}
}

function setWebkitTransform(object, value) {
	object.style.backgroundImage = "url(images/pay/" + value + ")";
}

function keyRight() {
	switch (flag) {
	case 0:
		setWebkitTransform($("buy"), "buy.png");
		setWebkitTransform($("return"), "return_focus.png");
		flag = 1;
		break;
	case 1:
		setWebkitTransform($("return"), "return.png");
		setWebkitTransform($("recommend_buy"), "recommend_buy_focus.png");
		flag = 2;
		break;
	}
}

function keyLeft() {

	switch (flag) {
	case 3:
		setWebkitTransform($("popularity_buy"), "recommend_buy.png");
		setWebkitTransform($("return"), "return_focus.png");
		flag = 1;
		break;
	case 2:
		setWebkitTransform($("recommend_buy"), "recommend_buy.png");
		setWebkitTransform($("return"), "return_focus.png");
		flag = 1;
		break;
	case 1:
		setWebkitTransform($("return"), "return.png");
		setWebkitTransform($("buy"), "buy_focus.png");
		flag = 0;
		break;
	}
}

function keyDown() {
	switch (flag) {
	case 2:
		setWebkitTransform($("recommend_buy"), "recommend_buy.png");
		setWebkitTransform($("popularity_buy"), "recommend_buy_focus.png");
		flag = 3;
		break;
	}
}

function keyUp() {
	switch (flag) {
	case 3:
		setWebkitTransform($("popularity_buy"), "recommend_buy.png");
		setWebkitTransform($("recommend_buy"), "recommend_buy_focus.png");
		flag = 2;
		break;
	}
}

function eventHandler(obj) {
	switch (obj.code) {
	case "KEY_BACK":
		// window.location.href = "HD_vodDetail.jsp?PROGID=" + progID +
		// "&PREFOUCS=0,0,0,0,0";
		window.location.href = backUrl;
		break;
	case "KEY_EXIT":
		// window.location.href = "HD_vodDetail.jsp?PROGID=" + progID +
		// "&PREFOUCS=0,0,0,0,0";
		window.location.href = backUrl;
		break;
	}

	if (flag == 0) {
		switch (obj.code) {
		case "KEY_SELECT":
			doSelect();
			break;
		case "KEY_RIGHT":
			keyRight();
			break;
		}
	} else if (flag == 1) {
		switch (obj.code) {
		case "KEY_SELECT":
			doSelect();
			break;
		case "KEY_RIGHT":
			if (length >= 1)
				keyRight();
			break;
		case "KEY_LEFT":
			if (!urlFlag)
				keyLeft();
			break;
		}
	} else if (flag == 2) {
		switch (obj.code) {
		case "KEY_SELECT":
			doSelect();
			break;
		case "KEY_DOWN":
			if (length == 2)
				keyDown();
			break;
		case "KEY_LEFT":
			keyLeft();
			break;
		}
	} else if (flag == 3) {
		switch (obj.code) {
		case "KEY_SELECT":
			doSelect();
			break;
		case "KEY_UP":
			keyUp();
			break;
		case "KEY_LEFT":
			keyLeft();
			break;
		}
	}
}