/*
 *init basic data
 */
//常量
var SERVICE_TYPE = "DDT20130703000055";//业务类型
var ITEM_KIND = "DDT20130703000057";//工种

var MT_TYPE_1 = "DDT20130705000002";//维修类型，普通
var MT_TYPE_2 = "DDT20130705000003";//维修类型，事故
var NO_MT_TYPE_1 = "DDT20130705000008";//未修类型1,流失主要原因
var NO_MT_TYPE_2 = "DDT20130705000009";//未修类型2,流失未修次要原因
var RECE_TYPE_1 = "DDT20130706000013";//收费类型,收费
var RECE_TYPE_2 = "DDT20130706000014";//收费类型,免费

var GUEST_SOURCE = "DDT20130703000075";//客户来源
var BOOK_STATUS = "DDT20130703000059";//预约状态
var PREBOOK_CATEGORY = "DDT20140315000001";//预约分类,
var PREBOOK_ITEM = "DDT20130705000001";//预约项目
var SCOUT_MODE = "DDT20130703000021";//跟进方式
var IS_USABLED = "DDT20130703000081";//跟踪状态
var CLAIMS_TYPE = "DDT20150726000001";//索赔类型
var PKG_TYPE = "DDT20130706000017";//维修套餐类别
var CAR_SPEC = "DDT20130722000001";//车辆规格
var KILO_TYPE = "DDT20130722000002";//里程类别
var IDENTITY = "DDT20130703000077";//客户身份
var INSURANCE_TYPE = "DDT20140427000001";//保险销售分类
var INSURANCE_DETAIL = "DDT20130703000028";//险种
var ENTER_OIL_MASS = "DDT20130703000051";//进厂油量
var BILL_TYPE = "DDT20130703000008";//票据类型
var SETT_TYPE = "DDT20130703000035";//结算方式
var ENTER_TYPE = "DDT20130703000064";//入库类型
var RETURN_TYPE = "DDT20130703000074";//退回原因
var MANAGER_DUTY = "DDT20180105000001";//供应商负责人职务
var GUEST_TYPE = "DDT20130703000084";//对象类型--新增客户
var GUEST_TYPE_S = "DDT20130703000085";//对象类型--新增供应商
var SUPPLIER_TYPE = "DDT20171226000001";//供应商类型
var UNIT = "DDT20130703000016";// --单位
var ABC_TYPE = "DDT20130703000067";// --ABC分类
var OUT_TYPE = "DDT20130703000065";//出库类型
var BACK_REASON = "DDT20130703000072";//采购退货原因
 
var _sysApiRoot = apiPath + sysApi;
var _initDmsObj = {};
var _initDmsCallback = {};
var _initDmsHash = {
	carBrand:{},//车辆品牌
	comp:{},//组织,
	insureComp:{},//保险公司,
	dict:{},//数据字典
	member:{}
};
window._initDmsHash = _initDmsHash;
//公司组织
function initComp(id,callback){
	_initDmsCallback["initComp"] = callback;
    if(checkObjExists(id, "initComp")){
        var url = _sysApiRoot + "/com.hsapi.system.dict.org.getComps.biz.ext";
        callAjax(url, {}, processAjax, processComp, null); 
    }
}
function processComp(data){
    _initDmsObj["initComp"].setData(data);
    setDataToHash(data,"comp","orgid");
    _initDmsCallback["initComp"] && _initDmsCallback["initComp"]() && (_initDmsCallback["initComp"] = null);
}

//车辆品牌
function initCarBrand(id,callback){
	_initDmsCallback["initCarBrand"] = callback;
    if(checkObjExists(id, "initCarBrand")){
        //var url = _sysApiRoot + "/com.hsapi.system.product.cars.carBrand.biz.ext";
        var url = _sysApiRoot + "/com.hsapi.system.dict.dictMgr.queryCarBrand.biz.ext";
        callAjax(url, {}, processAjax, processCarBrand, null); 
    }
}
function processCarBrand(data){
    _initDmsObj["initCarBrand"].setData(data);
    setDataToHash(data,"carBrand","id");
    _initDmsCallback["initCarBrand"] && _initDmsCallback["initCarBrand"]() && (_initDmsCallback["initCarBrand"] = null);
}

