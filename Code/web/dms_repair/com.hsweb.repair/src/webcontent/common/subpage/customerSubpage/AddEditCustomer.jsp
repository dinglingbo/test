<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-31 16:54:43
  - Description:
-->
<head>
<title>新增/修改客户档案</title>
<script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/CustomerProfile/AddEditCustomer.js?v=1.0.16"></script>
<style type="text/css">

table {
	font-size: 12px;
}

.form_label {
	width: 80px;
	text-align: right;
}

.required {
	color: red;
}
</style>
</head>
<body>
<div class="nui-splitter"
     id="addEditCustomerPage"
     style="width:100%;height:100%;" vertical="true"
     borderStyle="border:0;"
     handlerSize="0"
     allowResize="false">
    <div size="163" showCollapseButton="false" style="border:0;">
        <div class="nui-panel" showToolbar="false" title="客户信息" showFooter="false"
             borderStyle="border:0;"
             style="width:100%;height:100%;">
            <div class="form" id="basicInfoForm">
                <input class="nui-hidden" name="id"/>
                <table class="nui-form-table" style="width:100%">
                    <tr>
                        <td class="form_label required">
                            <label>客户名称：</label>
                        </td>
                        <td colspan="3">
                            <input class="nui-textbox" name="fullName" width="100%"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="form_label">
                            <label>客户简称：</label>
                        </td>
                        <td>
                            <input class="nui-textbox" name="shortName" width="100%"/>
                        </td>
                        <td class="form_label">
                            <label>会员卡号：</label>
                        </td>
                        <td>
                            <input class="nui-textbox" name="memCarNo" width="100%"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="form_label required">
                            <label>手机号码：</label>
                        </td>
                        <td>
                            <input class="nui-textbox" name="mobile" width="100%"/>
                        </td>
                        <td class="form_label">
                            <label>电话：</label>
                        </td>
                        <td>
                            <input class="nui-textbox" name="tel" width="100%"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="form_label">
                            <label>地址：</label>
                        </td>
                        <td colspan="3">
                            <input class="nui-textbox" name="addr" width="100%"/>
                        </td>
                    </tr>

                    <tr>
                        <td class="form_label">
                            <label>备注：</label>
                        </td>
                        <td colspan="3">
                            <input class="nui-textbox" name="remark" width="100%"/>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <div showCollapseButton="false" style="border:0;">
        <div class="nui-fit">
            <div class="nui-tabs" activeIndex="0"
                 style="width:100%;height: 100%;">
                <div title="车辆信息" showCloseButton="false">
                    <div class="form" id="carInfoFrom">
                        <input class="nui-hidden" name="id"/>
                        <input class="nui-hidden" name="carBrandId" id="carBrandId"/>
                        <table class="nui-form-table" style="width:100%;">
                            <tr>
                                <td class="form_label required">
                                    <label>车牌号：</label>
                                </td>
                                <td colspan="3">
                                    <input class="nui-textbox" name="carNo" id="carNo" width="100%"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label required">
                                    <label>车架号(VIN)：</label>
                                </td>
                                <td colspan="2">
                                    <input class="nui-textbox" id="underpanNo" name="underpanNo" width="100%"/>
                                </td>
                                <td>
                                    <a class="nui-button" onclick="onParseUnderpanNo()">解析</a>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label">
                                    <label>车型信息：</label>
                                </td>
                                <td colspan="3">
                                    <textarea class="nui-textarea" id="carModelInfo" name="carModelInfo" width="100%"></textarea>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label">
                                    <label>车型：</label>
                                </td>
                                <td colspan="3">
                                    <input class="nui-buttonedit" name="carModelId" id="carModelId" onclick="selectCarModel('carModelId','carBrandId')" width="100%"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label">
                                    <label>保险公司：</label>
                                </td>
                                <td colspan="3">
                                    <input class="nui-combobox" name="insureCompCode" id="insureCompCode"
                                           valueField="id"
                                           textField="fullName"
                                           width="100%"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label">
                                    <label>交强险到期：</label>
                                </td>
                                <td>
                                    <input name="insureDueDate" allowInput="false" class="nui-datepicker" width="100%"/>
                                </td>
                                <td class="form_label">
                                    <label>商业险到期：</label>
                                </td>
                                <td>
                                    <input name="annualInspectionDate" allowInput="false" class="nui-datepicker" width="100%"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label">
                                    <label>发动机号：</label>
                                </td>
                                <td>
                                    <input name="engineNo" class="nui-textbox" width="100%"/>
                                </td>
                                <td class="form_label">
                                    <label>保养到期：</label>
                                </td>
                                <td>
                                    <input id="careDueDdate" allowInput="false" class="nui-datepicker" width="100%"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label">
                                    <label>里程类型：</label>
                                </td>
                                <td>
                                    <input name="kiloType"
                                           id="kiloType"
                                           valueField="customid"
                                           textField="name"
                                           class="nui-combobox" width="100%"/>
                                </td>
                                <td class="form_label">
                                    <label>车型规格：</label>
                                </td>
                                <td>
                                    <input name="carSpec"
                                           id="carSpec"
                                           valueField="customid"
                                           textField="name"
                                           class="nui-combobox"
                                           width="100%"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label">
                                    <label>生产日期：</label>
                                </td>
                                <td>
                                    <input name="produceDate" allowInput="false" class="nui-datepicker" width="100%"/>
                                </td>
                                <td class="form_label">
                                    <label>上牌日期：</label>
                                </td>
                                <td>
                                    <input name="firstRegDate" allowInput="false" class="nui-datepicker" width="100%"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label">
                                    <label>年审到期：</label>
                                </td>
                                <td>
                                    <input name="annualVerificationDueDate" allowInput="false" class="nui-datepicker" width="100%"/>
                                </td>
                                <td class="form_label">
                                    <label>驾审到期：</label>
                                </td>
                                <td>
                                    <input name="drivingLicenceDueDate" allowInput="false" class="nui-datepicker" width="100%"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label">
                                    <label>公司内部车：</label>
                                </td>
                                <td>
                                    <input name="isCompanyInside"
                                           data="[{id:1,text:'是'},{id:0,text:'否'}]"
                                           class="nui-combobox" width="100%"/>
                                </td>
                                <td class="form_label">
                                    <label>本公司销售：</label>
                                </td>
                                <td>
                                    <input name="isCompanySell"
                                           data="[{id:1,text:'是'},{id:0,text:'否'}]"
                                           class="nui-combobox" width="100%"/>
                                </td>
                            </tr>
                        </table>
                        <div style="text-align:right;padding:10px;margin-top:0">
                            <a class="nui-button" iconCls="icon-upgrade" id="preCarBtn" onclick="preCar()" style="margin-right:10px;"></a>
                            <a class="nui-button" iconCls="icon-downgrade" id="nextCarBtn" onclick="nextCar()" style="margin-right:10px;"></a>
                        </div>
                    </div>
                </div>
                <div title="联系人信息" showCloseButton="false">
                    <div class="form" id="contactInfoForm">
                        <input class="nui-hidden" name="id"/>
                        <table class="nui-form-table" style="width:100%;">
                            <tr>
                                <td class="form_label required">
                                    <label>姓名：</label>
                                </td>
                                <td>
                                    <input class="nui-textbox" name="name" width="100%"/>
                                </td>
                                <td class="form_label">
                                    <label>性别：</label>
                                </td>
                                <td>
                                    <input class="nui-combobox" name="sex" name="date1" width="100%"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label required">
                                    <label>手机：</label>
                                </td>
                                <td>
                                    <input class="nui-textbox" name="mobile" width="100%"/>
                                </td>
                                <td class="form_label required">
                                    <label>身份：</label>
                                </td>
                                <td>
                                    <input class="nui-combobox"
                                           name="identity"
                                           id="identity"
                                           valueField="customid"
                                           textField="name"
                                           width="100%"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label required">
                                    <label>来源：</label>
                                </td>
                                <td colspan="3">
                                    <input class="nui-combobox" name="source"
                                           id="source"
                                           valueField="customid"
                                           textField="name"
                                           width="100%"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label">
                                    <label>生日类型：</label>
                                </td>
                                <td>
                                    <input class="nui-combobox" name="birthdayType" width="100%"/>
                                </td>
                                <td class="form_label">
                                    <label>生日：</label>
                                </td>
                                <td>
                                    <input name="birthday" allowInput="false" class="nui-datepicker" width="100%"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label">
                                    <label>身份证地址：</label>
                                </td>
                                <td colspan="3">
                                    <input class="nui-textbox" name="idAddress" width="100%"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label">
                                    <label>身份证号码：</label>
                                </td>
                                <td colspan="3">
                                    <input class="nui-textbox" name="idNo" width="100%"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label">
                                    <label>备注：</label>
                                </td>
                                <td colspan="3">
                                    <input class="nui-textbox" name="remark" width="100%"/>
                                </td>
                            </tr>
                        </table>
                        <div style="text-align:right;padding:10px;margin-top:0">
                            <a class="nui-button" iconCls="icon-upgrade" id="preContactBtn" onclick="preContact()" style="margin-right:10px;"></a>
                            <a class="nui-button" iconCls="icon-downgrade" id="nextContactBtn" onclick="nextContact()" style="margin-right:10px;"></a>
                            <a class="nui-button" iconCls="icon-add" onclick="addContact()"></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div style="text-align:right;padding:10px;margin-top:0">
            <a class="nui-button" onclick="onOk" style="margin-right:10px;">保存</a>
            <a class="nui-button" onclick="onCancel">取消</a>
        </div>
    </div>

</div>
</body>
</html>