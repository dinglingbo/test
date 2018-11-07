<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
<head>
	<title></title>
	<script>
		function showProcessList() {			
			//FIXME: document.getElementById  --> $id
			$name("pkgId").value='<b:write property="proVersions/packageID"/>';
			document.forms['processVerionForm'].action="com.primeton.workflow.manager.def.getAllProcessDef.flow";
			submitForm('processVerionForm');
		}

		function setSelectedPro(sid) {
			//var sid = getSid('processVerionForm');
			if (sid) {
				var values = new Array();
				values = sid.split(",");				
				if (values.length == 2) {
					$name('proId').value = values[0];
					$name('proName').value=values[1];
					return true;
				}
			}
			return false;
		}
   		function pubProcess (id) {
   			if (setSelectedPro(id)) {
   				openConfirmWindow('processVerionForm','com.primeton.workflow.manager.def.publishProcess.flow?act=pub','<%=request.getContextPath()%>','<b:message key="process_version_list_jsp.confirm_publish"/>',null,'<b:message key="process_version_list_jsp.publish_process"/>')//确认要发布该流程吗?/发布流程
   			}
   		}
   		
   		function cancelPubProcess(id) {
   			if (setSelectedPro(id)) {
   				openConfirmWindow('processVerionForm','com.primeton.workflow.manager.def.publishProcess.flow?act=depub','<%=request.getContextPath()%>','<b:message key="process_version_list_jsp.confirm_unpublish"/>',null,'<b:message key="process_version_list_jsp.cancel_publish_process"/>')//确认要取消发布该流程吗?/取消发布流程
   			}
   		}
   		
   		function deleteProcess (id) {
   			if(setSelectedPro(id)) 
				openWindow('<%=request.getContextPath()%>/workflow/wfmanager/definition/processdef_list/removeProConfirm.jsp?id='+obj('proId').value+'&name='+obj('proName').value+'&pkgId='+obj('pkgId').value+'&catalogUUID='+obj('catalogUUID').value,'<%=request.getContextPath()%>','300','200','<b:message key="process_version_list_jsp.delete_process"/>')//删除流程
   		}
   		
   		function uploadProcess() {
   			 var processDefName = $name('processDefName').value;
   			 var catalogUUID = $name('catalogUUID').value;
   			 showModalCenter('<%=request.getContextPath()%>/workflow/wfmanager/definition/processdef_list/upload_processFile.jsp?processDefName='+processDefName+'&catalogUUID='+catalogUUID+'',null,function (returnValue){
   			 	if (!returnValue) 
   			 		return false;
   			 	if (returnValue == 'failed')
   			 		return false ;
				try{
				 parent.left.refreshNode();
				}catch(e){
				}
   			 	window.location.href=location;
				
   			 	 
   			 },'450','340','<b:message key="process_version_list_jsp.update_process"/>');//更新流程
   		}
   		
   		function fresh(){
   			var refresh ='<b:write property="refresh"/>';
   			if (refresh == "true") {
	   			parent.left.refreshNode();
   			}
   			var act='<%=request.getParameter("act") %>';
   			if(act=="pub"||act=="depub"){
	   			//freshTreeNode();
   		    }
   		}
   		
   		function freshTreeNode(){
   			if(document.readyState=="complete"){
   				executeFresh();
   			}
   			else {
   				setTimeout("freshTreeNode()",100);
   			}
   			
   		}
   		
   		function executeFresh(){
   			parent.left.refreshNode();
   		}
   		
   		function pauseFresh(){
   			parent.left.pauseFresh();
   		}
   		
   		function showDiagram(id, pname, state, pkgId, pkgName, version) {
   			var pNode = getSelectNode();
			_save_select_node_id = version;
			pNode.reloadChild(afterClickReload);;
   		
   			//document.forms['processVerionForm'].action="<%=request.getContextPath()%>/workflow/wfmanager/definition/processdef_detail/process_diagram.jsp?id="+id+"&pname="+pname+"&state="+state+"&pkgId="+pkgId+"&pkgName="+pkgName+"&version="+version;
			//submitForm('processVerionForm');
   		}
   		
   		function afterClickReload(pNode){
			var curNode = getCurNodeByNameFromParent(pNode,_save_select_node_id);
			curNode.selected();
			clickNode(curNode);
		}
   		
   		function getSelectNode() {
			var curNode = parent.frames["left"].window.document.getElementById("tree").getSelectNode();
			return curNode;
		}
		
		function getCurNodeByNameFromParent(parentNode,name){
			var children = parentNode.getChildren();
			var goalNode = "";
			for(var k=0;k<children.length;k++){
				node = children[k];
				var nodeName = node.getProperty("versionSign");
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
		
		function clickNode(curNode) {
			if (isIE) {
				curNode.cell.click();
			} else {		
				var evt = document.createEvent("MouseEvents");
				evt.initEvent("click", true, true);
				curNode.cell.dispatchEvent(evt); 
			}
		}
	</script>
</head>
<body style="background:#FFFFFF;repeat-x;margin-top:0px;margin-left:0px;margin-buttom:0px;background:url(<%=request.getContextPath()%>/workflow/wfmanager/images/MainFrameBg.gif) no-repeat;overflow:auto;" onload="fresh();" >
   <form name="processVerionForm" method="post" enctype="multipart/form-data">
   <table border="0" cellpadding="0" cellspacing="0"  class="workarea" width="100%" height="100%">
   	<tr>
		<td class="workarea_title" valign="middle" >
			<h3><b:message key="process_version_list_jsp.process_version_list"/></h3><%-- 流程版本列表 --%>		
		</td>
	</tr> 
	<tr>
		<td width="100%" valign="middle" bgcolor="#E7F5FE">
			<table border="0" class="EOS_panel_body" height="100%" width="98%" style="margin-left:10px; margin-top:10px">
				<l:present property="proVersions">
						<tr>
							<td height="20" width="100%">
								<!-- 
								<div>Contribution: <a href="#" onclick="javasrcipt:showProcessList()" target="middle"><b:write property="proVersions/packageName"/></a></div>
								 -->
								<div><b:message key="process_version_list_jsp.process_name"/><b:write property="proVersions/processDefName"/></div><%-- 流程名称: --%>
								<div>
									<label><b:message key="process_version_list_jsp.process_display_name"/><b:write property="proVersions/processChName"/></label><%-- 流程显示名称: --%>
								</div>
								<div style="text-align:right">
										<a href="#" onclick="javascript:uploadProcess();return false;"><b:message key="process_version_list_jsp.update_process_from_local"/></a><%-- 从本地更新流程 --%>
								</div>
							</td>
						</tr>
				</l:present>
			</table>
		</td>
	</tr>
	<tr>
		<td class="EOS_panel_body" valign="top" height="2%">
			<hr>
		</td>
	</tr>
	<tr >
	  	<td width="100%" valign="top" height="80%">
			<table border="0" class="EOS_panel_body" width="100%" height="100%">
				<tr> 
					<td width="100%"  valign="top">
							<table border="0" class="EOS_table" width="98%" align="center"  >
								<tr class="EOS_table_head">
								  <th width="3%">#</th>
								  <th width="10%"><b:message key="process_version_list_jsp.version"/></th><%-- 版本号 --%>
								  <th width="13%"><b:message key="process_version_list_jsp.new_time"/></th><%-- 创建时间 --%>
								  <th width="13%"><b:message key="process_version_list_jsp.recent_update_time"/></th><%-- 最近更新时间 --%>
								  <th width="10%"><b:message key="process_version_list_jsp.cur_pub_state"/></th><%-- 当前发布状态 --%>
								  <th width="13%"><b:message key="process_version_list_jsp.process_owner"/></th><%-- 流程所有者 --%>
								  <th width="26%"><b:message key="process_version_list_jsp.operation"/></th><%-- 操作 --%>
								</tr>
								<l:present property="proVersions">
									<% int i=0;%>
									<l:iterate id="view" property="proVersions">
										<tr class="EOS_table_row">
											<td><%=++i%></td>
											<td><a href="javascript:showDiagram('<b:write iterateId="view" property="processDefID"/>', '<b:write iterateId="view" property="processDefName"/>', '<b:write iterateId="view" property="currentState"/>', '<b:write iterateId="view" property="packageID"/>', '<b:write iterateId="view" property="packageName"/>', '<b:write iterateId="view" property="versionSign"/>')">
												<b:write iterateId="view" property="versionSign"/>
												</a>
											</td>
											<td><b:write iterateId="view" property="createTime" formatPattern="yyyy-MM-dd hh:MM"/></td>
											<td><b:write iterateId="view" property="updateTime" formatPattern="yyyy-MM-dd hh:MM"/></td>
											<td align="center">
												<!--  <b:write iterateId="view" property="currentState"/> -->
												<l:equal iterateId="view" property="currentState" targetValue="1">
													 <b:message key="process_version_list_jsp.unpublished"/>
												</l:equal><%-- 未发布 --%>
												<l:equal iterateId="view" property="currentState" targetValue="3">
													 <b:message key="process_version_list_jsp.published"/>
												</l:equal><%-- 已发布 --%>
											</td>
											<td valign="center"><b:write iterateId="view" property="processDefOwner"/></td>
											<td>
												<l:equal iterateId="view" property="currentState" targetValue="1">
													 <a href="#" onclick="javascript:pubProcess('<b:write iterateId="view" property="processDefID"/>,<b:write iterateId="view" property="processDefName"/>');return false;"><b:message key="process_version_list_jsp.publish"/></a><%-- 发布 --%>
												</l:equal>
												<l:equal iterateId="view" property="currentState" targetValue="3">
													 <a href="#" onclick="javascript:cancelPubProcess('<b:write iterateId="view" property="processDefID"/>,<b:write iterateId="view" property="processDefName"/>');return false;"><b:message key="process_version_list_jsp.cancel_publish"/></a><%-- 取消发布 --%>
												</l:equal> | <a href="#" onclick="javascript:deleteProcess('<b:write iterateId="view" property="processDefID"/>,<b:write iterateId="view" property="processDefName"/>');return false;"><b:message key="process_version_list_jsp.delete"/></a><%-- 删除 --%>
											</td>
										</tr>
									</l:iterate>
								</l:present>
				  			</table>
					</td>	
				</tr>
	<%--			<tr>
					<td align="right" valign="top" >
						 
					</td>
				</tr>
				  <tr><td>
					<div style="margin-bottom:2px; padding-top:45px;">
						<table cellpadding="0" cellspacing="0" border="0" style="overflow:auto; padding-left:5px;">
							<tr><td>
								
								</td>
							</tr>
						</table>
					</div>
					</td></tr>--%>
			</table>
		</td>
	</tr>
   </table> 
   <l:present property="proVersions">
	   <input type="hidden" name="pkgId" value="<b:write property="proVersions/packageID"/>">
	   <input type="hidden" name="processDefId" value="<b:write property="proVersions/processDefId"/>">
	   <input type="hidden" name="processDefName" value="<b:write property="proVersions/processDefName"/>">
	   <input type="hidden" name="catalogUUID" value="<b:write property="proVersions/catalogUUID"/>">
   </l:present>
   <input type="hidden" name="proId">
   <input type="hidden" name="proName">
   </form>
</body>
</html>