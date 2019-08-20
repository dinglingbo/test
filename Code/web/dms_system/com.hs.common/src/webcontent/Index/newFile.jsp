<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
    <%@include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-08-15 16:18:18
  - Description:
-->
<head>
<title>Title</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%=webPath + contextPath%>/common/js/count.js?v=1.0.3"></script>



</head>
<body>

<div id="wrap">
<section>
<spen  id="aa"></spen>
<h1 class="jumbo" id="myTargetElement2"></h1>
<h1 class="jumbo" id="myTargetElement3"></h1>
</section>
</div>
<script type="text/javascript">
	var options = {
  useEasing : true, 
  useGrouping : true, 
  separator : ',', 
  decimal : '.', 
  prefix : '', 
  suffix : '' 
};
var demo = new CountUp("aa", 0, 1890, 0, 2.5, options);
var demo2 = new CountUp("myTargetElement2", 0, 15894, 0, 2.5, options);
var demo3 = new CountUp("myTargetElement3", 0, 385, 0, 2.5, options);
		demo.start();
		demo2.start();
		demo3.start();			
</script>
</body>
</html>