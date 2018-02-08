<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-03 17:10:57
  - Description:
-->
<head>
<title>jsp auto create</title>
<script src="<%= request.getContextPath() %>/purchase/js/sellMgr/sellOutDetail.js?v=1.0.0"></script>
<style type="text/css">
.title {
	width: 60px;
	text-align: right;
}

.title.required {
	color: red;
}

</style>
</head>
<body>


	<form id="form1" action="com.hsweb.part.purchase.sellOutDetail.flow"
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
