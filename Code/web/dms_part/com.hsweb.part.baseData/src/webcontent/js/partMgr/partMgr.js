/**
 * Created by Administrator on 2018/1/23.
 */
var basePath = window._rootUrl||"http://127.0.0.1:8080/default/";
var partListUrl = basePath+"com.hsapi.part.baseDataCrud.crud.queryPartList.biz.ext";
var partGrid = null;
$(document).ready(function(v)
{
    partGrid = nui.get("partGrid");
    partGrid.setUrl(partListUrl);
    //console.log("xxx");
});
var partMap = {
    isDisabled:{
        0:"有效",
        1:"失效"
    }
};
function onPartGridDraw(e)
{
    var field = e.field;
    var value = e.value;
    if(partMap[field] && partMap[field][value])
    {
        e.cellHtml = partMap[field][value];
    }
}


function reloadData()
{
    if(partGrid)
    {
        partGrid.reload();
    }
}
function getSearchParams()
{
    var params = {};
    params.code = nui.get("search-code").getValue();
    params.name = nui.get("search-name").getValue();
    params.namePy = nui.get("search-namePy").getValue().toUpperCase();
    params.applyCarModel = nui.get("search-applyCarModel").getValue();
    return params;
}
function onSearch()
{
    var params = getSearchParams();
    doSearch(params);
}
function doSearch(params)
{
    partGrid.load(params);
}

function addPart()
{
    nui.open({
        targetWindow: window,
        url: "com.hsweb.part.baseData.partDetail.flow",
        title: "配件资料",
        width: 740, height: 300,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {

        },
        ondestroy: function (action)
        {

        }
    });
}

