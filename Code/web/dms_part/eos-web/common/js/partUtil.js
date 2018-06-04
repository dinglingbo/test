



/**
 * 
 */
function doPost(opt) {
	var url = opt.url;
	var data = opt.data||{};
	var success = opt.success || function() {
	};
	var error = opt.error || function() {
	};
	data.userId = currUserId;
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
function getRoot() {
	var hostname = location.hostname;
	var pathname = location.pathname;
	var contextPath = pathname.split("/")[1];
	var port = location.port;
	var protocol = location.protocol;
	return protocol + "//" + hostname + ":" + port + "/" + contextPath
		+ "/";
}

window._rootUrl = apiPath + partApi + "/";
//console.log(window._rootUrl);

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
		var code = provinceHash[id].code;
		var currCityList = cityList.filter(function(v) {
			return v.parentid == code;
		});
		cityEl.setData(currCityList);
	}
}

var getDictItemsUrl = window._rootUrl
	+ "com.hsapi.part.common.svr.getDictItems.biz.ext";
function getDictItems(dictIdList, callback) {
	var params = {};
	params.dictIdList = dictIdList;
	doPost({
		url : getDictItemsUrl,
		data : params,
		success : function(data) {
			if (data && data.dataItems) {
				callback && callback({
					code : "S",
					dataItems : data.dataItems
				});
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			//  nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}
var getProvinceAndCityUrl = window._rootUrl
	+ "com.hsapi.part.common.svr.getProvinceAndCity.biz.ext";
function getProvinceAndCity(callback) {
	if (!provinceHash) {
		provinceHash = {};
	}
	if (!cityHash) {
		cityHash = {};
	}
	if (window.top._provinceList && window.top._cityList) {
		provinceList = window.top._provinceList;
		cityList = window.top._cityList;
		provinceList.forEach(function(v) {
			provinceHash[v.code] = v;
		});
		cityList.forEach(function(v) {
			cityHash[v.code] = v;
		});
		if (provinceEl) {
			provinceEl.setData(provinceList);
		}
		callback && callback({
			province : provinceList,
			city : cityList
		});
		console.log("getProvinceAndCity from client");
		return;
	}
	doPost({
		url : getProvinceAndCityUrl,
		data:{},
		success : function(data) {
			if (data && data.province) {
				window.top._provinceList = data.province;
				provinceList = window.top._provinceList;
				window.top._cityList = data.city;
				provinceList.forEach(function(v) {
					provinceHash[v.code] = v;
				});
				if (provinceEl) {
					provinceEl.setData(provinceList);
				}
				cityList = window.top._cityList;
				cityList.forEach(function(v) {
					cityHash[v.code] = v;
				});
				callback && callback(data);
			//	console.log("getProvinceAndCity from server");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			//  nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}
var getStorehouseUrl = window._rootUrl
	+ "com.hsapi.part.baseDataCrud.crud.getStorehouse.biz.ext";
function getStorehouse(callback) {
	doPost({
		url : getStorehouseUrl,
		success : function(data) {
			if (data && data.storehouse) {
				callback && callback(data);
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			//  nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}
var getAllCarBrandUrl = window._rootUrl
	+ "com.hsapi.part.common.svr.getAllCarBrand.biz.ext";
function getAllCarBrand(callback) {
	doPost({
		url : getAllCarBrandUrl,
		success : function(data) {
			if (data && data.carBrands) {
				callback && callback(data);
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			//  nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}
var getAllPartBrandUrl = window._rootUrl
	+ "com.hsapi.part.common.svr.getAllPartBrand.biz.ext";
function getAllPartBrand(callback) {
	doPost({
		url : getAllPartBrandUrl,
		success : function(data) {
			if (data && data.quality && data.brand) {
				callback && callback(data);
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			//  nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}
var getPartByIdUrl = window._rootUrl
	+ "com.hsapi.part.baseDataCrud.crud.getPartById.biz.ext";
function getPartById(id, callback) {
	var params = {};
	params.id = id;
	doPost({
		url : getPartByIdUrl,
		data : {
			id: id
		},
		success : function(data) {
			callback && callback(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			//  nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}
var getOrgListUrl = window._rootUrl
	+ "com.hsapi.part.common.svr.getOrgList.biz.ext";
function getOrgList(callback) {
	doPost({
		url : getOrgListUrl,
		success : function(data) {
			if (data && data.orgList) {
				callback && callback({
					code : "S",
					orgList : data.orgList
				});
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			//  nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}
var getRoleMemberUrl = window._rootUrl
	+ "com.hsapi.part.common.svr.getRoleMemberByRoleId.biz.ext";
function getRoleMember(roleId, callback) {
	var params = {};
	params.roleId = roleId;
	doPost({
		url : getRoleMemberUrl,
		data : JSON.stringify(params),
		success : function(data) {
			callback && callback(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			//  nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}

function selectOrg(elId, orgcodeEl) {
	nui.open({
		targetWindow : window,
		url : "com.hsweb.part.common.orgSelect.flow",
		title : "请选择公司",
		width : 200,
		height : 300,
		allowDrag : true,
		allowResize : false,
		onload : function() {
		},
		ondestroy : function(action) {
			if (action == "ok") {
				var iframe = this.getIFrameEl();
				var data = iframe.contentWindow.getData();
				if (data && data.org && data.org.orgid) {
					var org = data.org || {};
					if (elId && nui.get(elId)) {
						nui.get(elId).setValue(org.orgid);
						nui.get(elId).setText(org.orgname);
					}
					if (orgcodeEl && nui.get(orgcodeEl)) {
						nui.get(orgcodeEl).setValue(org.orgcode);
					}

				}
			}
		}
	});
}

var supplier = null;
function selectSupplier(elId, billTypeId, settTypeId) {
	supplier = null;
	nui.open({
		targetWindow : window,
		url : "com.hsweb.part.common.supplierSelect.flow",
		title : "供应商资料",
		width : 980,
		height : 560,
		allowDrag : true,
		allowResize : true,
		onload : function() {

		},
		ondestroy : function(action) {
			if (action == 'ok') {
				var iframe = this.getIFrameEl();
				var data = iframe.contentWindow.getData();
				console.log(data);
				console.log(elId);
				supplier = data.supplier;
				var value = supplier.id;
				var text = supplier.fullName;
				var el = nui.get(elId);
				el.setValue(value);
				el.setText(text);
				if (nui.get(billTypeId) && supplier.billTypeId) {
					nui.get(billTypeId).setValue(supplier.billTypeId);
					nui.get(billTypeId).doValueChanged();
				}
				if (nui.get(settTypeId) && supplier.settTypeId) {
					nui.get(settTypeId).setValue(supplier.settTypeId);
				}
			}
		}
	});
}
var getLocationListByStoreIdUrl = window._rootUrl
	+ "com.hsapi.part.common.svr.getLocationListByStoreId.biz.ext";
var locationListHash = window.parent.locationListHash || {};
function getLocationListByStoreId(storeId, callback) {
	if (locationListHash[storeId]) {
		callback && callback({
			locationList : locationListHash[storeId]
		});
		return;
	}
	var params = {};
	params.storeId = storeId;
	doPost({
		url : getLocationListByStoreIdUrl,
		type : "post",
		data : JSON.stringify(params),
		success : function(data) {
			if (data && data.locationList) {
				var list = data.locationList;
				locationListHash[storeId] = list;
				callback && callback({
					locationList : list
				});
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			//  nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}
var getCompBillNOUrl = window._rootSysUrl + "com.hs.common.uniq.getCompBillNO.biz.ext";
function getCompBillNO(billTypeCode, callback) {
	var params = {};
	params.billTypeCode = billTypeCode;
	params.orgid = currOrgid;
	doPost({
		url : getCompBillNOUrl,
		data : JSON.stringify(params),
		success : function(data) {
			callback && callback(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			//  nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}
var dictField = ["enterTypeId","settType","settTypeId","billTypeId","managerDuty","guestType","supplierType"];
dictField.push("backReasonId");
var insureField = ["insureCompCode","insuranceSaliComany","insuranceBizComany"];
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
	else if (insureField.indexOf(field) > -1)
	{
		var insureComp = hash.insureComp || {};
		insureComp[value] && (e.cellHtml = insureComp[value].fullName);
	}
}
function getDate(type)
{
	var now = (new Date(currentTimeMillis));
    var year = now.getFullYear();
    var month = now.getMonth();
    var date = now.getDate();
    var startDate,endDate;
    switch(type)
    {
    	case 0://本日
    		startDate = new Date(now);
            endDate = new Date(now);
    		break;
    	case 1://昨日
    		startDate = new Date(now);
    		startDate.setDate(startDate.getDate()-1);
            endDate = startDate;
    		break;
    	case 2://本周
    		startDate = new Date(now);
    		startDate.setDate(startDate.getDate()-startDate.getDay());
            endDate = new Date(now);
            endDate.setDate(endDate.getDate()-endDate.getDay()+6);
    		break;
    	case 3://上周
    		startDate = new Date(now);
    		startDate.setDate(startDate.getDate()-startDate.getDay()-7);
    		endDate = new Date(now);
    		endDate.setDate(endDate.getDate()-endDate.getDay()-1);
    		break;
        case 4://本月
            startDate = new Date(year,month,1);
            endDate = new Date(year,month+1,0);
            break;
        case 5://上月
            startDate = new Date(year,month-1,1);
            endDate = new Date(year,month,0);
            break;
        case 6://本年
            startDate = new Date(year,0,1);
            endDate = new Date(year,12,0);
            break;
        case 7://上年
        	startDate = new Date(year-1,0,1);
            endDate = new Date(year-1,12,0);
            break;
    }
    return {
    	startDate:startDate,
    	endDate:endDate
    };
}
function SelectCustomer(params)
{
    nui.open({
        url: window._webRepairUrl+"com.hsweb.RepairBusiness.Customer.flow",
        title: "客户选择", width: 800, height: 450,
        onload: function () {
        },
        ondestroy: function (action) {
            if ("ok" == action) {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                var guest = data.guest;
                var name = guest.guestFullName;
                for(var key in params)
                {
                    if(params[key] && nui.get(params[key]))
                    {
                        nui.get(params[key]).setValue(guest[key]);
                    }
                }
                var tmp = nui.get(params["guestId"]);
                tmp && tmp.setText && tmp.setText(name);
            }
        }
    });
}