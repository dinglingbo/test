/**
* Created by Administrator on 2018年9月21日19:29:11
*/
var baseUrl = apiPath + repairApi + "/";
var webBaseUrl = webPath + contextPath + "/";
var guestBoardGrid = null;
var workShopBoard = null;
var grid2 = null;
var guestBoardUrl = baseUrl + "com.hsapi.repair.repairService.daydata.queryGuestBoard.biz.ext";
var todayDataUrl = baseUrl + "com.hsapi.repair.repairService.daydata.queryTodayData.biz.ext";
var guestCarUrl = baseUrl + "com.hsapi.repair.repairService.daydata.queryGuestCar.biz.ext";
var statusHash = {
    "0" : "报价",
    "1" : "施工",
    "2" : "完工"
};
$(document).ready(function(v) {

    guestBoardGrid = nui.get("guestBoardGrid");
    workShopBoard = nui.get("workShopBoard");
    guestBoardGrid.setUrl(guestBoardUrl);

    guestBoardGrid.on("drawcell", function (e) {
        if (e.field == "status") {
            e.cellHtml = statusHash[e.value];
        }
    });

    setTimeout(function(){
        guestBoardGrid.load({
            token:token
        });

        queryTodayData(function(data){
            setGridTodayData(data);
        });

        var p = {
            orgid: currOrgId
        }
        queryGuestCarData(p,function(data){
            setGridGuestCarData(data);
        });
    },1000);

   //grid2 = nui.get("grid2");

    var grid1_data =[{business:"采购订单",custom:"长荣行",address:"上海浦东",date:"8:40",status:"已受理"},
    {business:"配件订单",custom:"李莉莉",address:"广东广州",date:"10:50",status:"已完成"}];

 /*   var grid2_data =[
    {business:"保养提醒",num:"2",cost:"5454342"},
    {business:"保险提醒",num:"0",cost:"0"},
    {business:"年检提醒",num:"1",cost:"72145"},
    {business:"年审提醒",num:"2",cost:"931455"},
    {business:"客户生日",num:"2",cost:"931455"},
    {business:"员工生日",num:"2",cost:"931455"}];*/
    //grid1.setData(grid1_data);
    //grid1.setShowVGridLines(false);
    //grid1.setShowHGridLines(false);

/*    grid2.setData(grid2_data);
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
    });*/

});

