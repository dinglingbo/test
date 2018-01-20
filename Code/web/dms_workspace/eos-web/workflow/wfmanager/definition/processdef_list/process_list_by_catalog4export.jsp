<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
<head>
	<title></title>
	<script>
		var catalogUUID ='<b:write property="catalogUUID"/>';
		var selectedProcessDefs ='<b:write property="selectedProcessDefs"/>';
		var isFirst = true;
		window.onload = function() {
			var rows = $id("group1").getRows();
			for(i=0; i<rows.length; i++) {
				var id = rows[i].getParam("view/processDefName");
				if (selectedProcessDefs.indexOf("," + id + ",") != -1) {
					rows[i].setSelected();
				}
			}
			var selelen = $id("group1").getSelectLength();
			var len = $id("group1").getLength();
			
			if (len > 0 && selelen == len) {
				processesForm.operation.checked = true;
			}
			isFirst = false;
		};
		
		function selectProcesses(){
			var isChecked = processesForm.operation.checked;
			if (isChecked) {
				selectAllProcess(catalogUUID);
			} else {
				disSelectAllProcess(catalogUUID);
			}
		}
		
		function selectAllProcess(catalogID){
			if (catalogID == catalogUUID) {
				processesForm.operation.checked=true;
				selectAll('group1');
			}
		}
		
		function disSelectAllProcess(catalogID){
			if (catalogID == catalogUUID) {
				processesForm.operation.checked=false;
				disSelectAll('group1');
			}
		}
		
		function selectProcess(prcId){
			var rows = $id("group1").getRows();
			for(i=0; i<rows.length; i++) {
				var id = rows[i].getParam("view/processDefName");
				if (prcId == id) {
					rows[i].setSelected();
				}
			}
		}
		
		function disSelectProcess(prcId){
			var rows = $id("group1").getRows();
			for(i=0; i<rows.length; i++) {
				var id = rows[i].getParam("view/processDefName");
				if (prcId == id) {
					rows[i].disSelected();
				}
			}
		}
		
		function addProcessId(row) {
			if (isFirst) {
				return;
			}
			var selelen = $id("group1").getSelectLength();
			var len = $id("group1").getLength();
			
			if (len > 0 && selelen == len) {
				processesForm.operation.checked = true;
			}
			
			var prcId = row.getParam("view/processDefName");
			parent.selectProcessNode(catalogUUID, prcId);			
		}
		
		function removeProcessId(row) {
			if (isFirst) {
				return;
			}
			if (processesForm.operation.checked) {
				processesForm.operation.checked = false;
			}			
			
			var prcId = row.getParam("view/processDefName");
			parent.disSelectProcessNode(catalogUUID, prcId);
		}
	</script>
</head>
<body style="background:#EEF3F6; margin-top:0px; margin-left:0px; margin-buttom:0px; background:url(<%=request.getContextPath()%>/workflow/wfmanager/images/MainFrameBg.gif) no-repeat;overflow:auto;">
<table border="0" cellpadding="1" cellspacing="1" class="workarea" width="100%" height="100%">
<tr valign="top"><td style="background:#E7F5FE;">
<form name="processesForm" method="post">
	<h:hidden id="catalogUUID" property="catalogUUID" />
	<w:checkGroup id="group1">
		<table cellpadding="0" cellspacing="0" border="0" class="EOS_panel_body" width="100%" height="100%">
			 <tr> 
				<td width="100%"  height="100%"  valign="top">
					<table id="chk1" border="0" class="EOS_table" width="100%">
					<tr class="EOS_table_head">
					  <th width="10%">
					  	<input name="operation" type="checkbox" onclick="selectProcesses();" ><b:message key="defcommon.select_all"/>
					  </th>
					  <th width="25%"><b:message key="process_list_by_catalog4export_jsp.proc_name"/></th>
					  <th width="25%"><b:message key="process_list_by_catalog4export_jsp.proc_cn_name"/></th>
					  <th width="15%"><b:message key="process_list_by_catalog4export_jsp.publish_ver"/></th>
					  <th width="10%"><b:message key="process_list_by_catalog4export_jsp.version_number"/></th>
					  <th width="15%"><b:message key="process_list_by_catalog4export_jsp.latest_ver"/></th>
					  </tr>
					<l:iterate id="view" property="processes">
						<tr class="EOS_table_row">
							<td>
								<w:rowCheckbox onSelectFunc="addProcessId" onUnSelectFunc="removeProcessId">
									<w:rowSelect property="processDefName" iterateId="view" checkedValue="@selectedProcessDefs" separator="," />
									<h:param property="processDefName" name="view/processDefName" iterateId="view" indexed="true"/>
								</w:rowCheckbox>
							</td>
							<td nowrap="nowrap">
								<span title='<b:write iterateId="view" property="processDefName"/>'><b:write iterateId="view" property="processDefName" maxLength="20"/></span>
							</td>
							<td nowrap="nowrap">
								<span title='<b:write iterateId="view" property="processChName"/>'><b:write iterateId="view" property="processChName" maxLength="20"/></span>
							</td>
							<td><b:write iterateId="view" property="publishedVersion"/></td>
							<td><b:write iterateId="view" property="processCount"/></td>
							<td><b:write iterateId="view" property="lastVersion"/></td>
						</tr>
					</l:iterate>
					</table>
					<br>		
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td>
                        	<!--<input type="button" name="deploy" value="部署业务流程" class="button" onclick="deployBizProcesses()">
                        	<input type="button" name="export" value="导出业务流程" class="button" onclick="exportBizProcesses()">-->
                   		</td>
                      </tr>
                    </table>
            	</td>
			</tr>
		</table>
	</w:checkGroup>
</form>
</td></tr></table>
</body>	
</html>
