<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="/frame/common/common.jsp"%>
<%
	String msgKey = (String)request.getAttribute("msgKey");
	String msg = ResourcesMessageUtil.getI18nResourceMessage(msgKey);
 %>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<form id="updateForm" method="post" action="com.primeton.bps.workspace.frame.multitenancy.MultiTenancyManager.flow">
<table border="0" cellpadding="1" cellspacing="1" class="workarea" width="100%">
  <tr> 
     <td class="workarea_title" valign="middle"><h3><b:message key="update_process_server_jsp.title"/></h3></td>
  </tr>
  <tr> 
    <td width="100%">
    
    <h:hidden property="_eosFlowKey" id="_eosFlowKey"></h:hidden> 
    <h:hidden id="_eosFlowAction" property="_eosFlowAction"/>
    <h:hidden id="_eosFlowDataContext" property="_eosFlowDataContext" />
    <h:hidden id="serverIdList" property="serverIdList"/>
    <h:hidden id="serverNameList" property="serverNameList"/>
    
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="form_table">
			<%
		     if(msg != null){
			%>
			    <tr>
					<td class="form_label" colspan="2">
		     		<%=msg %>
			</td>
		</tr>
		     <%
		     	}
		     %>
    <tr>
		<td class="form_label" width="20%">租户ID</td>
		<td>
			<h:text id="tenantID" style="width:170px" validateAttr="allowNull=false;maxLength=128;type=bpscommname" property="tenantID" onblur="checkInputId(this)" disabled="true" />
			<h:hidden property="tenantID"/>
		</td>
	</tr>
	<tr>
		<td class="form_label" width="20%">租户名称</td>
		<td>
			<h:text id="tenantName" style="width:170px" validateAttr="allowNull=false;maxLength=21;type=bpscommname" property="tenantName" onblur="checkInputName(this)"/>
		</td>
	</tr>
	<tr>
		<td class="form_label" width="20%">组织机构实现类</td>
		<td>
			<h:text id="domainOrganizationClass" style="width:170px" validateAttr="allowNull=false;maxLength=128;type=bpscommname" property="organizationClass" onblur="checkInput(this)"/>
		</td>
	</tr>
	<tr>
		<td class="form_label">权限接口实现类</td>
		<td>
			<h:text id="domainPermissionClass" style="width:170px" validateAttr="allowNull=false;maxLength=128;type=bpscommname" property="permissionClass" onblur="checkInput(this)"/>
		</td>
	</tr>
	<tr>
		<td class="form_label" width="20%">修改密码</td>
		<td>
			<input type="checkbox" id="checkbox" onclick="checkIsChecked(this)" > 
		</td>
	</tr>
	<tr id="oldPasswordCol" style="display: none;">
		<td class="form_label" width="20%">旧密码</td>
		<td>
			<h:password id="oldPwd" style="width:170px" validateAttr="maxLength=42;type=bpspassword;minLength=6;allowNull=false" property="oldPwd" onblur="checkInput(this)" filter="true" />
		</td>
	</tr>
	<tr id="newPasswordCol" style="display: none;">
		<td class="form_label" width="20%" >新密码</td>
		<td>
			<h:password id="newPwd" style="width:170px" validateAttr="maxLength=42;type=bpspassword;minLength=6;allowNull=false" property="newPwd" onblur="checkNewPwd(this)" filter="true" />
		</td>
	</tr>
	<tr id="confirmPasswordCol" style="display: none;">
		<td class="form_label" width="20%" >确认密码</td>
		<td>
			<h:password id="newRePwd" style="width:170px" validateAttr="maxLength=42;type=bpspassword;minLength=6;allowNull=false" onblur="checkInputnewRePwd(this)" filter="true" />
		</td>
	</tr>
	<tr>
		<td class="form_label" width="20%">绑定数据源</td>
		<td>
			<input type="checkbox" id="checkbox_bindDataSourceFlag" onclick="checkDataSource(this)" />
			 <h:hidden id="bindDataSourceFlag" property="bindDataSourceFlag" />
		</td>
	</tr>
	<tr id="datasourceCol">
		<td class="form_label" width="20%">数据源</td>
		<td>
			<r:comboSelect id="datasource" name="datasource" queryAction="com.primeton.bps.workspace.frame.multitenancy.tenancyMgr.queryDatasource.biz" width="15%" xpath="datasource" valueField="datasourceID" textField="datasourceName">
				<h:param name="clientID" property="clientID" scope="f"/>
			</r:comboSelect>
		</td>
	</tr>
	<script type="text/javascript">		
		$id("_eosFlowAction").value = "udateMultiTenancy";
	</script>
	
	<tr>
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
	(function(){
		var bindDataSourceFlag = "<b:write property="bindDataSourceFlag"/>";
		if("true"==bindDataSourceFlag){
			var bindDataSourceCheckbox = $id("checkbox_bindDataSourceFlag");
			bindDataSourceCheckbox.checked=true;
			$id("datasourceCol").style.display="";
			$id("datasource").value="<b:write property="datasource"/>";
		}else{
			$id("datasource").value="";
			$id("datasourceCol").style.display="none";
		}
	})();
	function back(){
		
		$id("_eosFlowAction").value='update2cancel';
		$id("updateForm").submit();
	}
	function checkInputId(obj){
		var serverIds = $id("serverIdList").value.split(",");
		var curServerId = "<b:write property="tenantID"/>";
		for(var i=0;i<serverIds.length;i++){
			if(obj.value.toLowerCase() == serverIds[i].toLowerCase()  && curServerId.toLowerCase() != obj.value.toLowerCase()){
				f_alert(obj, "租户ID已经存在!");
				return false;
			}
		}
		
		return checkInput(obj);
    }
    
    function checkInputName(obj){
		var servers = $id("serverNameList").value.split(",");
		var curServerName = "<b:write property="tenantName"/>";
		for(var i=0;i<servers.length;i++){
			if(obj.value.toLowerCase() == servers[i].toLowerCase() && curServerName.toLowerCase() != obj.value.toLowerCase()){
				f_alert(obj, "租户名称已经存在!");
				return false;
			}
		}
		
		return checkInput(obj);
	}
	 function checkIsChecked(obj){
		if(obj.checked==true){
			$id("oldPasswordCol").style.display="";
		    $id("newPasswordCol").style.display="";
		    $id("confirmPasswordCol").style.display="";
			$id("oldPwd").disabled=false;
		    $id("newPwd").disabled=false;
		    $id("newRePwd").disabled=false;
		    return true;
		 }else{
		 	$id("oldPasswordCol").style.display="none";
		    $id("newPasswordCol").style.display="none";
		    $id("confirmPasswordCol").style.display="none";
			$id("oldPwd").disabled=true;
		    $id("newPwd").disabled=true;
		    $id("newRePwd").disabled=true;
		    f_alert_hidden_message($id("oldPwd"));
		    f_alert_hidden_message($id("newPwd"));
		    f_alert_hidden_message($id("newRePwd"));
		    return false;
		 }
    }
    function checkDataSource(obj){
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
     function checkInputnewRePwd(obj){
    	var pwd = $id("newPwd").value;
			if(obj.value != pwd){
				f_alert(obj, "两次密码输入不一致!");
				return false;
			}
		
		return checkInput(obj);
    }
     function checkNewPwd(obj){
    	var pwd = $id("oldPwd").value;
			if(obj.value == pwd){
				f_alert(obj, "新密码和原密码一致!");
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
    	
    	if(!checkInput($id("domainOrganizationClass"))) {
    		return false;
    	}
    	
    	if(!checkInput($id("domainPermissionClass"))) {
    		return false;
    	}
    	if(checkIsChecked($id("checkbox"))) {
    		if(!checkInput($id("oldPwd"))) {
   		 		return false;
   		 	}
    	
    		if(!checkNewPwd($id("newPwd"))) {
    			return false;
    		}
    	
    		if(!checkInputnewRePwd($id("newRePwd"))) {
    			return false;
    		}
    	}
    	return true;
    }
    
    function _confirm(){
    	if(!_checkAll()){
    		return false;
    	}
        if($id("_eosFlowAction").value=="udateMultiTenancy"){
		    $id("_eosFlowAction").value="doUdate";
		    $id("updateForm").submit();
		}
    }
    
    function _validate(){
    	debugger;
    	if(!_checkAll()){
    		return false;
    	}
    	debugger;
		 var myAjax = new Ajax("com.primeton.bps.workspace.frame.processserver.validateConnection.validate.biz");
		 
		 	myAjax.addParam("pss/id", $id("domainID").value);
            myAjax.addParam("pss/name", $id("domainName").value);
            myAjax.addParam("pss/uddiHost", $id("domainPermissionClass").value);
            myAjax.addParam("pss/uddiPort", $id("psPort").value);
            myAjax.addParam("pss/uddiAdminPort", $id("psAdminPort").value);
            myAjax.addParam("pss/uddiWebContext", $id("psWebContext").value);
            myAjax.addParam("pss/description", $id("psDesc").value);
            myAjax.addParam("pss/logicName", $id("domainOrganizationClass").value);
            myAjax.addParam("pss/uddiUserID", $id("psUserId").value);
            myAjax.addParam("pss/uddiPassword", $id("psPassword").value);
            myAjax.submit();

            //取得调用后的结果
            var result = myAjax.getValue("root/data/result");

            if (result == "1") {
				alert("<b:message key="update_process_server_jsp.testConnInfo1"/>");
			} else if (result == "-1") {
				alert("<b:message key="update_process_server_jsp.testConnInfo2"/>");
            } else if (result == "-2") {
            	alert("<b:message key="update_process_server_jsp.testConnInfo3"/>");
            } else if (result == "-3") {
            	alert("<b:message key="update_process_server_jsp.testConnInfo4"/>");
            } else if (result == "-4") {
            	alert("<b:message key="update_process_server_jsp.testConnInfo5"/>");
            }
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
	function f_check_bpsname(obj){
		var str = obj.value;
	    var reg = /^[a-zA-Z_]{1}([a-zA-Z0-9_]|[.]){0,254}([a-zA-Z0-9_])$/;
	    if(!reg.test(str)){
	        f_alert(obj,"格式不对，以字母或_开头，可带数字、.的字串！");
	        return false;
	    } 
	    return true;
    }
    
</script>
