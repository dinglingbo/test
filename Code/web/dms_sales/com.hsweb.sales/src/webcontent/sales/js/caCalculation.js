var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + saleApi + "/";
var form = null;
$(document).ready(function(v) {
    form = new nui.Form("#form1");
    var calculate = "贷款利息=贷款金额*贷款利率(%)" +
        "\r\n费用合计= 按揭手续费+合同保证金+月供保证金+家访费+续保押金+GPS费用+上牌费+精品加装+其它费用+保险费预算+购置税预算" +
        "\r\n购车预算合计= 车型销价+费用合计"
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
        changeValueMsg(1);
    }
    return params;
}

function setSaleType(value) {
    var data = form.getData();
    data.saleType = value;
    form.setData(data);
    changeSaleType(1);
}

function SetDataMsg(serviceId, frameColorId, interialColorId) {
    var params = { billType: 2, serviceId: serviceId };
    nui.ajax({
        url: baseUrl + "sales.search.searchSaleCalc.biz.ext",
        type: "post",
        cache: false,
        data: {
            params: params
        },
        success: function(text) {
            if (text.errCode == "S") {
                var data = text.data[0];
                form.setData(data);
                if (data.saleType == "1558580770894") { //全款
                    changeSaleType(1);
                }
                if (!data.frameColorId) { //没值则取销售主表的颜色
                    nui.get("frameColorId").setValue(frameColorId);
                }
                if (!data.interialColorId) {
                    nui.get("interialColorId").setValue(interialColorId);
                }
                changeSaleType(1);
            }
        }
    });
}

function getBankHandlingRate(e) { //改变贷款银行时触发
    var value = e.selected.property1 || 0;
    nui.get("bankHandlingRate").setValue(value);
    changeValueMsg(1);
}

function changeSaleType(e) { //改变购买方式时触发
    var value = nui.get("saleType").value;
    if (value == "1558580770894") { //全款
        nui.get("loanPeriod").disable(); //贷款期数
        nui.get("signBillBankId").disable(); //贷款银行
        nui.get("loanPercent").disable(); //贷款比例
        nui.get("bankHandlingApportion").disable(); //银行利息分摊
        nui.get("mortgageAmt").disable(); //按揭手续费
        nui.get("riskAmt").disable(); //月供保证金
        nui.get("familyAmt").disable(); //家访费
        nui.get("contractGuaranteeAmt").disable(); //合同保证金

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
        nui.get("contractGuaranteeAmt").setValue(0); //合同保证金
    } else {
        nui.get("loanPeriod").enable(); //贷款期数
        nui.get("signBillBankId").enable(); //贷款银行
        nui.get("bankHandlingApportion").enable(); //银行利息分摊
        nui.get("mortgageAmt").enable(); //按揭手续费
        nui.get("riskAmt").enable(); //月供保证金
        nui.get("familyAmt").enable(); //家访费
        nui.get("loanPercent").enable(); //贷款比例
        nui.get("contractGuaranteeAmt").enable(); //合同保证金
    }
    changeValueMsg(1);
}

