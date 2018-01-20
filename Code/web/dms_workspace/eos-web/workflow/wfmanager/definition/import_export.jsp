<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/workflow/wfmanager/definition/head.jsp" %>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String importPar = ResourcesMessageUtil.getI18nResourceMessage("import_export_jsp.import_par");
String importARIS = ResourcesMessageUtil.getI18nResourceMessage("import_export_jsp.import_aris");
String exportPar = ResourcesMessageUtil.getI18nResourceMessage("import_export_jsp.export_par");
%>

<w:tabPanel id="port_pane" width="100%" height="100%" defaultTab="importECD">
	<w:tabPage id="importECD" title="<%=importPar%>" tabType="iframe" allowSelect="true" url="com.primeton.workflow.manager.def.deployContribution.flow">
    	<h:param name="_eosFlowAction" value="chooseFile"></h:param>
    	<h:param name="catalogUUID" value=""></h:param>
	</w:tabPage>
	<w:tabPage id="importARIS" title="<%=importARIS%>" tabType="iframe" allowSelect="true" url="com.primeton.workflow.manager.def.deployAris.flow">
    	<h:param name="_eosFlowAction" value="chooseFile"></h:param>
    	<h:param name="catalogUUID" value=""></h:param>
	</w:tabPage>
	<w:tabPage  id="exportECD" title="<%=exportPar%>" tabType="iframe" url="com.primeton.workflow.manager.def.exportProcess.flow">
    	<h:param name="_eosFlowAction" value="selectProcess"></h:param>
    	<h:param name="catalogUUID" value=""></h:param>
	</w:tabPage>
</w:tabPanel> 
<%@include file="/workflow/wfmanager/definition/tail.jsp" %>