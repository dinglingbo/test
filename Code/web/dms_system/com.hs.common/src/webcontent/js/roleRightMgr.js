/**
 * Created by steven on 2018/1/31.
 */

var baseUrl = apiPath + sysApi + "/";
var leftGridUrl = baseUrl + "com.hsapi.system.tenant.role.queryRole.biz.ext";
var saveUrl = baseUrl + "com.hsapi.system.tenant.role.saveRole.biz.ext";
var deleteRoleUrl = baseUrl + "com.hsapi.system.tenant.role.deleteRole.biz.ext";

var leftGrid;
var roleForm;
var action;
var mainTabs = null;
var funcTree = null;

$(document).ready(function(v) {
	leftGrid = nui.get("leftGrid");
	leftGrid.setUrl(leftGridUrl);
    roleForm = new nui.get("#roleForm");
    mainTabs = nui.get("mainTabs");

    funcTree = nui.get("funcTree");

    queryRole();
});

function queryRole() {
    var params = {};
    params.tenantId = 'default';

    leftGrid.load({
        params:params
    });  

    var db = new nui.DataBinding();
    db.bindForm("roleForm", leftGrid);    
}

function editRole(action) {
    var row = {};
    if (action != 'new') {
        var row = leftGrid.getSelected();
        if (!row) {
            alert("请选中一条记录");
            return;
        }   
    } else {
        var timestamp = new Date().getTime();
        var newRow = {roleName: "新角色", roleCode: timestamp};
        leftGrid.addRow(newRow, 0);

        leftGrid.deselectAll();
        leftGrid.select(newRow);
    }
    action = action;
    var title = action == 'new' ? '新增角色' : '修改角色';
    roleForm.setTitle(title);
    roleForm.showAtPos("center", "middle");   
}

function save() {
    var role = leftGrid.getChanges();
    var json = nui.encode(role);
    
    if (action == 'new') {
        role = {action: action};
    } else {            
        var row = leftGrid.getSelected();
        role.roleId = row.roleId;   
    }

    nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '保存中...'
    });

    nui.ajax({
        url:saveUrl,
        type:"post",
        data:JSON.stringify({
            capRole: role[0],
            token:token
        }),
        success:function(data)
        {
            nui.unmask();
            if (data.errCode == "S"){
                roleForm.hide();
                leftGrid.reload();  
            }else{
                nui.alert(data.errMsg||"保存失败");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            console.log(jqXHR.responseText);
            nui.unmask();
            nui.alert("网络出错");
        }
    });  
}

function deleteRole() {
    var row = leftGrid.getSelected();
    if (!row) {
        alert("请选中一条记录");
        return;
    }

    nui.confirm("确认删除吗？","提示",function(action) {
        if (action == "ok") {
             nui.mask({
                el : document.body,
                cls : 'mini-mask-loading',
                html : '保存中...'
            });

            nui.ajax({
                url:deleteRoleUrl,
                type:"post",
                data:JSON.stringify({
                    capRole: row,
                    token:token
                }),
                success:function(data)
                {
                    nui.unmask();
                    if (data.errCode == "S"){
                       leftGrid.reload();                   
                    }else{
                        nui.alert(data.errMsg||"保存失败");
                    }
                },
                error:function(jqXHR, textStatus, errorThrown){
                    console.log(jqXHR.responseText);
                    nui.unmask();
                    nui.alert("网络出错");
                }
            });            
        }
    });
    
}

function onCancel(e) {
    roleForm.hide();
}
function onLeftGridSelectionChanged() {
    var row = leftGrid.getSelected();

    //loadResAndUser(row);
}
function loadResAndUser(row) {
    if (row) {
        var tab = mainTabs.getActiveTab();
        if(tab.name == "billmain"){
            var data = rightGrid.getData();
            if(data && data.length <= 0){
                addNewRow(false);
            }   
        }

        basicInfoForm.setData(row);
        //bottomInfoForm.setData(row);
        nui.get("guestId").setText(row.guestFullName);

        var row = leftGrid.getSelected();
        if (row.auditSign == 1) {
            document.getElementById("basicInfoForm").disabled = true;
            setBtnable(false);
            setEditable(false);
        } else {
            document.getElementById("basicInfoForm").disabled = false;
            setBtnable(true);
            setEditable(true);
        }

        // 序列化入库主表信息，保存时判断主表信息有没有修改，没有修改则不需要保存
        var data = basicInfoForm.getData();
        data.orderAmt = data.orderAmt||0;
        formJson = nui.encode(data);

        // 加载采购订单明细表信息
        var mainId = row.id;
        if(!mainId){
            mainId = -1;
        }
        var auditSign = data.auditSign||0;
        loadRightGridData(mainId, auditSign);
    } else {
    }

}


function setRoleId(){
    //var row = leftGrid.getSelected();
    var roleId = 0;
    return {"roleId":roleId};
}

function saveTree(){
    var funcDatas = funcTree.getCheckedNodes();
    var leafNodes = [];
    for(var cursor = 0; cursor < funcDatas.length; cursor++){
        var node = funcDatas[cursor];
        if(funcTree.isLeaf(node)){
            leafNodes.push(node);
        }
    }
    //var row = leftGrid.getSelected();
    var roleId = 0;
    var json = nui.encode({functions:leafNodes,roleId:roleId});
    $.ajax({
        url: "org.gocom.components.coframe.framework.FunctionAuth.saveFunctionAuths.biz.ext",
        type: 'POST',
        data: json,
        cache: false,
        contentType:'text/json',
        success: function (text) {
            if(text.data){
                nui.alert("权限设置成功");
            }else{
                nui.alert("权限设置失败");
            }
        },
        error: function () {
            nui.alert("权限设置失败");
        }
    });
}

function search(){
    var filtedNodes = [];
    var key = nui.get("key").getValue();
    if(key == ""){
        funcTree.clearFilter();
    }else{
        var rootNode = funcTree.getRootNode();
        funcTree.cascadeChild(
            rootNode,
            function(node){
                var pNode = funcTree.getParentNode(node);
                var nofind = true;
                for(i = 0; i < filtedNodes.length; i++){
                    if(filtedNodes[i] == pNode.id){
                        filtedNodes.push(node.id);
                        nofind = false;
                        break;
                    }
                }
                if(nofind){
                    var text = node.text ? node.text.toLowerCase() : "";
                    if(text.indexOf(key) != -1){
                        filtedNodes.push(node.id);
                    }
                }
            }
        );
        funcTree.filter(function(node){
            for(i = 0; i < filtedNodes.length; i++){
                if(filtedNodes[i] == node.id){
                    return true;
                }
            }
        });
    }
}

function expandAll(){
    funcTree.expandAll();
}

function collapseAll(){
    funcTree.collapseAll();
}