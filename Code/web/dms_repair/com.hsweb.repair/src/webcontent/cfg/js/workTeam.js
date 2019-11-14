var baseUrl = apiPath + sysApi + "/";;
//var gridUrl = baseUrl + "com.hsapi.system.confi.paramSet.getbusinessSort.biz.ext";
var gridUrl = apiPath + repairApi + "/com.hsapi.repair.baseData.team.queryWorkTeam.biz.ext"
//var s=["维修","保养","美容","钣喷漆","轮胎","洗车","精品","零售","其他"];
var statusList = [{id:0,name:"启用"},{id:1,name:"禁用"}];
var statusHash = {0:"启用",1:"禁用"};
var dgGrid;
$(document).ready(function(v) {
	dgGrid=nui.get("dgGrid");
	dgGrid.setUrl(gridUrl);
	var params = {sortField:'id',sortOrder:'asc'};
	dgGrid.load({params:params,token:token});
	
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
		if(row.orgid){		
			if(row.orgid != currOrgId){
				e.cancel = true;
			}
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
			parent.showMsg("此分类不能删除!","W");
			return;
		}
		if(row.id){
			parent.showMsg("此分类不能删除,可修改为禁用!","W");
			return;
		}
	}
}
var saveUrl = apiPath + repairApi + "/com.hsapi.repair.baseData.team.saveWorkTeam.biz.ext";
function save(){
	var value = checkName();
	if(!value){
		parent.showMsg("名称不能为空!","W");
		return;
	}
    var addList = dgGrid.getChanges("added");
	var updateList = dgGrid.getChanges("modified");
	var deleteList = dgGrid.getChanges("removed");

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
			deleteList : deleteList,
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
    var params = {sortField:'id',sortOrder:'asc'};
	dgGrid.load({params:params,token:token});
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