<%@ page import="java.net.URLDecoder" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="java.net.Inet4Address" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="java.util.Map" %>
<%@ include file="HD_memToVas.jsp" %>
<body bgcolor="transparent">
<form action="" id="visForm" method="post"></form>

<script type="text/javascript">
    var form = document.getElementById("visForm");
</script>

<%
    String backUrl = (String) session.getAttribute("vas_back_url");
    backUrl = URLDecoder.decode(backUrl, "utf-8");
    //System.out.println("------------" + backUrl);
    session.removeAttribute("vas_back_url");
    

    String pageUrl = backUrl;
    if (backUrl.indexOf("?") != -1) {
        pageUrl = backUrl.substring(0, backUrl.indexOf("?"));
        String param = backUrl.substring(backUrl.indexOf("?") + 1);
        String[] splitParam = param.split("&");
        for (int i = 0; i < splitParam.length; i++) {
            if (!"action".equals(splitParam[i].substring(0, splitParam[i].indexOf("=")))) {
%>
<script type="text/javascript">
    var param = document.createElement("input");
    param.id = "param<%=i%>";
    param.type = "hidden";
    param.name = "<%=splitParam[i].substring(0, splitParam[i].indexOf("="))%>";
    param.value = "<%=splitParam[i].substring(splitParam[i].indexOf("=") + 1)%>";
    form.appendChild(param);
</script>
<%
            } else {
                pageUrl += "?" + splitParam[i];
            }
        }
    }

    ServiceHelp serviceHelp = new ServiceHelp(request);
    Map retMap = serviceHelp.checkAndGetFirstPage("en", "cn");
    String firstPage = (String) retMap.get("FIRSTPAGE");
    String currentTemplatePath = firstPage.substring(0, firstPage.lastIndexOf("/"));

    UserProfile userInfo = new UserProfile(request);
    StringBuffer sb = new StringBuffer();
	
	 //NBA准备
	 String authPurchase = request.getParameter("authPurchase");
	 sb.append("<server_ip>").append(request.getLocalAddr()).append("</server_ip>");
   sb.append("<group_name>").append(String.valueOf(userInfo.getAreaId())).append("</group_name>");
   sb.append("<group_path></group_path>");
   sb.append("<oss_user_id>").append(userInfo.getUserId()).append("</oss_user_id>");
   sb.append("<page_url>http://").append(request.getLocalAddr()).append(":").append(request.getLocalPort())
            .append("/EPG/jsp/").append(currentTemplatePath).append("/HD_vasToMemInterface.jsp</page_url>");
   sb.append("<partner>HUAWEI</partner>");	
	
	
   if (null != authPurchase && !"".equals(authPurchase)) 
	{
	
%>
<script type="text/javascript">
	var info2 = document.createElement("input");
    info2.type = "hidden";
    info2.name = "auth_status";
    info2.value = "<%=authPurchase%>";

   var info = document.createElement("input");
    info.type = "hidden";
    info.name = "epg_info";
    info.value = "<%=sb.toString()%>";
	
    form.appendChild(info);
	 form.appendChild(info2);
    form.action = "<%=pageUrl%>";
	 form.submit();
</script>
<%
}
else
{
%>
<script type="text/javascript">
   var info = document.createElement("input");
    info.type = "hidden";
    info.name = "epg_info";
    info.value = "<%=sb.toString()%>";	
    form.appendChild(info);
	
    form.action = "<%=pageUrl%>";
	 form.submit();
	</script>
	<%
	}
	%>
</body>
