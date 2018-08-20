<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 23:39:36
  - Description:
-->
<head>
<title>jsp auto create</title>

<script src="<%=webPath + contextPath%>/baseDataPart/js/customerMgr/customerAdd.js?v=1.0.7"></script>
<style type="text/css">

.title {
	text-align: right;
	display: inline-block;
}

.title-width1 {
	width: 60px;
}

.title-width2 {
	width: 75px;
}

.required {
	color: red;
}

.row {
	margin-top: 5px;
}

.form table {
	/*table-layout： fixed;*/
	
}

.width1 {
	width: 150px;
}

.width2 {
	width: 185px;
}

.width3 {
	width: 403px;
}

.width4 {
	width: 135px;
}

.width5 {
	width: 170px;
}

.width6 {
	width: 388px;
}

.mini-tabs-body {
	overflow: hidden;
}
</style>

</head>
<body>

<div style="text-align: right;">
    <span>内部往来</span>
    <div id="isInternal" name="isInternal" class="nui-checkbox" text="" onvaluechanged="onValueChanged" trueValue="1" falseValue="0"></div>
    <span>客户</span>
    <div id="isClient" name="isClient" class="nui-checkbox" text="" checked="true" trueValue="1" falseValue="0"></div>
    <span>供应商</span>
    <div id="isSupplier" name="isSupplier" class="nui-checkbox" text=""  trueValue="1" falseValue="0" enabled="false"></div>
    <span>是否禁用</span>
    <div id="isDisabled" name="isDisabled" class="nui-checkbox" text="" trueValue="1" falseValue="0"></div>
