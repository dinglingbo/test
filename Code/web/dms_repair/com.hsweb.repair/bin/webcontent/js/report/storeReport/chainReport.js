/**
* Created by Administrator on 2018年9月21日19:29:11
*/
var baseUrl = apiPath + repairApi + "/";
var webBaseUrl = webPath + contextPath + "/";
$(document).ready(function(v) {


});

function carInCompTotal(){
    var item={};
    item.id = "carInCompTotal";
    item.text = "在厂车辆汇总表";
    item.url = webPath + contextPath + "/repair/report/otherReports/allComp/carInCompTotal.jsp?token="+token;
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function cashGainTotal(){
    var item={};
    item.id = "cashGainTotal";
    item.text = "连锁现金收入汇总表";
    item.url = webPath + contextPath + "/repair/report/otherReports/allComp/cashGainTotal.jsp?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function clientTotal(){
    var item={};
    item.id = "clientTotal";
    item.text = "连锁客户汇总表";
    item.url = webPath + contextPath + "/repair/report/otherReports/allComp/clientTotal.jsp?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function grossProfitTotal(){
    var item={};
    item.id = "grossProfitTotal";
    item.text = "连锁毛利汇总表";
    item.url = webPath + contextPath + "/repair/report/otherReports/allComp/grossProfitTotal.jsp?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function storeTotal(){
    var item={};
    item.id = "storeTotal";
    item.text = "连锁库存汇总表";
    item.url = webPath + contextPath + "/repair/report/otherReports/allComp/storeTotal.jsp?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

