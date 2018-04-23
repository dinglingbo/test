/**
 * Created by Administrator on 2018/4/23.
 */
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var mainGrid = null;
var mainGridUrl = baseUrl + "com.hsapi.repair.repairService.query.queryNoRpeairList.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var queryInfoForm = null;
$(document).ready(function ()
{
	mainGrid = nui.get("mainGrid");
    mainGrid.setUrl(mainGridUrl);
    mainGrid.on("drawcell",onDrawCell);
    mainGrid.on("rowdblclick", function (e)
    {
        var row = e.record;
        loadRpsItemQuoteData(row);
        loadRpsPartQuoteData(row);
    });
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    queryInfoForm = new nui.Form("#queryInfoForm");
    var hash = {};
    nui.mask({
        html: '数据加载中..'
    });
    var checkComplete = function () {
    	var keyList = ['getDatadictionaries','initCarBrand',"initDicts"];
        for (var i = 0; i < keyList.length; i++) {
            if (!hash[keyList[i]]) {
                return;
            }
        }
        nui.unmask();
        quickSearch(0);
    };
    initRoleMembers({
        "mtAdvisorId-ad":"010802"
    },function(){
        hash.initRoleMembers = true;
        checkComplete();
    });
    var pId = SERVICE_TYPE;//业务类型
    getDatadictionaries(pId, function (data) {
        data = data || {};
        var list = data.list || [];
        nui.get("serviceTypeId").setData(list);
        var pId2 = ITEM_KIND;//工种
        getDatadictionaries(pId2, function (data) {
            data = data || {};
            var list = data.list || [];
            hash.getDatadictionaries = true;
            checkComplete();
        });
    });
    initDicts({
        mtType1:MT_TYPE_1,//维修类型，普通
        mtType2:MT_TYPE_2,//维修类型，事故
        noMtType1:NO_MT_TYPE_1,//未修类型
        noMtType2:NO_MT_TYPE_2//未修类型
    },function(){
        hash.initDicts = true;
        checkComplete();
    });
    initCarBrand("carBrand",function()
    {
        hash.initCarBrand = true;
        checkComplete();
    });
});
function onSearch()
{
    var searchData = advancedSearchForm.getData();
    var tmp = queryInfoForm.getData();
    var params = {
        startDate:searchData.startDate,
        endDate:searchData.endDate,
        status:tmp.status,
        carNo:tmp.carNo
    };
    params.startDate = params.startDate.substr(0,10);
    params.endDate = params.endDate.substr(0,10);
    doSearch(params);
}
function doSearch(params)
{
    params.orgid = currOrgid;
    mainGrid.load({
        token:token,
        params:params
    });
}
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
        nui.alert("未修起始日期和终止日期不能为空");
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
    var date = getDate(type);
    var searchData = advancedSearchForm.getData();
    searchData.startDate = date.startDate;
    searchData.endDate = date.endDate;
    advancedSearchForm.setData(searchData);
    onSearch();
}


var statusHash2 = ["报价未修", "已维修"];
var rpsItemQuoteGrid = null;
function loadRpsItemQuoteData(row) {
    if (!rpsItemQuoteGrid) {
        rpsItemQuoteGrid = nui.get("rpsItemQuoteGrid");
        rpsItemQuoteGrid.on("drawcell", function (e) {
            if (e.field == "status") {
                e.cellHtml = statusHash2[e.value];
            }
            else{
                onDrawCell(e);
            }
        });
        var rpsItemGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsItemQuoteByServiceId.biz.ext";
        rpsItemQuoteGrid.setUrl(rpsItemGridUrl);
    }
    if (!row.id) {
        return;
    }
    var params = {
        serviceId: row.id
    };
    rpsItemQuoteGrid.load({
        token:token,
        params: params
    });
}
var rpsPartQuoteGrid = null;
function loadRpsPartQuoteData(row) {
    if (!rpsPartQuoteGrid) {
        rpsPartQuoteGrid = nui.get("rpsPartQuoteGrid");
        rpsPartQuoteGrid.on("drawcell", function (e) {
            if (e.field == "status") {
                e.cellHtml = statusHash2[e.value];
            }
            else{
                onDrawCell(e);
            }
        });
        var rpsPartQuoteGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsPartQuoteByServiceId.biz.ext";
        rpsPartQuoteGrid.setUrl(rpsPartQuoteGridUrl);
    }
    if (!row.id) {
        return;
    }
    var params = {
        serviceId: row.id
    };
    rpsPartQuoteGrid.load({
        token:token,
        params: params
    });
}
