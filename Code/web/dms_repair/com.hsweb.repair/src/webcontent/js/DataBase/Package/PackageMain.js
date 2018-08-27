var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var leftGridUrl = baseUrl + "com.hsapi.repair.baseData.rpb_package.queryPackage.biz.ext";
var rightItemGridUrl = baseUrl + "com.hsapi.repair.baseData.query.queryRpbItemByPackageId.biz.ext";
var rightPartGridUrl = baseUrl + "com.hsapi.repair.baseData.query.queryRpbPartByPackageId.biz.ext";
var leftGrid = null;
var rightItemGrid = null;
var rightPartGrid = null;
var basicInfoForm = null;
var basicInfoForm1 = null;
var carBrandIdEl = null;
var carModelIdEl = null;
var carModelIdHash = {};
var editPartHash = {};
var carModelHash = [];
var servieTypeList = [];
var servieTypeHash = {};
var typeHash = {};
var typeList = [];
var hidePercent = null;
var salesDeductTypeEl = null;
//var techDeductTypeEl = null;
var advisorDeductTypeEl = null;
var typeList = [{id:"1",text:"按原价比例"},{id:"2",text:"按折后价比例"},{id:"3",text:"按产值比例"},{id:"4",text:"固定金额"}];
$(document).ready(function (v)
{
	salesDeductTypeEl = nui.get("salesDeductType");
	//techDeductTypeEl = nui.get("techDeductType");
	advisorDeductTypeEl = nui.get("advisorDeductType");
	salesDeductTypeEl.setData(typeList);
	//techDeductTypeEl.setData(typeList);
	advisorDeductTypeEl.setData(typeList);
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

	
	rightItemGrid = nui.get("itemGrid");
	rightItemGrid.setUrl(rightItemGridUrl);
	rightItemGrid.on("drawcell",onDrawCell);	
	rightPartGrid = nui.get("rightPartGrid");
	rightPartGrid.setUrl(rightPartGridUrl);
	
	
	rightPartGrid.on("cellendedit",function(e)
	{
				
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

	basicInfoForm = new nui.Form("#basicInfoForm");
	basicInfoForm1 = new nui.Form("#basicInfoForm1");
	queryForm = new nui.Form("#queryForm");
	carBrandIdEl = nui.get("carBrandId");
	carModelIdEl = nui.get("carModelId");
	
	init();
});

function onRateValidation(e){
	var el = e.sender.id;
	var value = 0;
	if(el == "salesDeductValue"){
		value = salesDeductTypeEl.getValue();
		if(value == 4){
			var reg=/(^[1-9]{1}[0-9]*$)|(^[0-9]*\.[0-9]{2}$|0$)/;
			if (!reg.test(e.value)) {
				e.errorText = "请输入大于等于0的整数或者保留两位小数";
				e.isValid = false;
				showMsg("请输入大于0的整数或者保留两位小数","W");
			}
		}else {
			if (e.isValid) {
				var reg=/^\d\.([1-9]{1,2}|[0-9][1-9])$|^[1-9]\d{0,1}(\.\d{1,2}){0,1}$|^100(\.0{1,2}){0,1}$|0$/
				if (!reg.test(e.value)) {
					e.errorText = "请输入0~100的数,最多可保留两位小数";
					e.isValid = false;
					showMsg("请输入0~100的数,最多可保留两位小数","W");
				}
			}
		}
	}else if(el == "techDeductValue"){
		//value = techDeductTypeEl.getValue();
		if(value == 4){
			var reg=/(^[1-9]{1}[0-9]*$)|(^[0-9]*\.[0-9]{2}$)|0$/;
			if (!reg.test(e.value)) {
				e.errorText = "请输入大于等于0的整数或者保留两位小数";
				e.isValid = false;
				showMsg("请输入大于0的整数或者保留两位小数","W");
			}
		}else {
			if (e.isValid) {
				//var reg=/(^[1-9][0-9]$|^[0-9]$|^100$)/;
				var reg=/^\d\.([1-9]{1,2}|[0-9][1-9])$|^[1-9]\d{0,1}(\.\d{1,2}){0,1}$|^100(\.0{1,2}){0,1}$|0$/
				if (!reg.test(e.value)) {
					e.errorText = "请输入0~100的数,最多可保留两位小数";
					e.isValid = false;
					showMsg("请输入0~100的数,最多可保留两位小数","W");
				}
			}
		}
	}else if(el == "advisorDeductValue"){
		value = advisorDeductTypeEl.getValue();
		if(value == 4){
			var reg=/(^[1-9]{1}[0-9]*$)|(^[0-9]*\.[0-9]{2}$)|0$/;
			if (!reg.test(e.value)) {
				e.errorText = "请输入大于等于0的整数或者保留两位小数";
				e.isValid = false;
				showMsg("请输入大于0的整数或者保留两位小数","W");
			}
		}else {
			if (e.isValid) {
				//var reg=/(^[1-9][0-9]$|^[0-9]$|^100$)/;
				var reg=/^\d\.([1-9]{1,2}|[0-9][1-9])$|^[1-9]\d{0,1}(\.\d{1,2}){0,1}$|^100(\.0{1,2}){0,1}$|0$/
				if (!reg.test(e.value)) {
					e.errorText = "请输入0~100的数,最多可保留两位小数";
					e.isValid = false;
					showMsg("请输入0~100的数,最多可保留两位小数","W");
				}
			}
		}
	}


}
function hidePercent(e){
	var value = e.value;
	var el = e.sender.id;
	if(el == "salesDeductType"){
		if(value == 4){
			$("#salesDeductValue").next().hide();
		}else {
			$("#salesDeductValue").next().show();
		}
	}else if(el == "techDeductType"){
		if(value == 4){
			$("#techDeductValue").next().hide();
		}else {
			$("#techDeductValue").next().show();
		}
	}else if(el == "advisorDeductType"){
		if(value == 4){
			$("#advisorDeductValue").next().hide();
		}else {
			$("#advisorDeductValue").next().show();
		}
	}
}
function init()
{
	/*carBrandIdEl.on("valuechanged",function()
	{
		var carBrandId = carBrandIdEl.getValue();
		
		getCarModel("carModelId",{
			value:carBrandId
		});
	});*/

	//
	var elList = basicInfoForm.getFields();
	var nameList = ["amount"];
	elList.forEach(function(v)
	{
		if(nameList.indexOf(v.name)>-1)
		{
			v.on("focus",function(e){
				//右对齐
				onInputFocus(e);
			});
			v.on("blur",function(e){
				//左对齐
				onInputBlur(e);
			});
		}
	});

	var hash = {};
	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '数据加载中...'
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
//	var pId2 = ITEM_KIND;//工种
//	getDatadictionaries(pId2, function (data) 
//	{
//		hash.getDatadictionaries = true;
//		checkComplete();
//	});
	
	var dictDefs ={"type":"DDT20130703000063"};
	initTreeDicts(dictDefs,function(){
		typeList = nui.get('type').getData();
		typeList.forEach(function(v) {
			typeHash[v.customid] = v;
		});
		hash.initDicts = true;
		checkComplete();
	});
	
//	initDicts({
//		type:PKG_TYPE
//	},function(){
//		var list = nui.get("type").getData();
//		nui.get("type-search").setData(list);
//		hash.initDicts = true;
//		checkComplete();
//	});
	initServiceType("serviceTypeId",function(data) {
        servieTypeList = nui.get("serviceTypeId").getData();
        servieTypeList.forEach(function(v) {
            servieTypeHash[v.id] = v;
        });
        hash.getDatadictionaries = true;
		checkComplete();
		
		nui.get('type-serviceTypeId').setData(servieTypeList);
    });
	
	initCarBrand("carBrandId",function()
	{
		var list = carBrandIdEl.getData();
		nui.get("carBrandId-search").setData(list);
		hash.initCarBrand = true;
		checkComplete();
	});
}
//显示车型的
function onCarBrandChange(e){     
	initCarModel("carModelId", e.value,"", function () {
        var data = nui.get("carModelId").getData();
        data.forEach(function (v) {
        	carModelHash[v.id] = v;
        });
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
	var el = e.sender;
	if(el)
	{    
		el.setInputStyle("text-align:left;");
		el.setFormat("");
	}
}

function onLeftGridRowClick(e)
{
	var row = leftGrid.getSelected();
	if(row)
	{
		basicInfoForm.clear();
		basicInfoForm1.clear();
		basicInfoForm.setData(row);
		basicInfoForm1.setData(row);
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
	basicInfoForm1.clear();
	rightItemGrid.clearRows();
	rightPartGrid.clearRows();
	var data = {
		amount:0,
		total:0
	};
	//设置原始数据
	basicInfoForm.setData(data);
	//basicInfoForm1.setData(data1);
}
var saveUrl = baseUrl + "com.hsapi.repair.baseData.rpb_package.savePackage.biz.ext";
function save()
{
	var data = basicInfoForm.getData();
	var data1 = basicInfoForm1.getData();
	data.advisorDeductType=data1.advisorDeductType;
	data.advisorDeductValue=data1.advisorDeductValue;
	data.salesDeductType=data1.salesDeductType;
	data.salesDeductValue=data1.salesDeductValue;
	data.techDeductType=data1.techDeductType;
	data.techDeductValue=data1.techDeductValue;

	var partList = rightPartGrid.getData();
	var i,tmp;
	var total = 0;
	for(i=0;i<partList.length;i++)
	{
		tmp = partList[i];
		total += tmp.amt;
	}
	var insParts = partList.filter(function(v){
		return !v.packageId;
	});
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
		el : document.body,
		cls : 'mini-mask-loading',
		html : '保存中...'
	});
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
				basicInfoForm1.clear();
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
		var row = rightItemGrid.findRow(function(row) {
			if (row.partId == part.id) {
				return true;
			}
			return false;
		});
		if(row && row.partId){
			showMsg("套餐已经包含此配件!","W");
			return;
		}
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
var techDeductTypeName=null;
function addItem()
{
	selectItem(function(data)
	{
		var item = data.item;
		var row = rightItemGrid.findRow(function(row) {
			if (row.itemId == item.id) {
				return true;
			}
			return false;
		});
		if(row && row.itemId){
			showMsg("套餐已经包含此工时!","W");
			return;
		}

		var packageItem = {
			itemId:item.id,
			itemCode:item.code,
			itemName:item.name,
			itemTime:item.itemTime,
			itemKind:item.itemKind,
			type:item.type,
			serviceTypeId:item.serviceTypeId,
			itemKindName:item.itemKindName,
			unitPrice:item.unitPrice,
			amt:item.amt,
			techDeductType:item.techDeductType,
			techDeductTypeName:techDeductTypeName,
			techDeductValue:item.techDeductValue
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
function onDrawCell(e){
	var hash = new Array("按原价比例(%)", "按折后价比例(%)", "按产值比例(%)","固定金额(元)");
	switch (e.field) {
	case "techDeductType":
		e.cellHtml = hash[e.value - 1];
		break;
	}
	if (e.field == "serviceTypeId") {
        if (servieTypeHash && servieTypeHash[e.value]) {
            e.cellHtml = servieTypeHash[e.value].name;
        }
    }else if (e.field == "type") {
        if (typeHash && typeHash[e.value]) {
            e.cellHtml = typeHash[e.value].name;
        }
    }	
}
