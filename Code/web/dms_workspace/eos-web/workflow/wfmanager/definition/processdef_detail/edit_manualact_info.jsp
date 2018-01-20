<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<%@ taglib uri="http://eos.primeton.com/tags/bean" prefix="b"%>
<html>
<head>
<%
	String product=com.eos.system.ServerContext.getInstance().getProductFamily();
 %>
<script src="<%=request.getContextPath()%>/workflow/wfmanager/definition/js/new-activity-api.js" language="javascript"></script>
<script src="<%=request.getContextPath()%>/workflow/wfmanager/definition/js/i18n/message.js" i18n="true"/>
	<title></title>
</head>
<body style="background:#FFFFFF;margin-top:0px;margin-left:0px;margin-buttom:0px;overflow: auto;" onload="sizeDialog();">
<form name="processInfo">
   <table border="0" cellpadding="0" cellspacing="0" id="tLayout" class="workarea" width="100%">
	   	<tr>
	   		<td  class="workarea_title" align="left" valign="middle" colspan="3">
				<font color="#000033" class="title_font"><b:message key="edit_manualact_info_jsp.edit_manualact_info"/></font><!-- 编辑人工活动详细信息 -->
			</td>
		</tr>
		<tr>
		  <td width="100" valign="top" style="padding-top:8px;padding-left:5px;">
			  	<div>
			  		<label><b:message key="edit_finishact_info_jsp.setOption"/></label><!-- 设置选项 -->
			  	</div>
			  	<div>
			  		<select id="proItem"  onChange="showDivInfo('proItem',this.options[this.selectedIndex].value);sizeDialog()" name="proItem" size="16" style="width:100px">
						<option value="basedInfo"><b:message key="edit_finishact_info_jsp.basicInfo"/></option><!-- 基本信息 -->
						<option value="participant"><b:message key="edit_manualact_info_jsp.participants"/></option><!-- 参与者 -->
						<option value="formData"><b:message key="edit_manualact_info_jsp.formData"/></option><!-- 表单数据 -->
						<option value="timeLimit"><b:message key="edit_manualact_info_jsp.timeLimit"/></option><!-- 时间限制 -->
						<option value="taskItem"><b:message key="edit_manualact_info_jsp.multiWorkItemSet"/></option><!-- 多工作项设置 -->
						<option value="triggerEvents"><b:message key="edit_autoact_info_jsp.trigger_event"/></option><!-- 触发事件 -->
						<option value="return"><b:message key="edit_autoact_info_jsp.roll_back"/></option><!-- 回退 -->
						<option value="freeFlow"><b:message key="edit_manualact_info_jsp.freeFlow"/></option>	<!-- 自由流 -->
						<option value="startStrategate"><b:message key="edit_finishact_info_jsp.startPolicy"/></option><!-- 启动策略 -->
					 </select>
			  	</div>
		   </td>
		  <td width="10px" style="repeat-y 50%;"></td>
		  <td valign="top" style="padding-top:10px;"> 
					 <!--活动基本属性和扩展属性项 如需删除该项，请将设置选项中相应的option:basedInfo删除-->
					 	<div id="basedInfo" style="height:290px">
					 		 <fieldset>
					 		 	<legend><b:message key="edit_finishact_info_jsp.basicProperties"/></legend><!-- 基本属性 -->
					 		 	<div>
					 		 		<label for="activityId"><b:message key="edit_manualact_info_jsp.activityID"/></label><!-- 活动ID: -->
					 		 		<div style="display:inline;padding-left:12px">
					 		 			<input type="text" class="textbox" id="activityId" name="activityId" readonly="readonly">
					 		 		</div>
					 		 		<div style="display:inline;padding-left:10px">
					 		 			<label for="activityName"><b:message key="edit_manualact_info_jsp.activityName"/></label><!-- 活动名称: -->
										<input type="text" class="textbox" id="activityName" name="activityName" onMouseMove="textCounter(this,200);" onkeydown="textCounter(this,200);" onkeyup="textCounter(this,200);">
									</div>
					 		 	</div>
					 		 	<div style="padding-top:2px">
					 		 		<label for="joinType"><b:message key="edit_manualact_info_jsp.aggregationModel"/></label><!-- 聚合模式: -->
						 		 		<select id="joinType" name="joinType">
					  	   				<option value="AND"><b:message key="edit_finishact_info_jsp.allAggregation"/></option><!-- 全部聚合 -->
					  	   				<option value="XOR"><b:message key="edit_finishact_info_jsp.singleAggregation"/></option><!-- 单一聚合 -->
					  	   				<option value="OR"><b:message key="edit_finishact_info_jsp.multipleAggregation"/></option><!-- 多路聚合 -->
					  	   			</select>
					  	   			<div style="display:inline;padding-left:64px">
						 		 		<label for="splitType"><b:message key="edit_autoact_info_jsp.branch_mode"/></label><!-- 分支模式: -->
						 		 		<select id="splitType" name="splitType">
						  	   				<option value="AND"><b:message key="edit_autoact_info_jsp.all_branch"/></option><!-- 全部分支 -->
						  	   				<option value="XOR"<b:message key="edit_autoact_info_jsp.single_branch"/>></option><!-- 单一分支 -->
						  	   				<option value="OR"><b:message key="edit_autoact_info_jsp.multi_branch"/></option><!-- 多路分支 -->
						  	   			</select>
					  	   			</div>
					 		 	</div>
					 		 	<div style="">
					 		 		<%--<label for="priority">优先级:</label>--%>
					 		 		<div style="disp">
						 		 	<%--	<select id="priority" name="priority">
						 		 			<option value="30">极低</option>
						 		 			<option value="40">低</option>
						 		 			<option value="50">次中</option>
						 		 			<option value="60">中</option>
						 		 			<option value="70">次高</option>
						 		 			<option value="80">高</option>
						 		 		</select>--%>
						 		 		<div style="display:inline;">
								 		 	<label for="implementation.manualActivity.allowAgent"><b:message key="edit_manualact_info_jsp.allowAgent"/></label><!-- 允许代理: -->
							 		 	</div>
							 		 	<div style="display:inline;">
							 		 		<input id="implementation.manualActivity.allowAgent"  name="implementation.manualActivity.allowAgent" type="checkbox" value="true">
							 		 	</div>
					 		 		</div>
					 		 	</div>
					 		 	<div>
					 		 		<div>
					 		 			<label for="splitTransaction"><b:message key="edit_autoact_info_jsp.split_trans"/></label><!-- 分割事务: -->
					 		 			<input id="splitTransaction"  name="splitTransaction" type="checkbox" value="true">
						 		 	</div>
					 		 	</div>
					 		 	<div>
					 		 		<label for="description"><b:message key="edit_manualact_info_jsp.desc"/></label><!-- 描述: -->
					 		 		<div style="display:inline;padding-left:25px">
					 		 			<textarea id="description" name="description" rows="4" cols="50" onMouseMove="textCounter(this,200);" onkeydown="textCounter(this,200);" onkeyup="textCounter(this,200);"></textarea>
					 		 		</div>
					 		 	</div>
					 		 </fieldset>
					 		 <fieldset style="padding-top:10px">
					 		 	<legend><b:message key="edit_manualact_info_jsp.extendAttribute"/></legend><!-- 扩展属性 -->
					 		 	<div>
					 		 		<label for="implementation.manualActivity.customURL.isSpecifyURL"><b:message key="edit_manualact_info_jsp.customURL"/></label><!-- 自定义URL -->
					 		 		<input id="implementation.manualActivity.customURL.isSpecifyURL" 
					 		 			name="implementation.manualActivity.customURL.isSpecifyURL" type="checkbox" value="true"
					 		 			_manipulateFields="customUrl">
					 		 	</div>
					 		 	<div id="customUrl">
						 		 	<div style="padding-left:0px">
						 		 		<label for="implementation.manualActivity.customURL.urlType"><b:message key="edit_manualact_info_jsp.URLType"/></label><!-- URL类型 -->
						 		 		<select id="implementation.manualActivity.customURL.urlType" name="implementation.manualActivity.customURL.urlType" > <!--select的默认操作模式是隐藏和显示div -->
											<% if(product.equals("Primeton EOS")){ %>
												<option value="pageflow"><b:message key="edit_manualact_info_jsp.pageFlow"/></option><!-- 页面流 -->
											<%} %>
						 		 			<option value="webpage"><b:message key="edit_manualact_info_jsp.Webpage"/></option><!-- WEB页面 -->
						 		 			<option value="other" _model="!dis"><b:message key="edit_manualact_info_jsp.other"/></option><!-- 其它 -->
						 		 		</select>
						 		 	</div>
						 		 	<div id="rulInfoDiv" style="padding-left:0px">
						 		 		<label for="implementation.manualActivity.customURL.urlInfo"><b:message key="edit_manualact_info_jsp.callURL"/></label><!-- 调用URL -->
						 		 		<div style="display:inline;padding-left:4px">
						 		 			<input id="implementation.manualActivity.customURL.urlInfo" name="implementation.manualActivity.customURL.urlInfo" type="text" class="textbox" size="35">
						 		 		</div>
						 		 	</div>
					 		 	</div>
					 		 </fieldset>
						 </div>
						 <!--活动参与者信息项 如需删除该项，请将设置选项中相应的option:participant删除-->
						  <div id="participant" style="display:none;height:290px">
						  		<fieldset>
						  			<legend><b:message key="edit_manualact_info_jsp.participantInfo"/></legend><!-- 参与者信息 -->
						  			<div>
						  				<label for="implementation.manualActivity.participants.participantType"><b:message key="edit_manualact_info_jsp.participantType"/></label><!-- 参与者类型: -->
						  				<select id="implementation.manualActivity.participants.participantType" name="implementation.manualActivity.participants.participantType"
						  				_manipulateFields="options">
						  				 <!-- onChange="showDivInfo('implementation.manualActivity.participants.participantType',this.options[this.selectedIndex].value)" -->
												<option value="process-starter"><b:message key="edit_manualact_info_jsp.processStarter"/></option><!-- 流程启动者 -->
												<option value="organization-list"><b:message key="edit_manualact_info_jsp.organization"/></option><!-- 组织机构 -->
												<option value="act-executer"><b:message key="edit_manualact_info_jsp.activityExecutor"/></option><!-- 活动执行者 -->
												<option value="relevantdata"><b:message key="edit_manualact_info_jsp.relatedData"/></option><!-- 相关数据 -->
												<option value="rulelogic"><b:message key="edit_finishact_info_jsp.ruleLogic"/></option><!-- 规则逻辑 -->
										</select>
						  			</div>
						  			<div id="process-starter" style="display:block">
									</div>
									<div id="organization-list" style="margin-top:10px;display:none">
										<r:datacell xpath="json" id="dataCellOrg" width="440" height="180"  allowAdd="true" allowDel="true" pageSize="1000">
											<r:field fieldId="id" fieldName="id" label="<b:message key="edit_manualact_info_jsp.participantID"/>"><h:text/></r:field><!-- 参与者ID -->
											<r:field fieldId="name" fieldName="name" label="<b:message key="edit_autoact_info_jsp.name"/>"><h:text/></r:field><!-- 名称 -->
											<r:field fieldId="type" fieldName="type" label="<b:message key="edit_autoact_info_jsp.type"/>"><h:text/></r:field><!-- 类型 -->
										    <r:toolbar tools="custom,edit:del" location="top"/>
										</r:datacell>
										<div>
											<input type="checkbox" id="implementation.manualActivity.participants.organization.isAllowAppointParticipants" name="implementation.manualActivity.participants.organization.isAllowAppointParticipants" value="true">
											<label for="implementation.manualActivity.participants.organization.isAllowAppointParticipants"><b:message key="edit_manualact_info_jsp.isAllowAppointParticipants"/></label><!-- 是否允许前驱活动根据如上参与者列表指派该活动的参与者 -->
										</div>
									</div>
									
						  			<div id="act-executer" style="margin-top:10px;display:none">
						  				<div>
											<label for="implementation.manualActivity.participants.specialActivityID"><b:message key="edit_manualact_info_jsp.readFromActivity"/></label><!-- 从活动中读取: -->
											<input type="text" id="implementation.manualActivity.participants.specialActivityID" name="implementation.manualActivity.participants.specialActivityID" class="textbox" size="30">
											 <!-- <div  style="display:inline" action="setActivityExecutor" class="editButton"><input type="button" value="设置"></div> -->
										</div>
									</div>
									<div id="relevantdata" style="margin-top:10px;display:none">
										<div>
											<label for="implementation.manualActivity.participants.specialPath"><b:message key="edit_manualact_info_jsp.fromActivityRelateData"/></label><!-- 从活动相关数据获取: -->
											<input type="text" id="implementation.manualActivity.participants.specialPath" class="textbox" size="30" name="implementation.manualActivity.participants.specialPath">
										</div>
 									</div>
									<div id="rulelogic" style="margin-top:10px;display:none">
										<div>
											<label for="implementation.manualActivity.participants.regularApp.application.applicationUri"><b:message key="edit_manualact_info_jsp.fromRuleLogic"/></label><!-- 从规则逻辑获取: -->
											<input type="text" id="implementation.manualActivity.participants.regularApp.application.applicationUri" 
													name="implementation.manualActivity.participants.regularApp.application.applicationUri" readonly
													class="textbox" size="45">
											<div  style="display:inline" class="editButton">
											<label for="btnParticipantRuleConfig"></label><input type="button" id="btnParticipantRuleConfig" name="btnParticipantRuleConfig" class="button" value="<b:message key="edit_manualact_info_jsp.set"/>"> </div><!-- 设置... -->
										</div>
									</div>
						  		</fieldset>
						</div>
						 <!--时间限制项 如需删除该项，请将设置选项中相应的option:timeLimit删除-->
						<div id="timeLimit" style="display:none;height:290px">
							<div>
								<input type="checkbox" id="implementation.manualActivity.timeLimit.isTimeLimitSet" name="implementation.manualActivity.timeLimit.isTimeLimitSet" 
								value="true" _manipulateFields="limitFields,alertStrategy" _ignores="timeLimitInfoDiv,remindInfoDiv,relevanDataDiv,remindRelevantDiv" >
								<label for="implementation.manualActivity.timeLimit.isTimeLimitSet"><b:message key="edit_manualact_info_jsp.enableTimeLimit"/></label><!-- 启用时间限制 -->
							</div>
							<fieldset id="limitFields" style="padding-top:10px">
								<legend><b:message key="edit_manualact_info_jsp.timeLimitSetPolicy"/></legend><!-- 时间限制设置策略 -->
								<div>
									<input type="radio" id="implementation.manualActivity.timeLimit.timeLimitInfo.timeLimitStrategy1" 
									name="implementation.manualActivity.timeLimit.timeLimitInfo.timeLimitStrategy" value="limit_strategy_designate"
									_manipulateFields="timeLimitInfoDiv" _manipulateFields1="relevanDataDiv">
									<label for="implementation.manualActivity.timeLimit.timeLimitInfo.timeLimitStrategy1"><b:message key="edit_manualact_info_jsp.timeLimitStrategy"/></label><!-- 时限 -->
									<div id="timeLimitInfoDiv" style="display:inline;padding-left:5px">
										<input type="text" id="implementation.manualActivity.timeLimit.timeLimitInfo.day" name="implementation.manualActivity.timeLimit.timeLimitInfo.day" size="5" maxlength="4">
										<label for="implementation.manualActivity.timeLimit.timeLimitInfo.day"><b:message key="edit_manualact_info_jsp.day"/></label><!-- 天 -->
										<input type="text" id="implementation.manualActivity.timeLimit.timeLimitInfo.hour" name="implementation.manualActivity.timeLimit.timeLimitInfo.hour" size="5" maxlength="2">
										<label for="implementation.manualActivity.timeLimit.timeLimitInfo.hour"><b:message key="edit_manualact_info_jsp.hour"/></label><!-- 小时 -->
										<input type="text" id="implementation.manualActivity.timeLimit.timeLimitInfo.minute" name="implementation.manualActivity.timeLimit.timeLimitInfo.minute" size="5" maxlength="2">
										<label for="implementation.manualActivity.timeLimit.timeLimitInfo.minute"><b:message key="edit_manualact_info_jsp.minute"/></label><!-- 分钟 -->
									</div>
								</div>
								
								<div>
									<input type="radio" id="implementation.manualActivity.timeLimit.timeLimitInfo.timeLimitStrategy2" 
									name="implementation.manualActivity.timeLimit.timeLimitInfo.timeLimitStrategy" value="limit_strategy_reldata"
									_manipulateFields="relevanDataDiv" _manipulateFields1="timeLimitInfoDiv">
									<label for="implementation.manualActivity.timeLimit.timeLimitInfo.timeLimitStrategy2"><b:message key="edit_manualact_info_jsp.fromRelateData"/></label><!-- 从相关数据获取 -->
								</div>
								<div id="relevanDataDiv" style="padding-left:20px">
									<input type="text" id="implementation.manualActivity.timeLimit.timeLimitInfo.relevantData" name="implementation.manualActivity.timeLimit.timeLimitInfo.relevantData" size="30">
									<div><label for="implementation.manualActivity.timeLimit.timeLimitInfo.relevantData"><b:message key="edit_manualact_info_jsp.relevantData"/></label></div><!-- (相关数据中时间限制格式为:3.5.20 表示时间限制为3天5小时20分钟) -->
								</div>
								<div>
									<input type="checkbox" id="implementation.manualActivity.timeLimit.timeLimitInfo.isSendMessageForOvertime" name="implementation.manualActivity.timeLimit.timeLimitInfo.isSendMessageForOvertime" value="true">
									<label for="implementation.manualActivity.timeLimit.timeLimitInfo.isSendMessageForOvertime"><b:message key="edit_manualact_info_jsp.isSendMessageForOvertime"/></label><!-- 启用邮件通知 -->
								</div>
							</fieldset>
							<fieldset id="alertStrategy" style="padding-top:10px">
								<legend><b:message key="edit_manualact_info_jsp.remindTimeLimit"/></legend><!-- 提醒时间限制设置策略 -->
								<div style="display:block">
									<input type="radio" id="implementation.manualActivity.timeLimit.remindInfo.remindStrategy1" 
									name="implementation.manualActivity.timeLimit.remindInfo.remindStrategy" value="remind_strategy_designate"
									_manipulateFields="remindInfoDiv" _manipulateFields1="remindRelevantDiv">
									<label for="implementation.manualActivity.timeLimit.remindInfo.remindStrategy1"><b:message key="edit_manualact_info_jsp.advance"/></label><!-- 提前 -->
									<div id="remindInfoDiv" style="display:inline;padding-left:5px">
										<input type="text" id="implementation.manualActivity.timeLimit.remindInfo.day1" name="implementation.manualActivity.timeLimit.remindInfo.day1" size="5" maxlength="4">
										<label for="implementation.manualActivity.timeLimit.remindInfo.day1"><b:message key="edit_manualact_info_jsp.day"/></label><!-- 天 -->
										<input type="text" id="implementation.manualActivity.timeLimit.remindInfo.hour1" name="implementation.manualActivity.timeLimit.remindInfo.hour1" size="5" maxlength="2">
										<label for="implementation.manualActivity.timeLimit.remindInfo.hour1"><b:message key="edit_manualact_info_jsp.hour"/></label><!-- 小时 -->
										<input type="text" id="implementation.manualActivity.timeLimit.remindInfo.minute1" name="implementation.manualActivity.timeLimit.remindInfo.minute1" size="5" maxlength="2">
										<label for="implementation.manualActivity.timeLimit.remindInfo.minute1"><b:message key="edit_manualact_info_jsp.minute"/></label><!-- 分钟 -->
									</div>
								</div>
								<div>
									<input type="radio" id="implementation.manualActivity.timeLimit.remindInfo.remindStrategy2" 
									name="implementation.manualActivity.timeLimit.remindInfo.remindStrategy" value="remind_strategy_reldata"
									_manipulateFields="remindRelevantDiv" _manipulateFields1="remindInfoDiv">
									<label for="implementation.manualActivity.timeLimit.remindInfo.remindStrategy2"><b:message key="edit_manualact_info_jsp.fromRelateData"/></label><!-- 从相关数据获取 -->
								</div>
								<div id="remindRelevantDiv" style="padding-left:20px">
									<input type="text" id="implementation.manualActivity.timeLimit.remindInfo.remindRelevantData" name="implementation.manualActivity.timeLimit.remindInfo.remindRelevantData" size="30">
									<div><label for="implementation.manualActivity.timeLimit.remindInfo.remindRelevantData"><b:message key="edit_manualact_info_jsp.relevantData"/></label></div><!-- (相关数据中时间限制格式为:3.5.20 表示时间限制为3天5小时20分钟) -->
								</div>
								<div>
									<input type="checkbox" id="implementation.manualActivity.timeLimit.remindInfo.isSendMessageForRemind" name="implementation.manualActivity.timeLimit.remindInfo.isSendMessageForRemind" value="true">
									<label for="implementation.manualActivity.timeLimit.remindInfo.isSendMessageForRemind"><b:message key="edit_manualact_info_jsp.isSendMessageForOvertime"/></label><!-- 启用邮件通知 -->
								</div>
							</fieldset>
						  </div>
						<div id="return" style="display:none;height:290px">
							<fieldset>
								<legend><b:message key="edit_manualact_info_jsp.cfgInfo"/></legend><!-- 配置信息 -->
								<div>
									<label for="implementation.manualActivity.rollBack.applicationInfo.actionType"><b:message key="edit_manualact_info_jsp.eventType"/></label><!-- 事件类型: -->
									<select id="implementation.manualActivity.rollBack.applicationInfo.actionType" name="implementation.manualActivity.rollBack.applicationInfo.actionType">
										<% if(product.equals("Primeton EOS")){ %>
												<option value="service-component"><b:message key="edit_autoact_info_jsp.service"/></option><!-- 服务 -->
												<option value="logic-flow"><b:message key="edit_autoact_info_jsp.logicFlow"/></option><!-- 逻辑流 -->
											<%} %>
										<option value="pojo"><b:message key="edit_autoact_info_jsp.arithmeticLogic"/></option><!-- 运算逻辑 -->
									</select>
								</div>
								<div>
									<label for="implementation.manualActivity.rollBack.applicationInfo.application.applicationUri"><b:message key="edit_autoact_info_jsp.eventAction"/></label><!-- 事件动作 -->
									<div style="display:inline">
										<input type="text" id="implementation.manualActivity.rollBack.applicationInfo.application.applicationUri" 
										name="implementation.manualActivity.rollBack.applicationInfo.application.applicationUri"size="35">
									</div>
								</div>
							</fieldset>
							<fieldset>
								<legend><b:message key="edit_manualact_info_jsp.paramAndReturnValue"/></legend><!-- 参数和返回值 -->
								<div><b:message key="edit_manualact_info_jsp.ParamCfgTable"/></div><!-- 参数配置表 -->
								<div id="rollBackParams">
									<r:datacell xpath="json" id="dataCellRBackParams" width="440" height="180" allowAdd="true" allowDel="true" pageSize="1000">
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
						<div id="taskItem" style="display:none;height:290px">
							<div>
								<input type="checkbox" id="implementation.manualActivity.multiWorkItem.isMulWIValid" name="implementation.manualActivity.multiWorkItem.isMulWIValid"
								 value="true" _manipulateFields="wiStrategy,finishRules" >
								<label for="implementation.manualActivity.multiWorkItem.isMulWIValid"><b:message key="edit_manualact_info_jsp.startMutiWorkitemSet"/></label><!-- 启动多工作项设置 -->
							</div>							
							<fieldset id="wiStrategy" style="padding-top:10px">
								<legend><b:message key="edit_manualact_info_jsp.multiWorkItemAllocationStrategy"/></legend><!-- 多工作项分配策略 -->
								<div>
									<input type="radio" id="implementation.manualActivity.multiWorkItem.workitemNumStrategy1" name="implementation.manualActivity.multiWorkItem.workitemNumStrategy" value="participant-number">
									<label for="implementation.manualActivity.multiWorkItem.workitemNumStrategy1"><b:message key="edit_manualact_info_jsp.workitemNumStrategy1"/></label><!-- 按参与者设置个数领取工作项 -->
								</div>
								<div>
									<input type="radio" id="implementation.manualActivity.multiWorkItem.workitemNumStrategy2" name="implementation.manualActivity.multiWorkItem.workitemNumStrategy" value="operator-number">
									<label for="implementation.manualActivity.multiWorkItem.workitemNumStrategy2"><b:message key="edit_manualact_info_jsp.workitemNumStrategy2"/></label><!-- 按操作员个数分配工作项 -->
								</div>
								<div>	
									<input type="checkbox" onmouseup="chkALL();" id="implementation.manualActivity.multiWorkItem.sequentialExecute" name="implementation.manualActivity.multiWorkItem.sequentialExecute"  _model="!dis" _manipulateFields="finishRule2Div,finishRule3Div,isAutoCancelDiv" >
									<label for="implementation.manualActivity.multiWorkItem.sequentialExecute"><b:message key="edit_manualact_info_jsp.sequentialExecute"/></label><!-- 顺序执行工作项 -->
								</div>
							</fieldset>
							<fieldset id="finishRules" style="padding-top:10px">
								<legend><b:message key="edit_manualact_info_jsp.finishRules"/>/legend><!-- 完成规则设定< -->
								<div id="finishRule1Div">
									<input type="radio" id="implementation.manualActivity.multiWorkItem.finishRule1" 
									name="implementation.manualActivity.multiWorkItem.finishRule" value="all" _manipulateFields1="rquiredNum,requiredPercentDiv">
									<label for="implementation.manualActivity.multiWorkItem.finishRule1"><b:message key="edit_manualact_info_jsp.finishRule1"/></label><!-- 全部完成 -->
								</div>
								<div id="finishRule2Div">
									<input type="radio" id="implementation.manualActivity.multiWorkItem.finishRule2" 
									name="implementation.manualActivity.multiWorkItem.finishRule" value="specifyNum"
									_manipulateFields="rquiredNum" _manipulateFields1="requiredPercentDiv">
									<label for="implementation.manualActivity.multiWorkItem.finishRule2"><b:message key="edit_manualact_info_jsp.finishRule2"/></label><!-- 完成个数 -->
									<div id="rquiredNum" style="padding-left:25px">
										<label for="implementation.manualActivity.multiWorkItem.finishRquiredNum"><b:message key="edit_manualact_info_jsp.finishRquiredNum"/></label><!-- 要求完成个数 -->
										<div style="display:inline;padding-left:12px"> 
											<input type="text" id="implementation.manualActivity.multiWorkItem.finishRquiredNum" name="implementation.manualActivity.multiWorkItem.finishRquiredNum" size="15">
										</div>
									</div>
								</div>
								<div id="finishRule3Div">
									<input type="radio" id="implementation.manualActivity.multiWorkItem.finishRule3" 
									name="implementation.manualActivity.multiWorkItem.finishRule" value="specifyPercent"
									_manipulateFields="requiredPercentDiv" _manipulateFields1="rquiredNum">
									<label for="implementation.manualActivity.multiWorkItem.finishRule3"><b:message key="edit_manualact_info_jsp.finishRule3"/></label><!-- 完成百分比 -->
									<div id="requiredPercentDiv" style="padding-left:25px">
										<label for="implementation.manualActivity.multiWorkItem.finishRequiredPercent"><b:message key="edit_manualact_info_jsp.finishRequiredPercent"/></label><!-- 要求完成百分比 -->
										<input type="text" id="implementation.manualActivity.multiWorkItem.finishRequiredPercent" name="implementation.manualActivity.multiWorkItem.finishRequiredPercent" size="15">%
									</div>
								</div>
								<div id="isAutoCancelDiv" style="margin-bottom:5px">
									<input type="checkbox" id="implementation.manualActivity.multiWorkItem.isAutoCancel" name="implementation.manualActivity.multiWorkItem.isAutoCancel" value="true">
									<label for="implementation.manualActivity.multiWorkItem.isAutoCancel"><b:message key="edit_manualact_info_jsp.isAutoCancel"/></label><!-- 未完成工作项自动终止 -->
								</div>
							</fieldset>
						</div>	 							
						<div id="startStrategate" style="display:none;height:290px">
							<fieldset>
								<legend><b:message key="edit_finishact_info_jsp.startPolicy"/></legend><!-- 启动策略 -->
								<div>
		  							<label for="activateRule.activateRuleType"><b:message key="edit_finishact_info_jsp.optionalRule"/></label><!-- 可选规则 -->
		  							<div>
		  									<input type="radio" id="activateRule.activateRuleType1" name="activateRule.activateRuleType" value="directRunning"
		  									_manipulateFields="activateRuleDiv"  _model="!dis"><label for="activateRule.activateRuleType1"><b:message key="edit_finishact_info_jsp.directOperation"/></label><!-- 直接运行 -->
		  									<input type="radio" id="activateRule.activateRuleType2" name="activateRule.activateRuleType" value="waitingActivition"
		  									_manipulateFields="activateRuleDiv"  _model="!dis"><label for="activateRule.activateRuleType2"><b:message key="edit_autoact_info_jsp.beActivated"/></label><!-- 待激活 -->
		  									<input type="radio" id="activateRule.activateRuleType3" name="activateRule.activateRuleType" value="startStrategybyApp"
		  									_manipulateFields="activateRuleDiv"><label for="activateRule.activateRuleType3"><b:message key="edit_autoact_info_jsp.activateRuleType3"/></label><!-- 由规则逻辑返回值确定 -->
		  							</div>
			  					</div>
			  					<div id="activateRuleDiv">
			  							<label for="activateRule.applicationInfo.application.applicationUri"><b:message key="edit_finishact_info_jsp.ruleLogic"/></label><!-- 规则逻辑 -->
			  							<input type="text" id="activateRule.applicationInfo.application.applicationUri" name="activateRule.applicationInfo.application.applicationUri" readonly size="30">
			  							<label for="btnActivateRuleConfig"></label><input type="button" id="btnActivateRuleConfig" size="45" class="button" value="<b:message key="edit_finishact_info_jsp.browse"/>"><!-- 浏览... -->
			  							<div style="display:block">
			  								<label><b:message key="edit_manualact_info_jsp.note"/></label><!-- 注:激活规则确定该活动在流程转至此时将以何种方式激活，规则逻辑返回值为1或true时均可直接激活，返回值为0或false时为待激活 -->
			  							</div>
			  					</div>
							</fieldset>
							<fieldset>
								<legend><b:message key="edit_manualact_info_jsp.reStart"/></legend><!-- 重新启动规则 -->
								<div>
									<input type="radio" id="implementation.manualActivity.resetParticipant1" name="implementation.manualActivity.resetParticipant" value="originalParticipant">
									<label for="implementation.manualActivity.resetParticipant1"><b:message key="edit_manualact_info_jsp.participantsInitially"/></label><!-- 最初参与者 -->
									<input type="radio" id="implementation.manualActivity.resetParticipant2" name="implementation.manualActivity.resetParticipant" value="finalParticipant">
									<label for="implementation.manualActivity.resetParticipant2"><b:message key="edit_manualact_info_jsp.finalParticipants"/></label><!-- 最终参与者 -->
								</div>
								<div>
					 		 		<label for="implementation.manualActivity.resetUrl.isSpecifyURL"><b:message key="edit_manualact_info_jsp.resetURL"/></label><!-- 重新设置URL -->
					 		 		<input id="implementation.manualActivity.resetUrl.isSpecifyURL" 
					 		 			name="implementation.manualActivity.resetUrl.isSpecifyURL" type="checkbox" value="true"
					 		 			_manipulateFields="resetUrl">
					 		 	</div>
					 		 	<div id="resetUrl">
						 		 	<div style="padding-left:0px">
						 		 		<label for="implementation.manualActivity.resetUrl.urlType"><b:message key="edit_manualact_info_jsp.URLType"/></label><!-- URL类型 -->
						 		 		<select id="implementation.manualActivity.resetUrl.urlType" name="implementation.manualActivity.resetUrl.urlType" > <!--select的默认操作模式是隐藏和显示div -->
											<% if(product.equals("Primeton EOS")){ %>
												<option value="pageflow"><b:message key="edit_manualact_info_jsp.pageFlow"/></option><!-- 页面流 -->
											<%} %>
						 		 			<option value="webpage"><b:message key="edit_manualact_info_jsp.Webpage"/></option><!-- WEB页面 -->
						 		 			<option value="other" _model="!dis"><b:message key="edit_manualact_info_jsp.other"/></option><!-- 其它 -->
						 		 		</select>
						 		 	</div>
						 		 	<div id="rulInfoDiv" style="padding-left:0px">
						 		 		<label for="implementation.manualActivity.resetUrl.urlInfo"><b:message key="edit_manualact_info_jsp.callURL"/></label><!-- 调用URL -->
						 		 		<div style="display:inline;padding-left:4px">
						 		 			<input id="implementation.manualActivity.resetUrl.urlInfo" name="implementation.manualActivity.resetUrl.urlInfo" type="text" class="textbox" size="40">
						 		 		</div>
						 		 	</div>
					 		 	</div>
							</fieldset>
						</div>
						<div id="freeFlow" style="display:none;height:290px">
							<div>
								<input type="checkbox" id="implementation.manualActivity.freeFlowRule.isFreeActivity" 
											name="implementation.manualActivity.freeFlowRule.isFreeActivity" value="true"
											 _manipulateFields="freeRangeStrategy,freeRulesSet">
								<label for="implementation.manualActivity.freeFlowRule.isFreeActivity"><b:message key="edit_manualact_info_jsp.isFreeActivity"/></label><!-- 设置该活动为自由流 -->
							</div>
							<fieldset id="freeRangeStrategy" style="padding-top:10px">
								<legend><b:message key="edit_manualact_info_jsp.freeRangeStrategy"/></legend><!-- 自由范围设置策略 -->
								<div>
									<input type="radio" id="implementation.manualActivity.freeFlowRule.freeRangeStrategy1" name="implementation.manualActivity.freeFlowRule.freeRangeStrategy" 
									_manipulateFields="freeActivitiesDiv" _model="!sh" value="freeWithinProcess">
									<label for="implementation.manualActivity.freeFlowRule.freeRangeStrategy1"><b:message key="edit_manualact_info_jsp.freeRangeStrategy1"/></label><!-- 在该流程范围内任意自由 -->
								</div>
								<div>
									<input type="radio" id="implementation.manualActivity.freeFlowRule.freeRangeStrategy2" name="implementation.manualActivity.freeFlowRule.freeRangeStrategy" 
									_manipulateFields="freeActivitiesDiv"  _model="sh" value="freeWithinActivityList">
									<label for="implementation.manualActivity.freeFlowRule.freeRangeStrategy2"><b:message key="edit_manualact_info_jsp.freeRangeStrategy2"/></label><!-- 在指定活动列表范围内自由 -->
								</div>
								<div id="freeActivitiesDiv" style="padding-top:5px;padding-left:25px;display:none;">
									<r:datacell xpath="json" id="dataCellFreeActivities" width="400" height="140" allowAdd="true" allowDel="true" pageSize="1000">
										<r:field fieldId="faid" fieldName="id" label="<b:message key=""/>"><h:text/></r:field><!-- 活动ID -->
										<r:field fieldId="faname" fieldName="name" label="<b:message key=""/>"><h:text/></r:field><!-- 活动名称 -->
									    <r:toolbar tools="edit:add del" location="top"/>
									</r:datacell>
								</div>
								<div>
									<input type="radio" id="implementation.manualActivity.freeFlowRule.freeRangeStrategy3" name="implementation.manualActivity.freeFlowRule.freeRangeStrategy"
									_manipulateFields="freeActivitiesDiv" _model="!sh"  value="freeWithinNextActivites">
									<label for="implementation.manualActivity.freeFlowRule.freeRangeStrategy3"><b:message key="edit_manualact_info_jsp.freeRangeStrategy3"/></label><!-- 在后继活动范围内自由 -->
								</div>
							</fieldset>
							<fieldset id="freeRulesSet" style="padding-top:10px">
								<legend><b:message key="edit_manualact_info_jsp.freeRulesSet"/></legend><!-- 自由流设置规则 -->
								<div>
									<input type="checkbox" id="implementation.manualActivity.freeFlowRule.isOnlyLimitedManualActivity" name="implementation.manualActivity.freeFlowRule.isOnlyLimitedManualActivity" value="true">
									<label for="implementation.manualActivity.freeFlowRule.isOnlyLimitedManualActivity"><b:message key="edit_manualact_info_jsp.isOnlyLimitedManualActivity"/></label><!-- 流向的目标活动仅限于人工活动 -->
								</div>
							</fieldset>
						</div>
						<div id="formData" style="display:none;height:290px">
								<r:datacell xpath="json" id="dataCellFormdata" width="450" height="250" allowAdd="true" allowDel="true" pageSize="1000">
									<r:field fieldId="fname" fieldName="name" label="<b:message key="edit_manualact_info_jsp.displayName"/>"><h:text/></r:field><!-- 显示名称 -->
									<r:field fieldId="fpath" fieldName="path" label="<b:message key="edit_manualact_info_jsp.relatedDatapath"/>"><h:text/></r:field><!-- 相关数据路径 -->
									<r:field fieldId="dataType" fieldName="dataType" onRefreshFunc="setFormDataTypeValue" label="<b:message key="edit_autoact_info_jsp.type"/>"></r:field><!-- 类型 -->
									<r:field fieldId="required" fieldName="required" onRefreshFunc="setFormRequiredValue" label="<b:message key="edit_manualact_info_jsp.isNecessary"/>"></r:field><!-- 是否必需 -->
									<r:field fieldId="defaultValue" fieldName="defaultValue" label="<b:message key="edit_manualact_info_jsp.defaultValue"/>"><h:text/></r:field><!-- 默认值 -->
									<r:field fieldId="accessType" fieldName="accessType" onRefreshFunc="setFormAccessTypeValue"  label="<b:message key="edit_manualact_info_jsp.visitMethod"/>"></r:field><!-- 访问方法 -->
									<r:field fieldId="description" fieldName="description" label="<b:message key="edit_finishact_info_jsp.desc"/>"><h:text/></r:field><!-- 描述 -->
								    <r:toolbar tools="edit:add del,custom" location="top"/>
								</r:datacell>
						</div>
						<div id="triggerEvents" style="display:none;height:290px">
							<r:datacell xpath="json" id="dataCellTrgEvnts" width="450" height="250" allowAdd="true" allowDel="true" pageSize="1000">
								<r:field fieldId="eventType" fieldName="eventType" onRefreshFunc="setEventTypeValue" label="<b:message key="edit_autoact_info_jsp.triggerTime"/>"></r:field><!-- 触发时机 -->
								<r:field fieldId="applicationUr" fieldName="applicationInfo/application/applicationUri" onRefreshFunc="setApplicationUriLink" label="<b:message key="edit_autoact_info_jsp.eventAction"/>" ></r:field><!-- 事件动作 -->
								<r:field fieldId="invokePattern" fieldName="applicationInfo/application/invokePattern" onRefreshFunc="setInvokePatternValue" label="<b:message key="edit_autoact_info_jsp.call_mode"/>"></r:field><!-- 调用方式 -->
								<r:field fieldId="transactionType" fieldName="applicationInfo/application/transactionType" onRefreshFunc="setTransactionTypeValue" label="<b:message key="edit_autoact_info_jsp.trans_policy"/>"></r:field><!-- 事务策略 -->
								<r:field fieldId="exceptionStrategy" fieldName="applicationInfo/application/exceptionStrategy" onRefreshFunc="setExceptionStrategyValue" label="<b:message key="edit_autoact_info_jsp.exce_process"/>"></r:field><!-- 异常处理 -->
								<r:field fieldId="tgdescription" fieldName="description" label="<b:message key="edit_autoact_info_jsp.desc"/>"><h:text/></r:field><!-- 描述 -->
							    <r:toolbar tools="edit:add del,custom" location="top"/>
							</r:datacell>
						</div>
						
						<div style="position:relative;display:block;padding-top:20px;padding-bottom:5px">
					            <button class="button" id="activityOK"><b:message key="edit_autoact_info_jsp.ok"/></button><!-- 确定 -->
					            <button class="button" id="activityCancel"><b:message key="edit_autoact_info_jsp.cancel"/></button><!-- 取消 -->
						</div>
	      </td>
	    </tr>
	</table>
