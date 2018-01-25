<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 23:12:35
  - Description:
-->
<head>
<title>供应商资料</title>
<script src="supplierDetail.js?v=1.0.0"></script>
<style type="text/css">
html,body {
	margin: 0;
	padding: 0;
	border: 0;
	width: 100%;
	height: 100%;
	overflow: hidden;
}

.title {
	text-align: right;
	display: inline-block;
}

.title-width1 {
	width: 75px;
}

.title-width2 {
	width: 90px;
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
    <div id="ck1" name="product" class="nui-checkbox" readOnly="false" text="" onvaluechanged="onValueChanged"></div>
    <span>客户</span>
    <div id="ck2" name="product" class="nui-checkbox" readOnly="false" text="" ></div>
    <span>供应商</span>
    <div id="ck3" name="product" class="nui-checkbox" text="" checked="true" enabled="false"></div>
    <span>是否禁用</span>
    <div id="ck4" name="product" class="nui-checkbox" readOnly="false" text=""></div>
</div>
<div class="nui-fit">
    <div id="tabs1" class="nui-tabs" activeIndex="0"  style="width:97%;height:100%;margin-left: 1.5%;"
         arrowPosition="side" showNavMenu="true">
        <div name="tab1" title="基本信息">
            <span>基本信息</span>
            <div id="basicInfoForm" class="form">
                <input class="nui-hidden" name="id"/>
                <div class="row">
                    <span class="title title-width1 required">供应商编码：</span>
                    <input name="loginname" class="nui-textbox width1"/>
                    <span class="title title-width1">供应商简称：</span>
                    <input name="loginname" class="nui-textbox width2" width="185"/>
                </div>
                <div class="row">
                    <span class="title title-width1 required">供应商全称：</span>
                    <input name="loginname" class="nui-textbox width3" width="403"/>
                </div>
                <div class="row">
                    <span class="title title-width1 required">票据类型：</span>
                    <input id="piaoju-type"
                           class="nui-combobox width1"
                           textField="text"
                           valueField="id"
                           emptyText="请选择..."
                           url=""
                           allowInput="true"
                           showNullItem="true"
                           nullItemText="请选择..."/>

                    <span class="title title-width1 required">结算方式：</span>
                    <input id="jiesuan-way"
                           class="nui-combobox width2"
                           textField="text"
                           valueField="id"
                           emptyText="请选择..."
                           url=""
                           allowInput="true"
                           showNullItem="true"
                           nullItemText="请选择..."/>
                </div>
                <div class="row">
                    <span class="title title-width1 required">供应类型：</span>
                    <input id="piaoju-types"
                           class="nui-combobox width1"
                           textField="text"
                           valueField="id"
                           emptyText="请选择..."
                           url=""
                           allowInput="true"
                           showNullItem="true"
                           nullItemText="请选择..."/>

                    <span class="title title-width2 required">优势品牌/产品：</span>
                    <input name="loginname" class="nui-textbox width1"/>
                </div>
                <div class="row">
                    <span class="title title-width1 required">联系人：</span>
                    <input name="loginname" class="nui-textbox" width="60"/>
                    <span class="title title-width1" style="width: 40px;">职务：</span>
                    <input id="position"
                           width="110"
                           class="nui-combobox"
                           textField="text"
                           valueField="id"
                           emptyText="请选择..."
                           url=""
                           allowInput="true"
                           showNullItem="true"
                           nullItemText="请选择..."/>
                    <span class="title title-width1 required" style="width: 40px;">手机：</span>
                    <input name="loginname" class="nui-textbox" width="137"/>
                </div>
                <div class="row">
                    <span class="title title-width1">业务员：</span>
                    <input name="loginname" class="nui-textbox width1" width="150"/>
                    <span class="title title-width1">手机：</span>
                    <input name="loginname" class="nui-textbox width2" width="185"/>
                </div>
                <div class="row">
                    <span class="title title-width1">电话：</span>
                    <input name="loginname" class="nui-textbox width3" width="403"/>
                </div>
                <div class="row">
                    <span class="title title-width1">信用等级：</span>
                    <input id="level"
                           class="nui-combobox width1"
                           textField="text"
                           valueField="id"
                           emptyText="请选择..."
                           url=""
                           allowInput="true"
                           showNullItem="true"
                           nullItemText="请选择..."/>
                    <span class="title title-width1">备注：</span>
                    <input name="loginname" class="nui-textbox width2" />
                </div>
            </div>
            <span>联系信息</span>
            <div class="form" id="contactInfoForm">
                <div class="row">
                    <span class="title title-width1 required">省份：</span>
                    <input id="selectProvince"
                           class="nui-combobox width1"
                           textField="name"
                           valueField="id"
                           emptyText="请选择..."
                           url=""
                           allowInput="true"
                           showNullItem="true"
                           nullItemText="请选择..."/>
                    <span class="title title-width1 required">城市：</span>
                    <input id="selectCity"
                           class="nui-combobox width2"
                           textField="name"
                           valueField="id"
                           emptyText="请选择..."
                           url=""
                           allowInput="true"
                           showNullItem="true"
                           nullItemText="请选择..."/>
                </div>
                <div class="row">
                    <span class="title title-width1">地址：</span>
                    <input name="loginname" class="nui-textbox width3"/>
                </div>
                <div class="row">
                    <span class="title title-width1">邮箱：</span>
                    <input name="loginname" class="nui-textbox width1"/>
                    <span class="title title-width1">QQ：</span>
                    <input name="loginname" class="nui-textbox width2"/>
                </div>
                <div class="row">
                    <span class="title title-width1">邮政编码：</span>
                    <input name="loginname" class="nui-textbox width3"/>
                </div>
            </div>
        </div>
        <div name="tab2" title="其他信息">
            <span>财务信息</span>
            <div id="financeInfoForm" class="form">
                <input class="nui-hidden" name="id"/>
                <div class="row">
                    <span class="title title-width2">银行帐号：</span>
                    <input name="loginname" class="nui-textbox width6"/>
                </div>
                <div class="row">
                    <span class="title title-width2">开户银行：</span>
                    <input name="loginname" class="nui-textbox width6"/>
                </div>
                <div class="row">
                    <span class="title title-width2">纳税人编码：</span>
                    <input name="loginname" class="nui-textbox width4"/>
                    <span class="title title-width2">纳税人电话：</span>
                    <input name="loginname" class="nui-textbox width5"/>
                </div>
                <div class="row">
                    <span class="title title-width2">纳税人名称：</span>
                    <input name="loginname" class="nui-textbox width6"/>
                </div>
            </div>
            <span>其他信息</span>
            <div class="form" id="otherInfoForm">
                <div class="row">
                    <span class="title title-width2">网址：</span>
                    <input name="loginname" class="nui-textbox width6"/>
                </div>
                <div class="row">
                    <span class="title title-width2">传真：</span>
                    <input name="loginname" class="nui-textbox width6"/>
                </div>
                <div class="row">
                    <span class="title title-width2">经营地址：</span>
                    <input name="loginname" class="nui-textbox width6"/>
                </div>
                <div class="row">
                    <span class="title title-width2">会员卡号：</span>
                    <input name="loginname" class="nui-textbox width6"/>
                </div>
                <div class="row">
                    <span class="title title-width2">会员等级：</span>
                    <input name="loginname" class="nui-textbox width4"/>
                    <span class="title title-width2">信誉额度：</span>
                    <input name="loginname" class="nui-textbox width5"/>
                </div>
            </div>
        </div>
    </div>
</div>
<div style="text-align:center;padding:10px;">
    <a class="mini-button" onclick="onAdvancedSearchOk" style="width:60px;margin-right:20px;">确定</a>
    <a class="mini-button" onclick="onCancel" style="width:60px;">取消</a>
</div>

</body>
</html>
