



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
	data.orgid = currOrgId;
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


var getStorehouseUrl = window._rootPartUrl
		+ "com.hsapi.part.baseDataCrud.crud.getStorehouse.biz.ext";
var getMemStorehouseUrl = apiPath + sysApi + "/com.hsapi.system.tenant.employee.queryMemStore.biz.ext";
function getStorehouse(callback) {
	var url = getStorehouseUrl;
	if(currRepairStoreControlFlag == "1") {
		url = getMemStorehouseUrl;
	}
	doPost({
		url : url,
		data : {token: token},
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
var getCarVinModelUrl = window._rootSysUrl + "com.hsapi.system.product.cars.carVinModel.biz.ext";
function getCarVinModel(vin, callback) {
	var params = {};
	params.vin = vin;
	doPost({
		url : getCarVinModelUrl,
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
var dictField = ["prebookCategory","prebookItem","insuranceId","type","claimsType","bookStatus","receTypeId","mtType","itemKind","serviceTypeId","guestSource","scoutMode","isUsabled","noMtType"];
dictField.push("insuranceType");
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

var getAllPartBrandUrl = window._rootPartUrl
+ "com.hsapi.part.common.svr.getAllPartBrand.biz.ext";
function getAllPartBrand(callback)
{
nui.ajax({
    url: getAllPartBrandUrl,
    data : {token: token},
    type:"post",
    async:false,
    success:function(data)
    {
        if(data && data.quality && data.brand)
        {
            callback && callback(data);
        }
    },
    error:function(jqXHR, textStatus, errorThrown){
        //  nui.alert(jqXHR.responseText);
        console.log(jqXHR.responseText);
    }
});
}

var getAllPartTypeUrl=window._rootUrl
+ "com.hsapi.system.dict.dictMgr.queryPartType.biz.ext";
function getAllPartType(callback)
{
	doPost({		
		url : getAllPartTypeUrl,
		async: false,
		success : function(data) {
			if (data && data.partTypes) {
				callback && callback(data);    
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			//  nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}

var getStockmanUrl = apiPath + sysApi + "/com.hsapi.system.tenant.employee.queryStockman.biz.ext";
function getStockman(callback) {
	doPost({
		url : getStockmanUrl,
		data : {token: token},
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

var getWorkTeamUrl = apiPath + repairApi + "/com.hsapi.repair.baseData.team.queryWorkTeam.biz.ext";
function getWorkTeam(callback) {
	doPost({
		url : getWorkTeamUrl,
		data : {token: token},
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

var getMtadvisorUrl = apiPath + sysApi + "/com.hsapi.system.dict.org.queryMember.biz.ext";
function getMtadvisor(callback) {
	doPost({
		url : getMtadvisorUrl,
		data : {isMtadvisor:1, token: token},
		success : function(data) {
			callback && callback(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
			callback && callback({});
		}
	});
}

var getCarVerificationDateUrl = apiPath + repairApi + "/com.hsapi.repair.common.common.getCarVerificationDate.biz.ext";
function getCarVerificationDate(regDate, callback) {
	doPost({
		url : getCarVerificationDateUrl,
		data : {regDate:regDate, token: token},
		success : function(data) {
			callback && callback(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
			callback && callback({});
		}
	});
}
