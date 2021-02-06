/**
 * Created by Administrator on 2018/2/1.
 */
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + cloudPartApi + "/";// window._rootUrl||"http://127.0.0.1:8080/default/";
var partBaseUrl = apiPath + cloudPartApi + "/";
var rightGridUrl = baseUrl
		+ "com.hsapi.cloud.part.settle.svr.queryRPAccountList.biz.ext";
var deductGridUrl = baseUrl + "com.hsapi.cloud.part.settle.svr.queryAdvanceDeduct.biz.ext";
var refundGridUrl = baseUrl + "com.hsapi.cloud.part.settle.svr.getAdvanceRefund.biz.ext";
/*
 * var innerPchsGridUrl =
 * baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjEnterDetailList.biz.ext";
 * var innerSellGridUrl =
 * baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjSellOutDetailList.biz.ext";
 */
var innerPchsGridUrl = partBaseUrl
		+ "com.hsapi.part.invoice.svr.queryPjPchsOrderDetailList.biz.ext";
var innerSellGridUrl = partBaseUrl
		+ "com.hsapi.part.invoice.svr.queryPjSellOrderDetailList.biz.ext";
var innerStateGridUrl = partBaseUrl
		+ "com.hsapi.part.invoice.settle.getPJStatementDetailById.biz.ext";
var rechargeBalaAmt = null;
var statusList = [{id:"0",name:"车牌号"},{id:"1",name:"手机号"},{id:"2",name:"客户名称"},{id:"3",name:"业务单号"}];
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var basicInfoForm = null;
var rRightGrid = null;
var rechargeBalaAmt = 0;
var btnEdit2Name = "";
var searchBeginDate = null;
var searchEndDate = null;
var comPartNameAndPY = null;
var comPartCode = null;
var comServiceId = null;
var comSearchGuestId = null;
var deductGrid = null;
var refundGrid = null;
// var editFormPchsEnterDetail = null;
var innerPchsEnterGrid = null;
// var editFormPchsRtnDetail = null;
var innerPchsRtnGrid = null;
// var editFormSellOutDetail = null;
var innerSellOutGrid = null;
// var editFormSellRtnDetail = null;
var innerSellRtnGrid = null;
var editFormStatementDetail = null;
var innerStatementGrid = null;
var auditWin = null;
var settleWin = null;
var gprows = null;
var mainTabs = null;
var settleAccountGrid = null;

var pchsEnterWin = null;
var pchsRtnWin = null;
var sellOutWin = null;
var sellRtnWin = null;

var storehouseHash = {};
var billTypeIdHash = {};
var settTypeIdHash = {};
var enterTypeIdList = [];
var enterTypeIdHash = {};
var compBrandList = [];
var compBrandHash = {};
var partBrandIdHash = {};
var billStatusHash = {
	"0" : "未审",
	"1" : "已审",
	"2" : "已过账",
	"3" : "已取消"
};
var settleStatusHash = {
	"0" : "未收款",
	"1" : "部分收款",
	"2" : "已收款"
};
var auditSignHash = {
		"0" : "未审核",
		"1" : "已审核"
	};
var headerHash = [{ name: '未收款', id: '0' }, { name: '部分收款', id: '1' }, { name: '已收款', id: '2' }];
var balanceList = [ {
	id : 0,
	text : "未对"
}, {
	id : 1,
	text : "已对"
}, {
	id : 2,
	text : "全部"
} ];
var settleStatusList = [ {
	id : 0,
	text : "未收款"
}, {
	id : 1,
	text : "部分收款"
}, {
	id : 2,
	text : "已收款"
} ];
var typeIdHash = {
	1 : "采购订单",
	2 : "销售订单",
	3 : "采购退货",
	4 : "销售退货"
};

$(document).ready(
		function(v) {
			rRightGrid = nui.get("rRightGrid");
			rRightGrid.setUrl(rightGridUrl);
			searchBeginDate = nui.get("beginDate");
			searchEndDate = nui.get("endDate");
			// comSearchGuestId = nui.get("searchGuestId");
			mainTabs = nui.get("mainTabs");
			settleAccountGrid = nui.get("settleAccountGrid");

			innerPchsEnterGrid = nui.get("innerPchsEnterGrid");
			editFormPchsEnterDetail = document
					.getElementById("editFormPchsEnterDetail");
			innerPchsEnterGrid.setUrl(innerPchsGridUrl);

			innerPchsRtnGrid = nui.get("innerPchsRtnGrid");
			editFormPchsRtnDetail = document
					.getElementById("editFormPchsRtnDetail");
			innerPchsRtnGrid.setUrl(innerSellGridUrl);

			innerSellOutGrid = nui.get("innerSellOutGrid");
			editFormSellOutDetail = document
					.getElementById("editFormSellOutDetail");
			innerSellOutGrid.setUrl(innerSellGridUrl);

			innerSellRtnGrid = nui.get("innerSellRtnGrid");
			editFormSellRtnDetail = document
					.getElementById("editFormSellRtnDetail");
			innerSellRtnGrid.setUrl(innerPchsGridUrl);

			innerStatementGrid = nui.get("innerStatementGrid");
			editFormStatementDetail = document
					.getElementById("editFormStatementDetail");
			innerStatementGrid.setUrl(innerStateGridUrl);

			advancedSearchWin = nui.get("advancedSearchWin");
			advancedSearchForm = new nui.Form("#advancedSearchWin");
			auditWin = nui.get("auditWin");
			settleWin = nui.get("settleWin");
			
			deductGrid = nui.get("deductGrid");
			deductGrid.setUrl(deductGridUrl);
			
			refundGrid = nui.get("refundGrid");
			refundGrid.setUrl(refundGridUrl);

			pchsEnterWin = nui.get("pchsEnterWin");
			pchsRtnWin = nui.get("pchsRtnWin");
			sellOutWin = nui.get("sellOutWin");
			sellRtnWin = nui.get("sellRtnWin");
			
			nui.get("rpSettleDate").setValue(now);

			/*rRightGrid.on("cellbeginedit",function(e){
				var row = rRightGrid.getSelected();
		    	if(row.status == 2)
		    	{
		    		switch (e.field)
		    		{
		    		   case "nowAmt":
		    			   e.cancel = true;
		    			   break;
		    		   default:
		    			   break;
		    		}
		    	}
			});*/
			
			getItemType(function(data) {
				enterTypeIdList = data.list || [];
				enterTypeIdList.filter(function(v) {
					enterTypeIdHash[v.id] = v;
				});
				
				var dictDefs ={"orgCarBrandId":"10444"};
			    initDicts(dictDefs, function() {
			    	compBrandList = nui.get("orgCarBrandId").getData();
					compBrandList.forEach(function(v){
						compBrandHash[v.customid]=v;
			    	});
			    });
			    
			});
			var filter = new HeaderFilter(rRightGrid, {
		        columns: [
		            { name: 'guestName' },
		            { name: 'settleStatus' },
		            { name: 'billServiceId' },
		            { name: 'remark' },
		            { name: 'billTypeId' }
		        ],
		        callback: function (column, filtered) {
		        },
		        tranCallBack: function (field) {
		        	var value = null;
		        	switch(field){
			    		case "settleStatus" : 
			    			value = headerHash;
			    			break;
			    		case "billTypeId" :
			    			var arr = [];
			    			for (var i in enterTypeIdHash) {
			    			    var o = {};
			    			    o.name = enterTypeIdHash[i].name;
			    			    o.id = enterTypeIdHash[i].id;
			    			    arr.push(o);
			    			}
			    			value = arr;
			    			break;			    			
			    	}
		        	return value;
		        }
		    });
			
			
			searchBeginDate.setValue(getNowStartDate());
			searchEndDate.setValue(addDate(getNowEndDate(), 1));
			 

			quickSearch(currType);
		});
