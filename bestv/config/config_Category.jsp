<!-- 文件名：config_Category.jsp -->
<!-- 版 权：Copyright 2005-2007 Huawei Tech. Co. Ltd. All Rights Reserved. -->
<!-- 描 述：EPG首页配置文件 -->
<!-- 修改人：sunmofei -->
<!-- 修改时间：2009-2-10 -->
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants" %> 
<%@ include file="../MemToVas.jsp" %>
<%@ include file="config_ZT.jsp" %>
<%@ include file="config_VOD.jsp" %>
<%!
    final static int DEFAULT_HIDEINFO_TIME = 6000;                 //默认隐藏信息
    final static int IS_DEFINITION_OPENPLAY = 1;                  //0:直接开机播放，1：需要校验
    final static int DEFAULT_ALPHA = 75;                         //图片透明的

%>
<%
    //获取eog相关信息
    String epgUrl = getEpgInfo(request);
    //保存首页相关的配置信息
    //Map type_Map = new HashMap();

    //链接至直播频道列表页面的url
    String url_chan = MessageUtil.getMessage(session, "channel_portal");
    type_Map.put("005", url_chan);

    //链接至电视回看页面的url
    String url_tvod = "catchup_portal.jsp";
    type_Map.put("006", url_tvod);

    //链接至点播栏目列表页面的url
    String url_vod = "vod_Action.jsp?TYPE_ID=" + MessageUtil.getMessage(session, "category_dianying") + "&ISCATEGORY=1";
    type_Map.put("007", url_vod);

    //获取sessionID及用户ID
    String mac_ip = request.getRemoteAddr();
    String user_tokenID = session.getId();
    String user_id = (String) session.getAttribute("USERID");
    String tt_requestUrl = request.getRequestURL().toString();
    String category_url = tt_requestUrl.substring(0, tt_requestUrl.lastIndexOf("/") + 1) + "spToMem.jsp";
    String caijing_back_url = tt_requestUrl.substring(0, tt_requestUrl.lastIndexOf("/") + 1) + "IPTVFinance.jsp";
    String tese_endURL = tt_requestUrl.substring(0, tt_requestUrl.lastIndexOf("/") + 1) + "tese.jsp";
    String finance_enter_url = tt_requestUrl.substring(0, tt_requestUrl.lastIndexOf("/") + 1) + "FinanceRecProgTable.jsp?ISFIRST=1&chanId=128&chan_index=0";
    String vod_enter_url = tt_requestUrl.substring(0, tt_requestUrl.lastIndexOf("/") + 1) + "vod_Action.jsp?TYPE_ID=3094&subjectType=10|0|4|9999&thirdback=1";

    //链接至资讯页面的url
    //String url_info = "http://125.88.98.133:8000/v2/info/default.aspx?stb=huawei&user="+user_id+"&ip="+mac_ip+"&tokenID="+user_tokenID+"&endURL="+category_url+"?PREFOUCS=3"+"&finance_enter_url="+finance_enter_url+"&vod_enter_url="+vod_enter_url;//公网2.0测试使用
    String url_info = "http://125.88.98.140:9080/zzyw/zx_xw.jsp?user=" + user_id + "&endUrl=" + category_url;
    //"http://125.88.98.133:8000/huawei08264p1/default.aspx?stb=huawei&user="+user_id+"&ip="+mac_ip+"&tokenID="+user_tokenID+"&endURL="+category_url+"?PREFOUCS=3"+"&finance_enter_url="+finance_enter_url+"&vod_enter_url="+vod_enter_url;
    //公网1.0使用	
    type_Map.put("008", url_info);

    //链接至应用页面的url
    //String url_App = "http://125.88.98.133:8000/v2/app/default.aspx?stb=huawei&user="+user_id+"&ip="+mac_ip+"&tokenID="+user_tokenID+"&endURL="+category_url+"?PREFOUCS=4";//公网2.0测试使用
    String url_App = "http://125.88.98.140:9080/zzyw/dxcx.jsp?user=" + user_id + "&endUrl=" + category_url;
    //"http://125.88.98.133:8000/huawei08264p2/default.aspx?stb=huawei&user="+user_id+"&ip="+mac_ip+"&tokenID="+user_tokenID+"&endURL="+category_url+"?PREFOUCS=4";//公网1.0使用
    type_Map.put("009", url_App);

    //链接至玩吧页面的url
    String url_wanba = "http://125.88.98.140:9080/zzyw/wb.jsp?user=" + user_id + "&endUrl=" + category_url;

    //链接至收藏页面的url
    String url_Favo = "IPTVFavourite.jsp";
    type_Map.put("010", url_Favo);

    //链接至帮助页面的url
    String url_help = "IPTVHelp.jsp?TYPE_ID=1348";
    type_Map.put("011", url_help);

    //链接至首映专区页面的url
    String url_shouying = "zt_PremiereArea_ChargeShow.jsp?INPUTPATHTYPE=CategoryIndex";
    type_Map.put("012", url_shouying);

    //链接至新闻中心页面的url
    String url_Special = "http://125.88.96.19:81/vasroot/apps/APP_HQ_NEWS/news.php?controller=NewsItem&action=Index&epg_info=" + epgUrl;
    type_Map.put("013", url_Special);

    //链接至超级体育页面的url
    String url_SSport = "http://125.88.96.19:81/vasroot/apps/APP_HQ_SSport_0620/index.php?appcode=APP_HQ_SSport_0620&action=Index&epg_info=" + epgUrl;
    type_Map.put("014", url_SSport);

    //链接至24小时剧场页面的url
    String url_tvshow = "vod_Action.jsp?MainPage=0&INDEXPAGE=0&STATION=0&LENGTH=25&TYPE_ID=" + HOURSTHEATER_TYPEID + "&ISFIRST=1&subjectType=" + EPGConstants.SUBJECTTYPE_VOD + "|" + EPGConstants.SUBJECTTYPE_VIDEO_VOD + "|" + EPGConstants.SUBJECTTYPE_AUDIO_VOD + "|" + EPGConstants.SUBJECTTYPE_MIXED;
    type_Map.put("015", url_tvshow);

    //链接至哈哈乐园页面的url
    String url_HHLY = "special/zt_HHLY_Category.jsp";
    type_Map.put("016", url_HHLY);

    //链接至南方新媒体页面的url
    String url_tvs = "special/zt_TvsIndex.jsp?ISFIRST=1";
    type_Map.put("017", url_tvs);

    //链接至新华社新闻页面的url
    String url_xinhua = "special/zt_XinhuaNewsIndex.jsp";
    type_Map.put("018", url_xinhua);

    //链接至天气预报更多页面的url
    //String weather_url= "http://125.88.98.142:4400/newiptv_test/login.jsp?boxtype=huawei&user="+user_id+"&ip="+mac_ip+"&tokenID="+user_tokenID+"&endUrl="+category_url;    //"http://125.88.98.142:4400/newiptv/login.jsp?boxtype=huawei&user="+user_id+"&ip="+mac_ip+"&tokenID="+user_tokenID+"&endUrl="+category_url;
    String weather_url = "http://125.88.98.142:4400/wtv09/login.jsp?boxtype=huawei&endUrl=" + category_url;
    type_Map.put("068", weather_url);

    //链接至游戏中心的url
    //String game_url = "http://125.88.98.23/portal_2.0/list.jsp?user="+user_id+"&enterURL="+category_url+"&PREFOUCS=13";
    String game_url = "http://itv.chinagames.net/portal_2.0/list.jsp?user=" + user_id + "&enterURL=" + category_url + "&PREFOUCS=13";
    type_Map.put("080", game_url);

    //链接至社区的url
    String community_url = "http://125.88.98.140:9090/commu/index.jsp?endUrl=" + category_url;

    //vod_FilmDetailRightRightSubPage.jsp页面，更多专辑的图标和链接至更多专辑页面
    String pic_moreSpecil = "images/display/vod/vodFilmDetail/moreSpecial.gif";
    String url_moreSpecil = "Special.jsp?STATION=0&ISFIRST=1&need_Get=1";
    type_Map.put("027", pic_moreSpecil);
    type_Map.put("028", url_Special);

    //链接至财经频道
    String finance_enter_url_str = URLEncoder.encode(finance_enter_url, "UTF-8");
    String vod_enter_url_str = URLEncoder.encode(vod_enter_url, "UTF-8");
    String url_caijing_default = "http://125.88.98.133:4000/CaiJing2/Default.aspx?stb=huawei&user=" + user_id + "&ip=" + mac_ip + "&tokenID=" + user_tokenID + "&endURL=" + caijing_back_url + "&finance_enter_url=" + finance_enter_url_str + "&vod_enter_url=" + vod_enter_url_str;
    String url_info_zx = "http://125.88.98.140:9080/zzyw/zx_xw.jsp?user=" + user_id;
    String url_caijing_zx = "http://125.88.98.133:4000/CaiJing2/Default.aspx?stb=huawei&user=" + user_id + "&ip=" + mac_ip + "&tokenID=" + user_tokenID + "&endURL=" + url_info_zx + "&finance_enter_url=" + finance_enter_url_str + "&vod_enter_url=" + vod_enter_url_str;

    //娱乐 公网2.0测试
    String url_bestv_yule = "http://125.88.96.19:81/vasroot/apps/APP_HQ_CZMH/index.php?site=yule&epg_info=" + epgUrl;

    //09第三季度营销活动链接
    String url_season3_marketing = "http://125.88.98.140:9090/season3/index.jsp?user=" + user_id + "&endUrl=" + category_url;

    //guoqing60 zhudi update
    String guoqing60 = "http://125.88.98.140:9090/season3/gq/index.jsp?user=" + user_id + "&endUrl=" + category_url;

    String kanhushishare = "http://125.88.98.140:9090/season4/index.jsp?user=" + user_id + "&endUrl=" + category_url;

    String mianfeidapian = "http://125.88.98.140:9090/marketing/index.jsp?user=" + user_id + "&endUrl=" + category_url;

    String yqpdy = "http://125.88.98.140:9090/film/index.jsp?user=" + user_id + "&endUrl=" + category_url;

    String kpyjhd = "http://125.88.98.140:9090/season4/yx_index.jsp?user=" + user_id + "&endUrl=" + category_url;

    //深圳电信分组专用入口
    UserProfile userProfile = new UserProfile(request);
    String userGroupId = userProfile.getUserGroupId();
    String url_szdx = "http://119.147.52.183/SubSite/Default.aspx?userGroupId=" + userGroupId + "&itvUserId=" + user_id + "&endUrl=" + category_url;

%>
