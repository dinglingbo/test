var mainGrid = null;
var mainGrid2 = null;
var mainGrid3 = null;
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + saleApi + "/";
var mainGridUrl = baseUrl + "sales.search.searchSalesMainMsg.biz.ext";
var statusList = [{ id: "0", name: "订单单号" }, { id: "1", name: "客户名称" }];
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
        mainGrid.load();
    }
    if (nui.get("typeMsg").value == 2) {
        mainGrid2.setVisible(true);
        nui.get("audit").setVisible(true);
        nui.get("auditno").setVisible(true);
        mainGrid2.load();
    }
    if (nui.get("typeMsg").value == 3) {
        mainGrid3.setVisible(true);
        nui.get("case").setVisible(true);
        nui.get("csaeno").setVisible(true);
        mainGrid3.load();
    }

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

});

function onenterSearch(e) {
    onSearch();
}

function onSearch() {

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