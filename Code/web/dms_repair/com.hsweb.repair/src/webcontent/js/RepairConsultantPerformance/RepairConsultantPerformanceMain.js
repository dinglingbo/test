/**
 * Created by Administrator on 2018/4/12.
 */
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var grid = null;
var gridUrl = baseUrl + "com.hsapi.repair.repairService.report.queryRepairAnaylsisList.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var serviceTypeIdHash = {};
var mtTypeHash = {};
var guestSourceHash = {};
var orgHash = {};
var mtAdvisorIdHash = {};
var carBrandHash = {};
var insuranceHash = {};
$(document).ready(function (v)
{
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    grid = nui.get("datagrid1");
    grid.setUrl(gridUrl);
    grid.on("drawcell",function(e)
    {
        var field = e.field;
        var row = e.record;
        if(field == "groupName")
        {
            switch(currAnayType)
            {
                case 0:
                    if(orgHash[e.value])
                    {
                        e.cellHtml = orgHash[e.value].orgname;
                    }
                    break;
                case 2://按品牌
                    if(carBrandHash[e.value])
                    {
                        e.cellHtml = carBrandHash[e.value].carBrandZh;
                    }
                    break;
                case 3://按客户来源
                    if(guestSourceHash[e.value])
                    {
                        e.cellHtml = guestSourceHash[e.value].name;
                    }
                    break;
                case 4://按业务类型
                    if(serviceTypeIdHash[e.value])
                    {
                        e.cellHtml = serviceTypeIdHash[e.value].name;
                    }
                    break;
                case 5://按维修类型
                    if(mtTypeHash[e.value])
                    {
                        e.cellHtml = mtTypeHash[e.value].name;
                    }
                    break;
                case 7://按投保公司
                    if(insuranceHash[e.value])
                    {
                        e.cellHtml = insuranceHash[e.value].fullName;
                    }
                    break;
            }
        }
    });
    var hash = {};
    nui.mask({
        html: '数据加载中..'
    });
    var checkComplete = function () {
        var keyList = ['getRoleMember', 'getDatadictionaries','getOrgList','getAllCarBrand',"getAllInsuranceCompany"];
        for (var i = 0; i < keyList.length; i++) {
            if (!hash[keyList[i]]) {
                return;
            }
        }
        nui.unmask();
        quickSearch(0);
    };
    var roleId = [];
    roleId.push("010802");//维修顾问
    getRoleMember(roleId, function (data) {
        data = data || {};
        var list = data.members || [];
        list.forEach(function(v){
            mtAdvisorIdHash[v.id] = v;
        });
        nui.get("mtAdvisorId-ad").setData(list);
        hash.getRoleMember = true;
        checkComplete();
    });
    var pId = "DDT20130703000055";//业务类型
    var serviceTypeIdEl = nui.get("serviceTypeId");
    getDatadictionaries(pId, function (data) {
        data = data || {};
        var list = data.list || [];
        var dictIdList = [];
        list.forEach(function (v) {
            dictIdList.push(v.id);
            serviceTypeIdHash[v.customid] = v;
        });
        serviceTypeIdEl.setData(list);
        //维修类型
        dictIdList.push("DDT20130703000075");//客户来源
        getDictItems(dictIdList, function (data) {
            data = data || {};
            var itemList = data.dataItems || [];
            var guestSourceList = itemList.filter(function(v){
                return v.dictid == "DDT20130703000075";
            });
            guestSourceList.forEach(function(v){
                guestSourceHash[v.customid] = v;
            });
            var mtTypeList = itemList.filter(function(v){
                return v.dictid != "DDT20130703000075";
            });
            mtTypeList.forEach(function(v){
                mtTypeHash[v.customid] = v;
            });
            hash.getDatadictionaries = true;
            checkComplete();
        });
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
    getAllCarBrand(function(data){

        data = data||{};
        var carBrands = data.carBrands||[];
        carBrands.forEach(function(v){
            carBrandHash[v.id] = v;
        });
        hash.getAllCarBrand = true;
        checkComplete();
    });
    getAllInsuranceCompany(function(data){
        data = data||{};
        var list = data.list||[];
        list.forEach(function(v){
            insuranceHash[v.id] = v;
        });
        hash.getAllInsuranceCompany = true;
        checkComplete();
    });
});
function advancedSearch()
{
    advancedSearchWin.show();
}
function onAdvancedSearchOk()
{
    var searchData = advancedSearchForm.getData();
    var i,tmpList;
    if(!searchData.startDate || !searchData.endDate)
    {
        nui.alert("结算起始日期和终止日期不能为空");
        return;

    }
    searchData.startDate = searchData.startDate.substr(0,10);
    searchData.endDate = searchData.endDate.substr(0,10);
    if(searchData.serviceCodeList)
    {
        tmpList = searchData.serviceCodeList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i]+"'";
        }
        searchData.serviceCodeList = tmpList.join(",");
    }
    advancedSearchWin.hide();
    searchData = getAnayType(searchData);
    doSearch(searchData);
}
function onAdvancedSearchCancel()
{
    advancedSearchWin.hide();
}
function onAdvancedSearchClear()
{
    advancedSearchForm.clear();
}
var searchByDateBtnTextHash = ["本日","昨日","本周","上周","本月","上月","本年","上年"];
var currType = 0;
function quickSearch(type) {
    var params = {};
    currType = type;

    var btn = nui.get("searchByDateBtn");
    if(btn)
    {
        var text = searchByDateBtnTextHash[type];
        btn.setText(text);
    }
    onSearch();
}
var currAnayType = 1;
var analysisByDateBtnTextHash = ["按分店","按维修顾问","按品牌","按客户来源","按业务类型","按维修类型","按来厂次数"];
function quickSearch1(type)
{
    currAnayType = type;
    var btn = nui.get("analysisByDateBtn");
    if(btn)
    {
        var text = analysisByDateBtnTextHash[type];
        btn.setText(text);
        grid.updateColumn("groupName", {header:analysisByDateBtnTextHash[type]+"分析"});
    }
    onSearch();
}
function getAnayType(params)
{
    switch (currAnayType)
    {
        case 0://按分店
            params.groupField = "a.orgid";
            break;
        case 1://按维修顾问
            params.groupField = "mt_advisor";
            break;
        case 2://按品牌
            params.groupField = "car_brand_id";
            break;
        case 3://按客户来源
            params.groupField = "source";
            break;
        case 4://按业务类型
            params.groupField = "service_type_id";
            break;
        case 5://按维修类型
            params.groupField = "mt_type";
            break;
        case 6://按来厂次数
            params.groupField = "a.chain_come_times";
            break;
        case 7://按投保公司
            params.groupField = "e.insure_comp_code";
            break;
    }
    return params;
}
function getSearchParams()
{
    var params = {};
    switch (currType) {
        case 0:
            params.today = 1;
            break;
        case 1:
            params.yesterday = 1;
            break;
        case 2:
            params.thisWeek = 1;
            break;
        case 3:
            params.lastWeek = 1;
            break;
        case 4:
            params.thisMonth = 1;
            break;
        case 5:
            params.lastMonth = 1;
            break;
        case 6:
            params.thisYear = 1;
            break;
        case 7:
            params.lastYear = 1;
            break;
        default:
            break;
    }
    params = getAnayType(params);
    return params;
}
function onSearch()
{
    var params = getSearchParams();
    doSearch(params);
}
function doSearch(params) {
    params.orgid = currOrgid;
    grid.load({
        token:token,
        params: params
    });
}
function history()
{
    var row = grid.getSelected();
    if(!row)
    {
        return;
    }
    nui.open({
        url: "com.hsweb.repair.common.repairHistory.flow",
        title: "维修历史", width: 850, height: 640,
        onload: function () {
            var iframe = this.getIFrameEl();
            var params = {
                contactorId:row.contactorId
            };
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action) {
        }
    });
}
function selectCustomer(elId) {
    nui.open({
        url: "com.hsweb.RepairBusiness.Customer.flow",
        title: "客户选择", width: 800, height: 450,
        onload: function () {
        },
        ondestroy: function (action) {
            if ("ok" == action) {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                var guest = data.guest;
                console.log(guest);
                if(nui.get(elId))
                {
                    nui.get(elId).setValue(guest.guestId);
                    nui.get(elId).setText(guest.guestFullName);
                }
            }
        }
    });
}