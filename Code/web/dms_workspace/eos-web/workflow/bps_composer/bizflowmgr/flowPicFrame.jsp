<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_composer/common/common_composer.jsp" %>
<%@ taglib uri="http://eos.primeton.com/tags/workflow/base" prefix="wfBase"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2009-10-26 14:25:59
  - Description:
-->
<head>
<title>flowPicFrame</title>
</head>
<body>
<l:equal property="isShow" targetValue="Y">
	<wfBase:tempProcessGraph processID="@processDefID"/>
</l:equal>
<l:equal property="isShow" targetValue="N">
	<b:message key="permission_common.no_diagram"/>
</l:equal>
</body>
</html>