var queryUrl = baseUrl
		+ "com.hsapi.cloud.part.settle.svr.queryFibInComeExpenses.biz.ext";
function getItemType(callback) {
	nui.ajax({
		url : queryUrl,
		data : {
			token : token
		},
		type : "post",
		success : function(data) {
			if (data && data.list) {
				callback && callback(data);
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
}
function getSearchParam() {
	var params = {};

	// params.guestId = comSearchGuestId.getValue();

	params.sCreateDate = searchBeginDate.getFormValue();
	params.eCreateDate = searchEndDate.getValue();
	var settleStatus = nui.get("settleStatus").getValue();
	if(settleStatus != 3) {
		params.settleStatus = settleStatus;
	}
	var auditSign = nui.get("auditSign").getValue();
	if(auditSign != 2) {
		params.auditSign = auditSign;
	}
	
	return params;
}
var currType = 2;
function quickSearch(type) {
	var params = getSearchParam();
	var queryname = "本日";
	switch (type) {
	case 0:
		params.today = 1;
		params.sCreateDate = getNowStartDate();
		params.eCreateDate = getNowEndDate();
		var queryname = "本日";
		break;
	case 1:
		params.yesterday = 1;
		params.sCreateDate = getPrevStartDate();
		params.eCreateDate = getPrevEndDate();
		var queryname = "昨日";
		break;
	case 2:
		params.thisWeek = 1;
		params.sCreateDate = getWeekStartDate();
		params.eCreateDate = getWeekEndDate();
		var queryname = "本周";
		break;
	case 3:
		params.lastWeek = 1;
		params.sCreateDate = getLastWeekStartDate();
		params.eCreateDate = getLastWeekEndDate();
		var queryname = "上周";
		break;
	case 4:
		params.thisMonth = 1;
		params.sCreateDate = getMonthStartDate();
		params.eCreateDate = getMonthEndDate();
		var queryname = "本月";
		break;
	case 5:
		params.lastMonth = 1;
		params.sCreateDate = getLastMonthStartDate();
		params.eCreateDate = getLastMonthEndDate();
		var queryname = "上月";
		break;
	case 10:
		params.thisYear = 1;
		params.sCreateDate = getYearStartDate();
		params.eCreateDate = getYearEndDate();
		var queryname = "本年";
		break;
	case 11:
		params.lastYear = 1;
		params.sCreateDate = getPrevYearStartDate();
		params.eCreateDate = getPrevYearEndDate();
		var queryname = "上年";
		break;
	default:
		break;
	}
	searchBeginDate.setValue(params.sCreateDate);
	searchEndDate.setValue(params.eCreateDate);
	currType = type;
	var menunamedate = nui.get("menunamedate");
	menunamedate.setText(queryname);
	
	doSearch(params);
}
function onSearch() {
	
	var params = getSearchParam();

	doSearch(params);
}
function doSearch(params) {
	var tab = mainTabs.getActiveTab();
	params.eCreateDate = addDate(params.eCreateDate, 1);
	params.guestId = nui.get("searchGuestId").getValue();
	params.isAdvance = 1;

	var name = tab.name;
	switch (name) {
	
	case "rRightTab":
		params.billDc = 2;
		rRightGrid.load({
			params : params,
			token : token
		});
		break;

	default:
		break;
	}

}
function advancedSearch() {
	advancedSearchWin.show();
	advancedSearchForm.clear();
	if (advancedSearchFormData) {
		advancedSearchForm.setData(advancedSearchFormData);
		nui.get("btnEdit2").setText(btnEdit2Name);
	}
}
function onAdvancedSearchOk() {
	var params = getSearchParam();
	var searchData = advancedSearchForm.getData();
	advancedSearchFormData = {};
	for ( var key in searchData) {
		advancedSearchFormData[key] = searchData[key];
	}
	 btnEdit2Name = nui.get("btnEdit2").getText();
	var i;
	if (searchData.sCreateDate) {
		searchData.sCreateDate = formatDate(searchData.sCreateDate);
	}
	if (searchData.eCreateDate) {
		var date = searchData.eCreateDate;
		searchData.eCreateDate = addDate(date, 1);
		
	}
	// 审核日期
	if (searchData.sBalanceDate) {
		searchData.sBalanceDate = searchData.sBalanceDate.substr(0, 10);
	}
	if (searchData.eBalanceDate) {
		var date = searchData.eBalanceDate;
		searchData.eBalanceDate = addDate(date, 1);
		searchData.eBalanceDate = searchData.eBalanceDate.substr(0, 10);
	}
	// 供应商
	if (searchData.guestId) {
		params.guestId = nui.get("btnEdit2").getValue();
	}
	// 订单单号
	if (searchData.billServiceIdList) {
		var tmpList = searchData.billServiceIdList.split("\n");
		for (i = 0; i < tmpList.length; i++) {
			tmpList[i] = "'" + tmpList[i] + "'";
		}
		searchData.billServiceIdList = tmpList.join(",");
	}
	if (searchData.balanceSign) {
		if (searchData.balanceSign == 2) {
			searchData.balanceSign = null;
		}
	}
	if(searchData.settleStatus) {
		var settleStatus = searchData.settleStatus;
		if(settleStatus == 3) {
			searchData.settleStatus = null;
		}
	}
	
	advancedSearchWin.hide();
	doSearch(searchData);
}
function onAdvancedSearchCancel() {
	advancedSearchForm.clear();
	advancedSearchWin.hide();
}
var supplier = null;
function selectSupplier(elId) {
	supplier = null;
	nui.open({
		targetWindow : window,
		// url: "com.hsweb.frm.arap.supplierSelect.flow",
		url : webPath + contextPath
				+ "/com.hsweb.cloud.part.common.guestSelect.flow?token=" + token,
		title : "结算单位资料",
		width : 980,
		height : 560,
		allowDrag : true,
		allowResize : true,
		onload : function() {
			var iframe = this.getIFrameEl();
            var params = {
                isClient: 1
            };
            iframe.contentWindow.setGuestData(params);
		},
		ondestroy : function(action) {
			if (action == 'ok') {
				var iframe = this.getIFrameEl();
				var data = iframe.contentWindow.getData();
				supplier = data.supplier;
				var value = supplier.id;
				var text = supplier.fullName;
				var el = nui.get(elId);
				el.setValue(value);
				el.setText(text);
			}
		}
	});
}
function onStateDrawCell(e) {
	switch (e.field) {
	case "typeCode":
		if (typeIdHash && typeIdHash[e.value]) {
			e.cellHtml = typeIdHash[e.value];
		}
		break;
	}
}
function onDrawCell(e) {
	switch (e.field) {
	case "comPartBrandId":
		if (partBrandIdHash && partBrandIdHash[e.value]) {
			e.cellHtml = partBrandIdHash[e.value].name;
		}
		break;
	case "billTypeId":
		if (enterTypeIdHash && enterTypeIdHash[e.value]) {
			e.cellHtml = enterTypeIdHash[e.value].name;
		}
		break;
	case "billStatus":
		if (billStatusHash && billStatusHash[e.value]) {
			e.cellHtml = billStatusHash[e.value];
		}
		break;
	case "settleTypeId":
		if (settTypeIdHash && settTypeIdHash[e.value]) {
			e.cellHtml = settTypeIdHash[e.value].name;
		}
		break;
	case "storeId":
		if (storehouseHash && storehouseHash[e.value]) {
			e.cellHtml = storehouseHash[e.value].name;
		}
		break;
	case "enterDayCount":
		var row = e.record;
		var enterTime = (new Date(row.enterDate)).getTime();
		var nowTime = (new Date()).getTime();
		var dayCount = parseInt((nowTime - enterTime) / 1000 / 60 / 60 / 24);
		e.cellHtml = dayCount + 1;
		break;
	case "settleStatus":
		if (settleStatusHash && settleStatusHash[e.value]) {
			e.cellHtml = settleStatusHash[e.value];
		}
		break;
	case "orgCarBrandId":
		if (compBrandHash && compBrandHash[e.value]) {
			e.cellHtml = compBrandHash[e.value].name;
		}
		break;
	case "auditSign":
		if (auditSignHash && auditSignHash[e.value]) {
			e.cellHtml = auditSignHash[e.value];
		}
		break;		
	case "nowAmt":
		e.cellStyle = 'background-color:#90EE90';
		break;
	case "nowVoidAmt":
		e.cellStyle = 'background-color:#90EE90';
		break;
	default:
		break;
	}
}

function onShowRowDetail(e) {
	var row = e.record;
	var mainId = row.billMainId;

	// 将editForm元素，加入行详细单元格内
	var rightGrid = null;
	var tab = mainTabs.getActiveTab();
	var name = tab.name;
	switch (name) {

	case "rRightTab":
		rightGrid = rRightGrid;
		break;

	default:
		break;
	}

	var td = rightGrid.getRowDetailCellEl(row);
	var billTypeId = row.billTypeId;
	var rpTypeId = row.rpTypeId;

	switch (billTypeId) {
	case 1:// "050101"
		if (rpTypeId != 1)
			return;
		td.appendChild(editFormPchsEnterDetail);
		editFormPchsEnterDetail.style.display = "";

		var params = {};
		params.mainId = mainId;
		innerPchsEnterGrid.load({
			params : params,
			token : token
		});
		break;
	case 4:// "050102"
		if (rpTypeId != 1)
			return;
		td.appendChild(editFormSellRtnDetail);
		editFormSellRtnDetail.style.display = "";

		var params = {};
		params.mainId = mainId;
		innerSellRtnGrid.load({
			params : params,
			token : token
		});

		break;
	case 3:// "050201"
		if (rpTypeId != 1)
			return;
		td.appendChild(editFormPchsRtnDetail);
		editFormPchsRtnDetail.style.display = "";

		var params = {};
		params.mainId = mainId;
		innerPchsRtnGrid.load({
			params : params,
			token : token
		});
		break;
	case 2:// "050202"
		if (rpTypeId != 1)
			return;
		td.appendChild(editFormSellOutDetail);
		editFormSellOutDetail.style.display = "";

		var params = {};
		params.mainId = mainId;
		innerSellOutGrid.load({
			params : params,
			token : token
		});

		break;
	case 101:
	case 102:
	case 201:
	case 202:// "050202"
		td.appendChild(editFormStatementDetail);
		editFormStatementDetail.style.display = "";

		var params = {};
		params.mainId = mainId;
		innerStatementGrid.load({
			params : params,
			token : token
		});

		break;
	default:
		break;
	}
}
function onStatementDbClick(e) {
	var row = e.record;
	var mainId = row.billMainId;
	var rpDc = row.rpDc;
	switch (rpDc) {
	case -1:
		pchsEnterWin.show();

		var params = {};
		params.mainId = mainId;
		innerPchsEnterGrid.load({
			params : params,
			token : token
		});
		break;
	case 1:// "050201"
		pchsRtnWin.show();

		var params = {};
		params.mainId = mainId;
		innerPchsRtnGrid.load({
			params : params,
			token : token
		});
		break;
	default:
		break;
	}
	/*
	 * var billTypeCode = row.typeCode; switch (billTypeCode) { case "050101":
	 * pchsEnterWin.show();
	 * 
	 * var params = {}; params.mainId = mainId; innerPchsEnterGrid.load({
	 * params:params, token: token }); break; case "050102"://"050102"
	 * sellRtnWin.show();
	 * 
	 * var params = {}; params.mainId = mainId; innerSellRtnGrid.load({
	 * params:params, token: token });
	 * 
	 * break; case "050201"://"050201" pchsRtnWin.show();
	 * 
	 * var params = {}; params.mainId = mainId; innerPchsRtnGrid.load({
	 * params:params, token: token }); break; case "050202"://"050202"
	 * sellOutWin.show();
	 * 
	 * var params = {}; params.mainId = mainId; innerSellOutGrid.load({
	 * params:params, token: token });
	 * 
	 * break; default: break; }
	 */
}
function doBalance() {
	var rightGrid = null;
	var firstRow = {};
	var guestId = null;
	var tab = mainTabs.getActiveTab();
	var name = tab.name;
	switch (name) {
	case "rRightTab":
		rightGrid = rRightGrid;
		break;

	default:
		break;
	}
	var msg = checkAuditRow(1);
	if (msg) {
		showMsg(msg, "W");
		return;
	}

	var rows = rightGrid.getSelecteds();
	var s = rows.length;
	if (s > 0) {
		auditWin.show();

		var rtn = getRPAmount(rows);
		var guestName = rows[0].guestName;
		document.getElementById('balanceGuestName').innerHTML = "对账单位："
				+ guestName;
		document.getElementById('balanceBillCount').innerHTML = "对账单据数：" + s;
		document.getElementById('pAmt').innerHTML = rtn.pAmount;
		document.getElementById('rAmt').innerHTML = rtn.rAmount;

	} else {
		showMsg("请选择单据!", "W");
		return;
	}
}
function getRPAmount(rows) {
	var s = rows.length;
	var pAmount = 0;
	var rAmount = 0;
	if (s > 0) {

		for (var i = 0; i < s; i++) {
			var row = rows[i];
			var dc = row.billDc;
			if (dc == -1) {
				pAmount += row.rpAmt;
			} else {
				rAmount += row.rpAmt;
			}
		}
	}
	var rtnMsg = {};
	rtnMsg.pAmount = pAmount;
	rtnMsg.rAmount = rAmount;
	return rtnMsg;
}
function balanceCancel() {
	document.getElementById('balanceGuestName').innerHTML = "对账单位：";
	document.getElementById('balanceBillCount').innerHTML = "对账单据数：";
	document.getElementById('pAmt').innerHTML = 0;
	document.getElementById('rAmt').innerHTML = 0;
	auditWin.hide();
}
function checkAuditRow(flag) {
	var rightGrid = null;
	var firstRow = {};
	var guestId = null;
	var tab = mainTabs.getActiveTab();
	var name = tab.name;
	switch (name) {
	case "rRightTab":
		rightGrid = rRightGrid;
		break;

	default:
		break;
	}
	var rows = rightGrid.getSelecteds();
	var msg = "";
	var s = rows.length;
	if (s > 0) {
		for (var i = 0; i < s; i++) {
			var row = rows[i];
			if (i == 0) {
				firstRow = row;
				guestId = firstRow.guestId;
			} else {
				var rowGuestId = row.guestId;
				if (guestId != rowGuestId) {
					return "请选择相同结算单位的单据!";
				}
			}
		}

		for (var i = 0; i < s; i++) {
			var row = rows[i];
			var balanceSign = row.balanceSign;
			var billServiceId = row.billServiceId;
			if (balanceSign == flag && balanceSign == 1) {
				msg += "业务单据：" + billServiceId + "已对账；</br>";
			} else if (balanceSign == flag && balanceSign == 0) {
				msg += "业务单据：" + billServiceId + "未对账；</br>";
			}
		}
	} else {
		msg = "请选择单据!";
	}

	return msg;
}

function checkSettleRow() {
	var rightGrid = null;
	var firstRow = {};
	var guestId = null;
	var orgCarBrandId = null;
	var tab = mainTabs.getActiveTab();
	var name = tab.name;
	switch (name) {


	case "rRightTab":
		rightGrid = rRightGrid;
		break;

	default:
		break;
	}
	var rows = rightGrid.getSelecteds();
	var msg = "";
	var s = rows.length;
	if (s > 0) {
		for (var i = 0; i < s; i++) {
			var row = rows[i];
			if (i == 0) {
				firstRow = row;
				guestId = firstRow.guestId;
				orgCarBrandId =  firstRow.orgCarBrandId;
			} else {
				var rowGuestId = row.guestId;
				var rowOrgCarBrandId =  row.orgCarBrandId;
				if (guestId != rowGuestId) {
					return "请选择相同结算单位的单据!";
				}
				if (orgCarBrandId != rowOrgCarBrandId) {
					return "请选择相同厂牌的单据!";
				}
			}
		}

		for (var i = 0; i < s; i++) {
			var row = rows[i];
			var balanceSign = row.balanceSign;
			var billServiceId = row.billServiceId;
			if (name == "rpRightTab") {
				var amt1 = row.amt1 || 0;
				var amt2 = row.amt2 || 0;
				var amt3 = row.amt3 || 0;
				var amt4 = row.amt4 || 0;
				var amt11 = row.amt11 || 0;
				var amt12 = row.amt12 || 0;
				var amt13 = row.amt13 || 0;
				var amt14 = row.amt14 || 0;
				if (amt1 + amt2 + amt3 + amt4 + amt11 + amt12 + amt13 + amt14 <= 0) {
					msg += "请填写业务单据：" + billServiceId + "的结算金额；</br>";
				}
			} else {
				var noCharOffAmt = row.noCharOffAmt || 0;
				if (noCharOffAmt <= 0) {
					msg += "业务单据：" + billServiceId + "的未结算金额为0；</br>";
				}
			}
		}
	} else {
		msg = "请选择单据!";
	}

	return msg;
}
function doSettle() {
	var msg = checkSettleRow();
	if (msg) {
		showMsg(msg, "W");
		return;
	}

	var rightGrid = null;
	var firstRow = {};
	var guestId = null;
	var tab = mainTabs.getActiveTab();
	var name = tab.name;
	switch (name) {


	case "rRightTab":
		rightGrid = rRightGrid;
		break;

	default:
		break;
	}

	var rows = rightGrid.getSelecteds();
	for(var i =0;i<rows.length;i++){
		if(rows[i].settleStatus==2){
			showMsg(rows[i].billServiceId+"已结算", "W");
			return;
		}
		if(rows[i].auditSign==0){
			showMsg("请先审核单据："+rows[i].billServiceId, "W");
			return;
		}
	}

	var s = rows.length;
	if (s > 0) {
		if (name == "pRightTab") {
			document.getElementById('rtTr').style.display = "none";
			document.getElementById('rcTr').style.display = "none";
			document.getElementById('ptTr').style.display = "";
			document.getElementById('pcTr').style.display = "";
		} else if (name == "rRightTab") {
			document.getElementById('rtTr').style.display = "";
			document.getElementById('rcTr').style.display = "";
			document.getElementById('ptTr').style.display = "none";
			document.getElementById('pcTr').style.display = "none";
		} else {
			document.getElementById('rtTr').style.display = "";
			document.getElementById('rcTr').style.display = "";
			document.getElementById('ptTr').style.display = "";
			document.getElementById('pcTr').style.display = "";
		}
		if(rows[0].billTypeCode==105||rows[0].billTypeCode==104){
			document.getElementById('ctTr').style.display = "none";
			document.getElementById('ccTr').style.display = "none";
		}
		var rtn = getSettleAmount(rows);
		var errCode = rtn.errCode;
		if (errCode != 'S') {
			showMsg(rtn.errMsg || "结算数据填写有问题!", "W");
			return;
		}		
		settleWin.show();
		var guestName = rows[0].guestName;
        document.getElementById('settleGuestName').innerHTML="结算单位："+guestName;
        document.getElementById('settleBillCount').innerHTML="结算单据数："+s;
        document.getElementById('rRPAmt').innerHTML=rtn.rRPAmt;
        document.getElementById('rTrueAmt').innerHTML=rtn.rNoCharOffAmt;
        //document.getElementById('rVoidAmt').innerHTML=rtn.rVoidAmt;
        document.getElementById('rNoCharOffAmt').innerHTML=rtn.rNoCharOffAmt;
        document.getElementById('rCharOffAmt').innerHTML=rtn.rCharOffAmt;
        document.getElementById('pRPAmt').innerHTML=rtn.pRPAmt;
        document.getElementById('pTrueAmt').innerHTML=rtn.pNoCharOffAmt;
        //document.getElementById('pVoidAmt').innerHTML=rtn.pVoidAmt;
        document.getElementById('pNoCharOffAmt').innerHTML=rtn.pNoCharOffAmt;
        document.getElementById('pCharOffAmt').innerHTML=rtn.pCharOffAmt;
        document.getElementById('rpAmt').innerHTML=rtn.rpAmt;

        settleAccountGrid.setData([]);
        addSettleAccountRow();
		


	} else {
		showMsg("请选择单据!", "W");
		return;
	}
}
function getSettleAmount(rows) {
	var tab = mainTabs.getActiveTab();
	var name = tab.name;

	var rRPAmt = 0; // 应收金额
	var rTrueAmt = 0; // 实收应收
	var rVoidAmt = 0; // 优惠金额
	var rNoCharOffAmt = 0; // 未结金额
	var rCharOffAmt = 0; // 已结金额
	var pRPAmt = 0; // 应付金额
	var pTrueAmt = 0; // 实付金额
	var pVoidAmt = 0; // 免付金额
	var pNoCharOffAmt = 0; // 未结金额
	var pCharOffAmt = 0; // 已结金额
	var rpAmt = 0; // 合计金额

	var s = rows.length;
	var pAmount = 0;
	var rAmount = 0;
	var s1 = 0; // 合计收
	var s2 = 0; // 合计付
	var billServiceId = null;
	var errCode = 'S';
	var errMsg = null;
	if (s > 0) {

		for (var i = 0; i < s; i++) {
			var row = rows[i];
			billServiceId = row.billServiceId;
			var billDc = row.billDc;
			var charOffAmt = row.charOffAmt || 0; // 已结金额
			var rpAmt = row.rpAmt || 0; // 应结金额
			var noCharOffAmt = row.noCharOffAmt || 0;
			charOffAmt = parseFloat(charOffAmt);
			rpAmt = parseFloat(rpAmt);
			noCharOffAmt = parseFloat(noCharOffAmt);
			if(noCharOffAmt == 0)  {
				errCode = 'E';
				errMsg = "业务单：" + billServiceId + "已结算";
				break;
			}
			
			if (name == "rpRightTab") {

				if (billDc == 2) {
					rRPAmt += rpAmt;
					rTrueAmt += charOffAmt;
					rNoCharOffAmt += noCharOffAmt;
					rCharOffAmt += charOffAmt;
				} else if (billDc == -2) {
					pRPAmt += rpAmt;
					pTrueAmt += charOffAmt;
					pNoCharOffAmt += noCharOffAmt;
					pCharOffAmt += charOffAmt;
				}
				s1 += noCharOffAmt;
			} else if (name == "pRightTab") {
				pRPAmt += rpAmt;
				pTrueAmt += charOffAmt;
				pNoCharOffAmt += noCharOffAmt;
				pCharOffAmt += charOffAmt;
				s1 += noCharOffAmt;
			} else if (name == "rRightTab") {
				rRPAmt += rpAmt;
				rTrueAmt += charOffAmt;
				rNoCharOffAmt += noCharOffAmt;
				rCharOffAmt += charOffAmt;
				s1 += noCharOffAmt;//(nowAmt + nowVoidAmt);
			}
		}

		s1 += s2;
	}
	var rtnMsg = {};
	rtnMsg.rRPAmt = rRPAmt; // 应收金额
	rtnMsg.rTrueAmt = rTrueAmt; // 实收应收
	//rtnMsg.rVoidAmt = rVoidAmt; // 优惠金额
	rtnMsg.rNoCharOffAmt = rNoCharOffAmt; // 未结金额
	rtnMsg.rCharOffAmt = rCharOffAmt; // 已结金额
	rtnMsg.pRPAmt = pRPAmt; // 应付金额
	rtnMsg.pTrueAmt = pTrueAmt; // 实付金额
	//rtnMsg.pVoidAmt = pVoidAmt; // 免付金额
	rtnMsg.pNoCharOffAmt = pNoCharOffAmt; // 未结金额
	rtnMsg.pCharOffAmt = pCharOffAmt; // 已结金额
	rtnMsg.rpAmt = s1; // 合计金额
	rtnMsg.errCode = errCode;
	rtnMsg.errMsg = errMsg;
	return rtnMsg;
}
function settleCancel() {
	document.getElementById('settleGuestName').innerHTML = "结算单位：";
	document.getElementById('settleBillCount').innerHTML = "结算单据数：";
	document.getElementById('rRPAmt').innerHTML = 0;
	document.getElementById('rTrueAmt').innerHTML = 0;
	document.getElementById('rVoidAmt').innerHTML = 0;
	document.getElementById('rNoCharOffAmt').innerHTML = 0;
	document.getElementById('pRPAmt').innerHTML = 0;
	document.getElementById('pTrueAmt').innerHTML = 0;
	document.getElementById('pVoidAmt').innerHTML = 0;
	document.getElementById('pNoCharOffAmt').innerHTML = 0;
	document.getElementById('rpAmt').innerHTML = 0;
	nui.get('rpTextRemark').setValue("");
	settleWin.hide();

	settleAccountGrid.setData([]);
}
var settleAuditUrl = baseUrl
		+ "com.hsapi.cloud.part.settle.rpsettle.rpAdvanceSettle.biz.ext";
function settleOK() {
	var msg = checkSettleRow();
	if (msg) {
		showMsg(msg, "W");
		return;
	}

	var rAmt = document.getElementById('rTrueAmt').innerHTML;
	var pAmt = document.getElementById('pTrueAmt').innerHTML;
	var rpAmt = document.getElementById('rpAmt').innerHTML;
	if (rAmt) {
		rAmt = parseFloat(rAmt);
	} else {
		rAmt = 0;
	}
	if (pAmt) {
		pAmt = parseFloat(pAmt);
	} else {
		pAmt = 0;
	}
	rpAmt = Math.abs(rAmt - pAmt);
	msg = checkSettleAccountAmt(rpAmt);
	if (!msg) {
		return;
	}

	var rightGrid = null;
	var firstRow = {};
	var guestId = null;
	var tab = mainTabs.getActiveTab();
	var name = tab.name;
	switch (name) {


	case "rRightTab":
		rightGrid = rRightGrid;
		break;

	default:
		break;
	}

	// account accountDetailList
	// guest_id, guest_name bala_type_id空 bala_account空 rp_dc char_off_amt
	// void_amt item_qty settle_type remark
	// bill_rp_id, bill_main_id bill_service_id bill_type_id rp_dc char_off_amt
	// void_amt
	var account = {};
	var accountDetailList = [];
	var rows = rightGrid.getSelecteds();
	var s = rows.length;
	if (s > 0) {

		var rRPAmt = 0; // 应收金额
		var rTrueAmt = 0; // 实收应收
		var rVoidAmt = 0; // 优惠金额
		var rNoCharOffAmt = 0; // 未结金额
		var pRPAmt = 0; // 应付金额
		var pTrueAmt = 0; // 实付金额
		var pVoidAmt = 0; // 免付金额
		var pNoCharOffAmt = 0; // 未结金额
		var rpAmt = 0; // 合计金额

		var s = rows.length;
		var pAmount = 0;
		var rAmount = 0;
		var s1 = 0; // 合计收
		var s2 = 0; // 合计付

		firstRow = rows[0];
		account.guestId = firstRow.guestId;
		account.guestName = firstRow.guestName;
		account.itemQty = s;
		account.remark = nui.get('rpTextRemark').getValue();

		for (var i = 0; i < s; i++) {
			var row = rows[i];
			var accountDetail = {};
			accountDetail.billRpId = row.id;
			accountDetail.billMainId = row.billMainId;
			accountDetail.billServiceId = row.billServiceId;
			accountDetail.billTypeId = row.billTypeId;
			if (name == "rpRightTab") {
				var billDc = row.billDc;
				var charOffAmt = row.charOffAmt || 0; // 已结金额
				var rpAmt = row.rpAmt || 0; // 应结金额
				var amt2 = row.amt2 || 0;
				var amt3 = row.amt3 || 0;
				var amt12 = row.amt12 || 0;
				var amt13 = row.amt13 || 0;
				var noCharOffAmt = rpAmt - charOffAmt;
				amt2 = parseFloat(amt2);
				amt3 = parseFloat(amt3);
				amt12 = parseFloat(amt12);
				amt13 = parseFloat(amt13);
				if (billDc == 1) {
					accountDetail.rpDc = 1;
					rRPAmt += rpAmt;
					rTrueAmt += amt2;
					rVoidAmt += amt3;
					rNoCharOffAmt += noCharOffAmt;
					s1 += (amt2 + amt3);
					accountDetail.charOffAmt = amt2;
					accountDetail.voidAmt = amt3;
				} else if (billDc == -1) {
					accountDetail.rpDc = -1;
					pRPAmt += rpAmt;
					pTrueAmt += amt12;
					pVoidAmt += amt13;
					pNoCharOffAmt += noCharOffAmt;
					s2 += (amt12 + amt13) * -1;
					accountDetail.charOffAmt = amt12;
					accountDetail.voidAmt = amt13;
				}
			} else if (name == "pRightTab") {
				var noCharOffAmt = row.noCharOffAmt || 0; // 已结金额
				var rpAmt = row.rpAmt || 0; // 应结金额
				var nowAmt = row.noCharOffAmt || 0;
				accountDetail.rpDc = -1;
				nowAmt = parseFloat(nowAmt);
				pRPAmt += rpAmt;
				pTrueAmt += nowAmt;
				pNoCharOffAmt += noCharOffAmt;
				s1 += (nowAmt);
				accountDetail.charOffAmt = nowAmt;
				accountDetail.voidAmt = 0;
			} else if (name == "rRightTab") {
				var noCharOffAmt = row.noCharOffAmt || 0; // 已结金额
				var rpAmt = row.rpAmt || 0; // 应结金额
				var nowAmt = row.noCharOffAmt || 0;
				accountDetail.rpDc = 1;
				nowAmt = parseFloat(nowAmt);
				rRPAmt += rpAmt;
				rTrueAmt += nowAmt;
				rNoCharOffAmt += noCharOffAmt;
				s1 += (nowAmt);
				accountDetail.charOffAmt = nowAmt;
				accountDetail.voidAmt = 0;
			}

			accountDetailList.push(accountDetail);
		}

		if (name == "rpRightTab") {
			s1 += s2;
			if (s1 < 0) {
				account.rpDc = -1;
			} else {
				account.rpDc = 1;
			}
			account.settleType = "综合";
			//account.voidAmt = Math.abs(rVoidAmt - pVoidAmt);
			account.trueCharOffAmt = Math.abs(rTrueAmt - pTrueAmt);
			account.charOffAmt = account.trueCharOffAmt;
		} else if (name == "pRightTab") {
			;
			account.rpDc = -1;
			account.settleType = "应付";
			account.voidAmt = pVoidAmt;
			account.trueCharOffAmt = pTrueAmt;
			account.charOffAmt = pVoidAmt + pTrueAmt;
		} else if (name == "rRightTab") {
			account.rpDc = 1;
			account.settleType = "应收";
			account.voidAmt = rVoidAmt;
			account.trueCharOffAmt = rTrueAmt;
			account.charOffAmt = rVoidAmt + rTrueAmt;
		}
        if(nui.get("rpSettleDate") == null) {
        	showMsg("请选择结算日期!","W");
        	return;
        }
        account.settleDate = nui.get("rpSettleDate").getValue();
		var accountTypeList = settleAccountGrid.getData();
		nui.mask({
			el : document.body,
			cls : 'mini-mask-loading',
			html : '数据处理中...'
		});

		nui.ajax({
			url : settleAuditUrl,
			type : "post",
			data : JSON.stringify({
				account : account,
				accountDetailList : accountDetailList,
				accountTypeList : accountTypeList,
				token : token
			}),
			success : function(data) {
				nui.unmask(document.body);
				data = data || {};
				if (data.errCode == "S") {
					showMsg("结算成功!", "S");
					
					if(data.mainId) {
						advanceVoucher(data.mainId, rows[0].orgCarBrandId);
					}

					settleCancel();

					balanceCancel();
					rightGrid.reload();

				} else {
					showMsg(data.errMsg || "结算失败!", "w");
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.log(jqXHR.responseText);
			}
		});

	} else {
		showMsg("请选择单据!", "W");
		return;
	}

}


function onRGridbeforeselect(e) {
	var row = e.row;
		var row = e.row;
		var billDc = row.billDc;
		var newRow = {
			nowAmt : row.noCharOffAmt
		};
		if (row.nowAmt) {
			newRow.nowAmt = row.noCharOffAmt;
		} else {
			newRow.nowAmt = row.noCharOffAmt;
		}
		rRightGrid.updateRow(row, newRow);
}


function onRGridheadercellclick(e) {
	rRightGrid.findRows(function(row) {
		var newRow = {};
		var billDc = row.billDc;
		var newRow = {};
		if (row.nowAmt) {
			newRow.nowAmt = row.noCharOffAmt;
		} else {
			newRow.nowAmt = row.noCharOffAmt;
		}
		rRightGrid.updateRow(row, newRow);

	});
}

function onrRightGridSelectionChanged() {
	var row = rRightGrid.getSelected(); 
	var fbillMainId = row.billMainId;
	deductGrid.load({
		mainId : fbillMainId,
		token : token
	});
	
	refundGrid.load({
		advanceId : fbillMainId,
		token : token
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
	var data = settleAccountGrid.getData();
	if (data && data.length == 1) {
		return;
	}
	var row = settleAccountGrid.getRowByUID(row_uid);
	if (row) {
		settleAccountGrid.removeRow(row);
	}
}
// 提交单元格编辑数据前激发
function onCellCommitEdit(e) {
	var editor = e.editor;
	var record = e.record;

	editor.validate();
	if (editor.isValid() == false) {
		showMsg("请输入数字!", "W");
		e.cancel = false;
	}
}
function checkSettleAccountAmt(charOffAmt) {
	var tAmt = 0;
	var rows = settleAccountGrid.findRows(function(row) {
		var settAccountId = row.settAccountId;
		var charOffAmt = row.charOffAmt;
		if (charOffAmt) {
			charOffAmt = parseFloat(charOffAmt);
		}

		tAmt += charOffAmt;

		if (!row.settAccountId) {
			return true;
		}
	});

	if (rows && rows.length > 0) {
		showMsg("请选择结算账户!", "W");
		return false;
	}
	
	if (tAmt != charOffAmt) {
		showMsg("请确定结算金额与合计金额一致!", "W");
		return false;
	}

	return true;
}
function OnModelCellBeginEdit(e) {
	var row = settleAccountGrid.getSelected();

	var column = e.column;
	var editor = e.editor;
	var row = settleAccountGrid.getSelected();

	if (column.field == "settAccountId") {
		var url = baseUrl
				+ "com.hsapi.cloud.part.settle.svr.queryFiSettleAccount.biz.ext?token="
				+ token;
		editor.setUrl(url);
	}

	if (column.field == "balaTypeCode") {
		var str = "accountId=" + row.settAccountId + "&token=" + token;
		var url = baseUrl
				+ "com.hsapi.cloud.part.baseDataCrud.crud.queryAccountSettleType.biz.ext?" + str;
		editor.setUrl(url);
	}

}
function onAccountValueChanged(e) {

	var r = settleAccountGrid.getSelected();
	var newRow = {
		balaTypeCode : null
	};
	settleAccountGrid.updateRow(r, newRow);

}

function onChanged() {
	var rows = rRightGrid.getSelecteds();
	var rtn = getSettleAmount(rows);
	var dk = nui.get("dk").getValue();
	if(dk>rechargeBalaAmt){
		showMsg("抵扣金额不能大于储值卡余额!","W");
		nui.get("dk").setValue(0);
		return;
	}
	document.getElementById('rpAmt').innerHTML = rtn.rpAmt-dk;

}




function onExport(){

	var detail = rRightGrid.getData();
	
	if(detail && detail.length > 0){
		setInitExportData(detail);
	}else{
		showMsg("没有可导出数据！","W");
	}
}
function setInitExportData(detail){
    var tds = '<td  colspan="1" align="left">[guestName]</td>' +
        "<td  colspan='1' align='left'>[billServiceId]</td>" +
        "<td  colspan='1' align='left'>[billTypeId]</td>" +
        "<td  colspan='1' align='left'>[remark]</td>" +
        "<td  colspan='1' align='left'>[rpAmt]</td>" +
        "<td  colspan='1' align='left'>[createDate]</td>" +
        "<td  colspan='1' align='left'>[settleStatus]</td>"+
        "<td  colspan='1' align='left'>[charOffAmt]</td>";
        
    var tableExportContent = $("#tableExportContent");
    tableExportContent.empty();
    for (var i = 0; i < detail.length; i++) {
        var row = detail[i];
        if(row){
        	var billTypeName = detail[i].billTypeId;
        	var settleStatus = detail[i].settleStatus;
        	if(billTypeName) {
        		billTypeName = enterTypeIdHash[billTypeName].name;
        	}
        	settleStatus = settleStatusHash[settleStatus];
            var tr = $("<tr></tr>");
            tr.append(tds.replace("[guestName]", detail[i].guestName?detail[i].guestName:"")
                         .replace("[billServiceId]", detail[i].billServiceId?detail[i].billServiceId:"")
                         .replace("[billTypeId]", billTypeName?billTypeName:"")
                         .replace("[remark]", detail[i].remark?detail[i].remark:"")
                         .replace("[rpAmt]", detail[i].rpAmt?detail[i].rpAmt:0)
                         .replace("[createDate]", detail[i].createDate?detail[i].createDate.Format("yyyy-MM-dd HH:mm:ss"):"")
                         .replace("[settleStatus]", settleStatus?settleStatus:"")
                         .replace("[charOffAmt]", detail[i].charOffAmt?detail[i].charOffAmt:0));
            tableExportContent.append(tr);
        }
    }

    method5('tableExcel',"预收账款管理",'tableExportA');
}

function openOrderDetail(){
	var row = rRightGrid.getSelected();
	if(row){
		if(row.billTypeId==103||row.billTypeId==106||row.billTypeId==108 ||row.billTypeId== 119){		
			var data={};
			data.id=row.billMainId;

			if(data.id){
				var item={};
				item.id = "11111";
			    item.text = "应收详情页";
				item.url =webBaseUrl+  "com.hsweb.repair.DataBase.orderDetail.flow?sourceServiceId="+data.id;
				item.iconCls = "fa fa-cog";
				window.parent.activeTabAndInit(item,data);
			}	
		}else{
		showMsg("无详情！","W");
		}
	}else{
		showMsg("请选择单据!", "W");
		return;
	}

}
var doAuditUrl = baseUrl+"com.hsapi.cloud.part.settle.rpsettle.advanceAudit.biz.ext";
function doAudit(){
	var rows = rRightGrid.getSelecteds();
	for(var i =0;i<rows.length;i++){
		if(rows[i].auditSign==1){
			showMsg(rows[i].billServiceId+"已审核", "W");
			return;
		}
/*		if(rows[i].nowAmt>rows[0].noCharOffAmt){
			showMsg("结算金额不能大于应结金额", "W");
			return;
		}*/
	}
	
	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '数据处理中...'
	});

	nui.ajax({
		url : doAuditUrl,
		type : "post",
		data : JSON.stringify({

			rpBill : rows
		}),
		success : function(data) {
			nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
				showMsg("审核成功!", "S");
				onSearch();

			} else {
				showMsg(data.errMsg || "审核失败!", "W");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
}

function onDeduct() {
	var rows = rRightGrid.getSelecteds();
	if(rows && rows.length == 1) {
		var row = rows[0];
		if(row.charOffAmt > 0) {
			nui.open({
				url : webPath + contextPath
						+ "/com.hsweb.cloud.part.settlement.deduct.flow?token=" + token,
				title : "预收款冲减",
				width : 700,
				height : 600,
				allowDrag : true,
				allowResize : false,
				onload : function() {
					var iframe = this.getIFrameEl();
					var data = {};
					data.guestId = row.guestId;
					data.isAdvance = 0;
					data.billDc = 1;
					data.guestName = row.guestName;
					data.billMainId = row.billMainId;
					data.rpDc = 1;
					data.settleType = "应收";
					iframe.contentWindow.setInitDate(data);
				},
				ondestroy : function(action) {
						quickSearch(2);
				}
			});
		}else {
			showMsg("请选择已结的记录", "W");
		}
	}else {
		showMsg("请选择一条记录", "W");
	}
}

function print(){
	var msg = checkSettleRow();
	if (msg) {
		showMsg(msg, "W");
		return;
	}
	var rows = rRightGrid.getSelecteds();
	var sourceUrl = webPath + contextPath + "/com.hsweb.RepairBusiness.arrearsPrint.flow?token="+token;
	var printName = currOrgName;
	var p = {
		comp : printName,
		partApiUrl:apiPath + partApi + "/",
		frmApiUrl:apiPath + frmApi + "/",
		baseUrl: apiPath + repairApi + "/",
		sysUrl: apiPath + sysApi + "/",
		webUrl:webPath + contextPath + "/",
        bankName: currBankName,
        bankAccountNumber: currBankAccountNumber,
        currCompAddress: currCompAddress,
        currCompTel: currCompTel,
        currSlogan1: currSlogan1,
        currSlogan2: currSlogan2,
        currUserName : currUserName,
        currCompLogoPath: currCompLogoPath,
		token : token
	};
	var businessNumber = "";
	var netInAmt =0;
	for(var i = 0;i<rows.length;i++){
		if(i==rows.length-1){
			businessNumber = businessNumber+rows[i].billServiceId
			netInAmt = parseFloat(netInAmt)+parseFloat(rows[i].nowAmt);
			netInAmt = netInAmt.toFixed(2);
			
		}else{
			businessNumber = businessNumber+rows[i].billServiceId+","
			netInAmt = parseFloat(netInAmt)+parseFloat(rows[i].nowAmt);
			netInAmt = netInAmt.toFixed(2)
		}
		
	}
	//var guestData = [{guestName:rows[0].fullName}]
	params = {
		guestData:rows,
		businessNumber :businessNumber,
		billServiceId : rows[0].billServiceId,
		netInAmt:netInAmt,
		p:p
	};


	nui.open({
        url: sourceUrl,
        title:"打印欠款证明单",
		width: "100%",
		height: "100%",
        onload: function () {
            var iframe = this.getIFrameEl();
           iframe.contentWindow.SetData(params);
        },
        ondestroy: function (action){
        }
    });
}
function addPrepaid(){
	nui.open({
		//targetWindow : window,
		url : webPath + contextPath
				+ "/com.hsweb.cloud.part.settlement.addPrepaid.flow?token=" + token,
		title : "新增预收账款",
		width : 480,
		height : 290,
		allowDrag : true,
		allowResize : true,
		onload : function() {
			var iframe = this.getIFrameEl();
			var data = {};
			data.type=2;//预收
			iframe.contentWindow.setData(data);
		},
		ondestroy : function(action) {
				quickSearch(2);
		}
	});
}

var advanceUrl = baseUrl+"com.hsapi.cloud.part.invoicing.ordersettle.generateKingAdvance.biz.ext";
function advanceVoucher(mainId, orgCarBrandId){
	nui.ajax({
		url : advanceUrl,
		type : "post",
		async:true,
		data : JSON.stringify({
			id: mainId,
			dc: 2,
			orgCarBrandId: orgCarBrandId,
			settleDate: nui.get("rpSettleDate").getValue()
		}),
		success : function(data) {
			console.log(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
}

function onRefund() {

	var rightGrid = null;
	var tab = mainTabs.getActiveTab();
	var name = tab.name;
	switch (name) {
		case "rRightTab":
			rightGrid = rRightGrid;
			break;
		default:
			break;
	}

	var rows = rightGrid.getSelecteds();
	if(rows == null || rows.length>1) {
		showMsg("请选择一条记录进行退款", "W");
		return;
	}
	var row = rightGrid.getSelected();
	if(row.settleStatus != 2) {
		showMsg("此记录未结算", "W");
		return;
	}
	
	nui.open({
		//targetWindow : window,
		url : webPath + contextPath
				+ "/com.hsweb.cloud.part.settlement.advanceRefund.flow?token=" + token,
		title : "预收退款",
		width : 480,
		height : 290,
		allowDrag : true,
		allowResize : true,
		onload : function() {
			var iframe = this.getIFrameEl();
			var data = {};
			data.advanceId=row.billMainId;//预收
			iframe.contentWindow.setData(data);
		},
		ondestroy : function(action) {
				quickSearch(2);
		}
	});
		

}

var delUrl = baseUrl+"com.hsapi.cloud.part.settle.svr.delAdvance.biz.ext";
function del(){
	
	var rows = rRightGrid.getSelecteds();
	if(rows && rows.length == 1) {
		var row = rows[0];
		
		if(row.settleStatus>7){
	    	showMsg("已结算不能作废","W");
	    	return;
	    }
	    
	    nui.confirm("是否确定作废?", "友情提示", function(action) {
			if (action == "ok") {
				
				nui.mask({
			        el: document.body,
			        cls: 'mini-mask-loading',
			        html: '处理中...'
			    });

			    nui.ajax({
			        url : delUrl,
			        type : "post",
			        data : JSON.stringify({
			            id : row.id,
			            token : token
			        }),
			        success : function(data) {
			            nui.unmask(document.body);
			            data = data || {};
			            if (data.errCode == "S") {
			                showMsg("操作成功!","S");
			                onSearch();

			            } else {
			                showMsg(data.errMsg || "操作失败!","W");
			            }
			        },
			        error : function(jqXHR, textStatus, errorThrown) {
			            console.log(jqXHR.responseText);
			        }
			    });
				
			} else {
				return;
			}
			
		});
	}else {
		showMsg("请选择一条记录", "W");
	}
	
	   
	    
}