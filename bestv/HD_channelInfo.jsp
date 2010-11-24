<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil" %>
<%@ page import="com.bestv.epg.util.WordUtil" %>
<%@ page import="com.bestv.epg.util.MessageUtil" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%!
    private static final int CHANNEL_PER_PAGE = 27;

    private void sortChanList(List channelList) {
        Collections.sort(channelList, new Comparator() {
            public int compare(Object o1, Object o2) {
                return ((Integer) ((Map) o1).get("CHANNELINDEX")).intValue() -
                        ((Integer) ((Map) o2).get("CHANNELINDEX")).intValue();
            }
        });
    }

    private String addZeroIfNecessary(Integer channelIndex) {
        String index = String.valueOf(channelIndex.intValue());
        while (index.length() < 3) {
            index = "0" + index;
        }
        return index;
    }
%>
<%
    //long tomes = System.currentTimeMillis();  
    String categoryId = request.getParameter("TYPE_ID");
    MetaData metaData = new MetaData(request);
    List channelResultList = null;
    try {
        channelResultList = metaData.getChanListByTypeIdSH(categoryId, 1000, 0);
        //tomes = System.currentTimeMillis();
       // System.out.println("END getChanListByTypeIdSH::::::::::" + channelResultList+"::::::::::::::::::"+categoryId);  
    } catch (Exception e) {
        e.printStackTrace();
    }
    if (channelResultList == null || channelResultList.size() != 2 || ((ArrayList) channelResultList.get(1)).size() == 0) {
%>
<script>
    window.location.href = "InfoDisplay.jsp?ERROR_ID=25&ERROR_TYPE=2";
</script>
<%
   } else {
        List channelList = (List) channelResultList.get(1);
    
        int channelCount = channelList.size();
        sortChanList(channelList);
    
        int pageNumber = (channelCount % CHANNEL_PER_PAGE == 0) ?
                channelCount / CHANNEL_PER_PAGE : (channelCount / CHANNEL_PER_PAGE + 1);
                
        ArrayList normal = new ArrayList();
        ArrayList hdchan = new ArrayList();
        
        for (Iterator iterator = channelList.iterator(); iterator.hasNext();) {

            HashMap chans = new HashMap();
            Map channel = (Map) iterator.next();
            int definition = ((Integer) channel.get("DEFINITION")).intValue();
            int channelId = ((Integer) channel.get("CHANNELID")).intValue();
            //回看标识
            int hasRecProg = ((Integer) channel.get("HASRECPROG")).intValue();            
            //用户是否订购该回看
            try {
                if ((metaData.getRecBillByUserOrderedProduct(channelId) == null
                        || metaData.getRecBillByUserOrderedProduct(channelId).length == 0)) {
                    hasRecProg = 0;
                }
            } catch (Exception e) {
            }
            HashMap singleInfo = metaData.getChannelInfoSH(String.valueOf(channelId));
            String picUrl = "";
            if(singleInfo == null || singleInfo.get("LOGOURL") == null) picUrl = "images/livingchannel/cldefault.gif";
            else {
            	picUrl = (String)singleInfo.get("LOGOURL");
            }
            
            chans.put("InnerChannelID" , channel.get("CHANNELID"));
            chans.put("ChannelName" , WordUtil.subWord(((String) channel.get("CHANNELNAME")).trim(), 18, "utf-8"));
            chans.put("ChannelID" , addZeroIfNecessary((Integer) channel.get("CHANNELINDEX")));
            chans.put("timeShift" , channel.get("ISPLTV"));
            chans.put("isSubscribe" , channel.get("ISSUBSCRIBED"));
            chans.put("IsTvod" , channel.get("ISTVOD"));
            chans.put("hasRecProg" , hasRecProg);
            chans.put("PICS_PATH" , picUrl);
            
//            System.out.println(channel);
            
            if(definition == 2) hdchan.add(chans);
            else normal.add(chans);
           
        }
        
        ArrayList jsonArr = new ArrayList();
        jsonArr.add(hdchan);
        jsonArr.add(normal);
        
        JSONArray jsonObject = JSONArray.fromObject(jsonArr);
        //System.out.println(jsonObject.toString());  					
        out.print(jsonObject.toString());
    }
%>