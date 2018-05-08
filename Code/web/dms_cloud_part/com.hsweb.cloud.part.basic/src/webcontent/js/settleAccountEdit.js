/**
 * Created by Administrator on 2018/5/5.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var mainForm = null;
var rowT = null;
var newRowT = null;
var partTypeHash = [];
var parentidEl = null;
var accountTypeList = null;
var accountTypeIdEl = null;

$(document).ready(function(v) {
	mainForm = new nui.Form("#editForm");
	parentidEl = nui.get("parentid");
	accountTypeIdEl  = nui.get("accountTypeId");

	accountTypeList = [{ id: 1, name: "现金" },{ id: 2, name: "银行存款" },{ id: 3, name: "积分/卡券" }];
	accountTypeIdEl.setData(accountTypeList);


});
function SetData(row, newRow){
	rowT = row;
	newRowT = newRow;
	mainForm.setData(rowT);
	if(row.id == null || row.id == ""){
		accountTypeIdEl.setValue(1);
	}
}
function save(){
	saveType('');
}
function add(){
	saveType('next');
}

var requiredField = {
	code : "账户编码",
	name : "账户名称",
	accountTypeId : "账户类型"
};

var saveUrl = baseUrl
		+ "com.hsapi.cloud.part.settle.svr.saveFiSettleAccount.biz.ext";
function saveType(type){
	var data = mainForm.getData();

	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
			nui.alert(requiredField[key] + "不能为空!");

			return;
		}
	}

	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '保存中...'
	});

	data.isdisabled = 0;
	data.isquickwear = 0;
	data.carbrandid = 'SYS';

	nui.ajax({
		url : saveUrl,
		type : "post",
		data : JSON.stringify({
			settleAccount: data
		}),
		success : function(data) {
			nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
				nui.alert("保存成功!");
				
			} else {
				nui.alert(data.errMsg || "保存失败!");
			}

			if(type == 'next') {
				newRowT = {};
				newRowT.parentid = rowT.parentid;
				SetData(newRowT, newRowT);
			}else{
				if (window.CloseOwnerWindow) return window.CloseOwnerWindow("ok");
    			else window.close();
			}
		},
		ondestroy: function() {
			
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
	
}
