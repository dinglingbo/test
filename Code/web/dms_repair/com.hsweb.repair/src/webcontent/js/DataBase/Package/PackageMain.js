var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var leftGridUrl = baseUrl + "com.hsapi.repair.baseData.rpb_package.queryPackage.biz.ext";
var rightItemGridUrl = baseUrl + "com.hsapi.repair.baseData.query.queryRpbItemByPackageId.biz.ext";
var rightPartGridUrl = baseUrl + "com.hsapi.repair.baseData.query.queryRpbPartByPackageId.biz.ext";
var totalUrl = baseUrl + "com.hsapi.repair.baseData.rpb_package.getPackageInfo.biz.ext";
var leftGrid = null;
var rightItemGrid = null;
var rightPartGrid = null;
var basicInfoForm = null;
var carBrandIdEl = null;
var carModelIdEl = null;
var carModelIdHash = {};
var editPartHash = {};
//页面加载完才执行，在这里面定义了方法
$(document).ready(function (v)
{
	//左边表格
	leftGrid = nui.get("leftGrid"); 
	leftGrid.setUrl(leftGridUrl);
	leftGrid.on("drawcell",onDrawCell);
	
	leftGrid.on("rowclick",function(e)
	{
		onLeftGridRowClick(e);
	});
	leftGrid.on("load",function(){
		onLeftGridRowClick({});
	});

	//右边表格
	rightItemGrid = nui.get("itemGrid");
	rightItemGrid.setUrl(rightItemGridUrl);
	//rightItemGrid.setUrl(totalUrl);
	rightItemGrid.on("drawcell",onDrawCell);
	
	rightPartGrid = nui.get("rightPartGrid");
	rightPartGrid.setUrl(rightPartGridUrl);
	
	//cellendedit事件，编辑结束时发生
	rightPartGrid.on("cellendedit",function(e)
	{
		/*
		sender: Object, //表格对象
	    record: Object, //行对象
	    column: Object //列对象
       */		
		var row = e.record;
		if(row)
		{
			var qty = row.qty;
			var unitPrice = row.unitPrice;
			if(qty && unitPrice)
			{
				var amt = unitPrice*qty;
				row.amt = amt;
				//修改行
				rightPartGrid.updateRow(row,row);
			}
		}
	});

	//基本信息
	basicInfoForm = new nui.Form("#basicInfoForm");
	//快速查找
	queryForm = new nui.Form("#queryForm");
	//品牌的对象
	carBrandIdEl = nui.get("carBrandId");
	//车型的对象
	carModelIdEl = nui.get("carModelId");
	
	init();
});


function init()
{
	carBrandIdEl.on("valuechanged",function()
	{
		var carBrandId = carBrandIdEl.getValue();		
		getCarModel("carModelId",{
			value:carBrandId
		});
	});

	//
	var elList = basicInfoForm.getFields();
	var nameList = ["amount"];
	//forEach？循环每一个元素？？
	elList.forEach(function(v)
	{
		if(nameList.indexOf(v.name)>-1)
		{
			v.on("focus",function(e){
				onInputFocus(e);
			});
			v.on("blur",function(e){
				onInputBlur(e);
			});
		}
	});

	var hash = {};
	//添加遮罩
	nui.mask({
		html: '数据加载中..'
	});
	var checkComplete = function () {
		var keyList = ['initDicts','initCarBrand',"getDatadictionaries"];
		for (var i = 0; i < keyList.length; i++) {
			if (!hash[keyList[i]]) {
				return;
			}
		}
		//取消遮罩
		nui.unmask();
		
		onSearch();
	};
	var pId2 = ITEM_KIND;//工种
	getDatadictionaries(pId2, function (data) 
	{
		hash.getDatadictionaries = true;
		checkComplete();
	});
	
	initDicts({
		type:PKG_TYPE
	},function(){
		var list = nui.get("type").getData();
		nui.get("type-search").setData(list);
		hash.initDicts = true;
		checkComplete();
	});
	
	initCarBrand("carBrandId",function()
	{
		var list = carBrandIdEl.getData();
		nui.get("carBrandId-search").setData(list);
		hash.initCarBrand = true;
		checkComplete();
	});
	
}


