<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 23:05:24
  - Description:
-->
<head>
<title>jsp auto create</title>
<script src="<%= request.getContextPath() %>/baseData/js/partMgr/partDetail.js?v=1.0.0"></script>
<style type="text/css">
html,body {
	margin: 0;
	padding: 0;
	border: 0;
	width: 100%;
	height: 100%;
	overflow: hidden;
}

.row {
	margin-top: 5px;
}

.width1 {
	width: 100px;
}

.width2 {
	width: 145px;
}

.width3 {
	width: 290px;
}

.width4 {
	width: 544px;
}

.width5 {
	width: 330px;
}

.width6 {
	width: 250px;
}

.title {
	text-align: right;
	display: inline-block;
}

.title-width1 {
	width: 60px;
}

.title.required {
	color: red;
}
</style>
</head>
<body>
	<div class="nui-fit" style="padding: 10px; overflow: hidden;">
		<span>基本信息</span>
		<div id="basicInfoForm" class="form">
			<input class="nui-hidden" name="id" />
			<div class="row">
				<span class="title title-width1 required">配件品质：</span> <input
					name="qualityTypeId" class="nui-combobox width1" textField="text"
					valueField="id" emptyText="请选择..." url="" allowInput="true"
					showNullItem="true" nullItemText="请选择..." /> <span
					class="title title-width1 required">名称：</span> <input name="name"
					class="nui-combobox width2" textField="text" valueField="id"
					emptyText="请选择..." url="" allowInput="true" showNullItem="true"
					nullItemText="请选择..." /> <span class="title required">编码：</span> <input
					name="code" class="nui-textbox width2" /> <span
					class="title required">单位：</span> <input name="unit"
					class="nui-combobox width1" textField="text" valueField="id"
					emptyText="请选择..." url="" allowInput="true" showNullItem="true"
					nullItemText="请选择..." />
			</div>
			<div class="row">
				<span class="title title-width1 required">配件品牌：</span> <input
					name="partBrandId" class="nui-combobox width1" textField="text"
					valueField="id" emptyText="请选择..." url="" allowInput="true"
					showNullItem="true" nullItemText="请选择..." /> <span
					class="title title-width1 required">ABC分类：</span> <input
					name="abcType" class="nui-combobox width2" textField="text"
					valueField="id" emptyText="请选择..." url="" allowInput="true"
					showNullItem="true" nullItemText="请选择..." /> <span class="title">型号：</span>
				<input name="xxxxx" class="nui-textbox width3" />
			</div>
			<div class="row">
				<span class="title title-width1 required">适用车型：</span> <input
					name="applyCarModel" class="nui-combobox width1" textField="text"
					valueField="id" emptyText="请选择..." url="" allowInput="true"
					showNullItem="true" nullItemText="请选择..." /> <input name="xxxxx"
					class="nui-textbox width4" />
			</div>
			<div class="row">
				<span class="title title-width1">通用编码：</span> <input
					name="commonCode" class="nui-textbox width5" /> <span
					class="title title-width1">规格：</span> <input name="spec"
					class="nui-textbox width6" />
			</div>
			<div class="row">
				<span class="title title-width1">配件全称：</span> <input name="fullName"
					class="nui-textbox width5" /> <span class="title title-width1">生产厂家：</span>
				<input name="produceFactory" class="nui-textbox width6" />
			</div>
		</div>
	</div>


</body>
</html>
