<%@page pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
<head>
<title>Title</title>
</head>
<body>
<form action="com.primeton.workflow.manager.instance.queryWorkItemListByActivityInstID.flow" name="form1" target="_self" method="post">
     <input type="hidden" name="_eosFlowAction" value="queryWithoutPage">
     <h:hidden name="activityInstID" property="activityInstID"/>
     <h:hidden name="processInstID" property="processInstID"/>
</form>
</body>
<script language="JavaScript">
	var activityInstID = parent.activityInstForm.currentActivityInstID.value;
	var processInstID = parent.activityInstForm.processInstID.value;
	document.forms['form1'].activityInstID.value = activityInstID;
	document.forms['form1'].processInstID.value = processInstID;			
	alert("<b:message key="error_workitem_jsp.operation_fail"/>");//操作失败！
	form1.submit();
</script>
</html>