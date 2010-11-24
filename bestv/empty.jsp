<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="designer" content="meifk" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<style type="text/css">
	#b{}
	</style>
<script>
	function test(){
		alert(event.which);
	}
	document.onkeypress = test;
	document.onirkeypress = test;
	document.onsystemevent = test;
	</script>
</head>
<body id="b" background="images/search/bg_search.jpg">
	<div id="tt" style="position:absolute;left:100;top:100;width:150;height:150;">
		<a href="#">this</a>
	</div>
  <div id="hh" style="position:absolute;left:400;top:400;width:150;height:150;">
		<a href="#">that</a>
	</div>
</body>
</html>