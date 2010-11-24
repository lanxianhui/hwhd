var PPROGRAM = 0, PNAME = 1, PSEARCH = 2, PTEXT = 3;
var singleCategoryTypeId;
var shown;
var colShown;
var subcolShown;
var returnAreaFlag;
var areaFlag;
var searchFlag = 7; // 1:按导演名搜索 2:按演员名搜索 7:按节目名搜索
var columnOrVod = 0;// 0:column 1:vod
var position;
var keyFlag = true; // 按键保护
var dialogState = "close"; // close readyClose open

var t;
var perNum = 0;
var dialogList = [];
var columnList = [];
var columnOne = [];
var columnTwo = [];
var columnThree = [];
var columnPos = 0; // 单天节目单数组指针的初始位置
var columnSize; // 数组的大小
var showColumnSize; // 需要展示的节目条数
var startCPos = 0; // 记div开始的位置
var endCPos; // 记div结束的位置
var maxC = 12; // div总个数

var subcolumnPos = 0;
var subcolumnSize;
var showSubcolumnSize;
var startSubCPos = 0; // 记div开始的位置
var endSubCPos; // 记div结束的位置
var maxSubC = 7; // div总个数
var upSub = 0;
var downSub = 0;
var inputObj;
var initFlag = true; // 初始化保护按键

var totalPage;
var nowPage;
var subtotalPage;
var subnowPage;
function eventHandler(obj) {
	if (!initFlag) {
		switch (obj.code) {
		case "KEY_NUMERIC":
			// if(areaFlag==1&&position==PTEXT){ inputObj.inputNum(obj.value);}
			if (areaFlag == 1 || areaFlag == 2)
				inputObj.inputNum(obj.value)
			break;
		case "KEY_#":
			if (areaFlag == 1 && position == PTEXT) {
				inputObj.changeType();
			}
			break;
		case "KEY_RIGHT":
			if (areaFlag == 0) {
				changeColFocusLR(1);
			} else if (areaFlag == 1) {
				focusControl("right");
			} else if (areaFlag == 2) {
				changeKeyFocusLR(1);
			} else if (areaFlag == 3 && dialogState == "open") {
				leaveSubcol();
			}
			break;
		case "KEY_LEFT":
			if (areaFlag == 0) {
				changeColFocusLR(-1);
			} else if (areaFlag == 1) {
				focusControl("left");
			} else if (areaFlag == 2) {
				changeKeyFocusLR(-1);
			} else if (areaFlag == 3 && dialogState == "readyClose"
					&& subcolumnSize != 0) {
				focusSubcol();
			}
			break;
		case "KEY_UP":
			if (areaFlag == 0) {
				changeColFocusUD(1);
			} else if (areaFlag == 1) {
				focusControl("up");
			} else if (areaFlag == 2) {
				changeKeyFocusUD(1);
			} else if (areaFlag == 3 && dialogState == "open") {
				changeSubcolFocusUD(1);
			}
			break;
		case "KEY_DOWN":
			if (areaFlag == 0) {
				changeColFocusUD(-1);
			} else if (areaFlag == 1) {
				focusControl("down");
			} else if (areaFlag == 2) {
				changeKeyFocusUD(-1);
			} else if (areaFlag == 3 && dialogState == "open") {
				changeSubcolFocusUD(-1);
			}
			break;
		case "KEY_PAGE_UP":
			if (areaFlag == 0) {
				turnPage(1);
			} else if (areaFlag == 3) {
				trunSubPage(1);
			}
			break;
		case "KEY_PAGE_DOWN":
			if (areaFlag == 0) {
				turnPage(-1);
			} else if (areaFlag == 3) {
				trunSubPage(-1);
			}
			break;
		case "KEY_SELECT":
			if (areaFlag == 0) {
				subnowPage = 1;
				subcolShown = 0;
				showSubcol();
			} else if (areaFlag == 1 && position == PSEARCH) {
				showSearchResult(searchFlag, inputObj.getKeyword());
			} else if (areaFlag == 2) {
				typeKeyword(shown);
			} else if (areaFlag == 3) {
				if (dialogState == "readyClose") {
					hiddenDialog();
				} else if (dialogState == "open") {
					var toUrl = "";
					if (columnOrVod == 0) {
						toUrl = "HD_vodSingleCategory.jsp?TYPE_ID="
								+ dialogList[0].VALUE[subcolShown].CATEGORYID;
					} else {
						toUrl = "HD_vodDetail.jsp?PROGID="
								+ dialogList[subcolShown].vodId + "&TYPE_ID=-1";// 单部vod
					}
					document.location = "HD_saveCurrFocus.jsp?currFocus="
							+ areaFlag + "," + shown + "," + colShown + ","
							+ nowPage + "," + columnOrVod + "," + subcolShown
							+ "," + subnowPage + "," + returnAreaFlag + ","
							+ searchFlag + "," + columnOrVod + ","
							+ inputObj.getKeyword() + "&url=" + toUrl;
				}
			}
			break;
		case "KEY_EXIT":
		case "KEY_BACK":
			if (areaFlag == 1 && position == PTEXT) {
				deleteChar();
			} else if (areaFlag == 3) {
				leaveSubcol();
			} else {
				document.location = backUrl;
			}
			break;
		}
		return 0;
	}
}

var temp = 1;

// 响应删除输入框字符操作
function deleteChar() {
	if (temp < 2) {
		if (inputObj.getIsChineseChoose() || inputObj.getIsPinYinChoose()) {
			inputObj.deletePY();
		} else {
			inputObj.finishFocusDelete();
		}
		temp += 1;
	} else {
		temp = 1;
	}
}
/** ***********************处理0区的代码******************************* */
function moveFocus(num) {
	$("focus").style.left = 15 + num % 3 * 275;
	$("focus").style.top = 55 + Math.floor(num / 3) * 60;
}