function changeValueMsg(e) { //更改数据信息时触发  统一触发此函数
    var data = form.getData();
    var saleAmt = parseFloat(data.saleAmt || 0); //车辆销价
    var loanPercent = parseFloat(data.loanPercent || 0) / 10; //贷款比例
    var loanAmt = parseFloat(data.loanAmt || 0); //贷款金额
    var loanPeriod = parseFloat(data.loanPeriod || 0); //贷款期数
    var downPaymentAmt = parseFloat(data.downPaymentAmt || 0); //首付金额
    var bankHandlingRate = parseFloat(data.bankHandlingRate || 0) / 100; //贷款利率
    var bankHandlingApportion = data.bankHandlingApportion; //利息是否分摊  0是  1否
    var bankHandlingAmt = parseFloat(data.bankHandlingAmt || 0); //银行利息
    var monthMoneyRates = 0; //每月利息
    var monthPayAmt = parseFloat(data.monthPayAmt || 0); //月供
    loanAmt = Math.floor(saleAmt * loanPercent / 1000 || 0) * 1000; //贷款金额 = 车辆销价 * 贷款比例   舍去千位已下的金额 取整 如142222 变为142000
    bankHandlingAmt = loanAmt * bankHandlingRate; //银行利息 = 贷款金额*贷款利率(%)
    if (bankHandlingApportion == 0) { //如果利息分摊
        if (loanPeriod == 0) {
            monthMoneyRates = 0;
            monthPayAmt = 0;
        } else {
            monthMoneyRates = bankHandlingAmt / loanPeriod || 0; // 每月利息 = 银行利息 / 贷款期数
            monthPayAmt = (loanAmt / loanPeriod || 0) + monthMoneyRates; // 月供 = 贷款金额 / 贷款期数 + 每月利息
        }
        downPaymentAmt = (saleAmt - loanAmt); // 首付 = 车辆销价 - 贷款金额
    } else {
        if (loanPeriod == 0) {
            monthPayAmt = 0;
        } else {
            monthPayAmt = (loanAmt / loanPeriod) || 0; // 月供 = 贷款金额 / 贷款期数 + 每月利息
        }
        downPaymentAmt = saleAmt - loanAmt + bankHandlingAmt; // 首付 = （车辆销价 - 贷款金额）+ 每月利息
    }
    var totalAmt = parseFloat(data.agentDeposit || 0) + parseFloat(data.riskAmt || 0) + parseFloat(data.familyAmt || 0) +
        parseFloat(data.contractGuaranteeAmt || 0) + parseFloat(data.gpsAmt || 0) + parseFloat(data.mortgageAmt || 0) +
        parseFloat(data.insuranceBudgetAmt || 0) + parseFloat(data.purchaseBudgetAmt || 0) + parseFloat(data.boardLotAmt || 0) +
        parseFloat(data.otherAmt || 0) + parseFloat(data.decrAmt || 0); //费用合计 = 续保押金+月供保证金+家访费+合同保证金+GPS费用+按揭服务费+保险费预算+购置税预算+上户上牌费+其它费用+精品加装
    var buyBudgetTotal = parseFloat(data.saleAmt || 0) + totalAmt; //购车预算合计= 车辆销价+费用合计
    var getCarTotal = downPaymentAmt + totalAmt;
    if (nui.get("saleType").value == "1558580770894") { //全款
        downPaymentAmt = 0;
        getCarTotal = buyBudgetTotal;
    }
    monthPayAmt = monthPayAmt.toFixed(2);
    data.monthPayAmt = monthPayAmt;
    data.loanAmt = loanAmt;
    data.downPaymentAmt = downPaymentAmt;
    data.bankHandlingAmt = bankHandlingAmt;
    data.totalAmt = totalAmt;
    data.buyBudgetTotal = buyBudgetTotal;
    data.getCarTotal = getCarTotal;
    form.setData(data);
}

function setDecrAmt(value) { //设置精品加装的值
    nui.get("decrAmt").setValue(value);
    changeValueMsg(1);
}

function setReadOnlyMsg() {
    var fields = form.getFields();
    for (var i = 0, l = fields.length; i < l; i++) {
        var c = fields[i];
        if (c.setReadOnly) c.setReadOnly(true); //只读
        if (c.setIsValid) c.setIsValid(true); //去除错误提示
    };
}

function setSelectCarValue(handcartAmt, carCost) { //选车之后将成本、运费赋值上来
    nui.get("handcartAmt").setValue(handcartAmt);
    nui.get("carCost").setValue(carCost);
}

function setInputModel() { //恢复表格为输入模式
    var fields = form.getFields();
    for (var i = 0, l = fields.length; i < l; i++) {
        var c = fields[i];
        if (c.setReadOnly) c.setReadOnly(false);
    };
}

function changeFrameColorId() {
    var data = form.getData();
    parent.changeFrameColorId(data.frameColorId);
}

function changeInterialColorId() {
    var data = form.getData();
    parent.changeInterialColorId(data.interialColorId);
}

var comeServiceIdF = null;
var statusF = null;
var saveComeUrl = baseUrl + "sales.save.saveSaleCalc.biz.ext";
var jpDetailGridUrl = baseUrl + "sales.search.searchSaleGiftApply.biz.ext";
var mainF = null

