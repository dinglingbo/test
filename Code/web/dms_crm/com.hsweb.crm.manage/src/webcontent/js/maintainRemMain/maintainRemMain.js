/**
* Created by Administrator on 2018/10/23.
*/
var baseUrl = apiPath +repairApi + "/";
var sysUrl =apiPath +sysApi+"/";
var gridCarUrl = baseUrl+"com.hsapi.repair.repairService.query.queryMainRemind.biz.ext";
var mainGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext";
var itemGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsItemQuoteByServiceId.biz.ext";
var visitModeCtrlUrl = sysUrl + "com.hsapi.system.dict.dictMgr.queryDict.biz.ext?dictid=DDT20130703000021&fromDb=true";

var gridCar = null;
var tabForm = null;
var rpsPackageGrid = null;
var rpsItemGrid = null;
var mainId_ctrl = null;
var visitMode_ctrl = null;
var tcarNo_ctrl = null;
var memList = [];
var mtAdvisorIdEl = null;
var mtAdvisorEl = null;
var visitManEl = null;
var visitIdEl = null;
var table1Form = null;
var tmobileEl=null;

$(document).ready(function(){
	rpsPackageGrid = nui.get("rpsPackageGrid");
	rpsItemGrid = nui.get("rpsItemGrid");
	mtAdvisorEl = nui.get("mtAdvisor");
	mtAdvisorIdEl = nui.get("mtAdvisorId");
	visitManEl = nui.get("visitMan");
	visitIdEl = nui.get("visitId");
	tabForm = new nui.Form("#tabs");
	table1Form = new nui.Form("#table1");
	tcarNo_ctrl = nui.get("tcarNo");
	tmobileEl=nui.get('tmobile');
	visitMode_ctrl = nui.get("visitMode");
	visitMode_ctrl.setUrl(visitModeCtrlUrl);
	gridCar = nui.get("gridCar");
	gridCar.setUrl(gridCarUrl);


	gridCar.on("rowclick",function(e){
		var record = e.record;
		SetData(record);
	});
	
	document.onkeyup = function(event) {
        var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下
        

        if ((keyCode == 13)) { // Enter
        	onSearch();
        }

    }
	onSearch();

});

function mtAdvisorChanged(e){
	var sel = e.selected;
	mtAdvisorIdEl.setValue(sel.empId);

}

function visitManChanged(e){
	var sel = e.selected;
	visitIdEl.setValue(sel.empId);

}

function SetData(rowData){
	var params = {
		data: {
			id: rowData.serviceId
		}
	};
	getMaintain(params, function(text){
		var errCode = text.errCode||"";
		var data = text.maintain||{};
		if(errCode == 'S'){
			var p = {
				data:{
					guestId: data.guestId||0,
					contactorId: data.contactorId||0
				}
			};
			getGuestContactorCar(p, function(text){
				var errCode = text.errCode||"";
				var guest = text.guest||{};
				var contactor = text.contactor||{};
				if(errCode == 'S'){
					

					var form ={
						mainId:rowData.id,
						guest:guest.fullName,
						carNo:data.carNo,
						carVin:data.carVin,
						carId:data.carId,
						guestId:data.guestId,
						serviceId:data.id,
						enterKilometers:data.enterKilometers,
						mobile:guest.mobile,
						contactor:guest.contactor,
						contactorTel:guest.contactorTel,
						mtAdvisor:data.mtAdvisor,
						mtAdvisorId:data.mtAdvisorId,
						billTypeId:data.billTypeId, 
						enterDate:data.enterDate, 
						outDate:data.outDate
					}; 
//					var visitdetaildata = searchVisitDetail(rowData.id);
//					if(visitdetaildata){
//						form.visitMode = visitdetaildata.visitMode;
//						form.visitId = visitdetaildata.visitId;
//						form.visitMan = visitdetaildata.visitMan;
//						form.visitDate = visitdetaildata.visitDate;
//						form.visitContent = visitdetaildata.visitContent;
//						form.careDueDate = visitdetaildata.careDueDate;
//						form.careDayCycle = visitdetaildata.careDayCycle;
//						form.detailId = visitdetaildata.id;
//					}
					tabForm.setData(form);
					table1Form.setData(data);


					var p1 = {
						interType: "package",
						data:{
							serviceId: data.id||0
						}
					};
					var p2 = {
						interType: "item",
						data:{
							serviceId: data.id||0
						}
					};
					var p3 = {
						interType: "part",
						data:{
							serviceId: data.id||0
						}
					};
					loadDetail(p1, p2, p3);




				}
			});
		}
	});
}


