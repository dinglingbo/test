var webBaseUrl = webPath + contextPath + "/";
var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var isBoundDriverLicense = null;
var radioList = [{id:1,text:"是"},{id:0,text:"否"}];
var radioList = [{id:1,text:"是"},{id:0,text:"否"}];
var billForm = null;
var grid = null;
$(document).ready(function(v) {
	isBoundDriverLicense = nui.get("isBoundDriverLicense");
	isBoundDriverLicense.setData(radioList);
	billForm = new nui.Form("#billForm");
	grid = nui.get("datagrid1");
	
	grid.on("drawcell", function (e) {
        var record = e.record;
        if (e.field == "status") {
        	if(record.status == 0) {
        		e.cellHtml = "未处理";
        	}else if(record.status==1) {
            	e.cellHtml = "已处理";
            }
        }else if (e.field == "CanProcess") {
        	if(record.CanProcess == 0) {
        		e.cellHtml = "不可以";
        	}else if(record.CanProcess==1) {
            	e.cellHtml = "可以";
            }
        }
    });
});

var getViolationUrl = apiPath + repairApi+ "/com.hsapi.repair.repairService.svr.getViolation.biz.ext";
function getViolation()
{
	var carNo = document.getElementById("carNo").value;
	if(carNo==""){
		showMsg("请输入车牌号！","W");
		return;
	}
    //判断车牌号,返回是否正确，和转化后的车牌
	var falge = isVehicleNumberNoJurisdiction(carNo);
	document.getElementById("carNo").value = falge.vehicleNumber;
	if(!falge.result){
		showMsg("请输入正确的车牌号","W");
		return;
	}
	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '查询中...'
	});
	var params = {
			carNo:carNo
	}
	var json = {
			params:{
				params:params
			},
			token:token
	}
	nui.ajax({
		url : getViolationUrl,
		type : 'POST',
		data : json,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			nui.unmask(document.body);
            data = text||{};
            if(data.errCode == "S"){
            	showMsg("查询成功，此车有"+data.result.violationList.length+"条违章！","S");
            	billForm.setData(data.result);
            	grid.setData(data.result.violationList);
            }else{
            	showMsg(data.errMsg||"查询失败!","W");
            }

		}
	});
}