<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_composer/common/common_composer.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String defaultForm = ResourcesMessageUtil.getI18nResourceMessage("global_bizhtask_info_jsp.default_form");
String pagaFlow = ResourcesMessageUtil.getI18nResourceMessage("global_bizhtask_list_jsp.page_flow");
String webPage = ResourcesMessageUtil.getI18nResourceMessage("global_bizhtask_list_jsp.web_page");
String procForm = ResourcesMessageUtil.getI18nResourceMessage("global_bizhtask_list_jsp.proc_form");
String other = ResourcesMessageUtil.getI18nResourceMessage("global_bizhtask_list_jsp.other");
%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2009-07-27 16:00:32
  - Description:
-->
<head>
<title><b:message key="global_bizhtask_info_jsp.manual_task_main"/></title><!-- 人工任务维护界面 -->
<script>
	var isFormComposerUseable ='false';
	
	function doSave(){
	  var frm = $name("dataform1");
	  if(!checkForm($name(frm))) {
		return false;
	  }
	  if($name("bizviewobj/mdfState").value!="9"){
		  	$name("bizviewobj/mdfState").value="1";
	  }
      frm.submit();
	}
	
	function go2List(){
	  var frm = $name("dataform1");
	  frm.elements["_eosFlowAction"].value = "pageQuery";
      frm.submit();
	}
	
	function callback(retValue){
		if(retValue){
			$name("bizviewobj/humantaskImpl").value = retValue.getProperty("formDefName");
		}
	}
		
	function selectForm(){
		var curCatalogUUID = $name("bizviewobj/catalogUUID").value;
	 	var pageURL = "com.bps.workspace.handler.catalogtree.flow?_eosFlowAction=tree&curCatalogUUID="+curCatalogUUID;
        var argument = "height ="+(window.screen.availHeight-100)+",width="+40+", top=60,left=60,toolbar=no,menubar=no,scrollbars=no,resizable=yes,location=no,status=no"
		showModalCenter(pageURL,null,callback,null,350,'<b:message key="global_bizhtask_info_jsp.select_form_win"/>');//选择表单窗口
	}
	
	window.onload = function(){
		if($name("bizviewobj/humantaskType").value == "bfsform")
			$name("btSelectBFSForm").disabled = false;
		else
			$name("btSelectBFSForm").disabled = true;
	}
	
	function changeTaskType(selectObj){
		if(selectObj.value == 'bfsform'){
			$name("btSelectBFSForm").disabled = false;
		}else {
			$name("btSelectBFSForm").disabled = true;
		}
	}
</script>
</head>
<body>
<form name="dataform1" action="com.primeton.bps.web.composer.bizresouce.CatalogBizHTaskMgr.flow" target="_self" method="post" >
	<input type="hidden" name="_eosFlowAction" value="save" />
	<h:hidden property="permType" />
	<h:hidden property="bizviewobj/humantaskUUID" />
	<h:hidden name="bizviewobj/catalogUUID" property="queryViewObject/catalogUUID"/>
	<h:hidden property="bizviewobj/mdfState" value="9" />
	<h:hiddendata property="page" />
	<h:hiddendata property="queryViewObject" />
<l:present property="ret/code">
	<l:notEqual property="ret/code" targetValue="1">
		<div id="ResponseMessage" class="response_message" onclick="hiddenResponseMessage(this)">&nbsp;&nbsp;<b:write property="ret/name"/>&nbsp;&nbsp;</div>
	</l:notEqual>
</l:present>
	<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
	<tr>
		<td class="workarea_title" valign="middle">
		<l:empty property="bizviewobj/calendarUUID"><h3><b:message key="global_bizhtask_info_jsp.add_manual_task"/></h3></l:empty><!-- 新增人工任务 -->
		<l:notEmpty property="bizviewobj/calendarUUID"><h3><b:message key="global_bizhtask_info_jsp.edit_manual_task"/></h3></l:notEmpty><!-- 修改人工任务 -->
    	</td>
  	</tr>
  	<tr> 
    	<td width="100%">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="form_table">
			<tr>
				<td class="form_label" width="20%"><b:message key="global_bizhtask_list_jsp.manual_task_name"/></td><!-- 人工任务名称 -->
				<td>
					<h:text property="bizviewobj/humantaskName" size="70" onblur="checkInput(this)" validateAttr="allowNull=false;maxLength=20;type=bpscommname"/>
				</td>
			</tr>
			<tr>
				<td class="form_label"><b:message key="global_bizhtask_list_jsp.manual_task_type"/></td><!-- 人工任务类型 -->
				<td>
					<l:equal property="productInfo/productName" targetValue="Primeton Platform" scope="session">
						<h:select name="bizviewobj/humantaskType" style="width:380" property="bizviewobj/humantaskType" onchange="changeTaskType(this)">
							<h:option label="<%=pagaFlow%>" value="pageflow"/><!-- 页面流 -->
							<h:option label="<%=webPage%>" value="webpage"/><!-- web页面 -->
							<l:equal property="isFormComposerUseable" targetValue="true" ignoreCase="true" compareType="string" scope="flow">
								<h:option label="<%=procForm%>" value="bfsform"/><!-- 业务表单 -->
								<script>
									isFormComposerUseable ='true';
								</script>
							</l:equal>
							<h:option label="<%=other%>" value="other"/><!-- 其他... -->
						</h:select>
					</l:equal>
					<l:notEqual property="productInfo/productName" targetValue="Primeton Platform" scope="session">
						<h:select name="bizviewobj/humantaskType" style="width:380" property="bizviewobj/humantaskType" onchange="changeTaskType(this)">
							<h:option label="<%=webPage%>" value="webpage"/><!-- web页面 -->
							<l:equal property="isFormComposerUseable" targetValue="true" ignoreCase="true" compareType="string" scope="flow">
								<h:option label="<%=procForm%>" value="bfsform"/><!-- 业务表单 -->
								<script>
									isFormComposerUseable ='true';
								</script>
							</l:equal>
							<h:option label="<%=other%>" value="other"/><!-- 其他... -->
						</h:select>
					</l:notEqual>
				</td>
			</tr>
			<tr>
				<td class="form_label"><b:message key="global_bizhtask_list_jsp.manual_task_impl"/></td><!-- 人工任务实现 -->
				<td>
				<h:text property="bizviewobj/humantaskImpl" size="70" onblur="checkInput(this)" validateAttr="maxLength=128;" value="<%=defaultForm%>"/><!-- 默认表单 -->
				<input id="btSelectBFSForm" name="btSelectBFSForm" type="button" value='<b:message key="global_bizhtask_info_jsp.select_form"/>' class="button" onclick="selectForm()"><!-- 选择表单 -->
				</td>
			</tr>
			<tr>
				<td class="form_label"><b:message key="global_bizhtask_list_jsp.desc"/></td><!-- 说明 -->
				<td><h:textarea property="bizviewobj/mark" style="width:380" rows="5" validateAttr="maxLength=170" onblur="checkInput(this)"/></td>
			</tr>

			<tr>
				<td colspan="2">
				<input id="btnSave" name="btnSave" type="button" value='<b:message key="permission_common.btn_save"/>' class="button" onclick="doSave()"><!-- 保存 -->
				<input id="btnBack" name="btnBack" type="button" value='<b:message key="permission_common.btn_back"/>' onclick="go2List();" class="button"><!-- 返回 -->
				</td>
			</tr>
		</table>
	</td>
	</tr>
</table>
</form>
</body>
</html>
