<%@ include file="HD_preFocusElement.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta name="designer" content="hwhd" />
	<meta name="page-view-size" content="1280*720" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>Download</title>
	<link href="css/default/HD_downloadPortal.css" rel="stylesheet" type="text/css" />
	<script src="js/mini.js" type="text/javascript"></script>
	<script src="js/DownLoad.js" type="text/javascript"></script>
	<script src="js/HD_downloadPortal.js" type="text/javascript"></script>
</head>

<body onload="init();" onunload="exit();">
	<div id="logo"></div>
	<div id="title">功能-我的下载</div>
	
	<div id="manager"> 				
		<a href="HD_DownloadManager.jsp">
			<img src="images/download/manager.png" width='193px' height='68px' border='0'>
		</a>
	</div>
	
	<div id="page_up"></div>
	<!--
	<div id="item_focus"></div>
	-->
	<div class="line" id="item_0">
		<div class="poster" id="poster_0" ></div>
		<div class="name" id="name_0" ></div>
		<div class="progress" id="progress_0">
			<div id="left_bar"></div>
			<div id="middle_bar"></div>
			<div id="right_bar"></div>
		</div>
		<div class="percent" id="percent_0">
			<div id="number_1"></div>
			<div id="number_2"></div>
			<div id="number_3"></div>
			<div id="number_4"></div>
		</div>
		<div id="status_1"></div>
	</div>
	
	<div class="line" id="item_1">
		<div class="poster" id="poster_1" ></div>
		<div class="name" id="name_1" ></div>
		<div class="progress" id="progress_1">
			<div id="left_bar"></div>
			<div id="middle_bar"></div>
			<div id="right_bar"></div>
		</div>
		<div class="percent" id="percent_1">
			<div id="number_1"></div>
			<div id="number_2"></div>
			<div id="number_3"></div>
			<div id="number_4"></div>
		</div>
	</div>
	<div class="line" id="item_2">
		<div class="poster" id="poster_2"></div>
		<div class="name" id="name_2" ></div>
		<div class="progress" id="progress_2">
			<div id="left_bar"></div>
			<div id="middle_bar"></div>
			<div id="right_bar"></div>
		</div>
		<div class="percent" id="percent_2">
			<div id="number_1"></div>
			<div id="number_2"></div>
			<div id="number_3"></div>
			<div id="number_4"></div>
		</div>
	</div>
	<div class="line" id="item_3">
		<div class="poster" id="poster_3" ></div>
		<div class="name" id="name_3" ></div>
		<div class="progress" id="progress_3">
			<div id="left_bar"></div>
			<div id="middle_bar"></div>
			<div id="right_bar"></div>
		</div>
		<div class="percent" id="percent_3">
			<div id="number_1"></div>
			<div id="number_2"></div>
			<div id="number_3"></div>
			<div id="number_4"></div>
		</div>
	</div>
	<div class="line" id="item_4">
		<div class="poster" id="poster_4" ></div>
		<div class="name" id="name_4" ></div>
		<div class="progress" id="progress_4">
			<div id="left_bar"></div>
			<div id="middle_bar"></div>
			<div id="right_bar"></div>
		</div>
		<div class="percent" id="percent_4">
			<div id="number_1"></div>
			<div id="number_2"></div>
			<div id="number_3"></div>
			<div id="number_4"></div>
		</div>
	</div>
	<div class="line" id="item_5">
		<div class="poster" id="poster_5" ></div>
		<div class="name" id="name_5" ></div>
		<div class="progress" id="progress_5">
			<div id="left_bar"></div>
			<div id="middle_bar"></div>
			<div id="right_bar"></div>
		</div>
		<div class="percent" id="percent_5">
			<div id="number_1"></div>
			<div id="number_2"></div>
			<div id="number_3"></div>
			<div id="number_4"></div>
		</div>
	</div>
	
	<div class="line" id="item_6">
		<div class="poster" id="poster_6" ></div>
		<div class="name" id="name_6" ></div>
		<div class="progress" id="progress_6">
			<div id="left_bar"></div>
			<div id="middle_bar"></div>
			<div id="right_bar"></div>
		</div>
		<div class="percent" id="percent_6">
			<div id="number_1"></div>
			<div id="number_2"></div>
			<div id="number_3"></div>
			<div id="number_4"></div>
		</div>
	</div>
	<div class="line" id="item_7">
		<div class="poster" id="poster_7" ></div>
		<div class="name" id="name_7" ></div>
		<div class="progress" id="progress_7">
			<div id="left_bar"></div>
			<div id="middle_bar"></div>
			<div id="right_bar"></div>
		</div>
		<div class="percent" id="percent_7">
			<div id="number_1"></div>
			<div id="number_2"></div>
			<div id="number_3"></div>
			<div id="number_4"></div>
		</div>
	</div>
	<div class="line" id="item_8">
		<div class="poster" id="poster_8" ></div>
		<div class="name" id="name_8" ></div>
		<div class="progress" id="progress_8">
			<div id="left_bar"></div>
			<div id="middle_bar"></div>
			<div id="right_bar"></div>
		</div>
		<div class="percent" id="percent_8">
			<div id="number_1"></div>
			<div id="number_2"></div>
			<div id="number_3"></div>
			<div id="number_4"></div>
		</div>
	</div>
	<div class="line" id="item_9">
		<div class="poster" id="poster_9" ></div>
		<div class="name" id="name_9" ></div>
		<div class="progress" id="progress_9">
			<div id="left_bar"></div>
			<div id="middle_bar"></div>
			<div id="right_bar"></div>
		</div>
		<div class="percent" id="percent_9">
			<div id="number_1"></div>
			<div id="number_2"></div>
			<div id="number_3"></div>
			<div id="number_4"></div>
		</div>
	</div>
	<div class="line" id="item_10">
		<div class="poster" id="poster_10" ></div>
		<div class="name" id="name_10" ></div>
		<div class="progress" id="progress_10">
			<div id="left_bar"></div>
			<div id="middle_bar"></div>
			<div id="right_bar"></div>
		</div>
		<div class="percent" id="percent_10">
			<div id="number_1"></div>
			<div id="number_2"></div>
			<div id="number_3"></div>
			<div id="number_4"></div>
		</div>
	</div>
	
	<div class="line" id="item_11">
		<div class="poster" id="poster_11" ></div>
		<div class="name" id="name_11" ></div>
		<div class="progress" id="progress_11">
			<div id="left_bar"></div>
			<div id="middle_bar"></div>
			<div id="right_bar"></div>
		</div>
		<div class="percent" id="percent_11">
			<div id="number_1"></div>
			<div id="number_2"></div>
			<div id="number_3"></div>
			<div id="number_4"></div>
		</div>
	</div>
	<div class="line" id="item_12">
		<div class="poster" id="poster_12" ></div>
		<div class="name" id="name_12" ></div>
		<div class="progress" id="progress_12">
			<div id="left_bar"></div>
			<div id="middle_bar"></div>
			<div id="right_bar"></div>
		</div>
		<div class="percent" id="percent_12">
			<div id="number_1"></div>
			<div id="number_2"></div>
			<div id="number_3"></div>
			<div id="number_4"></div>
		</div>
	</div>
	<div class="line" id="item_13">
		<div class="poster" id="poster_13" ></div>
		<div class="name" id="name_13" ></div>
		<div class="progress" id="progress_13">
			<div id="left_bar"></div>
			<div id="middle_bar"></div>
			<div id="right_bar"></div>
		</div>
		<div class="percent" id="percent_13">
			<div id="number_1"></div>
			<div id="number_2"></div>
			<div id="number_3"></div>
			<div id="number_4"></div>
		</div>
	</div>
	<div class="line" id="item_14">
		<div class="poster" id="poster_14" ></div>
		<div class="name" id="name_14" ></div>
		<div class="progress" id="progress_14">
			<div id="left_bar"></div>
			<div id="middle_bar"></div>
			<div id="right_bar"></div>
		</div>
		<div class="percent" id="percent_14">
			<div id="number_1"></div>
			<div id="number_2"></div>
			<div id="number_3"></div>
			<div id="number_4"></div>
		</div>
	</div>
	
	<div id="page_down" ></div>
	<div id="page_num"></div>
	
	<div id="error_tips">选中状态文字提示区</div>
	
</body>
</html> 