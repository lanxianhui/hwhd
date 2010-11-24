<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGSysParam" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil" %>
<%@ page import="com.huawei.iptvmw.epg.bean.func.UserBookmark" %>
<%@ page import="javax.servlet.http.*" %> 
<%@ page import="java.util.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="HD_GetPosterPathFunction.jsp" %>
<%@ taglib uri="http://epg.bestv.com/tags" prefix="bestv" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.ProgramBookInfo" %>

<%!
    public HashMap getVodBasicInfo(HttpSession session , HttpServletRequest request , ServiceHelp serviceHelp , MetaData metaData , String strFilmId , String strTypeId) {
        
        HashMap jsonMap = new HashMap();
        HashMap filmInfoMap = (HashMap) metaData.getVodDetailInfo(Integer.parseInt(strFilmId));
        if (null == filmInfoMap) return null;
        
        String[] strPicPath = null;
        if (filmInfoMap != null) {
            HashMap posterMap = (HashMap) filmInfoMap.get("POSTERPATHS");
            int posterFlag  = 0;
            int displayFlag = 0;
            strPicPath = GetPosterPathFunction(posterMap, posterFlag, displayFlag);
            if (strPicPath == null || strPicPath.length == 0) {
                strPicPath = new String[] { "images/vod/default.jpg" } ;
            }
            jsonMap.put("SMALLPIC" , strPicPath[0]);
            
            posterFlag  = 2;
            strPicPath = GetPosterPathFunction(posterMap, posterFlag, displayFlag);
            if (strPicPath == null || strPicPath.length == 0) {
                strPicPath = new String[] { "images/vod/default.jpg" } ;
            }
            jsonMap.put("HUGEPIC" , strPicPath[0]);
        }
        
        ArrayList pathList = new ArrayList();
        String tmpStrTypeId = strTypeId;
    
        String filePath = "";
        while (true) {
            HashMap parentInfo = metaData.getTypeInfoByTypeId(tmpStrTypeId);
    
            if (parentInfo != null) {
                if (parentInfo.get("PARENTID") != null) {
                    tmpStrTypeId = parentInfo.get("PARENTID").toString();
                    if (parentInfo.get("TYPENAME").toString().equals("Subject Tree")) {
                        break;
                    } else {
                        pathList.add(parentInfo.get("TYPENAME").toString());
                    }
                } else {
                    pathList.add("");
                    break;
                }
            } else {
                pathList.add("");
                break;
            }
        }
    
        if (pathList.size() != 0) {
            int pathSize = pathList.size();
            filePath += pathList.get(pathSize - 1).toString().equals("VOD") ? "点播" : pathList.get(pathSize - 1).toString();
            for (int i = pathSize - 2; i >= 0; i--) {
                filePath += "-" + pathList.get(i).toString();
            }
        }
    
        ArrayList idList = null == filmInfoMap ? (new ArrayList()) : (ArrayList) filmInfoMap.get("SUBVODIDLIST");
        ArrayList nameList = null == filmInfoMap ? (new ArrayList()) : (ArrayList) filmInfoMap.get("SUBVODNUMLIST");
    
        int intContentType = 0;
        if (filmInfoMap != null) {
            intContentType = ((Integer) filmInfoMap.get("CONTENTTYPE")).intValue();
        }
        
        jsonMap.put("PROGID" , strFilmId);
        jsonMap.put("PROGTYPE" , String.valueOf(intContentType));
    
        String vodName = "";
        if (filmInfoMap.get("VODNAME") != null) {
            vodName = filmInfoMap.get("VODNAME").toString();
        }
        jsonMap.put("VODNAME" , vodName);
    
        String[] actor = null;
        ArrayList actorList = new ArrayList();
        if (filmInfoMap.get("ACTOR") != null) {
            actor = filmInfoMap.get("ACTOR").toString().split(";");
            for(int i = 0; i < actor.length ; i++)
                actorList.add(actor[i]);
        }
        
        jsonMap.put("ACTOR" , actorList);
    
        ArrayList directList = new ArrayList();
        String[] director = null;
        if (filmInfoMap.get("DIRECTOR") != null) {
            director = filmInfoMap.get("DIRECTOR").toString().split(";");
            for(int i = 0; i < director.length ; i++)
                directList.add(director[i]);
        }
        jsonMap.put("DIRECTOR" , directList);
                
        String introduce = filmInfoMap.get("INTRODUCE") == null ? "该影片暂无简介" : (String) filmInfoMap.get("INTRODUCE");
        introduce.replaceAll("\"", "\\\"");
        jsonMap.put("INTRODUCE" , introduce);
        
        String date = "";
        if (Integer.parseInt(filmInfoMap.get("RELFLAG").toString()) == 3) {
            String year = filmInfoMap.get("ENDTIME").toString().substring(0, 4);
            String month = filmInfoMap.get("ENDTIME").toString().substring(4, 6);
            String day = filmInfoMap.get("ENDTIME").toString().substring(6, 8);
            date = year + "年" + month + "月" + day + "日下线";
        }
        jsonMap.put("OFFLINE" , date);
    
        //此处从后台取来的数据单位为“分钟”
        String elapsetime = String.valueOf(filmInfoMap.get("ELAPSETIME"));
        String vodPrice = (String) (filmInfoMap.get("VODPRICE") == null ? "0" : filmInfoMap.get("VODPRICE"));
        String searchCode = (String) filmInfoMap.get("SEARCHCODE");  //影片搜索代码，由操作员指定，用户可以通过该代码查询影片
    
        if (elapsetime == null) {
            elapsetime = "";
        } else if ((elapsetime.trim().length() == 0) || elapsetime.trim().equals("0")) {
            elapsetime = "";
        } else if (elapsetime.length() > 8) {
            elapsetime = EPGUtil.swapHtmlStr(elapsetime, 5, 1);
        }
        jsonMap.put("ELAPSETIME" , elapsetime);
        elapsetime = elapsetime + " 分钟";
    
        vodPrice = (vodPrice == null) ? "" : EPGUtil.swapHtmlStr(vodPrice, 8, 1);
        searchCode = (searchCode == null) ? "" : EPGUtil.swapHtmlStr(searchCode, 25, 1);
        int assessId = ((Integer) filmInfoMap.get("ASSESSID")).intValue(); // 片花ID
        int hasAssess = ((Integer) filmInfoMap.get("ISASSESS")).intValue();
    
        String playAssessHref = "";
        String playAssessHrefImg = "";
        if (hasAssess == 1) {
       
            playAssessHref = "HD_playFilm.jsp?CONTENTTYPE=" + intContentType
                    + "&PLAYTYPE=" + EPGConstants.PLAYTYPE_ASSESS
                    + "&PROGID=" + assessId + "&FATHERPROGID=" + strFilmId + "&BUSINESSTYPE=" + EPGConstants.BUSINESSTYPE_VOD; 
               
            playAssessHrefImg = "images/playfilm/link-playassess.gif";
        }
        // 是否连续剧及播放图片链接赋值
    
        String playHref = "";
        String playHrefImg = "";
        int isSitCom = ((Integer) filmInfoMap.get("ISSITCOM")).intValue();
        // 是连续剧父集
        if (isSitCom == EPGConstants.VOD_ISSITCOM_YESFATHER) {                            
            ArrayList sitcomList = metaData.getSitcomList(strFilmId , 1000, 0);
            HashMap countMap = (HashMap) sitcomList.get(0);
            int sitcomCountTotal = ((Integer) countMap.get(EPGConstants.KEY_COUNT)).intValue();
            elapsetime = "共" + sitcomCountTotal + "集";
            jsonMap.put("ISSITCOM" , "1");
            jsonMap.put("SITCOMNUM" , String.valueOf(sitcomCountTotal));
            //------------------------------------------------------------------
            ArrayList childList = (ArrayList)sitcomList.get(1);
            ArrayList ids = new ArrayList();
            ArrayList num = new ArrayList();
            for ( int i = 0; i < sitcomCountTotal; i++ )
            {
                HashMap sitcomMap = (HashMap)childList.get(i);
                ids.add(String.valueOf((Integer)sitcomMap.get("VODID")));
                num.add(String.valueOf((Integer)sitcomMap.get("SITCOMNUM")));
            }
            jsonMap.put("CHILDID" , ids);
            jsonMap.put("CHILDNUM" , num);           
                
            //playHref = "HD_playSeries.jsp?PROGID=" + strFilmId + "&TYPE_ID=" + strTypeId + "&CHILDNUM=";
            //前台会拼接PROGNUM，就是集号
            playHref = "HD_Authorization.jsp?CONTENTTYPE=0&BUSINESSTYPE=1&FATHERID="+strFilmId+"&PROGTYPE=null&PROGRAM_ORDER=null&TYPE_ID="+strTypeId+"&PLAYTYPE=1&ISTVSERIESFLAG=1&PROGNUM=";
         // System.out.println("playHref father:::::::::::"+playHref);
           
        } else {
        	  jsonMap.put("ISSITCOM" , "0");
        //  playHref = "HD_playFilm.jsp?CONTENTTYPE=" + intContentType + "&PLAYTYPE=" + EPGConstants.PLAYTYPE_VOD + "&PROGID=" + strFilmId + "&BUSINESSTYPE=" + EPGConstants.BUSINESSTYPE_VOD + "&TYPE_ID=" + strTypeId;
          playHref = "HD_Authorization.jsp?CONTENTTYPE=0&BUSINESSTYPE=1&PROGID="+strFilmId+"&PROGTYPE=null&PROGRAM_ORDER=null&TYPE_ID="+strTypeId+"&PLAYTYPE=1";
        //  System.out.println("playHref son:: :::::::::"+playHref);
        }
        
       // System.out.println(":::::::::::::::::::::::::::::::::::::::::::PLAYURL:: :::::::::"+playHref);
        jsonMap.put("PLAYURL" , playHref);
    
        // 判断用户是否收藏，显示对应链接
        String favoriteHref = "";
        int isFavo = 0;
    
        if (serviceHelp.isFavorited(Integer.parseInt(strFilmId) , intContentType)) isFavo = 1;
        jsonMap.put("ISFAVO" , String.valueOf(isFavo));
    
        //获取用户书签信息
        UserBookmark userBookmark = new UserBookmark(request);
        ArrayList tempBookMarkList = userBookmark.getBookmarkList();
    	
    	 int bookMarkCount =0;
    	
    	 if (null != tempBookMarkList && tempBookMarkList.size() >= 2 )
    	  {
        //书签总数
         bookMarkCount = ((Integer) ((HashMap) (tempBookMarkList.get(0))).get("COUNTTOTAL")).intValue();
       
    	  }
    	  
    	 // System.out.println("tempBookMarkList:::::::::::::::::::::"+tempBookMarkList);
    
    
        ArrayList bookMarkList = null;    
        String tempBookMarkId = "";
        String bookMarkBeginTime = "";
        int hasBookMark = 0;
        String bookMarkHref = "";
        
        ArrayList childBookmarkInfo = new ArrayList(); 
  
        if (null != tempBookMarkList && tempBookMarkList.size() >= 2 && bookMarkCount > 0) {
       
    
            bookMarkList = (ArrayList) tempBookMarkList.get(1);

           // System.out.println("bookMarkList::::::::::::::"+bookMarkList);
            
            for (int i = 0; i < bookMarkCount; i++) {
                tempBookMarkId = (String) ((HashMap) bookMarkList.get(i)).get("PROG_ID");
    
                if (isSitCom != EPGConstants.VOD_ISSITCOM_YESFATHER && tempBookMarkId.equals(strFilmId)) {
                    bookMarkBeginTime = (String) ((HashMap) bookMarkList.get(i)).get("BEGINTIME");
    
                   
    
                  /*  bookMarkHref = "HD_playFilm.jsp?CONTENTTYPE=0&PLAYTYPE=" + EPGConstants.PLAYTYPE_BOOKMARK + "&PROGID="
                            + strFilmId + "&BUSINESSTYPE=" + EPGConstants.BUSINESSTYPE_VOD + "&BOOKMARKTIME=" + bookMarkBeginTime
                            + "&TYPE_ID=" + strTypeId; */
                    
                     bookMarkHref = "HD_Authorization.jsp?CONTENTTYPE=0&PLAYTYPE=" + EPGConstants.PLAYTYPE_BOOKMARK + "&PROGID="
                            + strFilmId + "&BUSINESSTYPE=" + EPGConstants.BUSINESSTYPE_VOD + "&BOOKMARKTIME=" + bookMarkBeginTime
                            + "&TYPE_ID=" + strTypeId;
                              
                //表示该vod有书签
               hasBookMark = 1;      
                    break;
                } else if (isSitCom == EPGConstants.VOD_ISSITCOM_YESFATHER) {
    
                    try {
                        metaData.getTVSeriesEpisMap(Integer.parseInt(strFilmId));
                    } catch (Exception e) {
                    }
    
                    //获取书签
                    int bookFlag = 0;
                    String bookPlayUrl = "null";
                    //对已经存在的书签进行检索
    
                    ProgramBookInfo sitcomBookInfo = null;
                    String subFilmId = null;
                    //HashMap bookmarkMap = (HashMap) session.getAttribute("BOOKMARKMAP");
                     HashMap bookmarkMap = (HashMap) bookMarkList.get(i);

                    HashMap subIdMap = (HashMap) session.getAttribute("TVSERIESEPISMAP");  //此功能依赖于上面的getTVSeriesEpisMap
                    
                     // System.out.println("bookmarkMap::::::::::"+bookmarkMap+":::::::::subIdMap::::::::"+subIdMap);
                    
                    if (null != bookmarkMap && null != subIdMap) {
                      String tempid = (String) bookmarkMap.get("PROG_ID");
                   
                        Iterator iter = subIdMap.keySet().iterator();
                        while (iter.hasNext()) {
                            subFilmId = String.valueOf(iter.next());
                            // 如果该子集设置了书签,则停止循环
                         //System.out.println("subFilmId::::::::::::::::::::::::::::::::::::::::::"+subFilmId);
                        // System.out.println("tempid::::::::::::::::::::::::::::::::::::::::::"+tempid);
                            if (tempid.equals(subFilmId)) {
                            //书签的开始时间
                              String tempBeginTime = (String) bookmarkMap.get("BEGINTIME");
                                // 如果存在书签,需要查出子集集号, 
                                 hasBookMark = 1;
                                   ArrayList childBookmarkInfoTmp = new ArrayList(); //childBookmarkInfoTmp结构：{//子集ID，//父集id,子集集号，//开始时间，书签url}
                                 Map subFilmMap = metaData.getVodDetailInfo(Integer.parseInt(subFilmId));                                
                        if (null != subFilmMap) {
                        
                         // childBookmarkInfoTmp.add(subFilmId); 
                          
                            int fatherId = ((Integer) subFilmMap.get("FATHERVODID")).intValue(); 
                            // childBookmarkInfoTmp.add(String.valueOf(fatherId));
                             
                            Map fatherFilmMap = metaData.getVodDetailInfo(fatherId);
    
                            ArrayList vodIDList = (ArrayList) fatherFilmMap.get("SUBVODIDLIST");
                            ArrayList vodNUMList = (ArrayList) fatherFilmMap.get("SUBVODNUMLIST");
    
                            int index = vodIDList.indexOf(new Integer(subFilmId));
    
                            bookFlag = ((Integer) vodNUMList.get(index)).intValue();
                            //子集集号
                            childBookmarkInfoTmp.add(String.valueOf(bookFlag));
                           // System.out.println("bookFlag:::::0824::::::::::::::::::::::::::::::::::"+bookFlag);
                           
                            Integer contentType = (Integer) subFilmMap.get("CONTENTTYPE");
                           
                           String   bookMarkHrefTmp = "HD_Authorization.jsp?PROGID=" + subFilmId + "&PROGTYPE=" + EPGConstants.VOD_ISSITCOM_YESSUBFILM
                                + "&PLAYTYPE=" + EPGConstants.PLAYTYPE_BOOKMARK + "&CONTENTTYPE=" + contentType
                                + "&BUSINESSTYPE=" + EPGConstants.BUSINESSTYPE_VOD + "&BOOKMARKTIME=" + tempBeginTime + "&FATHERID=" + fatherId + "&TYPE_ID=" + strTypeId; 
                                 
                            // childBookmarkInfoTmp.add(tempBeginTime); 
                             //子集url 
                             childBookmarkInfoTmp.add(bookMarkHrefTmp);  
                            // bookMarkHref = bookMarkHrefTmp; 
                               
                        } 
                             childBookmarkInfo.add(childBookmarkInfoTmp);                  
                                break;
                            }
                            
                        }
                    }
                    //System.out.println("childBookmarkInfo:::::0824::::::::::::::::::::::::::::::::::"+childBookmarkInfo);
                   
   /*    
                    // 如果存在书签,需要查出子集集号,这里与bookFlag共用
                    if (null != sitcomBookInfo) {
                        hasBookMark = 1;

                        Map subFilmMap = metaData.getVodDetailInfo(Integer.parseInt(subFilmId));
                        if (null != subFilmMap) {
                            int fatherId = ((Integer) subFilmMap.get("FATHERVODID")).intValue();
                            Map fatherFilmMap = metaData.getVodDetailInfo(fatherId);
    
                            ArrayList vodIDList = (ArrayList) fatherFilmMap.get("SUBVODIDLIST");
                            ArrayList vodNUMList = (ArrayList) fatherFilmMap.get("SUBVODNUMLIST");
    
                            int index = vodIDList.indexOf(new Integer(subFilmId));
    
                            bookFlag = ((Integer) vodNUMList.get(index)).intValue();
//                            System.out.println("bookFlag:::::0824::::::::::::::::::::::::::::::::::"+bookFlag);
                        }
    
                        Integer contentType = (Integer) subFilmMap.get("CONTENTTYPE");
                        /*
                        bookMarkHref = "HD_playFilm.jsp?PROGID=" + sitcomBookInfo.getProgId() + "&PROGTYPE=" + EPGConstants.VOD_ISSITCOM_YESSUBFILM
                                + "&PLAYTYPE=" + EPGConstants.PLAYTYPE_BOOKMARK + "&CONTENTTYPE=" + contentType
                                + "&BUSINESSTYPE=" + EPGConstants.BUSINESSTYPE_VOD + "&BOOKMARKTIME=" + sitcomBookInfo.getBeginTime() + "&SUPVODID=" + strFilmId + "&TYPE_ID=" + strTypeId;
                               
                                
                       bookMarkHref = "HD_Authorization.jsp?PROGID=" + sitcomBookInfo.getProgId() + "&PROGTYPE=" + EPGConstants.VOD_ISSITCOM_YESSUBFILM
                                + "&PLAYTYPE=" + EPGConstants.PLAYTYPE_BOOKMARK + "&CONTENTTYPE=" + contentType
                                + "&BUSINESSTYPE=" + EPGConstants.BUSINESSTYPE_VOD + "&BOOKMARKTIME=" + sitcomBookInfo.getBeginTime() + "&SUPVODID=" + strFilmId + "&TYPE_ID=" + strTypeId;  
                                
                    }
                      */
                }
            }
        }
        //-----------------------------------------------------------------------------------------
        Object genre = filmInfoMap.get("GENRE");
        if(null != genre) {
            String[] strGenre = (String[])genre;
            jsonMap.put("FILMTYPE" , strGenre[0]);
        }
        
        jsonMap.put("INFORMATION" , elapsetime);
        jsonMap.put("HASBOOKMARK" , String.valueOf(hasBookMark));
       jsonMap.put("BOOKMARKURL" , bookMarkHref);
       jsonMap.put("BOOKMARKINFO" , childBookmarkInfo);
        return jsonMap;    
    }
    
    public String getTriggerUrl(ServiceHelp serviceHelp, int vodId) {
        String playUrl = serviceHelp.getTriggerPlayUrl(1, vodId, "0");
        int st=playUrl.indexOf("rtsp");
        return st != -1 ? playUrl.substring(st,playUrl.length()) : "";
    }
    
    
%>