<%@ include file="HD_preFocusElement.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page import="com.bestv.epg.util.MessageUtil" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="java.util.*" %>
<%@ include file="HD_common.jsp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>

<%
		//获取跳转URL个数
		String dx_count=MessageUtil.getMessage(session, "dx_count");
		if ((null == (dx_count)) || (("".equals(dx_count))) || ("null"==dx_count))
		{
			dx_count	=	"0";
		}
		
		//获取用户信息
		UserProfile userInfo = new UserProfile(request);
	
		//获取模板路径
		ServiceHelp serviceHelp = new ServiceHelp(request);
		Map retMap = serviceHelp.checkAndGetFirstPage("en", "cn");
		String firstPage = (String) retMap.get("FIRSTPAGE");
		String currentTemplatePath = firstPage.substring(0, firstPage.lastIndexOf("/"));
	
%>
<head>
<meta name="designer" content="bestv" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Page-Enter" content="blendTrans(Duration=0.0)">
<meta name="page-view-size" content="640*526" />
<title></title>
<script type="text/javascript">

var data = [];
var m = 0;
<%
	String dx_url = "";
	for(int i=0;i<(Integer.parseInt(dx_count));i++)
	{
		String sq = MessageUtil.getMessage(session, "dx_"+(i+1)+"_sq");
		String url = MessageUtil.getMessage(session, "dx_"+(i+1)+"_url");
		
		//游戏
		if ("1".equals(sq)) {
				 dx_url = url + "?user=" + userInfo.getUserId() + "&enterURL=http://" + request.getLocalAddr() + ":" + request.getLocalPort() + "/EPG/jsp/" + currentTemplatePath +"/HD_DXDispatch.jsp";
		}
		
		//卡拉OK
		if ("2".equals(sq)) {
				 dx_url =  url + "?userID=" + userInfo.getUserId() + "&endUrl=http://" + request.getLocalAddr() + ":" + request.getLocalPort() + "/EPG/jsp/" + currentTemplatePath +"/HD_DXDispatch.jsp";
		}
		System.out.println("xinsw-----------dx_url="+dx_url);	
%>
		data[m++]		=	"<%=dx_url%>"
<%}%>

function init(){
  var flag = window.location.search.substring(1).split("=")[1];
  iPanel.debug("xinsw--------flag="+flag);
  if (typeof flag != "undefined" && flag != "") {
	if(typeof(iPanel.eventFrame.DXDispatchBackURL) == "undefined"){
  	  	iPanel.eventFrame.eval("var DXDispatchBackURL= ''");
  	}
    iPanel.eventFrame.DXDispatchBackURL=backUrl;
	document.location  = data[flag];
  }else{
  	document.location  = iPanel.eventFrame.DXDispatchBackURL;
  }		
}	
	
</script>
</head>

<body onload="init()" style="background-color: transparent">
</body>
</html>
