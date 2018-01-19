<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
<head>
	<title></title>
	<script>
	</script>
</head>
<body style="background:#FFFFFF;margin-top:0px;margin-left:0px;margin-buttom:0px;background:url(<%=request.getContextPath()%>/workflow/wfmanager/images/MainFrameBg.gif) no-repeat;overflow:auto;">
<table border="0" cellpadding="1" cellspacing="0" class="workarea" width="100%" height="100%">
<tr>
	<td class="workarea_title" valign="middle"><h3><b:message key="deploy_result2_jsp.import_result"/></h3></td>
</tr>
<tr>
<td>
	<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%" height="100%">
	<tr>
	  <td>
		<table border="0" class="EOS_panel_body" width="100%" height="100%">
			 <tr> 
				<td width="100%" height="100%" valign="top">
					<table border="0" class="EOS_table" width="100%">
						<l:equal property="success" targetValue="0" ignoreCase="true">
						<tr class="EOS_table_row">
							<td class="form_label" width="150"><b:message key="deploy_result2_jsp.is_success"/></td>
							<td><b:message key="deploy_result2_jsp.yes"/></td>
						</tr>
						</l:equal>
						<l:equal property="success" targetValue="1" ignoreCase="true">
						<tr class="EOS_table_row">
							<td class="form_label" width="150"><b:message key="deploy_result2_jsp.is_success"/></td>
							<td style="color: red;"><b:message key="deploy_result2_jsp.no"/></td>
						</tr>
						<tr class="EOS_table_row">
							<td class="form_label" width="150"><b:message key="deploy_result2_jsp.failure_cause"/></td>
							<td style="color: red;"><b:message key="deploy_result2_jsp.failure_cause1"/></td>
						</tr>
						</l:equal>
						<l:equal property="success" targetValue="2" ignoreCase="true">
						<tr class="EOS_table_row">
							<td class="form_label" width="150"><b:message key="deploy_result2_jsp.is_success"/></td>
							<td style="color: red;"><b:message key="deploy_result2_jsp.no"/></td>
						</tr>
						<tr class="EOS_table_row">
							<td class="form_label" width="150"><b:message key="deploy_result2_jsp.failure_cause"/></td>
							<td style="color: red;"><b:message key="deploy_result2_jsp.failure_cause2"/></td>
						</tr>
						<tr class="EOS_table_row">
							<td class="form_label" width="150">失败的流程</td>
							<td style="color: red;"><b:write property="errorFlow"/></td>
						</tr>
						</l:equal>
						<l:equal property="success" targetValue="3" ignoreCase="true">
						<tr class="EOS_table_row">
							<td class="form_label" width="150"><b:message key="deploy_result2_jsp.is_success"/></td>
							<td style="color: red;"><b:message key="deploy_result2_jsp.no"/></td>
						</tr>
						<tr class="EOS_table_row">
							<td class="form_label" width="150"><b:message key="deploy_result2_jsp.failure_cause"/></td>
							<td style="color: red;"><b:message key="deploy_result2_jsp.failure_cause3"/></td>
						</tr>
						</l:equal>
					</table>
            	</td>
			</tr>
		</table>
</td></tr>
</table>
</body>
</html>	