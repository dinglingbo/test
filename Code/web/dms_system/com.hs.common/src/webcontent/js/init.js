/*
 *init basic data
 */
 
var _sysApiRoot = apiPath + sysApi;
var _initDmsObj = {}

//公司组织
function initComp(id){
    if(checkObjExists(id, "initComp")){
        var url = _sysApiRoot + "/com.hsapi.system.dict.org.getComps.biz.ext";
        callAjax(url, {}, processAjax, processComp, null); 
    }
}
function processComp(data){
    _initDmsObj["initComp"].setData(data);
}

//车辆品牌
function initCarBrand(id){
    if(checkObjExists(id, "initCarBrand")){
        //var url = _sysApiRoot + "/com.hsapi.system.product.cars.carBrand.biz.ext";
        var url = _sysApiRoot + "/com.hsapi.system.dict.dictMgr.queryCarBrand.biz.ext";
        callAjax(url, {}, processAjax, processCarBrand, null); 
    }
}
function processCarBrand(data){
    _initDmsObj["initCarBrand"].setData(data);
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
function initInsureComp(id){
    if(checkObjExists(id, "initInsureComp")){
        var url = _sysApiRoot + "/com.hsapi.system.dict.guestMgr.queryGuest.biz.ext";
        params = {};
        params.guestTypes = "01020104";
        callAjax(url, params, processAjax, processInsureComp, null);  
    }
}
function processInsureComp(data){
    _initDmsObj["initInsureComp"].setData(data);
}

//数据字典
function initDicts(dictDefs){//dictDefs{id1: dictid1, id2: dictid2}
    var url = _sysApiRoot + "/com.hsapi.system.dict.dictMgr.queryDict.biz.ext";
    params = {};
    params.dictids = filterParam("_dictDefs", dictDefs); 
    callAjax(url, params, processAjax, processDictids, null);
}
function processDictids(data){
    adapterData(_initDmsObj["_dictDefs"], data, "dictid");
}

//角色字典
function initRoleMembers(dictDefs){//dictDefs{id1: dictid1, id2: dictid2}
    var url = _sysApiRoot + "/com.hsapi.system.dict.roleMgr.queryRoleMember.biz.ext";
    params = {};
    params.roleId = filterParam("_roleDefs", dictDefs); ; 
    callAjax(url, params, processAjax, processRoleMembers, null);
}
function processRoleMembers(data){
    adapterData(_initDmsObj["_roleDefs"], data, "roleId");
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