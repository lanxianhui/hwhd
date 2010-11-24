function turnByLine(inputDiv, info, focusColor, focusDuration) {
	this.inputDiv = typeof (inputDiv) == "object" ? inputDiv : $(inputDiv);
	this.focus = $(inputDiv + "focus");

	var keyFlag = true;
	var info_size;
	var info_start;
	var info_end;

	var div_size;
	var div_start;
	var div_end;
	var div_position;
	var div_maxShow;

	var blurColor;
	var focusTopInit;
	var focusHeight;

	this.init = function() {
		div_size = 0;
		div_start = 0;
		while (typeof ($(inputDiv + div_size)) != "undefined") {
			div_size++;
		}
		div_maxShow = div_size - 2;
		div_end = (div_start + div_maxShow) % div_size;
		info_size = info.length;
		info_start = 0;
		info_end = Math.min(div_maxShow, info_size);
		div_position = 0;
		blurColor = $(inputDiv + "0").style.color;
		for ( var i = 0; i < div_maxShow; i++) {
			if ((info_start + i) > (info_size - 1)) {
				$(inputDiv + (div_start + i) % div_size).innerText = "";
				continue;
			}
			$(inputDiv + (div_start + i) % div_size).innerText = info[info_start
					+ i].NAME;
		}
		focusTopInit = this.focus.style.top;
		focusHeight = $(inputDiv + "1").style.top - $(inputDiv + "0").style.top;
	}
	this.leaveArea = function() {
		this.focus.style.opacity = 0;
		$(inputDiv + (div_start + div_position) % div_size).style.color = blurColor;
	}
	this.toArea = function() {
		this.focus.style.opacity = 1;
		this.focus.style.webkitTransitionDuration = "0ms";
		this.focus.style.top = focusTopInit + focusHeight * div_position;
		this.focus.style.webkitTransitionDuration = focusDuration;
		$(inputDiv + (div_start + div_position) % div_size).style.color = focusColor;
	}
	this.move = function(from, to) {// 上下移
		$(inputDiv + (div_start + from) % div_size).style.color = blurColor;
		setTimeout(function() {
			$(inputDiv + (div_start + to) % div_size).style.color = focusColor;
		}, 250);
		this.focus.style.webkitTransitionDuration = focusDuration;
		this.focus.style.top = focusTopInit + focusHeight * to;
	}
	this.turn = function(num) {// 翻动，一行
		for ( var i = 0; i < div_size; i++) {
			$(inputDiv + i).style.webkitTransitionDuration = focusDuration;
		}
		if (num > 0) {
			div_start = (div_start - 1 + div_size) % div_size;
			info_start--;
			info_end--;
			$(inputDiv + (div_start + 1) % div_size).style.color = blurColor;
			$(inputDiv + div_start).style.color = focusColor;
			$(inputDiv + div_start).innerText = info[info_start].NAME;
			$(inputDiv + (div_start - 1 + div_size) % div_size).innerText = "";
			for ( var i = 0; i < (div_size - 1); i++) {
				$(inputDiv + (div_start + i) % div_size).style.top = $(inputDiv
						+ (div_start + i + 1) % div_size).style.top;
			}
			$(inputDiv + (div_start - 1) % div_size).style.top = -100;
		}
		if (num < 0) {
			div_start = (div_start + 1) % div_size;
			info_start++;
			info_end++;
			$(inputDiv + (div_start + div_maxShow - 2) % div_size).style.color = blurColor;
			$(inputDiv + (div_start + div_maxShow - 1) % div_size).style.color = focusColor;
			$(inputDiv + (div_start + div_maxShow - 1) % div_size).innerText = info[info_end - 1].NAME;
			$(inputDiv + (div_start - 1 + div_size) % div_size).innerText = "";
			for ( var i = 0; i < (div_size - 1); i++) {
				$(inputDiv + (div_start + div_maxShow - 1 - i + div_size)
						% div_size).style.top = $(inputDiv
						+ (div_start + div_maxShow - 1 - i - 1 + div_size)
						% div_size).style.top;
			}
			$(inputDiv + (div_start - 1 + div_size) % div_size).style.top = 685;
		}
	}
	this.upDownShow = function() {
	}// 上下页箭头
	this.changeFocus = function(num) {// 上下键总逻辑控制
		if (keyFlag) {
			keyFlag = false;
			setTimeout(function() {
				keyFlag = true;
			}, 300);
			if (num > 0) {
				div_position--;
				if (div_position < 0) {
					div_position = 0;
					if (info_start != 0) {
						this.turn(1);
					}
					// this.upDownShow();
					return;
				}
			}
			if (num < 0) {
				div_position++;
				if (div_position > Math.min((div_size - 3), (info_size - 1))) {
					div_position = Math.min((div_size - 3), (info_size - 1));
					if (info_end < info_size) {
						this.turn(-1);
					}
					// this.upDownShow();
					return;
				}
			}
			this.move(div_position + num, div_position);
		}
		// this.upDownShow();
	}
	// this.returnUrl = function(){}

	this.init();
}