<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<%@ include file = "/workflow/wfmanager/instance/common.jsp"%>
<script language="javascript">

/*用Ajax提交验证活动状态*/
function validate(actionName){
	disableButton();
	var processInstID = document.forms['activityDetailForm'].processInstID.value;
	if(checkProcessState(processInstID)){

		var activityInstID = document.forms['activityDetailForm'].activityInstID.value;
		//验证活动状态
		var hs = new HideSubmit('com.primeton.workflow.manager.instance.ActivityInstanceManager.getActivityInstState.biz');
		hs.addParam('activityInstID',activityInstID);
		hs.submit();
		var currentState = hs.getProperty('currentState');
		if(actionName == 'btReStart'){
			if(!(currentState == 7 || currentState == 8 || currentState == -1)){
				alert('<b:message key="activityinst_detail_jsp.restart_condition"/>');//只有完成、终止、异常状态下的活动才能被重启
				enableButton();
				return false;
			}
			//验证是否已经有运行状态的活动实例，有运行状态的活动实例不能重启另一个活动实例，每个活动定义只能有一个活动实例处于运行状态。
			var hs = new HideSubmit('com.primeton.workflow.manager.instance.ActivityInstanceManager.hasExistRunningActivityInst.biz');
			hs.addParam('processInstID',processInstID);
			hs.addParam('activityDefID',document.forms['activityDetailForm'].activityDefID.value);
			try{
				hs.submit();
			}catch(e){
				alert('<b:message key="activityinst_detail_jsp.error"/>'+hs.getExceptionMessage());//出错:
				return false;
			}
			var hasExistMoreRuningActInst = hs.getProperty('hasExistRuningActInst');
			if(hasExistMoreRuningActInst == 'true'){
				alert('<b:message key="activityinst_detail_jsp.cannot_restart_again"/>');//已经存在运行的活动实例,不可再重启新活动实例
				return false;
			}
		}else if(actionName == 'btTerminate'){
			if(currentState != 2 && currentState != 10 && currentState != -1){
				alert('<b:message key="activityinst_detail_jsp.terminate_condition"/>');//只有运行、待激活或异常状态下的活动才能被终止
				enableButton();
				return false;
			}
		}else if(actionName == 'btRollBack'){
			if(currentState != 2){
				alert('<b:message key="activityinst_detail_jsp.roll_back_condition"/>');//只有运行状态下的活动才能被回退
				enableButton();
				return false;
			}
		}else if(actionName == 'btActivation'){
			if(currentState != 10){
				alert('<b:message key="activityinst_detail_jsp.active_condition"/>');//只有待激活状态下的活动才能被激活
				enableButton();
				return false;
			}
		}else if(actionName == 'btFinish'){
			if(currentState != 2){
				alert('<b:message key="activityinst_detail_jsp.complete_condition"/>');//只有运行状态的活动才可以执行完成操作
				enableButton();
				return false;
			}
			<%--if(currentState == 7){
				alert('活动已被完成，不可操作');
				return false;
			}--%>
		}else if(actionName == 'btSuspend'){
			if(currentState != 2){
				alert('<b:message key="activityinst_detail_jsp.suspend_condition"/>');//当前活动不是运行状态，不能执行挂起操作
				enableButton();
				return false;
			}
		}else if(actionName == 'btResume'){
			if(currentState != 3){
				alert('<b:message key="activityinst_detail_jsp.resume_condition"/>');//当前活动不是挂起状态，不能执行恢复操作
				enableButton();
				return false;
			}
		}
		
		return true;
	
	}
	
	return false;
}

function doRestart(){
	var hs = new HideSubmit('com.primeton.workflow.manager.instance.ActivityInstanceManager.reStartActivityInst.biz');
	hs.addParam('activityInstID',<b:write property="activityInst/activityInstID"/>);
	hs.submit();
	var currentState = hs.getProperty('activityInst/currentState');
	if(currentState == null){
		alert('<b:message key="activityinst_detail_jsp.operation_fail"/>');//操作失败
		enableButton();
		return;
	}
	//$id('activityInstState').innerHTML = currentState;
	//要求关闭弹出窗口后,刷新图形显示页面
	alert('<b:message key="activityinst_detail_jsp.operation_success"/>');//操作成功
	window.location.href=location;
	window.returnValue = 'refreshGraph';
}

