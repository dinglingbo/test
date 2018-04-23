/*
 *init basic data
 */
 
var _sysApiRoot = apiPath + sysApi;
var _initDmsObj = {};
var _initDmsCallback = {};
var _initDmsHash = {
	carBrand:{},//车辆品牌
	comp:{},//组织,
	insureComp:{},//保险公司,
	dict:{},//数据字典
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

//获取车型(选择品牌触发)
function getCarModel(id, e){
    if(checkObjExists(id, "getCarModel")){
        //var url = _sysApiRoot + "/com.hsapi.system.product.cars.carModel.biz.ext";
        var url = _sysApiRoot + "/com.hsapi.system.dict.dictMgr.queryCarModel.biz.ext";
        var params = {};
        params.carBrandId = e.value;
        callAjax(url, params, processAjax, processCarModel, null);
    }
}
function processCarModel(data){
    _initDmsObj["getCarModel"].setData(data);
}

//保险公司
function initInsureComp(id,callback){
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