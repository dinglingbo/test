var mainGrid = null;
var mainGrid2 = null;
var mainGrid3 = null;
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + saleApi + "/";
var mainGridUrl = baseUrl + "sales.search.searchSalesMain.biz.ext";
var statusList = [{ id: "0", name: "订单单号" }, { id: "1", name: "客户名称" }];
var param = {};
$(document).ready(function(v) {
    mainGrid = nui.get("mainGrid");
    mainGrid2 = nui.get("mainGrid2");
    mainGrid3 = nui.get("mainGrid3");
    mainGrid.setUrl(mainGridUrl);
    mainGrid2.setUrl(mainGridUrl);
    mainGrid3.setUrl(mainGridUrl);
    if (nui.get("typeMsg").value == 1) {
        mainGrid.setVisible(true);
        nui.get("addBtn").setVisible(true);
        nui.get("editBtn").setVisible(true);
    }
    if (nui.get("typeMsg").value == 2) {
        mainGrid2.setVisible(true);
        nui.get("audit").setVisible(true);
        nui.get("auditno").setVisible(true);
        document.getElementById("menubillstatus").style.display = "none"
    }
    if (nui.get("typeMsg").value == 3) {
        mainGrid3.setVisible(true);
        nui.get("case").setVisible(true);
        nui.get("csaeno").setVisible(true);
        document.getElementById("menubillstatus").style.display = "none"
    }
    quickSearch(4);
    mainGrid.on("load", function(e) {
        var data = e.text.data;
        if (data.length > 0) {
            for (var i = 0, l = data.length; i < l; i++) {
                var row = mainGrid.getRow(i);
                var buyBudgetTotal = data[i].buyBudgetTotal;
                var receivedDeposit = data[i].receivedDeposit;
                var receivedBala = data[i].receivedBala;
                var calculateField = buyBudgetTotal - (receivedDeposit + receivedBala);
                var newRow = { calculateField: calculateField };
                mainGrid.updateRow(row, newRow);
            }
        }
    });

    mainGrid.on("drawcell", function(e) {
        var field = e.field,
            value = e.value;
        if (field == "submiPlanDate" || field == "orderDate") {
            e.cellHtml = format(value, 'yyyy-MM-dd HH:mm:ss');
        }
        if (field == "status") {
            var value1 = value == 0 ? "草稿" : (value == 1 ? "待审" : (value == 2 ? "已审" : (value == 3 ? "作废" : "")));
            e.cellHtml = value1;
        }
    });

    mainGrid2.on("drawcell", function(e) {
        var field = e.field,
            value = e.value;
        if (field == "submiPlanDate") {
            e.cellHtml = format(value, 'yyyy-MM-dd HH:mm:ss');
        }
        if (field == "status") {
            var value1 = value == 0 ? "草稿" : (value == 1 ? "待审" : (value == 2 ? "已审" : (value == 3 ? "作废" : "")));
            e.cellHtml = value1;
        }
    });

    mainGrid3.on("drawcell", function(e) {
        var field = e.field,
            value = e.value;
        if (field == "submitTrueDate" || field == "submiPlanDate" || field == "financialEndDate") {
            e.cellHtml = format(value, 'yyyy-MM-dd HH:mm:ss');
        }
    });

    mainGrid.on("rowdblclick", function(e) {
        onSearch();
    });

    mainGrid2.on("rowdblclick", function(e) {
        onSearch();
    });

    mainGrid3.on("rowdblclick", function(e) {
        onSearch();
    });

});

function quickSearch(e) {
    var queryname = null;
    var menubillstatus = null;
    switch (e) {
        case 0:
            param.recordStartDate = getNowStartDate();
            param.recordEndDate = addDate(getNowEndDate(), 1);
            queryname = "本日";
            break;
        case 1:
            param.recordStartDate = getPrevStartDate();
            param.recordEndDate = addDate(getPrevEndDate(), 1);
            queryname = "昨日";
            break;
        case 2:
            param.recordStartDate = getWeekStartDate();
            param.recordEndDate = addDate(getWeekEndDate(), 1);
            queryname = "本周";
            break;
        case 3:
            param.recordStartDate = getLastWeekStartDate();
            param.recordEndDate = addDate(getLastWeekEndDate(), 1);
            queryname = "上周";
            break;
        case 4:
            param.recordStartDate = getMonthStartDate();
            param.recordEndDate = addDate(getMonthEndDate(), 1);
            queryname = "本月";
            break;
        case 5:
            param.recordStartDate = getLastMonthStartDate();
            param.recordEndDate = addDate(getLastMonthEndDate(), 1);
            queryname = "上月";
            break;
        case 10:
            param.recordStartDate = getYearStartDate();
            param.recordEndDate = getYearEndDate();
            queryname = "本年";
            break;
        case 11:
            param.recordStartDate = getPrevYearStartDate();
            param.recordEndDate = getPrevYearEndDate();
            queryname = "上年";
            break;
        case 12:
            param.status = null;
            menubillstatus = "所有";
            break;
        case 13:
            param.status = 0;
            menubillstatus = "草稿";
            break;
        case 14:
            param.status = 1;
            menubillstatus = "待审";
            break;
        case 15:
            param.status = 2;
            menubillstatus = "已审";
            break;
        case 16:
            param.status = 3;
            menubillstatus = "作废";
            break;
        default:
            break;
    }
    if (queryname) {
        var menunamedate = nui.get("menunamedate");
        menunamedate.setText(queryname);
    }
    if (menubillstatus) {
        var menubillstatusData = nui.get("menubillstatus");
        menubillstatusData.setText(menubillstatus);
    }
    onSearch();
}

function onenterSearch(e) {
    onSearch();
}

function onSearch() {
    param.serviceCode = null;
    param.guestName = null;
    var searchType = nui.get("searchType").value;
    searchType = parseInt(searchType);
    switch (searchType) {
        case 0:
            param.serviceCode = nui.get("textValue").value;
            break;
        case 1:
            param.guestName = nui.get("textValue").value;
            break;
        default:
            break;
    }
    if (nui.get("typeMsg").value == 1) {
        mainGrid.load({ params: param });
    }
    if (nui.get("typeMsg").value == 2) {
        param.status = "1,2";
        mainGrid2.load({ params: param });
    }
    if (nui.get("typeMsg").value == 3) {
        param.status = 2;
        param.isSettle = 1;
        mainGrid3.load({ params: param });
    }
}

function openPage(params) {
    var tabsId = null;
    var text = null;
    if (nui.get("typeMsg").value == 1) {
        tabsId = "12780";
        text = "编辑销售管理";
    }
    if (nui.get("typeMsg").value == 2) {
        tabsId = "12781";
        text = "编辑销售单审核";
    }
    if (nui.get("typeMsg").value == 3) {
        tabsId = "12782";
        text = "编辑销售结案";
    }
    var item = {};
    item.id = tabsId;
    item.text = text;
    item.url = webPath + contextPath + "/sales/sales/editCarSales.jsp";
    item.iconCls = "fa fa-file-text";
    window.parent.activeTabAndInit(item, params);
}

function addAndEdit(e) {
    var params = {
        typeMsg: nui.get("typeMsg").value
    };
    if (e == 2) {
        var row = mainGrid.getSelected() || mainGrid2.getSelected() || mainGrid3.getSelected();
        params.id = row.id;
    }
    openPage(params);
}