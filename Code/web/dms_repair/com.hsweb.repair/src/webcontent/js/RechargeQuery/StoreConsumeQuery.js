/**
 * Created by Administrator on 2018/4/27.
 */
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var grid = null;
var gridUrl = baseUrl + "com.hsapi.repair.repairService.report.queryStoreConsume.biz.ext";

var queryInfoForm = null;
$(document).ready(function (v)
{

  queryInfoForm = new nui.Form("#queryInfoForm");
    grid = nui.get("grid");
    grid.setUrl(gridUrl);
    grid.on("drawcell",onDrawCell);
    quickSearch(currType);
});

var currType = 0;
function quickSearch(type) {
    var params = {};
    currType = type;

 
    var dateObj = getDate(type);
    nui.get("startDate").setValue(dateObj.startDate);
    nui.get("endDate").setValue(dateObj.endDate);
    onSearch();
}
function getSearchParams()
{
    var params = {};
    params.startDate = nui.get("startDate").getValue().substr(0,10);
    params.endDate = nui.get("endDate").getValue().substr(0,10);
    params.dataList=nui.get("data").getValue();
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

function onAdvancedSearchOk()
{
    var searchData = queryInfoForm.getData();
    var i,tmpList;
    if(searchData.startDate)
    {
        searchData.startDate = searchData.startDate.substr(0,10);
    }
    if(searchData.endDate)
    {
        searchData.endDate = searchData.endDate.substr(0,10);
    }
    
    doSearch(searchData);
}

