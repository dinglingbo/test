<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>
    <!-- 
  - Author(s): Administrator
  - Date: 2019-05-09 14:41:57
  - Description:
-->

    <head>
        <title>购车计算</title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <%@include file="/common/commonRepair.jsp"%>
            <script src="<%=request.getContextPath()%>/sales/sales/js/caCalculation.js?v=1.0.956"></script>
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
        
        .auto-style1 {
            height: 31px;
        }
        
        .td_title {
            width: 90px;
            text-align: right;
        }
        
        .style1 {
            width: 95px;
            text-align: right;
        }
        
        .style2 {
            width: 80px;
        }
        
        .style3 {
            width: 132px;
        }
        
        .style4 {
            width: 81px;
            text-align: right;
        }
        
        .style5 {
            width: 81px;
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
        <div class="nui-toolbar" style="padding:0px;border-bottom:0;display:none" id="showSave">
            <table style="width:100%;">
                <tr>
                    <td style="width:100%;">
                        <a class="nui-button" onclick="saveCome()" plain="true" style="width: 60px;" id="saveCome"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                        <a class="nui-button" onclick="onCancel" plain="true" style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
                    </td>
                </tr>
            </table>
        </div>
        <div class="nui-fit">
            <div class="form" style="width:99%;height:99%;left:0;right:0;margin: 0 auto;" id="form1">
                <input class="nui-hidden" id="mainId" name="id" />
                <input class="nui-hidden" id="handcartAmt" name="handcartAmt" />
                <input class="nui-hidden" id="carCost" name="carCost" />
                <fieldset id="fd" style="width:950px;">
                    <legend><span>基本信息</span></legend>
                    <table>
                        <!--  <tr>
                    <td colspan="8">请填写购车计算信息(按回车计算)</td>
                </tr> -->
                        <tr>
                            <td class="td_title">
                                购车方式：
                            </td>
                            <td>
                                <input id="saleType" name="saleType" style="width: 100%" class="nui-combobox" textField="name" valueField="customid" onvaluechanged="changeSaleType" enabled="false">
                            </td>
                            <td class="td_title">
                                车价：
                            </td>
                            <td>
                                <input id="saleAmt" name="saleAmt" style="width: 100%" class="nui-textbox" vtype="float" onvaluechanged="changeValueMsg" />
                            </td>
                            <td class="td_title">
                                预付款：
                            </td>
                            <td>
                                <input id="advanceChargeAmt" name="advanceChargeAmt" style="width: 100%" class="nui-textbox" vtype="float" onvaluechanged="changeValueMsg" />
                            </td>
                        </tr>
                        <tr>
                            <td class="td_title">
                                外观颜色：
                            </td>
                            <td>
                                <input id="frameColorId" name="frameColorId" style="width: 100%" class="nui-combobox" textField="name" valueField="customid" onvaluechanged="changeFrameColorId">
                            </td>
                            <td class="td_title">
                                内饰颜色：
                            </td>
                            <td>
                                <input id="interialColorId" name="interialColorId" style="width: 100%" class="nui-combobox" textField="name" valueField="customid" onvaluechanged="changeInterialColorId">
                            </td>
                        </tr>
                    </table>
                </fieldset>
                <fieldset id="fd1" style="width:950px;">
                    <legend><span>贷款信息</span></legend>
                    <table>
                        <tr>
                            <td class="td_title">
                                贷款比例：
                            </td>
                            <td>
                                <input id="loanPercent" name="loanPercent" style="width: 100%" class="nui-combobox" data="loanPercentData" onvaluechanged="changeValueMsg">
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
                                <input id="loanPeriod" name="loanPeriod" data="period" style="width: 100%" class="nui-combobox" onvaluechanged="changeValueMsg" />
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
                                <input id="signBillBankId" name="signBillBankId" style="width: 100%" class="nui-combobox" textField="name" valueField="customid" onvaluechanged="getBankHandlingRate">
                            </td>
                            <td class="td_title">
                                贷款利率(%)：
                            </td>
                            <td>
                                <input id="bankHandlingRate" name="bankHandlingRate" style="width: 100%" class="nui-textbox" enabled="false" vtype="float" onvaluechanged="changeValueMsg">
                            </td>
                            <td class="td_title">
                                银行利息分摊：
                            </td>
                            <td>
                                <input id="bankHandlingApportion" name="bankHandlingApportion" data="is_not" value="0" style="width: 100%" class="nui-combobox" onvaluechanged="changeValueMsg" >
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
                                按揭手续费：
                            </td>
                            <td>
                                <input id="mortgageAmt" name="mortgageAmt" style="width: 100%" class="nui-textbox" vtype="float" onvaluechanged="changeValueMsg" />

                            </td>
                            <td class="td_title">
                                合同保证金：
                            </td>
                            <td>
                                <input id="contractGuaranteeAmt" name="contractGuaranteeAmt" style="width: 100%" class="nui-textbox" vtype="float" onvaluechanged="changeValueMsg" />

                            </td>
                            <td class="td_title">
                                月供保证金：
                            </td>
                            <td>
                                <input id="riskAmt" name="riskAmt" style="width: 100%" class="nui-textbox" vtype="float" onvaluechanged="changeValueMsg" />

                            </td>
                        </tr>
                        <tr>
                            <td class="td_title">
                                家访费：
                            </td>
                            <td>
                                <input id="familyAmt" name="familyAmt" style="width: 100%" class="nui-textbox" vtype="float" onvaluechanged="changeValueMsg" />

                            </td>
                        </tr>
                    </table>
                </fieldset>
                <fieldset id="fd2" style="width:950px;">
                    <legend><span>其它信息</span></legend>
                    <table>
                        <tr>
                            <td class="td_title">
                                续保押金：
                            </td>
                            <td>
                                <input id="agentDeposit" name="agentDeposit" style="width: 100%" class="nui-textbox" vtype="float" onvaluechanged="changeValueMsg" />

                            </td>
                            <td class="td_title">
                                GPS费用：
                            </td>
                            <td>
                                <input id="gpsAmt" name="gpsAmt" style="width: 100%" class="nui-textbox" vtype="float" onvaluechanged="changeValueMsg" />

                            </td>
                            <td class="td_title">
                                上牌费：
                            </td>
                            <td>
                                <input id="boardLotAmt" name="boardLotAmt" style="width: 100%" class="nui-textbox" vtype="float" onvaluechanged="changeValueMsg" />

                            </td>
                            <td class="td_title">
                                精品加装：
                            </td>
                            <td>
                                <input id="decrAmt" name="decrAmt" style="width: 100%" class="nui-textbox" vtype="float" onvaluechanged="changeValueMsg" enabled="false" />

                            </td>
                        </tr>
                        <tr>
                            <td class="td_title">
                                其它费用：
                            </td>
                            <td>
                                <input id="otherAmt" name="otherAmt" style="width: 100%" class="nui-textbox" vtype="float" onvaluechanged="changeValueMsg" />

                            </td>
                            <td class="td_title">
                                保险费预算：
                            </td>
                            <td>
                                <input id="insuranceBudgetAmt" name="insuranceBudgetAmt" style="width: 100%" class="nui-textbox" vtype="float" onvaluechanged="changeValueMsg" />

                            </td>
                            <td class="td_title">
                                购置税预算：
                            </td>
                            <td>
                                <input id="purchaseBudgetAmt" name="purchaseBudgetAmt" style="width: 100%" class="nui-textbox" vtype="float" onvaluechanged="changeValueMsg" />

                            </td>
                        </tr>
                        <tr>

                            <td class="td_title">
                                费用合计：
                            </td>
                            <td>
                                <input id="totalAmt" name="totalAmt" style="width: 100%" class="nui-textbox" enabled="false" vtype="float" />

                            </td>
                            <td class="td_title">
                                提车合计：
                            </td>
                            <td>
                                <input id="getCarTotal" name="getCarTotal" style="width: 100%" class="nui-textbox" vtype="float" enabled="false" />

                            </td>
                            <td class="td_title">
                                购车预算合计：
                            </td>
                            <td>
                                <input id="buyBudgetTotal" name="buyBudgetTotal" style="width: 100%" class="nui-textbox" enabled="false" vtype="float" />

                            </td>
                        </tr>
                        <tr>
                            <td align="right">备注：
                            </td>
                            <td colspan="7">
                                <input id="remark" name="remark" style="width: 100%;height:50px" class="nui-textarea" multiline="true" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">计算公式：
                            </td>
                            <td colspan="7">
                                <input id="calculate" style="width: 100%;height:150px" class="nui-textarea" multiline="true" enabled="false" />
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </div>
        </div>
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
            var is_not = [{
                id: 0,
                text: '是'
            }, {
                id: 1,
                text: '否'
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
            nui.parse();
        </script>
    </body>

    </html>