// 左区展示栏赋值
function oneLineInfo(num) {
	var realLength = 0;
	var lineInfo = "";
	if (typeof (columnOne[num]) == "string") {
		lineInfo = columnOne[num];
		return lineInfo;
	} else {
		lineInfo = columnOne[num].CATEGORYFULLNAME.slice(0, 6);
		realLength = columnOne[num].CATEGORYFULLNAME.length;
		if (realLength > 6)
			realLength = 6;
	}

	if (typeof (columnTwo[num]) == "string") {
		return lineInfo;
	} else {
		var space = "";
		for ( var t = 0; t < (28 - 3 * realLength); t++) {
			space += " ";
		}
		lineInfo = lineInfo + space;
		lineInfo = lineInfo + columnTwo[num].CATEGORYFULLNAME.slice(0, 6);
		realLength = 10 + columnTwo[num].CATEGORYFULLNAME.length;
		if (realLength > 16)
			realLength = 16;
	}
	if (typeof (columnThree[num]) == "string") {
		return lineInfo;
	} else {
		var space = "";
		for ( var t = 0; t < (55 - 3 * realLength); t++) {
			space += " ";
		}
		lineInfo = lineInfo + space;
		lineInfo = lineInfo + columnThree[num].CATEGORYFULLNAME.slice(0, 6);
	}
	return lineInfo;
}

function changeColShow(num) {
	var temTop, tempFontSize, tempOpacity;
	if (num < 0) {// down
		var indexI = (endCPos + 1 + maxC) % maxC;
		temTop = $("l" + indexI).style.top;
		tempOpacity = $("l" + indexI).style.opacity;
		if ((columnPos + showColumnSize) < columnSize) {
			$("l" + indexI).innerText = oneLineInfo(columnPos + showColumnSize);
			if (typeof (columnOne[columnPos + showColumnSize]) == "string") {
				$("l" + indexI).style.fontWeight = "bold";
				$("l" + indexI).style.fontSize = "30px";
				$("l" + indexI).style.color = "#F6FF00";
			} else {
				$("l" + indexI).style.fontWeight = "normal";
				$("l" + indexI).style.fontSize = "30px";
				$("l" + indexI).style.color = "#FFFFFF";
			}
		} else {
			$("down").src = "images/search/down1.png";
			$("l" + indexI).innerText = "";
		}
		$("up").src = "images/search/up.png";
		$("l" + indexI).style.opacity = 1;
		for ( var i = 0; i < 11; i++) {
			var indexB = (endCPos + 1 - i + maxC) % maxC;
			var indexF = (endCPos - i + maxC) % maxC;
			$("l" + indexB).style.fontWeight = $("l" + indexF).style.fontWeight;
			$("l" + indexB).style.top = $("l" + indexF).style.top;
		}
		$("l" + (endCPos - 10 + maxC) % maxC).innerText = "";
		$("l" + (endCPos - 9 + maxC) % maxC).innerText = "";
		$("l" + (endCPos - 10 + maxC) % maxC).style.webkitTransitionDuration = "0ms";
		$("l" + (endCPos - 10 + maxC) % maxC).style.top = temTop;
		$("l" + (endCPos - 10 + maxC) % maxC).style.webkitTransitionDuration = "200ms";
		$("l" + (endCPos - 10 + maxC) % maxC).style.opacity = tempOpacity;
		$("l" + (endCPos - 9 + maxC) % maxC).style.opacity = tempOpacity;
		startCPos = (startCPos + 1 + maxC) % maxC;
		endCPos = (endCPos + 1 + maxC) % maxC;
		columnPos = columnPos + 1;
		num++;
		if (num < 0) {
			changeColShow(num);
		}
	} else {
		var indexI = (startCPos - 1 + maxC) % maxC;
		tempOpacity = $("l" + indexI).style.opacity;
		temTop = $("l" + indexI).style.top;
		$("l" + indexI).innerText = oneLineInfo(columnPos - 1);
		if (typeof (columnOne[columnPos - 1]) == "string") {
			$("l" + indexI).style.fontWeight = "bold";
			$("l" + indexI).style.fontSize = "30px";
			$("l" + indexI).style.color = "#F6FF00";
		} else {
			$("l" + indexI).style.fontWeight = "normal";
			$("l" + indexI).style.fontSize = "30px";
			$("l" + indexI).style.color = "#FFFFFF";
		}
		if ((columnPos + showColumnSize) < columnSize) {
			$("down").src = "images/search/down.png";
		}
		if (columnPos == 1) {
			$("up").src = "images/search/up1.png";
		}
		$("l" + indexI).style.opacity = 1;
		for ( var i = 0; i < 11; i++) {
			var indexB = (startCPos + i + maxC) % maxC;
			var indexF = (startCPos - 1 + i + maxC) % maxC;
			$("l" + indexF).style.top = $("l" + indexB).style.top;
		}
		$("l" + (startCPos + 10 + maxC) % maxC).innerText = "";
		$("l" + (startCPos + 9 + maxC) % maxC).innerText = "";
		$("l" + (startCPos + 10 + maxC) % maxC).style.opacity = tempOpacity;
		$("l" + (startCPos + 9 + maxC) % maxC).style.opacity = tempOpacity;
		$("l" + (startCPos + 10 + maxC) % maxC).style.top = temTop;
		startCPos = (startCPos - 1 + maxC) % maxC;
		endCPos = (endCPos - 1 + maxC) % maxC;
		columnPos = columnPos - 1;
		num--;
		if (num > 0) {
			changeColShow(num);
		}
	}
}

// 响应左侧上下翻页按钮
function turnPage(num) {
	if (num < 0 && (columnPos + 10) < columnSize) {
		changeColShow(-10);
		nowPage++;
	} else if (num > 0 && columnPos > 0) {
		changeColShow(10);
		nowPage--;
	}
	colShown = 0;
	$("page").innerText = nowPage + "/" + totalPage;
	if (typeof (columnOne[columnPos]) == "string") {
		colShown = 3;
	}
	moveFocus(colShown);
}

