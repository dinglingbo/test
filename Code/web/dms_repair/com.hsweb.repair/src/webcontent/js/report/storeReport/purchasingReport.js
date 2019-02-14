/**
* Created by Administrator on 2018年9月21日19:29:11
*/
var baseUrl = apiPath + repairApi + "/";
var webBaseUrl = webPath + contextPath + "/";
$(document).ready(function(v) {


});

function partBrandPchsForMonth(){
    var item={};
    item.id = "partBrandPchsForMonth";
    item.text = "品牌采购分析表";
    item.url = webPath + contextPath + "/com.hsweb.part.manage.partBrandPchsForMonth.flow?token="+token;
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function supplierPchsForMonth(){
    var item={};
    item.id = "supplierPchsForMonth";
    item.text = "供应商采购分析表";
    item.url = webPath + contextPath + "/com.hsweb.part.manage.supplierPchsForMonth.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function partPchsForMonth(){
    var item={};
    item.id = "partPchsForMonth";
    item.text = "配件采购分析表";
    item.url = webPath + contextPath + "/com.hsweb.part.manage.partPchsForMonth.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function purchaseOrderQuery(){
    var item={};
    item.id = "purchaseOrderQuery";
    item.text = "采购订单明细表";
    item.url = webPath + contextPath + "/com.hsweb.part.manage.purchaseOrderQuery.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function pchsOrderEnterQuery(){
    var item={};
    item.id = "pchsOrderEnterQuery";
    item.text = "采购入库明细表";
    item.url = webPath + contextPath + "/com.hsweb.part.manage.pchsOrderEnterQuery.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function purcharseRank(){
    var item={};
    item.id = "purcharseRank";
    item.text = "采购排行分析表";
    item.url = webPath + contextPath + "/com.hsweb.part.manage.purcharseRank.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function purchaseOrderRtnQuery(){
    var item={};
    item.id = "purchaseOrderRtnQuery";
    item.text = "采购退货明细表";
    item.url = webPath + contextPath + "/com.hsweb.part.manage.purchaseOrderRtnQuery.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function partTypePchsForMonth(){
    var item={};
    item.id = "partTypePchsForMonth";
    item.text = "配件类型采购分析表";
    item.url = webPath + contextPath + "/com.hsweb.part.manage.partTypePchsForMonth.flow?token="+token
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

function projectConstructionDetail(){
    var item={};
    item.id = "projectConstructionDetail";
    item.text = "项目施工明细表";
    item.url = webPath + contextPath + "/com.hsweb.repair.repoart.projectConstructionDetail.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function projectConstructionTotal(){
    var item={};
    item.id = "projectConstructionTotal";
    item.text = "项目施工汇总表";
    item.url = webPath + contextPath + "/com.hsweb.repair.repoart.projectConstructionTotal.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}





