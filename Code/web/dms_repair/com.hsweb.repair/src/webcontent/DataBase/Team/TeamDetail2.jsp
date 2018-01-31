<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-30 15:46:03
  - Description:
-->
<head>
<title>Title</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>

</head>
<style type="text/css">
body {
	padding: 10px;
}

.title {
	/*text-align: right;*/
	display: inline-block;
}

.title-width1 {
	width: 60px;
}

.required {
	color: red;
}

.row {
	margin-top: 5px;
}

.width1 {
	width: 240px;;
}
</style>
</head>
<body>

	<div id="basicInfoForm" class="form">
		<input class="nui-hidden" name="id" /> <input class="nui-hidden"
			name="parentId" />
		<div class="row">
			<span class="title title-width1 required">品牌编码：</span> <input
				name="code" class="nui-textbox width1" />
		</div>
		<div class="row">
			<span class="title title-width1 required">品牌名称：</span> <input
				name="name" class="nui-textbox width1" />
		</div>
		<div class="row">
			<span class="title title-width1">生产厂家：</span> <input
				name="manufacture" class="nui-textbox width1" />
		</div>
		<div class="row">
			<span class="title title-width1">备注：</span> <input name="remark"
				class="nui-textbox width1" />
		</div>
	</div>
	<div style="text-align: center; padding: 10px;">
		<a class="mini-button" onclick="onOk"
			style="width: 60px; margin-right: 20px;">确定</a> <a
			class="mini-button" onclick="onCancel" style="width: 60px;">取消</a>
	</div>

</body>
</html>