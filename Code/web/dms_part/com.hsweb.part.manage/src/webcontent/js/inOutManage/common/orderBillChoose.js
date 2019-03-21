
var baseUrl = apiPath + partApi + "/";
var notStatementUrl = baseUrl + "com.hsapi.part.invoice.svr.queryPjSellOrPchsOrderMainChkList.biz.ext";
var innerPchsGridUrl = baseUrl+"com.hsapi.part.invoice.svr.queryPjPchsOrderDetailList.biz.ext";
var innerSellGridUrl = baseUrl+"com.hsapi.part.invoice.svr.queryPjSellOrderDetailList.biz.ext";
var notStatementGrid = null;
var leftGrid = null;
var rightGrid = null;
var editFormPchsEnterDetail = null;
var innerPchsEnterGrid = null;
var editFormPchsRtnDetail = null;
var innerPchsRtnGrid = null;
var orderTypeId = 1;

var brandHash = {};
var brandList = [];
var storehouse = null;
var storehouseHash={};
var billTypeIdEl = null;
var settleTypeIdEl = null;
var billTypeIdHash = {};
var settTypeIdHash = {};
var billTypeIdList = [];
var settTypeIdList = [];

var sBillAuditDateEl = null;
var eBillAuditDateEl = null;
var billSearchGuestIdEl = null;
var billServiceIdEl = null;
var billServiceManEl = null;

$(document).ready(function(v)
{
	notStatementGrid = nui.get("notStatementGrid");
    notStatementGrid.setUrl(notStatementUrl);	

    innerPchsEnterGrid = nui.get("innerPchsEnterGrid");
    editFormPchsEnterDetail = document.getElementById("editFormPchsEnterDetail");
    innerPchsEnterGrid.setUrl(innerPchsGridUrl);

    innerPchsRtnGrid = nui.get("innerPchsRtnGrid");
    editFormPchsRtnDetail = document.getElementById("editFormPchsRtnDetail");
    innerPchsRtnGrid.setUrl(innerSellGridUrl);

    billTypeIdEl = nui.get("billTypeId");
    settleTypeIdEl = nui.get("settleTypeId");
    sBillAuditDateEl = nui.get("sBillAuditDate");
	eBillAuditDateEl = nui.get("eBillAuditDate");
	billSearchGuestIdEl = nui.get("searchBillGuestId");
	billServiceIdEl = nui.get("billServiceId");
	billServiceManEl = nui.get("billServiceMan");

	sBillAuditDateEl.setValue(getLastMonthStartDate());//上月开始日期
	eBillAuditDateEl.setValue(getMonthEndDate());//本月结束日期

    var dictDefs ={"billTypeId":"DDT20130703000008", "settleTypeId":"DDT20130703000035"};
    initDicts(dictDefs,function()
    {
    	var billTypeIdList = billTypeIdEl.getData();
    	var settTypeIdList = settleTypeIdEl.getData();
    	billTypeIdList.filter(function(v)
        {
            billTypeIdHash[v.customid] = v;
            return true;
        });

        settTypeIdList.filter(function(v)
        {
            settTypeIdHash[v.customid] = v;
            return true;
        });

    });
    getStorehouse(function(data)
    {
        storehouse = data.storehouse||[];
        nui.get("storeId").setData(storehouse);
        if(currRepairStoreControlFlag == "1") {
        	if(storehouse && storehouse.length>0) {
        		nui.get("storeId").setValue(storehouse[0].id);
        	}
        }else {
        	nui.get("storeId").setAllowInput(true);
        }
        storehouse.forEach(function(v)
        {
            if(v && v.id)
            {
                storehouseHash[v.id] = v;
            }
        });
    });

    getAllPartBrand(function(data) {
        brandList = data.brand;
        brandList.forEach(function(v) {
            brandHash[v.id] = v;
        });
    });
    
    nui.get('billServiceId').focus();
    document.onkeyup = function(event) {
        var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下
        

        if ((keyCode == 13)) { // Enter
        	searchBill();
        }
        if(keyCode == 27){
        	CloseWindow('cancle');
        }
    }

});
function setInitData(data, ck, cck){
    callback = ck;
    checkcallback = cck;

    billSearchGuestIdEl.setValue(data.guestId);
    orderTypeId = data.orderTypeId;

    searchBill();
}

