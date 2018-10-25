/**
 * Created by Administrator on 2018/8/8.
 */

var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var partApiUrl = apiPath + partApi + "/";
var repairApiUrl = apiPath + repairApi + "/";
var grid = null;
var gridUrl = repairApiUrl+ "com.hsapi.repair.repairService.query.queryRepairOut.biz.ext";
var queryInfoForm = null;
var periodValidity = null;
var partInfoUrl = partApiUrl+ "com.hsapi.part.invoice.paramcrud.queryBillPartChoose.biz.ext";
var enterUrl = partApiUrl+ "com.hsapi.part.invoice.stockcal.queryOutableEnterGridWithPage.biz.ext";

var morePartCodeEl = null;
var morePartNameEl = null;
var moreServiceIdEl = null;
//var showStockEl = null;
var sortTypeEl = null;
var tempIdEl = null;
var brandHash = {};
var brandList = [];
var storehouse = null;
var billTypeHash = {};
var storeHash = {};
var FStoreId = null;
var mainId = 0;
var guestId = null;
var gpartId = 0;
var detail = null;
var serviceId = null;
$(document).ready(function(v) {

	queryInfoForm = new nui.Form("#queryInfoForm").getData(false, false);
	grid = nui.get("grid");

	grid.load(queryInfoForm);
	grid.setUrl(gridUrl);
	grid.on("drawcell", onDrawCell);
	getNowFormatDate();

	onSearch();

	enterGrid = nui.get("enterGrid");
	morePartCodeEl = nui.get("morePartCode");
	morePartNameEl = nui.get("morePartName");
	moreServiceIdEl = nui.get("moreServiceId");
//	showStockEl = nui.get("showStock");
	sortTypeEl = nui.get("sortType");
	sortTypeEl.setData(sortTypeList);
	tempIdEl = nui.get("tempId");

	enterGrid.on("selectionchanged", function(e) {
		var row = enterGrid.getSelected();
		gpartId = row.partId || 0;

	});

	enterGrid.setUrl(enterUrl);
	enterGrid.on("beforeload", function(e) {
		e.data.token = token;
	});
	enterGrid.on("load", function(e) {
		var row = enterGrid.getRow(0);
		if (row) {
			enterGrid.select(row, true);

		}
	});
	enterGrid.on("rowdblclick", function(e) {
		var row = enterGrid.getSelected();
		var rowc = nui.clone(row);
		if (!rowc)
			return;
		nui.get("qty").focus();

	});
	enterGrid.on("drawcell", function(e) {
		switch (e.field) {
		case "partBrandId":
			if (brandHash[e.value]) {
				e.cellHtml = brandHash[e.value].name || "";
			} else {
				e.cellHtml = "";
			}
			break;
		case "storeId":
			if (storeHash[e.value]) {
				e.cellHtml = storeHash[e.value].name || "";
			} else {
				e.cellHtml = "";
			}
			break;
		case "billTypeId":
			if (billTypeHash[e.value]) {
				e.cellHtml = billTypeHash[e.value].name || "";
			} else {
				e.cellHtml = "";
			}
			break;
		default:
			break;
		}

	});

	$("#morePartCode").bind("keydown", function(e) {

		if (e.keyCode == 13) {
			var value = morePartCodeEl.getValue();
			value = value.replace(/\s+/g, "");
			if (value.length >= 3) {
				morePartSearch();
			}
		}

	});

	$("#morePartName").bind("keydown", function(e) {

		if (e.keyCode == 13) {
			var value = morePartNameEl.getValue();
			value = value.replace(/\s+/g, "");
			if (value.length >= 3) {
				morePartSearch();
			}
		}

	});

	$("#moreServiceId").bind("keydown", function(e) {

		if (e.keyCode == 13) {
			var value = moreServiceIdEl.getValue();
			value = value.replace(/\s+/g, "");
			if (value.length >= 3) {
				morePartSearch();
			}
		}

	});

	$("#qty").bind("keydown", function(e) {
		if (e.keyCode == 13) {
			var price = nui.get("price");
			price.focus();
		}
	});

	$("#price").bind("keydown", function(e) {
		if (e.keyCode == 13) {
			var amt = nui.get("amt");
			amt.focus();
		}
	});
	$("#amt").bind("keydown", function(e) {
		if (e.keyCode == 13) {
			var remark = nui.get("remark");
			remark.focus();
		}
	});

	$("#remark").bind("keydown", function(e) {
		if (e.keyCode == 13) {
			var chooseBtn = nui.get("chooseBtn");
			chooseBtn.focus();
		}
	});

	document.onkeyup = function(event) {
		var e = event || window.event;
		var keyCode = e.keyCode || e.which;// 38向上 40向下
		
		if ((keyCode == 120)) { // F9
			morePartCodeEl.focus();
		}

		if ((keyCode == 121)) { // F10
			morePartNameEl.focus();
		}

	}

	var dictDefs = {
		"billTypeId" : "DDT20130703000008"
	};
	initDicts(dictDefs, function(e) {
		var billTypeList = nui.get("billTypeId").getData();
		billTypeList.forEach(function(v) {
			billTypeHash[v.customid] = v;
		});
	});
	getStorehouse(function(data) {
		storehouse = data.storehouse || [];
		if (storehouse && storehouse.length > 0) {
			FStoreId = storehouse[0].id;
			storehouse.forEach(function(v) {
				storeHash[v.id] = v;
			});
		}
	});

	getAllPartBrand(function(data) {
		brandList = data.brand;
		nui.get('partBrandId').setData(brandList);
		brandList.forEach(function(v) {
			brandHash[v.id] = v;
		});
	});
	morePartSearch();
});

