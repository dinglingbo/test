<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.eos.workflow.data.WFProcessDefine" %>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<html>
<head>
	<title></title>
	<% WFProcessDefine [] processArray = (WFProcessDefine [])request.getAttribute("processes"); %>
	<script>
		function init() {
			 
			<%
				if(processArray == null || processArray.length == 0) {
			%>	
			//FIXME:document.getElementById --> $id
				$id('deployType_update').disabled="true" ;
				$id('version').disabled="true" ;
				$id('isRelease').disabled="true" ;
			<%	
				} else {
					for(int i=0;i<processArray.length;i++) {
						WFProcessDefine processDefine = processArray[i] ;
						StringBuffer label = new StringBuffer("") ;
						label.append("vesion---(") ;
						label.append(processDefine.getVersionSign()) ;
						label.append(")") ;
						if("3".equals(processDefine.getCurrentState().toString())) {
							label.append(" *") ;
						}
						String value = processDefine.getVersionSign() ;
						%>
							CreateOptionItems('version','<%=value %>','<%=label%>');
						<%
					}
				}
			%>
		}
		
		function disableSelectbox(isDisable) {
			var List = $id('version')
		    if(isDisable == "true") {
		   		List.disabled="true" ;	
		   	}	else {
		   		
				var ListLen = List.options.length;
				for(i = ListLen - 1; i >= 0; i--)
				{
					//List.options(i)--> []
					List.options[i].selected = false ;
				}		   		
		   		List.disabled=false ;	
		   	}	
		}
		
		function deploy () {
			$id('option/isPublish').value = $id('isRelease').checked ;
			document.forms['deployProcess'].action="com.primeton.workflow.manager.def.deploy_signleFile.flow?_eosFlowAction=action5" ;
			document.forms['deployProcess'].submit();
		}
	</script>
</head>
<body onload="init()">
<form name="deployProcess" method="POST">
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td>
				<div>
					<fieldset>
						<legend><b:message key="deploy_multiprocesses_jsp.version_info"/></legend>
						<div>
							<input type="radio" id="deployType_default" name="option/mode" value="default" checked="true" onclick="disableSelectbox('true')">
							<label for="deployType_default"><b:message key="deploy_multiprocesses_jsp.submit_default"/></label>
							<div style="padding-left:13px"> 
								<b:message key="deploy_multiprocesses_jsp.note"/>
							</div>
						</div>
						<div>
							<input type="radio" id="deployType_update" name="option/mode" value="specific" onclick="disableSelectbox('false')">
							<label for="deployType_update"><b:message key='deploy_multiprocesses_jsp.overwrite_exist'/></label>
							<div style="padding-left:63px">
								<select id="version" name="version" size="4" style="width:240px" disabled="true">
								</select>
							</div>
						</div>
						<div>
							<input type="radio" id="deployType_new" name="option/mode" value="new" onclick="disableSelectbox('true')">
							<label for="deployType_new"><b:message key='deploy_multiprocesses_jsp.create_new'/></label>
						</div>
						<div>
							<div style="display:inline;padding-left:3px">
								<label for="isRelease"><b:message key="multi_process_form_jsp.whether_release"/></label>
							</div>
							<input type="checkbox" id="isRelease" name="isRelease" value="true" checked="checked">
						</div>
						<div>
							<div style="display:inline;padding-left:3px">
								<label for="description"><b:message key='deploy_multiprocesses_jsp.desc'/></label>
							</div>
							<div style="display:inline;padding-left:29px">
								<textarea id="description" name="option/versionDesc" rows="4" cols="33"></textarea>
							</div>
						</div>
					</fieldset>
				</div>
			</td>
		</tr> 
	</table>
	<h:hidden name="option/packageID" property="packageID" />
	<h:hidden name="option/isPublish" />
	<h:hidden name="option/packageName" property="packageName"/>

</form>