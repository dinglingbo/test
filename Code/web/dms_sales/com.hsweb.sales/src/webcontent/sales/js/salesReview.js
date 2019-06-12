var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + saleApi + "/";
var form = null;

$(document).ready(function(v) {
    form = new nui.Form("#form1");
    initDicts({
        saleType: '10392', //购车方式
        signBillBankId: "DDT20140530000001" //贷款银行
    });
});

function SetData(serviceId) {
    var params = { id: serviceId };
    nui.ajax({
        url: baseUrl + "sales.search.searchSalesMain.biz.ext",
        data: {
            params: params
        },
        cache: false,
        async: false,
        success: function(text) {
            if (text.errCode == "S") {
                var data = text.data[0];
                form.setData(data);
                nui.get("id").setValue(serviceId);
                changeValueMsg(1);
            } else {
                showMsg(text.errCode, "W");
            }
        }
    });
}

function changeValueMsg(e) { //值改变事件，统一触发此函数
    var data = form.getData();
    var saleGrossProfit = parseFloat(data.saleAmt || 0) - parseFloat(data.carCost || 0) - parseFloat(data.handcartAmt || 0); //车辆毛利 = 车辆销价 - 购买成本-运输费
    var insuranceDifferAmt = parseFloat(data.insuranceBudgetAmt || 0) - parseFloat(data.insuranceAmt || 0); //保险差额 = 保险费预算 - 实际保险费
    var agentGrossProfit = 0; //保险毛利
    var purchaseDifferAmt = parseFloat(data.purchaseBudgetAmt || 0) - parseFloat(data.purchaseAmt || 0); //购置税差额 = 购置税预算 - 实际购置税
    var differAmtTotal = Math.abs(insuranceDifferAmt) + Math.abs(purchaseDifferAmt); //差额合计 = 保险差额 + 购置税差额
    var boardLotGrossProfit = parseFloat(data.boardLotAmt || 0) - parseFloat(data.boardLotCost || 0); //上牌毛利 = 上牌费 - 上牌成本
    var gpsGrossProfit = parseFloat(data.gpsAmt || 0) - parseFloat(data.gpsCost || 0); //GPS毛利 = GPS费 - GPS成本
    var mortgageGrossProfit = parseFloat(data.mortgageAmt || 0) - parseFloat(data.mortgageCost || 0); //按揭毛利 = 按揭手续费 - 按揭成本
    var decrGrossProfit = parseFloat(data.decrAmt || 0) - parseFloat(data.decrCost || 0); //加装毛利 = 加装费 - 加装成本
    var familyGrossProfit = parseFloat(data.familyAmt || 0) - parseFloat(data.familyCost || 0); //家访毛利 = 家访费 - 家访成本
    var otherGrossProfit = parseFloat(data.otherAmt || 0) - parseFloat(data.otherCost || 0); //其他毛利 = 其他费 - 其他成本
    var totalGrossProfit = saleGrossProfit + agentGrossProfit + boardLotGrossProfit + gpsGrossProfit + mortgageGrossProfit + decrGrossProfit + familyGrossProfit + otherGrossProfit; //总毛利 = 车辆毛利+保险毛利+上牌毛利+GPS毛利+GPS毛利+按揭毛利+加装毛利+家访毛利+其他毛利
    var totalCost = parseFloat(data.carCost || 0) + parseFloat(data.boardLotCost || 0) + parseFloat(data.gpsCost || 0) + parseFloat(data.mortgageCost || 0) +
        parseFloat(data.decrCost || 0) + parseFloat(data.familyCost || 0) + parseFloat(data.otherCost || 0); //总成本 = 购买成本 + 上牌成本 + GPS成本 + 按揭成本 + 加装成本 + 家访成本 + 其他成本
    var receTotal = parseFloat(data.saleAmt || 0) + parseFloat(data.insuranceAmt || 0) + parseFloat(data.purchaseAmt || 0) +
        parseFloat(data.boardLotAmt || 0) + parseFloat(data.gpsAmt || 0) + parseFloat(data.mortgageAmt || 0) + parseFloat(data.decrAmt || 0) +
        parseFloat(data.familyAmt || 0) + parseFloat(data.otherAmt || 0); //购车总费用 = 车辆销价 + 实际保险费 + 实际购置税 + 上牌费 + GPS费 + 按揭手续费 + 加装费 + 家访费 + 其他费
    data.saleGrossProfit = saleGrossProfit;
    data.insuranceDifferAmt = insuranceDifferAmt;
    data.agentGrossProfit = agentGrossProfit;
    data.purchaseDifferAmt = purchaseDifferAmt;
    data.differAmtTotal = differAmtTotal;
    data.boardLotGrossProfit = boardLotGrossProfit;
    data.gpsGrossProfit = gpsGrossProfit;
    data.mortgageGrossProfit = mortgageGrossProfit;
    data.decrGrossProfit = decrGrossProfit;
    data.familyGrossProfit = familyGrossProfit;
    data.otherGrossProfit = otherGrossProfit;
    data.totalGrossProfit = totalGrossProfit;
    data.totalCost = totalCost;
    data.receTotal = receTotal;
    form.setData(data);
}

function save() {
    var data = form.getData();
    var isValid = form.isValid();
    if (isValid == false) {
        showMsg("请输入正确的数字后再保存！", "W");
        return;
    }
    nui.ajax({
        url: baseUrl + "sales.save.saveSaleExtend.biz.ext",
        data: {
            data: data
        },
        cache: false,
        async: false,
        success: function(text) {
            if (text.errCode == "S") {

                showMsg(text.errMsg, "S");
            };
        }
    });
}

function approved() { //审核通过   
    var data = form.getData();
    var isValid = form.isValid();
    if (isValid == false) {
        showMsg("请输入正确的数字后再保存！", "W");
        return;
    }
    nui.ajax({ //更改主表 isSettle为1 --- 已结算  未生成应收应付
        url: baseUrl + "sales.save.settlement.biz.ext",
        data: {
            saleMain: data,
            saleExtend: data
        },
        cache: false,
        async: false,
        success: function(text) {
            if (text.errCode == "S") {
                showMsg(text.errMsg, "S");
            } else {
                showMsg(text.errMsg, "W");
            }
        }
    });

}

function close() {
    window.CloseOwnerWindow('');
}