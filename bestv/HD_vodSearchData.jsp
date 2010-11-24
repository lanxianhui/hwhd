<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String keyword = request.getParameter("keyword");
    String searchFlag = request.getParameter("searchFlag");
    int flag = Integer.parseInt(searchFlag);

    ServiceHelp serviceHelp = new ServiceHelp(request);
    List vodSearchResult = new ArrayList();
    
    if(flag == EPGConstants.SEARCHFILMS_BY_CODE) {
        if(keyword.matches("[\\u4E00-\\u9FA5]+")) {
            flag = EPGConstants.SEARCHFILMS_BY_NAME;
        } 
    }
    int station = 0;
    int length = 300;
    
    switch (flag) {
        case EPGConstants.SEARCH_DIRECTORS: //搜索导演
        {
            break;
        }
        case EPGConstants.SEARCHFILMS_BY_DIRECTORS: //按导演查影片
        {
            List result = serviceHelp.searchFilmsByDirector(keyword.trim().toLowerCase(), station, length);
            if (result != null && result.size() == 2) {
                vodSearchResult = (List) result.get(1);
            }
            break;
        }
        case EPGConstants.SEARCH_ACTORS: //搜索演员
        {
            break;
        }
        case EPGConstants.SEARCHFILMS_BY_ACTORS: //按演员查影片
        {
            List result = serviceHelp.searchFilmsByActor(keyword.trim().toLowerCase(), station, length);
            if (result != null && result.size() == 2) {
                vodSearchResult = (List) result.get(1);
            }
            break;
        }
        case EPGConstants.SEARCHFILMS_BY_NAME: //按影片名查影片
        {
            List result = serviceHelp.searchFilmsByName(keyword.trim(), station, length);
            if (result != null && result.size() == 2) {
                vodSearchResult = (List) result.get(1);
            }
            break;
        }
        case EPGConstants.SEARCHFILMS_BY_CODE: //按影片代码查询影片
        {
            List result = serviceHelp.searchFilmsByCode(keyword.trim().toLowerCase(), station, length);
            if (result != null && result.size() == 2) {
                vodSearchResult = (List) result.get(1);
            }
            break;
        }
        case EPGConstants.SEARCHFILMS_BY_ID: //按影片ID查询影片
        {
            break;
        }
        default: {
            break;
        }
    }
    
    JSONArray jsonObject = JSONArray.fromObject(vodSearchResult); 
    //System.out.println(jsonObject.toString());  						
	out.print(jsonObject.toString());
%>