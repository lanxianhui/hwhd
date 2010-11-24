<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.bestv.epg.util.WordUtil" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGSysParam"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.func.UserBookmark" %>
<%@ page import="com.huawei.iptvmw.epg.facade.service.BookmarkImpl" %>
<%@ page import="com.huawei.iptvmw.facade.bean.info.BookmarkItem" %>
<%@ include file="HD_GetPosterPathFunction.jsp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="HD_substringUtil.jsp" %>
<%
    ArrayList dataList = new ArrayList();
    
    ServiceHelp serviceHelp = new ServiceHelp(request);
    MetaData metaData = new MetaData(request);
	  ArrayList result = null;
	  HashMap item = null;
	  int countTotal = 0;
	  //UserBookmark bookmark = new UserBookmark(request);
	 //  ArrayList bookmarkList = bookmark.getBookmarkList();
	  BookmarkImpl bookmark = new BookmarkImpl(request);
	  
	   List<BookmarkItem> bookmarkList = bookmark.getList();
	 //  System.out.println("bookmarkList::::::::::::::::"+bookmarkList);
	   
	 
	  
	  int bookMarkLimit = serviceHelp.getBookmarkLimit();

	  
	  if(bookmarkList == null)
	  {
		  return;
	  }
	  else
	  {
		  countTotal = bookmarkList.size();
		  //result = (ArrayList)bookmarkList;
	  }

//System.out.println("DOGCAI:"+bookmarkList);

    if(countTotal >0)
	  {
	
		  for(int i=0;i<countTotal;i++)
		  {
		   
		    HashMap hm = new HashMap();
		    
  			String tempProgId   = (String)((BookmarkItem)bookmarkList.get(i)).getContentId();
  			hm.put("PROGID" , tempProgId);
  			//String tempProgType = (String)((BookmarkItem)bookmarkList.get(i)).getName();
  			hm.put("PROGTYPE" , "0");
  			String tempProgName = (String)((BookmarkItem)bookmarkList.get(i)).getName();
  			hm.put("PROGFULLNAME" , tempProgName);
  			String tempProgName_cut = WordUtil.subWord(tempProgName , 500 , "24px", (Map) application.getAttribute("SUB_STRING_MAP"));
  			hm.put("PROGNAME" , tempProgName_cut);  			
  			String strTemp = "HD_vodDetail.jsp?PROGID=" + tempProgId;
  			hm.put("CLICKURL" , strTemp);
  			String tempSuperVod = (String)((BookmarkItem)bookmarkList.get(i)).getSuperVodId();
  			String strDel = "HD_bookMarkAction.jsp?ACTION=delete&PROGID=" + tempProgId+"&SUPVODID="+tempSuperVod; 
  			hm.put("DELETEURL" , strDel); 			
  	
  			 /*
  			HashMap hm = new HashMap();
  			String tempProgId   = bookmarkList.getContentId();
  			hm.put("PROGID" , tempProgId);
  			//String tempProgType = result.getContentId();
  		//	hm.put("PROGTYPE" , tempProgType);
  			String tempProgName = bookmarkList.getName();
  			hm.put("PROGFULLNAME" , tempProgName);
  			String tempProgName_cut = WordUtil.subWord(tempProgName , 500 , "24px", (Map) application.getAttribute("SUB_STRING_MAP"));
  			hm.put("PROGNAME" , tempProgName_cut);  			
  			String strTemp = "HD_vodDetail.jsp?PROGID=" + tempProgId;
  			hm.put("CLICKURL" , strTemp);  
  			String tempFatherId = result.getSuperVodId();
  			String strDel = "HD_bookMarkAction.jsp?ACTION=delete&PROGID=" + tempProgId+"&SUPVODID="+tempFatherId; 
  			hm.put("DELETEURL" , strDel);
  					*/
  			//add bookmark's poster
  		 HashMap filmInfoMap = (HashMap) metaData.getVodDetailInfo(Integer.parseInt(tempProgId));
  		  // System.out.println("filmInfoMap:::::::::::::"+filmInfoMap+":::::::::tempProgId::::::::"+tempProgId);
  		       String[] strPicPath = null;
        if (filmInfoMap != null) {
            HashMap posterMap = (HashMap) filmInfoMap.get("POSTERPATHS");
            int posterFlag  = 0;
            int displayFlag = 0;
            strPicPath = GetPosterPathFunction(posterMap, posterFlag, displayFlag);
            if (strPicPath == null || strPicPath.length == 0) {
                strPicPath = new String[] { "images/vod/default.jpg" } ;
            }
            hm.put("SMALLPIC" , strPicPath[0]);
                     
        }
  			
  			dataList.add(hm);
		 }
	 }
    
   JSONArray  jsonObject = JSONArray.fromObject(dataList);
   //System.out.println(jsonObject.toString());    	
	 // System.out.println("xinshanwu---------------------------book");  					
	 out.print(jsonObject.toString());   
%>