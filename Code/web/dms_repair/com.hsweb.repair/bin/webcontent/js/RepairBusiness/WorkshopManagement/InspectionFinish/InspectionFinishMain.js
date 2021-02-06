/**
 * Created by Administrator on 2018/4/10.
 */
window._rootPartUrl = "http://127.0.0.1:8080/default/";
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var leftGrid = null;
var leftGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext";
var statusHash = ["", "在报价", "在维修","已完工"];
var rpsItemGrid = null;
var rpsItemGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsItemByServiceId.biz.ext";
var repairOutGrid = null;
var repairOutGridUrl  = window._rootPartUrl + "com.hsapi.part.purchase.repair.queryRepairOutList.biz.ext";
$(document).ready(function (v)
{
    repairOutGrid = nui.get("repairOutGrid");
    repairOutGrid.setUrl(repairOutGridUrl);

    rpsItemGrid = nui.get("itemGrid");
    rpsItemGrid.on("drawcell", function (e) {
        if (e.field == "status") {
            e.cellHtml = statusHash[e.value+1];
        }
        else{
            onDrawCell(e);
        }
    });
    rpsItemGrid.setUrl(rpsItemGridUrl);

    leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);
    leftGrid.on("drawcell", function (e) {
        if (e.field == "status") {
            e.cellHtml = statusHash[e.value];
        }
    });
    leftGrid.on("rowdblclick", function (e) {
        var row = e.record;
        getMaintainById(row.id);
    });
    leftGrid.on("load", function () {
        var row = leftGrid.getSelected();
        if (row) {
            getMaintainById(row.id);
        }
    });
    basicInfoForm = new nui.Form("#basicInfoForm");
    basicInfoForm.setEnabled(false);
    init(function () {
        quickSearch(2);
    });
});
var mtType = [];
var mtTypeHash = {};
var serviceTypeIdHash = {};
var serviceTypeIdEl = null;
var mtTypeEl = null;
function init(callback)
{
	serviceTypeIdEl = nui.get("serviceTypeId");
    mtTypeEl = nui.get("mtType");
    serviceTypeIdEl.on("valuechanged", function (data) {
        var serviceTypeId = serviceTypeIdEl.getValue();
        var list = serviceTypeIdEl.getData();
        for(var i=0;i<list.length;i++)
        {
            if(list[i].customid == serviceTypeId)
            {
                var mtTypeEl = nui.get("mtType");
                initDicts({
                    mtType:list[i].id
                });
                break;
            }
        }
    });
    var hash = {};
    nui.mask({
        html: '数据加载中..'
    });
    var checkComplete = function () {
        var keyList = ['getDatadictionaries', 'initDicts','initCarBrand'];
        for (var i = 0; i < keyList.length; i++) {
            if (!hash[keyList[i]]) {
                return;
            }
        }
        nui.unmask();
        callback && callback();
    };
    var pId = "DDT20130703000055";//业务类型
    getDatadictionaries(pId, function (data) {
        data = data || {};
        var list = data.list || [];
        serviceTypeIdEl.setData(list);
        var pId2 = "DDT20130703000057";//工种
        getDatadictionaries(pId2, function (data) {
            data = data || {};
            var list = data.list || [];
            hash.getDatadictionaries = true;
            checkComplete();
        });
    });
    initDicts({
        enterOilMass: "DDT20130703000051"//进厂油量
    },function(){
        hash.initDicts = true;
        checkComplete();
    });
    initCarBrand("carBrand",function()
    {
        hash.initCarBrand = true;
        checkComplete();
    });
}
function getMaintainById(id)
{
    var getMaintainByIdUrl = baseUrl + "com.hsapi.repair.repairService.svr.getMaintainById.biz.ext";
    nui.mask({
        html: '数据加载中..'
    });
    doPost({
        url: getMaintainByIdUrl,
        data: {
            id: id
        },
        success: function (data) {
            nui.unmask();
            data = data || {};
            var maintain = data.maintain;
            basicInfoForm.setData(maintain);
            serviceTypeIdEl.doValueChanged();
            loadRpsItemData();
            loadRepairOutData();
        },
        error: function (jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            nui.unmask();
        }
    });
}
function reloadLeftGrid()
{
    leftGrid.reload();
}
function loadRepairOutData()
{
    var maintain = basicInfoForm.getData();
    if (!maintain.id) {
        return;
    }
    var params = {
        serviceId: maintain.id,
        returnSign:0,
        orgid:currOrgid
    };
    repairOutGrid.load({
        token:token,
        params:params
    });
}
//完工总检
function onFinnish()
{
    var maintain = basicInfoForm.getData();
    if (!maintain.id) {
        return;
    }
    var itemList = rpsItemGrid.findRows(function(row)
    {
        return row.status != 2;
    });
    if(itemList.length>0)
    {
        nui.alert("还有项目未完工，不能总检");
        return;
    }
    var partList = repairOutGrid.findRows(function(row){
        return !row.auditor;
    });
    if(partList.length>0)
    {
        nui.alert("还有材料未审核，不能总检");
        return;
    }
    nui.open({
        // targetWindow: window,
        url: "com.hsweb.RepairBusiness.workInspection.flow",
        title: "车辆总检",
        width: 660,
        height: 420,
        allowResize: false,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var params = {
                id: maintain.id
            };
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action)
        {
            if (action == "ok")
            {
                quickSearch(3);
            }
        }
    });
}
var currType = 0;
function quickSearch(type)
{
    currType = type;
    if ($("a[id*='type']").length > 0) {
        $("a[id*='type']").css("color", "black");
    }
    if ($("#type" + type).length > 0) {
        $("#type" + type).css("color", "blue");
    }
    onSearch();
}
function getSearchParams()
{
    var params = {};
    switch (currType) {
        case 0:
            params.mtAuditor = currUserName;
            break;
        case 1:
            params.status = 1;
            break;
        case 2:
            params.status = 2;
            break;
        case 3:
            params.status = 3;
            break;
        case 4:
            params.status = 4;
            break;
        default:
            break;
    }
    params.carNo = nui.get("carNo-search").getValue();
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
function loadRpsItemData()
{
    var maintain = basicInfoForm.getData();
    if (!maintain.id) {
        return;
    }
    var params = {
        serviceId: maintain.id,
        withPkg:1
    };
    rpsItemGrid.load({
        token:token,
        params: params
    });
}
