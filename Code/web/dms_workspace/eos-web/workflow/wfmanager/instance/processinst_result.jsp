<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
<head>
<title><b:message key="processinst_result_jsp.process_instance_query_result"/></title>
<script type="text/javascript">
	function checkAll(){
		if(document.forms['processInstForm'].processInstID != null) {
			var isChecked = document.forms['processInstForm'].operation.checked;
			var styleName = "";
			if (isChecked) {
				styleName = "EOS_table_selectRow";
			}
			else {
				styleName = "EOS_table_row";
			}
			if(document.forms['processInstForm'].processInstID.length == undefined) {
				document.forms['processInstForm'].processInstID.checked = isChecked;
			}
			else {
				for(i = 0;i<document.forms['processInstForm'].processInstID.length;i++) {
					document.forms['processInstForm'].processInstID[i].checked = isChecked;
					if (isFF) {
						$names("processInstRow")[i].setAttribute("class", styleName);//for FF
					}
					else {
						$names("processInstRow")[i].setAttribute("className", styleName);//for IE
					}
				}
			}
		}
	}
	
	function doSelect(chkObj){
		if (chkObj.checked){
			chkObj.checked=false;
		} else {
			chkObj.checked=true;
		}
	}
	
	function doSelectRow(rowObj) {
		var chkObj;
		chkObj = rowObj.cells[0].getElementsByTagName("input")[0];
		//chkObj.click();
		
		var chkAll = $name("operation");
	 	if(chkObj.checked && chkAll.checked){
	        chkAll.checked=false;
	        chkObj.checked=false;
	        rowObj.className = "EOS_table_row";
		}else{
			if(!chkObj.checked){
				  chkObj.checked=true;
				  rowObj.className = "EOS_table_selectRow";
			}else{
				  chkObj.checked=false;
				  rowObj.className = "EOS_table_row";
			}
			var el = document.getElementsByName('processInstID');
	      	var len = el.length;
	       	var temp=0;
	        for(var i=0; i<len; i++){  
	          if(el[i].checked == true){
	             temp=temp+1;
	          }
	        }
	        if(temp==len)
	        	chkAll.checked=true;
		}
	}
	
	function validate(actionName){

		if(document.forms['processInstForm'].processInstID == undefined)
			return false;
			
		if(actionName == 'btQuery' || actionName == 'changeAllVersion')
			return true;
			
		if(document.forms['processInstForm'].processInstID.length == undefined){
			if(document.forms['processInstForm'].processInstID.checked){
				var values = new Array();
				values[0] = document.forms['processInstForm'].processInstID.value;
				return isAllowDone(actionName,values);
			}
		}else{			
			var values = new Array(document.forms['processInstForm'].processInstID.length);
			var isChecked = false;
			for(i = 0;i<document.forms['processInstForm'].processInstID.length;i++){
			  	if(document.forms['processInstForm'].processInstID[i].checked){
					values[i] = document.forms['processInstForm'].processInstID[i].value;
					isChecked = true;
				}
		  	}
		  	if(isChecked)
	  			return isAllowDone(actionName,values);
		}
		alert('<b:message key="processinst_result_jsp.please_select_process_instance"/>');
		return false;
	}
	
	function isAllowDone(actionName,values){
		return true;
	}
	
	function doSubmit(actionName){
		if(validate(actionName)){
			if(actionName == 'btQuery')
				doQuery();
			else if(actionName == 'btDelete')
				doDeleteProcessBatch();
			else if(actionName == 'btSuspend')
				doSuspendProcessInst();
			else if(actionName == 'btResume')
				doResumeProcessInst();
			else if(actionName == 'btPress')
				doPressProcessInst();
			else if(actionName == 'btAnnotate')
				doAnnotateProcessInst();
			else if(actionName == 'changeAllVersion' || actionName == 'changeVersionBatch')
				doChangeVersion(actionName);
		}
	}
	
	function doQuery(){
		document.forms['processInstForm'].action = 'com.primeton.workflow.manager.instance.getProcessInstList.flow?_eosFlowAction=queryProcessInstWithPage';
		document.forms['processInstForm'].submit();
	}
	
	function doDetail(processInstID,processDefID){
		document.forms['processInstForm'].action = 'com.primeton.workflow.manager.instance.navigation.flow?sourceFlag=process_instance_query&_eosFlowAction=diagramAction&processInstID='+processInstID+"&processDefID="+processDefID;
		document.forms['processInstForm'].target="_parent";
		document.forms['processInstForm'].submit();
	}
	
	function doDeleteProcessBatch(){
		if(!confirm('<b:message key="processinst_result_jsp.delete_confirm_desc"/>')){
			return false;
		} else {
			document.forms['processInstForm'].action = 'com.primeton.workflow.manager.instance.deleteProcessInstBatch.flow?_eosFlowAction=deleteProcessBatch';
			document.forms['processInstForm'].submit();
		}	
	}
	
	function doSuspendProcessInst(){
		if(!confirm('<b:message key="processinst_result_jsp.suspend_confirm_desc"/>')){
			return false;
		} else {
			// 判断是不是运行状态，不是不能被挂起
			// bug:7544
			var eles = document.getElementsByName("processInstID");
			for(var i = 0;i < eles.length;i++){
				if(eles[i].checked==true){
					var ajax = new HideSubmit("com.primeton.workflow.manager.instance.ProcessInstanceManager.getProcessInstState.biz");
					ajax.addParam("processInstID",eles[i].value);
					
					ajax.onFailure=function (){};
					ajax.submit();
	
					var result;
					try{
						result = ajax.getProperty("currentState");
					}catch(e){}
					// 运行状态的值是2
					if(result !=2){
						alert('<b:message key="processinst_result_jsp.selected_instance_cant_suspend"/>');
						return;
					}
				}
			}
	
			document.forms['processInstForm'].action = 'com.primeton.workflow.manager.instance.suspendProcessInstance.flow?_eosFlowAction=suspendProcessBatch';
			document.forms['processInstForm'].submit();
		}
	}
	
	function doResumeProcessInst(){
		if(!confirm('<b:message key="processinst_result_jsp.resume_confirm_desc"/>')){
			return false;
		} else {
			// bug : 7545
			var eles = document.getElementsByName("processInstID");
			for(var i = 0;i < eles.length;i++){
					if(eles[i].checked==true){
						var ajax = new HideSubmit("com.primeton.workflow.manager.instance.ProcessInstanceManager.getProcessInstState.biz");
						ajax.addParam("processInstID",eles[i].value);
						
						ajax.onFailure=function (){};
						ajax.submit();
		
						var result;
						try{
							result = ajax.getProperty("currentState");
						}catch(e){}
						// 挂起状态的值是3
						if(result !=3){
							alert('<b:message key="processinst_result_jsp.selected_instance_cant_resume"/>');
							return;
						}
					}
			}
		
			document.forms['processInstForm'].action = 'com.primeton.workflow.manager.instance.resumeProcessInstance.flow?_eosFlowAction=resumeProcessBatch';
			document.forms['processInstForm'].submit();
		}
	}
	
	function doPressProcessInst() {
		var eles = document.getElementsByName("processInstID");
		var selects = 0;
		var select_num = 0;
		for(var i = 0;i < eles.length;i++){
			if(eles[i].checked==true){
				selects+=1;
				select_num = i;
			}
			if(selects > 1){
				alert('<b:message key="processinst_result_jsp.not_support_press_multiterm"/>');
				return;
			}
		}
	
		// 判断是不是运行状态，不是不能被挂起
		var ajax = new HideSubmit("com.primeton.workflow.manager.instance.ProcessInstanceManager.getProcessInstState.biz");
		ajax.addParam("processInstID",eles[select_num].value);
				
		ajax.onFailure=function (){};
		ajax.submit();

		var result;
		try{
			result = ajax.getProperty("currentState");
		}catch(e){}
		// 运行状态的值是2
		if(result !=2){
			alert('<b:message key="processinst_result_jsp.selected_instance_cant_press"/>');
			return;
		}
	
		showModalCenter(contextPath+"/workflow/wfmanager/instance/operate_msg.jsp"+"?"+"operateType=1",null,function(returnValue){
			
			if(!returnValue){
				return false;
			}
			
			if (returnValue != null && returnValue.length >=0) 
			{
				appendHiddenChild('processInstForm','pressMessage',returnValue[0]);		
			}
			document.forms['processInstForm'].action='com.primeton.workflow.manager.instance.pressWorkItem.flow?_eosFlowAction=pressProcessInst';
			document.forms['processInstForm'].target = '_self';
			document.forms['processInstForm'].submit();
			alert("<b:message key="all_workitem_list_jsp.press_success"/>");//催办成功
		},'550','300',"<b:message key="processinst_result_jsp.pressProcessInst"/>") ; //添加流程实例催办
	}
	
	function doAnnotateProcessInst() {
		var eles = document.getElementsByName("processInstID");
		var selects = 0;
		var select_num = 0;
		for(var i = 0;i < eles.length;i++){
			if(eles[i].checked==true){
				selects+=1;
				select_num = i;
			}
			if(selects > 1){
				alert('<b:message key="processinst_result_jsp.not_support_annotate_multiterm"/>');
				return;
			}
		}
		
		
		// 判断是不是运行状态，不是不能被挂起
		var ajax = new HideSubmit("com.primeton.workflow.manager.instance.ProcessInstanceManager.getProcessInstState.biz");
		ajax.addParam("processInstID",eles[select_num].value);
				
		ajax.onFailure=function (){};
		ajax.submit();

		var result;
		try{
			result = ajax.getProperty("currentState");
		}catch(e){}
		// 运行状态的值是2
		if(result !=2){
			alert('<b:message key="processinst_result_jsp.selected_instance_cant_annotate"/>');
			return;
		}
		
		showModalCenter(contextPath+"/workflow/wfmanager/instance/operate_msg.jsp"+"?"+"operateType=2",null,function(returnValue){
			
			if(!returnValue){
				return false;
			}
			
			if (returnValue != null && returnValue.length >=0) 
			{
				appendHiddenChild('processInstForm','annotationMessage',returnValue[0]);		
			}
			document.forms['processInstForm'].action='com.primeton.workflow.manager.instance.annotateWorkItem.flow?_eosFlowAction=annotateProcessInst';
			document.forms['processInstForm'].target = '_self';
			document.forms['processInstForm'].submit();
			alert("<b:message key="all_workitem_list_jsp.annotation_success"/>");//批注成功
		},'550','300',"<b:message key="processinst_result_jsp.annotateProcessInst"/>") ; //添加流程实例批注
	}
	
	function doChangeVersion(actionName) {
		if (actionName == "changeVersionBatch") {
			var eles = document.getElementsByName("processInstID");
			for(var i = 0;i < eles.length;i++){
				if(eles[i].checked==true){
					var ajax = new HideSubmit("com.primeton.workflow.manager.instance.ProcessInstanceManager.getProcessInstState.biz");
					ajax.addParam("processInstID",eles[i].value);
						
					ajax.onFailure=function (){};
					ajax.submit();
			
					var result;
					try{
						result = ajax.getProperty("currentState");
					}catch(e){}
					// 完成或终止状态的值是7,8
					if(result == 7 || result == 8){
						alert('<b:message key="processinst_result_jsp.selected_instance_cant_change_version2"/>'.replace('{0}',eles[i].value));
						return false;
					}
				}
			}
		}
		
		if (actionName == "changeAllVersion") {
		
		}
	
		var processDefID = document.forms['processInstForm'].elements['queryCondition/_expr[1]/processDefID'].value;
		var processInstIDS = document.forms['processInstForm'].processInstID;
		var page = 'com.primeton.workflow.manager.instance.getAllProcessVersionList.flow?_eosFlowAction=queryAllVersion&actionName='+actionName+"&processDefID="+processDefID;
		
		var mmm=showModalCenter(page,processInstIDS,function(arg){
			if(arg) {
				doSubmit('btQuery');
			}
		},'640','380','<b:message key="processinst_result_jsp.change_process_version"/>');

		
	}
	
	function initiFrame(){
		var height=frameElement.parentNode.offsetHeight;
		parent.frameElement
		frameElement.height=height;
		frameElement.style.height=height+"px";
	}
  </script>