</div>
<div class="nui-fit">
    <div id="tabs1" class="nui-tabs" activeIndex="0"  style="width:97%;height:100%;margin-left: 1.5%;"
         arrowPosition="side" showNavMenu="true">
        <div name="tab1" title="基本信息">
            <span>基本信息</span>
            <div id="basicInfoForm" class="form">
                <input class="nui-hidden" name="id"/>
                <input class="nui-hidden" name="isEdit"/>
                <div class="row">
                    <span class="title title-width1 required">客户编码：</span>
                    <input name="code" id="code" class="nui-textbox width1"/>
                    <span class="title title-width1">客户简称：</span>
                    <input name="shortName" class="nui-textbox width2" width="185"/>
                </div>
                <div class="row">
                    <span class="title title-width1 required">客户全称：</span>
                    <input name="fullName"
                           id="fullName"
                           class="nui-textbox width3" width="403"/>
                    <input name="fullName1" class="nui-buttonedit width3" width="403"
                           id="fullName1"
                           allowInput="false"
                           emptyText="请选择公司..."
                           onbuttonclick="selectOrg('fullName1','code')" selectOnFocus="true"
                           visible="false"/>
                </div>
                <div class="row">
                    <span class="title title-width1 required">票据类型：</span>
                    <input id="billTypeId"
                           name="billTypeId"
                           class="nui-combobox width1"
                           textField="name"
                           valueField="customid"
                           emptyText="请选择..."
                           url=""
                           allowInput="true"
                           showNullItem="false"
                           nullItemText="请选择..."/>

                    <span class="title title-width1 required">结算方式：</span>
                    <input id="settTypeId"
                           name="settTypeId"
                           class="nui-combobox width2"
                           textField="name"
                           valueField="customid"
                           emptyText="请选择..."
                           url=""
                           allowInput="true"
                           showNullItem="false"
                           nullItemText="请选择..."/>
                </div>
                <div class="row">
                    <span class="title title-width1 required">联系人：</span>
                    <input name="manager" class="nui-textbox" width="60"/>
                    <span class="title title-width1" style="width: 40px;">职务：</span>
                    <input id="managerDuty"
                           name="managerDuty"
                           width="110"
                           class="nui-combobox"
                           textField="name"
                           valueField="customid"
                           emptyText="请选择..."
                           url=""
                           allowInput="true"
                           showNullItem="true"
                           nullItemText="请选择..."/>
                    <span class="title title-width1 required" style="width: 40px;">手机：</span>
                    <input name="mobile" class="nui-textbox" width="137"/>
                </div>
                <div class="row">
                    <span class="title title-width1">业务员：</span>
                    <input name="contactor" class="nui-textbox width1" width="150"/>
                    <span class="title title-width1">手机：</span>
                    <input name="contactorTel" class="nui-textbox width2" width="185"/>
                </div>
                <div class="row">
                    <span class="title title-width1">电话：</span>
                    <input name="tel" class="nui-textbox width3" width="403"/>
                </div>
                <div class="row">
                    <span class="title title-width1">信用等级：</span>
                    <input id="tgrade"
                           name="tgrade"
                           class="nui-combobox width1"
                           textField="name"
                           valueField="customid"
                           emptyText="请选择..."
                           url=""
                           allowInput="true"
                           showNullItem="true"
                           nullItemText="请选择..."/>
                    <span class="title title-width1">备注：</span>
                    <input name="remark" class="nui-textbox width2" />
                </div>
            </div>
            <span>联系信息</span>
            <div class="form" id="contactInfoForm">
                <div class="row">
                    <span class="title title-width1 required">省份：</span>
                    <input name="provinceId"
                           id="provinceId"
                           class="nui-combobox"
                           textField="name"
                           valueField="id"
                           emptyText="请选择..."
                           url=""
                           allowInput="true"
                           showNullItem="false"
                           onvaluechanged="onProvinceSelected('cityId')"
                           nullItemText="请选择..."/>
                    <span class="title title-width1 required">城市：</span>
                    <input name="cityId"
                           id="cityId"
                           class="nui-combobox"
                           textField="name"
                           valueField="id"
                           emptyText="请选择..."
                           url=""
                           allowInput="true"
                           showNullItem="false"
                           nullItemText="请选择..."/>
                </div>
                <div class="row">
                    <span class="title title-width1">地址：</span>
                    <input name="addr" class="nui-textbox width3"/>
                </div>
                <div class="row">
                    <span class="title title-width1">邮箱：</span>
                    <input name="email" class="nui-textbox width1"/>
                    <span class="title title-width1">QQ/微信：</span>
                    <input name="instantMsg" class="nui-textbox width2"/>
                </div>
                <div class="row">
                    <span class="title title-width1">邮政编码：</span>
                    <input name="postalCode" class="nui-textbox width3"/>
                </div>
            </div>
        </div>
        <div name="tab2" title="其他信息">
            <span>财务信息</span>
            <div id="financeInfoForm" class="form">
                <input class="nui-hidden" name="id"/>
                <div class="row">
                    <span class="title title-width2">银行帐号：</span>
                    <input name="accountBankNo" class="nui-textbox width6"/>
                </div>
                <div class="row">
                    <span class="title title-width2">开户银行：</span>
                    <input name="accountBank" class="nui-textbox width6"/>
                </div>
                <div class="row">
                    <span class="title title-width2">纳税人编码：</span>
                    <input name="taxpayerCode" class="nui-textbox width4"/>
                    <span class="title title-width2">纳税人电话：</span>
                    <input name="taxpayerTel" class="nui-textbox width5"/>
                </div>
                <div class="row">
                    <span class="title title-width2">纳税人名称：</span>
                    <input name="taxpayerName" class="nui-textbox width6"/>
                </div>
            </div>
            <span>其他信息</span>
            <div class="form" id="otherInfoForm">
                <div class="row">
                    <span class="title title-width2">网址：</span>
                    <input name="website" class="nui-textbox width6"/>
                </div>
                <div class="row">
                    <span class="title title-width2">传真：</span>
                    <input name="fax" class="nui-textbox width6"/>
                </div>
                <div class="row">
                    <span class="title title-width2">经营地址：</span>
                    <input name="manageAddr" class="nui-textbox width6"/>
                </div>
                <div class="row">
                    <span class="title title-width2">会员卡号：</span>
                    <input name="memCarNo" class="nui-textbox width6"/>
                </div>
                <div class="row">
                    <span class="title title-width2">会员等级：</span>
                    <input name="memLevel" class="nui-textbox width4"/>
                    <span class="title title-width2">信誉额度：</span>
                    <input name="creditLimit" class="nui-textbox width5"/>
                </div>
            </div>
        </div>
    </div>
</div>
<div style="text-align:center;padding:10px;">
    <a class="mini-button" onclick="onOk" style="width:60px;margin-right:20px;">确定</a>
    <a class="mini-button" onclick="onCancel" style="width:60px;">取消</a>
</div>

</body>
</html>
