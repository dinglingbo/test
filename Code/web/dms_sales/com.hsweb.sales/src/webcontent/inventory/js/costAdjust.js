/**
 * Created by Administrator on 2018/5/5.
 */
var baseUrl = apiPath + saleApi + "/"; 
var mainForm = null;
var costAdjust = {};
$(document).ready(function(v) {
	mainForm = new nui.Form("#editForm");

});
function setData(row){
	costAdjust = row;

	mainForm.setData(costAdjust);
}

var saveUrl = baseUrl
		+ "sales.inventory.saveCost.biz.ext";
function save(type){

	costAdjust.unitPrice = nui.get("xunitPrice").getValue();
	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '保存中...'
	});

	nui.ajax({
		url : saveUrl,
		type : "post",
		data : JSON.stringify({
			cssCheckEnter: costAdjust
		}),
		success : function(data) {
			nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
				showMsg("调整成功!","S");
				
			} else {
				showMsg(data.errMsg || "调整异常!","W");
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
