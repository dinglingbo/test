/**
* Created by Administrator on 2018年9月21日19:29:11
*/
var baseUrl = apiPath + repairApi + "/";
var webBaseUrl = webPath + contextPath + "/";
$(document).ready(function(v) {


});

function checkMainDetail(){
    var item={};
    item.id = "checkMainDetail";
    item.text = "查车单明细表";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.checkMainDetail.flow?token="+token;
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function RetailStatistics(){
    var item={};
    item.id = "RetailStatistics";
    item.text = "零售业务统计分析表";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.RetailStatistics.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function RepairConsultantPerformanceMain(){
    var item={};
    item.id = "RepairConsultantPerformanceMain";
    item.text = "服务顾问业绩汇总表";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.RepairConsultantPerformanceMain.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function businessDaily(){
    var item={};
    item.id = "businessDaily";
    item.text = "营业日分析表";
    item.url = webPath + contextPath + "/com.hsweb.repair.repoart.businessDaily.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function carTypeCount(){
    var item={};
    item.id = "carTypeCount";
    item.text = "充值办卡汇总表";
    item.url = webPath + contextPath + "/com.hsweb.repair.DataBase.carTypeCount.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function selectCompensation(){
    var item={};
    item.id = "selectCompensation";
    item.text = "理赔开单明细表";
    item.url = webPath + contextPath + "/com.hsweb.part.purchase.selectCompensation.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function IncomeStatistics(){
    var item={};
    item.id = "IncomeStatistics";
    item.text = "仪表盘";
    item.url = webPath + contextPath + "/com.hsweb.repair.repoart.IncomeStatistics.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function CarInsuranceQuery(){
    var item={};
    item.id = "CarInsuranceQuery";
    item.text = "车险开单明细表";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.CarInsuranceQuery.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function selectComprehensive(){
    var item={};
    item.id = "selectComprehensive";
    item.text = "已结算工单明细表";
    item.url = webPath + contextPath + "/com.hsweb.part.purchase.selectComprehensive.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function inFactoryVehicle(){
    var item={};
    item.id = "inFactoryVehicle";
    item.text = "未结算工单明细表";
    item.url = webPath + contextPath + "/com.hsweb.part.purchase.inFactoryVehicle.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function businessOutputTotal(){
    var item={};
    item.id = "businessOutputTotal";
    item.text = "已结算工单汇总表";
    item.url = webPath + contextPath + "/com.hsweb.repair.DataBase.businessOutputTotal.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function returnQuery(){
    var item={};
    item.id = "returnQuery";
    item.text = "退货开单明细表";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.returnQuery.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function sellQuery(){
    var item={};
    item.id = "sellQuery";
    item.text = "销售开单明细表";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.sellQuery.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function sellectWash(){
    var item={};
    item.id = "sellectWash";
    item.text = "洗美开单明细表";
    item.url = webPath + contextPath + "/com.hsweb.part.purchase.sellectWash.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function BookingManagementSummary(){
    var item={};
    item.id = "BookingManagementSummary";
    item.text = "预约汇总表";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.BookingManagementSummary.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function notSettledPartDetail(){
    var item={};
    item.id = "notSettledPartDetail";
    item.text = "未结算配件明细表";
    item.url = webPath + contextPath + "/com.hsweb.repair.repoart.notSettledPartDetail.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function rpsCardTimeList(){
    var item={};
    item.id = "rpsCardTimeList";
    item.text = "计次卡消费明细表";
    item.url = webPath + contextPath + "/com.hsweb.repair.DataBase.rpsCardTimeList.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function cardRunningWaterSummary(){
    var item={};
    item.id = "cardRunningWaterSummary";
    item.text = "储值卡流水汇总表";
    item.url = webPath + contextPath + "/com.hsweb.repair.repoart.cardRunningWaterSummary.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function cardTimesRunningWaterSummary(){
    var item={};
    item.id = "cardTimesRunningWaterSummary";
    item.text = "计次卡流水汇总表";
    item.url = webPath + contextPath + "/com.hsweb.repair.repoart.cardTimesRunningWaterSummary.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}


