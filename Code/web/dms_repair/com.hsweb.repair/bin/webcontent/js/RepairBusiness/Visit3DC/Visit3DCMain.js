/**
 * Created by Administrator on 2018/4/13.
 */
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var leftGrid = null;
var leftGridUrl = baseUrl + "com.hsapi.repair.repairService.threeDC.queryScoutList.biz.ext";
var statusHash = ["", "在报价", "在维修","已完工","在结算"];
var mainTabs = null;
var reportTab = null;
var billTab = null;
var detailInfoForm = null;
$(document).ready(function (v)
{
    mainTabs = nui.get("mainTabs");
    reportTab = mainTabs.getTab("report");
    billTab = mainTabs.getTab("bill");
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
        getScoutDetailById(row.id);
    });
    leftGrid.on("load", function () {
        var row = leftGrid.getSelected();
        if (row) {
            getMaintainById(row.id);
        }
    });
    basicInfoForm = new nui.Form("#basicInfoForm");
    basicInfoForm.setEnabled(false);
    detailInfoForm = new nui.Form("detailInfoForm");
    detailInfoForm.setEnabled(false);
    init(function () {
        quickSearch(0);
    });
});
var mtType = [];
var mtTypeHash = {};
var serviceTypeIdHash = {};
var serviceTypeIdEl = null;
var mtTypeEl = null;
var receTypeHash = {};
var itemKindHash = {};
var artType = [];
function init(callback) {
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
        var keyList = ['getDatadictionaries','initCarBrand','initDicts'];
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
        identity: "DDT20130703000077",//客户身份
        receType1:"DDT20130706000013",//收费类型
        receType2:"DDT20130706000014",//免费类型
        mode:"DDT20130703000021",//回访方式
        artType:"DDT20130725000001"//话术类别
    },function(){
        artType = nui.get("artType").getData();
        hash.initDicts = true;
        checkComplete();
    });
    initRoleMembers({
        mtAdvisorId:"010802"//维修顾问
    },function(){
    });
    initCarBrand("carBrand",function()
    {
        hash.initCarBrand = true;
        checkComplete();
    });
}
var queryForm = null;
var currType = 0;
function quickSearch(type) {

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
    var carNo = nui.get("carNo-search").getValue();
    var params = {
        carNo:carNo
    };
    switch (currType) {
        case 0:
            params.mtAuditor = currUserName;
            params.highLeaveDay = 3;
            break;
        case 1:
            break;
        default:
            break;
    }
    return params;
}
function onSearch()
{
    var params = getSearchParams();
    doSearch(params);
}
function doSearch(params) {
 //   params.status = 6;
    params.orgid = currOrgid;
    leftGrid.load({
        token:token,
        params: params
    });
}
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
                token:token,
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
        token:token,
        params: params
    });
}
//套餐清单end
//估算项目/材料start
var statusHash2 = ["在报价", "在维修"];
var rpsItemQuoteGrid = null;
function loadRpsItemQuoteData() {
    if (!rpsItemQuoteGrid) {
        rpsItemQuoteGrid = nui.get("rpsItemQuoteGrid");
        rpsItemQuoteGrid.on("drawcell", function (e) {
        	var field = e.field;
            if (field == "status") {
                e.cellHtml = statusHash2[e.value];
            }
            else{
                onDrawCell(e);
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
        token:token,
        params: params
    });
}

var rpsPartQuoteGrid = null;
function loadRpsPartQuoteData() {
    if (!rpsPartQuoteGrid) {
        rpsPartQuoteGrid = nui.get("rpsPartQuoteGrid");
        rpsPartQuoteGrid.on("drawcell", function (e)
        {
        	var field = e.field;
            if (field == "status") {
                e.cellHtml = statusHash2[e.value];
            }
            else{
                onDrawCell(e);
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
        token:token,
        params: params
    });
}
//估算项目/材料end
//维修项目/材料start
var rpsItemGrid = null;
function loadRpsItemData() {
    if (!rpsItemGrid) {
        rpsItemGrid = nui.get("rpsItemGrid");
        var rpsItemGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsItemByServiceId.biz.ext";
        rpsItemGrid.setUrl(rpsItemGridUrl);
        rpsItemGrid.on("drawcell",function(e)
        {
        	var field = e.field;
            if (field == "status") {
                e.cellHtml = statusHash2[e.value];
            }
            else{
                onDrawCell(e);
            }
        });
    }
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


var rpsPartGrid = null;
function loadRpsPartData() {
    if (!rpsPartGrid) {
        rpsPartGrid = nui.get("rpsPartGrid");
        var rpsItemGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsPartByServiceId.biz.ext";
        rpsPartGrid.setUrl(rpsItemGridUrl);
        rpsPartGrid.on("drawcell",function(e)
        {
        	var field = e.field;
            if (field == "status") {
                e.cellHtml = statusHash2[e.value];
            }
            else{
                onDrawCell(e);
            }
        });
    }
    var maintain = basicInfoForm.getData();
    if (!maintain.id) {
        return;
    }
    var params = {
        serviceId: maintain.id
    };
    rpsPartGrid.load({
        token:token,
        params: params
    });
}
//维修项目/材料end

//出单项目/材料start
var rpsItemBillGrid = null;
function loadRpsItemBillData()
{
    if(!rpsItemBillGrid)
    {
        rpsItemBillGrid = nui.get("rpsItemBillGrid");
        rpsItemBillGrid.on("drawcell",onDrawCell);
        var url = baseUrl+"com.hsapi.repair.repairService.svr.getRpsItemBillByServiceId.biz.ext";
        rpsItemBillGrid.setUrl(url);
        rpsItemBillGrid.on("drawcell",function(e)
        {
            onDrawCell(e);
        });
    }
    var maintain = basicInfoForm.getData();
    if (!maintain.id) {
        return;
    }
    var params = {
        serviceId: maintain.id
    };
    rpsItemBillGrid.load({
        token:token,
        params: params
    });
}

var rpsPartBillGrid = null;
function loadRpsPartBillData() {
    if (!rpsPartBillGrid) {
        rpsPartBillGrid = nui.get("rpsPartBillGrid");
        rpsPartBillGrid.on("drawcell",onDrawCell);
        var url = baseUrl + "com.hsapi.repair.repairService.svr.getRpsPartBillByServiceId.biz.ext";
        rpsPartBillGrid.setUrl(url);
        rpsPartBillGrid.on("drawcell",function(e)
        {
            onDrawCell(e);
        });
    }
    var maintain = basicInfoForm.getData();
    if (!maintain.id) {
        return;
    }
    var params = {
        serviceId: maintain.id
    };
    rpsPartBillGrid.load({
        token:token,
        params: params
    });
}
//出单项目/材料end
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
            var descInfoForm = new nui.Form("descInfoForm");
            descInfoForm.setEnabled(false);
            descInfoForm.setData(maintain);
            loadRpsItemBillData();
            loadRpsPartBillData();
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

function reload() {
    leftGrid.reload();
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
function choiceScript()
{
    nui.open({
        url: window._webCrmUrl+"basic/talkArtTpl.jsp",
        title: "话术模板", width: 880, height: 630,
        onload: function () {
            var iframe = this.getIFrameEl();
            var params = {
            	action:"sel"
            };
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action)
        {
        	if(action == "ok")
            {
                var iframe = this.getIFrameEl();
                var art = iframe.contentWindow.getData();
                nui.get("content").setValue(art.content);
            }
        }
    });
}
function enableDetailForm()
{
    detailInfoForm.setEnabled(true);
    nui.get("scoutMan").disable();
    nui.get("scoutDate").disable();
}
function threeDc()
{
    var maintain = basicInfoForm.getData();
    if(!maintain || !maintain.id)
    {
        return;
    }
    var detail = detailInfoForm.getData();
    if(detail.detailId)
    {
        return;
    }
    enableDetailForm();
    detailInfoForm.setData({
        qualityDegree:5,
        serviceDegree:5,
        timeDegree:5,
        priceDegree:5,
        serviceId:maintain.id,
        scoutMan:currUserName,
        carId:maintain.carId,
        scoutDate:new Date(currentTimeMillis)
    });
}
function save()
{
    var detail = detailInfoForm.getData();
    var car = {};
    var params = {};
    car.id = detail.carId;
    car.careDueDate = detail.careDueDate;
    car.careCycle = detail.careCycle;
    params.car = car;
    params.detail = detail;
    var url = baseUrl+"com.hsapi.repair.repairService.threeDC.saveScoutDetail.biz.ext";
    nui.mask({
        html: '保存中..'
    });
    doPost({
        url: url,
        data: params,
        success: function (data) {
            nui.unmask();
            data = data||{};
            if(data.errCode=="S")
            {
                var _detail = data.detail;
                detail.detailId = _detail.detailId;
                detailInfoForm.setData(detail);
                nui.alert("保存成功");
            }
            else
            {
                nui.alert(data.errMsg||"保存失败");
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            nui.unmask();
            console.log(jqXHR.responseText);
        }
    });
}
function getScoutDetailById(serviceId)
{
    if(!serviceId)
    {
        return;
    }
    var url = baseUrl+"com.hsapi.repair.repairService.threeDC.getScoutDetailByServiceId.biz.ext";
    doPost({
        url: url,
        data: {
            params:{
                serviceId:serviceId
            }
        },
        success: function (data) {
            data = data||{};
            var detail = data.detail||{};
            if(detail.detailId)
            {
                detailInfoForm.setData(detail);
                enableDetailForm();
            }
            else
            {
                detailInfoForm.setEnabled(false);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function collectScript()
{
    var content = nui.get("content").getValue();
    if(!content)
    {
        return;
    }
    nui.open({
        url:window._webCrmUrl+"com.hsweb.crm.basic.talkArtTpl_edit.flow",
        title: "话术录入", width: 500, height: 420,
        onload: function () {
            var iframe = this.getIFrameEl();
            var data = {
                content:content,
                typeId:"061002",
                artType:artType
            };
            iframe.contentWindow.setData(data);
        },

        ondestroy: function (action)
        {
        }
    });
}
