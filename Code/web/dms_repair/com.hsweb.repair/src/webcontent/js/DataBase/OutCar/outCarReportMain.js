var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var leftTreeUrl = baseUrl + "com.hsapi.repair.baseData.outCar.getOutCarTree.biz.ext";
var dataGridUrl = baseUrl + "com.hsapi.repair.baseData.outCar.queryOutCar.biz.ext";
var leftTree = null;
var dataGrid = null;
var dataform1 = null;
var requiredFieldew={
		content:"报告类型"
}

$(document).ready(function (v){
	leftTree = nui.get("tree1");
	leftTree.setUrl(leftTreeUrl);
	
	dataGrid = nui.get("datagrid1");
	dataGrid.setUrl(dataGridUrl);
	
	dataform1 = new nui.Form("#dataform1");
	
	loadLeftTreeData({});
	loadDataGridData({});
});
function onOutCarRowClick(e){
	var row = e.record;
	loadDataGridData(row.id);
	
}
function onOutCarDataRowClick(e){
	var row = e.record;
	dataform1.setData(row);
}
function loadLeftTreeData(params){
	dataGrid.setData([]);
	leftTree.load(params,function(){
		var row = leftTree.getSelected();
		if(row){
			loadDataGridData(row.customid);
			
		}
	});
}
function loadDataGridData(type){
	dataGrid.load({
		type:type
	});
	
}
