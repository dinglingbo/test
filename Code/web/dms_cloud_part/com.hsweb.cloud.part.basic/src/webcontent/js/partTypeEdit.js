/**
 * Created by Administrator on 2018/5/5.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var queryUrl = baseUrl
		+ "com.hsapi.cloud.part.baseDataCrud.crud.queryComPartType.biz.ext";
var mainForm = null;
var rowT = null;
var newRowT = null;
var partTypeHash = [];
var parentidEl = null;

$(document).ready(function(v) {
	mainForm = new nui.Form("#editForm");
	parentidEl = nui.get("parentid");

	getComPartType(function(data) {
		partTypeHash = data.type || [];
		parentidEl.setData(partTypeHash);

	});
});
function SetData(row, newRow){
	rowT = row;
	newRowT = newRow;
	mainForm.setData(rowT);
}
function getComPartType(callback) {
	nui.ajax({
		url : queryUrl,
		data : {
			token: token
		},
		type : "post",
		success : function(data) {
			if (data && data.type) {
				callback && callback(data);
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			//  nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}
function save(){
	saveType('');
}
function add(){
	saveType('next');
}

var requiredField = {
	code : "分类编码",
	name : "分类名称"
};

var saveUrl = baseUrl
		+ "com.hsapi.cloud.part.baseDataCrud.crud.saveComPartType.biz.ext";
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
			comPartType: data,
			token: token
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