function setShowSave(params) {
    mainF = params;
    comeServiceIdF = params.id;
    statusF = params.status;
    var showSave = document.getElementById("showSave");
    var frameColorId = params.frameColorId;
    var interialColorId = params.interialColorId;
    showSave.style.display = "";
    if (params.show && params.show == 1) {
        document.getElementById("saveCome").style.display = "none";
    } else {
        document.getElementById("saveCome").style.display = "";
    }
    nui.get("saleType").setEnabled(true);
    if (comeServiceIdF) {
        var params = { billType: 1, serviceId: comeServiceIdF };
        nui.ajax({
            url: baseUrl + "sales.search.searchSaleCalc.biz.ext",
            type: "post",
            cache: false,
            async: false,
            data: {
                params: params
            },
            success: function(text) {
                if (text.errCode == "S") {
                    if (text.data.length > 0) {
                        var data = text.data[0];
                        form.setData(data);
                        if (data.saleType == "1558580770894") { //全款
                            nui.get("loanPeriod").disable(); //贷款期数
                            nui.get("signBillBankId").disable(); //贷款银行
                            nui.get("bankHandlingApportion").disable(); //银行利息分摊
                            nui.get("mortgageAmt").disable(); //按揭手续费
                            nui.get("riskAmt").disable(); //月供保证金
                            nui.get("familyAmt").disable(); //家访费
                            nui.get("loanPercent").disable(); //贷款比例
                        }
                    }
                }
                //颜色设置
                /*if(frameColorId){
                	//nui.get("frameColorId").setEnabled(false);
                	nui.get("frameColorId").setValue(frameColorId);
                }*/
                //有点问题
                if (frameColorId) { //没值则取销售主表的颜色
                    nui.get("frameColorId").setValue(frameColorId);
                }
                if (interialColorId) {
                    nui.get("interialColorId").setValue(interialColorId);
                }

            }
        });
        //查找精品加装费用
        nui.ajax({
            url: jpDetailGridUrl,
            type: "post",
            cache: false,
            async: false,
            data: {
                billType: 1,
                serviceId: comeServiceIdF
            },
            success: function(text) {
                if (text.errCode == "S") {
                    var giftData = text.data;
                    var amt = 0;
                    if (giftData.length > 0) {
                        for (var i = 0; i < giftData.length; i++) {
                            var temp = giftData[i];
                            if (temp.receType == 1) {
                                amt = amt + temp.amt;
                            }

                        }
                    }
                    if (amt > 0) {
                        nui.get("decrAmt").setValue(amt);
                    }
                    nui.get("decrAmt").setEnabled(false);
                    changeValueMsg();
                }

            }

        });
    } else {
        showMsg("请先保存来访登记", "W");
        return;
    }
}
//id没有返回
function saveCome() {
    var caCalculationData = form.getData();
    if (comeServiceIdF && comeServiceIdF < 0) {
        showMsg("请先保存来访登记", "W");
        return;
    } else if (statusF == 1) {
        showMsg("来访登记已归档不能修改", "W");
        return;
    } else if (statusF == 2) {
        showMsg("来访登记已转销售不能修改", "W");
        return;
    } else if (statusF == 3) {
        showMsg("来访登记已作废不能修改", "W");
        return;
    } else {
        var advanceChargeAmt = caCalculationData.advanceChargeAmt; //预付款
        var saleAmt = caCalculationData.saleAmt; //车型销价
        if (advanceChargeAmt > saleAmt) {
            showMsg("预付款金额不能大于车型销价金额！", "W");
        }
        caCalculationData.billType = 1; //来访登记的预算
        var json = nui.encode({
            caCalculationData: caCalculationData,
            serviceId: comeServiceIdF,
            token: token
        });
        nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '保存中...'
        });
        nui.ajax({
            url: saveComeUrl,
            type: 'POST',
            data: json,
            cache: false,
            contentType: 'text/json',
            success: function(text) {
                if (text.errCode == "S") {
                    var result = {}
                    result = text.caCalculationData;
                    var id = result.id;
                    nui.get("mainId").setValue(id);
                    //弹出打印界面
                    nui.confirm("是否打印购车预算", "友情提示", function(action) {
                        if (action == "ok") {
                            var saleType = caCalculationData.saleType;
                            if (saleType == "1558580770894") {
                                salesOnPrint(1);
                            } else {
                                salesOnPrint(2);
                            }
                        }
                    });
                    showMsg("保存成功", "S");
                }
                nui.unmask(document.body);
            }
        });
    }
}

function getSaleType() {
    var caCalculationData = form.getData();
    return caCalculationData;
}

function salesOnPrint(p) {
    var params = {};
    params.serviceId = mainF.id;
    params.billType = 1;
    params.guestFullName = mainF.fullName;
    params.carModelName = mainF.carModelName;
    params.carModelId = mainF.carModelId;
    var url = webPath + contextPath;
    switch (p) {
        case 1:
            url = url + "/sales/sales/print/cashPurchases.jsp";
            break;
        case 2:
            url = url + "/sales/sales/print/printLoanDetail .jsp";
            break;
    }
    nui.open({
        url: url,
        title: "打印",
        width: "100%",
        height: "100%",
        onload: function() {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.SetData(params);
        },
        ondestroy: function(action) {

        }
    });
}

function CloseWindow(action) {
    if (window.CloseOwnerWindow)
        return window.CloseOwnerWindow(action);
    else window.close();
}

function onCancel() {
    CloseWindow("cancel");
}