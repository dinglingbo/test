/**
 * Created by Administrator on 2018/5/5.
 */
var baseUrl = apiPath + frmApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var queryUrl = baseUrl + "com.hsapi.frm.setting.queryAccountSettleType.biz.ext";
var mainForm = null;
var rowT = null;
var newRowT = null;
var partTypeHash = [];
var parentidEl = null;
var accountTypeList = null;
var accountTypeIdEl = null;
var settleAccountGrid = null;
var settleList = null;
var isDefault = null;
$(document).ready(function(v) {
	mainForm = new nui.Form("#editForm");
	parentidEl = nui.get("parentid");
	accountTypeIdEl  = nui.get("accountTypeId");
	isDefault = nui.get("isDefault");

	accountTypeList = [{ id: 1, name: "现金" },{ id: 2, name: "银行存款" },{ id: 3, name: "积分/卡券" }];
	accountTypeIdEl.setData(accountTypeList);

	settleAccountGrid = nui.get("settleAccountGrid");
	settleAccountGrid.setUrl(queryUrl);

	getSettleType(function(data) {
		settleList = data.list || [];

	});
});
var querySettleTypeUrl = baseUrl
		+ "com.hsapi.frm.setting.querySettleType.biz.ext";
function getSettleType(callback) {
	nui.ajax({
		url : querySettleTypeUrl,
		data : {
			dictId: 'DDT20130703000031',
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
function SetData(row, newRow){
	rowT = row;
	newRowT = newRow;
	mainForm.setData(rowT);
	if(rowT.isDefault==1){
		isDefault.setValue(true);
	}
	if(row.id == null || row.id == ""){
		addSettleAccountRow();
		accountTypeIdEl.setValue(1);
	}else{
		settleAccountGrid.load({accountId:row.id});
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
		+ "com.hsapi.frm.setting.saveFiSettleAccount.biz.ext";
function saveType(type){
	
	var data = mainForm.getData();
	var settleTypeData = settleAccountGrid.getData();
	var is = isDefault.getValue();
	if(settleTypeData){
		if(settleTypeData.length == 0){
			nui.alert("请添加账户对应的结算方式!");
			if(settleTypeData && settleTypeData.length == 0){
				addSettleAccountRow();
			}
			return;			
		}else if(settleTypeData.length == 1){
			var r = settleTypeData[0];
			if(!r.customId){
				nui.alert("请添加账户对应的结算方式!");
				if(settleTypeData && settleTypeData.length == 0){
					addSettleAccountRow();
				}
				return;	
			}
		}
	}else{
		nui.alert("请添加账户对应的结算方式!");
		if(settleTypeData && settleTypeData.length == 0){
			addSettleAccountRow();
		}
		return;
	}

	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
			nui.alert(requiredField[key] + "不能为空!");

			return;
		}
	}

	var settleTypeAdd = settleAccountGrid.getChanges("added");
	var settleTypeUpdate = settleAccountGrid.getChanges("modified");
	var settleTypeDelete = settleAccountGrid.getChanges("removed");

	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '保存中...'
	});

	if(is=="true"){
		data.isDefault = 1;
	}else{
		data.isDefault = 0;
	}
	data.isDisabled = 0;
	data.isquickwear = 0;
	data.carbrandid = 'SYS';

	nui.ajax({
		url : saveUrl,
		type : "post",
		data : JSON.stringify({
			settleAccount: data,
			settleTypeAdd: settleTypeAdd,
			settleTypeDelete: settleTypeDelete,
			settleTypeUpdate: settleTypeUpdate
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

				settleAccountGrid.setData([]);
				addSettleAccountRow();
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
function onActionRenderer(e) {
    var grid = e.sender;
    var record = e.record;
    var uid = record._uid;
    var rowIndex = e.rowIndex;

    var s = '<a class="" href="javascript:addSettleAccountRow()">新增</a> '
            + '<a class="" href="javascript:delRow(\'' + uid + '\')">删除</a> ';
               
    return s;
}
function addSettleAccountRow() {            
    var row = {};
    settleAccountGrid.addRow(row, 0);
}
function delRow(row_uid) {
    var row = settleAccountGrid.getRowByUID(row_uid);
    if (row) {
        settleAccountGrid.removeRow(row);
    }
}
function onSettleTypeChanged(e){
	var row = e.selected;
	if(row){
		var r = settleAccountGrid.getSelected();
		var newRow = {customName:row.name};
		settleAccountGrid.updateRow(r,newRow);
	}
}
