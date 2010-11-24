<!--声明MIME类型，指定字符集-->
<%@ page contentType="text/html; charset =UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGSysParam"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ include file="HD_preFocusElement.jsp" %>
<!--定义常量,以下这些常量可以部署在部署文件中 -->
<html>
<link href="css/stylesheet.css" rel="stylesheet" type="text/css">
<meta name="page-view-size" content="1280*720" />
<style type="text/css">
<!--
.STYLE1 {font-size: 30px; color: #7EC2E1}
.STYLE2 {font-size: 45px; color: #ffffff}
.STYLE3 {font-size: 35px; color: #0F4369}
-->
</style>
<head>
<title>InfoDisplay</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<script src="js/mini.js" type="text/javascript"></script>
<script>
	function eventHandler(obj) {
		switch(obj.code) {
			case "KEY_BACK":
			case "KEY_SELECT":
				goBack()
				break;
		}
	}
	
    function goBack()
    {
        window.location.href = backUrl;
    }

</script>

<%!

    //信息内容定义
    protected String[][] info = new String[][]
    {
        //001
        {
            "系统产生未知错误。",
            "服务器错误。",
            "请稍候重试，如果问题依然存在，联系服务提供商。"
        },

        //002
        {
            "数据传输失败。",
            "服务器正忙。",
            "请稍候重试，如果问题依然存在，联系服务提供商"
        },

        //003
        {
            "用户订购认证失败。",
            "此用户不存在，或者用户名/密码为空。",
            "请输入正确的用户名和密码，如果问题依然存在，联系服务提供商。"
        },

        //004
        {
            "此用户已经暂停使用。",
            "此用户已经暂停使用。",
            "联系服务提供商。"
        },

        //005
       	{
            "用户状态错误。",
            "用户欠费。",
            "有关详情，请联系服务提供商。"
        },

        //006
        {
            "该用户不存在。",
            "该用户不存在,导致认证失败。",
            "重启机顶盒，进行认证。如果问题仍然存在，请联系服务提供商。"
        },

        //007
        {
            "用户状态异常。",
            "用户状态异常，导致认证失败。",
            "重启机顶盒，进行认证。如果问题仍然存在，请联系服务提供商。"
        },

        //008
        {
            "用户名/密码错误。",
            "用户名/密码错误，导致认证失败。",
            "重启机顶盒，进行认证。如果问题仍然存在，请联系服务提供商。"
        },

        //009
        {
            "用户取消了认证。",
            "认证已被取消。",
            "重启机顶盒，进行认证。如果问题仍然存在，请联系服务提供商。"
        },

        //010
        {
            "数据包格式错误。",
            "数据包格式错误，导致认证失败。",
            "重启机顶盒，进行认证。如果问题仍然存在，请联系服务提供商。"
        },

        //011
        {
            "验证显示数据错误。",
            "验证显示数据错误，导致认证失败。",
            "重启机顶盒，进行认证。如果问题仍然存在，请联系服务提供商。"
        },

        //012
        {
            "修改密码失败。",
            "修改密码失败。",
            "按返回键到上级菜单，如果问题依然存在，请联系服务提供商。"
        },

        //013
        {
            "修改密码成功。",
            "修改密码成功。",
            ""
        },

        //014
        {
            "设置父母锁成功。",
            "设置父母锁成功。",
            ""
        },

        //015
        {
            "设置父母锁失败。",
            "设置父母锁失败。",
            "按返回键到上一级菜单。"
        },

        //016
        {
            "验证密码与新密码不一致。",
            "验证密码与新密码不一致。",
            "按返回键到上一级菜单。"
        },

        //017
        {
            "新密码长度不超过12位数字。",
            "新密码长度不超过12位数字。",
            "按返回键到上一级菜单。"
        },

        //018
        {
            "旧密码错误。",
            "旧密码错误。",
            "按返回键到上一级菜单。"
        },

        //019
        {
            "密码错误。",
            "密码错误。",
            "按返回键到上一级菜单。"
        },

        //020
        {
            "获取电影URL失败。",
            "获取电影URL失败。",
            "按返回键到上一级菜单，如果问题仍然存在，请联系服务提供商。"
        },

        //021
        {
            "查询条件为空。",
            "查询条件不能为空。",
            "按返回键到上一级菜单。"
        },

        //022
        {
            "此频道不可用。",
            "此频道正在创建中。。。",
            "按返回键到首页重新选择其他功能。"
        },

        //023
        {
            "没有有效的子类别",
            "您所选的电影类别没有子类别。",
            "按返回键重新选择。"
        },

        //024
        {
            "电影URL错误。",
            "电影URL错误。",
            "按返回键再重试，如果问题依然存在，请联系服务提供商。"
        },

        //025
        {
            "没有可用的内容。",
            "您选择的类别下没有可用的内容。",
            "按返回键重新选择。"
        },

        //026
        {
            "授权失败。",
            "授权失败。",
            "请重试，如果问题依然存在，联系服务提供商。"
        },
        //027
        {
            "授权失败。",
            "授权失败，该节目不能被订购。",
            "请重试，如果问题依然存在，联系服务提供商。"
        },
        //028
        {
            "用户标志不能为空。",
            "用户标志不能为空。",
            "请稍后再试。如果问题仍然存在，请联系服务提供商。"
        },

        //029
        {
            "用户ID标记不能为空。",
            "用户ID标记不能为空。",
            "请稍后再试。如果问题仍然存在，请联系服务提供商。"
        },

        //030
        {
            "用户ID标记无效。",
            "用户ID标记无效。",
            "请稍后再试。如果问题仍然存在，请联系服务提供商。"
        },

        //031
        {
            "用户ID标记超时。",
            "用户ID标记超时。",
            "请稍后再试。如果问题仍然存在，请联系服务提供商。"
        },

        //032
        {
            "服务未启动。",
            "服务未启动。",
            "所选影片服务未启动，请选择播放其它节目。"
        },

        //033
        {
            "服务已停止。",
            "服务已停止。",
            "所选影片服务已停止，请选择播放其它节目。"
        },

        //034
        {
            "登录超时。",
            "登录超时。",
            "请登录后再使用该系统。"
        },
        //035
        {
            "用户未授权自动再订购产品。",
            "用户未授权自动再订购产品。",
            "请按返回返回前一菜单。"
        },

        //036
        {
            "订购产品失败。",
            "订购产品失败。",
            "按返回键到上一级菜单，如果问题依然存在，请联系服务提供商。"
        },

        //037
        {
            "余额不足。",
            "余额不足。",
            "余额不足，请在订购之前进入业务中心充值。"
            },

        //038
        {
            "用户取消了付款。",
            "用户取消了付款。",
            "用户取消了付款。",
        },

        //039
        {
            "订购失败。",
            "订购失败。",
            "订购失败。请稍后再试。如果问题仍然存在，请联系服务提供商。"
        },

        //040
        {
            "订购成功。",
            "订购成功。",
            "订购成功，但在系统更新时出现异常。如果要再订购，请重启机顶盒。如果问题仍然存在，请联系服务提供商。"
        },

        //041
        {
            "没有热点电影。",
            "当前时间没有热点电影。",
            "按返回键重新选择。"
        },

        //042
        {
            "不能删除节目。",
            "现在不能删除节目。",
            "请按返回重新选择。"
        },

        //043
        {
            "无最新节目。",
            "现在无最新节目。",
            "请按返回重新选择。"
        },

         //044
        {
            "清空收藏失败。",
            "清空收藏失败。",
            "按返回键再重试，如果问题依然存在，请联系服务提供商。"
        },

        //045
        {
            "添加收藏夹失败。",
            "添加收藏夹失败。",
            "按返回键重试，如果问题依然存在，请联系服务提供商。"
        },

        //046
        {
            "获取电影信息失败。",
            "获取电影信息失败。",
            "按返回键再重试，如果问题依然存在，请联系服务提供商。"
        },

        //047
        {
           	"视频点播记录为空。",
            "最近视频点播记录为空。",
            "请按返回返回。"
        },

        //048
        {
            "。",
            "电影已过期。",
            "此电影已被管理员取消，请选择其他的电影观看。"
        },

        //049
        {
            "父母控制级别修改成功。",
            "父母控制级别修改成功。",
            ""
        },

        //050
        {
            "父母控制级别修改失败。",
            "父母控制级别修改失败。服务器正忙。",
            "按返回键再重试，如果问题依然存在，请联系服务提供商。"
        },

        //051
        {
            "密码不能包含空格。",
            "密码不能包含空格。",
            "按返回键到上一级菜单。"
        },

        //052
        {
            "旧密码不能为空。",
            "旧密码不能为空。",
            "按返回键到上一级菜单。"
        },

        //053
        {
            "新密码不能为空。",
            "新密码不能为空。",
            "按返回键到上一级菜单。"
        },

        //054
        {
            "验证密码不能为空。",
            "验证密码不能为空。",
            "按返回键到上一级菜单。"
        },

        //055
        {
            "搜索条件不能为空。",
            //"No record is found.",
            "没有查询到记录",
			//"Press &lt;Back&gt; to go back to the previous menu."
			"按返回键到上一级菜单。"			
        },   
		
        //056
        {
            //"The network bandwidth is insufficient.",
            "网络带宽不足。",
			     //"The content bandwidth is greater than the subscriber's bandwidth.",
			      "节目所需带宽大于预订带宽。",
            //"Apply for greater network bandwidth."
			      "需要更大网络带宽。"
        },

        //057
        {
            //"No content is available in \"My Favorite\".",
            "收藏夹无可以访问的内容。",
			      //"No content is available in \"My Favorite\".",
            "收藏夹无可以访问的内容。",
			      //"Press &lt;Back&gt; to go back to the previous menu."
			      "按返回键到上一级菜单。"
        },

        //058
        {
            //"No CDR is found.",
			      "找不到CDR。",
            //"No CDR is found.",
			      "找不到CDR。",
            //"Press &lt;Back&gt; to go back to the previous menu."
			      "找不到CDR。"
        },

        //059
        {
            //"Fail to add to  \"My Favorite\", no space is available.",
			      "添加失败，收藏夹已满。",
            //"Fail to add to  \"My Favorite\" because no space is available.",
			      "添加失败，收藏夹已满。",
            //"Press &lt;Back&gt; to go back to the previous menu."
			      "按返回键到上一级菜单。"
        },

        //060
        {
            "登录超时。",
            "登录超时。",
            "按菜单重新登录。"
        },

        //061
        {
            //"The subscriber authentication failed.",
			      "用户认证失败。",
            //"The subscriber authentication failed.",
			      "用户认证失败。",
            //"Press &lt;Back&gt; to try again. If the problem persists, contact the service provider."
			      "按返回键重试，若仍有问题，请联系服务供应商。"
        },

        //062
        {
            "您的输入存在非法字符。",
            "您的输入存在非法字符。",
            "您的输入只允许以下字符： \"0-9\", \"a-z\", \"A-Z\", \".\" and \"@\"。按键回键到上一级菜单。"
        },

        //063
        {
            "密码不能为空。",
            "密码不能为空。",
            "按返回键到上一级菜单。"
        },

        //064
        {
            //"Query failed because the no space is available for the play list.",
			      "查询失败，播放空间不足。",
            //"Query failed because the no space is available for the play list.",
			      "查询失败，播放空间不足。",
            //"Press &lt;Back&gt; to go back to the previous menu."
			      "按返回键到上一级菜单。"
        },

        //065
        {
            //"Failed to query skins.",
			      "浏览界面风格失败。",
            //"Failed to query skins because the server is busy.",
			      "系统繁忙，浏览界面风格失败。",
            //"Failed to query skins. If the problem persists, contact the service provider."
			      "浏览界面风格失败。若问题仍存在，请联系服务供应商。"
        },

        //066
        {
            "此界面风格不需要切换。",
            "此界面风格不需要切换。",
            //"The skin does not need to be switched because it is identical with that you have selected."
			      "此界面风格不需要切换，已经选择同样界面风格。"
        },

        //067
        {
            "界面风格信息不存在。",
            "界面风格信息不存在。",
            //"Select another skin to switch because the information of the skin you have selected does not exist."
			      "所选界面风格信息不存在，请选择其他界面风格。"
        },

        //068
        {
            "界面风格切换失败。",
            "界面风格切换失败。",
            "界面风格切换失败。按返回键到上一级菜单。"
        },

        //069
        {
            "界面风格切换失败。",
            "界面风格切换失败。服务器正忙。",
            "按返回键再重试，如果问题依然存在，请联系服务提供商。"
        },

        //070
        {
            "播放流不存在或电影已过期。",
            "播放流不存在或电影已过期。",
            "请选择其他电影播放。"
        },

        //071
        {
            //"Failed to modify the Parental control.",
            "修改父节点失败。",
			      //"Failed to modify the Parental control because the server is busy.",
            "系统繁忙，修改父节点失败。",
			      //"Press &lt;Back&gt; to try again later. If the problem persists, contact the service provider."
			      "按返回键重试，若问题仍存在，请联系服务供应商。"
        },

        //072
        {
            //"Querying CDRs failed.",
			      "查询CDRs失败。",	
            //"Querying CDRs failed.",
			      "查询CDRs失败。",	
            //"Contact the service provider."
			      "请联系服务供应商。"
        },

        //073
        {
            "切换语言失败。",
            "切换语言失败。",
            //"Press &lt;Back&gt; to try to switch back to the language in use."
			"按返回键还原。"
        },

        //074
        {
            //"Failed to lock/unlock the program,subject or favourite.",
			"节目加/解锁失败，请选择子级目录或收藏夹。",
            //"Failed to lock/unlock the program,subject or favourite.",
			"节目加/解锁失败，请选择子级目录或收藏夹。",
            //"Press &lt;Back&gt; to try again. If the problem persists, contact the service provider."
			"按返回键重试，若问题仍存在，请联系服务供应商。"
        },

        //075
        {
            "节目或类别锁定失败。",
            "节目或类别锁定失败。",
            //"Delete the lock manually because the number of locks has reached the specified maximum value."
			"加锁数目已达上限，请将锁手动删除。"
        },

        //076
        {
            //"No content is available in \"My Lock\".",
            "加锁文件夹无可访问的内容。",
			//"No content is available in \"My Lock\".",
            "加锁文件夹无可访问的内容。",
			//"Press &lt;Back&gt; to go back to the previous menu."
			"按返回键，返回到上级菜单。"
        },

        //077
        /** [AB4D03162] 2007-01-26 qiaihua61086 mod begin **/
        {
            "收藏电影删除失败。",
            "收藏电影删除失败。",
            "请返回后重试，如果问题依然存在，请联系服务提供商。"
        },
        /** [AB4D03162] 2007-01-26 qiaihua61086 mod end **/

        //078
        {
            "取消定购成功。",
            "取消定购成功。",
            ""
        },

        //079
        {    "非自动续订的产品不能被取消。",
             "非自动续订的产品不能被取消。",
             "请联系服务提供商。"
        },

        //080
        {
            //"No order info has bean found.",
			"没有订购信息。",
            //"No order info is found.",
			"没有订购信息。",
            //"Press &lt;Back&gt; to go back to the previous menu."
			"按返回键，返回到上级菜单。"
        },

        //081
        {
            //"Querying order failed.",
            "查询订购失败。",
			//"Querying order failed.",
            "查询订购失败。",
			//"Press &lt;Back&gt; to try again. If the problem persists, contact the service provider."
			"按返回键重试，若问题仍存在，请联系服务供应商。"
        },

		//082
		{
		    //"Querying the movie ID failed.",
			"查询电影ID失败。",
			//"Querying the movie ID failed.",
			"查询电影ID失败。",
			//"Input a number for the movie ID."
			"请输入一个数字做为电影ID。"
		},

        //083
        {
            "修改密码失败。",
            "旧密码错误。",
            "按返回键到上一级菜单。"
        },

        //084
        {
            "没有有效的书签电影。",
            "没有有效的书签电影。",
            "按返回键到上一级菜单。"
        },

        //085
        {
            "搜索关键字不能为空。",
            "搜索关键字不能为空。",
            "按返回键到上一级菜单。"
        },

        //086
        {
            "此电影不存在。",
            "此电影不存在。",
            "按返回键到上一级菜单。"
        },

        //087
        {
            "密码修改失败。",
            "密码修改失败。服务器正忙。",
            "按返回键再重试，如果问题依然存在，请联系服务提供商。"
        },

        //088
        {
            "您的输入存在非法字符。",
            "您的输入存在非法字符。",
            "您的输入不支持如下字符: '<', '>', '\\', '\"', '\'', '%', '_', '#', '&', '+'。按返回键到上一级菜单。"
        },

        //089
        {
            "查询订购失败。",
            "查询订购失败，服务器正忙。",
            "按返回键重试，如果问题依然存在，请联系服务提供商。"
        },

        //090
        {
            "取消定购失败。",
            "取消定购失败，服务器正忙。",
            "按返回键重试，如果问题依然存在，请联系服务提供商。"
        },
        //091
        /** 问题单AB4D02223 wangshengli60020365  2006-12-6  add begin  */
        {
            "您的输入包含非法字符。",
            "您的输入包含非法字符。",
            "您的输入可能包含以下非法字符：'<', '>', '\\', '\"', '%', '_', '#', '+'。按返回键到上一级菜单。"
        },
        /** 问题单AB4D02223 wangshengli60020365  2006-12-6  add end  */
        //092
        /** add by wujian54818 for AB4D03651 on 2007-02-26---------begin  */
        {
        	//"Time out or network error while connect to ACS.",
        	"网络连接超时或连接ACS失败。",
			//"Time out or network error while connect to ACS.",
        	"网络连接超时或连接ACS失败。",
			//"Press &lt;Back&gt; to go back to the previous menu. If the problem persists, contact the service provider."
			"按返回键重试，若问题仍存在，请联系服务供应商。"
        },
        /** add by wujian54818 for AB4D03651 on 2007-02-26---------end  */
        //093
        /** B110开发 wangshengli60020365  2007-6-8  add begin  */
        {   
			//"Can not cancel this program now.",
            "现在不能关闭节目。",
			//"Can not cancel this program now.",
            "现在不能关闭节目。",
			//"Press &lt;Back&gt; to go back to the previous menu."
			"按返回键到上一级菜单。"
        },
        //094
        {
            //"Get PPV program failed,can not subscribe this program",
			"PPV节目获取失败，无法订购这个节目。",            
			//"Get PPV program failed,can not subscribe this program",
            "PPV节目获取失败，无法订购这个节目。",
			//"Press &lt;Back&gt; to go back to the previous menu."
			"按返回键到上级菜单。"
        },
        //095
        {
            //"This program has been ordered,but not reach the time",
            "该节目已经设定定时提醒，但没有达到播放时间。",
			//"This program has been ordered,but not reach the time",
            "该节目已经设定定时提醒，但没有达到播放时间。",            
			//"Press &lt;Back&gt; to go back to the previous menu."
			"按返回键到上级菜单。"
        },

        /** B110开发 wangshengli60020365  2006-6-8  add end  */
        /* C03B110版本开发 add by f60019624 2007-6-15 begin */
        //096
        {
            "增值服务已过期。",
            "增值服务已过期。",
            //"Select another Value-added service to play because the Value-added service has been canceled by the carrier."
			"该增值服务已过期，请选择其他增值服务。"
        },
        //097
        {
            "增值服务不存在。",
            "增值服务不存在。",
            "按返回键到上一级菜单。"
        } ,
        //098
        {
            //"This product can not been cancel automatic reorder,you may ordered next month program", 
            "本产品不能自动取消续购功能，您需要下月继续定购",
			//"This product can not been cancel automatic reorder,you may ordered next month program",
            "本产品不能自动取消续购功能，您需要下月继续定购",
			//"Press &lt;Back&gt; to go back to the previous menu."
			"按返回键到上一级菜单。"
        },
        //099
        {
            "该节目不支持订购。",
            "该节目不支持订购。",
            "按返回键到上一级菜单。"
        },
        //100
        {
            "现在不提供trailer服务。",
            "现在不提供trailer服务。",
            "按返回键到上一级菜单。"
        },
        /* C03B110版本开发 add by f60019624 2007-6-15 end */
        //101
        {
            //"Has ordered this product or program.",
			"该产品/节目已经订购。",
            //"Has ordered this product or program.",
            "该产品/节目已经订购。",
			//"Press &lt;Back&gt; to go back to the previous menu."
			"按返回键到上一级菜单。"
        },
        //102
        {
            //"Cancel this program failed.",
			"关闭节目失败。",
            //"Cancel this program failed.",
			"关闭节目失败。",
            //"Press &lt;Back&gt; to go back to the previous menu."
			"按返回键到上一级菜单。"
        },
        //103
        {
            //"This record not exist,or has been cancelled successfully.",
			"记录不存在或已经被删除。",
            //"This record not exist,or has been cancelled successfully.",
			"记录不存在或已经被删除。",			
            //"Press &lt;Back&gt; to go back to the previous menu."
			"按返回键到上一级菜单。"
        },
		//104
        {
            "没有下线电影。",
            "当前时间没有下线电影。",
            "按返回键重新选择。"
        },
		//105
        {
            "暂无节目单。",
            "您选择的频道暂无节目单。",
            "按返回键重新选择。"
        },
		//106
        {
            "暂不提供此服务",
            "暂不提供此服务。",
            "按返回键重新选择。"
        },
		//107
        {
            "暂无聚场",
            "您没有订购聚场。",
            "按返回键重新选择。"
        },
		//108
        {
             "暂无节目单。",
            "您选择的聚场暂无节目单。",
            "按返回键重新选择。"
        },
		//109
		{
			"节目还未录制好",
			"节目还未录制好",
			"按返回键重新选择。"
		},
		//110
        {
            "没有最新电影。",
            "当前时间没有最新电影。",
            "按返回键重新选择。"
        },
		//111
        {
            "没有一周排行电影。",
            "当前没有一周排行电影。",
            "按返回键重新选择。"
        },
		//112
        {
            "没有今日更新电影。",
            "当前没有今日更新电影。",
            "按返回键重新选择。"
        },
		//113
        {
            "暂无节目单。",
            "您选择的聚场暂无节目单。",
            "按返回键重新选择。"
        },
    		//114
    		{
    			"你选择的影片无在线订购服务",
    			"你选择的影片无在线订购服务",
    			"按返回键重新选择。"
    		},
        //115
        {
            "片花不存在或已经过期。",
            "片花不存在或已经过期。",
            "请选择其他电影播放。"
        },
		    //116
        {
            "推荐栏目数据提取错误。",
            "推荐栏目数据提取错误。",
            "按返回键到上一级菜单。"
        },
		    //117
        {
            "推荐VOD数据提取错误。",
            "推荐VOD数据提取错误。",
            "按返回键到上一级菜单。"
        },
		    //118
        {
            "该演员下没有任何影片。",
            "该演员下没有任何影片。",
            "按返回键到上一级菜单。"
        },
		    //119
        {
            "该导演下没有任何影片。",
            "该导演下没有任何影片。",
            "按返回键到上一级菜单。"
        },
		    //120
        {
            "没有任何演员。",
            "没有任何演员。",
            "按返回键到上一级菜单。"
        },
		    //121
        {
            "没有任何导演。",
            "没有任何导演。",
            "按返回键到上一级菜单。"
        },
		    //122
        {
            "你输入的频道不存在！",
            "你输入的频道不存在！",
            "按返回键到上一级菜单。"
        },
        //123
        {
            "查询频道信息失败！",
            "查询频道信息失败！",
            "请重新输入频道号，如果问题依然存在，请联系服务提供商。"
        },
        //124
        {
            "输入的频道号错误！",
            "输入的频道号错误！",
            "请重新输入频道号，如果问题依然存在，请联系服务提供商。"
        },
        //125
        {
            "该节目暂时无法观看，请稍后再试！",
            "该节目暂时无法观看，请稍后再试！",
            "按返回键键重新选择。"
        },
		    //126
        {
            "该频道不存在！",
            "你选择的频道不存在！",
            "按返回键到上一级菜单。"
        },
        //127
        {
            "该频道尚未订购",
            "你选择的频道尚未订购！",
            "按返回键到上一级菜单。"
        } ,
		    //128
        {
            "暂无节目单。",
            "您选择的时段暂无节目单。",
            "按返回键重新选择。"
        },
        //129
        {
            "暂无专辑。",
            "您选择的栏目暂无专辑。",
            "按返回键重新选择。"
        },
        //130
        {
	          "130您正在下载的节目已删除",
	          "您正在下载的节目已删除",
	          "按返回键重新选择"
	      },
        //131
	      {
	          "131无法下载",
	          "您的外接设备空间不足",
	          "请腾空你的外接设备"
	      },
	      //132
	      {
	          "132无法读取外接设备",
	          "您的外接设备和本机顶盒不兼容",
	          "请尝试其他外接设备"
	      },
	      //133
	      {
	          "133无法删除书签",
	          "用户ID读取失败",
	          "请重启机顶盒"
	      },
	      //134
	      {
	          "134无法读取您外接设备的文档",
	          "您的文档格式，机顶盒不支持",
	          "请尝试有效的文件格式"
	      },
	      //135
	      {
	          "135由于网络原因下载已暂停",
	          "由于网络原因下载已暂停",
	          "请检查网络连接"
	      }
	      ,
        //136
        {
            //"No order info has bean found.",
			"没有订购信息。",
            //"No order info is found.",
			"没有订购信息。",
            //"Press &lt;Back&gt; to go back to the previous menu."
			"按返回键，返回到上级菜单。"
        }
         ,
        //137
        {
            //"No order info has bean found.",
			"没有看吧信息。",
            //"No order info is found.",
			"没有看吧信息。",
            //"Press &lt;Back&gt; to go back to the previous menu."
			"按返回键，返回到上级菜单。"
        }
         ,
        //138
        {

			"产品不存在或者产品不可用。",
			"产品不存在或者产品不可用。",
			"按返回键，返回到上级菜单。"
        }
          ,
        //139
        {

			"服务不存在或状态不可用。",
			"服务不存在或状态不可用。",
			"按返回键，返回到上级菜单。"
        }
          ,
        //140
        {
			"订购的产品不在使用期内。",
			"订购的产品不在使用期内。",
			"按返回键，返回到上级菜单。"
        }
           ,
        //141
        {
			"用户没有订购相应产品或订购关系已失效或未生效。",
			"用户没有订购相应产品或订购关系已失效或未生效。",
			"按返回键，返回到上级菜单。"
        }
           ,
        //142
        {
			"没有可以订购的产品。",
			"没有可以订购的产品。",
			"按返回键，返回到上级菜单。"
        }
           ,
        //143
        {
			"数据库异常。",
			"数据库异常。",
			"按返回键，返回到上级菜单。"
        }
           ,
        //144
        {
			"操作超时。",
			"操作超时。",
			"按返回键，返回到上级菜单。"
        }
           ,
        //145
        {
			"用户不存在或非法用户。",
			"用户不存在或非法用户。",
			"按返回键，返回到上级菜单。"
        }
           ,
        //146
        {
			"用户令牌非法。",
			"用户令牌非法。",
			"按返回键，返回到上级菜单。"
        }
           ,
        //147
        {
			"传入的参数错误。",
			"传入的参数错误。",
			"按返回键，返回到上级菜单。"
        }
           ,
        //148
        {
			"解码出现异常。",
			"解码出现异常。",
			"按返回键，返回到上级菜单。"
        }
           ,
        //149
        {
			"授权失败。",
			"授权失败。",
			"按返回键，返回到上级菜单。"
			
        }
          ,
      //150
      {
          //"No order info has bean found.",
		"未检测到移动设备。",
          //"No order info is found.",
		"未检测到移动设备。",
          //"Press &lt;Back&gt; to go back to the previous menu."
		"按返回键，返回到上级菜单。"
      }
          ,
      //151
      {
          //"No order info has bean found.",
		"正在检测数据中...。",
          //"No order info is found.",
		"正在检测数据中...。",
          //"Press &lt;Back&gt; to go back to the previous menu."
		"按返回键，返回到上级菜单。"
      }
          ,
      //151
      {
          //"No order info has bean found.",
		"帮助页面数据为空。",
          //"No order info is found.",
		"帮助页面数据为空。",
          //"Press &lt;Back&gt; to go back to the previous menu."
		"按返回键，返回到上级菜单。"
      }
	  };
%>
<%
    String strErrorID = null;
    String errorType = null;
    String resolve = null;
    //警示图片路径
    String alertsrc = null;
    //背景图片路径
    String backsrc = null;
    //返回按钮图片路径
    String retbtsrc = "images/portal/ui_error_button.png";
    int iErrorID = 1;
    int ierrorType=2;
    int leftwidth=100;
    strErrorID = (String)request.getParameter("ERROR_ID");
    
    if(strErrorID != null && !strErrorID.equals(""))
    {
        iErrorID = Integer.parseInt(strErrorID);
    }
    else
    {
        iErrorID = 1;
    }
    if( iErrorID < 1 || iErrorID > info.length)
    {
        iErrorID = 1;
    }
    String desc = info[iErrorID-1][0];
    String user_desc = info[iErrorID-1][1];
    String solution  = info[iErrorID-1][2];
    backsrc = "images/portal/ui_error.jpg";
%>

<body leftmargin="0" topmargin="0" class="unnamed1" background="<%=backsrc%>">
</body>

<div id="back" style="position:absolute;left:570px;top:380px;width:142px;height:56px;"><img src="images/portal/link-dot.gif" width="142" height="56" /></a></div>
<div id="info0" style="position:absolute;left:120px;top:180px;width:1200px;height:34px;" class="STYLE2"><%=user_desc%></div>
<div id="info1" style="position:absolute;left:120px;top:250px;width:610px;height:34px" class="STYLE3"><%=solution%></div>
<div id="info2" style="position:absolute;left:22px;top:590px;width:610px;height:34px" class="STYLE1">错误信息：<%=desc%></div>
<div id="code" style="position:absolute;left:22px;top:630px;width:610px;height:34px" class="STYLE1">错误代码：<%=iErrorID%></div>

                       
</html>
