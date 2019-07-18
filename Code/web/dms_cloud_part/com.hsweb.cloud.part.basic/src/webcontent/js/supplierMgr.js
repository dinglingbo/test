/**
 * Created by Administrator on 2018/1/23.
 */
var baseUrl = apiPath + cloudPartApi + "/";// window._rootUrl ||
										// "http://127.0.0.1:8080/default/";
var gridUrl = baseUrl
		+ "com.hsapi.cloud.part.baseDataCrud.crud.querySupplierList.biz.ext";
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
	grid = nui.get("datagrid1");
	grid.setUrl(gridUrl);
	search();
	grid.on("beforeload", function(e) {
		e.data.token = token;
	});
	grid.on("drawcell", function(e) {
		var field = e.field;
		if ("isDisabled" == field) {
			e.cellHtml = e.value == 1 ? "是" : "否";
		} else if ("provinceId" == field) {
			if (provinceHash[e.value]) {
				e.cellHtml = provinceHash[e.value].name || "";
			}
		} else if ("cityId" == field) {
			if (cityHash[e.value]) {
				e.cellHtml = cityHash[e.value].name || "";
			}
		} else if ("tgrade" == field) {
			if (tgradeHash[e.value]) {
				e.cellHtml = tgradeHash[e.value].name || "";
			}
		}else if("isInternal" == field) {
			e.cellHtml = e.value == 1 ? "是" : "否";
		}
		else {
			onDrawCell(e);
		}
	});
	advancedSearchWin = nui.get("advancedSearchWin");
	advancedSearchForm = new nui.Form("#advancedSearchWin");
	// console.log("xxx");
	provinceEl = nui.get("provinceId");
	getProvinceAndCity(function(data) {
	});
	initDicts({
		billTypeId : BILL_TYPE,// 票据类型
		managerDuty : MANAGER_DUTY,// 供应商负责人职务
		settType : SETT_TYPE,// 结算方式
		supplierType : SUPPLIER_TYPE
	// 对象类型
	}, function() {
		initComp("orgId");
	});

    document.onkeyup=function(event){
	    var e=event||window.event;
		var keyCode=e.keyCode||e.which;
	    if((keyCode==27))  {  //ESC
	        advancedSearchWin.hide();
		 };
	  };
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
    var type = nui.get("search-type").getValue();
    var typeValue = nui.get("carNo-search").getValue().replace(/\s+/g, "");
    if(type==0){
    	params.fullName = typeValue;
    }else if(type==1){
    	params.advantageCarbrandId = typeValue;
    }else if(type==2){
    	params.mobile = typeValue;
    }
    params.supplierType= nui.get("supplierType").getValue().replace(/\s+/g, "");

	return params;

}
function doSearch(params) {
	params.isSupplier = 1;
	grid.load({
		params : params
	});
}
function advancedSearch() {
	advancedSearchWin.show();
	advancedSearchForm.clear();
	if (advancedSearchFormData) {
		advancedSearchForm.setData(advancedSearchFormData);
	}
}
function onAdvancedSearchOk() {
	var searchData = advancedSearchForm.getData();
	//去除空格
	for(var key in searchData){
    	if(searchData[key]!=null && searchData[key]!="" && typeof(searchData[key])=='string'){    		
    		searchData[key]=searchData[key].replace(/\s+/g, "");
    	}
    }
	advancedSearchFormData = searchData;
	advancedSearchWin.hide();
	// console.log(searchData);
	doSearch(searchData);
}
function onAdvancedSearchCancel() {
	advancedSearchForm.clear();
	advancedSearchWin.hide();
}

function addSuplier() {
	billTypeIdList = nui.get("billTypeId").getData();
	supplierTypeList = nui.get("supplierType").getData();
	settTypeIdList = nui.get("settType").getData();
	managerDutyList = nui.get("managerDuty").getData();
	nui
			.open({
				// targetWindow: window,,
				url : webPath + contextPath
						+ "/com.hsweb.cloud.part.basic.supplierDetail.flow?token="
						+ token,
				title : "供应商资料",
				width : 550,
				height : 550,
				allowDrag : true,
				allowResize : false,
				onload : function() {
					var iframe = this.getIFrameEl();
					iframe.contentWindow.setData({
						province : provinceList,
						city : cityList,
						supplierType : supplierTypeList,
						billTypeId : billTypeIdList,
						settTypeId : settTypeIdList,
						tgrade : tgradeList,
						managerDuty : managerDutyList
					});
				},
				ondestroy : function(action) {
					if (action == "ok") {
						grid.reload();
					}
				}
			});
}
function editSuplier() {
	var row = grid.getSelected();

	if (!row) {
		showMsg("请选择要编辑的数据", "W");
		return;
	}

	if (row && row.orgid == currOrgid) {
		billTypeIdList = nui.get("billTypeId").getData();
		supplierTypeList = nui.get("supplierType").getData();
		settTypeIdList = nui.get("settType").getData();
		managerDutyList = nui.get("managerDuty").getData();
		nui.open({
//			// targetWindow: window,,
			url : webPath + contextPath
					+ "/com.hsweb.cloud.part.basic.supplierDetail.flow?token="
					+ token,
			title : "供应商资料",
			width : 600,
			height : 550,
			allowDrag : true,
			allowResize : false,
			onload : function() {
				var iframe = this.getIFrameEl();
				iframe.contentWindow.setData({
					province : provinceList,
					city : cityList,
					supplier : row,
					supplierType : supplierTypeList,
					billTypeId : billTypeIdList,
					settTypeId : settTypeIdList,
					tgrade : tgradeList,
					managerDuty : managerDutyList
				});
			},
			ondestroy : function(action) {
				if (action == "ok") {
					grid.reload();
				}
			}
		});
	}
}
function onRowDblClick(e) {
	editSuplier();
}
function onGridRowClick(e) {
	var row = e.record || grid.getSelected();
	if (!row) {
		return;
	}
	if (row.orgid != currOrgid) {
		nui.get("editBtn").disable();
	} else {
		nui.get("editBtn").enable();
	}
}
function importSupplier() {
	billTypeIdList = nui.get("billTypeId").getData();
	settTypeIdList = nui.get("settType").getData();

	nui
			.open({
				// targetWindow: window,,
				url : webPath + contextPath
						+ "/com.hsweb.cloud.part.basic.importSupplier.flow?token="
						+ token,
				title : "供应商导入",
				width : 1000,
				height : 600,
				allowDrag : true,
				allowResize : true,
				onload : function() {
					var iframe = this.getIFrameEl();
					iframe.contentWindow.initData({
						province : provinceList,
						city : cityList,
						billTypeId : billTypeIdList,
						settTypeId : settTypeIdList
					});
				},
				ondestroy : function(action) {
					doSearch();
				}
			});
}

