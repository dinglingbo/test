
var baseUrl = apiPath + frmApi + "/"; 
var partBaseUrl = apiPath + partApi + "/";
var notStatementUrl = partBaseUrl + "com.hsapi.part.invoice.settle.queryOrderBill.biz.ext";
var innerPchsGridUrl = partBaseUrl+"com.hsapi.part.invoice.svr.queryPjPchsOrderDetailList.biz.ext";
var innerSellGridUrl = partBaseUrl+"com.hsapi.part.invoice.svr.queryPjSellOrderDetailList.biz.ext";
var innerAllotEnterGridUrl = partBaseUrl +"com.hsapi.part.invoice.partAllot.queryPjAllotDetailList.biz.ext";

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
var storeHash={};
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

var editFormAllotEnterDetail = null;

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

    innerAllotEnterGrid = nui.get("innerAllotEnterGrid");
    editFormAllotEnterDetail = document.getElementById("editFormAllotEnterDetail");
    innerAllotEnterGrid.setUrl(innerAllotEnterGridUrl);

    
    billTypeIdEl = nui.get("billTypeId");
    settleTypeIdEl = nui.get("settleTypeId");
    sBillAuditDateEl = nui.get("sBillAuditDate");
    eBillAuditDateEl = nui.get("eBillAuditDate");
    billSearchGuestIdEl = nui.get("searchBillGuestId");
    billServiceIdEl = nui.get("billServiceId");
    billServiceManEl = nui.get("billServiceMan");

    sBillAuditDateEl.setValue(getMonthStartDate());//上月开始日期
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
        storehouse.forEach(function(v){
        	storeHash[v.id]=v;
        });
    });

    getAllPartBrand(function(data) {
        brandList = data.brand;
        brandList.forEach(function(v) {
            brandHash[v.id] = v;
        });
    });
    

	 nui.get("billServiceId").focus();
	document.onkeyup=function(event){
       var e=event||window.event;
       var keyCode=e.keyCode||e.which;//38向上 40向下

       if((keyCode==27))  {  //ESC
           onCancel();
       }
     };
   
	

});
function setInitData(data, ck, cck){
    callback = ck;
    checkcallback = cck;

    billSearchGuestIdEl.setValue(data);

    searchBill();
}

var accountList = [
    {id:0,text:"未对账"},
    {id:1,text:"已对账"},
    {id:2,text:"全部"}
];
var orderTypeIdHash = {1:"采购订单",2:"销售订单",3:"采购退货",4:"销售退货",5:"调拨申请",6:"调拨受理"};
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
    params.auditSign = 1;
    params.sortField = "auditDate";
    params.sortOrder = "desc";
    params.settleTypeId = "020502";
    params.stateSign = 0;
    params.isState = 0;
    notStatementGrid.load({
        params:params,
        token: token
    });
}
function onShowRowDetail(e) {
    var row = e.record;
    var mainId = row.mainId;
    
    //将editForm元素，加入行详细单元格内
    var td = notStatementGrid.getRowDetailCellEl(row);
    var dc = row.dc;    
    var orderTypeId =row.orderTypeId;
    switch (orderTypeId)
    {
       case 1:
       case 4:
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
       case 3:
           /* td.appendChild(editFormPchsRtnDetail);
            editFormPchsRtnDetail.style.display = "";

            var params = {};
            params.mainId = mainId;
            params.auditSign = 1;
            innerPchsRtnGrid.load({
                params:params,
                token: token
            });*/
            
          //销售
        	if(orderTypeId ==2){
        		td.appendChild(editFormSellOutDetail);
        		editFormSellOutDetail.style.display = "";

                var params = {};
                params.mainId = mainId;
                params.auditSign = 1;
                innerSellOutGrid.load({
                    params:params,
                    token: token
                });
        	}else{
        		td.appendChild(editFormPchsRtnDetail);
                editFormPchsRtnDetail.style.display = "";

                var params = {};
                params.mainId = mainId;
                params.auditSign = 1;
                innerPchsRtnGrid.load({
                    params:params,
                    token: token
                });
        	}           
            break;
        case 5:
        case 6:
        	 td.appendChild(editFormAllotEnterDetail);
        	 editFormAllotEnterDetail.style.display = "";
        	 var params = {};
        	 params.mainId = mainId;
             innerAllotEnterGrid.load({
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

        //需要判断是否已经添加了此单据
        for(var i=0; i<rows.length; i++){
            var row = rows[i];
            var checkMsg = checkcallback(row.serviceId);
            if(checkMsg){
                nui.alert(checkMsg);
                return;
            }
        }

        callback(rows);

        CloseWindow("ok");
    }
}
function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}

//取消
function onCancel() {
    CloseWindow("cancel");
}

