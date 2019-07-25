var webBaseUrl = webPath + contextPath + "/";
var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var isBoundDriverLicense = null;
var radioList = [{id:1,text:"是"},{id:0,text:"否"}];
var billForm = null;
var grid = null;
$(document).ready(function(v) {
	isBoundDriverLicense = nui.get("isBoundDriverLicense");
	isBoundDriverLicense.setData(radioList);
	billForm = new nui.Form("#billForm");
	grid = nui.get("datagrid1");
});

var getViolationUrl = apiPath + repairApi+ "/com.hsapi.repair.repairService.svr.getViolation.biz.ext";
function getViolation()
{
	var carNo = document.getElementById("carNo").value;
	if(carNo==""){
		showMsg("请输入车牌号！","W");
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