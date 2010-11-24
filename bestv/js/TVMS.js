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
