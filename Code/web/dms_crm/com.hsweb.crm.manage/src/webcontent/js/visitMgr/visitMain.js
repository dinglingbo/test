/**
* Created by Administrator on 2018/10/23.
*/
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/"; 
var gridCarUrl = baseUrl+"com.hsapi.crm.svr.visit.queryCrmVisitData.biz.ext";
var mainGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext";
var itemGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsItemQuoteByServiceId.biz.ext";
var queryInfo = baseUrl + "com.hsapi.repair.repairService.query.queryRpsMaintainInfo.biz.ext";
var visitModeCtrlUrl = baseUrl + "com.hsapi.system.dict.dictMgr.queryDict.biz.ext?dictid=DDT20130703000021&fromDb=true";

var gridCar = null;
var tabForm = null;
var table1Form = null;
var tableDisForm = null; 
var tab5Form = null;
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
var serviceTypeIdEl = null;
var hash = {};

$(document).ready(function(){
	serviceTypeIdEl = nui.get("serviceTypeId");
	rpsPackageGrid = nui.get("rpsPackageGrid");
	rpsItemGrid = nui.get("rpsItemGrid");
	mtAdvisorEl = nui.get("mtAdvisor");
	mtAdvisorIdEl = nui.get("mtAdvisorId");
	visitManEl = nui.get("visitMan");
	visitIdEl = nui.get("visitId"); 
	tabForm = new nui.Form("#tabs");
	table1Form = new nui.Form("#table1");
	tcarNo_ctrl = nui.get("tcarNo");
	visitMode_ctrl = nui.get("visitMode");
	visitMode_ctrl.setUrl(visitModeCtrlUrl);
	gridCar = nui.get("gridCar");
	gridCar.setUrl(gridCarUrl);
	gridCar.load();

	gridCar.on("rowclick",function(e){
		var record = e.record;
		SetData(record);
	});
	
	document.onkeyup = function(event) {
		var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下
        

        if ((keyCode == 13)) { // Enter
        	quickSearch(3);
        }

    }

    initMember("mtAdvisor",function(){
    	memList = mtAdvisorEl.getData();
    	nui.get("visitMan").setData(memList); 
    }); 

    initServiceType("serviceTypeId",function(data) {

    });

    initDicts({
        //carSpec:CAR_SPEC,//车辆规格
        //kiloType:KILO_TYPE,//里程类别
        //source:GUEST_SOURCE,//客户来源
        identity:IDENTITY //客户身份
    },function(){
    	hash.initDicts = true;
    });

    initCarBrand("carBrandId",function(data) {
    });
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
		id: rowData.serviceId
	};
	nui.ajax({
		url:queryInfo,
		type:"post",
		data:{params:params},
		success:function(text){
			if(text.errCode == "S"){
				var data = text.list[0];

				var form ={
					mainId:rowData.id,
					serviceId:data.id,
					guest:data.guestShortName,
					carNo:data.carNo,
					carVin:data.carVin,
					carId:data.carId,
					carBrandId:data.carBrandId,
					carModel:data.carModel,
					guestId:data.guestId,
					enterKilometers:data.enterKilometers,
					compComeTimes:data.compComeTimes,
					engineNo:data.engineNo,
					mobile:data.mobile,
					contactor:data.contactorName,
					contactorTel:data.contactorMobile,
					identity:data.identity,
					mtAdvisor:data.mtAdvisorId, 
					mtAdvisorId:data.mtAdvisorId,
					billTypeId:data.billTypeId, 
					serviceTypeId:data.serviceTypeId, 
					enterDate:data.enterDate, 
					outDate:data.outDate,
					guestDesc:data.guestDesc,
					faultPhen:data.faultPhen,
					solveMethod:data.solveMethod
				}; 
				var visitdetaildata = searchVisitDetail(rowData.id);
				if(visitdetaildata){
					form.visitMode = visitdetaildata.visitMode;
					form.visitId = visitdetaildata.visitId;
					form.visitMan = visitdetaildata.visitMan;
					form.visitDate = visitdetaildata.visitDate;
					form.visitContent = visitdetaildata.visitContent;
					form.careDueDate = visitdetaildata.careDueDate;
					form.careDayCycle = visitdetaildata.careDayCycle;
					form.detailId = visitdetaildata.id;
				}
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
	var record = {
		id:data.detailId,
		visitMode:data.visitMode,
		visitId:data.visitId,
		visitMan:data.visitMan,
		visitDate:data.visitDate,
		visitContent:data.visitContent,
		careDueDate:data.careDueDate,
		careDayCycle:data.careDayCycle,
		carId:data.carId,
		guestId:data.guestId,
		serviceId:data.serviceId,
		type:'1',
		mainId:data.mainId
	};
	nui.ajax({
		url:baseUrl + "com.hsapi.crm.svr.visit.savevisitDetail.biz.ext",
		type:"post",
		data:{
			detail:record
		},
		success:function(text){
			if(text.errCode == "S"){
				var detailData = text.detailData;
				showMsg("保存成功！","S");
				nui.get("detailId").setValue(detailData.id);
			}

		}
	});
}

function searchVisitDetail(mid){
	var ret = null;
	var p ={
		mainId:mid
	};
	nui.ajax({
		url:baseUrl + "com.hsapi.crm.svr.visit.queryCrmVisitRecord.biz.ext",
		type:"post",
		async: false,
		data:{
			params:p,
			token:token
		},
		success:function(text){
			if(text.errCode == "S"){
				var tdata = text.data;
				if(tdata.length == 1){
					ret = tdata[0];
				}else if(tdata.length > 1 ){
					showMsg("获取数据失败！","E");
				}else{}
			}

		}
	});
	return ret;
}


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
			carNo:tcarNo_ctrl.value
		};
	}
	gridCar.load({params:p,token:token});
}

function WindowComplianDetail(){
	nui.open({
		url: webBaseUrl + "manage/complainDetail.jsp?token="+token,
		title:"投诉登记",
		height:"500px",
		width:"750px",
		onload:function(){
			//var iframe = this.getIFrameEl();
			//iframe.contentWindow.SetData("th");
		},
		ondestroy:function(action){
			if (action == "ok") {
				//var iframe = this.getIFrameEl();
				//var childdata = iframe.contentWindow.GetFormData();
				//savepartOutRtn(row,childdata);
                //savePartOut();     //如果点击“确定”
                //CloseWindow("close");
            }
        }

    });
}


function WindowrepairHistory(){
	nui.open({
		url: webBaseUrl + "manage/visitMgr/repairHistory.jsp?token="+token,
		title:"维修历史",
		height:"300px",
		width:"750px",
		onload:function(){
			//var iframe = this.getIFrameEl();
			//iframe.contentWindow.SetData("th");
		},
		ondestroy:function(action){
			if (action == "ok") {
				//var iframe = this.getIFrameEl();
				//var childdata = iframe.contentWindow.GetFormData();
				//savepartOutRtn(row,childdata);
                //savePartOut();     //如果点击“确定”
                //CloseWindow("close");
                
            }
        }

    });
}