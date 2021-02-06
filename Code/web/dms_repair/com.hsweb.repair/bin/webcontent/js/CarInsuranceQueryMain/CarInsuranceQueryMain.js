/**
 * Created by Administrator on 2018/4/26.
 */
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var grid = null;
var gridUrl = baseUrl + "com.hsapi.repair.repairService.report.queryRpsInsuranceList.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
$(document).ready(function (v)
{
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    grid = nui.get("grid");
    grid.setUrl(gridUrl);
    grid.on("drawcell",onDrawCell);
    var hash = {};
    nui.mask({
        html: '数据加载中..'
    });
    var checkComplete = function () {
        var keyList = ['initInsureComp','initCarBrand'];
        for (var i = 0; i < keyList.length; i++) {
            if (!hash[keyList[i]]) {
                return;
            }
        }
        nui.unmask();
        quickSearch(currType);
    };
    initRoleMembers({
        "insuranceCommissioner":"010807"
    },function(){
        hash.initRoleMembers = true;
        checkComplete();
    });
    initDicts({
        insuranceType:INSURANCE_TYPE ///保险销售分类
    },function(){
        hash.initDicts = true;
        checkComplete();
    });
    initInsureComp("insureComp",function(){
        hash.initInsureComp = true;
        checkComplete();
    });
    initCarBrand("carBrand",function()
    {
        hash.initCarBrand = true;
        checkComplete();
    });
});
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
    var dateObj = getDate(type);
    var data = advancedSearchForm.getData();
    data.startDate = dateObj.startDate;
    data.endDate = dateObj.endDate;
    advancedSearchForm.setData(data);
    onSearch();
}
function getSearchParams()
{
    var params = {};
    var data = advancedSearchForm.getData();
    params.startDate = data.startDate.substr(0,10);
    params.endDate = data.endDate.substr(0,10);
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
    var dateObj = getDate(currType);
    var data = advancedSearchForm.getData();
    data.startDate = dateObj.startDate;
    data.endDate = dateObj.endDate;
    advancedSearchForm.setData(data);
}
function selectCustomer()
{
    var params = {
        guestId:"guestId"
    };
    SelectCustomer(params);
}