function loadDetail(p1, p2, p3){
	if(p1 && p1.interType){
		getBillDetail(p1, function(text){
			var errCode = text.errCode;
			var data = text.data||[];
			if(errCode == "S"){
				rpsPackageGrid.clearRows();
				rpsPackageGrid.addRows(data);
				rpsPackageGrid.accept();
			}
		}, function(){}); 
	}
	if(p2 && p2.interType){
		getBillDetail(p2, function(text){
			var errCode = text.errCode;
			var data = text.data||[];
			if(errCode == "S"){
				rpsItemGrid.clearRows();
				rpsItemGrid.addRows(data);
				rpsItemGrid.accept();
			}
		}, function(){});
	}
}


function save(){
	var data = tabForm.getData();
	var row=gridCar.getSelected();
	var record = {
		id:data.id,
		orgid: currOrgId,
		careType:1,
		guestId:data.guestId,
		carId:data.carId,
		visitMode : data.visitMode,
		visitContent:data.visitContent,
		visitId:currUserId,
		visitMan:currUserName,
		visitDate:data.visitDate
	};
	nui.ajax({
		url:baseUrl + "com.hsapi.repair.repairService.crud.saveCareRecord.biz.ext",
		type:"post",
		data:{
			data:record
		},
		success:function(text){
			if(text.errCode == "S"){
				var detailData = text.list;
//				showMsg("保存成功！","S");
				nui.get("id").setValue(detailData.id);
				gridCar.removeRow (row, true);
			}

		}
	});
}

//function searchVisitDetail(mid){
//	var ret = null;
//	var p ={
//		mainId:mid
//	};
//	nui.ajax({
//		url:baseUrl + "com.hsapi.crm.svr.visit.queryCrmVisitRecord.biz.ext",
//		type:"post",
//		async: false,
//		data:{
//			params:p,
//			token:token
//		},
//		success:function(text){
//			if(text.errCode == "S"){
//				var tdata = text.data;
//				if(tdata.length == 1){
//					ret = tdata[0];
//				}else if(tdata.length > 1 ){
//					showMsg("获取数据失败！","E");
//				}else{}
//			}
//
//		}
//	});
//	return ret;
//}


function quickSearch(e){
	var  p = null;
	if(e == 1){//我接待的车
		p ={
			mtAdvisorId:currUserId
		};
	}
	if(e == 2){//所有车辆

	}
	if(e == 3){
		p = {
			carNo:tcarNo_ctrl.value,
			mobile :tmobileEl.value
		};
	}
	gridCar.load({params:p,token:token});
}

function onSearch(){
	var params={}
	if(tcarNo_ctrl.value ||tmobileEl.value ){
		quickSearch(3);
	}
	else{		
		doSearch(params);
	}
}

function doSearch(params){
	params.isNeedRemind=1;
	params.remindStatus=0;
	gridCar.load({params:params,token:token});
}


function addBooking() {
    var row = gridCar.getSelected();
    row.contactorName=row.guestName;
    row.contactorTel=row.mobile;
    row.carSeriesId=row.carModelId;
    if (row == undefined) {
        showMsg("请选中一条数据","W");
        return;
    }
    nui.open({
        url: webPath + repairDomain + "/repair/RepairBusiness/BookingManagement/BookingManagementEdit.jsp?token="+token,
        title: "新增", width: 655, height: 386,
        onload: function () {
            var iframe = this.getIFrameEl();
            var param = { action: "edit", data: row };
            iframe.contentWindow.SetData(param);
        },
        ondestroy: function (action) {
        	//重新加载
        }
    });
}

function checkMtRecord() {
    var row = gridCar.getSelected();
    if (row == undefined) {
        showMsg("请选中一条数据","W");
        return;
    }
    nui.open({
        url: webPath + repairDomain + "/manage/maintainRemind/checkMtRemind.jsp?token="+token,
        title: "查看保养提醒", width: 700, height: 386,
        onload: function () {
            var iframe = this.getIFrameEl();
            var param = { 
        		guestId: row.guestId,
        		careType : 1
        		};
            iframe.contentWindow.SetData(param);
        },
        ondestroy: function (action) {
        	//重新加载
        }
    });
}