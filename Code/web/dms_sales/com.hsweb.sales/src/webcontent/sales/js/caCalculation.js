var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + saleApi + "/";
var form = null;
$(document).ready(function(v) {
    form = new nui.Form("#form1");
    var calculate = "银行利息=贷款金额*贷款利率(%)" +
        "\r\n费用合计= 银行手续费+续保押金+月供保证金+家访费+合同保证金+GPS费用+按揭服务费+保险费预算+购置税预算+上户上牌费+其它费用+精品加装" +
        "\r\n购车预算合计= 车辆销价+费用合计"
    nui.get("calculate").setValue(calculate);

    initDicts({
        saleType: '10392', //购车方式
        frameColorId: "DDT20130726000003", //车辆颜色
        signBillBankId: "DDT20140530000001", //贷款银行
        interialColorId: "10391"
    });
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

function getBankHandlingRate(e) {
    var value = e.selected.property1 || 0;
    nui.get("bankHandlingRate").setValue(value);
}

function calculate() { //开始计算
    var data = form.getData();
    var bankHandlingAmt = parseFloat(data.loanAmt || 0) * parseFloat(data.bankHandlingRate || 0) / 100; //银行利息=贷款金额*贷款利率(%)
    var totalAmt = bankHandlingAmt + parseFloat(data.agentDeposit || 0) + parseFloat(data.riskAmt || 0) + parseFloat(data.familyAmt || 0) +
        parseFloat(data.contractGuaranteeAmt || 0) + parseFloat(data.gpsAmt || 0) + parseFloat(data.mortgageAmt || 0) +
        parseFloat(data.insuranceBudgetAmt || 0) + parseFloat(data.purchaseBudgetAmt || 0) + parseFloat(data.boardLotAmt || 0) +
        parseFloat(data.otherAmt || 0) + parseFloat(data.decrAmt || 0); //费用合计 = 银行手续费+续保押金+月供保证金+家访费+合同保证金+GPS费用+按揭服务费+保险费预算+购置税预算+上户上牌费+其它费用+精品加装
    var buyBudgetTotal = parseFloat(data.saleAmt || 0) + totalAmt; //购车预算合计= 车辆销价+费用合计
    data.bankHandlingAmt = bankHandlingAmt;
    data.totalAmt = totalAmt;
    data.buyBudgetTotal = buyBudgetTotal;
    form.setData(data);
}