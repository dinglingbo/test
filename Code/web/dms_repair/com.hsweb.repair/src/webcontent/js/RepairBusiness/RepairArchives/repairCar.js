/**
 * Created by Administrator on 2018/4/10.
 */
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var leftGrid = null;
var leftGridUrl = baseUrl + "com.hsapi.repair.repairService.query.queryMtHistoryList.biz.ext";

$(document).ready(function (v)
{
    leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);
    leftGrid.on("rowdblclick", function (e) {
        var row = e.record;
        onRowDblClick();
    });
    leftGrid.on("load", function () {
        var row = leftGrid.getSelected();
        if (row) {
            onRowDblClick({
                record:row
            });
        }
    });
    onSearch();
});

function onRowDblClick(e)
{
    var row = e.record;
    loadRpsPartData(row);
    loadRpsItemData(row);
}
function getSearchParams()
{
    var params = {};

    params.carNo = nui.get("carNo").getValue();
    params.serviceCode = nui.get("serviceCode").getValue();
    var searchType = nui.get("searchType").getValue();
    if(searchType == 1)
    {
        params.outDateIsNull = 1;
    }
    else {
        params.outDateIsNotNull = 1;
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
    leftGrid.load({
        token:token,
        params: params
    });
}
var statusHash2 = ["在报价", "在维修"];
var rpsItemGrid = null;
function loadRpsItemData(row) {
    if (!rpsItemGrid) {
        rpsItemGrid = nui.get("rpsItemGrid");
        var rpsItemGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsItemByServiceId.biz.ext";
        rpsItemGrid.setUrl(rpsItemGridUrl);
    }
    if (!row.id) {
        return;
    }
    var params = {
        serviceId: row.id
    };
    rpsItemGrid.load({
        token:token,
        params: params
    });
}
var rpsPartGrid = null;
function loadRpsPartData(row) {
    if (!rpsPartGrid) {
        rpsPartGrid = nui.get("rpsPartGrid");
        var rpsItemGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsPartByServiceId.biz.ext";
        rpsPartGrid.setUrl(rpsItemGridUrl);
    }
    if (!row.id) {
        return;
    }
    var params = {
        serviceId: row.id
    };
    rpsPartGrid.load({
        token:token,
        params: params
    });
}
function history()
{
    var row = leftGrid.getSelected();
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