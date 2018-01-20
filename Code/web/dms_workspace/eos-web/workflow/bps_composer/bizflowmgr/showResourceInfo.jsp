<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_composer/common/common_composer.jsp" %>
<html>
<!-- 
  - Author(s): bps
  - Date: 2009-08-07 16:46:40
  - Description:
-->
<head>
<title>Title</title>
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%" height="100%">
	<tr>
		<td class="workarea_title" valign="middle"><h3>[<b:write property="resouceName"/>]&nbsp;<b:message key="reference_jsp.res_desc"/></h3></td>
  	</tr>
  	<tr valign="top"> 
    	<td width="100%">
			&nbsp;<b:write property="resouceDesc" />
		</td>
	</tr>
</table>
</body>
</html>