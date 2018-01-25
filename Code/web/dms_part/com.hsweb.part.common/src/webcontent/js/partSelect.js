/**
 * Created by Administrator on 2018/1/23.
 */
var basePath = window._rootUrl||"http://127.0.0.1:8080/default/";
var partGridUrl = basePath+"com.hsapi.part.baseDataCrud.crud.queryPartList.biz.ext";
var partGrid = null;
$(document).ready(function(v)
{
    partGrid = nui.get("partGrid");
    partGrid.setUrl(partGridUrl);
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
        url: "./partDetailView.html",
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


var resultData = {};
var callback = null;
function onOk()
{
    var node = partGrid.getSelected();
    console.log(node);
    resultData = {
        node:node
    };
    if(!callback)
    {
        CloseWindow("ok");
    }
    else{
        callback(node);
    }
}
function getData(){
    return resultData;
}
function setData(data,ck){
    callback = ck;
}
function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}