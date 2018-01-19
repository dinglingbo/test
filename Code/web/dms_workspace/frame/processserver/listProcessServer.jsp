<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="/frame/common/common.jsp"%>
<script>
	var isLocalEmbeddedServer ='false';
</script>
<form method="post" id="form1" action="com.primeton.bps.workspace.frame.processserver.ProcessServerManage.flow" >
<table border="0" cellpadding="1" cellspacing="1" class="workarea" width="100%">
  <tr>
  	<td class="workarea_title" valign="middle"><h3><b:message key="list_process_server_jsp.title"/></h3></td>
  </tr>
  <tr> 
    <td width="100%" >
    
    	<h:hidden  property="_eosFlowAction" id="_eosFlowAction"/>
		<h:hidden id="_eosFlowKey" property="_eosFlowKey"/>
		<h:hidden id="_eosFlowDataContext" property="_eosFlowDataContext" />
		<h:hidden id="serverIdList" name="serverIdList"/>
		<h:hidden id="serverNameList" name="serverNameList"/>
		<h:hidden id="pass" name="pass"/>
		
		<w:radioGroup id="radio1">
			<table border="0" cellpadding="0" cellspacing="0" class="EOS_TABLE" width="100%" >
				<thead class="EOS_TABLE_HEAD">
				<tr>
					<th nowrap="nowrap"><b:message key="list_process_server_jsp.choose"/></th>
					<th nowrap="nowrap"><b:message key="list_process_server_jsp.engineName"/></th>
					<th nowrap="nowrap"><b:message key="list_process_server_jsp.ip"/></th>
					<th nowrap="nowrap"><b:message key="list_process_server_jsp.servicePort"/></th>
					<th nowrap="nowrap"><b:message key="list_process_server_jsp.adminPort"/></th>
					<th nowrap="nowrap"><b:message key="list_process_server_jsp.webAppName"/></th>
					<th nowrap="nowrap"><b:message key="list_process_server_jsp.desc"/></th>
				</tr>
				</thead>
				<l:iterate property="pss" id="ps">
				<tr>
					<td nowrap="nowrap">
						<w:rowRadio showRadio="true" onSelectFunc="change_button">
							<h:param name="clientId" iterateId="ps" property="id"></h:param>
							<h:param name="clientName" iterateId="ps" property="name"></h:param>
							<h:param name="clientHost" iterateId="ps" property="uddiHost"></h:param>
							<h:param name="clientPort" iterateId="ps" property="uddiPort"></h:param>
							<h:param name="clientAdminPort" iterateId="ps" property="uddiAdminPort"></h:param>
							<h:param name="clientWebContext" iterateId="ps" property="uddiWebContext"></h:param>
							<h:param name="clientDesc" iterateId="ps" property="description"></h:param>
							<h:param name="clientLogicName" iterateId="ps" property="logicName"></h:param>
							<h:param name="clientUserId" iterateId="ps" property="uddiUserID"></h:param>
							<h:param name="clientPassword" iterateId="ps" property="uddiPassword"></h:param>
						</w:rowRadio>
					</td>
					<td nowrap="nowrap">
						<b:write iterateId="ps" property="name" />
					</td>
					<td nowrap="nowrap">
						<b:write iterateId="ps" property="uddiHost" />
					</td>
					<td nowrap="nowrap">
						<b:write iterateId="ps" property="uddiPort" />
					</td>
					<td nowrap="nowrap">
						<b:write iterateId="ps" property="uddiAdminPort" />
					</td>
					<td nowrap="nowrap">
						<b:write iterateId="ps" property="uddiWebContext" />
					</td>
					<td nowrap="nowrap">
						<span title='<b:write iterateId="ps" property="description" />'><b:write iterateId="ps" property="description" maxLength="15"/></span>
					</td>
				</tr>
				</l:iterate>
				
				<tr>
				<td colspan="7">
					<input type="button" class="button" id="btn1" name="btn1" value="<b:message key="list_process_server_jsp.btnAdd"/>" onclick="changeAction('addProcessServer');" >
				    <input type="button" class="button" id="btn2" name="btn2" disabled="true"  value="<b:message key="list_process_server_jsp.btnEdit"/>" onclick="changeAction('updateProcessServer');">
				    <input type="button" class="button" id="btn3" name="btn3" disabled="true" value="<b:message key="list_process_server_jsp.btnDel"/>" onclick="changeAction('removeProcessServer');">
				    <input type="button" class="button" id="btn4" name="btn4" disabled="true" value="<b:message key="list_process_server_jsp.btnTestConn"/>" onclick="_validate();">
				    <input type="button" class="button" id="btn6" name="btn6" disabled="true" value="<b:message key="list_process_server_jsp.btnMulManager"/>" onclick="multiTanentMgr();">
				    <!--
				    <l:equal property="isLocalEmbeddedServer" targetValue="true" ignoreCase="true" compareType="string" scope="flow">
				    	<input type="button" class="button" id="btn5" name="btn5" disabled="true" value="<b:message key="list_process_server_jsp.configDS"/>" onclick="configDataSource();">
						<script>
							isLocalEmbeddedServer ='true';
						</script>
					</l:equal>
					-->
				</td>
				</tr>
			</table>
		</w:radioGroup>
	</td>	
  </tr>
