<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-04-23 11:00:21
  - Description:
-->
<%
	//String contextPath = request.getContextPath();
%>
<head>
<title>应收账款管理</title>
<%@include file="/common/sysCommon.jsp"%>
<link
	href="<%=webPath + contextPath%>/css/style1/style_form_edit.css?v=1.1"
	rel="stylesheet" type="text/css" />
<script src="<%=webPath + contextPath%>/frm/js/arap/receive.js?v=1.0"
	type="text/javascript"></script>

</head>
<body>
	<form id="form1" method="post">
	
		<fieldset style="border: solid 1px #aaa; padding: 3px;">
			<legend>业务单据信息</legend>
			<div style="padding: 5px;">
				<input class="nui-hidden"name="id">
				<table>
					<tr>
						<td class="title" style="width: 100px;">客户名称：</td>
						<td colspan="3"><input class="nui-textbox"  enabled="false" name="guestFullName"
							style="width: 440px;" /></td>
					</tr>

					<tr>
						<td class="title">工单号：</td>
						<td><input class="nui-textbox width2M"  enabled="false"name="serviceCode"/></td>
						<td class="title">应收金额：</td>
						<td style="width: 100px;"><input class="nui-textbox"  name="rpAmt"
							enabled="false" /></td>
					</tr>
					<tr>
						<td class="title">本单结转人：</td>
						<td><input class="nui-textbox width2M"  enabled="false" name="recorder"/></td>
						<td class="title">已收金额：</td>
						<td><input class="nui-textbox"  enabled="false" name="rpAmtNo" /></td>
					</tr>
					<tr>
						<td class="title">本单结转日期：</td>
						<td><input class="nui-datepicker width2M" enabled="false" name="recordDate"  format="yyyy-MM-dd HH:mm"/></td>
						<td class="title">未收金额：</td>
						<td><input class="nui-textbox"  enabled="false" name="rpAmtYes"/></td>
					</tr>

				</table>
			</div>
		</fieldset>
		<fieldset style="border: solid 1px #aaa; padding: 3px;">
			<legend>担保信息</legend>
			<div style="padding: 5px;">
			<table>
				<tr>
					<td class="title" style="width: 100px;" >担保方式：</td>
					<td><input name="onAccountType" class="nui-combobox"
						data="mentt" /></td>
					<td class="title">担保人：</td>
					<td><input id="guarantee" name="onAccountSurety" 
						class="nui-combobox" textField="empName"
                    	valueField="empId"
						/></td>
				</tr>
				<tr>
				<td class="title">担保备注：</td>
				<td colspan="3"><input name="remark" class="nui-textarea"
					required="true" style="margin-top: 20px; width: 440px;" />
				</td>
				</tr>
				</table>
			</div>
		</fieldset>
		<div style="text-align:center;padding:10px;">
	        <a class="nui-button" onclick="onOk" style="width:60px;">确定(O)</a>
	        <a class="nui-button" onclick="onCancel" style="width:60px;">取消(C)</a>
        </div>
	</form>
</body>
</html>