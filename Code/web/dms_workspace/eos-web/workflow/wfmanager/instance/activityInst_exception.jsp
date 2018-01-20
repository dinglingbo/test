<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<%@ include file = "/workflow/wfmanager/instance/common.jsp"%>
<script type="text/javascript" language="javascript">
	function validate(actionName){
		var processInstID = document.forms['tackleExceptionForm'].processInstID.value;
		if(checkProcessState(processInstID)){
		
		var length = document.forms['tackleExceptionForm'].elements['exceptionStrategy'].length;		
		for(i = 0; i < length; i++){
			if(document.forms['tackleExceptionForm'].elements['exceptionStrategy'][i].checked)
				return isAllowDone(actionName,document.forms['tackleExceptionForm'].elements['exceptionStrategy'][i].value);
		}		
		alert('<b:message key="activityinst_exception_jsp.select_exception_policy"/>');//请先选择异常处理策略	
		}		
		return false;
	}
	
	/*验证不同活动状态下,功能的可操作性*/
	function isAllowDone(actionName,exceptionStrategy){
		/*策略为'路由到其它活动'需要判断是否已经选定了要启动的活动定义*/
		if(actionName == 'btExecute' && exceptionStrategy == 'auto-freejump'){
			var activityDefID = document.forms['tackleExceptionForm'].elements['activityDefID'].value;
			if(activityDefID == null || activityDefID.length == 0){
				alert("<b:message key="activityinst_exception_jsp.click_browse_button"/>");//请点击 "浏览..." 按钮选择 活动定义
				document.forms['tackleExceptionForm'].elements['activityDefID'].focus();				
				return false;
			}
		}
		
		var activityInstID = document.forms['tackleExceptionForm'].activityInstID.value;
		var hs = new HideSubmit('com.primeton.workflow.manager.instance.ActivityInstanceManager.getActivityInstState.biz');
		hs.addParam('activityInstID',activityInstID);
		hs.submit();
		var currentState = hs.getProperty('currentState');
		/*必须活动处于异常状态才能进行异常补偿处理*/
		if(currentState != -1){
			alert('<b:message key="activityinst_exception_jsp.handle_condition"/>');//活动必须处于出错状态才能进行异常处理
			return false;
		}
		
		return true;
	}

	/*提交执行动作*/
	function doSubmit(actionName){
		if(validate(actionName)){
			if(actionName == 'btExecute'){
				tackleException();
			}else if(actionName == 'btBrowse'){
				chooseActivityDefine();
			}
		}
	}
	
	function tackleException(){
		var exceptionStrategy = null;//document.forms['tackleExceptionForm'].exceptionStrategy.value;
		for(i = 0 ;i<document.forms['tackleExceptionForm'].exceptionStrategy.length;i++){
			if(document.forms['tackleExceptionForm'].exceptionStrategy[i].checked)
			  exceptionStrategy = document.forms['tackleExceptionForm'].exceptionStrategy[i].value;
		}
		var activityInstID = document.forms['tackleExceptionForm'].activityInstID.value;
		/*执行回退动作，作为应用出错后的业务补偿动作*/
		if(exceptionStrategy == 'auto-backact'){
			doRollBack(activityInstID);			
		}else if(exceptionStrategy == 'auto-freejump'){
			doFreeJump();
		}else{
			doRestart(activityInstID);
		}
		
	}
	
	/*执行回退*/
	function doRollBack(activityInstID){
		var hs = new HideSubmit('com.primeton.workflow.manager.instance.ActivityInstanceManager.rollbackActivityInst.biz');
		hs.addParam('currentActInstID',activityInstID);
		hs.addParam('destActDefID','');
		hs.addParam('rollBackStrategy','one_step');
		hs.submit();
		if(ajaxIsSuccess==false){
			//alert('执行回退失败');
			return;
		}
		alert('<b:message key="activityinst_exception_jsp.roll_back_success"/>');//执行回退成功
		window.location.href=location;
		window.returnValue = 'refreshGraph';
	}
	
	/*重启活动*/
	function doRestart(activityInstID){
		var hs = new HideSubmit('com.primeton.workflow.manager.instance.ActivityInstanceManager.reStartActivityInst.biz');
		hs.addParam('activityInstID',activityInstID);
		hs.submit();
		if(ajaxIsSuccess==false){
			//alert('重启失败');
			return;
		}
		alert('<b:message key="activityinst_exception_jsp.restart_success"/>');//重启成功
		window.location.href=location;
		window.returnValue = 'refreshGraph';
	}
	
	/*启动用户所选当前流程中任意活动*/
	function doFreeJump(){
		var processInstID = document.forms['tackleExceptionForm'].processInstID.value;
		var activityDefID = document.forms['tackleExceptionForm'].activityDefID.value;
		var activityInstID = document.forms['tackleExceptionForm'].activityInstID.value;
		//TODO: 需要先终止当前活动，然后才创建选择的活动	
		var hs = new HideSubmit('com.primeton.workflow.manager.instance.ActivityInstanceManager.routeOtherActivityInst.biz');
		hs.addParam('processInstID',processInstID);
		hs.addParam('activityInstID',activityInstID);
		hs.addParam('activityDefID',activityDefID);		
		hs.submit();
		if(ajaxIsSuccess==false){
			//alert('操作失败');
			return;
		}
		var newActivityInstID = hs.getProperty('activityInst/activityInstID');
		alert('<b:message key="activityinst_exception_jsp.set_inst_success"/>'+newActivityInstID);//新活动实例创建成功,新实例ID为:
		window.location.href=location;
		window.returnValue = 'refreshGraph';
				
		
		<%--var hs = new HideSubmit('com.primeton.workflow.manager.instance.ActivityInstanceManager.createAndStartActivityInst.biz');
		hs.addParam('processInstID',processInstID);
		hs.addParam('activityDefID',activityDefID);
		hs.submit();
		var newActivityInstID = hs.getProperty('activityInst/activityInstID');
		alert('新活动实例创建成功,新实例ID为:'+newActivityInstID);
		--%>
	}
	
	function chooseActivityDefine(){
		var length = document.forms['tackleExceptionForm'].elements['exceptionStrategy'].length;
		for(i = 0; i < length; i++){
			if(document.forms['tackleExceptionForm'].elements['exceptionStrategy'][i].checked)
				if(document.forms['tackleExceptionForm'].elements['exceptionStrategy'][i].value != 'auto-freejump'){
					alert('<b:message key="activityinst_exception_jsp.select_route"/>');//请选择路由到其它活动
					return ;
				}
		}
		
		var processInstID = document.forms['tackleExceptionForm'].processInstID.value;
		var action = 'com.primeton.workflow.manager.instance.queryAllActivityDefine.flow?_eosFlowAction=queryAllActDef&processInstID='+processInstID;
		showModalCenter(action,null,function(returnValue){
			if(returnValue){
				document.forms['tackleExceptionForm'].activityDefID.value = returnValue;
			}
			
		},'500','300') ;
	}
	
	
	