//车系
function initCarSeries(id, carBrandId){	
    if(checkObjExists(id, "initCarSeries")){
        var url = _sysApiRoot + "/com.hsapi.system.dict.dictMgr.queryCarSeries.biz.ext";
        var params = {};
        params.carBrandId = carBrandId;
        callAjax(url, params, processAjax, processCarSeries, null); 
    }
}
function processCarSeries(data){
    _initDmsObj["initCarSeries"].setData(data);
    setDataToHash(data,"carSeries","id");
    _initDmsCallback["initCarSeries"] && _initDmsCallback["initCarSeries"]() && (_initDmsCallback["initCarSeries"] = null);    
}

//获取车型(选择品牌触发)
function initCarModel(id, carBrandId){
    if(checkObjExists(id, "initCarModel")){
        var url = _sysApiRoot + "/com.hsapi.system.dict.dictMgr.queryCarModel.biz.ext";
        var params = {};
        params.carBrandId = carBrandId;
        callAjax(url, params, processAjax, processCarModel, null);
    }
}
function processCarModel(data){
    _initDmsObj["initCarModel"].setData(data);
    setDataToHash(data,"carModel","id");
    _initDmsCallback["initCarModel"] && _initDmsCallback["initCarModel"]() && (_initDmsCallback["initCarModel"] = null);        
}


//业务分类
function initServiceType(id, callback){
    _initDmsCallback["initServiceType"] = callback;
    if(checkObjExists(id, "initServiceType")){
        var url = _sysApiRoot + "/com.hsapi.system.dict.dictMgr.queryServiceType.biz.ext";
        callAjax(url, {}, processAjax, processServiceType, null); 
    }
}
function processServiceType(data){
    _initDmsObj["initServiceType"].setData(data);
    setDataToHash(data,"serviceType","id");
    _initDmsCallback["initServiceType"] && _initDmsCallback["initServiceType"]() && (_initDmsCallback["initServiceType"] = null);
}


//保险公司
function initInsureComp(id,callback){ //险种：DDT20130703000028
	_initDmsCallback["initInsureComp"] = callback;
    if(checkObjExists(id, "initInsureComp")){
        var url = _sysApiRoot + "/com.hsapi.system.dict.guestMgr.queryGuest.biz.ext";
        params = {};
        params.guestTypes = "01020104";
        callAjax(url, params, processAjax, processInsureComp, null);  
    }
}
function processInsureComp(data){
    _initDmsObj["initInsureComp"].setData(data);
    setDataToHash(data,"insureComp","id");
    _initDmsCallback["initInsureComp"] && _initDmsCallback["initInsureComp"]() && (_initDmsCallback["initInsureComp"] = null);
}

//数据字典
function initDicts(dictDefs,callback){//dictDefs{id1: dictid1, id2: dictid2}
	_initDmsCallback["initDicts"] = callback;
    var url = _sysApiRoot + "/com.hsapi.system.dict.dictMgr.queryDict.biz.ext";
    params = {};
    params.dictids = filterParam("_dictDefs", dictDefs); 
    callAjax(url, params, processAjax, processDictids, null);
}
function processDictids(data){
    adapterData(_initDmsObj["_dictDefs"], data, "dictid");
    setDataToHash(data,"dict","customid");
    _initDmsCallback["initDicts"]  && _initDmsCallback["initDicts"]() && (_initDmsCallback["initDicts"] = null);
}
//根据customid获取类型下的所有子项
function initCustomDicts(el, customid,callback){//dictDefs{id1: dictid1, id2: dictid2}
	_initDmsCallback["initCustomDicts"] = callback;
	if(checkObjExists(el, "initCustomDicts")){
	    var url = _sysApiRoot + "/com.hsapi.system.dict.dictMgr.queryDictTypeItems.biz.ext";
	    params = {};
	    params.customid = customid; 
	    callAjax(url, params, processAjax, processCustomDictids, null);
    }
}
function processCustomDictids(data){
	_initDmsObj["initCustomDicts"].setData(data);
    _initDmsCallback["initCustomDicts"]  && _initDmsCallback["initCustomDicts"]() && (_initDmsCallback["initCustomDicts"] = null);
}

