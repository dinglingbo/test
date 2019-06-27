/**
 * Created by Administrator on 2018/1/24.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var tree = null;
var rightGrid = null;
var treeUrl = baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.getStorehouse.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.getSorehouseLocation.biz.ext";
var storeMemUrl = apiPath + sysApi + "/com.hsapi.system.tenant.employee.queryStoreMem.biz.ext";
var isHash ={"0":"否","1":"是"};
$(document).ready(function(v)
{
	tree = nui.get("tree1");
    tree.setUrl(treeUrl);
//    tree.on("beforeload",function(e){
//        e.data.token = token;
//    });
    
    tree.load({token:token});
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
    

    memGrid.on("drawcell",function(e){
        switch (e.field)
        {
            case "isOpenApp":
                if(isHash && isHash[e.value])
                {
                    e.cellHtml = isHash[e.value];
                }
                break;
            default:
                break;
        }
    });
    
    if(currIsOpenApp==1){
    	nui.get('delAppBtn').setVisible(true);
    	nui.get('recoverAppBtn').setVisible(true);
    	nui.get('chooseBth').setVisible(true);
    }else{
    	nui.get('delAppBtn').setVisible(false);
    	nui.get('recoverAppBtn').setVisible(false);
    	nui.get('chooseBth').setVisible(false);

    }
    
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
        url: webPath+contextPath+"/com.hsweb.cloud.part.basic.storehouseDetail.flow?token=" + token,
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
        url: webPath+contextPath+"/com.hsweb.cloud.part.basic.storehouseDetail.flow?token=" + token,
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
        url: webPath+contextPath+"/com.hsweb.cloud.part.basic.positionDetail.flow?token=" + token,
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

var saveUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.updateStorehouseLocation.biz.ext";
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

function chooseRoles(){
	 var node = tree.getSelectedNode();
	    var cangStoreId = "";
	    if(node){
	    	cangStoreId = node.cangStoreId;
	    }
	    else{
	        showMsg("请选择一个仓库","W");
	        return;
	    }
	var memList = memGrid.getSelecteds();
	if(memList.length<0 || memList.length>1){
		showMsg("请选择一条数据","W");
		return;
	}

	 nui.open({
	        url: webPath+contextPath+"/basic/chooseRolse.jsp?token=" + token,
	        title: "角色选择",
	        width: 600, height: 400,
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
					var roles = iframe.contentWindow.getRoles();
					updateRoles(roles, node.cangStoreId,node.id);
	            }
	        }
	    });
}

var updateRolesUrl = baseUrl +"/com.hsapi.cloud.part.baseDataCrud.cang.updateUser.biz.ext";
function updateRoles(roles,cangStoreId,storeId){
	
	var memRow = memGrid.getSelected();
	var empId = memRow.empId;
	nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
	});
    nui.ajax({
        url:updateRolesUrl,
        type:"post",
        data:JSON.stringify({
        	agency_id: currAgencyId,
        	wid      :  cangStoreId,
        	username :  "",
        	password :  "",
        	  phone  : "",
        	erp_id   :  empId,
        	roles  : roles,
        	storeId : storeId,
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
var saveStoreMemUrl = apiPath + sysApi + "/com.hsapi.system.tenant.employee.saveStoreMember.biz.ext";
function saveStoreMember(memList, storeId){
	var wid ="";
	var userinfos ="";
	var node = tree.getSelectedNode();
	var appData =[];
    if(node){
    	wid = node.cangStoreId;
    }
	//开启APP
    if(currIsOpenApp ==1){
    	
    	for(var i=0;i<memList.length;i++){
    		var map ={};
    		map.username =memList[i].systemAccount;
    		map.phone = memList[i].tel;
    		map.erp_id = memList[i].empid;
    		map.password =memList[i].loginPwd;
    		appData.push(map);
    	}
    	userinfos = appData;
    }
    
    if(!memList)
    {
        return;
    }
    var data = [];
    for(var i=0; i<memList.length; i++) {
    	memList[i].storeId = storeId;
    	var mem ={};
		mem.empId = memList[i].empid;
		mem.empName =memList[i].name;
		mem.storeId = storeId;
    	data.push(mem);
    }
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
	});
    nui.ajax({
        url:saveStoreMemUrl,
        type:"post",
        data:JSON.stringify({
        	memList:data,
        	wid : wid,
        	appData : userinfos,
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
	var wid ="";
	var erp_id ="";
	var node = tree.getSelectedNode();
    if(node){
    	wid = node.cangStoreId;
    }
    if(!rows)
    {
        return;
    }
    for(var i=0;i<rows.length;i++){
    	erp_id =erp_id +rows[i].empId +",";
    }
    erp_id =erp_id.substring(0,erp_id.length-1);
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '删除中...'
	});
    nui.ajax({
        url:delUrl,
        type:"post",
        data:JSON.stringify({
        	agency_id:currAgencyId,
        	erp_id : erp_id,
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

var  deleteAppUrl = baseUrl +"/com.hsapi.cloud.part.baseDataCrud.cang.unvalidUser.biz.ext";
//删除APP权限
function deleteApp(){
	var memberList =[];
	var rows = memGrid.getSelecteds();
	var erp_id ="";
    for(var i=0;i<rows.length;i++){
    	erp_id =erp_id +rows[i].empId +",";
    	var mem={};
    	mem.empid= rows[i].empId;
    	mem.isOpenApp =0;
    	memberList.push(mem);
    }
    erp_id =erp_id.substring(0,erp_id.length-1);
	 nui.mask({
	        el: document.body,
	        cls: 'mini-mask-loading',
	        html: '运行中...'
		});
	    nui.ajax({
	        url:deleteAppUrl,
	        type:"post",
	        data:JSON.stringify({
	        	memberList:memberList,
	        	agency_id:currAgencyId,
	        	erp_id : erp_id,
	            token:token
	        }),
	        success:function(data)
	        {
	            nui.unmask();
	            data = data||{};
	            if(data.errCode == "S")
	            {
	                showMsg("删除成功","S");
	                memGrid.reload();
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
var recoverAppUrl = baseUrl +"/com.hsapi.cloud.part.baseDataCrud.cang.validUser.biz.ext";
//恢复APP使用权限
function recoverApp(){
	var memberList =[];
	var rows = memGrid.getSelecteds();
	var erp_id ="";
	for(var i=0;i<rows.length;i++){
    	erp_id =erp_id +rows[i].empId +",";
    	var mem={};
    	mem.empid= rows[i].empId;
    	mem.isOpenApp =1;
    	memberList.push(mem);
    }
    erp_id =erp_id.substring(0,erp_id.length-1);
	 nui.mask({
	        el: document.body,
	        cls: 'mini-mask-loading',
	        html: '运行中...'
		});
	    nui.ajax({
	        url:recoverAppUrl,
	        type:"post",
	        data:JSON.stringify({
	        	memberList:memberList,
	        	agency_id:currAgencyId,
	        	erp_id : erp_id,
	            token:token
	        }),
	        success:function(data)
	        {
	            nui.unmask();
	            data = data||{};
	            if(data.errCode == "S")
	            {
	                showMsg("成功","S");
	                memGrid.reload();
	            }
	            else{
	                showMsg("失败","W");
	            }
	        },
	        error:function(jqXHR, textStatus, errorThrown){
	            //  nui.alert(jqXHR.responseText);
	        	nui.unmask();
	            console.log(jqXHR.responseText);
	        }
	    });
}
