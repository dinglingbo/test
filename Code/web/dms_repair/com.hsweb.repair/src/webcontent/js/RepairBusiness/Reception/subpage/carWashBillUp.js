var packageGrid = null;
var itemGrid = null;
var partGrid = null;
var sellForm = null;
var fserviceId = 0;

var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
$(document).ready(function(v) {
	sellForm = new nui.Form("#sellForm");
});


function getData(data){
		// 跨页面传递的数据对象，克隆后才可以安全使用
		data = data||{};
		var data1 = nui.clone(data);
		fserviceId = data.fserviceId;
		data1.data.amount=data1.data.mtAmt;
		data1.data.payType = "020101";
		var json = {
				guestId:data1.xyguest.guestId,
				token : token
		}
		
		nui.ajax({
			url : baseUrl
			+ "com.hsapi.repair.baseData.query.queryMemberByGuestId.biz.ext" ,
			type : "post",
			data : json,
			async: false,
			success : function(data) {
				if(data.member.length==0){
					data1.data.rechargeBalaAmt=0;
				}else{
					data1.data.rechargeBalaAmt = data.member[0].rechargeBalaAmt;
				}

			},
			error : function(jqXHR, textStatus, errorThrown) {
				// nui.alert(jqXHR.responseText);
				console.log(jqXHR.responseText);
			}
		});

		sellForm.setData(data1.data);
}


function onChanged() {
	var data = sellForm.getData();
	var deductible = nui.get("deductible").getValue();
	var PrefAmt = nui.get("PrefAmt").getValue();
	
	if(deductible==""){
		deductible=0;
	}
	if(PrefAmt==""){
		PrefAmt=0;
	}
	if(deductible>data.rechargeBalaAmt){
		showMsg("储值抵扣不能大于储值余额","W");
		nui.get("deductible").setValue(0);
		var deductible = nui.get("deductible").getValue();
		var PrefAmt = nui.get("PrefAmt").getValue();
		var amount = data.mtAmt-deductible-PrefAmt;
		nui.get("amount").setValue(amount.toFixed(2));
		return;
	}
	if(deductible>data.mtAmt){
		showMsg("储值抵扣不能大于应收金额","W");
		nui.get("deductible").setValue(0);
		var deductible = nui.get("deductible").getValue();
		var PrefAmt = nui.get("PrefAmt").getValue();
		var amount = data.mtAmt-deductible-PrefAmt;
		nui.get("amount").setValue(amount.toFixed(2));
		return;
	}
	if(PrefAmt>data.mtAmt){
		showMsg("优惠金额不能大于应收金额","W");
		nui.get("PrefAmt").setValue(0);
		var deductible = nui.get("deductible").getValue();
		var PrefAmt = nui.get("PrefAmt").getValue();
		var amount = data.mtAmt-deductible-PrefAmt;
		nui.get("amount").setValue(amount.toFixed(2));
		return;
	}
		var deductible = nui.get("deductible").getValue();
		var PrefAmt = nui.get("PrefAmt").getValue();
		var amount = data.mtAmt-deductible-PrefAmt;
		nui.get("amount").setValue(amount.toFixed(2));
	


} 

function noPay(){
	var data = sellForm.getData();
	doNoPay(fserviceId,data.mtAmt);
}

function pay(){
	var data = sellForm.getData();
	var json = {
			allowanceAmt:data.PrefAmt,
			cardPayAmt:data.deductible,
			serviceId:fserviceId,
			payType:data.payType,
			payAmt:data.amount
	};
    nui.confirm("结算金额:"+data.amount+"元,确定结算吗?", "友情提示",function(action){
	       if(action == "ok"){
			    nui.mask({
			        el : document.body,
				    cls : 'mini-mask-loading',
				    html : '处理中...'
			    });
	    		nui.ajax({
	    			url : baseUrl
	    			+ "com.hsapi.repair.repairService.settlement.receiveSettle.biz.ext" ,
	    			type : "post",
	    			data : json,
			        cache : false,
			        contentType : 'text/json',
	    			success : function(data) {
	    				nui.unmask(document.body);
	    				if(data.errCode=="S"){
	    					showMsg(data.errMsg,"S");
	    				}else{
	    					showMsg(data.errMsg,"W");
	    				}

	    			},
	    			error : function(jqXHR, textStatus, errorThrown) {
	    				// nui.alert(jqXHR.responseText);
	    				console.log(jqXHR.responseText);
	    			}
	    		});	
	     }else {
				return;
		 }
	});
}