</form>
		<jsp:include flush="true" page="/workflow/wfmanager/definition/processdef_detail/edit_common.jsp"></jsp:include>
		<script>
			 //alert(actJson.toJSONString());
			 //alert(actJson);
 			 manualActivity.renderManualActivity(actJson);
		</script>
		<script>
			function setEventTypeValue (value,entity,rowIndex,colIndex) {
				var funcName='eventType_'+rowIndex;
				
				$setFunction(funcName , function(cidx){
					entity.setProperty('eventType',''+this.options[this.selectedIndex].value);
				} );
				
				var _v=''+value;
				var sbox = '<select onchange="$function(\''+funcName+'\',this,['+colIndex+'])">' ;
				sbox+='<option value="before-start-act" '+(_v =="before-start-act"?'selected' : '') + '><b:message key="edit_manualact_info_jsp.beforeStartActivity"/></option>';	//活动启动前
				sbox+='<option value="after-start-act"'+(_v =="after-start-act"?'selected' : '') + '><b:message key="edit_manualact_info_jsp.activityStart"/></option>';		//活动启动后
				sbox+='<option value="before-finish-act"'+(_v =="before-finish-act"?'selected' : '') + '><b:message key="edit_manualact_info_jsp.beforeFinishActivity"/></option>';	//活动完成前
				sbox+='<option value="after-finish-act"'+(_v =="after-finish-act"?'selected' : '') + '><b:message key="edit_manualact_info_jsp.afterFinishAct"/></option>';		//活动完成后
				sbox+='<option value="after-resume-act"'+(_v =="after-resume-act"?'selected' : '') + '><b:message key="edit_manualact_info_jsp.actAfterRecovery"/></option>';		//活动恢复后
				sbox+='<option value="after-suspend-act"'+(_v =="after-suspend-act"?'selected' : '') + '><b:message key="edit_manualact_info_jsp.afterActSuspend"/></option>';	//活动挂起后
				
				sbox+='<option value="after-create-wi"'+(_v =="after-create-wi"?'selected' : '') + '><b:message key="edit_manualact_info_jsp.workitemCreated"/></option>';		//工作项创建后
				sbox+='<option value="after-get-wi"'+(_v =="after-get-wi"?'selected' : '') + '><b:message key="edit_manualact_info_jsp.afterReceivingWorkitem"/></option>';			//工作项领取后
				sbox+='<option value="after-cancel-wi"'+(_v =="after-cancel-wi"?'selected' : '') + '><b:message key="edit_manualact_info_jsp.afterCancelReceivingWorkitem"/></option>';	//工作项取消领取后
				sbox+='<option value="before-finish-wi"'+(_v =="before-finish-wi"?'selected' : '') + '><b:message key="edit_manualact_info_jsp.beforeFinishWorkitem"/></option>';	//工作项完成前
				sbox+='<option value="after-finish-wi"'+(_v =="after-finish-wi"?'selected' : '') + '><b:message key="edit_manualact_info_jsp.afterFinishWorkitem"/></option>';		//工作项完成后
				sbox+='<option value="after-resume-wi"'+(_v =="after-resume-wi"?'selected' : '') + '><b:message key="edit_manualact_info_jsp.afterResumptionWorkitem"/></option>';		//工作项恢复后
				sbox+='<option value="after-suspend-wi"'+(_v =="after-suspend-wi"?'selected' : '') + '><b:message key="edit_manualact_info_jsp.afterWorkitemSuspend"/></option>';	//工作项挂起后
				sbox+='<option value="after-timeout-wi"'+(_v =="after-timeout-wi"?'selected' : '') + '><b:message key="edit_manualact_info_jsp.afterWorkitemTimeout"/></option>';	//工作项超时后
				sbox+='<option value="after-remind-wi"'+(_v =="after-remind-wi"?'selected' : '') + '><b:message key="edit_manualact_info_jsp.afterWorkitemRemind"/></option>';		//工作项提醒后
				sbox += '</select>';
				return sbox;
			}
			
			function chkALL(){
				$("implementation.manualActivity.multiWorkItem.finishRule1").checked="checked";
			}
			
			
		</script>
</body>
</html>