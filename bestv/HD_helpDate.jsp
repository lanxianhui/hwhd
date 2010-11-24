<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ page import="com.bestv.epg.util.MessageUtil" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="HD_vodBasicInfo.jsp" %>

<%!
	  //每次最多取100部影片
	  protected static int FETCH_MAX = 100;
%>

<%

  ServiceHelp serviceHelp = new ServiceHelp(request);
  MetaData metaData = new MetaData(request);
  String helpTypeId=MessageUtil.getMessage(session, "help_typeId");
  
    String helpMessage=MessageUtil.getMessage(session, "help_message");
     String helpTitle=MessageUtil.getMessage(session, "help_title");
  
   ArrayList wholeVodTypeList=new ArrayList(); 
   ArrayList	maxVodTypeListTmp =new ArrayList();
   HashMap tepTypeVod=new HashMap();
  
  ArrayList  vodList_help = metaData.getVodListByTypeId(helpTypeId,FETCH_MAX, 0);
 
  
  if(vodList_help != null && vodList_help.size() == 2)
    {
    	  HashMap  newFilmMap = (HashMap)vodList_help.get(0);
    	  int	countTotal = ((Integer) newFilmMap.get("COUNTTOTAL")).intValue();
    	  tepTypeVod.put("count",countTotal);
    
    	 	List vodList_help_name = new ArrayList();
  	    List vodList_help_url = new ArrayList();
  	
  	    List realVodList_help = (List) vodList_help.get(1);
  	    
            for (Iterator iterator = realVodList_help.iterator(); iterator.hasNext();) 
       	    {
       	        HashMap tmp = new HashMap();
       	   	    Map vod = (Map) iterator.next();
       	   	 
       	   	    tmp.put("name" , vod.get("VODNAME"));
       	   	    
       	   	    int tmpVodID=(Integer)vod.get("VODID");
       	   	    
       	   	  // String temUrl= getTriggerUrl(serviceHelp, Integer.parseInt(tmpVodID));
       	   	  String temUrl= getTriggerUrl(serviceHelp, tmpVodID);      	   	       	   	
       	   	  String playByThis="";
       	   	  
       	   	  if(!"".equals(temUrl))
       	   	  {
       	   	  playByThis ="{mediaUrl:'"+temUrl;
      playByThis += "',mediaCode: 'jsoncode1',mediaType:2,audioType:1,videoType:1,streamType:1,drmType:1,fingerPrint:0,copyProtection:1,allowTrickmode:1,startTime:0,endTime:10000.3,entryID:'jsonentry1'}"; 
       	   	   } 
       	   	   // String temUrl="HD_vodDetail.jsp?PROGID="+vod.get("VODID");
       	   	    tmp.put("url" , playByThis);	   
       	   	                    
                maxVodTypeListTmp.add(tmp);
       	    }
			}
			else
			{
				 tepTypeVod.put("count","");
			}
			tepTypeVod.put("sub",maxVodTypeListTmp);
			tepTypeVod.put("title",helpTitle);
			tepTypeVod.put("info",helpMessage);
			wholeVodTypeList.add(tepTypeVod);	
			
			JSONArray  jsonObject = JSONArray.fromObject(wholeVodTypeList);
			//System.out.println("HD_help date:::::::::::::::::::::"+jsonObject.toString());    						
			out.print(jsonObject.toString());   


%>