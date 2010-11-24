<%@ page import="java.io.File" %>
<%@ page import="org.dom4j.io.SAXReader" %>
<%@ page import="org.dom4j.Element" %>
<%@ page import="org.dom4j.Document" %>
<%@ page import="com.bestv.epg.exception.BestvEpgException" %>
<%@ page import="org.dom4j.DocumentException" %>
<%@ page import="com.bestv.epg.common.EpgConstant" %>
<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="java.io.IOException" %>


<%!
    private String getConfigPath(HttpServletRequest request) {
          ServiceHelp serviceHelp = new ServiceHelp(request);
        Map retMap = serviceHelp.checkAndGetFirstPage("en", "cn");
        String firstPage = (String) retMap.get("FIRSTPAGE");
          //System.out.println("firstPage::"+firstPage);
         String currentTemplatePath = firstPage.substring(0, firstPage.lastIndexOf("/"));
         return "jsp/" + currentTemplatePath;
//        return "jsp/hwhd/en";

    }

    private void storeConfigPath(HttpServletRequest request, String configPath) {
        HttpSession session = request.getSession();
        session.setAttribute(EpgConstant.EPG_EMS_CONFIG, configPath);

        ServletContext context = session.getServletContext();
        String propKey = EpgConstant.EPG_EMS_CONFIG + "_" + configPath;
        context.removeAttribute(propKey);
        try {
            Properties prop = new Properties();
            prop.load(context.getResourceAsStream("/" + configPath + "/config/epg-config.properties"));
            context.setAttribute(propKey, prop);
        } catch (IOException e) {
//            System.out.println(e);
        }
    }

    private void parseGroupFile(ServletContext context, File groupFile) throws BestvEpgException {
        SAXReader reader = new SAXReader();
        try {
            Document document = reader.read(groupFile);
            Element root = document.getRootElement();
            String version = root.attributeValue("version");
            Map pkMap = new HashMap();
            for (Iterator iter = root.elementIterator("item"); iter.hasNext();) {
                Element item = (Element) iter.next();
                pkMap.put(item.getText(), item.attributeValue("param"));
            }
            context.setAttribute(EpgConstant.BESTV_EPG_VERSION, version);
            context.setAttribute(EpgConstant.BESTV_EPG_PKMAP, pkMap);
            //System.out.println("Group File loaded!");
        } catch (DocumentException e) {
            throw new BestvEpgException(e.getMessage());
        }
    }

    private void parseParamFile(ServletContext context, File paramFile) throws BestvEpgException {
        SAXReader reader = new SAXReader();
        try {
            Document document = reader.read(paramFile);
            Element root = document.getRootElement();
            Map paramMap = new HashMap();
            for (Iterator iter = root.elementIterator("group"); iter.hasNext();) {
                Element group = (Element) iter.next();
                Map itemMap = new HashMap();
                for (Iterator iIter = group.elementIterator("item"); iIter.hasNext();) {
                    Element item = (Element) iIter.next();
                    String itemKey = item.attribute("param").getValue();
                    Map map = new HashMap();
                    map.put("type", item.elementText("type"));
                    map.put("value", item.elementText("value"));
                    itemMap.put(itemKey, map);
                }
                String groupKey = group.attribute("code").getValue();
                paramMap.put(groupKey, itemMap);
            }
            context.setAttribute(EpgConstant.BESTV_EPG_PARAMMAP, paramMap);
            //System.out.println("Param File loaded!");
        } catch (DocumentException e) {
            throw new BestvEpgException(e.getMessage());
        }
    }
%>

<%
    ServletContext servletContext = session.getServletContext();
    String configPath = getConfigPath(request);
   // System.out.println("configPath:dxy:dxydxydxy:::::::::"+configPath);
    MessageUtil.parseEpgConfigFile(request, configPath);

%>
