/**
 * Created by Administrator on 2018/1/24.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var roleGrid = null;
var deductMemGrid = null;
var deductParamsGrid = null;
var advancedMemSetWin = null;
var pname = null;
var memName = null;
var memForm = null
var roleUrl = baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.queryDeductRole.biz.ext";
var deductMemUrl = baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.queryDeductMember.biz.ext";
var deductParamsUrl = baseUrl + "/com.hsapi.cloud.part.baseDataCrud.crud.queryDeductParams.biz.ext";
var frole = {};
var typehash = {
	"1":"按销售金额提成",
	"2":"按销售毛利提成"
}
var typeList = [{id:"1",name:"按销售金额提成"},{id:"2",name:"按销售毛利提成"}];
$(document).ready(function(v)
{
	roleGrid = nui.get("roleGrid");
	roleGrid.setUrl(roleUrl);
	roleGrid.on("beforeload",function(e){
        e.data.token = token;
    });
	
	pname = nui.get("pname");
	memName = nui.get("memName");
	memForm = new nui.Form("#memForm");
	
	deductMemGrid = nui.get("deductMemGrid");
	deductMemGrid.setUrl(deductMemUrl);
	deductMemGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    
	deductParamsGrid = nui.get("deductParamsGrid");
	deductParamsGrid.setUrl(deductParamsUrl);
    
	deductParamsGrid.on("beforeload",function(e){
        e.data.token = token;
    });
	
	deductParamsGrid.on("drawcell",function(e){
		var field = e.field;
		if(field == "type") {
			e.cellHtml = typehash[e.value];
		}
	});
	
	deductParamsGrid.on("cellcommitedit",function(e){
		var editor = e.editor;
		var record = e.record;
		var row = e.row;
		
		editor.validate();
		if (editor.isValid() == false) {
			showMsg("请输入数字!","W");
			e.cancel = true;
		}
	});
	
	roleGrid.on("selectionchanged",function(e) {
		var row = e.selected;
		var roleId = row.id;
		if(roleId) {
			frole.id = roleId;
			frole.name = name;
			var params = {
				roleId: roleId
			};
			deductMemGrid.load({
				token:token,
				params:params
			});
		}else {
			deductMemGrid.setData([]);
			deductParamsGrid.setData([]);
			frole.id = null;
			frole.name = null;
		}
	});
	
	deductMemGrid.on("selectionchanged",function(e) {
		var row = e.selected;
		var deductMemId = row.id;
		var params = {
			deductMemId: deductMemId
		}
		deductParamsGrid.load({
			token:token,
			params:params
		})
		
	});
	
	advancedMemSetWin = nui.get("advancedMemSetWin");
    
	roleGrid.load();
});
function addDeductMem() {
	if(!frole.id) {
		showMsg("请先选择角色，再添加成员");
		return;
	}
	
	var row = deductMemGrid.getSelected();
	if(row && row.id) {
		document.getElementById("t").innerHTML = "当前角色：" + frole.name||"";
		var prow = findParentRow(row.pid);
		var data = {
			pid: row.pid,
			roleId: row.roleId,
			pname: prow.name||""
		}
		memForm.setData(data);
	}else {
		var data = {
			pid: null,
			roleId: frole.id,
			pname: null
		}
		memForm.setData(data);
	}
	
	advancedMemSetWin.show();
	memName.focus();
}
function addDeductMemSub() {
	if(!frole.id) {
		showMsg("请先选择角色，再添加成员");
		return;
	}
	
	var row = deductMemGrid.getSelected();
	if(row && row.id) {
		document.getElementById("t").innerHTML = "当前角色：" + frole.name||"";
		var prow = findParentRow(row.id);
		var data = {
			pid: row.id,
			roleId: row.roleId,
			pname: prow.name||""
		}
		memForm.setData(data);
	}else {
		var data = {
			pid: null,
			roleId: frole.id,
			pname: null
		}
		memForm.setData(data);
	}
	
	advancedMemSetWin.show();
	memName.focus();
}

function cancel() {
	document.getElementById("t").innerHTML = "当前角色：" ;
	memForm.setData({});
	advancedMemSetWin.hide();
}
function findParentRow(id) {
	var row = null;
	row = deductMemGrid.findRow(function(record){
		if(record.id==id) return true;
	});
	
	return row||{};
}

var saveDeductMemUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.saveDeductMember.biz.ext";
function saveDeductMem() {
	var row = memForm.getData();
	if(!row.memName) {
		showMsg("请填写名称","W");
		return;
	}
	var data = {
		roleId: row.roleId,
		pid: row.pid,
		name: row.memName
	}
	nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
	});
    nui.ajax({
        url:saveDeductMemUrl,
        type:"post",
        data:JSON.stringify({
            data:data,
            token:token
        }),
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                showMsg("新增成员成功","S");
            }
            else{
                showMsg("新增成员失败","W");
            }
            
            cancel();
            var params = {
				roleId: frole.id
			};
			deductMemGrid.load({
				token:token,
				params:params
			});
        },
        error:function(jqXHR, textStatus, errorThrown){
        	nui.unmask();
            console.log(jqXHR.responseText);
        }
    });
}

function freshDeductMem() {
	if(!frole.id) return;
	var params = {
		roleId: frole.id
	};
	deductMemGrid.load({
		token:token,
		params:params
	});
}

function addRole() {
	var rowCheck = roleGrid.findRow(function(record) {
		if(!record.name) return true;
	});
	if(rowCheck) {
		showMsg("存在角色名称为空的数据，不能再新增");
		return;
	}
	var row = {};
	roleGrid.addRow(row);
}

function checkName(){
	var rows = roleGrid.findRows(function(row) {
		if (row.name == null || row.name == "" || row.name == undefined)
			return true;
	});
	if(rows && rows.length>0){
		return false;
	}

	return true;
}

var saveRoleUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.saveDeductRole.biz.ext";
function saveRole() {
	var value = checkName();
	if(!value){
		showMsg("角色名称不能为空!","W");
		return;
	}
    var addList = roleGrid.getChanges("added");
	var updateList = roleGrid.getChanges("modified");
	
	nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
	});
    nui.ajax({
        url:saveRoleUrl,
        type:"post",
        data:JSON.stringify({
        	addList:addList,
        	updateList:updateList,
            token:token
        }),
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                showMsg("保存成功","S");
            }
            else{
                showMsg("保存失败","W");
            }
            
            roleGrid.reload();
        },
        error:function(jqXHR, textStatus, errorThrown){
        	nui.unmask();
            console.log(jqXHR.responseText);
        }
    });
}

function addParams() {
	var row = deductMemGrid.getSelected();
	if(!row) {
		showMsg("请先选择成员，再设置提成参数");
		return;
	}
	var rowCheck = deductParamsGrid.findRow(function(record) {
		if(!record.type || !record.deductRate) return true;
	});
	if(rowCheck) {
		showMsg("存在参数设置有问题的数据，不能再新增");
		return;
	}
	var row = {
		type: 1,
		deductMemId: row.id,
		creator: currUserName,
		createDate: now
	};
	deductParamsGrid.addRow(row);
}

function checkParams(){
	var rows = deductParamsGrid.findRows(function(row) {
		if (row.type == null || row.type == "" || row.type == undefined)
			return true;
	});
	if(rows && rows.length>0){
		return false;
	}

	return true;
}

var saveParamsUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.saveDeductParams.biz.ext";
function saveParams() {
	var value = checkParams();
	if(!value){
		showMsg("提成参数设置有误","W");
		return;
	}
    var addList = deductParamsGrid.getChanges("added");
	var updateList = deductParamsGrid.getChanges("modified");
	
	nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
	});
    nui.ajax({
        url:saveParamsUrl,
        type:"post",
        data:JSON.stringify({
        	addList:addList,
        	updateList:updateList,
            token:token
        }),
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                showMsg("保存成功","S");
            }
            else{
                showMsg("保存失败","W");
            }
            
            roleGrid.reload();
        },
        error:function(jqXHR, textStatus, errorThrown){
        	nui.unmask();
            console.log(jqXHR.responseText);
        }
    });
}



