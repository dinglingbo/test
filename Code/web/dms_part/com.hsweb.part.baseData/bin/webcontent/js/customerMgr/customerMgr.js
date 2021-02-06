/**
 * Created by Administrator on 2018/1/23.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
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
    grid.on("drawcell",function(e)
    {
        var field = e.field;
        if("isDisabled" == field)
        {
            e.cellHtml = e.value==1?"是":"否";
        }
        else if("provinceId" == field)
        {
            if(provinceHash[e.value])
            {
                e.cellHtml = provinceHash[e.value].name||"";
            }
        }
        else if("cityId" == field)
        {
            if(cityHash[e.value])
            {
                e.cellHtml = cityHash[e.value].name||"";
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
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    //console.log("xxx");
    provinceEl = nui.get("provinceId");

    getProvinceAndCity(function(data)
    {});
    initDicts({
        billTypeId:BILL_TYPE,//票据类型
        managerDuty:MANAGER_DUTY,//供应商负责人职务
        settType:SETT_TYPE,//结算方式
        guestType:GUEST_TYPE //对象类型
    },function(){});
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
    //params.guestTypeList = "'01020102','01020202'";
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

function addCustomer()
{
    billTypeIdList = nui.get("billTypeId").getData();
    settTypeIdList = nui.get("settType").getData();
    managerDutyList = nui.get("managerDuty").getData();
    nui.open({
//        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.part.baseData.customerAdd.flow?token=" + token,
        title: "客户资料", width: 560, height: 560,
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
        showMsg("请选择要编辑的数据","W");
        return;
    }
    billTypeIdList = nui.get("billTypeId").getData();
    settTypeIdList = nui.get("settType").getData();
    managerDutyList = nui.get("managerDuty").getData();
    nui.open({
//        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.part.baseData.customerAdd.flow?token=" + token,
        title: "客户资料", width: 600, height: 550,
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
function onGridRowClick(e)
{
    var row = e.record||grid.getSelected();
    if(!row)
    {
        return;
    }
    if(row.orgid != currOrgid)
    {
        nui.get("editBtn").disable();
    }
    else{
        nui.get("editBtn").enable();
    }
}
function importGuest(){
    billTypeIdList = nui.get("billTypeId").getData();
    settTypeIdList = nui.get("settType").getData();

    nui.open({
//        // targetWindow: window,
        url: webPath + contextPath + "/com.hsweb.part.baseData.importClient.flow?token="+token,
        title: "客户导入", 
        width: 1000, 
        height: 5400,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.initData({
                    province:provinceList,
                    city:cityList,
                    billTypeId:billTypeIdList,
                    settTypeId:settTypeIdList
                });
        },
        ondestroy: function (action)
        {
            doSearch();
        }
    });
}
