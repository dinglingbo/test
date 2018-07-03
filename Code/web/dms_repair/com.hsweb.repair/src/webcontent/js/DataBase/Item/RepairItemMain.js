var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.repair.baseData.item.queryRepairItemList.biz.ext";
var tree1 = null;
var rightGrid = null;

$(document).ready(function()
{
	queryForm = new nui.Form("#queryForm");
	tree1 = nui.get("tree1");
	var parentId = "DDT20130703000063";
	getDatadictionaries(parentId,function(data)
	{
		var list = data.list||[];
		tree1.loadList(list);
	});
	var parentId1 = "DDT20130703000057";
	getDatadictionaries(parentId1,function(data)
	{
		var list = data.list||[];
		var itemKind = nui.get("itemKind");
		itemKind.setData(list);
	});
	/*initCarBrand("carBrandId",function()
	{
	});*/
	tree1.on("nodedblclick",function(e)
	{
		var node = e.node;
		var customid = node.customid;
		var params = getSearchParams();
		params.type = customid;
		doSearch(params);
	});
	//右边区域
	rightGrid = nui.get("rightGrid");
	rightGrid.setUrl(rightGridUrl);
	rightGrid.on("drawcell",onDrawCell);
	onSearch();
});
function onClear(){
	queryForm.clear();
}
function getSearchParams()
{
	var params = queryForm.getData();
	return params;
}
function onSearch()
{
	var params = getSearchParams();
	doSearch(params);
}
function doSearch(params)
{
	params.orgid = currOrgid;
	rightGrid.load({
		token:token,
		params:params
	});
}
function addOrEdit(item){
	nui.open({
		targetWindow: window,
		url:"com.hsweb.repair.DataBase.RepairItemDetail.flow",
		title:"维修项目",
		width:450,
		height:380,
		allowResize:false,
		onload: function()
		{
			var iframe = this.getIFrameEl();
			var params = {};
			params.typeList = tree1.getList();
			params.itemKindList = nui.get("itemKind").getData();
			params.carBrandIdList = nui.get("carBrandId").getData();
			if(item)
			{
				params.item = item;
			}
			iframe.contentWindow.setData(params);
		},
		ondestroy:function(action)
		{
	    	if(action == "ok")
			{
	    		rightGrid.reload();
	    	}	
		}
	});
}
function add(){
	addOrEdit();
}
function edit(){
	var row = rightGrid.getSelected();
	if(row){
		addOrEdit(row);
	}
}

var resultData = {};
var list = [];
function getData()
{
	return resultData;
}
function setData(data)
{
	list = data.list||[];
	nui.get("add").hide();
	nui.get("update").hide();
	nui.get("selectBtn").show();
}
function onOk()
{
	var row = rightGrid.getSelected();
	if(row)
	{
		resultData.item = row;
		CloseWindow("ok");
	}
	else{
		nui.alert("请选择一个项目");
	}
}
function CloseWindow(action)
{
	if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else window.close();
}

function onCancel() {
	CloseWindow("cancel");
}