var baseUrl = apiPath + repairApi + "/";
var queryForm;
var upGrid;
var downGrid;
var menuBtnStatusQuickSearch;
var menuBtnDateQuickSearch;
var serviceTypeHash = [];
var carBrandHash = [];
var carSeriesHash = [];
var mtAdvisorHash = [];
var scoutModeHash = [];
var scoutResutHash = [];

var prebookCategoryHash = [{ name: '客户主动预约', id: '0' }, { name: '客户被动预约', id: '1' }];
var prebookStatusHash = [{ name: '待确认', id: '0' }, { name: '已确认', id: '1' }, { name: '已开单', id: '2' }, { name: '已取消', id: '3' }, { name: '已评价', id: '4' }];

var upGridUrl = baseUrl + "com.hsapi.repair.repairService.booking.queryPrebookList.biz.ext";
var downGridUrl = baseUrl + "com.hsapi.repair.repairService.booking.queryBookingTrace.biz.ext";

$(document).ready(function (v) {
    menuBtnDateQuickSearch = nui.get("menuBtnDateQuickSearch");
    menuBtnStatusQuickSearch = nui.get("menuBtnStatusQuickSearch");

    upGrid = nui.get("upGrid");
    upGrid.setUrl("upGridUrl");
    upGrid.on("drawcell", onDrawCell);

    downGrid = nui.get("downGrid");
    downGrid.setUrl("downGridUrl");
    downGrid.on("drawcell", onDrawCell);

    init();
    quickSearch(menuBtnDateQuickSearch, 0, '今日');

    upGrid.on("selectionchanged", function () {
        onupGridSelectionchanged();
    });

});

function init() {
    initCarBrand("carBrandList", function () {
        var data = nui.get("carBrandList").getData();
        data.forEach(function (v) {
            carBrandHash[v.id] = v;
        });
    });

    initCarSeries("carSeriesList", "", function () {
        var data = nui.get("carSeriesList").getData();
        data.forEach(function (v) {
            carSeriesHash[v.id] = v;
        });
    });

    initMember("mtAdvisorList", function () {
        var data = nui.get("mtAdvisorList").getData();
        data.forEach(function (v) {
            mtAdvisorHash[v.id] = v;
        });
    });

    initServiceType("bisinessList", function () {
        var data = nui.get("bisinessList").getData();
        data.forEach(function (v) {
            serviceTypeHash[v.id] = v;
        });
    });

    initDicts({
        scoutModeList: SCOUT_MODE, //跟进方式
        scoutReustList: IS_USABLED //跟踪状态
    }, function () {
        var data = nui.get("scoutModeList").getData();
        data.forEach(function (v) {
            scoutModeHash[v.customid] = v;
        });
        var data = nui.get("scoutReustList").getData();
        data.forEach(function (v) {
            scoutResutHash[v.customid] = v;
        });
    });
}

var currType = 0;

function quickSearch(ctlid, value, text) {
    ctlid.setValue(value);
    ctlid.setText(text);
    currType = value;
    doSearch();
}

function doSearch() {
    var params = getSearchParam();

    upGrid.load({
        params: params,
        token: token
    });
}

function getSearchParam() {
    var params = {};
    params.mtAdvisorId = nui.get("mtAdvisorList").getValue();
    params.carNo = nui.get("carNo").getValue();
    params.contactorTel = nui.get("contactorTel").getValue();

    var d = menuBtnDateQuickSearch.getValue();

    if (d == 0) {
        params.today = 1;
        params.startDate = getNowStartDate();
        params.endDate = addDate(getNowEndDate(), 1);
    } else if (d == 1) {
        params.yesterday = 1;
        params.startDate = getPrevStartDate();
        params.endDate = addDate(getPrevEndDate(), 1);
    } else if (d == 2) {
        params.thisWeek = 1;
        params.startDate = getWeekStartDate();
        params.endDate = addDate(getWeekEndDate(), 1);
    } else if (d == 3) {
        params.lastWeek = 1;
        params.startDate = getLastWeekStartDate();
        params.endDate = addDate(getLastWeekEndDate(), 1);
    } else if (d == 4) {
        params.thisMonth = 1;
        params.startDate = getMonthStartDate();
        params.endDate = addDate(getMonthEndDate(), 1);
    } else if (d == 5) {
        params.lastMonth = 1;
        params.startDate = getLastMonthStartDate();
        params.endDate = addDate(getLastMonthEndDate(), 1);
    }

    var status = menuBtnStatusQuickSearch.getValue();

    if (status != -1) {
        params.status = status;
    }

    return params;
}