function getSearchParams() {
	var params = {};
	params.returnSign=0;
	params.billTypeId='050207';
	params.sCreateDate = nui.get("sCreateDate").getValue().substr(0, 10);
	params.eCreateDate = nui.get("eCreateDate").getValue().substr(0, 10);
	params.pickMan = nui.get('pickMan1').getValue();
	return params;
}
function onSearch() {
	var params = getSearchParams();

	doSearch(params);
}
function doSearch(params) {
	grid.load({
		token : token,
		params : params
	});
}
function getNowFormatDate() {
	var date = new Date();
	var seperator1 = "-";
	var seperator2 = ":";
	var month = date.getMonth() + 1;
	var strDate = date.getDate();
	if (month >= 1 && month <= 9) {
		month = "0" + month;
	}
	if (strDate >= 0 && strDate <= 9) {
		strDate = "0" + strDate;
	}

	var sCreateDate = date.getFullYear() + seperator1 + month + seperator1
			+ "01";
	var eCreateDate = date.getFullYear() + seperator1 + month + seperator1
			+ strDate;
	nui.get('sCreateDate').setValue(sCreateDate);
	nui.get('eCreateDate').setValue(eCreateDate);
}


// 库存数量↑，库存数量↓；入库日期↑，入库日期↓；成本↑，成本↓
var sortTypeList = [ {
	id : "1",
	text : "入库日期↑"
}, {
	id : "2",
	text : "入库日期↓"
}, {
	id : "3",
	text : "库存数量↑"
}, {
	id : "4",
	text : "库存数量↓"
}, {
	id : "5",
	text : "成本↑"
}, {
	id : "6",
	text : "成本↓"
} ];
var resultData = {};
var callback = null;
var checkcallback = null;
function setInitData(params, ck, cck) {
	var value = params.value;
	mainId = params.mainId;
	guestId = params.guestId;
	callback = ck;
	checkcallback = cck;

	//var type = judgeConditionType(value);// 1代表编码，2代表名称，3代表拼音，-1输入信息有误
	var params = {};

	/*if (type == 1) {
		morePartCodeEl.setValue(value);
		params.partCode = value.replace(/\s+/g, "");
	} else if (type == 2) {
		morePartNameEl.setValue(value);
		params.partName = value;
	} else if (type == 3) {
		params.namePy = value.replace(/\s+/g, "");
	}*/

	params.sortField = "B.ENTER_DATE";
	params.sortOrder = "asc";
	enterGrid.load({
		params : params
	}, function(e) {
		enterGrid.focus();
	});

}

