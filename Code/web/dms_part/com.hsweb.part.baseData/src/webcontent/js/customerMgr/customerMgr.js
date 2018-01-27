/**
 * Created by Administrator on 2018/1/23.
 */
var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var gridUrl = baseUrl+"com.hsapi.part.baseDataCrud.crud.queryCustomList.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var grid = null;
var billTypeIdList = [];
var billTypeIdHash = {};
var settTypeIdList = [];
var settTypeIdHash = {};
var managerDutyList = [];
var managerDutyHash = {};
var guestTypeList = [];
var guestTypeHash = {};
$(document).ready(function(v)
{
    grid = nui.get("datagrid1");
    grid.setUrl(gridUrl);
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    //console.log("xxx");


    getProvinceAndCity();
    var dictIdList = [];
    dictIdList.push('DDT20130703000008');//票据类型
    dictIdList.push('DDT20180105000001');//供应商负责人职务
    dictIdList.push('DDT20130703000035');//结算方式
    dictIdList.push('DDT20130703000084');//对象类型
    getDictItems(dictIdList,function(data)
    {
        if(data && data.dataItems)
        {
            var dataItems = data.dataItems||[];
            billTypeIdList = dataItems.filter(function(v)
            {
                if(v.dictid == "DDT20130703000008")
                {
                    billTypeIdHash[v.customid] = v;
                    return true;
                }
            });
            settTypeIdList = dataItems.filter(function(v)
            {
                if(v.dictid == "DDT20130703000035")
                {
                    settTypeIdHash[v.customid] = v;
                    return true;
                }
            });
            managerDutyList = dataItems.filter(function(v)
            {
                if(v.dictid == "DDT20180105000001")
                {
                    managerDutyHash[v.customid] = v;
                    return true;
                }
            });
            guestTypeList = dataItems.filter(function(v)
            {
                if(v.dictid == "DDT20130703000084")
                {
                    guestTypeHash[v.customid] = v;
                    return true;
                }
            });
        }
    });
});
function onSearch(){
    search();
}
function search()
{
    var param = getSearchParam();
    doSearch(param);
}
function getSearchParam()
{
    var params = {
        fullName:nui.get("fullName").getValue(),
        mobile:nui.get("mobile").getValue(),
        code:nui.get("code").getValue()
    };

    return params;
}
function doSearch(params)
{
    grid.load({
        params:params
    });
}
function advancedSearch()
{
    advancedSearchWin.show();
    advancedSearchForm.clear();
    if(advancedSearchFormData)
    {
        advancedSearchForm.setData(advancedSearchFormData);
    }
}
function onAdvancedSearchOk()
{
    var searchData = advancedSearchForm.getData();
    advancedSearchWin.hide();
    doSearch(searchData);
}
function onAdvancedSearchCancel(){
    advancedSearchForm.clear();
    advancedSearchWin.hide();
}
function onDrawCell(e)
{
    switch (e.field)
    {
        case "isDisabled":
            e.cellHtml = e.value==1?"是":"否";
            break;
        case "provinceId":
            if(provinceHash[e.value])
            {
                e.cellHtml = provinceHash[e.value].name;
            }
            break;
        case "cityId":
            if(cityHash[e.value])
            {
                e.cellHtml = cityHash[e.value].name;
            }
            break;
        case "tgrade":
            //if(tgradeHash && tgradeHash[e.value]){
            //    e.cellHtml = tgradeHash[e.value].name||"";
            //}
            break;
        case "billTypeId":
            if(billTypeIdHash[e.value]){
                e.cellHtml = billTypeIdHash[e.value].name||"";
            }
            break;
        case "settTypeId":
            if(settTypeIdHash[e.value]){
                e.cellHtml = settTypeIdHash[e.value].name||"";
            }
            break;
        case "managerDuty":
            if(managerDutyHash[e.value]){
                e.cellHtml = managerDutyHash[e.value].name||"";
            }
            break;
        case "guestType":
            if(guestTypeHash[e.value])
            {
                e.cellHtml = guestTypeHash[e.value].name||"";
            }
            break;
    }
}

var getProvinceAndCityUrl = baseUrl+"com.hsapi.part.common.svr.getProvinceAndCity.biz.ext";
function getProvinceAndCity(callback)
{
    if(!provinceEl)
    {
        provinceEl = nui.get("provinceId");
        cityEl = nui.get("cityId");
    }
    nui.ajax({
        url:getProvinceAndCityUrl,
        type:"post",
        success:function(data)
        {
            if(data)
            {
                provinceList = data.province||[];
                provinceList.forEach(function(v){
                    provinceHash[v.id] = v;
                });
                provinceEl.setData(provinceList);
                cityList = data.city||[];
                cityList.forEach(function(v){
                    cityHash[v.id] = v;
                });
                callback && callback({
                    code:"S"
                });
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function addCustomer()
{
    nui.open({
        targetWindow: window,
        url: "com.hsweb.part.baseData.customerAdd.flow",
        title: "客户资料", width: 500, height: 560,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {

        },
        ondestroy: function (action)
        {

        }
    });
}

