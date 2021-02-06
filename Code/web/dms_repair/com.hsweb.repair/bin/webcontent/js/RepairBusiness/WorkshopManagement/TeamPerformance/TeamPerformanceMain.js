/**
 * Created by Administrator on 2018/4/12.
 */
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var grid1 = null;
var grid1Url = baseUrl + "com.hsapi.repair.repairService.report.queryTeamPreformanceList.biz.ext";
var tree = null;
var treeUrl = baseUrl+"com.hsapi.repair.common.svr.getClassTree.biz.ext";
var queryInfoFrom = null;
var grid2 = null;
var grid2Url = baseUrl + "com.hsapi.repair.repairService.report.queryTeamMemberPreformanceList.biz.ext";
$(document).ready(function (v)
{
    queryInfoFrom = new nui.Form("#queryInfoFrom");
    grid1 = nui.get("grid1");
    grid1.setUrl(grid1Url);
    grid1.on("rowdblclick",function(e)
    {
        var row = e.record;
        if(row.code)
        {
            loadClassMemberByCode(row.code);
        }
    });
    grid2  = nui.get("grid2");
    grid2.setUrl(grid2Url);
    grid2.on("drawcell",onDrawCell);
    tree = nui.get("tree1");
    tree.on("beforeload",function(e){
        e.data["orgid"] = currOrgid;
        e.data["token"] = token;
    });
    tree.on("nodeselect",function(e)
    {
        var node = e.node;
        if(node.parentid)
        {
            var id = node.id;
            id = id.replace("C","");
            loadClassMemberByWorkId(id);
        }
    });
    tree.setUrl(treeUrl);
    var hash = {};
    nui.mask({
        html: '数据加载中..'
    });
    var checkComplete = function () {
        var keyList = ["getDatadictionaries"];
        for (var i = 0; i < keyList.length; i++) {
            if (!hash[keyList[i]]) {
                return;
            }
        }
        nui.unmask();
        quickSearch(4)
    };
    var pId2 = "DDT20130703000057";//工种
    getDatadictionaries(pId2, function (data) {
        data = data || {};
        var list = data.list || [];
        hash.getDatadictionaries = true;
        checkComplete();
    });
});
function loadClassMemberByCode(code)
{
    var params = getSearchParams();
    params.classCode = code;
    loadClassMember(params);
}
function loadClassMemberByWorkId(id)
{
    var params = getSearchParams();
    params.workerId = id;
    loadClassMember(params);
}
function loadClassMember(params)
{
    params.orgid = currOrgid;
    grid2.load({
        token:token,
        params:params
    });
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
    var now = (new Date(currentTimeMillis));
    var year = now.getFullYear();
    var month = now.getMonth();
    var startDate,endDate;
    switch(type)
    {
        case 4://本月
            startDate = new Date(year,month,1);
            endDate = new Date(year,month+1,0);
            break;
        case 5://上月
            startDate = new Date(year,month-1,1);
            endDate = new Date(year,month,0);
            break;
        case 6://本年
            startDate = new Date(year,0,1);
            endDate = new Date(year,12,0);
            break;
        case 7://上年
            startDate = new Date(year-1,month,1);
            endDate = new Date(year-1,month+1,0);
            break;
    }
    queryInfoFrom.setData({
        startDate:startDate,
        endDate:endDate
    });
    onSearch();
}
function getSearchParams()
{
    var params = queryInfoFrom.getData();
    if(params.startDate)
    {
        params.startDate = params.startDate.substr(0,10);
    }
    if(params.endDate)
    {
        params.endDate = params.endDate.substr(0,10);
    }
    return params;
}
function onSearch()
{
    var params = getSearchParams();
    doSearch(params);
}
function doSearch(params) {
    params.orgid = currOrgid;
    grid1.load({
        token:token,
        params: params
    });
}