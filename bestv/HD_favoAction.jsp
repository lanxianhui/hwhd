<%-- Copyright (C), Bestv Tech. Co., Ltd. --%>
<%-- CreateAt:2010-04-08 --%>
<%-- FileName:HD_favoAction.jsp--%>

<%--ACTION          执行的动作，可选值:   insert  delete  clearall
    FAVLIST         收藏夹对象 ArrayList
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil" %>

<%
    
    ServiceHelp serviceHelp = new ServiceHelp(request);
    UserProfile userInfo = new UserProfile(request);
    TurnPage turnPage = new TurnPage(request);
    String action = request.getParameter("ACTION");
 
    
 		//ArrayList favRec = new ArrayList();
	  //HashMap item = null;
    
    
    //如果action为空，提示出错
    if(action == null || action.length() == 0) {
        out.write("1");
				return;
    }
    
    
  
   
    if(action.equals("insert")) {
        //得到增加删除字符串
        String progId = request.getParameter("PROGID");
        String progType = request.getParameter("PROGTYPE");
        //收藏夹容量
        int favoSize = serviceHelp.getFavouriteLimit();
        //保存修改
        List userFavo= userInfo.getFavorite();
        StringBuffer xml = new StringBuffer();

        //当收藏夹最大容量为0时，增加出错提示信息
        if(progId == null ||progType == null || favoSize == 0) {
						//item.put("rec" , -1);
	     		  //favRec.add(item);
	     		  //JSONArray  jsonObject = JSONArray.fromObject(favRec);
	      	  //out.print(jsonObject.toString()); 
	          //out.print("2");
	            xml.append("<?xml version='1.0' ?>");
			  		  xml.append("<subject>");
           		xml.append("<subnum>"); 
           		xml.append("2");     
           		xml.append("</subnum>");  
           		xml.append("</subject>"); 
       				response.setContentType("text/xml;charset=UTF8");
       			  response.setHeader("Cache-Control", "no-cache"); 
       			  response.setHeader("pragma","no-cache");//保持向后兼容
		        //页面不再缓存
       			  response.getWriter().write(xml.toString());	 	
             return;
        }
        
        if(userFavo != null) {
            if(userFavo.size() >= favoSize)
            {
         //  	session.setAttribute("favoRec", "3");
	   		//   flag = "1";
               // out.print("3");
              xml.append("<?xml version='1.0' ?>");
			  		  xml.append("<subject>");
           		xml.append("<subnum>"); 
           		xml.append("1");     
           		xml.append("</subnum>");  
           		xml.append("</subject>"); 
       				response.setContentType("text/xml;charset=UTF8");
       			  response.setHeader("Cache-Control", "no-cache"); 
       			  response.setHeader("pragma","no-cache");
       			  response.getWriter().write(xml.toString());	 	
              return;
            }
        }
        
        boolean ret = serviceHelp.insFavItem(progId,progType);
        if( ret == false ) {
     				//session.setAttribute("favoRec", "4");
	    	 		// flag = "1";
         		//out.print("4");
         		  xml.append("<?xml version='1.0' ?>");
			  		  xml.append("<subject>");
           		xml.append("<subnum>"); 
           		xml.append("4");     
           		xml.append("</subnum>");  
           		xml.append("</subject>"); 
       				response.setContentType("text/xml;charset=UTF8");
       			  response.setHeader("Cache-Control", "no-cache"); 
       			  response.setHeader("pragma","no-cache");
       			  response.getWriter().write(xml.toString());	 	
					 return;
        }else {  
        	//  session.setAttribute("favoRec", "0");
	   			//   flag = "1";
          //  out.write("0");  
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
        }
        
        // System.out.println("action::::::::::"+action+":::::::ret::::::::"+ret); 
    }
     //  删除收藏夹中的某部节目
    
    if(action.equals("delete"))
    {
        //得到增加删除字符串
        String progId = request.getParameter("PROGID");
        String progType = request.getParameter("PROGTYPE");
        StringBuffer xml = new StringBuffer();
        if(progId == null ||progType== null ) {
         /*  out.write("2");
          // System.out.println("-------xinsw---2");  */
           	  xml.append("<?xml version='1.0' ?>");
			  		  xml.append("<subject>");
           		xml.append("<subnum>"); 
           		xml.append("2");     
           		xml.append("</subnum>");  
           		xml.append("</subject>"); 
       				response.setContentType("text/xml;charset=UTF8");
       			  response.setHeader("Cache-Control", "no-cache"); 
       			  response.setHeader("pragma","no-cache");//保持向后兼容
		        //页面不再缓存
       			  response.getWriter().write(xml.toString());	 	
           return;
        }
       
        boolean ret = serviceHelp.delFavItem(progId,progType);
        if( ret == false )
        {
          	 xml.append("<?xml version='1.0' ?>");
			  		  xml.append("<subject>");
           		xml.append("<subnum>"); 
           		xml.append("4");     
           		xml.append("</subnum>");  
           		xml.append("</subject>"); 
       				response.setContentType("text/xml;charset=UTF8");
       			  response.setHeader("Cache-Control", "no-cache"); 
       			  response.setHeader("pragma","no-cache");//保持向后兼容
		        //页面不再缓存
       			  response.getWriter().write(xml.toString());	 	
           return;
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
       			  response.setHeader("pragma","no-cache");//保持向后兼容
		        //页面不再缓存
       			  response.getWriter().write(xml.toString());	 	
           return;
        }
       
    }
    
    if(action.equals("clearAll"))
    {                 
        List tmpList = userInfo.getFavorite();
        if(tmpList == null)
        {
           out.write("5");
           return;
        }     
        else
        { 
            if(serviceHelp.clearAllFavo())
            {
               out.write("0");
               return;
            }
            else
            {
               out.write("4");
               return;
            }
        }   
    }
    
    //自动添加最新一条记录，删除最早的记录
   if(action.equals("autoUpdate"))
   {
       // 得到增加删除字符串
       boolean ret = serviceHelp.isFavoFull();
       if(ret == false)
       {              
           out.write("4");
           return;
       }

       String addProgId = request.getParameter("PROGID");        
       String addProgType = request.getParameter("PROGTYPE");
       
       ArrayList favList = serviceHelp.getFavList();
       String delProgId ="";
       String delProgType ="";
       if(favList!=null && favList.size()>1 )
       {
          ArrayList tmpList = (ArrayList)favList.get(1);
          int lastIndex =  tmpList.size() -1;
          HashMap map = (HashMap )tmpList.get(lastIndex);
          delProgId = String.valueOf(map.get("PROG_ID"));
          delProgType = String.valueOf(map.get("PROG_TYPE"));        
       }
   
       if(addProgId == null ||addProgType== null ||delProgId==null || delProgType==null )
       {
           out.write("2");
           return;
       }
      
       ret = serviceHelp.delFavItem(delProgId,delProgType);
       if( ret == false )
       {
           out.write("4");
           return;
       }      
       ret = serviceHelp.insFavItem(addProgId,addProgType);
       if( ret == false )
       {
           out.write("4");
           return;
       }
       else
       {           
           out.write("0");
           return;           
       }
   }     
//		System.out.println("-----------xinsw----------------ok");  
%> 







