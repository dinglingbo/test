<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-08 09:58:25
  - Description:
-->
<head>
<title>索赔结算</title>
<script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/CustomerClaim/subpage/claimSettlement.js?v=1.0.0"></script>
<style type="text/css">
table {
	font-size: 12px;
}

.form_label {
	text-align: right;
}

.required {
	color: red;
}
</style>
</head>
<body>
<div class="nui-toolbar" style="border-width: 0;border-bottom-width:1px;">
    <table>
        <tr>
            <td>
                <a class="nui-button" plain="true" iconCls="icon-save" onclick="onOk()">保存</a>
                <a class="nui-button" plain="true" iconCls="icon-no" onclick="onCancel()">关闭</a>
            </td>
        </tr>
    </table>
</div>
<div id="basicInfoForm">
    <input class="nui-hidden" name="id" id="id"/>
    <table>
        <tr>
            <td class="form_label">
                <label>索赔单号：</label>
            </td>
            <td>
                <input class="nui-textbox" enabled="false" id="serviceCode" name="serviceCode"/>
            </td>
            <td class="form_label">
                <label>业务单号：</label>
            </td>
            <td colspan="3">
                <input class="nui-textbox" enabled="false" name="maintainServiceCode"/>
            </td>
        </tr>
    </table>
    <div  class="nui-panel" showToolbar="false" title="索赔结算信息" showFooter="false" style="width:calc(100% - 10px);margin: 5px;">
        <table>
            <tr>
                <td class="form_label">
                    <label>索赔项目金额：</label>
                </td>
                <td>
                    <input class="nui-spinner" enabled="false" id="itemAmt" name="itemAmt" showButton="false" minValue="0" maxValue="10000000000"/>
                </td>
                <td class="form_label">
                    <label>索赔配件金额：</label>
                </td>
                <td>
                    <input class="nui-spinner" enabled="false" id="partAmt" name="partAmt" showButton="false" minValue="0" maxValue="10000000000"/>
                </td>
            </tr>
            <tr>
                <td class="form_label">
                    <label>折让金额：</label>
                </td>
                <td>
                    <input class="nui-spinner" enabled="true" id="agioAmt" name="agioAmt" showButton="false" minValue="0" maxValue="10000000000"/>
                </td>
                <td class="form_label">
                    <label>其他费用：</label>
                </td>
                <td>
                    <input class="nui-spinner" enabled="true" id="otherAmt" name="otherAmt" showButton="false" minValue="0" maxValue="10000000000"/>
                </td>
            </tr>
            <tr>
                <td class="form_label">
                    <label>结算金额：</label>
                </td>
                <td>
                    <input class="nui-spinner" enabled="false" id="balanceAmt" name="balanceAmt" showButton="false" minValue="0" maxValue="10000000000"/>
                </td>
            </tr>
            <tr>
                <td class="form_label">
                    <label>备注：</label>
                </td>
                <td colspan="3">
                    <input class="nui-textbox" enabled="true" style="width: 100%;" name="remark"/>
                </td>
            </tr>
        </table>
    </div>
</div>
</body>
</html>