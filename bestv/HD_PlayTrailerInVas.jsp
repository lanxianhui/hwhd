<%@ page contentType="application/x-javascript; charset=UTF-8" language="java" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>

<%
System.out.println("test~~~~~~~~~~~~~~~~~~~~~"); 
    int supportHD = 0;
	try
	{
		supportHD = Integer.valueOf((String)session.getAttribute("SupportHD")).intValue();
	}
	catch(Exception ee)
	{
		supportHD = 0 ;
	}

	//接口
    MetaData metaData = new MetaData(request);
    ServiceHelpHWCTC serviceHelphwctc = new ServiceHelpHWCTC(request);
	//Trailer播放界面的位置以及大小
    int left = 0;
    int top = 0;
    int width = 1280;
    int height = 720;
    if (request.getParameter("left") != null && !"".equals(request.getParameter("left")))
	{
    	left = Integer.parseInt(request.getParameter("left")) ;
    }
	if (request.getParameter("top") != null && !"".equals(request.getParameter("top")))
    {
		top = Integer.parseInt(request.getParameter("top")) ;
    }
	if (request.getParameter("width") != null && !"".equals(request.getParameter("width")))
    {
		width = Integer.parseInt(request.getParameter("width"));
    }
	if (request.getParameter("height") != null && !"".equals(request.getParameter("height")))
    {
		height = Integer.parseInt(request.getParameter("height"));
	}


	String cut = "0";
	if(EPGUtil.isValidateUser(request)) {
		cut = "0";
	} else {
		cut = "1";
	}

	//播放类型
    String type = "";
	int typeid = -1;
	//节目外部编号
	String mediacode = "";
	//节目ID
	String value = "";
	//播放内容类型
	String strContentType = "";
	//根据内容类型获得对应的内容类型值
	HashMap ht = new HashMap();
	ht.put("VOD","0");
	ht.put("CHAN","1");
	ht.put("TVOD","300");
	//根据播放类型获得对应的播放类型值
	HashMap urlparam = new HashMap();
	urlparam.put("VOD" ,"1");
	urlparam.put("CHAN","2");
	urlparam.put("TVOD","4");
	//需要的参数：type 播放类型，mediacode 节目外部编号，value 节目id，contenttype 内容类型
    if (request.getParameter("type") != null && !"".equals(request.getParameter("type")))
	{
    	type = request.getParameter("type");
		if(ht.containsKey(type))
		{
			typeid = Integer.parseInt((String)ht.get(type));
    	}
	}
	if (request.getParameter("mediacode") != null && !"".equals(request.getParameter("mediacode")))
	{
    	mediacode = request.getParameter("mediacode");
    }
	if (request.getParameter("value") != null && !"".equals(request.getParameter("value")))
	{
    	value = request.getParameter("value");
    }
	if (request.getParameter("contenttype") != null && !"".equals(request.getParameter("contenttype")))
	{
    	strContentType = request.getParameter("contenttype");
    }

	System.out.println("xinsw~~~~~~~~~~~~~~~~~~~~~"); 

	if((value.equals("") && mediacode.equals("")) || typeid == -1) {
%>
<jsp:forward page="HD_infoDisplay.jsp?ERROR_ID=23"/>
<%
	}
	//节目id
	String progId = value;
	//节目单编号（可选参数），仅当progId是频道时有效
	int progIndex = -1;
	//如果是TVOD，根据传来的proid赋值给节目编号progIndex
	if(type.equals("TVOD"))
	{
		progIndex = Integer.parseInt(progId);
	}

	HashMap result = null;
	if(value.equals(""))
	{
		//根据传入的内容的外部编号和内容类型，查找内容的详细信息
		result = metaData.getContentDetailInfoByForeignSN(mediacode,typeid);
		if(result != null)
		{
			if(type.equals("CHAN"))
			{
				progId = result.get("CHANNELID").toString();
			} else if(type.equals("VOD"))
			{
				progId = result.get("VODID").toString();
			}
		}
	}
	if(progId.equals("") || progId == null)
	{
		System.out.println("xinsw~~~~~~~~~~~~~~~~~~~~~1111"); 
%>
<jsp:forward page="HD_InfoDisplay.jsp?ERROR_ID=23"/>
<%
	}
	//如果播放类型为频道，则根据节目id获取节目单编号
    if(type.equals("CHAN"))
	{
		Map channelInfo = metaData.getChannelInfo(progId);
		if (channelInfo.get("CHANNELINDEX") != null)
		{
			progIndex = ((Integer)channelInfo.get("CHANNELINDEX")).intValue();
		}
	}
	//播放类型不是频道的情况下，如果播放节目的ID为空，则赋值
	else
	{
		if(value.equals(""))
		{
			progId = result.get("VODID").toString();
		}
	}

	//根据播放类型获得播放类型值
	int parameter =  Integer.parseInt((String)urlparam.get(type));


	String playUrl = null;
	String strNotice = "";
	if(type.equals("VOD"))
	{
		HashMap vodInfo = (HashMap)metaData.getVodDetailInfo(Integer.parseInt(progId));
		if(supportHD == 0 &&  vodInfo != null && ((Integer)vodInfo.get("DEFINITION")).intValue()==1)
		{
			strNotice = "暂不支持高清";
		}
		else
		{
			//根据播放类型等，获取触发节目播放的URL
    		playUrl = serviceHelphwctc.getTriggerPlayUrlHWCTC(parameter,Integer.parseInt(progId),progIndex,"0","0","0","0",strContentType);
		}
	}
	else if(type.equals("CHAN"))
	{

		HashMap chanInfo = metaData.getChannelInfo(progId);
		if(supportHD == 0 &&  ((Integer)chanInfo.get("DEFINITION")).intValue()==1)
		{
			strNotice = "暂不支持高清";
		}
		else
		{
			//根据播放类型等，获取触发节目播放的URL
   			playUrl = serviceHelphwctc.getTriggerPlayUrlHWCTC(parameter,Integer.parseInt(progId),progIndex,"0","0","0","0",strContentType);
		}
	}

	//对获得的URL进行处理，得到MediaPlayer需要的url值
	if(playUrl != null && playUrl.length() > 0)
    {
		int st=playUrl.indexOf("rtsp");
		if(-1 != st)
		{
			playUrl=playUrl.substring(st,playUrl.length());
		}
	}
	System.out.println("xinsw~~~~~~~~~~~~~~~~~~~~~22222"); 
