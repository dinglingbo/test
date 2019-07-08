/**
 * Created by steven on 2018/1/31.
 */

var baseUrl = apiPath + sysApi + "/";
var leftGridUrl = baseUrl + "com.primeton.tenant.comTenant.comTenantQueryBySql.biz.ext";
var saveUrl = baseUrl + "com.hsapi.system.tenant.role.saveRole.biz.ext";
var deleteRoleUrl = baseUrl + "com.hsapi.system.tenant.role.deleteRole.biz.ext";

var leftGrid;
var roleForm;
var action;
var mainTabs = null;

$(document).ready(function(v) {
	leftGrid = nui.get("leftGrid");
	leftGrid.setUrl(leftGridUrl);
    roleForm = new nui.get("#roleForm");
    mainTabs = nui.get("mainTabs");

	queryTenant();
});

function queryTenant() {
    var params = {};
    params.isDisabled = 0;
    var tenantId = nui.get("tenantId").getValue();
    if(tenantId){
    	params.tenantId = tenantId;
    }
    leftGrid.load({
        params:params,
        token:token
    });  

    /*var db = new nui.DataBinding();
    db.bindForm("roleForm", leftGrid);  */  
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
                showMsg(data.errMsg||"保存失败","W");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            console.log(jqXHR.responseText);
            nui.unmask();
            showMsg("网络出错","W");
        }
    });  
}

function deleteRole() {
    var row = leftGrid.getSelected();
    if (!row) {
        showMsg("请选中一条记录","W");
        return;
    }

    if(row && row.roleId){
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
                            showMsg(data.errMsg||"保存失败","W");
                        }
                    },
                    error:function(jqXHR, textStatus, errorThrown){
                        console.log(jqXHR.responseText);
                        nui.unmask();
                        showMsg("网络出错","W");
                    }
                });            
            }
        });
    }else{
        leftGrid.removeRow(row);
    }

    
}

function onCancel(e) {
    roleForm.hide();
}
function onLeftGridSelectionChanged() {
    var row = leftGrid.getSelected();

    loadResAndUser(row);
}
function loadResAndUser(row) {
    if (row) {
    	var tenantId = row.tenantId||0;
    	var tenantType = row.tenantType;
        var tab = mainTabs.getActiveTab();
        if(tab.name == "role"){
        	mainTabs.loadTab(webPath + defDomin + "/common/function/tenant_role_auth.jsp?tenantId="+tenantId+"&tenantType="+tenantType+"&token="+token, tab);
        }else if(tab.name == "resauth"){
            mainTabs.loadTab(webPath + defDomin + "/common/function/employee_auth.jsp?roleId="+roleId+"&token="+token, tab);   
        }else if(tab.name == "roleResauth"){
            mainTabs.loadTab(webPath + defDomin + "/common/function/app_role_auth.jsp?roleId="+roleId+"&roleCode="+roleCode+"&roleName="+roleName+"&tenantId="+tenantId+"&token="+token, tab);   
        }
    } else {
    	//showMsg("请选择一个租户","W");
    }

}
function ontopTabChanged(e){
    var tab = e.tab;
    var name = tab.name;
    var row = leftGrid.getSelected();
    if(!row) return;
    var tenantId = row.tenantId||0;
    var tenantType = row.tenantType;
    if(name == "role"){
    	mainTabs.loadTab(webPath + defDomin + "/common/function/tenant_role_auth.jsp?tenantId="+tenantId+"&tenantType="+tenantType+"&token="+token, tab);
    }else if(name == "resauth"){
        mainTabs.loadTab(webPath + defDomin + "/common/function/employee_auth.jsp?roleId="+roleId+"&token="+token, tab);   
    }else if(name == "roleResauth"){
        mainTabs.loadTab(webPath + defDomin + "/common/function/app_role_auth.jsp?roleId="+roleId+"&roleCode="+roleCode+"&roleName="+roleName+"&tenantId="+tenantId+"&token="+token, tab);   
    }
    
}
