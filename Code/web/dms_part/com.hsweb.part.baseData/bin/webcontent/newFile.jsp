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
<title>配件资料</title>
<script src="<%=webPath + contextPath%>/baseDataPart/js/partMgr/partDetail.js?v=1.0.12"></script>
<style type="text/css">
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
   <div class="nui-fit" style="padding: 10px;overflow: hidden;">
        <span>基本信息</span>
        <div id="basicInfoForm" class="form">
            <input class="nui-hidden" name="id"/>
            <input class="nui-hidden" name="isEdit"/>
            <div class="row">
                <span class="title title-width1 required">配件品质：</span>
                <input name="qualityTypeId"
                       id="qualityTypeId"
                       class="nui-combobox width1"
                       textField="name"
                       valueField="id"
                       emptyText="请选择..."
                       url=""
                       allowInput="true"
                       showNullItem="false"
                       onvaluechanged="onQualityTypeIdChanged"
                       nullItemText="请选择..."/>
                <span class="title title-width1 required">名称：</span>
                <input name="partNameId" id="partNameId"
                       class="nui-buttonedit" emptyText=""
                       allowInput="false"
                       onbuttonclick="onButtonEdit" selectOnFocus="true" />
                <span class="title required">编码：</span>
                <input name="code" class="nui-textbox width2" id="code"/>
                <span class="title required">单位：</span>
                <input name="unit"
                       id="unit"
                       class="nui-combobox width1"
                       textField="name"
                       valueField="name"
                       emptyText="请选择..."
                       url=""
                       allowInput="true"
                       showNullItem="false"
                       nullItemText="请选择..."/>
            </div>
            <div class="row">
                <span class="title title-width1 required">配件品牌：</span>
                <input name="partBrandId"
                       id="partBrandId"
                       class="nui-combobox width1"
                       textField="name"
                       valueField="id"
                       emptyText="请选择..."
                       url=""
                       allowInput="true"
                       showNullItem="false"
                       nullItemText="请选择..."/>
                <span class="title title-width1 required">ABC分类：</span>
                <input name="abcType"
                       id="abcType"
                       class="nui-combobox width2"
                       textField="name"
                       valueField="customid"
                       emptyText="请选择..."
                       url=""
                       allowInput="true"
                       showNullItem="false"
                       nullItemText="请选择..."/>
                <span class="title">型号：</span>
                <input name="model" class="nui-textbox width3"/>
            </div>
            <div class="row">
                <span class="title title-width1">适用车型：</span>
                <input name="applyCarbrandId"
                       id="applyCarbrandId"
                       class="nui-combobox width1"
                       textField="nameCn"
                       valueField="id"
                       emptyText="请选择..."
                       url=""
                       allowInput="true"
                       showNullItem="false"
                       nullItemText="请选择..."/>
                <input name="applyCarModel" id="applyCarModel" class="nui-textbox width4"/>
            </div>
            <div class="row">
                <span class="title title-width1">通用编码：</span>
                <input name="commonCode" class="nui-textbox width5"/>
                <span class="title title-width1">规格：</span>
                <input name="spec" class="nui-textbox width6"/>
            </div>
            <div class="row">
                <span class="title title-width1">配件全称：</span>
                <input name="fullName" class="nui-textbox width5" enabled="false"/>
                <span class="title title-width1">生产厂家：</span>
                <input name="produceFactory" class="nui-textbox width6"/>
            </div>
            <div class="row">
                <span class="title title-width1">零售价：</span>
                <input name="retailPrice" class="nui-textbox width1" value="0"/>
                <span class="title title-width1">批发价：</span>
                <input name="wholeSalePrice" class="nui-textbox width1" value="0"/>
                <span class="title title-width1">统一价：</span>
                <input name="uniformSellPrice" class="nui-textbox width1" value="0"/>
                <span class="title title-width1">兑换积分：</span>
                <input name="exchangeIntegral" class="nui-textbox width1" value="0"/>
            </div>
            <div class="row">
                <span class="title title-width1">用量：</span>
                <input name="usage" class="nui-spinner width1"  minValue="0" maxValue="1000000" value="0"/>
                <span class="title title-width1">重量：</span>
                <input name="weight" class="nui-textbox width1" value="0"/>
                <span class="title title-width1">是否禁用：</span>
                <input name="isDisabled" class="nui-checkbox" trueValue="1" falseValue="0"/>
                <span class="title title-width1">统一售价：</span>
                <input name="isUniform" class="nui-checkbox" trueValue="1" falseValue="0"/>
            </div>
        </div>
    </div>
    <div style="text-align:center;padding:10px;">
        <a class="mini-button" onclick="onOk" style="width:60px;margin-right:20px;">确定</a>
        <a class="mini-button" onclick="onCancel" style="width:60px;">取消</a>
    </div>
</body>
</html>
