var baseUrl = apiPath + frmApi + "/";
var settleAccountList = {};
var statusList = [{id:"0",name:"所有"}];
$(document).ready(function(v) {
	setData();

});


var queryFiSettleAccountUrl = baseUrl
+ "com.hsapi.frm.frmService.crud.queryFiSettleAccount.biz.ext";
function setData(){
	nui.ajax({
		url : queryFiSettleAccountUrl,
		data : {
			token: token
		},
		type : "post",
		success : function(data) {
			settleAccountList = data.settleAccount;
			if(isEmptyObject(settleAccountList)){
				
			}else{
				for(var i =0;i<settleAccountList.length;i++){
					statusList[i+1]={
							id:settleAccountList[i].id,
							name:settleAccountList[i].name
					}
				}
				nui.get(auditSign).setData(statusList);
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
	
}


function isEmptyObject (obj){
	for(var key in obj ){
		return false;
	}
	return true;
}