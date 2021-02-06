/**
* Created by Administrator on 2018年9月21日19:29:11
*/
var baseUrl = apiPath + repairApi + "/";
var webBaseUrl = webPath + contextPath + "/";
$(document).ready(function(v) {


});

function checkMainDetail(){
    var item={};
    item.id = "RepairCommissionDetailsMain";
    item.text = "员工提成明细表";
    item.url = webPath + contextPath + "/com.hsweb.part.purchase.RepairCommissionDetailsMain.flow?token="+token;
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function RetailStatistics(){
    var item={};
    item.id = "projectConstructionDetail";
    item.text = "施工项目明细表";
    item.url = webPath + contextPath + "/com.hsweb.repair.repoart.projectConstructionDetail.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function RepairConsultantPerformanceMain(){
    var item={};
    item.id = "projectConstructionTotal";
    item.text = "施工项目汇总表";
    item.url = webPath + contextPath + "/com.hsweb.repair.repoart.projectConstructionTotal.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}






