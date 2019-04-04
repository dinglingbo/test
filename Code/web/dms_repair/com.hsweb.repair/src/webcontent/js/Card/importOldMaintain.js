
var baseUrl = apiPath + repairApi + "/";
var queryOldMaintain = baseUrl
+"com.hsapi.repair.baseData.crud.queryOldMaintain.biz.ext";
var queryOldItemPart = baseUrl
+"com.hsapi.repair.baseData.crud.queryOldItemPart.biz.ext";

var datagrid1 = null;
var datagrid2 = null;
var datagrid3 = null;

$(document).ready(function () {
	datagrid1 = nui.get("datagrid1");
	datagrid2 = nui.get("datagrid2");
	datagrid3 = nui.get("datagrid3");
	datagrid1.setUrl(queryOldMaintain);
});

function onSearch(){
	datagrid2.setData([]);
	datagrid3.setData([]);
	var params = getSearchParams();
    doSearch(params);
}

function getSearchParams(){
    var params = {};
    params.carNo = nui.get("carNo").getValue();
    params.guestName = nui.get("guestName").getValue();
    params.serviceCode = nui.get("serviceCode").getValue();
    return params;
}

function doSearch(params){
	datagrid1.load({
        token:token,
        params:params
    });
}
function selectionChanged() {
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '数据加载中...'
    });
	var row = datagrid1.getSelected();
	var serviceCode = row.serviceCode;
	var params = {};
	params.serviceCode = serviceCode;
	var json1 = {
			params:	params
	};
	nui.ajax({
		url : queryOldItemPart,
		type : 'POST',
		data : json1,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			nui.unmask(document.body);
			datagrid2.setData(text.oldPart);
			datagrid3.setData(text.oldItem);
		}
	});
}