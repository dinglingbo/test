<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/instance/common.jsp"%>

<html>
<head>
<script language="javascript">
	
	function validate(actionName){
		disableButton();
		var hs = new HideSubmit('com.primeton.workflow.manager.instance.ProcessInstanceManager.getProcessInstState.biz');
		var processInstID = $id('hiddenData').processInstID.value;
		hs.addParam('processInstID',processInstID);
		
		if(actionName == 'btResume'){
			hs.submit();
			var currentState = hs.getProperty('currentState');
			if(currentState != 3){
				alert('<b:message key="process_inst_graph_jsp.unsuspend_cannot_resume"/>');//流程实例状态当前不是挂起状态，不能执行恢复操作
				enableButton();
				return false;
			}
		}else if(actionName == 'btSuspend'){
			hs.submit();
			var currentState = hs.getProperty('currentState');
			if(currentState != 2){
				alert('<b:message key="process_inst_graph_jsp.not_running_cannot_suspend"/>');//流程实例状态当前不是运行状态，不能执行挂起操作
				enableButton();
				return false;
			}
		
		}else if(actionName == 'btTerminate'){
			hs.submit();
			var currentState = hs.getProperty('currentState');
			if(currentState == 7){
				alert('<b:message key="process_inst_graph_jsp.completed_cannot_terminate"/>');//流程实例状态当前是已完成状态，不能执行终止操作
				enableButton();
				return false;
			}else if(currentState == 8){
				alert('<b:message key="process_inst_graph_jsp.terminational_cannot_terminate"/>');//流程实例状态当前是终止状态，不能执行终止操作
				enableButton();
				return false;
			}
		}else if(actionName == 'btStart'){
			hs.submit();
			var currentState = hs.getProperty('currentState');
			if(currentState != 1){
				alert('<b:message key="process_inst_graph_jsp.unstart_can_start"/>');//未启动的流程实例才能执行 启动 操作
				enableButton();
				return false;
			}
		}else if(actionName == 'changeVersionBatch'){
			hs.submit();
			var currentState = hs.getProperty('currentState');
			// 完成或终止状态的值是7,8
			if(currentState == 7 || currentState == 8){
				alert('<b:message key="process_inst_graph_jsp.cannot_modify_version"/>');//选中的流程实例状态为完成或终止，不能更换版本
				enableButton();
				return false;
			}
		}
		
		return true;
	}
	
	
	function doSubmit(actionName){
		if(validate(actionName)){
			if(actionName == 'btProcessInstDetail')
				showProcessInstDetail();
				
			else if(actionName == 'btRelativeData')
				showRelativeData();
				
			else if(actionName == 'btSuspend')
				doSuspendProcessInst();
				
			else if(actionName == 'btResume')
				doResumeProcessInst();
				
			else if(actionName == 'btTerminate')
				doTerminateProcessInst();
				
			else if(actionName == 'btDelete')
				doDeleteProcessInst();
				
			else if(actionName == 'changeVersionBatch')
				doChangeVersion(actionName);
			
			else if(actionName == 'goBackDoQuery')
				goBackDoQuery();
				
			else if(actionName == 'goBackDoAdvanceQuery')
				goBackDoAdvanceQuery();
				
			else if(actionName == 'btStart')
				goStart();
		}
	}
	
	function reloadProcessInstGraph(){
		enableButton();
		var formObj = $id('hiddenData');		
		formObj.action = 'com.primeton.workflow.manager.instance.navigation.flow?_eosFlowAction=graphAction';
		formObj.target = '_parent';
		formObj.submit();
	}
	
	function showProcessInstDetail(){
		enableButton();
		var formObj = $id('hiddenData');
		var page =  'com.primeton.workflow.manager.instance.findProcessInstanceDetail.flow?_eosFlowAction=action0&processInstID='+formObj.processInstID.value;
		showModalCenter(page,null,null,'510','200','<b:message key="process_inst_graph_jsp.proc_inst_info"/>') ;//流程实例信息
	}
	
	function showRelativeData(){
		enableButton();
		var formObj = $id('hiddenData');
		var page = 'com.primeton.workflow.manager.instance.loadRelativeDataXml.flow?_eosFlowAction=loadXmlString&processInstID='+formObj.processInstID.value;
		showModalCenter(page,null,null,'590','280','<b:message key="process_inst_graph_jsp.related_data"/>') ;//相关数据
	}
	
	function doSuspendProcessInst(){
		var formObj = $id('hiddenData');
		formObj.action = 'com.primeton.workflow.manager.instance.suspendProcessInstance.flow?_eosFlowAction=suspendAction';
		formObj.submit();
	}
	
	function doResumeProcessInst(){
		var formObj = $id('hiddenData');
		formObj.action = 'com.primeton.workflow.manager.instance.resumeProcessInstance.flow?_eosFlowAction=resumeAction';
		formObj.submit();
	}
	
	function doTerminateProcessInst(){
		if(!confirm('<b:message key="process_inst_graph_jsp.sure_operation"/>')){//您确定要执行该操作吗？
			enableButton();
	      	return false;
		}
		var formObj = $id('hiddenData');
		formObj.action = 'com.primeton.workflow.manager.instance.terminateProcessInstance.flow?_eosFlowAction=terminateAction';
		formObj.submit();		
	}
	
	//来源页面标识
	var sourceFlag = '<b:write property="sourceFlag"/>';
	
	function doDeleteProcessInst(){
		if(!confirm('<b:message key="process_inst_graph_jsp.sure_operation"/>')){//您确定要执行该操作吗？
			enableButton();
	      	return false;
		}	
		var formObj = $id('hiddenData');
		formObj.action = 'com.primeton.workflow.manager.instance.deleteProcessInstBatch.flow?_eosFlowAction=deleteProcessSingle&sourceFlag='+sourceFlag;
		formObj.target = '_parent';
		formObj.submit();
	}
	
	function doChangeVersion(actionName){
		enableButton();
		var formObj = $id('hiddenData');
		var processDefID = formObj.elements['processDefID'].value;
		//var processInstID = formObj.elements['processInstID'].value;
 		var processInstIDS = formObj.processInstID;
 		if(processInstIDS.value<0){
 			alert('<b:message key="process_inst_graph_jsp.short_process_cannot_modify_version"/>');//短流程不允许更换版本
 		}else{
			var action = 'com.primeton.workflow.manager.instance.getAllProcessVersionList.flow?_eosFlowAction=queryAllVersion&actionName='+actionName+"&processDefID="+processDefID;
			showModalCenter(action,processInstIDS,function(arg){
				if(arg) {
					if (sourceFlag=="process_instance_query") {
						goBackDoQuery();
					} else if (sourceFlag=="advance_query") {
						goBackDoAdvanceQuery();
					} else {
						goBackDoQuery();
					}
				}
			},'640','400','<b:message key="process_inst_graph_jsp.modify_proc_inst_version"/>');//更换流程实例版本
		}
	}	
	
	function goBackDoQuery(){
		var formObj = $id('hiddenData');
		formObj.action = 'com.primeton.workflow.manager.instance.navigation.flow?_eosFlowAction=queryWithProcessInstCriteria';
		formObj.target = '_parent';
		formObj.submit();		
	}
	
	function goBackDoAdvanceQuery(){
		var formObj = $id('hiddenData');
		formObj.action = '<%=request.getContextPath()%>/workflow/wfmanager/query/query_instance.jsp';
		formObj.target = '_parent';
		formObj.submit();		
	}
	
	function goStart(){
		var formObj = $id('hiddenData');
		formObj.action = 'com.primeton.workflow.manager.instance.startProcessInstance.flow?_eosFlowAction=startAction';
		enableButton()
		formObj.submit();		
	
	}
	
	function handleZoom(selectObj) {
	//FIXME: document.getElementById  --> $id
		var action = 'com.primeton.workflow.manager.instance.navigation.flow?_eosFlowAction=graphAction&processInstID=<b:write property="processInstID"/>&zoomQuotiety='+selectObj.value;
		$id('instgraph').src = action;
	}
	
	function  refreshGraph(){
		//document.frames("instgraph").document.location.reload();				
	   	window.instgraph.location.href='com.primeton.workflow.manager.instance.navigation.flow?'+'_eosFlowAction=graphAction&processInstID=<b:write property="processInstID"/>&zoomQuotiety='+$id('selectZoomQuotiety').value;
　　    //window.instgraph.location.reload;
	}
	
	function disableButton(){
		$name("btProcessInstDetail").disabled=true;
		$name("btRelativeData").disabled=true;
		$name("btStart").disabled=true;
		$name("btResume").disabled=true;
		$name("btSuspend").disabled=true;
		$name("btTerminate").disabled=true;
		$name("btDelete").disabled=true;
		$name("btChangeVersion").disabled=true;
	}
	
	function enableButton(){
		$name("btProcessInstDetail").disabled=false;
		$name("btRelativeData").disabled=false;
		$name("btStart").disabled=false;
		$name("btResume").disabled=false;
		$name("btSuspend").disabled=false;
		$name("btTerminate").disabled=false;
		$name("btDelete").disabled=false;
		$name("btChangeVersion").disabled=false;
	}
