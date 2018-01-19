<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
<head>
<script src="<%=request.getContextPath()%>/workflow/wfmanager/definition/js/new-activity-api.js" language="javascript"></script>
<script src="<%=request.getContextPath()%>/workflow/wfmanager/definition/js/i18n/message.js" i18n="true"/>
<script src="<%=request.getContextPath()%>/workflow/wfmanager/definition/js/json.js" language="javascript"></script>
<title></title>
<script>
	function init () {
	  var triggerEvent = window["dialogArguments"] ;
	  triggerEvents.renderTriggerEvent(triggerEvent);
	}
</script>
</head>
<body style="background:#FFFFFF;margin-top:0px;margin-left:0px;margin-buttom:0px;overflow: auto;" onload="init();sizeDialog()">
<form>
	 <table id="tLayout"  width="100%" border="0" cellpadding="0" cellspacing="0" class="workarea">
		<tr>
			<td class="workarea_title" valign="middle"> 
				<font color="#000033" class="title_font"><b:message key="edit_trigger_event_jsp.editTriggerEventDetails"/></font><!-- 编辑触发事件详细信息 -->
			</td>
		</tr>
		<tr>
			<td>
		        <div>
		        	<fieldset>
		        		<legend><b:message key="edit_manualact_info_jsp.cfgInfo"/></legend><!-- 配置信息 -->
		        		<div>
		        			<label for="eventType"><b:message key="edit_autoact_info_jsp.triggerTime"/></label><!-- 触发时机 -->
		        			<select id="eventType" name="eventType">
		        				<option value="before-start-act"><b:message key="edit_manualact_info_jsp.beforeStartActivity"/></option><!-- 活动启动前 -->
		        				<option value="after-start-act"><b:message key="edit_manualact_info_jsp.activityStart"/></option><!-- 活动启动后 -->
		        				<option value="before-finish-act"><b:message key="edit_manualact_info_jsp.beforeFinishActivity"/></option><!-- 活动完成前 -->
		        				<option value="after-finish-act"><b:message key="edit_manualact_info_jsp.afterFinishAct"/></option><!-- 活动完成后 -->
		        				<option value="after-resume-act"><b:message key="edit_manualact_info_jsp.actAfterRecovery"/></option><!-- 活动恢复后 -->
		        				<option value="after-suspend-act"><b:message key="edit_manualact_info_jsp.afterActSuspend"/></option><!-- 活动挂起后 -->
		        			</select>
			        		<div style="display:inline">
			        			<label for="applicationInfo.actionType"><b:message key="edit_manualact_info_jsp.eventType"/></label><!-- 事件类型 -->
			        			<select id="applicationInfo.actionType" name="applicationInfo.actionType">
			        				<option value="service-component"><b:message key="edit_autoact_info_jsp.service"/></option><!-- 服务 -->
			        				<option value="logic-flow"><b:message key="edit_autoact_info_jsp.logicFlow"/></option><!-- 逻辑流 -->
			        				<option value="pojo"><b:message key="edit_autoact_info_jsp.arithmeticLogic"/></option><!-- 运算逻辑 -->
			        			</select>
			        		</div>
		        		</div>
		        		<div>
		        			<label for="applicationInfo.application.applicationUri"><b:message key="edit_autoact_info_jsp.eventAction"/></label><!-- 事件动作 -->
		        			<input type="text" id="applicationInfo.application.applicationUri" name="applicationInfo.application.applicationUri" size="30">
		        		</div>
		        		<div>
		        			<label for="applicationInfo.application.invokePattern"><b:message key="edit_autoact_info_jsp.call_mode"/></label><!-- 调用方式 -->
		        			 <select id="applicationInfo.application.invokePattern" name="applicationInfo.application.invokePattern">
		        				<option value="synchronous"><b:message key="edit_autoact_info_jsp.synchronous"/></option><!-- 同步 -->
		        				<option value="asynchronous"><b:message key="edit_autoact_info_jsp.asynchronous"/></option><!-- 异步 -->
		        			</select>
		        			<div style="display:inline;padding-left:35px">
		        				<label for="applicationInfo.application.transactionType"><b:message key="edit_autoact_info_jsp.trans_policy"/></label><!-- 事务策略 -->
			        			 <select id="applicationInfo.application.transactionType" name="applicationInfo.application.transactionType">
			        				<option value="join">Join</option>
			        				<option value="suspend">Suspend</option>
			        			</select>
		        			</div>
		        		</div>
		        		<div>
		        			<label for="applicationInfo.application.exceptionStrategy"><b:message key="edit_autoact_info_jsp.exce_process"/></label><!-- 异常处理 -->
		        			<select id="applicationInfo.application.exceptionStrategy" name="applicationInfo.application.exceptionStrategy">
		        				<option value="rollback"><b:message key="edit_autoact_info_jsp.roll_back"/></option><!-- 回滚 -->
		        				<option value="ignore"><b:message key="edit_trigger_event_jsp.ignore"/></option><!-- 忽略 -->
		        				<option value="interrupt"><b:message key="edit_trigger_event_jsp.interrupt"/></option><!-- 中断 -->
		        			</select>
		        		</div>
		        		<div>
		        			<label for="description"><b:message key="edit_autoact_info_jsp.desc"/></label><!-- 描述 -->
		        			<div style="display:inline; padding-left:23px"><textarea id="description" name="description" cols="45" rows="5" onMouseMove="textCounter(this,200);" onkeydown="textCounter(this,200);" onkeyup="textCounter(this,200);"></textarea></div>
		        		</div>
		        	</fieldset>
		        </div>
		        <div>
		        	<fieldset>
		        		<legend><b:message key="edit_trigger_event_jsp.parameAndReturnValue"/></legend><!-- 参数和返回值 -->
		        		<b:message key="edit_autoact_info_jsp.paramConftable"/><!-- 参数配置表 -->
	        			<r:datacell xpath="json" id="triggerParamsDcell" width="500" height="180" allowAdd="true" allowDel="true" pageSize="1000">
							<r:field fieldId="name" fieldName="name" label="<b:message key="edit_autoact_info_jsp.name"/>"><h:text/></r:field><!-- 名称 -->
							<r:field fieldId="dataType" fieldName="dataType/typeValue" label="<b:message key="edit_autoact_info_jsp.dataType"/>" ><h:text/></r:field><!-- 数据类型 -->
							<r:field fieldId="value" fieldName="value" label="<b:message key="edit_autoact_info_jsp.value"/>"><h:text/></r:field><!-- 值 -->
							<r:field fieldId="valueType" fieldName="valueType" label="<b:message key="edit_autoact_info_jsp.valueType"/>"><h:text/></r:field><!-- 值类型 -->
							<r:field fieldId="mode" fieldName="mode" label="<b:message key="edit_parameter_jsp.passMode"/>"><h:text/></r:field><!-- 传递方式 -->
						    <r:toolbar tools="edit:add del" location="top"/>
						</r:datacell>
		        	</fieldset>
		        </div>
		        <div style="padding-top:10px">
					<input type="button" name="activityOK" id="activityOK" value="<b:message key="edit_finishact_info_jsp.ok"/>"><!-- 确定 -->
					<button class="button" id="activityCancel"><b:message key="edit_finishact_info_jsp.cancel"/></button><!-- 取消 -->
		        </div>
		</td></tr>
	</table>
</form>
	<script>
	 
	</script>
</body>
</html>