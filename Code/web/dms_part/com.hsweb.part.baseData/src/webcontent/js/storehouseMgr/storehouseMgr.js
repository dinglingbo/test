/**
 * Created by Administrator on 2018/1/24.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var tree = null;
var rightGrid = null;
var treeUrl = baseUrl+"com.hsapi.part.baseDataCrud.crud.getStorehouse.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.part.baseDataCrud.crud.getSorehouseLocation.biz.ext";
$(document).ready(function(v)
{
	tree = nui.get("tree1");
    tree.setUrl(treeUrl);
    tree.on("beforeload",function(e){
        e.data.token = token;
    });

    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    rightGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    rightGrid.on("rowclick",onRowClick);
    rightGrid.on("load",function(){
        onRowClick({});
    });
});
function onRowClick(e)
{
    var row = rightGrid.getSelected();
    if(row.isDisabled)
    {
        nui.get("disableBtn").hide();
        nui.get("enableBtn").show();
    }
    else{
        nui.get("enableBtn").hide();
        nui.get("disableBtn").show();
    }
}
function onAddNode()
{
    nui.open({
        targetWindow: window,
        url: webPath+partDomain+"/com.hsweb.part.baseData.storehouseDetail.flow?token=" + token,
        title: "仓库定义",
        width: 500, height: 200,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
        	var iframe = this.getIFrameEl();
            iframe.contentWindow.setData({
                storehouse:{
                    isEdit:"N",
                    chargeMan:currUserName||""
                }
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
    nui.open({
        targetWindow: window,
        url: webPath+partDomain+"/com.hsweb.part.baseData.storehouseDetail.flow?token=" + token,
        title: "仓库定义",
        width: 500, height: 200,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            node.isEdit = "Y";
            iframe.contentWindow.setData({
                storehouse:node
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
        showMsg("请选择一个仓库","W");
        return;
    }
    var storehouseList = tree.getList()||[];
    nui.open({
        targetWindow: window,
        url: webPath+partDomain+"/com.hsweb.part.baseData.positionDetail.flow?token=" + token,
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
        	if(action == "ok")
            {
                reloadGrid();
            }
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
            locations:data,
            token:token
        }),
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                showMsg("禁用成功","S");
                reloadGrid();
            }
            else{
                showMsg("禁用失败","W");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function enableLocation(){
    var row = rightGrid.getSelected();
    if(!row)
    {
        return;
    }
    var data = [
        {
            id:row.id,
            isDisabled:0
        }
    ];
    nui.mask({
        html:'保存中...'
    });
    nui.ajax({
        url:saveUrl,
        type:"post",
        data:JSON.stringify({
            locations:data,
            token:token
        }),
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                showMsg("启用成功","S");
                reloadGrid();
            }
            else{
                showMsg("启用失败","W");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function savePosition()
{
    var rows = rightGrid.getChanges("modified")||[];
    if(rows.length == 0)
    {
        return;
    }
    var locations = [];
    for(var i=0;i<rows.length;i++)
    {
        locations.push({
            id:rows[i].id,
            name:rows[i].name
        });
    }
  //  console.log(locations);
    nui.mask({
        html:'保存中...'
    });
    nui.ajax({
        url:saveUrl,
        type:"post",
        data:JSON.stringify({
            locations:locations,
            token:token
        }),
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                showMsg("保存成功","S");
                reloadGrid();
            }
            else{
                showMsg("保存失败","W");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            showMsg("网络出错","W");
            console.log(jqXHR.responseText);
        }
    });
}
function reloadGrid(){
    rightGrid.reload();
}