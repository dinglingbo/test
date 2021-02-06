<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-04-03 15:48:45
  - Description:
-->
<head>
<title>完工结算</title>
<script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/Reception/settleAccounts.js?v=1.0.0"></script>
<style type="text/css">
table {
	font-size: 12px;
}

.form_label {
	width: 108px;
	text-align: right;
}

.required {
	color: red;
}
</style>
</head>
<body style="padding:5px;">
<div id="basicInfoForm">
	<input class="nui-hidden" name="serviceCode"/>
    <input class="nui-hidden" name="serviceId"/>
    <input class="nui-hidden" name="outBillBalaAmt">
    <input class="nui-hidden" name="partTrueCost">
    <input class="nui-hidden" name="elecDeduct">
    <input class="nui-hidden" name="paintDeduct">
    <input class="nui-hidden" name="metalDeduct">
    <input class="nui-hidden" name="mpRpCost">
    <input class="nui-hidden" name="packageDiscountAmt">
    <input class="nui-hidden" name="packgePrefAmt">
    <input class="nui-hidden" name="cardAmt">
    <input class="nui-hidden" name="totalPrefRate">
    <div class="nui-panel" title="项目信息" style="width:calc(100% - 10px);" bodyStyle="padding:0;" borderStyle="border-bottom:0;" headerStyle="height:22px;">
        <table class="nui-form-table">
            <tr>
                <td class="form_label">
                    <label>总项目费：</label>
                </td>
                <td>
                    <input name="itemTotalAmt" class="nui-spinner"  minValue="0" maxValue="1000000000" showButton="false" enabled="false"/>
                </td>
                <td class="form_label">
                    <label>免费项目：</label>
                </td>
                <td>
                    <input name="itemFreeAmt" class="nui-spinner"  minValue="0" maxValue="1000000000" showButton="false" enabled="false"/>
                </td>
                <td class="form_label">
                    <label>收费项目：</label>
                </td>
                <td>
                    <input name="itemAmt" class="nui-spinner"  minValue="0" maxValue="1000000000" showButton="false" enabled="false"/>
                </td>
            </tr>
            <tr>
                <td class="form_label">
                    <label>优惠率：</label>
                </td>
                <td>
                    <input name="itemPrefRate" class="nui-spinner"  minValue="0" maxValue="1000000000" showButton="false" enabled="false"/>
                </td>
                <td class="form_label">
                    <label>优惠金额：</label>
                </td>
                <td>
                    <input name="itemPrefAmt" class="nui-spinner"  minValue="0" maxValue="1000000000" showButton="false" enabled="false"/>
                </td>
                <td class="form_label">
                    <label>项目小计：</label>
                </td>
                <td>
                    <input name="itemSubtotal" class="nui-spinner"  minValue="0" maxValue="1000000000" showButton="false" enabled="false"/>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-panel" title="材料信息" style="width:calc(100% - 10px);" bodyStyle="padding:0;" borderStyle="border-bottom:0;" headerStyle="height:22px;">
        <table class="nui-form-table">
            <tr>
                <td class="form_label">
                    <label>总材料费：</label>
                </td>
                <td>
                    <input name="partTotalAmt" class="nui-spinner"  minValue="0" maxValue="1000000000" showButton="false" enabled="false"/>
                </td>
                <td class="form_label">
                    <label>免费材料：</label>
                </td>
                <td>
                    <input name="partFreeAmt" class="nui-spinner"  minValue="0" maxValue="1000000000" showButton="false" enabled="false"/>
                </td>
                <td class="form_label">
                    <label>收费材料：</label>
                </td>
                <td>
                    <input name="partAmt" class="nui-spinner"  minValue="0" maxValue="1000000000" showButton="false" enabled="false"/>
                </td>
            </tr>
            <tr>
                <td class="form_label">
                    <label>优惠率：</label>
                </td>
                <td>
                    <input name="partPrefRate" class="nui-spinner"  minValue="0" maxValue="1000000000" showButton="false" enabled="false"/>
                </td>
                <td class="form_label">
                    <label>优惠金额：</label>
                </td>
                <td>
                    <input name="partPrefAmt" class="nui-spinner"  minValue="0" maxValue="1000000000" showButton="false" enabled="false"/>
                </td>
                <td class="form_label">
                    <label>材料小计：</label>
                </td>
                <td>
                    <input name="partSubtotal" class="nui-spinner"  minValue="0" maxValue="1000000000" showButton="false" enabled="false"/>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-panel" title="其他费用信息" style="width:calc(100% - 10px);" bodyStyle="padding:0;" borderStyle="border-bottom:0;" headerStyle="height:22px;">
        <table class="nui-form-table">
            <tr>
                <td class="form_label">
                    <label>辅料费：</label>
                </td>
                <td>
                    <input name="materialExp" class="nui-spinner"  minValue="0" maxValue="1000000000" showButton="false" enabled="false"/>
                </td>
                <td class="form_label">
                    <label>管理费用：</label>
                </td>
                <td>
                    <input name="partManageExp" class="nui-spinner"  minValue="0" maxValue="1000000000" showButton="false" enabled="false"/>
                </td>
                <td class="form_label">
                    <label>其他费用：</label>
                </td>
                <td>
                    <input name="otherExp" class="nui-spinner"  minValue="0" maxValue="1000000000" showButton="false" enabled="false"/>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-panel" title="出单信息" style="width:calc(100% - 10px);" bodyStyle="padding:0;" borderStyle="border-bottom:0;" headerStyle="height:22px;">
        <table class="nui-form-table">
            <tr>
                <td class="form_label">
                    <label>开大金额：</label>
                </td>
                <td>
                    <input name="outTurnUpAmt" class="nui-spinner"  minValue="0" maxValue="1000000000" showButton="false" enabled="false"/>
                </td>
                <td class="form_label">
                    <label>开大税款：</label>
                </td>
                <td>
                    <input name="outTurnUpTaxAmt" class="nui-spinner"  minValue="0" maxValue="1000000000" showButton="false" enabled="true"/>
                </td>
                <td class="form_label">
                    <label>返利：</label>
                </td>
                <td>
                    <input name="outRebateAmt" class="nui-spinner"  minValue="0" maxValue="1000000000" showButton="false" enabled="false"/>
                </td>
            </tr>
            <tr>
                <td class="form_label">
                    <label>出单优惠合计：</label>
                </td>
                <td>
                    <input name="outTotalPrefAmt" class="nui-spinner"  minValue="0" maxValue="1000000000" showButton="false" enabled="false"/>
                </td>
                <td class="form_label">
                    <label>出单小计：</label>
                </td>
                <td>
                    <input name="outBillBalaSubtoal" class="nui-spinner"  minValue="0" maxValue="1000000000" showButton="false" enabled="false"/>
                </td>
                <td class="form_label">
                    <label>出单折让：</label>
                </td>
                <td>
                    <input name="outBillAllowance" class="nui-spinner"  minValue="0" maxValue="1000000000" showButton="false" enabled="false"/>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-panel" title="结算信息" style="width:calc(100% - 10px);" bodyStyle="padding:0;" borderStyle="border-bottom:0;" headerStyle="height:22px;">
        <table class="nui-form-table">
            <tr>
                <td class="form_label">
                    <label>维修金额：</label>
                </td>
                <td>
                    <input name="mtAmt" class="nui-spinner"  minValue="0" maxValue="1000000000" showButton="false" enabled="false"/>
                </td>
                <td class="form_label">
                    <label>优惠合计：</label>
                </td>
                <td>
                    <input name="totalPrefAmt" class="nui-spinner"  minValue="0" maxValue="1000000000" showButton="false" enabled="false"/>
                </td>
                <td class="form_label">
                    <label>折让金额：</label>
                </td>
                <td>
                    <input name="allowanceAmt" class="nui-spinner"  minValue="0" maxValue="1000000000" showButton="false" enabled="false"/>
                </td>
            </tr>
            <tr>
                <td class="form_label">
                    <label>免费+优惠+折让：</label>
                </td>
                <td>
                    <input name="freePrefAllowanceAmt" class="nui-spinner"  minValue="0" maxValue="1000000000" showButton="false" enabled="false"/>
                </td>
                <td class="form_label">
                    <label>结算金额：</label>
                </td>
                <td>
                    <input name="balaAmt" class="nui-spinner"  minValue="0" maxValue="1000000000" showButton="false" enabled="false"/>
                </td>
                <td class="form_label">
                    <label>发票金额：</label>
                </td>
                <td>
                    <input name="billAmt" class="nui-spinner"  minValue="0" maxValue="1000000000" showButton="false" enabled="false"/>
                </td>
            </tr>
            <tr>
                <td class="form_label">
                    <label>计划税款：</label>
                </td>
                <td>
                    <input name="planTaxAmt" class="nui-spinner"  minValue="0" maxValue="1000000000" showButton="false" enabled="false"/>
                </td>
                <td class="form_label">
                    <label>备注说明：</label>
                </td>
                <td colspan="3">
                    <input name="businessRemark" class="nui-textbox" enabled="false" style="width: 100%;"/>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-panel" title="营业信息" style="width:calc(100% - 10px);" bodyStyle="padding:0;" headerStyle="height:22px;">
        <table class="nui-form-table">
            <tr>
                <td class="form_label">
                    <label>预提费：</label>
                </td>
                <td>
                    <input name="accruedExpensesAmt" class="nui-spinner"  minValue="0" maxValue="1000000000" showButton="false" enabled="false"/>
                </td>
                <td class="form_label">
                    <label>预提费说明：</label>
                </td>
                <td colspan="3">
                    <input name="accruedExpensesRemark" class="nui-textbox" enabled="false" style="width: 100%;"/>
                </td>
            </tr>
            <tr>
                <td class="form_label">
                    <label>营业收入：</label>
                </td>
                <td>
                    <input name="incomeAmt" class="nui-spinner"  minValue="0" maxValue="1000000000" showButton="false" enabled="false"/>
                </td>
                <td class="form_label">
                    <label>应收金额：</label>
                </td>
                <td>
                    <input name="receivableAmt" class="nui-spinner"  minValue="0" maxValue="1000000000" showButton="false" enabled="false"/>
                </td>
                <td class="form_label">
                    <label>真实收入：</label>
                </td>
                <td>
                    <input name="incomeRealAmt" class="nui-spinner"  minValue="0" maxValue="1000000000" showButton="false" enabled="false"/>
                </td>
            </tr>
        </table>
    </div>
</div>
<div style="text-align:right;padding:10px;">
    <a class="nui-button" onclick="setRate" id="setRateBtn" style="margin-right:20px;">优惠设置</a>
    <a class="nui-button" onclick="onOk" style="width:60px;margin-right:20px;">保存</a>
    <a class="nui-button" onclick="transferBill" id="transferBillBtn" enabled="false" style="width:60px;margin-right:20px;">转单</a>
    <a class="nui-button" onclick="onCancel" style="width:60px;">关闭</a>
</div>
</body>
</html>
