var baseUrl = apiPath + sysApi + "/";;
var gridUrl = apiPath + sysApi + "/com.hsapi.system.dict.dictMgr.queryDict.biz.ext"
var statusList = [{id:0,name:"启用"},{id:1,name:"禁用"}];
var statusHash = {0:"启用",1:"禁用"};
var dgGrid;
$(document).ready(function(v) {
	dgGrid=nui.get("dgGrid");
	dgGrid.setUrl(gridUrl);
	var params = {
		tenantIds:currTenantId,
		dictid:"DDT20130703000075",
		fromDb:true,
		token:token
	};
	dgGrid.load(params);
	//dgGrid.load({sortField:"record_date",sortOrder:"asc",orgids:currOrgId,dictid:"DDT20130703000075",fromDb:true,token:token});
	
	dgGrid.on("drawcell",function(e){
        switch (e.field) {
            case "isDisabled":
                if (statusHash[e.value]) {
                    e.cellHtml = statusHash[e.value] || "";
                } else {
                    e.cellHtml = "";
                }
				break;
			case "operateBtn":
				e.cellHtml = '<span class="fa fa-plus" onClick="javascript:addR()" title="添加行">&nbsp;&nbsp;</span>'+
							 ' <span class="fa fa-close" onClick="javascript:deleteR()" title="删除行"></span>';
                break;
            default:
                break;
        }
	});
	
	dgGrid.on("cellbeginedit",function(e){
		var field=e.field; 
		var row = e.row;
        if(row.orgid != currOrgId){
			e.cancel = true;
		}
	});
});
function addR(){
    var newRow = {isDisabled:0};
    dgGrid.addRow(newRow);
}
function deleteR(){
	var row = dgGrid.getSelected();
	if(row){
		if(row.orgid == 0){
			parent.showMsg("此来源不能删除!","W");
			return;
		}
		if(row.id){
			parent.showMsg("此来源不能删除,可修改为禁用!","W");
			return;
		}
	}
}
var saveUrl = apiPath + sysApi + "/com.hsapi.system.dict.dictMgr.saveDictList.biz.ext";
function save(){
	var value = checkName();
	if(!value){
		parent.showMsg("客户来源不能为空!","W");
		return;
	}
    var addList = dgGrid.getChanges("added");
	var updateList = dgGrid.getChanges("modified");

    nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '保存中...'
	});

	nui.ajax({
		url : saveUrl,
		type : "post",
		data : JSON.stringify({
			addList : addList,
			updateList : updateList,
			dictid : 'DDT20130703000075',
			token: token
		}),
		success : function(data) {
			nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
				parent.showMsg("保存成功!","S");
				doSearch();
			} else {
				parent.showMsg(data.errMsg || "保存失败!","E");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});

}
function doSearch()
{
	var params = {
		params:{
			sortField:"record_date",
			sortOrder:"asc"
		},
		orgids:currOrgId,
		dictid:"DDT20130703000075",
		fromDb:true,
		token:token
	};
	dgGrid.load(params);
}

function checkName(){
	var rows = dgGrid.findRows(function(row) {
		if (row.name == null || row.name == "" || row.name == undefined)
			return true;
	});
	if(rows && rows.length>0){
		return false;
	}

	return true;
}