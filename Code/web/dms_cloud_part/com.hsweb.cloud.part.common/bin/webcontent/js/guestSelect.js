/**
 * Created by Administrator on 2018/1/23.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var gridUrl = apiPath + sysApi+"/com.hsapi.system.basic.crudBasic.queryGuestList.biz.ext";
var treeUrl = baseUrl+"";
var billTypeIdEl=null;
var settleTypeIdEl=null;
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var grid = null;
var tree = null;
var isSupplier = null;
var isClient = null;
var supplierType = null;
var guestType = null;
var nameEl = null;
var isInternal = null;
var typeEl =null;

var billTypeIdList = [];
var billTypeIdHash = {};
var settTypeIdList = [];
var settTypeIdHash = {};
$(document).ready(function(v)
{
	grid = nui.get("datagrid1");
    grid.setUrl(gridUrl);
    nameEl = nui.get("name");
    billTypeIdEl = nui.get("billTypeId");
    settleTypeIdEl = nui.get("settType");
    grid.on("beforeload",function(e){
        e.data.token = token;
    });
    typeEl = nui.get("type");
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
        }else if("isInternal" == field)
        {
            e.cellHtml = e.value==1?"是":"否";
        }else if("billTypeId"== field){
        	if(billTypeIdHash && billTypeIdHash[e.value])
            {
                e.cellHtml = billTypeIdHash[e.value].name;
            }
        }else if("settTypeId" == field){
        	if(settTypeIdHash && settTypeIdHash[e.value])
            {
                e.cellHtml = settTypeIdHash[e.value].name;
            }
        }
        else{
            onDrawCell(e);
        }
    });
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
        tree.loadList(province.concat(city),"code","parentid");
        provinceEl = nui.get("provinceId");
        provinceEl.setData(province);
    });
    initDicts({
        billTypeId:BILL_TYPE,//票据类型
        settType:SETT_TYPE //结算方式
    },function(){
        //grid.load();
    	billTypeIdList = billTypeIdEl.getData();
    	settTypeIdList = settleTypeIdEl.getData();
    	billTypeIdList.filter(function(v)
        {
            billTypeIdHash[v.customid] = v;
            return true;
        });

        settTypeIdList.filter(function(v)
        {
            settTypeIdHash[v.customid] = v;
            return true;
        });
    });

    nui.get("pyName").focus();
    
    document.onkeyup = function(event) {
		var e = event || window.event;
		var keyCode = e.keyCode || e.which;// 38向上 40向下
		

		if ((keyCode == 27)) { // ESC
			onCancel();
		}

	}
    $("#name").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });
    $("#code").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });
    $("#phone").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
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
function setGuestData(data){
//	$.ajaxSettings.async = false;
	if(data) {
		
        if(data.isSupplier){
            isSupplier = data.isSupplier;
            if(isSupplier == 1){
                initDicts({
                    type:GUEST_TYPE_S,
                    billTypeId:BILL_TYPE,//票据类型
                    settType:SETT_TYPE //结算方式
                },function(){
                	billTypeIdList = billTypeIdEl.getData();
        	    	settTypeIdList = settleTypeIdEl.getData();
        	    	billTypeIdList.filter(function(v)
        	        {
        	            billTypeIdHash[v.customid] = v;
        	            return true;
        	        });
        
        	        settTypeIdList.filter(function(v)
        	        {
        	            settTypeIdHash[v.customid] = v;
        	            return true;
        	        });
        	        
        	        if(data.guestType){
        	            guestType = data.guestType;

        	            //typeEl.setValue(guestType);
        	        }
                });
            }
            //nui.get("type").show();
            if(data.guestType){
	            guestType = data.guestType;

	            //typeEl.setValue(guestType);
	        }
        }
        if(data.isClient){
            isClient = data.isClient;
            if(isClient == 1){
                initDicts({
                    type:GUEST_TYPE,
                    billTypeId:BILL_TYPE,//票据类型
                    settType:SETT_TYPE //结算方式
                },function(){
                	billTypeIdList = billTypeIdEl.getData();
        	    	settTypeIdList = settleTypeIdEl.getData();
        	    	billTypeIdList.filter(function(v)
        	        {
        	            billTypeIdHash[v.customid] = v;
        	            return true;
        	        });
        
        	        settTypeIdList.filter(function(v)
        	        {
        	            settTypeIdHash[v.customid] = v;
        	            return true;
        	        });
        	        if(data.guestType){
        	            guestType = data.guestType;

        	            //typeEl.setValue(guestType);
        	        }
                });
            }
            //nui.get("type").show();
            if(data.guestType){
	            guestType = data.guestType;

	            //typeEl.setValue(guestType);
	        }
        }
       
        if(data.supplierType){
            supplierType = data.supplierType;
        }
        if(data.isInternal) {
        	isInternal = data.isInternal;
        }
        if(data.isInternal===0) {
        	isInternal = data.isInternal;
        }

    }

    onSearch();
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
    params.code = nui.get("code").getValue().replace(/(^\s*)|(\s*$)/g, "");
    params.name = nui.get("name").getValue().replace(/\s+/g, "");
    params.mobile = nui.get("phone").getValue().replace(/\s+/g, "");
    params.contactorTel = params.mobile;
    params.pyName = nui.get("pyName").getValue().replace(/\s+/g, "");
//    params.type = nui.get("type").getValue();
    var showDisabled = nui.get("showDisabled").getValue().replace(/\s+/g, "");
    if(showDisabled == 0)
    {
        params.isDisabled = 0;
    }
    return params;
}
function doSearch(params)
{
	params.isInternal = isInternal;
    params.isSupplier = isSupplier;
    params.isClient = isClient;
    //params.supplierType = supplierType;
    //params.guestType = nui.get("type").getValue();
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
    console.log(searchData);
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

function onNodeDblClick(e)
{
	var node = e.node;
    var params = getSearchParam();
    if(node.level == 2)
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

function onDrawCell(e){
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
    }else if("isInternal" == field)
    {
        e.cellHtml = e.value==1?"是":"否";
    }
}