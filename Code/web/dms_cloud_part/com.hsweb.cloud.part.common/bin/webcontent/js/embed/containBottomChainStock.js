/**
 * Created by Administrator on 2018/3/17.
 */
var rightGridUrl = apiPath + cloudPartApi + "/com.hsapi.cloud.part.invoicing.query.queryPartChainStock.biz.ext";
var basicInfoForm = null;
var rightGrid = null;
var searchBeginDate = null;
var searchEndDate = null;
var comPartNameAndPY = null;
var comPartCode = null;
var partBrandId = null;
var storeId = null;
var storeShelf = null;
var partId = null;
var showAll = null;

var storehouseHash = {};
var billTypeIdHash = {};
var settTypeIdHash = {};
var enterTypeIdHash = {};
var partBrandIdHash = {};
$(document).ready(function(v)
{
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);

    /*getStorehouse(function(data)
    {
        var storehouse = data.storehouse||[];
        storehouse.forEach(function(v)
        {
            if(v && v.id)
            {
                storehouseHash[v.id] = v;
            }
        });
    });*/

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
//    if(!params.partId && params.partCode){
//        rightGrid.setData([]);
//        return;
//    }
    //params.sortField = "b.stock_qty";
    //params.sortOrder = "desc";
    /*if(params.partCode){
    	params={};
    	params.pids=partCode;
    }*/
//    params.notShowAll = 1;
//    params.sortField = "a.outable_qty";
//    params.sortOrder = "desc";
    rightGrid.load({
        params:params,
        token:token
    });
}
function onDrawCell(e)
{
    switch (e.field)
    {
        case "storeId":
            if(storehouseHash && storehouseHash[e.value])
            {
                e.cellHtml = storehouseHash[e.value].name;
            }
            break;
        default:
            break;
    }
}
