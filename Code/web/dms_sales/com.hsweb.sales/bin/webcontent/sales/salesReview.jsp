<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>
    <!-- 
  - Author(s): Administrator
  - Date: 2019-05-09 17:30:27
  - Description:
-->

    <head>
        <title>销售结案审核</title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <%@include file="/common/commonRepair.jsp"%>
            <script src="<%= request.getContextPath() %>/sales/sales/js/salesReview.js?v=1.008" type="text/javascript"></script>
    </head>
    <style type="text/css">
        body {
            margin: 0;
            padding: 0;
            border: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
        }
        
        .td_title {
            width: 90px;
            text-align: right;
        }
        
        .textbox {
            height: 20px;
            margin: 0;
            padding: 0 2px;
            box-sizing: content-box;
        }
        
        .textbox .textbox-text {
            white-space: pre-wrap!important;
        }
    </style>

    <body>
        <div class="nui-toolbar" id="toolbar">
            <div align="right">
                <a class="nui-button" iconCls="" plain="true" onclick="save()" id="addBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                <a class="nui-button" iconCls="" plain="true" onclick="approved()" id="addBtn"><span class="fa fa-check fa-lg"></span>&nbsp;审核通过</a>
                <a class="nui-button" iconCls="" plain="true" onclick="close()" id="addBtn"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
            </div>
        </div>
        <form id="form1">
            <input class="nui-hidden" name="id" id="id" />
            <table style="line-height: 23px; padding-top: 10px;width: 100%" align="center">
                <tr>
                    <td class="td_title">
                        购车方式：
                    </td>
                    <td>
                        <input id="saleType" name="saleType" style="width: 100%" class="nui-combobox" textField="name" valueField="customid" enabled="false">
                    </td>
                    <td class="td_title">
                        购车预算合计：
                    </td>
                    <td>
                        <input id="buyBudgetTotal" name="buyBudgetTotal" style="width: 100%" class="nui-textbox" enabled="false" vtype="float" />
                    </td>
                    <td class="td_title">
                        已收合计：
                    </td>
                    <td>
                        <input id="receivedTotal" name="receivedTotal" style="width: 100%" class="nui-textbox" enabled="false" />
                    </td>
                    <td class="td_title">
                        未收余款：
                    </td>
                    <td>
                        <input id="receivedBalaNo" name="receivedBalaNo" style="width: 100%" class="nui-textbox" enabled="false" />
                    </td>
                </tr>
                <tr>
                    <td class="td_title">
                        车辆销价：
                    </td>
                    <td>
                        <input id="saleAmt" name="saleAmt" style="width: 100%" class="nui-textbox" vtype="float" enabled="false" />
                    </td>
                    <td class="td_title">
                        购买成本：
                    </td>
                    <td>
                        <input id="carCost" name="carCost" style="width: 100%" class="nui-textbox" vtype="float" enabled="false" />
                    </td>
                    <td class="td_title">
                        运输费：
                    </td>
                    <td>
                        <input id="handcartAmt" name="handcartAmt" style="width: 100%" class="nui-textbox" vtype="float" enabled="false" />
                    </td>
                    <td class="td_title">
                        车辆毛利：
                    </td>
                    <td>
                        <input id="saleGrossProfit" name="saleGrossProfit" style="width: 100%" class="nui-textbox" vtype="float" enabled="false" />
                    </td>
                </tr>
                <tr>
                    <td class="td_title">
                        保险费预算：
                    </td>
                    <td>
                        <input id="insuranceBudgetAmt" name="insuranceBudgetAmt" style="width: 100%" class="nui-textbox" vtype="float" enabled="false" />
                    </td>
                    <td class="td_title">
                        实际保险费：
                    </td>
                    <td>
                        <input id="insuranceAmt" name="insuranceAmt" style="width: 100%" class="nui-textbox" vtype="float" onvaluechanged="changeValueMsg" enabled="false" />
                    </td>
                    <td class="td_title">
                        保险差额：
                    </td>
                    <td>
                        <input id="insuranceDifferAmt" name="insuranceDifferAmt" style="width: 100%" class="nui-textbox" vtype="float" enabled="false" />
                    </td>
                    <td class="td_title">
                        保险毛利：
                    </td>
                    <td>
                        <input id="agentGrossProfit" name="agentGrossProfit" style="width: 100%" class="nui-textbox" vtype="float" enabled="false" />
                    </td>
                </tr>
                <tr>
                    <td class="td_title">
                        购置税预算：
                    </td>
                    <td>
                        <input id="purchaseBudgetAmt" name="purchaseBudgetAmt" style="width: 100%" class="nui-textbox" vtype="float" enabled="false" />
                    </td>
                    <td class="td_title">
                        实际购置税：
                    </td>
                    <td>
                        <input id="purchaseAmt" name="purchaseAmt" style="width: 100%" class="nui-textbox" vtype="float" onvaluechanged="changeValueMsg" enabled="false" />
                    </td>
                    <td class="td_title">
                        购置税差额：
                    </td>
                    <td>
                        <input id="purchaseDifferAmt" name="purchaseDifferAmt" style="width: 100%" class="nui-textbox" vtype="float" enabled="false" />
                    </td>
                    <td class="td_title">
                        差额合计：
                    </td>
                    <td>
                        <input id="differAmtTotal" name="differAmtTotal" style="width: 100%" class="nui-textbox" vtype="float" enabled="false" />
                    </td>
                </tr>
                <tr>
                    <td class="td_title">
                        上牌费：
                    </td>
                    <td>
                        <input id="boardLotAmt" name="boardLotAmt" style="width: 100%" class="nui-textbox" vtype="float" enabled="false" />
                    </td>
                    <td class="td_title">
                        上牌成本：
                    </td>
                    <td>
                        <input id="boardLotCost" name="boardLotCost" style="width: 100%" class="nui-textbox" vtype="float" onvaluechanged="changeValueMsg" enabled="false" />
                    </td>
                    <td class="td_title">
                        上牌毛利：
                    </td>
                    <td>
                        <input id="boardLotGrossProfit" name="boardLotGrossProfit" style="width: 100%" class="nui-textbox" vtype="float" enabled="false" />
                    </td>
                </tr>
                <tr>
                    <td class="td_title">
                        GPS费：
                    </td>
                    <td>
                        <input id="gpsAmt" name="gpsAmt" style="width: 100%" class="nui-textbox" vtype="float" enabled="false" />
                    </td>
                    <td class="td_title">
                        GPS成本：
                    </td>
                    <td>
                        <input id="gpsCost" name="gpsCost" style="width: 100%" class="nui-textbox" vtype="float" onvaluechanged="changeValueMsg" enabled="false" />
                    </td>
                    <td class="td_title">
                        GPS毛利：
                    </td>
                    <td>
                        <input id="gpsGrossProfit" name="gpsGrossProfit" style="width: 100%" class="nui-textbox" vtype="float" enabled="false" />
                    </td>
                </tr>
                <tr>
                    <td class="td_title">
                        按揭手续费：
                    </td>
                    <td>
                        <input id="mortgageAmt" name="mortgageAmt" style="width: 100%" class="nui-textbox" vtype="float" enabled="false" />
                    </td>
                    <td class="td_title">
                        按揭成本：
                    </td>
                    <td>
                        <input id="mortgageCost" name="mortgageCost" style="width: 100%" class="nui-textbox" vtype="float" onvaluechanged="changeValueMsg" enabled="false" />
                    </td>
                    <td class="td_title">
                        按揭毛利：
                    </td>
                    <td>
                        <input id="mortgageGrossProfit" name="mortgageGrossProfit" style="width: 100%" class="nui-textbox" vtype="float" enabled="false" />
                    </td>
                </tr>
                <tr>
                    <td class="td_title">
                        加装费：
                    </td>
                    <td>
                        <input id="decrAmt" name="decrAmt" style="width: 100%" class="nui-textbox" vtype="float" enabled="false" />
                    </td>
                    <td class="td_title">
                        加装成本：
                    </td>
                    <td>
                        <input id="decrCost" name="decrCost" style="width: 100%" class="nui-textbox" vtype="float" onvaluechanged="changeValueMsg" enabled="false" />
                    </td>
                    <td class="td_title">
                        加装毛利：
                    </td>
                    <td>
                        <input id="decrGrossProfit" name="decrGrossProfit" style="width: 100%" class="nui-textbox" vtype="float" enabled="false" />
                    </td>
                </tr>
                <tr>
                    <td class="td_title">
                        家访费：
                    </td>
                    <td>
                        <input id="familyAmt" name="familyAmt" style="width: 100%" class="nui-textbox" vtype="float" enabled="false" />
                    </td>
                    <td class="td_title">
                        家访成本：
                    </td>
                    <td>
                        <input id="familyCost" name="familyCost" style="width: 100%" class="nui-textbox" vtype="float" onvaluechanged="changeValueMsg" enabled="false" />
                    </td>
                    <td class="td_title">
                        家访毛利：
                    </td>
                    <td>
                        <input id="familyGrossProfit" name="familyGrossProfit" style="width: 100%" class="nui-textbox" vtype="float" enabled="false" />
                    </td>
                </tr>
                <tr>
                    <td class="td_title">
                        其他收费：
                    </td>
                    <td>
                        <input id="otherAmt" name="otherAmt" style="width: 100%" class="nui-textbox" vtype="float" enabled="false" />
                    </td>
                    <td class="td_title">
                        其他成本：
                    </td>
                    <td>
                        <input id="otherCost" name="otherCost" style="width: 100%" class="nui-textbox" vtype="float" onvaluechanged="changeValueMsg" enabled="false" />
                    </td>
                    <td class="td_title">
                        其他毛利：
                    </td>
                    <td>
                        <input id="otherGrossProfit" name="otherGrossProfit" style="width: 100%" class="nui-textbox" vtype="float" enabled="false" />
                    </td>
                </tr>
                <tr>
                    <td class="td_title">
                        贷款比例：
                    </td>
                    <td>
                        <input id="loanPercent" name="loanPercent" style="width: 100%" class="nui-combobox" data="loanPercentData" enabled="false">
                    </td>
                    <td class="td_title">
                        贷款金额：
                    </td>
                    <td>
                        <input id="loanAmt" name="loanAmt" style="width: 100%" class="nui-textbox" vtype="float" enabled="false" />

                    </td>
                    <td class="td_title">
                        贷款期数：
                    </td>
                    <td>
                        <input id="loanPeriod" name="loanPeriod" data="period" style="width: 100%" class="nui-combobox" enabled="false" />
                    </td>
                    <td class="td_title">
                        首付金额：
                    </td>
                    <td>
                        <input id="downPaymentAmt" name="downPaymentAmt" style="width: 100%" class="nui-textbox" vtype="float" enabled="false" />

                    </td>
                </tr>
                <tr>
                    <td class="td_title">
                        贷款银行：
                    </td>
                    <td>
                        <input id="signBillBankId" name="signBillBankId" style="width: 100%" class="nui-combobox" textField="name" valueField="customid" enabled="false">
                    </td>
                    <td class="td_title">
                        贷款利率(%)：
                    </td>
                    <td>
                        <input id="bankHandlingRate" name="bankHandlingRate" style="width: 100%" class="nui-textbox" enabled="false" vtype="float">
                    </td>
                    <td class="td_title">
                        利息分摊：
                    </td>
                    <td>
                        <input id="bankHandlingApportion" name="bankHandlingApportion" data="is_not" style="width: 100%" class="nui-combobox" enabled="false">
                    </td>
                    <td class="td_title">
                        贷款利息：
                    </td>
                    <td>
                        <input id="bankHandlingAmt" name="bankHandlingAmt" style="width: 100%" class="nui-textbox" enabled="false" vtype="float" />

                    </td>
                </tr>
                <tr>
                    <td class="td_title">
                        月供：
                    </td>
                    <td>
                        <input id="monthPayAmt" name="monthPayAmt" style="width: 100%" class="nui-textbox" vtype="float" enabled="false" />

                    </td>
                    <td class="td_title">
                        续保押金：
                    </td>
                    <td>
                        <input id="agentDeposit" name="agentDeposit" style="width: 100%" class="nui-textbox" vtype="float" enabled="false" />

                    </td>
                    <td class="td_title">
                        月供保证金：
                    </td>
                    <td>
                        <input id="riskAmt" name="riskAmt" style="width: 100%" class="nui-textbox" vtype="float" enabled="false" />

                    </td>
                    <td class="td_title">
                        合同保证金：
                    </td>
                    <td>
                        <input id="contractGuaranteeAmt" name="contractGuaranteeAmt" style="width: 100%" class="nui-textbox" vtype="float" enabled="false" />

                    </td>
                </tr>
                <tr>
                    <td class="td_title">
                        购车总费用：
                    </td>
                    <td>
                        <input id="receTotal" name="receTotal" style="width: 100%" class="nui-textbox" vtype="float" enabled="false" />
                    </td>
                    <td class="td_title">
                        销售收入：
                    </td>
                    <td>
                        <input id="saleIncomeTotal" name="saleIncomeTotal" style="width: 100%" class="nui-textbox" vtype="float" enabled="false" />
                    </td>
                    <td class="td_title">
                        销售提成：
                    </td>
                    <td>
                        <input id="salesmanDeduct" name="salesmanDeduct" style="width: 100%" class="nui-textbox" vtype="float" onvaluechanged="changeValueMsg(1)"/>
                    </td>
                    <td class="td_title">
                        佣金：
                    </td>
                    <td>
                        <input id="commissionDeduct" name="commissionDeduct" style="width: 100%" class="nui-textbox" vtype="float"  onvaluechanged="changeValueMsg(1)"/>
                    </td>
                </tr>
                <tr>
                    <td class="td_title">
                        总成本：
                    </td>
                    <td>
                        <input id="totalCost" name="totalCost" style="width: 100%" class="nui-textbox" vtype="float" enabled="false" />
                    </td>
                    <td class="td_title">
                        毛利调整：
                    </td>
                    <td>
                        <input id="adjustmentAmt" name="adjustmentAmt" style="width: 100%" class="nui-textbox" vtype="float" onvaluechanged="changeValueMsg(1)" />
                    </td>
                    <td class="td_title">
                        调整说明：
                    </td>
                    <td colspan="3">
                        <input id="adjustmentRemark" name="adjustmentRemark" style="width: 100%" class="nui-textbox" />
                    </td>
                </tr>
                <tr>
                    <td class="td_title">
                        总毛利：
                    </td>
                    <td>
                        <input id="totalGrossProfit" name="totalGrossProfit" style="width: 100%" class="nui-textbox" vtype="float" enabled="false" />
                    </td>
                    <td class="td_title">
                        毛利率(%)：
                    </td>
                    <td>
                        <input id="totalGrossProfitRate" name="totalGrossProfitRate" style="width: 100%" class="nui-textbox"  enabled="false" />
                    </td>
                </tr>
                <tr>
                    <td class="td_title">
                        开票价格：
                    </td>
                    <td>
                        <input id="billAmt" name="billAmt" style="width: 100%" class="nui-textbox" vtype="float" />
                    </td>
                    <td class="td_title">
                        发票抬头：
                    </td>
                    <td colspan="5">
                        <input id="billTitle" name="billTitle" style="width: 100%" class="nui-textbox" />
                    </td>
                </tr>
                <tr>
                    <td align="right">备注：
                    </td>
                    <td colspan="7">
                        <input id="remark" name="remarka" style="width: 100%;height:100px" class="nui-textarea" multiline="true" />
                    </td>
                </tr>
            </table>
        </form>

        <script type="text/javascript">
            var period = [{
                id: 0,
                text: ""
            }, {
                id: 12,
                text: "12期"
            }, {
                id: 24,
                text: "24期"
            }, {
                id: 36,
                text: "36期"
            }, {
                id: 48,
                text: "48期"
            }, {
                id: 60,
                text: "60期"
            }];
            var loanPercentData = [{
                id: 0,
                text: ""
            }, {
                id: 1,
                text: "1成"
            }, {
                id: 2,
                text: "2成"
            }, {
                id: 3,
                text: "3成"
            }, {
                id: 4,
                text: "4成"
            }, {
                id: 5,
                text: "5成"
            }, {
                id: 6,
                text: "6成"
            }, {
                id: 7,
                text: "7成"
            }];
            var is_not = [{
                id: 0,
                text: '是'
            }, {
                id: 1,
                text: '否'
            }];
            nui.parse();
        </script>
    </body>

    </html>