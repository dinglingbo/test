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
	  //formFieldsData.renderField(fieldJson);
	}
</script>
</head>
<body style="background:#FFFFFF;margin-top:0px;margin-left:0px;margin-buttom:0px;overflow: auto;" onload="init();sizeDialog()">
	<table id="tLayout"  width="100%" border="0" cellpadding="0" cellspacing="0" class="workarea">
		<tr>
			<td class="workarea_title" valign="middle"> 
				<font color="#000033" class="title_font"><b:message key="edit_startact_info_jsp.edit_trigger_event_info"/></font><!-- 编辑触发事件详细信息 -->
			</td>
		</tr>
		<tr>
			<td>
				<div>
					<fieldset>
						 <legend><b:message key="edit_manualact_info_jsp.cfgInfo"/></legend><!-- 配置信息 -->
						 
					</fieldset>
				</div>
				<div style="position:relative;display:block;padding-top:20px;padding-bottom:5px">
			            <button class="button" id="activityOK"><b:message key="edit_finishact_info_jsp.ok"/></button><!-- 确定 -->
			            <button class="button" id="activityCancel"><b:message key="edit_finishact_info_jsp.cancel"/></button><!-- 取消 -->
				</div>
			</td>
		</tr>
	</table>
</body>
</html>