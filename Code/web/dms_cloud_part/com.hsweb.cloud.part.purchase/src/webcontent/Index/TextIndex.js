/**
* Created by Administrator on 2018年9月21日19:29:11
*/

var grid1 = null;
var grid2 = null;
$(document).ready(function(v) {

    grid1 = nui.get("grid1");
    grid2 = nui.get("grid2");

    var grid1_data =[{business:"采购订单",custom:"长荣行",address:"上海浦东",date:"8:40",status:"已受理"},
    {business:"配件订单",custom:"李莉莉",address:"广东广州",date:"10:50",status:"已完成"}];

    var grid2_data =[{business:"报价的工单",num:"2",cost:"5454342"},
    {business:"施工的工单",num:"0",cost:"0"},
    {business:"完工未转预结算的工单",num:"1",cost:"72145"},
    {business:"完工待结算的工单",num:"2",cost:"931455"}];
    grid1.setData(grid1_data);
    grid1.setShowVGridLines(false);
    grid1.setShowHGridLines(false);

    grid2.setData(grid2_data);
    grid2.setShowVGridLines(false);
    grid2.setShowHGridLines(false);
    
    grid2.on("drawcell",function(e){
        var record = e.record;
        var column = e.column;
        var field = e.field;
        var value = e.value;
        var row = e.row;
        if(column.field == "num"||column.field == "business"){
            if(value){
                e.cellStyle = "color:#4d7496";
            }
        }
    });

});

function toReceptionMain(){
    var item={};
    item.id = "1036";
    item.text = "综合开单";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.ReceptionMain.flow";
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}
function toSellBill(){//1
    var item={};
    item.id = "4000";
    item.text = "销售-工单";
    item.url = webPath + contextPath + "/repair/RepairBusiness/Reception/sellBill.jsp";
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}
function toCarWashMgr(){
    var item={};
    item.id = "1104";
    item.text = "洗车开单";
    item.url = webPath + contextPath + "/repair/RepairBusiness/Reception/carWashMgr.jsp";
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}
function toPurchaseOrder(){
    var item={};
    item.id = "1184";
    item.text = "采购订单";
    item.url = webPath + contextPath + "/com.hsweb.cloud.part.purchase.purchaseOrder.flow";
    item.iconCls = "fa fa-car";
    window.parent.activeTab(item);
}
function addCustomer(){
/*    var item={};
    item.id = "1561";
    item.text = "车辆新建";
    item.url = webPath + contextPath + "/com.hsweb.cloud.part.purchase.packOut.flow";
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);*/
    var title = "新增客户资料";
    nui.open({
        url: webPath + contextPath + "/com.hsweb.repair.DataBase.AddEditCustomer.flow?token="+token,
        title: title, width: 560, height: 570,
        onload: function () {
            //var iframe = this.getIFrameEl();
            //iframe.contentWindow.setData(params);
        },
        ondestroy: function (action)
        {
        }
    });
}

function toReceivableSettle(){
    var item={};
    item.id = "1481";
    item.text = "应收款管理";
    item.url = webPath + contextPath + "/manage/settlement/receivableSettle.jsp";
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}
function toPaySettle(){
    var item={};
    item.id = "1482";
    item.text = "应付款管理";
    item.url = webPath + contextPath + "/manage/settlement/paySettle.jsp";
    item.iconCls = "fa fa-exchange";
    window.parent.activeTab(item);
}

function toOthersReceive(){
    var item={};
    item.id = "1221";
    item.text = "其他收支";
    item.url = webPath + contextPath + "/manage/settlement/othersReceive_view0.jsp";
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}
function toStockCheck(){
    var item={};
    item.id = "1985";
    item.text = "盘点单";
    item.url = webPath + contextPath + "/com.hsweb.part.manage.stockCheck.flow";
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}
function toCardList(){
    var item={};
    item.id = "1861";
    item.text = "储值卡定义";
    item.url = webPath + contextPath + "/repair/DataBase/Card/cardList.jsp";
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}
