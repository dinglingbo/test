<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_catalog/common/common_catalog.jsp"%>
<%@page import="com.eos.data.xpath.XPathLocator"%>

<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String process_mgr_permission = ResourcesMessageUtil.getI18nResourceMessage("catalog_view_jsp.process_mgr_permission");
String process_composer_permission = ResourcesMessageUtil.getI18nResourceMessage("catalog_view_jsp.process_composer_permission");
String process_setting_permission = ResourcesMessageUtil.getI18nResourceMessage("catalog_view_jsp.process_setting_permission");
String resource_mgr_permission = ResourcesMessageUtil.getI18nResourceMessage("catalog_view_jsp.resource_mgr_permission");
String resource_use_permission = ResourcesMessageUtil.getI18nResourceMessage("catalog_view_jsp.resource_use_permission");
 %>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2009-07-06 13:33:44
  - Description:
-->
<head>
<title>CatalogView</title>

<script>	

	function modifyCatalog(){
		window.location.href = "com.primeton.bps.web.bizcatalog.CatalogMgr.flow?_eosFlowAction=modify&comefrom=viewPage&WFBizCatalogInfo/catalogUuid=<b:write property="WFBizCatalogInfo/catalogUuid"/>";
	}
	
	function addSubCatalog(){
		parent.frames["catalogright"].window.location.href = "com.primeton.bps.web.bizcatalog.CatalogMgr.flow?_eosFlowAction=insert&comefrom=viewPage&puid=<b:write property="WFBizCatalogInfo/catalogUuid"/>";
	}
	
	function addBrotherCatalog(){
		var pNode = getSelectParentNode();
		pNode.selected();
		parent.frames["catalogright"].window.location.href = "com.primeton.bps.web.bizcatalog.CatalogMgr.flow?_eosFlowAction=insert&comefrom=viewPage&puid=<b:write property="WFBizCatalogInfo/parentCatalogUuid"/>";
	}
	
	function sortChildrenCatalog(){
		parent.frames["catalogright"].window.location.href = "com.primeton.bps.web.bizcatalog.CatalogMgr.flow?_eosFlowAction=sort&querySub/catalogUuid=<b:write property="WFBizCatalogInfo/catalogUuid"/>";
	}
	
	function deleteCatalog(){
		var argument = new Array(2);
		argument[0] = '<b:message key="catalog_view_jsp.delete_prompt"/>';
		var param1 = '<b:write property="WFBizCatalogInfo/catalogName"/>';
		argument[0] = argument[0].replace('{0}',param1);//argument[0]="确定要删除[<b:write property="WFBizCatalogInfo/catalogName"/>]业务目录吗?"	
		showModalCenter("<%=request.getContextPath()%>/workflow/bps_catalog/ConfirmWin.jsp",argument,callBack,'300','125',"<b:message key="catalog_view_jsp.confirm_box"/>");//确认框
	}
	
	function callBack(value){
		if(value==""){
			return;
		}
        if(value[0]=="Y"){
		    var myAjax = new Ajax("com.primeton.bps.web.bizcatalog.bizcatalogmgr.delCatalog.biz");
			myAjax.addParam("WFBizCatalogInfo/catalogUuid","<b:write property="WFBizCatalogInfo/catalogUuid"/>");
			myAjax.submit(); 
			var isSuc =myAjax.getValue("root/data/RtnMsg/code")
			//alert(isSuc);
			if(isSuc==1){
				var pNode = getSelectParentNode();
				//刷新树菜单,刷新上级节点
				refreshSelectParentNode();
				//选中上级节点，并触发其点击事件。
				pNode.selected();
				_clickEvent_common(pNode.cell);
				//if(pNode.isRootNode()){
				//	parent.frames["catalogright"].window.location.href = "com.primeton.bps.web.bizcatalog.CatalogMgr.flow?_eosFlowAction=desc";
				//}else{
				//	parent.frames["catalogright"].window.location.href = "com.primeton.bps.web.bizcatalog.CatalogMgr.flow?_eosFlowAction=view&WFBizCatalogInfo/catalogUuid="+pNode.getProperty("catalogUuid");							
				//}
			}else{
				showMessage($id("ResponseMessage"),myAjax.getValue("root/data/RtnMsg/name"));
			}
		}
	}
