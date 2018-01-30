<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 09:10:02
  - Description:
-->
<head>
<title>jsp auto create</title>
<script src="<%= request.getContextPath() %>/baseData/js/storehouseMgr/positionDetail.js?v=1.0.4"></script>
<style type="text/css">
.row {
	margin-top: 5px;
}

.width1 {
	width: 105px;	
}

.title {
	text-align: right;
	display: inline-block;
}

.title-width2 {
	width: 100px;
}

.title.required {
	color: red;
}
</style>
</head>
<body>

<div title="仓位信息" class="nui-panel" style="width:calc(100% - 20px);height:130px;margin: 10px;"
     onbuttonclick="onbuttonclick">
    <div id="basicInfoForm" class="form">
        <input class="nui-hidden" name="id"/>
        <div class="row">
            <span class="title title-width2">仓库：</span>
            <input name="storeId"
                   id="storeId"
                   class="nui-combobox width1"
                   textField="name"
                   valueField="id"
                   emptyText="请选择..."
                   url=""
                   allowInput="true"
                   enabled="false"
                   showNullItem="true"
                   nullItemText="请选择..."/>
            <span class="title title-width2">仓位固定位：</span>
            <input name="firstChar" id="firstChar" class="nui-textbox width1" onvaluechanged="onFirstCharChanged"/>示例：A-1-2
        </div>
        <div class="row">
            <span class="title title-width2 required">仓位流水起始号：</span>
            <input name="startIndex" id="startIndex" class="nui-textbox width1"
                   vtype="int"  intErrorText="仓位流水起始号只能输入整数"
                   onvaluechanged="onStartIndexChanged"/>
            <span class="title title-width2">仓位流水终止号：</span>
            <input name="endIndex" id="endIndex" class="nui-textbox width1"
                   vtype="int"  intErrorText="仓位流水终止号只能输入整数"
                   onvaluechanged="onEndIndexChanged"/>
        </div>
        <div class="row">
            <span class="title title-width2">起始仓位：</span>
            <input class="nui-textbox width1" enabled="false" id="startName"/>
            <span class="title title-width2">终止仓位：</span>
            <input class="nui-textbox width1" enabled="false" id="endName"/>
        </div>
    </div>
</div>
<div style="text-align:center;padding:10px;">
    <a class="mini-button" onclick="onOk" style="width:60px;margin-right:20px;">确定</a>
    <a class="mini-button" onclick="onCancel" style="width:60px;">取消</a>
</div>

</body>
</html>