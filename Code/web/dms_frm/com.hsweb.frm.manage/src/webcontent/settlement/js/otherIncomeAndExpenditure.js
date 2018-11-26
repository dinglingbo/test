var baseUrl = apiPath + frmApi + "/";
var datagrid1 = null;
var queryOtherIncomeAndExpenditureUrl = baseUrl
+ "com.hsapi.frm.setting.queryOtherIncomeAndExpenditure.biz.ext";
var statusList = [{id:"4",name:"全部"},{id:"0",name:"未结算"},{id:"1",name:"部分结算"},{id:"2",name:"全部结算"}];
var statusList1 = [{id:"4",name:"全部"},{id:"1",name:"已审核"},{id:"0",name:"未审核"}];
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
    params.guestName = nui.get("advanceGuestId").getValue();
    if(nui.get("auditSign").getValue()==4){
    	
    }else{
    	params.auditSign=nui.get("auditSign").getValue();
    }
    if(nui.get("settleStatus").getValue()==4){
    	
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


function selectSupplier(elId) {
    supplier = null;
    nui.open({
        targetWindow : window,
        url : webPath+contextPath+"/com.hsweb.part.common.guestSelect.flow?token="+token,
        title : "客户资料",
        width : 980,
        height : 560,
        allowDrag : true,
        allowResize : true,
        onload : function() {
            var iframe = this.getIFrameEl();
            var params = {
                isClient: 1
            };
            iframe.contentWindow.setGuestData(params);
        },
        ondestroy : function(action) {
            if (action == 'ok') {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();

                supplier = data.supplier;
                var value = supplier.id;
                var text = supplier.fullName;
                var el = nui.get(elId);
                el.setValue(value);
                el.setText(text);

            }
        }
    });
}
