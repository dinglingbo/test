<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<%
	String product=com.eos.system.ServerContext.getInstance().getProductFamily();
 %>
<html>
<head>
<script src="<%=request.getContextPath()%>/workflow/wfmanager/definition/js/new-activity-api.js" language="javascript"></script>
<script src="<%=request.getContextPath()%>/workflow/wfmanager/definition/js/i18n/message.js" i18n="true"/>
	<title></title>
</head>
<body style="background:#FFFFFF;margin-top:0px;margin-left:0px;margin-buttom:0px;overflow: auto;" onload="sizeDialog()">
<form name="processInfo">
   <table  id="tLayout" border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
   	<tr>
		<td colspan="3" class="workarea_title" valign="middle"><font color="#000033" class="title_font"><b:message key="edit_process_info_jsp.editFlowFigureDetail"/></font></td><!-- 编辑流程图详细信息 -->
	</tr>
	<tr>
	  <td width="100" valign="top" style="padding-top:8px;padding-left:5px;">
			<div>
				<label><b:message key="edit_finishact_info_jsp.setOption"/></able><!-- 设置选项 -->
			</div>
			<div>
			 <select onChange="showDivInfo('proItem',this.options[this.selectedIndex].value);sizeDialog()" name="proItem" multiple="multiple" size="16" style="width:100px;">
				<option value="basedInfo"><b:message key="edit_finishact_info_jsp.basicInfo"/></option><!-- 基本信息 -->
				<% if(product.equals("Primeton EOS")){ %>
					<option value="dataEntity"><b:message key="edit_process_info_jsp.dataEntityAssociate"/></option><!-- 数据实体关联 -->
				<%} %>
				<option value="relativeData"><b:message key="edit_manualact_info_jsp.relatedData"/></option><!-- 相关数据 -->
				<option value="preferences"><b:message key="edit_process_info_jsp.processParam"/></option><!-- 流程参数 -->
				<option value="triggerEvent"><b:message key="edit_autoact_info_jsp.trigger_event"/></option><!-- 触发事件 -->
				<option value="timeLimit"><b:message key="edit_manualact_info_jsp.timeLimit"/></option><!-- 时间限制 -->
				<option value="launcher"><b:message key="edit_manualact_info_jsp.processStarter"/></option><!-- 流程启动者 -->
			 </select>
			</div>
    </td>
    <td width="10px" style="repeat-y 50%;"></td>
	  <td valign="top" style="padding-top:10px;"> 
	  	<div id="basedInfo" style="height:235px;width:500px;">
	  			<fieldset>
	  					<legend><b:message key="edit_finishact_info_jsp.basicInfo"/></legend><!-- 基本信息 -->
	  					<div>
	  							<label for="processBasicInfo.processId"><b:message key="edit_process_info_jsp.processID"/></label><!-- 流程ID -->
	  							<div style="display:inline;padding-left:14px;">
	  								<input type="text" id="processBasicInfo.processId" name="processBasicInfo.processId" readonly size="47">
	  						    </div>
	  					</div>
	  					<div>
	  							<label for="processBasicInfo.processName"><b:message key="edit_process_info_jsp.processName"/></label><!-- 流程名称 -->
	  							<input type="text" id="processBasicInfo.processName" name="processBasicInfo.processName" size="47" maxlength="512">
	  					</div>
	  					<div>
	  							<label for="processBasicInfo.author"><b:message key="edit_process_info_jsp.author"/></label><!-- 作者 -->
	  							<div style="display:inline;padding-left:24px">
	  								<input type="text" id="processBasicInfo.author" name="processBasicInfo.author" size="47" maxlength="512">
	  							</div>
	  					</div>
	  					<div>
	  							<label for="processBasicInfo.department"><b:message key="edit_process_info_jsp.department"/></label><!-- 部门 -->
	  							<div style="display:inline;padding-left:24px">
		  							<input type="text" id="processBasicInfo.department" name="processBasicInfo.department" size="47"  maxlength="512">
		  						</div>
	  					</div>
	  					<div>
	  							<%--<label for="processBasicInfo.priority">优先级</label>
	  							<div style="display:inline;padding-left:12px">
		  							<select id="processBasicInfo.priority" name="processBasicInfo.priority">
					 		 			<option value="30">极低</option>
					 		 			<option value="40">低</option>
					 		 			<option value="50">次中</option>
					 		 			<option value="60">中</option>
					 		 			<option value="70">次高</option>
					 		 			<option value="80">高</option>
					 		 		</select>
					 		 	</div>--%>
				 		 		<div style="display:inline;">  
				 		 				<label for="splitTransaction"><b:message key="edit_autoact_info_jsp.split_trans"/></label><!-- 分割事务 -->
				 		 				<input type="checkbox" id="splitTransaction" name="splitTransaction" value="true">
				 		 		</div>
	  					</div>
	  					<div>
	  							<label for="processBasicInfo.description"><b:message key=""/></label><!-- 描述 -->
	  							<div style="display:inline;padding-left:24px">
	  								<textarea id="processBasicInfo.description" name="processBasicInfo.description" cols="45" rows="6" onMouseMove="textCounter(this,200);" onkeydown="textCounter(this,200);" onkeyup="textCounter(this,200);"></textarea>
	  							</div>
	  					</div>
	  			</fieldset>
	  	</div>
	  	<div id="relativeData" style="display:none;margin-top:5px;height:230px">
	  		<r:datacell xpath="json" id="dataCellRelativeDt" width="500" height="220"  allowAdd="true" allowDel="true" pageSize="1000">
				<r:field fieldId="name" fieldName="name" label="<b:message key="edit_autoact_info_jsp.name"/>"><h:text/></r:field><!-- 名称 -->
				<r:field fieldId="dataType" fieldName="dataType/typeValue" label="<b:message key="edit_autoact_info_jsp.dataType"/>"><h:text/></r:field><!-- 数据类型 -->
				<r:field fieldId="typeClass" onRefreshFunc="setSelectBoxValue2" fieldName="dataType/typeClass" label="<b:message key="edit_autoact_info_jsp.dataClassification"/>" ></r:field><!-- 数据分类 -->
				<r:field fieldId="isArray" onRefreshFunc="setIsArrayValue" fieldName="isArray" label="<b:message key="edit_process_info_jsp.array"/>"></r:field><!-- 数组 -->
				<r:field fieldId="initialValue" fieldName="initialValue" label="<b:message key="edit_process_info_jsp.initialValue"/>"><h:text/></r:field><!-- 初始值 -->
				<r:field fieldId="description" fieldName="description" label="<b:message key="edit_finishact_info_jsp.desc"/>"><h:text/></r:field><!-- 描述 -->
			    <r:toolbar tools="edit:add del" location="top"/>
			</r:datacell>
	  	</div>
	  	<div id="dataEntity" style="display:none;margin-top:5px;height:230px">
					<fieldset style="height:200px">
							<legend><b:message key="edit_process_info_jsp.dataEntityInfo"/></legend><!-- 数据实体信息 -->
							<div>
								<label for="bizEntityInfo.bizEntityName"><b:message key="edit_process_info_jsp.dataEntity"/></label><!-- 数据实体 -->
								<div style="display:inline;padding-left:12px">
									<input type="text" id="bizEntityInfo.bizEntityName" name="bizEntityInfo.bizEntityName" size="30">
								</div>
							</div>
							<div>
								<label for="bizEntityInfo.relevantKey"><b:message key="edit_process_info_jsp.relevantKey"/></label><!-- 关联字段名 -->
								<input type="text" id="bizEntityInfo.relevantKey" name="bizEntityInfo.relevantKey" size="30">
								<div style="padding-left:68px">
									<label><b:message key="edit_process_info_jsp.relevantKey2"/></label><!-- (与流程实例ID相关的字段的名称) -->
								</div>
							</div>
					</fieldset>
	  	</div>
	  	<div id="timeLimit" style="display:none;margin-top:5px;">
  			<div>
  				<input type="checkbox" id="timeLimit.isTimeLimitSet" name="timeLimit.isTimeLimitSet" value="true" _manipulateFields="limitFields,alertStrategy" _ignores="timeLimitInfoDiv,relevanDataDiv,remindInfoDiv,remindRelevantDiv">
				<label for="timeLimit.isTimeLimitSet"><b:message key="edit_manualact_info_jsp.enableTimeLimit"/></label><!-- 启用时间限制 -->
			</div>
			<fieldset id="limitFields" style="padding-top:10px">
				<legend><b:message key="edit_manualact_info_jsp.timeLimitSetPolicy"/></legend><!-- 时间限制设置策略 -->
				<div>
					<input type="radio" id="timeLimit.timeLimitInfo.timeLimitStrategy1" 
					name="timeLimit.timeLimitInfo.timeLimitStrategy" value="limit_strategy_designate"
					_manipulateFields="timeLimitInfoDiv">
					<label for="timeLimit.timeLimitInfo.timeLimitStrategy1"><b:message key="edit_manualact_info_jsp.timeLimitStrategy"/></label><!-- 时限 -->
					<div id="timeLimitInfoDiv" style="display:inline;padding-left:5px">
						<input type="text" id="timeLimit.timeLimitInfo.day" name="timeLimit.timeLimitInfo.day" size="5"  maxlength="4">
						<label for="timeLimit.timeLimitInfo.day"><b:message key="edit_manualact_info_jsp.day"/></label><!-- 天 -->
						<input type="text" id="timeLimit.timeLimitInfo.hour" name="timeLimit.timeLimitInfo.hour" size="5" maxlength="2">
						<label for="timeLimit.timeLimitInfo.hour"><b:message key="edit_manualact_info_jsp.hour"/></label><!-- 小时 -->
						<input type="text" id="timeLimit.timeLimitInfo.minute" name="timeLimit.timeLimitInfo.minute" size="5" maxlength="2">
						<label for="timeLimit.timeLimitInfo.minute"><b:message key="edit_manualact_info_jsp.minute"/></label><!-- 分钟 -->
					</div>
				</div>
				
				<div>
					<input type="radio" id="timeLimit.timeLimitInfo.timeLimitStrategy2" 
					name="timeLimit.timeLimitInfo.timeLimitStrategy" value="limit_strategy_reldata"
					_manipulateFields="relevanDataDiv">
					<label for="timeLimit.timeLimitInfo.timeLimitStrategy2"><b:message key="edit_process_info_jsp.timeLimitStrategy2"/></label><!-- 从相关数据获取时间限制 -->
				</div>
				<div id="relevanDataDiv" style="padding-left:20px">
					<input type="text" id="timeLimit.timeLimitInfo.relevantData" name="timeLimit.timeLimitInfo.relevantData" size="30">
					<div><label for="timeLimit.timeLimitInfo.relevantData"><b:message key="edit_manualact_info_jsp.relevantData"/></label></div><!-- (相关数据中时间限制格式为:3.5.20 表示时间限制为3天5小时20分钟) -->
				</div>
				<div>
					<input type="checkbox" id="timeLimit.timeLimitInfo.isSendMessageForOvertime" name="timeLimit.timeLimitInfo.isSendMessageForOvertime" value="true">
					<label for="timeLimit.timeLimitInfo.isSendMessageForOvertime"><b:message key="edit_manualact_info_jsp.isSendMessageForOvertime"/></label><!-- 启用邮件通知 -->
				</div>
			</fieldset>
			<fieldset id="alertStrategy" style="padding-top:10px">
				<legend><b:message key="edit_manualact_info_jsp.remindTimeLimit"/></legend><!-- 提醒时间限制设置策略 -->
				<div style="display:block">
					<input type="radio" id="timeLimit.remindInfo.remindStrategy1" 
					name="timeLimit.remindInfo.remindStrategy" value="remind_strategy_designate"
					_manipulateFields="remindInfoDiv">
					<label for="timeLimit.remindInfo.remindStrategy1"><b:message key="edit_manualact_info_jsp.remindTimeLimit"/></label><!-- 提醒时间限制设置策略 -->
					<div id="remindInfoDiv" style="display:inline;padding-left:5px">
						<input type="text" id="timeLimit.remindInfo.day1" name="timeLimit.remindInfo.day1" size="5" maxlength="4">
						<label for="timeLimit.remindInfo.day1"><b:message key="edit_manualact_info_jsp.day"/></label><!-- 天 -->
						<input type="text" id="timeLimit.remindInfo.hour1" name="timeLimit.remindInfo.hour1" size="5" maxlength="2">
						<label for="timeLimit.remindInfo.hour1"><b:message key="edit_manualact_info_jsp.hour"/></label><!-- 小时 -->
						<input type="text" id="timeLimit.remindInfo.minute1" name="timeLimit.remindInfo.minute1" size="5" maxlength="2">
						<label for="timeLimit.remindInfo.minute1"><b:message key="edit_manualact_info_jsp.minute"/></label><!-- 分钟 -->
					</div>
				</div>
				<div>
					<input type="radio" id="timeLimit.remindInfo.remindStrategy2" 
					name="timeLimit.remindInfo.remindStrategy" value="remind_strategy_reldata"
					_manipulateFields="remindRelevantDiv">
					<label for="timeLimit.remindInfo.remindStrategy2"><b:message key="edit_process_info_jsp.timeLimitStrategy2"/></label><!-- 从相关数据获取时间限制 -->
				</div>
				<div id="remindRelevantDiv" style="padding-left:20px">
					<input type="text" id="timeLimit.remindInfo.remindRelevantData" name="timeLimit.remindInfo.remindRelevantData" size="30">
					<div><label for="timeLimit.remindInfo.remindRelevantData"><b:message key="edit_manualact_info_jsp.relevantData"/></label></div><!-- (相关数据中时间限制格式为:3.5.20 表示时间限制为3天5小时20分钟) -->
				</div> 
				<div>  
					<input type="checkbox" id="timeLimit.remindInfo.isSendMessageForRemind" name="timeLimit.remindInfo.isSendMessageForRemind" value="true">
					<label for="timeLimit.remindInfo.isSendMessageForRemind"><b:message key="edit_manualact_info_jsp.isSendMessageForOvertime"/></label><!-- 启用邮件通知 -->
				</div>
			</fieldset>
	  	</div>
	  	
	  	<div id="launcher" style="display:none;margin-top:5px;height:230px">
	  		<input type="radio" id="procStarterLists.processStarterType1"
	  		 name="procStarterLists.processStarterType" value="all" 
	  		 _manipulateFields="processOrgDiv" _model="!sh">
	  		<label for="procStarterLists.processStarterType1">
	  			<b:message key="edit_process_info_jsp.processStarterType1"/>
	  		</label><!-- 任意人员启动 -->
	  		<input type="radio" id="procStarterLists.processStarterType2"
	  		 name="procStarterLists.processStarterType" value="organization-list"  
	  		 _manipulateFields="processOrgDiv" _model="sh">
	  		<label for="procStarterLists.processStarterType2">
	  			<b:message key="edit_process_info_jsp.processStarterType2"/>
	  		</label><!-- 组织机构与角色 -->
	  		<div id="processOrgDiv" style="display:none">
				<r:datacell xpath="json" id="dataCellOrg" width="500" height="180"  allowAdd="true" allowDel="true" pageSize="1000">
					<r:field fieldId="id" fieldName="id" label="<b:message key="edit_manualact_info_jsp.participantID"/>"><h:text/></r:field><!-- 参与者ID -->
					<r:field fieldId="name" fieldName="name" label="<b:message key="edit_autoact_info_jsp.name"/>"><h:text/></r:field><!-- 名称 -->
					<r:field fieldId="type" fieldName="type" label="<b:message key="edit_autoact_info_jsp.type"/>"><h:text/></r:field><!-- 类型 -->
				    <r:toolbar tools="custom,edit:del" location="top"/>
				</r:datacell>
			</div>
	  	</div>
	  	<div id="preferences" style="display:none;margin-top:5px;height:230px">
			<r:datacell xpath="json" id="dataCellProcessParams" width="500" height="220" allowAdd="true" allowDel="true" pageSize="1000">
				<r:field fieldId="pmode" onRefreshFunc="setSelectBoxValue" fieldName="mode" label="<b:message key="edit_autoact_info_jsp.type"/>"></r:field><!-- 类型 -->
				<r:field fieldId="pname" fieldName="name" label="<b:message key="edit_autoact_info_jsp.name"/>"><h:text/></r:field><!-- 名称 -->
				<r:field fieldId="ptypeValue" fieldName="dataType/typeValue" label="<b:message key="edit_autoact_info_jsp.dataType"/>" ><h:text/></r:field><!-- 数据类型 -->
				<r:field fieldId="ptypeClass" onRefreshFunc="setSelectBoxValue2" fieldName="dataType/typeClass" label="<b:message key="edit_autoact_info_jsp.dataClassification"/>" ></r:field><!-- 数据分类 -->
				<r:field fieldId="pisArray" onRefreshFunc="setIsArrayValue" fieldName="isArray" label="<b:message key="edit_process_info_jsp.array"/>"></r:field><!-- 数组 -->
				<r:field fieldId="pdesrciption" fieldName="description" label="<b:message key="edit_autoact_info_jsp.desc"/>"><h:text/></r:field><!-- 描述 -->
			    <r:toolbar tools="edit:add del" location="top"/>
			</r:datacell>
	  	</div> 
	  	<div id="triggerEvent" style="display:none;margin-top:5px;height:230px">
			<r:datacell xpath="json" id="dataCellTrgEvnts" width="500" height="220" allowAdd="true" allowDel="true" pageSize="1000">
				<r:field fieldId="tgeventType" fieldName="eventType" onRefreshFunc="setProcessEventTypeValue" label="<b:message key="edit_autoact_info_jsp.triggerTime"/>"></r:field><!-- 触发时机 -->
				<r:field fieldId="tgapplicationUri" fieldName="applicationInfo/application/applicationUri" onRefreshFunc="setApplicationUriLink" label="<b:message key="edit_autoact_info_jsp.eventAction"/>" ></r:field><!-- 事件动作 -->
				<r:field fieldId="invokePattern" fieldName="applicationInfo/application/invokePattern" onRefreshFunc="setInvokePatternValue" label="<b:message key="edit_autoact_info_jsp.call_mode"/>"></r:field><!-- 调用方式 -->
				<r:field fieldId="transactionType" fieldName="applicationInfo/application/transactionType" onRefreshFunc="setTransactionTypeValue" label="<b:message key="edit_autoact_info_jsp.trans_policy"/>"></r:field><!-- 事务策略 -->
				<r:field fieldId="exceptionStrategy" fieldName="applicationInfo/application/exceptionStrategy" onRefreshFunc="setExceptionStrategyValue" label="<b:message key="edit_autoact_info_jsp.exce_process"/>"></r:field><!-- 异常处理 -->
				<r:field fieldId="tgdescription" fieldName="description" label="<b:message key="edit_autoact_info_jsp.desc"/>描述"><h:text/></r:field><!--  -->
			    <r:toolbar tools="edit:add del,custom" location="top"/>
			</r:datacell>
	  	</div>
	  	<div style="position:relative;display:block;padding-top:20px;padding-bottom:5px">
	            <button class="button" id="processOK"><b:message key="edit_autoact_info_jsp.ok"/></button><!-- 确定 -->
	            <button class="button" id="processCancel"><b:message key="edit_autoact_info_jsp.cancel"/></button><!-- 取消 -->
		</div>
	  </td>
	</tr>
</table> 
   
</form>
	<jsp:include flush="true" page="/workflow/wfmanager/definition/processdef_detail/edit_common.jsp"></jsp:include>
	<script>
			processJson = getProcessOrActivityInfo('processHead');
			//alert(processJson.processHeader.toJSONString());
			//alert(processRender.renderProcess);
			//for(f in processRender){
				//alert('processRender.'+f+'='+processRender[f]);
			//}
			
			//alert(processRender.renderProcess);
 			processRender.renderProcess(processJson.processHeader);
 			
	</script>
</body>
</html>