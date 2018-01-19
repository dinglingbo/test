<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
<head>
	<title></title>
	<script>
		var catalogUUID ='<b:write property="catalogUUID"/>';
		
		function showProcessVersions(name){
			var pNode = getSelectNode();
			_save_select_node_id = name;
			pNode.reloadChild(afterClickReload);;
			
			//obj('processDefName').value = name ;
			//document.forms['processesForm'].action="com.primeton.workflow.manager.def.getAllProcessVersions.flow";
			//submitForm('processesForm');
		}
		
		function afterClickReload(pNode){
			var curNode = getCurNodeByNameFromParent(pNode,_save_select_node_id);
			curNode.selected();
			clickNode(curNode);
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
		
		function getCurNodeByNameFromParent(parentNode,name){
			var children = parentNode.getChildren();
			var goalNode = "";
			for(var k=0;k<children.length;k++){
				node = children[k];
				var nodeName = node.getProperty("processDefName");
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
		
		function deployBizProcesses() {
			parent.frames["middle"].window.location.href = 'com.primeton.workflow.manager.def.deployContribution.flow?_eosFlowAction=chooseFile&catalogUUID='+catalogUUID;
   		}
   		
   		function exportBizProcesses(){
   			parent.frames["middle"].window.location.href = 'com.primeton.workflow.manager.def.exportProcess.flow?_eosFlowAction=selectProcess&catalogUUID='+catalogUUID;
   		}
   		
   		function getSelectNode() {
			var curNode = parent.frames["left"].window.document.getElementById("tree").getSelectNode();
			return curNode;
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
 <form name="processesForm" method="post">
   <table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%" height="100%">
   	<tr>
		<td class="workarea_title" valign="middle"><h3><b:message key="process_list_by_catalog_jsp.process_list"/></h3></td><%-- 流程列表 --%>
	</tr>
	<tr>
	  <td>
		<table border="0" class="EOS_panel_body" width="100%" height="100%">
			 <tr> 
				<td width="100%"  height="100%"  valign="top">
					<table border="0" class="EOS_table" width="100%">
				<tr class="EOS_table_head">
				  <th width="18%"><b:message key="process_list_by_catalog_jsp.process_name"/></th><%-- 流程名称 --%>
				  <th width="19%"><b:message key="process_list_by_catalog_jsp.process_cn_name"/></th><%-- 流程中文名称 --%>
				  <th width="18%"><b:message key="process_list_by_catalog_jsp.pub_version"/></th><%-- 发布版本 --%>
				  <th width="19%"><b:message key="process_list_by_catalog_jsp.version_num"/></th><%-- 版本数 --%>
				  <th width="19%"><b:message key="process_list_by_catalog_jsp.newest_version"/></th><%-- 最新版本 --%>
				  </tr>
				<l:iterate id="view" property="processes">
					<tr class="EOS_table_row">
					    <td><a href="javascript:showProcessVersions('<b:write iterateId="view" property="processDefName"/>')"><b:write iterateId="view" property="processDefName"/></a></td>
						<td><b:write iterateId="view" property="processChName"/></td>
						<td><b:write iterateId="view" property="publishedVersion"/></td>
						<td><b:write iterateId="view" property="processCount"/></td>
						<td><b:write iterateId="view" property="lastVersion"/></td>
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
<input type="hidden" name="processDefName">
</form>
<div id="exp"/>
</body>	
</html>