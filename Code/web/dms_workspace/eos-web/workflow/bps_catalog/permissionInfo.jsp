<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_catalog/common/common_catalog.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>

<%
String busicatalog = ResourcesMessageUtil.getI18nResourceMessage("permission_info_jsp.business_catalog");

String process_mgr_permission = ResourcesMessageUtil.getI18nResourceMessage("permission_info_jsp.process_mgr_permission");
String process_composer_permission = ResourcesMessageUtil.getI18nResourceMessage("permission_info_jsp.process_composer_permission");
String process_setting_permission = ResourcesMessageUtil.getI18nResourceMessage("permission_info_jsp.process_setting_permission");
String resource_mgr_permission = ResourcesMessageUtil.getI18nResourceMessage("permission_info_jsp.resource_mgr_permission");
String resource_use_permission = ResourcesMessageUtil.getI18nResourceMessage("permission_info_jsp.resource_use_permission");
 %>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2009-09-23 17:25:03
  - Description:
-->
<head>
<title>permissionInfo</title>
<script>
	function savePermission(){
		hiddenResponseMessage(window.parent.document.getElementById("AlertMessage"));
		
		setFormData("PERM_0","catalogUUIDs[1]");
		<l:equal property="hasFLOWCUST" targetValue="TRUE" ignoreCase="true">
		setFormData("PERM_1","catalogUUIDs[2]");
		setFormData("PERM_2","catalogUUIDs[3]");
		setFormData("PERM_3","catalogUUIDs[4]");
		setFormData("PERM_4","catalogUUIDs[5]");
		</l:equal>

		var myAjax = new Ajax("com.primeton.bps.web.bizcatalog.bizcatalogmgr.saveCatalogRelations.biz");
		myAjax.submitForm("saveForm"); 
		var isSuc =myAjax.getValue("root/data/result");
		
		if(isSuc=="true"){
			showMessage(window.parent.document.getElementById("AlertMessage"),"<b:message key="permission_info_jsp.save_success"/>");//保存成功
		}else{
			showMessage(window.parent.document.getElementById("AlertMessage"),"<b:message key="permission_info_jsp.save_failed"/>");//保存失败，请查看日志
		}
	}
	
	function setFormData(treeID,vObjName){
		var catloguuidString0 = "";
		var tree0 = $id(treeID);
		var checklist0 = tree0.getCheckedList();
		var entitys0 = checklist0[0];
		
		for(i=0;i<entitys0.list.length;i++){
			catloguuidString0 += entitys0.list[i].getProperty("catalogUuid")+";";
		}
		
		$name(vObjName).value=catloguuidString0;
	}
