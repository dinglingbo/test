/**
* Created by Administrator on 2018年9月21日19:29:11
*/
var baseUrl = apiPath + repairApi + "/";
var webBaseUrl = webPath + contextPath + "/";
$(document).ready(function(v) {


});

function commissionChangeRecord(){
    var item={};
    item.id = "commissionChangeRecord";
    item.text = "提成变更记录明细表";
    item.url = webPath + contextPath + "/repair/report/otherReports/performance/commissionChangeRecord.jsp?token="+token;
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function technicianCommissionDetail(){
    var item={};
    item.id = "technicianCommissionDetail";
    item.text = "技师提成明细表";
    item.url = webPath + contextPath + "/repair/report/otherReports/performance/technicianCommissionDetail.jsp?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function memberCommissionTotal(){
    var item={};
    item.id = "memberCommissionTotal";
    item.text = "员工提成汇总表";
    item.url = webPath + contextPath + "/com.hsweb.repair.repoart.memberCommissionTotal.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function memberMonthlyWage(){
    var item={};
    item.id = "memberMonthlyWage";
    item.text = "员工月工资结算汇总表";
    item.url = webPath + contextPath + "/repair/report/otherReports/performance/memberMonthlyWage.jsp?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function mtAdvisorCommissionDetail(){
    var item={};
    item.id = "mtAdvisorCommissionDetail";
    item.text = "服务顾问提成明细表";
    item.url = webPath + contextPath + "/repair/report/otherReports/performance/mtAdvisorCommissionDetail.jsp?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function mtAdvisorCommissionTotal(){
    var item={};
    item.id = "mtAdvisorCommissionTotal";
    item.text = "服务顾问提成汇总表";
    item.url = webPath + contextPath + "/repair/report/otherReports/performance/mtAdvisorCommissionTotal.jsp?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function salePerformanceDetail(){
    var item={};
    item.id = "salePerformanceDetail";
    item.text = "销售业绩明细表";
    item.url = webPath + contextPath + "/repair/report/otherReports/performance/salePerformanceDetail.jsp?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function salePerformanceTotal(){
    var item={};
    item.id = "salePerformanceTotal";
    item.text = "销售业绩汇总表";
    item.url = webPath + contextPath + "/repair/report/otherReports/performance/salePerformanceTotal.jsp?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function technicianCommissionTotal(){
    var item={};
    item.id = "technicianCommissionTotal";
    item.text = "技师提成汇总表";
    item.url = webPath + contextPath + "/repair/report/otherReports/performance/technicianCommissionTotal.jsp?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

