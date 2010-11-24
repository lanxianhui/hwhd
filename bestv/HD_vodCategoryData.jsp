<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="java.util.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="com.bestv.epg.ui.BaseUI" %>
<%@ include file="HD_vodBasicInfo.jsp" %>
<%!
	  //每次最多取72部影片or分类
	  protected static int FETCH_MAX = 12 * 5; 
%>
<%
    ServiceHelp serviceHelp = new ServiceHelp(request);
    
    String flag    = request.getParameter("PAGE");
    String typeId  = request.getParameter("TYPE_ID");
    String display = request.getParameter("DISPLAY");

    if (null == flag || flag.equals("")) 
    {
    	 flag = "0";
    }
    
    if (null == typeId || typeId.equals("")) 
    {
    	  JSONArray  jsonObject = JSONArray.fromObject(new ArrayList());
     //   System.out.println(jsonObject.toString());    						
			  out.print(jsonObject.toString());
    	  return;
    }
    
    if (null == display || display.equals(""))
    {
        display = "1";
    }
    
    MetaData metaData = new MetaData(request);
    String categoryPath = "";
    String categoryName = "";
    String pathId = typeId;
    while (true) {
        if (pathId.equals("-1")) break;
        HashMap parentInfo = metaData.getTypeInfoByTypeId(pathId);
        if(("".equals(categoryName))&&(parentInfo != null)) categoryName = parentInfo.get("TYPENAME").toString();
        pathId = parentInfo.get("PARENTID").toString();
        categoryPath = "-" + parentInfo.get("TYPENAME").toString() + categoryPath;
    }
    categoryPath = "点播" + categoryPath;
    
  	ArrayList wholeVodTypeList=new ArrayList(); 
  	ArrayList	maxVodTypeListTmp =new ArrayList();

  	ArrayList  vodList_zxgx = metaData.getVodListByTypeId(typeId,FETCH_MAX, FETCH_MAX*(Integer.parseInt(flag)));
  	//System.out.println("vodList_zxgx::::::::::::::"+vodList_zxgx+":::::::flag:::::::"+flag);
  	HashMap tepTypeVod=new HashMap();
  	if(vodList_zxgx != null && vodList_zxgx.size() == 2)
    {
    	  HashMap  newFilmMap = (HashMap)vodList_zxgx.get(0);
    	  int	countTotal = ((Integer) newFilmMap.get("COUNTTOTAL")).intValue();
    	  tepTypeVod.put("count",countTotal);
    
    	 	List vodList_zxgx_name = new ArrayList();
  	    List vodList_zxgx_url = new ArrayList();
  	    List vodList_zxgx_pic = new ArrayList();
  	    List realVodList_zxgx = (List) vodList_zxgx.get(1);
  	    if("1".equals(display)) {
            for (Iterator iterator = realVodList_zxgx.iterator(); iterator.hasNext();) 
       	    {
       	        HashMap tmp = new HashMap();
       	   	    Map vod = (Map) iterator.next();
//  				System.out.println(vod.get("VODNAME"));     	   	 
       	   	    tmp.put("name" , vod.get("VODNAME"));
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
   	    }else {
   	    	  int v = 0;//高清推荐取4部片子
   	    	  for (Iterator iterator = realVodList_zxgx.iterator(); v<4 && iterator.hasNext();v++) 
       	    {
       	   	    Map vod = (Map) iterator.next();
       	   	    String vodId = ((Integer)vod.get("VODID")).toString();
       	   	    HashMap vodDetail = getVodBasicInfo(session , request , serviceHelp , metaData , vodId , typeId);      	   	   
                maxVodTypeListTmp.add(vodDetail);
       	    }
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
  	  	
      JSONArray  jsonObject = JSONArray.fromObject(wholeVodTypeList);
       //System.out.println("VODtest::::::::::::"+jsonObject.toString());    						
	  out.print(jsonObject.toString());    
%>