</script>
</head>
<body style="background:#FFFFFF;margin-top:0px;margin-left:0px;margin-buttom:0px;background:url(<%=request.getContextPath()%>/workflow/wfmanager/images/MainFrameBg.gif) no-repeat;overflow:auto;">
<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%" height="100%">
  <tr> 
    <td class="workarea_title" valign="middle"><h3><b:message key="permission_info_jsp.check_catalog"/></h3></td><!-- 勾选需要赋权限的目录 -->
  </tr>
  <tr> 
    <td width="100%">
		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td colspan="2">
					<w:tabPanel bodyStyle="" defaultTab="Flow_Manager" height="100%" id="permission" titleStyle="" width="100%">
				  		<w:tabPage cache="true" id="Flow_Manager" tabType="div" title="<%=process_mgr_permission %>"><!-- 流程管理权限 -->
				  			<table>
				                 <tr height="295px">
					                 <td style="width:300px;border:1px solid #75B5C3;">
										<div id="orgTreediv1" style="width:100%;height:100%;overflow:auto;overflow-x:auto;overflow-y: auto;float: left;">
										
											<w:tree id="PERM_0" hasCheckBox="true" >
									            <w:treeRoot display="<%=busicatalog %>"></w:treeRoot><!-- 业务目录 -->
									            <w:treeNode nodeType="WFBizCatalogInfo" showField="catalogName" xpath="catalogList">
									                <w:treeRelation parentNodeType="root" field="parentCatalogUuid" value="1" />
									                <w:treeRelation parentNodeType="WFBizCatalogInfo" field="parentCatalogUuid" parentField="catalogUuid" />
									                <w:treeCheckbox field="catalogUuid" checkedXpath="selectList0" checkedField="catalogUUID" />
									            </w:treeNode>
									        </w:tree>
										</div>
					                 </td>
				                 </tr>
				            </table>
				  		</w:tabPage>
				  		<l:equal property="hasFLOWCUST" targetValue="TRUE" ignoreCase="true">
				  		<w:tabPage cache="true" id="Flow_Custom" tabType="div" title="<%=process_composer_permission %>"><!-- 流程定制权限 -->
				  			<table>
				                 <tr height="295px">
					                 <td style="width:300px;border:1px solid #75B5C3;">
										<div id="orgTreediv2" style="width:100%;height:100%;overflow:auto;overflow-x:auto;overflow-y: auto;float: left;">
										<nobr>
											<w:tree id="PERM_1" hasCheckBox="true" >
									            <w:treeRoot display="<%=busicatalog %>"></w:treeRoot><!-- 业务目录 -->
									            <w:treeNode nodeType="WFBizCatalogInfo" showField="catalogName" xpath="catalogList">
									                <w:treeRelation parentNodeType="root" field="parentCatalogUuid" value="1" />
									                <w:treeRelation parentNodeType="WFBizCatalogInfo" field="parentCatalogUuid" parentField="catalogUuid" />
									                <w:treeCheckbox field="catalogUuid" checkedXpath="selectList1" checkedField="catalogUUID" />
									            </w:treeNode>
									        </w:tree>
										</nobr>
										</div>
					                 </td>
				                 </tr>
				            </table>
				  		</w:tabPage>
				  		<w:tabPage cache="true" id="Flow_Config" tabType="div" title="<%=process_setting_permission %>"><!-- 流程配置权限 -->
				  			<table>
				                 <tr height="295px">
					                 <td style="width:300px;border:1px solid #75B5C3;">
										<div id="orgTreediv3" style="width:100%;height:100%;overflow:auto;overflow-x:auto;overflow-y: auto;float: left;">
										<nobr>
											<w:tree id="PERM_2" hasCheckBox="true" >
									            <w:treeRoot display="<%=busicatalog %>"></w:treeRoot><!-- 业务目录 -->
									            <w:treeNode nodeType="WFBizCatalogInfo" showField="catalogName" xpath="catalogList">
									                <w:treeRelation parentNodeType="root" field="parentCatalogUuid" value="1" />
									                <w:treeRelation parentNodeType="WFBizCatalogInfo" field="parentCatalogUuid" parentField="catalogUuid" />
									                <w:treeCheckbox field="catalogUuid" checkedXpath="selectList2" checkedField="catalogUUID" />
									            </w:treeNode>
									        </w:tree>
										</nobr>
										</div>
					                 </td>
				                 </tr>
				            </table>
				  		</w:tabPage>
				  		<w:tabPage cache="true" id="Resource_Manager" tabType="div" title="<%=resource_mgr_permission %>"><!-- 资源管理权限 -->
				  			<table>
				                 <tr height="295px">
					                 <td style="width:300px;border:1px solid #75B5C3;">
										<div id="orgTreediv4" style="width:100%;height:100%;overflow:auto;overflow-x:auto;overflow-y: auto;float: left;">
										<nobr>
											<w:tree id="PERM_3" hasCheckBox="true" >
									            <w:treeRoot display="<%=busicatalog %>"></w:treeRoot><!-- 业务目录 -->
									            <w:treeNode nodeType="WFBizCatalogInfo" showField="catalogName" xpath="catalogList">
									                <w:treeRelation parentNodeType="root" field="parentCatalogUuid" value="1" />
									                <w:treeRelation parentNodeType="WFBizCatalogInfo" field="parentCatalogUuid" parentField="catalogUuid" />
									                <w:treeCheckbox field="catalogUuid" checkedXpath="selectList3" checkedField="catalogUUID" />
									            </w:treeNode>
									        </w:tree>
										</nobr>
										</div>
					                 </td>
				                 </tr>
				            </table>
				  		</w:tabPage>
				  		<w:tabPage cache="true" id="Resource_Use" tabType="div" title="<%=resource_use_permission %>"><!-- 资源使用权限 -->
				  			<table>
				                 <tr height="295px">
					                 <td style="width:300px;border:1px solid #75B5C3;">
										<div id="orgTreediv5" style="width:100%;height:100%;overflow:auto;overflow-x:auto;overflow-y: auto;float: left;">
										<nobr>
											<w:tree id="PERM_4" hasCheckBox="true" >
									            <w:treeRoot display="<%=busicatalog %>"></w:treeRoot><!-- 业务目录 -->
									            <w:treeNode nodeType="WFBizCatalogInfo" showField="catalogName" xpath="catalogList">
									                <w:treeRelation parentNodeType="root" field="parentCatalogUuid" value="1" />
									                <w:treeRelation parentNodeType="WFBizCatalogInfo" field="parentCatalogUuid" parentField="catalogUuid" />
									                <w:treeCheckbox field="catalogUuid" checkedXpath="selectList4" checkedField="catalogUUID" />
									            </w:treeNode>
									        </w:tree>
										</nobr>
										</div>
					                 </td>
				                 </tr>
				            </table>
				  		</w:tabPage>
				  		</l:equal>
					</w:tabPanel>
				</td>
			</tr> 
		</table>
	</td>
   </tr>
   <tr>
	<td>
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="form_table">
	    <tr><td>
			<input type="button" name="btnsave" id="btnsave" value="<b:message key="permission_info_jsp.save"/>" class="button" onclick="savePermission();"><!-- 保存 -->
		</td></tr>
		</table>
	</td>
  </tr>
</table>
<div id="exp"/>
</body>
<form id="saveForm" name="saveForm">
	<input type="hidden" name="catalogPerm/partiType" value="<b:write property="participantType"/>"/>
	<input type="hidden" name="catalogPerm/partiName" value="<b:write property="participantName"/>"/>
	<input type="hidden" name="catalogPerm/partiID" value="<b:write property="participantID"/>"/>
	<input type="hidden" name="catalogUUIDs[1]" value=""/>
	<input type="hidden" name="catalogUUIDs[2]" value=""/>
	<input type="hidden" name="catalogUUIDs[3]" value=""/>
	<input type="hidden" name="catalogUUIDs[4]" value=""/>
	<input type="hidden" name="catalogUUIDs[5]" value=""/>
</form>
</html>