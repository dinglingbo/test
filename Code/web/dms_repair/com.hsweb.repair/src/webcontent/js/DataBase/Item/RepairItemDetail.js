var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var basicInfoForm = null;
var deductForm = null;
var salesDeductTypeEl = null;
var techDeductTypeEl = null;
var advisorDeductTypeEl = null;

var requiredField = {
	name: "工时名称",
	type: "工时类型",
	code: "工时编码"
	//carBrandId: "品牌"
	//carModelId: "车型"
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
var carBrandIdEl;
var carSeriesId;
var carModelIdEl;
var carModelIdHash = {};
function init(callback)
{
	basicInfoForm = new nui.Form("#basicInfoForm");
	deductForm = new nui.Form("#deductForm");
	carBrandIdEl = nui.get("carBrandId");
    carSeriesId = nui.get("carSeriesId");
	carModelIdEl = nui.get("carModelId");
	salesDeductTypeEl = nui.get("salesDeductType");
	techDeductTypeEl = nui.get("techDeductType");
	advisorDeductTypeEl = nui.get("advisorDeductType");
	salesDeductTypeEl.setData(typeList);
	techDeductTypeEl.setData(typeList);
	advisorDeductTypeEl.setData(typeList);
	
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
var typeList = [{id:"1",text:"按原价比例"},{id:"2",text:"按折后价比例"},{id:"3",text:"按产值比例"},{id:"4",text:"固定金额"}];
function setData(data)
{
	init();
	data = data||{};
	if(data.typeList)
	{//项目类型
		var typeList = data.typeList;
		var typeItemList = [];
		for(var i=0; i<typeList.length; i++){
			var type = typeList[i].type;
			if(type == 'item'){
				typeItemList.push(typeList[i]);
			}
		}
		nui.get("type").setData(typeItemList);
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
		deductForm.setData(item);
		carBrandIdEl.doValueChanged();
        carSeriesId.doValueChanged();
	}

	
}
var saveUrl = baseUrl+"com.hsapi.repair.baseData.item.saveRpbItem.biz.ext";
function onOk(){
	var data = basicInfoForm.getData();
	if(data.id){
		var row = leftGrid.getSelected();
		var orgid = row.orgid||0;
		if(orgid != currOrgId){
			showMsg("只能修改本店套餐!",);
			return;
		}
	}
	for(var key in requiredField){
		if(!data[key] || data[key].trim().length==0)
        {
            showMsg(requiredField[key]+"不能为空", "W");
            return;
        }
	}

	deductForm.validate();
    if (deductForm.isValid() == false) {
        return;
	}

	var deData = deductForm.getData();
	for(var key in deData){
		data[key] = deData[key];
	}
	
	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '保存中...'
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
				showMsg("保存成功");
				CloseWindow("ok");
			}
			else{
				showMsg(data.errMsg||"保存失败", "E");
			}
		},
		error:function(jqXHR, textStatus, errorThrown)
		{
			console.log(jqXHR.responseText);
			nui.unmask();
			showMsg("网络出错", "E");
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
				//var reg=/(^[1-9][0-9]$|^[0-9]$|^100$)/;
				var reg=/^(\d|[1-9]\d)(\.\d{1,2})?$|100$/;
				if (!reg.test(e.value)) {
					e.errorText = "请输入0~100的数,最多可保留两位小数";
					e.isValid = false;
					showMsg("请输入0~100的数,最多可保留两位小数","W");
				}
			}
		}
	}else if(el == "techDeductValue"){
		value = techDeductTypeEl.getValue();
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
				var reg=/^(\d|[1-9]\d)(\.\d{1,2})?$|100$/;
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
				var reg=/^(\d|[1-9]\d)(\.\d{1,2})?$|100$/;
				if (!reg.test(e.value)) {
					e.errorText = "请输入0~100的数,最多可保留两位小数";
					e.isValid = false;
					showMsg("请输入0~100的数,最多可保留两位小数","W");
				}
			}
		}
	}


}
function calc(type){
    var itemTime = nui.get("itemTime").getValue();
    var unitPrice = nui.get("unitPrice").getValue();
    var amt = nui.get("amt").getValue();
    
    if(itemTime == null || itemTime == '') {
        nui.get("itemTime").setValue(0);
    }else if(itemTime < 0) {
        nui.get("itemTime").setValue(0);
    }
    
    if(unitPrice == null || unitPrice == '') {
        nui.get("unitPrice").setValue(0);
    }else if(unitPrice < 0) {
        nui.get("unitPrice").setValue(0);
    }
    
    if(amt == null || amt == '') {
        nui.get("amt").setValue(0);
    }else if(amt < 0) {
        nui.get("amt").setValue(0);
    }
    
    itemTime = nui.get("itemTime").getValue();
    unitPrice = nui.get("unitPrice").getValue();
    amt = nui.get("amt").getValue();
    
    if(type == 'itemTime'){
        nui.get("amt").setValue(itemTime * unitPrice);
    }
    
    if(type == 'unitPrice'){
        nui.get("amt").setValue(itemTime * unitPrice);
    }
    
    if(type == 'amt'){
        if(itemTime > 0) {
            unitPrice = (amt / itemTime).toFixed(2);
            nui.get("unitPrice").setValue(unitPrice);
        }else {
            nui.get("itemTime").setValue(0);
            nui.get("amt").setValue(0);
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