/**
 * Created by Administrator on 2018/1/31.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var gridUrl = baseUrl+"com.hsapi.part.baseDataCrud.crud.queryCustomList.biz.ext";
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
$(document).ready(function(v)
{
    grid = nui.get("datagrid1");
    grid.setUrl(gridUrl);
    grid.on("beforeload",function(e){
        e.data.token = token;
    });
    grid.on("drawcell",function(e)
    {
        var field = e.field;
        if("isDisabled" == field)
        {
            e.cellHtml = e.value==1?"失效":"有效";
        }
        else if("provinceId" == field)
        {
            if(provinceHash[e.value])
            {
                e.cellHtml = provinceHash[e.value].name;
            }
        }
        else if("cityId" == field)
        {
            if(cityHash[e.value])
            {
                e.cellHtml = cityHash[e.value].name;
            }
        }
        else if("tgrade" == field)
        {
            if(tgradeHash[e.value]){
                e.cellHtml = tgradeHash[e.value].name||"";
            }
        }
        else{
            onDrawCell(e);
        }
    });
    tree = nui.get("tree1");
    tree.on("beforeload",function(e){
        e.data.token = token;
    });
    //  tree.setUrl(gridUrl);
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    //console.log("xxx");

    getProvinceAndCity(function(data)
    {
        var province = data.province;
        var city = data.city;
        cityList = city;
        tree.loadList(province.concat(city),"code","parentid");
        provinceEl = nui.get("provinceId");
        provinceEl.setData(province);
    });
    initDicts({
        billTypeId:BILL_TYPE,//票据类型
        settType:SETT_TYPE//结算方式
        //guestType:GUEST_TYPE //对象类型
    },function(){
        grid.load();
    });
    provinceEl.focus();
    document.onkeyup = function(event) {
		var e = event || window.event;
		var keyCode = e.keyCode || e.which;// 38向上 40向下
		if ((keyCode == 27)) { // ESC
			CloseWindow('cancle');
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
    params.code = nui.get("code").getValue();
    params.name = nui.get("name").getValue();
    params.mobile = nui.get("phone").getValue();
    params.contactorTel = params.mobile;
    //params.guestType = nui.get("guestType").getValue();
    var showDisabled = nui.get("showDisabled").getValue();
    if(showDisabled == 0)
    {
        params.isDisabled = 0;
    }
    return params;
}
function doSearch(params)
{
    grid.load({
    	token:token,
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
    console.log(searchData);
    if(searchData.showDisabled == 0)
    {
        searchData.isDisabled = 0;
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
        console.log(node);
        resultData = {
        	customer:node
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

function onNodeDblClick(e)
{
    var node = e.node;
    var params = getSearchParam();
    if(node.provinceId)
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

