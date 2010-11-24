<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.*"%>
<jsp:directive.page import="java.net.Inet4Address" />
<jsp:directive.page import="com.huawei.iptvmw.epg.bean.info.UserProfile" />
<%!
    public String getEpgInfo(HttpServletRequest request) throws Exception{
		    String path = request.getContextPath();
        String basePath = request.getScheme() + "://"
                + request.getServerName() + ":" + request.getServerPort()
                + path + "/";
		    UserProfile userInfo = new UserProfile(request);
		    String templateName = userInfo.getTemplate();
		
		    if(null == templateName || "".equals(templateName))
		    {
		        templateName = "hwhd/en/";
		    }
		 	 		
		    String str = "";
		    //String epgAddr = "http://" + request.getLocalAddr() + ":" + request.getLocalPort();
		    //str += "<server_ip>"+Inet4Address.getLocalHost().getHostAddress()+"</server_ip>";
		    str += "<server_ip>"+request.getLocalAddr()+"</server_ip>";
		    str += "<group_name>"+String.valueOf(userInfo.getAreaId())+"</group_name>";
		    str += "<group_path></group_path>";
		    str += "<oss_user_id>"+userInfo.getUserId()+"</oss_user_id>";
		    str += "<page_url>http://"+request.getLocalAddr()+":"+ request.getLocalPort() +"/EPG/jsp/hwhd/en/HD_vasToMemInterface.jsp</page_url>";
		    str += "<partner>HUAWEI</partner>";
		    
		    System.out.println("::::::::::::::::::::::::::"+str);
		    return str;
    }
  
%>