</script>
</head>
<body style="background:#FFFFFF;margin-top:0px;margin-left:0px;margin-buttom:0px;background:url(<%=request.getContextPath()%>/workflow/wfmanager/images/MainFrameBg.gif) no-repeat;overflow:auto;">
<div id="ResponseMessage" class="response_message" style="display:none;" onclick="hiddenResponseMessage(this)"></div>
<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
  <tr> 
    <td class="workarea_title" valign="middle"><h3><b:message key="catalog_view_jsp.view_business_catalog"/></h3></td><%-- 查看业务目录 --%>
  </tr>
  <tr> 
    <td width="100%">
	<form id="catalogForm">
		<h:hidden property="WFBizCatalogInfo/permFlow_Manager" id="WFBizCatalogInfo/permFlow_Manager" />
        <h:hidden property="WFBizCatalogInfo/permFlow_Custom" id="WFBizCatalogInfo/permFlow_Custom" />
        <h:hidden property="WFBizCatalogInfo/permFlow_Config" id="WFBizCatalogInfo/permFlow_Config" />
        <h:hidden property="WFBizCatalogInfo/permResource_Manager" id="WFBizCatalogInfo/permResource_Manager" />
        <h:hidden property="WFBizCatalogInfo/permResource_Use" id="WFBizCatalogInfo/permResource_Use" />
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="form_table">
	    <tr>
			<td class="form_label" width="20%"><b:message key="catalog_view_jsp.business_catalog_name"/></td><%-- 业务目录名称 --%>
			<td width="30%">
				<b:write property="WFBizCatalogInfo/catalogName"/>
			</td>
			<td class="form_label" style="border:1px"  width="20%"><b:message key="catalog_view_jsp.business_catalog_label"/></td><%-- 业务目录标识 --%>
			<td width="30%" style="border:1px" >
				<b:write property="WFBizCatalogInfo/catalogUuid"/>
			</td>
		</tr>
		<tr>
			<td class="form_label" width="20%"><b:message key="catalog_view_jsp.business_catalog_desc"/></td><%-- 业务目录描述 --%>
			<td colspan="3" style="word-break:break-all;"><b:write property="WFBizCatalogInfo/demo" /></td>
		</tr>
		</table>
	</form>
	</td>
  </tr>
  <tr> 
	<td width="100%">
			
						<w:tabPanel bodyStyle="" defaultTab="Flow_Manager" height="100%" id="permission" titleStyle="" width="100%">
					  		<w:tabPage cache="true" id="Flow_Manager" tabType="div" title="<%=process_mgr_permission %>"><%-- 流程管理权限 --%>
					  			<table width="100%">
					                 <tr>
					                     <td><b:message key="catalog_view_jsp.granted"/></td><%-- 已授予 --%>
					                 </tr>
					                 <tr>
					                 	<td>			                     	
					                     	<table class='EOS_TABLE' style="width:100%;border:1px solid #75B5C3;">
					                     		<thead class='EOS_TABLE_HEAD'>
					                     			<tr><th><b:message key="catalog_view_jsp.participant_name"/></th><th><b:message key="catalog_view_jsp.participant_id"/></th><th><b:message key="catalog_view_jsp.participant_type"/></th></tr><%-- 参与者名称/参与者ID/参与者类型 --%>
					                     		</thead>
					                     		<%
								               		String perms = (String)XPathLocator.getInstance().getValue(request,"WFBizCatalogInfo/permFlow_Manager");
								               		
								               		if (perms == null) {
								               			perms = "";
								               		}								               		
								               		if (perms.trim().length() == 0) {
								               	%>
								               	 	<tr><td colspan='3'><b:message key="catalog_view_jsp.not_set_permission"/></td></tr><%-- 没有设置权限 --%>
								               	 <% }  else {
								               			String[] permsArray = perms.split(";");
									               		for (String perm : permsArray) {		
									               			String[] permItems = perm.split(",");						               		
								               	 %>
								               	 	<tr>
								               	 		<td><%=permItems[1] %></td>
								               	 		<td><%=permItems[0] %></td>
								               	 		<td><%=permItems[3] %>(<%=permItems[2] %>)</td>
								               	 	</tr>
								               	 <% 	} 
								               	 	}
								               	 %>
								               	 
					                     	</table> 
					                     </td>
					                     </tr>
					            </table>
					  		</w:tabPage>
					  		<l:equal property="hasFLOWCUST" targetValue="TRUE" ignoreCase="true">
					  		<w:tabPage cache="true" id="Flow_Custom" tabType="div" title="<%=process_composer_permission %>"><%-- 流程定制权限 --%>
					  			<table width="100%">
					                 <tr>
						                 <td><b:message key="catalog_view_jsp.granted"/></td><%-- 已授予 --%>
					                 </tr>
					                 <tr>
						                 <td style="width:100%;border:1px solid #75B5C3;">
						                 	<div id="permissionFlow_Custom" style="width:100%">
						                 	<table class='EOS_TABLE' width='100%'>
					                     		<thead class='EOS_TABLE_HEAD'>
					                     			<tr><th><b:message key="catalog_view_jsp.participant_name"/></th><th><b:message key="catalog_view_jsp.participant_id"/></th><th><b:message key="catalog_view_jsp.participant_type"/></th></tr><%-- 参与者名称/参与者ID/参与者类型 --%>
					                     		</thead>
					                     		<%
								               		String permsCustom = (String)XPathLocator.getInstance().getValue(request,"WFBizCatalogInfo/permFlow_Custom");
								               		if (permsCustom == null) {
								               			permsCustom = "";
								               		}
								               		if (permsCustom.trim().length() == 0) {
								               	%>
								               	 	<tr><td colspan='3'><b:message key="catalog_view_jsp.not_set_permission"/></td></tr><%-- 没有设置权限 --%>
								               	 <% }  else {
								               			String[] permsArray = permsCustom.split(";");
									               		for (String perm : permsArray) {		
									               			String[] permItems = perm.split(",");						               		
								               	 %>
								               	 	<tr>
								               	 		<td><%=permItems[1] %></td>
								               	 		<td><%=permItems[0] %></td>
								               	 		<td><%=permItems[3] %>(<%=permItems[2] %>)</td>
								               	 	</tr>
								               	 <% 	} 
								               	 	}
								               	 %>
								               	 
					                     	</table>
						                 	</div>
					                 	 </td>
					                 </tr>
					            </table>
					  		</w:tabPage>
					  		<w:tabPage cache="true" id="Flow_Config" tabType="div" title="<%=process_setting_permission %>"><%-- 流程配置权限 --%>
					  			<table width="100%">
					                 <tr>
					                     <td><b:message key="catalog_view_jsp.granted"/></td><%-- 已授予 --%>
					                 </tr>
					                 <tr>
						                 <td style="width:100%;border:1px solid #75B5C3;">
						                 	<div id="permissionFlow_Config" style="width:100%">
						                 	<table class='EOS_TABLE' width='100%'>
					                     		<thead class='EOS_TABLE_HEAD'>
					                     			<tr><th><b:message key="catalog_view_jsp.participant_name"/></th><th><b:message key="catalog_view_jsp.participant_id"/></th><th><b:message key="catalog_view_jsp.participant_type"/></th></tr><%-- 参与者名称/参与者ID/参与者类型 --%>
					                     		</thead>
					                     		<%
								               		String permsConfig = (String)XPathLocator.getInstance().getValue(request,"WFBizCatalogInfo/permFlow_Config");
								               		if (permsConfig == null) {
								               			permsConfig = "";
								               		}
								               		if (permsConfig.trim().length() == 0) {
								               	%>
								               	 	<tr><td colspan='3'><b:message key="catalog_view_jsp.not_set_permission"/></td></tr><%-- 没有设置权限 --%>
								               	 <% }  else {
								               			String[] permsArray = permsConfig.split(";");
									               		for (String perm : permsArray) {		
									               			String[] permItems = perm.split(",");						               		
								               	 %>
								               	 	<tr>
								               	 		<td><%=permItems[1] %></td>
								               	 		<td><%=permItems[0] %></td>
								               	 		<td><%=permItems[3] %>(<%=permItems[2] %>)</td>
								               	 	</tr>
								               	 <% 	} 
								               	 	}
								               	 %>
								               	 
					                     	</table>
						                 	</div>
						                 </td>
					                 </tr>
					            </table>
					  		</w:tabPage>
					  		<w:tabPage cache="true" id="Resource_Manager" tabType="div" title="<%=resource_mgr_permission %>"><%-- 资源管理权限 --%>
					  			<table width="100%">
					                 <tr>
					                     <td><b:message key="catalog_view_jsp.granted"/></td><%-- 已授予 --%>
					                 </tr>
					                 <tr>
					                     <td style="width:100%;border:1px solid #75B5C3;">
					                     	<div id="permissionResource_Manager" style="width:100%">
					                     	<table class='EOS_TABLE' width='100%'>
					                     		<thead class='EOS_TABLE_HEAD'>
					                     			<tr><th><b:message key="catalog_view_jsp.participant_name"/></th><th><b:message key="catalog_view_jsp.participant_id"/></th><th><b:message key="catalog_view_jsp.participant_type"/></th></tr><%-- 参与者名称/参与者ID/参与者类型 --%>
					                     		</thead>
					                     		<%
								               		String permsManager = (String)XPathLocator.getInstance().getValue(request,"WFBizCatalogInfo/permResource_Manager");
								               		if (permsManager == null) {
								               			permsManager = "";
								               		}
								               		if (permsManager.trim().length() == 0) {
								               	%>
								               	 	<tr><td colspan='3'><b:message key="catalog_view_jsp.not_set_permission"/></td></tr><%-- 没有设置权限 --%>
								               	 <% }  else {
								               			String[] permsArray = permsManager.split(";");
									               		for (String perm : permsArray) {		
									               			String[] permItems = perm.split(",");						               		
								               	 %>
								               	 	<tr>
								               	 		<td><%=permItems[1] %></td>
								               	 		<td><%=permItems[0] %></td>
								               	 		<td><%=permItems[3] %>(<%=permItems[2] %>)</td>
								               	 	</tr>
								               	 <% 	} 
								               	 	}
								               	 %>
								               	 
					                     	</table>
					                     	</div>
				                     	 </td>
					                 </tr>
					            </table>
					  		</w:tabPage>
					  		<w:tabPage cache="true" id="Resource_Use" tabType="div" title="<%=resource_use_permission %>"><%-- 资源使用权限 --%>
					  			<table width="100%">
					                 <tr>
					                     <td><b:message key="catalog_view_jsp.granted"/></td><%-- 已授予 --%>
					                 </tr>
					                 <tr>
					                     <td style="width:100%;border:1px solid #75B5C3;">
					                     	<div id="permissionResource_Use" style="width:100%">
					                     	<table class='EOS_TABLE' width='100%'>
					                     		<thead class='EOS_TABLE_HEAD'>
					                     			<tr><th><b:message key="catalog_view_jsp.participant_name"/></th><th><b:message key="catalog_view_jsp.participant_id"/></th><th><b:message key="catalog_view_jsp.participant_type"/></th></tr><%-- 参与者名称/参与者ID/参与者类型 --%>
					                     		</thead>
					                     		<%
								               		String permsUse = (String)XPathLocator.getInstance().getValue(request,"WFBizCatalogInfo/permResource_Use");
								               		if (permsUse == null) {
								               			permsUse = "";
								               		}
								               		if (permsUse.trim().length() == 0) {
								               	%>
								               	 	<tr><td colspan='3'><b:message key="catalog_view_jsp.not_set_permission"/></td></tr><%-- 没有设置权限 --%>
								               	 <% }  else {
								               			String[] permsArray = permsUse.split(";");
									               		for (String perm : permsArray) {		
									               			String[] permItems = perm.split(",");						               		
								               	 %>
								               	 	<tr>
								               	 		<td><%=permItems[1] %></td>
								               	 		<td><%=permItems[0] %></td>
								               	 		<td><%=permItems[3] %>(<%=permItems[2] %>)</td>
								               	 	</tr>
								               	 <% 	} 
								               	 	}
								               	 %>
								               	 
					                     	</table>
					                     	</div>
				                     	 </td>
					                 </tr>
					            </table>
					  		</w:tabPage>
					  		</l:equal>
						</w:tabPanel>
						<span id="spanPositionID" style="position:absolute"></span>
	</td>
  </tr>
  <tr>
	<td id="buttonPositionID">
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="form_table">
	    <tr><td>
		    <input type="button" name="btnsave" id="btnsave1" value="<b:message key="catalog_view_jsp.modify"/>" class="button" onclick="modifyCatalog();"><%-- 修改 --%>
		    <input type="button" name="btnsave" id="btnsave2" value="<b:message key="catalog_view_jsp.del_catalog"/>" class="button" onclick="deleteCatalog();"><%-- 删除目录 --%>
			<input type="button" name="btnsave" id="btnsave3" value="<b:message key="catalog_view_jsp.add_sub_catalog"/>" class="button" onclick="addSubCatalog();"><%-- 新增子目录 --%>
			<input type="button" name="btnsave" id="btnsave4" value="<b:message key="catalog_view_jsp.add_sibling_catalog"/>" class="button" onclick="addBrotherCatalog();"><%-- 新增同级目录 --%>
			<input type="button" name="btnsave" id="btnsave5" value="<b:message key="catalog_view_jsp.sub_catalog_sort"/>" class="button" onclick="sortChildrenCatalog();"><%-- 子目录排序 --%>
		</td></tr>
		</table>
	</td>
  </tr>
</table>
</body>
<script>
window.onload=function(){
	if(isFF) {
		$id("buttonPositionID").style.top=$id("spanPositionID").offsetTop + "px";
	}	
};
</script>
</html>