<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String procInstDiag = ResourcesMessageUtil.getI18nResourceMessage("process_inst_diagram_jsp.process_inst_diagram");
String actiInstInfo = ResourcesMessageUtil.getI18nResourceMessage("process_inst_diagram_jsp.activity_inst_info");
String workItemInfo = ResourcesMessageUtil.getI18nResourceMessage("process_inst_diagram_jsp.work_item_info");
 %>
<html>
<head>
<%@include file="/workflow/wfmanager/instance/common.jsp" %>
</head>
<body>
<w:tabPanel id="instance_pane" defaultTab="instance_graph" width="100%" height="100%">
	<w:tabPage  id="instance_graph" title="<%=procInstDiag %>" tabType="iframe" url="com.primeton.workflow.manager.instance.navigation.flow"><%-- 流程实例图 --%>
    	
    	<h:param name="_eosFlowAction" value="graphIFrameAction"></h:param>
    	<l:present property="sourceFlag">
			<h:param name="sourceFlag" property="sourceFlag"></h:param>
		</l:present>
    	<l:present property="processInstID">
			<h:param name="processInstID" property="processInstID"></h:param>
		</l:present>
		<l:present property="processDefID">
			<h:param name="processDefID" property="processDefID"></h:param>
		</l:present>
		<l:present property="queryCondition/_expr[1]/processDefID">
			<h:param name="queryCondition/_expr[1]/processDefID" property="queryCondition/_expr[1]/processDefID"></h:param>
	    </l:present>
	    <l:present property="queryCondition/_expr[2]/processInstID">
	   		<h:param name="queryCondition/_expr[2]/processInstID" property="queryCondition/_expr[2]/processInstID"></h:param>
	   	</l:present>
	    <l:present property="queryCondition/_expr[3]/processInstName">
	   		<h:param name="queryCondition/_expr[3]/processInstName" property="queryCondition/_expr[3]/processInstName"></h:param>
	    </l:present>
	    <l:present property="queryCondition/_expr[4]/currentState">
	    	<h:param name="queryCondition/_expr[4]/currentState" property="queryCondition/_expr[4]/currentState"></h:param>
	   	</l:present>
	   	<l:present property="queryCondition/_expr[5]/isTimeOut">
	    	<h:param name="queryCondition/_expr[5]/isTimeOut" property="queryCondition/_expr[5]/isTimeOut"></h:param>
	   	</l:present>
	    <l:present property="pageCond/begin">
	    	<h:param name="pageCond/begin" property="pageCond/begin"></h:param>
        </l:present>
        <l:present property="pageCond/length">
       		<h:param name="pageCond/length" property="pageCond/length"></h:param>
    	</l:present>
    	<l:present property="pageCond/isCount">
    		<h:param name="pageCond/isCount" property="pageCond/isCount"></h:param>
		</l:present>
	</w:tabPage>
	<w:tabPage  id="activityInstInfo" title="<%=actiInstInfo %>" tabType="iframe" url="com.primeton.workflow.manager.instance.getAllActivityInstList.flow"><%-- 活动实例信息 --%>
    	<h:param name="_eosFlowAction" value="firstQueryWithPage"></h:param>
		<l:present property="processInstID">
			<h:param name="processInstID" property="processInstID"></h:param>
		</l:present>
	</w:tabPage>
	<w:tabPage  id="workItemInfo" title="<%=workItemInfo %>" tabType="iframe" url="com.primeton.workflow.manager.instance.getAllWorkItemList.flow"><%-- 工作项信息 --%>
    	<h:param name="_eosFlowAction" value="firstQueryWithPage"></h:param>
    	<l:present property="processInstID">
			<h:param name="processInstID" property="processInstID"></h:param>
		</l:present>
	</w:tabPage>
</w:tabPanel>
</body>
</html>