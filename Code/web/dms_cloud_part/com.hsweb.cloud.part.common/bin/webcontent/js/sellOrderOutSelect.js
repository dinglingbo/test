
var baseUrl = apiPath + cloudPartApi + "/";
var innerSellGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.stockcal.querySellOrderOutRtnGridWithPage.biz.ext";
var notStatementGrid = null;
var leftGrid = null;
var rightGrid = null;
var editFormPchsEnterDetail = null;
var innerPchsEnterGrid = null;
var editFormPchsRtnDetail = null;
var innerPchsRtnGrid = null;
var editFormAllotApplyDetail =null;
var innerAllotApplyGrid = null;

var orderTypeId = 2;
var businessTypeId = "1591934420679";
var settleGuestId = "";
var storeId = "";
var guestId = "";
var billTypeId = "";

var brandHash = {};
var brandList = [];
var compBrandList = [];
var compBrandHash = {};
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

});
function setInitData(data, ck, cck){
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
	
	var dictDefs ={"billTypeId":"DDT20130703000008", "settleTypeId":"DDT20130703000035", "orgCarBrandId": "10444"};
    initDicts(dictDefs,function()
    {
    	compBrandList = nui.get("orgCarBrandId").getData();
		compBrandList.forEach(function(v){
			compBrandHash[v.customid]=v;
    	});
		
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
        
        getStorehouse(function(data)
	    {
	        storehouse = data.storehouse||[];
	        if(storehouse && storehouse.length>0){
	            storehouse.forEach(function(v){
	        		storeHash[v.id]=v;
	        	});
	        }
	        
	        getAllPartBrand(function(data) {
		        brandList = data.brand;
		        brandList.forEach(function(v) {
		            brandHash[v.id] = v;
		        });
		        
		        searchBill();
		        
		    });
	        
	    });

	    

    });
	
    callback = ck;
    checkcallback = cck;

    guestId = data.guestId;
    orderTypeId = data.orderTypeId;
    businessTypeId = data.businessTypeId || "1591934420679";
    settleGuestId = data.settleGuestId || data.guestId;
    storeId = data.storeId || "-1";
    billTypeId = data.billTypeId;

    
}
function getBillSearchParam(){

	var params = {};
    params.sAuditDate = sBillAuditDateEl.getFormValue();
    params.eAuditDate = addDate(eBillAuditDateEl.getValue(), 1);
    params.serviceId = billServiceIdEl.getValue().replace(/\s+/g, "");
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
    params.settleGuestId = settleGuestId;
    params.businessTypeId = businessTypeId;
    params.guestId = guestId;
    params.storeId = storeId;
    params.auditSign = 1;
    params.isDiffOrder = 1;
    params.billTypeId = billTypeId;
    innerPchsRtnGrid.load({
        params:params,
        token: token
    });
}
var resultData = {};
var callback = null;
var checkcallback = null;
function addStatement()
{
    var rows = innerPchsRtnGrid.getSelecteds();
   
    if(!rows){
    	showMsg("请选择销售出库记录","W");
        return;
    }else if(rows && rows.length<=0){
    	showMsg("请选择销售出库记录","W");
        return;
    }
    var settleTypeId = rows[0].settleTypeId;

    if(!callback)
    {
        CloseWindow("ok");
    }
    else{
        callback(rows);
        CloseWindow("ok");
    }
}
function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onClose(){
    CloseWindow("cancel");
}
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
        case "orgCarBrandId":
        	if(compBrandHash[e.value])
            {
        		e.cellHtml = compBrandHash[e.value].name||"";
            }
            else{
                e.cellHtml = "";
            }
            break;
        default:
            break;
    }
}