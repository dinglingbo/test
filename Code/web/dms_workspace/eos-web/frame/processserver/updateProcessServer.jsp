<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="/frame/common/common.jsp"%>
<form id="addForm" method="post" action="com.primeton.bps.workspace.frame.processserver.ProcessServerManage.flow">
<table border="0" cellpadding="1" cellspacing="1" class="workarea" width="100%">
  <tr> 
    <td class="workarea_title" valign="middle"><h3><b:message key="update_process_server_jsp.title"/></h3></td>
  </tr>
  <tr> 
    <td width="100%">
    
    <h:hidden property="_eosFlowKey"></h:hidden> 
    <h:hidden id="_eosFlowAction" property="_eosFlowAction"/>
    <h:hidden id="_eosFlowDataContext" property="_eosFlowDataContext" />
    <h:hidden id="serverIdList" property="serverIdList"/>
    <h:hidden id="serverNameList" property="serverNameList"/>
    
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="form_table">
    <tr>
		<td class="form_label" width="20%"><b:message key="update_process_server_jsp.engineID"/></td>
		<td>
			<h:text id="psId" validateAttr="allowNull=false;maxLength=40;type=bpscommname" property="ps/id" onblur="checkInputId(this)" disabled="true" />
			<h:hidden property="ps/id"/>
		</td>
	</tr>
	<tr>
		<td class="form_label" width="20%"><b:message key="update_process_server_jsp.engineName"/></td>
		<td>
			<h:text id="psName" validateAttr="allowNull=false;maxLength=40;type=bpscommname" property="ps/name" onblur="checkInputName(this)" />
		</td>
	</tr>
	<tr>
		<td class="form_label" width="20%"><b:message key="update_process_server_jsp.logicName"/></td>
		<td>
			<h:text id="psLogicName" validateAttr="allowNull=true;maxLength=40;type=bpscommname" property="ps/logicName" onblur="checkInput(this)"/>
		</td>
	</tr>
	<tr>
		<td class="form_label"><b:message key="update_process_server_jsp.ip"/></td>
		<td>
			<h:text id="psIP" validateAttr="allowNull=false;type=IP;" property="ps/uddiHost" onblur="checkInput(this)"/>
		</td>
	</tr>
	<tr>
		<td class="form_label"><b:message key="update_process_server_jsp.servicePort"/></td>
		<td>
		<h:text id="psPort" validateAttr="allowNull=false;type=port;" property="ps/uddiPort" onblur="checkInput(this)"/>
		</td>
	</tr>
	<tr>
		<td class="form_label"><b:message key="update_process_server_jsp.adminPort"/></td>
		<td>
		<h:text id="psAdminPort" validateAttr="allowNull=false;type=port;" property="ps/uddiAdminPort" onblur="checkInput(this)"/>
		</td>
	</tr>
	<tr>
		<td class="form_label"><b:message key="update_process_server_jsp.webAppName"/></td>
		<td>
			<h:text id="psWebContext" validateAttr="allowNull=false;maxLength=64;minLength=3;" property="ps/uddiWebContext" onblur="checkSameLogicName(this);"/>
		</td>
	</tr>
	<tr>
		<td class="form_label"><b:message key="update_process_server_jsp.userName"/></td>
		<td>
			<h:text id="psUserId" validateAttr="allowNull=true;maxLength=20;" property="ps/uddiUserID" onblur="checkInput(this)"/>
		</td>
	</tr>
	<tr>
		<td class="form_label"><b:message key="update_process_server_jsp.pwd"/></td>
		<td>
			<h:password id="psPassword" validateAttr="allowNull=true;maxLength=20;" property="ps/uddiPassword" onblur="checkInput(this)" filter="true" />
		</td>
	</tr>
	<tr>
		<td class="form_label"><b:message key="update_process_server_jsp.desc"/></td>
		<td>
			<h:textarea id="psDesc" cols="50" rows="5" validateAttr="allowNull=true;maxLength=200;" property="ps/description" onblur="checkInput(this)"/>
		</td>
	</tr>
	
	<script type="text/javascript">		
		$id("_eosFlowAction").value = "updateProcessServer";
	</script>
	
	<tr>
		<td colspan="2">
			<input id="btnOK" name="btnOK" class="button" type="button" value="<b:message key="update_process_server_jsp.btnOK"/>" onclick="_confirm()">
			<input id="btnCancel" name="btnCancel" class="button" type="button" value="<b:message key="update_process_server_jsp.btnCancel"/>" onClick="window.location='com.primeton.bps.workspace.frame.processserver.ProcessServerManage.flow'">
			<input id="btnTest" name="btnTest" class="button" type="button" value="<b:message key="update_process_server_jsp.btnTestConn"/>" onclick="_validate()">
		</td>
	</tr>
	
    </table>
	</td>	
   </tr>