function doTerminate(){
	if(!confirm('<b:message key="activityinst_detail_jsp.sure_operation"/>')){//您确定要执行该操作吗？
		enableButton();
      	return false;
	}
	var hs = new HideSubmit('com.primeton.workflow.manager.instance.ActivityInstanceManager.terminateActivityInst.biz');
	hs.addParam('activityInstID',<b:write property="activityInst/activityInstID"/>);	
	hs.submit();
	var currentState = hs.getProperty('activityInst/currentState');
	if(currentState == null){
		alert('<b:message key="activityinst_detail_jsp.operation_fail"/>');//操作失败
		enableButton();
		return;
	}
	//$id('activityInstState').innerHTML = currentState;
	//要求关闭弹出窗口后,刷新图形显示页面
	alert('<b:message key="activityinst_detail_jsp.operation_success"/>');//操作成功
	window.location.href=location;
	window.returnValue = 'refreshGraph';
}

function doRollBack(){
	var activityInstID = document.forms['activityDetailForm'].activityInstID.value;
	var processInstID = document.forms['activityDetailForm'].processInstID.value;
	var action = 'com.primeton.workflow.manager.instance.queryActivitDefByProcessDefID.flow?_eosFlowAction=queryActivityDefsByProcessInstID&processInstID='+processInstID+'&activityInstID='+activityInstID;
	showModalCenter(action,null,function(returnValue){
		if(returnValue == true){
			document.forms['activityDetailForm'].submit();
		}
			
	},'500','300','<b:message key="activityinst_detail_jsp.act_inst_roll_back"/>') ;//活动实例回退
	enableButton();
}


function doActivation(){
	var activityInstID = document.forms['activityDetailForm'].activityInstID.value;
	var hs = new HideSubmit('com.primeton.workflow.manager.instance.ActivityInstanceManager.activationActivity.biz');
	hs.addParam('activityInstID',<b:write property="activityInst/activityInstID"/>);
    hs.submit();
	var currentState = hs.getProperty('activityInst/currentState');
	if(currentState == null){
		alert('<b:message key="activityinst_detail_jsp.operation_fail"/>');//操作失败
		enableButton();
		return;
	}
	alert('<b:message key="activityinst_detail_jsp.operation_success"/>');//操作成功
	window.location.href=location;
	window.returnValue = 'refreshGraph';	
}

function doFinish(){
	var activityInstID = document.forms['activityDetailForm'].activityInstID.value;
	var hs = new HideSubmit('com.primeton.workflow.manager.instance.ActivityInstanceManager.finishActivityInst.biz');
	hs.addParam('activityInstID',activityInstID);
	hs.submit();	
	if(ajaxIsSuccess==false){
		//alert('操作失败');
		enableButton();
		return;
	}
	alert('<b:message key="activityinst_detail_jsp.operation_success"/>');//操作成功
	window.location.href=location;
	window.returnValue = 'refreshGraph';
}


function doSuspend(){

	var hs = new HideSubmit('com.primeton.workflow.manager.instance.ActivityInstanceManager.suspendActivityInst.biz');
	hs.addParam('activityInstID',<b:write property="activityInst/activityInstID"/>);	
	hs.submit();
	var currentState = hs.getProperty('activityInst/currentState');
	if(currentState == null){
		alert('<b:message key="keySactivityinst_detail_jsp.operation_failtring"/>');//操作失败
		enableButton();
		return;
	}

	alert('<b:message key="activityinst_detail_jsp.operation_success"/>');//操作成功
	window.location.href=location;
	window.returnValue = 'refreshGraph';
}

