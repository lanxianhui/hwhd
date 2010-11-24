<%-- Copyright (C), Huawei Tech. Co., Ltd. --%>
<!-- Author:dxy -->
<%-- CreateAt:2008-04-11 --%>
<%-- FileName:EnsureSubscribeResult.jsp --%>

<%-- 页面功能:
    处理用户定购确认操作
--%>
<%-- 跳转描述:
--%>

<%@ page language="java" errorPage="ShowException.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.bean.func.UserService" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGErrorCode" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConfig"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ taglib uri="/WEB-INF/ca.tld" prefix="ca" %>

<html>
<%

// System.out.println("subResu dxy!!!!!!!!!!!!::::::::::::::"+request.getQueryString());
 /* PRODID=222&PROGID=322140&PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&SELECTPRODCONT=0&SERVICEID=202&FATHERID=322142 */
 
    ServiceHelp serviceHelp = new ServiceHelp(request);
	ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
	MetaData metaData = new MetaData(request);
	
	// 播放类型
    String strPlayType = (String)request.getParameter("PLAYTYPE");
    String strBookmarkTime =  (String)request.getParameter("BOOKMARKTIME");
	String progId = (String)request.getParameter("PROGID");
	
	 // 产品id
    String prodId = (String)request.getParameter("PRODID");
    
     // 服务编码
    String ExpiredTime = (String)request.getParameter("ExpiredTime");
    
     if(null == ExpiredTime || ExpiredTime.trim().length() < 14)
    {
    	ExpiredTime = "20991230235959";
    }
    
	//PPV标识
	String orderPPV = (String)request.getParameter("ORDERPPV");
	
	String serviceType = (String)session.getAttribute("SERVICETYPE");
	
	//如果serviceType为null，则赋值为-1
    if ( serviceType == null || serviceType.trim().length() == 0 )
    {
        serviceType = "-1";
    }
    
   
	
	String strTypeId = request.getParameter("TYPE_ID");

    //频道对应的服务编号
	String serviceId = request.getParameter("SERVICEID");
  
	//superVodID父集编号 节目所属的栏目，如果为“-1”，表示所有栏目

    String supVodId = (String)request.getParameter("FATHERID");
    
    	int fatherSeriesId = -1;
	
    	if(null != supVodId && !"".equals(supVodId)&& !"null".equals(supVodId))
    	{
    	    fatherSeriesId = Integer.parseInt(supVodId);
    	}
    	
    	 //连续剧集号
    String sChildNum = request.getParameter("PROGNUM");
	
    
     String ProductName = (String)request.getParameter("ProductName");
    if(null == ProductName)
    {
    	ProductName = "null";
    }
    
	//内容类型
    String contentTypeStr = request.getParameter("CONTENTTYPE");
    // 业务类型
    String businessTypeStr = request.getParameter("BUSINESSTYPE");
  
    
    //可持续订购
    int prodCont = Integer.parseInt(EPGConstants.SUBSCRIPTION_NOTCONTINUEABLE);
    int prodType = 0;
    int contentType =  0;
    int businessType =  0;
    int contentId =  0;

    try
    {     
         businessType =  Integer.parseInt(businessTypeStr);
         prodCont = Integer.parseInt((String)request.getParameter("SELECTPRODCONT"));
         contentId =  Integer.parseInt(progId);
         contentType =  Integer.parseInt(contentTypeStr);
        
       
    }
    catch(Exception e)
    {
        prodCont = Integer.parseInt(EPGConstants.SUBSCRIPTION_NOTCONTINUEABLE);
    }
    
    int playType = EPGConstants.PLAYTYPE_VOD;
    try
    {
        playType = Integer.parseInt(strPlayType);
    }
    catch(Exception e)
    {
        playType = EPGConstants.PLAYTYPE_VOD;
    }
    
  
    
    //书签设置时间
    String bookMarkTime = (String)request.getParameter( "BOOKMARKTIME" );
    if (bookMarkTime == null)
    {
        bookMarkTime = "";
    }
    else
    {
        bookMarkTime = bookMarkTime.trim();
    }
	

 
  /*  //   ///////////////////////////////////////////////////////////////////////////////////////////// */
 

    if(null == ExpiredTime || "".equals(ExpiredTime.trim()))
    {
           ExpiredTime = "20991212000000";
    }
    String pageName = "HD_infoDisplay.jsp?ERROR_ID=136";
    TurnPage turnPage = new TurnPage(request);

	Map orderfilm = new HashMap();
	
	
	//System.out.println("prodId:::::::::::"+prodId+":::::serviceId:::::::::"+serviceId+"::::::contentType:::::::"+contentType+"::::businessType::::::"+businessType+"::::::::prodCont:::::::"+prodCont+":::::::::progId::::::"+progId);
	
	    //prodId = "PPVPRODUCT00300";
	    //如果是连续剧子集，需要订购连续剧父集ID
        if(null != supVodId && supVodId.trim().length() > 0 && !"null".equalsIgnoreCase(supVodId.trim()))
        {            
            //orderfilm = serviceHelp.subscribeSH(prodId, supVodId.trim(), contentType, businessType, isPPV);//for SH
            orderfilm = serviceHelpHWCTC.subscribeHWCTC(prodId+"", serviceId, prodCont,contentType,contentId,businessType,fatherSeriesId);
        }
        else
        {
            //orderfilm = serviceHelp.subscribeSH(prodId, progId, contentType, businessType, isPPV); //for SH
            orderfilm = serviceHelpHWCTC.subscribeHWCTC(prodId, serviceId, prodCont,contentType,contentId,businessType,-2);
        }
	

	
    int ret_code= ((Integer)orderfilm.get(EPGConstants.KEY_RETCODE)).intValue();
    
   // System.out.println("ret_code::::111111111111111111111ss:::::::::::::::::::"+ret_code);
 
   //ret_code  = 0;
   String userid = (String)request.getParameter( "UserID" );
    //订购确认成功
    if(ret_code == EPGConstants.SH_RESULT_OK_I)
    {      
    	
    	String fee = null;
    	int purchaseType=-1;
    	try
    	{
    		//retCode = Integer.parseInt(retMap.get(EPGConstants.KEY_RETCODE).toString());
    		fee = request.getParameter("Fee");
    		purchaseType = Integer.parseInt(request.getParameter("PurchaseType"));
    	}
    	catch(Exception e)
    	{
    	}
    	
    	//二次认证成功，则更新产品服务信息
	
        //删除密码输入页面session中的url
        //需要连续删除两次,保证播放不会返回订购     
        turnPage.removeLast();
        turnPage.removeLast();
        
       
        
        //播放影片后会出现过滤页面，清除缓存




        if(out!=null && out.getBufferSize()!=0)
        {
        	out.clearBuffer();
        }
 
                          
        String requestUrl = request.getRequestURL().toString();
         String forwardPage ="";
        
          //如果是连续剧子集
        if(null != supVodId && supVodId.trim().length() > 0 && !"null".equalsIgnoreCase(supVodId.trim()))
        {            
            forwardPage = "play.jsp?PROGID=" + contentId + "&PLAYTYPE=" + strPlayType + "&FATHERID=" + fatherSeriesId  + "&TYPEID=" + strTypeId+ "&PROGNUM=" + sChildNum;             
        }
        else
        {
               forwardPage = "play.jsp?PROGID=" + progId + "&PLAYTYPE=" + strPlayType + "&SUPVODID=" + supVodId  + "&TYPEID=" + strTypeId;
        }
       
   
        if (null != strBookmarkTime)
        {
        	forwardPage += "&BOOKMARKTIME=" + strBookmarkTime;
        }
        
%>
<script>
        window.location.href = "<%=forwardPage%>";
</script>
<%
    }
    else
    {     
    //System.out.println("turnPage:::::::::::::::"+turnPage.getLast());
       	turnPage.removeLast();
      	turnPage.removeLast();

     
               
        
%>
       <jsp:forward page="<%= pageName %>"/>
<%
    }
%>
</html>
