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
	
	if(deductible>data.rechargeBalaAmt){
		nui.alert("储值抵扣不能大于储值余额","提示");
		nui.get("deductible").setValue(0);
		return;
	}
	if(PrefAmt>data.mtAmt){
		nui.alert("优惠金额不能大于应收金额","提示");
		nui.get("PrefAmt").setValue(0);
		return;
	}
	if(deductible==""){
		deductible=0;
	}
	if(PrefAmt==""){
		PrefAmt=0;
	}
	var amount = data.mtAmt-deductible-PrefAmt;
	nui.get("amount").setValue(amount);

}

function noPay(){
	// 跨页面传递的数据对象，克隆后才可以安全使用
	var data = sellForm.getData();
	var json = {
			serviceId:fserviceId,
			allowanceAmt:data.PrefAmt
	}
	
	nui.ajax({
		url : baseUrl
		+ "com.hsapi.repair.repairService.settlement.preReceiveSettle.biz.ext" ,
		type : "post",
		data : json,
		async: false,
		success : function(data) {
			if(data.errCode=="S"){
				nui.alert(data.errMsg,"提示");
			}else{
				nui.alert(data.errMsg,"提示");
			}

		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});

	sellForm.setData(data1.data);
}