var mainGrid = null;
var mainGrid2 = null;
var mainGrid3 = null;
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + saleApi + "/";
var mainGridUrl = baseUrl + "com.hsapi.sales.svr.search.searchSalesMain.biz.ext";
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
        /*nui.get("auditno").setVisible(true);*/ 
        document.getElementById("menubillstatus").style.display = "none";
    }
    if (nui.get("typeMsg").value == 3) {
        mainGrid3.setVisible(true);
        nui.get("case").setVisible(true);
        nui.get("csaeno").setVisible(true);
        document.getElementById("menubillstatus").style.display = "none";
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
        if (field == "submitPlanDate" || field == "orderDate") {
            if (value) {
                e.cellHtml = format(value, 'yyyy-MM-dd HH:ss');
            }
        }else if (e.field == "serviceCode") {
            e.cellHtml = '<a href="##" onclick="edit(' + e.record._uid + ')">' + e.record.serviceCode + '</a>';
        }
    });

    mainGrid2.on("drawcell", function(e) {
        var field = e.field,
            value = e.value;
        if (field == "submitPlanDate") {
            if (value) {
                e.cellHtml = format(value, 'yyyy-MM-dd HH:ss');
            }
        }else if (e.field == "serviceCode") {
            e.cellHtml = '<a href="##" onclick="edit2(' + e.record._uid + ')">' + e.record.serviceCode + '</a>';
        }
    });

    mainGrid3.on("drawcell", function(e) {
        var field = e.field,
            value = e.value;
        if (field == "submitTrueDate" || field == "submitPlanDate" || field == "financialEndDate") {
            if (value) {
                e.cellHtml = format(value, 'yyyy-MM-dd HH:ss');
            }
        }else if (e.field == "serviceCode") {
            e.cellHtml = '<a href="##" onclick="edit3(' + e.record._uid + ')">' + e.record.serviceCode + '</a>';
        }
    });

    mainGrid.on("rowdblclick", function(e) {
        addAndEdit(2);
    });

    mainGrid2.on("rowdblclick", function(e) {
        addAndEdit(2);
    });

    mainGrid3.on("rowdblclick", function(e) {
        addAndEdit(2);
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
    //销售单管理。查询
    if (nui.get("typeMsg").value == 1) {
        mainGrid.load({ params: param, type: 1,token:token});
    }
    if (nui.get("typeMsg").value == 2) {
        param.status = "1,2";
        mainGrid2.load({ params: param, type: 1,token:token });
    }
    if (nui.get("typeMsg").value == 3) {
        param.status = 2;
        param.isSettle = 1;
        param.isSubmitCar = 1;
        mainGrid3.load({ params: param, type: 1,token:token });
    }
}

function openPage(params) {
    var tabsId = null;
    var text = null;
    if (nui.get("typeMsg").value == 1) {
        tabsId = "12780";
        text = "销售管理详情";
    }
    if (nui.get("typeMsg").value == 2) {
        tabsId = "12781";
        text = "销售单审核详情";
    }
    if (nui.get("typeMsg").value == 3) {
        tabsId = "12782";
        text = "销售结案详情";
    }
    var item = {};
    item.id = tabsId;
    item.text = text;
    item.url = webPath + contextPath + "/sales/sales/editCarSales.jsp";
    item.iconCls = "fa fa-file-text";
    params.typeMsg = nui.get("typeMsg").value;
    window.parent.activeTabAndInit(item, params);
}

function addAndEdit(e) {
    var params = {};
    if (e == 2) {
        var row = mainGrid.getSelected() || mainGrid2.getSelected() || mainGrid3.getSelected();
        params.id = row.id;
    }
    openPage(params);
}
function edit(row_uid){
    var row = mainGrid.getRowByUID(row_uid);
    var params = {};  
    params.id = row.id;
    openPage(params);
}
function edit2(row_uid){
    var row = mainGrid2.getRowByUID(row_uid);
    var params = {};  
    params.id = row.id;
    openPage(params);
}
function edit3(row_uid){
    var row = mainGrid3.getRowByUID(row_uid);
    var params = {};  
    params.id = row.id;
    openPage(params);
}

//反结案
function backSettlement(){
	var row = mainGrid3.getSelected();
	if(row){
		var isSettle = row.isSettle || 0;
		if(isSettle != 1){
			showMsg("销售单未结案，不能反结案","W");
			return;
		}
		var status = row.status || 0;
		//var enterId = row.enterId || 0;
		if(status == 3){
			showMsg("销售单已作废，不能反结案","W");
			return;
		}
		if(status == 2){
			showMsg("销售单未审核，不能反结案","W");
			return;
		}
		var saleMain = {};
		saleMain.id = row.id;
		nui.ajax({
	         url: baseUrl + "com.hsapi.sales.svr.save.backSettlement.biz.ext",
	         data: {
	        	 saleMain: saleMain
	         },
	         cache: false,
	         async: false,
	         success: function(text) {
	             if (text.errCode == "S") {
	                 showMsg("反结案成功", "S");
	                 param.status = 2;
	                 param.isSettle = 1;
	                 param.isSubmitCar = 1;
	                 mainGrid3.load({ params: param, type: 1 });
	             }else{
	            	 showMsg(text.errMsg, "E");
	             }
	             nui.unmask(document.body);
	         }
	     });
	}else{
		showMsg("请选择销售单记录","W");
	}
}



