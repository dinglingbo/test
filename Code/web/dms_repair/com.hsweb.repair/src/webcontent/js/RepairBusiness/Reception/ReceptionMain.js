/**
 * Created by Administrator on 2018/3/21.
 */
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var leftGrid = null;
var leftGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext";
var tree1 = null;
var statusHash = ["", "在报价", "在维修"];
var itemGrid = null;
var itemGridUrl = baseUrl + "com.hsapi.repair.baseData.item.queryRepairItemList.biz.ext";
$(document).ready(function (v) {
    itemGrid = nui.get("itemGrid");
    itemGrid.setUrl(itemGridUrl);
    tree1 = nui.get("tree1");
    var parentId = "DDT20130703000063";
    getDatadictionaries(parentId, function (data) {
        var list = data.list || [];
        tree1.loadList(list);
    });
    tree1.on("nodedblclick", function (e) {
        var node = e.node;
        var customid = node.customid;
        var params = getSearchItemParams();
        params.type = customid;
        doSearchItem(params);
    });
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
    init(function () {
        quickSearch(0);
    });
});
var mtType = [];
var mtTypeHash = {};
var serviceTypeIdHash = {};
var serviceTypeIdEl = null;
var mtTypeEl = null;
function init(callback) {
    serviceTypeIdEl = nui.get("serviceTypeId");
    mtTypeEl = nui.get("mtType");
    serviceTypeIdEl.on("valuechanged", function (data) {
        var serviceTypeId = serviceTypeIdEl.getValue();
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
    });
    var hash = {};
    nui.mask({
        html: '数据加载中..'
    });
    var checkComplete = function () {
        var keyList = ['getDatadictionaries', 'getDictItems', 'getRoleMember'];
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
    dictIdList.push("DDT20130703000077");//客户身份
    getDictItems(dictIdList, function (data) {
        data = data || {};
        var itemList = data.dataItems || [];
        var enterOilMassList = itemList.filter(function (v) {
            return "DDT20130703000051" == v.dictid;
        });
        nui.get("enterOilMass").setData(enterOilMassList);
        var identityList = itemList.filter(function (v) {
            return "DDT20130703000077" == v.dictid;
        });
        nui.get("identity").setData(identityList);
        hash.getDictItems = true;
        checkComplete();
    });
    var roleId = [];
    roleId.push("010802");
    getRoleMember(roleId, function (data) {
        data = data || {};
        var list = data.members || [];
        nui.get("mtAdvisorId").setData(list);
        hash.getRoleMember = true;
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
        params: params
    });
}
//工时录入start
var itemQueryForm = null;
function getSearchItemParams() {
    if (!itemQueryForm) {
        itemQueryForm = new nui.Form("#itemQueryForm");
    }
    var params = itemQueryForm.getData();
    if (params.pyName) {
        params.pyName = params.pyName.toUpperCase();
    }
    return params;
}
function onSearchItem() {
    var params = getSearchItemParams();
    doSearchItem(params);
}
function doSearchItem(params) {
    params.orgid = currOrgid;
    itemGrid.load({
        params: params
    });
}
function selectItem() {
    var row = itemGrid.getSelected();
    if (row) {
        var item = {
            itemId: row.id,
            itemCode: row.code,
            itemName: row.name,
            itemIsNeed: 1,
            itemKind: row.itemKind,
            itemTime: row.itemTime,
            unitPrice: row.unitPrice,
            amt: row.amt,
            pkgitemamt: 0,
            rate: 0,
            discountAmt: 0,
            subtotal: row.amt,
            deductAmt: row.deductAmt,
            status: 0,
            receTypeId: "04150101"
        };
        var insList = [];
        insList.push(item);
        saveItem(insList, [], function (data) {
            data = data || {};
            if (data.errCode == "S") {
                nui.alert("录入成功");
                loadRpsItemQuoteData();
            }
            else {
                nui.alert("保存失败");
            }
        });
    }
}
function saveItem(insList, updList, callback) {
    var maintain = basicInfoForm.getData();
    if (!maintain.id) {
        nui.alert("数据错误");
        return;
    }
    insList = insList || [];
    updList = updList || [];
    var saveItemUrl = baseUrl + "com.hsapi.repair.repairService.crud.saveRpsItemQuote.biz.ext";
    doPost({
        url: saveItemUrl,
        data: {
            insList: insList,
            updList: updList,
            serviceId: maintain.id
        },
        success: function (data) {
            callback && callback(data);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            callback({});
        }
    });
}
//本店套餐录入
function selectPackage() {
    var maintain = basicInfoForm.getData();
    if (!maintain.id) {
        return;
    }
    nui.open({
        targetWindow: window,
        url: "com.hsweb.repair.common.rpbPackageSelect.flow",
        title: "本店套餐",
        width: 1000,
        height: 600,
        allowResize: false,
        onload: function () {
            var iframe = this.getIFrameEl();
            var params = {};
            iframe.contentWindow.setData(params, function (data, callback) {
                console.log(data);
                var _package = {};
                var tmpPkg = data.package;
                _package.serviceId = maintain.id;
                _package.packageId = tmpPkg.id;
                _package.packageName = tmpPkg.name;
                _package.packageTypeId = tmpPkg.type;
                _package.receTypeId = "04150101";
                _package.pkgamt = tmpPkg.amount;
                _package.amt = tmpPkg.amount;
                _package.detailAmt = tmpPkg.amount;
                _package.subtotal = tmpPkg.amount;
                _package.amt4s = tmpPkg.total;
                _package.differAmt = 0;
                _package.costAmt = 0;
                _package.discountAmt = 0;
                _package.rate = 0;
                _package.status = 0;
                _package.isDisabled = 0;
                var tmpItemList = data.itemList;
                var itemList = tmpItemList.map(function (v) {
                    return {
                        itemId: v.itemId,
                        itemCode: v.itemCode,
                        itemName: v.itemName,
                        itemIsNeed: 1,
                        receTypeId: _package.receTypeId,
                        serviceId: _package.serviceId,
                        itemKind: v.itemKind,
                        itemTime: v.itemTime,
                        unitPrice: v.unitPrice,
                        pkgitemamt: v.amt,
                        amt: v.amt,
                        rate: 0,
                        discountAmt: 0,
                        subtotal: v.amt,
                        status: 0
                    }
                });
                var tmpPartList = data.partList;
                var partList = tmpPartList.map(function (v) {
                    return {
                        receTypeId: _package.receTypeId,
                        serviceId: _package.serviceId,
                        partId: v.partId,
                        partCode: v.partCode,
                        partName: v.partName,
                        partIsNeed: 1,
                        qty: v.qty,
                        unit: v.unit,
                        unitPrice: v.unitPrice,
                        amt: v.amt,
                        rate: 0,
                        discountAmt: 0,
                        subtotal: v.amt,
                        status: 0
                    };
                });
                var par = {
                    pkg: _package,
                    itemList: itemList,
                    partList: partList
                };
                savePackage(par, function (data) {
                    data = data || {};
                    if (data.errCode == "S") {
                        callback && callback({
                            info: "本店套餐录入成功",
                            close: true
                        });
                        loadPackageGridData();
                    }
                    else {
                        callback && callback({
                            info: data.errMsg || "本店套餐录入失败",
                            close: false
                        })
                    }
                })
            });
        },
        ondestroy: function (action) {
        }
    });
}
function savePackage(params, callback) {
    var maintain = basicInfoForm.getData();
    if (!maintain.id) {
        nui.alert("数据错误");
        return;
    }
    var saveItemUrl = baseUrl + "com.hsapi.repair.repairService.crud.insRpsPackage.biz.ext";
    doPost({
        url: saveItemUrl,
        data: params,
        success: function (data) {
            callback && callback(data);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            callback({});
        }
    });
}
//工时录入end
//套餐清单start
var packageGrid = null;
var packageDetailGrid_Form = null;
var packageDetailGrid = null;
function loadPackageGridData()
{
    if (!packageGrid)
    {
        packageDetailGrid_Form = document.getElementById("packageDetailGrid_Form");
        packageGrid = nui.get("packageGrid");
        packageGrid.on("load",function()
        {
            var list = packageGrid.getData();
            var sum = 0;
            list.forEach(function(v){
                sum += v.amt;
            });
            sum = sum.toFixed(2);
            $("#pkgTotal").html(sum);
        });
        var packageGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.queryRpsPackageByServiceId.biz.ext";
        packageGrid.setUrl(packageGridUrl);
        packageDetailGrid = nui.get("packageDetailGrid");
        var packageDetailGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsPackageDetail.biz.ext";
        packageDetailGrid.setUrl(packageDetailGridUrl);
        packageGrid.on("drawcell", function (e) {
            if (e.field == "status") {
                e.cellHtml = statusHash2[e.value];
            }
        });
        packageGrid.on("showrowdetail", function (e) {
            var grid = e.sender;
            var row = e.record;
            var td = grid.getRowDetailCellEl(row);
            td.appendChild(packageDetailGrid_Form);
            packageDetailGrid_Form.style.display = "block";
            var params = {
                serviceId: row.serviceId,
                packageId: row.id
            };
            packageDetailGrid.load({
                params: params
            });
        });
    }
    var maintain = basicInfoForm.getData();
    if (!maintain.id) {
        return;
    }
    var params = {
        serviceId: maintain.id
    };
    packageGrid.load({
        params: params
    });
}
function editRpsPackage() {
    var row = packageGrid.getSelected();
    if (!row.id) {
        return;
    }
    nui.open({
        targetWindow: window,
        url: "com.hsweb.RepairBusiness.editRpsPackage.flow",
        title: "修改套餐",
        width: 800,
        height: 500,
        allowResize: false,
        onload: function () {
            var iframe = this.getIFrameEl();
            var params = {
                packageId: row.id
            };
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action) {
            if (action == "ok") {
                loadPackageGridData();
            }
        }
    });
}
function removeRpsPackage() {
    var row = packageGrid.getSelected();
    if (row && row.id) {
        var deleteUrl = baseUrl + "com.hsapi.repair.repairService.svr.deleteRpsPackage.biz.ext";
        nui.mask({
            html: '删除中..'
        });
        doPost({
            url: deleteUrl,
            data: {
                id: row.id
            },
            success: function (data) {
                nui.unmask();
                data = data || {};
                if (data.errCode == "S") {
                    nui.alert("删除成功");
                    loadPackageGridData();
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
function sureMtRpsPackage()
{
    var maintain = basicInfoForm.getData();
    if (maintain.status == 1) {
        return;
    }
    var row = packageGrid.getSelected();
    if (row && row.id) {
        var sureMtUrl = baseUrl + "com.hsapi.repair.repairService.sureMt.sureMtPackage.biz.ext";
        nui.mask({
            html: '保存中..'
        });
        doPost({
            url: sureMtUrl,
            data: {
                pkgId: row.id
            },
            success: function (data) {
                nui.unmask();
                data = data || {};
                if (data.errCode == "S") {
                    nui.alert("同意维修成功");
                    loadPackageGridData();
                }
                else {
                    nui.alert(data.errMsg || "同意维修失败");
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
//套餐清单end
//估算项目/材料start
function rpsItemPartQuoteAmtCal()
{
    if(!rpsItemQuoteGrid || !rpsItemQuoteGrid)
    {
        return;
    }
    var itemList = rpsItemQuoteGrid.getData();
    var i,sum = 0;
    for(i=0;i<itemList.length;i++)
    {
        sum += itemList[i].amt;
    }
    var partList = rpsPartQuoteGrid.getData();
    for(i=0;i<partList.length;i++)
    {
        sum += partList[i].amt;
    }
    sum = sum.toFixed(2);
    $("#rpsItemPartQuoteAmt").html(sum);
}
var statusHash2 = ["在报价", "在维修"];
var rpsItemQuoteGrid = null;
function loadRpsItemQuoteData() {
    if (!rpsItemQuoteGrid) {
        rpsItemQuoteGrid = nui.get("rpsItemQuoteGrid");
        rpsItemQuoteGrid.on("load",function(){
            rpsItemPartQuoteAmtCal();
        });
        rpsItemQuoteGrid.on("drawcell", function (e) {
            if (e.field == "status") {
                e.cellHtml = statusHash2[e.value];
            }
        });
        var rpsItemGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsItemQuoteByServiceId.biz.ext";
        rpsItemQuoteGrid.setUrl(rpsItemGridUrl);
    }
    var maintain = basicInfoForm.getData();
    if (!maintain.id) {
        return;
    }
    var params = {
        serviceId: maintain.id
    };
    rpsItemQuoteGrid.load({
        params: params
    });
}
function addOrEditRpsItemQuote(idx)
{
    var maintain = basicInfoForm.getData();
    if(!maintain.id)
    {
        return;
    }
    nui.open({
        targetWindow: window,
        url:"com.hsweb.RepairBusiness.addEditItem.flow",
        title:"维修项目录入",
        width:600,
        height:200,
        allowResize:false,
        onload: function()
        {
            var list = rpsItemQuoteGrid.getData();
            var iframe = this.getIFrameEl();
            var params = {
                serviceId:maintain.id,
                sourceCode:"rpsItemQuote",
                editType:"new",
                list:list
            };
            if(idx >= 0)
            {
                params.idx = idx;
                params.editType = "edit";
            }
            iframe.contentWindow.setData(params);
        },
        ondestroy:function(action)
        {
            if(action == "ok")
            {
                nui.alert("保存成功");
                loadRpsItemGridData();
            }
        }
    });
}
function addRpsItemQuote()
{
    addOrEditRpsItemQuote();
}
function editRpsItemQuote()
{
    var row = rpsItemQuoteGrid.getSelected();
    var idx = 0;
    if(row)
    {
        idx = rpsItemQuoteGrid.indexOf(row);
    }
    addOrEditRpsItemQuote(idx);
}
function removeRpsItemQuote()
{
    var row = rpsItemQuoteGrid.getSelected();
    if(row && row.itemId && row.serviceId)
    {
        var deleteItemUrl = baseUrl+"com.hsapi.repair.repairService.crud.deleteRpsItemQuote.biz.ext";
        nui.mask({
            html:'删除中..'
        });
        doPost({
            url:deleteItemUrl,
            data:{
                item:{
                    itemId:row.itemId,
                    serviceId:row.serviceId
                }
            },
            success:function(data)
            {
                nui.unmask();
                data = data||{};
                if(data.errCode == "S")
                {
                    nui.alert("删除成功");
                    loadRpsItemGridData();
                }
                else{
                    nui.alert(data.errMsg||"删除失败");
                }
            },
            error:function(jqXHR, textStatus, errorThrown)
            {
                nui.unmask();
                console.log(jqXHR.responseText);
                nui.alert("网络出错");
            }
        });
    }
}
function sureMtItem()
{
    var maintain = basicInfoForm.getData();
    if(maintain.status == 0)
    {
        return;
    }
    var row = rpsItemQuoteGrid.getSelected();
    if (row && row.status == 0) {
        var sureMtItemUrl = baseUrl + "com.hsapi.repair.repairService.sureMt.sureMtItem.biz.ext";
        nui.mask({
            html: '保存中..'
        });
        doPost({
            url: sureMtItemUrl,
            data: {
                itemQuote: row
            },
            success: function (data) {
                nui.unmask();
                data = data || {};
                if (data.errCode == "S") {
                    nui.alert("同意维修成功");
                    loadRpsItemQuoteData();
                    loadRpsItemData();
                }
                else {
                    nui.alert(data.errMsg || "同意维修失败");
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

var rpsPartQuoteGrid = null;
function loadRpsPartQuoteData() {
    if (!rpsPartQuoteGrid) {
        rpsPartQuoteGrid = nui.get("rpsPartQuoteGrid");
        rpsPartQuoteGrid.on("load",function(){
            rpsItemPartQuoteAmtCal();
        });
        rpsPartQuoteGrid.on("drawcell", function (e) {
            if (e.field == "status") {
                e.cellHtml = statusHash2[e.value];
            }
        });
        var rpsPartQuoteGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsPartQuoteByServiceId.biz.ext";
        rpsPartQuoteGrid.setUrl(rpsPartQuoteGridUrl);
    }
    var maintain = basicInfoForm.getData();
    if (!maintain.id) {
        return;
    }
    var params = {
        serviceId: maintain.id
    };
    rpsPartQuoteGrid.load({
        params: params
    });
}
function addOrEditRpsPartQuote(idx)
{
    var maintain = basicInfoForm.getData();
    if(!maintain.id)
    {
        return;
    }
    nui.open({
        targetWindow: window,
        url:"com.hsweb.RepairBusiness.addEditMaterial.flow",
        title:"维修材料录入",
        width:600,
        height:200,
        allowResize:false,
        onload: function()
        {
            var list = rpsPartQuoteGrid.getData();
            var iframe = this.getIFrameEl();
            var params = {
                serviceId:maintain.id,
                sourceCode:"rpsPartQuote",
                editType:"new",
                list:list
            };
            if(idx >= 0)
            {
                params.idx = idx;
                params.editType = "edit";
            }
            iframe.contentWindow.setData(params);
        },
        ondestroy:function(action)
        {
            if(action == "ok")
            {
                nui.alert("保存成功");
                loadRpsPartQuoteData();
            }
        }
    });
}
function addRpsPartQuote()
{
    addOrEditRpsPartQuote();
}
function editRpsPartQuote()
{
    var row = rpsPartQuoteGrid.getSelected();
    var idx = 0;
    if(row)
    {
        idx = rpsPartQuoteGrid.indexOf(row);
    }
    addOrEditRpsPartQuote(idx);
}
function removeRpsPartQuote()
{
    var row = rpsPartQuoteGrid.getSelected();
    if(row && row.partId && row.serviceId)
    {
        var deleteItemUrl = baseUrl+"com.hsapi.repair.repairService.crud.deleteRpsPartQuote.biz.ext";
        nui.mask({
            html:'删除中..'
        });
        doPost({
            url:deleteItemUrl,
            data:{
                item:{
                    partId:row.partId,
                    serviceId:row.serviceId
                }
            },
            success:function(data)
            {
                nui.unmask();
                data = data||{};
                if(data.errCode == "S")
                {
                    nui.alert("删除成功");
                    loadRpsPartQuoteData();
                }
                else{
                    nui.alert(data.errMsg||"删除失败");
                }
            },
            error:function(jqXHR, textStatus, errorThrown)
            {
                nui.unmask();
                console.log(jqXHR.responseText);
                nui.alert("网络出错");
            }
        });
    }
}
function sureMtPart()
{
    var maintain = basicInfoForm.getData();
    if(maintain.status == 0)
    {
        return;
    }
    var row = rpsPartQuoteGrid.getSelected();
    if (row && row.status == 0) {
        var sureMtPartUrl = baseUrl + "com.hsapi.repair.repairService.sureMt.sureMtPart.biz.ext";
        nui.mask({
            html: '保存中..'
        });
        doPost({
            url: sureMtPartUrl,
            data: {
                partQuote: row
            },
            success: function (data) {
                nui.unmask();
                data = data || {};
                if (data.errCode == "S") {
                    nui.alert("同意维修成功");
                    loadRpsPartQuoteData();
                    loadRpsPartData();
                }
                else {
                    nui.alert(data.errMsg || "同意维修失败");
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
//估算项目/材料end
//维修项目/材料start
function rpsItemPartAmtAmtCal()
{
    if(!rpsItemGrid || !rpsPartGrid)
    {
        return;
    }
    var itemList = rpsItemGrid.getData();
    var i,sum = 0;
    for(i=0;i<itemList.length;i++)
    {
        sum += itemList[i].amt;
    }
    var partList = rpsPartGrid.getData();
    for(i=0;i<partList.length;i++)
    {
        sum += partList[i].amt;
    }
    sum = sum.toFixed(2);
    $("#rpsItemPartAmt").html(sum);
}
var rpsItemGrid = null;
function loadRpsItemData() {
    if (!rpsItemGrid) {
        rpsItemGrid = nui.get("rpsItemGrid");
        rpsItemGrid.on("load",function(){
            rpsItemPartAmtAmtCal();
        });
        var rpsItemGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsItemByServiceId.biz.ext";
        rpsItemGrid.setUrl(rpsItemGridUrl);
    }
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
function addOrEditRpsItem(idx) {
    var maintain = basicInfoForm.getData();
    if (!maintain.id) {
        return;
    }
    nui.open({
        targetWindow: window,
        url: "./subpage/addEditItem.html",
        title: "维修项目录入",
        width: 600,
        height: 200,
        allowResize: false,
        onload: function () {
            var list = rpsItemGrid.getData();
            var iframe = this.getIFrameEl();
            var params = {
                serviceId: maintain.id,
                sourceCode: "rpsItem",
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
                loadRpsItemData();
            }
        }
    });
}
function editRpsItem()
{
    var row = rpsItemGrid.getSelected();
    var idx = 0;
    if (row) {
        idx = rpsItemGrid.indexOf(row);
    }
    addOrEditRpsItem(idx);
}
function removeRpsItem() {
    var row = rpsItemGrid.getSelected();
    if (row && row.itemId && row.serviceId) {
        var deleteItemUrl = baseUrl + "com.hsapi.repair.repairService.sureMt.deleteRpsItem.biz.ext";
        nui.mask({
            html: '删除中..'
        });
        doPost({
            url: deleteItemUrl,
            data: {
                item: {
                    itemId: row.itemId,
                    serviceId: row.serviceId
                }
            },
            success: function (data) {
                nui.unmask();
                data = data || {};
                if (data.errCode == "S") {
                    nui.alert("删除成功");
                    loadRpsItemData();
                    loadRpsItemQuoteData()
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


var rpsPartGrid = null;
function loadRpsPartData() {
    if (!rpsPartGrid) {
        rpsPartGrid = nui.get("rpsPartGrid");
        rpsPartGrid.on("load",function(){
            rpsItemPartAmtAmtCal();
        });
        var rpsItemGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsPartByServiceId.biz.ext";
        rpsPartGrid.setUrl(rpsItemGridUrl);
    }
    var maintain = basicInfoForm.getData();
    if (!maintain.id) {
        return;
    }
    var params = {
        serviceId: maintain.id
    };
    rpsPartGrid.load({
        params: params
    });
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
                    loadRpsPartQuoteData();
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
function addOrEditRpsPart(idx) {
    var maintain = basicInfoForm.getData();
    if (!maintain.id) {
        return;
    }
    nui.open({
        targetWindow: window,
        url: "./subpage/addEditMaterial.html",
        title: "维修材料录入",
        width: 600,
        height: 200,
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
function editRpsPart()
{
    var row = rpsPartGrid.getSelected();
    var idx = 0;
    if (row) {
        idx = rpsPartGrid.indexOf(row);
    }
    addOrEditRpsPart(idx);
}
//维修项目/材料end
function resetBtn()
{
    nui.get("sureMtBtn").disable();
    nui.get("unMtBtn").disable();
    nui.get("reviewBtn").disable();
    nui.get("balanceBtn").disable();
    nui.get("outBtn").disable();
    nui.get("returnBtn").disable();
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
            resetBtn();
            if (maintain.status == 1) {
                nui.get("sureMtBtn").enable();
                nui.get("unMtBtn").enable();
            }
            loadRpsItemQuoteData();
            loadRpsPartQuoteData();
            loadPackageGridData();
            loadRpsItemData();
            loadRpsPartData();
        },
        error: function (jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            nui.unmask();
        }
    });
}
function selectCustomer(callback)
{
    nui.open({
        url: "../common1/Customer.html",
        title: "客户选择", width: 800, height:450,
        onload: function () {
        },
        ondestroy: function (action)
        {
            if("ok" == action)
            {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                var guest = data.guest;
                callback && callback(guest);
            }
        }
    });
}
function reload()
{
    leftGrid.reload();
}
function add()
{
    selectCustomer(function(car)
    {
        var maintain = {
            guestId:car.guestId,
            contactorId:car.contactorId,
            carId:car.id,
            carNo:car.carNo,
            carVin:car.underpanNo,
            serviceTypeId:"0",
            mtType:"0",
            mtAdvisor:currUserName,
            insureCompCode:car.insureCompCode
        };
        nui.mask({
            html:'保存中..'
        });
        getServiceCode(function(data)
        {
            var code = data.code;
            if(!code)
            {
                nui.alert("获取单号失败");
                return;
            }
            maintain.serviceCode = code;
            saveMaintain(maintain,function(data)
            {
                nui.unmask();
                data = data||{};
                if(data.errCode == "S")
                {
                    reload();
                }
                else{
                    nui.alert(data.errMsg||"新增失败");
                }
            });
        });
    });
}
function changeCar()
{
    var maintain = basicInfoForm.getData();
    if(!maintain.id)
    {
        return;
    }
    selectCustomer(function(car)
    {

        maintain.carId = car.id;
        maintain.carNo = car.carNo;
        maintain.carVin = car.underpanNo;
        maintain.engineNo = car.engineNo;
        maintain.contactorId = car.contactorId;
        maintain.contactorName = car.contactName;
        maintain.identity = car.identity;
        maintain.mobile = car.mobile;
        maintain.guestFullName = car.guestFullName;
        maintain.guestId = car.guestId;
        maintain.carModel = car.carModel;
        basicInfoForm.setData(maintain);
    });
}
function getServiceCode(callback)
{
    callback = callback||function(){};
    var billTypeCode = "BJD";
    getCompBillNO(billTypeCode,function(data)
    {
        data = data||{};
        var code = data.serviceno;
        callback && callback({
            code:code
        });
    });
}
var saveUrl = baseUrl+"com.hsapi.repair.repairService.crud.saveRpsMaintain.biz.ext";
function saveMaintain(maintain,callback)
{
    doPost({
        url:saveUrl,
        data:{
            maintain:maintain
        },
        success:function(data)
        {
            callback && callback(data);
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            callback({});
        }
    });
}
function save()
{
    var maintain = basicInfoForm.getData();
    if(!maintain.id)
    {
        nui.alert("数据错误");
        return;
    }
    nui.mask({
        html:'保存中..'
    });
    saveMaintain(maintain,function(data)
    {
        nui.unmask();
        data = data||{};
        if(data.errCode == "S")
        {
            reload();
            nui.alert("保存成功");
        }
        else{
            nui.alert(data.errMsg||"保存失败");
        }
    });
}
function getSureMtCode(callback) {
    callback = callback || function () {
        };
    var billTypeCode = "WXD";
    getCompBillNO(billTypeCode, function (data) {
        data = data || {};
        var code = data.serviceno;
        callback && callback({
            code: code
        });
    });
}
function sureMt() {
    var maintain = basicInfoForm.getData();
    if (!maintain.id) {
        return;
    }
    var sureMtUrl = baseUrl + "com.hsapi.repair.repairService.sureMt.repairSureMt.biz.ext";
    nui.mask({
        html: '保存中..'
    });
    getSureMtCode(function (data) {
        data = data || {};
        var code = data.code;
        if (!code) {
            nui.unmask();
            nui.alert("获取单号失败");
            return;
        }
        doPost({
            url: sureMtUrl,
            data: {
                id: maintain.id,
                serviceCode: code
            },
            success: function (data) {
                nui.unmask();
                data = data || {};
                if (data.errCode == "S") {
                    nui.alert("确定维修成功");
                    quickSearch(2);
                }
                else {
                    nui.alert(data.errMsg || "确定维修失败");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                //  nui.alert(jqXHR.responseText);
                nui.unmask();
                console.log(jqXHR.responseText);
                nui.alert("网络出错");
            }
        });
    });

}
function entry() {
    nui.open({
        url: "./subpage/ProductEntry.jsp",
        title: "标准化产品查询", width: 900, height: 600,
        onload: function () {
            var iframe = this.getIFrameEl();
            var data = {pageType: "add"};
            iframe.contentWindow.setData(data);
        },

        ondestroy: function (action) {
            grid.reload();
        }
    });
}
function onReferral() {
    nui.open({
        url: "../../common/Customer.jsp",
        title: "客户选择", width: 350, height: 430,
        onload: function () {
            var iframe = this.getIFrameEl();
            var data = {pageType: "referral"};
            iframe.contentWindow.setData(data);
        },

        ondestroy: function (action) {
            grid.reload();
        }
    });
}
function noRepair() {
    nui.open({
        url: "./subpage/NotRepair.jsp",
        title: "未修归档", width: 400, height: 200,
        onload: function () {
            var iframe = this.getIFrameEl();
            var data = {pageType: "noRepair"};
            iframe.contentWindow.setData(data);
        },

        ondestroy: function (action) {
            grid.reload();
        }
    });
}

function settlement() {
    nui.open({
        url: "../../common/Settlement.jsp",
        title: "完工结算", width: 650, height: 630,
        onload: function () {
            var iframe = this.getIFrameEl();
            var data = {pageType: "settlement"};
            iframe.contentWindow.setData(data);
        },

        ondestroy: function (action) {
            grid.reload();
        }
    });
}
function customer() {
    nui.open({
        url: "../../RepairBusiness/CustomerProfile/CustomerProfileDetail.jsp",
        title: "客户资料", width: 460, height: 640,
        onload: function () {
            var iframe = this.getIFrameEl();
            var data = {pageType: "customer"};
            iframe.contentWindow.setData(data);
        },

        ondestroy: function (action) {
            grid.reload();
        }
    });
}
function examine() {
    nui.open({
        url: "../../common/RepairExamine.jsp",
        title: "维修单审核", width: 930, height: 600,
        onload: function () {
            var iframe = this.getIFrameEl();
            var data = {pageType: "examine"};
            iframe.contentWindow.setData(data);
        },

        ondestroy: function (action) {
            grid.reload();
        }
    });
}
function returnList() {
    nui.open({
        url: "../../common/ReturnList.jsp",
        title: "返单处理", width: 500, height: 200,
        onload: function () {
            var iframe = this.getIFrameEl();
            var data = {pageType: "returnList"};
            iframe.contentWindow.setData(data);
        },

        ondestroy: function (action) {
            grid.reload();
        }
    });
}
//重新刷新页面
function refresh() {
    var form = new nui.Form("#form1");
    var json = form.getData(false, false);
    grid.load(json);
    nui.get("update").enable();
}
//查询
function search() {
    var form = new nui.Form("#form1");
    var json = form.getData(false, false)
    grid.load(json);
}
//重置查询条件
function reset() {
    var form = new nui.Form("#form1");
    grid.reset();
}
//enter键触发
function onKeyEnter(e) {
    search();
}
//选择列（判定，大于一编辑禁用）
function selectionChanged() {
    var rows = grid.getSelecteds();
    if (rows.length > 1) {
        nui.get("update").disable();
    } else {
        nui.get("update").enable();
    }
}
function onIsDisabled(e) {
    if (e.value == 1) return "禁用";
    if (e.value == 0) return "启用";
}
