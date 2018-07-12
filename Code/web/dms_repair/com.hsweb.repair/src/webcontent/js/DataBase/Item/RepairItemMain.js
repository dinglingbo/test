var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.repair.baseData.item.queryRepairItemList.biz.ext";
var treeUrl = apiPath + sysApi + "/com.hsapi.system.dict.dictMgr.queryDictTypeTree.biz.ext";
var tree1 = null;
var rightGrid = null;
var typeHash = {};

$(document).ready(function()
{
	queryForm = new nui.Form("#queryForm");
	tree1 = nui.get("tree1");
	var parentId = "DDT20130703000063";
    tree1.setUrl(treeUrl+"?p/rootId=DDT20130703000063&token="+token);
    var data = tree1.getList();
	data.forEach(function(v) {
		typeHash[v.customid] = v;
	});
	// getDatadictionaries(parentId,function(data)
	// {
	// 	var list = data.list||[];
	// 	tree1.loadList(list);
	// });
	// var parentId1 = "DDT20130703000057";
	// getDatadictionaries(parentId1,function(data)
	// {
	// 	var list = data.list||[];
	// 	var itemKind = nui.get("itemKind");
	// 	itemKind.setData(list);
	// });
	// initCarBrand("carBrandId",function()
	// {
	// });
    // initDicts({"costType": COST_TYPE});
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
    rightGrid.on("drawcell",function(e){
		switch (e.field){
			case "type":
				if(typeHash && typeHash[e.value])
				{
					e.cellHtml = typeHash[e.value].name||"";
				}
				break;
		}
	});
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
    params.orgid = currOrgid;
	rightGrid.load({
		token:token,
		params:params
	});
}
function addOrEdit(item){
	nui.open({
		targetWindow: window,
		url:webPath + repairDomain + "/com.hsweb.repair.DataBase.RepairItemDetail.flow?token="+token,
		title:"维修工时",
		width:550,
		height:360,
		allowResize:false,
		onload: function()
		{
			var iframe = this.getIFrameEl();
			var params = {};
			params.typeList = tree1.getList();
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
		showMsg("请选择一个工时", "W");
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