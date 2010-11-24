<%-- Copyright (C), Huawei Tech. Co., Ltd. --%>
<!-- Author:guanfei -->
<%-- CreateAt:2009-02-02 --%>
<%-- FileName:Authorization.jsp --%>
<%-- 
	本页面用与授权
--%>
<%@ page language="java" errorPage="ShowException.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGErrorCode" %>
<%@ page import="com.huawei.iptvmw.util.StringDateUtil" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>

<html>
<head>
    <title>SubscribeSelect</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<%

//System.out.println("Author dxy!!!!!!!!!!!!::::::::::::::"+request.getQueryString());  

//long tomes = System.currentTimeMillis();
 // System.out.println("Start AU:" + tomes);    

    TurnPage turnPage = new TurnPage(request);
  //  turnPage.addUrl();

    ServiceHelp serviceHelp = new ServiceHelp(request);
    ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
   
   

    //栏目号
    String typesId = request.getParameter("TYPE_ID") == null ? "-1" : "null".equals(request.getParameter("TYPE_ID")) ? "-1" : request.getParameter("TYPE_ID");
    //部分页面栏目参数名为TYPEID
    if (typesId == null || "-1".equals(typesId)) {
        typesId = request.getParameter("TYPEID") == null ? "-1" : "null".equals(request.getParameter("TYPEID")) ? "-1" : request.getParameter("TYPEID");
    }
    int superVodID = -2;
    int progId=-999;
    
    //要播放影片的id   
   String sProgId = request.getParameter("PROGID");
   
   //连续剧字集id 
   String sChildId = request.getParameter("CHILDID");
     //连续剧集号
    String sChildNum = request.getParameter("PROGNUM");
       
    //电视剧父集ID
    String sFatherSeriesId = request.getParameter("FATHERID") == null ? "-2" : "null".equals(request.getParameter("FATHERID")) ? "-2" : "-1".equals(request.getParameter("FATHERID")) ? "-2" : request.getParameter("FATHERID");
    // 播放类型 内容类型 业务类型
    String sPlayType = request.getParameter("PLAYTYPE");
    String sContentType = request.getParameter("CONTENTTYPE");
    String sBusinessType = request.getParameter("BUSINESSTYPE");
    //是否续订标示
    String programOrder = request.getParameter("PROGRAM_ORDER");
    //电视剧标志
    String isTVSeriesFlag = request.getParameter("ISTVSERIESFLAG");

   
  //    sProgId = "94";
   //   sPlayType="1";
  //    sContentType="1";
  //    sBusinessType="1";
   //   programOrder="1";
    
    if (sProgId != null) {
         progId = Integer.parseInt(sProgId);
    }
    
  
    
    int playType = Integer.parseInt(sPlayType);
    int contentType = Integer.parseInt(sContentType);
    int businessType = Integer.parseInt(sBusinessType);
    int fatherSeriesId = -1;
    if ("1".equals(isTVSeriesFlag) || !"-2".equals(sFatherSeriesId)) {
        if (null != sFatherSeriesId && !"".equals(sFatherSeriesId)) {
            fatherSeriesId = Integer.parseInt(sFatherSeriesId);
        }
    }
    
    
  

    Map retMap;
    if ("1".equals(isTVSeriesFlag) || !"-2".equals(sFatherSeriesId)) {
    //System.out.println(":::::::"+fatherSeriesId+"*******"+playType+"##########"+contentType+"$$$$$$$$$$$"+businessType+"-----"+typesId);
    
        retMap = serviceHelpHWCTC.authorizationHWCTC(fatherSeriesId, playType, contentType, businessType, typesId, fatherSeriesId);
    } else {
    //	 System.out.println("222222222222222222");
     //   System.out.println("::::"+progId+"*******"+playType+"##########::"+contentType+"$$$$$$$$$$$::::"+businessType+"-----"+typesId+"::::::"+"-----"+superVodID);
    
    	//long tomes2 = System.currentTimeMillis();
//  System.out.println("start AU2:" + tomes2); 
        retMap = serviceHelpHWCTC.authorizationHWCTC(progId, playType, contentType, businessType, typesId, superVodID);
        	//long tomes3 = System.currentTimeMillis();
 // System.out.println("end AU2:" + tomes3); 
    }
    
   // System.out.println("this is test ret map:::::"+retMap);

    int retCode = EPGErrorCode.AUTHORIZATION_DATABASEERROR;   //初始化为数据库异常，防止出现空值

    if (null != retMap && null != retMap.get(EPGConstants.KEY_RETCODE)) {
        retCode = (Integer) retMap.get(EPGConstants.KEY_RETCODE);
    }
    String pageName = "HD_infoDisplay.jsp";
    
    //System.out.println("retCode:::::::::::::"+retCode);

    //授权通过
    if (retCode == EPGErrorCode.SUCCESS) {
    %>
 
<body bgcolor="transparent" onLoad="alert('this')">
<table width="640" height="340" border="0">
    <tr>
        <td width="640" height="300">&nbsp;</td>
    </tr>
    <tr>
        <td align="center" style="font-size:15px;color:#FFFFFF">正在处理，请稍候...</td>
    </tr>
</table>
</body>
<%
       // turnPage.removeLast();


    if (out != null && out.getBufferSize() != 0) {
        out.clearBuffer();
    }
    //获取授权通过的产品编号和服务编号
    String sProdId = (String) retMap.get("PROD_CODE");
    String sServiceId = (String) retMap.get("SERVICE_CODE");
    String sPrice = (String) retMap.get("PROD_PRICE");

    if (sPrice == null || "".equals(sPrice)) {
        sPrice = "0";
    }

    //由于价格中可能包含中文，需要对价格进行编码
    sPrice = URLEncoder.encode(sPrice, "UTF-8");
    StringBuffer queryStr = new StringBuffer();
    queryStr.append(request.getQueryString());
    queryStr.append("&PRODUCTID=").append(sProdId).append("&SERVICEID=").append(sServiceId).append("&ONECEPRICE=").append(sPrice);
   // pageName = "play_pageControl.jsp?" + queryStr.toString();
   
   if("1".equals(isTVSeriesFlag))
   {
    // System.out.println("PROGID:::::::::::::"+sChildId+":::::PROGNUM:::::::::"+sChildNum+"××××××××××"+fatherSeriesId);
   pageName = "play.jsp?PROGID=" + sChildId + "&PROGNUM=" + sChildNum + "&FATHERID=" + fatherSeriesId + "&TYPE_ID=" + typesId; 
   }
  else
  	{
    
  	 pageName="play.jsp?" + request.getQueryString();
  	
  	}
  	//System.out.println("SW:::::::"+pageName);
  	 response.sendRedirect(pageName);

}  else if (retCode == 0x07020002 || retCode == 500 || retCode == 501 || retCode == 502 || retCode == 503 || retCode == 504 ||retCode == 101056529) {
	   ArrayList list = (ArrayList) retMap.get("TIMES_LIST");
    if (list.size() == 0 && retCode == 500) {
        pageName = pageName + "?ERROR_ID=136";
    } else if (list.size() == 0 && retCode == 501)//产品不存在或状态不可用
    {
        pageName = pageName + "?ERROR_ID=138";
    } else if (list.size() == 0 && retCode == 502)//服务不存在或状态不可用
    {
        pageName = pageName + "?ERROR_ID=139";
    } else if (list.size() == 0 && retCode == 503)//订购的产品不在使用期内
    {
        pageName = pageName + "?ERROR_ID=140";
    } else if (list.size() == 0 && retCode == 504)//用户没有订购相应产品或订购关系已失效或未生效
    {
        pageName = pageName + "?ERROR_ID=141";
    } else {
    
        session.setAttribute("RETMAP", retMap);

        pageName = "HD_subscribe.jsp?SHOWPRODUCTTYPE=0&" + request.getQueryString();
    }


     
         response.sendRedirect(pageName);

}
else
	{
	
	    if (retCode == 0x07020001)//没有可以订购的产品
    {
        pageName = pageName + "?ERROR_ID=142";

} else if (retCode == 0x07020100)//0x07020100：数据库异常
{
    pageName = pageName + "?ERROR_ID=143";

} else if (retCode == 0x07020200)//0x07020200：操作超时
{
    pageName = pageName + "?ERROR_ID=144";

} else if (retCode == 0x04010004)//0x04010004：用户不存在或非法用户
{
    pageName = pageName + "?ERROR_ID=145";

} else if (retCode == 0x04010899)//0x04010899：用户令牌非法
{
    pageName = pageName + "?ERROR_ID=146";

} else if (retCode == 0x07000005) //0x07000005 传入的参数错误
{
    pageName = pageName + "?ERROR_ID=147";

} else if (retCode == 0x07000006) //0x07000006 解码出现异常
{
    pageName = pageName + "?ERROR_ID=148";

} else {
    pageName = pageName + "?ERROR_ID=149";

        }
      // 	System.out.println("here~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"+pageName);

         response.sendRedirect(pageName);
        

}
%>


</html>