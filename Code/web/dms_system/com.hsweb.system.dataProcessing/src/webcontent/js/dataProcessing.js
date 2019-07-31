var treeList = [
                {id: "base", text: "数据清除"},
            	{id: "wbRps", text: "售后业务数据", pid: "base"},
            	
            	{id: "wbPart", text: "售后库存数据", pid: "base"},
            	{id: "wbGuest", text: "售后客户数据", pid: "base"},
            	{id: "wbCommon", text: "售后供应商数据", pid: "base"},
            	{id: "wbRpb", text: "售后基础数据", pid: "base"},
            	{id: "dmsSystem", text: "员工基础数据", pid: "base"},
            	{id: "wbSales", text: "售后汽贸数据", pid: "base"},
            	{id: "wbFrm", text: "财务业务数据", pid: "base"}


            ];


/*var treeList = [
                {id: "base", text: "数据清除"},
            	{id: "datagrid", text: "售后业务数据", pid: "base"},
            	
            	{id: "lists", text: "售后库存数据", pid: "base"},
            	{id: "tree", text: "售后客户数据", pid: "base"},
            	{id: "treegrid", text: "售后供应商数据", pid: "base"},
            	{id: "layouts", text: "售后基础数据", pid: "base"},
            	{id: "panel", text: "员工基础数据", pid: "base"},
            	{id: "toolbar", text: "售后汽贸数据", pid: "base"},
            	{id: "outlookbar", text: "财务业务数据", pid: "base"}


            	
            	{id: "lists", text: "售后库存数据"},
            	
            	{id: "datagrid", text: "DataGrid", pid: "lists"},
            	{id: "tree", text: "Tree", pid: "lists"},
            	{id: "treegrid", text: "TreeGrid ", pid: "lists"},

            	{id: "layouts", text: "售后客户数据"},
            	
            	{id: "panel", text: "售后供应商数据", pid: "layouts"},
            	
            	{id: "navigations", text: "售后基础数据"},
            			
            	{id: "toolbar", text: "员工基础数据", pid: "navigations"},
            	{id: "tabs", text: "Tabs", pid: "navigations"},
            	{id: "outlookbar", text: "OutlookBar", pid: "navigations"},
            	{id: "menu", text: "Menu", pid: "navigations"},
            	{id: "pager", text: "Pager", pid: "navigations"},

            	{id: "other", text: "售后汽贸数据", isLeaf: false, asyncLoad: false},
            	{id: "other", text: "财务业务数据", isLeaf: false, asyncLoad: false}

            ];*/
var tree = null;
$(document).ready(function () {
	tree = nui.get("tree2");
	//tree.setData(treeList);
	 tree.loadList(treeList, "id", "pid");
});

var saveUrl = apiPath + sysApi + "/com.hsapi.system.dataProcessing.wbPart.dataProcessing.biz.ext";
function save(){
	var rows = tree.getCheckedNodes();
	if(rows.length==0){
		showMsg("请选择清除数据！","W");
	}else{
	    nui.mask({
	        el: document.body,
	        cls: 'mini-mask-loading',
	        html: '清除中...'
	    });
	    
	}

	var params = {};
	
	for(var i = 0;i<rows.length;i++){
		if(rows[i].id=="wbRps"){
			params.wbRps = 1;
		}else if(rows[i].id=="wbPart"){
			params.wbPart = 1;
		}else if(rows[i].id=="wbGuest"){
			params.wbGuest = 1;
		}else if(rows[i].id=="wbCommon"){
			params.wbCommon = 1;
		}else if(rows[i].id=="wbRpb"){
			params.wbRpb = 1;
		}else if(rows[i].id=="dmsSystem"){
			params.dmsSystem = 1;
		}else if(rows[i].id=="wbSales"){
			params.wbSales = 1;
		}else if(rows[i].id=="wbFrm"){
			params.wbFrm = 1;
		}
	}
	var json = {
			params : 	params,
			token : token
	};
	nui.ajax({
		url : saveUrl,
		type : 'POST',
		data : json,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			nui.unmask(document.body);
			if(text.errCode=="S"){
				showMsg("清除成功!","S")
				CloseWindow("ok");
			}else{
				showMsg(text.errMsg||"清除失败!","W")
			}
		}
	 });
	
}

function CloseWindow(action) {
	if (action == "close") {

	} else if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else
		return window.close();
}