var storeStockGrid = null;
var enterGrid = null;
var storeStockUrl = partApiUrl + "com.hsapi.part.invoice.query.queryPartStoreStock.biz.ext";
var enterDetailUrl = partApiUrl + "com.hsapi.part.invoice.query.queryOutableDetailList.biz.ext";
var billTypeList = null;
var billTypeHash = {};
var storehouse = null;
var storeHash = {};
var brandList = null;
var brandHash = {};

$(document).ready(function(v) {
    storeStockGrid = nui.get("storeStockGrid");
    enterGrid = nui.get("enterGrid");

    storeStockGrid.setUrl(storeStockUrl);
    enterGrid.setUrl(enterDetailUrl);

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
            storehouse.forEach(function(v) {
                storeHash[v.id] = v;
            });
        }
    });

    getAllPartBrand(function(data) {
        brandList = data.brand;
        brandList.forEach(function(v) {
            brandHash[v.id] = v;
        });
    });

    storeStockGrid.on("drawcell",function(e){
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
            default:
                break;
        }
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

    var params = {partId: partId};
    doSearch(params);
});
function doSearch(params){
    if(!params.partId || params.partId==0){
        storeStockGrid.setData([]);
        enterGrid.setData([]);
        return;
    }
    storeStockGrid.load({
        params:params,
        token:token
    });

    enterGrid.load({
        params:params,
        token:token
    });
}