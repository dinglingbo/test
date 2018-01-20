<%@page pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
<head>
<title>Title</title>
</head>
<body>
<form action="com.primeton.workflow.manager.handover.queryHandoverInfo.flow" name="form1" target="_self" method="post">
     <input type="hidden" name="_eosFlowAction" value="action1">
     <h:hidden name="from" property="from"/>
     <h:hidden name="to" property="oTo"/>
     <h:hidden name="fromName" property="fromName"/>
     <h:hidden name="toName" property="oToName"/>
</form>
</body>
<script language="JavaScript">
	alert("<b:message key="success_process_jsp.operation_success"/>");//操作成功！
	form1.submit();
</script>
</html>