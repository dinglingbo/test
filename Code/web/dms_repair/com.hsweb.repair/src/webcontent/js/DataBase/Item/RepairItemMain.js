var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.repair.baseData.item.queryRepairItemList.biz.ext";
var treeUrl = apiPath + sysApi + "/com.hsapi.system.dict.dictMgr.queryDictTypeTree.biz.ext";
var tree1 = null;
var rightGrid = null;
var typeHash = {};
var advancedAddWin = null;
var advancedAddForm = null;
var isOpenWin = 0;
var tempGrid = null;
var xs = 0;
var isChooseClose = 1;//默认选择后就关闭窗体

$(document).ready(function()
{
	queryForm = new nui.Form("#queryForm");
	tree1 = nui.get("tree1");
	
	advancedAddWin = nui.get("advancedAddWin");
	advancedAddForm  = new nui.Form("#advancedAddForm");
	tempGrid = nui.get("tempGrid");
	
	var parentId = "DDT20130703000063";
    tree1.setUrl(treeUrl+"?p/rootId=DDT20130703000063&token="+token);
    var data = tree1.getList();
    nui.get('dictid').setData(data);
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
	 initCarBrand("carBrandId",function()
	 {
	 });
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
    rightGrid.on("rowdblclick",function(e){
		onOk();
	});
	tempGrid.on("cellclick",function(e){ 
		var field=e.field;
		var row = e.row;
        if(field=="check" ){
            //if(e.row.check==1){
			//}else{}
			//删除所选记录
			delcallback && delcallback(row,function(){
				tempGrid.removeRow(row);
			});
			tempGrid.removeRow(row);
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
	params.orgid = currOrgId;
	if(isOpenWin == 1){
		params.isDisabled = 0;
	}
	rightGrid.load({
		token:token,
		params:params
	});
}
function addOrEdit(item){
	nui.open({
		targetWindow: window,
		url:webPath + contextPath + "/com.hsweb.repair.DataBase.RepairItemDetail.flow?token="+token,
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
	nui.get("addItemType").hide();
	nui.get("editItemType").hide();
	document.getElementById('sep').style.display = "none";  
	nui.get("selectBtn").show();
	isOpenWin = 1;
}
var callback = null;
var delcallback = null;
var ckcallback = null;
//用于工单添加工时
function setViewData(ck, delck, cck){
	//ck 保存数据 delck 删除数据 cck 判断数据
	isChooseClose = 0;
	callback = ck;
	delcallback = delck;
	ckcallback = cck;
	rightGrid.setWidth("70%");
	tempGrid.setStyle("display:inline");
	document.getElementById("splitDiv").style.display="";
}

function getDataAll(){
	var row = rightGrid.getSelecteds();
	return row;
}

function onOk()
{
	if(nui.get("state").value){
		CloseWindow("ok");
	}else{
		var row = rightGrid.getSelected();
		if(row)
		{
			if(ckcallback){
				var rs = ckcallback(row);
				if(rs){
					showMsg("此工时已添加,请返回查看!","W");
					return;
				}else{
					if(callback){
						nui.mask({
							el: document.body,
							cls: 'mini-mask-loading',
							html: '处理中...'
						});

						callback(row,function(data){
							if(data){
								data.check = 1;
								tempGrid.addRow(data);
							}
						},function(){
							nui.unmask(document.body);
						})
					}
				}
			}else{
				if(callback){
					callback(row,function(data){
						if(data){
							data.check = 1;
							tempGrid.addRow(data);
						}
					})
				}
			}
			resultData.item = row;
			if(isChooseClose == 1){
				CloseWindow("ok");
			}
		}
		else{
			showMsg("请选择一个工时", "W");
		}
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

function addItemType(){
	advancedAddForm.setData([]);
	advancedAddWin.show();
	nui.get('name').focus();
}
function editItemType(){	
	var row = tree1.getSelected();
	var orgid = row.orgid;
	if(orgid != currOrgId){
		showMsg("只能修改本店定义的工时类型!","W");
		return;
	}
	advancedAddForm.setData([]);
	advancedAddWin.show();
	advancedAddForm.setData(row);
}
function onAdvancedAddCancel(){
	advancedAddWin.hide();
	advancedAddForm.setData([]);
}
var saveUrl = apiPath + sysApi + "/com.hsapi.system.dict.dictMgr.saveDictList.biz.ext";
function onAdvancedAddOk(){
	var value = nui.get('name').getValue();
	var id = nui.get('id').getValue();
	if(!value){
		showMsg("类型名称不能为空!","W");
		return;
	}

	var dictid = nui.get('dictid').getValue();
	if(!dictid){
		dictid = 'DDT20130703000063';
	}

	var data = advancedAddForm.getData();

    var addList = [];
	var updateList = [];
	if(data.id){
		var newObj = {id : id,dictid : dictid,name: value, rootId: 'DDT20130703000063'};
		updateList.push(newObj);
	}else{
		var newObj = {name: value, rootId: 'DDT20130703000063'};
		addList.push(newObj);
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
			addList : addList,
			updateList : updateList,
			dictid : dictid,
			token: token
		}),
		success : function(data) {
			nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
				showMsg("保存成功!","S");

				tree1.setUrl(treeUrl+"?p/rootId=DDT20130703000063&token="+token);
				var data = tree1.getList();
				nui.get('dictid').setData(data);
				data.forEach(function(v) {
					typeHash[v.customid] = v;
				});

				onAdvancedAddCancel();
				
			} else {
				showMsg(data.errMsg || "保存失败!","W");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});

}
function onDrawCell(e) {
	switch (e.field) {
	case "isShare":
		e.cellHtml = e.value == 1 ? "总部" : "分店";
		break;
	case "isDisabled":
		e.cellHtml = e.value == 1 ? "是" : "否";
		break;
	case "orgid":
		e.cellHtml = currOrgId == e.value? '本店' : '连锁';
		break;
	default:
		break;
	}

}

function showCheckcolumn(){
	rightGrid.showColumn("checkcolumn");
	nui.get("state").setValue(6);
	nui.get("selectBtn").show();
}

//当选择列时
function selectionChanged() {
	var rows = rightGrid.getSelecteds();
	if(currIsMaster!="1"){
		if(rows[0].isShare=="1"){
			nui.get('update').setVisible(false);
		}else{
			nui.get('update').setVisible(true);
		}
		
	}else{
		if(rows[0].isShare=="1"){
			nui.get('update').setVisible(true);
		}else{
			nui.get('update').setVisible(false);
		}
	}
	if(xs==1){
		mini.get("update").setVisible(false);
		mini.get("add").setVisible(false);
	}
}