function toRepairBill(){
    var item={};
    item.id = "1036";
    item.text = "综合开单";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.repairBill.flow?token="+token;
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}
function toCarWashBill(){//1
    var item={};
    item.id = "4000";
    item.text = "洗车开单";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.carWashBill.flow?token="+token;
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}
function toSellBill(){
    var item={};
    item.id = "1104";
    item.text = "销售开单";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.sellBill.flow?token="+token;
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}
function toCarInsuranceDetail(){
    var item={};
    item.id = "1184";
    item.text = "保险开单";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.CarInsuranceDetail.flow?token="+token;
    item.iconCls = "fa fa-car";
    window.parent.activeTab(item);
}
function addCustomer(){
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

function toRepairOut(){
    var item={};
    item.id = "1481";
    item.text = "维修出库";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.repairOut.flow?token="+token,
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}
function toPurchaseOrderMain(){
    var item={};
    item.id = "1482";
    item.text = "采购订单";
    item.url = webPath + contextPath + "/com.hsweb.part.manage.purchaseOrderMain.flow?token="+token,
    item.iconCls = "fa fa-exchange";
    window.parent.activeTab(item);
}

function toCustomerProfileMain(){
    var item={};
    item.id = "1221";
    item.text = "车辆新建";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.CustomerProfileMain.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}
function toStockCheck(){
    var item={};
    item.id = "1985";
    item.text = "盘点单";
    item.url = webPath + contextPath + "/com.hsweb.part.manage.stockCheck.flow?token="+token;
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}
function toTimesCardList(){
    var item={};
    item.id = "1862";
    item.text = "计次卡销售";
    item.url = webPath + contextPath + "/com.hsweb.repair.DataBase.timesCardList.flow?token="+token;
    item.iconCls = "fa fa-file-text";
    var params = {id:1862};
    window.parent.activeTabAndInit(item,params);
}

function toCardList(){
    var item={};
    item.id = "1861";
    item.text = "储值卡充值";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.CardUp.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function toVisitMain(){
    var item={};
    item.id = "1863";
    item.text = "工单回访";
    item.url = webPath + contextPath + "/com.hsweb.crm.manage.visitMain.flow?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function showGuestBoard(){
    //document.getElementById("gridGuestBoard").style.display ='block';
    //document.getElementById("gridWorkShopBoard").style.display ='none';
    window.open(webBaseUrl+"com.hsweb.RepairBusiness.guestBoard.flow?token="+token); 
}
function showWorkShopBoard(){
    //document.getElementById("gridGuestBoard").style.display ='none';
    //document.getElementById("gridWorkShopBoard").style.display ='block';
    window.open(webBaseUrl+"com.hsweb.RepairBusiness.workshopBoard.flow?token="+token); 
}
function queryTodayData(callback) {
    var p = {
        startDate: getNowStartDate(),
        endDate: addDate(getNowStartDate(),1)
    };
	nui.ajax({
		url : todayDataUrl,
		type : "post",
		data : JSON.stringify({
            params: p,
            token:token
        }),
		success : function(text) {
			var data = text.data || {};
			if (data && data.length>0) {
                var d = data[0];
				callback(d);
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
}
function setGridTodayData(data){
	$("#newCarQty").text(0);
	$("#recordBillQty").text(0);
	$("#settleQty").text(0);
	$("#serviceBillQty").text(0);
	$("#bookingBillQty").text(0);
	$("#receiveAmt").text(0);
	
	if(data){
		var newCarQty = 0, recordBillQty = 0, settleQty = 0, serviceBillQty = 0, bookingBillQty = 0, receiveAmt = 0;
        newCarQty = data.newCarQty||0;
        recordBillQty = data.recordBillQty||0;
        settleQty = data.settleQty||0;
        serviceBillQty = data.serviceBillQty||0;
        bookingBillQty = data.bookingBillQty||0;
        receiveAmt = data.receiveAmt||0;        
        $("#newCarQty").text(newCarQty);
        $("#recordBillQty").text(recordBillQty);
        $("#settleQty").text(settleQty);
        $("#serviceBillQty").text(serviceBillQty);
        $("#bookingBillQty").text(bookingBillQty);
        $("#receiveAmt").text(receiveAmt);
	}

}
function queryGuestCarData(p,callback) {
    p.startDate = getNowStartDate();
    p.endDate = addDate(getNowStartDate(),1);
	nui.ajax({
		url : guestCarUrl,
		type : "post",
		data : JSON.stringify({
            params: p,
            token:token
        }),
		success : function(text) {
			var data = text.data || {};
			callback(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
}
function setGridGuestCarData(data){
	$("#addGuestQty").text(0);
	$("#guestQty").text(0);
	$("#addCarQty").text(0);
	$("#carQty").text(0);
	
	if(data){
		var addGuestQty = 0, guestQty = 0, addCarQty = 0, carQty = 0;
        addGuestQty = data.addGuestQty||0;
        guestQty = data.guestQty||0;
        addCarQty = data.addCarQty||0;
        carQty = data.carQty||0;       
        $("#addGuestQty").text(addGuestQty);
        $("#guestQty").text(guestQty);
        $("#addCarQty").text(addCarQty);
        $("#carQty").text(carQty);
	}

}
function showOrgGuestCar(){
    var p = {
        orgid: currOrgId
    }
    queryGuestCarData(p,function(data){
        setGridGuestCarData(data);
    });
}
function showTenantGuestCar(){
    var p = {
        tenantId: currTenantId
    }
    queryGuestCarData(p,function(data){
        setGridGuestCarData(data);
    });
}