/**
* Created by Administrator on 2018年9月21日19:29:11
*/
var baseUrl = apiPath + repairApi + "/";
var webBaseUrl = webPath + contextPath + "/";
$(document).ready(function(v) {


});

function businessOutputTotal(){
    var item={};
    item.id = "businessOutputTotal";
    item.text = "业务产值汇总表";
    item.url = webPath + contextPath + "/repair/report/otherReports/sell/businessOutputTotal.jsp?token="+token;
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function businessTrend(){
    var item={};
    item.id = "businessTrend";
    item.text = "营业趋势汇总表";
    item.url = webPath + contextPath + "/repair/report/otherReports/sell/businessTrend.jsp?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function dailySettlementDetail(){
    var item={};
    item.id = "dailySettlementDetail";
    item.text = "日结算明细表";
    item.url = webPath + contextPath + "/repair/report/otherReports/sell/dailySettlementDetail.jsp?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function stockCheckQuery(){
    var item={};
    item.id = "stockCheckQuery";
    item.text = "盘点单明细表";
    item.url = webPath + contextPath + "/com.hsweb.part.manage.stockCheckQuery.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function shopInvoingCount(){
    var item={};
    item.id = "shopInvoingCount";
    item.text = "进销存汇总表";
    item.url = webPath + contextPath + "/com.hsweb.part.manage.shopInvoingCount.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function shopInvoingDetail(){
    var item={};
    item.id = "shopInvoingDetail";
    item.text = "进销存明细表";
    item.url = webPath + contextPath + "/com.hsweb.part.manage.shopInvoingDetail.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function storeInvoingDetail(){
    var item={};
    item.id = "storeInvoingDetail";
    item.text = "分仓进销存明细表";
    item.url = webPath + contextPath + "/com.hsweb.part.manage.storeInvoingDetail.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function storeInvongCount(){
    var item={};
    item.id = "storeInvongCount";
    item.text = "分仓进销存汇总表";
    item.url = webPath + contextPath + "/com.hsweb.part.manage.storeInvongCount.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function RepairOutReport(){
    var item={};
    item.id = "RepairOutReport";
    item.text = "维修出库明细表";
    item.url = webPath + contextPath + "/com.hsweb.repair.repoart.RepairOutReport.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function RepairReturnReport(){
    var item={};
    item.id = "RepairReturnReport";
    item.text = "维修归库明细表";
    item.url = webPath + contextPath + "/com.hsweb.repair.repoart.RepairReturnReport.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function sellOutQty(){
    var item={};
    item.id = "sellOutQty";
    item.text = "销售出库明细表";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.sellOutQty.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function returnOutQty(){
    var item={};
    item.id = "returnOutQty";
    item.text = "退货归库明细表";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.returnOutQty.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function shiftPositionOrderQuery(){
    var item={};
    item.id = "shiftPositionOrderQuery";
    item.text = "移仓单明细表";
    item.url = webPath + contextPath + "/com.hsweb.part.manage.shiftPositionOrderQuery.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function stockTurnOverCount(){
    var item={};
    item.id = "stockTurnOverCount";
    item.text = "库存周转汇总表";
    item.url = webPath + contextPath + "/com.hsweb.part.manage.stockTurnOverCount.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function stockTurnOverDetail(){
    var item={};
    item.id = "stockTurnOverDetail";
    item.text = "库存周转明细表";
    item.url = webPath + contextPath + "/com.hsweb.part.manage.stockTurnOverDetail.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function productUnsoldReport(){
    var item={};
    item.id = "productUnsoldReport";
    item.text = "滞销产品汇总表";
    item.url = webPath + contextPath + "/com.hsweb.repair.repoart.productUnsoldReport.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function insuranceSaleDetail(){
    var item={};
    item.id = "insuranceSaleDetail";
    item.text = "保险销售明细表";
    item.url = webPath + contextPath + "/repair/report/otherReports/sell/insuranceSaleDetail.jsp?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}



function itemSaleReport(){
    var item={};
    item.id = "itemSaleReport";
    item.text = "套餐销售汇总表";
    item.url = webPath + contextPath + "/repair/report/otherReports/sell/itemSaleReport.jsp?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function partRepairTotal(){
    var item={};
    item.id = "partRepairTotal";
    item.text = "配件维修汇总表";
    item.url = webPath + contextPath + "/com.hsweb.repair.repoart.partRepairTotal.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function partSaleReport(){
    var item={};
    item.id = "partSaleReport";
    item.text = "配件销售汇总表";
    item.url = webPath + contextPath + "/repair/report/otherReports/sell/partSaleReport.jsp?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function projectSaleReport(){
    var item={};
    item.id = "projectSaleReport";
    item.text = "项目销售汇总表";
    item.url = webPath + contextPath + "/repair/report/otherReports/sell/projectSaleReport.jsp?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function RepairNoSettle(){
    var item={};
    item.id = "RepairNoSettle";
    item.text = "未结算配件明细表";
    item.url = webPath + contextPath + "/com.hsweb.repair.repoart.RepairNoSettle.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function RepairOutQty(){
    var item={};
    item.id = "RepairOutQty";
    item.text = "配件出库明细表";
    item.url = webPath + contextPath + "/com.hsweb.repair.repoart.RepairOutQty.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function RepairReturnQty(){
    var item={};
    item.id = "RepairReturnQty";
    item.text = "配件归库明细表";
    item.url = webPath + contextPath + "/com.hsweb.repair.repoart.RepairReturnQty.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function repairTotalReport(){
    var item={};
    item.id = "repairTotalReport";
    item.text = "维修汇总表";
    item.url = webPath + contextPath + "/repair/report/otherReports/sell/repairTotalReport.jsp?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function saleDetailTotal(){
    var item={};
    item.id = "saleDetailTotal";
    item.text = "销售明细汇总表";
    item.url = webPath + contextPath + "/repair/report/otherReports/sell/saleDetailTotal.jsp?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function wholesaleReport(){
    var item={};
    item.id = "wholesaleReport";
    item.text = "批发汇总表";
    item.url = webPath + contextPath + "/repair/report/otherReports/sell/wholesaleReport.jsp?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}
