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
    var params = {};
    var data = form.getData();
    var isValid = form.isValid();
    params = {
        data: data,
        isValid: isValid
    };
    if (isValid) {
        calculate();
    }
    return params;
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
                var data = text.data[0];
                form.setData(data);
                if (data.saleType == "1558580770894") { //全款
                    nui.get("loanPeriod").disable(); //贷款期数
                    nui.get("signBillBankId").disable(); //贷款银行
                    nui.get("bankHandlingApportion").disable(); //银行利息分摊
                    nui.get("mortgageAmt").disable(); //按揭手续费
                    nui.get("riskAmt").disable(); //月供保证金
                    nui.get("familyAmt").disable(); //家访费
                }
            }
        }
    });
}

function getBankHandlingRate(e) { //改变贷款银行时触发
    var value = e.selected.property1 || 0;
    nui.get("bankHandlingRate").setValue(value);
    calculate();
}

function changeSaleType(e) { //改变购买方式时触发
    if (e.value == "1558580770894") { //全款
        nui.get("loanPeriod").disable(); //贷款期数
        nui.get("signBillBankId").disable(); //贷款银行
        nui.get("bankHandlingApportion").disable(); //银行利息分摊
        nui.get("mortgageAmt").disable(); //按揭手续费
        nui.get("riskAmt").disable(); //月供保证金
        nui.get("familyAmt").disable(); //家访费

        nui.get("loanPercent").setValue(0); //贷款利率
        nui.get("loanAmt").setValue(0); //贷款金额
        nui.get("loanPeriod").setValue(0); //贷款期数
        nui.get("downPaymentAmt").setValue(0); //贷款利率
        nui.get("downPaymentAmt").setValue(0); //首付金额
        nui.get("signBillBankId").setValue(""); //贷款银行
        nui.get("bankHandlingRate").setValue(0); //贷款利率(%)
        nui.get("bankHandlingApportion").setValue(1); //银行利息分摊
        nui.get("bankHandlingAmt").setValue(0); //贷款利息
        nui.get("monthPayAmt").setValue(0); //月供
        nui.get("mortgageAmt").setValue(0); //按揭手续费
        nui.get("riskAmt").setValue(0); //月供保证金
        nui.get("familyAmt").setValue(0); //家访费
    } else {
        nui.get("loanPeriod").enable(); //贷款期数
        nui.get("signBillBankId").enable(); //贷款银行
        nui.get("bankHandlingApportion").enable(); //银行利息分摊
        nui.get("mortgageAmt").enable(); //按揭手续费
        nui.get("riskAmt").enable(); //月供保证金
        nui.get("familyAmt").enable(); //家访费
    }
}

function changeLoanPercent(e) { //贷款比例更改时触发
    var data = form.getData();
    var saleAmt = data.saleAmt; //车辆销价
    var loanPercent = data.loanPercent; //贷款比例
    var loanAmt = parseFloat(saleAmt) * parseFloat(loanPercent) / 10; //贷款金额
    loanAmt = Math.floor(loanAmt / 1000) * 1000;
    data.loanAmt = loanAmt;
    var downPaymentAmt = parseFloat(saleAmt) - loanAmt; //首付金额
    if (data.bankHandlingApportion == 0) { //分摊利息
        var bankHandlingAmt = parseFloat(data.bankHandlingAmt || 0); //银行利息
        var loanPeriod = parseFloat(data.loanPeriod || 0); //分期数
        var monthMoney = bankHandlingAmt / loanPeriod; // 每月利息
        downPaymentAmt = downPaymentAmt + monthMoney;
        data.downPaymentAmt = downPaymentAmt;
        var monthPayAmt = (saleAmt - downPaymentAmt) / loanPeriod + monthMoney; //月供 = （车辆销价 - 首付）/分期数 + 每月利息
        data.monthPayAmt = monthPayAmt;
    } else { //利息不分期
        var bankHandlingAmt = parseFloat(data.bankHandlingAmt || 0); //银行利息
        downPaymentAmt = downPaymentAmt + bankHandlingAmt;
        data.downPaymentAmt = downPaymentAmt;
        var loanPeriod = parseFloat(data.loanPeriod || 0); //分期数
        var monthPayAmt = (saleAmt - downPaymentAmt) / loanPeriod; //月供 = （车辆销价 - 首付）/分期数
        data.monthPayAmt = monthPayAmt;
    }

    form.setData(data);
    calculate();
}

function calculate() { //开始计算
    var data = form.getData();
    var bankHandlingAmt = (parseFloat(data.loanAmt || 0) * parseFloat(data.bankHandlingRate || 0) / 100) || 0; //银行利息=贷款金额*贷款利率(%)
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

function setDecrAmt(value) { //设置精品加装的值
    nui.get("decrAmt").setValue(value);
    calculate();
}