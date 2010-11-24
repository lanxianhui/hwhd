<%@page contentType="text/html; charset =UTF-8" language="java" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@page import="com.huawei.iptvmw.epg.util.EPGUtil" %>
<%@page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="net.sf.json.JSONArray" %>
<%@page import="net.sf.json.JSONObject" %>
<%

	String chanNum = request.getParameter("CHANNUM");
	int chanId = -1;
	if(chanNum != null)
	{	
		ServiceHelp serviceHelp = new ServiceHelp(request);
		chanId = serviceHelp.getChannelIdByChanNum(Integer.parseInt(chanNum));
	}
	
	HashMap miniInfo = new HashMap();
	
//	System.out.println("chanNum::::::"+chanNum+":::::::::::chanId::::::::::::::"+chanId);

	String channelName = "";
	String progName = "";
	String progTimeBegin = "";
	String progTimeEnd = "";
	String progTimeSpan = "";	
	String preProgName = "";	
	String nextProgName = "";
	
	MetaData meta = new MetaData(request);	
	HashMap progConextInfo =  null;	
	int time = -1;	
	int bb = -1;
	String timeSpan = "";	
	if(-1 != chanId)
	{    	
		progConextInfo = meta.getLiveProgContextInfo(chanId);
	}
	
//	System.out.println("progConextInfo::::::"+progConextInfo+":::::::::::chanId::::::::::::::"+chanId);
	
	if (null != progConextInfo)
	{
		channelName = (String)progConextInfo.get("CHANNELNAME");	
		progName = (String)progConextInfo.get("PROGNAME");
		progTimeBegin = (String)progConextInfo.get("BEGINTIME");
	  progTimeEnd = (String)progConextInfo.get("ENDTIME");		
		preProgName = (String)progConextInfo.get("PREPROGNAME");	
		nextProgName = (String)progConextInfo.get("NEXTPROGNAME");

    if (6 < channelName.length())
    {
    	 channelName = EPGUtil.swapHtmlStr(channelName, 12, 1);
    }  	    
  
    if (6 < progName.length())
    {
       	progName = EPGUtil.swapHtmlStr(progName, 30, 1);
    }  	    
  
    if (8 < preProgName.length())
    {
    	  preProgName = EPGUtil.swapHtmlStr(preProgName, 18, 1);
    } 
  
    if (8 < nextProgName.length())
    {
    	  nextProgName = EPGUtil.swapHtmlStr(nextProgName, 18, 1);    		
    }  
	}	
  if(progName.equals("") && preProgName.equals("") && nextProgName.equals("")) {
      progName = "无编排节目信息";
  }
  miniInfo.put("PROGTIMEBEGIN" , progTimeBegin);
  miniInfo.put("PROGTIMEEND" , progTimeEnd);
	miniInfo.put("CHANNELNAME" , channelName);
	miniInfo.put("PROGNAME" , progName);
	miniInfo.put("PREPROGNAME" , preProgName);
	miniInfo.put("NEXTPROGNAME" , nextProgName);	
	
  JSONArray jsonObject = JSONArray.fromObject(miniInfo); 
  //System.out.println(jsonObject.toString());  						
	out.print(jsonObject.toString());
%>