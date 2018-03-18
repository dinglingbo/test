<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-31 14:21:19
  - Description:
-->
<head>
<title>新增车系</title>
<script src="<%= request.getContextPath() %>/repair/js/DataBase/Brand/CarSeriesDetail.js?v=1.0.1"></script>
<style type="text/css">
table {
	table-layout: fixed;
	font-size: 12px;
}

.form_label {
	width: 60px;
	text-align: right;
}
</style>
</head>
<body>
<fieldset style="width: 95%; height: 65%; border: solid 1px #aaa; position: relative; margin: 5px 5px;">
	<div id="dataform1" class="form">
		<input name="id" class="nui-hidden"/>
		<input name="carBrandId" class="nui-hidden"/>
		<table class="nui-form-table" style="width:100%;">
			<tr>
				<td class="form_label">
					<label>品牌：</label>
				</td>
				<td colspan="1">
					<input class="nui-textbox" name="carBrandName" width="100%" enabled="false"/>
				</td>
			</tr>
			<tr>
				<td class="form_label">
					<label>厂商：</label>
				</td>
				<td colspan="1">
					<input class="nui-textbox" name="carFactoryName"  width="100%"/>
				</td>
			</tr>
			<tr>
				<td class="form_label">
					<label>车系名称：</label>
				</td>
				<td colspan="1">
					<input class="nui-textbox" name="name" width="100%"/>
				</td>
			</tr>
			<tr>
				<td class="form_label">
					<label>备注：</label>
				</td>
				<td colspan="1">
					<input class="nui-textbox" name="remark"  width="100%"/>
				</td>
			</tr>
		</table>
	</div>
</fieldset>
<div style="text-align: right; padding: 10px;">
	<a class="nui-button" onclick="onOk" style="margin-right: 20px;">保存</a>
	<a class="nui-button" onclick="onCancel">取消</a>
</div>


</body>
</html>