var saveUrl = apiPath + saleApi + "/com.hsapi.sales.svr.base.addCsbGift.biz.ext";
var gridUrl = apiPath + saleApi + "/com.hsapi.sales.svr.base.searchCsbGift.biz.ext";
var isDisArr = [{id:'',text:'全部'},{id:0,text:'启用'},{id:1,text:'禁用'}];
var statusList = [{id:0,name:"启用"},{id:1,name:"禁用"}];
var statusHash = {0:"启用",1:"禁用"};
var dgGrid = null;
var nullMsg = "精品名称不能为空!";
$(document).ready(function(v) {
	dgGrid=nui.get("dgGrid");
    dgGrid.setUrl(gridUrl);
    dgGrid.load();
    //doSearch();

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
				e.cellHtml = '<span class="fa fa-plus" onClick="javascript:addR()" title="添加行">&nbsp;&nbsp;</span>';
							 //' <span class="fa fa-close" onClick="javascript:deleteR()" title="删除行"></span>';
                break;
            default:
                break;
        }
	});
	
	// dgGrid.on("cellbeginedit",function(e){
	// 	var field=e.field; 
	// 	var row = e.row;
    //     if(row.orgid == 0){
	// 		e.cancel = true;
	// 	}
    // });
	// dgGrid.on("cellcommitedit",function(e){
	// 	var field = e.field; 
    //     var value = e.value; 
    //     var editor = e.editor;
    //     if (field == 'rebateAmt') {
    //         if (editor.isValid() == false) {
    //             showMsg("请输入有效数字！","W");
    //             e.cancel = true;
    //         }
    //     }

    // });
    
});

function search() {
    var params = {
        name: nui.get('name').value,
        isDisabled: nui.get('isDisabled').value
    };
    dgGrid.load({ params: params });
}

function addShareUrl(){
    var newRow = {isDisabled:0};
    dgGrid.addRow(newRow);
}

function del() {
    var row = dgGrid.getSelected();
    if (!row) {
        showMsg('请先选中需要删除的数据', 'W');
        return;
    }
    if (row.name) {
        nui.confirm('是否删除【' + row.name+'】', '删除',function (action) {
            if (action == 'ok') {
                dgGrid.removeRow(row);
            } else {
                return;
            }
        })
    } else {
        dgGrid.removeRow(row);
    }
}

function save() {
	var value = checkName();
	if(!value){
        parent.showMsg(nullMsg,"W");
		return;
	}
    var addList = dgGrid.getChanges("added");
	var updateList = dgGrid.getChanges("modified");
    var delArr = dgGrid.getChanges('removed');

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
            updateList: updateList,
            removeList:delArr,
			token: token
		}),
		success : function(data) {
			nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
				parent.showMsg("保存成功!","S");
				//doSearch();
			} else {
				parent.showMsg(data.errMsg || "保存失败!","E");
            }
            dgGrid.load();
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});

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