<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-07 15:52:16
  - Description:
-->
<head>
<title>保险结算</title>
<script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/CIRegister/subpage/SettlementInsurance.js?v=1.0.0"></script>
<style type="text/css">

table {
	font-size: 12px;
}

.form_label {
	width: 84px;
	text-align: right;
}
</style>
</head>
<body>
<div id="basicInfoForm">
    <input class="nui-hidden" name="id"/>
    <input class="nui-hidden" name="grossProfit"/>
    <input class="nui-hidden" name="guestId"/>
    <input class="nui-hidden" name="guestFullName"/>
    <input class="nui-hidden" name="serviceCode"/>
    <table style="width: 100%;">
        <tr>
            <td class="form_label">
                <label>交强险：</label>
            </td>
            <td>
                <input class="nui-spinner"
                       format="￥0.00"
                       showButton="false"
                       inputStyle="text-align:right"
                       style="width: 100%;"
                       enabled="false"
                       name="insuranceSaliAmt"
                       maxValue="100000000"/>
            </td>
        </tr>
        <tr>
            <td class="form_label">
                <label>商业险：</label>
            </td>
            <td>
                <input class="nui-spinner" format="￥0.00" showButton="false"
                       inputStyle="text-align:right"
                       style="width: 100%;"
                       enabled="false"
                       name="insuranceBizAmt"
                       maxValue="100000000"/>
            </td>
        </tr>
        <tr>
            <td class="form_label">
                <label>车船税：</label>
            </td>
            <td>
                <input class="nui-spinner" format="￥0.00" showButton="false"
                       inputStyle="text-align:right"
                       style="width: 100%;"
                       enabled="false"
                       name="carBoartTax"
                       maxValue="100000000"/>
            </td>
        </tr>
        <tr>
            <td class="form_label">
                <label>保费：</label>
            </td>
            <td>
                <input class="nui-spinner" format="￥0.00" showButton="false"
                       inputStyle="text-align:right"
                       style="width: 100%;"
                       enabled="false"
                       name="insuranceAmt"
                       maxValue="100000000"/>
            </td>
        </tr>
        <tr>
            <td class="form_label">
                <label>交强险佣金率：</label>
            </td>
            <td>
                <input class="nui-spinner" format="0"
                       inputStyle="text-align:right"
                       style="width: 100%;"
                       name="insuranceSaliRate"
                       id="insuranceSaliRate"
                       maxValue="100000000"/>
            </td>
        </tr>
        <tr>
            <td class="form_label">
                <label>商业险佣金率：</label>
            </td>
            <td>
                <input class="nui-spinner" format="0"
                       inputStyle="text-align:right"
                       style="width: 100%;"
                       name="insuranceBizRate"
                       id="insuranceBizRate"
                       maxValue="100000000"/>
            </td>
        </tr>
        <tr>
            <td class="form_label">
                <label>佣金：</label>
            </td>
            <td>
                <input class="nui-spinner" format="￥0.00" showButton="false"
                       inputStyle="text-align:right"
                       style="width: 100%;"
                       enabled="false"
                       name="commissionAmt"
                       maxValue="100000000"/>
            </td>
        </tr>
        <tr>
            <td class="form_label">
                <label>返利：</label>
            </td>
            <td>
                <input class="nui-spinner" format="￥0.00" showButton="false"
                       inputStyle="text-align:right"
                       style="width: 100%;"
                       name="discount"
                       id="discount"
                       maxValue="100000000"/>
            </td>
        </tr>
        <tr>
            <td class="form_label">
                <label>其他费用：</label>
            </td>
            <td>
                <input class="nui-spinner" format="￥0.00" showButton="false"
                       inputStyle="text-align:right"
                       style="width: 100%;"
                       name="othetExpense"
                       id="othetExpense"
                       maxValue="100000000"/>
            </td>
        </tr>
        <tr>
            <td class="form_label">
                <label>备注：</label>
            </td>
            <td>
                <input class="nui-textbox"
                inputStyle="text-align:right"
                       style="width: 100%;"
                       id="remark" name="remark"/>
            </td> 
        </tr>
        <tr>
            <td class="form_label">
                <label>公式说明：</label>
            </td>
            <td colspan="1">
                <input class="nui-textarea" style="width: 100%;height: 100px;" enabled="false" id="showMsg"/>
            </td>
        </tr>
    </table>
</div>
<div style="text-align:center;padding:10px;">
    <a class="nui-button" onclick="onSave" id="onSave" style="width:60px;margin-right:20px;">转入预结算</a>
    <a class="nui-button" onclick="pay" style="width:60px;margin-right:20px;" id="okBtn" >结算</a>
    <a class="nui-button" onclick="onCancel" style="width:60px;">取消</a>
</div>
</body>
</html>