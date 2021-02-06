/**
 * Created by Administrator on 2018/4/16.
 */
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var leftGrid = null;
var leftGridUrl = baseUrl + "com.hsapi.repair.repairService.query.queryMtHistoryList.biz.ext";
var serviceTypeIdHash = {};
var mtTypeHash = {};
var carBrandHash = {};
var insuranceCompanyHash = {};
var orgHash = {};
$(document).ready(function (v)
{
    leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);
    leftGrid.on("rowdblclick", function (e) {
        var row = e.record;
        onOk();
    });
    leftGrid.on("drawcell",onDrawCell);

    var hash = {};
    nui.mask({
        html: '数据加载中..'
    });
    var checkComplete = function () {
        var keyList = ['getDatadictionaries','getAllCarBrand','getAllInsuranceCompany','getOrgList'];
        for (var i = 0; i < keyList.length; i++) {
            if (!hash[keyList[i]]) {
                return;
            }
        }
        nui.unmask();
        quickSearch(0);
    };
    var pId = "DDT20130703000055";//业务类型
    getDatadictionaries(pId, function (data) {
        data = data || {};
        var list = data.list || [];
        var dictIdList = [];
        list.forEach(function (v) {
            dictIdList.push(v.id);
            serviceTypeIdHash[v.customid] = v;
        });
        getDictItems(dictIdList, function (data) {
            data = data || {};
            var itemList = data.dataItems || [];
            itemList.forEach(function (v) {
                mtTypeHash[v.customid] = v;
            });
            hash.getDatadictionaries = true;
            checkComplete();
        });
    });
    getAllCarBrand(function(data)
    {
        data = data||{};
        var carBrandList = data.carBrands||[];
        carBrandList.forEach(function (v) {
            carBrandHash[v.id] = v;
        });
        hash.getAllCarBrand = true;
        checkComplete();
    });
    getAllInsuranceCompany(function(data){
        data = data||{};
        var list = data.list||[];
        list.forEach(function (v) {
            insuranceCompanyHash[v.id] = v;
        });
        hash.getAllInsuranceCompany = true;
        checkComplete();
    });
    getOrgList(function(data)
    {
        data = data||{};
        var orgList = data.orgList||[];
        orgList.forEach(function(v){
            orgHash[v.orgid] = v;
        });
        hash.getOrgList = true;
        checkComplete();
    });
});
function onDrawCell(e)
{
    var field = e.field;
    if(field == "serviceTypeId" && serviceTypeIdHash[e.value])
    {
        e.cellHtml = serviceTypeIdHash[e.value].name;
    }
    else if (field == "carBrandId" && carBrandHash[e.value]) {
        e.cellHtml = carBrandHash[e.value].carBrandZh;
    }
    else if (field == "mtType" && mtTypeHash[e.value]) {
        e.cellHtml = mtTypeHash[e.value].name;
    }
    else if (field == "insureCompCode" && insuranceCompanyHash[e.value]) {
        e.cellHtml = insuranceCompanyHash[e.value].fullName;
    }
    else if (field == "orgid" && orgHash[e.value]) {
        e.cellHtml = orgHash[e.value].orgname;
    }
}
function quickSearch(type)
{
    onSearch();
}
function getSearchParams()
{
    var params = {};
    var queryField = nui.get("queryField").getValue();
    var queryValue = nui.get("queryValue").getValue();
    params[queryField] = queryValue;
    return params;
}
function onSearch()
{
    var params = getSearchParams();
    doSearch(params);
}
function doSearch(params) {
    params.orgid = currOrgid;
    leftGrid.load({
        token:token,
        params: params
    });
}
var resultData = {};
function getData()
{
    return resultData;
}
function onOk()
{
    var row = leftGrid.getSelected();
    if(row)
    {
        resultData.repairCustomer = row;
     //   console.log(row);
        CloseWindow("ok");
    }
}

function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}