// 响应左侧左右移动按钮
function changeColFocusLR(num) {
	if (num < 0 && colShown % 3 == 0) {
		return;
	}
	if (num > 0) {
		var isToArea2 = false;
		if (colShown % 3 == 2) {
			isToArea2 = true;
		} else if (colShown % 3 == 1) {
			if (typeof (columnThree[columnPos + Math.floor(colShown / 3)]) == "string") {
				isToArea2 = true;
			}
		} else {
			if (typeof (columnTwo[columnPos + Math.floor(colShown / 3)]) == "string") {
				isToArea2 = true;
			}
		}
		if (isToArea2) {
			areaFlag = 2;
			$("focus").style.opacity = 0;
			inFocus(shown);
			return;
		}
	}
	colShown = colShown + num;
	moveFocus(colShown);
}

// 光标停留在左侧导航专区，响应上下移动按钮
function changeColFocusUD(num) {
	if (keyFlag) {
		keyFlag = false;
		setTimeout("keyFlag = true;", 100);
		if (num > 0) {
			if (colShown < 6) {
				if (typeof (columnOne[columnPos]) == "string" || colShown < 3) {
					turnPage(num);
					return;
				}
			}
			var isUp = true;
			if (typeof (columnOne[columnPos + Math.floor(colShown / 3) - 1]) == "string") {
				isUp = false;
			}
			if (isUp) {
				if (colShown % 3 == 0) {
					colShown = colShown - num * 3;
				} else if (colShown % 3 == 1) {
					if (typeof (columnTwo[columnPos + Math.floor(colShown / 3)
							- 1]) == "string") {
						colShown = colShown - num * 3 - 1;
					} else {
						colShown = colShown - num * 3;
					}
				} else if (colShown % 3 == 2) {
					if (typeof (columnThree[columnPos
							+ Math.floor(colShown / 3) - 1]) == "string") {
						if (typeof (columnTwo[columnPos
								+ Math.floor(colShown / 3) - 1]) == "string") {
							colShown = colShown - num * 3 - 2;
						} else {
							colShown = colShown - num * 3 - 1;
						}
					} else {
						colShown = colShown - num * 3;
					}
				}
			} else {
				if (colShown % 3 == 0) {
					colShown = colShown - num * 3 * 2;
				} else if (colShown % 3 == 1) {
					if (typeof (columnTwo[columnPos + Math.floor(colShown / 3)
							- 2]) == "string") {
						colShown = colShown - num * 3 * 2 - 1;
					} else {
						colShown = colShown - num * 3 * 2;
					}
				} else if (colShown % 3 == 2) {
					if (typeof (columnThree[columnPos
							+ Math.floor(colShown / 3) - 2]) == "string") {
						if (typeof (columnTwo[columnPos
								+ Math.floor(colShown / 3) - 2]) == "string") {
							colShown = colShown - num * 3 * 2 - 2;
						} else {
							colShown = colShown - num * 3 * 2 - 1;
						}
					} else {
						colShown = colShown - num * 3 * 2;
					}
				}
			}
		}
		if (num < 0) {
			if ((columnPos + Math.floor(colShown / 3) + 1) >= columnSize) {
				return;
			}
			if (colShown > 23) {
				if (typeof (columnOne[columnPos + 11]) == "string"
						|| colShown > 26) {
					turnPage(num);
					return;
				}
			}
			var isDown = true;
			if (typeof (columnOne[columnPos + Math.floor(colShown / 3) + 1]) == "string") {
				isDown = false;
			}
			if (isDown) {
				if (colShown % 3 == 0) {
					colShown = colShown - num * 3;
				} else if (colShown % 3 == 1) {
					if (typeof (columnTwo[columnPos + Math.floor(colShown / 3)
							+ 1]) == "string") {
						colShown = colShown - num * 3 - 1;
					} else {
						colShown = colShown - num * 3;
					}
				} else if (colShown % 3 == 2) {
					if (typeof (columnThree[columnPos
							+ Math.floor(colShown / 3) + 1]) == "string") {
						if (typeof (columnTwo[columnPos
								+ Math.floor(colShown / 3) + 1]) == "string") {
							colShown = colShown - num * 3 - 2;
						} else {
							colShown = colShown - num * 3 - 1;
						}
					} else {
						colShown = colShown - num * 3;
					}
				}
			} else {
				if (colShown % 3 == 0) {
					colShown = colShown - num * 3 * 2;
				} else if (colShown % 3 == 1) {
					if (typeof (columnTwo[columnPos + Math.floor(colShown / 3)
							+ 2]) == "string") {
						colShown = colShown - num * 3 * 2 - 1;
					} else {
						colShown = colShown - num * 3 * 2;
					}
				} else if (colShown % 3 == 2) {
					if (typeof (columnThree[columnPos
							+ Math.floor(colShown / 3) + 2]) == "string") {
						if (typeof (columnTwo[columnPos
								+ Math.floor(colShown / 3) + 2]) == "string") {
							colShown = colShown - num * 3 * 2 - 2;
						} else {
							colShown = colShown - num * 3 * 2 - 1;
						}
					} else {
						colShown = colShown - num * 3 * 2;
					}
				}
			}
		}
		moveFocus(colShown);
	}
}

