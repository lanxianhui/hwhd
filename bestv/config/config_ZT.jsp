<%-- FileName:config_ZT.jsp --%>
<%-- Copyright (C), Huawei Tech. Co., Ltd. --%>
<!-- Author:gaolei&ChengYong-->
<%-- CreateAt:2009-02-1 --%>
<%@ page import="java.util.*" %>

<%!
/***************欧洲足球********************/
	//欧洲足球的频道ID
	final static int EUROPEFOOTBALL_CHANNELID = 147;//现场ID 147

	
/***************新华社新闻********************/
	//时政栏目编号
	final static String CURRENT_AFFAIRS_ID = "1726"; //现场ID 1726
		
	//国际栏目编号
	protected static String CURRENT_INTERNATIONAL_ID = "1727";//现场ID 1727

	//财经栏目编号
	protected static String CURRENT_FINANCE_ID = "1728";//现场ID 1728
	
	//视频栏目编号
	protected static  String CURRENT_VIDEO_ID = "026"; //现场ID 1731

	//图片栏目编号
	protected static String CURRENT_PICTURE_ID = "1729";//现场ID 1729
	
	//新闻栏目编号
	protected static String CURRENT_NEWS_ID = "1730";//现场ID 1730
	
	//播放类型
	protected static int XINHUANEWS_PLAY_TYPE = 1;
		
	
/***************special********************
	说明：此处配置现在已经移动到同文件夹的config_VOD.jsp文件中
    protected static String VOD_SPECIAL_ACCESSID = "1336";  //专题点播入口ID(现场ID1336)
	
	protected static String VOD_SPECIAL_TYPEID = "002004";  //专题点播获取数据的栏目ID
	
***************24小时剧场********************/

	protected static String HOURSTHEATER_TYPEID = "1328";  //现场ID 1328


/***************特色节目********************/
	
	//天翼189trailer播放的vodID
	final static int TY189TRAILER_VODID = 1;
	
/***************南方TVS********************/	
	
	//首页TVS频道ID配置
	protected static String TVS1_CHANNNELID = "144";  //现场ID 144
	protected static String TVS2_CHANNNELID = "146";  //现场ID 146
	protected static String TVS3_CHANNNELID = "177";  //现场ID 177
	protected static String TVS4_CHANNNELID = "178";  //现场ID 178
	protected static String TVS5_CHANNNELID = "179";  //现场ID 179
	
	//过瘾剧场栏目ID
	protected static String TVS_GYJC_XOZID = "1702";  //现场ID 1702
	protected static String TVS_GYJC_CLKXID = "2525";
	protected static String TVS_GYJC_KXBID = "1703";
	protected static String TVS_GYJC_LMSXID = "2526";
	
	//真实现场栏目ID
	protected static String TVS_ZSXC_ZSGSID = "1701";  //现场ID 1701
	protected static String TVS_ZSXC_QQYXID = "2530";
	
	//七彩娱乐show栏目ID
	protected static String TVS_QCYL_HXBBID = "1698";  //现场ID 1698
	protected static String TVS_QCYL_NFSEMTDSID = "1699";
	protected static String TVS_QCYL_NFXSLMTDSID = "1697";
	protected static String TVS_QCYL_GPCHYID = "1696";
	
	//奇奇怪界栏目ID
	protected static String TVS_QQGJID = "2528";      //现场ID 2528
	
	//潮人馆栏目ID
	protected static String TVS_CRGID = "2527";        //现场ID 2527
	
	//独家专题栏目ID
	protected static String TVS_DJZTID = "2529";       //现场ID 2529
%>

