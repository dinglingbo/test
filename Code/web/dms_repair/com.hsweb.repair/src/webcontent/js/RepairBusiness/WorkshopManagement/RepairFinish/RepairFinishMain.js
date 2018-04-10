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
    rpsItemGrid.on("beforeload",function(e){
        e.data.token = "";
    });
    rpsItemGrid.on("drawcell", function (e) {
        if (e.field == "status") {
            e.cellHtml = statusHash[e.value+1];
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
        onSearch();
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
        if(serviceTypeIdHash[serviceTypeId])
        {
            var id = serviceTypeIdHash[serviceTypeId].id;
            if (mtTypeHash[id]) {
                mtTypeEl.setData(mtTypeHash[id]);
            }
            else {
                var dictIdList = [];
                dictIdList.push(id);
                getDictItems(dictIdList, function (data) {
                    data = data || {};
                    var itemList = data.dataItems || [];
                    mtTypeHash[id] = itemList;
                    mtTypeEl.setData(mtTypeHash[id]);
                });
            }
        }
    });
    var hash = {};
    nui.mask({
        html: '数据加载中..'
    });
    var checkComplete = function () {
        var keyList = ['getDatadictionaries', 'getDictItems','getAllCarBrand'];
        for (var i = 0; i < keyList.length; i++) {
            if (!hash[keyList[i]]) {
                return;
            }
        }
        nui.unmask();
        callback && callback();
    };
    var pId = "DDT20130703000055";
    getDatadictionaries(pId, function (data) {
        data = data || {};
        var list = data.list || [];
        list.forEach(function (v) {
            serviceTypeIdHash[v.customid] = v;
        });
        serviceTypeIdEl.setData(list);
        hash.getDatadictionaries = true;
        checkComplete();
    });
    var dictIdList = [];
    dictIdList.push("DDT20130703000051");//进厂油量
    getDictItems(dictIdList, function (data) {
        data = data || {};
        var itemList = data.dataItems || [];
        var enterOilMassList = itemList.filter(function (v) {
            return "DDT20130703000051" == v.dictid;
        });
        nui.get("enterOilMass").setData(enterOilMassList);

        hash.getDictItems = true;
        checkComplete();
    });
    getAllCarBrand(function(data)
    {
        data = data||[];
        var carBrandList = data.carBrands||[];
        nui.get("carBrand").setData(carBrandList);
        hash.getAllCarBrand = true;
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
function checkAll()
{
    repairOutGrid.selectAll();
}
function inverse()
{
    var rows = repairOutGrid.getSelecteds();
    repairOutGrid.selectAll();
    repairOutGrid.deselects(rows);
}
function partAudit()
{
    var rows = repairOutGrid.getSelecteds();
    var url = window._rootPartUrl+"com.hsapi.part.purchase.repair.partAudit.biz.ext";
    nui.mask({
        html: '审核中..'
    });
    doPost({
        url: url,
        data: {
            list:rows
        },
        success: function (data) {
            nui.unmask();
            data = data || {};
            if(data.errCode == "S")
            {
                nui.alert("审核成功");
                repairOutGrid.reload();
            }
            else{
                nui.alert(data.errMsg||"审核失败");
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            nui.unmask();
            nui.alert("网络出错");
        }
    });
}
function antiPartAudit()
{
    var rows = repairOutGrid.getSelecteds();
    var url = window._rootPartUrl+"com.hsapi.part.purchase.repair.antiPartAudit.biz.ext";
    nui.mask({
        html: '取消审核中..'
    });
    doPost({
        url: url,
        data: {
            list:rows
        },
        success: function (data) {
            nui.unmask();
            data = data || {};
            if(data.errCode == "S")
            {
                nui.alert("取消审核成功");
                repairOutGrid.reload();
            }
            else{
                nui.alert(data.errMsg||"取消审核失败");
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            nui.unmask();
            nui.alert("网络出错");
        }
    });
}

function getSearchParams()
{
    var params = {};
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
    params.status = 2;
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
        serviceId: maintain.id
    };
    rpsItemGrid.load({
        token:token,
        params: params
    });
}
//项目完工
function itemFinish()
{
    var rows = rpsItemGrid.getSelecteds();
    rows = rows.filter(function(v){
        return v.beginDate;
    });
    var itemList = [];
    if(rows && rows.length>0)
    {
        itemList = rows.map(function(v)
        {
            return {
                serviceId:v.serviceId,
                itemId:v.itemId
            };
        });
    }
    else
    {
        nui.alert("请选择已派工的要完工的项目");
        return;
    }
    nui.mask({
        html:'保存中...'
    });
    var Url = baseUrl+"com.hsapi.repair.repairService.work.itemFinish.biz.ext";
    doPost({
        url:Url,
        data:{
            itemList:itemList
        },
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                nui.alert("完工成功");
                loadRpsItemData();
            }
            else{
                nui.alert(data.errMsg||"完工失败");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            nui.unmask();
            nui.alert("网络出错");
        }
    });
}
//取消项目完工
function cancelItemFinish()
{
    var rows = rpsItemGrid.getSelecteds();
    var itemList = [];
    if(rows && rows.length>0)
    {
        itemList = rows.map(function(v)
        {
            return {
                serviceId:v.serviceId,
                itemId:v.itemId
            };
        });
    }
    else
    {
        nui.alert("请选择要取消完工的项目");
    }
    nui.mask({
        html:'保存中...'
    });
    var Url = baseUrl+"com.hsapi.repair.repairService.work.cancelItemFinish.biz.ext";
    doPost({
        url:Url,
        data:{
            itemList:itemList
        },
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                nui.alert("取消完工成功");
                loadRpsItemData();
            }
            else{
                nui.alert(data.errMsg||"取消完工失败");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            nui.unmask();
            nui.alert("网络出错");
        }
    });
}
function selectAll()
{
    rpsItemGrid.selectAll();
}