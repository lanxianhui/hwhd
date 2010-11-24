<%-- Created By Caiyuhong 2010-04-14--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.apache.commons.httpclient.HttpClient" %>
<%@ page import="org.apache.commons.httpclient.HttpMethod" %>
<%@ page import="org.apache.commons.httpclient.methods.GetMethod" %>
<%@ page import="org.apache.commons.httpclient.params.HttpMethodParams" %>
<%@ page import="org.apache.commons.httpclient.DefaultHttpMethodRetryHandler" %>
<%@ page import="org.apache.commons.httpclient.methods.PostMethod" %>
<%@ page import="org.apache.commons.httpclient.HttpStatus" %>
<%@ page import="com.bestv.epg.util.MessageUtil" %>
<%@ page import="org.dom4j.io.SAXReader" %>
<%@ page import="org.dom4j.Document" %>
<%@ page import="org.dom4j.Element" %>
<%@ page import="java.util.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="java.io.*" %>

<%!    
    public ArrayList readKanbaDataFromVAS(HttpServletRequest request) {
       // System.out.println(MessageUtil.getMessage(request.getSession(), "vis_kanba_url"));
       // System.out.println(MessageUtil.getMessage(request.getSession(), "vis_kanba_code"));
        if (MessageUtil.getMessage(request.getSession(), "vis_kanba_url") != null && MessageUtil.getMessage(request.getSession(), "vis_kanba_code") != null) {
            String visIp   = MessageUtil.getMessage(request.getSession(), "vis_kanba_url");
            String visCode = MessageUtil.getMessage(request.getSession(), "vis_kanba_code");
            if (visIp != null && !"".equals(visIp) && visCode != null && !"".equals(visCode)) {
                StringBuffer param = new StringBuffer();
                param.append("?categorycode=").append(visCode);
                param.append("&itemtype=").append("tvbar,url");
                param.append("&pageindex=1");
                param.append("&pagesize=").append("1000");
                param.append("&withdetail=").append("1");

                String visUrl = visIp + param.toString();
                String xmlData = getXMLFromVAS(visUrl);
                xmlData = xmlData.replace("UTF-8" , "GB2312");
              //  System.out.println("DOGCAI:::::::::::::::::::::::::" + xmlData);
                return getKanbaParameters(xmlData);
            }
        }
        return null;
    }
    
    public String getXMLFromVAS(String urlStr){
        StringBuffer ad_buffer = new StringBuffer();
        try {
            if (null == urlStr || "".equals(urlStr)){ return ""; }
            HttpClient adClient = new HttpClient();
            GetMethod method = new GetMethod(urlStr);
            method.getParams().setParameter(HttpMethodParams.RETRY_HANDLER,new DefaultHttpMethodRetryHandler(0, false));
            method.getParams().setContentCharset("UTF-8");  
            adClient.getHttpConnectionManager().getParams().setConnectionTimeout(500); 
            adClient.setTimeout(500);
            int statusCode = adClient.executeMethod(method);
            if (statusCode == HttpStatus.SC_OK){
                  InputStream in = method.getResponseBodyAsStream();      
                  BufferedReader br = new BufferedReader(new InputStreamReader(in,"UTF-8"));   
                  String tempbf;   
                  StringBuffer html = new StringBuffer(100);   
                  while ((tempbf = br.readLine()) != null) {   
                      html.append(tempbf +"\n");   
                  }
                  String finalData = html.toString();
                  finalData = new String(finalData.getBytes() , "gb2312");
                  return finalData;
            }else{
                return "";
            }
        }catch (Exception e) {
          //  e.printStackTrace();
            return "";
        }
    }
    
    public ArrayList getKanbaParameters(String data) {
        try{
            if(data != null && !"".equals(data)){
                SAXReader reader = new SAXReader();
               // System.out.println("before1------------------------------"+data);  
              // ByteArrayInputStream testStream = new ByteArrayInputStream(data.getBytes());
               // Document source = reader.read(testStream);  
                 
                  Document source = reader.read(new ByteArrayInputStream(data.getBytes())); 
                  
               // System.out.println("after------------------------------"+testStream.read());
                Element root = source.getRootElement();
                ArrayList KbList = new ArrayList();
                root = root.element("items");
                 int i =0;
                for (Iterator iter = root.elementIterator("item"); iter.hasNext();) {
                    Element adElement = (Element) iter.next();
                    HashMap map = new HashMap();
                    i++;
                    for (Iterator iters = adElement.elementIterator("property"); iters.hasNext();) {                     
                         Element sElement = (Element) iters.next();
                         String tmpstr = (String)sElement.attribute(0).getData();
                         if("itemname".equals(tmpstr))  map.put("NAME" , sElement.getData());
                        //   else if("url".equals(tmpstr))  map.put("TURNURL" , "HD_encapsulaUrl.jsp?url=" + sElement.getData());
                         else if("url".equals(tmpstr))  map.put("TURNURL" , "HD_encapsulaUrl.jsp?fromKanba=1&item="+String.valueOf(i)+"&url=" + sElement.getData());
                         else if("item_icon".equals(tmpstr))  map.put("ITEMICON" , sElement.getData());
                    }
                    KbList.add(map);
                }

            //   System.out.println(KbList);
//               System.out.println("--------------------------------------");
                return KbList;
            }
        } catch(Exception e){
           // e.printStackTrace();
        }
        return null;
    }
    
%>