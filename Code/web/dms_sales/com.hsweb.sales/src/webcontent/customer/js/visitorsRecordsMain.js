var baseUrl = window._rootSysUrl || "http://127.0.0.1:8080/default/";
var beginDateEl = null;
var endDateEl = null;
var mainGrid = null;
var form = null;
var queryUrl = apiPath + saleApi + "/com.hsapi.sales.svr.custormer.queryGuestCome.biz.ext";
//状态：0草稿，1归档，2转销售，3作废
var statusHash = {
    "0": "草稿",
    "1": "归档",
    "2": "转销售",
    "3": "作废"
}
$(document).ready(function () {
    beginDateEl = nui.get("sEnterDate");
    endDateEl = nui.get("eEnterDate");
    mainGrid = nui.get("mainGrid");
    form = new nui.Form("#form1");

    initMember("saleAdvisorId", function () {
    });
    initDicts({
        interialColorId: "10391",
        frameColorId: "DDT20130726000003",
        intentLevelId: "DDT20130703000050"
    });
    mainGrid.setUrl(queryUrl);
    mainGrid.on('drawcell', function (e) {
        var value = e.value;
        var field = e.field;
        if (field == 'launchDate') {
            e.cellHtml = nui.formatDate(new Date(value), 'yyyy-MM-dd');
        } else if (field == 'sex') {
            e.cellHtml = (value == 0 ? '女' : '男');
        } else if (field == 'intentLevelId') {
            e.cellHtml = setColVal('intentLevelId', 'customid', 'name', e.value);
        } else if (field == 'frameColorId') {
            e.cellHtml = setColVal('frameColorId', 'customid', 'name', e.value);
        } else if (field == 'interialColorId') {
            e.cellHtml = setColVal('interialColorId', 'customid', 'name', e.value);
        } else if (field == 'status') {
            e.cellHtml = statusHash[e.value];
        } else if (e.field == "serviceCode") {
            e.cellHtml = '<a href="##" onclick="edit(' + e.record._uid + ')">' + e.record.serviceCode + '</a>';
        }
    });
    mainGrid.on("select", function (e) {
        var row = e.record;
        if (row.status > 0) {
            nui.get("deletBtn").disable();
        }
    });
    quickSearch(2);
});

function quickSearch(type) {
    var params = getSearchParam();
    var querysign = 1;
    var queryname = "本日";
    switch (type) {
        case 0:
            params.today = 1;
            params.sOutDate = getNowStartDate();
            params.eOutDate = addDate(getNowEndDate(), 1);
            querysign = 1;
            queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.sOutDate = getPrevStartDate();
            params.eOutDate = addDate(getPrevEndDate(), 1);
            querysign = 1;
            queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.sOutDate = getWeekStartDate();
            params.eOutDate = addDate(getWeekEndDate(), 1);
            querysign = 1;
            queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.sOutDate = getLastWeekStartDate();
            params.eOutDate = addDate(getLastWeekEndDate(), 1);
            querysign = 1;
            queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.sOutDate = getMonthStartDate();
            params.eOutDate = addDate(getMonthEndDate(), 1);
            querysign = 1;
            queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.sOutDate = getLastMonthStartDate();
            params.eOutDate = addDate(getLastMonthEndDate(), 1);
            querysign = 1;
            queryname = "上月";
            break;
        case 10:
            params.thisYear = 1;
            params.sOutDate = getYearStartDate();
            params.eOutDate = getYearEndDate();
            querysign = 1;
            queryname = "本年";
            break;
        case 11:
            params.lastYear = 1;
            params.sOutDate = getPrevYearStartDate();
            params.eOutDate = getPrevYearEndDate();
            querysign = 1;
            queryname = "上年";
            break;

        default:
            break;
    }

    beginDateEl.setValue(params.sOutDate);
    endDateEl.setValue(addDate(params.eOutDate, -1));
    if (querysign == 1) {
        var menunamedate = nui.get("menunamedate");
        menunamedate.setText(queryname);
    }

    doSearch(params);
}

var status = 0;
function quickSearch2(type) {
    var queryname = "草稿";
    switch (type) {
        case 0:
            status = 0;  //报价
            queryname = "草稿";
            break;
        case 1:
            status = 1;  //报价
            queryname = "归档";
            break;
        case 2:
            status = 2;  //施工
            queryname = "转销售";
            //document.getElementById("advancedMore").style.display='block';
            break;
        case 3:
            status = 3;  //完工
            queryname = "作废";
            break;
        case 4:
            status = 4;//待结算
            queryname = "全部";
            break;
        default:
            break;
    }
    var menunamestatus = nui.get("menunamestatus");
    menunamestatus.setText(queryname);
    doSearch();
}


