<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
<head>
<script src="<%=request.getContextPath()%>/workflow/wfmanager/definition/js/new-activity-api.js" language="javascript"></script>
<script src="<%=request.getContextPath()%>/workflow/wfmanager/definition/js/i18n/message.js" i18n="true"/>
	<title></title>
</head> 
<body style="background:#FFFFFF;margin-top:0px;margin-left:0px;margin-buttom:0px;overflow: auto;" onload="sizeDialog()">
<form name="startActForm">
	
   <table id="tLayout" width="100%" border="0" cellpadding="0" cellspacing="0" class="workarea">
   	<tr>
		<td colspan="3" class="workarea_title" valign="middle">
			<font color="#000033" class="title_font"><b:message key="edit_finishact_info_jsp.endActivityDetail"/></font><!-- 结束活动详细信息 -->
		</td>
	</tr>
	<tr>
	  <td width="100" valign="top" style="padding-top:8px;padding-left:5px;">
	  	 <div>
	  	 	<label><b:message key="edit_finishact_info_jsp.setOption"/></label><!-- 设置选项 -->
	  	 </div>
	  	 <div>
			 <select onChange="showDivInfo('proItem',this.options[this.selectedIndex].value);sizeDialog()" name="proItem" multiple="multiple" size="12" style="width:100px;">
				<option value="basedInfo"><b:message key="edit_finishact_info_jsp.basicInfo"/></option><!-- 基本信息 -->
				<option value="startStrategy"><b:message key="edit_finishact_info_jsp.startPolicy"/></option><!-- 启动策略 -->
			 </select>
		</div>
	  </td>
	   <td width="10px" style="repeat-y 50%;"></td>
		<td valign="top" style="padding-top:10px;"> 
	  	<div id="basedInfo" style=" display:inline; margin-top:5px;height:200px">
		  	   <fieldset>
		  	   		<legend><b:message key="edit_finishact_info_jsp.basicProperties"/></legend><!-- 基本属性 -->
		  	   		<div>
		  	   			<label for="activityId"><b:message key="edit_finishact_info_jsp.activityID"/></label><!-- 活动ID -->
		  	   			 <div style="display:inline;padding-left:14px">
		  	   				<input type="text" id="activityId" name="activityId" size="30" readonly="true">
		  	   			 </div>
		  	   		</div>
		  	   		<div>
		  	   			<label for="activityName"><b:message key="edit_finishact_info_jsp.activityName"/></label><!-- 活动名称 -->
		  	   			<input type="text" id="activityName" name="activityName" size="30">
		  	   		</div>
		  	   		<div>
		  	   					<label for="joinType"><b:message key="edit_finishact_info_jsp.aggregationModel"/></label><!-- 聚合模式 -->
		  	   					<select id="joinType" name="joinType">
				  	   				<option value="AND"><b:message key="edit_finishact_info_jsp.allAggregation"/></option><!-- 全部聚合 -->
				  	   				<option value="XOR"><b:message key="edit_finishact_info_jsp.singleAggregation"/></option><!-- 单一聚合 -->
				  	   				<option value="OR"><b:message key="edit_finishact_info_jsp.multipleAggregation"/></option><!-- 多路聚合 -->
				  	   			</select>
		  	   		</div>
		  	   		<div>
		  	   				<label for="description"><b:message key="edit_finishact_info_jsp.desc"/></label><!-- 描述 -->
		  	   				<div style="display:inline;padding-left:24px">
		  	   					<textarea id="description" name="description" rows="6" cols="45" onMouseMove="textCounter(this,200);" onkeydown="textCounter(this,200);" onkeyup="textCounter(this,200);"></textarea>
		  	   				</div>
		  	   		</div>
		  	  </fieldset>
		  	 </div>
		  	 <div id="startStrategy" style="display:none;height:200px">
			  		<fieldset>
			  					<legend><b:message key="edit_finishact_info_jsp.activationRule"/></legend><!-- 激活规则 -->
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
			  							<input type="text" id="activateRule.applicationInfo.application.applicationUri" name="activateRule.applicationInfo.application.applicationUri" readonly size="45">
			  							<label for="btnActivateRuleConfig"></label><input type="button" id="btnActivateRuleConfig" size="45" value="<b:message key="edit_finishact_info_jsp.browse"/>" class="button"><!-- 浏览... -->
			  							<div style="display:block">
			  								<label><b:message key="edit_finishact_info_jsp.note"/></label><!-- 注:激活规则确定该活动在流程转至此时将以何种方式激活，规则逻辑返回值为1或true时均可直接激活，返回值为0或false时为待激活 -->
			  							</div>	
			  					</div> 
			  			</fieldset>
			  </div>
			   <div style="position:relative;display:block;padding-top:20px;padding-bottom:5px">
			            <button class="button" id="activityOK"><b:message key="edit_finishact_info_jsp.ok"/></button><!-- 确定 -->
			            <button class="button" id="activityCancel" onClick="closeWindows()"><b:message key="edit_finishact_info_jsp.cancel"/></button><!-- 取消 -->
				</div>
	  </td>
	</tr>
</table> 
</form>
		<jsp:include flush="true" page="/workflow/wfmanager/definition/processdef_detail/edit_common.jsp"></jsp:include>
		<script>
 				finishActivity.finishSubActivity(actJson.activity);
		</script>
</body>
</html>