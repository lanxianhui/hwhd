<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.bestv.epg.util.MessageUtil" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.bestv.epg.util.WordUtil" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" buffer="16kb" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    int MAXDAYCATCHUP = 7;

    String channelId = request.getParameter("CHANNELID");

  //System.out.println("test:::::::::::::::::"+channelId);
	
    MetaData metaData = new MetaData(request);
    ServiceHelp serviceHelp = new ServiceHelp(request);
    Map channelInfo = metaData.getChannelInfoSH(channelId);
int recordSeconds = 0;

   if(null != channelInfo)  
   {
  recordSeconds = ((Integer) channelInfo.get("RECORDLENGTH")).intValue();
  }
    
    int recordDays = serviceHelp.getRecdayFromSec(recordSeconds);
    
    Date today = new Date();
    String[] dateStr = new String[MAXDAYCATCHUP];
    String[] timeStr = new String[MAXDAYCATCHUP];
    DateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
    DateFormat timeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            
    for(int i = -3 ; i < 4 ; i ++) {
        Calendar calendar=Calendar.getInstance();   
        calendar.setTime(new Date());
        calendar.set(Calendar.DAY_OF_MONTH , calendar.get(Calendar.DAY_OF_MONTH) + i);
        Date tmpDate = calendar.getTime();
        dateStr[i + 3] = dateformat.format(tmpDate);
        timeStr[i + 3] = timeFormat.format(tmpDate);
        //System.out.println(timeStr[i + 3]);
    }
    
    String[] progBill = new String[0];
    String[] recBill = new String[0];

    try {
        progBill = metaData.getProgBill(Integer.parseInt(channelId));
        recBill = metaData.getRecBill(Integer.parseInt(channelId));
        if (progBill == null) progBill = new String[0];
        if (recBill == null) recBill = new String[0];
		//System.out.println("progBill.length::"+progBill.length+"recBill.lengt::"+recBill.length);
    } catch (Exception e) {
        e.printStackTrace();
    }
    
    String[] progBillArr = new String[progBill.length + recBill.length];
    System.arraycopy(recBill, 0, progBillArr, 0, recBill.length);
    System.arraycopy(progBill, 0, progBillArr, recBill.length, progBill.length);
    		    for(int i = 0; i < progBillArr.length ; i++ ) {
    		        String[] progInfoTem = progBillArr[i].split("\u007f");
    		        //for(int j = 0; j < progInfoTem.length ; j++)
    		          //  System.out.print(progInfoTem[j] + "\t");
//    		        System.out.println();
    		    }
    		    

    
    String label = "" , prog_label = "";
    ArrayList jsonAl = new ArrayList();
    String[] progInfoTem = null;
    int position = 0;
    
    for(int i = 0 ; i < MAXDAYCATCHUP ; i ++ ) {
        HashMap entry = new HashMap();
        if(i == 3) label = "now";
		    else if(i < 3) label = "ago";
		    else label = "after";
		    entry.put("day"   , dateStr[i].substring(5,7) + "月" + dateStr[i].substring(8,10) + "日");
		  	entry.put("state" , label);
		  	
		  	String currentTime =  dateStr[i];
		  	ArrayList info = new ArrayList();
        if(position < progBillArr.length) {
            progInfoTem = progBillArr[position].split("\u007f");
            while(currentTime.equals(progInfoTem[0])) {
                HashMap singleInfo = new HashMap();
                String SproInfo = progInfoTem[0] + " " + progInfoTem[1];
		            String EproInfo = progInfoTem[0] + " " + progInfoTem[3];
                if((timeStr[i].compareTo(SproInfo) >=0 && timeStr[i].compareTo(EproInfo) <= 0)) { 
		                prog_label = "now"; 
		            }else {
		      	        prog_label = "1".equals(progInfoTem[8]) ? "ago" : "after";
		            }
		            singleInfo.put("nowState"  , prog_label);
		            singleInfo.put("startTime" , progInfoTem[1].substring(0, progInfoTem[1].length()- 3));
		            singleInfo.put("endTime"   , progInfoTem[3].substring(0, progInfoTem[1].length()- 3));
		            singleInfo.put("name"      , progInfoTem[2]);
		            
		            String playUrl = "HD_playTvodControl.jsp?";
		            playUrl = playUrl + "CHANNELID=" + channelId;
		            playUrl = playUrl + "&PROGID=" + progInfoTem[4];
		            playUrl = playUrl + "&PLAYTYPE=4&CONTENTTYPE=300&BUSINESSTYPE=5";
		            playUrl = playUrl + "&PROGSTARTTIME=" + progInfoTem[0].replaceAll("-" , "") + progInfoTem[1].replaceAll(":" , "");
		            playUrl = playUrl + "&PROGENDTIME="  + progInfoTem[0].replaceAll("-" , "") + progInfoTem[3].replaceAll(":" , "");
  	            singleInfo.put("turnUrl"   , playUrl);
		            
		            info.add(singleInfo);
		            position ++;
		            if(position >= progBillArr.length) break;
		            progInfoTem = progBillArr[position].split("\u007f");
		            SproInfo = progInfoTem[0] + " " + progInfoTem[1];
		            EproInfo = progInfoTem[0] + " " + progInfoTem[3];
          }
        }
        entry.put("info" , info);
        jsonAl.add(entry);
    }
    JSONArray jsonObject = JSONArray.fromObject(jsonAl); 
//    System.out.println("HD_channelProgInfo.jsp::::::"+jsonObject.toString());  						
	  out.write(jsonObject.toString());
%>