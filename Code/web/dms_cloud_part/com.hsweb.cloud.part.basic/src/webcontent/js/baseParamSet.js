var baseUrl = apiPath + sysApi + "/";
var gridUrl = apiPath + sysApi + "/com.hsapi.system.dict.dictMgr.queryDict.biz.ext";
var saveUrl = apiPath + sysApi + "/com.hsapi.system.dict.dictMgr.saveDictList.biz.ext";
var statusList = [{id:0,name:"启用"},{id:1,name:"禁用"}];
var statusHash = { 0: "启用", 1: "禁用" };
var mainTabs = null;
var dgGrid = null;
var DICTID = " ";//
var nullMsg = "";

$(document).ready(function() {
    mainTabs = nui.get("mainTabs");
    dgGrid = nui.get("dgGrid");
    dgGrid.setUrl(gridUrl);


    mainTabs.on("activechanged",function(e){
        showTabInfo();
    });

    dgGrid.on("drawcell",function(e){
        switch (e.field) {
            case "isDisabled":
                if (statusHash[e.value]) {
                    e.cellHtml = statusHash[e.value] || "";
                } else {
                    e.cellHtml = "";
                }
				break;
			// case "operateBtn":
			// 	e.cellHtml = '<span class="fa fa-plus" onClick="javascript:addR()" title="添加行">&nbsp;&nbsp;</span>';
			// 				 //' <span class="fa fa-close" onClick="javascript:deleteR()" title="删除行"></span>';
            //     break;
            default:
                break;
        }
    });
    	dgGrid.on("cellbeginedit",function(e){
		var field=e.field; 
		var row = e.row;
        if(row.orgid == 0){
			e.cancel = true;
		}
	});

});

function doSearch()
{
	var params = {
		params:{
			sortField:"record_date",
			sortOrder:"asc"
		},
		tenantId:currTenantId,
		dictid:DICTID,
		fromDb:true,
		token:token
	};
	dgGrid.load(params);
}


function addShareUrl(){
    var newRow = {isDisabled:0};
    dgGrid.addRow(newRow);
}

// function del() {
//     var row = dgGrid.getSelected();
//     if (!row) {
//         showMsg('请先选中需要删除的数据', 'W');
//         return;
//     }
//     if (row.name) {
//         nui.confirm('是否删除【' + row.name + '】', '删除', function (action) {
//             if (action == 'ok') {
//                 dgGrid.removeRow(row);
//             } else {
//                 return;
//             }
//         });
//     } else {
//         dgGrid.removeRow(row);
//     }
// }

function save(){
    var addList = dgGrid.getChanges("added");
    var updateList = dgGrid.getChanges("modified");
    for (var k = 0; k < updateList.length; k++) {
        var uptemp = updateList[k];
        if (uptemp.name == null || uptemp.name == "" || uptemp.name == undefined) {
            parent.showMsg('修改行的'+nullMsg,"W");
            return;
        }
    }
    var addArr = [];
    for (var i = 0; i < addList.length; i++) {
        var temp = addList[i];
        if (temp.name) {
            addArr.push(temp)
        }
    }
    nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '保存中...'
	});

	nui.ajax({
		url : saveUrl,
		type : "post",
		data : JSON.stringify({
			addList : addArr,
			updateList : updateList,
			dictid : DICTID,
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


// function checkName(){
// 	var rows = dgGrid.findRows(function(row) {
// 		if (row.name == null || row.name == "" || row.name == undefined)
// 			return true;
// 	});
// 	if(rows && rows.length>0){
// 		return false;
// 	}
// 	return true;
// }

//hideColumn ( column )		隐藏列	
//showColumn ( column )

function showTabInfo(){
	var tab = mainTabs.getActiveTab();
	var name = tab.name;
    var url = tab.url;
    dgGrid.hideColumn('property1');
    dgGrid.hideColumn('property2');
    dgGrid.hideColumn('property3');
    var col = dgGrid.getColumn('name');
    var tit = tab.title;
    DICTID = '';
	switch (name)
    {
        case "productClass"://产品线分类
            DICTID = '10441';
            tit = '产品线分类';
            break;
        case "maintainProClass"://维修性质分类
            DICTID = '10442';
            tit = '维修性质分类';
            break;
        default:
            break;
    }
    nullMsg = tit + '不能为空';
    doSearch();
    dgGrid.updateColumn(col, { header: tit});
}