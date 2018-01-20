<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String setDelegate = ResourcesMessageUtil.getI18nResourceMessage("delegate_mgr_jsp.set_delegate");
String queryDelegate = ResourcesMessageUtil.getI18nResourceMessage("delegate_mgr_jsp.query_delegate");
 %>
<html>
<head>
<title>Title</title>
</head>
<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0">
	<w:tabPanel id="myTabPanel" width="100%" height="100%">
		<w:tabPage id="setDeleg" title="<%=setDelegate %>" tabType="iframe" url="delegate_set.jsp"></w:tabPage><%-- 设置代办 --%>
		<w:tabPage id="queryDeleg" title="<%=queryDelegate %>" tabType="iframe" url="delegate_query.jsp"></w:tabPage><%-- 查询代办 --%>
	</w:tabPanel>
</body>
</html>