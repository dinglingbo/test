
/**
 * 
 */
function doPost(opt) {
	var url = opt.url;
	var data = opt.data;
	var success = opt.success || function() {
	};
	var error = opt.error || function() {
	};
	data.orgid = currOrgid;
	data.userName = currUserName;
	data.token = token;
	nui.ajax({
		url : url,
		type : "post",
		data : JSON.stringify(data),
		success : success,
		error : error
	});
}
var provinceHash = {};
var provinceList = [];
var cityHash = {};
var cityList = [];
var provinceEl = null;
var cityEl = null;
function onProvinceSelected(cityId) {
	if (provinceEl) {
		cityEl = nui.get(cityId);
		var id = provinceEl.getValue();
		var currCityList = cityList.filter(function(v) {
			return v.provinceId == id;
		});
		cityEl.setData(currCityList);
	}
}
var getStorehouseUrl = window._rootPartUrl
		+ "com.hsapi.part.baseDataCrud.crud.getStorehouse.biz.ext";
function getStorehouse(callback) {
	doPost({
		url : getStorehouseUrl,
		data : {},
		success : function(data) {
			callback && callback(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
			callback && callback({});
		}
	});
}
var getDatadictionariesUrl = window._rootUrl
		+ "com.hsapi.repair.common.common.getDatadictionaries.biz.ext";
function getDatadictionaries(parentId, callback) {
	var params = {};
	params.parentId = parentId;
	doPost({
		url : getDatadictionariesUrl,
		data : params,
		success : function(data) 
		{
			var list = data.list||[];
			setDataToHash(list,"dict","customid");
			callback && callback(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
			callback && callback({});
		}
	});
}

var getDictItemsUrl = window._rootUrl
		+ "com.hsapi.repair.common.common.getDictItems.biz.ext";
function getDictItems(dictIdList, callback) {
	var params = {};
	params.dictIdList = dictIdList;
	doPost({
		url : getDictItemsUrl,
		data : params,
		success : function(data) {
			callback && callback(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}
var getProvinceAndCityUrl = window._rootUrl
		+ "com.hsapi.repair.common.common.getProvinceAndCity.biz.ext";
function getProvinceAndCity(callback) {
	nui.ajax({
		url : getProvinceAndCityUrl,
		type : "post",
		success : function(data) {
			if (data) {
				callback && callback(data);
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}

var getAllCarBrandUrl = window._rootPartUrl
		+ "com.hsapi.part.common.svr.getAllCarBrand.biz.ext";
function getAllCarBrand(callback) {
	doPost({
		url : getAllCarBrandUrl,
		data : {},
		success : function(data) {
			callback && callback(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
			callback && callback({});
		}
	});
}
var getCarSeriesByBrandIdUrl = window._rootUrl
		+ "com.hsapi.repair.common.common.getCarSeriesByBrandId.biz.ext";
function getCarSeriesByBrandId(brandId, callback) {
	var params = {};
	params.brandId = brandId;
	doPost({
		url : getCarSeriesByBrandIdUrl,
		data : params,
		success : function(data) {
			callback && callback(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
			callback && callback(null);
		}
	});
}
var getCarModelByBrandIdUrl = window._rootUrl
		+ "com.hsapi.repair.common.common.getCarModelByBrandId.biz.ext";
function getCarModelByBrandId(brandId, callback, carModelId) {
	var params = {};
	params.brandId = brandId;
	if (carModelId) {
		params.carModelId = carModelId;
	}
	doPost({
		url : getCarModelByBrandIdUrl,
		data : params,
		success : function(data) {
			callback && callback(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
			callback && callback(null);
		}
	});
}
function selectCarModel(elId, carBrandId, carModelId) {
	nui.open({
		targetWindow : window,
		url : "com.hsweb.repair.common.carModelSelect.flow",
		title : "选择车型",
		width : 900,
		height : 600,
		allowDrag : true,
		allowResize : false,
		onload : function() {
		},
		ondestroy : function(action) {
			if (action == "ok") {
				var iframe = this.getIFrameEl();
				var data = iframe.contentWindow.getData();
				if (data && data.carModel) {
					var carModel = data.carModel || {};
					if (elId && nui.get(elId)) {
						nui.get(elId).setValue(carModel.id);
						nui.get(elId).setText(carModel.carModel);
					}
					if (carBrandId && nui.get(carBrandId)) {
						nui.get(carBrandId).setValue(carModel.carBrandId);
						if (nui.get(carBrandId).doValueChanged) {
							nui.get(carBrandId).doValueChanged();
						}
					}
					if (carModelId && nui.get(carModelId)) {
						nui.get(carModelId).setValue(carModel.id);
					}
				}
			}
		}
	});
}
var getAllInsuranceCompanyUrl = window._rootUrl
		+ "com.hsapi.repair.common.svr.getAllInsuranceCompany.biz.ext";
function getAllInsuranceCompany(callback) {
	var params = {};
	doPost({
		url : getAllInsuranceCompanyUrl,
		data : params,
		success : function(data) {
			callback && callback(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
			callback && callback(null);
		}
	});
}
var getCompBillNOUrl = window._rootSysUrl
		+ "com.hs.common.uniq.getCompBillNO.biz.ext";
function getCompBillNO(billTypeCode, callback) {
	var params = {};
	params.billTypeCode = billTypeCode;
	params.orgid = currOrgid;
	doPost({
		url : getCompBillNOUrl,
		data : params,
		success : function(data) {
			callback && callback(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
			callback && callback(null);
		}
	});
}
var getRoleMemberUrl = window._rootPartUrl
		+ "com.hsapi.part.common.svr.getRoleMemberByRoleId.biz.ext";
function getRoleMember(roleId, callback) {
	var params = {};
	params.roleId = roleId;
	doPost({
		url : getRoleMemberUrl,
		data : params,
		success : function(data) {
			callback && callback(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
			callback && callback(null);
		}
	});
}
var getTeamByTypeListUrl = window._rootUrl
		+ "com.hsapi.repair.baseData.team.getTeamByTypeList.biz.ext";
function getTeamByTypeList(typeList, callback) {
	var params = {};
	params.type = typeList;
	doPost({
		url : getTeamByTypeListUrl,
		data : params,
		success : function(data) {
			callback && callback(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
			callback && callback(null);
		}
	});
}
var getTeamMemberByTeamIdListUrl = window._rootUrl
		+ "com.hsapi.repair.baseData.team.getTeamMemberByTeamIdList.biz.ext";
function getTeamMemberByTeamIdList(idList, callback) {
	var params = {};
	params.idList = idList;
	doPost({
		url : getTeamMemberByTeamIdListUrl,
		data : params,
		success : function(data) {
			callback && callback(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
			callback && callback(null);
		}
	});
}
var getOrgListUrl = window._rootPartUrl
		+ "com.hsapi.part.common.svr.getOrgList.biz.ext";
function getOrgList(callback) {
	doPost({
		url : getOrgListUrl,
		data : {},
		success : function(data) {
			callback && callback(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
			callback && callback(null);
		}
	});
}
var getDeductRateUrl = window._rootUrl
		+ "com.hsapi.repair.common.svr.getDeductRate.biz.ext";
function getDeductRate(itemKindList, callback) {
	var params = {};
	doPost({
		url : getDeductRateUrl,
		data : params,
		success : function(data) {
			callback && callback(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
			callback && callback(null);
		}
	});
}
var getCarVinModelUrl = window._rootUrl
		+ "com.hsapi.system.product.cars.carVinModel.biz.ext";
function getCarVinModel(vin, callback) {
	var params = {};
	params.vin = vin;
	doPost({
		url : getCarVinModelUrl,
		data : params,
		success : function(data) {
			// data.rs;
			callback && callback(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
			callback && callback(null);
		}
	});
}
var dictField = ["receTypeId","mtType","itemKind","serviceTypeId","guestSource"];
function onDrawCell(e) {
	var hash = _initDmsHash || {};
	var field = e.field;
	var value = e.value;
	if (field == "carBrandId") {// 车辆品牌
		var carBrand = hash.carBrand || {};
		carBrand[value] && (e.cellHtml = carBrand[value].nameCn);
	} else if (dictField.indexOf(field) > -1) {
		var dict = hash.dict || {};
		dict[value] && (e.cellHtml = dict[value].name);
	}
	else if(field == "orgid")
	{
		var comp = hash.comp || {};
		comp[value] && (e.cellHtml = comp[value].orgname);
	}
	else if(field == "insureCompCode")
	{
		var insureComp = hash.insureComp || {};
		insureComp[value] && (e.cellHtml = insureComp[value].fullName);
	}
}