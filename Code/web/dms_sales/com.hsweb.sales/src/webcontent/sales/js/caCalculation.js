var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + saleApi + "/";
var form = null;
$(document).ready(function(v) {
    form = new nui.Form("#form1");
    var calculate = "银行利息=贷款金额*贷款利率(%)" +
        "\r\n担保费=贷款金额*担保费率(%)" +
        "\r\n费用合计 = 按揭手续费 + 合同保证金 + 续保押金 + 风险保证金+ 家访费+ 保险费预算+ 购置税预算 + GPS费用   + 上牌费 + 其它费 + 不分摊银行利息" +
        "\r\n购车预算合计= 车辆销价+费用合计"
    nui.get("calculate").setValue(calculate);
});

function getValue() {
    var data = form.getData();
    return data;
}

function SetDataMsg(serviceId) {
    nui.ajax({
        url: baseUrl + "sales.search.searchSaleCalc.biz.ext",
        type: "post",
        cache: false,
        data: {
            billType: 2,
            serviceId: serviceId
        },
        success: function(text) {
            if (text.errCode == "S") {
                var data = text.data;
                form.setData(data[0]);
            }
        }
    });
}

function calculate() { //开始计算
    var data = form.getData();
    var bankHandlingAmt = parseFloat(data.loanAmt || 0) * parseFloat(data.bankHandlingRate || 0); //银行利息=贷款金额*贷款利率(%)
    var totalAmt = parseFloat(data.mortgageAmt || 0) + parseFloat(data.contractGuaranteeAmt || 0) + parseFloat(data.agentDeposit || 0) +
        parseFloat(data.familyAmt || 0) + parseFloat(data.insuranceBudgetAmt || 0) + parseFloat(data.purchaseBudgetAmt || 0) + parseFloat(data.gpsAmt || 0) +
        parseFloat(data.boardLotAmt || 0) + parseFloat(data.otherAmt || 0) + bankHandlingAmt; //费用合计 = 按揭手续费 + 合同保证金 + 续保押金 + 风险保证金+ 家访费+ 保险费预算+ 购置税预算 + GPS费用   + 上牌费 + 其它费 + 不分摊银行利息
    var buyBudgetTotal = parseFloat(data.saleAmt || 0) + totalAmt; //购车预算合计= 车辆销价+费用合计
    data.bankHandlingAmt = bankHandlingAmt;
    data.totalAmt = totalAmt;
    data.buyBudgetTotal = buyBudgetTotal;
    form.setData(data);
}