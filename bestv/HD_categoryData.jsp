<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://epg.bestv.com/tags" prefix="bestv" %>
<%@ page import="com.bestv.epg.util.MessageUtil" %>
<%@ page import="com.bestv.epg.util.WordUtil" %>
<%@ page import="com.bestv.epg.ui.BaseUI" %>
<%@ page import="com.bestv.epg.common.EpgConstant" %>
<%@ page import="com.bestv.epg.bean.PositionViewEntity" %>
<%@ page import="com.bestv.epg.bean.PositionItem" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="java.util.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="com.bestv.epg.ui.BaseUI" %>
<%@ include file="HD_common.jsp" %>
<%@ include file="HD_categoryDataFunction.jsp" %>
<%@ include file="HD_GetPosterPathFunction.jsp" %>
<%@ include file="HD_substringUtil.jsp" %>
<%
    ArrayList dataList = new ArrayList();
    ArrayList partOne = new ArrayList();
    ArrayList partTwo = new ArrayList();
    ArrayList partThree = new ArrayList();
    
    for(int i = 0;i < 7; i++)
    {
        HashMap item = new HashMap();
  	    String superHeadline=MessageUtil.getMessage(session, "portal_headline_"+(i+1));
  	    item.put("NAME" , superHeadline);
  	    String superHeadlineType=MessageUtil.getMessage(session, "portal_headline_"+(i+1)+"_info");
  	    String superHeadlineUrl =MessageUtil.getMessage(session, "portal_headline_"+(i+1)+"_url");
  	    item.put("TURNURL"  , superHeadlineUrl);
  	    partOne.add(item);
  	    ArrayList al = getSecondLayoutList(request , i , superHeadlineType);
  	    partTwo.add(al);  	    
  	}
  	
  	BaseUI baseUI = new BaseUI(request.getSession().getServletContext());
    pageContext.setAttribute("baseUI", baseUI);
    
    String rootUrl = request.getContextPath()+ "/" + application.getAttribute(EpgConstant.EPG_GROUP_PATH) + "/";
    //System.out.println(rootUrl);
    
    String dispatchUrl = "HD_dispatcher.jsp?";
    
%>
<bestv:findEntity name="baseUI" groupCode='<%=MessageUtil.getMessage(session, "epg.group.code")%>' positionCode="pos-hdportal-001" resultId="adPos2"/>

<bestv:notEmpty name="adPos2">
	<%
	//System.out.println("this is not none!!!!!!!!!!!!!!!!!!!!!!!");
	%>
    <bestv:iterate id="adPosItem" name="adPos2" property="itemList" indexId="posIndex">
        <%
            HashMap hm = new HashMap();
           // System.out.println("11111111111111::::::::pageContext:::::::::::::::"+pageContext);  
            String positionType = ((PositionViewEntity) ((PositionItem) pageContext.getAttribute("adPosItem")).
                    getViewEntity()).getType();
            String posName = ((PositionViewEntity) ((PositionItem) pageContext.getAttribute("adPosItem")).
                    getViewEntity()).getValue();
            if("txt".equals(positionType)) {
                posName = WordUtil.subWord(posName , 160 , "24px", (Map) application.getAttribute("SUB_STRING_MAP"));
           //     System.out.println(posName);
            }
            hm.put("NAME" , posName);
            String linkColor = ((PositionViewEntity) ((PositionItem) pageContext.getAttribute("adPosItem")).
                    getViewEntity()).getStyle();
            hm.put("STYLE" , linkColor);
            String linkHref = ((PositionViewEntity) ((PositionItem) pageContext.getAttribute("adPosItem")).
                    getEntityLink()).getValue();
            String linkType = ((PositionViewEntity) ((PositionItem) pageContext.getAttribute("adPosItem")).
                    getEntityLink()).getType();
            hm.put("TURNURL" , dispatchUrl + "type=" + linkType + "&value=" + linkHref);
           //for shenzhen's demo
           // hm.put("TURNURL" , "");
            //System.out.println("URL:" + dispatchUrl + "type=" + linkType + "&value=" + linkHref);
            String picUrl = rootUrl + ((PositionItem) pageContext.getAttribute("adPosItem")).getLocalPath() + "/" + posName;
            hm.put("IMGURL" , picUrl);
            partThree.add(hm);
        %>
    </bestv:iterate>
