/**
 * Created by Administrator on 2018/4/3.
 */
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var leftGrid = null;
var leftGridUrl = baseUrl + "com.hsapi.repair.repairService.query.queryMtHistoryList.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;

$(document).ready(function (v)
{
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
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
    leftGrid.on("drawcell",onDrawCell);
    var hash = {};
//    nui.mask({
//        html: '数据加载中..'
//    });
    var checkComplete = function () {
        var keyList = ['initRoleMembers','getDatadictionaries',"initDicts","initComp","initInsureComp"];
        for (var i = 0; i < keyList.length; i++) {
            if (!hash[keyList[i]]) {
                return;
            }
        }
        nui.unmask();
        quickSearch(0);
    };
    initRoleMembers({
        mtAdvisorId:"010802"
    },function(){
        var list = nui.get("mtAdvisorId").getData();
        nui.get("mtAdvisorId-ad").setData(list);
        hash.initRoleMembers = true;
        checkComplete();
    });
    initDicts({
        mtType1: "DDT20130705000002",//维修类型，普通
        mtType2: "DDT20130705000003",//维修类型，事故
        receType1:"DDT20130706000013",//收费类型
        receType2:"DDT20130706000014"//免费类型
    },function(){
        hash.initDicts = true;
        checkComplete();
    });
    var pId = "DDT20130703000055";//业务类型
    getDatadictionaries(pId, function (data) {
        data = data || {};
        var list = data.list || [];
        nui.get("serviceTypeId").setData(list);
        var pId2 = "DDT20130703000057";//工种
        getDatadictionaries(pId2, function (data) {
            data = data || {};
            var list = data.list || [];
            hash.getDatadictionaries = true;
            checkComplete();
        });
    });
    initComp("orgId",function(data){
        hash.initComp = true;
        checkComplete();
    });
    initInsureComp("insureComp",function(){
        hash.initInsureComp = true;
        checkComplete();
    });
});
function advancedSearch()
{
    advancedSearchWin.show();
}
function onAdvancedSearchOk()
{
    var searchData = advancedSearchForm.getData();
    var i,tmpList;
    if(!searchData.startDate || !searchData.endDate)
    {
        nui.alert("离厂起始日期和终止日期不能为空");
        return;

    }
    searchData.startDate = searchData.startDate.substr(0,10);
    searchData.endDate = searchData.endDate.substr(0,10);
    if(searchData.serviceCodeList)
    {
        tmpList = searchData.serviceCodeList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i]+"'";
        }
        searchData.serviceCodeList = tmpList.join(",");
    }
    if(searchData.carNoList)
    {
        tmpList = searchData.carNoList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i]+"'";
        }
        searchData.carNoList = tmpList.join(",");
    }
    advancedSearchWin.hide();
    doSearch(searchData);
}
function onAdvancedSearchCancel()
{
    advancedSearchWin.hide();
}
function onAdvancedSearchClear()
{
    advancedSearchForm.clear();
}
function onRowDblClick(e)
{
    var row = e.record;
    loadPackageGridData(row);
    loadRpsItemQuoteData(row);
    loadRpsPartQuoteData(row);
    loadRpsPartData(row);
    loadRpsItemData(row);
    loadRpsItemBillData(row);
    loadRpsPartBillData(row);
    loadAuxiliaryGridData(row);
    getMaintainById(row.id);
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
    onSearch();
}
function getSearchParams()
{
    var params = {};
    switch (currType) {
        case 0:
            params.today = 1;
            break;
        case 1:
            params.yesterday = 1;
            break;
        case 2:
            params.thisWeek = 1;
            break;
        case 3:
            params.lastWeek = 1;
            break;
        case 4:
            params.thisMonth = 1;
            break;
        case 5:
            params.lastMonth = 1;
            break;
        case 6:
            params.thisYear = 1;
            break;
        case 7:
            params.lastYear = 1;
            break;
        default:
            break;
    }
    params.guestId = nui.get("guestId").getValue();
    params.mtAdvisorId = nui.get("mtAdvisorId").getValue();
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
var auxiliaryGrid = null;
function loadAuxiliaryGridData(maintain)
{
    if(!auxiliaryGrid)
    {
        auxiliaryGrid = nui.get("auxiliaryGrid");
        var url = window._rootPartUrl + "com.hsapi.part.purchase.repair.getRepairOutByServiceId.biz.ext";
        auxiliaryGrid.setUrl(url);
    }
    if (!maintain.id) {
        return;
    }
    var params = {
        pickType: "050210"
    };
    auxiliaryGrid.load({
        token:token,
        serviceId: maintain.id,
        params: params
    });
}
var statusHash2 = ["在报价", "在维修"];
var packageGrid = null;
var packageDetailGrid_Form = null;
var packageDetailGrid = null;
function loadPackageGridData(row)
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
                token:token,
                params: params
            });
        });
    }
    if (!row.id) {
        return;
    }
    var params = {
        serviceId: row.id
    };
    packageGrid.load({
        token:token,
        params: params
    });
}
var rpsItemQuoteGrid = null;
function loadRpsItemQuoteData(row) {
    if (!rpsItemQuoteGrid) {
        rpsItemQuoteGrid = nui.get("rpsItemQuoteGrid");
        rpsItemQuoteGrid.on("drawcell", function (e) {
            if (e.field == "status") {
                e.cellHtml = statusHash2[e.value];
            }
            else {
                onDrawCell(e);
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
            else{
                onDrawCell(e);
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
function addOrEdit(guest)
{
    var title = "新增客户资料";
    if(guest)
    {
        title = "修改客户资料";
    }
    nui.open({
        url:"../common1/subpage/customerSubpage/AddEditCustomer.html",
        title:title,
        width:500,
        height:630,
        onload:function(){
            var iframe = this.getIFrameEl();
            var params = {};
            if(guest)
            {
                params.guest = guest;
            }
            iframe.contentWindow.setData(params);
        },
        ondestroy:function(action)
        {
            if(action  == "ok")
            {
                grid.reload();
            }
        }
    });
}
function showCustomer()
{
    var row = leftGrid.getSelected();
    if(!row || !row.guestId)
    {
        return;
    }
    addOrEdit(row);
}
function selectCustomer(elId) {
    nui.open({
        url: "com.hsweb.RepairBusiness.Customer.flow",
        title: "客户选择", width: 800, height: 450,
        onload: function () {
        },
        ondestroy: function (action) {
            if ("ok" == action) {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                var guest = data.guest;
                var name = guest.guestFullName;
                var guestId = guest.guestId;
                var el = nui.get(elId);
                if(el)
                {
                    el.setValue(guestId);
                    if(el.setText)
                    {
                        el.setText(name);
                    }
                }
            }
        }
    });
}
function onClean(e)
{
    nui.get("guestId").setValue("");
    nui.get("guestId").setText("");
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
