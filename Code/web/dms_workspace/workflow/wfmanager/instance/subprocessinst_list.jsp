<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<%@ include file = "/workflow/wfmanager/instance/common.jsp"%>
<script language="javascript">
	function checkAll(){
		if(document.forms['subProcessInstForm'].processInstID != null){
			var isChecked = document.forms['subProcessInstForm'].operation.checked;
			if(document.forms['subProcessInstForm'].processInstID.length == undefined)
				document.forms['subProcessInstForm'].processInstID.checked = isChecked;				
			else
				for(i = 0;i<document.forms['subProcessInstForm'].processInstID.length;i++)
					document.forms['subProcessInstForm'].processInstID[i].checked = isChecked;
		}
	}
	
	function validate(actionName){

		if(document.forms['subProcessInstForm'].processInstID == undefined)
			return false;
			
		if(document.forms['subProcessInstForm'].processInstID.length == undefined){
			if(document.forms['subProcessInstForm'].processInstID.checked){
				var values = new Array();
				values[0] = document.forms['subProcessInstForm'].processInstID.value;
				return isAllowDone(actionName,values);
			}
		}else{
			var values = new Array(document.forms['subProcessInstForm'].processInstID.length);
			var isChecked = false;
			for(i = 0;i<document.forms['subProcessInstForm'].processInstID.length;i++){
			  	if(document.forms['subProcessInstForm'].processInstID[i].checked){
					values[i] = document.forms['subProcessInstForm'].processInstID.value;
					isChecked = true;
				}
		  	}
		  	if(isChecked)
	  			return isAllowDone(actionName,values);
		}
		alert('<b:message key="subprocessinst_list_jsp.select_subproinst_record"/>');//请先选中一条子流程实例记录
		return false;
	}
	
	//TODO:用Ajax判断状态
	function isAllowDone(actionName,values){
		if(actionName == 'btSuspend')
			//TODO:检查所选择的流程实例是否处于运行状态
			return true;
		else if(actionName == 'btResume')
			//TODO:检查所选择的流程实例是否处于挂起状态
			return true;
		return true;
	}
	
	function doSubmit(actionName){
		if(validate(actionName)){
			if(actionName == 'btDelete')
				doDeleteProcessBatch();
			else if(actionName == 'btSuspend')
				doSuspendProcessInst();
			else if(actionName == 'btResume')
				doResumeProcessInst();
		}
	}
	
	function doDeleteProcessBatch(){
		if(!confirm('<b:message key="subprocessinst_list_jsp.sure_exec_op"/>')){//您确定要执行该操作吗？
				      return false;
		}
		document.forms['subProcessInstForm'].action = 'com.primeton.workflow.manager.instance.deleteProcessInstBatch.flow?_eosFlowAction=deleteSubProcessBatch';	
		document.forms['subProcessInstForm'].submit();
	}
	
	function doSuspendProcessInst(){
		if(!confirm('<b:message key="subprocessinst_list_jsp.sure_suspend"/>')){//您确定要挂起流程实例吗？
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
						alert('<b:message key="subprocessinst_list_jsp.selected_cannot_suspend"/>');//选中的流程实例不能被挂起
						return;
					}
				}
			}
			
			document.forms['subProcessInstForm'].action = 'com.primeton.workflow.manager.instance.suspendProcessInstance.flow?_eosFlowAction=suspendSubProcessBatch';
			document.forms['subProcessInstForm'].submit();
		}
	}
	
	function doResumeProcessInst(){
		if(!confirm('<b:message key="subprocessinst_list_jsp.sure_resume_inst"/>')){//您确定要恢复流程实例吗？
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
							alert('<b:message key="subprocessinst_list_jsp.selected_cannot_resume"/>');//选中的流程实例不能被恢复
							return;
						}
					}
			}
			
		document.forms['subProcessInstForm'].action = 'com.primeton.workflow.manager.instance.resumeProcessInstance.flow?_eosFlowAction=resumeSubProcessBatch';
		document.forms['subProcessInstForm'].submit();
		}
	}
	
	function showSubProcessGraph(processInstID){
		var modelArgs = getCurrentModalArguments();
		var offset = 20;
		var modelLeft = Number(substringBefore(modelArgs.container.style.left,'px'));
		var modelTop = Number(substringBefore(modelArgs.container.style.top,'px'));
		var winLeft = modelLeft + offset;
		var winTop = modelTop + offset;
		if(processInstID == null)
			return;
		var action = 'com.primeton.workflow.manager.instance.navigation.flow?_eosFlowAction=graphAction&processInstID='+processInstID;
		showModal(action,null,function(returnValue){
			if(returnValue == 'refreshGraph')
				window.location.href=location;
			},'620','400',winLeft,winTop,'<b:message key="subprocessinst_list_jsp.act_instance_monitor"/>');//活动实例监控
	}
	
