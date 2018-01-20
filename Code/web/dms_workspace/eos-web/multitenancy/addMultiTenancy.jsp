<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="/frame/common/common.jsp"%>
<script>
	function f_check_bpsname(obj){
		var str = obj.value;
        var reg = /^[a-zA-Z_]{1}([a-zA-Z0-9_]|[.]){0,254}([a-zA-Z0-9_])$/;
        if(!reg.test(str)){
            f_alert(obj,"格式不对，以字母或_开头，可带数字、.的字串！");
            return false;
        } 
        return true;
    }
	function f_check_tenantID(obj){
		var str = obj.value;
        var reg = /^([a-zA-Z0-9_]|[.]){0,254}$/;
        if(!reg.test(str)){
            f_alert(obj,"不能为中文，可包含数字、字母或_的字符串！");
            return false;
        } 
        return true;
    }
    function f_check_bpspassword(obj){
    	var str = obj.value;
    	if(containsChinese(str)){
    		f_alert(obj,"不能包含中文，可包含数字、字母或_的字符串！");
    		return false;
    	}
        return true;
    }
    function containsChinese(str){
		var re = /[\u4e00-\u9fa5]+/;
		if (re.test(str)) return true;
		return false;
	}
</script>
<form id="addForm" method="post" action="com.primeton.bps.workspace.frame.multitenancy.MultiTenancyManager.flow">
<table border="0" cellpadding="1" cellspacing="1" class="workarea" width="100%">
  <tr> 
    <td class="workarea_title" valign="middle"><h3>添加租户信息</h3></td>
  </tr>
  <tr> 
    <td width="100%">
    
    <h:hidden property="_eosFlowKey" id="_eosFlowKey"></h:hidden> 
    <h:hidden id="_eosFlowAction" property="_eosFlowAction"/>
    <h:hidden id="_eosFlowDataContext" property="_eosFlowDataContext" />
    <h:hidden id="serverIdList" property="serverIdList"/>
    <h:hidden id="serverNameList" property="serverNameList"/>
    
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="form_table">
    <tr>
		<td class="form_label" width="20%">租户ID</td>
		<td>
			<h:text id="tenantID" style="width:170px" validateAttr="allowNull=false;maxLength=128;type=tenantID" property="multiTenancyModel/tenantID" onblur="checkInputId(this)"/>
		</td>
	</tr>
	<tr>
		<td class="form_label" width="20%">租户名称</td>
		<td>
			<h:text id="tenantName" style="width:170px" validateAttr="allowNull=false;maxLength=21;type=bpscommname" property="multiTenancyModel/tenantName" onblur="checkInputName(this)"/>
		</td>
	</tr>
	<tr>
		<td class="form_label" width="20%">组织机构实现类</td>
		<td>
			<h:text id="organizationClass" style="width:170px" validateAttr="allowNull=false;maxLength=128;type=bpsname" property="multiTenancyModel/organizationClass" onblur="checkInput(this)"/>
		</td>
	</tr>
	<tr>
		<td class="form_label">权限接口实现类</td>
		<td>
			<h:text id="permissionClass" style="width:170px" validateAttr="allowNull=false;maxLength=128;type=bpsname" property="multiTenancyModel/permissionClass" onblur="checkInput(this)"/>
		</td>
	</tr>
	<tr>
		<td class="form_label" width="20%">密码</td>
		<td>
			<h:password id="tenantPassword" style="width:170px" validateAttr="maxLength=42;type=bpspassword;minLength=6;allowNull=false" property="multiTenancyModel/tenantPassword" filter="true" onblur="checkInput(this)"/>
		</td>
	</tr>
	<tr>
		<td class="form_label" width="20%">确认密码</td>
		<td>
			<h:password id="adminRePwd" style="width:170px" validateAttr="maxLength=42;type=bpspassword;minLength=6;allowNull=false" onblur="checkInputRePwd(this)" filter="true" />
		</td>
	</tr>
	<tr>
		<td class="form_label" width="20%">绑定数据源</td>
		<td>
			<input type="checkbox" id="checkbox_bindDataSourceFlag" onclick="checkIsChecked(this)" />
			 <h:hidden id="bindDataSourceFlag" property="multiTenancyModel/bindDataSourceFlag" />
		</td>
	</tr>
	<tr id="datasourceCol" style="display: none;">
		<td class="form_label" width="20%">数据源</td>
		<td>
			<r:comboSelect id="datasource" name="multiTenancyModel/datasource" queryAction="com.primeton.bps.workspace.frame.multitenancy.tenancyMgr.queryDatasource.biz" width="15%" xpath="datasource" valueField="datasourceID" textField="datasourceName">
				<h:param name="clientID"  property="clientID" scope="f"/>
			</r:comboSelect>
		</td>
	</tr>
	<script type="text/javascript">		
		$id("_eosFlowAction").value = "addMultiTenancy";
	</script>

	<tr style="display: block;">
		<td colspan="2">
			<input id="btnOK" name="btnOK" class="button" type="button" value="<b:message key="add_process_server_jsp.btnOK"/>" onclick="_confirm()">
			<input id="btnCancel" name="btnCancel" class="button" type="button" value="<b:message key='add_process_server_jsp.btnCancel'/>" onclick="back()">
		</td>
	</tr>
	
    </table>
	</td>	
   </tr>
