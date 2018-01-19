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
	function closepage(){
		//window.close();
		window.location.href="com.primeton.bps.web.composer.participantcal.participantCalMgr.flow";
	}
</script>
</head>
<body>
<b:write property="ret/name"/>


<input type="button" value='<b:message key="permission_common.btn_close"/>' onclick="closepage()">
</body>
</html>