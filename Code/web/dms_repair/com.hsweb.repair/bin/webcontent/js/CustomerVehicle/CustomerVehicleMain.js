/**
 * Created by Administrator on 2018/4/27.
 */
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var grid = null;
var gridUrl = baseUrl + "com.hsapi.repair.repairService.report.queryCustomerCarDetailList.biz.ext";
var queryInfoForm = null;
var mainTab = null;
$(document).ready(function ()
{
    queryInfoForm = new nui.Form("#queryInfoForm");
    queryInfoForm.setData({
        queryDate:new Date()
    });
    mainTab = nui.get("mainTab");
    mainTab.on("activechanged",function()
    {
        onSearch();
    });
    var hash = {};
    nui.mask({
        html: '数据加载中..'
    });
    var checkComplete = function () {
        var keyList = ['initComp','initCarBrand','initInsureComp'];
        for (var i = 0; i < keyList.length; i++) {
            if (!hash[keyList[i]]) {
                return;
            }
        }
        nui.unmask();
        onSearch();
    };
    initComp("orgId",function(){
        hash.initComp = true;
        checkComplete();
    });
    initCarBrand("carBrand",function()
    {
        hash.initCarBrand = true;
        checkComplete();
    });
    initInsureComp("insureComp",function(){
        hash.initInsureComp = true;
        checkComplete();
    });
});

function getSearchParams()
{
    var params = queryInfoForm.getData();
    var activeTab = mainTab.getActiveTab();
    //console.log(activeTab);
    params.queryDate = params.queryDate.substr(0,10);
    params.queryType = activeTab._id.toString();
    return params;
}
function onSearch()
{
    var activeTab = mainTab.getActiveTab();
    if(activeTab._id < 9)
    {
        var params = getSearchParams();
        doSearch(params);
    }
}
function doSearch(params) {
    params.orgid = currOrgid;
    var type = params.queryType;
    var grid = nui.get("grid"+type);
    grid.setUrl(gridUrl);
    grid.on("drawcell",onDrawCell);
    grid.load({
        token:token,
        params: params
    });
}