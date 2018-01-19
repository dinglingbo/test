<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.eos.workflow.data.WFProcessDefine" %>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
<head>
	<title></title>
	<% 
		WFProcessDefine [] processArray = null ;
		if(request.getAttribute("processes") != null) {
			processArray = (WFProcessDefine [])request.getAttribute("processes"); 
		}
	%>
	<script>
		function init() {
			 
			<%
				if(processArray == null || processArray.length == 0) {
			%>	
			//FIXME: document.getElementById  --> $id
				$id('deployType_update').disabled="true" ;
				$id('version').disabled="true" ;
				//$id('isRelease').disabled="true" ;
				//$id('btnOK').disabled="true" ;
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
				
				if(request.getAttribute("packageID") == null || request.getAttribute("packageID").equals("")) {
			%>
						$id('btnOK').disabled="true" ;
			    <% }%>
		}
		
		function disableSelectbox(isDisable) {
			var List = $id('version')
		    if(isDisable == "true") {
		   		List.disabled="true" ;
		   		
		   	}	else {
		   		
				var ListLen = List.options.length;
				for(i = ListLen - 1; i >= 0; i--)
				{
				//FIXME: ()  --> []
					List.options[i].selected = true ;
				}		   		
		   		List.disabled=false ;
		   	}	
		}
		
		function deploy () {
			$name("btnOk").disabled="disabled";
			$name("deployProcessForm").action="com.primeton.workflow.manager.def.deploy_signleFile.flow?_eosFlowAction=action5";
			$name("deployProcessForm").submit();
		}
		
		function closeWin() {
			if(parent.G_NESTED) {
				parent.window.close();
			} else {
				window.close() ;
			}
		}
	</script>
</head>
<body onload="init()">
<form name="deployProcessForm" method="POST" action="">
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td>
				<div>
					<fieldset>
						<legend><b:message key="deploy_process_jsp.versionInfo"/></legend><!-- 版本相关信息 -->
						<div>
							<input type="radio" id="deployType_default" name="option/mode" value="default" checked="true" onclick="disableSelectbox('true')">
							<label for="deployType_default"><b:message key="deploy_process_jsp.deployType_default"/></label><!-- 按照默认方式提交 -->
							<div style="padding-left:13px"> 
								<b:message key="deploy_process_jsp.note"/>					
							</div><!-- (注: 当已经存在流程定义时覆盖最新版本,
								不存在流程定义时则创建新版本)  -->
						</div>
						<div>
							<input type="radio" id="deployType_update" name="option/mode" value="old-version" onclick="disableSelectbox('false')">
							<label for="deployType_update"><b:message key="deploy_process_jsp.deployType_update"/></label><!-- 覆盖已有版本 -->
							<div style="padding-left:63px">
								<select id="version" name="version" size="4" style="width:240px" disabled="true" >
								</select>
							</div>
						</div>
						<div>
							<input type="radio" id="deployType_new" name="option/mode" value="new-version" onclick="disableSelectbox('true')">
							<label for="deployType_new"><b:message key="deploy_process_jsp.deployType_new"/></label><!-- 创建新版本 -->
						</div>
						<div>
							<div style="display:inline;padding-left:3px">
								<label for="isRelease"><b:message key="deploy_process_jsp.isRelease"/></label><!-- 立即发布 -->
							</div>
							<input type="checkbox" id="isRelease" name="isRelease" value="true" checked="checked">
						</div>
						<div>
							<div style="display:inline;padding-left:3px">
								<label for="description"><b:message key="edit_autoact_info_jsp.desc"/></label><!-- 描述 -->
							</div>
							<div style="display:inline;padding-left:29px">
								<textarea id="description" name="option/versionDesc" rows="4" cols="33"></textarea>
							</div>
						</div>
					</fieldset>
				</div>
				<div style="margin-top:15px; text-align:right;">
					<input type="button" name="btnOk" value="<b:message key="edit_autoact_info_jsp.ok"/>" class="button" onclick="deploy()"><!-- 确定 -->
					<input type="button" name="btnCancel" value="<b:message key="edit_autoact_info_jsp.cancel"/>" class="button" onclick="closeWin()"><!-- 取消 -->
				</div>
			</td>
		</tr> 
	</table>
	
	<h:hidden name="option/packageID" property="packageID" />
	<h:hidden name="option/packageName" property="packageName" />
	<h:hidden name="path" property="path" />
	<h:hidden name="processDefName" property="processDefName" />
	<h:hidden name="catalogUUID" property="catalogUUID" />
	
</form>