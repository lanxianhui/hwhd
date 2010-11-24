<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.bestv.epg.util.MessageUtil" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
    TurnPage turnPage = new TurnPage(request);
    String pageName = turnPage.getLast();
    String backUrl = request.getParameter("url");

    if (backUrl != null) {

        if (backUrl.indexOf(MessageUtil.getMessage(session, "epg.portal.page") + ".jsp") != -1) {
            pageName = backUrl;
        }
    }
    System.out.println("backUrl:::::::::::"+backUrl);
%>

<script type="text/javascript">
    window.location.href = "<%=pageName%>";
</script>

<html>
<body bgcolor="transparent"></body>
</html>