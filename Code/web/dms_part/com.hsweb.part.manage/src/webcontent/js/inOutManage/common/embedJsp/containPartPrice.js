/**
 * Created by Administrator on 2018/3/17.
 */
var priceGridUrl = partApiUrl+"com.hsapi.part.invoice.pricemanage.getPartPriceInfo.biz.ext";
var basicInfoForm = null;
var priceGrid = null;

var storehouseHash = {};
var billTypeIdHash = {};
var settTypeIdHash = {};
var enterTypeIdHash = {};
var partBrandIdHash = {};
$(document).ready(function(v)
{
    priceGrid = nui.get("priceGrid");
    priceGrid.setUrl(priceGridUrl);

    if(partId){
        var params = {partId:partId};
        doSearch(params);
    }
});
function getSearchParam(){
    var params = {};
    return params;
}
function onSearch(){
    var params = getSearchParam();

    doSearch(params);
}
function doSearch(params)
{
    if(!params.partId || params.partId<=0){
        priceGrid.setData([]);
        return;
    }

    priceGrid.load({
        params:params,
        token:token
    });
}
