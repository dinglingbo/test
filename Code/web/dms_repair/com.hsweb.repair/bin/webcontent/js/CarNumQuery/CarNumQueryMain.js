/**
 * Created by Administrator on 2018/4/26.
 */
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var grid = null;
var gridUrl = baseUrl + "com.hsapi.repair.repairService.report.queryCarBaseList.biz.ext";
var queryInfoForm = null;
$(document).ready(function (v)
{
    queryInfoForm = new nui.Form("#queryInfoForm");
    grid = nui.get("grid");
    grid.setUrl(gridUrl);
    grid.on("drawcell",onDrawCell);
    var hash = {};
    nui.mask({
        html: '数据加载中..'
    });
    var checkComplete = function () {
        var keyList = ['initComp'];
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
});

function getSearchParams()
{
    var params = queryInfoForm.getData();
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
