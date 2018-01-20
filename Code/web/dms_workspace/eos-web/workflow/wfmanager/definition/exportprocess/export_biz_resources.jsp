<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil" %>
<%
String bizRes = ResourcesMessageUtil.getI18nResourceMessage("defcommon.biz_res");
%>
<h:script src="/workflow/wfmanager/definition/js/rtree-checkbox.js"></h:script>
<html>
<head>
<title><b:message key="export_biz_resources_jsp.export_biz_res"/></title>
<script>
	var catalogUUID ='<b:write property="catalogUUID"/>';
	var hasBizComposer ='<b:write property="hasBizComposer"/>';
	
	function backStep() {
		window.location.href = 'com.primeton.workflow.manager.def.exportProcess.flow?_eosFlowAction=selectProcess&catalogUUID='+catalogUUID;
	}
	
	//完成导出
	function finishExport() {
		if (getSelectedNodeList($id("resourceTree"), "").length == 0) {
			alert('<b:message key="export_biz_resources_jsp.select_tip"/>');
			return;
		}
		
		$id("_eosFlowAction").value = "finishExport2";
		form1.action = "com.primeton.workflow.manager.def.exportProcess.flow";
		createSubmitRTreeHiddenData($id("resourceTree"), "BIZCATALOG", "bizcatalogs2");
		createSubmitRTreeHiddenData($id("resourceTree"), "RESOURCE", "resources");
		form1.submit();
	}
	
	function showBizResources(node) {		
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
		var parentCatalogUUID = node.getProperty('catalogUUID');	
		var selectedResources = ",";
		if (directFlag == "Y" || directFlag == null) {
			var childrenNode = node.getChildren();
			for (var i = 0; i < childrenNode.length; i++) {
				if (isNodeSelectedState(childrenNode[i])) {
					selectedResources += childrenNode[i].getProperty("unit/id") + ",";	
				}
			}
			
			var url = "com.primeton.workflow.manager.def.exportProcess.flow?_eosFlowAction=listResource&catalogUUID="+parentCatalogUUID + "&selectedResources="+selectedResources;
			$name("rlist").src = url;
		}
		else {
			var url = "com.primeton.workflow.manager.def.exportProcess.flow?_eosFlowAction=noResource&catalogUUID="+parentCatalogUUID + "&selectedResources="+selectedResources;
			$name("rlist").src = url;
		}
	}
	
	function checkAllBizResource(node) {
		var catalogUUID = node.getProperty("catalogUUID");
		if(isNodeSelectedState(node)) {
			rlist.window.selectAllBizResource(catalogUUID);
		} else {
			rlist.window.disSelectAllBizResource(catalogUUID);
		}
	}
	
	function checkBizResource(node) {
		var resId = node.getProperty("unit/id");
		if(isNodeSelectedState(node)) {
			rlist.window.selectBizResource(resId);
		}
		else {
			rlist.window.disSelectBizResource(resId);
		}
	}
	
	function selectBizResourceNode(catalogUUID, resId) {
		var node = findTreeNode($id('resourceTree'), "BIZCATALOG", "catalogUUID", catalogUUID);
		var children = node.getChildren();
		for(i=0; i<children.length; i++) {
			var id = children[i].getProperty("unit/id");
			if (id == resId) {
				switchState(children[i], STREE_CHECKBOX_TRUE_ICON);
				break;
			}
		}
		node.selected();
	}
	
	function disSelectBizResourceNode(catalogUUID, resId) {
		var node = findTreeNode($id('resourceTree'), "BIZCATALOG", "catalogUUID", catalogUUID);
		var children = node.getChildren();
		for(i=0; i<children.length; i++) {
			var id = children[i].getProperty("unit/id");
			if (id == resId) {
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
	
	function renderResourceNode(node) {
		renderCheckboxNode(node, "RESOURCE", node.getProperty("unit/name"), "switchPlistPageState");
	}
	
	function switchPlistPageState() {
		var pNode = $id('resourceTree').cur_node;		
		if ("BIZCATALOG" == getNodeType(pNode)) {
			checkAllBizResource(pNode);
		} else if("RESOURCE" == getNodeType(pNode)) {
			checkBizResource(pNode);
		}
	}
	
	window.onload=function (){
		$id("rlist").style.height = $id("tr1").offsetHeight;
		$id("treediv").style.height = $id("tr1").offsetHeight;
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
		<td class="workarea_title" valign="middle"><h3><b:message key="export_biz_resources_jsp.select_biz_res"/></h3></td>
	</tr>
	<tr>
	  <td>
	  	<table border="0" class="EOS_panel_body" width="100%" height="100%">
			 <tr> 
				<td width="100%" height="100%" valign="top">
					<table border="0" class="EOS_table" width="100%" height="300">
						<tr id="tr1" height="100%" class="EOS_table" valign="top">
							<td width="200px" height="100%">
							<div id="treediv" style="overflow-x: auto ; background-color: #EEF3F6 ; overflow-y: auto ; width:200px ; height:100%">
							<!--<nobr>
								<w:tree id="catalogTree1" hasCheckBox="true" checkBoxType="associated">
									<w:treeRoot display="<%=bizRes%>"></w:treeRoot>
									<w:treeNode nodeType="catalog" showField="catalogName" xpath="catalog" onClickFunc="showResources" onCheckFunc="checkResources" >
										<w:treeRelation parentNodeType="root" field="parentCatalogUUID" value="1" />
										<w:treeRelation parentNodeType="catalog" field="parentCatalogUUID" parentField="catalogUUID" />
									</w:treeNode>
									<w:treeNode nodeType="resource" showField="unit/name" xpath="resource" submitXpath="bizResource" onCheckFunc="checkResource" iconField="icon" >
						                <w:treeRelation parentNodeType="catalog" parentField="catalogUUID" field="catalogUUID" />
						            	<w:treeCheckbox field="unit/id" checkedXpath="seleResource" checkedField="unit/id"/>
						            </w:treeNode>
								</w:tree>
							</nobr>-->
							<nobr>
								<r:rtree hasRoot="false" id="resourceTree">
									<r:treeRoot action="com.primeton.workflow.manager.def.processdef.getResourceRoot.biz" 
										childEntities="rootEntity"/>
										
									<r:treeNode action="com.primeton.workflow.manager.def.processdef.getResourceFixedCatalogRoot.biz" initParamFunc="initParam" submitXpath="querySub"
										showField="catalogName" nodeType="rootEntity" childEntities="fixedCatalogList" 
										onClickFunc="showBizResources" onRefreshFunc="renderCatalogNode"/>
										
									<r:treeNode action="com.primeton.workflow.manager.def.processdef.getSecondCatalogOrResource2.biz" initParamFunc="initParam" submitXpath="querySub" 
										showField="catalogName" nodeType="fixedCatalogList" childEntities="catalogRootList;bizResourceList" 
										onClickFunc="showBizResources" onRefreshFunc="renderCatalogNode"/>
										
									<r:treeNode action="com.primeton.workflow.manager.def.processdef.getSubCatalogAndResource2.biz" initParamFunc="initParam" submitXpath="querySub" 
										showField="catalogName" nodeType="catalogRootList" childEntities="catalogSubList;bizResourceList" 
										onClickFunc="showBizResources" onRefreshFunc="renderCatalogNode"/>
										
									<r:treeNode action="com.primeton.workflow.manager.def.processdef.getSubCatalogAndResource2.biz" initParamFunc="initParam" submitXpath="querySub" 
										showField="catalogName" nodeType="catalogSubList" childEntities="catalogSubList;bizResourceList" 
										onClickFunc="showBizResources" onRefreshFunc="renderCatalogNode"/>
										
									<r:treeNode showField="unit/name" nodeType="bizResourceList" onRefreshFunc="renderResourceNode" iconField="icon" />
								</r:rtree>
							</nobr>
							</div>
							</td>
							<td width="5px;"></td>
							<td>
								<iframe align="top" id="rlist" name="rlist" width="100%" height="100%" frameborder="0" scrolling="auto" src="com.primeton.workflow.manager.def.exportProcess.flow?_eosFlowAction=listResource&catalogUUID=1"></iframe>
							</td>
						</tr>
					</table>
				  	<br>		
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
					  <tr>
					    <td>&nbsp;</td>
					  </tr>
					  <tr>
					    <td>&nbsp;</td>
					  </tr>
                      <tr>
                        <td>
                        	<input id="btnNext" type="button" name="next" value='<b:message key="defcommon.btn_previous"/>' class="button" onclick="backStep();">
                        	<input id="btnCancel" type="button" name="cancel" value='<b:message key="defcommon.btn_done_exp"/>' class="button" onclick="finishExport();">
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