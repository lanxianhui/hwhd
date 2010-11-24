<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="java.util.*" %>
<%@ page import="com.bestv.epg.util.WordUtil" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://epg.bestv.com/tags" prefix="bestv" %>
<%
    String categoryId = request.getParameter("TYPE_ID");
    MetaData metaData = new MetaData(request);
    int station = 0;
    int length = 1000;
    
    int row_count = 0;
    
    ArrayList jsonList = new ArrayList();
    HashMap jsonMap = new HashMap();

    List categoryList = metaData.getTypeListByTypeId(categoryId, length, station);
    if (categoryList == null || categoryList.size() < 2) {
        out.write("");
        return;
    }
    int categoryCount = ((Integer) ((HashMap) categoryList.get(0)).get("COUNTTOTAL")).intValue();
    List realCategoryList = (List) categoryList.get(1);
    
    row_count = row_count + realCategoryList.size();

    for (Iterator iterator = realCategoryList.iterator(); iterator.hasNext();) {
        Map category = (Map) iterator.next();
        
        HashMap categoryInfo = new HashMap();
        String tmpTypeId = (String) category.get("TYPE_ID");

        categoryInfo.put("CATEGORYID" , tmpTypeId );
        categoryInfo.put("CATEGORYNAME" , WordUtil.subWord((String) category.get("TYPE_NAME"), 18, "utf-8"));
        categoryInfo.put("CATEGORYFULLNAME" , category.get("TYPE_NAME"));
        categoryInfo.put("CATEGORYURL" , "HD_vodAction.jsp?TYPE_ID=" + tmpTypeId);
        
        HashMap secondChild = new HashMap();
        List secondCategoryList = metaData.getTypeListByTypeId(tmpTypeId, length, station, null, 0);
        ArrayList secondList = new ArrayList();
                    
        if (secondCategoryList != null && secondCategoryList.size() >= 2) {
            List secondRealCategoryList = (List) categoryList.get(1);
            int tmpInt = secondRealCategoryList.size() % 3 == 0 ? secondRealCategoryList.size() / 3 : ( secondRealCategoryList.size() / 3 + 1 );
            row_count = row_count + tmpInt;

            for (Iterator secondIterator = secondRealCategoryList.iterator(); secondIterator.hasNext();) {
                Map secondCategory = (Map) secondIterator.next();
                HashMap secondCategoryInfo = new HashMap();
                
                tmpTypeId = (String) secondCategory.get("TYPE_ID");
                secondCategoryInfo.put("CATEGORYID" , tmpTypeId );
                secondCategoryInfo.put("CATEGORYNAME" , WordUtil.subWord((String) secondCategory.get("TYPE_NAME"), 18, "utf-8"));
                secondCategoryInfo.put("CATEGORYFULLNAME" , secondCategory.get("TYPE_NAME"));
                secondCategoryInfo.put("CATEGORYURL" ,"HD_vodAction.jsp?TYPE_ID=" + tmpTypeId);
                
                secondList.add(secondCategoryInfo);
            }
        }
        categoryInfo.put("CHILDINFO" , secondList);
        jsonList.add(categoryInfo);
    } 
    jsonList.add(String.valueOf(row_count));
    JSONArray jsonObject = JSONArray.fromObject(jsonList); 
    //System.out.println(jsonObject.toString());  						
	  out.print(jsonObject.toString());
%>