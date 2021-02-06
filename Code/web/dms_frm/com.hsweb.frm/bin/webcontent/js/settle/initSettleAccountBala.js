/**
 * Created by Administrator on 2018/5/5.
 */
var baseUrl = apiPath + frmApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var queryUrl = baseUrl
		+ "com.hsapi.frm.frmService.crud.queryFiSettleAccount.biz.ext";
var mainGrid = null;
var disableEl = null;
var undisableEl = null;

$(document).ready(function(v) {
	mainGrid = nui.get("mainGrid");
	mainGrid.setUrl(queryUrl);
	disableEl = nui.get("disable");
	undisableEl = nui.get("undisable");

	doSearch();
});
function doSearch() {
	mainGrid.load({
		token : token
	});
}
var accountTypeList = [{ id: 1, text: '现金' }, { id: 2, text: '银行存款'}, { id: 3, text: '积分/卡券'}];
function onAccount(e) {
    for (var i = 0, l = accountTypeList.length; i < l; i++) {
        var g = accountTypeList[i];
        if (g.id == e.value) return g.text;
    }
    return "";
}
var disableList = [{ id: 0, text: '否' }, { id: 1, text: '是'}];
function onRenderer(e) {
    for (var i = 0, l = disableList.length; i < l; i++) {
        var g = disableList[i];
        if (g.id == e.value) return g.text;
    }
    return "";
}
function refresh(){
	doSearch();
}

var saveUrl = baseUrl
		+ "com.hsapi.frm.frmService.crud.saveFiSettleAccount.biz.ext";
function save(){
	
	var data = mainGrid.getChanges("modified");
	var settleAccount = [];
	if(data){
		for(var i=0; i<data.length; i++){
			var temp = data[i];
			if(temp.modifyDate) {
		        temp.modifyDate = format(temp.modifyDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
		    }
		    settleAccount.push(temp);
		}

		if(settleAccount && settleAccount.length>0) {
			nui.mask({
				el : document.body,
				cls : 'mini-mask-loading',
				html : '保存中...'
			});
			
			nui.ajax({
				url : saveUrl,
				type : "post",
				data : JSON.stringify({
					settleAccount: settleAccount
				}),
				success : function(data) {
					nui.unmask(document.body);
					data = data || {};
					if (data.errCode == "S") {
						nui.alert("保存成功!");
						
						doSearch();
					} else {
						nui.alert(data.errMsg || "保存失败!");
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					console.log(jqXHR.responseText);
				}
			});
		}
		
	}
	
}
var auditUrl = baseUrl
		+ "com.hsapi.frm.frmService.crud.initSettleAccountBalance.biz.ext";
function audit(){
	var data = mainGrid.getData();
	var settleAccount = [];
	if(data){
		for(var i=0; i<data.length; i++){
			var temp = data[i];
			var initBalance = temp.initBalance||0;
			if(temp.isInit == 0 && initBalance != 0){
				if(temp.modifyDate) {
			        temp.modifyDate = format(temp.modifyDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
			    }
			    settleAccount.push(temp);
			}
		}

		if(settleAccount && settleAccount.length>0) {
			nui.mask({
				el : document.body,
				cls : 'mini-mask-loading',
				html : '审核中...'
			});

			nui.ajax({
				url : auditUrl,
				type : "post",
				data : JSON.stringify({
					settleAccount: settleAccount
				}),
				success : function(data) {
					nui.unmask(document.body);
					data = data || {};
					if (data.errCode == "S") {
						nui.alert("审核成功!");
						
						doSearch();
					} else {
						nui.alert(data.errMsg || "审核失败!");
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					console.log(jqXHR.responseText);
				}
			});
		}
		
	}
	
}
function onCellCommitEdit(e) {
    var editor = e.editor;
    var record = e.record;
    
    editor.validate();
    if (editor.isValid() == false) {
        nui.alert("请输入数字！");
        e.cancel = true;
    }
}
function OnrpMainGridCellBeginEdit(e)
{
	var column = e.column;
    var editor = e.editor;
    var row = e.row;
    if(row.isInit == 1){
        if (column.field == "initBalance") {
            e.cancel = true;
        }
    }
}