/**
 * Created by Administrator on 2018/1/23.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var gridUrl = baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.querySupplierList.biz.ext";
var treeUrl = baseUrl+"";

var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var grid = null;
var tree = null;

var billTypeIdList = [];
var billTypeIdHash = {};
var settTypeIdList = [];
var settTypeIdHash = {};
var isSupplier = 0;
var isClient = 0;
$(document).ready(function(v)
{
	grid = nui.get("datagrid1");
    grid.setUrl(gridUrl);

    tree = nui.get("tree1");
  //  tree.setUrl(gridUrl);
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    //console.log("xxx");

    getProvinceAndCity(function(data)
    {
        var province = data.province;
        var city = data.city;
        cityList = city;
        tree.loadList(province.concat(city),"id","parentid");
        provinceEl = nui.get("provinceId");
        provinceEl.setData(province);
    });
    var dictIdList = [];
    dictIdList.push('DDT20130703000008');//票据类型
    dictIdList.push('DDT20130703000035');//结算方式
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
        }
    });
    

    document.onkeyup=function(event){
	    var e=event||window.event;
	    var keyCode=e.keyCode||e.which;
	  
	    if((keyCode==13))  {  //ESC
	    	onSearch();
        }
	}
});
var cityList = [];
var provinceEl = null;
var cityEl = null;
function onProvinceSelected(cityId)
{
    if(provinceEl)
    {
        cityEl = nui.get(cityId);
        var id = provinceEl.getValue();
        var currCityList = cityList.filter(function(v){
            return v.provinceId == id;
        });
        cityEl.setData(currCityList);
    }
}
function setData(data)
{
    data = data||{};
    isSupplier = data.isSupplier;
    isClient = data.isClient;

    search();
}
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
    var params = {};
    params.code = nui.get("code").getValue().replace(/\s+/g, "");
    params.name = nui.get("name").getValue().replace(/\s+/g, "");
    params.mobile = nui.get("phone").getValue().replace(/\s+/g, "");
    params.contactorTel = params.mobile;
//    params.type = nui.get("type").getValue();
    var showDisabled = nui.get("showDisabled").getValue();
    if(showDisabled == 0)
    {
        params.isDisabled = 0;
    }
    params.isSupplier = isSupplier;
    params.isClient = isClient;
    return params;
}
function doSearch(params)
{
    grid.load({
        params:params,
        token:token
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
    
    if(searchData.showDisabled == 0)
    {
        searchData.isDisabled = 0;
    }
  //去除空格
    for(var key in searchData){
    	if(searchData[key]!=null && searchData[key]!="" && typeof(searchData[key])=='string'){    		
    		searchData[key]=searchData[key].replace(/\s+/g, "");
    	}
    }
    doSearch(searchData);
}
function onAdvancedSearchCancel(){
    advancedSearchForm.clear();
    advancedSearchWin.hide();
}

var resultData = {};
function onOk()
{
	var node = grid.getSelected();
    if(node)
    {
       
        resultData = {
            supplier:node
        };
        //  return;
        CloseWindow("ok");
    }
}
function getData(){
    return resultData;
}
function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}

function onDrawCell(e)
{
    switch (e.field)
    {
        case "isDisabled":
            e.cellHtml = e.value==1?"失效":"有效";
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
            if(tgradeHash[e.value]){
                e.cellHtml = tgradeHash[e.value].name||"";
            }
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
        case "supplierType":
            if(supplierTypeHash[e.value])
            {
                e.cellHtml = supplierTypeHash[e.value].name||"";
            }
            break;
    }
}
function onNodeDblClick(e)
{
    var node = e.node;
    var params = getSearchParam();
    if(node.parentid)
    {
        params.cityId = node.id;
        var parentNode = tree.getParentNode(node);
        params.provinceId = parentNode.id;
    }
    else{
        params.provinceId = node.id;
    }
    doSearch(params);
}