// 初始化首页面显示数据
function initColInfo() {
	var j = 0, k = 0;
	var colNum = columnList.length - 1;
	var line = parseInt(columnList[colNum].LINENUM);
	var isFather = true;
	var childNum = columnList[j].CHILDINFO.length;
	for ( var i = 0; i < line; i++) {
		if (isFather) {
			columnOne[i] = typeof (columnList[j].CATEGORYFULLNAME) == "undefined" ? ""
					: columnList[j].CATEGORYFULLNAME.slice(0, 10);
			columnTwo[i] = "";
			columnThree[i] = "";
			isFather = false;
		} else {
			columnOne[i] = columnList[j].CHILDINFO[k];
			k++;
			if (k >= childNum) {
				j++;
				k = 0;
				isFather = true;
				childNum = columnList[j].CHILDINFO.length;
				columnTwo[i] = "";
				columnThree[i] = "";
				continue;
			}
			columnTwo[i] = columnList[j].CHILDINFO[k];
			k++;
			if (k >= childNum) {
				j++;
				k = 0;
				isFather = true;
				childNum = columnList[j].CHILDINFO.length;
				columnThree[i] = "";
				continue;
			}
			columnThree[i] = columnList[j].CHILDINFO[k];
			k++;
			if (k >= childNum) {
				j++;
				k = 0;
				isFather = true;
				childNum = columnList[j].CHILDINFO.length;
				continue;
			}
		}
	}
	columnSize = line;
	showColumnSize = Math.min(10, columnSize);
	endCPos = startCPos + showColumnSize - 1;
	if (columnSize > 10) {
		$("down").src = "images/search/down.png";
		down = 1;
	}
	var oneLine = "";
	columnPos = (nowPage - 1) * 10;
	for ( var l = columnPos; l < (columnPos + 10); l++) {
		if (line < (l + 1)) {
			$("l" + (l - columnPos)).innerText = "";
			continue;
		}
		var realLength = 0;
		if (typeof (columnOne[l]) == "string") {
			$("l" + (l - columnPos)).innerText = columnOne[l];
			$("l" + (l - columnPos)).style.fontSize = "30px";
			$("l" + (l - columnPos)).style.fontWeight = "bold";
			$("l" + (l - columnPos)).style.color = "F6FF00";
			continue;
		} else {
			oneLine = (typeof (columnOne[l].CATEGORYFULLNAME) == "undefined" ? ""
					: columnOne[l].CATEGORYFULLNAME.slice(0, 6));
			realLength = columnOne[l].CATEGORYFULLNAME.length;
			if (realLength > 6)
				realLength = 6;
		}
		if (typeof (columnTwo[l]) == "string") {
			$("l" + (l - columnPos)).innerText = oneLine;
			continue;
		} else {
			var space = "";
			for ( var t = 0; t < (28 - 3 * realLength); t++) {
				space += "&nbsp;";
			}
			oneLine = oneLine + space;
			oneLine = oneLine
					+ (typeof (columnTwo[l].CATEGORYFULLNAME) == "undefined" ? ""
							: columnTwo[l].CATEGORYFULLNAME.slice(0, 6));
			realLength = 10 + columnTwo[l].CATEGORYFULLNAME.length;
			if (realLength > 16)
				realLength = 16;
		}
		if (typeof (columnThree[l]) == "string") {
			$("l" + (l - columnPos)).innerText = oneLine;
			continue;
		} else {
			var space = "";
			for ( var t = 0; t < (55 - 3 * realLength); t++) {
				space += " ";
			}
			oneLine = oneLine + space;
			oneLine = oneLine
					+ (typeof (columnThree[l].CATEGORYFULLNAME) == "undefined" ? ""
							: columnThree[l].CATEGORYFULLNAME.slice(0, 6));
		}
		$("l" + (l - columnPos)).innerText = oneLine;
	}
	totalPage = Math.floor(line / 10);
	if (line % 10 != 0) {
		totalPage++;
	}
	$("page").innerText = nowPage + "/" + totalPage;
}

/** ******************处理1区的代码************************* */
function leaveProgram(actionType) {
	if (actionType == "left" || actionType == "down") {
		$("program").style.backgroundImage = "url(images/search/btn_choose.png)";
	} else if (actionType == "right" || actionType == "up") {
		$("program").style.backgroundImage = "";
		$("program").style.color = "#FFFFFF";
	}
}
function focusProgram() {
	$("program").style.backgroundImage = "url(images/search/btn_focus.png)";
	searchFlag = 7;
	position = PPROGRAM;
	$("program").style.color = "#333333";
}
function leaveName(actionType) {
	if (actionType == "left" || actionType == "up") {
		$("name").style.backgroundImage = "";
		$("name").style.color = "#FFFFFF";
	} else if (actionType == "down") {
		$("name").style.backgroundImage = "url(images/search/btn_choose.png)";
	}
}
function focusName() {
	$("name").style.backgroundImage = "url(images/search/btn_focus.png)";
	searchFlag = 2;
	position = PNAME;
	$("name").style.color = "#333333";
}
function leaveText() {
	inputObj.hiddenFocus();
	$("textImg").style.backgroundImage = "";
}
function focusText() {
	inputObj.showFocus(0);
	$("textImg").style.backgroundImage = "url(images/search/textFocus.png)";
	position = PTEXT;
}
function leaveSearch() {
	$("btn").src = "images/search/btn_S.png";
}
function focusSearch() {
	$("btn").src = "images/search/btn_SFocus.png";
	position = PSEARCH;
}

