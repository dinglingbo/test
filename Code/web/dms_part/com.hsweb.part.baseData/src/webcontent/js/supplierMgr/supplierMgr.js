/**
 * Created by Administrator on 2018/1/23.
 */
var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var gridUrl = baseUrl+"com.hsapi.part.baseDataCrud.crud.querySupplierList.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var grid = null;
$(document).ready(function(v)
{
    grid = nui.get("datagrid1");
    grid.setUrl(gridUrl);
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    //console.log("xxx");
    
    getProvinceAndCity();
});
function onSearch(){
    search();
}
function search()
{
    var param = getSearchParam();
    doSearch(param);
}
function getSearchParam() {

	var params = {
		fullName : nui.get("fullName").getValue(),
		advantageCarbrandId : nui.get("advantageCarbrandId").getValue(),
		mobile : nui.get("mobile").getValue()
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

function addSuplier()
{
    nui.open({
        targetWindow: window,
        url: "com.hsweb.part.baseData.supplierDetail.flow",
        title: "供应商资料", width: 530, height: 560,
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
function editSuplier()
{

}



function onDrawCell(e)
{
    if(e.field == "isDisabled")
    {
        e.cellHtml = e.value==0?"否":"是";
    }
    switch (e.field)
    {
        case "isDisabled":
            e.cellHtml = e.value==0?"否":"是";
            break;
        case "provinceId":
            e.cellHtml = provinceHash[e.value].name;
            break;
        case "cityId":
            e.cellHtml = cityHash[e.value].name;
            break;
    }
}

var getProvinceAndCityUrl = baseUrl+"com.hsapi.part.common.svr.getProvinceAndCity.biz.ext";
var provinceHash = {};
var provinceList = [];
var cityHash = {};
var cityList = [];
var provinceEl = null;
var cityEl = null;
function onProvinceSelected(e){
    var id = provinceEl.getValue();
    var currCityList = cityList.filter(function(v){
        return v.provinceId == id;
    });
    cityEl.setData(currCityList);
}
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

