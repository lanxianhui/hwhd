<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ page import="java.util.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="com.bestv.epg.ui.BaseUI" %>
<%@ page import="com.bestv.epg.util.MessageUtil" %>
<%@ include file="HD_GetPosterPathFunction.jsp" %>


<%!
	  //每次最多取75部影片or分类
	  protected static int FETCH_MAX = 15 * 5;
%>
<%
    ServiceHelp serviceHelp = new ServiceHelp(request);
    
    String flag    = request.getParameter("PAGE");
   // String typeId  = request.getParameter("TYPE_ID");
    //String display = request.getParameter("DISPLAY");
    
     String typeId  = MessageUtil.getMessage(session, "download_vod");
     //System.out.println("typeIdwwwwwwwwwwwwwwwwwwww:::::::::::"+typeId);

    if (null == flag || flag.equals("")) 
    {
    	 flag = "0";
    }
    
    if (null == typeId || typeId.equals("")) 
    {
    	  JSONArray  jsonObject = JSONArray.fromObject(new ArrayList());
        //System.out.println(jsonObject.toString());    						
			  out.print(jsonObject.toString());
    	  return;
    }
    
 
    
    MetaData metaData = new MetaData(request);

    String categoryPath = "";
    String categoryName = "";

  	ArrayList wholeVodTypeList=new ArrayList(); 
  	ArrayList	maxVodTypeListTmp =new ArrayList();

  	ArrayList  vodList_gqxz = metaData.getVodListByTypeId(typeId,FETCH_MAX, FETCH_MAX*(Integer.parseInt(flag)));
  	HashMap tepTypeVod=new HashMap();
  	if(vodList_gqxz != null && vodList_gqxz.size() == 2)
    {
    	  HashMap  newFilmMap = (HashMap)vodList_gqxz.get(0);
    	  int	countTotal = ((Integer) newFilmMap.get("COUNTTOTAL")).intValue();
    	  tepTypeVod.put("count",countTotal);
    
    	 	List vodList_gqxz_name = new ArrayList();
  	    List vodList_gqxz_url = new ArrayList();
  	    List vodList_gqxz_pic = new ArrayList();
  	    List realvodList_gqxz = (List) vodList_gqxz.get(1);
  	   
            for (Iterator iterator = realvodList_gqxz.iterator(); iterator.hasNext();) 
       	    {
       	        HashMap tmp = new HashMap();
       	   	    Map vod = (Map) iterator.next();
       	   	 
       	   	    tmp.put("name" , vod.get("VODNAME"));
       	   	    tmp.put("vodId" , vod.get("VODID"));
       	   	    String temUrl="HD_vodDetail.jsp?PROGID="+vod.get("VODID");
       	   	    tmp.put("url" , temUrl);	   
       	   	 
                HashMap posterMap = (HashMap) vod.get("POSTERPATHS");
                int posterFlag  = 0;
                int displayFlag = 0;
                String[] pics = GetPosterPathFunction(posterMap, posterFlag, displayFlag);
                String picPath = (pics != null && pics.length > 0) ? pics[0] : "images/vod/default.jpg";
                tmp.put("pic" , picPath);
                
                maxVodTypeListTmp.add(tmp);
       	    }
   	    
			}
			else
			{
				 tepTypeVod.put("count","");
			}
			tepTypeVod.put("sub",maxVodTypeListTmp);
			tepTypeVod.put("pathname" , categoryPath);
			tepTypeVod.put("typename" , categoryName);
			wholeVodTypeList.add(tepTypeVod);	
			
		//	String testCase='[{"sub":[{"vodId":1,"name":"beijing","pic":"images od/default.jpg","url":"HD_vodDetail.jsp?PROGID=8"},{"vodId":2,"name":"千手观音","pic":"images od/default.jpg","url":"HD_vodDetail.jsp?PROGID=9"},{"vodId":3,"name":"宝贝宝贝宝贝宝贝宝贝","pic":"images od/default.jpg","url":"HD_vodDetail.jsp?PROGID=10"},{"vodId":4,"name":"诺基京"pic":"images od/default.jpg","url":"HD_vodDetail.jsp?PROGID=12"},{"vodId":5,"name":"paly","pic":"images od/default.jpg","url":"HD_vodDetail.jsp?PROGID=22"},{"vodId":6,"name":"car","pic":"images od/default.jpg","url":"HD_vodDetail.jsp?PROGID=42"},{"vodId":7,"name":"高清paly","pic":"images od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":8,"name":"高清paly","pic":"images od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":9,"name":"高清paly","pic":"images od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":10,"name":"高清paly","pic":"images od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":11,"name":"高清paly","pic":"images od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":12,"name":"高清paly","pic":"images od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":13,"name":"高清paly","pic":"images od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":14,"name":"高清paly","pic":"images od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":15,"name":"高清paly","pic":"images od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":16,"name":"高清paly","pic":"images od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":17,"name":"高清paly","pic":"images od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":18,"name":"高清paly","pic":"images od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":19,"name":"高清paly","pic":"images od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":20,"name":"高清paly","pic":"images od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":21,"name":"高清paly","pic":"images od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":22,"name":"高清paly","pic":"images od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":23,"name":"高清paly","pic":"images od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":24,"name":"高清paly","pic":"images od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":25,"name":"高清paly","pic":"images od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":26,"name":"高清paly","pic":"images od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":27,"name":"高清paly","pic":"images od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":28,"name":"高清paly","pic":"images od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":29,"name":"高清paly","pic":"images od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},{"vodId":30,"name":"高清paly","pic":"images od/default.jpg","url":"HD_vodDetail.jsp?PROGID=43"},],"count":30,"typename":"","pathname":""}]';
  	  	
  	 // System.out.println(testCase); 	
  	  	
      JSONArray  jsonObject = JSONArray.fromObject(wholeVodTypeList);
    //  JSONArray  jsonObject = JSONArray.fromObject(testCase);
        					
			out.print(jsonObject.toString());    
%>
