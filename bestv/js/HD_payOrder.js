var flag = 0;
var webkit = 1.3;

function init() {
	var params = window.location.search.substring(1).split("=");
	flag = params[1];
}

function setWebkitTransform(object, value) {
	object.style.backgroundImage = "url(images/pay/" + value + ")";
}

function eventHandler(obj) {
	if (flag == 0) {
		switch (obj.code) {
		case "KEY_SELECT":
			window.location = backUrl;
			break;
		case "KEY_RIGHT":
			setWebkitTransform($("affirmance"), "buy.png");
			setWebkitTransform($("return"), "return_focus.png");
			flag = 1;
			break;
		case "KEY_BACK":
			window.location = backUrl;
		}
	} else if (flag == 1) {
		switch (obj.code) {
		case "KEY_SELECT":
			window.location = backUrl;
			break;
		case "KEY_LEFT":
			setWebkitTransform($("return"), "return.png");
			setWebkitTransform($("affirmance"), "buy_focus.png");
			flag = 0;
			break;
		}
	}
}