var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var basicInfoForm = null;

var requiredField = {
	code: "项目编码",
	itemKind: "工种",
	name: "项目名称",
	type: "项目类型",
	carBrandId: "品牌",
	carSeriesId: "车型"
};
$(document).ready(function(){

});
var carBrandIdEl = null;
var carSeriesIdEl = null;
var carSeriesIdHash = {};
function init(callback)
{
	basicInfoForm = new nui.Form("#basicInfoForm");
	carBrandIdEl = nui.get("carBrandId");
	carSeriesIdEl = nui.get("carSeriesId");
	carBrandIdEl.on("valuechanged",function()
	{
		var carBrandId = carBrandIdEl.getValue();
		if(carSeriesIdHash[carBrandId])
		{
			carSeriesIdEl.setData(carSeriesIdHash[carBrandId]);
		}
		else
		{
			getCarSeriesByBrandId(carBrandId,function(data)
			{
				var list = data.list||[];
				carSeriesIdHash[carBrandId] = list;
				carSeriesIdEl.setData(carSeriesIdHash[carBrandId]);
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
	}

	
}
var saveUrl = baseUrl+"";
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
