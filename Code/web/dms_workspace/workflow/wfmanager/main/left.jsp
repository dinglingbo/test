<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String bizprocess = ResourcesMessageUtil.getI18nResourceMessage("left_jsp.biz_process");
 %>
<html>
<head>
<title></title>
<style type="text/css">
<!--
.left_tree {
	background:#EEF3F6;
	display:inline;
	border-top-width: 1px;
	border-right-width: 1px;
	border-bottom-width: 1px;
	border-left-width: 1px;
	border-top-style: none;
	border-right-style: none;
	border-bottom-style: none;
	border-left-style: none;
	border-top-color: #75B5C3;
	border-right-color: #75B5C3;
	border-bottom-color: #75B5C3;
	border-left-color: #75B5C3;
}
-->
</style>
<script>

	function initParam(node) {
		var id = node.getProperty('catalogUUID') ;
		return "<catalogUUID>"+id+"</catalogUUID>";
	}
	function initParam2(node) {
		var name = node.getProperty('processDefName') ;
		return "<processDefName>"+name+"</processDefName>";
	}
	
	function showProcessDefs(node) {
		parent.frames["middle"].window.location.href = 'com.primeton.workflow.manager.def.getProcessByCatalogID.flow?catalogUUID='+node.getProperty("catalogUUID")+'&directFlag='+node.getProperty("directFlag");
	}
	
	function showProcessVersions(node) {
		parent.frames["middle"].window.location.href = 'com.primeton.workflow.manager.def.getAllProcessVersions.flow?processDefName='+node.getProperty("processDefName");
	}
	
	function showProcessCatalogs(node){
		parent.frames["middle"].window.location.href = 'com.primeton.workflow.manager.def.getProcessCatalogsWithCount.flow';
	}
	
	function createLink (node) {
		versionName = node.getProperty("versionSign");
		state = node.getProperty("currentState");
		if(state == "3") {
			versionName+="*" ;
		}
		node.setText(versionName) ;
	}
	
	function showProcessDetail(node) {
		parent.frames["middle"].window.location.href = '<%=request.getContextPath()%>/workflow/wfmanager/definition/processdef_detail/process_diagram.jsp?id='+node.getProperty("processDefID")+'&pname='+node.getProperty("processDefName")+'&state='+node.getProperty("currentState")+'&pkgId='+node.getProperty("packageID")+'&state='+node.getProperty("currentState")+'&pkgName='+node.getProperty("packageName")+'&version='+node.getProperty("versionSign");
	}
	
	
	function refreshTreeRoot() {
		pNode = $id('tree').getRootNode();
		if (!pNode) return ;
		pNode.reloadChild(refreshTree);
	}
	
 	function refreshNode() {
		pNode = $id('tree').cur_node ;
		if (!pNode) return ;
		pNode.selected();
		pNode.reloadChild(refreshTree);
	}
	
	function pauseFresh(){
		Pause(this,1000);//调用暂停函数
		this.NextStep = function() {
			refreshNode();
		}
	}
	
	function refreshParentNode() {
		pNode = $id('tree').cur_node.getParent() ;
		if (!pNode) return ;
		pNode.selected();
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
<form name="processTree" action="com.primeton.workflow.manager.def.getProcessCatalogs.flow" method="post" target="middle">
<table cellpadding="0" cellspacing="0"  bgcolor="#EEF3F6" style="width: 100%; height: 100%; table-layout: fixed;">
	<tr>
		<td class="tree_head"><h2><b:message key="left_jsp.process_mgr"/></h2></td><!-- 业务流程管理 -->
	</tr>
	<tr id="tr1">
		<td valign="top" style="border-left:1px solid #7ACBFF; border-right:1px solid #7ACBFF;">
			<div id="treediv" style="width: 100%; height: 100%; overflow:auto; overflow-x:auto; overflow-y: auto; float: left; ">
			<nobr>
				 <r:rtree hasRoot="true" id="tree" expandLevel="2">
					<r:treeRoot display="<%=bizprocess %>" action="com.primeton.workflow.manager.def.processdef.getFixedCatalogRoot.biz" childEntities="fixedCatalogList" onClickFunc="showProcessCatalogs" onDblclickFunc="refreshNode"/> <%-- 业务流程 --%>
					<r:treeNode action="com.primeton.workflow.manager.def.processdef.getSecondCatalogOrProcess.biz" initParamFunc="initParam" submitXpath="querySub" showField="catalogName" nodeType="fixedCatalogList" childEntities="catalogRootList;processDefList" onClickFunc="showProcessDefs" onDblclickFunc="refreshNode" />
					<r:treeNode action="com.primeton.workflow.manager.def.processdef.getSubCatalogAndProcess.biz" initParamFunc="initParam" submitXpath="querySub" showField="catalogName" nodeType="catalogRootList" childEntities="catalogSubList;processDefList" onClickFunc="showProcessDefs" onDblclickFunc="refreshNode" />
					<r:treeNode action="com.primeton.workflow.manager.def.processdef.getSubCatalogAndProcess.biz" initParamFunc="initParam" submitXpath="querySub" showField="catalogName" nodeType="catalogSubList" childEntities="catalogSubList;processDefList" onClickFunc="showProcessDefs" onDblclickFunc="refreshNode"/>
					<r:treeNode action="com.primeton.workflow.manager.def.processdef.getProcessVersions.biz" initParamFunc="initParam2" showField="processDefName" nodeType="processDefList" childEntities="processVersionList" onClickFunc="showProcessVersions" onDblclickFunc="refreshNode" icon="/workflow/wfmanager/images/processdef.gif"/>
					<r:treeNode showField="versionSign" nodeType="processVersionList" onClickFunc="showProcessDetail" onRefreshFunc="createLink" icon="/workflow/wfmanager/images/version.gif"/>
				 </r:rtree>
			</nobr>
			</div>
		</td>
	</tr>
</table>
</form>
</body>
</html>
