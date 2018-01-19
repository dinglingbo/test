<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_catalog/common/common_catalog.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String process_mgr_permission = ResourcesMessageUtil.getI18nResourceMessage("mdf_catalog_jsp.process_mgr_permission");
String process_composer_permission = ResourcesMessageUtil.getI18nResourceMessage("mdf_catalog_jsp.process_composer_permission");
String process_setting_permission = ResourcesMessageUtil.getI18nResourceMessage("mdf_catalog_jsp.process_setting_permission");
String resource_mgr_permission = ResourcesMessageUtil.getI18nResourceMessage("mdf_catalog_jsp.resource_mgr_permission");
String resource_use_permission = ResourcesMessageUtil.getI18nResourceMessage("mdf_catalog_jsp.resource_use_permission");
String organization = ResourcesMessageUtil.getI18nResourceMessage("mdf_catalog_jsp.organization"); 
 %>

<html>
<!-- 
  - Author(s): Administrator
  - Date: 2009-06-26 15:53:37
  - Description:
-->
<head>
<title>AddCatalog</title>
<script>
	var _save_select_node = null;
	var _save_select_node_id = null;
	function saveCatalog(){
		hiddenResponseMessage($id("ResponseMessage"));
		var frm = $name("catalogForm");
		if(!checkForm(frm)) {
    		return false;
    	}
		$id("btnsave").disabled="disabled";
		//调用业务流
        var myAjax = new Ajax("com.primeton.bps.web.bizcatalog.bizcatalogmgr.addCatalog.biz");
		myAjax.submitForm("catalogForm");
		var isSuc =myAjax.getValue("root/data/RtnMsg/code"); 
		if(isSuc==1){
			//showMessage($id("ResponseMessage"),"业务目录修改成功");
			//刷新树菜单
			var selectNode = getSelectNode();
			var selectParentNode = getSelectParentNode();
			_save_select_node_id = selectNode.getProperty("catalogUuid");
			selectParentNode.reloadChild(afterSaveReload);
			
			//curNode.selected();
			//并跳转到View页面
			//curNode.cell.click;
			//window.location.href = "com.primeton.bps.web.bizcatalog.CatalogMgr.flow?_eosFlowAction=view&WFBizCatalogInfo/catalogUuid=<b:write property="WFBizCatalogInfo/catalogUuid" />";
		}else{
			showMessage($id("ResponseMessage"),myAjax.getValue("root/data/RtnMsg/name"));
		}
		$id("btnsave").disabled="";
	}
	
	function afterSaveReload(pNode){
		var curNode = getCurNodeByUUIDFromParent(pNode,_save_select_node_id);
		curNode.selected();
		_clickEvent_common(curNode.cell);
	}
	
	function go2View(){
		window.location.href = "com.primeton.bps.web.bizcatalog.CatalogMgr.flow?_eosFlowAction=view&WFBizCatalogInfo/catalogUuid=<b:write property="WFBizCatalogInfo/catalogUuid" />";
	}
	
	function init(){
		initOnePermission("WFBizCatalogInfo/permFlow_Manager","permissionFlow_Manager");
		<l:equal property="hasFLOWCUST" targetValue="TRUE" ignoreCase="true">
		initOnePermission("WFBizCatalogInfo/permFlow_Custom","permissionFlow_Custom");
		initOnePermission("WFBizCatalogInfo/permFlow_Config","permissionFlow_Config");
		initOnePermission("WFBizCatalogInfo/permResource_Manager","permissionResource_Manager");
		initOnePermission("WFBizCatalogInfo/permResource_Use","permissionResource_Use");
		</l:equal>
	}
	
	function initOnePermission(pname,oname){
		var p0 = $id(pname).value;
		var oSel = $id(oname);
		var perm = p0.split(";");
		for(var i=0;i<perm.length;i++){
			if(perm[i]!=""){
				var permitem = perm[i].split(",");
				var permvalue = permitem[0]+","+permitem[1]+","+permitem[2];
				_addSelectOption_common(oSel,permitem[1],permvalue,false);
			}
		}
	}
	
	function addPermission(oTree,oSel){
		hiddenResponseMessage($id("ResponseMessage"));
		var curNode = oTree.getSelectNode();
		if(curNode==null){
			showMessage($id("ResponseMessage"),"<b:message key="mdf_catalog_jsp.select_permission"/>");//请选择要添加的权限
			return;
		}
		if(!curNode.isRootNode()){
			var nodeType = curNode.getProperty("typeCode");
			if(nodeType!="_PARTITYPE_"){
				var nodeName = curNode.getProperty("name");
				var nodeID = curNode.getProperty("id");
				var val = nodeID+","+nodeName+","+nodeType;
				if(!isSelected(oSel,val)){
					_addSelectOption_common(oSel,nodeName,val,false);
					buildString(oSel);
				}else{
					showMessage($id("ResponseMessage"),"<b:message key="mdf_catalog_jsp.permission_exist"/>");//所选权限已存在
				}
			}
		}
	}
	
	function delPermission(oSel){
		hiddenResponseMessage($id("ResponseMessage"));
		if(oSel.selectedIndex!=-1){
     		//oSel.remove(oSel[oSel.selectedIndex]);  
     		oSel.options[oSel.selectedIndex] = null; 
     		buildString(oSel);
    	}else{
        	showMessage($id("ResponseMessage"),"<b:message key="mdf_catalog_jsp.select_del_permission"/>");//请选择要删除的权限
     	}
	}
	
	function delAllPermission(oSel){
		hiddenResponseMessage($id("ResponseMessage"));
		var len = oSel.length;
		for(var i = oSel.options.length - 1; i >= 0; i--) { 
			oSel.remove(i);
　　　　	}
		buildString(oSel);
	}
	
	function isSelected(oSel,val){
		var len = oSel.length;
		for(var i=0; i<len; i++){
			if(oSel[i].value==val){ return true;}
　　　　	}
		return false;
	}
	
	function buildString(oSel){
		var str = "";
		var len = oSel.options.length;
		for(var i=0; i<len; i++){
			str += oSel.options[i].value+";";
　　　　	}
		
		$id(oSel.getAttribute("field")).value = str;
		
		//alert($id("CatalogPermRels/Flow_Manager").value);
	}
	
	function selparam(node) {
		var id = node.getProperty('id') ;
		var type = node.getProperty('typeCode') ;
		return "<type>"+type+"</type><id>"+id+"</id>";
	}
	
	function refreshNode(node) {
		var type = node.getProperty('typeCode') ;
		//alert(type);
		//node.setLeaf();
		setNodeIcon(node,type);

	}
	
	function tnode_dbclick(node){		
		hiddenResponseMessage($id("ResponseMessage"));
		var tid = node.getTree().id;
		if(tid=="orgTree1"){
			addPermission($id('orgTree1'),$id('permissionFlow_Manager'));
		}else if(tid=="orgTree2"){
			addPermission($id('orgTree2'),$id('permissionFlow_Custom'));
		}else if(tid=="orgTree3"){
			addPermission($id('orgTree3'),$id('permissionFlow_Config'));
		}else if(tid=="orgTree4"){
			addPermission($id('orgTree4'),$id('permissionResource_Manager'));
		}else if(tid=="orgTree5"){
			addPermission($id('orgTree5'),$id('permissionResource_Use'));
		}
		
	}
	
	function tsel_dbclick(obj){
		delPermission(obj);
	}
	
	function tnode_click(obj){
		hiddenResponseMessage($id("ResponseMessage"));
	}
	
	function initiFrame(){
		init();
		
		if (isFF) {
			var height = $id('exp').offsetHeight;
			height += 80;
			$id('exp').style.height = height;
		}
	}
