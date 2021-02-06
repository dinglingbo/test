/**
 * Created by Administrator on 2018/3/19.
 */
var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var treeUrl = baseUrl+"com.hsapi.repair.common.svr.queryCarBrandSeriesTree.biz.ext";
var tree = null;
var grid = null;
var gridUrl = baseUrl+"com.hsapi.repair.common.common.getCarModelByBrandId.biz.ext";
var queryForm = null;
var datagrid1 = null;
$(document).ready(function(v)
{
    tree = nui.get("tree");
    datagrid1 = nui.get("datagrid1");
    tree.setUrl(treeUrl);
/*
 * {
  sender: Object,         //树对象
  node: Object,           //节点对象
  isLeaf: Boolean
}
 * 
 * */
    //"nodedblclick":节点双击时发生
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
    
    datagrid1.on("rowdblclick",function(e){
		onOk();
	});
    
    nui.get("carModel").focus();
    document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27))  {  //ESC
            onCancel();
        }
     
    }
    
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
	params.token = token;
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
        showMsg("请选择一个车型", "W");
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

function searchOnenter(){
	onSearch();
}

