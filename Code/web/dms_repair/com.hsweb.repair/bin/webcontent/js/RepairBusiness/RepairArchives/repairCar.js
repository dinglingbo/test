/**
 * Created by Administrator on 2018/4/10.
 */
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var leftGrid = null;
var leftGridUrl = baseUrl + "com.hsapi.repair.repairService.query.queryMtHistoryList.biz.ext";
var statusHash = ["", "在报价", "在维修","已完工","在结算","预结算"];
$(document).ready(function (v)
{
    leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);
    leftGrid.on("drawcell",function(e){
        var field = e.field;
        if(field == "status")
        {
            e.cellHtml = statusHash[e.value];
        }
        else{
            onDrawCell(e);
        }
    });
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
    var hash = {};
    nui.mask({
        html: '数据加载中..'
    });
    var checkComplete = function () {
    	var keyList = ['getDatadictionaries',"initDicts","initCarBrand"];
        for (var i = 0; i < keyList.length; i++) {
            if (!hash[keyList[i]]) {
                return;
            }
        }
        nui.unmask();
        onSearch();
    };
    initDicts({
        receType1:"DDT20130706000013",//收费类型
        receType2:"DDT20130706000014"//免费类型
    },function(){
        hash.initDicts = true;
        checkComplete();
    });
    var pId2 = "DDT20130703000057";//工种
    getDatadictionaries(pId2, function (data) {
        data = data || {};
        var list = data.list || [];
        hash.getDatadictionaries = true;
        checkComplete();
    });
    initCarBrand("carBrand",function()
    {
        hash.initCarBrand = true;
        checkComplete();
    });
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
        rpsItemGrid.on("drawcell",onDrawCell);
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
        rpsPartGrid.on("drawcell",onDrawCell);
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
    if(!row || !row.guestId)
    {
        return;
    }
    nui.open({
        url: "com.hsweb.repair.common.repairHistory.flow",
        title: "维修历史", width: 850, height: 640,
        onload: function () {
            var iframe = this.getIFrameEl();
            var params = {
            	guestId:row.guestId
            };
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action) {
        }
    });
}