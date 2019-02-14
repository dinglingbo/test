/**
* Created by Administrator on 2018年9月21日19:29:11
*/
var baseUrl = apiPath + repairApi + "/";
var webBaseUrl = webPath + contextPath + "/";
$(document).ready(function(v) {


});

function dailyQualityDetail(){
    var item={};
    item.id = "dailyQualityDetail";
    item.text = "质检日明细表";
    item.url = webPath + contextPath + "//repair/report/otherReports/works/dailyQualityDetail.jsp?token="+token;
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function dailyQualityTotal(){
    var item={};
    item.id = "dailyQualityTotal";
    item.text = "质检日汇总表";
    item.url = webPath + contextPath + "/repair/report/otherReports/works/dailyQualityTotal.jsp?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function dailyReceptionDetail(){
    var item={};
    item.id = "dailyReceptionDetail";
    item.text = "接待日明细表";
    item.url = webPath + contextPath + "/repair/report/otherReports/works/dailyReceptionDetail.jsptoken="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function dailyReceptionTotal(){
    var item={};
    item.id = "dailyReceptionTotal";
    item.text = "接待日汇总表";
    item.url = webPath + contextPath + "/repair/report/otherReports/works/dailyReceptionTotal.jsp?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function dailyTechnicianDetail(){
    var item={};
    item.id = "dailyTechnicianDetail";
    item.text = "技师日明细表";
    item.url = webPath + contextPath + "/repair/report/otherReports/works/dailyTechnicianDetail.jsp?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function dailyTechnicianTotal(){
    var item={};
    item.id = "dailyTechnicianTotal";
    item.text = "技师日汇总表";
    item.url = webPath + contextPath + "/repair/report/otherReports/works/dailyTechnicianTotal.jsp?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}
