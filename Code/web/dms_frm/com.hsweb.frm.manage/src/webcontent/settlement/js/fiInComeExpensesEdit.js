/**
 * Created by Administrator on 2018/5/5.
 */
var baseUrl = apiPath + frmApi + "/"; 
var partBaseUrl = apiPath + partApi + "/";
var queryUrl = baseUrl
		+ "com.hsapi.frm.frmService.crud.queryFibInComeExpenses.biz.ext";
var mainForm = null;
var rowT = null;
var newRowT = null;
var typeHash = [];
var parentidEl = null;
var itemTypeIdEl = null;
var itemTypeIdList = null;
var isPrimaryBusinessEl = null;
var isSaleEl = null;
var primaryBusinessList = null;

$(document).ready(function(v) {
	mainForm = new nui.Form("#editForm");
	parentidEl = nui.get("parentId");
	itemTypeIdEl = nui.get("itemTypeId");
	primaryBusinessEl = nui.get("isPrimaryBusiness");
	isSaleEl = nui.get("isSale");

	itemTypeIdList = [{ id: 1, name: "收入类" },{ id: -1, name: "支出类" },];
	itemTypeIdEl.setData(itemTypeIdList);

	primaryBusinessList = [{ id: 0, name: "否" },{ id: 1, name: "是" },];
	primaryBusinessEl.setData(primaryBusinessList);
	isSaleEl.setData(primaryBusinessList);
	getInComeExpenses(function(data) {
		listHash = data.list || [];
		parentidEl.setData(listHash);

	});

	parentidEl.focus();
    document.onkeyup = function(event) {
		var e = event || window.event;
		var keyCode = e.keyCode || e.which;// 38向上 40向下
		

		if ((keyCode == 27)) { // ESC
			CloseWindow('cancle');
		}
	};
});
function SetData(row, newRow){
	rowT = row;
	newRowT = newRow;
	mainForm.setData(rowT);
}
function getInComeExpenses(callback) {
	nui.ajax({
		url : queryUrl,
		data : {
			token: token
		},
		type : "post",
		success : function(data) {
			if (data && data.list) {
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
	code : "项目编码",
	name : "项目名称",
	itemTypeId : "项目类型",
	isPrimaryBusiness : "是否主营业务"
};

var saveUrl = baseUrl
		+ "com.hsapi.frm.frmService.crud.saveFibInComeExpenses.biz.ext";
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

	nui.ajax({
		url : saveUrl,
		type : "post",
		data : JSON.stringify({
			data: data
		}),
		success : function(data) {
			nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
				showMsg("保存成功!","S");
				
			} else {
				showMsg(data.errMsg || "保存失败!","S");
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
