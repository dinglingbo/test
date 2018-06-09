/**
 * Created by steven on 2018/1/31.
 */

var baseUrl = apiPath + sysApi + "/";
var leftGridUrl = baseUrl + "com.hsapi.system.employee.roleRight.queryRole.biz.ext";
var saveUrl = baseUrl + "com.hsapi.system.employee.roleRight.saveRole.biz.ext";

var leftGrid;
var roleForm;
var action;

$(document).ready(function(v) {
	leftGrid = nui.get("leftGrid");
	leftGrid.setUrl(leftGridUrl);
    roleForm = nui.get("roleForm");

    queryRole();
});

function queryRole() {
    var params = {};
    params.tenantId = 'default';

    leftGrid.load(params,function(){
    },function(){
        nui.alert("角色下载失败！");
    });
}

function editRole(action) {
    action = action;
    var title = action == 'new' ? '新增角色' : '修改角色';
    roleForm.setTitle(title);
    roleForm.showAtPos("center", "middle");   
}

function save() {
    var role = {};
    
    if (action == 'new') {
        role = {action: action};
    } else {
        var row = leftGrid.getSelected();
        if (!row) {
            alert("请选中一条记录");
            return;
        }
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
            tenantId: 'default',
            token:token
        }),
        success:function(data)
        {
            nui.unmask();
            callback && callback(data);
        },
        error:function(jqXHR, textStatus, errorThrown){
            console.log(jqXHR.responseText);
            nui.alert("保存失败！");
        }
    });
    roleForm.hide();
    leftGrid.reload();    
}

function onCancel(e) {
    roleForm.hide();
}