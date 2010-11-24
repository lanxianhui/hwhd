<%@ include file="config/config_Category.jsp" %>

<html>
<script type="text/javascript">
    var stbVersion = iPanel.ioctlRead("hardware_type");
    if (stbVersion == 'undefined' || stbVersion == '')
        stbVersion = iPanel.ioctlRead("STBType");
</script>

<%
    String link = request.getParameter("link");

    String pageName = "Category.jsp";

    if (link.equals("zixun")) {
        pageName = url_info;
    } else if (link.equals("yingyong")) {
        pageName = url_App;
    } else if (link.equals("youxi")) {
        pageName = game_url;
    } else if (link.equals("caijing")) {
        pageName = url_caijing_default;
    } else if (link.equals("caijing_zx")) {
        pageName = url_caijing_zx;
    } else if (link.equals("tianqi")) {
        pageName = weather_url;
    } else if (link.equals("wanba")) {
        pageName = url_wanba;
    } else if (link.equals("shequ")) {
        pageName = community_url;
    } else if (link.equals("yingxiao")) {
        pageName = url_season3_marketing;
    } else if (link.equals("guoqing60")) {
        pageName = guoqing60;
    } else if (link.equals("kanhushishare")) {
        pageName = kanhushishare;
    } else if (link.equals("mianfeidapian")) {
        pageName = mianfeidapian;
    } else if (link.equals("yqpdy")) {
        pageName = yqpdy;
    } else if (link.equals("kpyjhd")) {
        pageName = kpyjhd;
    } else if (link.equals("dianxin")) {
        pageName = url_szdx;
    }

%>
<body bgcolor="transparent">
<script type="text/javascript">
    window.location.href = "<%=pageName%>" + "&stbType=" + stbVersion;
</script>
</body>
</html>