function onupGridSelectionchanged(e) {
    var row = upGrid.getSelected();
    if (!row) return;

    var status = row.status;

    var btnEdit = nui.get("btnEdit");
    var btnconfirm = nui.get("btnconfirm");
    var btnNewBill = nui.get("btnNewBill");
    var btnCancel = nui.get("btnCancel");
    var btnCall = nui.get("btnCall");

    if (status == 0) { //待确认
        btnEdit.enable();
        btnconfirm.enable();
        btnNewBill.disable();
        btnCancel.enable();
        btnCall.enable();
    } else if (status == 1) { //已确认
        btnEdit.disable();
        btnconfirm.disable();
        btnNewBill.enable();
        btnCancel.enable();
        btnCall.enable();
    } else if (status >= 2) { //已开单，已取消，已评价
        btnEdit.disable();
        btnconfirm.disable();
        btnNewBill.disable();
        btnCancel.disable();
        btnCall.disable();
    }

    var params = {};
    params.serviceId = row.id;

    downGrid.load({
        params: params,
        token: token
    });
}

function onDrawCell(e) {
    var field = e.field;

    if (field == "serviceTypeId" && serviceTypeHash[e.value]) {
        e.cellHtml = serviceTypeHash[e.value].name;
    } else if (field == "carBrandId" && carBrandHash[e.value]) {
        e.cellHtml = carBrandHash[e.value].name;
    } else if (field == "carSeriesId" && carSeriesHash[e.value]) {
        e.cellHtml = carSeriesHash[e.value].name;
    } else if (field == "prebookCategory" && prebookCategoryHash[e.value]) {
        e.cellHtml = prebookCategoryHash[e.value].name;
    } else if (field == "status" && prebookStatusHash[e.value]) {
        e.cellHtml = prebookStatusHash[e.value].name;
    } else if (field == "scoutMode" && scoutModeHash[e.value]) {
        e.cellHtml = scoutModeHash[e.value].name;
    } else if (field == "isUsabled" && scoutResutHash[e.value]) {
        e.cellHtml = scoutResutHash[e.value].name;
    }
}

function addRow() {
    nui.open({
        url: "BookingManagementEdit.jsp",
        title: "新增预约", width: 700, height: 380,
        onload: function () {

        },
        ondestroy: function (action) {
            upGrid.reload();
        }
    });
}

function editRow() {
    var row = upGrid.getSelected();
    if (row == undefined) {
        nui.alert("请选中一条数据");
        return;
    }
    nui.open({
        url: "BookingManagementEdit.jsp",
        title: "修改", width: 700, height: 380,
        onload: function () {
            var iframe = this.getIFrameEl();
            var param = { action: "edit", data: row };
            iframe.contentWindow.SetData(param);
        },
        ondestroy: function (action) {
            upGrid.reload();
        }
    });
}

function confirmRow() {
    updateRpspreBookStatus('confirm');
}

function cancelBill() {
    updateRpspreBookStatus('cancel');
}

function updateRpspreBookStatus(action) {
    var row = upGrid.getSelected();
    if (!row || row == undefined) {
        nui.alert("请选中一条数据");
        return;
    }

    row.status = action == "confirm" ? 1 : 
                 action == "newBill" ? 2 :
                 action == "cancel" ? 3 : 1;

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });

    nui.ajax({
        url: baseUrl + "com.hsapi.repair.repairService.booking.updateBooking.biz.ext",
        type: 'post',
        data:JSON.stringify({
            rpsPrebook: row,
            action: action,
            token: token
        }),        
        success: function(data) {
            if (data.errCode == "S") {
                nui.unmask();
                nui.alert("保存成功");     
                upGrid.reload();
            } else {
                nui.unmask();
                nui.alert(data.errMsg || "保存失败");
            }
        },
        error: function(jqXHR, textStatus, errorThrown) {
            nui.unmask();
            console.log(jqXHR.responseText);
            nui.alert("网络出错，保存失败");           
        }
    });
}

function callBill() {
    var row = upGrid.getSelected();
    if (!row || row == undefined) {
        nui.alert("请选中一条数据");
        return;
    }
    
    nui.open({
        url: "BookingScout.jsp",
        title: "预约跟进", width: 700, height: 350,
        onload: function () {
            var iframe = this.getIFrameEl();
            var param = { action: "edit", data: row };
            iframe.contentWindow.SetData(param);
        },
        ondestroy: function (action) {
            downGrid.reload();
        }
    });   
}
