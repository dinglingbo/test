var saveUrl = apiPath + saleApi + "/sales.base.addCsbPDI.biz.ext";
var gridUrl = apiPath + saleApi + "/sales.base.searchCsbPDI.biz.ext"
var checkList = [{id:0,name:"勾选"},{id:1,name:"描述"}];
var statusList = [{id:0,name:"启用"},{id:1,name:"禁用"}];
var statusHash = {0:"启用",1:"禁用"};
var dgGrid = null;
var nullMsg = "返利政策不能为空!";
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
            case "isEnableCheck":
                    e.cellHtml = (e.value == 0?'勾选':'描述');
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
        code: nui.get('code').value
    };
    dgGrid.load({ params: params });
}

function addShareUrl(){
    var newRow = {isDisabled:0,isEnableCheck:0};
    dgGrid.addRow(newRow);
}

function save(){
	var value = checkName();
	if(!value){
		parent.showMsg(nullMsg,"W");
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