</script>
<title><b:message key="process_inst_graph_jsp.biz_proc_graph"/></title><%-- 业务流程图 --%>
</head>
<body topmargin="0" leftmargin="0" rightmargin="0" marginheight="0">
<table width="100%" height="100%" border="0" cellspacing="0"
	cellpadding="0">
	<tr height="30">
		<td width="2%">&nbsp;</td>
		<td width="59%">
			<input type="button" id="btProcessInstDetail" name="btProcessInstDetail"	value="<b:message key="process_inst_graph_jsp.inst_info"/>" class="button" onClick="doSubmit('btProcessInstDetail')"><%-- 流程实例信息 --%>
			<input type="button" id="btRelativeData" name="btRelativeData" value="<b:message key="process_inst_graph_jsp.related_data"/>" class="button" onClick="doSubmit('btRelativeData')"><%-- 相关数据 --%>
			<input type="button" id="btStart" name="btStart" value="<b:message key="process_inst_graph_jsp.start"/>" class="button" onClick="doSubmit('btStart')" title="<b:message key="process_inst_graph_jsp.start_pro_inst"/>"><%-- 启动/启动流程实例 --%>
			<input type="button" id="btResume" name="btResume" value="<b:message key="process_inst_graph_jsp.resume"/>" class="button"	onClick="doSubmit('btResume')" title="<b:message key="process_inst_graph_jsp.process_resume"/>"><%-- 恢复/使流程恢复运行状态继续执行 --%>
			<input type="button" id="btSuspend" name="btSuspend" value="<b:message key="process_inst_graph_jsp.suspend"/>" class="button" onClick="doSubmit('btSuspend')" title="<b:message key="process_inst_graph_jsp.suspend_title"/>"><%-- 挂起/使流程处于挂起状态,流程不可执行,按‘ 恢复’按钮 后才能恢复执行 --%>
			<input type="button" id="btTerminate" name="btTerminate" value="<b:message key="process_inst_graph_jsp.terminate"/>" class="button" onClick="doSubmit('btTerminate')" title="<b:message key="process_inst_graph_jsp.terminate_title"/>"><%-- 终止/使流程处于终止状态,流程实例从此不可再被执行 --%>
			<input type="button" id="btDelete" name="btDelete" value="<b:message key="process_inst_graph_jsp.delete"/>" class="button"	onClick="doSubmit('btDelete')"><%-- 删除 --%>
			<input type="button" id="btChangeVersion" name="btChangeVersion" value="<b:message key="process_inst_graph_jsp.modify_version"/>" class="button" onClick="doSubmit('changeVersionBatch')"><%-- 更换版本 --%>
		</td>
		<td width="9%" align="right" nowrap><b:message key="process_inst_graph_jsp.scaling"/></td><%-- 缩放比例: --%>
		<td width="7%"><select id="selectZoomQuotiety" onChange="handleZoom(this)" size="1"
			name="zoomQuotiety">
			<option value="1.0"><b:message key="process_inst_graph_jsp.auto"/></option><%-- 自动 --%>
			<option value="0.4">40%</option>
			<option value="0.55">55%</option>
			<option value="0.7">70%</option>
			<option value="0.85">85%</option>
			<option value="1.0">100%</option>
			<option value="1.5">150%</option>
			<option value="2.0">200%</option>
		</select></td>
		<td width="13%"><input type="button" id="freshBtn" name="fresh" value="<b:message key="process_inst_graph_jsp.refresh"/>" class="button" onClick="refreshGraph();"></td><%-- 刷新 --%>
		<td width="10%" align="right">
			<l:equal property="sourceFlag" targetValue="process_instance_query">
				<input type="button" id="btGoBackDoQuery1" name="btGoBackDoQuery" value="<b:message key="process_inst_graph_jsp.back_to_inst_list"/>" class="button" onClick="doSubmit('goBackDoQuery')"><%-- 返回实例列表 --%>
			</l:equal>
			<l:equal property="sourceFlag" targetValue="advance_query">
				<input type="button" id="btGoBackDoQuery2" name="btGoBackDoQuery" value="<b:message key="process_inst_graph_jsp.back_to_inst_list"/>" class="button" onClick="doSubmit('goBackDoAdvanceQuery')"><%-- 返回实例列表 --%>
			</l:equal>
		</td>
	</tr>
	<tr>
		<td colspan="6"><iframe id="instgraph" name="instgraph"
			src='com.primeton.workflow.manager.instance.navigation.flow?_eosFlowAction=graphAction&processInstID=<b:write property="processInstID"/>&zoomQuotiety=1.0'
			frameborder="0" scrolling="auto" width="100%" marginwidth="0"
			marginheight="0" height="400" onload="enableButton();"></iframe></td>
	</tr>
	</form>
	<tr>
		<td colspan="6">&nbsp;</td>
	</tr>
</table>
<form id="hiddenData" name="hiddenDataForm" action="" target="instgraph" method="post">
<h:hidden name="processDefID" property="processDefID" />
<h:hidden name="processInstID" property="processInstID" />
<h:hidden name="pageCond/begin"	property="pageCond/begin" />
<h:hidden name="pageCond/length" property="pageCond/length" />
<h:hidden name="pageCond/isCount" property="pageCond/isCount" />
<h:hidden name="queryCondition/_entity"	value="com.eos.workflow.data.WFProcessInst" />
<!-- 保存流程实例查询条件值，用于返回按钮使用 -->
<h:hidden name="queryCondition/_expr[1]/processDefID" property="queryCondition/_expr[1]/processDefID" />
<h:hidden name="queryCondition/_expr[2]/processInstID" property="queryCondition/_expr[2]/processInstID" />
<h:hidden name="queryCondition/_expr[3]/processInstName" property="queryCondition/_expr[3]/processInstName" />
<h:hidden name="queryCondition/_expr[4]/currentState" property="queryCondition/_expr[4]/currentState" />
<h:hidden name="queryCondition/_expr[5]/isTimeOut" property="queryCondition/_expr[5]/isTimeOut" />
</form>
</body>
</html>
