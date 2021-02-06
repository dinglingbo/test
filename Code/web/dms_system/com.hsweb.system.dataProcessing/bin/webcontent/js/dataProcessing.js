var treeList = [
                {id: "base", text: "数据清除"},
            	{id: "wbRps", text: "售后业务数据", pid: "base"},
            	{id: "rpsCard", text: "次卡储值卡数据", pid: "wbRps"},
            	{id: "rpsMaintain", text: "工单数据", pid: "wbRps"},
            	{id: "wbRepair", text: "售后功能项目数据", pid: "wbRps"},
            	
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
	//tree = nui.get("tree2");
	//tree.setData(treeList);
	// tree.loadList(treeList, "id", "pid");
});

function save(url){
	var saveUrl = apiPath + sysApi + "/com.hsapi.system.dataProcessing.wbPart."+url+".biz.ext";
	var orgid = nui.get("orgid").getValue()
	if(!orgid>0){
		showMsg("请输入门店orgid！","W");
		return;
	}
	var params = {};
	params.orgid = orgid;	
	var json = {
			params : 	params,
			token : token
	};
	  nui.confirm("是否确定清除?", "友情提示",function(action){
	       if(action == "ok"){
				nui.mask({
					el : document.body,
					cls : 'mini-mask-loading',
					html : '数据处理中...'
				});
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
							showMsg(text.errMsg||"清除失败!","W");
						}
					}
				 });

	     }else {
				return;
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

