var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + frmApi + "/";// window._rootUrl||"http://127.0.0.1:8080/default/";
var partBaseUrl = apiPath + partApi + "/";
var gridUrl = baseUrl
		+ "com.hsapi.frm.frmService.query.queryFisPreBill.biz.ext";
var grid = null;
$(document).ready(function(v) {
	grid = nui.get("datagrid1");
	grid.setUrl(gridUrl);
	search();
	
	grid.on("drawcell", function (e) {
        var record = e.record;
        if (e.field == "settleStatus") {
        	if(e.value==1) {
        		e.cellHtml = "已结算";
        	}else if(e.value==0) {
            	e.cellHtml = "未结算";
            }else if(e.value==2) {
            	e.cellHtml = "已作废";
            }
        }
    });
});


function search(){
	var params = {};
	params.guestName = nui.get("guestName").getValue();
	params.carNo = nui.get("carNo").getValue();
	grid.load({params : params,token:token});
}

function invalid(){
	
}