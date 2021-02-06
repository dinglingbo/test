<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-03 11:09:20
  - Description:
-->
<head>
<title>维修材料录入</title>
<script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/Reception/subpage/addEditMaterial.js?v=1.0.2"></script>
<style type="text/css">
.form_label {
	width: 72px;
	text-align: right;
}

.required {
	color: red;
}
</style>

</head>
<body>
<div id="basicInfoForm" class="form">
	<input class="nui-hidden" name="serviceId"/>
	<input class="nui-hidden" name="partId" id="partId"/>
	<input class="nui-hidden" name="partCode" id="partCode"/>
	<input class="nui-hidden" name="partNameId" id="partNameId"/>
	<input class="nui-hidden" name="partBrandId" id="partBrandId"/>
	<input class="nui-hidden" name="unit" id="unit"/>
	<input class="nui-hidden" name="rate"/>
	<table>
		<tr>
			<td class="form_label required">
				<label>零件名称：</label>
			</td>
			<td colspan="5">
				<input class="nui-buttonedit" onclick="selectPartName" id="partName" name="partName" width="100%"/>
			</td>
		</tr>
		<tr>
			<td class="form_label">
				<label>收费类型：</label>
			</td>
			<td>
				<input class="nui-combobox" id="receTypeId" name="receTypeId"
					   valueField="customid" textField="name"
					   allowInput="false"/>
			</td>
			<td class="form_label">
				<label>项目进程：</label>
			</td>
			<td>
				<input class="nui-combobox" name="status" enabled="false" value="1"
					   data="[{id:0,text:'在报价'},{id:1,text:'在维修'}]"
					   allowInput="false"/>
			</td>
		</tr>
		<tr>
			<td class="form_label">
				<label>数量：</label>
			</td>
			<td>
				<input class="nui-spinner" name="qty" id="qty" format="0.00"
					   allowNull="false" value="1"
					   showButton="false" style="text-align:right"
					   minValue="0" maxValue="100000000"/>
			</td>
			<td class="form_label">
				<label>单价：</label>
			</td>
			<td>
				<input class="nui-spinner" name="unitPrice" id="unitPrice" format="0.00"
					   allowNull="false"
					   showButton="false" style="text-align:right"
					   minValue="0" maxValue="100000000"/>
			</td>
			<td class="form_label">
				<label>金额：</label>
			</td>
			<td>
				<input class="nui-spinner" name="amt" id="amt" format="0.00"
					   allowNull="false"
					   showButton="false" style="text-align:right"
					   minValue="0" maxValue="100000000"/>
			</td>
		</tr>
		<tr>
			<td class="form_label">
				<label>备注：</label>
			</td>
			<td colspan="5">
				<input class="nui-textbox" id="data" width="100%"/>
			</td>
		</tr>
	</table>
</div>
<div style="text-align:right;padding:10px;margin-top:0">
	<a class="nui-button" onclick="preItem">上一条</a>
	<a class="nui-button" onclick="nextItem">下一条</a>
	<a class="nui-button" onclick="addItem" id="addBtn" visible="false">继续添加</a>
	<a class="nui-button" onclick="onOk">保存</a>
	<a class="nui-button" onclick="onCancel">关闭</a>
</div>
</body>
</html>