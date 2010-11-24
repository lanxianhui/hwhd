<%-- Copyright (C), Huawei Tech. Co., Ltd. --%>
<!-- Author:guanfei -->
<%-- CreateAt:2008-02-02 --%>
<%-- FileName:SubscribeSelect_Pre.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="HD_GetPosterPathFunction.jsp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %> 
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="java.net.URLEncoder" %>

<%

    System.out.println("HD_SubscribeSelect 0820qqqqqqqqqqqqqqqqqqqqqqqqqq:::::::::::::::"+request.getQueryString());

    //页面跳转
    TurnPage turnPage = new TurnPage(request);
	//播放影片后会出现过滤页面，清除缓存
    if(out!=null && out.getBufferSize()!=0)
    {
        out.clearBuffer();
    }
    
    
      // 影片ID
    String sProgId = request.getParameter("PROGID"); 
    
    int progId=-999;
    
    if (sProgId != null) {
         progId = Integer.parseInt(sProgId);
    }
    
    
      //连续剧子集id 
   String sChildId = request.getParameter("CHILDID");
     if (sChildId != null) {
         progId = Integer.parseInt(sChildId);
    }
    
 
   	
	ServiceHelp serviceHelp = new ServiceHelp(request);
	MetaData metaData = new MetaData(request);
    
    // 播放类型
    String sPlayType = request.getParameter("PLAYTYPE");
    String sContentType = request.getParameter("CONTENTTYPE");
    String sBusinessType = request.getParameter("BUSINESSTYPE");

	
	String strTypeId = request.getParameter("TYPE_ID");

    
    /* IPTVMEMV100R001C03B310 连续剧特性 2008-05-25 mod by z104564 begin */
	 String supVodid = (String)request.getParameter("FATHERID");
	  //连续剧集号
    String sChildNum = request.getParameter("PROGNUM");
	/* IPTVMEMV100R001C03B310 连续剧特性 2008-05-25 mod by z104564 end */
    // 节目类型
    String sProgType = request.getParameter("PROGTYPE");
    
      //书签设置时间
    String bookMarkTime = request.getParameter( "BOOKMARKTIME" );
	
    if (bookMarkTime == null)
    {
        bookMarkTime = "";
    }
    else
    {
        bookMarkTime = bookMarkTime.trim();
    }
    String hasBookMark = request.getParameter( "hasBookMark" );
    
    if (hasBookMark == null)
    {
        hasBookMark = "0";
    }
    



	
	int playType = Integer.parseInt(sPlayType);
	HashMap film=null;
	
	

ArrayList productsPackage = new ArrayList();
ArrayList vodArr = new ArrayList();
HashMap vodJsonMap = new HashMap();

ArrayList ppvArr = new ArrayList();

