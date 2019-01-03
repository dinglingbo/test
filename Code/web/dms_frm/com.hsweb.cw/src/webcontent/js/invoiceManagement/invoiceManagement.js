var grid = null;
var baseUrl = apiPath + repairApi + "/";
var servieTypeList = [];
var servieTypeHash = {};
$(document).ready(function () {
    searchBeginDate = nui.get("start");
    searchEndDate = nui.get("end");
    searchBeginDate.setValue(addDate(getNowEndDate(), -30));
    searchEndDate.setValue(addDate(getNowEndDate(), 1));
	
	grid = nui.get("grid");
	grid.setUrl(baseUrl+"com.hsapi.repair.repairService.query.selectInvoiceMain.biz.ext");
	grid.load({token : token});
	
	 grid.on("drawcell",function(e){
     	var field = e.field,
     	value = e.value;
     	if(field == "recordDate" || field == "recordDateMain"){
     		if(value){
     			e.cellHtml = format(value,"yyyy-MM-dd");
     		}
     	}
     	if(field == "rate"){
     		if(value){
     			e.cellHtml = value + "%";
     		}
     	}
     	if(field == "invoiceType"){
     		if(value){
     			e.cellHtml = servieTypeHash[value].name;
     		}
		}
     });
	 grid.on("rowdbclick",function(){
		 newBill(2);
	 });
	 var dicDefs = {"invoiceType":"DDT20130703000008"};
		initDicts(dicDefs,function(data){
			servieTypeList = nui.get("invoiceType").getData();
	        servieTypeList.forEach(function(v) {
	        servieTypeHash[v.id] = v;
	        });
	});
});

function refresh(){
	var params = {};
	if(nui.get("type").value == 1){
		params.invoiceNo = nui.get("message").value;
	}else if(nui.get("type").value == 2){
		params.code = nui.get("message").value;
	}else if(nui.get("type").value == 3){
		params.serviceCode = nui.get("message").value;
	}else if(nui.get("type").value == 4){
		params.name = nui.get("message").value;
	}else if(nui.get("type").value == 5){
		params.mobile = nui.get("message").value;
	}else if(nui.get("type").value == 6){
		params.carNo = nui.get("message").value;
	}
	if(nui.get("start").value){
		params.recordStartDate = nui.get("start").value;
	}
	if(nui.get("end").value){
		params.recordEndDate =addDate(nui.get("end").value, 1);
	}
	grid.load({token : token,params : params});
}

function newBill(e) {
    var item={};
    item.id = "TicketOpeningMgr";
    item.text = "开票单";
    var url = null;
    if(e == 1){
    	url = "/cwY.invoice.flow?token="+token;
    }else{
    	row = grid.getSelected();
    	if(row){
    		url = "/cwY.invoice.flow?state=1&serviceCode="+row.serviceCode+"&main="+row.main;
    	}
    }
    item.url = webPath + contextPath + url;
    item.iconCls = "fa fa-cog";
    window.parent.activeTab(item);
}

