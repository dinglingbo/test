/**
 * Created by Administrator on 2018/1/24.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var tree = null;
var rightGrid = null;
var memGrid = null;
var treeUrl = baseUrl+"com.hsapi.part.baseDataCrud.crud.getStorehouse.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.part.baseDataCrud.crud.getSorehouseLocation.biz.ext";
var storeMemUrl = apiPath + sysApi + "/com.hsapi.system.tenant.employee.queryStoreMember.biz.ext";
$(document).ready(function(v)
{
	tree = nui.get("tree1");
    tree.setUrl(treeUrl);
//    tree.on("beforeload",function(e){
//        e.data.token = token;
//    });
    
    tree.load({fromDb:true,token:token});
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    rightGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    rightGrid.on("rowclick",onRowClick);
    rightGrid.on("load",function(){
    	var data=rightGrid.getData();
    	if(data.length>0){
    		onRowClick({});
    	}
        
    });
    
    memGrid = nui.get("memGrid");
    memGrid.setUrl(storeMemUrl);
    
    memGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    
});
function onRowClick(e)
{
    var row = rightGrid.getSelected();
    if(row.isDisabled==1)
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
        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.part.baseData.storehouseDetail.flow?token=" + token,
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
        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.part.baseData.storehouseDetail.flow?token=" + token,
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
        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.part.baseData.positionDetail.flow?token=" + token,
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
            storeId:node.id,
            fromDb: true
        });
        
        memGrid.load({
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
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
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
        	nui.unmask();
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
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
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
        	nui.unmask();
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
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
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
            nui.unmask();
            console.log(jqXHR.responseText);
        }
    });
}
function reloadGrid(){
    rightGrid.reload();
}

function addStoreMem()
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
        url: webPath+contextPath+"/com.hs.common.employeeChoose.flow?token=" + token,
        title: "员工选择",
        width: 600, height: 300,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
        },
        ondestroy: function (action)
        {
        	if(action == "ok")
            {
        		var iframe = this.getIFrameEl();
				var data = iframe.contentWindow.getRetData();
				saveStoreMember(data, node.id);
            }
        }
    });
}

var saveUrl = apiPath + sysApi + "/com.hsapi.system.tenant.employee.saveStoreMember.biz.ext";
function saveStoreMember(memList, storeId){
    if(!memList)
    {
        return;
    }
    var data = [];
    for(var i=0; i<memList.length; i++) {
    	memList[i].storeId = storeId;
    	var mem = {
    		empId : memList[i].empid,
    		empName: memList[i].name,
    		storeId : storeId
    	}
    	data.push(mem);
    }
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
	});
    nui.ajax({
        url:saveUrl,
        type:"post",
        data:JSON.stringify({
        	memList:data,
            token:token
        }),
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                showMsg("添加成功","S");
                memGrid.reload();
            }
            else{
                showMsg("添加失败","W");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
        	nui.unmask();
            console.log(jqXHR.responseText);
        }
    });
}

var delUrl = apiPath + sysApi + "/com.hsapi.system.tenant.employee.deleteStoreMember.biz.ext";
function delStoreMem(){
	var rows = memGrid.getSelecteds();
    if(!rows)
    {
        return;
    }
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '删除中...'
	});
    nui.ajax({
        url:delUrl,
        type:"post",
        data:JSON.stringify({
        	memList:rows,
            token:token
        }),
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                showMsg("删除成功","S");
                memGrid.removeRows(rows);
            }
            else{
                showMsg("删除失败","W");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
        	nui.unmask();
            console.log(jqXHR.responseText);
        }
    });
}











