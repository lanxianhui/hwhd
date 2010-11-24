<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="java.util.*" %>
<%@ page import="com.bestv.epg.util.WordUtil" %>
<%@ page import="com.bestv.epg.util.MessageUtil" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    public static int VODSNUMBER = 18;
%>
<%
    String categoryId = request.getParameter("TYPE_ID");
    String method     = request.getParameter("METHOD");
    MetaData metaData = new MetaData(request);
    int station = 0;
    int length = 1000;
    
    int row_count = 0;
    
    ArrayList jsonList = new ArrayList();
    HashMap jsonMap = new HashMap();

    List realCategoryList = new ArrayList();
    int categoryCount = -1;
    
    if(method == null || !"config".equals(method)) {
        List categoryList = metaData.getTypeListByTypeId(categoryId, length, station);
        if (categoryList == null || categoryList.size() < 2) {
            out.write("");
            return;
        }
        categoryCount = ((Integer) ((HashMap) categoryList.get(0)).get("COUNTTOTAL")).intValue();
        realCategoryList = (List) categoryList.get(1);
    } else {
        for(int i = 0;i < VODSNUMBER; i++)
        {
            String strtmp = "vod_category_"+ (i+1);
  	        String value  = MessageUtil.getMessage(session , strtmp);
  	        if(value == null) break;
  	        String[] strs = value.split("_");
  	        if(strs.length >= 2) {
                HashMap hm = new HashMap();
  	            hm.put("TYPE_NAME" , strs[0]);
  	            hm.put("TYPE_ID"   , strs[1]);
  	            realCategoryList.add(hm);
  	        }
  	    }
  	    categoryCount = realCategoryList.size();
    }
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
            List secondRealCategoryList = (List) secondCategoryList.get(1);
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
                secondCategoryInfo.put("CATEGORYDATA" ,new ArrayList());                
                secondList.add(secondCategoryInfo);
            }
        }
        categoryInfo.put("CHILDINFO" , secondList);
        if( secondList.size() > 0 || (method != null && "config".equals(method))) jsonList.add(categoryInfo);
        else {
        	row_count = row_count - 1; 
        }
    } 
    HashMap lm = new  HashMap();
    if(method == null || !"config".equals(method)) {
        lm.put("LINENUM" , String.valueOf(row_count));
        jsonList.add(lm);
    }
    JSONArray jsonObject = JSONArray.fromObject(jsonList); 
  //   System.out.println(jsonObject.toString());  						
	out.print(jsonObject.toString());
%>