</bestv:notEmpty>
<bestv:findEntity name="baseUI" groupCode='<%=MessageUtil.getMessage(session, "epg.group.code")%>' positionCode="pos-hdportal-002" resultId="adPos2"/>
<bestv:notEmpty name="adPos2">
    <bestv:iterate id="adPosItem" name="adPos2" property="itemList" indexId="posIndex">
        <%
            HashMap hm = new HashMap();
            String positionType = ((PositionViewEntity) ((PositionItem) pageContext.getAttribute("adPosItem")).
                    getViewEntity()).getType();
            String posName = ((PositionViewEntity) ((PositionItem) pageContext.getAttribute("adPosItem")).
                    getViewEntity()).getValue();
            hm.put("NAME" , posName);
            String linkColor = ((PositionViewEntity) ((PositionItem) pageContext.getAttribute("adPosItem")).
                    getViewEntity()).getStyle();
            hm.put("STYLE" , linkColor);
            String linkHref = ((PositionViewEntity) ((PositionItem) pageContext.getAttribute("adPosItem")).
                    getEntityLink()).getValue();
            String linkType = ((PositionViewEntity) ((PositionItem) pageContext.getAttribute("adPosItem")).
                    getEntityLink()).getType();
            hm.put("TURNURL" , dispatchUrl + "type=" + linkType + "&value=" + linkHref);
           //for shenzhen's demo
          //  hm.put("TURNURL" , "");
            String picUrl = rootUrl + ((PositionItem) pageContext.getAttribute("adPosItem")).getLocalPath() + "/" + posName;
            hm.put("IMGURL" , picUrl);
            partThree.add(hm);
        %>
    </bestv:iterate>
</bestv:notEmpty>
<bestv:findEntity name="baseUI" groupCode='<%=MessageUtil.getMessage(session, "epg.group.code")%>' positionCode="pos-hdportal-003" resultId="adPos2"/>
<bestv:notEmpty name="adPos2">
    <bestv:iterate id="adPosItem" name="adPos2" property="itemList" indexId="posIndex">
        <%
            HashMap hm = new HashMap();
            String positionType = ((PositionViewEntity) ((PositionItem) pageContext.getAttribute("adPosItem")).
                    getViewEntity()).getType();
            String posName = ((PositionViewEntity) ((PositionItem) pageContext.getAttribute("adPosItem")).
                    getViewEntity()).getValue();
            if("txt".equals(positionType)) {
                posName = WordUtil.subWord(posName, 160 , "24px", (Map) application.getAttribute("SUB_STRING_MAP"));
                //System.out.println(posName);
            }
            hm.put("NAME" , posName);
            String linkColor = ((PositionViewEntity) ((PositionItem) pageContext.getAttribute("adPosItem")).
                    getViewEntity()).getStyle();
            hm.put("STYLE" , linkColor);
            String linkHref = ((PositionViewEntity) ((PositionItem) pageContext.getAttribute("adPosItem")).
                    getEntityLink()).getValue();
            String linkType = ((PositionViewEntity) ((PositionItem) pageContext.getAttribute("adPosItem")).
                    getEntityLink()).getType();
            hm.put("TURNURL" , dispatchUrl + "type=" + linkType + "&value=" + linkHref);
            //for shenzhen's demo
           // hm.put("TURNURL" , "");
            String picUrl = rootUrl + ((PositionItem) pageContext.getAttribute("adPosItem")).getLocalPath() + "/" + posName;
            hm.put("IMGURL" , picUrl);
            partThree.add(hm);
        %>
    </bestv:iterate>
</bestv:notEmpty>
<%
    partThree.addAll(getDataFromBottom(request));
       
  	dataList.add(partOne);
  	dataList.add(partTwo);
  	dataList.add(partThree);
  	JSONArray jsonObject = JSONArray.fromObject(dataList);
//  	System.out.println("-------------------------------------");
//    System.out.println(jsonObject.toString());  						
	out.write(jsonObject.toString());  	
%>