</script>
</head>
<body leftmargin="0" rightmargin="0" bottommargin="0" marginheight="0" marginwidth="0" topmargin="0"  style="background:#EAF0F1;repeat-x;margin-top:0px;margin-left:0px;margin-buttom:0px; margin-right: 0px;margin: auto;overflow:auto; overflow-y:hidden; overflow-x: auto;">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
    <td class="EOS_panel_head" valign="middle"><b:message key="subprocessinst_list_jsp.query_results_list"/></td><%-- 查询流程实例结果列表 --%>
  </tr>
  <tr>
    <td width="100%"  height="440"  valign="top">
      <form name="subProcessInstForm" action="" method="post">          
      <h:hidden name="activityInstID" property="activityInstID"/>      
      <table border="0" class="EOS_table" width="100%">
        <tr class="EOS_table_head">
          <th width="12%"><input type="checkbox" name="operation" value="checkbox" onClick="checkAll();"><b:message key="subprocessinst_list_jsp.operation"/></th><%-- 操作 --%>
          <th width="12%"><b:message key="subprocessinst_list_jsp.process_inst_id"/></th><%-- 流程实例ID --%>
          <th width="12%"><b:message key="subprocessinst_list_jsp.inst_name"/></th><%-- 实例名称 --%>
          <th width="12%"><b:message key="subprocessinst_list_jsp.state"/></th><%-- 状态 --%>
          <th width="12%"><b:message key="subprocessinst_list_jsp.is_outtime"/></th><%-- 是否超时 --%>
          <th width="12%"><b:message key="subprocessinst_list_jsp.creator"/></th><%-- 创建者 --%>
        </tr>
        <l:present property="subProcessInstList">
		    <l:iterate id="list" property="subProcessInstList">
        <tr class="EOS_table_selectRow">
          <td><h:checkbox iterateId="list" name="processInstID" property="processInstID"/></td>
          <td><b:write iterateId="list" property="processInstID"/></td>
          <td>
          <a href="javascript:void(showSubProcessGraph(<b:write iterateId="list" property="processInstID"/>))">
          <b:write iterateId="list" property="processInstName"/>
          </a>
          </td>
          <td><d:write iterateId="list" property="currentState" dictTypeId="WFDICT_ProcessState"/></td>
          <td><d:write iterateId="list" property="isTimeOut" dictTypeId="WFDICT_YN"/></td>
          <td><b:write iterateId="list" property="creator"/></td>          
        </tr>
        	</l:iterate>
        </l:present>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" >
        <tr>
          <td nowrap="nowrap">
            <input name=btDelete type="button" class="button" value="<b:message key="subprocessinst_list_jsp.delete"/>" onclick="doSubmit('btDelete')"><%-- 删除 --%>
            <input name="btSuspend" type="button" class="button" value="<b:message key="subprocessinst_list_jsp.suspend"/>" onclick="doSubmit('btSuspend')"><%-- 挂起 --%>
            <input name="btResume" type="button" class="button" value="<b:message key="subprocessinst_list_jsp.resume"/>" onclick="doSubmit('btResume')"><%-- 恢复 --%>
            &nbsp;&nbsp;
          </td>
          <td align="right" nowrap="nowrap">
            <b:set name="action" value="com.primeton.workflow.manager.instance.getProcessInstList.flow?_eosFlowAction=querySubProcessWithPage"/>
		    <b:set name="target" value="_self"/>
	        <%@ include file="/workflow/wfcomponent/web/common/pagination.jsp"%>
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
	<l:present property="subProcessInstList">
	cnt = <b:size property="subProcessInstList"/>
	</l:present>
	if (cnt==0){
		$name("btDelete").disabled=true;
		$name("btSuspend").disabled=true;
		$name("btResume").disabled=true;
	}
</script>