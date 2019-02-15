/**
* Created by Administrator on 2018年9月21日19:29:11
*/
var baseUrl = apiPath + repairApi + "/";
var webBaseUrl = webPath + contextPath + "/";
$(document).ready(function(v) {


});

function cashBankReport(){
    var item={};
    item.id = "cashBankReport";
    item.text = "现金银行汇总表";
    item.url = webPath + contextPath + "/repair/report/otherReports/finance/cashBankReport.jsp?token="+token;
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function dailySettlementReport(){
    var item={};
    item.id = "dailySettlementReport";
    item.text = "日结算汇总表";
    item.url = webPath + contextPath + "/repair/report/otherReports/finance/dailySettlementReport.jsp?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function accountBalance(){
    var item={};
    item.id = "accountBalance";
    item.text = "账户余额汇总表";
    item.url = webPath + contextPath + "/com.hsweb.frm.arap.accountBalance.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function accountDetail(){
    var item={};
    item.id = "accountDetail";
    item.text = "账户明细表";
    item.url = webPath + contextPath + "/com.hsweb.frm.arap.accountDetail.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function otherIncomeAndExpenditure(){
    var item={};
    item.id = "otherIncomeAndExpenditure";
    item.text = "其他收支明细表";
    item.url = webPath + contextPath + "/com.hsweb.frm.manage.otherIncomeAndExpenditure.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function accountPBillDetail(){
    var item={};
    item.id = "accountPBillDetail";
    item.text = "供应商欠款明细表";
    item.url = webPath + contextPath + "/com.hsweb.frm.arap.accountPBillDetail.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function accountPDetail(){
    var item={};
    item.id = "accountPDetail";
    item.text = "付款明细表";
    item.url = webPath + contextPath + "/com.hsweb.frm.arap.accountPDetail.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function accountRDetail(){
    var item={};
    item.id = "accountRDetail";
    item.text = "收款明细表";
    item.url = webPath + contextPath + "/com.hsweb.frm.arap.accountRDetail.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function settlementStatement(){
    var item={};
    item.id = "settlementStatement";
    item.text = "经营收支统计汇总表";
    item.url = webPath + contextPath + "/com.hsweb.frm.manage.settlementStatement.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function summaryAccountBalances(){
    var item={};
    item.id = "summaryAccountBalances";
    item.text = "结算账户余额汇总表";
    item.url = webPath + contextPath + "/com.hsweb.frm.manage.summaryAccountBalances.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function expenseSummary(){
    var item={};
    item.id = "expenseSummary";
    item.text = "费用汇总表";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.expenseSummary.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function otherGainPayReport(){
    var item={};
    item.id = "otherGainPayReport";
    item.text = "其它收支明细表";
    item.url = webPath + contextPath + "/repair/report/otherReports/finance/otherGainPayReport.jsp?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function painReport(){
    var item={};
    item.id = "painReport";
    item.text = "应收明细表";
    item.url = webPath + contextPath + "/repair/report/otherReports/finance/painReport.jsp?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function paymentReport(){
    var item={};
    item.id = "paymentReport";
    item.text = "洗应付明细表";
    item.url = webPath + contextPath + "/repair/report/otherReports/finance/paymentReport.jsp?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function profitTotal(){
    var item={};
    item.id = "profitTotal";
    item.text = "利润汇总表";
    item.url = webPath + contextPath + "/repair/report/otherReports/finance/profitTotal.jsp?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function twoCompSettleReport(){
    var item={};
    item.id = "twoCompSettleReport";
    item.text = "跨店结算明细表";
    item.url = webPath + contextPath + "/repair/report/otherReports/finance/twoCompSettleReport.jsp?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}






