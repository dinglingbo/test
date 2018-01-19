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
	  var fieldJson = window["dialogArguments"] ;
	  //alert(fieldJson);
	  formFieldsData.renderField(fieldJson);
	}
</script>
</head>
<body style="background:#FFFFFF;margin-top:0px;margin-left:0px;margin-buttom:0px;overflow: auto;" onload="init();sizeDialog()">
	<table id="tLayout"  width="100%" border="0" cellpadding="0" cellspacing="0" class="workarea">
		<tr>
			<td class="workarea_title" valign="middle"> 
				<font color="#000033" class="title_font"><b:message key="edit_startact_info_jsp.propertySet"/></font><!-- 属性设置 -->
			</td>
		</tr>
		<tr>
			<td align="center">
				<div id="extrDiv">
					<r:datacell xpath="json" id="datacell2" width="260" height="200" allowAdd="true" allowDel="true" pageSize="1000">
						<r:field fieldId="option" fieldName="option" label="<b:message key="edit_startact_info_jsp.property"/>" align="center" width="130"><h:text/></r:field><!-- 属性 -->
						<r:field fieldId="value" fieldName="value" label="<b:message key="edit_autoact_info_jsp.value"/>" align="center" width="130"><h:text/></r:field><!-- 值 -->
					    <r:toolbar tools="edit:add del" location="top"/>
					</r:datacell>
				</div>
				<div style="position:relative;display:block;padding-top:20px;padding-bottom:5px">
			            <button class="button" id="activityOK"><b:message key="edit_autoact_info_jsp.ok"/></button><!-- 确定 -->
			            <button class="button" id="activityCancel"><b:message key="edit_autoact_info_jsp.cancel"/></button><!-- 取消 -->
				</div>
			</td>
		</tr>	
	</table>
</body>
</html>