/**
 * 定义function 原型函数
 */
Function.prototype.method = function(name, func) {
	this.prototype[name] = func;
	return this;
}

/**
 * 功能：当时间为个位数时在其前补空格
 */
String.method("processTime", function() {
	var timegroup = this.split(":");
	if ((timegroup[0].substring(0,1) == 0))  timegroup[0] = timegroup[0].replace("0", "&nbsp;&nbsp;");
	if (timegroup[0].length == 1) timegroup[0] = "&nbsp;&nbsp;" + timegroup[0];
	return  timegroup[0] + ":" + timegroup[1];
});

/**
 * 功能：当月份、天数为个位数时在月份前补空格
 * @param date
 * @return
 */
String.method("dealDate", function() {
	var timegroup = this.split("月");
	if (timegroup[0].substring(0,1) == 0)  timegroup[0] = timegroup[0].replace(/0/g, "&nbsp;&nbsp;");
	if (timegroup[1].substring(0,1) == 0)  timegroup[1] = timegroup[1].replace(/0/g, "&nbsp;&nbsp;");
	
	return  timegroup[0] + "月" + timegroup[1];
});

/**
 * 功能：截取字符串，超出的部分用\...替换
 */
String.method('cutString', function(strlen) {
	return (this.length > strlen) ?  (this.slice(0,strlen-2)+ "...") : this; 
});

/**
 * 功能：创建一个使用原对象作为其原型的新对象
 */
if(typeof Object.beget !== 'function') {
	Object.beget = function (o) {
		var F = function() {};
		F.prototype = o;
		return new F();
	}
}

var func	=	{
		/**
		 * 设置标签的WebkitTransitionDuration
		 * @param obj, Array; 封装需要改变WebkitTransitionDuration的元素
		 */
		setWebkitTransitionDuration : function (obj, value) {
			if ((typeof obj == 'object') && (obj.length > 0)) {
				var temp_num = obj.length;
				for(var i=0; i<temp_num; i++)  obj[i].name.style.webkitTransitionDuration	=	obj[i].value;
			} else {
				obj.style.webkitTransitionDuration	= value;
			}
		},
		
		/**
		 * 设置标签的opacity
		 */
		setOpacity : function (obj, value) {
			if (typeof obj == 'object' && obj.length > 0) {
				var temp_num = obj.length;
				for(var i=0; i<temp_num; i++) obj[i].name.style.opacity	=	obj[i].value;
			} else {
				obj.style.opacity	= value;
			}
		},
		
		/**
		 * 设置标签的left
		 */
		setLeft : function (obj, value) {
			if (typeof obj == 'object' && obj.length > 0) {
				var temp_num = obj.length;
				for(var i=0; i<temp_num; i++) obj[i].name.style.left =	obj[i].value;
			} else {
				obj.style.left	= value;
			}
		},
		
		/**
		 * 设置标签的backgroundImage
		 */
		setBackgroundImage : function (obj, value) {
			if (typeof obj == 'object' && obj.length > 0) {
				var temp_num = obj.length;
				for(var i=0; i<temp_num; i++) obj[i].name.style.backgroundImage =	obj[i].value;
			} else {
				obj.style.backgroundImage	= value;
			}
		},
		
		set : function (param, myArr, value) {
			if ((typeof myArr == 'object') && (myArr.length > 0)) {
				var temp_num = myArr.length;
				var str	= 'myArr[i].style.' + param;
				var temp = str.replace(/\"/g ,);
				for(var i=0; i<temp_num; i++) {
					temp	=	value;
				}
			} else {
				var str	= "myArr.style." + param;
				var temp = str.replace(/\"/g ,);
				temp	=  value;
				alert(temp);
			}
		}
};

var myFunc = Object.beget(func);