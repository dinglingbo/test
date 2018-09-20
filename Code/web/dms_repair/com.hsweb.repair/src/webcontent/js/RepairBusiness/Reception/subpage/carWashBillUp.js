var packageGrid = null;
var itemGrid = null;
var partGrid = null;
var sellForm = null;
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
$(document).ready(function(v) {
	sellForm = new nui.Form("#sellForm");
	

});


function getData(data){
		// 跨页面传递的数据对象，克隆后才可以安全使用
		data = data||{};
		var data1 = nui.clone(data);
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
function onPayOk(){
	packageGrid.getData();
	itemGrid.getData();
	partGrid.getData();
	
}

function onChanged() {
	var data = sellForm.getData();
	var dk = nui.get("dk").getValue();
	if(dk>data.rechargeBalaAmt){
		nui.alert("储值抵扣不能大于储值余额","提示");
		nui.get("dk").setValue(0);
		return;
	}
	if(dk==""){
		dk=0;
	}
	var amount = data.mtAmt-dk;
	nui.get("amount").setValue(amount);

}