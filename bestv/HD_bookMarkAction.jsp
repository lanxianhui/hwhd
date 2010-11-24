<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.bean.func.UserBookmark" %>
<%@ page import="com.huawei.iptvmw.epg.facade.service.BookmarkImpl" %>
<%@ page import="com.huawei.iptvmw.facade.bean.info.BookmarkItem" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="java.util.*" %>
<%
	  ServiceHelp serviceHelp = new ServiceHelp(request);
	  MetaData meta = new MetaData(request);
	  UserBookmark bookmark = new UserBookmark(request);
	  
	   BookmarkImpl bookmarkDel = new BookmarkImpl(request);
    String action = request.getParameter("ACTION");    
	  ArrayList bookmarkList = new ArrayList();
	  
	  
    //如果action为空，提示出错
    if(action == null || action.length() == 0)
    {
        out.write("-1");
        return;         //action缺失
    }
    
    String progId = request.getParameter("PROGID"); 
    
    String supVodId = request.getParameter("SUPVODID");
     
    //加入书签
    if(action.equals("insert"))
    {
        String beginTime = request.getParameter("BEGINTIME");
		    String endTime = request.getParameter("ENDTIME");
			  //onekeySwitchTurnPage参数，包含添加完书签后需要跳转的页面URL
		    String tempURL = request.getQueryString();
		    
		   // System.out.println("tempURL:::::::::::::::0824"+tempURL);
		    
		    int index = tempURL.indexOf("onekeySwitchTurnPage=");
		    int templength = "onekeySwitchTurnPage=".length();
		    String onekeySwitchTurnPage = "";
		    StringBuffer xml = new StringBuffer();
		    if(index!=-1)
		    {
		      onekeySwitchTurnPage = tempURL.substring(index+templength);
		    }     	
        //书签的上限
		    int bookmarkSize = serviceHelp.getBookmarkLimit();
        //当书签的最大容量为0或缺少参数时，增加出错提示信息
        if(progId == null || beginTime == null || endTime==null || bookmarkSize==0)
		    {
		    		  xml.append("<?xml version='1.0' ?>");
			  		  xml.append("<subject>");
           		xml.append("<subnum>"); 
           		xml.append("-2");     
           		xml.append("</subnum>");  
           		xml.append("</subject>"); 
       				response.setContentType("text/xml;charset=UTF8");
       			  response.setHeader("Cache-Control", "no-cache"); 
       			  response.setHeader("pragma","no-cache");
       			  response.getWriter().write(xml.toString());	 	
       			   //System.out.println("-----------(-2)"); 	
		       // out.write("-2");
            return; //参数缺失 
		    }
             
		    int tempcountTotal =0; 
		    ArrayList tempList = bookmark.getBookmarkList();
        if(tempList != null )
        {
			    HashMap temp = (HashMap)tempList.get(0);
			    tempcountTotal = ((Integer)temp.get("COUNTTOTAL")).intValue();
	      }
			  //用户已有的书签大于书签的上限时报错
		    if(tempList != null)
        {
            if(tempcountTotal >= bookmarkSize)
            {
              xml.append("<?xml version='1.0' ?>");
			  		  xml.append("<subject>");
           		xml.append("<subnum>"); 
           		xml.append("-3");     
           		xml.append("</subnum>");  
           		xml.append("</subject>"); 
       				response.setContentType("text/xml;charset=UTF8");
       			  response.setHeader("Cache-Control", "no-cache"); 
       			  response.setHeader("pragma","no-cache");
       			  response.getWriter().write(xml.toString());	 	
       			   //System.out.println("-----------(-3)"); 	
              //  out.write("-3");
                return;  //用户书签已满 
            }
        }
        boolean ret ;
             System.out.println("supVodId insert:::::::::::::::0831"+supVodId);
       ret = bookmarkDel.addItem(progId, beginTime, endTime, supVodId);
        
        /*
          if (null != supVodId) {
         // System.out.println("this is right place!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");   
           ret = bookmark.saveBookmark(progId,beginTime,endTime,supVodId);
          
        } else {
        	//System.out.println("this is wrong place!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        	  ret = bookmark.saveBookmark(progId,beginTime,endTime,null);
           
        }
        */

        if( ret == false )
        {
        		  xml.append("<?xml version='1.0' ?>");
			  		  xml.append("<subject>");
           		xml.append("<subnum>"); 
           		xml.append("-4");     
           		xml.append("</subnum>");  
           		xml.append("</subject>"); 
       				response.setContentType("text/xml;charset=UTF8");
       			  response.setHeader("Cache-Control", "no-cache"); 
       			  response.setHeader("pragma","no-cache");
       			  response.getWriter().write(xml.toString());	 	
           // out.write("-4");
            //System.out.println("-----------(-4)"); 	
            return;      //添加用户书签失败 
        }
        else
        {
       // System.out.println("this is insert right::::::::::::::::::::::::::::::::::::::::::::::::::::"); 	
        		  xml.append("<?xml version='1.0' ?>");
			  		  xml.append("<subject>");
           		xml.append("<subnum>"); 
           		xml.append("0");     
           		xml.append("</subnum>");  
           		xml.append("</subject>"); 
       				response.setContentType("text/xml;charset=UTF8");
       			  response.setHeader("Cache-Control", "no-cache"); 
       			  response.setHeader("pragma","no-cache");
       			  response.getWriter().write(xml.toString());	
       			 //System.out.println("-----------0"); 	
           // out.write("0");
            return;      //添加用户书签成功     
        }
    }
		
    //删除某个书签
    if(action.equals("delete"))
    {
       //得到增加删除字串
       StringBuffer xml = new StringBuffer();
       if(progId == null)
       {
       		 		xml.append("<?xml version='1.0' ?>");
			  		  xml.append("<subject>");
           		xml.append("<subnum>"); 
           		xml.append("-2");     
           		xml.append("</subnum>");  
           		xml.append("</subject>"); 
       				response.setContentType("text/xml;charset=UTF8");
       			  response.setHeader("Cache-Control", "no-cache"); 
       			  response.setHeader("pragma","no-cache");
       			  response.getWriter().write(xml.toString());	 	
       			  // System.out.println("-----------(-2)"); 	
          //  out.write("-2");
            return;     //参数缺失 
       }
      // boolean ret = bookmark.delBookmark(progId);
      
      //删除书签
      BookmarkItem item = new BookmarkItem();

    List<BookmarkItem> delList = new ArrayList<BookmarkItem>();
    item.setContentId(progId);
    item.setSuperVodId(supVodId);
    
     System.out.println("supVodId:::::::::::::::0831"+supVodId);
    
    delList.add(item);
    boolean ret = bookmarkDel.deleteItems(delList);
      
      
       if( ret == false )
       {
       			 xml.append("<?xml version='1.0' ?>");
			  		 xml.append("<subject>");
           	 xml.append("<subnum>"); 
           	 xml.append("-4");     
           	 xml.append("</subnum>");  
           	 xml.append("</subject>"); 
       			 response.setContentType("text/xml;charset=UTF8");
       			 response.setHeader("Cache-Control", "no-cache"); 
       			 response.setHeader("pragma","no-cache");
       			 response.getWriter().write(xml.toString());	 	
       			// System.out.println("-----------(-4)"); 	
           // out.write("-4");    
            return;     //删除用户书签失败 
       }
       else
       {     
       			  xml.append("<?xml version='1.0' ?>");
			  		  xml.append("<subject>");
           		xml.append("<subnum>"); 
           		xml.append("0");     
           		xml.append("</subnum>");  
           		xml.append("</subject>"); 
       				response.setContentType("text/xml;charset=UTF8");
       			  response.setHeader("Cache-Control", "no-cache"); 
       			  response.setHeader("pragma","no-cache");
       			  response.getWriter().write(xml.toString());	 	
       			 //  System.out.println("-----------(0)"); 	
           // out.write("0");
            return;     //删除用户书签成功 
       }
    }
    
    //清空所有的书签
    if(action.equals("clearAll"))
    {    
        ArrayList tmpList = bookmark.getBookmarkList();
        if(tmpList == null)
        {
            out.write("-5");
            return;     //获取用户书签列表失败
        }     
        else
        { 
            if(bookmark.clearAll())
            {
                out.write("-4");
                return; //清空用户书签失败
            }
            else {
            	  out.write("0");
                return; //清空用户书签成功
            }
        }
    }
    
    JSONArray jsonObject = JSONArray.fromObject(bookmarkList);	
   // System.out.println(jsonObject.toString());  
   // System.out.println("-----------xinsw----------------ok");  						
	  out.write(jsonObject.toString());
   
%>