</script>
</head>
<body  leftmargin="0" rightmargin="0" bottommargin="0" marginheight="0" marginwidth="0" topmargin="0"  style="background:#EAF0F1;repeat-x;margin-top:0px;margin-left:0px;margin-buttom:0px; margin-right: 0px;margin: auto;overflow:auto; overflow-y:hidden; overflow-x: auto;">
<form name="tackleExceptionForm" action="" method="post">
<h:hidden name="activityInstID" property="activityInstID"/>
<h:hidden name="processInstID" property="processInstID"/>
<table border="0" class="workarea" width="100%">
  <tr>
    <td class="EOS_panel_head"><b:message key="activityinst_exception_jsp.app_exception_handle"/></td><%-- 应用异常处理 --%>
  </tr>
  <tr>
    <td><b:message key="activityinst_exception_jsp.select_handle_strategy"/></td><%-- 请选择异常处理策略: --%>
  </tr>
  <tr>
    <td><h:radio name="exceptionStrategy" value="auto-restar" onclick="javascript:void(document.forms['tackleExceptionForm'].browse.disabled=true)"/><b:message key="activityinst_exception_jsp.restart_activity"/></td><%-- 重新启动活动 --%>
  </tr>
  <tr>
    <td><h:radio name="exceptionStrategy" value="auto-backact" onclick="javascript:void(document.forms['tackleExceptionForm'].browse.disabled=true)"/><b:message key="activityinst_exception_jsp.step_back"/></td><%-- 单步回退，并且终止当前活动 --%>
  </tr>
  <tr>
    <td><h:radio name="exceptionStrategy" value="auto-freejump" onclick="javascript:void(document.forms['tackleExceptionForm'].browse.disabled=false)"/><b:message key="activityinst_exception_jsp.route_acyivity"/><br><%-- 路由到其它活动，并且终止当前活动 --%>
	<b:message key="activityinst_exception_jsp.select_acyivity"/><h:text name="activityDefID" value="" readonly="true"/><input type="button" id="browseBtn" name="browse" value="<b:message key="activityinst_exception_jsp.browse"/>" class="button" onClick="doSubmit('btBrowse')" disabled=true><%-- 选择活动:/浏览... --%>
	</td>
  </tr>
  <tr>
  	<td>
  		<input type="button" id="btExecute" name="btExecute" value="<b:message key="activityinst_exception_jsp.execute"/>" class="button" onClick="doSubmit('btExecute')"/>  	</td><%-- 执行 --%>
  </tr>
</table>
</form>
</body>
</html>