var accountList = [
    {id:0,text:"未对账"},
    {id:1,text:"已对账"},
    {id:2,text:"全部"}
];
var orderTypeIdHash = {1:"采购订单",2:"销售订单"};
var accountSignHash = {
    "0":"未对账",
    "1":"已对账"
};
function onDrawCell(e)
{
    switch (e.field)
    {
        case "comPartBrandId":
            if(brandHash && brandHash[e.value])
            {
                e.cellHtml = brandHash[e.value].name;
            }
            break;
        case "billTypeId":
            if(billTypeIdHash && billTypeIdHash[e.value])
            {
                e.cellHtml = billTypeIdHash[e.value].name;
            }
            break;
        /*case "billStatus":
            if(billStatusHash && billStatusHash[e.value])
            {
                e.cellHtml = billStatusHash[e.value];
            }
            break;*/
        case "orderTypeId":
            if(orderTypeIdHash && orderTypeIdHash[e.value])
            {
                e.cellHtml = orderTypeIdHash[e.value];
            }
            break;
        case "settleTypeId":
            if(settTypeIdHash && settTypeIdHash[e.value])
            {
                e.cellHtml = settTypeIdHash[e.value].name;
            }
            break;
        case "storeId":
            if(storehouseHash && storehouseHash[e.value])
            {
                e.cellHtml = storehouseHash[e.value].name;
            }
            break;
        case "accountSign":
            if(accountSignHash && accountSignHash[e.value])
            {
                e.cellHtml = accountSignHash[e.value];
            }
            break;
        default:
            break;
    }
}
function getBillSearchParam(){

	var params = {};
    params.sAuditDate = sBillAuditDateEl.getValue();
    params.eAuditDate = addDate(eBillAuditDateEl.getValue(), 1);
    params.serviceId = billServiceIdEl.getValue();
    params.guestId = billSearchGuestIdEl.getValue();
    return params;
}
function searchBill()
{
    var param = getBillSearchParam();
    doNotStatement(param);
}
function doNotStatement(params){
    params.orderTypeId = orderTypeId;
    params.auditSign = 1;
    params.isDiffOrder = 0;
    params.storeId = nui.get("storeId").value;
    notStatementGrid.load({
        params:params,
        token: token
    });
}
function onShowRowDetail(e) {
    var row = e.record;
    var mainId = row.id;
    
    //将editForm元素，加入行详细单元格内
    var td = notStatementGrid.getRowDetailCellEl(row);
    var orderTypeId = row.orderTypeId;    

    switch (orderTypeId)
    {
        case 1:
            td.appendChild(editFormPchsEnterDetail);
            editFormPchsEnterDetail.style.display = "";

            var params = {};
            params.mainId = mainId;
            params.auditSign = 1;
            innerPchsEnterGrid.load({
                params:params,
                token: token
            });
            break;
        case 2:
            td.appendChild(editFormPchsRtnDetail);
            editFormPchsRtnDetail.style.display = "";

            var params = {};
            params.mainId = mainId;
            params.auditSign = 1;
            innerPchsRtnGrid.load({
                params:params,
                token: token
            });
            break;
        default:
            break;
    }
}

var resultData = {};
var callback = null;
var checkcallback = null;
function addStatement()
{
    var rows = notStatementGrid.getSelecteds();
    //var nodec = nui.clone(node);
    
    if(!rows){
        return;
    }else if(rows && rows.length<=0){
        return;
    }


    if(!callback)
    {
        CloseWindow("ok");
    }
    else{

        if(orderTypeId == 1){
            getPchsDetails();
        }else if(orderTypeId == 2){
            getSellDetails();
        }        

        /*//需要判断是否已经添加了此单据
        for(var i=0; i<rows.length; i++){
            var row = rows[i];
            var checkMsg = checkcallback(row.serviceId);
            if(checkMsg){
                nui.alert(checkMsg);
                return;
            }
        }

        callback(rows);

        CloseWindow("ok");*/
    }
}
function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
var querySellUrl = baseUrl+"com.hsapi.part.invoice.svr.queryPjSellOrderDetailList.biz.ext";
function getSellDetails()
{
    var rows = notStatementGrid.getSelecteds();

    if(rows && rows.length>0){
        nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '处理中...'
        });

        var mainIdsList = [];
        for(var i = 0; i<rows.length; i++){
            mainIdsList.push(rows[i].id);
        }
        var mainIds = mainIdsList.join(",");
        var params = {};
        params.auditSign = 1;
        params.mainIds = mainIds;
        nui.ajax({
            url : querySellUrl,
            type : "post",
            data : JSON.stringify({
                params : params,
                token : token
            }),
            success : function(data) {
                nui.unmask(document.body);
                var pjSellOrderDetailList = data.pjSellOrderDetailList || [];
                if (pjSellOrderDetailList && pjSellOrderDetailList.length>0) {
                    
                    callback(pjSellOrderDetailList);

                    CloseWindow("ok");
                    
                } else {
                    showMsg(data.errMsg || "操作失败!","W");
                }
            },
            error : function(jqXHR, textStatus, errorThrown) {
                console.log(jqXHR.responseText);
            }
        });
    }

}
var queryPchsUrl = baseUrl+"com.hsapi.part.invoice.svr.queryPjPchsOrderDetailList.biz.ext";
function getPchsDetails()
{
    var rows = notStatementGrid.getSelecteds();

    if(rows && rows.length>0){
        nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '处理中...'
        });

        var mainIdsList = [];
        for(var i = 0; i<rows.length; i++){
            mainIdsList.push(rows[i].id);
        }
        var mainIds = mainIdsList.join(",");
        var params = {};
        params.auditSign = 1;
        params.mainIds = mainIds;
        nui.ajax({
            url : queryPchsUrl,
            type : "post",
            data : JSON.stringify({
                params : params,
                token : token
            }),
            success : function(data) {
                nui.unmask(document.body);
                var pjPchsOrderDetailList = data.pjPchsOrderDetailList || [];
                if (pjPchsOrderDetailList && pjPchsOrderDetailList.length>0) {
                    
                    callback(pjPchsOrderDetailList);

                    CloseWindow("ok");
                    
                } else {
                    showMsg(data.errMsg || "操作失败!","W");
                }
            },
            error : function(jqXHR, textStatus, errorThrown) {
                console.log(jqXHR.responseText);
            }
        });
    }

}