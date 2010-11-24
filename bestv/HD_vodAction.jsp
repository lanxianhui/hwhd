<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<%@ page import="com.bestv.epg.util.WordUtil" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="java.util.*" %>
<%@page pageEncoding="UTF-8"%>

<%
    //获取类别参数
    String strTypeId = request.getParameter("TYPE_ID");
    HashMap jsonMap = new HashMap();
    //获取类别下的子集类别
    MetaData metaData = new MetaData(request);
    //对接新CMS适配，获取所有栏目
    int subType = metaData.getAllSubTypeOrVod(strTypeId);
    
		if(subType == EPGErrorCode.NO_CONTENT)
		{
		    jsonMap.put("CODE" , "-1" );
		}
		else if(subType == EPGConstants.TYPE_HASCHILDREN_NO)
		{
			  jsonMap.put("CODE" , "0" );
    }
		else if(subType == EPGConstants.TYPE_HASCHILDREN_YES)
		{
        jsonMap.put("CODE" , "1" );
        List categoryList = metaData.getTypeListByTypeId(strTypeId, 1000, 0);
        if (categoryList == null || categoryList.size() < 2) {
            out.write("");
            return;
        }
        int categoryCount = ((Integer) ((HashMap) categoryList.get(0)).get("COUNTTOTAL")).intValue();
        List realCategoryList = (List) categoryList.get(1);
        ArrayList al = new ArrayList();
        for (Iterator iterator = realCategoryList.iterator(); iterator.hasNext();) {
            Map category = (Map) iterator.next();
            HashMap categoryInfo = new HashMap();
            String tmpTypeId = (String) category.get("TYPE_ID");
            categoryInfo.put("CATEGORYID" , tmpTypeId );
            categoryInfo.put("CATEGORYNAME" , WordUtil.subWord((String) category.get("TYPE_NAME"), 36, "utf-8"));
            categoryInfo.put("CATEGORYFULLNAME" , category.get("TYPE_NAME"));
            categoryInfo.put("CATEGORYURL" , "HD_vodAction.jsp?TYPE_ID=" + tmpTypeId);
            al.add(categoryInfo);
        }
        jsonMap.put("VALUE" , al);
    }else {
    	  jsonMap.put("CODE" , "-2" );
    } 
    JSONArray jsonObject = JSONArray.fromObject(jsonMap);
    //System.out.println(jsonObject.toString());
	  out.print(jsonObject.toString());
%>