/**
 * Created by Administrator on 2018/1/24.
 */
var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var tree = null;
var rightGrid = null;
var treeUrl = baseUrl+"com.hsapi.part.baseDataCrud.crud.getStorehouse.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.part.baseDataCrud.crud.getSorehouseLocation.biz.ext";
$(document).ready(function(v)
{
	tree = nui.get("tree1");
    tree.setUrl(treeUrl);
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
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
    var storehouseList = tree.getList()||[];
    nui.open({
        targetWindow: window,
        url: "./storehouseDetailView.html",
        title: "仓库定义",
        width: 500, height: 250,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData({
                storehouse:{
                    isEdit:"N",
                    chargeMan:"周坤",
                    id:(new Date()).getTime(),
                    parentId:pId
                },
                storehouseList:storehouseList
            });
        },
        ondestroy: function (action)
        {
            if(action == "ok")
            {
                tree.reload();
            }
        }
    });
}
function onAddChildNode(){
    var node = tree.getSelectedNode();
    if(!node)
    {
        return;
    }
    var pId = "";
    if(node){
        pId = node.id;
    }
    var storehouseList = tree.getList()||[];
    nui.open({
        targetWindow: window,
        url: "./storehouseDetailView.html",
        title: "仓库定义",
        width: 500, height: 250,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData({
                storehouse:{
                    isEdit:"N",
                    chargeMan:"周坤",
                    id:(new Date()).getTime(),
                    parentId:pId
                },
                storehouseList:storehouseList
            });
        },
        ondestroy: function (action)
        {
            if(action == "ok")
            {
                tree.reload();
            }
        }
    });
}
function onEditNode(){
    var node = tree.getSelectedNode();
    if(!node)
    {
        return;
    }
    var storehouseList = tree.getList()||[];
    nui.open({
        targetWindow: window,
        url: "./storehouseDetailView.html",
        title: "仓库定义",
        width: 500, height: 250,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            node.isEdit = "Y";
            iframe.contentWindow.setData({
                storehouse:node,
                storehouseList:storehouseList
            });
        },
        ondestroy: function (action)
        {
            if(action == "ok")
            {
                tree.reload();
            }
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
    else{
        nui.alert("请选择一个仓库");
        return;
    }
    var storehouseList = tree.getList()||[];
    nui.open({
        targetWindow: window,
        url: "./positionDetailView.html",
        title: "仓位定义",
        width: 525, height: 230,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData({
                storehouse:node,
                storehouseList:storehouseList
            });
        },
        ondestroy: function (action)
        {

        }
    });
}

function onNodeselect(e)
{
    var node = e.node;
    if(node && node.id)
    {
        rightGrid.load({
            storeId:node.id
        });
    }
}
function onDrawCell(e){

    switch (e.field)
    {
        case "isDisabled":
            e.cellHtml = e.value==1?"是":"否";
            break;
    }
}

var saveUrl = baseUrl + "com.hsapi.part.baseDataCrud.crud.updateStorehouseLocation.biz.ext";
function disableLocation(){
    var row = rightGrid.getSelected();
    if(!row)
    {
        return;
    }
    var data = [
        {
            id:row.id,
            isDisabled:1
        }
    ];
    nui.mask({
        html:'保存中...'
    });
    nui.ajax({
        url:saveUrl,
        type:"post",
        data:JSON.stringify({
            locations:data
        }),
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                nui.alert("禁用成功");
            }
            else{
                nui.alert("禁用失败");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}