var gridUrl = apiPath + sysApi + "/com.hsapi.system.tenant.carCoin.queryCarCoin.biz.ext";
var saveCarCoinUrl = apiPath + sysApi + "/com.hsapi.system.tenant.carCoin.saveCarCoin.biz.ext";
var statusList = [{id:0,name:"启用"},{id:1,name:"禁用"}];
var statusHash = {0:"启用",1:"禁用"};
var dgGrid = null;
$(document).ready(function(v) {
	dgGrid=nui.get("dgGrid");
	dgGrid.setUrl(gridUrl);
	loadCarCoin();
	
	dgGrid.on("drawcell",function(e){
        switch (e.field) {
            case "status":
                if (statusHash[e.value]) {
                    e.cellHtml = statusHash[e.value] || "";
                } else {
                    e.cellHtml = "";
                }
				break;
			case "operateBtn":
				e.cellHtml = '<span class="fa fa-arrow-up" onClick="javascript:upRow()" title="上移行">&nbsp;&nbsp;&nbsp;&nbsp;</span>'+
							 ' <span class="fa fa-arrow-down" onClick="javascript:downRow()" title="下移行"></span>';
                break;
            default:
                break;
        }
	});
	
//	dgGrid.on("cellbeginedit",function(e){
//		var field=e.field; 
//		var row = e.row;
//        if(row.orgid == 0){
//			e.cancel = true;
//		}
//	});
});
function addR(){
  var newRow = {status:0};
    dgGrid.addRow(newRow);

}

function save(){
    var carCoin = dgGrid.getData();
	for(var i = 0;i<carCoin.length;i++){
		carCoin[i].orderNumber = i;
		if(carCoin[i].salePrice==null||carCoin[i].rechargeCoin==null||carCoin[i].giveCoin==null){
			showMsg("请规范第"+i+"行数据！","W");
		}
	}
    nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '保存中...'
	});

	nui.ajax({
		url : saveCarCoinUrl,
		type : "post",
		data : JSON.stringify({
			carCoin : carCoin,
			token: token
		}),
		success : function(data) {
			nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
				parent.showMsg("保存成功!","S");
				loadCarCoin();
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



//提交单元格编辑数据前激发
function onCellCommitEdit(e) {
    var editor = e.editor;
    var record = e.record;
    var row = e.row;

    editor.validate();
    if (editor.isValid() == false) {
		parent.showMsg("请输入数字!","W");
        e.cancel = true;
    } 
}
function upRow(){
	var row = dgGrid.getSelected();
	var index = dgGrid.indexOf(row);
	if(index!=0){		
		dgGrid.moveRow(row,index-1);
	}else{
		showMsg("已到顶部！","W");
	}
}
function downRow(){
	var row = dgGrid.getSelected();
	var data = dgGrid.getData();
	var index = dgGrid.indexOf(row);
	if(index!=data.length-1){		
		dgGrid.moveRow(row,index+2);
	}else{
		showMsg("已到底部！","W");
	}	
}

function loadCarCoin(){
	dgGrid.load({token:token},function(){
		var carCoinList = dgGrid.getData();
		var newCarCoinList = [];
		for(var i = 0;i<carCoinList.length;i++){
			for(var j = 0;j<carCoinList.length;j++){
				if(carCoinList[j].orderNumber==i){
					newCarCoinList.push(carCoinList[j]);
				}
			}
		}
		dgGrid.setData(newCarCoinList);
	});
}