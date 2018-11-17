var baseUrl = apiPath + frmApi + "/";
var settleAccountList = {};
var statusList = [];
var datagrid1 = null;
var sDate = null;
var eDate = null;
$(document).ready(function(v) {
	datagrid1 = nui.get("datagrid1");
	datagrid1.setUrl(querySummaryAccountBalances);
	sDate = nui.get("sDate");
	eDate = nui.get("eDate");
	sDate.setValue(getMonthStartDate());
	eDate.setValue(addDate(getMonthEndDate(), 1));
	setData();

	datagrid1.on("drawcell", function (e) {
        switch (e.field) {
            case "rpDc":
                if(e.value==1){
                    e.cellHtml = "应收";
                }else{
                	e.cellHtml = "应付";
                }
                break;
            default:
                break;
        }
        
    });
	
});


var queryFiSettleAccountUrl = baseUrl
+ "com.hsapi.frm.frmService.crud.queryFiSettleAccount.biz.ext";
function setData(){
	var params = [];
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
					statusList[i]={
							id:settleAccountList[i].id,
							name:settleAccountList[i].name
					}
				}
				nui.get("auditSign").setData(statusList);
				nui.get("auditSign").setValue(statusList[0].id);
				params.balaTypeId = statusList[0].id;
				datagrid1.load({
					params:{
						settAccountId:statusList[0].id
					},
			        token: token
			    });
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
	
}
var querySummaryAccountBalances = baseUrl
+ "com.hsapi.frm.frmService.crud.querySummaryAccountBalances.biz.ext";
function querySummaryAccountBalances(params){
	nui.ajax({
		url : querySummaryAccountBalances,
		data : {
			params:params,
			token: token
		},
		type : "post",
		success : function(data) {
			settleAccountList = data.settleAccount;
			if(isEmptyObject(settleAccountList)){
				
			}else{
				
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

function search(){
	var settAccountId = nui.get("auditSign").getValue();
	var startDate = nui.get("sDate").getValue();
	var endDate =nui.get("eDate").getValue();
	
	datagrid1.load({
		params:{
			settAccountId:settAccountId,
			startDate :startDate,
			endDate: endDate
		},
        token: token
    });
}