function onInputBlur(e)
{
	var el = e.sender;
	if(el)
	{
		el.setInputStyle("text-align:right;");
		el.setFormat("￥0.00");
	}
}
function onInputFocus(e)
{
	//表格对象
	var el = e.sender;
	if(el)
	{    
		el.setInputStyle("text-align:left;");
		el.setFormat("");
	}
}
//点击左边表格信息，右边表格显示数据
function onLeftGridRowClick(e)
{
	var row = leftGrid.getSelected();
	if(row)
	{
		basicInfoForm.clear();
		basicInfoForm.setData(row);
		//doValueChanged??
		carBrandIdEl.doValueChanged();
		loadRightPartGridData(row.id);
		loadRightItemGridData(row.id);
		
	}
}
function onSearch()
{
	var params = getSearchParams();
	doSearch(params);
}
function getSearchParams()
{
	var params = queryForm.getData();
	return params;
}
function doSearch(params)
{
	addPackage();
	params.orgid = currOrgid;
	leftGrid.load({
		token:token,
		params:params
	});
}
function loadRightItemGridData(packageId)
{
	/*var params = {
		packageId:packageId
	};*/
	
	rightItemGrid.load({
		token:token,
		/*params:params*/
		packageId:packageId
	});
}
function loadRightPartGridData(packageId)
{
	rightPartGrid.load({
		token:token,
		packageId:packageId
	});
}
function addPackage()
{
	//添加时清除右边基本数据
	basicInfoForm.clear();
	rightItemGrid.clearRows();
	rightPartGrid.clearRows();
	var data = {
		amount:0,
		total:0
	};
	//设置原始数据
	basicInfoForm.setData(data);
}
var saveUrl = baseUrl + "com.hsapi.repair.baseData.rpb_package.savePackage.biz.ext";
function save()
{
	var data = basicInfoForm.getData();
	var partList = rightPartGrid.getData();
	var i,tmp;
	var total = 0;
	for(i=0;i<partList.length;i++)
	{
		tmp = partList[i];
		total += tmp.amt;
	}
	//增加
	var insParts = partList.filter(function(v){
		return !v.packageId;
	});
	//删除和修改的
	var delParts = rightPartGrid.getChanges("removed");
	var updParts = rightPartGrid.getChanges("modified");

	var itemList = rightItemGrid.getData();
	
	var insItems = itemList.filter(function(v){
		return !v.packageId;
	});
	
	var delItems = rightItemGrid.getChanges("removed");
	var updItems = rightItemGrid.getChanges("modified");
	for(i=0;i<itemList.length;i++)
	{
		tmp = itemList[i];
		total += tmp.amt;
	}
	data.total = total;
	nui.mask({
		html:'保存中..'
	});
	//doPost和其他的有什么区别
	doPost({
		url:saveUrl,
		data:{
			main:data,
			insParts:insParts,
			delParts:delParts,
			updParts:updParts,
			insItems:insItems,
			delItems:delItems,
			updItems:updItems
		},
		success:function(data)
		{
			nui.unmask();
			data = data||{};
			if(data.errCode == "S")
			{
				nui.alert("保存成功");
				basicInfoForm.clear();
				leftGrid.reload();
			}
			else{
				nui.alert(data.errMsg||"保存失败");
			}
		},
		error:function(jqXHR, textStatus, errorThrown)
		{
			console.log(jqXHR.responseText);
			nui.unmask();
			nui.alert("网络出错");
		}
	});
}

function selectPart(callback)
{
	nui.open({
		targetWindow: window,
		url: "com.hsweb.part.common.partSelectView.flow",
		title: "选择配件", width: 930, height: 560,
		allowDrag:true,
		allowResize:true,
		onload: function ()
		{
			var iframe = this.getIFrameEl();
			var params = {};
			params.list = rightPartGrid.getData();
			iframe.contentWindow.setData(params);
		},
		ondestroy: function (action)
		{
			if(action == "ok")
			{
				var iframe = this.getIFrameEl();
				var data = iframe.contentWindow.getData();
				callback && callback(data);
			}
		}
	});
}
function addPart()
{
	selectPart(function(data)
	{
		var part = data.part;
		var packagePart = {
			partId:part.id,
			partCode:part.code,
			partName:part.name,
			qty:1,
			unitPrice:0,
			unit:part.unit,
			amt:0
		};
		rightPartGrid.addRow(packagePart);
	});
}
function removePart()
{
	var row = rightPartGrid.getSelected();
	if(row)
	{
		rightPartGrid.removeRow(row,true);
	}
}

function selectItem(callback)
{
	nui.open({
		targetWindow: window,
		url: "com.hsweb.repair.DataBase.RepairItemMain.flow",
		title: "维修项目", width: 930, height: 560,
		allowDrag:true,
		allowResize:true,
		onload: function ()
		{
			var iframe = this.getIFrameEl();
			var params = {};
			params.list = rightItemGrid.getData();
			iframe.contentWindow.setData(params);
		},
		ondestroy: function (action)
		{
			if(action == "ok")
			{
				var iframe = this.getIFrameEl();
				var data = iframe.contentWindow.getData();
				callback && callback(data);
			}
		}
	});
}
function addItem()
{
	selectItem(function(data)
	{
		var item = data.item;
		var packageItem = {
			itemId:item.id,
			itemCode:item.code,
			itemName:item.name,
			itemTime:item.itemTime,
			itemKind:item.itemKind,
			itemKindName:item.itemKindName,
			unitPrice:item.unitPrice,
			amt:item.amt
		};
		rightItemGrid.addRow(packageItem);
	});
}
function removeItem()
{
	var row = rightItemGrid.getSelected();
	if(row)
	{
		rightItemGrid.removeRow(row,true);
	}
}