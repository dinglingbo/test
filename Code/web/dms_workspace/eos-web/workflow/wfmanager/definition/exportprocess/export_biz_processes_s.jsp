<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String bizProc = ResourcesMessageUtil.getI18nResourceMessage("defcommon.biz_proc");
%>
<html>
<head>
<title><b:message key="export_biz_processes_jsp.export_biz_proc"/></title>
<script>
	
	//下一步
	function nextStep(){
		$id("_eosFlowAction").value = "selectBizRes";
		form1.action = "com.primeton.workflow.manager.def.exportProcess.flow";
		catalogTree.createHiddenData();
		form1.submit();
	}
	
	//取消导出
	function cancelExport(){
		parent.frames["middle"].window.location.href = 'com.primeton.workflow.manager.def.getProcessByCatalogID.flow?catalogUUID='+$id("catalogUUID").value;
	}
	
	function showProcessDefs(node) {
		if (node.hasChildNode()) {
			node.expandNode();
		}
		
		var seleProcessList = new Array();
		var seleProcessDefs = "";
		seleProcessList = $id("catalogTree").getCheckedList("process");
		for(i=0; i<seleProcessList.getLength(); i++) {
			seleProcessDefs += "&seleProcessDefs["+i+"]="+seleProcessList.list[i].getProperty("processDefName");
		}
		
		var catalogUUID = node.getProperty('catalogUUID');
		plist.src = "com.primeton.workflow.manager.def.exportProcess.flow?_eosFlowAction=listProcess&catalogUUID="+catalogUUID+"&seleProcessDefs="+seleProcessDefs;
		plist.window.location = "com.primeton.workflow.manager.def.exportProcess.flow?_eosFlowAction=listProcess&catalogUUID="+catalogUUID+"&seleProcessDefs="+seleProcessDefs;
	}
	
	function checkProcessDefs(node) {
		var catalogUUID = node.getProperty('catalogUUID');
		
		if(node.isChecked()) {
			plist.selectAllProcess(catalogUUID);
		}
		else {
			plist.disSelectAllProcess(catalogUUID);
		}
	}
	
	function checkProcessDef(node) {
		var prcId = node.getProperty('processDefName');
		
		if(node.isChecked()) {
			plist.selectProcess(prcId);
		}
		else {
			plist.disSelectProcess(prcId);
		}
	}
	
	function reverseSelect() {
		var isChecked = form1.link.checked;
		if (isChecked) {
			form1.link.checked=false;
		}
		else {
			form1.link.checked=true;
		}
	}
	
	function linkBizResource() {
	
	}
	
	function selectProcessNode(prcId) {
		var node = $id("catalogTree").getSelectedNode();
		var children = new Array();
		children = node.getChildren();
		for(i=0; i<children.length; i++) {
			var id = children[i].getProperty("processDefName");
			if (id == prcId) {
				if (!children[i].isChecked()) {
					children[i].checkbox_click();
				}
			}
		}
	}
	
	function disSelectProcessNode(prcId) {
		var node = $id("catalogTree").getSelectedNode();
		var children = new Array();
		children = node.getChildren();
		for(i=0; i<children.length; i++) {
			var id = children[i].getProperty("processDefName");
			if (id == prcId) {
				if (children[i].isChecked()) {
					children[i].checkbox_click();
				}
			}
		}
	}
	
</script>
</head>
<body style="background:#FFFFFF;margin-top:0px;margin-left:0px;margin-buttom:0px;background:url(<%=request.getContextPath()%>/workflow/wfmanager/images/MainFrameBg.gif) no-repeat;overflow:auto;">
<form name="form1" action="com.primeton.workflow.manager.def.exportProcess.flow" method="post">
<h:hidden id="catalogUUID" property="catalogUUID" />
<h:hidden id="_eosFlowAction" property="_eosFlowAction" />
<h:hidden id="_eosFlowDataContext" property="_eosFlowDataContext" />
   <table border="0" cellpadding="1" cellspacing="1" class="workarea" width="100%" height="100%">
   	<tr>
		<td class="workarea_title" valign="middle"><h3><b:message key="export_biz_processes_jsp.select_process"/></h3></td>
	</tr>
	<tr>
	  <td>
		<table border="0" class="EOS_panel_body" cellpadding="0" cellspacing="0" width="100%" height="100%">
			 <tr> 
				<td width="100%" height="100%" valign="top">
					<table border="0" class="EOS_table" cellpadding="0" cellspacing="0" width="100%" height="75%">
						<tr height="100%" class="EOS_table" style="background-color: #EEF3F6 ;">
							<td width="200px" valign="top">
							<div id="treediv" style="overflow-x: auto ; background-color: #EEF3F6 ; overflow-y: auto ; width:200px ; height:100%">
							<nobr>
								<w:tree id="catalogTree" hasCheckBox="true" checkBoxType="associated">
									<w:treeRoot display="<%=bizProc%>"></w:treeRoot>
									<w:treeNode nodeType="catalog" showField="catalogName" xpath="catalog" onClickFunc="showProcessDefs" onCheckFunc="checkProcessDefs" >
										<w:treeRelation parentNodeType="root" field="parentCatalogUUID" value="1" />
										<w:treeRelation parentNodeType="catalog" field="parentCatalogUUID" parentField="catalogUUID" />
									</w:treeNode>
									<w:treeNode nodeType="process" showField="processDefName" xpath="process" submitXpath="processDef" onCheckFunc="checkProcessDef" icon="/workflow/wfmanager/images/processdef.gif">
						                <w:treeRelation parentNodeType="catalog" parentField="catalogUUID" field="catalogUUID" />
						                <w:treeCheckbox field="processDefName" checkedXpath="seleProcess" checkedField="processDefName"/>
						            </w:treeNode>
								</w:tree>
							</nobr>
							</div>
							</td>
							<td width="5px;"></td>
							<td>
								<iframe align="top" id="plist" width="100%" height="100%" frameborder="0" scrolling="auto" src="com.primeton.workflow.manager.def.exportProcess.flow?_eosFlowAction=listProcess&catalogUUID=1"></iframe>
							</td>
						</tr>
					</table>
				  	<br>		
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
					  <tr>
					  	<td>
					  		<b:message key="export_biz_processes_s_jsp.export_selection"/>
					  	</td>
					  </tr>
					  <tr>
					  	<td>
					  		<input name="link" type="checkbox" onclick="linkBizResource();" checked="checked" ><b:message key="export_biz_processes_s_jsp.rel_biz_res"/>
					  	</td>
					  </tr>
					  <tr>
					    <td>&nbsp;</td>
					  </tr>
                      <tr>
                        <td>
                        	<input id="btnOK" type="button" name="next" value='<b:message key="defcommon.btn_next"/>' class="button" onclick="nextStep();">
                        	<input id="btnCancel" type="button" name="cancel" value='<b:message key="defcommon.btn_cancel"/>' class="button" onclick="cancelExport();">
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