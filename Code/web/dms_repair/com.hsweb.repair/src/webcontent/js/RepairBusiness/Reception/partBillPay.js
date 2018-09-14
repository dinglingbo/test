var form = null;
var partAmt = null;
//页面标签加载完之后执行，但是修改的数据还没有设置
$(document).ready(function(v) {
	form = new nui.Form("#dataform");
	partAmt = nui.get("partAmt");
	amt = nui.get("amt")
});

var maintain = null;
function getData(data)
{
    var data = nui.clone(data);
    partAmt.setValue(data.partAmt);
    amt.setValue(data.partAmt);
    maintain = data;
}

function onChanged(e){
	var formData = form.getData();
	var pAmt = formData.partAmt; 
	var yz = /^(\d*)(\.\d{1,2})?$/;
	if(!yz.test(e.value)){
		showMsg("优惠金额必须为正数,小数点后最多两位!", "W");
		return;
	}else{
		var amtR = pAmt - e.value;
	    amt.setValue(amtR);

	}
	
}


var payType = {
		'020101':'现金',
		'020102':'刷卡',
	    '020104':'微信/支付宝'		
};


var partPayUrl = apiPath + repairApi + "/com.hsapi.repair.repairService.settlement.partBay.biz.ext";
function payOk(){	
	var fdata = form.getData();
    //maintain
	var sum = parseFloat(fdata.rateAmt)+parseFloat(fdata.amt);
	if(maintain.partAmt != sum){
		showMsg("实付金额和应付金额不符");
		return;
	}else{
		
		 var json = nui.encode({
			    "maintain":maintain,
			    "amt":fdata.amt,
			    token:token
		 });
		
		 nui.ajax({
			    url : partPayUrl,
			    type : 'POST',
		        data : json,
		        cache : false,
		        contentType : 'text/json',
		        success : function(text) {		
			        var returnJson = nui.decode(text);
			        if (returnJson.errCode == "S") {
			        	showMsg("结算成功!","S");
			        }
			        else {
			        	showMsg("结算失败!","W");
			        }
			   }				        	  
		  });		
	} 	
}
