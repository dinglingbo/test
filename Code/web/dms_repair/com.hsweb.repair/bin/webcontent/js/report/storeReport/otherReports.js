/**
* Created by Administrator on 2018年9月21日19:29:11
*/
var baseUrl = apiPath + repairApi + "/";
var webBaseUrl = webPath + contextPath + "/";
$(document).ready(function(v) {


});

function expensesRecord(){
    var item={};
    item.id = "expensesRecord";
    item.text = "消费记录明细表";
    item.url = webPath + contextPath + "/repair/report/otherReports/others/expensesRecord.jsp?token="+token;
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function noSettleRecord(){
    var item={};
    item.id = "noSettleRecord";
    item.text = "反结算记录明细表";
    item.url = webPath + contextPath + "/repair/report/otherReports/others/noSettleRecord.jsp?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

