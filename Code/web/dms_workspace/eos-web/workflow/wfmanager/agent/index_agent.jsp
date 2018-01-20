<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/workflow/wfmanager/common/common.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String agentMgr = ResourcesMessageUtil.getI18nResourceMessage("index_agent_jsp.agent_manage");
String agentScope = ResourcesMessageUtil.getI18nResourceMessage("index_agent_jsp.agent_scope");
 %>
<html>
	<head>
		<title>Title</title>
	</head>
	<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0">
		<w:tabPanel id="agentPanel" defaultTab="agent"    width="100%" height="100%">
			<w:tabPage id="agent"      title="<%=agentMgr %>"       tabType="iframe" url="com.primeton.workflow.manager.agent.queryAgent.flow?_eosFlowAction=initial"></w:tabPage><%-- 代理管理 --%>
			<w:tabPage id="agentscope" title="<%=agentScope %>" tabType="iframe" url="/workflow/wfmanager/agent/agentscopeframe.jsp"></w:tabPage><%-- 代理人范围 --%>
		</w:tabPanel>
    </body>
</html>