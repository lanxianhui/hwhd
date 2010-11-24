<%-- Created By Caiyuhong 2010-04-21--%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="javax.servlet.http.*" %> 
<%@ page import="java.util.*" %>
<%@ include file="HD_vodBasicInfo.jsp" %>

<%!    
    public ArrayList getCrossFilms(HttpSession session , HttpServletRequest request , ServiceHelp serviceHelp , MetaData metaData , String strFilmId) {
    
        HashMap filmInfoMap = (HashMap) metaData.getVodDetailInfo(Integer.parseInt(strFilmId));
        if (null == filmInfoMap) return null;
        Object genre = filmInfoMap.get("GENRE");
        if(null == genre) return null;
        
        ArrayList finalData = new ArrayList();
        HashMap keys = new HashMap();      
        String[] strGenre = (String[])genre;
        for(int i = 0; i < strGenre.length ; i ++ ) {
            ArrayList al = (ArrayList)serviceHelp.searchFilmsByGenre(strGenre[i] , 0 , 10);
            if(al != null && al.size() == 2) al = (ArrayList)al.get(1);
            for(int j = 0 ; j < al.size() ; j++ ) {
                HashMap slot = (HashMap)al.get(j);
                String keyid = slot.get("VODID").toString();
                if(strFilmId.equals(keyid) || keys.containsKey(keyid)) continue;
                else keys.put( keyid , "0");
                HashMap tmp = getVodBasicInfo(session , request , serviceHelp , metaData , slot.get("VODID").toString() , null);
                if(tmp != null) finalData.add(tmp);
            }
        }
        return finalData;
    }   
    
      public ArrayList getRecomandFilms(HttpSession session , HttpServletRequest request , ServiceHelp serviceHelp , MetaData metaData , String vodRecommandTypeId,String vodRecommandCount) 
      {
      if("".equals(vodRecommandCount)||"null".equals(vodRecommandCount)||null == vodRecommandCount)
      {
      vodRecommandCount="0";
      }
    
        ArrayList  tmpDate = metaData.getVodListByTypeId(vodRecommandTypeId,Integer.parseInt(vodRecommandCount), 0);
        ArrayList finalData = new ArrayList();
        if(tmpDate != null && tmpDate.size() == 2)
      {
         List realVodList = (List) tmpDate.get(1);
         for (Iterator iterator = realVodList.iterator(); iterator.hasNext();) 
       	    {
       	        Map vod = (Map) iterator.next();
       	   	    String tmpVodID= vod.get("VODID").toString();
       	   	    HashMap tmp = getVodBasicInfo(session , request , serviceHelp , metaData , tmpVodID , null);
                if(tmp != null) finalData.add(tmp);
       	    }
      }
        return finalData;
    } 
%>