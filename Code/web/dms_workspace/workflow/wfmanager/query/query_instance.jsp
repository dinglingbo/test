<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/workflow/wfmanager/query/head.jsp" %>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String proc_inst_query = ResourcesMessageUtil.getI18nResourceMessage("query_instance_jsp.proc_inst_query");
String work_item_query = ResourcesMessageUtil.getI18nResourceMessage("query_instance_jsp.work_item_query");
 %>
<w:tabPanel id="instance_pane" width="100%" height="100%" defaultTab="processInstQuery">
	<w:tabPage id="processInstQuery" title="<%=proc_inst_query %>" tabType="iframe" allowSelect="true"  url="com.primeton.workflow.manager.query.navigation.flow"><%-- 流程实例查询 --%>
    	<h:param name="_eosFlowAction" value="showProcInstQueryPage"></h:param>
	</w:tabPage>
	<w:tabPage  id="workItemQuery" title="<%=work_item_query %>" tabType="iframe" url="com.primeton.workflow.manager.query.navigation.flow"><%-- 工作项查询 --%>
    	<h:param name="_eosFlowAction" value="showWorkItemQueryPage"></h:param>
	</w:tabPage>
</w:tabPanel> 
<%@include file="/workflow/wfmanager/query/tail.jsp" %>    