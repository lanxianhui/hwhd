<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.bestv.epg.util.MessageUtil" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil" %>
<%@ page import="com.bestv.epg.util.WordUtil" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="GetPosterPathFunction.jsp" %>
<%@ include file="subscribeUtil.jsp" %>
<%@ include file="../keyboard/keydefine.jsp" %>
<%@ page import="java.util.*" %>
<%@ page buffer="12kb"%>

<html>
<head>
    <title>订购</title>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <style type="text/css">
        <!--
        body {
            margin-left: 0;
            margin-top: 0;
            margin-right: 0;
            margin-bottom: 0;
        }

        -->
    </style>
</head>

<%
    TurnPage turnPage = new TurnPage(request);

    MetaData metaData = new MetaData(request);

    String progId = (String) session.getAttribute("ContentID");
    String supVodId = (String) session.getAttribute("SUPVODID");
    String sBusinessType = (String) session.getAttribute("BUSINESSTYPE");
    int progIdInt = Integer.parseInt(progId);
    int businessTypeInt = Integer.parseInt(sBusinessType);

    //获取节目名称
    String progName = "";
    if (progId != null && businessTypeInt == EPGConstants.BUSINESSTYPE_VOD) {
        int filmId = Integer.parseInt(progId);
        if (null != supVodId && !"".equals(supVodId.trim()) && !"null".equalsIgnoreCase(supVodId.trim())) {
            filmId = Integer.parseInt(supVodId.trim());
        }
        Map filmInfoMap;
        filmInfoMap = metaData.getVodDetailInfo(filmId);
        if (filmInfoMap != null) {
            if (!filmInfoMap.get("VODNAME").toString().equals("null") || filmInfoMap.get("VODNAME").toString() != null) {
                progName = filmInfoMap.get("VODNAME").toString();
                progName = EPGUtil.swapHtmlStr(progName, 12, 1);
            }
        }
    }

    //获取节目图片
    String progImg = "images/vodbrowse/default.jpg";
    Map film = metaData.getVodDetailInfo(progIdInt);
    if (film != null) {
        HashMap posterMap = (HashMap) film.get("POSTERPATHS");
        String[] picArr = GetPosterPathFunction(posterMap, -1, 0);
        if (picArr != null && picArr.length > 0) {
            progImg = picArr[0];
        }
    }

    Map retMap = (Map) session.getAttribute("SUBSCRIBE_PACKAGE_LIST");
    String[] flags = (String[]) retMap.get("flag");
    String[] prodIds = (String[]) retMap.get("PROD_CODE");
    String[] prodNames = (String[]) retMap.get("PROD_NAME");
    String[] prodPrices = (String[]) retMap.get("PROD_PRICE");
    int[] prodRentals = (int[]) retMap.get("RentalTerm");
    int[] prodConts = (int[]) retMap.get("PROD_CONTINUEABLE");
    String[] prodDescs = (String[]) retMap.get("productDescribeList");

    boolean gotPPV = false;
    Map ppvProduct = new HashMap();
    List nonPPVProducts = new ArrayList();

    if (flags == null || flags.length == 0) {
%>
<jsp:forward page="InfoDisplay.jsp?ERROR_ID=114"/>
<%
} else {

    for (int i = 0; i < flags.length; i++) {
        String flag = flags[i];
        if ("isPPV".equals(flag) && !gotPPV) {  //获取第一个PPV产品
            ppvProduct.put("prodId", prodIds[i]);
            ppvProduct.put("prodName", prodNames[i]);
            ppvProduct.put("prodPrice", prodPrices[i]);
            ppvProduct.put("prodRental", new Integer(prodRentals[i]));
            ppvProduct.put("prodDesc", prodDescs[i]);
            gotPPV = true;
        }
        if (!"isPPV".equals(flag)) {    //获取非PPV产品列表
            Map nonPPV = new HashMap();
            nonPPV.put("prodId", prodIds[i]);
            nonPPV.put("prodName", prodNames[i]);
            nonPPV.put("prodPrice", prodPrices[i]);
            nonPPV.put("prodRental", new Integer(prodRentals[i]));
            nonPPV.put("prodCont", new Integer(prodConts[i]));
            nonPPV.put("prodDesc", prodDescs[i]);
            nonPPVProducts.add(nonPPV);
        }
    }

    session.removeAttribute("PPV_PRODUCT");
    session.setAttribute("PPV_PRODUCT", ppvProduct);

    session.removeAttribute("NON_PPV_PRODUCT");
    session.setAttribute("NON_PPV_PRODUCT", nonPPVProducts);

    String forwardUrl;

    //ppv产品价格为零
    if (gotPPV && "0".equals(ppvProduct.get("prodPrice"))) {
        forwardUrl = "submitSubscription.jsp?PROGID=" + progId + "&PRODID=" + ppvProduct.get("prodId") +
                "&PRODPRICE=" + ppvProduct.get("prodPrice") + "&PLAYTYPE=" + session.getAttribute("PLAYTYPE") +
                "&CONTENTTYPE=" + session.getAttribute("CONTENTTYPE") + "&BUSINESSTYPE=" + sBusinessType +
                "&SUPVODID=" + supVodId + "&TYPEID=" + session.getAttribute("TYPEID") + "&ORDERPPV=ppv";
%>
<script type="text/javascript">
    window.location.href = '<%=forwardUrl%>';
</script>
<%
    }

    //如果不支持在线订购
    if (MessageUtil.getMessage(session, "subscribe.isAlwaysPPV") != null &&
            "true".equals(MessageUtil.getMessage(session, "subscribe.isAlwaysPPV"))) {
        forwardUrl = "ensureSubscription.jsp?ORDERPPV=ppv";
        if (!gotPPV) forwardUrl = "subscribeError.jsp";
%>
<script type="text/javascript">
    window.location.href = '<%=forwardUrl%>';
</script>
<%
    } else {
        //页面需要展现，入栈
        turnPage.addUrl();
    }
%>

<body background="images/subscribe/ui_bg_vod_buy.jpg" onload="document.getElementById('ppvPackage').focus();">

<div style="position:absolute;left:132px;top:70px;">
    <img src="<%=progImg%>" width="140" height="116" border="0" alt="">
</div>
<div style="position:absolute;left:20px;top:34px;width:361px;color:#ffffff;font-size:20px" align="center"><%=progName%>
</div>
<div style="position:absolute;left:120px;top:208px;">
    <a id="ppvPackage" onclick="location.href='ensureSubscription.jsp?ORDERPPV=ppv'">
        <img src="images/subscribe/ui_button_check.gif" border="0" alt="">
    </a>
</div>
<div style="position:absolute;left:128px;top:280px;">
    <a href="<%=turnPage.go(-1)%>">
        <img src="images/subscribe/ui_button_back.gif" border="0" alt="">
    </a>
</div>
<div style="position:absolute;left:50px;top:380px;width:80px;color:#8ab7f2;font-size:20px;" align="right">价格：</div>
<div style="position:absolute;left:50px;top:420px;width:80px;color:#8ab7f2;font-size:20px;" align="right">有效期：</div>
<div style="position:absolute;left:130px;top:380px;color:#fba01c;font-size:20px;"><%=transferPrice((String) ppvProduct.get("prodPrice"))%>
</div>
<div style="position:absolute;left:130px;top:420px;color:#fba01c;font-size:20px;">
    自购买起<%=transferTime(((Integer) ppvProduct.get("prodRental")).intValue())%>内
</div>

<%
    if (nonPPVProducts.size() > 0) {
        Map nonPPV1 = (Map) nonPPVProducts.get(0);
        String price1 = transferPrice((String) nonPPV1.get("prodPrice"));
        price1 = price1.substring(0, price1.indexOf("."));
%>

<div style="position:absolute;left:382px;top:13px;">
    <img src="images/subscribe/ui_button_package2.gif" border="0" alt="">
</div>

<div style="position:absolute;left:520px;top:43px;color:#FFFFFF" align="center">
    <%
        for (int i = 0; i < price1.length(); i++) {
    %>
    <img src="images/subscribe/<%=price1.substring(i, i + 1)%>.gif" border="0"
         alt=""><%=i == price1.length() - 1 ? "元" : ""%>
    <%
        }
    %>
</div>

<div style="position:absolute;left:390px;top:102px;width:220px;color:#162133;font-size:24px;"
     align="center"><%=WordUtil.subWord((String) nonPPV1.get("prodName"), 18, "utf-8")%>
</div>

<div style="position:absolute;left:390px;top:132px;width:220px;color:#535c6b;font-size:20px;"
     align="left"><%=WordUtil.subWord((String) nonPPV1.get("prodDesc"), 54, "utf-8")%>
</div>

<div style="position:absolute;left:426px;top:195px;">
    <a href="ensureSubscription.jsp?packageIndex=0">
        <img src="images/dot.gif" width="150" height="50" border="0" alt="">
    </a>
</div>

<%
    }

    if (nonPPVProducts.size() > 1) {
        Map nonPPV2 = (Map) nonPPVProducts.get(1);
        String price2 = transferPrice((String) nonPPV2.get("prodPrice"));
        price2 = price2.substring(0, price2.indexOf("."));
%>

<div style="position:absolute;left:382px;top:263px;">
    <img src="images/subscribe/ui_button_package1.gif" border="0" alt="">
</div>
<div style="position:absolute;left:546px;top:293px;color:#FFFFFF" align="center">
    <%
        for (int i = 0; i < price2.length(); i++) {
    %>
    <img src="images/subscribe/<%=price2.substring(i, i + 1)%>.gif" border="0"
         alt=""><%=i == price2.length() - 1 ? "元" : ""%>
    <%
        }
    %>
</div>
<div style="position:absolute;left:390px;top:352px;width:220px;color:#162133;font-size:24px;"
     align="center"><%=WordUtil.subWord((String) nonPPV2.get("prodName"), 18, "utf-8")%>
</div>
<div style="position:absolute;left:390px;top:382px;width:220px;color:#535c6b;font-size:20px;"
     align="left"><%=WordUtil.subWord((String) nonPPV2.get("prodDesc"), 54, "utf-8")%>
</div>

<div style="position:absolute;left:426px;top:445px;">
    <a href="ensureSubscription.jsp?packageIndex=1">
        <img src="images/dot.gif" width="150" height="50" border="0" alt="">
    </a>
</div>
<%
    }
%>

<script type="text/javascript">

    document.onirkeypress = keyevent;
    document.onkeypress = keyevent;

    function keyevent() {
    var    val = (event.keyCode == undefined) ? event.which:event.keyCode;
        return keypress(val);
    }


    function keypress(keyval)
    {
        switch (keyval)
                {
            case <%=KEY_RETURN%>:
            case <%=KEY_BACKSPACE%>:
                window.location.href = "<%=turnPage.go(-1)%>"; break;
            default: break;
        }
    }
</script>


</body>
<%
    }
%>
</html>