function doResume(){

	var hs = new HideSubmit('com.primeton.workflow.manager.instance.ActivityInstanceManager.resumeActivityInst.biz');
	hs.addParam('activityInstID',<b:write property="activityInst/activityInstID"/>);	
	hs.submit();
	var currentState = hs.getProperty('activityInst/currentState');
	if(currentState == null){
		alert('<b:message key="activityinst_detail_jsp.operation_fail"/>');//操作失败
		enableButton();
		return;
	}

	alert('<b:message key="activityinst_detail_jsp.operation_success"/>');//操作成功
	window.location.href=location;
	window.returnValue = 'refreshGraph';
}

function doSubmit(actionName){
	if(validate(actionName)){
		if(actionName == 'btReStart')
			doRestart();
		else if(actionName == 'btTerminate')
			doTerminate();
		else if(actionName == 'btRollBack')
			doRollBack();
		else if(actionName == 'btActivation')
			doActivation();
		else if(actionName == 'btFinish')
			doFinish();
		else if(actionName == 'btSuspend')
			doSuspend();
		else if(actionName == 'btResume')
			doResume();
	}
}

function doQuery(){
	document.forms['activityDetailForm'].action = 'com.primeton.workflow.manager.instance.findActivityInstDetail.flow?_eosFlowAction=action0';
	document.forms['activityDetailForm'].target = '_self';
	document.forms['activityDetailForm'].submit();
}

function disableButton(){
	if($name("btFinish"))
		$name("btFinish").disabled=true;
	//$name("btReStart").disabled=true;
	if($name("btSuspend"))
		$name("btSuspend").disabled=true;
	if($name("btResume"))
		$name("btResume").disabled=true;
	if($name("btActivation"))
		$name("btActivation").disabled=true;
	if($name("btTerminate"))
		$name("btTerminate").disabled=true;
	if($name("btRollBack"))
		$name("btRollBack").disabled=true;
}

