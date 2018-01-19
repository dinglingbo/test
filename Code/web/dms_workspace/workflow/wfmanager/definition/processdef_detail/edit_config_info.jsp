<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
<head>
	<script>
	
		function init () {
			 appInfo = window["dialogArguments"] ; 
			 //alert(appInfo);
			 AppConfiguration.renderAppConfg(appInfo);
		}
		deepEntity(true);

		
	</script>
<script src="<%=request.getContextPath()%>/workflow/wfmanager/definition/js/new-activity-api.js" language="javascript"></script>
<script src="<%=request.getContextPath()%>/workflow/wfmanager/definition/js/i18n/message.js" i18n="true"/>
<script src="<%=request.getContextPath()%>/workflow/wfmanager/definition/js/json.js" language="javascript"></script>
	<title></title>

</head>
<body style="background:#FFFFFF;margin-top:0px;margin-left:0px;margin-buttom:0px;overflow: hidden;" onload="init();sizeDialog()">
	<form name="">
		<table id="tLayout" border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%" height="100%">
				<tr>
					<td class="workarea_title" valign="middle"><font color="#000033" class="title_font"><b:message key=""/></font></td><!-- 获取规则逻辑 -->
				</tr>
				<tr>
					<td>
						<div>
							<fieldset>
								<legend><b:message key="edit_autoact_info_jsp.confInfo"/></legend><!-- 配置信息 -->
								<div>
										<label for="actionType"><b:message key="edit_autoact_info_jsp.eventType"/></label><!-- 事件类型 -->
										<select id="actionType" name="actionType">
										
											<%
												String product=com.eos.system.ServerContext.getInstance().getProductFamily();
											    if(product.equals("Primeton EOS")){ %>
												<option value="service-component"><b:message key="edit_autoact_info_jsp.service"/></option><!-- 服务 -->
												<option value="logic-flow"><b:message key="edit_autoact_info_jsp.logicFlow"/></option><!-- 逻辑流 -->
											<%} %>
											<option value="pojo"><b:message key="edit_autoact_info_jsp.arithmeticLogic"/></option><!-- 运算逻辑 -->
										</select>
								</div>
								<div>
							     <label for="applicationUri"><b:message key="edit_autoact_info_jsp.eventAction"/></label><!-- 事件动作 -->
							     <input type="text" id="applicationUri" name="applicationUri" size="35">
								     <div id="errorMsg" style="display:none;padding-left:60px">
								     	<font color="red" size="9px"><b:message key="edit_autoact_info_jsp.eventActionError"/></font><!-- 事件动作不是一个正确的URI! -->
								     </div>
								</div>
							</fieldset> 
							<div>
								<label><b:message key="edit_autoact_info_jsp.paramConftable"/></label><!-- 参数配置表 -->
								<r:datacell xpath="json" id="dataCellConfigParams" width="500" height="180" allowAdd="true" allowDel="true" pageSize="1000">
									<r:field fieldId="mode" onRefreshFunc="setSelectBoxValue" fieldName="mode" label="<b:message key="edit_autoact_info_jsp.type"/>"></r:field><!-- 类型 -->
									<r:field fieldId="name" fieldName="name" label="<b:message key="edit_autoact_info_jsp.name"/>"><h:text/></r:field><!-- 名称 -->
									<r:field fieldId="dataType/typeValue" fieldName="dataType/typeValue" label="<b:message key="edit_autoact_info_jsp.dataType"/>" ><h:text/></r:field><!-- 数据类型 -->
									<r:field fieldId="dataType/typeClass" onRefreshFunc="setSelectBoxValue2" fieldName="dataType/typeClass" label="<b:message key="edit_autoact_info_jsp.dataClassification"/>" ></r:field><!-- 数据分类 -->
									<r:field fieldId="value" fieldName="value" label="<b:message key="edit_autoact_info_jsp.value"/>"><h:text/></r:field><!-- 值 -->
									<r:field fieldId="valueType" fieldName="valueType" label="<b:message key="edit_autoact_info_jsp.valueType"/>" ><select><option value="variable" selected><b:message key="edit_autoact_info_jsp.variable"/></option><option value="constant"><b:message key="edit_autoact_info_jsp.constant"/></option></select></r:field><!-- 值类型 --><!-- 变量 --><!-- 常量 -->
									<r:field fieldId="fillBack" onRefreshFunc="setCheckboxValue" fieldName="fillBack" label="<b:message key="edit_autoact_info_jsp.backfillRelatedData"/>"></r:field><!-- 回填相关数据 -->
									<r:toolbar tools="edit:add del" location="top"/>
								</r:datacell>
							</div>
						</div>
						 <div style="padding-top:10px">
							<input type="button" name="activityOK" id="activityOK" value="<b:message key="edit_autoact_info_jsp.ok"/>" class="button"><!-- 确定 -->
							<button class="button" id="activityCancel"><b:message key="edit_autoact_info_jsp.cancel"/></button><!-- 取消 -->
				        </div>
					</td>
				</tr>
		</table>
	</form>
</body>
</html>
