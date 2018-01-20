<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_composer/common/common_composer.jsp" %>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2009-08-07 16:03:28
  - Description:
-->
<head>
<title><b:message key="bizresource_putin_detail_jsp.res_detail"/></title><!-- 资源明细信息 -->
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%" height="100%">
	<tr>
		<td class="workarea_title" valign="middle"><h3><b:message key="bizresource_putin_detail_jsp.biz_res_desc"/></h3></td><!-- 业务资源描述 -->
  	</tr>
  	<tr valign="top"> 
    	<td width="100%">
			&nbsp;<b:write property="resDesc" />
		</td>
	</tr>
</table>
</body>
</html>