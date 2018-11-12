var baseUrl = apiPath + frmApi + "/";
var datagrid1 = null;
var queryOtherIncomeAndExpenditureUrl = baseUrl
+ "com.hsapi.frm.setting.queryOtherIncomeAndExpenditure.biz.ext";
var statusList = [{id:"0",name:"全部"},{id:"1",name:"未结算"},{id:"2",name:"部分结算"},{id:"3",name:"全部结算"}];
var statusList1 = [{id:"0",name:"全部"},{id:"1",name:"已审批"},{id:"2",name:"未审批"}];
var statusList2 = [{id:"0",name:"发生日期"},{id:"1",name:"审核日期"}];

var auditSignHash = {
	    "0" : "未审核",
	    "1" : "已审核"
	};
var settleStatusHash = {
	    "0" : "未结算",
	    "1" : "部分结算",
	    "2" : "全部结算"
	};


$(document).ready(function(v) {
	datagrid1 = nui.get("datagrid1");
	datagrid1.setUrl(queryOtherIncomeAndExpenditureUrl);
    search();
    datagrid1.on("drawcell", function (e) {
        if (e.field == "status") {
            e.cellHtml = statusHash[e.value];
        }else if (e.field == "auditSign") {
            if (auditSignHash && auditSignHash[e.value]) {
                e.cellHtml = auditSignHash[e.value];
            }
        }else if (e.field == "settleStatus") {
            if (settleStatusHash && settleStatusHash[e.value]) {
                e.cellHtml = settleStatusHash[e.value];
            }
        }else if(e.field == "billDc"){
            if(e.value == 1){
                e.cellHtml = "应收";
            }else{
                e.cellHtml = "应付";
            }
        }
    });
});



function search() {
    var params = {};
    params.guestName = nui.get("guestName").getValue();
    if(nui.get("auditSign").getValue()==0){
    	
    }else{
    	params.auditSign=nui.get("auditSign").getValue();
    }
    if(nui.get("settleStatus").getValue()==0){
    	
    }else{
    	params.settleStatus=nui.get("settleStatus").getValue();
    }
    
    var type = nui.get("search-date").getValue();
    if(type==0){
    	params.screateDate = nui.get("sDate").getValue();
    	params.ecreateDate = nui.get("eDate").getValue();
    }else if(type==1){
    	params.sauditDate = nui.get("sDate").getValue();
    	params.eauditDate = nui.get("eDate").getValue();
    }
    datagrid1.load({params:params,token:token});
}


	
