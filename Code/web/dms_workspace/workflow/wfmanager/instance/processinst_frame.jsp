<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file = "/workflow/wfmanager/common/common.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String processInstanceInfo = ResourcesMessageUtil.getI18nResourceMessage("processinst_frame_jsp.process_instance_info");
 %>
<b:set name="title1" value="<%=processInstanceInfo %>"/>
<%@ include file="/workflow/wfmanager/instance/head.jsp"%>
<l:present property="queryCondition">
	<l:present property="queryCondition/_expr[1]/processDefID">
		<iframe id="processInstFrame" name="processInstFrame" width="100%" marginHeight="0" 
				frameBorder="0" marginWidth="0"  
				src="com.primeton.workflow.manager.instance.navigation.flow?_eosFlowAction=queryWithProcessInstCriteria&queryCondition/_expr[1]/processDefID=<b:write property="queryCondition/_expr[1]/processDefID"/>" 
				frameborder="0" scrolling="auto"></iframe>
	</l:present>
	<l:present property="queryCondition/_and[1]/_or[1]/_expr[1]/catalogUUID">
		<iframe id="processInstFrame" name="processInstFrame" width="100%" marginHeight="0" 
				frameBorder="0" marginWidth="0"  
				src="com.primeton.workflow.manager.instance.navigation.flow?_eosFlowAction=queryWithProcessInstCriteria&queryCondition/_and[1]/_or[1]/_expr[1]/catalogUUID=<b:write property="queryCondition/_and[1]/_or[1]/_expr[1]/catalogUUID"/>" 
				frameborder="0" scrolling="auto"></iframe>
	</l:present>
</l:present>
<l:notPresent property="queryCondition">
	<iframe id="processInstFrame" name="processInstFrame" width="100%" marginHeight="0"
			scrolling="auto" frameBorder="0" marginWidth="0" src="com.primeton.workflow.manager.instance.navigation.flow?_eosFlowAction=queryWithProcessInstCriteria" ></iframe>
</l:notPresent>
<form name="hiddenForm" id="hiddenForm" action="" method="post">
</form>
<%@ include file="/workflow/wfmanager/common/tail.jsp"%>