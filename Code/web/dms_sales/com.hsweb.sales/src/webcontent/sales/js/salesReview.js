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

function SetData(serviceId, type) {
    if (type == 1) { //已结算
        document.getElementById("toolbar").style.display = "none";
        var fields = form.getFields();
        for (var i = 0, l = fields.length; i < l; i++) {
            var c = fields[i];
            if (c.setReadOnly) c.setReadOnly(true); //只读
        };
    }
    var giftCost = 0;
    var receivedTotal = 0;//已收合计
    var receivedDeposit = 0;//已收定金
    var receivedBala = 0;//已收余额
    if(type != 1){//未结算的需要查找精品加装手动填写成本
    	 nui.ajax({
	        url: baseUrl + "sales.search.searchSaleGiftApply.biz.ext",
	        data: {
	        	billType:2,
	        	serviceId:serviceId
	        },
	        cache: false,
	        async: false,
	        success: function(text) {
	            if (text.errCode == "S"){
	               var gift = text.data;
	               if(gift.length>0){
	            	   for(var i = 0;i<gift.length;i++){
    	            	   var temp = gift[i];
    	            	   if(temp.receType==1){//计算收费的精品
    	            		   var costAmt = temp.costAmt || 0;
    	            		   giftCost = parseFloat(giftCost) + parseFloat(costAmt);
    	            		   giftCost.toFixed(2);
    	            	   }
    	               } 
	               }
	            } else {
	                
	            }
	        }
	    });
    	 nui.ajax({
 	        url: baseUrl + "sales.save.queryGiftItemCost.biz.ext",
 	        data: {
 	        	serviceId:serviceId
 	        },
 	        cache: false,
 	        async: false,
 	        success: function(text) {
 	            if (text.errCode == "S"){
 	               var item = text.data;
 	               if(item.length>0){
 	            	   for(var i = 0;i<item.length;i++){
     	            	   var temp = item[i];
 	            		   var totalAmt = temp.totalAmt || 0;//总金额(总成本 = 配件成本+工时成本）
 	            		   giftCost = parseFloat(giftCost) + parseFloat(totalAmt);
 	            		   giftCost.toFixed(2);
     	               } 
 	               }
 	            } 
 	        }
 	    });
    	 //查找已结算的预收金额
    	 nui.ajax({
  	        url: baseUrl + "sales.search.queryFisRpAdvance.biz.ext",
  	        data: {
  	        	codeId:serviceId
  	        },
  	        cache: false,
  	        async: false,
  	        success: function(text) {
  	            if (text.errCode == "S"){
  	               var fisRpAdvanceList = text.fisRpAdvanceList;
  	               if(fisRpAdvanceList.length>0){
  	            	   for(var i = 0;i<fisRpAdvanceList.length;i++){
      	            	   var temp = fisRpAdvanceList[i];
  	            		   var amt = temp.amt || 0;//总金额(总成本 = 配件成本+工时成本）
  	            		   receivedTotal = parseFloat(receivedTotal) + parseFloat(amt);
  	            		   receivedTotal.toFixed(2);
  	            		   
      	               } 
  	               }
  	            } 
  	        }
  	    });
    }
    
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
                if(type != 1){
                	//设置精品加装成本
                	nui.get("decrCost").setValue(giftCost);
                	nui.get("receivedTotal").setValue(receivedTotal);
                	//未收余款
                	var buyBudgetTotal = data.buyBudgetTotal;
                	var ykAmt = parseFloat(buyBudgetTotal) + parseFloat(receivedTotal);
                	nui.get("receivedBalaNo").setValue(ykAmt);
                }
                changeValueMsg(1);
            } else {
                showMsg(text.errCode, "E");
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
    var totalGrossProfitRate = (totalCost / receTotal).toFixed(2);
    data.totalGrossProfitRate = totalGrossProfitRate;
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
    data.remark = data.remarka;
    var isValid = form.isValid();
    if (isValid == false) {
        showMsg("请输入正确的数字后再保存！", "W");
        return;
    }
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });
    nui.ajax({
        url: baseUrl + "sales.save.saveSaleExtend.biz.ext",
        data: {
            data: data
        },
        cache: false,
        async: false,
        success: function(text) {
            if (text.errCode == "S") {
                showMsg("保存成功", "S");
            }else{
            	 showMsg(text.errMsg, "E");
            };
            nui.unmask(document.body);
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
            saleExtend: data
        },
        cache: false,
        async: false,
        success: function(text) {
            if (text.errCode == "S") {
                showMsg(text.errMsg, "S");
                close();
            } else {
                showMsg(text.errMsg, "W");
            }
        }
    });

}

function close() {
    window.CloseOwnerWindow('');
}