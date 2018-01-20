<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file = "/workflow/wfmanager/common/common.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String bizCatalog = ResourcesMessageUtil.getI18nResourceMessage("left_jsp.biz_process");
 %>
<html>
<head>
<title><b:message key="left_jsp.process_instance_mgr"/></title>
<script>
	function initParam(node) {
		var id = node.getProperty('catalogUUID') ;
		return "<catalogUUID>"+id+"</catalogUUID>";
	}
	function initParam2(node) {
		var name = node.getProperty('processDefName') ;
		return "<processDefName>"+name+"</processDefName>";
	}
	
	
	function showProcessInstanceQuery(node){
		try{
			obj('pkgId').value=node.getProperty("packageID");
			obj('processDefName').value=node.getProperty("processDefName");
	
			obj('versionSign').value=node.getProperty("versionSign");
			obj('currentFlag').value=node.getProperty("currentFlag");
			obj('currentState').value=node.getProperty("currentState");
			obj('queryCondition/_expr[1]/processDefID').value=node.getProperty("processDefID");
			
			obj('queryCondition/_and[1]/_or[1]/_expr[1]/catalogUUID').value='';
			
			document.forms['processTree'].action="com.primeton.workflow.manager.instance.navigation.flow?_eosFlowAction=queryProcessInstByProcessDefID";
			submitForm('processTree');
		}catch(e){
			alert(e);
		}
	}
	
	function showAllProcessInstance(node) {
		try{
			document.forms['processTree'].action="<%=request.getContextPath()%>/workflow/wfmanager/instance/processinst_frame.jsp";
			submitForm('processTree');
		}catch(e){
			alert(e);
		}
	}
	
	function showProcessInstanceByCatalogID(node) {
		try{
			obj('queryCondition/_and[1]/_or[1]/_expr[1]/catalogUUID').value=node.getProperty("catalogUUID");
			
			obj('queryCondition/_expr[1]/processDefID').value='';
			
			document.forms['processTree'].action="com.primeton.workflow.manager.instance.navigation.flow?_eosFlowAction=queryProcessInstByProcessDefID";
			submitForm('processTree');
		}catch(e){
			alert(e);
		}
	}
	
	function refreshNode() {
		pNode = $id('tree').cur_node ;
		if (!pNode) return ;
		pNode.reloadChild(refreshTree);
	}
	
	function refreshTree(pNode) {
		if(!pNode) return ;
		if (pNode.hasChild) {
			return ;
		} else {
			pNode = pNode.getParent();
			if(pNode == null || !pNode)
			return;
			if(pNode.isRootNode()) pNode.reloadChild();
			else
			pNode.reloadChild(refreshTree);
		}
	}
	
	function createLink(node) {
		versionName = node.getProperty("versionSign");
		state = node.getProperty("currentState");
		if(state == "3") {
			versionName+="*" ;
		}
		node.setText(versionName);
	}
	
	function dealScroll(){
 		if (document.compatMode == "BackCompat") {
			treeHeight = document.body.clientHeight;
			}
			else {
			treeHeight = document.documentElement.clientHeight;
		} 
		if (isIE7 || isIE8) { 
 			treeHeight -= 30;
 		}
 		else if (isIE9) { 
 			treeHeight -= 35;
 		}
 		else {
 			treeHeight = treeHeight - 100;
 		}
 		
		$id("treediv").style.height = treeHeight;
	}
	
	window.onload = function(){
		dealScroll();
	}
	
	window.onresize = function(){
		dealScroll();
	}
</script>
</head>

<body style="background:#EAF0F1;margin-top:0px;margin-left:0px;margin-right: 0px;margin-buttom:0px;width: 100%;height: 100%;">
<form name="processTree" action="com.primeton.workflow.manager.getProcessPackages.flow" method="post" target="middle">
<table cellpadding="0" cellspacing="0"  bgcolor="#EEF3F6" style="width: 100%; table-layout:fixed;">
	<tr>
		<td class="tree_head"><h2><b:message key="left_jsp.process_instance_mgr"/></h2></td>
	</tr>
	<tr id="tr1">
		<td valign="top" style="border-left:1px solid #7ACBFF; border-right:1px solid #7ACBFF;">
			<div id="treediv"  style="width:100%;height:100%;overflow:auto;overflow-x:auto;overflow-y: auto;float: left; ">
			<nobr>
				<r:rtree hasRoot="true" id="tree" expandLevel="2">
					<r:treeRoot display="<%=bizCatalog %>" action="com.primeton.workflow.manager.def.processdef.getFixedCatalogRoot.biz" childEntities="fixedCatalogList" onDblclickFunc="refreshNode" onClickFunc="showAllProcessInstance"/>
					<r:treeNode action="com.primeton.workflow.manager.def.processdef.getSecondCatalogOrProcess.biz" initParamFunc="initParam" submitXpath="querySub" showField="catalogName" nodeType="fixedCatalogList" childEntities="catalogRootList;processDefList" onDblclickFunc="refreshNode" onClickFunc="showProcessInstanceByCatalogID"/>
					<r:treeNode action="com.primeton.workflow.manager.def.processdef.getSubCatalogAndProcess.biz" initParamFunc="initParam" submitXpath="querySub" showField="catalogName" nodeType="catalogRootList" childEntities="catalogSubList;processDefList" onDblclickFunc="refreshNode" onClickFunc="showProcessInstanceByCatalogID"/>
					<r:treeNode action="com.primeton.workflow.manager.def.processdef.getSubCatalogAndProcess.biz" initParamFunc="initParam" submitXpath="querySub" showField="catalogName" nodeType="catalogSubList" childEntities="catalogSubList;processDefList" onDblclickFunc="refreshNode" onClickFunc="showProcessInstanceByCatalogID"/>
					<r:treeNode action="com.primeton.workflow.manager.def.processdef.getProcessVersions.biz" initParamFunc="initParam2" showField="processDefName" nodeType="processDefList" childEntities="processVersionList" onDblclickFunc="refreshNode" icon="/workflow/wfmanager/images/processdef.gif"/>
					<r:treeNode showField="versionSign" nodeType="processVersionList" onClickFunc="showProcessInstanceQuery" onRefreshFunc="createLink" icon="/workflow/wfmanager/images/version.gif"/>
				</r:rtree>
			</nobr>
			</div>
		</td>
	</tr>
</table>
<input type="hidden" name="pkgId" id="pkgId">
<input type="hidden" name="processDefName" id="processDefName">
<input type="hidden" name="versionSign" id="versionSign">
<input type="hidden" name="currentFlag" id="currentFlag">
<input type="hidden" name="currentState" id="currentState">

<input type="hidden" name="queryCondition/_entity" id="queryCondition/_entity" value="com.eos.workflow.data.WFProcessInst" >
<input type="hidden" name="queryCondition/_expr[1]/processDefID" id="queryCondition/_expr[1]/processDefID">
<input type="hidden" name="queryCondition/_and[1]/_or[1]/_expr[1]/catalogUUID" id="queryCondition/_and[1]/_or[1]/_expr[1]/catalogUUID">
<input type="hidden" name="pageCond/begin" value="0">
<input type="hidden" name="pageCond/length" value="10">
<input type="hidden" name="pageCond/isCount" value="true">
</form>
</body>
</html>
