/**
 * Created by Administrator on 2018/1/23.
 */
var baseUrl = apiPath + sysApi + "/";// window._rootUrl ||
										// "http://127.0.0.1:8080/default/";
var gridUrl = baseUrl
		+ "com.hsapi.system.employee.mac.queryMac.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var grid = null;
// 信誉等级
var tgradeList = [ {
	"customid" : 0,
	"name" : "高"
}, {
	"customid" : 1,
	"name" : "中"
}, {
	"customid" : 2,
	"name" : "低"
} ];

var statusList = [{id:"0",name:"供应商全称"},{id:"1",name:"优势品牌/产品"},{id:"2",name:"联系人电话"}];
var tgradeHash = {
	0 : tgradeList[0],
	1 : tgradeList[1],
	2 : tgradeList[2]
};
var billTypeIdList = [];
var billTypeIdHash = {};
var settTypeIdList = [];
var settTypeIdHash = {};
var managerDutyList = [];
var managerDutyHash = {};
var supplierTypeList = [];
var supplierTypeHash = {};
var orgHash = {};
$(document).ready(function(v) {
	grid = nui.get("rightGrid");
	grid.setUrl(gridUrl);
	
	grid.on("beforeload", function(e) {
		e.data.token = token;
	});
	
	onSearch();

});
function onSearch() {
	search();
}
function search() {
	var param = getSearchParam();
	doSearch(param);
}
function getSearchParam() {
	var params = {};
    params.macAddress = nui.get("macAddress").getValue().replace(/\s+/g, "");
    params.name= nui.get("name").getValue().replace(/\s+/g, "");

	return params;

}
function doSearch(params) {
	grid.load({
		params : params,
		toekn: token
	});
}

function add() {
	grid.addRow({});
}

function del() {
	grid.removeRows(grid.getSelecteds());
}

var saveUrl = baseUrl + "com.hsapi.system.employee.mac.saveMacs.biz.ext";
function save() {

    var addList = grid.getChanges("added");
    var updList = grid.getChanges("modified");
    var delList = grid.getChanges("removed");

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });

	nui.ajax({
		url : saveUrl,
		type : "post",
		data : JSON.stringify({
			addList : addList,
			delList : delList,
			updList : updList,
            token : token
		}),
		success : function(data) {
            nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
                showMsg("保存成功!","S");
                onSearch();
                
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

