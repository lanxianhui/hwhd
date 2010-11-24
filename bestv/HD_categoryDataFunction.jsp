<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.bestv.epg.util.MessageUtil" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="java.util.*" %>
<%@ include file="HD_kanBarFunction.jsp" %>
<%!
    public static int DATANUMBER = 7;
    public static int VODSNUMBER = 18;
    
    public ArrayList getSecondLayoutList(HttpServletRequest request , int index , String info) {
        if("addition".equals(info)) return getDataFromAddition(request , index);
        else if("channel".equals(info))  return getDataFromChannel(request);
        else if("catchup".equals(info))  return getDataFromCatchupChannel(request);
        else if("vasdata".equals(info))  return readKanbaDataFromVAS(request);
        else if("vodroot".equals(info))  return getDataFromVodroot(request);
        else return new ArrayList();        
    }
    
    public ArrayList getDataFromAddition(HttpServletRequest request , int index) {
        int tag = index + 1;
        ArrayList result = new ArrayList();
        for(int i = 0;i < DATANUMBER; i++)
        {
            String strtmp = "portal_headline_"+ tag + "_" + (i+1);
  	        String headline=MessageUtil.getMessage(request.getSession(), strtmp);
  	        if(headline == null) break;
  	        String headlineUrl=MessageUtil.getMessage(request.getSession(), strtmp + "_url");
            HashMap hm = new HashMap();
  	        hm.put("NAME" , headline);
  	        hm.put("TURNURL"  , headlineUrl);
  	        result.add(hm);
  	    }
  	    return result;
    }
    
    public void sortChanList(List channelList) {
        Collections.sort(channelList, new Comparator() {
            public int compare(Object o1, Object o2) {
                return ((Integer) ((Map) o1).get("CHANNELINDEX")).intValue() -
                        ((Integer) ((Map) o2).get("CHANNELINDEX")).intValue();
            }
        });
    }
    
    public String addZeroIfNecessary(Integer channelIndex) {
        String index = String.valueOf(channelIndex.intValue());
        while (index.length() < 3) {
            index = "0" + index;
        }
        return index;
    }
    
    public ArrayList getDataFromChannel(HttpServletRequest request) {
        ArrayList result = new ArrayList();
        String categoryId =  MessageUtil.getMessage(request.getSession(), "portal_recommand_channel");
        if(categoryId == null) return result;
        
        MetaData metaData = new MetaData(request);
        List channelResultList = null;
        try {
            channelResultList = metaData.getChanListByTypeIdSH(categoryId, 7, 0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (channelResultList == null || channelResultList.size() != 2 || ((ArrayList) channelResultList.get(1)).size() == 0) {

        } else {
            List channelList = (List) channelResultList.get(1);
    
            int channelCount = channelList.size();
            sortChanList(channelList);
            
            HashMap hm = new HashMap();
            hm.put("NAME" , "全部电视台");
            hm.put("TURNURL"  , "HD_channelPortal.jsp");
            result.add(hm);
            
            for (Iterator iterator = channelList.iterator(); iterator.hasNext();) {
                Map channel = (Map) iterator.next();
                hm = new HashMap();
  	            hm.put("NAME" , WordUtil.subWord(((String) channel.get("CHANNELNAME")).trim(), 18, "utf-8"));
  	            hm.put("TURNURL"  , "HD_channelPortal.jsp?CHANNELID=" + channel.get("CHANNELID") + "&CHANNELINDEX=" + addZeroIfNecessary((Integer) channel.get("CHANNELINDEX")));
                result.add(hm);
            }
        }
        return result;
    }
    
     public ArrayList getDataFromCatchupChannel(HttpServletRequest request) {
        ArrayList result = new ArrayList();
        String categoryId =  MessageUtil.getMessage(request.getSession(), "portal_recommand_channel");
        if(categoryId == null) return result;
        
        MetaData metaData = new MetaData(request);
        List channelResultList = null;
        try {
            channelResultList = metaData.getChanListByTypeIdSH(categoryId, 7, 0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (channelResultList == null || channelResultList.size() != 2 || ((ArrayList) channelResultList.get(1)).size() == 0) {

        } else {
            List channelList = (List) channelResultList.get(1);
    
            int channelCount = channelList.size();
            sortChanList(channelList);
            
            HashMap hm = new HashMap();
            hm.put("NAME" , "全部电视台");
            hm.put("TURNURL"  , "HD_catchupPortal.jsp");
            result.add(hm);
            
            for (Iterator iterator = channelList.iterator(); iterator.hasNext();) {
                Map channel = (Map) iterator.next();
                hm = new HashMap();
  	            hm.put("NAME" , WordUtil.subWord(((String) channel.get("CHANNELNAME")).trim(), 18, "utf-8"));
  	            hm.put("TURNURL"  , "HD_catchupPortal.jsp?CHANNELID=" + channel.get("CHANNELID") + "&CHANNELINDEX=" + addZeroIfNecessary((Integer) channel.get("CHANNELINDEX")));
                result.add(hm);
            }
        }
        return result;
    }
    
    public ArrayList getDataFromVodroot(HttpServletRequest request) {
        ArrayList result = new ArrayList();
        for(int i = 0;i < VODSNUMBER; i++)
        {
            String strtmp = "vod_category_"+ (i+1);
  	        String value  = MessageUtil.getMessage(request.getSession(), strtmp);
  	        if(value == null) break;
  	        String[] strs = value.split("_");
  	        if(strs.length >= 2) {
                HashMap hm = new HashMap();
  	            hm.put("NAME" , strs[0]);
  	            hm.put("TURNURL"  , "HD_vod.jsp?TYPE_ID=00000100000000090000000000001048&CHILD_ID=" + strs[1]);
  	            result.add(hm);
  	        }
  	    }
  	    return result;
    }
    
    public ArrayList getDataFromBottom(HttpServletRequest request) {
        ArrayList result = new ArrayList();
        for(int i = 0;i < 7; i++)
        {
            String strtmp = "portal_bottom_" + (i+1);
  	        String headline=MessageUtil.getMessage(request.getSession(), strtmp);
  	        if(headline == null) break;
  	        String headlineUrl=MessageUtil.getMessage(request.getSession(), strtmp + "_url");
            HashMap hm = new HashMap();
  	        hm.put("NAME" , headline);
  	        hm.put("TURNURL"  , headlineUrl);
  	        result.add(hm);
  	    }
  	    return result;
    }
%>
