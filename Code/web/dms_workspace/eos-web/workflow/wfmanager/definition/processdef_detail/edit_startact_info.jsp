<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<%@ taglib uri="http://eos.primeton.com/tags/bean" prefix="b"%>
<html>
<head>
<script src="<%=request.getContextPath()%>/workflow/wfmanager/definition/js/new-activity-api.js" language="javascript"></script>
<script src="<%=request.getContextPath()%>/workflow/wfmanager/definition/js/i18n/message.js" i18n="true"/>
<script src="<%=request.getContextPath()%>/workflow/wfmanager/definition/js/json.js" language="javascript"></script>

<title><b:message key="edit_startact_info_jsp.startActDetails"/></title><!-- 开始活动详细信息 -->
</head>
<body style="background:#FFFFFF;margin-top:0px;margin-left:0px;margin-buttom:0px;overflow: auto;">
<form name="startActForm">
   <table id="tLayout"  width="100%" border="0" cellpadding="0" cellspacing="0" class="workarea">
   	<tr>
			<td colspan="3" class="workarea_title" valign="middle"> 
				<font color="#000033" class="title_font"><b:message key="edit_startact_info_jsp.startActDetails"/></font><!-- 开始活动详细信息 -->
			</td>
		</tr>
		<tr>
		  <td width="100" valign="top" style="padding-top:8px;padding-left:5px;">
			    <div>
			  		<label><b:message key="edit_startact_info_jsp.optionSet"/></label><!-- 选项设置 -->
			  	</div>
			  	<div>
			  		<select onChange="showDivInfo('proItem',this.options[this.selectedIndex].value);sizeDialog()" id="proItem" name="proItem" size="12" style="width:100px;">
							<option value="basedInfo"><b:message key="edit_autoact_info_jsp.basic_info"/></option><!-- 基本信息 -->	
							<option value="startForm"><b:message key="edit_startact_info_jsp.startForm"/></option><!-- 启动表单 -->
					 </select>
			  	</div>
		   <td width="10px" style="repeat-y 50%;"></td>
		  <td valign="top" style="padding-top:10px;"> 
		  		<div id="basedInfo" style="height:210px">
					<fieldset>
			 		 	<legend><b:message key="edit_autoact_info_jsp.basic_attr"/></legend><!-- 基本属性 -->
				 		 	<div>
				 		 		<label for="activityId"><b:message key="edit_autoact_info_jsp.act_id"/></label><!-- 活动ID: -->
				 		 		<div style="display:inline;padding-left:11px">
				 		 			<input type="text" class="textbox" id="activityId" name="activityId" size="45" readonly="readonly">
				 		 		</div>
				 		 	</div>
				 		 	<div>
				 		 		<label for="activityName"><b:message key="edit_autoact_info_jsp.act_name"/></label><!-- 活动名称: -->
				 		 		<input type="text" class="textbox" id="activityName" name="activityName" size="45" >
				 		 	</div>
				 		 	<div>
				 		 		<label for="splitType"><b:message key="edit_autoact_info_jsp.branch_mode"/></label><!-- 分支模式: -->
				 		 		<select id="splitType" name="splitType">
				 		 				<option value="AND"><b:message key="edit_autoact_info_jsp.all_branch"/></option><!-- 全部分支 -->
			 		 					<option value="XOR"><b:message key="edit_autoact_info_jsp.single_branch"/></option><!-- 单一分支 -->
			 		 					<option value="OR"><b:message key="edit_autoact_info_jsp.multi_branch"/></option><!-- 多路分支 -->
				 		 		</select>
				 		 	</div>
				 		 	<div>
			 		 			<label for="description"><b:message key="edit_autoact_info_jsp.desc"/></label><!-- 描述: -->
			 		 			<div style="display:inline;padding-left:25px">
			 		 				<textarea id="description" name="description" rows="6" cols="45" onMouseMove="textCounter(this,200);" onkeydown="textCounter(this,200);" onkeyup="textCounter(this,200);"></textarea>
			 		 			</div>
				 		 	</div>
			 		 </fieldset>		 
				</div>    
				<div id="startForm" style="display:none;height:210px">
					<r:datacell xpath="json" id="datacell1" width="450" height="200"  allowAdd="true" allowDel="true" pageSize="1000">
						<r:field fieldId="name" fieldName="name" label="<b:message key="edit_manualact_info_jsp.displayName"/>"><h:text/></r:field><!-- 显示名称 -->
						<r:field fieldId="path" fieldName="path" label="<b:message key="edit_manualact_info_jsp.relatedDatapath"/>"><h:text/></r:field><!-- 相关数据路径 -->
						<r:field fieldId="dataType" fieldName="dataType" onRefreshFunc="setFormDataTypeValue" label="<b:message key="edit_autoact_info_jsp.type"/>"></r:field><!-- 类型 -->
						<r:field fieldId="required" fieldName="required" onRefreshFunc="setFormRequiredValue" label="<b:message key="edit_manualact_info_jsp.isNecessary"/>"></r:field><!-- 是否必需 -->
						<r:field fieldId="defaultValue" fieldName="defaultValue" label="<b:message key="edit_manualact_info_jsp.defaultValue"/>"><h:text/></r:field><!-- 默认值 -->
						<r:field fieldId="accessType" fieldName="accessType" onRefreshFunc="setFormAccessTypeValue"  label="<b:message key="edit_manualact_info_jsp.visitMethod"/>"></r:field><!-- 访问方法 -->
						<r:field fieldId="description" fieldName="description" label="<b:message key="edit_manualact_info_jsp.desc"/>"><h:text/></r:field><!-- 描述 -->
					    <r:toolbar tools="edit:add del,custom" location="top"/>
					</r:datacell>
				</div>
				<div style="position:relative;display:block;padding-top:20px;padding-bottom:5px">
			            <button class="button" id="activityOK"><b:message key="edit_finishact_info_jsp.ok"/></button><!-- 确定 -->
			            <button class="button" id="activityCancel"><b:message key="edit_finishact_info_jsp.cancel"/></button><!-- 取消 -->
				</div>
			</td>
		</tr>
	</table> 
</form>
		<jsp:include flush="true" page="/workflow/wfmanager/definition/processdef_detail/edit_common.jsp"></jsp:include>
		<script>
				startActivity.renderStartActivity(actJson.activity);
		</script>
</body>
</html>