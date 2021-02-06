/**
 * Created by Administrator on 2018/3/14.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var partGridUrl = baseUrl+"com.hsapi.part.purchase.stockCheck.getStockCheckList.biz.ext";
var partGrid = null;
var storeIdEl = null;
$(document).ready(function(v)
{
    partGrid = nui.get("partGrid");
    partGrid.setUrl(partGridUrl);
    partGrid.on("beforeload",function(e){
        e.data.token = token;
    });

    storeIdEl = nui.get("storeId");
});

function onSearch()
{
    var params = getSearchParams();
    doSearch(params);
}
function getSearchParams()
{
    var params = {};
    params.storeId = nui.get("storeId").getValue();
    return params;
}
function doSearch(params)
{
    params = params||{};
    params.orgid = currOrgid;
    partGrid.load(params);
}

var resultData = {};
function onOk()
{
    var row = partGrid.getSelected();
 //   console.log(row);
    if(!row)
    {
        return;
    }
    resultData = {
        stockCheck:row
    };
    CloseWindow("ok");
}
function getData(){
    return resultData;
}
var storeList = [];
function setData(data,ck)
{
    data = data||{};
    storeList = data.storeList||[];
    nui.get("storeId").setData(storeList);
    if(storeList.length>0)
    {
        nui.get("storeId").setValue(storeList[0].id);
    }
    onSearch();
}
function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}