<%
	Map zt_TeseMap = new HashMap();
	
	//返回路径调试
	String zt_requestUrl = request.getRequestURL().toString();
	String zt_mac_ip = request.getRemoteAddr();
	String zt_user_tokenID= session.getId();
   	String zt_user_id = (String)session.getAttribute("USERID");
	String zt_trans_url = zt_requestUrl.substring(0, zt_requestUrl.lastIndexOf("/")+1);
	String zt_trans_url_caijing = zt_trans_url.substring(0, zt_trans_url.lastIndexOf("/")+1) + "special";
	String zt_category_url= zt_trans_url+"category_Index.jsp";
   	String zt_finance_enter_url = zt_trans_url_caijing+"FinanceRecProgTable.jsp?ISFIRST=1&chanId=128&chan_index=0";
   	String zt_vod_enter_url = zt_trans_url_caijing+"zt_VodFilmList.jsp?TYPE_ID=1863";

	String zt_endURL = zt_requestUrl.substring(0, zt_requestUrl.lastIndexOf("/")+1) + "tese.jsp";

	String new_year_url = "http://125.88.98.133:4000/WebSiteOfSanChong/index.aspx?user="+zt_user_id+"&endUrl="+zt_endURL+"?PREFOUCS=1";
	
	String url_caijing = "http://125.88.98.133:4000/CaiJing2/Default.aspx?stb=huawei&user="+zt_user_id+"&ip="+zt_mac_ip+"&tokenID="+zt_user_tokenID+"&endURL="+zt_endURL+"?PREFOUCS=3"+"&finance_enter_url="+zt_finance_enter_url+"&vod_enter_url="+zt_vod_enter_url;
	
	

/***************特色节目********************/
	//方大同
	String tese_game_url = "special/zt_hw_fangdatong.jsp?ISFIRST=1&PREFOUCS=0";
	zt_TeseMap.put("001",tese_game_url);
	
	//天翼迎春
	String tese_stock_url = new_year_url;
	zt_TeseMap.put("002",tese_stock_url);
	
	//天翼呼唤你
	String tese_europefootball_url ="special/zt_hw_tianyi189_index.jsp?ISFIRST=1";
	zt_TeseMap.put("003",tese_europefootball_url);
	
	//股金纵横
	String tese_189_url = url_caijing;
	zt_TeseMap.put("004",tese_189_url);
	
	//欧洲足球
	String tese_vote_url = "special/zt_EuropeFootball.jsp?ISFIRST=1";
	zt_TeseMap.put("005",tese_vote_url); 
		

%>
<script>
/***************新华社新闻配置********************/

	//栏目链接数组
	var tempurllist = new Array();
	
	//时政栏目链接
	tempurllist[0] = "http://125.88.98.133:8883/ListOfNews.aspx?ColumnID=277";
	
	//国际栏目链接
	tempurllist[1] = "http://125.88.98.133:8883/ListOfNews.aspx?ColumnID=276";   
	
	//财经栏目链接
	tempurllist[2] = "http://125.88.98.133:8883/ListOfNews.aspx?ColumnID=275";
	
	//视频栏目链接
	tempurllist[3] = "special/zt_XinhuaNewsVideoDisplay.jsp?LENGTH=6&STATION=0&TYPE_ID=<%=CURRENT_VIDEO_ID%>&ISFIRST=1";
	
	//图片栏目链接
	tempurllist[4] = "http://125.88.98.133:8883/photoNews.aspx?noThisPar=1";
	
	//视频列表链接
	tempurllist[5] = "special/zt_XinhuaNewsVideoList.jsp?STATION=0&TYPE_ID=<%=CURRENT_VIDEO_ID%>&ISFIRST=1";
	
	
/***********************南方TVS********************/
    
	//左边栏目列表的链接地址		
	var menu_urllist = new Array();
	menu_urllist[0] = "special/zt_TVS_guoying_theater_xiaokouzu.jsp?ISFIRST=1";
	menu_urllist[1] = "special/zt_TVS_reality_theater_story.jsp?ISFIRST=1";
	menu_urllist[2] = "special/zt_TVS_sevenshow_tigerbaby.jsp?ISFIRST=1";
	menu_urllist[3] = "special/zt_TVS_qiqiguaijie.jsp?ISFIRST=1";
	menu_urllist[4] = "special/zt_TVS_chaorenguan.jsp?ISFIRST=1";
	menu_urllist[5] = "special/zt_TVS_unique_special.jsp?ISFIRST=1";
</script>



