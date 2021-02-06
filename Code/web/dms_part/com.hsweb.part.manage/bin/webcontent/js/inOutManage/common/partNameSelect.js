/**
 * Created by Administrator on 2018/1/27.
 */

var baseUrl = apiPath + partApi + "/";
var gridUrl = baseUrl+"com.hsapi.part.common.svr.queryPartName.biz.ext";
var treeUrl = baseUrl+"com.hsapi.part.common.svr.getPartTypeTree.biz.ext";
var grid = null;
var tree = null;
$(document).ready(function(v)
{
    grid = nui.get("grid1");
    grid.setUrl(gridUrl);

    tree = nui.get("tree1");
    tree.setUrl(treeUrl);
    //console.log("xxx");
});
function onDrawNode(e)
{
    var node = e.node;
    e.nodeHtml = node.code + " " + node.name;
}
function onNodeDblClick(e)
{
    var currTree = e.sender;
    var currNode = e.node;
    var level = currTree.getLevel(currNode);
    var list = [];
    var tmpNode = currNode;
    do{
        list[level] = tmpNode.id;
        tmpNode = currTree.getParentNode(tmpNode);
        level = currTree.getLevel(tmpNode);
    }while(tmpNode&&tmpNode.id);

    var cartypef = list[0]||"";
    var cartypes = list[1]||"";
    var cartypet = list[2]||"";

    var partName = {
        cartypef:cartypef,
        cartypes:cartypes,
        cartypet:cartypet
    };
    doSearch({
        partName:partName
    });
}
var partTypeHash = null;
function onPartGridDraw(e)
{
    if(!partTypeHash)
    {
        partTypeHash = {};
        var partTypeList = tree.getList();
        partTypeList.forEach(function(v)
        {
            partTypeHash[v.id] = v;
        });
    }

    switch (e.field)
    {
        case "isdisabled":
            e.cellHtml = e.value == 1?"禁用":"启用";
            break;
        case "cartypef":
        case "cartypes":
        case "cartypet":
            if(partTypeHash[e.value])
            {
                e.cellHtml = partTypeHash[e.value].name||"";
            }
            else{
                e.cellHtml = "";
            }
            break;
        default:
            break;
    }
}


function reloadData()
{
    if(grid)
    {
        grid.reload();
    }
}
function getSearchParams()
{
    var params = {};
    params.searchKey = nui.get("searchKey").getValue();
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
function onOk()
{
    var node = grid.getSelected();
    if(node)
    {
        console.log(node);
        resultData = {
            partName:node
        };
        CloseWindow("ok");
    }

}
function getData(){
    return resultData;
}
function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}