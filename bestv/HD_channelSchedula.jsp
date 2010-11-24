<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.bestv.epg.util.WordUtil" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="HD_substringUtil.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" buffer="16kb" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
   String channelId = request.getParameter("CHANNELID");
   MetaData metaData = new MetaData(request);
   ServiceHelp serviceHelp = new ServiceHelp(request);
   //Fetch channel info
   Map channelInfo = metaData.getChannelInfoSH(channelId);
 
  int recordSeconds = ((Integer) channelInfo.get("RECORDLENGTH")).intValue();
  int recordDays = serviceHelp.getRecdayFromSec(recordSeconds);
  Date today = new Date();
  DateFormat format = new SimpleDateFormat("M月d日 EEE");

  Calendar cal = Calendar.getInstance();
  cal.setTime(today);

  //当前时间HH:mm格式
  DateFormat timeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
  String timeStr = timeFormat.format(today);
  timeFormat = new SimpleDateFormat("yyyyMMdd");
  String timeparam = timeFormat.format(today);
  
  //System.out.println("NOW:" + timeStr);
  
  String[] progBill = new String[0];
  String[] recBill = new String[0];

  try {
      progBill = metaData.getProgBill(Integer.parseInt(channelId) , timeparam);
      recBill = metaData.getRecBill(Integer.parseInt(channelId) , timeparam);
      if (progBill == null) progBill = new String[0];
      if (recBill == null) recBill = new String[0];
		
		  //System.out.println("progBill.length::"+progBill.length+"recBill.lengt::"+recBill.length);
		  
  } catch (Exception e) {
        e.printStackTrace();
  }
  
  String[] result = new String[9];  
  String[] progBillArr = new String[progBill.length + recBill.length];
  System.arraycopy(recBill, 0, progBillArr, 0, recBill.length);
  System.arraycopy(progBill, 0, progBillArr, recBill.length, progBill.length);

  int i = 0 ;
  boolean hit = false;
  for (i = 0; i < progBillArr.length; i++) {
      //System.out.println(progBillArr[i]);  
		  String[] progInfoTem = progBillArr[i].split("\u007f");
		  //System.out.print("NO" + i + "\t");
		  //for(int h = 0; h < progInfoTem.length ; h ++ )
		      //System.out.print(progInfoTem[h]+"\t");
		  //System.out.println();
  }
  for (i = 0; i < progBillArr.length; i++) {  
		  String[] progInfoTem = progBillArr[i].split("\u007f");
		  String SproInfo = progInfoTem[0] + " " + progInfoTem[1];
		  String EproInfo = progInfoTem[0] + " " + progInfoTem[3];
		  if((timeStr.compareTo(SproInfo) >=0 && timeStr.compareTo(EproInfo) <= 0)) { hit = true ;break; }
		  if(timeStr.compareTo(SproInfo) < 0) break;
  }
  int start = -1, end = -1;
  //System.out.println(hit + "==========" + i);
  if(i != progBillArr.length) {
      start = i - 4 > 0 ? i - 4 : 0;
      end  = i + 4 < progBillArr.length ? i + 4 : progBillArr.length - 1;
      int pos = hit ?  4 : 3;
      for(int k = i ; k >= start ; k--, pos--) 
          result[pos] =  progBillArr[k];
      pos = 5;
      for(int k = i + 1 ; k <= end ; k++ , pos++) 
          result[pos] =  progBillArr[k];
  }else {
      start = i - 4 > 0 ? i - 4 : 0;
      int pos = 3;
      for(int k = i - 1 ; k >= start ; k--, pos--) 
          result[pos] =  progBillArr[k];
	}
	for(i = 0 ; i < result.length; i++ ) {
	    if(result[i] == null) result[i] ="";
	    else {
		      String[] progInfoTem = result[i].split("\u007f");
		      result[i] = progInfoTem[1].substring(0 , progInfoTem[1].length() - 3) + " " + progInfoTem[2];
	    }
	    
	    result[i] = WordUtil.subWord(result[i] , 160 , "16px", (Map) application.getAttribute("SUB_STRING_MAP"));
	}
	JSONArray  jsonObject = JSONArray.fromObject(result); 
  //System.out.println(jsonObject.toString());  						
	out.print(jsonObject.toString());
%>
