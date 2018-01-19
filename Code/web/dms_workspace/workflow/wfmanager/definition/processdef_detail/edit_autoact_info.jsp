<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
<head>
<script type="text/javascript">
		window.onProcessBefore = function (field) {
		//FIXME: document.getElementById  --> $id
			if(field.id=='invokePattern-suspend' && $id('invokePattern-asynchronous').checked == true) {
				return false;
			}
			return true;
		}

		window.onProcessAfter = function (field) {
			if(field.id == 'invokePattern-asynchronous' &&
				field.value == 'asynchronous') {
				$id('invokePattern-suspend').checked = true;	
				$id('exceptionStrategy-ignore').checked = true;	
			}
			
		}

</script>
<script src="<%=request.getContextPath()%>/workflow/wfmanager/definition/js/new-activity-api.js" language="javascript"></script>
<script src="<%=request.getContextPath()%>/workflow/wfmanager/definition/js/i18n/message.js" i18n="true"/>
	<title></title>

</head>
<body style="background:#FFFFFF;margin-top:0px;margin-left:0px;margin-buttom:0px;overflow: auto;" onload="showDivInfo('proItem',$id('proItem').options[0].value);sizeDialog()">
<form name="processInfo">
   <table  id="tLayout" border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
   	<tr>
		<td colspan="3" class="workarea_title" valign="middle"><font color="#000033" class="title_font"><b:message key="edit_autoact_info_jsp.edit_auto_act_info"/></font></td><!-- 编辑自动活动详细信息 -->
	</tr>
	<tr>
	   <td width="100" valign="top" style="padding-top:8px;padding-left:5px;">
		  	<label><b:message key="edit_autoact_info_jsp.cfg_item"/></label><!-- 设置选项 -->
		  	<div>
		  		<select id="proItem"  onChange="showDivInfo('proItem',this.options[this.selectedIndex].value);sizeDialog()" name="proItem" size="16" style="width:100px">
					<option value="basedInfo"><b:message key="edit_autoact_info_jsp.basic_info"/></option><!-- 基本信息 -->
					<option value="config"><b:message key="edit_autoact_info_jsp.app_cfg"/></option><!-- 应用配置 -->
					<option value="rollback"><b:message key="edit_autoact_info_jsp.roll_back"/></option><!-- 回退 -->
					<option value="triggerEvents"><b:message key="edit_autoact_info_jsp.trigger_event"/></option><!-- 触发事件 -->
					<option value="startStrategate"><b:message key="edit_autoact_info_jsp.start_policy"/></option><!-- 启动策略 -->
				 </select>
		  	</div>  
	  </td>
		  <td width="10px" style="repeat-y 50%;"></td>
	  <td valign="top" style="padding-top:10px;"> 
			  	<div id="basedInfo" style=" display:inline; height:305px;">
					  <fieldset tyle="height:255px">
					  		<legend><b:message key="edit_autoact_info_jsp.basic_attr"/></legend><!-- 基本属性 -->
					  		<div>
					  				<label for="activityId"><b:message key="edit_autoact_info_jsp.act_id"/></label><!-- 活动ID: -->
					  				<div style="display:inline;padding-left:11px">
					  				<input type="text" size="50" id="activityId" class="textbox"  readonly name="activityId">
					  				</div>
					  		</div>
					  		<div>
					  				<label for="activityName"><b:message key="edit_autoact_info_jsp.act_name"/></label><!-- 活动名称: -->
					  				<input type="text" size="50"  class="textbox" id="activityName" name="activityName" onMouseMove="textCounter(this,200);" onkeydown="textCounter(this,200);" onkeyup="textCounter(this,200);">
					  		</div>
					  		<div>
					  				<label for="splitType"><b:message key="edit_autoact_info_jsp.branch_mode"/></label><!-- 分支模式: -->
					  				<select id="splitType" name="splitType">
					  					<option value="AND"><b:message key="edit_autoact_info_jsp.all_branch"/></option><!-- 全部分支 -->
					  					<option value="XOR"><b:message key="edit_autoact_info_jsp.single_branch"/></option><!-- 单一分支 -->
					  					<option value="OR"><b:message key="edit_autoact_info_jsp.multi_branch"/></option><!-- 多路分支 -->
					  				</select>
					  				<div style="display:inline;padding-left:88px">
						  				<label for="joinType"><b:message key="edit_autoact_info_jsp.aggr_mode"/></label><!-- 聚合模式: -->
						  				<select  id="joinType" name="joinType">
						  					<option value="AND"><b:message key="edit_autoact_info_jsp.all_aggr"/></option><!-- 全部聚合 -->
						  					<option value="XOR"><b:message key="edit_autoact_info_jsp.single_aggr"/></option><!-- 单一聚合 -->
						  					<option value="OR"><b:message key="edit_autoact_info_jsp.multi_aggr"/></option><!-- 多路聚合 -->
						  				</select>
					  				</div>
					  		</div>
					  		<div>
					  				<%--<label for="priority"><b:message key="edit_autoact_info_jsp.priority"/></label><!-- 优先级: -->
					 		 			<div style="display:inline;padding-left:12px">
						 		 		<select id="priority" name="priority">
						 		 			<option value="30"><b:message key="edit_autoact_info_jsp.level_very_low"/></option><!-- 极低 -->
						 		 			<option value="40"><b:message key="edit_autoact_info_jsp.level_low"/></option><!-- 低 -->
						 		 			<option value="50"><b:message key="edit_autoact_info_jsp.level_inferior_medium"/></option><!-- 次中 -->
						 		 			<option value="60"><b:message key="edit_autoact_info_jsp.level_medium"/></option><!-- 中 -->
						 		 			<option value="70"><b:message key="edit_autoact_info_jsp.level_inferior_high"/></option><!-- 次高 -->
						 		 			<option value="80"><b:message key="edit_autoact_info_jsp.level_high"/></option><!-- 高 -->
						 		 		</select>--%>
						 		 	<div style="display:inline;">
					  					<label for="implementation.autoActivity.terminateType"><b:message key="edit_autoact_info_jsp.way_of_end"/></label><!-- 结束方式: -->
							 		 		<select id="implementation.autoActivity.terminateType" name="implementation.autoActivity.terminateType">
							 		 			<option value="auto"><b:message key="edit_autoact_info_jsp.auto"/></option><!-- 自动 -->
							 		 			<option value="manual"><b:message key="edit_autoact_info_jsp.manual"/></option><!-- 人工 -->
							 		 		</select>
					  				</div>
					  		</div>
					  		<div>
				  				<label for="splitTransaction"><:messgae key="edit_autoact_info_jsp.split_trans"/></label><!-- 分割事务 -->
				  				<div style="display:inline;padding-left:5px">
			  					<input type="checkbox" id="splitTransaction" name="splitTransaction" value="true">
			  				</div>
					  		<div>
					  				<label for="description"><b:message key="defcommon.desc"/></label><!-- 描述 -->
					  				<div style="display:inline;padding-left:35px">
					  					<textarea id="description" name="description" rows="6" cols="48"  onMouseMove="textCounter(this,200);" onkeydown="textCounter(this,200);" onkeyup="textCounter(this,200);"></textarea>
					  				</div>
					  		</div>
					  </fieldset>
				  </div>
				  <div id="config" style="display:none;height:305px">
							<div>
								<label for="implementation.autoActivity.taskApplication.applicationInfo.application.applicationUri"><b:message key="edit_autoact_info_jsp.app_cfg"/></label><!-- 应用设置 -->
								<input type="text" id="implementation.autoActivity.taskApplication.applicationInfo.application.applicationUri" 
								name="implementation.autoActivity.taskApplication.applicationInfo.application.applicationUri" readonly  size="30">
								<input type="button" id="btnConfiguration" name="btnConfiguration" value='<b:message key="edit_autoact_info_jsp.browse"/>' class="button"><!-- 浏览... -->
							</div>
							<fieldset tyle="height:255px">
								<legend><b:message key="edit_autoact_info_jsp.call_mode"/></legend><!-- 调用方式 -->
								<div>
									<input type="radio" id="invokePattern-synchronous" _manipulateFields="_exceptionStrategyDiv,_rollbackExceptionDiv,_invkPatnJoinDiv" _model="dis" _ignores="_ignoreExceptionDiv,_freeJumpDiv,_exceptionAppConfgDiv"  name="implementation.autoActivity.taskApplication.applicationInfo.application.invokePattern" value="synchronous">
									<label for="invokePattern-synchronous"><b:message key="edit_autoact_info_jsp.synchronous"/></label><!-- 同步 -->
									<div id="_invkPtnAsynchDiv" style="display:inline;">
										<input type="radio" id="invokePattern-asynchronous"  _manipulateFields="_exceptionStrategyDiv,_rollbackExceptionDiv,_invkPatnJoinDiv" _model="!dis" _ignores="_ignoreExceptionDiv,_freeJumpDiv,_exceptionAppConfgDiv"
										name="implementation.autoActivity.taskApplication.applicationInfo.application.invokePattern" value="asynchronous" >
										<label for="invokePattern-asynchronous"><b:message key="edit_autoact_info_jsp.asynchronous"/></label><!-- 异步 -->
									</div>
								</div>
							</fieldset>
							<fieldset tyle="height:255px">
								<legend><b:message key="edit_autoact_info_jsp.trans_policy"/></legend><!-- 事务策略 -->
								<div>
									<div id="_invkPatnJoinDiv" style="display:inline;">
										<input type="radio" id="invokePattern-join" name="implementation.autoActivity.taskApplication.applicationInfo.application.transactionType" 
									_manipulateFields="_exceptionStrategyDiv" _model="!dis" _ignores="_invkPtnAsynchDiv,_freeJumpDiv,_exceptionAppConfgDiv,_ignoreExceptionDiv" value="join"><label for="invokePattern-join">Join</label>
									</div>
									<div id="_invkPatnSuspendDiv" style="display:inline;">
									   <input type="radio" id="invokePattern-suspend" name="implementation.autoActivity.taskApplication.applicationInfo.application.transactionType" 
									_manipulateFields="_exceptionStrategyDiv" _model="dis"  _ignores="_invkPtnAsynchDiv,_freeJumpDiv,_exceptionAppConfgDiv,_ignoreExceptionDiv" value="suspend"><label for="invokePattern-suspend">Suspend</label>
									</div>	
								</div>
							</fieldset>			
							<fieldset tyle="height:255px">
									<legend><b:message key="edit_autoact_info_jsp.exce_process"/></legend><!-- 异常处理 -->
									<div id="_rollbackExceptionDiv">
										<input type="radio" id="exceptionStrategy-rollback" name="implementation.autoActivity.taskApplication.applicationInfo.application.exceptionStrategy"
										value="rollback">
										<label for="exceptionStrategy-rollback"><b:message key="edit_autoact_info_jsp.rb_exce"/></label><!-- 回滚异常 -->
									</div>
									<div id="_ignoreExceptionDiv">
										<input type="radio" id="exceptionStrategy-ignore" _model="dis" name="implementation.autoActivity.taskApplication.applicationInfo.application.exceptionStrategy"
										value="ignore">
										<label for="exceptionStrategy-ignore"><b:message key="edit_autoact_info_jsp.ignore_exce"/></label><!-- 忽略异常 -->
									</div>
									<div id="_exceptionStrategyDiv">
										<div>
											<input type="radio" id="exceptionStrategy-interrupt" name="implementation.autoActivity.taskApplication.applicationInfo.application.exceptionStrategy"
											value="interrupt">
											<label for="exceptionStrategy-interrupt"><b:message key="edit_autoact_info_jsp.into_exce"/></label><!-- 进入异常状态，等待人工干预 -->
										</div>
										<div>
											<input type="radio" id="exceptionStrategy-backact" name="implementation.autoActivity.taskApplication.applicationInfo.application.exceptionStrategy"
											value="auto-backact">
											<label for="exceptionStrategy-backact"><b:message key="edit_autoact_info_jsp.back_stop"/></label><!-- 自动执行单步回退，活动终止 -->
										</div>
										<div>
											<input type="radio" id="exceptionStrategy-freejump" name="implementation.autoActivity.taskApplication.applicationInfo.application.exceptionStrategy"
											_manipulateFields="_freeJumpDiv"
											value="auto-freejump">
											<label for="exceptionStrategy-freejump"><b:message key="edit_autoact_info_jsp.route_stop"/></label><!-- 自动路由到其它活动，活动终止 -->
											<div id="_freeJumpDiv" style="padding-left:35px">
												<label for="implementation.autoActivity.taskApplication.destActivityInException"><b:message key="edit_autoact_info_jsp.jumpActivity"/></label><!-- 跳转活动 -->
												<input type="text" id="implementation.autoActivity.taskApplication.destActivityInException" name="implementation.autoActivity.taskApplication.destActivityInException" size="45">
												<!-- <input type="button" value="浏览..." onclick=""> -->
											</div>
										</div>
										<div>
											<input type="radio" id="exceptionStrategy-application" 
											    name="implementation.autoActivity.taskApplication.applicationInfo.application.exceptionStrategy"
											    _manipulateFields="_exceptionAppConfgDiv"
												value="auto-application">
											<label for="exceptionStrategy-application">自动执行规则逻辑</label><!-- 自动执行规则逻辑 -->
											<div id="_exceptionAppConfgDiv" style="padding-left:35px">
												<label for="implementation.autoActivity.taskApplication.exceptionApp.application.applicationUri"><b:message key="edit_autoact_info_jsp.jumpApplication"/></label><!-- 跳转应用 -->
												<input type="text" id="implementation.autoActivity.taskApplication.exceptionApp.application.applicationUri" name="implementation.autoActivity.taskApplication.exceptionApp.application.applicationUri" readonly size="45">
												<label for="btnExceptionAppConfg"/><input type="button" id="btnExceptionAppConfg" name="btnExceptionAppConfg"  value="<b:message key="edit_autoact_info_jsp.browse"/>" size="45" class="button"><!-- 浏览... -->
											</div>
										</div>
									  </div>
						   </fieldset>
			  	</div>
			  	<div id="rollback" style="display:none;height:305px">
			  		<fieldset style="height:255px">
						<legend><b:message key="edit_autoact_info_jsp.confInfo"/></legend><!-- 配置信息 -->
						<div>
							<label for="implementation.autoActivity.rollBack.applicationInfo.application.actionType"><b:message key="edit_autoact_info_jsp.eventType"/></label><!-- 事件类型 -->
							<select id="implementation.autoActivity.rollBack.applicationInfo.application.actionType" name="implementation.autoActivity.rollBack.applicationInfo.application.actionType">
									<option value="service-component"><b:message key="edit_autoact_info_jsp.service"/></option><!-- 服务 -->
									<option value="logic-flow"><b:message key="edit_autoact_info_jsp.logicFlow"/></option><!-- 逻辑流 -->
									<option value="pojo"><b:message key="edit_autoact_info_jsp.arithmeticLogic"/></option><!-- 运算逻辑 -->
							</select>
						</div>
						<div>
								<label for="implementation.autoActivity.rollBack.applicationInfo.application.applicationUri"><b:message key="edit_autoact_info_jsp.eventAction"/></label><!-- 事件动作 -->
								<input type="text" id="implementation.autoActivity.rollBack.applicationInfo.application.applicationUri"
								 name="implementation.autoActivity.rollBack.applicationInfo.application.applicationUri" size="35">
						</div>
						<div>
								<label><b:message key="edit_autoact_info_jsp.paramConftable"/></label><!-- 参数配置表 -->
								<r:datacell xpath="json" id="dataCellRollBackParams" width="440" height="180" allowAdd="true" allowDel="true" pageSize="1000">
									<r:field fieldId="rpmode" onRefreshFunc="setSelectBoxValue" fieldName="mode" label="<b:message key="edit_autoact_info_jsp.type"/>"></r:field><!-- 类型 -->
									<r:field fieldId="rpname" fieldName="name" label="<b:message key="edit_autoact_info_jsp.name"/>"><h:text/></r:field><!-- 名称 -->
									<r:field fieldId="rptypeValue" fieldName="dataType/typeValue" label="<b:message key="edit_autoact_info_jsp.dataType"/>" ><h:text/></r:field><!-- 数据类型 -->
									<r:field fieldId="rptypeClass" onRefreshFunc="setSelectBoxValue2" fieldName="dataType/typeClass" label="<b:message key="edit_autoact_info_jsp.dataClassification"/>" ></r:field><!-- 数据分类 -->
									<r:field fieldId="rpvalue" fieldName="value" label="<b:message key="edit_autoact_info_jsp.value"/>"><h:text/></r:field><!-- 值 -->
									<r:field fieldId="rpvalueType" onRefreshFunc="setValueType" fieldName="valueType" label="<b:message key="edit_autoact_info_jsp.valueType"/>"></r:field><!-- 值类型 -->
									<r:field fieldId="rpfillBack" onRefreshFunc="setCheckboxValue" fieldName="fillBack" label="<b:message key="edit_autoact_info_jsp.backfillRelatedData"/>"></r:field><!-- 回填相关数据 -->
								    <r:toolbar tools="edit:add del" location="top"/>
								</r:datacell>
						</div>
					</fieldset>
			  	</div>
			  	<div id="triggerEvents" style="display:none;height:305px">
						<r:datacell xpath="json" id="dataCellTrgEvnts" width="450" height="253" allowAdd="true" allowDel="true" pageSize="1000">
							<r:field fieldId="eventType" fieldName="eventType" onRefreshFunc="setEventTypeValue" label="<b:message key="edit_autoact_info_jsp.triggerTime"/>"></r:field><!-- 触发时机 -->
							<r:field fieldId="applicationUr" fieldName="applicationInfo/application/applicationUri" onRefreshFunc="setApplicationUriLink" label="<b:message key="edit_autoact_info_jsp.eventAction"/>" ></r:field><!-- 事件动作 -->
							<r:field fieldId="invokePattern" fieldName="applicationInfo/application/invokePattern" onRefreshFunc="setInvokePatternValue" label="<b:message key="edit_autoact_info_jsp.eventAction"/>"></r:field><!-- 事件动作 -->
							<r:field fieldId="transactionType" fieldName="applicationInfo/application/transactionType" onRefreshFunc="setTransactionTypeValue" label="<b:message key="edit_autoact_info_jsp.eventAction"/>"></r:field><!-- 事件动作 -->
							<r:field fieldId="exceptionStrategy" fieldName="applicationInfo/application/exceptionStrategy" onRefreshFunc="setExceptionStrategyValue" label="<b:message key="edit_autoact_info_jsp.eventAction"/>"></r:field><!-- 事件动作 -->
							<r:field fieldId="tgdescription" fieldName="description" label="<b:message key="edit_autoact_info_jsp.desc"/>"><h:text/></r:field><!-- 描述 -->
						    <r:toolbar tools="edit:add del,custom" location="top"/>
						</r:datacell>
			  	</div>
			  	<div id="startStrategate" style="display:none;height:305px">
			  			<fieldset style="height:255px">
			  					<legend><b:message key="edit_autoact_info_jsp.activationRules"/></legend><!-- 激活规则 -->
			  					<div>
			  							<label for="activateRule.activateRuleType"><b:message key="edit_autoact_info_jsp.activationRules"/></label><!-- 激活规则 -->
			  							<div>
			  									<input type="radio" id="activateRule.activateRuleType1" name="activateRule.activateRuleType" value="directRunning"
			  									_manipulateFields="activateRuleDiv"  _model="!dis"><label for="activateRule.activateRuleType1"><b:message key="edit_autoact_info_jsp.beActivated"/></label><!-- 待激活 -->
			  									<input type="radio" id="activateRule.activateRuleType2" name="activateRule.activateRuleType" value="waitingActivition"
			  									_manipulateFields="activateRuleDiv"  _model="!dis"><label for="activateRule.activateRuleType2"><b:message key="edit_autoact_info_jsp.beActivated"/></label><!-- 待激活 -->
			  									<input type="radio" id="activateRule.activateRuleType3" name="activateRule.activateRuleType" value="startStrategybyApp"
			  									_manipulateFields="activateRuleDiv"><label for="activateRule.activateRuleType3"><b:message key="edit_autoact_info_jsp.activateRuleType3"/></label><!-- 由规则逻辑返回值确定 -->
			  							</div>
			  					</div>
			  					<div id="activateRuleDiv">
			  							<label for="activateRule.applicationInfo.application.applicationUri"><b:message key=""/></label><!-- 规则逻辑 -->
			  							<input type="text" id="activateRule.applicationInfo.application.applicationUri" name="activateRule.applicationInfo.application.applicationUri" readonly size="30">
			  							<label for="btnActivateRuleConfig"></label><input class="button" type="button" id="btnActivateRuleConfig" name="btnActivateRuleConfig" size="45" value="<b:message key="edit_autoact_info_jsp.browse"/>"><!-- 浏览... -->
			  							<div style="display:block">
			  								<label><b:message key="edit_autoact_info_jsp.note"/></label><!-- 注:激活规则确定该活动在流程转至此时将以何种方式激活，规则逻辑返回值为1或true时均可直接激活，返回值为0或false时为待激活 -->
			  							</div>
			  					</div>
			  			</fieldset>
			  	</div>
			  	<div style="display:'';padding-top:20px;padding-bottom:5px">
			            <button class="button" id="activityOK" name="activityOK"><b:message key="edit_autoact_info_jsp.ok"/></button><!-- 确定 -->
			            <button class="button" id="activityCancel" name="activityCancel"><b:message key="edit_autoact_info_jsp.cancel"/></button><!-- 取消 -->
				</div>
	  </td>
	</tr>
</table> 
</form>
 		<jsp:include flush="true" page="/workflow/wfmanager/definition/processdef_detail/edit_common.jsp"></jsp:include>
		<script>
 				autoActivity.renderAutoActivity(actJson.activity);
		</script>
</body>
</html>
