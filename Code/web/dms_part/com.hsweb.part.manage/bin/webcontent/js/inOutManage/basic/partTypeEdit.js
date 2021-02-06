/**
 * Created by Administrator on 2018/5/5.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var queryUrl = baseUrl
		+ "com.hsapi.part.baseDataCrud.crud.queryComPartType.biz.ext";
var mainForm = null;
var rowT = null;
var newRowT = null;
var partTypeHash = [];
var parentidEl = null;

$(document).ready(function(v) {
	mainForm = new nui.Form("#editForm");
	parentidEl = nui.get("parentId");
	nui.get('code').focus();
	
	
    document.onkeyup = function(event) {
        var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下
        
        if ((keyCode == 27)) { // ESC
            CloseWindow('cancle');
        }

    }
});
function SetData(row, newRow){
	rowT = row;
	newRowT = newRow;
	mainForm.setData(rowT);
	
	getComPartType(function(data) {
		partTypeHash = data.type || [];
		parentidEl.setData(partTypeHash);
		parentidEl.setValue(rowT.parentId);
	});
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

function CloseWindow(action)
{
	if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else
		window.close();
}

var saveUrl = baseUrl
		+ "com.hsapi.part.baseDataCrud.crud.saveComPartType.biz.ext";
function saveType(type){
	var data = mainForm.getData();

	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
			showMsg(requiredField[key] + "不能为空!","W");

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
				showMsg("保存成功!","S");
				
			} else {
				showMsg(data.errMsg || "保存失败!","E");
			}

			if(type == 'next') {
				newRowT = {};
				newRowT.parentid = rowT.parentid;
				SetData(newRowT, newRowT);
			}else{
				if(data.errCode == "S"){
					if (window.CloseOwnerWindow) return window.CloseOwnerWindow("ok");
    				else window.close();
				}
				
			}
		},
		ondestroy: function() {
			
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
	
}

function CloseWindow(action) {
	if (action == "close") {
	} else if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else
		return window.close();
}

function onClose(){
	window.CloseOwnerWindow();	
}
