var isTrue = [ {id : 1,text : "是"}, {id : 0,text : "否"} ];
var typeList = [{id:0,name:"功能模块"},{id:1,name:"接口调用"}];
var form = new nui.Form("#form1");

nui.parse();
var productLimitedCycle = nui.get("cycle");//产品限定周期
var costNumCycle = nui.get("consumptionTimes");//周期消费次数
var isLimitedCycle = nui.get("isCycle");//是否限定周期

$(document).ready(function(v) {

});
function isLimitedCycleChanged() {
	var isLimitedCycle_value = isLimitedCycle.getValue();
	if (isLimitedCycle_value == "0") {
		costNumCycle.setVisible(false);
		costNumCycle.setValue(null);
		costNumCycle.setRequired(false);
		costNumCycle.setIsValid(true);
		productLimitedCycle.setVisible(false);
		productLimitedCycle.setValue(null);
		productLimitedCycle.setRequired(false);
		productLimitedCycle.setIsValid(true);
	} else {
		costNumCycle.setVisible(true);
		costNumCycle.enable();
		costNumCycle.setRequired(true);//设置为必填
		productLimitedCycle.setVisible(true);
		productLimitedCycle.setRequired(true);
		productLimitedCycle.enable();
	}
}

function onOk(e) {

	var s = new nui.Form("#form1").getData();
	saveData(s);
}
baseUrl = apiPath + sysApi + "/";
;
var savetUrl = baseUrl + "com.primeton.tenant.comProduct.updateProduct.biz.ext";
function saveData(row) {

	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '保存中...'
	});
	nui.ajax({
		url : savetUrl,
		type : 'post',
		data : nui.encode({
			params : row
		}),
		cache : false,
		success : function(data) {
			if (data.errCode == "S") {
				nui.unmask(document.body);
				nui.alert("保存成功！");
				CloseOwnerWindow('ok');
			} else {
				nui.unmask(document.body);
				nui.alert("保存失败！");
				CloseOwnerWindow('ok');
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			nui.alert(jqXHR.responseText);
		}
	});

}

function onCancel(e) {
	if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow('ok');
	else
		window.close();
}

function SetInitData(s) {
	new nui.Form("#form1").setData(s);
}