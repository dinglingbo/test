
var baseUrl = apiPath + cloudPartApi + "/";
var notStatementUrl = baseUrl + "com.hsapi.cloud.part.invoicing.svr.queryPjSellOrPchsOrderMainChkList.biz.ext";
var innerPchsGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjPchsOrderDetailList.biz.ext";
var innerSellGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjSellOrderDetailList.biz.ext";
var innerAllotAppyGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.allotsettle.queryAllotApplyDetails.biz.ext";
var notStatementGrid = null;
var leftGrid = null;
var rightGrid = null;
var editFormPchsEnterDetail = null;
var innerPchsEnterGrid = null;
var editFormPchsRtnDetail = null;
var innerPchsRtnGrid = null;
var editFormAllotApplyDetail =null;
var innerAllotApplyGrid = null;

var orderTypeId = 1;

var brandHash = {};
var brandList = [];
var storehouse = null;
var storeHash  ={};
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
var pjSellOrderDetailList =[];
var pjPchsOrderDetailList = [];
var pjAllotApplyDetails = [];
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
    
    innerAllotApplyGrid = nui.get("innerAllotApplyGrid");
    editFormAllotApplyDetail = document.getElementById("editFormAllotApplyDetail");
    innerAllotApplyGrid.setUrl(innerAllotAppyGridUrl);

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
        if(storehouse && storehouse.length>0){
            storehouse.forEach(function(v){
        		storeHash[v.id]=v;
        	});
        }
    });

    getAllPartBrand(function(data) {
        brandList = data.brand;
        brandList.forEach(function(v) {
            brandHash[v.id] = v;
        });
    });

    

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
var orderTypeIdHash = {1:"采购订单",2:"销售订单",3:"调拨入库单"};
var accountSignHash = {
    "0":"未对账",
    "1":"已对账"
};
function onDrawCell(e)
{
    switch (e.field)
    {
        case "comPartBrandId":
        	if(brandHash[e.value])
            {
//                e.cellHtml = brandHash[e.value].name||"";
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
            if(orderTypeIdHash && orderTypeIdHash[e.value] && orderTypeId !=3)
            {
                e.cellHtml = orderTypeIdHash[e.value];
            }
            else if( orderTypeId ==3){
            	 e.cellHtml = orderTypeIdHash[3];
            }
            break;
        case "settleTypeId":
            if(settTypeIdHash && settTypeIdHash[e.value])
            {
                e.cellHtml = settTypeIdHash[e.value].name;
            }
            break;
        case "storeId":
            if(storeHash && storeHash[e.value])
            {
                e.cellHtml = storeHash[e.value].name;
            }
            break;
        case "accountSign":
            if(accountSignHash && accountSignHash[e.value])
            {
                e.cellHtml = accountSignHash[e.value];
            }
            break;
        case "orderAmt":
            if(e.record.orderTypeId ==2)
            {
                e.cellHtml = e.record.showAmt;
            }
            break;
        default:
            break;
    }
}
function getBillSearchParam(){

	var params = {};
    params.sAuditDate = sBillAuditDateEl.getFormValue();
    params.eAuditDate = addDate(eBillAuditDateEl.getValue(), 1);
    params.serviceId = billServiceIdEl.getValue().replace(/\s+/g, "");
    params.guestId = billSearchGuestIdEl.getValue();
    params.partCode = nui.get('partCode').getValue().replace(/(^\s*)|(\s*$)/g, "");
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
    params.isDiffOrder =1;
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
//    var orderTypeId = row.orderTypeId;    

    switch (orderTypeId)
    {
        case 1:
            td.appendChild(editFormPchsEnterDetail);
            editFormPchsEnterDetail.style.display = "";

            var params = {};
            params.mainId = mainId;
            params.auditSign = 1;
            params.partCode = nui.get("partCode").getValue();
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
        //调拨入库单
        case 3:
            td.appendChild(editFormAllotApplyDetail);
            editFormAllotApplyDetail.style.display = "";

            var params = {};
            params.mainId = mainId;
            params.auditSign = 1;
            innerAllotApplyGrid.load({
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
    var settleTypeId = rows[0].settleTypeId;

    if(!callback)
    {
        CloseWindow("ok");
    }
    else{

        if(orderTypeId == 1){
            getPchsDetails();
            if(pjPchsOrderDetailList){
            	var innerPchsEnterGridRow=innerPchsEnterGrid.getSelecteds();
            	if(innerPchsEnterGridRow.length>0){
            		var mainId = innerPchsEnterGridRow[0].mainId;
                	for(var i=0;i<pjPchsOrderDetailList.length;i++){
                		if(pjPchsOrderDetailList[i].mainId==mainId){   					
                			pjPchsOrderDetailList.splice(i--, 1);
        				}
                	}
                	for(var i=0;i<innerPchsEnterGridRow.length;i++){			
                		pjPchsOrderDetailList.push(innerPchsEnterGridRow[i]);
        			}
            	}
            }
            for(var i=0;i<pjPchsOrderDetailList.length;i++){	
            	pjPchsOrderDetailList[i].settleTypeId =settleTypeId;
			}
            callback(pjPchsOrderDetailList);
            CloseWindow("ok");
            
        }else if(orderTypeId == 2){
            getSellDetails();
            if(pjSellOrderDetailList){
            	var innerPchsRtnGridRow=innerPchsRtnGrid.getSelecteds();
            	if(innerPchsRtnGridRow.length>0){
            		var mainId = innerPchsRtnGridRow[0].mainId;
                	for(var i=0;i<pjSellOrderDetailList.length;i++){
                		if(pjSellOrderDetailList[i].mainId==mainId){   					
                			pjSellOrderDetailList.splice(i--, 1);
        				}
                	}
                	for(var i=0;i<innerPchsRtnGridRow.length;i++){	
                		innerPchsRtnGridRow[i].settleTypeId =settleTypeId;
                		pjSellOrderDetailList.push(innerPchsRtnGridRow[i]);
        			}
            	}
            	
            }
            for(var i=0;i<pjSellOrderDetailList.length;i++){	
            	pjSellOrderDetailList[i].settleTypeId =settleTypeId;
			}
            callback(pjSellOrderDetailList);
            CloseWindow("ok");
        }
        else if(orderTypeId == 3){
        	getAllotDetails();
            if(pjAllotApplyDetails){
            	var innerAllotApplyGridRow=innerAllotApplyGrid.getSelecteds();
            	if(innerAllotApplyGridRow.length>0){
            		var mainId = innerAllotApplyGridRow[0].mainId;
                	for(var i=0;i<pjAllotApplyDetails.length;i++){
                		if(pjAllotApplyDetails[i].mainId==mainId){   					
                			pjAllotApplyDetails.splice(i--, 1);
        				}
                	}
                	for(var i=0;i<innerAllotApplyGridRow.length;i++){			
                		pjAllotApplyDetails.push(innerAllotApplyGridRow[i]);
        			}
            	}
            	
            }
            callback(pjAllotApplyDetails);
            CloseWindow("ok");
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
var querySellUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjSellOrderDetailList.biz.ext";
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
            async: false,
            data : JSON.stringify({
                params : params,
                token : token
            }),
            success : function(data) {
                nui.unmask(document.body);
                 pjSellOrderDetailList = data.pjSellOrderDetailList || [];
                if (pjSellOrderDetailList && pjSellOrderDetailList.length>0) {
                    
//                    callback(pjSellOrderDetailList);
//
//                    CloseWindow("ok");
                    
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
var queryPchsUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjPchsOrderDetailList.biz.ext";
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
            async: false,
            data : JSON.stringify({
                params : params,
                token : token
            }),
            success : function(data) {
                nui.unmask(document.body);
                pjPchsOrderDetailList = data.pjPchsOrderDetailList || [];
                if (pjPchsOrderDetailList && pjPchsOrderDetailList.length>0) {
                    
//                    callback(pjPchsOrderDetailList);
//
//                    CloseWindow("ok");
                    
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

var queryAllotApplyUrl= baseUrl+"com.hsapi.cloud.part.invoicing.allotsettle.queryAllotApplyDetails.biz.ext";
function getAllotDetails(){
	
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
            url : queryAllotApplyUrl,
            type : "post",
            async: false,
            data : JSON.stringify({
                params : params,
                token : token
            }),
            success : function(data) {
                nui.unmask(document.body);
                pjAllotApplyDetails = data.pjAllotApplyDetails || [];
                if (pjAllotApplyDetails && pjAllotApplyDetails.length>0) {
                    
//                    callback(pjPchsOrderDetailList);
//
//                    CloseWindow("ok");
                    
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