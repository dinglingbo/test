/*
 *init basic data
 */
 
var _sysApiRoot = apiPath + sysApi;
var _initDmsObj = {}
var _dictDefs;//字典

//车辆品牌
function initCarBrand(id){
    if(checkObjExists(id, "initCarBrand")){
        var url = _sysApiRoot + "/com.hsapi.system.product.cars.carBrand.biz.ext";
        callAjax(url, {}, processAjax, processCarBrand, null); 
    }
}
function processCarBrand(data){
    _initDmsObj["initCarBrand"].setData(data);
}

//获取车型(选择品牌触发)
function getCarModel(id, e){
    if(checkObjExists(id, "getCarModel")){
        var url = _sysApiRoot + "/com.hsapi.system.product.cars.carModel.biz.ext";
        var params = {};
        params.carBrandId = e.value;
        params.token = token;
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
    var dictids = [];
    var o = {};
    for(var i in dictDefs){
        if(!checkObjExists(i, dictDefs[i])){
            return;
        }
        if(!o[dictDefs[i]]){
            o[dictDefs[i]] = 1;
            dictids.push(dictDefs[i]);            
        }
    }
    _dictDefs = dictDefs;

    var url = _sysApiRoot + "/com.hsapi.system.dict.dictMgr.queryDict.biz.ext";
    params = {};
    params.dictids = dictids; 
    callAjax(url, params, processAjax, processDictids, null);
}
function processDictids(data){
    var tmpList;
    for(var i in _dictDefs){
        if(checkObjExists(i, _dictDefs[i])){
            tmpList = data.filter(function(v){
                return v.dictid == _dictDefs[i];
            });
            _initDmsObj[_dictDefs[i]].setData(tmpList);
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