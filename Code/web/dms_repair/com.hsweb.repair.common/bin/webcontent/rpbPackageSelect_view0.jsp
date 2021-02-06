<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-03-26 18:54:47
  - Description:
-->
<head>
<title>本店套餐</title>
<script src="<%= request.getContextPath() %>/commonRepair/js/rpbPackageSelect.js?v=1.0.0"></script>
<style type="text/css">
html,body {
	margin: 0;
	padding: 0;
	border: 0;
	width: 100%;
	height: 100%;
	overflow: hidden;
}

table {
	font-size: 12px;
}

.form_label {
	width: 72px;
	text-align: right;
}

.required {
	color: red;
}
</style>
</head>
<body>


	<form id="form1" action="com.hsweb.repair.common.rpbPackageSelect.flow"
		method="post">
		<h:hidden name="_eosFlowKey" property="_eosFlowKey"></h:hidden>


		<table cellPadding="0" style="width: 80%" class="pg_result"
			align="left" cellSpacing="1" border="1">
			<tr bgcolor="#99FFFF">
				<td colspan="4" align="center">???????????</td>
			</tr>
			<tr bgcolor="#CCCCFF">
				<td style="width: 10%">???????</td>
				<td style="width: 10%">???????</td>
				<td style="width: 10%">????????</td>
				<td style="width: 25%">?????</td>
			</tr>


		</table>
		<input id="action" type="hidden" name="_eosFlowAction" value="action1">

		<script type="text/javascript">
			function selectAction(action) {
				document.getElementById("action").value = action;
				document.getElementById("form1").submit();
			}
		</script>

		<input type="button" align="left" value="??"
			onclick="selectAction('action1');">
	</form>




</body>
</html>
