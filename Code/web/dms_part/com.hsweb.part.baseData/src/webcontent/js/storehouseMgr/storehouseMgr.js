/**
 * Created by Administrator on 2018/1/24.
 */
var baseUrl = "";
var tree = null;
var treeUrl = baseUrl+"";
$(document).ready(function(v)
{
    tree = nui.get("tree1");
   // tree.setUrl(treeUrl);
    //console.log("xxx");
});

function onBeforeOpen(e)
{
    var menu = e.sender;
    var node = tree.getSelectedNode();
    var editItem = nui.getbyName("edit", menu);
    var addChildItem = nui.getbyName("addChild", menu);
    if(!node)
    {
        editItem.hide();
        addChildItem.hide();
    }
    else{
        editItem.show();
        addChildItem.show();
    }
}
function onAddNode()
{
    var node = tree.getSelectedNode();
    var pId = "";
    if(node){
        pId = node.pId;
    }
    nui.open({
        targetWindow: window,
        url: "com.hsweb.part.baseData.storehouseDetail.flow",
        title: "仓库定义",
        width: 500, height: 250,
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



function addPosition()
{
    var node = tree.getSelectedNode();
    var id = "";
    if(node){
        id = node.id;
    }
    nui.open({
        targetWindow: window,
        url: "com.hsweb.part.baseData.positionDetail.flow",
        title: "仓位定义",
        width: 525, height: 230,
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