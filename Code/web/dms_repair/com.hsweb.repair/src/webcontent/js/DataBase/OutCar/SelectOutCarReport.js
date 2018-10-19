var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
var saveUrl = baseUrl + "com.hsapi.repair.repairService.crud.saveOutCarReport.biz.ext";
var queryUrl = baseUrl + "com.hsapi.repair.repairService.crud.queryOurCartReport.biz.ext";
var form = null;
$(document).ready(function (v) {
	form = new nui.Form("#basicInfoForm");
});

function SelectReport(){
	nui.open({
        url: webPath + contextPath +"/repair/DataBase/OutCar/OutCarReport.jsp?token="+token,
        title: "出车报告", width: "50%", height: "60%", 
        onload: function () {
           /* var iframe = this.getIFrameEl();
            iframe.contentWindow.setData(params);*/
        },
        ondestroy: function (action) {
			var iframe = this.getIFrameEl();
			var data = iframe.contentWindow.getData();
			form.setData(data);
        }
    });
}
var getData = null;
function setData(params){
	serviceId = params.serviceId||0;
	getData = params;
	init();
}
function init(){
	var main = getData;
	var json = nui.encode({
		main:main,
		token : token
	});
  nui.ajax({
	url : queryUrl,
	type : 'POST',
	data : json,
	cache : false,
	contentType : 'text/json',
	success : function(text) {
		var returnJson = nui.decode(text);
		var outCar = returnJson.main;
		if(outCar){
			var outCarData = {};
			outCarData.content = outCar.drawOutReport;
			form.setData(outCarData);
		}
	}
});	
} 
function save(){
	var isSettle = getData.isSettle;
	if(isSettle == 1){
		showMsg("本单已结算,不能登记出车报告!","W");
        return;
	}
	var formData = form.getData();
	var main = {};
	main.id = getData.id;
	main.drawOutReport = formData.content;
	 var json = nui.encode({
			main:main,
			token : token
		});
	nui.ajax({
		url : saveUrl,
		type : 'POST',
		data : json,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			var returnJson = nui.decode(text);
			if (returnJson.errCode == "S") {
				showMsg("保存成功","S");
			} else {
				showMsg(returnJson.errMsg,"W");
			}		
		}
	});	
}
function close(){
	CloseWindow("ok");
}

function CloseWindow(action)
{
	if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else window.close();
}
