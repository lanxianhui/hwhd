<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="java.util.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="com.bestv.epg.bean.Category" %>
<%@ page import="com.bestv.epg.ui.BaseUI" %>
<%@ page import="com.bestv.epg.util.MessageUtil" %>
<%@ page import="com.bestv.epg.bean.CategoryViewEntity" %>
<%@ page import="com.bestv.epg.exception.BestvEpgException" %>
<%@ page import="com.bestv.epg.ui.CategoryUI" %>
<%@ page buffer="32kb" %>

<%
   String positionCode = request.getParameter("POSITIONCODE");
   List subjectList = new ArrayList();
   int subjectCount = 0;
   try {
       Category category = (Category)
               new BaseUI(request.getSession().getServletContext()).getEntityByPositionCode("1", positionCode);      
       if(category != null) {
             subjectList = category.getItemList();
             subjectCount = subjectList.size();
       }
   } catch (BestvEpgException e) {
       e.printStackTrace();
   }
   
   ArrayList jsonData = new ArrayList();
   for (Iterator iterator = subjectList.iterator(); iterator.hasNext();) {
     HashMap subjectMap = new HashMap();
     
     CategoryViewEntity subject = (CategoryViewEntity) iterator.next();
     String mediaCode = subject.getEntityCode();
     BaseUI baseUI = new BaseUI(request.getSession().getServletContext(), mediaCode);
     
     String subjectPath = "";
     try {
       subjectPath = baseUI.getEntityContextPath();
     } catch (Exception e) {
       e.printStackTrace();
     }
     
     subjectMap.put("SUBJECTCODE" , subject.getEntityCode());
     subjectMap.put("SUBJECTNAME" , subject.getViewName());
     subjectMap.put("SUBJECTPIC" , "/EPG" + subjectPath + "/" + subject.getIconPath());     
     subjectMap.put("SUBJECTURL" , "HD_subject.jsp?mediaCode=" + subject.getEntityCode());
    
     jsonData.add(subjectMap);
   }  	
   
   JSONArray jsonObject = JSONArray.fromObject(jsonData);
    System.out.println("sub::::::::::::::"+jsonObject.toString());    						
	 out.print(jsonObject.toString());    
%>