</table>
</form>
<script type="text/javascript">

	function checkInputId(obj){
		var serverIds = $id("serverIdList").value.split(",");
		var curServerId = "<b:write property="ps/id"/>";
		for(var i=0;i<serverIds.length;i++){
			if(obj.value.toLowerCase() == serverIds[i].toLowerCase()  && curServerId.toLowerCase() != obj.value.toLowerCase()){
				f_alert(obj, "<b:message key="update_process_server_jsp.engineIDExist"/>");
				return false;
			}
		}
		
		return checkInput(obj);
    }
    
     function checkSameLogicName(obj){
    	var logicName = $id("psLogicName").value;
    	var webAppName = obj.value;
    	if(webAppName != logicName){
    		f_alert(obj, "<b:message key="add_process_server_jsp.same_logic_name"/>");
    		return false;
    	}
    	return checkInput(obj);
    }
    
    function checkInputName(obj){
		var servers = $id("serverNameList").value.split(",");
		var curServerName = "<b:write property="ps/name"/>";
		for(var i=0;i<servers.length;i++){
			if(obj.value.toLowerCase() == servers[i].toLowerCase() && curServerName.toLowerCase() != obj.value.toLowerCase()){
				f_alert(obj, "<b:message key="update_process_server_jsp.engineNameExist"/>");
				return false;
			}
		}
		
		return checkInput(obj);
	}
    
    function _checkAll(){
    	if(!checkInputId($id("psId"))) {
    		return false;
    	}
    	
    	if(!checkInputName($id("psName"))) {
    		return false;
    	}
    	
    	if(!checkInput($id("psLogicName"))) {
    		return false;
    	}
    	
    	if(!checkInput($id("psIP"))) {
    		return false;
    	}
    	
    	if(!checkInput($id("psPort"))) {
    		return false;
    	}
    	
    	if(!checkInput($id("psAdminPort"))) {
    		return false;
    	}
    	
    	if(!checkSameLogicName($id("psWebContext"))) {
    		return false;
    	}
    	
    	if(!checkInput($id("psUserId"))) {
    		return false;
    	}
    	
    	if(!checkInput($id("psPassword"))) {
    		return false;
    	}
    	
    	if(!checkInput($id("psDesc"))) {
    		return false;
    	}
    	
    	return true;
    }
    
    function _confirm(){
    	if(!_checkAll()){
    		return false;
    	}
    	
        if($id("_eosFlowAction").value=="updateProcessServer"){
		    $id("_eosFlowAction").value="doUpdateProcessServer";
		    $id("addForm").submit();
		}
    }
    
    function _validate(){
    	if(!_checkAll()){
    		return false;
    	}
		 var myAjax = new Ajax("com.primeton.bps.workspace.frame.processserver.validateConnection.validate.biz");
		 
		 	myAjax.addParam("pss/id", $id("psId").value);
            myAjax.addParam("pss/name", $id("psName").value);
            myAjax.addParam("pss/uddiHost", $id("psIP").value);
            myAjax.addParam("pss/uddiPort", $id("psPort").value);
            myAjax.addParam("pss/uddiAdminPort", $id("psAdminPort").value);
            myAjax.addParam("pss/uddiWebContext", $id("psWebContext").value);
            myAjax.addParam("pss/description", $id("psDesc").value);
            myAjax.addParam("pss/logicName", $id("psLogicName").value);
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
</script>