function focusControl(actionType) {
	switch (actionType) {
	case "right":
		if (position == PPROGRAM) {
			leaveProgram("right");
			focusName();
		} else if (position == PTEXT) {
			if (inputObj.getIsPinYinChoose()) {
				inputObj.setIsChineseChoose(true);
				inputObj.showWords();
			} else if (inputObj.getIsChineseChoose()) {
				inputObj.nextWords();
			} else {
				if (!inputObj.moveLeftRight(1)) {
					leaveText();
					focusSearch();
				}
			}
		}
		break;
	case "left":

		if (position == PNAME) {
			leaveName("left");
			focusProgram();
		} else if (position == PPROGRAM) {
			areaFlag = 0;
			$("focus").style.opacity = 1;
			leaveProgram("left");
		} else if (position == PSEARCH) {
			leaveSearch();
			focusText();
		} else if (position == PTEXT) {
			if (inputObj.getIsChineseChoose()) {
				inputObj.preWords();
			} else if (inputObj.getIsPinYinChoose()) {
			} else {
				inputObj.moveLeftRight(-1);
			}
		}
		break;
	case "up":
		if (position == PSEARCH) {
			leaveSearch();
			if ("" == $("name").style.backgroundImage) {
				leaveName("up");
				focusProgram();
			} else {
				leaveProgram("up");
				focusName();
			}
		} else if (position == PTEXT) {
			leaveText();
			if ("" == $("name").style.backgroundImage) {
				leaveName("up");
				focusProgram();
			} else {
				leaveProgram("up");
				focusName();
			}
		}
		break;
	case "down":
		if (position == PPROGRAM) {
			leaveProgram("down");
			focusText();
		} else if (position == PNAME) {
			leaveName("down");
			focusText();
		} else if (position == PSEARCH) {
			areaFlag = 2;
			leaveSearch();
			inFocus(shown);
		} else if (position == PTEXT) {
			areaFlag = 2;
			leaveText();
			inFocus(shown);
		}
		break;
	}
}
/** ***********************软键盘****************************** */
function typeKeyword(key) {
	if (keyFlag) {
		keyFlag = false;
		switch (key) {
		case 0:
			inputObj.finishOnceInput("A");
			break;
		case 1:
			inputObj.finishOnceInput("B");
			break;
		case 2:
			inputObj.finishOnceInput("C");
			break;
		case 4: // 删除
			inputObj.finishDelete();
			break;
		case 5:
			inputObj.finishOnceInput("D");
			break;
		case 6:
			inputObj.finishOnceInput("E");
			break;
		case 7:
			inputObj.finishOnceInput("F");
			break;
		case 9:
			inputObj.finishOnceInput(" ");
			break;
		case 10:
			inputObj.finishOnceInput("G");
			break;
		case 11:
			inputObj.finishOnceInput("H");
			break;
		case 12:
			inputObj.finishOnceInput("I");
			break;
		case 13:
			inputObj.finishOnceInput("J");
			break;
		case 14:
			inputObj.finishOnceInput("K");
			break;
		case 15:
			inputObj.finishOnceInput("L");
			break;
		case 16:
			inputObj.finishOnceInput("M");
			break;
		case 17:
			inputObj.finishOnceInput("N");
			break;
		case 18:
			inputObj.finishOnceInput("O");
			break;
		case 19:
			inputObj.finishOnceInput("P");
			break;
		case 20:
			inputObj.finishOnceInput("Q");
			break;
		case 21:
			inputObj.finishOnceInput("R");
			break;
		case 22:
			inputObj.finishOnceInput("S");
			break;
		case 23:
			inputObj.finishOnceInput("T");
			break;
		case 24:
			inputObj.finishOnceInput("U");
			break;
		case 25:
			inputObj.finishOnceInput("V");
			break;
		case 26:
			inputObj.finishOnceInput("W");
			break;
		case 27:
			inputObj.finishOnceInput("X");
			break;
		case 28:
			inputObj.finishOnceInput("Y");
			break;
		case 29:
			inputObj.finishOnceInput("Z");
			break;
		}
		inputObj.showText();
		setTimeout("keyFlag = true;", 400);
	}
}
/** ***********************处理2区的代码****************************** */
function circleNum() {
	perNum++;
	perNum = perNum % 10;
	$("k8").innerText = "" + perNum;
}
function leaveFocus(source) {
	if (source == 4 || source == 9) {
		$("k" + source).style.backgroundImage = "url(images/search/btn_space.png)";
		$("k" + source).style.width = 150;
	} else {
		$("k" + source).style.backgroundImage = "url(images/search/btn_key.png)";
		$("k" + source).style.width = 71;
	}

	$("k" + source).style.fontSize = 30;
	$("k" + source).style.height = 71;
	$("k" + source).style.top = $("k" + source).style.top + 19;
	$("k" + source).style.left = $("k" + source).style.left + 20;
	$("k" + source).style.color = "#333333";
	$("k" + source).style.lineHeight = "75px";
	$("k" + source).style.zIndex = "1";
}

// 响应软键盘光标
function inFocus(target) {
	if ((target == 4) || (target == 9)) {
		$("k" + target).style.backgroundImage = "url(images/search/btn_spaceFocus.png)";
		$("k" + target).style.width = 186;
		$("k" + target).style.height = 95;
	} else {
		$("k" + target).style.backgroundImage = "url(images/search/btn_keyFocus.png)";
		$("k" + target).style.width = 113;
		$("k" + target).style.height = 106;
	}

	$("k" + target).style.top = $("k" + target).style.top - 19;
	$("k" + target).style.left = $("k" + target).style.left - 20;
	$("k" + target).style.color = "#FFFFFF";
	$("k" + target).style.fontSize = "35px";
	$("k" + target).style.lineHeight = "105px";
	$("k" + target).style.zIndex = "2";
}

function changeFocus(source, target) {
	leaveFocus(source);
	inFocus(target);
	shown = target;
}

// 响应键盘左右移动按钮
function changeKeyFocusLR(num) {
	if (num > 0 && (shown % 5 == 4)) {
		return;
	}
	if (num < 0 && (shown % 5 == 0)) {
		areaFlag = 0;
		leaveFocus(shown);
		$("focus").style.opacity = 1;
		return;
	}
	if (num > 0 && shown == 2) {
		num++;
	}
	if (num > 0 && shown == 7) {
		num++;
	}

	if (num < 0 && shown == 4) {
		num--;
	}
	if (num < 0 && shown == 9) {
		num--;
	}

	changeFocus(shown, shown + num);
}
function changeKeyFocusUD(num) {
	var deta = 0;
	if (num < 0 && shown > 24) {
		return;
	}
	if (num > 0 && shown < 5) {
		areaFlag = 1;
		leaveFocus(shown);
		focusSearch();
		return;
	}
	if (num < 0 && shown == 8) {
		deta = 1;
	}
	if (num > 0 && shown == 18) {
		deta = 1;
	}
	changeFocus(shown, shown - num * 5 + deta);
}
/** *************************处理3区的代码******************************** */
function hiddenDialog() {
	// 隐藏搜索结果悬浮框
	$("dialog").style.opacity = 0;
	$("hidden").style.backgroundImage = "";
	$("close").style.opacity = 0;
	$("subFocus").style.opacity = 0;
	$("circleUp").style.opacity = 0;
	$("circleMiddle").style.opacity = 0;
	$("circleDown").style.opacity = 0;
	for ( var i = 0; i < 7; i++) {
		$("col" + i).style.opacity = 0;
	}
	dialogState = "close";
	areaFlag = returnAreaFlag;
	if (returnAreaFlag == 0) {
		$("focus").style.opacity = 1;
	} else {
		leaveText();
		focusSearch();
	}
}

