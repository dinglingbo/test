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
	function go2page(){
		location.href = "<b:write property="toPageUrl"/>";
	}
</script>
</head>
<body>
<b:write property="ret/name"/>
<input id="btnBack" name="btnBack" type="button" value='<b:message kry="permission_common.btn_back"/>' onclick="go2page()">
</body>
</html>