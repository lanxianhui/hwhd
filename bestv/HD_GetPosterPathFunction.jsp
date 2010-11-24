<%-- Copyright (C), Huawei Tech. Co., Ltd. --%>
<!-- Author:liguoli104719 -->
<%-- CreateAt:2008-05-07 --%>
<%-- FileName:GetPosterPathFunction.jsp --%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>

<%!

    /*
    *
    * 函数说明：根据传入参数，获得特定海报
    *posterMap: POSTERPATHS 键值对应的HashMap  由调用处进行校验，非null
    * posterFlag：  获得海报类型的标志。 0：缩略图 1：海报 2：剧照  其他：以上三种之和

    *displayFlag： 显示方式： 0：获得图片中的第一张  其他：获得所有图片（优先顺序：海报，剧照，缩略图）

    *返回类型：  String类型数组,和接口中的返回类型保持一致

    */

    String[] GetPosterPathFunction(HashMap posterMap, int posterFlag, int displayFlag) {

        ArrayList posterPathList = new ArrayList();
        ;
        int posterLength0 = 0;
        int posterLength1 = 0;
        int posterLength2 = 0;
        int totalLength = 0;
        if (null == posterMap) return null;
        if (posterMap.get("0") != null) {
            String[] temp0 = (String[]) posterMap.get("0");   //缩略图


            if (temp0.length > 0) {
                for (int j = 0; j < temp0.length; j++) {
                    posterPathList.add(temp0[j]);
                }
                posterLength0 = temp0.length;
                totalLength += posterLength0;
            }//获得缩略图图片地址，加入 arraylist


        }
        if (posterMap.get("1") != null) {
            String[] temp1 = (String[]) posterMap.get("1");   //海报


            if (temp1.length > 0) {
                for (int j = 0; j < temp1.length; j++) {
                    posterPathList.add(temp1[j]);
                }
                posterLength1 = temp1.length;
                totalLength += posterLength1;
            }//获得海报图片地址，加入 arraylist

        }
        if (posterMap.get("2") != null) {
            String[] temp2 = (String[]) posterMap.get("2");   //剧照

            if (temp2.length > 0) {
                for (int j = 0; j < temp2.length; j++) {
                    posterPathList.add(temp2[j]);
                }
                posterLength2 = temp2.length;
                totalLength += posterLength2;
            } //获得剧照图片地址，加入 arraylist
        }

        if (displayFlag == 0)    //显示方式为只取一张图片地址
        {
            if (posterFlag == 0) {
                if (posterLength0 == 0)
                    return null;
                else {
                	
                    String[] returnPostre = {(String) posterPathList.get(0)};
      
                    return returnPostre;  //只取缩略图图片的第一个地址
                }

            } else if (posterFlag == 1) {
                if (posterLength1 == 0)
                    return null;
                else {
                    String[] returnPostre = {(String) posterPathList.get(posterLength0)};
                    return returnPostre; //只取海报图片的第一个地址
                }
            } else if (posterFlag == 2) {
                if (posterLength2 == 0)
                    return null;
                else {
                    String[] returnPostre = {(String) posterPathList.get(posterLength0 + posterLength1)};
                    return returnPostre; //只取剧照图的第一个片地址
                }
            } else {

                if (totalLength == 0)
                    return null;

                if (posterLength1 > 0) {
                    String[] returnPostre1 = {(String) posterPathList.get(posterLength0)};
                    return returnPostre1; //取海报图片的第一个地址
                } else {
                    if (posterLength2 > 0) {
                        String[] returnPostre2 = {(String) posterPathList.get(posterLength0 + posterLength1)};
                        return returnPostre2; //只取剧照图的第一个片
                    } else {
                        String[] returnPostre3 = {(String) posterPathList.get(0)};
                        return returnPostre3;  //只取缩略图图片的第一个地址

                    }
                }

                //return null;

            }

        } else     // 取所有图片地址
        {
            if (posterFlag == 0) {
                if (posterLength0 == 0)
                    return null;
                else {
                    String[] returnPostre = new String[posterLength0];
                    for (int j = 0; j < posterLength0; j++) {
                        returnPostre[j] = (String) posterPathList.get(j);
                    }
                    return returnPostre;  //取得所有缩略图图片的地址
                }

            } else if (posterFlag == 1) {
                if (posterLength1 == 0)
                    return null;
                else {
                    String[] returnPostre = new String[posterLength1];
                    for (int j = 0; j < posterLength1; j++) {
                        returnPostre[j] = (String) posterPathList.get(j + posterLength0);
                    }
                    return returnPostre;//取得所有海报图片的地址
                }
            } else if (posterFlag == 2) {
                if (posterLength2 == 0)
                    return null;
                else {
                    String[] returnPostre = new String[posterLength2];
                    for (int j = 0; j < posterLength2; j++) {
                        returnPostre[j] = (String) posterPathList.get(j + posterLength0 + posterLength1);
                    }
                    return returnPostre;  //取得所有剧照图片的地址
                }
            } else {
                if (totalLength == 0)
                    return null;
                else {
                    String[] returnPostre = new String[totalLength];
                    for (int j = 0; j < totalLength; j++) {
                        returnPostre[j] = (String) posterPathList.get(j);
                    }
                    return returnPostre;  ////取得以上三种图片之和的地址
                }

            }

        }


    }

    /**
     * description : 获取展示内容维护中信息

     * @param inMetaData IPTV获取数据对象
     * @param inPosition 内容展示位置，可以是页面约定好的展示位置标识，也可以直接是栏目ID
     * @param inIsSubject 展示位置是否是栏目0：非栏目 1：栏目

     * @param inLayouttype 展示类型1：推荐2：最新上线3：即将下线4：热点排行

     * @param inContentType 内容类型0：视频VOD1：视频频道2：音频频道4：音频VOD100：增值业务（VAS）200：栏目300：节目（录播节目）

     * @param inStation 从station参数指定的位置开始获取（值≥0）

     * @param inLength 返回结果的最大个数（值≥0）

     */
    ArrayList getLayoutContentByPositionFunction(MetaData inMetaData, String inPosition, int inIsSubject, int[] inLayouttype, int[] inContentType, int inStation, int inLength) {
        ArrayList returnList = new ArrayList();
        HashMap mapInfo = inMetaData.getLayoutContentByPosition(inPosition, inIsSubject, inLayouttype, inContentType, inStation, inLength);

        if (null != mapInfo) {

            //返回全部的结果

            ArrayList tmpList = (ArrayList) mapInfo.get(new Integer(1));

            if (tmpList != null && tmpList.size() == 2) {
                //实际的内容

                ArrayList tmpMapvodList = (ArrayList) tmpList.get(1);

                if (null != tmpMapvodList && tmpMapvodList.size() > 0) {
                    return tmpMapvodList;
                }
            }
        }
        return returnList;
    }

%>