function showSubcol() {
	if (colShown % 3 == 0) {
		$("DName").innerText = columnOne[columnPos + Math.floor(colShown / 3)].CATEGORYNAME;
		singleCategoryTypeId = columnOne[columnPos + Math.floor(colShown / 3)].CATEGORYID;
		reqSubcolInfo(columnOne[columnPos + Math.floor(colShown / 3)].CATEGORYURL);
	} else if (colShown % 3 == 1) {
		$("DName").innerText = columnTwo[columnPos + Math.floor(colShown / 3)].CATEGORYNAME;
		singleCategoryTypeId = columnTwo[columnPos + Math.floor(colShown / 3)].CATEGORYID;
		reqSubcolInfo(columnTwo[columnPos + Math.floor(colShown / 3)].CATEGORYURL);
	} else if (colShown % 3 == 2) {
		$("DName").innerText = columnThree[columnPos + Math.floor(colShown / 3)].CATEGORYNAME;
		singleCategoryTypeId = columnThree[columnPos + Math.floor(colShown / 3)].CATEGORYID;
		reqSubcolInfo(columnThree[columnPos + Math.floor(colShown / 3)].CATEGORYURL);
	}
}

function leaveSubcol() {
	$("subFocus").style.opacity = 0;
	$("close").style.backgroundImage = "url(images/search/close_focus.png)";
	dialogState = "readyClose";
}

function focusSubcol() {
	$("subFocus").style.opacity = 1;
	$("close").style.backgroundImage = "url(images/search/close.png)";
	dialogState = "open";
}

function moveSubcol(num) {
	$("subFocus").style.top = 65 + num * 70;
}

function positionShow() {
	$("circleUp").style.top = 101 + 286 / subtotalPage * (subnowPage - 1);
	$("circleMiddle").style.top = $("circleUp").style.top + 14;
	$("circleMiddle").style.height = Math.floor(286 / subtotalPage);
	$("circleDown").style.top = $("circleMiddle").style.top
			+ $("circleMiddle").style.height;
	$("subpage").innerText = subnowPage + "/" + subtotalPage + "页";
}

function turnSubcol(num) {
	var temTop, tempFontSize, tempOpacity;
	if (num < 0) {// down
		var indexI = (endSubCPos + 1 + maxSubC) % maxSubC;
		temTop = $("col" + indexI).style.top;
		tempOpacity = $("col" + indexI).style.opacity;
		if ((subcolumnPos + showSubcolumnSize) < subcolumnSize) {
			if (columnOrVod == 0) {
				$("col" + indexI).innerText = dialogList[0].VALUE[subcolumnPos
						+ showSubcolumnSize].CATEGORYNAME;
			} else {
				$("col" + indexI).innerText = dialogList[subcolumnPos
						+ showSubcolumnSize].vodName.slice(0, 16);
			}
		} else {
			$("col" + indexI).innerText = "";
		}
		$("col" + indexI).style.opacity = 1;
		for ( var i = 0; i < 6; i++) {
			var indexB = (endSubCPos + 1 - i + maxSubC) % maxSubC;
			var indexF = (endSubCPos - i + maxSubC) % maxSubC;
			$("col" + indexB).style.fontWeight = $("col" + indexF).style.fontWeight;
			$("col" + indexB).style.top = $("col" + indexF).style.top;
		}
		$("col" + (endSubCPos - 5 + maxSubC) % maxSubC).innerText = "";
		$("col" + (endSubCPos - 4 + maxSubC) % maxSubC).innerText = "";
		$("col" + (endSubCPos - 5 + maxSubC) % maxSubC).style.top = temTop;
		$("col" + (endSubCPos - 5 + maxSubC) % maxSubC).style.opacity = tempOpacity;
		$("col" + (endSubCPos - 4 + maxSubC) % maxSubC).style.opacity = tempOpacity;
		startSubCPos = (startSubCPos + 1 + maxSubC) % maxSubC;
		endSubCPos = (endSubCPos + 1 + maxSubC) % maxSubC;
		subcolumnPos = subcolumnPos + 1;
	} else {
		var indexI = (startSubCPos - 1 + maxSubC) % maxSubC;
		tempOpacity = $("col" + indexI).style.opacity;
		temTop = $("col" + indexI).style.top;
		if (subcolumnPos > 0) {
			if (columnOrVod == 0) {
				$("col" + indexI).innerText = dialogList[0].VALUE[subcolumnPos - 1].CATEGORYNAME;
			} else {
				$("col" + indexI).innerText = dialogList[subcolumnPos - 1].vodName
						.slice(0, 16);
			}
		} else {
			$("col" + indexI).innerText = "";
		}
		$("col" + indexI).style.opacity = 1;
		for ( var i = 0; i < 6; i++) {
			var indexB = (startSubCPos + i + maxSubC) % maxSubC;
			var indexF = (startSubCPos - 1 + i + maxSubC) % maxSubC;
			$("col" + indexF).style.top = $("col" + indexB).style.top;
		}
		$("col" + (startSubCPos + 5 + maxSubC) % maxSubC).innerText = "";
		$("col" + (startSubCPos + 4 + maxSubC) % maxSubC).innerText = "";
		$("col" + (startSubCPos + 5 + maxSubC) % maxSubC).style.opacity = tempOpacity;
		$("col" + (startSubCPos + 4 + maxSubC) % maxSubC).style.opacity = tempOpacity;
		$("col" + (startSubCPos + 5 + maxSubC) % maxSubC).style.top = temTop;
		startSubCPos = (startSubCPos - 1 + maxSubC) % maxSubC;
		endSubCPos = (endSubCPos - 1 + maxSubC) % maxSubC;
		subcolumnPos = subcolumnPos - 1;
	}
}

