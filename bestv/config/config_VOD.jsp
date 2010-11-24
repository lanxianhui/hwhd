<%@ page import="com.bestv.epg.util.MessageUtil" %>
<%!
    /***************special******************************/

    protected static String VOD_SPECIAL_ACCESSID = "1336";  //专题点播入口ID(现场ID1336)

    protected static String VOD_SPECIAL_TYPEID = "1961";  //专题点播获取数据的栏目ID(1961)

    protected static String VOD_KANDAPIAN_TYPEID = "2420";  //看大片栏目ID

    protected static String VOD_TVS_TYPEID = "1340";    //TVS栏目ID

    protected static String VOD_TVS_ALL_TYPEID = "3035";    //TVS全部栏目ID

%>
<%
    String DEFAULT_SUBJECTID_VOD = MessageUtil.getMessage(session, "category_dianying");

    java.util.Map type_Map = new java.util.HashMap();
    //VOD详情，连续剧详情页面右边更多外部链接的图片
    String pic_onMoreSpecil = "images/display/vod/common/onmoreSpecial.gif";
    String pic_offMoreSpecil = "images/display/vod/common/offmoreSpecial.gif";
    //VOD详情，连续剧详情页面右边更多外部链接的地址
    String url_moreSpecil_add = "vod_Special.jsp?STATION=0&ISFIRST=1&need_Get=1&TYPE_ID=" + VOD_SPECIAL_TYPEID;
    type_Map.put("00101", pic_onMoreSpecil);
    type_Map.put("00102", pic_offMoreSpecil);
    type_Map.put("002", url_moreSpecil_add);
%>