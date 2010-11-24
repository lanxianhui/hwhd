<%@ page import="com.bestv.epg.common.EpgConstant" %>
<%@ page import="com.bestv.epg.util.MultiVideoUtil" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
    String type = request.getParameter("type");
    String value = request.getParameter("value");
    
    //System.out.println("type:::::::::"+type+"::::::::value::::::::::"+value);

    String currentTemplatePath;
    if (session.getAttribute(EpgConstant.EPG_EMS_CONFIG) == null) {
        ServiceHelp serviceHelp = new ServiceHelp(request);
        String templateName = serviceHelp.getUserTemplateName();
        if (templateName == null || "".equals(templateName)) templateName = "defaultwg";
        currentTemplatePath = request.getContextPath() + "/jsp/" + templateName + "/en";
    } else {
        currentTemplatePath = request.getContextPath() + "/" + session.getAttribute(EpgConstant.EPG_EMS_CONFIG);
    }
%>
<html>
<body>
<%
    MetaData metaData = new MetaData(request);
    Map entityMap = null;
       System.out.println("type::::::::::"+type);
    if (type.equals("vod") || type.equals("series")) {
        try {
            entityMap = metaData.getContentDetailInfoByForeignSN(value, 0);
              System.out.println("entityMap::::::::::"+entityMap+"::::value:::::::::"+value);
        } catch (Exception e) {
        }
        if (entityMap != null) {
            int vodId = (Integer) entityMap.get("VODID");
            response.sendRedirect(currentTemplatePath + "/HD_vodDetail.jsp?FILM_ID=" + vodId + "&TYPE_ID=-1");
        } else {
            response.sendRedirect(currentTemplatePath + "/HD_infoDisplay.jsp?ERROR_ID=86");
        }
    } else if (type.equals("channel")) {
        String backUrl = request.getParameter("returnUrl");
        try {
            entityMap = metaData.getContentDetailInfoByForeignSN(value, 1);
        } catch (Exception e) {
        }
        if (entityMap != null) {
            int channelNum = (Integer) entityMap.get("CHANNELINDEX");
            response.sendRedirect(currentTemplatePath + "/play_ControlChannel.jsp?CHANNELNUM=" + channelNum +
                    ((backUrl == null || "".equals(backUrl)) ? "" : "&backurl=" + backUrl));
        } else {
            response.sendRedirect(currentTemplatePath + "/HD_infoDisplay.jsp?ERROR_ID=131");
        }
    } else if (type.equals("url")) {
        if (value.startsWith("http://") || value.startsWith("HTTP://") || value.startsWith("Http://")) {
            response.sendRedirect(currentTemplatePath + "HD_encapsulaUrl.jsp?url=" + value);
        } else {
            response.sendRedirect(value);
        }
    } else if (type.equals("tvbar")) {
        response.sendRedirect("tvbar.jsp?mediaCode=" + value);
    } else if (type.equals("tvgather")) {
        response.sendRedirect("tvgather.jsp?mediaCode=" + value);
    } else if (type.equals("subject")) {
        response.sendRedirect("HD_subject.jsp?mediaCode=" + value);
    } else if (type.equals("page")) {
        response.sendRedirect("subject.jsp?mediaCode=" + request.getParameter("mediaCode") + "&pageCode=" + value);
    } else if (type.equals("category")) {
        try {
            entityMap = metaData.getContentDetailInfoByForeignSN(value, 200); 
        } catch (Exception e) {
        }
        if (entityMap != null) {
            String typeId = (String) entityMap.get("TYPEID");
            response.sendRedirect(currentTemplatePath + "/vod_Action.jsp?TYPE_ID=" + typeId);
        } else {
            response.sendRedirect(currentTemplatePath + "/HD_infoDisplay.jsp?ERROR_ID=134");
        }
    } else if (type.equals("multi")) {
        String mediaCode = MultiVideoUtil.getMultiVideoCode(session, value);
        String multiType = request.getParameter("videoType");
        if ("channel".equals(multiType)) {
            try {
                entityMap = metaData.getContentDetailInfoByForeignSN(mediaCode, 1);
            } catch (Exception e) {
            }
            if (entityMap != null) {
                int channelNum = (Integer) entityMap.get("CHANNELINDEX");
                response.sendRedirect(currentTemplatePath + "/play_ControlChannel.jsp?CHANNELNUM=" + channelNum);
            } else {
                response.sendRedirect(currentTemplatePath + "/HD_infoDisplay.jsp?ERROR_ID=131");
            }
        } else if ("vod".equals(multiType)) {
            try {
                entityMap = metaData.getContentDetailInfoByForeignSN(mediaCode, 0);
                System.out.println("mediaCode::::::::::"+mediaCode+"::::::::entityMap:::::::::"+entityMap);
            } catch (Exception e) {
            }
            if (entityMap != null) {
                int vodId = (Integer) entityMap.get("VODID");
                response.sendRedirect(currentTemplatePath + "/IPTVseriesListDetail.jsp?FILM_ID=" + vodId + "&TYPE_ID=-1");
            } else {
                response.sendRedirect(currentTemplatePath + "/HD_infoDisplay.jsp?ERROR_ID=86");
            }
        }
    }
%>

</body>
</html>
