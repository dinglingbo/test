var saveUrl = apiPath + saleApi + "/com.hsapi.sales.svr.base.addCsbPDI.biz.ext";
var gridUrl = apiPath + saleApi + "/com.hsapi.sales.svr.base.searchCsbPDI.biz.ext";
var isDisArr = [{id:'',text:'全部'},{id:0,text:'启用'},{id:1,text:'禁用'}];
var checkList = [{id:0,name:"勾选"},{id:1,name:"描述"}];
var statusList = [{id:0,name:"启用"},{id:1,name:"禁用"}];
var statusHash = {0:"启用",1:"禁用"};
var dgGrid = null;
var pdiTypeIdList = [];
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
            case "pdiTypeId":
                    e.cellHtml = setColVal('pdiTypeId', 'customid', 'name', e.value);
				break;
            default:
                break;
        }
	});
    initDicts({
        pdiTypeId:'10361'//pdi检测类型
    }, function () {
            pdiTypeIdList = nui.get("pdiTypeId").getData();
    });
	// dgGrid.on("cellbeginedit",function(e){
    //     var field=e.field; 
    //     var editor = e.editor;
	// 	var row = e.row;
    //     if(field == 'pdiTypeId'){
	// 		editor.setData(pdiTypeIdList);
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
        code: nui.get('code').value,
        pdiTypeId: nui.get('pdiTypeId').value,
        isDisabled: nui.get('isDisabled').value,
    };
    dgGrid.load({ params: params });
}

function addShareUrl(){
    var newRow = {isDisabled:0,isEnableCheck:0};
    dgGrid.addRow(newRow);
}

// function save(){
// 	var value = checkName();
// 	if(!value){
// 		parent.showMsg(nullMsg,"W");
// 		return;
// 	}
//     var addList = dgGrid.getChanges("added");
// 	var updateList = dgGrid.getChanges("modified");

//     nui.mask({
// 		el : document.body,
// 		cls : 'mini-mask-loading',
// 		html : '保存中...'
// 	});

// 	nui.ajax({
// 		url : saveUrl,
// 		type : "post",
// 		data : JSON.stringify({
// 			addList : addList,
// 			updateList : updateList,
// 			token: token
// 		}),
// 		success : function(data) {
// 			nui.unmask(document.body);
// 			data = data || {};
// 			if (data.errCode == "S") {
// 				parent.showMsg("保存成功!","S");
// 				//doSearch();
// 			} else {
// 				parent.showMsg(data.errMsg || "保存失败!","E");
//             }
//             dgGrid.load();
// 		},
// 		error : function(jqXHR, textStatus, errorThrown) {
// 			// nui.alert(jqXHR.responseText);
// 			console.log(jqXHR.responseText);
// 		}
// 	});

// }


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

function edit(e) {
    var tit = null;
    var row = null;
    if (e == 1) {
        tit = '新增';
    } else {
        tit = '修改';
        row = dgGrid.getSelected();
        if (!row) {
            showMsg("请先选中需要修改的数据", 'W');
            return;
        }
    }
    nui.open({
        url: webPath + contextPath + '/sales/base/PDI_check_det.jsp',
        title: tit,
        width: 500,
        height: 300,
        onload: function () {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.SetData(row);
        },
        ondestroy: function (action) {
            dgGrid.reload();
        }
    });
} 