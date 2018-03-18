var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var basicInfoForm = null;

var requiredField = {
	code: "项目编码",
	itemKind: "工种",
	name: "项目名称",
	type: "项目类型",
	carBrandId: "品牌",
	carModelId: "车型"
};
$(document).ready(function(){

});
function onInputFocus(e)
{
	var el = e.sender;
	el.setInputStyle("text-align:left;");
}
function onInputBlur(e)
{
	var el = e.sender;
	el.setInputStyle("text-align:right;");
}
var carBrandIdEl = null;
var carModelIdEl = null;
var carModelIdHash = {};
function init(callback)
{
	basicInfoForm = new nui.Form("#basicInfoForm");
	carBrandIdEl = nui.get("carBrandId");
	carModelIdEl = nui.get("carModelId");
	carBrandIdEl.on("valuechanged",function()
	{
		var carBrandId = carBrandIdEl.getValue();
		if(carModelIdHash[carBrandId])
		{
			carModelIdEl.setData(carModelIdHash[carBrandId]);
		}
		else
		{
			getCarModelByBrandId(carBrandId,function(data)
			{
				var list = data.list||[];
				carModelIdHash[carBrandId] = list;
				carModelIdEl.setData(carModelIdHash[carBrandId]);
			});
		}
	});
	var elList = basicInfoForm.getFields();
	var nameList = ["itemTime","unitPrice","deductAmt","amt"];
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
}
function setData(data)
{
	init();
	data = data||{};
	if(data.typeList)
	{//项目类型
		var typeList = data.typeList;
		nui.get("type").setData(typeList);
	}
	if(data.itemKindList)
	{//工种
		var itemKindList = data.itemKindList;
		nui.get("itemKind").setData(itemKindList);
	}
	if(data.carBrandIdList)
	{//品牌
		var carBrandIdList = data.carBrandIdList;
		carBrandIdEl.setData(carBrandIdList);
	}
	if(data.item)
	{
		var item = data.item;
		basicInfoForm.setData(item);
		carBrandIdEl.doValueChanged();
	}

	
}
var saveUrl = baseUrl+"com.hsapi.repair.baseData.item.saveRpbItem.biz.ext";
function onOk(){
	var data = basicInfoForm.getData();
	console.log(data);
	for(var key in requiredField){
		if(!data[key] || data[key].trim().length==0)
        {
            nui.alert(requiredField[key]+"不能为空");
            return;
        }
	}
	nui.mask({
		html:'保存中..'
	});
	doPost({
		url:saveUrl,
		data:{
			item:data	
		},
		success:function(data)
		{
			nui.unmask();
			data = data||{};
			if(data.errCode == "S")
			{
				nui.alert("保存成功");
				CloseWindow("ok");
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
function CloseWindow(action)
{
	if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else window.close();
}

function onCancel() {
  CloseWindow("cancel");
}
