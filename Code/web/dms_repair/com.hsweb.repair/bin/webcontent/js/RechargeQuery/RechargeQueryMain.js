/**
 * Created by Administrator on 2018/4/27.
 */
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var grid = null;
var gridUrl = baseUrl + "com.hsapi.repair.repairService.report.queryCardRechargeList.biz.ext";
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
    quickSearch(currType);
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
    nui.get("startDate").setValue(dateObj.startDate);
    nui.get("endDate").setValue(dateObj.endDate);
    onSearch();
}
function getSearchParams()
{
    var params = {};
    params.startDate = nui.get("startDate").getFormValue();
    params.endDate = nui.get("endDate").getFormValue();
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
    if(searchData.startDate)
    {
        searchData.startDate = searchData.startDate.substr(0,10);
    }
    if(searchData.endDate)
    {
        searchData.endDate = searchData.endDate.substr(0,10);
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