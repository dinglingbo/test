/**
 * Created by Administrator on 2018/1/23.
 */
var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var gridUrl = baseUrl+"com.hsapi.part.baseDataCrud.crud.queryCustomList.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var grid = null;

//信誉等级
var tgradeList = [
    {
        "customid":0,
        "name":"高"
    },
    {
        "customid":1,
        "name":"中"
    },
    {
        "customid":2,
        "name":"低"
    }
];
var tgradeHash = {
    0:tgradeList[0],
    1:tgradeList[1],
    2:tgradeList[2]
};
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
    grid.on("beforeload",function(e){
        e.data.token = token;
    });
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    //console.log("xxx");
    provinceEl = nui.get("provinceId");

    getProvinceAndCity(function(data)
    {});
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
	params.guestTypeList = "'01020102','01020202'";
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
    advancedSearchFormData = searchData;
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
        	if(tgradeHash && tgradeHash[e.value]){
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
        case "guestType":
            if(guestTypeHash[e.value])
            {
                e.cellHtml = guestTypeHash[e.value].name||"";
            }
            break;
    }
}

function addCustomer()
{
    nui.open({
        targetWindow: window,
        url: "com.hsweb.part.baseData.customerAdd.flow?token=" + token,
        title: "客户资料", width: 500, height: 560,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData({
                province:provinceList,
                city:cityList,
                billTypeId:billTypeIdList,
                settTypeId:settTypeIdList,
                tgrade:tgradeList,
                managerDuty:managerDutyList
            });
        },
        ondestroy: function (action)
        {
            if(action == "ok")
            {
                grid.reload();
            }
        }
    });
}
function editCustomer()
{
    var row = grid.getSelected();

    if(!row)
    {
        nui.alert("请选择要编辑的数据");
        return;
    }
    nui.open({
        targetWindow: window,
        url: "com.hsweb.part.baseData.customerAdd.flow?token=" + token,
        title: "客户资料", width: 500, height: 560,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData({
                province:provinceList,
                city:cityList,
                supplier:row,
                billTypeId:billTypeIdList,
                settTypeId:settTypeIdList,
                tgrade:tgradeList,
                managerDuty:managerDutyList
            });
        },
        ondestroy: function (action)
        {
            if(action == "ok")
            {
                grid.reload();
            }
        }
    });
}
function onRowDblClick(e)
{
    editCustomer();
}

