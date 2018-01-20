<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/bps/wfclient/common/common.jsp"%>
<%@page import="com.primeton.bps.web.control.I18nUtil"%>
<html>
<head>
<title>My Process</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body style="margin:0;width: 98%; height:100%;overflow-x:hidden">	
	<div id ="tabs" class="nui-tabs" width="100%" height="100%">
		<div title="<%=I18nUtil.getMessage(request, "bps.wfclient.common.PendingProcess") %>" url="<%=request.getContextPath() %>/bps/wfclient/process/myProcess.jsp?queryType=backlog">
		</div>
		<div title="<%=I18nUtil.getMessage(request, "bps.wfclient.common.HandleProcess") %>" url="<%=request.getContextPath() %>/bps/wfclient/process/myProcess.jsp?queryType=complete">
		</div>
		<div title="<%=I18nUtil.getMessage(request, "bps.wfclient.common.FinishedProcess") %>" url="<%=request.getContextPath() %>/bps/wfclient/process/myProcess.jsp?queryType=finish">
		</div>
	</div>
	
<script type="text/javascript">	
	nui.parse();
</script>
</body>
</html>