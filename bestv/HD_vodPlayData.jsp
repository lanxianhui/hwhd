<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="java.util.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="HD_vodBasicInfo.jsp" %>
<%
    ServiceHelp serviceHelp = new ServiceHelp(request);
    MetaData metaData = new MetaData(request);
        
    String returnUrl = null;
    String playingUrl = "";
    String progID = null;
    String playUrl = null;
	  String mediacode = null;
    String backurl =request.getParameter("BACKURL");
	  String snumber= request.getParameter("PROGNUM");
    String typeId = (String) request.getParameter("TYPE_ID");
    String supVodid = (String)request.getParameter("FATHERID");
    
  //  System.out.println("snumber:::"+snumber+"::::::supVodid::::"+supVodid);
    
    session.setAttribute("AREAID" , "-1");
    
	  String isSitcom = "0";      //是否是连续剧标志 isSitcom = 0 不是 isSitcom = 1 是		 
    if (request.getParameter("PROGID") != null && !"".equals(request.getParameter("PROGID")))
    {
    	progID = request.getParameter("PROGID");
    	playingUrl = getTriggerUrl(serviceHelp, Integer.parseInt(progID));
    	if(null == playingUrl || playingUrl.length() < 1)  return;

		  int tmpVodId = Integer.parseInt(progID);
      Map tmpVodMap = metaData.getVodDetailInfo(tmpVodId);
		  mediacode = (String)tmpVodMap.get("CODE");
    }

    String vodCode = "";
    if (request.getParameter("VALUE") != null && !"".equals(request.getParameter("VALUE")))
    {
    	vodCode = request.getParameter("VALUE");
    	int vodId = 0;
    	Map entityMap = metaData.getContentDetailInfoByForeignSN(vodCode, 0);

    	if (entityMap != null)
    	{
    		vodId = ((Integer)entityMap.get("VODID")).intValue();
    	}
    	if ("".equals(progID) || null == progID)
    	{
    		progID = String.valueOf(vodId);
    	}
    	playingUrl = getTriggerUrl(serviceHelp, vodId);
    }
    
    HashMap jsonMap = getVodBasicInfo(session , request , serviceHelp , metaData , progID , typeId); 
    if(null == jsonMap) return;
    
    jsonMap.put("RTSP" , playingUrl);
    
   // System.out.println("rtsp:::dxy::::::"+playingUrl);

    if (session.getAttribute("vas_back_url") != null && !"".equals(session.getAttribute("vas_back_url")))
    {
        returnUrl = "backToVis.jsp";
    }
    jsonMap.put("BACKURL" , returnUrl);
    
    if (null != supVodid && !"".equals(supVodid.trim()) && !"null".equals(supVodid.trim()))
	  {
		  isSitcom = "1";
		  
		  int[] TVSeriesEpis = metaData.getTVSeriesEpis(Integer.parseInt(progID));
      if (TVSeriesEpis == null)
      {
        TVSeriesEpis = new int[2];
        TVSeriesEpis[0] = -1;
        TVSeriesEpis[1] = -1;
      }

		  String descPre = "";
		  String descNext = "";
      
  		ArrayList childList = metaData.getSitcomList(supVodid, 1000, 0);

		  if (childList != null && childList.size() == 2) 
		  {
         ArrayList sitcomList = (ArrayList)childList.get(1);
         int fetchNum = sitcomList.size();
         HashMap sitcomMap = null;
         String tmpid = "";
		
         for ( int i = 0; i < fetchNum; i++ )
         {
            sitcomMap = (HashMap)sitcomList.get(i);
            tmpid = String.valueOf((Integer)sitcomMap.get("VODID"));
            if(String.valueOf(TVSeriesEpis[0]).equals(tmpid)) {
               StringBuffer temp = new StringBuffer(String.valueOf((Integer)sitcomMap.get("SITCOMNUM")));
               descPre = temp.toString();
            }
			      if(String.valueOf(TVSeriesEpis[1]).equals(tmpid)) {
               StringBuffer temp = new StringBuffer(String.valueOf((Integer)sitcomMap.get("SITCOMNUM")));
               descNext = temp.toString();
            }
        }
		  }	  
		  jsonMap.put("PREEPIS" , descPre);
		  if("".equals(descPre))
		  {
		  jsonMap.put("PREEPISURL","");	  
		  }
		  else
		  {
		    jsonMap.put("PREEPISURL" , "HD_playSeries.jsp?PROGID=" + supVodid + "&CHILDID=" + TVSeriesEpis[0] + "&CHILDNUM=" + descPre + "&TYPE_ID=" + typeId);	  
		  }
		  jsonMap.put("NEXTEPIS" , descNext); 
		   if("".equals(descNext))
		  {
		  jsonMap.put("NEXTEPISURL","");	  
		  }
		  else
		  {
		     jsonMap.put("NEXTEPISURL" , "HD_playSeries.jsp?PROGID=" + supVodid + "&CHILDID=" + TVSeriesEpis[1] + "&CHILDNUM=" + descNext + "&TYPE_ID=" + typeId);	  
		   }  
		 
		
		
	  }	  
	  
	  jsonMap.put("PARENTID" , supVodid);
    jsonMap.put("ISSITCOM" , String.valueOf(isSitcom));
    

    int filmId = -1;
    filmId = Integer.parseInt(progID);
    Map filmInfoMap = metaData.getVodDetailInfo(filmId);
	  if (null == filmInfoMap) return;
	  
    String price = (String)filmInfoMap.get("VODPRICE");
    String productId = (String)session.getAttribute("PRODUCTID");
    String serviceId = (String)session.getAttribute("SERVICEID");
    int playType = EPGConstants.PLAYTYPE_VOD;
    try
    {
        String playTypeStr = (String)request.getParameter("PLAYTYPE");
        playType = Integer.parseInt(playTypeStr);
    }
    catch(Exception e)
    {
        playType = EPGConstants.PLAYTYPE_VOD;
    }

    String beginTime = "0";
    switch (playType)
    {
        case EPGConstants.PLAYTYPE_ASSESS:
        {
            break;
        }
        case EPGConstants.PLAYTYPE_BOOKMARK:
        {
            beginTime = (String)request.getParameter("BOOKMARKTIME");
        }
        case EPGConstants.PLAYTYPE_TVOD:
        {
            break;
        }
        default:
        {
            break;
        }
    }
    
    String playJson = "[{mediaUrl:'" + playingUrl + "',";
    playJson += "mediaCode: 'jsoncode1',";
    playJson += "mediaType:2,";
    playJson += "audioType:1,";
    playJson += "videoType:1,";
    playJson += "streamType:1,";
    playJson += "drmType:1,";
    playJson += "fingerPrint:0,";
    playJson += "copyProtection:1,";
    playJson += "allowTrickmode:1,";
    playJson += "startTime:0,";
    playJson += "endTime:10000.3,";
    playJson += "entryID:'jsonentry1'}]";
    
    jsonMap.put("PLAYJSON" , playJson);
       
    JSONArray jsonObject = JSONArray.fromObject(jsonMap); 
    System.out.println("xinsw----------------"+jsonObject.toString());  						
	out.print(jsonObject.toString());
%>