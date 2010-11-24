var flag = 0;
var webkit = 1.3;
var goUrl = '';

function setWebkitTransform(object, value) {
	object.style.backgroundImage = "url(images/pay/" + value + ")";
}

function init() {

	var params = window.location.search.substring(1).split("&");
	var temp = window.location.search.substring(1).split("url=");

	goUrl = temp[1];
	for ( var i = 0; i < params.length; i++) {
		if (params[i].indexOf("prodName") > -1)
			$("program_name").innerText = params[i].split("=")[1].slice(0, 20);
		if (params[i].indexOf("prodPrice") > -1)
			$("money_name").innerText = params[i].split("=")[1] + "元";
		if (params[i].indexOf("prodEndTime") > -1)
			$("validate_name").innerText = params[i].split("=")[1];
		if (params[i].indexOf("prodDesc") > -1)
			$("introduce").innerText = params[i].split("=")[1].slice(0, 50);
	}
}

function eventHandler(obj) {
	if (flag == 0) {
		switch (obj.code) {
		case "KEY_SELECT":
			window.location.href = goUrl;
			break;
		case "KEY_EXIT":
		case "KEY_BACK":
			window.location = backUrl;
			break;
		case "KEY_RIGHT":
			setWebkitTransform($("affirmance"), "affirmance.png");
			setWebkitTransform($("return"), "return_focus.png");
			flag = 1;
			break;
		}
	} else if (flag == 1) {
		switch (obj.code) {
		case "KEY_SELECT":
			window.location = backUrl;
		case "KEY_EXIT":
		case "KEY_BACK":
			window.location = backUrl;
			break;
		case "KEY_LEFT":
			setWebkitTransform($("return"), "return.png");
			setWebkitTransform($("affirmance"), "affirmance_focus.png");
			flag = 0;
			break;
		}
	}
}