function morePartSearch() {
	var params = {};
	params.partCode = morePartCodeEl.getValue();
	params.partName = morePartNameEl.getValue();
//	params.showStock = showStockEl.getValue();
	params.serviceId = moreServiceIdEl.getValue();
	params.partBrandId = nui.get('partBrandId').getValue();
	var sortTypeValue = sortTypeEl.getValue();

	if (!params.partCode && !params.partName && !params.serviceId
			&& !params.partBrandId && !sortTypeValue) {
		showMsg("请输入查询条件!", "W");
		return;
	}

	if (sortTypeValue == 1) {
		params.sortField = "B.ENTER_DATE";
		params.sortOrder = "asc";
	} else if (sortTypeValue == 2) {
		params.sortField = "B.ENTER_DATE";
		params.sortOrder = "desc";
	} else if (sortTypeValue == 3) {
		params.sortField = "b.OUTABLE_QTY";
		params.sortOrder = "asc";
	} else if (sortTypeValue == 4) {
		params.sortField = "b.OUTABLE_QTY";
		params.sortOrder = "desc";
	} else if (sortTypeValue == 5) {
		params.sortField = "B.ENTER_PRICE";
		params.sortOrder = "asc";
	} else if (sortTypeValue == 6) {
		params.sortField = "B.ENTER_PRICE";
		params.sortOrder = "desc";
	}
	enterGrid.load({
		params : params
	}, function(e) {
		enterGrid.focus();
	});

}

function onPartClose() {
	CloseWindow("cancel");
}
function CloseWindow(action) {
	if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else
		window.close();
}

function getRtnData() {
	return resultData;
}

var requiredField = {

	outQty : "出库数量",
	pickMan : "领料人",
	remark : "出库原因"

};

var requiredField2 = {

		outQty : "归库数量",
		returnMan : "归库人",
		returnRemark : "归库原因"

	};
function onAdvancedAddOk() {

	var data = enterGrid.getSelected();
	for ( var key in requiredField) {
		if (!data[key] || data[key].toString().trim().length == 0) {
			showMsg(requiredField[key] + "不能为空!", "W");
			if (key == "outQty") {
				var outQty = nui.get("outQty");
				outQty.focus();
			
			}
			if (key == "pickMan") {
				var pickMan = nui.get("pickMan");
				returnMan.focus();
			}
			if (key == "remark") {
				var remark = nui.get("remark");
				remark.focus();
			}

			return false;
		}
	}
	

}


function onOut() {
	var row = enterGrid.getSelected();
	var partBrandId=row.partBrandId;
	for(var i=0;i<brandList.length;i++){
		if(partBrandId==brandList[i].id){
			row.partBrandId=brandList[i].name;
		}
	}

	if (row) {
		nui.open({
			url : webPath+ partDomain+ "/manage/inOutManage/common/fastPartForConsumableAdd.jsp?token"+ token,
			title : "出库",
			width : 410,
			height : 250,
			allowDrag : false,
			allowResize : false,
			onload : function() {
				var iframe = this.getIFrameEl();
				var params = {
					data : row
				};

				iframe.contentWindow.SetData(params);
			},
			ondestroy : function(action) {
				if (action == 'ok') {
					onSearch();
					morePartSearch();
				}
			}
		});
	} else {
		showMsg("请选择一条记录", "W");
	}
}

function onBlack() {
	var row = grid.getSelected();

	if (row) {
		nui.open({
			url : webPath+ partDomain+ "/manage/inOutManage/common/fastPartForConsumableAdd2.jsp?token"+ token,
			title : "归库",
			width : 430,
			height : 230,
			allowDrag : false,
			allowResize : false,
			onload : function() {
				var iframe = this.getIFrameEl();
				var params = {
					data : row
				};

				iframe.contentWindow.SetData(params);
			},
			ondestroy : function(action) {
				if (action == 'ok') {

					onSearch();
					morePartSearch();

				}
			}
		});
	} else {
		showMsg("请选择一条记录", "W");
	}
}
