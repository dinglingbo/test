<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_composer/common/common_composer.jsp" %>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2009-07-28 20:32:46
  - Description:
-->
<head>
<title>Title</title>
<script>
	var ret = new Array(2);
	function closePage(){
		ret[0]="Y";
		ret[1]="<b:write property="optTypeName"/>";
        window['returnValue'] = ret;
        window.close();
	}
</script>
</head>
<body onload="closePage();">
</body>
</html>