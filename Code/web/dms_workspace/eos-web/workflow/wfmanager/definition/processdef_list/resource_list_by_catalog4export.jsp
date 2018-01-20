<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
<head>
	<title></title>
	<script>
		var catalogUUID ='<b:write property="catalogUUID"/>';
		
		function selectResources(){
			var isChecked = resourceForm.operation.checked;
			if (isChecked) {
				selectAll('group1');
			}
			else {
				disSelectAll('group1');
			}
		}
		
		function selectAllBizResource(catalogID){
			if (catalogID == catalogUUID) {
				resourceForm.operation.checked=true;
				selectAll('group1');
			}
		}
		
		function disSelectAllBizResource(catalogID){
			if (catalogID == catalogUUID) {
				resourceForm.operation.checked=false;
				disSelectAll('group1');
			}
		}
		
		function selectBizResource(resId){
			var rows = new Array();
			rows = $id("group1").getRows();
			for(i=0; i<rows.length; i++) {
				var id = rows[i].getParam("view/unit/id");
				if (resId == id) {
					rows[i].setSelected();
				}
			}
		}
		
		function disSelectBizResource(resId){
			var rows = new Array();
			rows = $id("group1").getRows();
			for(i=0; i<rows.length; i++) {
				var id = rows[i].getParam("view/unit/id");
				if (resId == id) {
					rows[i].disSelected();
				}
			}
		}
		
		function addResourceId(row) {
			var selelen = $id("group1").getSelectLength();
			var len = $id("group1").getLength();
			
			if (selelen == len) {
				resourceForm.operation.checked=true;
			}
			
			var resId = row.getParam("view/unit/id");
			parent.selectBizResourceNode(catalogUUID, resId);
		}
		
		function removeResourceId(row) {
			resourceForm.operation.checked=false;
			
			var resId = row.getParam("view/unit/id");
			parent.disSelectBizResourceNode(catalogUUID, resId);
		}
	</script>
</head>
<body style="background:#FFFFFF;margin-top:0px;margin-left:0px;margin-buttom:0px;background:url(<%=request.getContextPath()%>/workflow/wfmanager/images/MainFrameBg.gif) no-repeat;overflow:auto;">
<table border="0" cellpadding="1" cellspacing="1" class="workarea" width="100%" height="100%">
<tr valign="top"><td>
<form name="resourceForm" method="post">
	<h:hidden id="catalogUUID" property="catalogUUID" />
	<w:checkGroup id="group1">
		<table cellpadding="0" cellspacing="0" border="0" class="EOS_panel_body" width="100%" height="100%">
			 <tr> 
				<td width="100%" height="100%"  valign="top">
					<table id="chk1" border="0" class="EOS_table" width="100%">
					<tr class="EOS_table_head">
					  <th width="10%">
					  	<input name="operation" type="checkbox" onclick="selectResources();" ><b:message key="defcommon.select_all"/>
					  </th>
					  <th width="30%"><b:message key="resource_list_by_catalog4export_jsp.res_name"/></th>
					  <th width="20%"><b:message key="resource_list_by_catalog4export_jsp.res_type"/></th>
					  <th width="40%"><b:message key="resource_list_by_catalog4export_jsp.desc"/></th>
					  </tr>
					<l:iterate id="view" property="resources">
						<tr class="EOS_table_row">
							<td>
								<w:rowCheckbox onSelectFunc="addResourceId" onUnSelectFunc="removeResourceId">
									<w:rowSelect property="unit/id" iterateId="view" checkedProperty="seleResources" />
									<h:param property="unit/id" name="view/unit/id" iterateId="view" indexed="true"/>
								</w:rowCheckbox>
							</td>
							
						    <td>
						    	<img alt='<d:write iterateId="view" property="unit/type" dictTypeId="WFDICT_BizResourceType"/>' src='<%=request.getContextPath()%><b:write iterateId="view" property="icon"/>'>
								<span title='<b:write iterateId="view" property="unit/name"/>'><b:write iterateId="view" property="unit/name" maxLength="20"/></span>
						    </td>
							<td><d:write iterateId="view" property="unit/type" dictTypeId="WFDICT_BizResourceType"/></td>
							<td nowrap="nowrap">
								<span title='<b:write iterateId="view" property="unit/desc"/>'><b:write iterateId="view" property="unit/desc" maxLength="20"/></span>
							</td>
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