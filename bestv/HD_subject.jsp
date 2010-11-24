<%@ page import="com.bestv.epg.ui.SubjectUI" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.bestv.epg.exception.BestvEpgException" %>
<%@ page import="com.bestv.epg.common.EpgConstant" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://epg.bestv.com/tags" prefix="bestv" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>

<%
    String mediaCode = request.getParameter("mediaCode");
    String pageCode = null;
    String bgPath = "";
    String subjectName = "";
    if (request.getParameter("pageCode") != null && !"".equals(request.getParameter("pageCode")))
        pageCode = request.getParameter("pageCode");
    try {
        SubjectUI subjectUI = new SubjectUI(request.getSession().getServletContext(), mediaCode);
        pageContext.setAttribute("subjectUI", subjectUI);
        bgPath = subjectUI.getEntityContextPath();

        subjectName = (session.getAttribute("AD_FROMWHICHPAGE") == null ? "" :
                session.getAttribute("AD_FROMWHICHPAGE") + "/") + "专辑/" + subjectUI.getSubject().getName();
        session.setAttribute("AD_SUBJECT_NAME", subjectName);        
    } catch (BestvEpgException e) {
        e.printStackTrace();
    }
    
    TurnPage turnPage = new TurnPage(request);
    turnPage.addUrl(); 
    System.out.println(turnPage.go(-1)+"==============="+turnPage.go(0));
%>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <meta name="page-view-size" content="640*530" /> 
    <style type="text/css">
    body{background:url(<%=request.getContextPath()%>/<%=bgPath%>/<bestv:subjectBg name="subjectUI" pageCode="<%=pageCode%>" />)}
    </style>
    
    <script src="js/mini.js" type="text/javascript"></script>
    
<script type="text/javascript">

  function promotionDispatch(type, value) {
      var  url = '<%=request.getContextPath()%>/<%=session.getAttribute(EpgConstant.EPG_EMS_CONFIG)%>/HD_dispatcher.jsp?type=' + type + '&value=' + value;
        if (type == 'page') url += "&mediaCode=<%=mediaCode%>";
       // location.href = url;
        document.location = url;
   
  }

	function eventHandler(obj) {
		switch(obj.code) {
			case "KEY_BACK":
				goBack();
					break;
			
		}
	}
	
    function goBack()
    {
        window.location.href = '<%=turnPage.go(-1)%>';
    }


</script>
</head>
<body margin="0">
<%
    String transparentPic = "images/dot.gif";
%>
<bestv:subjectLinkList name="subjectUI" pageCode="<%=pageCode%>" resultId="subjectLinkList"/>
<bestv:notEmpty name="subjectLinkList">
    <bestv:iterate id="link" name="subjectLinkList">
        <div style="left:<bestv:write name="link" property="positionLeft" />px; top:<bestv:write name="link" property="positionTop" />px; width:<bestv:write name="link" property="positionWidth" />px; height:<bestv:write name="link" property="positionHeight" />px; position:absolute;">
            <a href="javascript:promotionDispatch('<bestv:write name="link" property="entityType" />', '<bestv:write name="link" property="entityCode" />')">
                <img src="<%=transparentPic%>" alt="" width="<bestv:write name="link" property="positionWidth" />px"
                     height="<bestv:write name="link" property="positionHeight" />">
            </a>
        </div>
    </bestv:iterate>
</bestv:notEmpty>
</body>
</html>