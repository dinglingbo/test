
var baseUrl = apiPath + cloudPartApi + "/";
var notPackUrl = baseUrl + "com.hsapi.cloud.part.invoicing.svr.queryPjStockCheckMainList.biz.ext";
var innerSellGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjStockCheckDetailList.biz.ext";
var notPackGrid = null;
var leftGrid = null;
var rightGrid = null;
var editFormSellOutDetail = null;
var innerSellOutGrid = null;
var brandHash = {};
var brandList = [];
var storehouse = null;
var billTypeIdEl = null;
var settleTypeIdEl = null;
var billTypeIdHash = {};
var settTypeIdHash = {};
var billTypeIdList = [];
var settTypeIdList = [];
var FStoreId=null;

var sBillAuditDateEl = null;
var eBillAuditDateEl = null;
var billSearchGuestIdEl = null;
var billServiceIdEl = null;
var billServiceManEl = null;
var accountSignEl = null;
var dcHash = {
	"1":"盘盈",
	"0":"正常",
	"-1":"盘亏"
};

$(document).ready(function(v)
{
	notPackGrid = nui.get("notPackGrid");
    notPackGrid.setUrl(notPackUrl);	

    innerSellOutGrid = nui.get("innerSellOutGrid");
    editFormSellOutDetail = document.getElementById("editFormSellOutDetail");
    innerSellOutGrid.setUrl(innerSellGridUrl);

    billTypeIdEl = nui.get("billTypeId");
    settleTypeIdEl = nui.get("settleTypeId");
    sBillAuditDateEl = nui.get("sBillAuditDate");
	eBillAuditDateEl = nui.get("eBillAuditDate");
	billSearchGuestIdEl = nui.get("searchBillGuestId");
	billServiceIdEl = nui.get("billServiceId");
	billServiceManEl = nui.get("billServiceMan");
	accountSignEl = nui.get("accountSign");

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
    });

    getAllPartBrand(function(data) {
        brandList = data.brand;
        brandList.forEach(function(v) {
            brandHash[v.id] = v;
        });
    });

    

});
function setInitData(guestId, storeId, ck, cck){
    callback = ck;
    checkcallback = cck;
    
    FStoreId = storeId;

    billSearchGuestIdEl.setValue(guestId);

    searchBill();
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
        case "settleTypeId":
            if(settTypeIdHash && settTypeIdHash[e.value])
            {
                e.cellHtml = settTypeIdHash[e.value].name;
            }
            break;
        case "storeId":
            if(storehouse && storehouse[e.value])
            {
                e.cellHtml = storehouse[e.value].name;
            }
            break;
        case "dc":
            if(dcHash && dcHash[e.value])
            {
                e.cellHtml = dcHash[e.value];
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
    params.serviceId = billServiceIdEl.getValue().replace(/\s+/g, "");
    params.orderMan = billServiceManEl.getValue();
    params.guestId = billSearchGuestIdEl.getValue();
    return params;
}
function searchBill()
{
    var param = getBillSearchParam();
    doNotStatement(param);
}
function doNotStatement(params){
	params.sortField = "a.audit_date";
    params.sortOrder = "desc";
    params.packSign = 0;
    params.auditSign = 1;
    params.storeId = FStoreId;
    notPackGrid.load({
        params:params,
        token: token
    });
}
function onShowRowDetail(e) {
    var row = e.record;
    var mainId = row.id;
    
    //将editForm元素，加入行详细单元格内
    var td = notPackGrid.getRowDetailCellEl(row);   

    td.appendChild(editFormSellOutDetail);
    editFormSellOutDetail.style.display = "";

    var params = {};
    params.mainId = mainId;
    innerSellOutGrid.load({
        params:params,
        token: token
    });
}

var resultData = {};
var callback = null;
var checkcallback = null;
function addStatement()
{
    var rows = notPackGrid.getSelecteds();
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
                showMsg(checkMsg,"W");
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
function onCancel(e) {
    CloseWindow("ok");
}