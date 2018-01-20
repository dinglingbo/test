<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/bps/wfclient/common/common.jsp"%>
<%@page import="com.primeton.bps.web.control.I18nUtil"%>
<html>
<head>
<title>My Task</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body style="margin:0;width: 98%; height:100%;overflow-x:hidden">
	<div id ="tabs" class="nui-tabs" width="100%" height="100%">
		<div title="<%=I18nUtil.getMessage(request, "bps.wfclient.common.PendingTask") %>" url="<%=request.getContextPath() %>/bps/wfclient/task/taskList.jsp?taskType=self">
		</div>
		<div title="<%=I18nUtil.getMessage(request, "bps.wfclient.common.FinishedTask") %>" url="<%=request.getContextPath() %>/bps/wfclient/task/taskList.jsp?taskType=finishedSelf">
		</div>
		<div title="<%=I18nUtil.getMessage(request, "bps.wfclient.common.EntrustedTask") %>" url="<%=request.getContextPath() %>/bps/wfclient/task/taskList.jsp?taskType=entrust">
		</div>
		<div title="<%=I18nUtil.getMessage(request, "bps.wfclient.common.Entr-FinishedTask") %>" url="<%=request.getContextPath() %>/bps/wfclient/task/taskList.jsp?taskType=finishedEntrust">
		</div>
		<div title="<%=I18nUtil.getMessage(request, "bps.wfclient.common.UnReadNotice") %>" url="<%=request.getContextPath() %>/bps/wfclient/task/notificationList.jsp?state=UNVIEWED">
		</div>
		<div title="<%=I18nUtil.getMessage(request, "bps.wfclient.common.ReadedNotice") %>" url="<%=request.getContextPath() %>/bps/wfclient/task/notificationList.jsp?state=VIEWED">
		</div>
	</div>
	
<script type="text/javascript">	
	nui.parse();
</script>
</body>
</html>