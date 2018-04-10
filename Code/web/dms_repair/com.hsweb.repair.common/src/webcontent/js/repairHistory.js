/**
 * Created by Administrator on 2018/4/10.
 */
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var leftGrid = null;
var leftGridUrl = baseUrl + "com.hsapi.repair.repairService.query.queryMtHistoryList.biz.ext";

$(document).ready(function (v)
{
    setData({
        contactorId:1
    });
});
var mtTypeHash = {};
var serviceTypeIdHash = {};
var basicInfoForm = null;
var guestInfoForm = null;
var serviceTypeIdEl = null;
function init()
{
    basicInfoForm = new nui.Form("#basicInfoForm");
    basicInfoForm.setEnabled(false);
    guestInfoForm = new nui.Form("#guestInfoForm");
    guestInfoForm.setEnabled(false);
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
    var roleId = [];
    roleId.push("010802");
    getRoleMember(roleId, function (data) {
        data = data || {};
        var list = data.members || [];
        nui.get("mtAdvisorId").setData(list);
    });
    var pId = "DDT20130703000055";
    serviceTypeIdEl = nui.get("serviceTypeId");
    getDatadictionaries(pId, function (data) {
        data = data || {};
        var list = data.list || [];
        list.forEach(function (v) {
            serviceTypeIdHash[v.customid] = v;
        });
        serviceTypeIdEl.setData(list);
    });
    var dictIdList = [];
    dictIdList.push("DDT20130703000077");//客户身份
    getDictItems(dictIdList,function(data)
    {
        data = data||{};
        var itemList = data.dataItems||[];
        var identityList = itemList.filter(function(v){
            return  "DDT20130703000077" == v.dictid;
        });
        nui.get("identity").setData(identityList);
    });
    getAllCarBrand(function(data)
    {
        var list = data.carBrands;
        var carBrandIdEl = nui.get("carBrandId");
        carBrandIdEl.setData(list);
    });
    serviceTypeIdEl.on("valuechanged", function (data)
    {
        var serviceTypeId = serviceTypeIdEl.getValue();
        var mtTypeEl = nui.get("mtType");
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
}
function getGuestInfoByContactorId(contactorId,callback)
{
    var url = baseUrl + "com.hsapi.repair.repairService.query.getGuestInfoByContactorId.biz.ext";
    doPost({
        url:url,
        data:{
            contactorId:contactorId
        },
        success:function(data)
        {
            callback && callback(data);
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            callback && callback(null);
        }
    });
}
function setData(data)
{
    init();
    data = data||{};
    var contactorId = data.contactorId;
    getGuestInfoByContactorId(contactorId,function(data)
    {
        data = data||{};
        var guest = data.guest;
        if(guest && guest.id)
        {
            guestInfoForm.setData(guest);
        }
    });
    doSearch({
        contactorId:contactorId
    });
}

function onRowDblClick(e)
{
    var row = e.record;

    loadRpsItemQuoteData(row);
    loadRpsPartQuoteData(row);
    loadRpsPartData(row);
    loadRpsItemData(row);
    loadRpsItemBillData(row);
    loadRpsPartBillData(row);
    getMaintainById(row.id);
}

function doSearch(params) {
    params.orgid = currOrgid;
    leftGrid.load({
        token:token,
        params: params
    });
}
var statusHash2 = ["在报价", "在维修"];
var rpsItemQuoteGrid = null;
function loadRpsItemQuoteData(row) {
    if (!rpsItemQuoteGrid) {
        rpsItemQuoteGrid = nui.get("rpsItemQuoteGrid");
        rpsItemQuoteGrid.on("drawcell", function (e) {
            if (e.field == "status") {
                e.cellHtml = statusHash2[e.value];
            }
        });
        var rpsItemGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsItemQuoteByServiceId.biz.ext";
        rpsItemQuoteGrid.setUrl(rpsItemGridUrl);
    }
    if (!row.id) {
        return;
    }
    var params = {
        serviceId: row.id
    };
    rpsItemQuoteGrid.load({
        token:token,
        params: params
    });
}

var rpsPartQuoteGrid = null;
function loadRpsPartQuoteData(row) {
    if (!rpsPartQuoteGrid) {
        rpsPartQuoteGrid = nui.get("rpsPartQuoteGrid");
        rpsPartQuoteGrid.on("drawcell", function (e) {
            if (e.field == "status") {
                e.cellHtml = statusHash2[e.value];
            }
        });
        var rpsPartQuoteGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsPartQuoteByServiceId.biz.ext";
        rpsPartQuoteGrid.setUrl(rpsPartQuoteGridUrl);
    }
    if (!row.id) {
        return;
    }
    var params = {
        serviceId: row.id
    };
    rpsPartQuoteGrid.load({
        token:token,
        params: params
    });
}
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
var rpsItemBillGrid = null;
function loadRpsItemBillData(row)
{
    if(!rpsItemBillGrid)
    {
        rpsItemBillGrid = nui.get("rpsItemBillGrid");
        var url = baseUrl+"com.hsapi.repair.repairService.svr.getRpsItemBillByServiceId.biz.ext";
        rpsItemBillGrid.setUrl(url);
    }
    if (!row.id) {
        return;
    }
    var params = {
        serviceId: row.id
    };
    rpsItemBillGrid.load({
        token:token,
        params: params
    });
}
var rpsPartBillGrid = null;
function loadRpsPartBillData(row) {
    if (!rpsPartBillGrid) {
        rpsPartBillGrid = nui.get("rpsPartBillGrid");
        var url = baseUrl + "com.hsapi.repair.repairService.svr.getRpsPartBillByServiceId.biz.ext";
        rpsPartBillGrid.setUrl(url);
    }
    if (!row.id) {
        return;
    }
    var params = {
        serviceId: row.id
    };
    rpsPartBillGrid.load({
        token:token,
        params: params
    });
}
function getMaintainById(id) {
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
            if(!maintain)
            {
                return;
            }
            basicInfoForm.setData(maintain);
            serviceTypeIdEl.doValueChanged();
            nui.get("drawOutReport").setValue(maintain.drawOutReport);
            nui.get("guestDesc").setValue(maintain.guestDesc);
            nui.get("faultPhen").setValue(maintain.faultPhen);
            nui.get("solveMethod").setValue(maintain.solveMethod);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            nui.unmask();
        }
    });
}