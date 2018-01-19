<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_composer/common/common_composer.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2009-07-27 16:00:32
  - Description:
-->
<head>
<title><b:message key="catalog_bizvar_info_jsp.biz_var_main"/></title>
<script>
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
</script>
</head>
<body>
<form name="dataform1" action="com.primeton.bps.web.composer.bizresouce.CatalogBizVarMgr.flow" target="_self" method="post">
	<input type="hidden" name="_eosFlowAction" value="save" />
	<h:hidden property="permType" />
	<h:hidden property="bizviewobj/busivarUUID" />
	<h:hidden name="bizviewobj/catalogUUID" property="queryViewObject/catalogUUID"/>
	<h:hidden property="bizviewobj/mdfState" value="9" />
	<h:hidden property="bizviewobj/busivarScope" value="00000000" />
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
		<l:empty property="bizoptviewobj/busioptUUID"><h3><b:message key="catalog_bizvar_info_jsp.add_biz_var"/></h3></l:empty><!-- 新增业务变量 -->
		<l:notEmpty property="bizoptviewobj/busioptUUID"><h3><b:message key="catalog_bizvar_info_jsp.edit_biz_var"/></h3></l:notEmpty><!-- 修改业务变量 -->
    	</td>
  	</tr>
  	<tr> 
    	<td width="100%">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="form_table">	
			<tr>
				<td class="form_label" width="20%"><b:message key="catalog_bizvar_list_jsp.biz_var_name"/></td>
				<td>
					<h:text property="bizviewobj/busivarName" size="70" onblur="checkInput(this)" validateAttr="allowNull=false;maxLength=20;type=bpscommname"/>
				</td>
			</tr>
			<tr>
				<td class="form_label"><b:message key="catalog_bizvar_list_jsp.biz_var_xpath"/></td>
				<td><h:text property="bizviewobj/busivarImpl" size="70" onblur="checkInput(this)" validateAttr="maxLength=128;type=bpscommxpath"/>
				</td>
			</tr>
			<tr>
				<td class="form_label"><b:message key="catalog_bizvar_list_jsp.biz_var_desc"/></td>
				<td><h:textarea property="bizviewobj/mark" style="width:380" rows="5" validateAttr="maxLength=170" onblur="checkInput(this)"/></td>
			</tr>

			<tr>
				<td colspan="2">
				<input id="btnSave" name="btnSave" type="button" value='<b:message key="permission_common.btn_save"/>' class="button" onclick="doSave()">
				<input id="btnBack" name="btnBack" type="button" value='<b:message key="permission_common.btn_back"/>' onclick="go2List();" class="button">
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</form>
</body>
</html>
