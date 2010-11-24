<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%!
    public String transferPrice(String prodPrice) {
        String prodPriceTemp;
        if (prodPrice != null && !"".equals(prodPrice) && !"null".equals(prodPrice)) {
            //将价格从分换算到元
            try {
                int prodPricesInt = Integer.parseInt(prodPrice);
                int prodPricesBuck = prodPricesInt / 100;
                int prodPricesChiao = (prodPricesInt % 100) / 10;
                int prodPricesCent = (prodPricesInt % 100) % 10;
                //prodPriceTemp = prodPricesBuck + " 元 " + prodPricesChiao + " 角 " + prodPricesCent + " 分";
                prodPriceTemp = "" + prodPricesBuck + "." + prodPricesChiao + prodPricesCent + " 元 ";
            }
            catch (Exception e) {
                prodPriceTemp = prodPrice + "元";
            }
            prodPriceTemp = EPGUtil.swapHtmlStr(prodPriceTemp, 16, 1);
        } else {
            prodPriceTemp = "元";
        }
        return prodPriceTemp;
    }

    public String transferTime(int prodRental) {
        int tempDayInt, tempHourInt, tempMinuteInt;
        String result;
        if (prodRental >= 2 * 24 * 60) {
            tempDayInt = prodRental / 1440;
            result = tempDayInt + " 天";
        } else if (prodRental >= 60) {
            tempHourInt = prodRental / 60;
            result = tempHourInt + " 小时";
        } else {
            result = prodRental + " 分钟";
        }
        return result;
    }

%>