</table>
</form>
<script type="text/javascript">
	function back(){
		
		$id("_eosFlowAction").value='add2cancel';
		$id("addForm").submit();
	}
    function checkInputId(obj){
    	if(validateInfo(obj)) return;
		var serverIds = $id("serverIdList").value.split(",");
		for(var i=0;i<serverIds.length;i++){
			if(obj.value.toLowerCase() == serverIds[i].toLowerCase()){
				f_alert(obj, "租户ID已经存在!");
				return false;
			}
		}
		
		return checkInput(obj);
    }
    
    function checkInputName(obj){
    	if(validateInfo(obj)) return;
		var servers = $id("serverNameList").value.split(",");
		for(var i=0;i<servers.length;i++){
			if(obj.value.toLowerCase() == servers[i].toLowerCase()){
				f_alert(obj, "租户名称已经存在!");
				return false;
			}
		}
		return checkInput(obj);
    }
    function checkInputRePwd(obj){
    	var pwd = $id("tenantPassword").value;
		if(obj.value != pwd){
			f_alert(obj, "两次密码输入不一致!");
			return false;
		}
		return checkInput(obj);
    }
    function _checkAll(){
    	if(!checkInputId($id("tenantID"))) {
    		return false;
    	}
    	
    	if(!checkInputName($id("tenantName"))) {
    		return false;
    	}
    	
    	if(!checkInput($id("organizationClass"))) {
    		return false;
    	}
    	
    	if(!checkInput($id("permissionClass"))) {
    		return false;
    	}
    	
    	if(!checkInput($id("tenantPassword"))) {
    		return false;
    	}
    	if(!checkInputRePwd($id("adminRePwd"))) {
    		return false;
    	}
    	return true;
    }
    
    function _confirm(){
    	if(!_checkAll()){
    		return false;
    	}
    	
        if($id("_eosFlowAction").value=="addMultiTenancy"){
		    $id("_eosFlowAction").value="doAdd";
		    $id("addForm").submit();
		}
    }
    
    function _validate(){
    	if(!_checkAll()){
    		return false;
    	}
		 var myAjax = new Ajax("com.primeton.bps.workspace.frame.processserver.validateConnection.validate.biz");
            
            myAjax.addParam("pss/id", $id("tenantID").value);
            myAjax.addParam("pss/name", $id("tenantName").value);
            myAjax.addParam("pss/uddiHost", $id("permissionClass").value);
            myAjax.addParam("pss/logicName", $id("organizationClass").value);
            myAjax.submit();

            //取得调用后的结果
            var result = myAjax.getValue("root/data/result");

            if (result == "1") {
				alert("<b:message key="add_process_server_jsp.testConnInfo1"/>");
			} else if (result == "-1") {
				alert("<b:message key="add_process_server_jsp.testConnInfo2"/>");
            } else if (result == "-2") {
            	alert("<b:message key="add_process_server_jsp.testConnInfo3"/>");
            } else if (result == "-3") {
            	alert("<b:message key="add_process_server_jsp.testConnInfo4"/>");
            } else if (result == "-4") {
            	alert("<b:message key="add_process_server_jsp.testConnInfo5"/>");
            }
    }
    
     function checkIsChecked(obj){
		if(obj.checked==true){
			$id("datasourceCol").style.display="";
			$id("bindDataSourceFlag").value=true;
		    return true;
		 }else{
		 	$id("datasourceCol").style.display="none";
		 	f_alert_hidden_message($id("datasource"));
		 	$id("bindDataSourceFlag").value=false;
		    return false;
		 }
    }
    
    function validateInfo(obj){
		if(null==obj.value||undefined==obj.value||""==obj.value.trim()){
				f_alert(obj, "该项为必填项!");
				return true;
		}
    }
    
</script>