</head>
<body onLoad="initiFrame()" style="background:#EAF0F1;repeat-x;margin-top:0px;margin-left:0px;margin-buttom:0px; margin-right: 0px;margin: auto;overflow:auto; overflow-y:auto; overflow-x: auto;">
<table class="workarea" width="100%">
	<tr>
		<td class="EOS_panel_head" valign="middle"><b:message key="processinst_result_jsp.query_process_instance_result_list"/></td>
	</tr>
	<tr>
		<td width="100%" valign="top">
		<form name="processInstForm" action="" method="post">
		<l:present property="queryCondition">
			<h:hiddendata property="queryCondition" />
			<h:hidden property="isIncludeSubCatalog" />
			<h:hidden property="catalogUUID" />
			<h:hidden id="pressMessage"/>
   			<h:hidden id="annotationMessage"/>
		</l:present>
		<table border="0" class="EOS_table" width="100%">
			<tr>
				<th width="5%" nowrap="nowrap"><input type="checkbox"
					name="operation" value="checkbox" onClick="checkAll();"><b:message key="processinst_result_jsp.operation"/></th>
				<th width="10%" nowrap="nowrap"><b:message key="catalog_common.biz_catalog"/></th>
				<th width="10%" nowrap="nowrap"><b:message key="processinst_result_jsp.process_instance_id"/></th>
				<th width="10%" nowrap="nowrap"><b:message key="processinst_result_jsp.process_instance_name"/></th>
				<th width="20%" nowrap="nowrap"><b:message key="processinst_result_jsp.process_def_name"/></th>
				<th width="5%" nowrap="nowrap"><b:message key="processinst_result_jsp.process_instance_status"/></th>
				<th width="5%" nowrap="nowrap"><b:message key="processinst_result_jsp.is_overtime"/></th>
				<th width="5%" nowrap="nowrap"><b:message key="processinst_result_jsp.creator"/></th>
				<th width="15%" nowrap="nowrap"><b:message key="processinst_result_jsp.start_time"/></th>
				<th width="15%" nowrap="nowrap"><b:message key="processinst_result_jsp.end_time"/></th>
			</tr>
			<l:present property="processInstList">
				<l:iterate id="list" property="processInstList">
					<tr id="processInstRow" name="processInstRow" class="EOS_table_row" onclick="doSelectRow(this);">
						<td nowrap="nowrap"><h:checkbox iterateId="list" onclick="doSelect(this);"
							name="processInstID" property="processInstID" /></td>
						<td nowrap="nowrap">
							<l:present iterateId="list" property="catalogName" >
								<b:write iterateId="list" property="catalogName" />
							</l:present>
							<l:notPresent iterateId="list" property="catalogName" >
								<b:message key="catalog_common.default_biz_catalog"/>
							</l:notPresent>
						</td>
						<td nowrap="nowrap"><b:write iterateId="list" property="processInstID" /></td>
						<td nowrap="nowrap">
							<a href="javascript:void(doDetail(<b:write iterateId="list" property="processInstID"/>,<b:write iterateId="list" property="processDefID"/>))">
								<b:write iterateId="list" property="processInstName" maxLength="50" /></a></td>
						<td nowrap="nowrap">
							<span title='<b:write iterateId="list" property="processDefName" />'><b:write iterateId="list" property="processDefName" maxLength="15"/></span>
						</td>
						<td nowrap="nowrap">
							<d:write iterateId="list" dictTypeId="WFDICT_ProcessState" property="currentState" />
							<h:hidden iterateId="list" property="currentState" /></td>
						<td nowrap="nowrap">
							<d:write iterateId="list" dictTypeId="WFDICT_YN" property="isTimeOut" /></td>
						<td nowrap="nowrap"><b:write iterateId="list" property="creator" /></td>
						<td nowrap="nowrap">
							<b:write iterateId="list" property="startTime" formatPattern="yyyy-MM-dd hh:MM" srcFormatPattern="yyyyMMddHHmmss" /></td>
						<td nowrap="nowrap">
							<b:write iterateId="list" property="endTime" formatPattern="yyyy-MM-dd hh:MM" srcFormatPattern="yyyyMMddHHmmss" /></td>
					</tr>
				</l:iterate>
			</l:present>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			height="30">
			<tr>
				<td align="left" nowrap="nowrap">
				<input name="btDelete" type="button" class="button" value='<b:message key="manager_common.delete"/>' onClick="doSubmit('btDelete')">
				<input name="btSuspend" type="button" class="button" value='<b:message key="manager_common.suspend"/>' onClick="doSubmit('btSuspend')">
				<input name="btResume" type="button" class="button" value='<b:message key="manager_common.resume"/>' onClick="doSubmit('btResume')">
				<input name="btPress" type="button" class="button" value='<b:message key="manager_common.press"/>' onClick="doSubmit('btPress')">
				<input name="btAnnotate" type="button" class="button" value='<b:message key="manager_common.annotate"/>' onClick="doSubmit('btAnnotate')">
				<l:present property="queryCondition">
					<l:present property="queryCondition/_expr[1]/processDefID">
						<l:notEqual property="queryCondition/_expr[1]/processDefID" targetValue="">
							<input name="btChangeVersion" type="button" class="button" value='<b:message key="manager_common.change_version"/>' onClick="doSubmit('changeVersionBatch')">
							<input name="btChangeVersion" type="button" class="button" value='<b:message key="manager_common.change_all_version"/>' onClick="doSubmit('changeAllVersion')">
						</l:notEqual>
					</l:present>
				</l:present></td>
				<td align="right" nowrap="nowrap">
					<b:set name="action" value="com.primeton.workflow.manager.instance.getProcessInstList.flow?_eosFlowAction=queryProcessInstWithPage" />
					<b:set name="target" value="_self" /> 
					<%@ include	file="/workflow/wfcomponent/web/common/pagination.jsp"%>
				</td>
			</tr>
		</table>
		</form>
		</td>
	</tr>
</table>
</body>
</html>
<script>
	var cnt = 0;
	<l:present property="processInstList">
	cnt = <b:size property="processInstList"/>
	</l:present>
	if (cnt==0){
		$name("btDelete").disabled=true;
		$name("btSuspend").disabled=true;
		$name("btResume").disabled=true;
		$name("btPress").disabled=true;
		$name("btAnnotate").disabled=true;
	}
</script>
