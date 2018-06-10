/**
 * Created by steven on 2018/1/31.
 */

var baseUrl = apiPath + sysApi + "/";
var leftGridUrl = baseUrl + "com.hsapi.system.employee.roleRight.queryRole.biz.ext";
var saveUrl = baseUrl + "com.hsapi.system.employee.roleRight.saveRoles.biz.ext";

var leftGrid;
var roleForm;
var action;

$(document).ready(function(v) {
	leftGrid = nui.get("leftGrid");
	leftGrid.setUrl(leftGridUrl);
    roleForm = new nui.get("#roleForm");

    queryRole();
});

function queryRole() {
    var params = {};
    params.tenantId = 'default';

    leftGrid.load(params,function(){
    },function(){
        nui.alert("角色下载失败！");
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
            capRole: role,
            //tenantId: 'default',
            token:token
        }),
        success:function(data)
        {
            nui.unmask();
            if (data.errCode == "S"){
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
    roleForm.hide();
    leftGrid.reload();    
}

function onCancel(e) {
    roleForm.hide();
}