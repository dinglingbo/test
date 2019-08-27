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
//var colorList=[{color:"#5da4ff"},{color:"#2e6fff"},{color:"#e3251b"},{color:"#fd5d04"},{color:"#8302fc"},{color:"#ff7e00"},{color:"#ff9f2a"},{color:"#31c2f9"},{color:"#69c0ff"}];
var colorList=[{color:"#1faeff"},{color:"#ffd666"},{color:"#ff7875"},{color:"#ffc069"},{color:"#8c64279e"},{color:"#d3f261"},{color:"#95de64"},{color:"#5cdbd3"},{color:"#69c0ff"}];
var oder = 0;//颜色下标
var homePage = [];//主页图片
$(document).ready(function(v) {

/*    guestBoardGrid = nui.get("guestBoardGrid");
    guestBoardGrid.setUrl(guestBoardUrl);*/
    workShopBoard = nui.get("workShopBoard");

/*    guestBoardGrid.on("drawcell", function (e) {
        if (e.field == "status") {
            e.cellHtml = statusHash[e.value];
        }
		if (e.field == "recordDate") {
			var str =e.cellHtml.split(" "); 
			var qian = str[0].split("-");
			var time = qian[1]+"月"+qian[2]+"日"+" "+str[1];
				e.cellHtml = time;
			}
		if (e.field == "enterDate") { 
			var str =e.cellHtml.split(" "); 
			var qian = str[0].split("-");
			var time = qian[1]+"月"+qian[2]+"日"+" "+str[1];
				e.cellHtml = time;
			}
		if (e.field == "planFinishDate") {
			if(e.cellHtml!=""&&e.cellHtml!=null){
				var str =e.cellHtml.split(" "); 
				var qian = str[0].split("-");
				var time = qian[1]+"月"+qian[2]+"日"+" "+str[1];
				e.cellHtml = time;
			}
		}
    });*/

    setTimeout(function(){
/*        guestBoardGrid.load({
            token:token
        });*/

        queryTodayData(function(data){
            setGridTodayData(data);
        });
        queryHomePage();//加载主页图标按钮
        var p = {
            orgid: currOrgId
        }
        queryGuestCarData(p,function(data){
            setGridGuestCarData(data);
        });
        
        if(currIsReadSysmsg != "1") {
        	getLastLog();
        }
        
        setInitShareUrl();
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
    query();
});

function toRepairBill(){
   var item={};
    item.id = "2000";
    item.text = "综合开单详情";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.repairBill.flow?token="+token;
    item.iconCls = "fa fa-file-text";
    var params = {
    	id: ''
    };
    window.parent.activeTabAndInit(item,params);
}
function toCarWashBill(){//1
    var item={};
    item.id = "3000";
    item.text = "洗美开单详情";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.carWashBill.flow?token="+token;
    item.iconCls = "fa fa-file-text";
    var params = {
        	id: ''
        };
    window.parent.activeTabAndInit(item,params);
}
function toSellBill(){
    var item={};
    item.id = "5000";
    item.text = "销售开单详情";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.sellBill.flow?token="+token;
    item.iconCls = "fa fa-file-text";
    var params = {
        	id: ''
        };
    window.parent.activeTabAndInit(item,params);
}
function toCarInsuranceDetail(){
    var item={};
    item.id = "InsuranceDetail";
    item.text = "车险开单详情";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.CarInsuranceDetail.flow?token="+token;
    item.iconCls = "fa fa-car";
    var params = {
        	id: ''
        };
    window.parent.activeTabAndInit(item,params);
}
function toRepairBillTable(){
    /*var title = "新增客户资料";addCustomer()
    nui.open({
        url: webPath + contextPath + "/com.hsweb.repair.DataBase.AddEditCustomer.flow?token="+token,
        title: title, width: 560, height: 630,
        onload: function () {
        	var params={};
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action)
        {
        }
    });*/
	var item={};
    item.id = "maintenanceFiles";
    item.text = "维修档案";
    item.url = webPath + contextPath + "/com.hsweb.part.purchase.maintenanceFiles.flow?token="+token;
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}

function toRepairOut(){
    var item={};
    item.id = "2091";
    item.text = "配件领料";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.repairOut.flow?token="+token,
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}
function toPurchaseOrderMain(){
    var item={};
    item.id = "6000";
    item.text = "采购订单详情";
    item.url = webPath + contextPath + "/com.hsweb.part.manage.purchaseOrder.flow?token="+token,
    item.iconCls = "fa fa-exchange";
    var params = {};
    window.parent.activeTabAndInit(item,params);
}

function toCustomerProfileMain(){
    var item={};
    item.id = "2101";
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
/*function toTimesCardList(){
    var item={};
    item.id = "2107-1";
    item.text = "计次卡销售";
    item.url = webPath + contextPath + "/com.hsweb.repair.DataBase.timesCardList.flow?token="+token;
    item.iconCls = "fa fa-file-text";
    var params = {id:1862};
    window.parent.activeTabAndInit(item,params);
}

function toCardList(){
    var item={};
    item.id = "2108-1";
    item.text = "储值卡充值";
    item.url = webPath + contextPath + "/com.hsweb.repair.DataBase.cardList.flow?token="+token
    item.iconCls = "fa fa-file-text";
    var params = {};
    window.parent.activeTabAndInit(item,params);
}*/

function toTimesCardList(){
    var item={};
    item.id = "timesCard";
    item.text = "计次卡销售";
    item.url = webPath + contextPath + "/com.hsweb.frm.manage.cardTimesSettlement.flow?token="+token;
    item.iconCls = "fa fa-file-text";
    var params = {
    			cardType:1 //计次卡
    		};
    window.parent.activeTabAndInit(item,params);
}

function toCardList(){
    var item={};
    item.id = "card";
    item.text = "储值卡充值";
    item.url = webPath + contextPath + "/com.hsweb.frm.manage.cardSettlement.flow?token="+token;
    item.iconCls = "fa fa-file-text";
    var params = {
    			cardType:2 
    		};
    window.parent.activeTabAndInit(item,params);
}

function toVisitMain(){
    var item={};
    item.id = "2187";
    item.text = "客户回访";
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
function showPartLogisticsBoard(){
    window.open(webBaseUrl+"com.hsweb.part.manage.partLogistics.flow?token="+token); 
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
var queryHomePageUrl = apiPath + sysApi + "/com.hsapi.system.employee.employeeMgr.queryHomePage.biz.ext";
function queryHomePage(callback) {
	nui.ajax({
		url : queryHomePageUrl,
		type : "post",
		data : JSON.stringify({
            token:token
        }),
		success : function(text) {
			 homePage = text.homePage || {};
			 setHomePage(homePage);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
}
function setGridTodayData(data){
/*	$("#newCarQty").text(0);
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
        receiveAmt = data.netinAmt||0; 
        
        $("#newCarQty ").text(newCarQty);
        $("#recordBillQty").text(recordBillQty);
        $("#settleQty ").text(settleQty);
        $("#serviceBillQty ").text(serviceBillQty);
        $("#bookingBillQty ").text(bookingBillQty);
        $("#receiveAmt ").text(receiveAmt);
	}*/
	var todayNum = [data.newCarQty||0,data.recordBillQty||0,data.settleQty||0,data.serviceBillQty||0,data.bookingBillQty||0];
	var todayType = ["首修车辆","今日进厂","结算车次","在修车辆","预约车辆"];
	open(todayType,todayNum);
}
function setHomePage(data){
    for(var i=0;i<data.length;i++){
    	for(var j=0;j<data.length;j++){
        	if(data[j].iconOrder==i){
            	addDiv(data[j].address,data[j].name,data[j].iconId);
        	}    		
    	}
    }
	var twidth = 90 + (data.length+3)*90;
	var html="";
		html+='<div  style="float: left;"> ';		
		html+='	<a href="javascript:;" id="faker4" class="addImage tc sub-add-btn" onclick="addIcon()" style="display: flex;border: 2px dotted #B8B8B8;border-radius: 5px 5px 5px 5px;color: #222222;height: 50px;width:90px;text-align: center;text-decoration: none;left;margin-top: 10px;margin-left: 10px;border-radius: 12px;">';
		html+='	<img alt="" style="height: 50px;width: 90px;" src="'+webPath + contextPath+'/repair/prototype/images/add1.png"> ';
		html+='</a>';
		html+='</div>';
		$("#demo").append(html);
	
	if(data.length<11){
		document.getElementById("demoFather").style.width = "100%";	
	}else{
		document.getElementById("demoFather").style.width = twidth + 'px';	
	}
	document.getElementById("demo").style.width = twidth + 'px';
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
/*	$("#addGuestQty").text(0);
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
	}*/
	if(data){
		var options = {
				useEasing : true, 
				useGrouping : true, 
				separator : ',', 
				decimal : '.', 
				prefix : '', 
				suffix : '' 
		};
		var addGuestQty = new CountUp("addGuestQty", 0, data.addGuestQty||0, 0, 1.5, options);
		var guestQty = new CountUp("guestQty", 0, data.guestQty||0, 0, 1.5, options);
		var addCarQty = new CountUp("addCarQty", 0, data.addCarQty||0, 0, 1.5, options);
		var carQty = new CountUp("carQty", 0, data.carQty||0, 0, 1.5, options);
		addGuestQty.start();
		guestQty.start();
		addCarQty.start();
		carQty.start();	
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
function toMaintain(e){
	if(e==1||e==2){
	    var item={};
	    item.id = "maintain";
	    item.text = "首页提醒";
	    item.url = webPath + contextPath + "/stat.maintain.flow?token="+token;
	    item.iconCls = "fa fa-file-text";
	    var params = {id:e};
	    window.parent.activeTabAndInit(item,params);
	}else if(e==8){
	    var item={};
	    item.id = "2261";
	    item.text = "保养提醒";
	    item.url = webPath + contextPath + "/com.hsweb.crm.manage.maintainRemind.flow?token="+token;
	    item.iconCls = "fa fa-file-text";
	    var params = {id:e};
	    window.parent.activeTab(item);
	}else if(e==9){
	    var item={};
	    item.id = "allMaintain";
	    item.text = "工单明细表";
	    item.url = webPath + contextPath + "/com.hsweb.part.purchase.allMaintain.flow?token="+token;
	    var params = {id:"recordBillQty"};
	    item.iconCls = "fa fa-file-text";
	    var params = {id:"recordBillQty"};
	    window.parent.activeTabAndInit(item,params);
	}else if(e==10){
	    var item={};
	    item.id = "allMaintain";
	    item.text = "工单明细表";
	    item.url = webPath + contextPath + "/com.hsweb.part.purchase.allMaintain.flow?token="+token;
	    item.iconCls = "fa fa-file-text";
	    var params = {id:"settleQty"};
	    window.parent.activeTabAndInit(item,params);
	}else if(e==11){
	    var item={};
	    item.id = "allMaintain";
	    item.text = "工单明细表";
	    item.url = webPath + contextPath + "/com.hsweb.part.purchase.allMaintain.flow?token="+token;
	    item.iconCls = "fa fa-file-text";
	    var params = {id:"serviceBillQty"};
	    window.parent.activeTabAndInit(item,params);
	}else if(e==12){
	    var item={};
	    item.id = "2101";
	    item.text = "客户车辆";
	    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.CustomerProfileMain.flow?token="+token;
	    item.iconCls = "fa fa-file-text";
	    var params = {id:"newCarQty"};
	    window.parent.activeTabAndInit(item,params);
	}else if(e==13){
	    var item={};
	    item.id = "2081";
	    item.text = "预约管理";
	    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.BookingManagementList.flow?token="+token;
	    item.iconCls = "fa fa-file-text";
	    var params = {id:"bookingBillQty"};
	    window.parent.activeTabAndInit(item,params);
	}else if(e==14){
	    var item={};
	    item.id = "dms_dashboard";
	    item.text = "仪表盘";
	    item.url = webPath + contextPath + "/com.hsweb.repair.repoart.IncomeStatistics.flow?token="+token;
	    item.iconCls = "fa fa-file-text";
	    var params = {id:"receiveAmt"};
	    window.parent.activeTabAndInit(item,params);
	}else{
	    var item={};
	    item.id = "te";
	    item.text = "特别关怀";
	    item.url = webPath + contextPath + "/com.hsweb.crm.manage.specialAttention.flow?token="+token;
	    item.iconCls = "fa fa-file-text";
	    var params = {id:e};
	    window.parent.activeTabAndInit(item,params);
	}

}

//查询消息提醒，msg_Type消息类型
function queryRemind (carExtendQty,contactorQty,messageQty,appQty){
/*
	var queryAppointment = 0;//6预约到店
	var queryEmployeeBirthday = 0;//18员工生日
*/	
	var date = new Date();
	var month = date.getMonth()+1;
	var day = date.getDate();
	var dateStr = month+"月"+day+"日"+" 8:30";
	//等于0不显示，不等于0才显示
	if(carExtendQty[0].needQuantity!=0){
		//大于99条显示99+
		if(carExtendQty[0].needQuantity>99){
			$("#queryMaintain p").text("99+");
		}else{			
			$("#queryMaintain p").text(carExtendQty[0].needQuantity);
		}
	}else{
		document.getElementById('queryMaintain').style.display='none';
	}
	if(carExtendQty[0].annualQuantity!=0){
		if(carExtendQty[0].annualQuantity>99){			
			$("#queryBusiness p").text("99+");
		}else{
			$("#queryBusiness p").text(carExtendQty[0].annualQuantity);
		}
	}else{
		document.getElementById('queryBusiness').style.display='none';
	}
	if(carExtendQty[0].insureQuantity!=0){	
		if(carExtendQty[0].insureQuantity>99){			
			$("#queryCompulsoryInsurance p").text("99+");
		}else{
			$("#queryCompulsoryInsurance p").text(carExtendQty[0].insureQuantity);
		}
	}else{
		document.getElementById('queryCompulsoryInsurance').style.display='none';
	}
	if(contactorQty[0].licenseQuantity!=0){
		if(carExtendQty[0].licenseQuantity>99){			
			$("#queryDrivingLicense p").text("99+");
		}else{
			$("#queryDrivingLicense p").text(contactorQty[0].licenseQuantity);
		}
	}else{
		document.getElementById('queryDrivingLicense').style.display='none';
	}
	if(carExtendQty[0].veriQuantity!=0){
		if(carExtendQty[0].veriQuantity>99){			
			$("#queryCar p").text("99+");
		}else{
			$("#queryCar p").text(carExtendQty[0].veriQuantity);	
		}
	}else{
		document.getElementById('queryCar').style.display='none';
	}
	if(appQty[0].appQuantity!=0){
		if(carExtendQty[0].appQuantity>99){		
			$("#queryAppointment p").text("99+");
		}else{
			$("#queryAppointment p").text(appQty[0].appQuantity);	
		}
	}else{
		document.getElementById('queryAppointment').style.display='none';
	}
	if(contactorQty[0].birQuantity!=0){	
		if(carExtendQty[0].birQuantity>99){			
			$("#queryGuestBirthday p").text("99+");
		}else{
			$("#queryGuestBirthday p").text(contactorQty[0].birQuantity);			
		}
	}else{
		document.getElementById('queryGuestBirthday').style.display='none';
	}
	if(messageQty[0].ebirQuantity!=0){
		if(carExtendQty[0].ebirQuantity>99){			
			$("#queryEmployeeBirthday p").text("99+");
		}else{
			$("#queryEmployeeBirthday p").text(messageQty[0].ebirQuantity);			
		}
	}else{
		document.getElementById('queryEmployeeBirthday').style.display='none';
	}
	
	
	document.getElementById('queryMaintainDate').innerHTML=dateStr;
	document.getElementById('queryBusinessDate').innerHTML=dateStr;
	document.getElementById('queryCompulsoryInsuranceDate').innerHTML=dateStr;
	document.getElementById('queryDrivingLicenseDate').innerHTML=dateStr;
	document.getElementById('queryCarDate').innerHTML=dateStr;
	document.getElementById('queryAppointmentDate').innerHTML=dateStr;
	document.getElementById('queryGuestBirthdayDate').innerHTML=dateStr;
	document.getElementById('queryEmployeeBirthdayDate').innerHTML=dateStr;
}

//判断对象是否为{}
function isEmptyObject (obj){
	for(var key in obj ){
		return false;
	}
	return true;
}
function query (){
	var queryMaintainUrl = baseUrl+"com.hsapi.repair.repairService.query.homePageQuantity.biz.ext";
	nui.ajax({
		url : queryMaintainUrl,
		type : "post",
		cache : false,
		data : JSON.stringify({ 
            token:token
        }),
		success : function(text) {
			var carExtendQty = text.carExtendQty;
			var contactorQty = text.contactorQty;
			var messageQty = text.messageQty;
			var appQty = text.appQty;
			queryRemind(carExtendQty,contactorQty,messageQty,appQty); 
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
	
	var queryMaintainUrl = baseUrl+"com.hsapi.repair.repairService.query.homePageQuantity.biz.ext";
	nui.ajax({
		url : queryMaintainUrl,
		type : "post",
		cache : false,
		data : JSON.stringify({ 
            token:token
        }),
		success : function(text) {
			var carExtendQty = text.carExtendQty;
			var contactorQty = text.contactorQty;
			var messageQty = text.messageQty;
			var appQty = text.appQty;
			queryRemind(carExtendQty,contactorQty,messageQty,appQty); 
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
}

function bookingMgr(){
    var part={};
    part.id = "2081";
    part.text = "预约管理";
    part.url = webPath + contextPath + "/com.hsweb.RepairBusiness.BookingManagementList.flow?token="+token;
    part.iconCls = "fa fa-file-text";
    var params = {
        viewType:"reminding"
    };
    window.parent.activeTabAndInit(part,params);

}

var shareUrlGridUrl = apiPath + sysApi + "/com.hsapi.system.config.paramSet.queryTenantShareUrl.biz.ext";
function setInitShareUrl(){
	var param = {tenantId:currTenantId};
	nui.ajax({
		url : shareUrlGridUrl,
		type : "post",
		data : JSON.stringify({
			param : param,
			token: token
		}),
		success : function(data) {
			nui.unmask(document.body);
			data = data || {};
			var list = data.list;
			if (list && list.length>0) {
				$(".newul").empty();
				for(var i=0; i<list.length; i++){
					var r = list[i];
					var name = r.name;
					var url = r.shareUrl;//<li><a href="http://www.baidu.com">华胜企业体系</a></li>
					$(".newul").append('<li ><a href='+url+' target="_Blank">'+name+'</a></li>');
				}


			} else {
				
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}

//判断公司是否开启消息提醒，判断当前登录人是否已经读了消息
var updateLogUrl = apiPath + sysApi + "/com.hsapi.system.employee.slog.getLastLog.biz.ext";
function getLastLog(){
    nui.ajax({
        url:updateLogUrl,
        type:"post",
        data:JSON.stringify({
        	token: token
        }),
        success:function(text)
        {
            var data = text.data||{};
            if (data && data.content) {
            	nui.open({
                    url: webPath + contextPath + "/com.hs.common.updateLogTip.flow?token="+token,
                    title: "系统通知", width: 600, height: 550,
                    onload: function () {
                    	var params={};
                        var iframe = this.getIFrameEl();
                        iframe.contentWindow.setInitData(data);
                    },
                    ondestroy: function (action)
                    {
                    }
                });
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
        }
    });
}
function addIcon(){
	nui.open({
		url : webPath + contextPath + "/common/homeIcon.jsp",
		title : "设置主页图标",
		width : 900,
		height : 450,
		allowDrag : true,
		allowResize : false,
		onload : function() {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData(homePage);
		},
		ondestroy : function(action) {
			if (action == "ok") {
				$('#demo').html("");
				queryHomePage();
			}
		}
	});
}

function addDiv(address,name,iconId){
	if(oder==8){
		oder=0;
	}
	var html="";

//可拖动
/*	html+='<div class="item item'+number+' dads-children dad-draggable-area" data-dad-id="'+number+'" data-dad-position="'+number+'" style="background-color: #1faeff;width: 80px;height: 80px;float: left;">';		
	html+='		<i class="fa fa-wrench fa-4x  fa-inverse"></i>';
	html+='		<span>'+name+'</span> ';
	html+='</div>';
	$("#demo").append(html);*/
	//$('#demo').dad();
	//$("#demo").before(html);


	//不可拖动
	html+='<div class="menu_pannel menu_pannel_bg" style="background-color: '+colorList[oder].color+';width: 90px;height: 50px;float: left;margin-top: 10px;margin-left: 15px;border-radius: 12px;">';
		html+='<div class="menu_pannel menu_pannel_bg" style="width: 90px;height: 40px;float: left;margin-top: 10px;border-radius: 12px;">';
			html+='<a onclick="tojump('+"'" +address+"','"+name+"','"+iconId+"'" + ')" style="width: 50px;height: 60px;">';
				html+='<i class="fa fa-file-code-o fa-2x  fa-inverse" style="margin-top: 10px;margin-left: 10px;"></i>';
			html+='</a>';
		html+='</div>';
		html+='<p align="center" style="margin-top: 50px;">'+name+'</p>';                       
	html+='</div>';
	oder++;
	$("#demo").append(html);
}

function tojump(address,name,iconId){
    var item={};
    item.id = iconId;
    item.text = name;
    item.url = webPath + contextPath +address+"?token="+token;
    item.iconCls = "fa fa-file-text";
    var params = {};
    window.parent.activeTabAndInit(item,params);
}

function open2(todayType,todayNum){

	option = {
/*			title : {
			    text: '今日数据表',
			    //subtext: '纯属虚构'
			},*/
			tooltip : {
			    trigger: 'axis'
			},
			legend: {
			    data:['数量']
			},
			toolbox: {
			    show : true,
			    feature : {
			        mark : {show: true},
			        dataView : {show: true, readOnly: false},
			        magicType : {show: true, type: ['line', 'bar']},
			        restore : {show: true},
			        saveAsImage : {show: true}
			    }
			},
			calculable : true,

			xAxis : [
			    {
			        type : 'category',
			        data : todayType,
			        barGap: '10px',            // 柱间距离，默认为柱形宽度的30%，可设固定值
			        barWidth: '30%',
			        barCategoryGap : '50px',   // 类目间柱形距离，默认为类目间距的20%，可设固定值
			    }
			],
			yAxis : [
			    {
			        type : 'value'
			    }
			],
			series : [
			    {
			        name:'数量',
			        type:'bar',
			        data:todayNum,
			        markPoint : {
			            data : [
			                {type : 'max', name: '最大值'},
			                {type : 'min', name: '最小值'}
			            ]
			        },
			        markLine : {
			            data : [
			                {type : 'average', name: '平均值'}
			            ]
			        }
			    },
			]
			};
			var orgChart1 = echarts.init(document.getElementById('todayData'));
			            orgChart1.setOption(option);
}

function open(todayType,todayNum){

	option = {
			tooltip : {
			    trigger: 'axis'
			},
			grid: {  
				top: '32px', 
				bottom :"25px",
				containLabel: true  
			},

			xAxis : [
			    {

			        data : todayType,
			        triggerEvent:true,
			        barGap: '10px',            // 柱间距离，默认为柱形宽度的30%，可设固定值
			        barWidth: '30px',
			        barCategoryGap : '50px'   // 类目间柱形距离，默认为类目间距的20%，可设固定		        
	       
			    }
			],
			yAxis : [
			    {
			        type : 'value'
			    }
			],
			color:['#1e90ff'],//颜色 

			series : [
			    {
			        name:'数量',
			        type:'bar',
			        clickable : true, 
			        data:todayNum,
			        barWidth : 30,//柱图宽度
			        markPoint : {
			            data : [
			            ]
			        },
			        itemStyle: {        //上方显示数值
			                normal: {
			                    label: {
			                        show: true, //开启显示
			                        position: 'top', //在上方显示
			                        textStyle: { //数值样式
			                            color: '#1e90ff',
			                            fontSize: 14
			                        }
			                    }
			                }
			            },
			        markLine : {
			            data : [

			            ]
			        }
			    },
			]
			};
			var orgChart1 = echarts.init(document.getElementById('todayData'));
			            orgChart1.setOption(option);
			orgChart1.on('click', function (params) {
					if(params.componentType=="xAxis"){
						if(params.value=="首修车辆"){
					    	toMaintain(12);
					    }else if(params.value=="今日进厂"){
					    	toMaintain(9);
					    }else if(params.value=="结算车次"){
					    	toMaintain(10);
					    }else if(params.value=="在修车辆"){
					    	toMaintain(11);
					    }else if(params.value=="预约车辆"){
					    	toMaintain(13);
					    }				
					}else if(params.componentType=="series"){						
					    if(params.name=="首修车辆"){
					    	toMaintain(12);
					    }else if(params.name=="今日进厂"){
					    	toMaintain(9);
					    }else if(params.name=="结算车次"){
					    	toMaintain(10);
					    }else if(params.name=="在修车辆"){
					    	toMaintain(11);
					    }else if(params.name=="预约车辆"){
					    	toMaintain(13);
					    }
					}
				});
				
}	