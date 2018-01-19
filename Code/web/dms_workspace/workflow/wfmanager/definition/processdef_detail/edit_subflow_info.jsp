<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
<head>
<script src="<%=request.getContextPath()%>/workflow/wfmanager/definition/js/new-activity-api.js" language="javascript"></script>
<script src="<%=request.getContextPath()%>/workflow/wfmanager/definition/js/i18n/message.js" i18n="true"/>
	<title></title>
</head>
<body style="background:#FFFFFF;margin-top:0px;margin-left:0px;margin-buttom:0px;overflow: auto;" onload="sizeDialog()">
<form name="processInfo">
   <table   id="tLayout" border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
   	<tr>
		<td colspan="3" class="workarea_title" valign="middle"><font color="#000033" class="title_font">编辑子流程详细信息</font></td>
	</tr>
	<tr>
	  <td width="100" valign="top" style="padding-top:8px;padding-left:5px;">
			 <div>
	  	 	<label><b:message key="edit_finishact_info_jsp.setOption"/></label><!-- 设置选项 -->
	  	 </div>
	  	 <div>
			 <select onChange="showDivInfo('proItem',this.options[this.selectedIndex].value);sizeDialog()" name="proItem" multiple="multiple" size="16" style="width:100px;">
				<option value="basedInfo"><b:message key="edit_finishact_info_jsp.basicInfo"/></option><!-- 基本信息 -->
				<option value="preferences"><b:message key="edit_subflow_info_jsp.subProcessParam"/></option><!-- 子流程参数 -->
				<option value="triggerEvent"><b:message key="edit_autoact_info_jsp.trigger_event"/></option><!-- 触发事件 -->
				<option value="subflows"><b:message key="edit_subflow_info_jsp.multiSubProcessPolicy"/></option><!-- 多子流程策略 -->
				<option value="rollback"><b:message key="edit_autoact_info_jsp.roll_back"/></option><!-- 回退 -->
				<option value="startStrategy"><b:message key="edit_autoact_info_jsp.start_policy"/></option><!-- 启动策略 -->
			 </select>
			</div>
	  </td>
	  <td width="10px" style="repeat-y 50%;"></td>
		<td valign="top" style="padding-top:10px;"> 
		  	<div id="basedInfo" style=" display:inline; margin-top:5px;height:265px">
		  	   <fieldset>
		  	   		<legend><b:message key="edit_autoact_info_jsp.basic_attr"/></legend><!-- 基本属性 -->
		  	   		<div>
		  	   			<label for="activityId"><b:message key="edit_finishact_info_jsp.activityID"/></label><!-- 活动ID -->
		  	   			<div style="display:inline;padding-left:14px">
		  	   				<input type="text" id="activityId" name="activityId" readonly size="45">
		  	   			</div>
		  	   		</div>
		  	   		<div>
		  	   			<label for="activityName"><b:message key="edit_finishact_info_jsp.activityName"/></label><!-- 活动名称 -->
		  	   			<input type="text" id="activityName" name="activityName" size="45">
		  	   		</div>
		  	   		<div>
		  	   			<label for="splitType"><b:message key="edit_process_info_jsp.branch_mode"/></label><!-- 分支模式 -->
		  	   			<select id="splitType" name="splitType">
		  	   				<option value="AND"><b:message key="edit_autoact_info_jsp.all_branch"/></option><!-- 全部分支 -->
		  	   				<option value="XOR"><b:message key="edit_autoact_info_jsp.single_branch"/></option><!-- 单一分支 -->
		  	   				<option value="OR"><b:message key="edit_autoact_info_jsp.multi_branch"/></option><!-- 多路分支 -->
		  	   			</select>
		  	   			<div style="display:inline;padding-left:50px">
		  	   					<label for="joinType"><b:message key="edit_subflow_info_jsp.aggr_mode"/></label><!-- 聚合模式 -->
		  	   					<select id="joinType" name="joinType">
				  	   				<option value="AND"><b:message key="edit_autoact_info_jsp.all_aggr"/></option><!--全部聚合 -->
				  	   				<option value="XOR"><b:message key="edit_autoact_info_jsp.single_aggr"/></option><!-- 单一聚合 -->
				  	   				<option value="OR"><b:message key="edit_autoact_info_jsp.multi_aggr"/></option><!-- 多路聚合 -->
				  	   			</select>
		  	   			</div>
		  	   		</div>
		  	   		<div>
		  	   					<%--<label for="priority">优先级</label>
		  	   					<div style="display:inline;padding-left:12px">
	  	   							<select id="priority" name="priority">
					 		 			<option value="30">极低</option>
					 		 			<option value="40">低</option>
					 		 			<option value="50">次中</option>
					 		 			<option value="60">中</option>
					 		 			<option value="70">次高</option>
					 		 			<option value="80">高</option>
					 		 		</select>
					 		 	</div>--%>
				 		 		<div style="display:inline;">
				 		 				<label for="splitTransaction"><b:message key=""/></label><!--  -->
				 		 				<input type="checkbox" id="splitTransaction" name="splitTransaction" value="true">
				 		 		</div>
		  	   		</div>
		  	   		<div>
		  	   				<label for="description"><b:message key="edit_autoact_info_jsp.desc"/></label><!-- 描述 -->
		  	   				<div style="display:inline;padding-left:24px">
		  	   					<textarea id="description" name="description" rows="6" cols="48" onMouseMove="textCounter(this,200);" onkeydown="textCounter(this,200);" onkeyup="textCounter(this,200);"></textarea>
		  	   				</div>
		  	   		</div>
		  	  </fieldset>
			  </div>
			  <div id="rollback" style="display:none;height:270px">
			  		<fieldset>
			  				<legend><b:message key="edit_autoact_info_jsp.confInfo"/></legend><!-- 配置信息 -->
			  				<div>
			  						<label for="implementation.subActivity.rollBack.applicationInfo.application.actionType"><b:message key="edit_autoact_info_jsp.eventType"/></label><!-- 事件类型 -->
			  						<select id="implementation.subActivity.rollBack.applicationInfo.application.actionType" name="implementation.subActivity.rollBack.applicationInfo.application.actionType">
			  								<option value="service-component"><b:message key="edit_autoact_info_jsp.service"/></option><!-- 服务 -->
			  								<option value="logic-flow"><b:message key="edit_autoact_info_jsp.logicFlow"/></option><!-- 逻辑流 -->
			  								<option value="pojo"><b:message key="edit_autoact_info_jsp.arithmeticLogic"/></option><!-- 运算逻辑 -->
			  						</select>
			  				</div>
			  				<div>
			  						<label for="implementation.subActivity.rollBack.applicationInfo.application.applicationUri"><b:message key="edit_autoact_info_jsp.eventAction"/></label><!-- 事件动作 -->
			  						<input type="text" id="implementation.subActivity.rollBack.applicationInfo.application.applicationUri" name="implementation.subActivity.rollBack.applicationInfo.application.applicationUri" size="35">
			  				</div>
			  		</fieldset>
			  		<div>
			  				<label><b:message key="edit_autoact_info_jsp.paramConftable"/></label><!-- 参数配置表 -->
							<r:datacell xpath="json" id="dataCellRollBackParams" width="480" height="180" allowAdd="true" allowDel="true" pageSize="1000">
								<r:field fieldId="rpmode" onRefreshFunc="setSelectBoxValue" fieldName="mode" label="<b:message key="edit_autoact_info_jsp.type"/>"></r:field><!-- 类型 -->
								<r:field fieldId="rpname" fieldName="name" label="<b:message key="edit_autoact_info_jsp.name"/>"><h:text/></r:field><!-- 名称 -->
								<r:field fieldId="rptypeValue" fieldName="dataType/typeValue" label="<b:message key="edit_autoact_info_jsp.dataType"/>" ><h:text/></r:field><!-- 数据类型 -->
								<r:field fieldId="rptypeClass" onRefreshFunc="setSelectBoxValue2" fieldName="dataType/typeClass" label="<b:message key="edit_autoact_info_jsp.dataClassification"/>" ><h:text/></r:field><!-- 数据分类 -->
								<r:field fieldId="rpvalue" fieldName="value" label="<b:message key="edit_autoact_info_jsp.value"/>"><h:text/></r:field><!-- 值 -->
								<r:field fieldId="rpvalueType" fieldName="valueType" label="<b:message key="edit_autoact_info_jsp.valueType"/>"><h:text/></r:field><!-- 值类型 -->
								<r:field fieldId="rpfillBack" onRefreshFunc="setCheckboxValue" fieldName="fillBack" label="<b:message key="edit_autoact_info_jsp.backfillRelatedData"/>"></r:field><!-- 回填相关数据 -->
							    <r:toolbar tools="edit:add del" location="top"/>
							</r:datacell>
			  		</div>
			  </div>
			  <div id="triggerEvent" style="display:none;height:270px">
					<r:datacell xpath="json" id="dataCellTrigger" width="480" height="240" allowAdd="true" allowDel="true" pageSize="1000">
						<r:field fieldId="eventType" fieldName="eventType" onRefreshFunc="setEventTypeValue" label="<b:message key="edit_autoact_info_jsp.triggerTime"/>"></r:field><!-- 触发时机 -->
						<r:field fieldId="applicationUri" fieldName="applicationInfo/application/applicationUri" onRefreshFunc="setApplicationUriLink" label="<b:message key="edit_autoact_info_jsp.eventAction"/>" ></r:field><!-- 事件动作 -->
						<r:field fieldId="invokePattern" fieldName="applicationInfo/application/invokePattern" onRefreshFunc="setInvokePatternValue" label="<b:message key="edit_autoact_info_jsp.call_mode"/>"></r:field><!-- 调用方式 -->
						<r:field fieldId="transactionType" fieldName="applicationInfo/application/transactionType" onRefreshFunc="setTransactionTypeValue" label="<b:message key="edit_autoact_info_jsp.trans_policy"/>"></r:field><!-- 事务策略 -->
						<r:field fieldId="exceptionStrategy" fieldName="applicationInfo/application/exceptionStrategy" onRefreshFunc="setExceptionStrategyValue" label="<b:message key="edit_autoact_info_jsp.exce_process"/>"></r:field><!-- 异常处理 -->
						<r:field fieldId="description" fieldName="description" label="<b:message key="edit_autoact_info_jsp.desc"/>"><h:text/></r:field><!-- 描述 -->
					    <r:toolbar tools="edit:add del,custom" location="top"/>
					</r:datacell>
			  </div>
			  <div id="startStrategy" style="display:none;height:270px">
			  		<fieldset>
		  					<legend><b:message key="edit_autoact_info_jsp.start_policy"/></legend><!-- 启动策略 -->
		  					<div>
		  							<label for="activateRule.activateRuleType"><b:message key="edit_finishact_info_jsp.optionalRule"/></label><!-- 可选规则 -->
		  							<div>
		  									<input type="radio" id="activateRule.activateRuleType1" name="activateRule.activateRuleType" value="directRunning"
		  									_manipulateFields="activateRuleDiv"  _model="!dis"><label for="activateRule.activateRuleType1"><b:message key="edit_finishact_info_jsp.directOperation"/></label><!-- 直接运行 -->
		  									<input type="radio" id="activateRule.activateRuleType2" name="activateRule.activateRuleType" value="waitingActivition"
		  									_manipulateFields="activateRuleDiv"  _model="!dis"><label for="activateRule.activateRuleType2"><b:message key="edit_finishact_info_jsp.beActivated"/></label><!-- 待激活 -->
		  									<input type="radio" id="activateRule.activateRuleType3" name="activateRule.activateRuleType" value="startStrategybyApp"
		  									_manipulateFields="activateRuleDiv"><label for="activateRule.activateRuleType3"><b:message key="edit_finishact_info_jsp.activateRuleType3"/></label><!-- 由规则逻辑返回值确定 -->
		  							</div>
		  					</div>
		  					<div id="activateRuleDiv">
		  							<label for="activateRule.applicationInfo.application.applicationUri"><b:message key="edit_finishact_info_jsp.ruleLogic"/></label><!-- 规则逻辑 -->
		  							<input type="text" id="activateRule.applicationInfo.application.applicationUri" name="activateRule.applicationInfo.application.applicationUri" readonly size="55">
		  							<label for="btnActivateRuleConfig"></label><input type="button" size="45" id="btnActivateRuleConfig" name="btnActivateRuleConfig" value="<b:message key="edit_finishact_info_jsp.browse"/>" class="button"><!-- 浏览... -->
		  							<div style="display:block">
		  								<label><b:message key="edit_finishact_info_jsp.note"/></label><!-- 注:激活规则确定该活动在流程转至此时将以何种方式激活，规则逻辑返回值为1或true时均可直接激活，返回值为0或false时为待激活 -->
		  							</div>
		  					</div>
		  			</fieldset>
			  </div>
			  <div id="subflows" style="display:none;height:270px">
			  		<fieldset>
			  				<legend><b:message key="edit_subflow_info_jsp.multiSubProcessSet"/></legend><!-- 多子流程设置 -->
			  				<div>
			  						<input type="checkbox" id="implementation.subActivity.isMultiSubProcess" name="implementation.subActivity.isMultiSubProcess"
			  						value="true"
			  						_manipulateFields="rationalDataDiv">
			  						<label for="implementation.subActivity.isMultiSubProcess"><b:message key="edit_subflow_info_jsp.enableMultiSubProcessSet"/></label><!-- 启用多子流程设置 -->
			  				</div>
			  				<div id="rationalDataDiv">
			  						<label for="implementation.subActivity.iterationVariableName"><b:message key="edit_subflow_info_jsp.iterationVariableName"/></label><!-- 迭代变量名 -->
			  						<input type="text" id="implementation.subActivity.iterationVariableName" name="implementation.subActivity.iterationVariableName" size="30">
			  						<div>
				  						<label for="implementation.subActivity.iterationRelevantData"><b:message key="edit_subflow_info_jsp.iterationRelevantData"/></label><!-- 被迭代相关数据 -->
				  						<input type="text" id="implementation.subActivity.iterationRelevantData" name="implementation.subActivity.iterationRelevantData" size="30">
			  						</div>
			  				</div>
			  				 
			  		</fieldset>
			  </div>
			  <div id="preferences" style="display:none;height:270px">
			  		<div style="height:15px">
		  	  				<label for="implementation.subActivity.syncType"><b:message key="edit_autoact_info_jsp.call_mode"/></label><!-- 调用方式 -->
		  	  				<select id="implementation.subActivity.syncType" name="implementation.subActivity.syncType">
		  	  						<option value="synchronous"><b:message key="edit_autoact_info_jsp.synchronous"/></option><!-- 同步 -->
		  	  						<option value="asynchronous"><b:message key="edit_autoact_info_jsp.asynchronous"/></option><!-- 异步 -->
		  	  				</select>
		  	  		</div>
		  	  		<div>
		  	  				<label for="implementation.subActivity.subProcess"><b:message key="edit_subflow_info_jsp.subProcess"/></label><!-- 子流程 -->
		  	  				<div style="display:inline;padding-left:12px">
		  	  					<input type="text" id="implementation.subActivity.subProcess" name="implementation.subActivity.subProcess" size="45">
		  	  				</div>
		  	  				 <div id="errorMsg" style="display:none;padding-left:60px">
						     	<font color="red" size="9px"><b:message key="edit_subflow_info_jsp.errorMsg"/></font><!-- 事件动作不是一个正确的URI! -->
						     </div>
		  	  		</div>
		  	  		<div>
						<r:datacell xpath="json" id="dataCellSubflowParams" width="480" height="200" allowAdd="true" allowDel="true" pageSize="1000">
							<r:field fieldId="mode" onRefreshFunc="setSelectBoxValue" fieldName="mode" label="<b:message key="edit_autoact_info_jsp.type"/>"></r:field><!-- 类型 -->
							<r:field fieldId="name" fieldName="name" label="<b:message key="edit_autoact_info_jsp.name"/>"><h:text/></r:field><!-- 名称 -->
							<r:field fieldId="typeValue" fieldName="dataType/typeValue" label="<b:message key="edit_autoact_info_jsp.dataType"/>" ><h:text/></r:field><!-- 数据类型 -->
							<r:field fieldId="typeClass" onRefreshFunc="setSelectBoxValue2" fieldName="dataType/typeClass" label="<b:message key="edit_autoact_info_jsp.dataClassification"/> " ></r:field><!-- 数据分类 -->
							<r:field fieldId="value" fieldName="value" label="<b:message key="edit_autoact_info_jsp.value"/>"><h:text/></r:field><!-- 值 -->
							<r:field fieldId="valueType" fieldName="valueType" label="<b:message key="edit_autoact_info_jsp.valueType"/>"><h:text/></r:field><!-- 值类型 -->
							<r:field fieldId="fillBack" onRefreshFunc="setCheckboxValue" fieldName="fillBack" label="<b:message key="edit_autoact_info_jsp.backfillRelatedData"/>"></r:field><!-- 回填相关数据 -->
					    <r:toolbar tools="edit:add del" location="top"/>
						</r:datacell>
					</div>
			  </div>
			  <div style="position:relative;display:block;padding-top:20px;padding-bottom:5px">
			            <button class="button" id="activityOK"><b:message key="edit_autoact_info_jsp.ok"/></button><!-- 确定 -->
			            <button class="button" id="activityCancel" onClick="closeWindows()"><b:message key="edit_autoact_info_jsp.cancel"/></button><!-- 取消 -->
				</div>
	  </td>
	</tr>
</table> 
</form>
		<jsp:include flush="true" page="/workflow/wfmanager/definition/processdef_detail/edit_common.jsp"></jsp:include>
		<script>
 				subActivity.renderSubActivity(actJson.activity);
		</script>
</body>
</html>