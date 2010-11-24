<%-- Created By Caiyuhong 2010-04-21--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="java.util.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="com.bestv.epg.util.MessageUtil" %>
<%@ include file="HD_crossFilmRules.jsp" %>

<%
	
    ServiceHelp serviceHelp = new ServiceHelp(request);
    MetaData metaData = new MetaData(request);
   
    String strFilmId = (String) request.getParameter("PROGID");
    int filmId = (strFilmId == null) ? -1 : Integer.parseInt(strFilmId);
    String strTypeId = (String) request.getParameter("TYPE_ID");
    
    ArrayList retData = new ArrayList();
    HashMap jsonMap = getVodBasicInfo(session , request , serviceHelp , metaData , strFilmId , strTypeId);
    //System.out.println(":::::::::::::::::::::::::::::jsonMap:::::::::::::::::::::::::::::::"+jsonMap);
    if(jsonMap == null) return;
     retData.add(jsonMap);
    
      ArrayList al = new ArrayList();
      String vodCrossFilmRules=MessageUtil.getMessage(session, "vod_crossFilmRules");
      //System.out.println("vodCrossFilmRules:::::::::::::"+vodCrossFilmRules);
	  
      if("1".equals(vodCrossFilmRules))
      {
		 al = getCrossFilms(session , request , serviceHelp , metaData , strFilmId);
      }
     else
     {		
       String vodRecommandTypeId=MessageUtil.getMessage(session, "vod_recommand_typeId");
       String vodRecommandCount=MessageUtil.getMessage(session, "vod_recommand_count");
      al = getRecomandFilms(session , request , serviceHelp , metaData , vodRecommandTypeId,vodRecommandCount);
     }
	
   //System.out.println("al:++++++++:"+al); 
    if(null != al && al.size() != 0) retData.addAll(al);
    
    JSONArray jsonObject = JSONArray.fromObject(retData); 
	//System.out.println("HD_VODCdetailInfo:::::::::::::::"+jsonObject.toString());  						
	  out.print(jsonObject.toString());

%>
