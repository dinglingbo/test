
var baseUrl = apiPath + repairApi + "/";
var frmUrl = apiPath + frmApi + "/";
var netInAmt = 0;
$(document).ready(function (){
	
});

function setData(data){
	var rechargeBalaAmt = 0;
	document.getElementById('carNo').innerHTML = data[0].carNo;
	document.getElementById('guest').innerHTML = data[0].guestName;
	document.getElementById('totalAmt').innerHTML = "￥"+data[0].nowAmt;
	document.getElementById('totalAmt1').innerHTML = data[0].nowAmt;
	document.getElementById('amount').innerHTML = data[0].nowAmt;
	netInAmt = data[0].nowAmt;
	var json = {
			guestId:data[0].guestId,
			token : token
	}
	
	nui.ajax({
		url : apiPath + repairApi + "/com.hsapi.repair.baseData.query.queryMemberByGuestId.biz.ext" ,
		type : "post",
		data : json,
		success : function(data) {
			if(data.member.length==0){
				rechargeBalaAmt=0;
			}else{	
				rechargeBalaAmt = data.member[0].rechargeBalaAmt;
			}
			nui.get("rechargeBalaAmt").setValue("￥"+rechargeBalaAmt); 
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
	nui.ajax({
		url : apiPath + frmApi + "/com.hsapi.frm.frmService.crud.queryFiSettleAccount.biz.ext?token="+ token,
		type : "post",
		data : "",
		success : function(data) {
			var optaccount = document.getElementById('optaccount');
			//optaccount.options[0].value = 0;
			//optaccount.options[0].text = "请选择..";
			for (var i = 0; i < data.settleAccount.length; i++) {
			optaccount.options[i].value = 0;
			optaccount.options[i].text = data.settleAccount[i];
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}

function onChanged() {
	var deductible = nui.get("deductible").getValue()||0;
	var PrefAmt = nui.get("PrefAmt").getValue()||0;
	var memAmt = nui.get("rechargeBalaAmt").getValue()||0;
	memAmt = (memAmt.split("￥"))[1];

	if(deductible>memAmt){
		nui.alert("储值抵扣不能大于储值余额","提示");
		nui.get("deductible").setValue(0);
		nui.get("PrefAmt").setValue(0);
		return;
	}
	if(parseFloat(deductible) + parseFloat(PrefAmt) > netInAmt){
		nui.alert("储值抵扣加上优惠金额不能大于应收金额","提示");
		nui.get("deductible").setValue(0);
		nui.get("PrefAmt").setValue(0);
		return;
	}
	
	var amount = parseFloat(netInAmt) - parseFloat(deductible) - parseFloat(PrefAmt);
	document.getElementById('amount').innerHTML = amount;

}

function addF(){
	var deductible = nui.get("deductible").getValue()||0;
	var PrefAmt = nui.get("PrefAmt").getValue()||0;
	var memAmt = nui.get("rechargeBalaAmt").getValue()||0;


}