/**
 * Created by Administrator on 2018/2/7.
 */
window._rootPartUrl = "http://127.0.0.1:8080/default/";
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var basicInfoForm = null;
var queryForm = null;
var queryInfoForm = null;


var leftGrid = null;
var leftGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext";
var rightGrid = null;
var rightGridUrl = window._rootPartUrl + "com.hsapi.part.purchase.svr.queryEnterStockList.biz.ext";
var rpsPartGrid = null;
var rpsPartGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsPartByServiceId.biz.ext";
var rightGrid1 = null;
var rightGrid1Url = window._rootPartUrl + "com.hsapi.part.purchase.repair.queryRepairOutList.biz.ext";
var rpsPartQuoteGrid = null;
var rpsPartQuoteGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsPartQuoteByServiceId.biz.ext";
var rpsItemGrid = null;
var itemGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsItemByServiceId.biz.ext";
var rightGrid5 = null;
var rightGrid5Url = baseUrl + "";
var statusHash = ["", "在报价", "在维修", "已完工"];
var statusHash2 = ["在报价", "在维修", "已领料"];
var statusHash3 = ["在报价", "在维修", "已完工"];
$(document).ready(function () {
    basicInfoForm = new nui.Form("#basicInfoForm");
    basicInfoForm.setEnabled(false);
    queryForm = new nui.Form("#queryForm");
    console.log(queryForm);
    queryInfoForm = new nui.Form("#queryInfoForm");
    console.log(queryInfoForm);

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


    rightGrid = nui.get("rightGrid");
    console.log(rightGrid);
    rightGrid.setUrl(rightGridUrl);

    rpsPartGrid = nui.get("rpsPartGrid");
    rpsPartGrid.setUrl(rpsPartGridUrl);
    rpsPartGrid.on("drawcell", function (e) {
        if (e.field == "status") {
            e.cellHtml = statusHash2[e.value];
        }
    });

    rightGrid1 = nui.get("rightGrid1");
    rightGrid1.setUrl(rightGrid1Url);
    rightGrid1.on("drawcell", function (e) {
        var maintain = basicInfoForm.getData();
        if (e.field == "action") {
            var row = e.record;
            console.log(maintain);
            if (maintain.status == 2 && maintain.partAuditSign != 1) {
                e.cellHtml = "<a href='javascript:;' onclick='returnStore(" + row.id + ")'>退回</a>";
            }
        }
    });

    rpsPartQuoteGrid = nui.get("rpsPartQuoteGrid");
    rpsPartQuoteGrid.setUrl(rpsPartQuoteGridUrl);
    rpsPartQuoteGrid.on("drawcell", function (e) {
        if (e.field == "status") {
            e.cellHtml = statusHash2[e.value];
        }
    });

    rpsItemGrid = nui.get("itemGrid");
    rpsItemGrid.setUrl(itemGridUrl);
    rpsItemGrid.on("drawcell", function (e) {
        if (e.field == "status") {
            e.cellHtml = statusHash3[e.value];
        }
        else {
            onDrawCell(e);
        }
    });

    rightGrid5 = nui.get("rightGrid5");
    //   console.log(rightGrid5);
    rightGrid5.setUrl(rightGrid5Url);
    init(function () {
        quickSearch(2);
    });
});
var serviceTypeIdHash = {};
var serviceTypeIdEl = null;
var mtTypeEl = null;
var mtTypeHash = {};
function init(callback) {
    serviceTypeIdEl = nui.get("serviceTypeId");
    mtTypeEl = nui.get("mtType");
    serviceTypeIdEl.on("valuechanged", function (data) {
        var serviceTypeId = serviceTypeIdEl.getValue();
        var list = serviceTypeIdEl.getData();
        for (var i = 0; i < list.length; i++) {
            if (serviceTypeId == list[i].customid) {
                var id = list[i].id;
                initDicts({
                    mtType: id
                }, function () {
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
        var keyList = ['getDatadictionaries', 'initDicts', 'initCarBrand', 'getStorehouse', 'initRoleMembers'];
        for (var i = 0; i < keyList.length; i++) {
            if (!hash[keyList[i]]) {
                return;
            }
        }
        nui.unmask();
        callback && callback();
    };
    
    var pId = SERVICE_TYPE;
    getDatadictionaries(pId, function (data) {
        data = data || {};
        var list = data.list || [];
        serviceTypeIdEl.setData(list);
        var pId = ITEM_KIND;
        getDatadictionaries(pId, function (data) {
            hash.getDatadictionaries = true;
            checkComplete();
        });
    });

    initDicts({
        enterOilMass: ENTER_OIL_MASS,//进厂油量
    }, function () {
        hash.initDicts = true;
        checkComplete();
    });
    initCarBrand("carBrand", function () {
        hash.initCarBrand = true;
        checkComplete();
    });
    getStorehouse(function (data) {
        data = data || [];
        var list = data.storehouse || [];
        nui.get("storeId").setData(list);
        if (list.length > 0) {
            nui.get("storeId").setValue(list[0].id);
        }
        hash.getStorehouse = true;
        checkComplete();
    });
    initRoleMembers({
        pickMan: "010817"
    }, function () {
        hash.initRoleMembers = true;
        checkComplete();
    });
}

function quickSearch(type) {
    var params = {};
    switch (type) {
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
    if ($("a[id*='type']").length > 0) {
        $("a[id*='type']").css("color", "black");
    }
    if ($("#type" + type).length > 0) {
        $("#type" + type).css("color", "blue");
    }
    doSearch(params);
}
function doSearch(params) {
    params.orgid = currOrgid;
    leftGrid.load({
        params: params,
        token :token
    });
}

function onSearch2(type) {
    var params = queryInfoForm.getData();
    if (type == 1) {
        params = {
            today: 1
        };
    }
    doSearch2(params);
}
function doSearch2(params) {
    params.orgid = currOrgid;
    rightGrid.load({
        params: params,
        token : token
    });
}
function reloadLeftGrid() {
    leftGrid.reload();
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
            basicInfoForm.setData(maintain);
            serviceTypeIdEl.doValueChanged();
            loadRpsPartData();
            loadRpsItemData();
            loadRpsPartQuoteData();
            loadRightGrid1Data();

            if (maintain.status != 2) {
                nui.get("auditBtn").disable();
                nui.get("antiAuditBtn").disable();
                nui.get("selectOut").disable();
            }
            else if (maintain.partAuditSign != 1) {
                nui.get("auditBtn").enable();
                nui.get("antiAuditBtn").disable();
                nui.get("selectOut").enable();
            }
            else {
                nui.get("auditBtn").disable();
                nui.get("antiAuditBtn").enable();
                nui.get("selectOut").disable();
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            nui.unmask();
        }
    });
}
function returnStore(id) {
    var row = rightGrid1.findRow(function (v) {
        if (v.id = id) {
            return true;
        }
    });
    nui.open({
        // targetWindow: window,
        url: "com.hsweb.RepairBusiness.repairOutReturn.flow",
        title: "车间退回", width: 500, height: 400,
        allowDrag: true,
        allowResize: false,
        onload: function () {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData({
                part: row
            });
        },
        ondestroy: function (action) {
            if (action == "ok") {
                loadRightGrid1Data();
                rightGrid.reload();
            }
        }
    });
}
function loadRightGrid1Data() {
    var maintain = basicInfoForm.getData();
    if (!maintain.id) {
        return;
    }
    var params = {};
    params.pickType = "050203";
    params.serviceId = maintain.id;
    params.returnSign = 0;
    params.orgid = currOrgid;
    rightGrid1.load({
        params: params
    });
}
function loadRpsPartData() {
    var maintain = basicInfoForm.getData();
    if (!maintain.id) {
        return;
    }
    var params = {
        serviceId: maintain.id,
        withPkg: 1
    };
    rpsPartGrid.load({
        params: params
    });
}
function loadRpsItemData() {
    var maintain = basicInfoForm.getData();
    if (!maintain.id) {
        return;
    }
    var params = {
        serviceId: maintain.id
    };
    rpsItemGrid.load({
        params: params
    });
}
function loadRpsPartQuoteData() {
    var maintain = basicInfoForm.getData();
    if (!maintain.id) {
        return;
    }
    var params = {
        serviceId: maintain.id,
        withPkg: 1
    };
    rpsPartQuoteGrid.load({
        params: params
    });
}

function repairOut() {
    var maintain = basicInfoForm.getData();
    if (!maintain.id) {
        return;
    }
    var row = rightGrid.getSelected();
    if (!row) {
        nui.alert("请选择要出库的配件");
        return;
    }
    nui.open({
        // targetWindow: window,
        url: "com.hsweb.RepairBusiness.repairOutDetail.flow",
        title: "车间领料", width: 500, height: 350,
        allowDrag: true,
        allowResize: false,
        onload: function () {
            var iframe = this.getIFrameEl();
            var params = {};
            var out = {
                serviceId: maintain.id,
                serviceCode: maintain.serviceCode,
                carNo: maintain.carNo,
                carId: maintain.carId,
                vin: maintain.vin,
                partId: row.partId,
                partCode: row.partCode,
                partName: row.partName,
                partNameId: row.partNameId,
                partFullName: row.partFullName,
                unit: row.unit,
                outableQty: row.outableQty,
                noTaxUnitPrice: row.noTaxUnitPrice,
                taxUnitPrice: row.taxUnitPrice,
                taxSign: row.taxSign,
                detailId: row.detailId,
                storeId: row.storeId,
                pickMan: nui.get("pickMan").getValue()
            };
            var pickManList = nui.get("pickMan").getData();
            params.out = out;
            params.pickManList = pickManList;
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action) {
            if (action == "ok") {
                rightGrid.reload();
                loadRightGrid1Data();
            }
        }
    });
}
function audit() {
    var maintain = basicInfoForm.getData();
    if (!maintain.id) {
        return;
    }
    var url = baseUrl + "com.hsapi.repair.repairService.work.partAudit.biz.ext";
    nui.mask({
        html: '审核中..'
    });
    doPost({
        url: url,
        data: {
            id: maintain.id
        },
        success: function (data) {
            nui.unmask();
            data = data || {};
            if (data.errCode == "S") {
                nui.alert("审核成功");
                reloadLeftGrid();
            }
            else {
                nui.alert(data.errMsg || "审核失败");
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
function antiAudit() {
    var maintain = basicInfoForm.getData();
    if (!maintain.id) {
        return;
    }
    var url = baseUrl + "com.hsapi.repair.repairService.work.antiPartAudit.biz.ext";
    nui.mask({
        html: '反审核中..'
    });
    doPost({
        url: url,
        data: {
            id: maintain.id
        },
        success: function (data) {
            nui.unmask();
            data = data || {};
            if (data.errCode == "S") {
                nui.alert("反审核成功");
                reloadLeftGrid();
            }
            else {
                nui.alert(data.errMsg || "反审核失败");
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

function addOrEditRpsPart(idx) {
    var maintain = basicInfoForm.getData();
    if (!maintain.id) {
        return;
    }
    nui.open({
        // targetWindow: window,
        url: "com.hsweb.RepairBusiness.addEditMaterialRepairOut.flow",
        title: "维修材料录入",
        width: 600,
        height: 220,
        allowResize: false,
        onload: function () {
            var list = rpsPartGrid.getData();
            var iframe = this.getIFrameEl();
            var params = {
                serviceId: maintain.id,
                sourceCode: "rpsPart",
                editType: "new",
                list: list
            };
            if (idx >= 0) {
                params.idx = idx;
                params.editType = "edit";
            }
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action) {
            if (action == "ok") {
                nui.alert("保存成功");
                loadRpsPartData();
            }
        }
    });
}
function onAddMaterial() {
    addOrEditRpsPart();
}
function onEditMaterial() {
    var row = rpsPartGrid.getSelected();
    var idx = 0;
    if (row) {
        idx = rpsPartGrid.indexOf(row);
    }
    addOrEditRpsPart(idx);
}
function onDeleteMaterial() {
    removeRpsPart();
}
function removeRpsPart() {
    var row = rpsPartGrid.getSelected();
    if (row && row.partId && row.serviceId) {
        var deletePartUrl = baseUrl + "com.hsapi.repair.repairService.sureMt.deleteRpsPart.biz.ext";
        nui.mask({
            html: '删除中..'
        });
        doPost({
            url: deletePartUrl,
            data: {
                part: {
                    partId: row.partId,
                    serviceId: row.serviceId
                }
            },
            success: function (data) {
                nui.unmask();
                data = data || {};
                if (data.errCode == "S") {
                    nui.alert("删除成功");
                    loadRpsPartData();
                }
                else {
                    nui.alert(data.errMsg || "删除失败");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                nui.unmask();
                console.log(jqXHR.responseText);
                nui.alert("网络出错");
            }
        });
    }
}
function onSaveMaterial() {

}
