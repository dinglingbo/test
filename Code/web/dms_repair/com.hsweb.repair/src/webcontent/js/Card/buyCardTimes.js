var form2 = null;
var sellAmt = null;
//页面标签加载完之后执行，但是修改的数据还没有设置
$(document).ready(function(v) {
	form2 = new nui.Form("#dataform2");
	sellAmt = nui.get("sellAmt");
});

var rpbCardTimes = null;
function giveData(data)
{
    rpbCardTimes = nui.clone(data);
    sellAmt.setValue(rpbCardTimes.sellAmt);
}


function selectCustomer() {
    openCustomerWindow(function (v) {
       
    	contactorName = mini.get("contactorName");	
       var  main = form2.getData();
        main.guestId = v.guestId;
        main.contactorName = v.guestFullName;
        contactorName.setText(v.guestFullName);
        form2.setData(main);
       // $("#contactorName").setValue(v.guestFullName);
    });
}

function openCustomerWindow(callback) {
    nui.open({
        url: "com.hsweb.RepairBusiness.Customer.flow",
        title: "客户选择", width: 800, height: 450,
        onload: function () {
        },
        ondestroy: function (action) {
            if ("ok" == action) {
                var iframe = this.getIFrameEl();
                //调用子界面的方法，返回子界面的数据
                var data = iframe.contentWindow.getData();
                var guest = data.guest;
                callback && callback(guest);
            }
        }
    });
}


var payType = {
		'020101':'现金',
		'020102':'刷卡',
	    '020104':'微信/支付宝'		
};


var payMeth = apiPath + repairApi + "/com.hsapi.repair.repairService.settlement.receiveCardTimes.biz.ext";
function payOk(){	
	var data = form2.getData();
	var rpbCard = rpbCardTimes;
    var payAmt = null;
	if(data.contactorName){
		var cardTimes ={
			guestId:data.guestId,
			guestName:data.contactorName,
			cardId:rpbCard.id,
			cardName:rpbCard.name,
			periodValidity:rpbCard.periodValidity,
			salesDeductType:rpbCard.salesDeductType,
			remark:rpbCard.remark,
			salesDeductValue:rpbCard.salesDeductValue,
			sellAmt:rpbCard.sellAmt,
			totalAmt:rpbCard.totalAmt,
			useRemark:rpbCard.useRemark
	    };
	//整理数据
	    payAmt = rpbCard.sellAmt;
	    var json = nui.encode({
		    "payAmt":payAmt,
		    "payType":data.payType,
		    "cardTimes":cardTimes,
		    token:token
	  });
		//提示框 
		//判断客户有没有选择
	    nui.confirm("结算金额【"+payAmt+"】元,确定以【"+payType[data.payType]+"】结算吗？", "友情提示",function(action){
	       if(action == "ok"){
			    nui.mask({
			        el : document.body,
				    cls : 'mini-mask-loading',
				    html : '处理中...'
			    });
		        nui.ajax({
				    url : payMeth,
				    type : 'POST',
			        data : json,
			        cache : false,
			        contentType : 'text/json',
			        success : function(text) {		
			            nui.unmask(document.body);
				        var returnJson = nui.decode(text);
				        if (returnJson.errCode == "S") {
				            nui.alert("结算成功", "系统提示");
				        }
				        else {
				            nui.alert("结算失败:"+returnJson.errMsg, "系统提示");
				        }
				   }				        	  
			  });		
	     }else {
				return;
		 }
		 });

	}else{
		nui.alert("请选择客户", "提示");
		
	}	
	
}


