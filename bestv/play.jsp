<%@ include file="HD_preFocusElement.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="designer" content="meifk"  />
<meta name="page-view-size" content="1280*720" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>点播播放页面</title>
<link href="css/default/HD_play.css" rel="stylesheet" type="text/css" />
<script src="js/mini.js" type="text/javascript"></script>
<script src="js/HD_play.js" type="text/javascript"></script>
</head>

<body onunload="exit()" scroll="no">
<div id="menu">
	<!--<div id="title">-->
  	<div id="playcurrtime"></div>
    <div id="programname"></div>
    <!--<div id="playstatus"></div>-->
  <!--</div>-->

  <!--<div id="shortcuts"></div>-->
  <div id="shortprogress"> <div id="shortprogresslinetd"></div></div>
  <div id="programtime"></div>	
  <div id="panel">
  	<div id="information">
    	<table>
      		<tr>
				<td style="color:#00A8FF; width:100px; font-size:24px" align="left">导演：</td>
				<td id="director" align="left" style="color:#ffffff; width:390px;font-size:24px "></td>
				<td style="color:#00A8FF;width:100px;" align="left">主演：</td>
				<td id="actor"  align="left" style="color:#ffffff; width:390px;font-size:24px"></td>
			</tr>
       		<tr >
			 	<td style="color:#00A8FF;width:60px;font-size:24px" align="left">简介:</td>
				<td id="introduction"  align="left" style="color:#ffffff; width:840px;font-size:24px" colspan="3"></td>
			</tr>	
      </table>
    </div>

    <div id="seekprogress">
      <div id="starttime"></div>
      <div id="progresslinetable">
      	<div class="progresstable">
          <table cellpadding="4" cellspacing="4">
            <tr>
              <td></td><td></td><td></td><td></td><td></td>
              <td></td><td></td><td></td><td></td><td></td>
              <td></td><td></td><td></td><td></td><td></td>
              <td></td><td></td><td></td><td></td><td></td>
              <td></td><td></td><td></td><td></td><td></td>
            </tr>
          </table>
        </div>
      </div>
      <div id="progressfocus">
      <div id="progresstime"></div></div>
      <div id="progressline">
      <div id="progresslinetd"></div></div>
      <div id="endtime"></div>
    </div>
  </div>
  <div id="seek">
  	<div id="seektip">
    	<table>
      	<tr>
          <td><img src="images/play/vod_icon_backward.png" /><img src="images/play/vod_icon_backward.png" />&nbsp;&nbsp;快退</td>
          <td><img src="images/play/vod_icon_forward.png" /><img src="images/play/vod_icon_pause.png" />&nbsp;&nbsp;播放/暂停</td>
          <td><img src="images/play/vod_icon_forward.png" /><img src="images/play/vod_icon_forward.png" />&nbsp;&nbsp;快进</td>
        </tr>
      </table>
    </div>

    <div id="seektime">
      <table>
        <tr>
          <td class="ta">输入播放时刻</td>
          <td id="seek_0" class="tf">00</td>
          <td class="tb">时</td>
          <td id="seek_1" class="tf">00</td>
          <td class="tb">分</td>
          <td id="seek_2" class="tf">跳转</td>
          <td id="seek_info" class="tc"></td>
        </tr>
      </table>
  	</div>
  </div>

</div>
<div id="playstatus"></div>
<div id="tip"></div>
<div id="exitWindow1">
	<div id="exitItem02" style="position:absolute; left:20px; top:6px; width:261px; height:84px;background-image:url(images/play/over1.png)"></div>
	<div id="exitItem03" style="position:absolute; left:21px; top:90px; width:267px; height:65px;background-image:url(images/play/continue0.png)"></div>
</div>
<div id="exitWindow">
	<table border="0" cellpadding="0" cellspacing="0" width="571" height="218" >
		<tr VALIGN="middle"><td width="153" rowspan="3" class="sty0" id="exitItem0" style="background-image:url(images/play/pre0.png);">&nbsp;</td>
		  <td width="265" height="63" class="sty0" id="exitItem1" style="background-image:url(images/play/bookmark1.png);">&nbsp;</td>
		  <td width="153" rowspan="3" class="sty0" id="exitItem4" style="background-image:url(images/play/next0.png);">&nbsp;</td>
		</tr>
		<tr VALIGN="middle"><td height="92" class="sty0" id="exitItem2" style="background-image:url(images/play/over0.png);">&nbsp;</td>
	    </tr>
		<tr VALIGN="middle"><td height="63" class="sty0" id="exitItem3" style="background-image:url(images/play/continue0.png);">&nbsp;</td>
	    </tr>
	</table>
	<div id="preNum" style="position:absolute; width:119px; height:42px; left:10px; top:169px; color:#FFFFFF; line-height:42px; font-size:28px;" align="center"></div>
	<div id="nextNum" style="position:absolute; width:119px; height:42px; left:420px; top:169px; color:#FFFFFF; line-height:42px; font-size:28px;" align="center"></div>
</div>
<div id="readTips" style="position:absolute; left:350px; top:208px; height:122px; width:539px; background-image: url(images/vod/tck_bg1.png); text-align:center; visibility:visible">
 <table width="430" border="0" cellspacing="0" cellpadding="0" class="bg">
  <tr>
   <td height="120" colspan="2" align="center" style="font-size:28px; color:#f6ff00;" id="content"></td>
  </tr>
  <!--<tr>
   <td width="215" height="100" align="center" background="images/vod/button0_bg1.gif" id="readBtn0">确定</td>
   <td width="215" align="center" background="images/vod/button0_bg0.gif" id="readBtn1">取消</td>
  </tr>-->
 </table>
</div>
<div id="channelPrompg" style="overflow:hidden; position:absolute; left:350px; top:240px; text-align:center; background-image:url(images/vod/tck_bg2.png); background-repeat:no-repeat; z-index:110;-webkit-transition-duration:1ms;-webkit-transform:scale(0)">
	<table width='576' border='0' cellspacing='0' cellpadding='0' >
		<tr>
			<td height='120' colspan='2' align='center' style='font-size:40px; color:#f6ff00;' vaglin='bottom' id='channelPrompgText'></td>
		</tr>
		<tr>
			<td height='120' colspan='2' valign='top' align='center' style='font-size:40px; color:#f6ff00;' >请切换到其他频道观看</td>
		</tr>
	</table>
</div>

<div id="seriesTips" >
	<div id="seresName"></div>
	<div id="seresSecond"></div>
	<div id="seresNextTips">后自动跳转至下一集...</div>
	<div id="seresNext"></div>
	<div id="seresReturn"></div>
	<div id="seresFocus"></div>
</div>
<div style="position: absolute;left: 950;top: 10;width: 308;height: 45;"><img src="images/portal/logo.png" /></div>
</body>

</html>

