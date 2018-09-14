var grid = null;
var baseUrl = apiPath + repairApi + "/";
$(document).ready(function () {
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
     });
});



function valueChane(){
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
		params.recordEndDate = nui.get("end").value;
	}
	grid.load({token : token,params : params});
}