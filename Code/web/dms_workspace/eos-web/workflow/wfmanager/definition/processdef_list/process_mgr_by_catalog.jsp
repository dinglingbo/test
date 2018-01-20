<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
<head>
	<title></title>
	<script>
		var catalogUUID ='<b:write property="catalogUUID"/>';
		
		var curNode = getSelectNode();
		if (curNode ==null) {
			Pause(this,1000);//调用暂停函数
			this.NextStep = function() {
				curNode = parent.frames["left"].window.document.getElementById("tree").getRootNode();
				curNode.selected();
			}
		}
		
   		function deployBizProcesses() {
			parent.frames["middle"].window.location.href = 'com.primeton.workflow.manager.def.deployContribution.flow?_eosFlowAction=chooseFile&catalogUUID='+catalogUUID;
   		}
   		
   		function exportBizProcesses() {
   			parent.frames["middle"].window.location.href = 'com.primeton.workflow.manager.def.exportProcess.flow?_eosFlowAction=selectProcess&catalogUUID='+catalogUUID;
   		}
   		
   		function clickNode(curNode) {
			if (isIE) {
				curNode.cell.click();
			} else {		
				var evt = document.createEvent("MouseEvents");
				evt.initEvent("click", true, true);
				curNode.cell.dispatchEvent(evt); 
			}
		}
		
   		function getProcessByCatalogID(catalogUUID, directFlag) {
   			var pNode = getSelectNode();
   			_save_select_node_id = catalogUUID;
   			if (!pNode.isRootNode()) {
				pNode.reloadChild(afterClickReload);;
   			}
   			else {
   				var curNode = getCurNodeByNameFromParent(pNode,catalogUUID);

  				if (!curNode.isRootNode() && curNode.getProperty("catalogUUID") == "-1") {
  					pNode.reloadChild(afterClickReload);;
   				}
   				else {
   					var curNode = getCurNodeByNameFromParent(pNode,"1");
   					curNode.reloadChild(afterClickReload);;
   				}
   			}
   		
			//document.forms['packageForm'].action="com.primeton.workflow.manager.def.getProcessByCatalogID.flow?catalogUUID="+catalogUUID+"&directFlag="+directFlag;
			//submitForm('packageForm');
   		}
   		
   		function afterClickReload(pNode){
			var curNode = getCurNodeByNameFromParent(pNode,_save_select_node_id);
			curNode.selected();
			clickNode(curNode);
		}
   		
   		function getCurNodeByNameFromParent(parentNode,name){
			var children = parentNode.getChildren();
			var goalNode = "";
			for(var k=0;k<children.length;k++){
				node = children[k];
				var nodeName = node.getProperty("catalogUUID");
				if(nodeName==name){
					goalNode = node;
					break;
				}
			}
			
			if(goalNode!=""){
				return goalNode;
			}
			
			return parentNode;
		}
   		
   		function getSelectNode() {
   			var tree = parent.frames["left"].window.document.getElementById("tree");
   			if (tree == null) {
	   			Pause(this,100);//调用暂停函数
				this.NextStep = function() {
					return getSelectNode();
				}
   			}
   			else {
				return getCurNode(tree);
   			}
		}
		
		function getCurNode(tree) {
			var curNode = tree.getSelectNode();
			if (curNode == null) {
		   		Pause(this,100);//调用暂停函数
				this.NextStep = function() {
					return getCurNode(tree);
				}
	   		}
	   		else {
				return curNode;
	   		}
		}
		
		function initiFrame(){
			if (isFF) {
				var height = $id('exp').offsetHeight;
				height += 80;
				$id('exp').style.height = height;
			}
		}
	</script>
</head>
<body onLoad="initiFrame()" style="background:#FFFFFF;margin-top:0px;margin-left:0px;margin-buttom:0px;background:url(<%=request.getContextPath()%>/workflow/wfmanager/images/MainFrameBg.gif) no-repeat;overflow:auto;">
<form name="packageForm" method="post" action="com.primeton.workflow.manager.def.getAllProcessDef.flow">
<table border="0" cellpadding="1" cellspacing="1" class="workarea" width="100%" height="100%">
<tr>
	<td class="workarea_title" valign="middle"><h3><b:message key="process_mgr_by_catalog_jsp.biz_process_details"/></h3></td><%-- 业务流程信息 --%>
</tr>
<tr>
<td>		
    <table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%" height="100%">
   	<tr>
   		<td class="EOS_panel_head" valign="middle"><b:message key="process_mgr_by_catalog_jsp.deployed_biz_catalog"/></td><%-- 已部署的业务目录 --%>
	</tr>
	<tr>
	  <td>
		<table border="0" cellspacing="1" cellpadding="1" class="EOS_panel_body" width="100%" height="100%">
			 <tr> 
			   <td width="100%" height="100%" valign="top">
					 
				<table border="0" class="EOS_table" width="100%">
				<tr class="EOS_table_head">
				  <th width="43%"><b:message key="process_mgr_by_catalog_jsp.name"/></th><%-- 名称 --%>
				  <th width="25%"><b:message key="process_mgr_by_catalog_jsp.process_num"/></th><%-- 流程数量 --%>
				</tr>
					<l:iterate id="catalog" property="catalogs" scope="request">
						<tr class="EOS_table_row">
							  <td>
							  	<a href="javascript:getProcessByCatalogID('<b:write iterateId="catalog" property="catalog/catalogUUID"/>', '<b:write iterateId="catalog" property="catalog/directFlag"/>')" target="middle">
							  		<b:write iterateId="catalog" property="catalog/catalogName"/>
							  	</a>
							  </td>
							  <td><b:write iterateId="catalog" property="processCount"/></td>
						</tr>
					</l:iterate>		 
			  </table>
			  <br>
				    <!--<table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td>
							<input type="button" name="deploy" value="导入业务流程" class="button" onclick="deployBizProcesses()">
                        	<input type="button" name="export" value="导出业务流程" class="button" onclick="exportBizProcesses()">
                        </td>
                      </tr>
                    </table>-->
            	</td>
			</tr>
		</table>
		</td></tr>
		</table>
</td></tr>
</form>
</table>
<div id="exp"/>
</body>
</html>