// 光标在搜索悬浮框响应上下翻页按键
function trunSubPage(num) {
	if (num > 0) {
		subcolumnPos -= 5;
		subnowPage--;
		if (subnowPage < 1) {
			subnowPage = subtotalPage;
			subcolumnPos = (subnowPage - 1) * 5;
		}
		for ( var i = 0; i < 5; i++) {
			if (columnOrVod == 0) {
				if (typeof (dialogList[0].VALUE[subcolumnPos + i]) == "undefined") {
					$("col" + i).innerText = "";
				} else {
					$("col" + i).innerText = dialogList[0].VALUE[subcolumnPos
							+ i].CATEGORYNAME;
				}
			} else {
				if (typeof (dialogList[subcolumnPos + i].vodName) == "undefined") {
					$("col" + i).innerText = "";
				} else {
					$("col" + i).innerText = dialogList[subcolumnPos + i].vodName
							.slice(0, 16);
				}
			}
		}
	}
	if (num < 0) {
		subcolumnPos += 5;
		subnowPage++;
		if (subnowPage > subtotalPage) {
			subnowPage = 1;
			subcolumnPos = 0;
		}
		subcolShown = 0;
		$("subFocus").style.webkitTransitionDuration = "0ms";
		$("subFocus").style.top = 65;
		$("subFocus").style.webkitTransitionDuration = "300ms";
		for ( var i = 0; i < 5; i++) {
			if ((subcolumnPos + i) > (subcolumnSize - 1)) {
				$("col" + i).innerText = "";
				continue;
			}
			if (columnOrVod == 0) {
				if (typeof (dialogList[0].VALUE[subcolumnPos + i]) == "undefined") {
					$("col" + i).innerText = "";
				} else {
					$("col" + i).innerText = dialogList[0].VALUE[subcolumnPos
							+ i].CATEGORYNAME;
				}
			} else {
				if (typeof (dialogList[subcolumnPos + i].vodName) == "undefined") {
					$("col" + i).innerText = "";
				} else {
					$("col" + i).innerText = dialogList[subcolumnPos + i].vodName
							.slice(0, 16);
				}
			}
		}
	}
	positionShow();
}

// 响应搜索悬浮框上下移动按钮
function changeSubcolFocusUD(num) {

	if (num > 0) {
		if (subnowPage == 1 && subcolShown < 1) {
			trunSubPage(num);
		} else {
			if (subcolShown > 0) {
				subcolShown = subcolShown - num;
				moveSubcol(subcolShown);
			} else if (subcolShown == 0 && subcolumnPos > 4) {
				subcolumnPos -= 5;
				subnowPage--;
				for ( var i = 0; i < 5; i++) {
					if (columnOrVod == 0) {
						$("col" + i).innerText = dialogList[0].VALUE[subcolumnPos
								+ i].CATEGORYNAME;
					} else {
						$("col" + i).innerText = dialogList[subcolumnPos + i].vodName
								.slice(0, 16);
					}
				}
			}
		}
	}
	if (num < 0) {
		if (subnowPage == subtotalPage && subcolShown >= 4) {
			trunSubPage(num);
		} else {
			if (subcolShown < Math.min(4, subcolumnSize - 1)) {
				if ((subcolumnPos + subcolShown + 1) >= subcolumnSize) {
					return;
				}
				subcolShown = subcolShown - num;
				moveSubcol(subcolShown);
			} else if (subcolShown == 4
					&& (subcolumnPos + showSubcolumnSize) < subcolumnSize) {
				subcolumnPos += 5;
				subnowPage++;
				subcolShown = 0;
				$("subFocus").style.webkitTransitionDuration = "0ms";
				$("subFocus").style.top = 65;
				$("subFocus").style.webkitTransitionDuration = "300ms";
				for ( var i = 0; i < 5; i++) {
					if ((subcolumnPos + i) > (subcolumnSize - 1)) {
						$("col" + i).innerText = "";
						continue;
					}
					if (columnOrVod == 0) {
						$("col" + i).innerText = dialogList[0].VALUE[subcolumnPos
								+ i].CATEGORYNAME;
					} else {
						$("col" + i).innerText = dialogList[subcolumnPos + i].vodName
								.slice(0, 16);
					}
				}
			}
		}
	}
	positionShow();
}

function showMessage() {
	returnAreaFlag = areaFlag;
	areaFlag = 3;
	$("dialog").style.opacity = 1;
	$("hidden").style.backgroundImage = "url(images/search/hidden.png)";
	$("close").style.opacity = 1;
	$("focus").style.opacity = 0;
	$("close").style.backgroundImage = "url(images/search/close_focus.png)";
	$("subFocus").style.opacity = 0;
	$("DName").innerText = "该栏目下无节目！";
	dialogState = "readyClose";
}

function initSearchResult() {
	columnOrVod = 1;
	subcolShown = 0;
	subcolumnPos = 0;
	subcolumnSize = dialogList.length;
	showSubcolumnSize = Math.min(5, subcolumnSize);
	endSubCPos = startSubCPos + showSubcolumnSize - 1;
	for ( var i = 0; i < 7; i++) {
		if (i < showSubcolumnSize) {
			$("col" + i).innerText = dialogList[i].vodName.slice(0, 16);
			$("col" + i).style.opacity = 1;
		} else {
			$("col" + i).innerText = "";
		}
		if (i == 5) {
			$("col" + i).style.top = -50;
		} else if (i == 6) {
			$("col" + i).style.top = 500;
		} else {
			$("col" + i).style.top = 95 + 70 * i;
		}
	}
	moveSubcol(subcolShown);
	returnAreaFlag = areaFlag;
	areaFlag = 3;
	$("dialog").style.opacity = 1;
	$("hidden").style.backgroundImage = "url(images/search/hidden.png)";
	$("close").style.opacity = 1;
	$("focus").style.opacity = 0;
	subtotalPage = Math.floor((subcolumnSize) / 5);
	if (subcolumnSize % 5 != 0) {
		subtotalPage++;
	}
	if (subtotalPage == 0)
		subtotalPage = 1;
	subnowPage = 1;
	$("subpage").innerText = subnowPage + "/" + subtotalPage + "页";
	if (subcolumnSize == 0) {
		$("close").style.backgroundImage = "url(images/search/close_focus.png)";
		$("subFocus").style.opacity = 0;
		$("DName").innerText = "搜索不到相关内容！";
		dialogState = "readyClose";
	} else {
		positionShow();
		$("DName").innerText = "共搜索到" + subcolumnSize + "个节目";
		$("close").style.backgroundImage = "url(images/search/close.png)";
		$("circleUp").style.opacity = 1;
		$("circleMiddle").style.opacity = 1;
		$("circleDown").style.opacity = 1;
		$("subFocus").style.opacity = 1;
		dialogState = "open";
	}
	leaveSearch();
}

