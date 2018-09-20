var packageGrid = null;
var itemGrid = null;
var partGrid = null;
var sellForm = null;
$(document).ready(function(v) {
	sellForm = new nui.Form("#sellForm");
	

});


function getData(data){
		// 跨页面传递的数据对象，克隆后才可以安全使用
		data = data||{};
		var json = nui.clone(data);
		
/*		var guestName = rows[0].guestName;
		var json = {
				guestId:rows[0].guestId,
				token : token
		}
		
		nui.ajax({
			url : baseUrl
			+ "com.hsapi.repair.baseData.query.queryMemberByGuestId.biz.ext" ,
			type : "post",
			data : json,
			cache : false,
			success : function(data) {
				rechargeBalaAmt = data.member[0].rechargeBalaAmt;
				document.getElementById('settleGuestName').innerHTML = "结算单位："
					+ guestName;
			document.getElementById('settleBillCount').innerHTML = "结算单据数：" + s;
			document.getElementById('rRPAmt').innerHTML = rtn.rRPAmt;
			document.getElementById('rTrueAmt').innerHTML = rtn.rTrueAmt;
			document.getElementById('rVoidAmt').innerHTML = rtn.rVoidAmt;
			document.getElementById('rNoCharOffAmt').innerHTML = rtn.rNoCharOffAmt;
			document.getElementById('pRPAmt').innerHTML = rtn.pRPAmt;
			document.getElementById('pTrueAmt').innerHTML = rtn.pTrueAmt;
			document.getElementById('pVoidAmt').innerHTML = rtn.pVoidAmt;
			document.getElementById('pNoCharOffAmt').innerHTML = rtn.pNoCharOffAmt;
			document.getElementById('rpAmt').innerHTML = rtn.rpAmt;
			//document.getElementById('rechargeBalaAmt').innerHTML =rechargeBalaAmt;
			$("#rechargeBalaAmt").html(rechargeBalaAmt+"元");
			
			settleAccountGrid.setData([]);
			addSettleAccountRow();
			},
			error : function(jqXHR, textStatus, errorThrown) {
				// nui.alert(jqXHR.responseText);
				console.log(jqXHR.responseText);
			}
		});*/

		sellForm.setData(json);
}
function onPayOk(){
	packageGrid.getData();
	itemGrid.getData();
	partGrid.getData();
	
}