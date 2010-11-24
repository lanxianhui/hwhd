<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.bestv.epg.util.WordUtil" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGSysParam"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.func.UserBookmark" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ include file="HD_GetPosterPathFunction.jsp" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="HD_substringUtil.jsp" %>
<%
    ArrayList dataList = new ArrayList();
    
    ServiceHelp serviceHelp = new ServiceHelp(request);
     MetaData metaData = new MetaData(request);
	  HashMap item = null;
	  int countTotal = 0;
	  
	  ArrayList result = serviceHelp.getFavList();   
    ArrayList favoList = null;
    if(result !=null && result.size()>1 ) {
       favoList = (ArrayList)result.get(1);      
    }else {
    	 return;
    }

    if (favoList != null && favoList.size() > 0)
    {
        for (int i = 0; i < favoList.size(); i++)
        {
            HashMap hmap = new HashMap();
        	  item = (HashMap)favoList.get(i);
            int prog_id = ((Integer)item.get("PROG_ID")).intValue();
            hmap.put("PROGID" , String.valueOf(prog_id));
            int prog_type = ((Integer)item.get("PROG_TYPE")).intValue();
            hmap.put("PROGTYPE" , String.valueOf(prog_type));
            hmap.put("PROGNAME" , (String)item.get("PROG_NAME"));
            hmap.put("PROGDELETEURL" , "HD_favoAction.jsp?ACTION=delete&PROGID=" + prog_id + "&PROGTYPE=" + prog_type);
            
            		//add favo's poster
  		 HashMap filmInfoMap = (HashMap) metaData.getVodDetailInfo(prog_id);
  		 //  System.out.println("filmInfoMap:::::::::::::"+filmInfoMap+":::::::::tempProgId::::::::"+tempProgId);
  		       String[] strPicPath = null;
        if (filmInfoMap != null) {
            HashMap posterMap = (HashMap) filmInfoMap.get("POSTERPATHS");
            int posterFlag  = 0;
            int displayFlag = 0;
            strPicPath = GetPosterPathFunction(posterMap, posterFlag, displayFlag);
            if (strPicPath == null || strPicPath.length == 0) {
                strPicPath = new String[] { "images/vod/default.jpg" } ;
            }
            hmap.put("SMALLPIC" , strPicPath[0]);
                     
        }

            dataList.add(hmap);
            countTotal++;
        }
    }else {
    	  return;
    }	
    
   JSONArray  jsonObject = JSONArray.fromObject(dataList);
   //System.out.println(jsonObject.toString());    						
	 out.print(jsonObject.toString()); 
	 
	// System.out.println("gogogogog");  
%>