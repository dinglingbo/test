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
        changeValueMsg(1);
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
                    nui.get("loanPercent").disable(); //贷款比例
                }
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
    if (e.value == "1558580770894") { //全款
        nui.get("loanPeriod").disable(); //贷款期数
        nui.get("signBillBankId").disable(); //贷款银行
        nui.get("loanPercent").disable(); //贷款比例
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
        nui.get("loanPercent").enable(); //贷款比例
    }
}

function changeValueMsg(e) { //更改数据信息时触发  统一触发此函数
    var data = form.getData();
    var saleAmt = parseFloat(data.saleAmt); //车辆销价
    var loanPercent = parseFloat(data.loanPercent) / 10; //贷款比例
    var loanAmt = parseFloat(data.loanAmt); //贷款金额
    var loanPeriod = parseFloat(data.loanPeriod || 0); //贷款期数
    var downPaymentAmt = parseFloat(data.downPaymentAmt || 0); //首付金额
    var bankHandlingRate = parseFloat(data.bankHandlingRate || 0) / 100; //贷款利率
    var bankHandlingApportion = data.bankHandlingApportion; //利息是否分摊  0是  1否
    var bankHandlingAmt = parseFloat(data.bankHandlingAmt || 0); //银行利息
    var monthMoneyRates = 0; //每月利息
    var monthPayAmt = parseFloat(data.monthPayAmt || 0); //月供
    loanAmt = Math.floor(saleAmt * loanPercent / 1000) * 1000; //贷款金额 = 车辆销价 * 贷款比例   舍去千位一下的金额 取整 如142222 变为142000
    bankHandlingAmt = loanAmt * bankHandlingRate; //银行利息 = 贷款金额*贷款利率(%)
    if (bankHandlingApportion == 0) { //如果利息分摊
        monthMoneyRates = bankHandlingAmt / loanPeriod; // 每月利息 = 银行利息 / 贷款期数
        monthPayAmt = loanAmt / loanPeriod + monthMoneyRates; // 月供 = 贷款金额 / 贷款期数 + 每月利息
        downPaymentAmt = (saleAmt - loanAmt) + monthMoneyRates; // 首付 = （车辆销价 - 贷款金额）+ 每月利息
    } else {
        monthPayAmt = bankHandlingAmt; // 月供 = 贷款金额 / 贷款期数 + 每月利息
        downPaymentAmt = (saleAmt - loanAmt) + bankHandlingAmt; // 首付 = （车辆销价 - 贷款金额）+ 每月利息
    }
    var totalAmt = bankHandlingAmt + parseFloat(data.agentDeposit || 0) + parseFloat(data.riskAmt || 0) + parseFloat(data.familyAmt || 0) +
        parseFloat(data.contractGuaranteeAmt || 0) + parseFloat(data.gpsAmt || 0) + parseFloat(data.mortgageAmt || 0) +
        parseFloat(data.insuranceBudgetAmt || 0) + parseFloat(data.purchaseBudgetAmt || 0) + parseFloat(data.boardLotAmt || 0) +
        parseFloat(data.otherAmt || 0) + parseFloat(data.decrAmt || 0); //费用合计 = 银行手续费+续保押金+月供保证金+家访费+合同保证金+GPS费用+按揭服务费+保险费预算+购置税预算+上户上牌费+其它费用+精品加装
    var buyBudgetTotal = parseFloat(data.saleAmt || 0) + totalAmt; //购车预算合计= 车辆销价+费用合计

    data.monthPayAmt = monthPayAmt;
    data.loanAmt = loanAmt;
    data.downPaymentAmt = downPaymentAmt;
    data.bankHandlingAmt = bankHandlingAmt;
    data.totalAmt = totalAmt;
    data.buyBudgetTotal = buyBudgetTotal;
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
    }
}

var comeServiceIdF= null;
var saveComeUrl = baseUrl + "sales.save.saveSaleCalc.biz.ext";
function setShowSave(serviceId){
	comeServiceIdF = serviceId;
	var showSave =document.getElementById("showSave");
	showSave.style.display="";
	if(serviceId){
		nui.ajax({
	        url: baseUrl + "sales.search.searchSaleCalc.biz.ext",
	        type: "post",
	        cache: false,
	        data: {
	            billType: 1,
	            serviceId: serviceId
	        },
	        success: function(text) {
	            if (text.errCode == "S") {
	            	if(text.data.length>0){
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
	        }
	    });
	}else{
		showMsg("请先保存来访登记","W");
		return;
	}
}
//id没有返回
function saveCome(){
	var caCalculationData = form.getData();
	if(comeServiceIdF && comeServiceIdF <0){
		showMsg("请先保存来访登记","W");
		return;
	}else{
		caCalculationData.billType = 1;//来访登记的预算
		 var json = nui.encode({
			 caCalculationData:caCalculationData,
			 serviceId:comeServiceIdF,
	   		 token:token
	   	  });
		  nui.mask({
		     el: document.body,
		     cls: 'mini-mask-loading',
		     html: '保存中...'
		  });
		  nui.ajax({
			url : saveComeUrl,
			type : 'POST',
			data : json,
			cache : false,
			contentType : 'text/json',
			success : function(text) {
				if(text.errCode=="S"){
					var result = {}
					result = text.caCalculationData;
					var id = result.id;
					nui.get("mainId").setValue(id);
			    	showMsg("保存成功","S");
			    }
				nui.unmask(document.body);
			}
		  });
	}
}

function CloseWindow(action)
{
	if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else window.close();
}

function onCancel(){
	CloseWindow("cancel");
}