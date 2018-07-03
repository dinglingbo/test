<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 09:26:10
  - Description:
-->
<head>
<title>新增和编辑</title>
<script src="<%= request.getContextPath() %>/repair/js/DataBase/Item/RepairItemDetail.js?v=1.0.9"></script>
<style type="text/css">
table {
	table-layout: fixed;
	font-size: 12px;
	width: 100%;
}

.form_label {
	width: 60px;
	text-align: right;
}

.mini-panel {
	margin-top: 10px;
	margin-left: 10px;
	margin-right: 10px;
	width: calc(100% - 20px) !important;
}

.required {
	color: red;
}
</style>
</head>
<body>
<div id="basicInfoForm" class="form">
	<input name="id" class="nui-hidden"/>
	<div class="nui-panel" showToolbar="false" title="基本信息" showFooter="false"
		style="width:calc(100% - 20px);">
        <table class="nui-form-table" border=0>
            <tr>
				<td class="form_label required">
					<label>项目名称：</label>
				</td>
				<td>
					<input class="nui-textbox" name="name" width="100%"/>
				</td>
                <td class="form_label required">
                    <label>项目类型：</label>
                </td>
                <td colspan="1">
                    <input class="nui-combobox" name="type" id="type"
                           valueField="customid"
                           textField="name"
                           width="100%"/>
                </td>
            </tr>
            <tr>
                <td class="form_label required">
                    <label>项目编码：</label>
                </td>
                <td colspan="1">
                    <input class="nui-textbox" name="code" width="100%"/>
                </td>
                
                <td class="form_label required">
                    <label>工种：</label>
                </td>
                <td colspan="1">
                    <input class="nui-combobox" name="itemKind" id="itemKind"
                           valueField="customid"
                           textField="name"
                           width="100%"/>
                </td>
            </tr>
            <tr>
                <td class="form_label">
                    <label>品牌：</label>
                </td>
                <td>
                    <input class="nui-combobox" name="carBrandId" id="carBrandId"
                           valueField="id"
                           textField="nameCn"
                           onValuechanged="initCarModel('carModelId', e.value)"
                           width="100%"/>
                </td>
                <td class="form_label">
                    <label>车型：</label>
                </td>
                <td>
                    <input class="nui-combobox" name="carModelId" id="carModelId"
                           valueField="carModelId"
                           textField="carModel"
                           width="100%"/>
                </td>
            </tr>
        </table>
	</div>
	<div class="nui-panel" showToolbar="false" title="工时价格信息" showFooter="false"
		 style="width:calc(100% - 20px);">
		<table class="nui-form-table" border=0>
			<tr>
				<td class="form_label">
					<label>标准工时：</label>
				</td>
				<td colspan="1">
					<input class="nui-spinner"
						   name="itemTime"
						   format="0.00"
						   value="0" maxValue="1000000000"
						   changeOnMousewheel="true" showButton="false"
						   width="100%" inputStyle="text-align:right;"/>
				</td>
				<td class="form_label">
					<label>工时单价：</label>
				</td>
				<td colspan="1">
					<input class="nui-spinner" name="unitPrice" format="0.00" value="0" maxValue="1000000000"
						   changeOnMousewheel="true" showButton="false" width="100%" inputStyle="text-align:right;"/>
				</td>
			</tr>
            <tr>
				<td class="form_label">
					<label>成本定义：</label>
				</td>
				<td colspan="1">
					<input class="nui-combobox" name="costDef" id="costDef"
							   valueField="id"
							   textField="nameCn"
							   width="100%"/>
				</td>
				<td class="form_label">
					<label>成本参数：</label>
				</td>
				<td colspan="1">
					<input class="nui-spinner" name="unitPrice" format="0.00" value="0" maxValue="1000000000"
						   changeOnMousewheel="true" showButton="false" width="100%" inputStyle="text-align:right;"/>
				</td>
			</tr>
			<tr>
				<td class="form_label">
					<label>工时金额：</label>
				</td>
				<td colspan="1">
					<input class="nui-spinner" name="amt" format="0.00" value="0" maxValue="1000000000"
						   changeOnMousewheel="true" showButton="false" width="100%" inputStyle="text-align:right;"/>
				</td>
			</tr>
            <!--
			<tr>
				<td class="form_label">
					<label>提成金额：</label>
				</td>
				<td colspan="1">
					<input class="nui-spinner" name="deductAmt" format="0.00" value=" " maxValue="1000000000"
						   changeOnMousewheel="true" showButton="false" width="100%" inputStyle="text-align:right;"/>
				</td>
			</tr>
            -->
		</table>
	</div>
</div>
<div style="text-align:center;padding:10px;">
	<a class="nui-button" onclick="onOk" style="width:60px;margin-right:20px;">确定</a>
	<a class="nui-button" onclick="onCancel" style="width:60px;">取消</a>
</div>
		
	
</body>
</html>