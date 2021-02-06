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
//租户类型：1，汽修店，2汽配店，3变速箱维修店，4汽贸店，5汽贸汽修综合店
var tenantTypeHash = {
		"1":"汽修店",
		"2":"汽配店",
		"3":"变速箱维修店",
		"4":"汽贸店",
		"5":"汽贸汽修综合店"
};
$(document).ready(function(v) {
	leftGrid = nui.get("leftGrid");
	leftGrid.setUrl(leftGridUrl);
    roleForm = new nui.get("#roleForm");
    mainTabs = nui.get("mainTabs");
    leftGrid.on("drawcell", function (e) {
       var record = e.record;
       var uid = record._uid;
       if(e.field=="tenantType"){
          e.cellHtml = tenantTypeHash[e.value];
       }
    }); 
	queryTenant();
});

function queryTenant() {
    var params = {};
    if(isDisabled != 2){
    	params.isDisabled = isDisabled;
    }
    if(tenantType != 6){
    	params.tenantType = tenantType;
    }
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
            mainTabs.loadTab(webPath + defDomin + "/common/function/tenant_function.jsp?tenantId="+tenantId+"&tenantType="+tenantType+"&token="+token, tab);   
        }else if(tab.name == "roleResauth"){
            mainTabs.loadTab(webPath + defDomin + "/common/function/role_right_mgrt.jsp?tenantId="+tenantId+"&tenantType="+tenantType+"&token="+token, tab);   
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
        mainTabs.loadTab(webPath + defDomin + "/common/function/tenant_function.jsp?tenantId="+tenantId+"&tenantType="+tenantType+"&token="+token, tab);   
    }else if(name == "roleResauth"){
    	 mainTabs.loadTab(webPath + defDomin + "/common/function/role_right_mgrt.jsp?tenantId="+tenantId+"&tenantType="+tenantType+"&token="+token, tab);   
    }
    
}


var isDisabled = 0;
function quickSearch(type) {
   // var params = getSearchParam();
    var queryname = "在用";
    switch (type) {
        case 1:
            //params.isDisabled = 1;
            queryname = "停用";
            isDisabled = 1;
            break;
        case 0:
        	//params.isDisabled =0;
        	isDisabled = 0;
            queryname = "在用";
            break;
        case 2:
            //queryname = "所有";
            isDisabled = 2;
            break;
        default:
            break;
    }
    var menunamedate = nui.get("menunamedate");
    menunamedate.setText(queryname);
    queryTenant();
}

//1，汽修店，2汽配店，3变速箱维修店，4汽贸店，5汽贸汽修综合店
var tenantType = 6;
function quickSearch1(type) {
    var queryname = "所有";
    switch (type) {
        case 1:
            //params.tenantType = 1;
            queryname = "汽修";
            tenantType = 1;
            break;
        case 2:
        	//params.tenantType =1;
        	tenantType = 2;
            queryname = "汽配";
            break;
        case 3:
        	//params.tenantType =3;
        	tenantType = 3;
            queryname = "变速箱";
            break;
        case 4:
        	//params.tenantType =4;
        	tenantType = 4;
            queryname = "汽贸";
            break;
        case 5:
        	//params.tenantType =5;
        	tenantType = 5;
            queryname = "汽修汽贸";
            break;
        case 6:
            queryname = "所有";
            tenantType = 6;
            break;
        default:
            break;
    }
    var menunamedate = nui.get("menunamestatus");
    menunamedate.setText(queryname);
    queryTenant();
}
