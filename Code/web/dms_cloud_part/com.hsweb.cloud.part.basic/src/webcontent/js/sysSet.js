/**
 * Created by Administrator on 2018/5/4.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var queryUrl = baseUrl
		+ "com.hsapi.cloud.part.baseDataCrud.query.queryComCompany.biz.ext";

var comForm = null;
var ynData = [{id:"0",text:"否"},{id:"1",text:"是"}];
var provinceHash = null;
var cityHash = null;
var countyHash = null;
var provinceEl = null;
var cityEl = null;
var countyEl = null;
var streetAddressEl = null;
var addressEl = null;
var compInfo =null;

$(document).ready(function(v) {
	comForm = new nui.Form("#comForm");
	cityEl = nui.get("cityId");
	provinceEl = nui.get("provinceId");
	
	countyEl = nui.get("countyId");
	streetAddressEl = nui.get("streetAddress");
	addressEl = nui.get("address");
	
	getProvinceAndCity(function(data)
    {
        var province = data.province;
        var city = data.city;
        cityList = city;
//        tree.loadList(province.concat(city),"code","parentid");
        provinceEl = nui.get("provinceId");
        provinceEl.setData(province);
        cityEl.setData(cityList);
    });

	getRegion(null,function(data) {
		provinceHash = data.rs || [];
		provinceEl.setData(provinceHash);

	});

	var comp = {orgid: currOrgId};
	quickComp(comp);
});
function setInitData(el, value){
	getRegion(value,function(data) {
		hash = data.rs || [];
		el.setData(hash);
		if(!countyEl.value){
			countyEl.setValue(compInfo.countyId);
		}
	});
}
function onProvinceChange(e){
	var value = e.value;
	cityEl.setValue(null);
	countyEl.setValue(null);
	getRegion(value,function(data) {
		cityHash = data.rs || [];
		cityEl.setData(cityHash);

	});
	setAddress();
}
function onCityChange(e){
	var value = e.value;
	countyEl.setValue(null);
	getRegion(value,function(data) {
		countyHash = data.rs || [];
		countyEl.setData(countyHash);

	});
	setAddress();
}
function onCountyChange(e){
	setAddress();
}
function onStreetChange(e){
	setAddress();
}
function setAddress() {
	var provinceT = provinceEl.getText()||'';
	var cityT = cityEl.getText()||'';
	var countyT = countyEl.getText()||'';
	var streetAddressT = streetAddressEl.getValue()||'';
	var address = provinceT + cityT + countyT + streetAddressT;
	addressEl.setValue(address);
	addressEl.getValue();
}
function quickComp(comp){
	nui.ajax({
		url : queryUrl,
		type : "post",
		data : {
			comp: comp,
			token: token
		},
		success : function(data) {
		    compInfo = data.comp;
			if(compInfo){
				comForm.setData(compInfo);
				setInitData(provinceEl, null);
				provinceEl.setValue(compInfo.provinceId);
				setInitData(cityEl, compInfo.provinceId);
				setInitData(countyEl, compInfo.cityId);
			}else{
            	//初始化新增数据
            	nui.get("isOpenSystem").setValue(0);
            	nui.get("isOpenProcess").setValue(0);
            	nui.get("isUnifyFinancial").setValue(0);
            	nui.get("isAccount").setValue(0);
            	nui.get("isDataShare").setValue(1);
            	nui.get("orgid").setValue(currOrgId);
			}

		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
}

var requiredField = {
	code : "编码",
	name : "公司全称",
	shortName : "公司简称",
	tel : "联系电话",
	provinceId : "省",
	cityId : "市",
	countyId : "乡/镇",
	streetAddress : "详细地址"
};
function checkValidate(){
	comForm.validate();
	return comForm.isValid();
}
function onFloatValidate(e) {
    if (!e.isValid) {
        e.errorText = "请输入数字";
        e.isValid = false;  
    }
}

var saveUrl = baseUrl
		+ "com.hsapi.cloud.part.baseDataCrud.crud.saveComCompany.biz.ext";
function save() {
	var check = checkValidate();
    if(!check) return;

	var data = comForm.getData();
	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
			showMsg(requiredField[key] + "不能为空!","W");

			return;
		}
	}

	if (data.modifyDate) {
		data.modifyDate = format(data.modifyDate, 'yyyy-MM-dd HH:mm:ss')
				+ '.0';// 用于后台判断数据是否在其他地方已修改
		// data.versionNo = format(data.versionNo, 'yyyy-MM-dd HH:mm:ss');
	}


	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '保存中...'
	});

	nui.ajax({
		url : saveUrl,
		type : "post",
		data : {
			comCompany: data,
			token: token
		},
		success : function(data) {
			nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
				showMsg("保存成功!","S");
				var comCompany = data.comCompany;
				comForm.setData(comCompany);
			} else {
				showMsg(data.errMsg || "保存失败!","E");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}

var getRegionUrl = apiPath + sysApi + "/" + "com.hs.common.region.getRegin.biz.ext";
function getRegion(parentId,callback) {
	nui.ajax({
		url : getRegionUrl,
		data : {
			token: token, 
			parentId: parentId
		},
		type : "post",
		success : function(data) {
			if (data && data.rs) {
				callback && callback(data);
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			//  nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
	/*
	 * data : JSON.stringify({
			token: token, 
			parentId: parentId
		})
	 * */
}