function onSearch() {
    doSearch();
}
function doSearch() {
    var gsparams = getSearchParam();
    if (status != 4) {
        gsparams.status = status;
    }
    /*if(gsparams.billTypeIds && gsparams.billTypeIds==5){
    	gsparams.billTypeIds = "0,2,4,6";
    }
    if(nui.get("isCollectMoney").getValue()==1){
    	gsparams.isCollectMoneys="0,1";
    }else{
    	
    	gsparams.isSettle = 1;
    	gsparams.isCollectMoney=1;
    }*/
    // gsparams.billTypeId = 0;
    //gsparams.isDisabled = 0;

    mainGrid.load({
        token: token,
        params: gsparams
    });
}
function getSearchParam() {
    var params = {};
    params.comeDateStart = nui.get("sEnterDate").getValue();
    params.comeDateEnd = addDate(endDateEl.getValue(), 1);
    var saleAdvisorId = nui.get("saleAdvisorId").getValue();
    params.saleAdvisorId = saleAdvisorId;
    var fullName = nui.get("fullName").getValue();
    params.fullName = fullName;
    return params;
}

function add() {
    var part = {};
    part.id = "addVisitors";
    part.text = "来访记录详情";
    part.url = webPath + contextPath + "/com.hsweb.customer.addVisitRecords.flow?token=" + token;
    part.iconCls = "fa fa-file-text";
    var params = {};
    window.parent.activeTabAndInit(part, params);
}

function addFollowUpRecord() {
    nui.open({
        url: webPath + contextPath + "/com.hsweb.repair.potentialCustomer.FollowUpRecord.flow?token=" + token,
        title: "来访记录详情",
        width: 600,
        height: 360,
        allowDrag: true,
        allowResize: true,
        onload: function () {
			/*var iframe = this.getIFrameEl();
            iframe.contentWindow.updatRowSetData(params);//显示该显示的功能
           // iframe.contentWindow.setViewData(dock, dodelck, docck);
*/		},
        ondestroy: function (action) {


        }
    });
}

function potentialCustomer() {
    nui.open({
        url: webPath + contextPath + "/com.hsweb.repair.potentialCustomer.check.flow?token=" + token,
        title: "审核",
        width: 600,
        height: 360,
        allowDrag: true,
        allowResize: true,
        onload: function () {
			/*var iframe = this.getIFrameEl();
            iframe.contentWindow.updatRowSetData(params);//显示该显示的功能
           // iframe.contentWindow.setViewData(dock, dodelck, docck);
*/		},
        ondestroy: function (action) {


        }
    });
}


function edit(row_uid) {
    if (!row_uid) {
        var row = mainGrid.getSelected();
    } else {
        var row = mainGrid.getRowByUID(row_uid);
    }
    if (!row) return;
    var part = {};
    part.id = "addVisitors";
    part.text = "来访记录详情";
    part.url = webPath + contextPath + "/customer.addVisitRecords.flow?token=" + token;
    part.iconCls = "fa fa-file-text";
    var params = {};
    window.parent.activeTabAndInit(part, row);
}

function guestInfo() {
    var row = mainGrid.getSelected();
    if (row) {
        nui.open({
            url: webPath + contextPath + "/sales/customer/addGuest.jsp?token=" + token,
            title: "编辑客户资料",
            width: 900,
            height: 460,
            allowDrag: true,
            allowResize: true,
            onload: function () {
                var iframe = this.getIFrameEl();
                iframe.contentWindow.queryData(row.guestId);//显示该显示的功能
            },
            ondestroy: function (action) {
                doSearch();
            }
        });
    } else {
        showMsg("请选择一条记录!", "W");
        return;
    }

}

function queryCar() {
    var part = {};
    part.id = "3223";
    part.text = "库存管理";
    part.url = webPath + contextPath + "/inventory.carSalesInventory.flow?token=" + token;
    part.iconCls = "fa fa-file-text";
    var params = {};
    window.parent.activeTabAndInit(part, params);
}

var statusUrl = apiPath + saleApi + "/com.hsapi.sales.svr.custormer.changStatus.biz.ext";
function del() {
    var row = mainGrid.getSelected();
    if (row) {
        var status = row.status;
        if (status == 1) {
            showMsg("来访登记已归档！", "W");
            return;
        }
        if (status == 2) {
            showMsg("来访登记已转销售！", "W");
            return;
        }
        var json = nui.encode({
            id: row.id,
            action: "delete",
            token: token
        });
        nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '保存中...'
        });
        nui.ajax({
            url: statusUrl,
            type: 'POST',
            data: json,
            cache: false,
            contentType: 'text/json',
            success: function (text) {
                if (text.errCode == "S") {
                    showMsg("作废成功!", "S");
                } else {
                    showMsg("作废失败!", "E");
                }
                nui.unmask(document.body);
                doSearch();
            }
        });
    } else {
        showMsg("请选择一条记录！", "W");
        return;
    }
}