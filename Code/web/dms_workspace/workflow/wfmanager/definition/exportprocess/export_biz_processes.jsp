<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<h:script src="/workflow/wfmanager/definition/js/rtree-checkbox.js"></h:script>
<%@page import="com.primeton.bps.workspace.frame.common.WSContributionHelper"%>
<%
boolean hasBizComposer = WSContributionHelper.isProcComposerUseable();
request.setAttribute("hasBizComposer", Boolean.valueOf(hasBizComposer));
%>
<html>
<head>
<title><b:message key="export_biz_processes_jsp.export_biz_proc"/></title>
<script>
	var hasBizComposer ='<b:write property="hasBizComposer"/>';
	
	//下一步
	function nextStep(){
		$id("_eosFlowAction").value = "selectBizRes";
		form1.action = "com.primeton.workflow.manager.def.exportProcess.flow";		
		createSubmitRTreeHiddenData($id("processTree"), "BIZCATALOG", "bizcatalogs");
		createSubmitRTreeHiddenData($id("processTree"), "PROCESS", "processs");
		form1.submit();
	}
	
	//完成导出
	function finishExport() {
		if (getSelectedNodeList($id("processTree"), "").length == 0) {
			//请至少选择一个业务目录或者流程！
			alert('<b:message key="export_biz_processes_jsp.export_tip1"/>');
			return;
		}
		
		$id("_eosFlowAction").value = "finishExport1";
		form1.action = "com.primeton.workflow.manager.def.exportProcess.flow";
		createSubmitRTreeHiddenData($id("processTree"), "BIZCATALOG", "bizcatalogs");
		createSubmitRTreeHiddenData($id("processTree"), "PROCESS", "processs");
		form1.submit();
	}
	
	//取消导出
	function cancelExport(){
		parent.frames["middle"].window.location.href = 'com.primeton.workflow.manager.def.getProcessByCatalogID.flow?catalogUUID='+$id("catalogUUID").value;
	}
	
	function showProcessDefs(node) {		
		if (!node.childLoaded) {
			node.expandNode(displayPlistpage);
		}else {
			displayPlistpage(node);
		}
		node.selected();
	}
	
	function displayPlistpage(node) {
		//var directFlag = node.getProperty("directFlag");
		var directFlag = "Y";
		var catalogUUID = node.getProperty('catalogUUID');
		var selectedProcessDefs = ",";
		if (directFlag == "Y" || directFlag == null) {
			var childrenNode = node.getChildren();
			for (var i = 0; i < childrenNode.length; i++) {
				if (isNodeSelectedState(childrenNode[i])) {
					selectedProcessDefs += childrenNode[i].getProperty("processDefName") + ",";	
				}
			}
			
			var url = "com.primeton.workflow.manager.def.exportProcess.flow?_eosFlowAction=listProcess&catalogUUID="+catalogUUID + "&selectedProcessDefs="+selectedProcessDefs;
			$name("plist").src = url;
		}
		else {
			var url = "com.primeton.workflow.manager.def.exportProcess.flow?_eosFlowAction=noProcess&catalogUUID="+catalogUUID + "&selectedProcessDefs="+selectedProcessDefs;
			$name("plist").src = url;
		}
	}
	
	function checkAllProcessDef(node) {
		var catalogUUID = node.getProperty("catalogUUID");
		if(isNodeSelectedState(node)) {
			plist.window.selectAllProcess(catalogUUID);
		} else {
			plist.window.disSelectAllProcess(catalogUUID);
		}
	}
	
	function checkProcessDef(node) {
		var prcId = node.getProperty("processDefName");
		if(isNodeSelectedState(node)) {
			plist.window.selectProcess(prcId);
		}
		else {
			plist.window.disSelectProcess(prcId);
		}
	}
	
	window.onload=function (){
		$id("plist").style.height = $id("tr1").offsetHeight;
		$id("treediv").style.height = $id("tr1").offsetHeight;
		linkBizResource();
	}
	
	function linkBizResource() {
		if (hasBizComposer == "true") {
			//var obj = $id("linkBizResourceCheckboxID");
			//if (obj.checked) {
			//	$id("nextbuttonID").disabled = true;
			//	$id("finishbuttonID").disabled = false;
			//} else {
				$id("nextbuttonID").disabled = false;
				$id("finishbuttonID").disabled = false;
			//}
		}
		else {
			$id("linkBizResourceCheckboxDiv").style.display = "none";
			$id("nextbuttonID").style.display = "none";
		}
	}
	
	function selectProcessNode(catalogUUID, prcId) {
		var node = findTreeNode($id('processTree'), "BIZCATALOG", "catalogUUID", catalogUUID);
		var children = node.getChildren();
		for(i=0; i<children.length; i++) {
			var id = children[i].getProperty("processDefName");
			if (id == prcId) {
				switchState(children[i], STREE_CHECKBOX_TRUE_ICON);
				break;
			}
		}
		node.selected();
	}
	
	function disSelectProcessNode(catalogUUID, prcId) {
		var node = findTreeNode($id('processTree'), "BIZCATALOG", "catalogUUID", catalogUUID);
		var children = node.getChildren();
		for(i=0; i<children.length; i++) {
			var id = children[i].getProperty("processDefName");
			if (id == prcId) {
				switchState(children[i], STREE_CHECKBOX_FALSE_ICON);
				break;
			}
		}
		node.selected();
	}
	
	function initParam(node) {
		var id = node.getProperty('catalogUUID') ;
		return "<catalogUUID>"+id+"</catalogUUID>";
	}
	
	function renderCatalogNode(node) {
		renderCheckboxNode(node, "BIZCATALOG", node.getProperty("catalogName"), "switchPlistPageState");
	}
	
	function renderProcessNode(node) {
		renderCheckboxNode(node, "PROCESS", node.getProperty("processDefName"), "switchPlistPageState");
	}
	
	function switchPlistPageState() {
		var pNode = $id('processTree').cur_node;		
		if ("BIZCATALOG" == getNodeType(pNode)) {
			checkAllProcessDef(pNode);
		} else if("PROCESS" == getNodeType(pNode)) {
			checkProcessDef(pNode);
		}
	}
	
	/*
 	function refreshNode() {
		var pNode = $id('processTree').cur_node ;
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
	*/
	
	function initiFrame(){
		var height = $id('exp').offsetHeight;
		if (isFF) {
			var height = $id('exp').offsetHeight;
			height += 80;
			$id('exp').style.height = height;
		}
	}