function initSubcolumn() {
	subcolumnSize = dialogList[0].VALUE.length;
	showSubcolumnSize = Math.min(5, subcolumnSize);
	endSubCPos = startSubCPos + showSubcolumnSize - 1;
	var pStart = (subnowPage - 1) * 5;
	for ( var i = 0; i < 7; i++) {
		if (i < showSubcolumnSize) {
			$("col" + i).innerText = dialogList[0].VALUE[pStart + i].CATEGORYNAME;
			$("col" + i).style.opacity = 1;
		} else {
			$("col" + i).innerText = "";
		}
		if (i == 5) {
			$("col" + i).style.top = 400;
		} else if (i == 6) {
			$("col" + i).style.top = 80;
		} else {
			$("col" + i).style.top = 95 + 70 * i;
		}
	}
	subtotalPage = Math.floor((subcolumnSize - 1) / 5) + 1;
	if (subcolumnSize % 5 != 0) {
		subtotalPage++;
	}
	$("subpage").innerText = subnowPage + "/" + subtotalPage + "页";
	moveSubcol(subcolShown);
	positionShow();
	returnAreaFlag = areaFlag;
	areaFlag = 3;
	$("dialog").style.opacity = 1;
	$("hidden").style.backgroundImage = "url(images/search/hidden.png)";
	$("close").style.backgroundImage = "url(images/search/close.png)";
	$("close").style.opacity = 1;
	$("focus").style.opacity = 0;
	$("circleUp").style.opacity = 1;
	$("circleMiddle").style.opacity = 1;
	$("circleDown").style.opacity = 1;
	$("subFocus").style.opacity = 1;
	dialogState = "open";
}

function getSearchResult(__xmlhttp) {
	var data = eval(__xmlhttp.responseText);
	dialogList = data;
	initSearchResult();
}

function getSubcolInfo(__xmlhttp) {
	var data = eval(__xmlhttp.responseText);
	dialogList = data;
	if ("1" == dialogList[0].CODE) {
		initSubcolumn();
		if (returnAreaFlag == 3) {
			if (myArray[7] == undefined) {
				returnAreaFlag = 0;
			} else {
				returnAreaFlag = parseInt(myArray[7]);
			}
		}
	} else if ("0" == dialogList[0].CODE) {
		var toUrl = "";
		toUrl = "HD_vodSingleCategory.jsp?TYPE_ID=" + singleCategoryTypeId;
		document.location = "HD_saveCurrFocus.jsp?currFocus=" + areaFlag + ","
				+ shown + "," + colShown + "," + nowPage + "," + columnOrVod
				+ "," + subcolShown + "," + subnowPage + "," + returnAreaFlag
				+ "," + searchFlag + "," + columnOrVod + ","
				+ inputObj.getKeyword() + "&url=" + toUrl;
	} else {
		showMessage();
	}
}
function showSearchResult(searchType, keyword) {
	if (keyword == "") {
		return;
	}
	var requestUrl = "HD_vodSearchData.jsp?searchFlag=" + searchType
			+ "&keyword=" + keyword;
	var ajaxObj = new AJAX_OBJ(requestUrl, getSearchResult);
	ajaxObj.requestData();
}

function reqSubcolInfo(reqUrl) {
	var requestUrl = reqUrl;
	var ajaxObj = new AJAX_OBJ(requestUrl, getSubcolInfo);
	ajaxObj.requestData();
}

/** *************************初始化区域******************************** */
function getColInfo(__xmlhttp) {
	var data = eval(__xmlhttp.responseText);
	columnList = data;
	initColInfo(); // 初始化首页面显示数据
	if (areaFlag == 2) {
		inFocus(shown);
	} else if (areaFlag == 0) {
		moveFocus(colShown);
		$("focus").style.opacity = 1;
	} else if (reaFlag == 3) {
		dialogState = "open";
		subcolumnPos = (subnowPage - 1) * 5;
		moveFocus(colShown);
		if (columnOrVod == 0) {
			showSubcol();
		} else {
			showSearchResult(searchFlag, myArray[10]);
		}
	}
}

// Ajax请求页面数据
function reqColInfo(typeId) {

	// 获取搜索首页面显示数据
	var requestUrl = "HD_vodCategoryTreeData.jsp?TYPE_ID=" + typeId;
	var ajaxObj = new AJAX_OBJ(requestUrl, getColInfo);
	ajaxObj.requestData();
}

// 处理初始化页面参数
function init(typeId) {
	setTimeout(function() {
		initFlag = false;
	}, 1000);
	// 焦点记忆
	// if(myArray[0]==null){
	areaFlag = 2;
	shown = 0;
	colShown = 3;
	nowPage = 1;
	columnOrVod = 0;
	subcolShown = 0;
	subnowPage = 1;
	returnAreaFlag = 0;
	// }else{
	// areaFlag = parseInt(myArray[0]);
	// shown = parseInt(myArray[1]);
	// colShown = parseInt(myArray[2]);
	// nowPage = parseInt(myArray[3]);
	// columnOrVod = parseInt(myArray[4]);
	// subcolShown= parseInt(myArray[5]);
	// subnowPage = parseInt(myArray[6]);
	// searchFlag = parseInt(myArray[8]);
	// columnOrVod = parseInt(myArray[9]);
	// if(searchFlag == 2){
	// leaveProgram("right");
	// focusName();
	// }
	// }
	// 请求页面数据
	reqColInfo(typeId);
	inputObj = new inputBox("text", 165, "F9E400", "cursor", "tip");
	$("bodyDiv").style.backgroundImage = "url(images/search/index.jpg)";
}