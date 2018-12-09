var baseUrl = apiPath + sysApi + "/";
var shareUrlGrid = null;
var shareUrlGridUrl = baseUrl + "com.hsapi.system.config.paramSet.queryTenantShareUrl.biz.ext";
var statusList = [{id:0,name:"启用"},{id:1,name:"禁用"}];
var statusHash = {0:"启用",1:"禁用"};
$(document).ready(function(v) {
    shareUrlGrid = nui.get("shareUrlGrid");
    shareUrlGrid.setUrl(shareUrlGridUrl);

    search();

    shareUrlGrid.on("drawcell",function(e){
        switch (e.field) {
            case "isDisabled":
                if (statusHash[e.value]) {
                    e.cellHtml = statusHash[e.value] || "";
                } else {
                    e.cellHtml = "";
                }
                break;
            default:
                break;
            }
    });
});
function search(){
    var param = {tenantId:currTenantId};
    shareUrlGrid.load({
        param:param,
        token:token
    });
}
function addShareUrl(){
    var newRow = {isDisabled:0};
    shareUrlGrid.addRow(newRow);
}
function delShareUrl(){
    var row = shareUrlGrid.getSelected();
    if(row){
        shareUrlGrid.removeRow(row,true);
    }
}
var saveShareUrl = baseUrl + "com.hsapi.system.config.paramSet.saveTenantShareUrl.biz.ext";
function saveShare(){
    var addList = shareUrlGrid.getChanges("added");
	var updateList = shareUrlGrid.getChanges("modified");
	var deleteList = shareUrlGrid.getChanges("removed");

    nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '保存中...'
	});

	nui.ajax({
		url : saveShareUrl,
		type : "post",
		data : JSON.stringify({
			addList : addList,
			updateList : updateList,
			deleteList : deleteList,
			token: token
		}),
		success : function(data) {
			nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
                queryStation();
			} else {
				showMsg(data.errMsg || "保存失败!","E");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});

}