<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>

<%!
	public String getEpgInfo(HttpServletRequest request) {
        UserProfile userInfo = new UserProfile(request);
        String templateName = userInfo.getTemplate();

        if (null == templateName || "".equals(templateName)) {
            templateName = "default";
        }
        String str = "";
        str += "<server_ip>" + request.getLocalAddr() + "</server_ip>";
        str += "<group_name>" + templateName + "</group_name>";
        str += "<group_path></group_path>";
        str += "<oss_user_id>" + userInfo.getUserId() + "</oss_user_id>";
        str += "<page_url>http://" + request.getLocalAddr() + ":"
            + request.getServerPort() + "/EPG/jsp/" + templateName
            + "/en/VasToMem.jsp</page_url>";
        str += "<partner>HUAWEI</partner>";
        return str;
    }
%>