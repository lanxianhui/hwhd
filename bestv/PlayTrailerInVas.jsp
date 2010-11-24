<!-- Copyright (C), Bestv. Co., Ltd. -->
<!-- Author:caiyuhong -->
<!-- CreateAt:20080512 -->
<!-- FileName:PlayTrailerInVas.jsp -->
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.memtable.MemTableManager" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<%@ page import="java.util.*"%>

<html>
<script>
<%   
    TurnPage turnPage = new TurnPage(request);
    ServiceHelp serviceHelp = new ServiceHelp(request);
    MetaData metaData = new MetaData(request);
    
    int left = 0;
    int top = 0;
    int width = 640;
    int height = 530;
    if (request.getParameter("left") != null && !"".equals(request.getParameter("left")))
    	left = Integer.parseInt(request.getParameter("left")) ;
    if (request.getParameter("top") != null && !"".equals(request.getParameter("top")))
    	top = Integer.parseInt(request.getParameter("top")) ;
    if (request.getParameter("width") != null && !"".equals(request.getParameter("width")))
    	width = Integer.parseInt(request.getParameter("width"));
    if (request.getParameter("height") != null && !"".equals(request.getParameter("height")))
    	height = Integer.parseInt(request.getParameter("height"));

    String type = "";
	int typeid = -1;
	String mediacode = "";
	String value = "";
	HashMap ht = new HashMap();
	ht.put("VOD","0");
	ht.put("CHAN","1");
	HashMap urlparam = new HashMap();
	urlparam.put("VOD" ,"1");
	urlparam.put("CHAN","2");
	urlparam.put("TVOD","4");
	


    if (request.getParameter("type") != null && !"".equals(request.getParameter("type"))) {
    	type = request.getParameter("type");
		if(ht.containsKey(type)) 
			typeid = Integer.parseInt((String)ht.get(type));
    }
	if (request.getParameter("mediacode") != null && !"".equals(request.getParameter("mediacode"))) {
    	mediacode = request.getParameter("mediacode");
    }
	if (request.getParameter("value") != null && !"".equals(request.getParameter("value"))) {
    	value = request.getParameter("value");
    }

	if((value.equals("") && mediacode.equals("")) || typeid == -1) {
%>
	    <jsp:forward page="HD_infoDisplay.jsp?ERROR_ID=86"/>
<%
	}
	String progId = value;
	int progIndex = -1;
	HashMap result = null;
	Object objsID = null;
	Map typeInfo = new HashMap();
	if(value.equals("")) {
		 //MemTableManager manager = MemTableManager.getInstance();
     if (typeid == 1) {
          typeInfo = metaData.getContentDetailInfoByForeignSN(mediacode, EPGConstants.CONTENTTYPE_CHANNEL_VIDEO);	
          		  if(typeInfo == null) {
              %>
	    <jsp:forward page="HD_infoDisplay.jsp?ERROR_ID=22"/>
<%
              	}
              else
              	{
							objsID = typeInfo.get("CHANNELID");
			}
		
         if(objsID != null) {
            progId = objsID.toString();
         }
     }else if (typeid == 0) {
     	   typeInfo = metaData.getContentDetailInfoByForeignSN(mediacode, EPGConstants.CONTENTTYPE_VOD_VIDEO);
     	      		  if(typeInfo == null) {
             %>
	    <jsp:forward page="HD_infoDisplay.jsp?ERROR_ID=23"/>
<%
              	}
              else
              	{
									objsID = typeInfo.get("VODID");
			}

         if(objsID != null) {
	//	 System.out.println(objsID.toString());
         	  progId = objsID.toString();
         }
     }
	}
	if(progId.equals("") || progId == null) {
%>
	    <jsp:forward page="InfoDisplay.jsp?ERROR_ID=23&ERROR_TYPE=2"/>
<%
	}
  if(type.equals("CHAN")) {
		Map channelInfo = metaData.getChannelInfo(progId);
		if (channelInfo.get("CHANNELINDEX") != null)
			progIndex = ((Integer)channelInfo.get("CHANNELINDEX")).intValue();
	} 

	int parameter =  Integer.parseInt((String)urlparam.get(type));
  String playUrl = serviceHelp.getTriggerPlayUrl(parameter,Integer.parseInt(progId),"0");
  int st=playUrl.indexOf("rtsp");
  playUrl=playUrl.substring(st,playUrl.length());  
%>
	//setTimeout(init,500);
	var mp = new MediaPlayer();
	var NativePlayerInstanceID = mp.getNativePlayerInstanceID();
	mp.setNativeUIFlag(0);
	mp.setMuteUIFlag(0);
	mp.setAudioVolumeUIFlag(0);
	mp.setAudioTrackUIFlag(0);
	mp.setProgressBarUIFlag(0);
	mp.setChannelNoUIFlag(0);
	
  var json = '[{mediaUrl:"<%=playUrl%>",';
	json +=	'mediaCode: "<%=mediacode%>",';
	json +=	'mediaType:2,';
	json +=	'audioType:1,';
	json +=	'videoType:3,';
	json +=	'streamType:2,';
	json +=	'drmType:1,';
	json +=	'fingerPrint:0,';
	json +=	'copyProtection:1,';
	json +=	'allowTrickmode:0,';
	json +=	'startTime:0,';
	json +=	'endTime:10000.3,';
	json +=	'entryID:"jsonentry1"}]';
	
  var playStat = "";
  var speed = 0;

	var channelIndex = <%=progIndex%>;
	var playtype = '<%=type%>';
    
    function play_trailer()
    {
		initMediaPlay();
	    if(playtype == "CHAN") mp.leaveChannel();
		iPanel.debug("xinsw----------------------------------playtype="+playtype);
		mp.setSingleMedia(json);
		mp.setAllowTrickmodeFlag(0);
		iPanel.debug("xinsw----------------------------------channelIndex="+channelIndex);
		iPanel.debug("xinsw-------------------------------------init");
		play();
	 }
    
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
        mp.initMediaPlayer(instanceId,playListFlag,videoDisplayMode,height,width,left,top,muteFlag,useNativeUIFlag,subtitleFlag,videoAlpha,cycleFlag,randomFlag,autoDelFlag);
    }
    
    function play()
    {

		if(playtype == "CHAN"){ 
			joinChannel(channelIndex);
		}
		if(playtype == "VOD") {
			mp.playFromStart();
		}
		mp.setVideoDisplayArea(<%=left%>,<%=top%>,<%=width%>,<%=height%>);
    	mp.setVideoDisplayMode(0);
		mp.refreshVideoDisplay();
		iPanel.debug("xinsw-------------------------------------play");
	}

	function joinChannel(index) {
    	channelIndex = index;
    	mp.leaveChannel();
    	mp.joinChannel(index);
		iPanel.debug("xinsw-------------------------------------join channel");
    }
    
    function destoryMP()
    {
		if(playtype == "CHAN") mp.leaveChannel();
        mp.stop();
        mp.releaseMediaPlayer(mp.getNativePlayerInstanceID());
    }
</script>

<body bgcolor="transparent" leftmargin="0" topmargin="0" onLoad="play_trailer()" onUnload="destoryMP()" style="background-Repeat:no-repeat">
</body>
</html>
