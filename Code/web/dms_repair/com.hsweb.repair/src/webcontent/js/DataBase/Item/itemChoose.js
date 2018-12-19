var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.repair.baseData.item.queryRepairItemList.biz.ext";
var treeUrl = apiPath + sysApi + "/com.hsapi.system.dict.dictMgr.queryDictTypeTree.biz.ext";
var itemGridUrl = apiPath + sysApi + "/com.hsapi.system.product.items.getItem.biz.ext";
var tree1 = null;
var rightGrid = null;
var typeHash = {};
var advancedAddWin = null;
var advancedAddForm = null;
var isOpenWin = 0;
var tempGrid = null;
var xs = 0;
var isChooseClose = 1;//默认选择后就关闭窗体
var servieTypeList = [];
var servieTypeHash = {};
var treeHash={};
var tree = null;
var itemGrid = null;
var carModelIdLy = null;
var serviceId = null;
$(document).ready(function()
{
	queryForm = new nui.Form("#queryForm");
	tree1 = nui.get("tree1");
	itemGrid = nui.get("itemGrid");
	itemGrid.setUrl(itemGridUrl);
	advancedAddWin = nui.get("advancedAddWin");
	advancedAddForm  = new nui.Form("#advancedAddForm");
	tempGrid = nui.get("tempGrid");
	itemGrid.hide();
	
	var parentId = "DDT20130703000063";
    tree1.setUrl(treeUrl+"?p/rootId=DDT20130703000063&token="+token);
    var data = tree1.getList();
    nui.get('dictid').setData(data);
	data.forEach(function(v) {
		typeHash[v.customid] = v;
	});

	 initCarBrand("carBrandId",function()
	 {
	 });

	tree1.on("nodedblclick",function(e)
	{
		var node = e.node;
		var customid = node.customid;
		var params = getSearchParams();
		params.type = customid;
		doSearch(params);
	});
	itemGrid.on("rowdblclick",function(e){
		var row = e.row;
		selectStdItem(row);
	});
	
	//右边区域
	rightGrid = nui.get("rightGrid");
	rightGrid.setUrl(rightGridUrl);
	onSearch();
	rightGrid.on("rowdblclick",function(e){
		onOk();	
	});
    rightGrid.on("drawcell",function(e){
		switch (e.field){
			case "type":
				if(typeHash && typeHash[e.value])
				{
					if(typeHash[e.value] && typeHash[e.value].name) {
						e.cellHtml = typeHash[e.value].name||"";
					}
				}
				break;
			case "belonging":
				if(currOrgId==e.row.orgid){
					e.cellHtml="本店";
				}else{
					e.cellHtml="";
				}
				break;
            case "serviceTypeId":
            	if(servieTypeHash[e.value] && servieTypeHash[e.value].name) {
					e.cellHtml = servieTypeHash[e.value].name||"";
				}
                break;
            default:
                break;
		}
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
	 initServiceType("serviceTypeId",function(data) {
	        servieTypeList = nui.get("serviceTypeId").getData();
	        servieTypeList.forEach(function(v) {
	            servieTypeHash[v.id] = v;
	        });
	 });

	nui.get("search-name").focus();
	document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27))  {  //ESC
            if(isOpenWin==1){
                onCancel();
            }
           
        }
      };

	tree1.on("nodeclick",function(e){
		itemGrid.hide();
    	rightGrid.show();
    	var serviceLabel =document.getElementById("serviceLabel");
    	serviceLabel.style.display="";

    	var itemCodeLabel =document.getElementById("itemCodeLabel");
    	itemCodeLabel.style.display="";
    	//showHot
    	
    	nui.get("serviceTypeId").setVisible(true);
    	nui.get("search-code").setVisible(true);
    	var showHot =document.getElementById("showHot");
    	showHot.style.display="none";
    });
	
	var hotUrl = apiPath + sysApi + "/com.hsapi.system.product.items.getHotWord.biz.ext";
    tree = nui.get("tree");
    tree.on("load",function(e)
    {
        var list = tree.getList();
        treeHash = {};
        list.forEach(function(v){
            treeHash[v.id] = v;
        });
    });
    tree.setUrl(hotUrl);
    tree.on("preload",function(e){
    	tree.setData([]);
    	var data = e.result.rs||[];
    	var rs = [];
    	for(var i = 0; i<data.length; i++){
    		var row = data[i];
    		var customId = row.customId||"";
    		var indexCus = customId.indexOf("01");
    		if(indexCus == 0){
    			rs.push(row);
    		}
    	}
    	tree.setData(rs);
    });
    tree.on("nodedblclick",function(e)
    {
        var node = e.node;
        var nodeList = tree.getAncestors(node);
 
        if(nodeList.length<0)
        {
            return;
        }
        var params = {
        	partName:node.name
        };
        doSearchItem(params);

    });
    tree.on("nodeclick",function(e){
    	rightGrid.hide();
    	itemGrid.show();

    	var serviceLabel =document.getElementById("serviceLabel");
    	serviceLabel.style.display="none";

    	var itemCodeLabel =document.getElementById("itemCodeLabel");
    	itemCodeLabel.style.display="none";
    	
    	nui.get("serviceTypeId").setVisible(false);
    	nui.get("search-code").setVisible(false);
    	var showHot =document.getElementById("showHot");
    	showHot.style.display="";
    });
});
function setRoleId(){
	return {"token":token};
}
function doSearchItem(params)
{
    params.itemName = params.name||"";
    params.carModelId = carModelIdLy;
    itemGrid.load({
    	token:token,
        p:params
    });
}
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
	if(itemGrid.visible) {
		var params = {
			name: nui.get("search-name").getValue()
		}
		doSearchItem(params);
	}else {
		var params = getSearchParams();
		doSearch(params);
	}
}
function doSearch(params)
{
	params.orgid = currOrgId;
	params.isDisabled = 0;
	rightGrid.load({
		token:token,
		params:params
	});
}
function addOrEdit(item){
	nui.open({
		targetWindow: window,
		url:webPath + contextPath + "/com.hsweb.repair.DataBase.RepairItemDetail.flow?token="+token,
		title:"维修项目",
		width:600,
		height:400,
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

	isOpenWin = 1;

	carModelIdLy = data.carModelIdLy||"";
	if(isNaN(data.serviceId)){
		var xm = (data.serviceId).split("m");
		serviceId = xm[1];
		var params = {
				orgid : currOrgId,
				isDisabled : 0,
				serviceTypeId : 3
			};
		var json={
				params: params,
				token:token
		}
			nui.ajax({
				url : rightGridUrl,
				type : 'POST',
				data : json,
				cache : false,
				contentType : 'text/json',
				success : function(text) {
					rightGrid.setData(text.list);
					var params1 = {
							orgid : currOrgId,
							isDisabled : 0,
							serviceTypeId : 6
						};
					var json1={
							params: params1,
							token:token
					}
					nui.ajax({
						url : rightGridUrl,
						type : 'POST',
						data : json1,
						cache : false,
						contentType : 'text/json',
						success : function(data) {
							for(var i=0;i<data.list.length;i++){
								rightGrid.addRow(data.list[i]);
							}
							
						}
					 });
				}
			 });
	}else{
		serviceId = data.serviceId;
	}
	
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
	//tempGrid.setStyle("display:inline");
	//document.getElementById("splitDiv").style.display="";

}

function getDataAll(){
	var row = rightGrid.getSelecteds();
	return row;
}
function choose() {
	if(itemGrid.visible) {
		var row = itemGrid.getSelected();
		if(!row){
			showMsg("请选择一个项目", "W");
			return;
		}
		selectStdItem(row);
	}else {
		onOk();
	}
}
function onOk()
{
	if(nui.get("state").value){
		CloseWindow("ok");
	}else{
		var row = rightGrid.getSelected();
		if(row)
		{
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
				});
			}
		}
		else{
			showMsg("请选择一个项目", "W");
		}
	}
}
var stdItemUrl = apiPath + repairApi + "/com.hsapi.repair.repairService.crud.insStdItem.biz.ext";
function selectStdItem(row) {    
   if(!row.ItemID) return;
   nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '处理中...'
   });
   
   var insItem = {
   		itemId:row.ItemID,
     }
   	var json = nui.encode({
   		"insItem":insItem,
   		"serviceId":serviceId,
   		token:token
   	});
	nui.ajax({
		url : stdItemUrl,
		type : 'POST',
		data : json,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			var returnJson = nui.decode(text);
			if (returnJson.errCode == "S") {
				nui.unmask(document.body);
				var data = returnJson.data;
				if(data){
					data.check = 1;
					tempGrid.addRow(data);
				}
				
			} else {
				showMsg(returnJson.errMsg||"添加项目失败!","E");
				nui.unmask(document.body);
		    }
		}
	 });

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
		showMsg("只能修改本店定义的项目类型!","W");
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
				showMsg(data.errMsg || "保存失败!","E");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});

}


