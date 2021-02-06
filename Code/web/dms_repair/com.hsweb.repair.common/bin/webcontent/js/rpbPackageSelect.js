/**
 * Created by Administrator on 2018/3/23.
 */
var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var leftGridUrl = baseUrl + "com.hsapi.repair.baseData.rpb_package.queryPackage.biz.ext";
var rightItemGridUrl = baseUrl + "com.hsapi.repair.baseData.rpb_package.queryPackageItem.biz.ext";
var rightPartGridUrl = baseUrl + "com.hsapi.repair.baseData.rpb_package.queryPackagePart.biz.ext";

var leftGrid = null;
var rightItemGrid = null;
var rightPartGrid = null;
var basicInfoForm = null;
var carBrandIdEl = null;
var carModelIdEl = null;
var carModelIdHash = {};
$(document).ready(function (v)
{
    leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);
    leftGrid.on("rowclick",function(e)
    {
        onLeftGridRowClick(e);
    });
    leftGrid.on("load",function(){
        onLeftGridRowClick({});
    });

    rightItemGrid = nui.get("rightItemGrid");
    rightItemGrid.setUrl(rightItemGridUrl);

    rightPartGrid = nui.get("rightPartGrid");
    rightPartGrid.setUrl(rightPartGridUrl);

    basicInfoForm = new nui.Form("#basicInfoForm");
    basicInfoForm.setEnabled(false);
    queryForm = new nui.Form("#queryForm");
    carBrandIdEl = nui.get("carBrandId");
    carModelIdEl = nui.get("carModelId");
    init();
    onSearch();
});
function init()
{
    carBrandIdEl.on("valuechanged",function()
    {
        var carBrandId = carBrandIdEl.getValue();
        if(carModelIdHash[carBrandId])
        {
            carModelIdEl.setData(carModelIdHash[carBrandId]);
        }
        else
        {
            getCarModelByBrandId(carBrandId,function(data)
            {
                var list = data.list||[];
                carModelIdHash[carBrandId] = list;
                carModelIdEl.setData(carModelIdHash[carBrandId]);
            });
        }
    });
    var elList = basicInfoForm.getFields();
    var nameList = ["amount"];
    elList.forEach(function(v)
    {
        if(nameList.indexOf(v.name)>-1)
        {
            v.on("focus",function(e){
                onInputFocus(e);
            });
            v.on("blur",function(e){
                onInputBlur(e);
            });
        }
    });
    var dictIdList = [];
    dictIdList.push("DDT20130706000017");
    getDictItems(dictIdList,function(data)
    {
        data = data||{};
        var list = data.dataItems||[];
        nui.get("type").setData(list);
        nui.get("type-search").setData(list);
    });
    getAllCarBrand(function(data)
    {
        var list = data.carBrands||[];
        carBrandIdEl.setData(list);
        nui.get("carBrandId-search").setData(list);
    });
}

function onLeftGridRowClick(e)
{
    var row = leftGrid.getSelected();
    if(row)
    {
        basicInfoForm.clear();
        basicInfoForm.setData(row);
        carBrandIdEl.doValueChanged();
        loadRightPartGridData(row.id);
        loadRightItemGridData(row.id);
    }
}
function onSearch()
{
    var params = getSearchParams();
    doSearch(params);
}
function getSearchParams()
{
    var params = queryForm.getData();
    return params;
}
function doSearch(params)
{
    basicInfoForm.clear();
    params.orgid = currOrgid;
    leftGrid.load({
    	token:token,
        params:params
    });
}
function loadRightItemGridData(packageId)
{
    var params = {
        packageId:packageId
    };
    rightItemGrid.load({
    	token:token,
        params:params
    });
}
function loadRightPartGridData(packageId)
{
    rightPartGrid.load({
    	token:token,
        packageId:packageId
    });
}
var resultData = {};
var callback = null;
function setData(data,ck)
{
    callback = ck||null;
}
function getData(){
    return resultData;
}
function onOk()
{
    var row = leftGrid.getSelected();
    if(row)
    {
        resultData.package = basicInfoForm.getData();
        resultData.itemList = rightItemGrid.getData();
        resultData.partList = rightPartGrid.getData();
        if(callback)
        {
            callback(resultData,function(data)
            {
                if(data.info)
                {
                    nui.alert(data.info,"提示",function()
                    {
                        if(data.close)
                        {
                            CloseWindow("cancel");
                        }
                    });
                }
                else
                {
                    if(data.close)
                    {
                        CloseWindow("cancel");
                    }
                }
            })
        }
        else{
            CloseWindow("ok");
        }
    }
    else{
        nui.alert("请选择一个套餐");
    }
}

function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel() {
    CloseWindow("cancel");
}