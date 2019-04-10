
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
var storeShelfEl =null;
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
var sCreateDateEl=null;
var eCreateDateEl =null;
var sEnterDateEl =null;
var eEnterDateEl =null;
var pickManHash={};
$(document).ready(function(v) {

	queryInfoForm = new nui.Form("#queryInfoForm").getData(false, false);
	grid = nui.get("grid");

	grid.load(queryInfoForm);
	grid.setUrl(gridUrl);
	grid.on("drawcell", onDrawCell);
//	grid.on("drawcell", function(e){
//		switch (e.field) {
//			case "pickMan" :
//				if (pickManHash[e.value]) {
//					e.cellHtml = pickManHash[e.value].empName || "";
//				} else {
//					e.cellHtml = e.value || "";
//				}
//				break;
//			default:
//				break;
//		}
//	});
	sCreateDateEl=nui.get("sCreateDate");
	eCreateDateEl=nui.get("eCreateDate");
	sEnterDateEl = nui.get('sEnterDate');
	eEnterDateEl = nui.get('eEnterDate');
	getNowFormatDate();

	quickSearch(4);

	enterGrid = nui.get("enterGrid");
	morePartCodeEl = nui.get("morePartCode");
	morePartNameEl = nui.get("morePartName");
	storeShelfEl = nui.get("storeShelf");
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
		onOut();

	});
	
	grid.on("rowdblclick", function(e) {    
		var row = grid.getSelected();
		var rowc = nui.clone(row);
		if (!rowc)
			return;
		onBlack();

	});
	 var filter = new HeaderFilter(enterGrid, {   
	        columns: [
	            { name: 'applyCarModel' },
	            { name: 'guestName' },
	            { name: 'pickMan' },
	            { name: 'partCode' },
	            { name: 'oemCode' },
	            { name: 'remark' },
	            { name: 'partName' }
	        ],
	        callback: function (column, filtered) {
	        },

	        tranCallBack: function (field) {
	        	var value = null;
	        	switch(field){
		    	}
	        	return value;
	        }
	    });     
	 
	 var filter = new HeaderFilter(grid, {
	        columns: [
	            { name: 'partCode' },
	            { name: 'partName' },
	            { name: 'remark' },
	            { name: 'pickMan' },
	            { name: 'returnMan' },
	            { name: 'recorder'}
	        ],
	        callback: function (column, filtered) {
	        },

	        tranCallBack: function (field) {
	        	var value = null;
	        	switch(field){
		    	}
	        	return value;
	        }
	    });
	
	enterGrid.on("drawcell", function(e) {
		switch (e.field) {
		case "partBrandId":
			 if(brandHash[e.value])
             {
//                 e.cellHtml = brandHash[e.value].name||"";
             	if(brandHash[e.value].imageUrl){
             		
             		e.cellHtml = "<img src='"+ brandHash[e.value].imageUrl+ "'alt='配件图片' height='25px' width=' '/><br> "+brandHash[e.value].name||"";
             	}else{
             		e.cellHtml = brandHash[e.value].name||"";
             	}
             }
             else{
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
    
	$("#storeShelf").bind("keydown", function(e) {

		if (e.keyCode == 13) {
			var value = storeShelfEl.getValue();
			value = value.replace(/\s+/g, "");
			morePartSearch();
			
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
//		
//		if ((keyCode == 27)) { // F9
//			onPartClose();
//		}

		if ((keyCode == 121)) { // F10
			morePartNameEl.focus();
		}

	}
	
    initMember("pickMan1",function(){
//    	var pickManList = nui.get(pickMan1).getData();
//    	pickManList.forEach(function(v){
//    		pickManHash[v.empId] = v;
//    	});
    });

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
		nui.get("storeId").setData(storehouse);
        if(currRepairStoreControlFlag == "1") {
        	if(storehouse && storehouse.length>0) {
        		nui.get("storeId").setValue(storehouse[0].id);
        	}
        }else {
        	nui.get("storeId").setAllowInput(true);
        }
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

function quickMorePartSearch(type){
    var queryname = "所有";
    var params={};
    switch (type)
    {
        case 0:
            params.today = 1;
            params.sEnterDate = null;
            params.eEnterDate = null;
            queryname = "所有";
            sEnterDateEl.setValue(null);
    		eEnterDateEl.setValue(null);
    		morePartSearch();
            break;
        case 1:
            params.today = 1;
            params.sEnterDate = getNowStartDate();
            params.eEnterDate = addDate(getNowEndDate(), 1);
            queryname = "本日";
            sEnterDateEl.setValue(params.sEnterDate);
    		eEnterDateEl.setValue(addDate(params.eEnterDate,-1));
    		morePartSearch();
            break;
        case 2:
            params.thisWeek = 1;
            params.sEnterDate = getWeekStartDate();
            params.eEnterDate = addDate(getWeekEndDate(), 1);
            queryname = "本周";
            sEnterDateEl.setValue(params.sEnterDate);
    		eEnterDateEl.setValue(addDate(params.eEnterDate,-1));
    		morePartSearch();
            break;
        default:
            break;
    }

    currType = type;
    var menunamedate = nui.get("menunamedate2");
    menunamedate.setText(queryname);
}
function quickSearch(type){
    var params = getSearchParams();
    var querysign = 1;
    var queryname = "本日";
    switch (type)
    {
        case 0:
            params.today = 1;
            params.sCreateDate = getNowStartDate();
            params.eCreateDate = addDate(getNowEndDate(), 1);
            querysign = 1;
            queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.sCreateDate = getPrevStartDate();
            params.eCreateDate = addDate(getPrevEndDate(), 1);
            querysign = 1;
            queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.sCreateDate = getWeekStartDate();
            params.eCreateDate = addDate(getWeekEndDate(), 1);
            querysign = 1;
            queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.sCreateDate = getLastWeekStartDate();
            params.eCreateDate = addDate(getLastWeekEndDate(), 1);
            querysign = 1;
            queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.sCreateDate = getMonthStartDate();
            params.eCreateDate = addDate(getMonthEndDate(), 1);
            querysign = 1;
            queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.sCreateDate = getLastMonthStartDate();
            params.eCreateDate = addDate(getLastMonthEndDate(), 1);
            querysign = 1;
            queryname = "上月";
            break;
        default:
            break;
    }
    
    sCreateDateEl.setValue(params.sCreateDate);
    eCreateDateEl.setValue(addDate(params.eCreateDate,-1));
    currType = type;
    if(querysign == 1){
    	var menunamedate = nui.get("menunamedate");
    	menunamedate.setText(queryname); 	
    }
    doSearch(params);
}
function getSearchParams() {
	var params = {};
	params.returnSign=0;
	params.billTypeId='050207';
    params.partCode=nui.get("partCode").getValue();
    params.partName=nui.get("partName").getValue();
	params.sCreateDate = sCreateDateEl.getText();
	params.eCreateDate = addDate(eCreateDateEl.getText(),1);
	params.pickMan = nui.get('pickMan1').getText();
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
	params.storeId = nui.get("storeId").value;
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
	params.storeShelf = storeShelfEl.getValue();
//	params.showStock = showStockEl.getValue();
	params.serviceId = moreServiceIdEl.getValue();
	params.partBrandId = nui.get('partBrandId').getValue();
	params.storeId = nui.get("storeId").value;
	var sortTypeValue = sortTypeEl.getValue();
  if(eEnterDateEl.getFormValue()){ 
    params.eEnterDate= addDate(eEnterDateEl.getFormValue(),1);
  }
  params.sEnterDate = nui.get('sEnterDate').getFormValue();
  
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
	row.remark=null;
	var partBrandId=row.partBrandId;
	for(var i=0;i<brandList.length;i++){
		if(partBrandId==brandList[i].id){
			row.partBrandId=brandList[i].name;
		}
	}

	if (row) {
		nui.open({
			url : webPath+ partDomain+ "/manage/inOutManage/common/fastPartForConsumableAdd.jsp?token"+ token,
			title : "领料",
			width : 460,
			height : 300,
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
			width : 475,
			height : 270,
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


function onExport(){
	
	var billTypeIdHash = [{name:"综合",id:"0"},{name:"检查",id:"1"},{name:"洗美",id:"2"},{name:"销售",id:"3"},{name:"理赔",id:"4"},{name:"退货",id:"5"}];

	var detail = grid.getData();
	
	for(var i=0;i<detail.length;i++){
		for(var j=0;j<billTypeIdHash.length;j++){
			if(detail[i].billTypeId==billTypeIdHash[j].id){
				detail[i].billTypeId=billTypeIdHash[j].name;
			}
		}
	}
	

	
	if(detail && detail.length > 0){
		setInitExportData( detail);
	}
}


function setInitExportData( detail){
	


    var tds = '<td  colspan="1" align="left">[partCode]</td>' +
        "<td  colspan='1' align='left'>[partName]</td>" +
        "<td  colspan='1' align='left'>[outQty]</td>" +
        "<td  colspan='1' align='left'>[sellUnitPrice]</td>" +
        "<td  colspan='1' align='left'>[sellAmt]</td>" +        
        "<td  colspan='1' align='left'>[remark]</td>" +
        "<td  colspan='1' align='left'>[pickDate]</td>" +
        "<td  colspan='1' align='left'>[pickMan]</td>" ;
        
        
    var tableExportContent = $("#tableExportContent");
    tableExportContent.empty();
    for (var i = 0; i < detail.length; i++) {
        var row = detail[i];
        if(row.id){
            var tr = $("<tr></tr>");
            tr.append(tds.replace("[partCode]", detail[i].partCode?detail[i].partCode:"")
                         .replace("[partName]", detail[i].partName?detail[i].partName:"")
                         .replace("[outQty]", detail[i].outQty?detail[i].outQty:"")
                         .replace("[sellUnitPrice]", detail[i].sellUnitPrice?detail[i].sellUnitPrice:"")
                         .replace("[sellAmt]", detail[i].sellAmt?detail[i].sellAmt:"")
                          
                         
                         .replace("[remark]", detail[i].remark?detail[i].remark:"")                        
                          .replace("[pickDate]", nui.formatDate(detail[i].pickDate?detail[i].pickDate:"",'yyyy-MM-dd HH:mm'))
                         .replace("[pickMan]", detail[i].pickMan?detail[i].pickMan:""));
            tableExportContent.append(tr);
        }
    }

 
    method5('tableExcel',"耗材出库导出",'tableExportA');
}

//查看入库记录
function onEnter(){
	var row ={};
	row = enterGrid.getSelected();
	if(!row){
		showMsg("请选择一条记录","W");
		return;
	}
	var partId = row.partId;
	onEnterRecord(partId);

}

//查看出库记录
function onOutTo(){
	var row ={};
	row = enterGrid.getSelected();
	if(!row){
		showMsg("请选择一条记录","W");
		return;
	}
	var partId = row.partId;
	onOutRecord(partId);
	
}