%>



<%
	System.out.println("xinsw----------playUrl=="+playUrl);
%>
var cut = "<%=cut%>";

var flag = "<%=strNotice%>";

var mp = new MediaPlayer();
var json = '[{mediaUrl:"<%=playUrl%>",';
json += 'mediaCode: "<%=mediacode%>",';
json += 'mediaType:1,';
json += 'audioType:1,';
json += 'videoType:3,';
json += 'streamType:2,';
json += 'drmType:1,';
json += 'fingerPrint:0,';
json += 'copyProtection:1,';
json += 'allowTrickmode:0,';
json += 'startTime:0,';
json += 'endTime:10000.3,';
json += 'entryID:"jsonentry1"}]';

var playStat = "";
var speed = 0;

var channelIndex = <%=progIndex%>;
var playtype = '<%=type%>';

function play_trailer()
{
    initMediaPlay();
    if (playtype == "CHAN") mp.leaveChannel();

    mp.setSingleMedia(json);
    mp.setAllowTrickmodeFlag(0);

    mp.setNativeUIFlag(0);
    mp.setMuteUIFlag(0);
	iPanel.debug("xinsw----------------------------------playtype="+playtype);
	iPanel.debug("xinsw----------------------------------channelIndex="+channelIndex);
    play();
	iPanel.debug("xinsw----------init");
}



/**
 *初始化MediaPlay的属性
 */
function initMediaPlay()
{
    var instanceId = mp.getNativePlayerInstanceID();
    var playListFlag = 0;
    var videoDisplayMode = 0;
    var height = 0;
    var width = 0;
    var left = 0;
    var top = 0;
    var muteFlag = 0;
    var subtitleFlag = 0;
    var videoAlpha = 0;
    var cycleFlag = 0;
    var randomFlag = 0;
    var autoDelFlag = 0;
    var useNativeUIFlag = 1;
    mp.initMediaPlayer(instanceId, playListFlag, videoDisplayMode, height, width, left, top, muteFlag, useNativeUIFlag, subtitleFlag, videoAlpha, cycleFlag, randomFlag, autoDelFlag);
}

/**
 *开始播放
 */
function play()
{   
    if (playtype == "CHAN") mp.joinChannel(channelIndex);
    if (playtype == "VOD" || playtype == "TVOD") mp.playFromStart();
	mp.setVideoDisplayArea(<%=left%>, <%=top%>, <%=width%>, <%=height%>);
    mp.setVideoDisplayMode(0);
    mp.refreshVideoDisplay();
	iPanel.debug("xinsw------------play");
}

/**
 *如果是频道，则需要加入直播
 */
function joinChannel(index)
{
    channelIndex = index;
    mp.leaveChannel();
    mp.joinChannel(index);
}

/**
 *停止播放
 */
function stop_trailer()
{
    if (playtype == "CHAN") mp.leaveChannel();
    mp.stop();
}