//角色字典
function initRoleMembers(dictDefs,callback){//dictDefs{id1: dictid1, id2: dictid2}
	_initDmsCallback["initRoleMembers"] = callback;
    var url = _sysApiRoot + "/com.hsapi.system.dict.roleMgr.queryRoleMember.biz.ext";
    params = {};
    params.roleId = filterParam("_roleDefs", dictDefs); ; 
    callAjax(url, params, processAjax, processRoleMembers, null);
}
function processRoleMembers(data){
    adapterData(_initDmsObj["_roleDefs"], data, "roleId");
    _initDmsCallback["initRoleMembers"]  && _initDmsCallback["initRoleMembers"]() && (_initDmsCallback["initRoleMembers"] = null);
}
//省份
function initProvince(id,callback){
    _initDmsCallback["initProvince"] = callback;
    if(checkObjExists(id, "initProvince")){
        var url = _sysApiRoot + "/com.hsapi.system.dict.dictMgr.getProvinces.biz.ext";
        callAjax(url, {}, processAjax, processProvince, null); 
    }
}
function processProvince(data){
    _initDmsObj["initProvince"].setData(data);
    setDataToHash(data,"province","code");
    _initDmsCallback["initProvince"] && _initDmsCallback["initProvince"]() && (_initDmsCallback["initProvince"] = null);
}
//城市
function initCity(id,callback){
    _initDmsCallback["initCity"] = callback;
    if(checkObjExists(id, "initCity")){
        var url = _sysApiRoot + "/com.hsapi.system.dict.dictMgr.getCitys.biz.ext";
        callAjax(url, {}, processAjax, processCity, null); 
    }
}
function processCity(data){
    _initDmsObj["initCity"].setData(data);
    setDataToHash(data,"city","code");
    _initDmsCallback["initCity"] && _initDmsCallback["initCity"]() && (_initDmsCallback["initCity"] = null);
}
//公司员工
function initMember(id,callback){//dictDefs{id1: dictid1, id2: dictid2}
	_initDmsCallback["initCompMember"] = callback;
	if(checkObjExists(id, "getMember")){
	    var url = _sysApiRoot + "/com.hsapi.system.dict.org.queryMember.biz.ext";
	    var params = {};
	    callAjax(url, params, processAjax, processMember, null);
    }
}
function processMember(data){
	_initDmsObj["getMember"].setData(data);
    _initDmsCallback["initCompMember"]  && _initDmsCallback["initCompMember"]() && (_initDmsCallback["initCompMember"] = null);
}

//filter Param
function filterParam(paramName, paramDef){
    var params = [];
    var o = {};
    for(var i in paramDef){
        if(!checkObjExists(i, paramDef[i])){
            return;
        }
        if(!o[paramDef[i]]){
            o[paramDef[i]] = 1;
            params.push(paramDef[i]);            
        }
    }
    _initDmsObj[paramName] = paramDef;
    return params;
}

//adapter Data
function adapterData(_defs, data, key){
    var tmpList;
    for(var i in _defs){
        if(checkObjExists(i, _defs[i])){
            tmpList = data.filter(function(v){
                return v[key] == _defs[i];
            });
            _initDmsObj[_defs[i]].setData(tmpList);
        }
    } 
}

function checkObjExists(id, key){
    _initDmsObj[key] = nui.get(id);
    if(_initDmsObj[key]){
        return true;
    }else{
    nui.alert("对象【" + id + "】不存在！");
        return false;
    }
}
function setDataToHash(data,key,idFiled)
{
	if(_initDmsHash[key] && data.forEach)
	{
		data.forEach(function(v)
		{
			v[idFiled] && (_initDmsHash[key][v[idFiled]] = v);
		});
	//	console.log(_initDmsHash);
	}
}