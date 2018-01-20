<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_composer/common/common_composer.jsp" %>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String procEdit = ResourcesMessageUtil.getI18nResourceMessage("biz_process_add_jsp.proc_edit");
%>
<html>
<!-- 
  - Author(s): bps
  - Date: 2009-07-24 11:30:13
  - Description:
-->
<head>
<title><b:message key="biz_process_add_jsp.title"/></title>
<script>
	function f_check_defname(obj){
		var str = obj.value;
        var reg = /^[a-zA-Z_]{1}([a-zA-Z0-9_]|[.]){0,254}([a-zA-Z0-9_])$/;
        var reg2 = /^[a-zA-Z_]{1}([a-zA-Z0-9_]){0,1}$/;
        if(str.length<2){
        	if(!reg2.test(str)){
	            f_alert(obj,'<b:message key="biz_process_add_jsp.check_define1"/>');
	            return false;
	        } 
        }else{
	        if(!reg.test(str)){
	            f_alert(obj,'<b:message key="biz_process_add_jsp.check_define2"/>');
	            return false;
	        } 
        }
        return true;
    }
</script>
</head>
<body>
<div id="ResponseMessage" class="response_message" style="display:none;" onclick="hiddenResponseMessage(this)"></div>
  <form id="saveform" name="saveform" action="com.primeton.bps.web.composer.bizflowmgr.bizProcessCustomMgr.flow" target="_self" method="post">
    <input type="hidden" name="_eosFlowAction" value="save"/>
    <h:hidden property="queryCatalogUUID"/>
    <h:hiddendata property="page" />
    <h:hidden property="treeType"/>
    <h:hidden property="permType"/>
    <h:hidden name="processDef/catalogUUID" property="queryCatalogUUID"/>
<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
  <tr>
  	<td class="workarea_title" valign="middle"><h3><b:message key="biz_process_add_jsp.title"/></h3></td>
  </tr>
  <tr> 
   	<td width="100%" >
   	<table class="EOS_TABLE" width="100%" >    
      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="form_table">
        <tr>
          <td class="form_label" width="20%">
            <b:message key="biz_process_add_jsp.current_catalog"/>
          </td>
          <td colspan="1">
          	<b:write property="pathName"/>
          </td>
        </tr>
        <tr>
          <td class="form_label">
            <b:message key="biz_process_add_jsp.biz_proc_name"/>
          </td>
          <td colspan="1">
            <h:text property="processDef/processDefCHName" validateAttr="allowNull=false;maxLength=85;type=bpscommname" style="width:50%" onblur="checkInput(this)"/>
          </td>
        </tr>
        <tr>
          <td class="form_label">
            <b:message key="biz_process_add_jsp.biz_proc_def"/>
          </td>
          <td colspan="1">
            <h:text property="processDef/processDefName" validateAttr="allowNull=false;maxLength=256;type=defname" style="width:50%" onblur="checkInput(this)" />
          </td>
        </tr>
        <tr>
          <td class="form_label">
            <b:message key="biz_process_add_jsp.biz_proc_desc"/>
          </td>
          <td colspan="1">
            <h:textarea property="processDef/description" validateAttr="allowNull=true;maxLength=170" style="width:50%" rows="5" onblur="checkInput(this)"/>
          </td>
        </tr>
        <tr>
          <td colspan="2">
            <input name="btnSave" type="button" value='<b:message key="biz_process_add_jsp.btn_save"/>' onclick="javascript:doSave()" class="button" id="save">
            <input name="btnEdit" type="button" value='<b:message key="biz_process_add_jsp.btn_save_edit"/>' onclick="saveAndEdit()" class="button" id="save_edit">
            <input id="btnBack" name="btnBack" type="button" value='<b:message key="biz_process_add_jsp.btn_back"/>' onclick="go2List();" class="button">
          </td>
        </tr>
      </table>
  </form>
</body>
</html>
<script>
	var locale ='<b:write property="language" scope="session"/>';
	var hasForm ='<b:write property="hasForm" scope="session"/>';
    function saveAndEdit() {
      var frm = $name("saveform");
	  if(!checkForm($name(frm))) {
		return false;
	  }
     $id("save").disabled="disabled";
     $id("save_edit").disabled="disabled";
      var myAjax = new Ajax("com.primeton.bps.web.composer.bizflowmgr.bizprocessmgr.saveProcessDefinebiz.biz");
      if($name("processDef/catalogUUID").value=="99999"){
      	$name("processDef/catalogUUID").value="-1";
      }
      myAjax.submitForm('saveform'); 
      var isSuc =myAjax.getValue("root/data/RtnMsg/code");
      if(isSuc==1){
		  //刷新树菜单
		  refreshSelectNode();
	      var processDefID =myAjax.getValue("root/data/processDef/processDefID");
	      if (processDefID == null) processDefID = "";
	      var processDefName =myAjax.getValue("root/data/processDef/processDefName");
	      var processDefCHName =myAjax.getValue("root/data/processDef/processDefCHName");
	      var description =myAjax.getValue("root/data/processDef/description");
	      var catalogUUID =myAjax.getValue("root/data/processDef/catalogUUID");
	      if (catalogUUID == null) catalogUUID = "";
	      if(processDefID != "") {
	         //window.close();
	         $id("save").disabled=true;
	         $id("save_edit").disabled=true;
	         
	         var pageURL = "<%=request.getContextPath()%>/workflow/bps_composer/flex/bizProcessCustomDg.jsp?hasForm="+hasForm+"&locale="+locale+"&processDefID="+ processDefID 
	                   + "&processDefName=" + processDefName 
	                   +"&processDefCHName=" + processDefCHName 
	                   +"&description=" + description
	                   +"&catalogUUID=" + catalogUUID
	                   +"&author=" + '<b:write property="userObject/userName" scope="session"/>';
	         
	         var argument = "height ="+(window.screen.availHeight-40)+",width="+(window.screen.availWidth-40)+", top=0,left=0,toolbar=no,menubar=no,scrollbars=no,resizable=yes,location=no,status=no";
	         window.open(encodeURI(pageURL),"<%=procEdit%>",argument); //流程编辑
	      }
	  }else{
		 showMessage($id("ResponseMessage"),myAjax.getValue("root/data/RtnMsg/name"));
	  }
	  $id("save").disabled="";
	  $id("save_edit").disabled="";
    }
    
    function doSave() {
      var frm = $name("saveform");
	  if(!checkForm($name(frm))) {
		return false;
	  }
	$id("save").disabled="disabled";
	$id("save_edit").disabled="disabled";
      var myAjax = new Ajax("com.primeton.bps.web.composer.bizflowmgr.bizprocessmgr.saveProcessDefinebiz.biz");
      if($name("processDef/catalogUUID").value=="99999"){
      	$name("processDef/catalogUUID").value="-1";
      }
      myAjax.submitForm('saveform'); 
      var isSuc =myAjax.getValue("root/data/RtnMsg/code");
      if(isSuc==1){
		  //刷新树菜单
		  refreshSelectNode();
		  go2List();
	  }else{
		 showMessage($id("ResponseMessage"),myAjax.getValue("root/data/RtnMsg/name"));
	  }
	  $id("save").disabled="";
	  $id("save_edit").disabled="";
    }
    
    function go2List() {
      var frm = $id("saveform");
      frm.elements["_eosFlowAction"].value = "pageQuery";
      frm.submit();
    }
</script>