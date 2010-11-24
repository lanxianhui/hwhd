<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="java.util.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%
    ServiceHelp serviceHelp = new ServiceHelp(request);
    MetaData metaData = new MetaData(request);
        
    String returnUrl = null;
	  String mediacode = null;
    String progID = request.getParameter("PROGID");
    String playType = request.getParameter("PLAYTYPE");
    String channelID = request.getParameter("CHANNELID");
    int i_chanId = -1 , i_progId = -1 , i_playType = -1;
    
    HashMap jsonMap = new HashMap();
    
    if(channelID != null)
    {
    	i_chanId = Integer.parseInt(channelID);
    }
    
    String strProgDate = "";
    
    if(progID != null)
    {
    	i_progId = Integer.parseInt(progID);
		  Map tmpTvodMap = metaData.getProgDetailInfo(i_progId);
		  mediacode = (String)tmpTvodMap.get("CODE");
    }

    if(playType != null)
    {
    	i_playType = Integer.parseInt(playType);;
    }
    
    String beginTime = request.getParameter("PROGSTARTTIME");
    String endTime = request.getParameter("PROGENDTIME");
    strProgDate = beginTime.substring(4,6) + "月" + beginTime.substring(6,8) + "日";
    jsonMap.put("PROGDATE" , strProgDate);    
    
    String playUrl = serviceHelp.getTriggerPlayUrl_MDN(i_playType, i_chanId, i_progId, beginTime, endTime); 
    if(playUrl != null && playUrl.indexOf("^") > 0)
    {
    	playUrl = playUrl.substring(playUrl.lastIndexOf("^") + 1,playUrl.length());
    }    
    
    String  playJson = "[{mediaUrl:'" + playUrl + "','";
	  playJson +=	"mediaCode: 'jsoncode1',";
	  playJson +=	"mediaType:2,";
	  playJson +=	"audioType:1,";
	  playJson +=	"videoType:1,";
	  playJson +=	"streamType:1,";
	  playJson +=	"drmType:1,";
	  playJson +=	"fingerPrint:0,";
	  playJson +=	"copyProtection:1,";
	  playJson +=	"allowTrickmode:1,";
	  playJson +=	"startTime:0,";
	  playJson +=	"endTime:100.3,";
	  playJson +=	"entryID:'jsonentry1'}]";
	  
	  jsonMap.put("PLAYJSON" , playJson);
    jsonMap.put("RTSP" , playUrl);

    if (session.getAttribute("vas_back_url") != null && !"".equals(session.getAttribute("vas_back_url")))
    {
        returnUrl = "backToVis.jsp";
    }
    jsonMap.put("BACKURL" , returnUrl);    
    
    
    String channelName = "";
	  String progName = "";
	  String progTimeBegin = "";
	  String progTimeEnd = "";
	  String progTimeSpan = "";
	
	  String preProgName = "";
	  String preProgBeginTime = "";
	  String preProgEndTime = "";
	  int    preProgId = -1;
	
	  String nextProgName = "";
	  String nextProgBeginTime = "";
	  String nextProgEndTime = "";
	  int    nextProgId = -1;
	
	  int time = -1;
		HashMap progConextInfo =  null;	
	
	
	  if(null != progID)
	  {    	
		   progConextInfo = metaData.getRecProgContextInfo(i_progId , i_chanId);
	  }
	  if (null != progConextInfo)
	  {
  		channelName = (String)progConextInfo.get("CHANNELNAME");
  		jsonMap.put("CHANNELNAME" , channelName);
  		
  		progName = (String)progConextInfo.get("PROGNAME");
  		jsonMap.put("PROGNAME" , progName);
  		progTimeBegin = (String)progConextInfo.get("BEGINTIME");
  		jsonMap.put("PROGBEGIN" , progTimeBegin);
  		progTimeEnd = (String)progConextInfo.get("ENDTIME");
  		jsonMap.put("PROGEND"   , progTimeEnd);
  		
  		preProgName = (String)progConextInfo.get("PREPROGNAME");
  		jsonMap.put("PREPROGNAME" ,  preProgName);
  		preProgBeginTime = (String)progConextInfo.get("PREPROGBEGINTIME");
  		jsonMap.put("PREPROGBEGIN" , preProgBeginTime);
  		preProgEndTime = (String)progConextInfo.get("PREPROGENDTIME");
  		jsonMap.put("PREPROGEND"   , preProgEndTime);
  		preProgId = ((Integer)progConextInfo.get("PREPROGID")).intValue();
  		jsonMap.put("PREPROGID"   , preProgId);
  		
  		nextProgName = (String)progConextInfo.get("NEXTPROGNAME");
  		jsonMap.put("NEXTPROGNAME" ,  nextProgName);
  		nextProgBeginTime = (String)progConextInfo.get("NEXTPROGBEGINTIME");
  		jsonMap.put("NEXTPROGBEGIN" , nextProgBeginTime);
  		nextProgEndTime = (String)progConextInfo.get("NEXTPROGENDTIME");
  		jsonMap.put("NEXTPROGEND"   , nextProgEndTime);
  		nextProgId = ((Integer)progConextInfo.get("NEXTPROGID")).intValue();
  		jsonMap.put("NEXTPROGID"   , nextProgId);	
  	
  		if (progTimeBegin.length() >= 8)
  		{
  			int hour = Integer.parseInt(progTimeBegin.substring(0, 2));
  			int min = Integer.parseInt(progTimeBegin.substring(3, 5));			
  			int sec = Integer.parseInt(progTimeBegin.substring(6, 8));
  			if (sec >= 30)
  			{
  				min += 1;
  				if (min == 60)
  				{
  					hour += 1;
  					min = 0;
  					
  					if (hour == 24)
  						hour = 0;
  				}
  			}
  			
  			progTimeBegin = (hour < 10 ? "0" : "") + hour + ":" + (min < 10 ? "0" : "") + min;
  		}
  		
  		progTimeEnd = (String)progConextInfo.get("ENDTIME");	
  			
  		if (progTimeEnd.length() >= 8)
  		{
  			int hour = Integer.parseInt(progTimeEnd.substring(0, 2));
  			int min = Integer.parseInt(progTimeEnd.substring(3, 5));			
  			int sec = Integer.parseInt(progTimeEnd.substring(6, 8));
  			if (sec >= 30)
  			{
  				min += 1;
  				if (min == 60)
  				{
  					hour += 1;
  					min = 0;
  					
  					if (hour == 24)
  						hour = 0;
  				}
  			}
  			
  			progTimeEnd = (hour < 10 ? "0" : "") + hour + ":" + (min < 10 ? "0" : "") + min;
  		}
  		
  		//	不使用上面精确到秒的算法，改为精确到分的算法
  		if (progTimeBegin.length() == 5 && progTimeEnd.length() == 5)
  		{
  			int mins1 = Integer.parseInt(progTimeBegin.substring(0, 2)) * 60 + Integer.parseInt(progTimeBegin.substring(3, 5));
  			int mins2 = Integer.parseInt(progTimeEnd.substring(0, 2)) * 60 + Integer.parseInt(progTimeEnd.substring(3, 5));
  			time = mins2 - mins1;
  			
  			// 跨天的情况
  
  			if (time < 0)
  			{
  				time += 24 * 60;
  			}
  		}
  
  		progTimeSpan = progTimeBegin + "~" + progTimeEnd;	
  		jsonMap.put("PROGTIMESPAN"   , progTimeSpan);	  	
  	}   

    JSONArray jsonObject = JSONArray.fromObject(jsonMap); 
//    System.out.println(jsonObject.toString());  						
	  out.print(jsonObject.toString());
%>