</script>
</head>
<body style="background:#FFFFFF;margin-top:0px;margin-left:0px;margin-buttom:0px;background:url(<%=request.getContextPath()%>/workflow/wfmanager/images/MainFrameBg.gif) no-repeat;overflow:auto;">
<form name="form1" action="com.primeton.workflow.manager.def.exportProcess.flow" method="post">
<h:hidden id="hasBizComposer" property="hasBizComposer" />
<h:hidden id="catalogUUID" property="catalogUUID" />
<h:hidden id="_eosFlowAction" property="_eosFlowAction" />
<h:hidden id="_eosFlowDataContext" property="_eosFlowDataContext" />
<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%" height="100%">
   	<tr>
		<td class="workarea_title" valign="middle"><h3><b:message key="export_biz_processes_jsp.select_process"/></h3></td>
	</tr>
	<tr>
	  <td>
		<table border="0" class="EOS_panel_body" width="100%" height="100%">
			 <tr>  
				<td width="100%" height="100%" valign="top">
					<table id="exp" border="0" class="EOS_table" width="100%" height="300">
						<tr id="tr1" height="100%" class="EOS_table" valign="top">
							<td width="200px" height="100%">
							<div id="treediv" style="overflow-x: auto ; background-color: #EEF3F6 ; overflow-y: auto ; width:200px ; height: 100%;">
							<nobr>
								<r:rtree hasRoot="false" id="processTree">
									<r:treeRoot action="com.primeton.workflow.manager.def.processdef.getProcessRoot.biz" 
										childEntities="rootEntity"/>
										
									<r:treeNode action="com.primeton.workflow.manager.def.processdef.getFixedCatalogRoot.biz" initParamFunc="initParam" submitXpath="querySub"
										showField="catalogName" nodeType="rootEntity" childEntities="fixedCatalogList" 
										onClickFunc="showProcessDefs" onRefreshFunc="renderCatalogNode"/>
										
									<r:treeNode action="com.primeton.workflow.manager.def.processdef.getSecondCatalogOrProcess2.biz" initParamFunc="initParam" submitXpath="querySub" 
										showField="catalogName" nodeType="fixedCatalogList" childEntities="catalogRootList;processDefList" 
										onClickFunc="showProcessDefs" onRefreshFunc="renderCatalogNode"/>
										
									<r:treeNode action="com.primeton.workflow.manager.def.processdef.getSubCatalogAndProcess2.biz" initParamFunc="initParam" submitXpath="querySub" 
										showField="catalogName" nodeType="catalogRootList" childEntities="catalogSubList;processDefList" 
										onClickFunc="showProcessDefs" onRefreshFunc="renderCatalogNode"/>
										
									<r:treeNode action="com.primeton.workflow.manager.def.processdef.getSubCatalogAndProcess2.biz" initParamFunc="initParam" submitXpath="querySub" 
										showField="catalogName" nodeType="catalogSubList" childEntities="catalogSubList;processDefList" 
										onClickFunc="showProcessDefs" onRefreshFunc="renderCatalogNode"/>
										
									<r:treeNode initParamFunc="initParam2" showField="processDefName" nodeType="processDefList" 
										onRefreshFunc="renderProcessNode" icon="/workflow/wfmanager/images/processdef.gif"/>
								</r:rtree>
							</nobr>
							</div>
							</td>
							<td width="5px;"></td>
							<td>
								<iframe align="top" id="plist" name="plist" width="100%" frameborder="0" scrolling="auto" src="com.primeton.workflow.manager.def.exportProcess.flow?_eosFlowAction=listProcess&catalogUUID=1"></iframe>
							</td>
						</tr>
					</table>
				  	<br>		
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
					  
					  <tr>
					  	<td>
					  		<div id="linkBizResourceCheckboxDiv">
					  		<!-- 
					  		<input id="linkBizResourceCheckboxID" name="link" type="checkbox" onclick="linkBizResource();" checked="checked">导出关联业务资源  -->
					  		</div>
					  	</td>
					  </tr>
					  <tr>
					    <td>&nbsp;</td>
					  </tr>
                      <tr>
                        <td>                        	
                        	<input type="button" id="nextbuttonID" name="next" value='<b:message key="defcommon.btn_next"/>' class="button" onclick="nextStep();">
                        	<input type="button" id="finishbuttonID" name="finish" value='<b:message key="defcommon.btn_done_exp"/>' class="button" onclick="finishExport();">
                        	<!--<input type="button" id="btnCancel" name="cancel" value='<b:message key="defcommon.cancel"/>' class="button" onclick="cancelExport();">-->
                   		</td>
                      </tr>
                    </table>
            	</td>
			</tr>
		</table>
</td></tr>
</table>
</form>
</body>
</html>