</table>
</form>
	<script>
		
		function changeAction(action){
			$id("_eosFlowAction").value=action;
			deleConfirm(action);
		}		
		function multiTanentMgr(){
			$id("form1").action='com.primeton.bps.workspace.frame.multitenancy.MultiTenancyManager.flow';
			$id("_eosFlowAction").value='listTenants';
			$id("_eosFlowKey").value='';
			$id("form1").submit();
		}
		 
		function deleConfirm(action){
			if(action!="removeProcessServer")
				$id("form1").submit();
			else{
				if(confirm("<b:message key="list_process_server_jsp.delConfirm"/>"))
					$id("form1").submit();
			}
		}
		
		function configDataSource(){
			var row = $id("radio1").getSelectRow();
		 	var myAjax = new Ajax("com.primeton.bps.workspace.frame.processserver.WSContributionHelper.isEmbeddedServer.biz");
            
            myAjax.addParam("clientId", row.getParam("clientId"));

            myAjax.submit();

            //取得调用后的结果
            var result = myAjax.getValue("root/data/ret");
            
            if (result == "true") {
				var serverIP = row.getParam("clientHost");
				var serverAdminPort = row.getParam("clientAdminPort");
				var appName = row.getParam("clientWebContext");
				var serverName = row.getParam("clientName");
				var ServerParams = "?ip=" + serverIP + "&port=" + serverAdminPort + "&appName=" +appName + "&serverName=" + serverName;
	
				document.location.href = "com.primeton.workflow.governor.datasource.datasource.flow" + ServerParams;
            }
            else if (result == "error") {
            	alert("<b:message key="list_process_server_jsp.dsCfgError1"/>");
            }
            else {
            	alert("<b:message key="list_process_server_jsp.dsCfgError2"/>");
            }
		}
		
		function change_button(obj){
			
			var clientId = obj.getParam("clientId");
		    if(clientId != ""){
		    	$id("btn2").disabled=false;
		    	$id("btn3").disabled=false;
		    	$id("btn4").disabled=false;
		    	
		    	if (isLocalEmbeddedServer == 'true') {
		    		$id("btn5").disabled=false;
		    	}
		    	var myAjax = new Ajax("com.primeton.bps.workspace.frame.common.EngineTenantModeMgr.queryEngineMode.biz");
				myAjax.addParam("clientID", clientId);
				myAjax.submit();
				var result = myAjax.getValue("root/data/isMultiTenant");
				if(result=="true"){
					$id("btn6").disabled=false;
				}else{
					$id("btn6").disabled=true;
				}
		    }else{
		    	$id("btn6").disabled=true;
		    }
		}
		
		
		function _validate(){
			var row = $id("radio1").getSelectRow();
		 	var myAjax = new Ajax("com.primeton.bps.workspace.frame.processserver.validateConnection.validate.biz");
            
            myAjax.addParam("pss/id", row.getParam("clientId"));
            myAjax.addParam("pss/name", row.getParam("clientName"));
            myAjax.addParam("pss/uddiHost", row.getParam("clientHost"));
            myAjax.addParam("pss/uddiPort", row.getParam("clientPort"));
            myAjax.addParam("pss/uddiAdminPort", row.getParam("clientAdminPort"));
            myAjax.addParam("pss/uddiWebContext", row.getParam("clientWebContext"));
            myAjax.addParam("pss/description", row.getParam("clientDesc"));
            myAjax.addParam("pss/logicName", row.getParam("clientLogicName"));
            myAjax.addParam("pss/uddiUserID", row.getParam("clientUserId"));
            myAjax.addParam("pss/uddiPassword", row.getParam("clientPassword")); 

            myAjax.submit();
            
            //取得调用后的结果
            var result = myAjax.getValue("root/data/result");

            if (result == "1") {
				alert("<b:message key="list_process_server_jsp.testConnInfo1"/>");
			} else if (result == "-1") {
				alert("<b:message key="list_process_server_jsp.testConnInfo2"/>");
            } else if (result == "-2") {
            	alert("<b:message key="list_process_server_jsp.testConnInfo3"/>");
            } else if (result == "-3") {
            	alert("<b:message key="list_process_server_jsp.testConnInfo4"/>");
            } else if (result == "-4") {
            	alert("<b:message key="list_process_server_jsp.testConnInfo5"/>");
            }
	    }
		
		var ids = new Array(
       		<l:iterate property="pss" id="ps">
	      		'<b:write iterateId="ps" property="id" />',
	      	</l:iterate>
		'@');
		var serverIds = "";
		for(var i=0;i<ids.length-1;i++){
			serverIds += ids[i]+",";
		}
		if(serverIds == ""){
			$id("serverIdList").value = "";
		}else{
			$id("serverIdList").value = serverIds.substring(0,serverIds.length-1);
		}
		
		var servers = new Array(
       		<l:iterate property="pss" id="ps">
	      		'<b:write iterateId="ps" property="name" />',
	      	</l:iterate>
		'@');
		var serverNames = "";
		for(var i=0;i<servers.length-1;i++){
			serverNames += servers[i]+",";
		}
		if(serverNames == ""){
			$id("serverNameList").value = "";
		}else{
			$id("serverNameList").value = serverNames.substring(0,serverNames.length-1);
		}
		
	</script>
