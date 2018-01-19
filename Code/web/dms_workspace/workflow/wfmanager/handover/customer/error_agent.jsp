<%@page pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
<head>
<title>Title</title>
</head>
<body>
<form action="com.primeton.workflow.manager.handover.queryHandoverInfo.flow" name="form1" target="_self" method="post">
     <input type="hidden" name="_eosFlowAction" value="action0">
     <h:hidden name="from" property="from"/>
     <h:hidden name="toName" property="toName"/>
</form>
</body>
<script language="JavaScript">
	alert("<b:message key="error_process_jsp.operation_failed"/>");//操作失败！
	form1.submit();
</script>
</html>