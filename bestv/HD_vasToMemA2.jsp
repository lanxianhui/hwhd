<%-- Copyright (C),BesTV. Co., Ltd. --%>
<%-- Author:Caiyuhong --%>
<%-- CreateAt:20080502 --%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.io.ByteArrayInputStream"%>
<%@ page import="org.dom4j.io.SAXReader"%>
<%@ page import="org.dom4j.Document"%>
<%@ page import="org.dom4j.Element"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="java.text.*" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage"%>
<%@ page import="com.huawei.iptvmw.util.StringUtil"%>
<%@ page import="com.huawei.iptvmw.util.SingleReturn"%>
<%@ page import="com.huawei.iptvmw.util.IPTVConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.CodeTransformUtil"%>
<%@ page import="com.huawei.iptvmw.util.DataValidation"%>
<%@ page import="com.huawei.iptvmw.logger.EPGSysLogger"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page buffer="16kb" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>Process Vas Request</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript">
		
			//此处URL需根据所使用的模板做相应的调整

			//0:Portal 1:VOD_Menu 2:LiveTV_Menu 3:TVOD_Menu
			var tempurllist = new Array();
			tempurllist[0] = "./HD_portal.jsp";
	        tempurllist[1] = "./VodAction.jsp?MainPage=1&INDEXPAGE=0&STATION=0&LENGTH=25&TYPE_ID=-1&ISFIRST=1&subjectType=" + <%=EPGConstants.SUBJECTTYPE_VOD%> + "|" + <%=EPGConstants.SUBJECTTYPE_VIDEO_VOD%> + "|" + <%=EPGConstants.SUBJECTTYPE_AUDIO_VOD%> + "|" + <%=EPGConstants.SUBJECTTYPE_MIXED%>;
	        tempurllist[2] = "./ChanAction.jsp?TYPE_ID=1003&LENGTH=54&STATION=0&ISFIRST=1&subjectType=" + <%=EPGConstants.SUBJECTTYPE_CHANNEL%> + "|" + <%=EPGConstants.SUBJECTTYPE_VIDEO_CHANNEL%> + "|" + <%=EPGConstants.SUBJECTTYPE_AUDIO_CHANNEL%> + "|" + <%=EPGConstants.SUBJECTTYPE_MIXED%>;
	        tempurllist[3] = "./ProgRecordTable.jsp?ISFIRST=1";
		</script>
	</head>

	<body bgcolor="transparent" style="background-Repeat:no-repeat">
		<%
         final String ACTION_PLAY_TV = "play_tv";
         final String ACTION_PLAY_TVOD = "play_tvod";
         final String ACTION_PLAY_VOD = "play_vod";
		     final String ACTION_PLAY_TRAILER = "play_trailer";
		     final String ACTION_FULLSCREEN = "fullscreen";
         final String ACTION_BACK = "back";
         final String ACTION_GOTO_PAGE = "goto_page";
		     //NBA开发
		     final String ACTION_GOTO_NBA = "auth_and_purchase";
		     final String ACTION_GOTO_NBA_AUTH = "vis_auth";
		     final String ACTION_GOTO_NBA_PUR = "vis_purchase";

         final String GOTO_PAGE_PORTAL = "portal";
         final String GOTO_PAGE_LIVETV_MENU = "LiveTV_Menu";
         final String GOTO_PAGE_TVOD_MENU = "TVOD_Menu";
         final String GOTO_PAGE_VOD_MENU = "VOD_Menu";
         final String GOTO_PAGE_THIRD_PAGE = "Third_page";
         final String GOTO_PAGE_OTHER = "Other";
		 
		     final String GOTO_PAGE_NBA = "NBA_page";
		 
		

         String vas_action = null;

         String mediacode = null;
		     String mediatype = null;

         String vas_back_url = null;

         String epg_page = null;

         String schedule_time = null;

		 String additional = null;

		 String width = null, height = null, top = null, left = null;
		 String trailer_type = null;
		 
		     String amod = null;

     SingleReturn ret = new SingleReturn(true, IPTVConstants.PROCESS_OK);
         
		 ServiceHelp serviceHelp = new ServiceHelp(request);
         MetaData metaData = new MetaData(request);

		 try{			 
			 String test = request.getParameter("vas_info") != null ? request.getParameter("vas_info") :
                (String) session.getAttribute("vas_info");//request.getQueryString();
       session.removeAttribute("vas_info");
			 test = URLDecoder.decode(test);
//            System.out.println("vas_info=this:::::::::::::::::::::" + test);
             //int p = test.indexOf("vas_info=");

			 //String str = test.substring(p+9,test.length());
			 String str = test;
	         String vas_info = "<?xml version=\"1.0\" encoding=\"GB2312\"?><root>" + str + "</root>";

			 vas_info = vas_info.replaceAll("&","&amp;"); 
			 System.out.println("After decode:" + vas_info);
       SAXReader reader = new SAXReader();
	 
	     Document doc = reader.read(new ByteArrayInputStream(
           vas_info.getBytes()));
       Element root = doc.getRootElement();

       vas_action = root.elementText("vas_action");
       
      // System.out.println("ceshihsiahidhsvsdv::::::::::::"+vas_action); 

       mediacode = root.elementText("mediacode");	
	     mediatype = root.elementText("mediatype");	
	 
	     additional = root.elementText("additional");
	     if(additional != null) {
	       //System.out.println("additional:" + additional);
	     }
	 
	     vas_back_url = root.elementText("vas_back_url");
       if(vas_back_url != null) {
		     vas_back_url = vas_back_url.replaceAll("&amp;","&");
		     vas_back_url = URLEncoder.encode(vas_back_url);
			 session.setAttribute("vas_back_url", vas_back_url);
	     }
	     
	     //System.out.println("vas_back_url:" + vas_back_url);

       epg_page = root.elementText("epg_page");

       schedule_time = root.elementText("schedule_time");
       
       amod = root.elementText("amod");

			 //支持fullscreen，将其分发到具体的三种类型

			 if(ACTION_FULLSCREEN.equalsIgnoreCase(vas_action)) {
				 if(mediatype == null && !(mediatype.equalsIgnoreCase("TV") || mediatype.equalsIgnoreCase("TVOD")
					 || mediatype.equalsIgnoreCase("VOD")) ) {
					 ret.setSuccessOrFail(false);
					 ret.setMessage("fullscreen's parameter of mediatype is missing.");
				 }else {
					 if(mediatype.equalsIgnoreCase("TV"))        vas_action = ACTION_PLAY_TV;
				     else if(mediatype.equalsIgnoreCase("TVOD")) vas_action = ACTION_PLAY_TVOD;
				     else if(mediatype.equalsIgnoreCase("VOD"))  vas_action = ACTION_PLAY_VOD;
				 }
			 }

       // ==================开始：校验============================
       if (ACTION_PLAY_TV.equalsIgnoreCase(vas_action)
           || ACTION_PLAY_VOD.equalsIgnoreCase(vas_action)
           || ACTION_PLAY_TVOD.equalsIgnoreCase(vas_action))
       {
       //System.out.println("here:::::::::::::::::::::");
           // LiveTV 、点播、TVOD
           if (StringUtil.isNullString(mediacode)
               || StringUtil.isNullString(vas_back_url))
           {
               ret.setMessage("mediacode or vas_back_url can not be null or empty.");
               ret.setSuccessOrFail(false);
           }
       }else if(ACTION_PLAY_TRAILER.equalsIgnoreCase(vas_action)) {
				 width  = root.elementText("width");
				 height = root.elementText("height");
				 top  = root.elementText("top");
				 left = root.elementText("left");
				 if(width == null || height == null || top == null 
					 || left == null) {
					 ret.setSuccessOrFail(false);
	                 ret.setMessage("play trailer's parameters are missing.");
				 }else {
					 try {
						 Integer.parseInt(width);
						 Integer.parseInt(height);
						 Integer.parseInt(top);
						 Integer.parseInt(left);
					 }catch(NumberFormatException e) {
						 ret.setSuccessOrFail(false);
						 ret.setMessage("play trailer'parameters is not numeral.");
					 }					
				 }

			 }
			 //NBA新开发
			 else if (ACTION_GOTO_NBA.equalsIgnoreCase(vas_action))
	         {
			    if (StringUtil.isNullString(mediacode)
                    || StringUtil.isNullString(vas_back_url))
               {
               ret.setMessage("mediacode or vas_back_url can not be null or empty.");
               ret.setSuccessOrFail(false);
               }
			 }
			 	 else if (ACTION_GOTO_NBA_AUTH.equalsIgnoreCase(vas_action))
	         {
			    if (StringUtil.isNullString(mediacode)
                    || StringUtil.isNullString(vas_back_url))
               {
               ret.setMessage("mediacode or vas_back_url can not be null or empty.");
               ret.setSuccessOrFail(false);
               }
			 }
			 	 else if (ACTION_GOTO_NBA_PUR.equalsIgnoreCase(vas_action))
	         {
			    if (StringUtil.isNullString(mediacode)
                    || StringUtil.isNullString(vas_back_url))
               {
               ret.setMessage("mediacode or vas_back_url can not be null or empty.");
               ret.setSuccessOrFail(false);
               }
			 }
			 else if (ACTION_BACK.equalsIgnoreCase(vas_action))
	         {
				       //Mask By Caiyuhong 2008-05-08
	             // 返回到进入的Epg页面
	             //if (StringUtil.isNullString(epg_page))
	             //{
	                 //ret.setMessage("epg_page can not be null or empty.");
	                 //ret.setSuccessOrFail(false);
	             //}
	         }else if (ACTION_GOTO_PAGE.equalsIgnoreCase(vas_action))
	         {
	             // 与epg_page相结合，进入相应的Page页面
	         }else
	         {
	             ret.setSuccessOrFail(false);
	             ret.setMessage("vas_action type is error.");
	         }
		}
		catch(Exception e)
		{
			e.printStackTrace();
			ret.setSuccessOrFail(false);
			ret.setMessage("parse xml error. vas_info:"+request.getParameter("vas_info"));
		}
		 // ==================结束：校验============================
		 //Modifyed by Caiyuhong in 2008-05-16**********************
		 String progId = "";
		 if (ret.isSuccessOrFail() && !ACTION_BACK.equalsIgnoreCase(vas_action)) {
			 if(ACTION_PLAY_TRAILER.equalsIgnoreCase(vas_action) && mediatype !=null) {
			 	 if(mediatype.equalsIgnoreCase("TV"))        trailer_type = "CHAN";
			 	 else if(mediatype.equalsIgnoreCase("VOD"))  trailer_type = "VOD";
				 else {
					 //ret.setSuccessOrFail(false);
					 //ret.setMessage("Trailer can only support CHAN and VOD now.");
				 }
			 }

			 int typeid = -1;
			 if(ACTION_PLAY_TVOD.equalsIgnoreCase(vas_action) || ACTION_PLAY_TV.equalsIgnoreCase(vas_action))
		      typeid = 1;
			 else if(ACTION_PLAY_VOD.equalsIgnoreCase(vas_action))  typeid = 0;
			 else if(ACTION_GOTO_NBA.equalsIgnoreCase(vas_action))  typeid = 0;
			 else if(ACTION_GOTO_NBA_AUTH.equalsIgnoreCase(vas_action))  typeid = 0;
			 else if(ACTION_GOTO_NBA_PUR.equalsIgnoreCase(vas_action))  typeid = 0;
			 else typeid = -1;
       
       Object objsID = null;
	     Map typeInfo = new HashMap();
	     
	    
		 
			 if(typeid != -1) {
          if (typeid == 1) {
          
			 typeInfo = metaData.getContentDetailInfoByForeignSN(mediacode, EPGConstants.CONTENTTYPE_CHANNEL_VIDEO);
	      if(typeInfo == null) {
              	ret.setSuccessOrFail(false);
              	}
              else
              	{
			objsID = typeInfo.get("CHANNELID");
			}
			 
              if(objsID == null) {
              	ret.setSuccessOrFail(false);
              }else {
                progId = objsID.toString();
                trailer_type = "CHAN";
              }
          }else if (typeid == 0) {
          	
			  typeInfo = metaData.getContentDetailInfoByForeignSN(mediacode, EPGConstants.CONTENTTYPE_VOD_VIDEO);

			
			  if(typeInfo == null) {
              	ret.setSuccessOrFail(false);
              	}
              else
              	{
						objsID = typeInfo.get("VODID");
			}
			
              if(objsID == null) {
              	ret.setSuccessOrFail(false);
              }else {
              	 //System.out.println("xxxxxxxxxxxxxxxxxx:::::::::::::::::::::"+objsID);
                progId = objsID.toString();
                trailer_type = "VOD";
              }
          }
			}
		    //**********************************************************
			if(progId.equals("") && typeid != -1) {
				ret.setSuccessOrFail(false);
				ret.setMessage("Play Media action, but missing progId.");
			}
     
			if(trailer_type == null && ACTION_PLAY_TRAILER.equalsIgnoreCase(vas_action)) {
				 int tmp = 0;
				 //System.out.println("DOGCAI:"+mediacode);
		 
		  typeInfo = metaData.getContentDetailInfoByForeignSN(mediacode, EPGConstants.CONTENTTYPE_VOD_VIDEO);
			
				  if(typeInfo == null) {
              	ret.setSuccessOrFail(false);
              	}
              else
              	{
						objsID = typeInfo.get("VODID");
			}
         
				 if(objsID != null) tmp = Integer.parseInt((String)objsID);
				 else tmp = 0;
				 if(tmp == 0) {
		   	 typeInfo = metaData.getContentDetailInfoByForeignSN(mediacode, EPGConstants.CONTENTTYPE_CHANNEL_VIDEO);	
			objsID = typeInfo.get("CHANNELID");
		   
					 if(objsID != null) {
						 tmp = Integer.parseInt((String)objsID);
						 trailer_type = "CHAN";
					 }
					 else
						 tmp = 0;
				 }else {
					 trailer_type = "VOD";
				 }
				 if(tmp == 0) {
					 ret.setSuccessOrFail(false);
					 ret.setMessage("Can not find the Trailer's type.");
				 }					 
			}
		 }

         if (ret.isSuccessOrFail())
         {
		   //NBA新增
		   if (ACTION_GOTO_NBA.equalsIgnoreCase(vas_action))
		     {
		      %>
			    <script>
							window.location.href.target = "_top";
						//	window.location.href = "PlayChannelControl.jsp?ProgID=<%=progId%>&backurl=<%=vas_back_url%>";
							window.location.href ="NBASubscription.jsp?CONTENTTYPE=10&BUSINESSTYPE=1&PLAYTYPE=1&PROGID=<%=progId%>" ;
                 </script>
			  <%
		      }
		       if (ACTION_GOTO_NBA_AUTH.equalsIgnoreCase(vas_action))
		     {
		      %>
			    <script>
							window.location.href.target = "_top";
						//	window.location.href = "PlayChannelControl.jsp?ProgID=<%=progId%>&backurl=<%=vas_back_url%>";
							window.location.href ="NBASubscription.jsp?CONTENTTYPE=10&BUSINESSTYPE=1&PLAYTYPE=1&PROGID=<%=progId%>&authFlag=1" ; 
                 </script>
			  <%
		      }
		       if (ACTION_GOTO_NBA_PUR.equalsIgnoreCase(vas_action))
		     {
		      %>
			    <script>
							window.location.href.target = "_top";
						//	window.location.href = "PlayChannelControl.jsp?ProgID=<%=progId%>&backurl=<%=vas_back_url%>";
							window.location.href ="NBASubscription.jsp?CONTENTTYPE=10&BUSINESSTYPE=1&PLAYTYPE=1&PROGID=<%=progId%>" ;
                 </script>
			  <%
		      }
		   
				if (ACTION_PLAY_TV.equalsIgnoreCase(vas_action))
	            {
					session.setAttribute("MEDIAPLAY","1");
				String	chanNum = String.valueOf(serviceHelp.getChannelIndexByID(new Integer(progId)));
					//播放TV
					%>
						<script>
							window.location.href.target = "_top";
							//window.location.href = "PlayChannelControl.jsp?ProgID=<%=progId%>&backurl=<%=vas_back_url%>";
								window.location.href = "HD_playliveControl.jsp?currentNum=<%=chanNum%>&flag=1"
                        </script>
					<%
                }
                else if (ACTION_PLAY_TRAILER.equalsIgnoreCase(vas_action))
                {
		                // 播放trailer
		               
		                String temp ="HD_PlayTrailerInVas.jsp?mediacode="+ mediacode+ "&type="+trailer_type+"&width="+width+"&height="+height+"&top="+top+"&left="+left;
		                System.out.println("temp::::::: "+temp);
						response.sendRedirect(temp);     
						//window.location.href = temp;
						%>
						<script>
						//	window.location.href.target = "_top";
						//	window.location.href = "PlayTrailerInVas.jsp?mediacode=<%=mediacode%>&type=<%=trailer_type%>&width=<%=width%>&height=<%=height%>&top=<%=top%>&left=<%=left%>";
						</script>
						<%
                }
				else if (ACTION_PLAY_VOD.equalsIgnoreCase(vas_action))
                {
                	String vodTarget = "";
                		//System.out.println("progId2222222222222222::::::: " + progId);
		               // 播放点播
						if(amod != null) 
						{
        vodTarget = "IPTVAmodHandel.jsp?amod=" + amod + "&PROGID=" + progId + "&PLAYTYPE=1" +
                (additional == null ? "" : "&categoryName=" + additional);
            }else {
        vodTarget = "play.jsp?PROGID=" + progId + "&PLAYTYPE=1" +
                (additional == null ? "" : "&categoryName=" + additional);                
    }%>
<script type="text/javascript">
    window.location.href.target = "_top";
    window.location.href = '<%=vodTarget%>';  
</script>
<%
                }
                else if (ACTION_PLAY_TVOD.equalsIgnoreCase(vas_action))
                {
                
	                    // 校验时间的格式是否正确

	                    DataValidation dv = new DataValidation();
	                    dv.addDatetime("schedule_time", schedule_time);
	                    ret = dv.validate();

	                    // 播放TVOD
	                    if (ret.isSuccessOrFail())
	                    {
	                    
	                    	//String playBillCode=null;
							StringBuffer sb = null;
	                    
					        if (EPGSysLogger.isDebug())
					        {
					            sb = new StringBuffer(50);
					            sb.append("The parameter : chanCode = ").append(mediacode);
					            sb.append(" schedule_time=").append(schedule_time);
					            EPGSysLogger.debug(sb.toString());
					        }

				
							HashMap resultBill = metaData.getContentDetailInfoByForeignSN(mediacode, 1);
							
							
							String channelId = "";
							int intChannelId = 0;
							progId = "0";
							String progStartTime = "";
							String progEndTime = "";
							boolean processing = false;
							String progStatus = "";
							List progRecord = null;
							
							String bktp1 = "";
							String bktp2 = "";

							if (resultBill != null) {
								channelId = ((Integer) resultBill.get("CHANNELID")).toString();
								intChannelId = ((Integer) resultBill.get("CHANNELID")).intValue();
								//根据channel ID 获取节目单,参数详见接口文档
								progRecord = metaData.getChannelRecBill(intChannelId, 999, 0, 1, "-1");
							}

							// 没有在中间件中通过code找到对应的内部channelId
							if ("".equals(channelId)) {
								// 频道不存在，直接返回错误
								ret.setMessage("cannot find the channel according to mediacode:"
										+ mediacode + ".");
								ret.setSuccessOrFail(false);
							}
					
							// 找到channelId，则做进一步处理
							else {
	
								String playBillCode = null; //控制是否播放TVOD
					
								if (progRecord == null || ((ArrayList) progRecord.get(1)).size() == 0) {
									EPGSysLogger.debug("This channel doesn't have playbills.");	
										String	infoDisplayPage = "HD_infoDisplay.jsp?ERROR_ID=105";
														%>
														<jsp:forward page="<%=infoDisplayPage%>"/>
														<%				
								} else {
									ArrayList vas_billRecord = (ArrayList) progRecord.get(1);
									//本次获取的实际节目单数
									int progSize = vas_billRecord.size();
					
									if (progSize == 0) {
										EPGSysLogger.debug("This channel doesn't have playbills.");
					
									}
									//有节目单的，则做节目单遍历，找到schedule_time对应的节目CODE
									else {
										HashMap progMap = new HashMap();
										//节目的录制状态
										int[] STATUS = new int[progSize];
										//节目的录制状态
										int j = 0;
										for (j = 0; j < progSize; j++) {
											progMap = (HashMap) vas_billRecord.get(j);
					
											// 获取当前节目单的状态，第5位即int[4]是TVOD的状态
											STATUS[j] = ((Integer) progMap.get("STATUS")).intValue();
					
											// 计算开始和结束时间
											progStartTime = (String) progMap.get("STARTTIME");
											bktp1 =progStartTime;
											progStartTime = progStartTime.substring(0, progStartTime.length() - 2) + "00";
											progEndTime = (String) progMap.get("ENDTIME");
											bktp2 = progEndTime;
											progEndTime = progEndTime.substring(0, progEndTime.length() - 2) + "00";
					
											if (progStartTime.compareTo(schedule_time) <= 0
													&& progEndTime.compareTo(schedule_time) > 0) //录播的节目单时间必须完全在时间范围跨度内
											{
												if (STATUS[j] == EPGConstants.TVOD_PROGRAM_FAILED) {
												String	infoDisplayPage = "HD_infoDisplay.jsp?ERROR_ID=1&backurl=" + vas_back_url;
													%>
													<jsp:forward page="<%=infoDisplayPage%>"/>
													<%
												}
												if (STATUS[j] == EPGConstants.TVOD_PROGRAM_INIT) {
													SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss",Locale.SIMPLIFIED_CHINESE);
													String str = sdf.format(new Date()); 
													if (str.compareTo(progEndTime) >= 0) {
													String	infoDisplayPage = "HD_infoDisplay.jsp?ERROR_ID=105&backurl=" + vas_back_url;
														%>
														<jsp:forward page="<%=infoDisplayPage%>"/>
														<%
													}else {
														processing = true;
													}
													}
													progId = progMap.get("PROGRAMID").toString();
													playBillCode = "ok";
													break;
												}
											}
					
											//找不到相应节目单，则进入直播
											if (j == progSize) {
												processing = true;
											}
					
					
											if ((null == playBillCode || "".equals(playBillCode)) && !processing) {
												ret.setSuccessOrFail(false);
												ret.setMessage("the playbill does not exists.");
											}else if (processing) {
												int channelNum = 0;
												String	chanNum ="";
												try {
													Map entityMap = metaData.getContentDetailInfoByForeignSN(mediacode, 1);
													channelNum = ((Integer) entityMap.get("CHANNELINDEX")).intValue();
													chanNum = String.valueOf(serviceHelp.getChannelIndexByID(new Integer(channelNum))); 
												} catch (Exception e) {
													ret.setSuccessOrFail(false);
													ret.setMessage("processing fail.");
												}
											//	System.out.println("111111111111111111");
												%>
												<script>
													window.location.href.target = "_top";
													//window.location.href = "PlayChannelControl.jsp?ProgID=<%=channelNum%>&backurl=<%=vas_back_url%>";
												window.location.href = "HD_playliveControl.jsp?currentNum=<%=chanNum%>&flag=1"
												</script>
												<%
											}else {
											//System.out.println("222222222222222");
													if(additional == null) {
													%>
													<script>
														window.location.href.target = "_top";
													//	window.location.href = "PlayTvodControl.jsp?PROGID=<%=progId%>&PROGSTARTTIME=<%=progStartTime%>&PROGENDTIME=<%=progEndTime%>&backurl=<%=vas_back_url%>&CHANNELID=<%=channelId%>&PLAYTYPE=<%=EPGConstants.PLAYTYPE_TVOD%>";
										window.location.href = "HD_playTvodControl.jsp?PROGID=<%=progId%>&PROGSTARTTIME=<%=progStartTime%>&PROGENDTIME=<%=progEndTime%>&CHANNELID=<%=channelId%>&PLAYTYPE=<%=EPGConstants.PLAYTYPE_TVOD%>";
													</script>
													<%
													}else {
												//	System.out.println("333333333333333");
													%>
													<script>
														window.location.href.target = "_top";
													//	window.location.href = "PlayTvodAd.jsp?PROGID=<%=progId%>&PROGSTARTTIME=<%=bktp1%>&PROGENDTIME=<%=bktp2%>&backurl=<%=vas_back_url%>&channelName=<%=additional%>&PLAYTYPE=4&CHANNELID=<%=channelId%>";
													window.location.href = "HD_playTvodControl.jsp?PROGID=<%=progId%>&PROGSTARTTIME=<%=progStartTime%>&PROGENDTIME=<%=progEndTime%>&CHANNELID=<%=channelId%>&PLAYTYPE=<%=EPGConstants.PLAYTYPE_TVOD%>";
													</script>
													<%
													}
											}
										}
									}
								}
						}
                }
                else if (ACTION_BACK.equalsIgnoreCase(vas_action))
                {
                    new TurnPage(request).getNewTurnList();
                		
                    // 返回到进入的Epg页面
					%>
					<script type="text/javascript">
						//	alert(tempurllist[0]);	
						    window.location.href = tempurllist[0];
					</script>
					<%
                }
                else if (ACTION_GOTO_PAGE.equalsIgnoreCase(vas_action))
                {
                    // 与epg_page相结合，进入相应的Page页面
                    int index = -1;

                    if (epg_page.equalsIgnoreCase(GOTO_PAGE_PORTAL))
                    {
                        // Portal
                        index = 0;
                    }
                    else if (epg_page.equalsIgnoreCase(GOTO_PAGE_VOD_MENU))
                    {
                        // VOD_Menu
                        index = 1;
                    }
                    else if (epg_page.equalsIgnoreCase(GOTO_PAGE_LIVETV_MENU))
                    {
                        // LiveTV_Menu
                        index = 2;
                    }
                    else if (epg_page.equalsIgnoreCase(GOTO_PAGE_TVOD_MENU))
                    {
                        // TVOD_Menu
                        index = 3;
                    }
                    else
                    {
                        ret.setSuccessOrFail(false);
                        ret.setMessage("epg_page type is error or not realized. ");
                    }

                    if (ret.isSuccessOrFail())
                    {
						%>
						<script type="text/javascript">window.location.href = tempurllist[<%=index%>];</script>
						<%
                	}

                }
            }
            if (!ret.isSuccessOrFail())
            {
                EPGSysLogger.debug("VASTOMEM: " + ret.toString());
				//System.out.println("Deal result:" + ret.toString());
				//System.out.println("end vas_back_url:" + vas_back_url);
				String pageUrl = "InfoDisplay.jsp?ERROR_ID=86&ERROR_TYPE=2&backurl=" + vas_back_url;
				%>
				<jsp:forward page="<%=pageUrl%>"/>
				<%
				
			}
		%>
	</body>
</html>