function enableButton(){
	if($name("btFinish"))
		$name("btFinish").disabled=false;
	//$name("btReStart").disabled=true;
	if($name("btSuspend"))
		$name("btSuspend").disabled=false;
	if($name("btResume"))
		$name("btResume").disabled=false;
	if($name("btActivation"))
		$name("btActivation").disabled=false;
	if($name("btTerminate"))
		$name("btTerminate").disabled=false;
	if($name("btRollBack"))
		$name("btRollBack").disabled=false;
}
</script>
</head>
<body  leftmargin="0" rightmargin="0" bottommargin="0" marginheight="0" marginwidth="0" topmargin="0" style="background:#EAF0F1;repeat-x;margin-top:0px;margin-left:0px;margin-buttom:0px; margin-right: 0px;margin: auto;overflow:auto; overflow-y:hidden; overflow-x: auto;">
<table border="0" cellpadding="1" cellspacing="1" class="workarea" width="100%">
  <tr>
    <td class="EOS_panel_head"><b:message key="activityinst_detail_jsp.activity_inst_info"/></td><%-- 活动实例信息 --%>
  </tr>
  <tr>
    <td width="100%">      
      <form name="activityDetailForm" action="com.primeton.workflow.manager.instance.findActivityInstDetail.flow?_eosFlowAction=action0" target="_self">
        <table border="0" cellpadding="0" cellspacing="0" align="center" width="98%">
          <tr>
            <td>
              <h:hidden name="activityInstID" property="activityInst/activityInstID"/>
              <h:hidden name="processInstID" property="activityInst/processInstID"/>
              <h:hidden name="activityDefID" property="activityInst/activityDefID"/>
              <table width="100%" border="0" cellpadding="0" cellspacing="0" class="form_table">
                <tr>
                  <td width="15%" class="EOS_table_row"><b:message key="activityinst_detail_jsp.activity_inst_id"/></td><%-- 活动实例ID: --%>
                  <td width="35%"><b:write property="activityInst/activityInstID"/></td>
                  <td width="15%" class="EOS_table_row"><b:message key="activityinst_detail_jsp.end_time"/></td><%-- 结束时间: --%>
                  <td width="35%" ><b:write property="activityInst/endTime"  formatPattern="yyyy-MM-dd hh:MM" srcFormatPattern="yyyyMMddHHmmss" ignore="true"/>
                  </td>
                </tr>
                <tr>
                  <td class="EOS_table_row"><b:message key="activityinst_detail_jsp.activity_name"/></td><%-- 活动名称: --%>
                  <td><b:write property="activityInst/activityInstName"/></td>
                  <td class="EOS_table_row" nowrap="nowrap"><b:message key="activityinst_detail_jsp.proc_inst_id"/></td><%-- 流程实例ID: --%>
                  <td><b:write property="activityInst/processInstID"/></td>
                </tr>
                <tr>
                  <td class="EOS_table_row"><b:message key="activityinst_detail_jsp.act_desc"/></td><%-- 活动描述: --%>
                  <td><b:write property="activityInst/activityInstDesc"/></td>
                  <td class="EOS_table_row"><b:message key="activityinst_detail_jsp.act_def_id"/></td><%-- 活动定义ID: --%>
                  <td><b:write property="activityInst/activityDefID"/></td>
                </tr>
                <tr>
                  <td class="EOS_table_row"><b:message key="activityinst_detail_jsp.cur_state"/></td><%-- 当前状态: --%>
                  <td><span id="activityInstState"><d:write property="activityInst/currentState" dictTypeId="WFDICT_ActivityState"/></span></td>
                  <td class="EOS_table_row"><b:message key="activityinst_detail_jsp.act_type"/></td><%-- 活动类型: --%>
                  <td><d:write property="activityInst/activityType" dictTypeId="WFDICT_ActivityType"/></td>
                </tr>
                <tr>
                  <td class="EOS_table_row"><b:message key="activityinst_detail_jsp.create_time"/></td><%-- 创建时间: --%>
                  <td><b:write property="activityInst/createTime" formatPattern="yyyy-MM-dd hh:MM"  srcFormatPattern="yyyyMMddHHmmss"/>
                  </td>
                  <td class="EOS_table_row"><b:message key="activityinst_detail_jsp.start_time"/></td><%-- 启动时间: --%>
                  <td><b:write property="activityInst/startTime" formatPattern="yyyy-MM-dd hh:MM" srcFormatPattern="yyyyMMddHHmmss"/>
                 &nbsp;</td>
                </tr>
                <tr>
                  <td colspan="4" class="form_bottom">
                  	<l:equal property="activityInst/activityType" targetValue="finish">
                  	<input type="button" id="btActivation" name="btActivation" value="<b:message key="activityinst_detail_jsp.activate"/>" class="button" onClick="doSubmit('btActivation');">&nbsp;<%-- 激活 --%>
                  	</l:equal>
                  	<l:notEqual property="activityInst/activityType" targetValue="finish">
                  	<input type="button" id="btFinish" name="btFinish" value="<b:message key="activityinst_detail_jsp.complete"/>" class="button" onClick="doSubmit('btFinish')">&nbsp;<%-- 完成 --%>
				    <input type="button" id="btSuspend" name="btSuspend" value="<b:message key="activityinst_detail_jsp.suspend"/>" class="button" onClick="doSubmit('btSuspend');">&nbsp;<%-- 挂起 --%>
				    <input type="button" id="btResume" name="btResume" value="<b:message key="activityinst_detail_jsp.resume"/>" class="button" onClick="doSubmit('btResume');">&nbsp;<%-- 恢复 --%>
				    <input type="button" id="btActivation" name="btActivation" value="<b:message key="activityinst_detail_jsp.activate"/>" class="button" onClick="doSubmit('btActivation');">&nbsp;<%-- 激活 --%>
				  	<input type="button" id="btTerminate" name="btTerminate" value="<b:message key="activityinst_detail_jsp.terminate"/>" class="button" onClick="doSubmit('btTerminate');">&nbsp;<%-- 终止 --%>
				    <input type="button" id="btRollBack" name="btRollBack" value="<b:message key="activityinst_detail_jsp.roll_back"/>" class="button" onClick="doSubmit('btRollBack');">&nbsp;<%-- 回退 --%>
				    </l:notEqual>
				  </td>
                </tr>
              </table>
            </td>
          </tr>          
        </table>
      </form>
    </td>
  </tr>
</table>
</body>
</html>
