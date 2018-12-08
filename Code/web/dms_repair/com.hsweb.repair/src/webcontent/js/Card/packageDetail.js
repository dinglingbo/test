var gridUrl = apiPath + repairApi
		+ "/com.hsapi.repair.baseData.crud.queryPackageDetail.biz.ext";

var item = null;
var part = null;
var form = null;
var servieTypeHash = {};
var servieTypeList = [];
$(document).ready(function(v) {
	item = nui.get("#item");
	part = nui.get("#part");
	form = new nui.Form("#dataform1");
	nui.get('item').focus();
	document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27))  {  //ESC
            onCancel();
        }
	 };
});

function setData(data) {
	
	// 跨页面传递的数据对象，克隆后才可以安全使用
	var json = nui.clone(data);
	var a = json.row;
	if(a.serviceTypeId!=""){
		a.serviceTypeId=json.servieTypeHash[a.serviceTypeId].name;
	}else{
		a.serviceTypeId="";
	}
	form.setData(a);
	form.setChanged(false);
	// 计次卡明细查询
	var json1 = nui.encode({
		"package1" : a,
		"token":token
	});
	nui.ajax({
		url : gridUrl,
		type : 'POST',
		data : json1,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			var returnJson = nui.decode(text);
			if (returnJson.exception == null) {
				item.setData(returnJson.item);
				part.setData(returnJson.part);
			} else {
				nui.alert("获取明细失败", "系统提示", function(action) {
					if (action == "ok" || action == "close") {
						// CloseWindow("saveFailed");
					}
				});
			}
		}
	});
}
function onCancel() {
	CloseWindow("cancel");
}

function CloseWindow(action) {
	if (action == "close") {

	} else if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else
		return window.close();
}
