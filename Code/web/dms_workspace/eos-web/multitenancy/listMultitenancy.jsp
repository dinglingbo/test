<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="/frame/common/common.jsp"%>
<form method="post" id="form1" action="com.primeton.bps.workspace.frame.multitenancy.MultiTenancyManager.flow" >
<table border="0" cellpadding="1" cellspacing="1" class="workarea" width="100%">
  <tr>
  	<td class="workarea_title" valign="middle"><h3><b:message key="list_Multitenancy_jsp.title"/></h3></td>
  </tr>
  <tr> 
    <td width="100%" >
    	<h:hidden id="_eosFlowAction" property="_eosFlowAction"/>
		<h:hidden property="_eosFlowKey"/>
		<h:hidden id="_eosFlowDataContext" property="_eosFlowDataContext" />
		<h:hidden id="serverIdList" name="serverIdList"/>
		<h:hidden id="serverNameList" name="serverNameList"/>
		<h:hidden id="pass" name="pass"/>
		<h:hidden id="adminPWD" name="adminPWD"/>
		
		<w:radioGroup id="radio1">
			<table border="0" cellpadding="0" cellspacing="0" class="EOS_TABLE" width="100%" >
				<thead class="EOS_TABLE_HEAD">
				<tr>
					<th nowrap="nowrap"><b:message key="list_Multitenancy_jsp.choose"/></th>
					<th nowrap="nowrap">租户ID</th>
					<th nowrap="nowrap">租户名称</th>
					<th nowrap="nowrap">组织机构实现类</th>
					<th nowrap="nowrap">权限接口实现类</th>
				</tr>
				</thead>
				<l:iterate property="pss" id="ps">
				<tr>
					<td nowrap="nowrap">
						<w:rowRadio showRadio="true" onSelectFunc="change_button">
							<h:param name="tenantID" iterateId="ps" property="tenantID"></h:param>
							<h:param name="tenantName" iterateId="ps" property="tenantName"></h:param>
							<h:param name="organizationClass" iterateId="ps" property="organizationClass"></h:param>
							<h:param name="permissionClass" iterateId="ps" property="permissionClass"></h:param>
							<h:param name="bindDataSourceFlag" iterateId="ps" property="bindDataSourceFlag"></h:param>
							<h:param name="datasource" iterateId="ps" property="datasource" ></h:param>
							<h:param name="a" iterateId="ps" property="a" ></h:param>
						</w:rowRadio>
					</td>
					<td nowrap="nowrap">
						<b:write iterateId="ps" property="tenantID" />
					</td>
					<td nowrap="nowrap">
						<b:write iterateId="ps" property="tenantName" />
					</td>
					<td nowrap="nowrap">
						<b:write iterateId="ps" property="organizationClass" />
					</td>
					<td nowrap="nowrap">
						<b:write iterateId="ps" property="permissionClass" />
					</td>
				</tr>
				</l:iterate>
				
				<tr>
				<td colspan="6">
					<input type="button" class="button" id="btn1" name="btn1" value="<b:message key="list_process_server_jsp.btnAdd"/>" onclick="changeAction('addMultiTenancy');" >
				    <input type="button" class="button" id="btn2" name="btn2" disabled="true"  value="<b:message key="list_process_server_jsp.btnEdit"/>" onclick="changeAction('udateMultiTenancy');">
				    <input type="button" class="button" id="btn3" name="btn3" disabled="true" value="<b:message key="list_process_server_jsp.btnDel"/>" onclick="changeAction('deleteMultiTenancy');">
				    <input type="button" class="button" id="btn4" name="btn4" disabled="true" value="<b:message key="list_process_server_jsp.downloadToken"/>" onclick="downloadToken('downloadToken')">
					<input type="button" class="button" id="btn5" name="btn5" value="<b:message key="list_process_server_jsp.btnCancel"/>" onclick="location='com.primeton.bps.workspace.frame.processserver.ProcessServerManage.flow'">
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
		
		function deleConfirm(action){
			if(action!="removeProcessServer")
				$id("form1").submit();
			else{
				if(confirm("<b:message key="list_process_server_jsp.delConfirm"/>"))
					$id("form1").submit();
			}
		}
		
		function downloadToken(action){
			$id("_eosFlowAction").value=action;
			//$id("form1").target="_blank";
			$id("form1").submit();
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
			var tenantID = obj.getParam("tenantID");
		    if(tenantID != ""){
		    	$id("btn2").disabled=false;
		    	$id("btn3").disabled=false;
		    	$id("btn4").disabled=false;
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
	      		'<b:write iterateId="ps" property="tenantID" />',
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
	      		'<b:write iterateId="ps" property="tenantName" />',
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
