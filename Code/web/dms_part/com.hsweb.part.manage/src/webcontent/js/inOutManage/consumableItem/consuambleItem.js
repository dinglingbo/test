/**
 * Created by Administrator on 2018/8/8.
 */

var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var partApiUrl = apiPath +  partApi + "/";
var grid = null;
var gridUrl = baseUrl
		+ "com.hsapi.part.invoice.query.queryPjSellOrderMainDetailList.biz.ext";
var queryInfoForm = null;
var periodValidity = null;
var partInfoUrl = partApiUrl + "com.hsapi.part.invoice.paramcrud.queryBillPartChoose.biz.ext";                             
var enterUrl = partApiUrl + "com.hsapi.part.invoice.stockcal.queryOutableEnterGridWithPage.biz.ext";


var morePartCodeEl = null;
var morePartNameEl = null;
var moreServiceIdEl = null;
var showStockEl = null;
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
var detail=null;
var serviceId=null;
var FGuestId=null;
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
	    showStockEl = nui.get("showStock");
	    sortTypeEl = nui.get("sortType");
	    sortTypeEl.setData(sortTypeList);
	    tempIdEl = nui.get("tempId");
	    
	    
	    getGuestId();
		
	   
	    enterGrid.on("selectionchanged",function(e){
	        var row = enterGrid.getSelected();
	        gpartId = row.partId||0;

	    });

	    enterGrid.setUrl(enterUrl);
	    enterGrid.on("beforeload",function(e){
	        e.data.token = token;
	    });
	    enterGrid.on("load", function(e) {
	        var row = enterGrid.getRow(0);
	        if(row){
	            enterGrid.select(row,true);

	        }
	    });
	    enterGrid.on("rowdblclick", function(e) {
	        var row = enterGrid.getSelected();
	        var rowc = nui.clone(row);
	        if(!rowc) return;
	        nui.get("qty").focus();
	        
	    });
	    enterGrid.on("drawcell",function(e){
	        switch (e.field)
	        {
	            case "partBrandId":
	                if(brandHash[e.value])
	                {
	                    e.cellHtml = brandHash[e.value].name||"";
	                }
	                else{
	                    e.cellHtml = "";
	                }
	                break;
	            case "storeId":
	                if(storeHash[e.value])
	                {
	                    e.cellHtml = storeHash[e.value].name||"";
	                }
	                else{
	                    e.cellHtml = "";
	                }
	                break;
	            case "billTypeId":
	                if(billTypeHash[e.value])
	                {
	                    e.cellHtml = billTypeHash[e.value].name||"";
	                }
	                else{
	                    e.cellHtml = "";
	                }
	                break;
	            default:
	                break;
	        }
	    });
	    
	    $("#morePartCode").bind("keydown", function (e) {

	        if (e.keyCode == 13) {
	            var value = morePartCodeEl.getValue();
	            value = value.replace(/\s+/g, "");
	            if(value.length>=3){
	                morePartSearch();
	            }
	        }  
	        
	    });

	    $("#morePartName").bind("keydown", function (e) {

	        if (e.keyCode == 13) {
	            var value = morePartNameEl.getValue();
	            value = value.replace(/\s+/g, "");
	            if(value.length>=3){
	                morePartSearch();
	            }
	        }
	        
	    });

	    $("#moreServiceId").bind("keydown", function (e) {

	        if (e.keyCode == 13) {
	            var value = moreServiceIdEl.getValue();
	            value = value.replace(/\s+/g, "");
	            if(value.length>=3){
	                morePartSearch();
	            }
	        }
	        
	    });

	    $("#qty").bind("keydown", function (e) {
	        if (e.keyCode == 13) {
	            var price = nui.get("price");
	            price.focus();
	        }
	    });

	    $("#price").bind("keydown", function (e) {
	        if (e.keyCode == 13) {
	            var amt = nui.get("amt");
	            amt.focus();
	        }
	    });
	    $("#amt").bind("keydown", function (e) {
	        if (e.keyCode == 13) {
	            var remark = nui.get("remark");
	            remark.focus();
	        }
	    });

	    $("#remark").bind("keydown", function (e) {
	        if (e.keyCode == 13) {
	            var chooseBtn = nui.get("chooseBtn");
	            chooseBtn.focus();
	        }
	    });

	    document.onkeyup=function(event){
	        var e=event||window.event;
	        var keyCode=e.keyCode||e.which;//38向上 40向下


	        if((keyCode==27))  {  //ESC
	      
	                onPartClose();

	        }
	        
	        if((keyCode==120))  {  //F9
	            morePartCodeEl.focus();
	        }

	        if((keyCode==121))  {  //F10
	            morePartNameEl.focus();
	        }
	     
	    }


	    var dictDefs ={"billTypeId":"DDT20130703000008"};
	    initDicts(dictDefs, function(e){
	        var billTypeList = nui.get("billTypeId").getData();
	        billTypeList.forEach(function(v) {
	            billTypeHash[v.customid] = v;
	        });
	    });
	    getStorehouse(function(data)
	    	    {
	    	        storehouse = data.storehouse||[];
	    	        if(storehouse && storehouse.length>0){
//	    	            nui.get("storeId").setData(storehouse);
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

//	    morePartSearch();
});

function getSearchParams() {
	var params = {};
	params.sCreateDate = nui.get("sCreateDate").getValue().substr(0, 10);
	params.eCreateDate = nui.get("eCreateDate").getValue().substr(0, 10);
	params.pickMan = nui.get('pickMan').getValue();
	return params; 
}
function onSearch() {
	var params = getSearchParams();

	doSearch(params);
}
function doSearch(params) {
	params.orderTypeId = 5;
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

function getPart() {
	nui.open({
		url:webPath + partDomain +"/com.hsweb.part.manage.fastPartForConsumable.flow?token"+token,
		title: "领料", width: 1000, height: 600,
		allowDrag : true,
        allowResize : true,
		onload: function(){
		},
		ondestroy: function(action){
			if(action == 'ok'){
				var iframe = this.getIFrameEl();
				grid.reload();
			}
		}
	});
}


function getMainData() {
    var data = grid.getSelected();
    // 汇总明细数据到主表
//    data.isFinished = 0;
//    data.auditSign = 0;
//    data.billStatusId = 0;
//    data.printTimes = 0;
//    data.orderTypeId = 5;

    if (data.operateDate) {
        data.operateDate = format(data.operateDate, 'yyyy-MM-dd HH:mm:ss')
                + '.0';// 用于后台判断数据是否在其他地方已修改
        // data.versionNo = format(data.versionNo, 'yyyy-MM-dd HH:mm:ss');
    }

    if(!data.billTypeId){
        data.billTypeId = "050207";
    }

    grid.findRow(function(row){
        var partId = row.partId;
        var partCode = row.comPartCode;
        if(partId == null || partId == "" || partId == undefined || partCode == null || partCode == "" || partCode == undefined){
            enterGrid.removeRow(row);
        }
    });

    return data;
}
//function getModifyData(data, addList, delList){
//    var arr = [];
//    if(data==addList) return arr;
//    for(var i=0; i<addList.length; i++) {
//    
//       var val = addList[i];
//       for(var j=0; j<data.length; j++) {
//        
//           if(data[j] == val)
//           data.splice(j, 1);
//        }
//    }
//            
//    for(var i=0; i<delList.length; i++) {
//    
//       var val = delList[i];
//       for(var j=0; j<data.length; j++) {
//        
//           if(data[j] == val)
//           data.splice(j, 1);
//        }
//    }
//
//    return data;
//}
//function order(){
//    var data = grid.getData();
//    var flagSign = 0; 
//    var flagStr = "提交中...";
//    var flagRtn = "提交成功!";
//    orderEnter(flagSign, flagStr, flagRtn);
//}
//
//function orderToEnter(){
//    //如果是内部订单，直接入库时需要判断 bill_status_id = 2（待收货）
//    var data = grid.getData();
//    var isInner = data.isInner||0;
//    var billStatusId = data.billStatusId||0;
//    //if(isInner == 0 && billStatusId == 0){
//        var flagSign = 1; 
//        var flagStr = "入库中...";
//        var flagRtn = "入库成功!";
//        orderEnter(flagSign, flagStr, flagRtn);     
//
//}

function checkRightData() {
	var row=grid.getSelected();
    var msg = '';
    var rows = grid.findRows(function(row) {
        if(row.partId){  
            if (row.outQty) {
                if (row.outQty <= 0)
                    return true;
            } else {
                return true;
            }
            if (row.orderPrice) {
                if (row.orderPrice <= 0)
                    return true;
            } else {
                return true;
            }
            if (row.orderAmt) {
                if (row.orderAmt <= 0)
                    return true;
            } else {
                return true;
            }

            if (row.storeId) {
            } else {
                return true;
            }
        }
    });

    if (rows && rows.length > 0) {
        msg = "请完善退货配件的数量，单价，金额，仓库等信息！";
    }
    return msg;
}
//归库
var backUrl = baseUrl
+ "com.hsapi.repair.repairService.work.repairOutRtn.biz.ext";
function orderEnter() {

    var row = grid.getSelected();
    if (row) {
        if (row.auditSign == 1) {
            showMsg("此单已入库!","W");
            return;
        }
    } else {
        return;
    }

    // 审核时，数量，单价，金额，仓库不能为空
//    var msg = checkRightData();
//    if (msg) {
//        showMsg(msg,"W");
//        return;
//    }

    nui.confirm("是否确定归库?", "友情提示", function(action) {
        if (action == "ok") {

            data = getMainData();
            data.serviceId=null;
            var billTypeId='050107';
            var list=[];
            list.push(data);

            //由于票据类型可能修改，所以除了新建和删除，其他都应该是修改
//            var detailData = grid.getData();
//
//            var pchsOrderDetailAdd = grid.getChanges("added");
//            var pchsOrderDetailUpdate = grid.getChanges("modified");
//            var pchsOrderDetailDelete = grid.getChanges("removed");
//            var pchsOrderDetailUpdate = getModifyData(detailData, pchsOrderDetailAdd, pchsOrderDetailDelete);
            nui.mask({
                el : document.body,
                cls : 'mini-mask-loading',
                html : "归库中..."
            });

            nui.ajax({
                url : backUrl,
                type : "post",
                data : JSON.stringify({
                    data : list,
                    billTypeId :billTypeId,
//                    pchsOrderDetailAdd : pchsOrderDetailAdd,
//                    pchsOrderDetailUpdate : pchsOrderDetailUpdate,
//                    pchsOrderDetailDelete : pchsOrderDetailDelete,
//                    operateFlag : flagSign,
                    token: token
                }),
                success : function(data) {
                    nui.unmask(document.body);
                    data = data || {};
                    if (data.errCode == "S") {
                        showMsg("归库成功!","S");
                        // onLeftGridRowDblClick({});
                        var pjPchsOrderMainList = data.pjPchsOrderMainList;
         
                    } else {
                        showMsg(data.errMsg || ("归库失败!"),"W");
                    }
                },
                error : function(jqXHR, textStatus, errorThrown) {
                    // nui.alert(jqXHR.responseText);
                    console.log(jqXHR.responseText);
                }
            });

        } else {
            return;
        }
    });

}


//库存数量↑，库存数量↓；入库日期↑，入库日期↓；成本↑，成本↓
var sortTypeList = [
    {id:"1",text:"入库日期↑"},{id:"2",text:"入库日期↓"},
    {id:"3",text:"库存数量↑"},{id:"4",text:"库存数量↓"},
    {id:"5",text:"成本↑"},{id:"6",text:"成本↓"}
];
var resultData = {};
var callback = null;
var checkcallback = null;
function setInitData(params, ck, cck){
    var value = params.value;
    mainId = params.mainId;
    guestId = params.guestId;
    callback = ck;
    checkcallback = cck;

    var type = judgeConditionType(value);//1代表编码，2代表名称，3代表拼音，-1输入信息有误
    var params = {};

    if(type == 1){
        morePartCodeEl.setValue(value);
        params.partCode = value.replace(/\s+/g, "");
    }else if(type == 2){
        morePartNameEl.setValue(value);
        params.partName = value;
    }else if(type == 3){
        params.namePy = value.replace(/\s+/g, "");
    }

        params.sortField = "B.ENTER_DATE";
        params.sortOrder = "asc";
        enterGrid.load({params:params},function(e){
            enterGrid.focus();
        });

    
}

function morePartSearch(){
    var params = {}; 
    params.partCode = morePartCodeEl.getValue();
    params.partName = morePartNameEl.getValue();
    params.showStock = showStockEl.getValue();
    params.serviceId = moreServiceIdEl.getValue();
    params.partBrandId = nui.get('partBrandId').getValue();
    var sortTypeValue = sortTypeEl.getValue();

    if(!params.partCode && !params.partName && !params.serviceId && !params.partBrandId && !sortTypeValue){
        showMsg("请输入查询条件!","W");
        return;
    }

        if(sortTypeValue == 1){
            params.sortField = "B.ENTER_DATE";
            params.sortOrder = "asc";
        }else if(sortTypeValue == 2){
            params.sortField = "B.ENTER_DATE";
            params.sortOrder = "desc";
        }else if(sortTypeValue == 3){
            params.sortField = "b.OUTABLE_QTY";
            params.sortOrder = "asc";
        }else if(sortTypeValue == 4){
            params.sortField = "b.OUTABLE_QTY";
            params.sortOrder = "desc";
        }else if(sortTypeValue == 5){
            params.sortField = "B.ENTER_PRICE";
            params.sortOrder = "asc";
        }else if(sortTypeValue == 6){
            params.sortField = "B.ENTER_PRICE";
            params.sortOrder = "desc";
        }
        enterGrid.load({params:params},function(e){
            enterGrid.focus();
        });
    
}

function onPartClose(){
    CloseWindow("cancel");
}
function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}

function getRtnData(){
    return resultData;
}

var requiredField = {

	outQty	:"出库数量",
	pickMan	:"领料人",
	remark	:"出库原因"

};
function onAdvancedAddOk(){
	
	var data=enterGrid.getSelected();
    for(var key in requiredField)
    {
        if(!data[key] || data[key].toString().trim().length==0)
        {
            showMsg(requiredField[key]+"不能为空!","W");
            if(key == "outQty") {
                var qty = nui.get("outQty");
                qty.focus();
            }
            if(key == "pickMan") {
                var price = nui.get("pickMan");
                price.focus();
            }
            if(key == "remark") {
                var price = nui.get("remark");
                price.focus();
            }
            
            return;
        }
    }
    resultData.outQty = data.outQty;
    resultData.pickMan = data.pickMan;
   
    var row = enterGrid.getSelected();
    var stockQty = row.stockQty;
    var preOutQty = row.preOutQty||0;
    if(data.outQty > stockQty - preOutQty){
    	showMsg("出库数量超出此批次可出库数量","W");
    	return;
    } 
}

//function calc(type){
//    var qty = nui.get("qty").getValue();
//    var price = nui.get("price").getValue();
//    var amt = nui.get("amt").getValue();
//    
//    if(qty == null || qty == '') {
//        nui.get("qty").setValue(0);
//    }else if(qty < 0) {
//        nui.get("qty").setValue(0);
//    }
//    
//    if(price == null || price == '') {
//        nui.get("price").setValue(0);
//    }else if(price < 0) {
//        nui.get("price").setValue(0);
//    }
//    
//    if(amt == null || amt == '') {
//        nui.get("amt").setValue(0);
//    }else if(amt < 0) {
//        nui.get("amt").setValue(0);
//    }
//    
//    qty = nui.get("qty").getValue();
//    price = nui.get("price").getValue();
//    amt = nui.get("amt").getValue();
//    
//    if(type == 'qty'){
//        nui.get("amt").setValue(qty * price);
//    }
//    
//    if(type == 'price'){
//        nui.get("amt").setValue(qty * price);
//    }
//    
//    if(type == 'amt'){
//        if(qty > 0) {
//            price = (amt / qty).toFixed(4);
//            nui.get("price").setValue(price);
//        }else {
//            nui.get("qty").setValue(0);
//            nui.get("amt").setValue(0);
//        }
//    }
//}
var partPriceUrl = partApiUrl + "com.hsapi.part.invoice.pricemanage.getSellDefaultPrice.biz.ext";
function getPartPrice(params){
    var price = 0;
    nui.ajax({
        url : partPriceUrl,
        type : "post",
        async: false,
        data : {
            params: params,
            token: token
        },
        success : function(data) {
            var errCode = data.errCode;
            if(errCode == "S"){
                var priceRecord = data.priceRecord;
                if(priceRecord.sellPrice){
                    price = priceRecord.sellPrice;
                }
            }

        },
        error : function(jqXHR, textStatus, errorThrown) {

            console.log(jqXHR.responseText);
        }
    });

    return price;
}


var guestUrl = partApiUrl + "com.hsapi.part.common.svr.getGuestByInternalId.biz.ext";
function getGuestId() {

    nui.ajax({
        url : guestUrl,
        type : "post",
        data : JSON.stringify({}),
        success : function(data) {
            data = data || {};
            if (data.guest) {
                var guest = data.guest;
                FGuestId = guest.id;

            } else {
                console.log(data.errMsg);
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
        }
    });
}

//function getMainData()
//{
//	
//
//    //汇总明细数据到主表
//    var isFinished = 0;
//    var auditSign = 0;
//    var billStatusId = '';
//    var printTimes = 0;
//    var orderTypeId = 5;
//    var isDiffOrder = 1;
//    var date=new Date();
//    var operateDate = format(date, 'yyyy-MM-dd HH:mm:ss') + '.0';
//    var data = {
//    	guestId		: FGuestId,
//    	isFinished	: isFinished,
//    	auditSign	: auditSign,
//    	billStatusId: billStatusId,
//    	printTimes  : printTimes, 
//    	orderTypeId : orderTypeId,
//    	isDiffOrder : isDiffOrder,
//    	operateDate : operateDate
//    };
//    
//
//    return data;
//}
//function removeChanges(added, modified, removed, all) {
//    for(var i=0; i<added.length; i++) {
//    
//       var val = added[i];
//       for(var j=0; j<all.length; j++) {
//        
//           if(all[j] == val)
//           all.splice(j, 1);
//        }
//    }
//    
//    for(var i=0; i<modified.length; i++) {
//    
//       var val = modified[i];
//       for(var j=0; j<all.length; j++) {
//        
//           if(all[j] == val)
//           all.splice(j, 1);
//        }
//    }
//    
//    for(var i=0; i<removed.length; i++) {
//    
//       var val = removed[i];
//       for(var j=0; j<all.length; j++) {
//        
//           if(all[j] == val)
//           all.splice(j, 1);
//        }
//    }
//
//    return all;
//}
//
////新增单据时，取单据ID
//var saveAddUrl = partApiUrl + "com.hsapi.part.invoice.crud.saveAddSellOrder.biz.ext";
//function getSellOrderBillNO(callback){
//    var data = getMainData();
//    data.isDiffOrder = 1;
//    nui.ajax({
//        url : saveAddUrl,
//        type : "post",
//        async:false,
//        data : JSON.stringify({
//            main : data,
//            token : token
//        }),
//        success : function(data) {
//            data = data || {};
//            if (data.errCode == "S") {
//                var main = data.main;
//                serviceId=data.main.serviceId;
//                var row=enterGrid.getSelected();
//                var newRow={serviceId:serviceId};
//                enterGrid.updateRow(row,newRow);
//                callback && callback(main)
//            } else {
//                showMsg(data.errMsg || "请先保存单据添加配件","W");
//            }
//        },
//        error : function(jqXHR, textStatus, errorThrown) {
//            // nui.alert(jqXHR.responseText);
//            console.log(jqXHR.responseText);
//        }
//    });
//}
////判断库存
//
//var saveStepUrl = partApiUrl + "com.hsapi.part.invoice.crud.insertPjSellOrderStepTran.biz.ext";
//function saveDetail(detail){
//	detail=enterGrid.getSelected();
//    nui.ajax({
//		url : saveStepUrl,
//		type : "post",
//		async:false,
//		data : JSON.stringify({
//			sellOrderDetail : detail,
//			serviceId :detail.serviceId,
//            token : token
//		}),
//		success : function(data) {
//			data = data || {};
//			if (data.errCode == "S") {
//                var sellOrderDetail = data.sellOrderDetail;
//                callback && callback(sellOrderDetail,data.p);
//			} else {
//				alert(data.errMsg || "新增数据失败!");
//			}
//		},
//		error : function(jqXHR, textStatus, errorThrown) {
//			// nui.alert(jqXHR.responseText);
//			console.log(jqXHR.responseText);
//		}
//	});
//}
//
//var saveUrl = partApiUrl + "com.hsapi.part.invoice.crud.savePjSellOrder.biz.ext?token"+token;
//function save() {
//
//    data = getMainData();
//   
//
//    var sellOrderDetailAdd = enterGrid.getChanges("added");
//    var sellOrderDetailUpdate = enterGrid.getChanges("modified");
//    var sellOrderDetailDelete = enterGrid.getChanges("removed");
//    var sellOrderDetailList = enterGrid.getData();
//    sellOrderDetailList = removeChanges(sellOrderDetailAdd, sellOrderDetailUpdate, sellOrderDetailDelete, sellOrderDetailList);
//
//    nui.mask({
//        el: document.body,
//        cls: 'mini-mask-loading',
//        html: '保存中...'
//    });
//
//	nui.ajax({
//		url : saveUrl,
//		type : "post",
//		async:false,
//		data : JSON.stringify({
//			sellOrderMain : data,
//			sellOrderDetailAdd : sellOrderDetailAdd,
//			sellOrderDetailUpdate : sellOrderDetailUpdate,
//			sellOrderDetailDelete : sellOrderDetailDelete,
//            sellOrderDetailList : sellOrderDetailList,
//            token : token
//		}),
//		success : function(data) {
//            nui.unmask(document.body);
//			data = data || {};
//			if (data.errCode == "S") {
//                showMsg("保存成功!","S");
//                var pjSellOrderMainList = data.pjSellOrderMainList;
//   
//
//			} else {
//                showMsg(data.errMsg || "保存失败!","W");
//			}
//		},
//		error : function(jqXHR, textStatus, errorThrown) {
//            nui.unmask(document.body);
//			console.log(jqXHR.responseText);
//		}
//	});
//}

function checkStockOutQty(){
    var msg = '';
    var row = enterGrid.getSelected();
    var rows = enterGrid.findRows(function(row){
        if(row.stockOutQty > 0){
            return true;
        }
    });
    
    if(rows && rows.length > 0){
        var comPartCode = rows[0].comPartCode;
        msg = "配件：" + comPartCode + "缺货，不能出库！";
    }
    return msg;
}

function checkRightData()
{
	var row = enterGrid.getSelected();
    var msg = '';
    var rows = enterGrid.findRows(function(row){
        if(row.partId){
            if(row.orderQty){
                if(row.orderQty <= 0) return true;
            }else{
                return true;
            }
            if(row.orderPrice){
                if(row.orderPrice <= 0) return true;
            }else{
                return true;
            }
            if(row.orderAmt){
                if(row.orderAmt <= 0) return true;
            }else{
                return true;
            }
            
            if(row.storeId){
            }else{
                return true;
            }       
        }

    });
    
    if(rows && rows.length > 0){
        msg = "请完善销售配件的数量，单价，金额，仓库等信息！";
    }
    return msg;
}
//出库
var partToOutUrl = partApiUrl+"com.hsapi.repair.repairService.work.repairOut.biz.ext";
function partToOut()
{

//    //审核时，数量，单价，金额，仓库不能为空
//    var msg = checkStockOutQty();
//    if(msg){
//        showMsg(msg,"W");
//        return;
//    }
//    //审核时，判断是否存在缺货信息
//    var msg = checkRightData();
//    if(msg){
//        showMsg(msg,"W");
//        return;
//    }

    data = enterGrid.getSelected();
    data.guestId=FGuestId;
    data.billTypeId="050207";
    data.partNameId='0';
    data.pickType='0';
    var date=new Date();
    var operateDate = format(date, 'yyyy-MM-dd HH:mm:ss') + '.0';
    data.operateDate=operateDate;
    var list=[];
    list.push(data);

//    var sellOrderDetailAdd = enterGrid.getChanges("added");
//    var sellOrderDetailUpdate = enterGrid.getChanges("modified");
//    var sellOrderDetailDelete = enterGrid.getChanges("removed");
//    var sellOrderDetailList = enterGrid.getData();
//    if(sellOrderDetailList.length <= 0) {
//        showMsg("明细为空，不能出库!","W");
//        return;
//    }
//    sellOrderDetailList = removeChanges(sellOrderDetailAdd, sellOrderDetailUpdate, sellOrderDetailDelete, sellOrderDetailList);


    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '出库中...'
    });

    nui.ajax({
        url : partToOutUrl,
        type : "post",
        data : JSON.stringify({
            data : list,
            billTypeId :data.billTypeId,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                showMsg("出库成功!","S");
                var pjSellOrderMainList = data.pjSellOrderMainList;
  
            } else {
                showMsg(data.errMsg || "出库失败!","W");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {

            console.log(jqXHR.responseText);
        }
    });
}
function onOut(){
	var row=enterGrid.getSelected();
	if(!row || row==undefined){
		showMsg("请在上方先选择一条记录");
	}
	if(row){
		nui.open({
			url:webPath + partDomain +"/manage/inOutManage/common/fastPartForConsumableAdd.jsp?token"+token,
			title: "出库", width: 410, height: 250,
			allowDrag : true,
	        allowResize : true,
			onload: function(){
				var iframe=this.getIFrameEl();
				var params={
						data :row
				};
				
				iframe.contentWindow.SetData(params);
			},
			ondestroy: function(action){
				if(action == 'ok'){
					var iframe = this.getIFrameEl();
					var data=iframe.contentWindow.getData();
					var	part=data.data;
					var pickMan=part.pickMan;
					var remark=part.remark;
					var outQty=part.outQty;
					var row=enterGrid.getSelected();
					var newRow={pickMan:pickMan,remark:remark,outQty:outQty};
					enterGrid.updateRow(row,newRow);
					onAdvancedAddOk();
					partToOut();
//					getSellOrderBillNO();
//					saveDetail();
//					save();
//					saveAndOut();
//					enterGrid.setData(data);
//					enterGrid.reload();
//					nui.alert("确定出库？");
//					CloseWindow("ok");
				}
			}
		});
	}else{
		showMsg("请选择一条记录","W");
	}
}
function saveAndOut(){
	onAdvancedAddOk();
	getSellOrderBillNO();
	saveDetail();
	save();
	audit();
}

