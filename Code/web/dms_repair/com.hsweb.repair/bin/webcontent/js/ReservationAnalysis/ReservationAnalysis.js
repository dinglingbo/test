/**
 * Created by Administrator on 2018/4/26.
 */

var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var grid = null;
var gridUrl = baseUrl + "com.hsapi.repair.repairService.report.queryPreBookAnaylsisList.biz.ext";

$(document).ready(function (v)
{
    grid = nui.get("grid");
    grid.setUrl(gridUrl);
    grid.on("load",function(){
        var list = grid.getData();
        for(var i=0;i<list.length;i++)
        {
            var row = list[i];
            row.zyyp = row.zyy / row.tcount;
            row.bjp = row.bj / row.tcount;
            row.lsp = row.ls / row.tcount;
        }
        grid.setData(list);
    });
    grid.on("drawcell",function(e)
    {
        var field = e.field;
        var row = e.record;
        if(field == "groupName")
        {
            switch(currAnayType)
            {
                case 1://按维修顾问
                    e.field = "recorder";
                    break;
                case 8://按预约类型
                    e.field = "prebookCategory";
                    break;
                case 9://按预约项目
                    e.field = "prebookItem";
                    break;
            }
            onDrawCell(e);
        }
    });

    var hash = {};
    nui.mask({
        html: '数据加载中..'
    });
    var checkComplete = function () {
        var keyList = ["initDicts"];
        for (var i = 0; i < keyList.length; i++) {
            if (!hash[keyList[i]]) {
                return;
            }
        }
        nui.unmask();
        quickSearch(currType);
    };
    initDicts({
        prebookItem:PREBOOK_ITEM,//预约项目
        prebookCategory:PREBOOK_CATEGORY,//预约分类
    },function(){
        hash.initDicts = true;
        checkComplete();
    });
});

var searchByDateBtnTextHash = ["本日","昨日","本周","上周","本月","上月","本年","上年"];
var currType = 4;
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
var currAnayType = 1;
var analysisByDateBtnTextHash = ["按分店","按维修顾问","按品牌","按客户来源","按业务类型","按维修类型","按来厂次数","按投保公司","按预约类型","按预约项目"];
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
        case 1://按维修顾问
            params.groupField = "recorder";
            break;
        case 8://按预约类型
            params.groupField = "prebook_category";
            break;
        case 9://按预约项目
            params.groupField = "prebook_item";
            break;
    }
    return params;
}
function getSearchParams()
{
    var params = {};
    params.startDate = nui.get("startDate").getFormValue();
    params.endDate = nui.get("endDate").getFormValue();
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