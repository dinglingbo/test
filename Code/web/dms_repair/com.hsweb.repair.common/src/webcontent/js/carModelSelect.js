/**
 * Created by Administrator on 2018/3/19.
 */
var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var treeUrl = baseUrl+"com.hsapi.repair.common.svr.queryCarBrandSeriesTree.biz.ext";
var tree = null;
var grid = null;
var gridUrl = baseUrl+"com.hsapi.repair.common.common.getCarModelByBrandId.biz.ext";
var queryForm = null;
$(document).ready(function(v)
{
    tree = nui.get("tree");
    tree.setUrl(treeUrl);
    tree.on("nodedblclick",function(e)
    {
        var node = e.node;
        var params = {};
        if("carSeries" == node.nodeType)
        {
            var pNode = tree.getParentNode(node);
            params.seriesId = node.nodeId;
            params.brandId = pNode.nodeId;
        }
        else{
            params.brandId = node.nodeId;
        }
        doSearch(params);
    });

    grid = nui.get("datagrid1");
    grid.setUrl(gridUrl);

    queryForm = new nui.Form('#queryForm');
});
function getSearchParams()
{
    var params = queryForm.getData();
    return params;
}
function onSearch()
{
    var params = getSearchParams();
    doSearch(params);
}
function doSearch(params)
{
    grid.load(params);
}
var resultData = {};
function getData(){
    return resultData;
}
function onOk()
{
    var row = grid.getSelected();
    if(row)
    {
        resultData.carModel = row;
        CloseWindow("ok");
    }
    else{
        nui.alert("请选择一个车型");
    }
}

function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}