</script>
</head>
<body onload="initiFrame()" style="background:#FFFFFF;margin-top:0px;margin-left:0px;margin-buttom:0px;background:url(<%=request.getContextPath()%>/workflow/wfmanager/images/MainFrameBg.gif) no-repeat;overflow:auto;">
<div id="ResponseMessage" class="response_message" style="display:none;" onclick="hiddenResponseMessage(this)"></div>
<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
  <tr> 
    <td class="workarea_title" valign="middle"><h3><b:message key="mdf_catalog_jsp.modify_busi_catalog"/></h3></td><!-- 修改业务目录 -->
  </tr>
  <tr> 
    <td width="100%">
	<form id="catalogForm" name="catalogForm">
		<h:hidden property="WFBizCatalogInfo/catalogUuid" />
    	<h:hidden property="WFBizCatalogInfo/parentCatalogUuid" />
    	<h:hidden property="WFBizCatalogInfo/isLeaf" />
    	<h:hidden property="WFBizCatalogInfo/permFlow_Manager" id="WFBizCatalogInfo/permFlow_Manager" />
        <h:hidden property="WFBizCatalogInfo/permFlow_Custom" id="WFBizCatalogInfo/permFlow_Custom" />
        <h:hidden property="WFBizCatalogInfo/permFlow_Config" id="WFBizCatalogInfo/permFlow_Config" />
        <h:hidden property="WFBizCatalogInfo/permResource_Manager" id="WFBizCatalogInfo/permResource_Manager" />
        <h:hidden property="WFBizCatalogInfo/permResource_Use" id="WFBizCatalogInfo/permResource_Use" />
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="form_table">
	    <tr>
			<td class="form_label" width="20%"><b:message key="mdf_catalog_jsp.busi_catalog_name"/></td><!-- 业务目录名称 -->
			<td>
				<h:text property="WFBizCatalogInfo/catalogName" onblur="checkInput(this)" validateAttr="allowNull=false;maxLength=20;type=bpscommname" size="64" onkeydown="if (event.keyCode==13) return false;"/>
			</td>
		</tr>
		<tr>
			<td class="form_label" width="20%"><b:message key="mdf_catalog_jsp.busi_catalog_desc"/></td><!-- 业务目录描述 -->
			<td width="80%">
				<h:textarea property="WFBizCatalogInfo/demo" cols="80" rows="3" validateAttr="maxLength=170" onblur="checkInput(this)" onfocus="hiddenResponseMessage($id('ResponseMessage'))"/>
			</td>
		</tr>
		</table>
	</form>
	</td>
  </tr>
  <tr> 
	<td width="100%">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td colspan="2">
						<w:tabPanel bodyStyle="" defaultTab="Flow_Manager" height="100%" id="permission" titleStyle="" width="100%">
					  		<w:tabPage cache="true" id="Flow_Manager" tabType="div" title="<%=process_mgr_permission %>"><!-- 流程管理权限 -->
					  			<table>
					                 <tr>
						                 <td width="45%"><b:message key="mdf_catalog_jsp.could_grant"/></td><!-- 可授予 -->
					                     <td width="10%">&nbsp;</td>
					                     <td width="45%"><b:message key="mdf_catalog_jsp.granted"/></td><!-- 已授予 -->
					                 </tr>
					                 <tr height="300px">
					                 	<td style="width:300px;border:1px solid #75B5C3;">
											<div id="orgTreediv1" style="width:100%;height:100%;overflow:auto;overflow-x:auto;overflow-y: auto;float: left;">
											<nobr>
											<r:rtree hasRoot="true" id="orgTree1">
												<r:treeRoot display="<%=organization%>" action="com.primeton.bps.web.bizcatalog.bizcatalogpermission.selectParticipants.biz" 
													childEntities="participants" icon="/workflow/wfcomponent/web/images/participant/process_eos.gif"/><!-- 组织机构 -->
												<r:treeNode action="com.primeton.bps.web.bizcatalog.bizcatalogpermission.selectChilds.biz" showField="name" 
													onRefreshFunc="refreshNode" initParamFunc="selparam" nodeType="participants" childEntities="participants" 
													icon="/workflow/wfcomponent/web/images/participant/role_view.gif,/workflow/wfcomponent/web/images/participant/role_view.gif" 
													onDblclickFunc="tnode_dbclick" onClickFunc="tnode_click"/>
											</r:rtree>
											</nobr>
											</div>
						                 </td>
					                     <td>
						                 	<input type ="button" class="button" value="<b:message key="mdf_catalog_jsp.add_to"/>" id="btnDowm" onclick="addPermission($id('orgTree1'),$id('permissionFlow_Manager'))" style="width:65" /><br/><!-- 增加到&gt;&gt; -->
					                     	<br/><br/><br/>
					                     	<input type ="button" class="button" value="<b:message key="mdf_catalog_jsp.delete"/>" id="btnUp1" onclick="delPermission($id('permissionFlow_Manager'))" style="width:65" /><!-- 删除 -->
											<input type ="button" class="button" value="<b:message key="mdf_catalog_jsp.delete_all"/>" id="btnUp2" onclick="delAllPermission($id('permissionFlow_Manager'))" style="width:65" /> <br /><!-- 全部删除 -->
					                     	
					                     </td>
					                     <td style="width:300px;border:1px solid #75B5C3;">
					                     	<select id="permissionFlow_Manager" size="20" style="width:100%" field="WFBizCatalogInfo/permFlow_Manager" ondblclick="tsel_dbclick(this)" onchange="hiddenResponseMessage($id('ResponseMessage'))">
					                     </td>
					                 </tr>
					            </table>
					  		</w:tabPage>
					  		<l:equal property="hasFLOWCUST" targetValue="TRUE" ignoreCase="true">
					  		<w:tabPage cache="true" id="Flow_Custom" tabType="div" title="<%=process_composer_permission %>"><!-- 流程定制权限 -->
					  			<table>
					                 <tr>
						                 <td width="45%"><b:message key="mdf_catalog_jsp.could_grant"/></td><!-- 可授予 -->
					                     <td width="10%">&nbsp;</td>
					                     <td width="45%"><b:message key="mdf_catalog_jsp.granted"/></td><!-- 已授予 -->
					                 </tr>
					                 <tr height="300px">
					                 	<td style="width:300px;border:1px solid #75B5C3;">
											<div id="orgTreediv2" style="width:100%;height:100%;overflow:auto;overflow-x:auto;overflow-y: auto;float: left;">
											<nobr>
											<r:rtree hasRoot="true" id="orgTree2">
												<r:treeRoot display="<%=organization%>" action="com.primeton.bps.web.bizcatalog.bizcatalogpermission.selectParticipants.biz" childEntities="participants" icon="/workflow/wfcomponent/web/images/participant/process_eos.gif"/><!-- 组织机构 -->
												<r:treeNode action="com.primeton.bps.web.bizcatalog.bizcatalogpermission.selectChilds.biz" showField="name" onRefreshFunc="refreshNode" initParamFunc="selparam" nodeType="participants" childEntities="participants" icon="/workflow/wfcomponent/web/images/participant/role_view.gif,/workflow/wfcomponent/web/images/participant/role_view.gif" onDblclickFunc="tnode_dbclick" onClickFunc="tnode_click"/>
											</r:rtree>
											</nobr>
											</div>
						                 </td>
					                     <td>
						                 	<input type ="button" class="button" value="<b:message key="mdf_catalog_jsp.add_to"/>" id="btnDowm" onclick="addPermission($id('orgTree2'),$id('permissionFlow_Custom'))" style="width:65" /><br/><!-- 增加到&gt;&gt; -->
					                     	<br/><br/><br/>
					                     	<input type ="button" class="button" value="<b:message key="mdf_catalog_jsp.delete"/>" id="btnUp1" onclick="delPermission($id('permissionFlow_Custom'))" style="width:65" /><!-- 删除 -->
											<input type ="button" class="button" value="<b:message key="mdf_catalog_jsp.delete_all"/>" id="btnUp2" onclick="delAllPermission($id('permissionFlow_Custom'))" style="width:65" /> <br /><!-- 全部删除 -->
					                     	
					                     </td>
					                     <td style="width:300px;border:1px solid #75B5C3;">
					                     	<select id="permissionFlow_Custom" size="20" style="width:100%" field="WFBizCatalogInfo/permFlow_Custom" ondblclick="tsel_dbclick(this)" onchange="hiddenResponseMessage($id('ResponseMessage'))">
					                     </td>
					                 </tr>
					            </table>
					  		</w:tabPage>
					  		<w:tabPage cache="true" id="Flow_Config" tabType="div" title="<%=process_setting_permission %>"><!-- 流程配置权限 -->
					  			<table>
					                 <tr>
						                 <td width="45%"><b:message key="mdf_catalog_jsp.could_grant"/></td><!-- 可授予 -->
					                     <td width="10%">&nbsp;</td>
					                     <td width="45%"><b:message key="mdf_catalog_jsp.granted"/></td><!-- 已授予 -->
					                 </tr>
					                 <tr height="300px">
					                 	<td style="width:300px;border:1px solid #75B5C3;">
											<div id="orgTreediv3" style="width:100%;height:100%;overflow:auto;overflow-x:auto;overflow-y: auto;float: left;">
											<nobr>
											<r:rtree hasRoot="true" id="orgTree3">
												<r:treeRoot display="<%=organization%>" action="com.primeton.bps.web.bizcatalog.bizcatalogpermission.selectParticipants.biz" childEntities="participants" icon="/workflow/wfcomponent/web/images/participant/process_eos.gif"/><!-- 组织机构 -->
												<r:treeNode action="com.primeton.bps.web.bizcatalog.bizcatalogpermission.selectChilds.biz" showField="name" onRefreshFunc="refreshNode" initParamFunc="selparam" nodeType="participants" childEntities="participants" icon="/workflow/wfcomponent/web/images/participant/role_view.gif,/workflow/wfcomponent/web/images/participant/role_view.gif" onDblclickFunc="tnode_dbclick" onClickFunc="tnode_click"/>
											</r:rtree>
											</nobr>
											</div>
						                 </td>
					                     <td>
						                 	<input type ="button" class="button" value="<b:message key="mdf_catalog_jsp.add_to"/>" id="btnDowm" onclick="addPermission($id('orgTree3'),$id('permissionFlow_Config'))" style="width:65" /><br/><!-- 增加到&gt;&gt; -->
					                     	<br/><br/><br/>
					                     	<input type ="button" class="button" value="<b:message key="mdf_catalog_jsp.delete"/>" id="btnUp1" onclick="delPermission($id('permissionFlow_Config'))" style="width:65" /><!-- 删除 -->
											<input type ="button" class="button" value="<b:message key="mdf_catalog_jsp.delete_all"/>" id="btnUp2" onclick="delAllPermission($id('permissionFlow_Config'))" style="width:65" /> <br /><!-- 全部删除 -->
					                     	
					                     </td>
					                     <td style="width:300px;border:1px solid #75B5C3;">
					                     	<select id="permissionFlow_Config" size="20" style="width:100%" field="WFBizCatalogInfo/permFlow_Config" ondblclick="tsel_dbclick(this)" onchange="hiddenResponseMessage($id('ResponseMessage'))">
				                     	 </td>
					                 </tr>
					            </table>
					  		</w:tabPage>
					  		<w:tabPage cache="true" id="Resource_Manager" tabType="div" title="<%=resource_mgr_permission %>"><!-- 资源管理权限 -->
					  			<table>
					                 <tr>
						                 <td width="45%"><b:message key="mdf_catalog_jsp.could_grant"/></td><!-- 可授予 -->
					                     <td width="10%">&nbsp;</td>
					                     <td width="45%"><b:message key="mdf_catalog_jsp.granted"/></td><!-- 已授予 -->
					                 </tr>
					                 <tr height="300px">
					                 	<td style="width:300px;border:1px solid #75B5C3;">
											<div id="orgTreediv4" style="width:100%;height:100%;overflow:auto;overflow-x:auto;overflow-y: auto;float: left;">
											<nobr>
											<r:rtree hasRoot="true" id="orgTree4">
												<r:treeRoot display="<%=organization%>" action="com.primeton.bps.web.bizcatalog.bizcatalogpermission.selectParticipants.biz" childEntities="participants" icon="/workflow/wfcomponent/web/images/participant/process_eos.gif"/><!-- 组织机构 -->
												<r:treeNode action="com.primeton.bps.web.bizcatalog.bizcatalogpermission.selectChilds.biz" showField="name" onRefreshFunc="refreshNode" initParamFunc="selparam" nodeType="participants" childEntities="participants" icon="/workflow/wfcomponent/web/images/participant/role_view.gif,/workflow/wfcomponent/web/images/participant/role_view.gif" onDblclickFunc="tnode_dbclick" onClickFunc="tnode_click"/>
											</r:rtree>
											</nobr>
											</div>
						                 </td>
					                     <td>
						                 	<input type ="button" class="button" value="<b:message key="mdf_catalog_jsp.add_to"/>" id="btnDowm" onclick="addPermission($id('orgTree4'),$id('permissionResource_Manager'))" style="width:65" /><br/><!-- 增加到&gt;&gt; -->
					                     	<br/><br/><br/>
					                     	<input type ="button" class="button" value="<b:message key="mdf_catalog_jsp.delete"/>" id="btnUp1" onclick="delPermission($id('permissionResource_Manager'))" style="width:65" /><!-- 删除 -->
											<input type ="button" class="button" value="<b:message key="mdf_catalog_jsp.delete_all"/>" id="btnUp2" onclick="delAllPermission($id('permissionResource_Manager'))" style="width:65" /> <br /><!-- 全部删除 -->
					                     	
					                     </td>
					                     <td style="width:300px;border:1px solid #75B5C3;">
					                     	<select id="permissionResource_Manager" size="20" style="width:100%" field="WFBizCatalogInfo/permResource_Manager" ondblclick="tsel_dbclick(this)" onchange="hiddenResponseMessage($id('ResponseMessage'))">
					                     </td>
					                 </tr>
					            </table>
					  		</w:tabPage>
					  		<w:tabPage cache="true" id="Resource_Use" tabType="div" title="<%=resource_use_permission %>"><!-- 资源使用权限 -->
					  			<table>
					                 <tr>
						                 <td width="45%"><b:message key="mdf_catalog_jsp.could_grant"/></td><!-- 可授予 -->
					                     <td width="10%">&nbsp;</td>
					                     <td width="45%"><b:message key="mdf_catalog_jsp.granted"/></td><!-- 已授予 -->
					                 </tr>
					                 <tr height="300px">
					                 	<td style="width:300px;border:1px solid #75B5C3;">
											<div id="orgTreediv5" style="width:100%;height:100%;overflow:auto;overflow-x:auto;overflow-y: auto;float: left;">
											<nobr>
											<r:rtree hasRoot="true" id="orgTree5">
												<r:treeRoot display="<%=organization%>" action="com.primeton.bps.web.bizcatalog.bizcatalogpermission.selectParticipants.biz" childEntities="participants" icon="/workflow/wfcomponent/web/images/participant/process_eos.gif"/><!-- 组织机构 -->
												<r:treeNode action="com.primeton.bps.web.bizcatalog.bizcatalogpermission.selectChilds.biz" showField="name" onRefreshFunc="refreshNode" initParamFunc="selparam" nodeType="participants" childEntities="participants" icon="/workflow/wfcomponent/web/images/participant/role_view.gif,/workflow/wfcomponent/web/images/participant/role_view.gif" onDblclickFunc="tnode_dbclick" onClickFunc="tnode_click"/>
											</r:rtree>
											</nobr>
											</div>
						                 </td>
					                     <td>
						                 	<input type ="button" class="button" value="<b:message key="mdf_catalog_jsp.add_to"/>" id="btnDowm" onclick="addPermission($id('orgTree5'),$id('permissionResource_Use'))" style="width:65" /><br/><!-- 增加到&gt;&gt; -->
					                     	<br/><br/><br/>
					                     	<input type ="button" class="button" value="<b:message key="mdf_catalog_jsp.delete"/>" id="btnUp1" onclick="delPermission($id('permissionResource_Use'))" style="width:65" /><!-- 删除 -->
											<input type ="button" class="button" value="<b:message key="mdf_catalog_jsp.delete_all"/>" id="btnUp2" onclick="delAllPermission($id('permissionResource_Use'))" style="width:65" /> <br /><!-- 全部删除 -->
					                     	
					                     </td>
					                     <td style="width:300px;border:1px solid #75B5C3;">
					                     	<select id="permissionResource_Use" size="20" style="width:100%" field="WFBizCatalogInfo/permResource_Use" ondblclick="tsel_dbclick(this)" onchange="hiddenResponseMessage($id('ResponseMessage'))">
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
		<input type="button" name="btnsave" id="btnsave" value="<b:message key="mdf_catalog_jsp.save"/>" class="button" onclick="saveCatalog();"><!-- 保存 -->
		<%if("viewPage".equals(request.getParameter("comefrom"))){ %>
			<input type="button" name="btnreturn" id="btnreturn" value="<b:message key="mdf_catalog_jsp.back"/>" class="button" onclick="go2View();"><!-- 返回 -->
		<%} %>
		</td></tr>
		</table>
	</td>
  </tr>
</table>
<div id="exp"/>
</body>
</html>