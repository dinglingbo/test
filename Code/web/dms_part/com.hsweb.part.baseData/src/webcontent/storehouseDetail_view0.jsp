<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 09:08:33
  - Description:
-->
<head>
<title>jsp auto create</title>
<script src="<%= request.getContextPath() %>/baseData/js/storehouseMgr/storehouseDetail.js?v=1.0.3"></script>
<style type="text/css">
.row {
	margin-top: 5px;
}

.width1 {
	width: 145px;
}

.title {
	text-align: right;
	display: inline-block;
}

.title-width2 {
	width: 75px;
}

.title.required {
	color: red;
}
</style>
</head>
<body>

<div title="车型规格分类" class="nui-panel" style="width:calc(100% - 20px);height:150px;margin: 10px;"
     onbuttonclick="onbuttonclick">
    <div id="basicInfoForm" class="form">
        <input class="nui-hidden" name="isEdit"/>
        <div class="row">
            <span class="title title-width2">仓库编码：</span>
            <input name="id" class="nui-textbox width1" enabled="false"/>
            <span class="title title-width2 required">仓库名称：</span>
            <input name="name" class="nui-textbox width1"/>
        </div>
        <div class="row">
            <span class="title title-width2">上级仓库：</span>
            <input name="parentId"
                   id="parentId"
                   class="nui-combobox width1"
                   textField="name"
                   valueField="id"
                   emptyText="请选择..."
                   url=""
                   allowInput="true"
                   showNullItem="true"
                   nullItemText="请选择..."/>
            <span class="title title-width2 required">仓库管理员：</span>
            <input name="chargeMan" class="nui-textbox width1"/>
        </div>
        <div class="row">
            <span class="title title-width2 required">管理员电话：</span>
            <input name="chargeTel" class="nui-textbox width1"/>
            <span class="title title-width2 required">仓库级别：</span>
            <input name="levelNumber" class="nui-textbox width1" vtype="int"  intErrorText="仓库级别只能输入整数"/>
        </div>
        <div class="row">
            <span class="title title-width2">是否末级：</span>
            <input name="isEnd" class="nui-checkbox" trueValue="1" falseValue="0"/>
            <span class="title title-width2">是否禁用：</span>
            <input name="isDisabled" class="nui-checkbox" trueValue="1" falseValue="0"/>
        </div>
    </div>
</div>
<div style="text-align:center;padding:10px;">
    <a class="mini-button" onclick="onOk" style="width:60px;margin-right:20px;">确定</a>
    <a class="mini-button" onclick="onCancel" style="width:60px;">取消</a>
</div>


</body>
</html>