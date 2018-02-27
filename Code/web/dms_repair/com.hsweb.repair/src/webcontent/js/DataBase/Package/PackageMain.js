var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var leftGridUrl = baseUrl + "com.hsapi.repair.baseData.rpb_package.queryPackage.biz.ext";
var rightItemGridUrl = baseUrl + "com.hsapi.repair.baseData.rpb_package.queryPackageItem.biz.ext";
var rightPartGridUrl = baseUrl + "com.hsapi.repair.baseData.rpb_package.queryPackagePart.biz.ext";

var leftGrid = null;
var rightItemGrid = null;
var rightPartGrid = null;
var dataform = null;

$(document).ready(function (v){
	leftGrid = nui.get("leftGrid"); 
	leftGrid.setUrl(leftGridUrl); 
	
	rightItemGrid = nui.get("rightItemGrid");
	rightItemGrid.setUrl(rightItemGridUrl);
	
	rightPartGrid = nui.get("rightPartGrid");
	rightPartGrid.setUrl(rightPartGridUrl);
	
	dataform = new nui.Form("#dataform1");
	
	loadLeftGridData({});
	loadRightItemGridData({});
	loadRightPartGridData({});
	
});

function onLeftGridRowClick(e){
	var row = e.record;
	dataform.setData(row);
	loadRightItemGridData(row.id);
	loadRightPartGridData(row.id);
}
function loadLeftGridData(params){
	rightItemGrid.setData([]);
	rightPartGrid.setData([]);
	leftGrid.load(params,function(){
		var row = leftGrid.getSelected();
		if(row){
			loadRightItemGridData(row.id);
			loadRightPartGridData(row.id);
			
		}
	});
}
function loadRightItemGridData(packageId){
	rightItemGrid.load({
		packageId:packageId
	});
	
}
function loadRightPartGridData(packageId){
	rightPartGrid.load({
		packageId:packageId
	});
}