ArrayList svodArr = new ArrayList();

	
	//判断播放的类型
	if(playType == EPGConstants.PLAYTYPE_VOD||playType==EPGConstants.PLAYTYPE_BOOKMARK)
	{
		 film = (HashMap)metaData.getVodDetailInfo(progId); 
	}

	String progName= "";
	String vodPrice = "0";
	String vodPrices = "0";
	 String[] strPicPath = null;
	if(film != null)
	{
		vodPrice = (String)(film.get("VODPRICE")==null?"0":film.get("VODPRICE"));
		vodPrices = (String)(film.get("VODPRICE")==null?"0":film.get("VODPRICE"));
		if(playType == EPGConstants.PLAYTYPE_VOD||playType==EPGConstants.PLAYTYPE_BOOKMARK)
		{
			progName = (String)(EPGUtil.swapHtmlStr(film.get("VODNAME").toString(),17,1));
		}
		else
		{
			progName = (String)(EPGUtil.swapHtmlStr(film.get("PROGRAMNAME").toString(),17,1));
		}
		 HashMap posterMap = (HashMap) film.get("POSTERPATHS");
            int posterFlag  = 2;
            int displayFlag = 0;
            strPicPath = GetPosterPathFunction(posterMap, posterFlag, displayFlag);
            if (strPicPath == null || strPicPath.length == 0) {
                strPicPath = new String[] { "images/vod/default.jpg" } ;
	}
	
 vodJsonMap.put("VodID" , progId);	
 vodJsonMap.put("VodName" , progName);
 vodJsonMap.put("HUGEPIC" , strPicPath[0]);
  vodArr.add(vodJsonMap);
	}
	 
	
		
	HashMap retMap = (HashMap)session.getAttribute("RETMAP");
	
	//System.out.println("retMap:::dxy:::::::::::"+retMap);
	
	ArrayList productTimeList = new ArrayList();
	ArrayList productMonthList = new ArrayList();
	
	//包月按次都展示。	
		if(retMap.get("TIMES_LIST") != null)
		{
			productTimeList.addAll((ArrayList)retMap.get("TIMES_LIST"));
		}
		if(retMap.get("MONTH_LIST") != null) 
		{
			productMonthList.addAll((ArrayList)retMap.get("MONTH_LIST"));
		}
	
	
	
	if((productTimeList == null || productTimeList.size() == 0)&&(productMonthList == null || productMonthList.size() == 0))
	{
		turnPage.removeLast();
		%>
			<jsp:forward page="HD_infoDisplay.jsp?ERROR_ID=136" />
		<%		
	}


	for(int i=0; i<productTimeList.size(); i++)
	{
	HashMap ppvJsonMap = new HashMap();
		HashMap productInfo = (HashMap)productTimeList.get(i);
		String prodDesc = (String)productInfo.get("PROD_DESCRIBE");
		int prodCont = ((Integer)productInfo.get("PROD_CONTINUEABLE")).intValue();
		if(null == prodDesc || "null".equals(prodDesc))
        {
            prodDesc = "";
        }
        else
        {
            prodDesc = EPGUtil.swapHtmlStr(prodDesc,50,3);
        }
		
		String prodName = (String)productInfo.get("PROD_NAME");
		String prodName1 = (String)productInfo.get("PROD_NAME");
		if (prodName != null)
    	{
    	    prodName = EPGUtil.swapHtmlStr(prodName,17,1);
    	}
    	
		String prodPrice="0";
		String cdrPrice="0";
		prodPrice = (String)productInfo.get("PROD_PRICE");
		cdrPrice  = (String)productInfo.get("PROD_PRICE");
		if(prodPrice==null)
		{
			prodPrice="0";
		}
		else
		{
			try
			{
				double num = Double.parseDouble(prodPrice);
				num = num/100;
				if (prodPrice != null) 
				{
					prodPrice = EPGUtil.swapHtmlStr(num+"",17, 1);
					prodPrice= prodPrice + "";
				}
			} 
			catch (Exception ex) 
			{
				prodPrice = EPGUtil.swapHtmlStr(prodPrice,17, 1);
				prodPrice = prodPrice;
			}
		}
		//是否支持续订
		if(prodCont == 0 && (playType == EPGConstants.PLAYTYPE_VOD||playType==EPGConstants.PLAYTYPE_BOOKMARK))
		{
		    if(vodPrice==null)
			{
				vodPrice="0";
			}
			else
			{
				try
				{
					double num = Double.parseDouble(vodPrices);
					num = num/100;
					if (vodPrice != null) 
					{
						vodPrice = EPGUtil.swapHtmlStr(num+"",17, 1);
						vodPrice= vodPrice + "";
					}
				} 
				catch (Exception ex) 
				{
					vodPrice = EPGUtil.swapHtmlStr(vodPrice,17, 1);
				}
			}	
			prodPrice = vodPrice;
			cdrPrice  = vodPrices;
		}
		
		String prodPriceTemp = cdrPrice; 
		if(cdrPrice !=null)    
        {
        	if(cdrPrice.indexOf("'") >= 0)
        	{
        		prodPriceTemp = cdrPrice.replaceAll("'","\\\\'");
        	}
            //由于价格中可能包含中文，需要对价格进行编码
        	prodPriceTemp = URLEncoder.encode(prodPriceTemp,"UTF-8");
		}
		else
		{
			prodPrice = "0";
			prodPriceTemp = "0";
		}
		// 获取 产品编码 服务编号 可订购产品有效期的开始时间 可订购产品有效期的结束时间
		String prodID = (String)productInfo.get("PROD_CODE");
		String serviceId = (String)productInfo.get("SERVICE_CODE");
		String prodBeginTime = (String)productInfo.get("productStartTime");
		String prodEndTime = (String)productInfo.get("productEndTime");
		String tempProdEndTime = null;
		if(prodCont == 0)
		{
			tempProdEndTime = serviceHelp.getServiceExpireTime(prodID,serviceId);
			if (tempProdEndTime == null || tempProdEndTime.length() == 0)
			{
				tempProdEndTime = "自购买起24小时";
			}
			else
			{
				tempProdEndTime = tempProdEndTime.substring(0,4) + "-" + tempProdEndTime.substring(4,6) + "-" + tempProdEndTime.substring(6,8) + " " +  tempProdEndTime.substring(8,10) + ":" +tempProdEndTime.substring(10,12) + ":" + tempProdEndTime.substring(12,14);
			}
		}
		else
		{
			if(prodEndTime != null && prodEndTime.length() > 8)
			{
				tempProdEndTime = prodEndTime.substring(0,4) + "-" + prodEndTime.substring(4,6) + "-" + prodEndTime.substring(6,8);
			}
		}
		
		String url ="";
		String  jumpUrl="HD_EnsureSubscribeResult.jsp?PRODID="+prodID+"&PROGID="+progId+"&PLAYTYPE="+playType+"&CONTENTTYPE="+sContentType+"&BUSINESSTYPE="+sBusinessType+"&SELECTPRODCONT="+prodCont+"&SERVICEID="+serviceId+"&FATHERID="+supVodid+"&PROGNUM="+sChildNum+"&BOOKMARKTIME="+bookMarkTime;
		
		
		url="HD_payDetail.jsp?prodName="+prodName+"&prodPrice="+prodPrice+"&prodEndTime="+tempProdEndTime+"&prodDesc="+prodDesc+"&url="+jumpUrl;
		
		
	
	//System.out.println("url::11111111111111111111111111::::::::::::"+url);

//ppv产品名字
	 ppvJsonMap.put("prodName" , prodName);
	 //ppv全名
	  ppvJsonMap.put("prodNameFull" , prodName1);
	  //ppv描述  
	 ppvJsonMap.put("prodDesc" , prodDesc);
	 //ppv价格
	  ppvJsonMap.put("prodPrice" , prodPrice);
	  //ppv有效期
	  ppvJsonMap.put("tempProdEndTime" , tempProdEndTime);
	  //ppv url
	  ppvJsonMap.put("ppvUrl" , url);  
	  
	    ppvArr.add(ppvJsonMap);
	
	}
	
	for(int i=0; i<productMonthList.size(); i++)
	{
	HashMap svodJsonMap = new HashMap();
		HashMap productInfo = (HashMap)productMonthList.get(i);
		String prodDesc = (String)productInfo.get("PROD_DESCRIBE");
		int prodCont = ((Integer)productInfo.get("PROD_CONTINUEABLE")).intValue();
		if(null == prodDesc || "null".equals(prodDesc))
        {
            prodDesc = "";
        }
        else
        {
            prodDesc = EPGUtil.swapHtmlStr(prodDesc,50,3);
        }
		
		String prodName = (String)productInfo.get("PROD_NAME");
		String prodName1 = (String)productInfo.get("PROD_NAME");
		if (prodName != null)
    	{
    	    prodName = EPGUtil.swapHtmlStr(prodName,17,1);
    	}
    	
		String prodPrice="0";
		String cdrPrice="0";
		prodPrice = (String)productInfo.get("PROD_PRICE");
		cdrPrice  = (String)productInfo.get("PROD_PRICE");
		if(prodPrice==null)
		{
			prodPrice="0";
		}
		else
		{
			try
			{
				double num = Double.parseDouble(prodPrice);
				num = num/100;
				if (prodPrice != null) 
				{
					prodPrice = EPGUtil.swapHtmlStr(num+"",17, 1);
					prodPrice= prodPrice + "";
				}
			} 
			catch (Exception ex) 
			{
				prodPrice = EPGUtil.swapHtmlStr(prodPrice,17, 1);
				prodPrice = prodPrice;
			}
		}
		//是否支持续订
		if(prodCont == 0 && (playType == EPGConstants.PLAYTYPE_VOD||playType==EPGConstants.PLAYTYPE_BOOKMARK))
		{
		    if(vodPrice==null)
			{
				vodPrice="0";
			}
			else
			{
				try
				{
					double num = Double.parseDouble(vodPrices);
					num = num/100;
					if (vodPrice != null) 
					{
						vodPrice = EPGUtil.swapHtmlStr(num+"",17, 1);
						vodPrice= vodPrice + "";
					}
				} 
				catch (Exception ex) 
				{
					vodPrice = EPGUtil.swapHtmlStr(vodPrice,17, 1);
				}
			}	
			prodPrice = vodPrice;
			cdrPrice  = vodPrices;
		}
		
		String prodPriceTemp = cdrPrice; 
		if(cdrPrice !=null)    
        {
        	if(cdrPrice.indexOf("'") >= 0)
        	{
        		prodPriceTemp = cdrPrice.replaceAll("'","\\\\'");
        	}
            //由于价格中可能包含中文，需要对价格进行编码
        	prodPriceTemp = URLEncoder.encode(prodPriceTemp,"UTF-8");
		}
		else
		{
			prodPrice = "0";
			prodPriceTemp = "0";
		}
		// 获取 产品编码 服务编号 可订购产品有效期的开始时间 可订购产品有效期的结束时间
		String prodID = (String)productInfo.get("PROD_CODE");
		String serviceId = (String)productInfo.get("SERVICE_CODE");
		String prodBeginTime = (String)productInfo.get("productStartTime");
		String prodEndTime = (String)productInfo.get("productEndTime");
		String tempProdEndTime = null;
		if(prodCont == 0)
		{
			tempProdEndTime = serviceHelp.getServiceExpireTime(prodID,serviceId);
			if (tempProdEndTime == null || tempProdEndTime.length() == 0)
			{
				tempProdEndTime = "自购买起24小时";
			}
			else
			{
				tempProdEndTime = tempProdEndTime.substring(0,4) + "-" + tempProdEndTime.substring(4,6) + "-" + tempProdEndTime.substring(6,8) + " " +  tempProdEndTime.substring(8,10) + ":" +tempProdEndTime.substring(10,12) + ":" + tempProdEndTime.substring(12,14);
			}
		}
		else
		{
			if(prodEndTime != null && prodEndTime.length() > 8)
			{
				tempProdEndTime = prodEndTime.substring(0,4) + "-" + prodEndTime.substring(4,6) + "-" + prodEndTime.substring(6,8);
			}
		}
		
		String url2 = "";
		
		  
		
		String  jumpUrl="HD_EnsureSubscribeResult.jsp?PRODID="+prodID+"&PROGID="+progId+"&PLAYTYPE="+playType+"&CONTENTTYPE="+sContentType+"&BUSINESSTYPE="+sBusinessType+"&SELECTPRODCONT="+prodCont+"&SERVICEID="+serviceId+"&FATHERID="+supVodid+"&BOOKMARKTIME="+bookMarkTime; 
		
		url2="HD_payDetail.jsp?prodName="+prodName+"&prodPrice="+prodPrice+"&prodEndTime="+tempProdEndTime+"&prodDesc="+prodDesc+"&url="+jumpUrl;
			

//svod产品名字
	 svodJsonMap.put("prodName" , prodName);
	 //svod全名
	  svodJsonMap.put("prodNameFull" , prodName1);
	  //svod描述  
	 svodJsonMap.put("prodDesc" , prodDesc);
	 //svod价格
	  svodJsonMap.put("prodPrice" , prodPrice);
	  //svod有效期
	  svodJsonMap.put("tempProdEndTime" , tempProdEndTime);
	  //svod url
	  svodJsonMap.put("svodUrl" , url2);  
	  
	      svodArr.add(svodJsonMap);		
	}
	
	productsPackage.add(vodArr);
	productsPackage.add(ppvArr);
	productsPackage.add(svodArr);
	
	    JSONArray jsonObject = JSONArray.fromObject(productsPackage); 
//    System.out.println("HD_HD_SubscribeSelectInfo:::::::::::::::"+jsonObject.toString());  						
	  out.print(jsonObject.toString());
	
%>
