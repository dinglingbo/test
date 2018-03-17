<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-29 15:58:11
  - Description:
-->
<head>
<title>编辑保险公司</title>
<script src="<%= request.getContextPath() %>/repair/js/DataBase/Insurance/InsuranceDetail.js?v=1.0.2"></script>
<style type="text/css">
table {
	table-layout: fixed;
	font-size: 12px;
	width: 100%;
}

.form_label {
	width: 90px;
	text-align: right;
}

.required {
	color: red;
}
</style>
</head>
<body>
<div id="basicInfoForm" class="nui-form" style="padding-top:5px;">
	<input name="id" class="nui-hidden"/>
	<table class="nui-form-table">
		<tr>
			<td class="form_label required">
				<label>保险公司代码：</label>
			</td>
			<td colspan="1">
				<input class="nui-textbox" name="code" width="100%"/>
			</td>
		</tr>
		<tr>
			<td class="form_label required">
				<label>保险公司名称：</label>
			</td>
			<td colspan="1">
				<input class="nui-textbox" name="fullName" width="100%"/>
			</td>
		</tr>
		<tr>
			<td class="form_label">
				<label>保险公司缩写：</label>
			</td>
			<td colspan="1">
				<input class="nui-textbox" name="shortName" width="100%"/>
			</td>
		</tr>
		<tr>
			<td class="form_label">
				<label>保险公司拼音：</label>
			</td>
			<td colspan="1">
				<input class="nui-textbox" name="pyName" width="100%"/>
			</td>
		</tr>
		<tr>
			<td class="form_label">
				<label>联系人：</label>
			</td>
			<td colspan="1">
				<input class="nui-textbox" name="contactor" width="100%"/>
			</td>
		</tr>
		<tr>
			<td class="form_label">
				<label>联系人电话：</label>
			</td>
			<td colspan="1">
				<input class="nui-textbox" name="contactorTel" width="100%"/>
			</td>
		</tr>
		<tr>
			<td class="form_label">
				<label>排序号：</label>
			</td>
			<td colspan="1">
				<input class="nui-spinner" name="orderIndex" minValue="0" maxVlaue="1000000000" width="100%" inputStyle="text-align:right;"/>
			</td>
		</tr>
	</table>
</div>
<div style="text-align:center;padding:10px;">
	<a class="nui-button" onclick="onOk" style="width:60px;margin-right:20px;">确定</a>
	<a class="nui-button" onclick="onCancel" style="width:60px;">取消</a>
</div>

</body>
</html>