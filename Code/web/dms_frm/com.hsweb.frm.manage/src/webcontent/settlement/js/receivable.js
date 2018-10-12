
var baseUrl = apiPath + repairApi + "/";

$(document).ready(function (){
	
});

function setData(data){
	var rechargeBalaAmt = 0;
	nui.get("carNo").setValue(data[0].carNo);
	nui.get("guest").setValue(data[0].guestName);
	nui.get("totalAmt").setValue(data[0].nowAmt);
	var json = {
			guestId:data.guestId,
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
			nui.get("rechargeBalaAmt").setValue(rechargeBalaAmt);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}