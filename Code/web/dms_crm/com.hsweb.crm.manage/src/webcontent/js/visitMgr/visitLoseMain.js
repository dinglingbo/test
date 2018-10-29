/**
* Created by Administrator on 2018/10/23.
*/
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/"; 
var gridCarUrl = baseUrl+"com.hsapi.crm.svr.visit.queryLoseGuestByDay.biz.ext";
var mainGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext";
var itemGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsItemQuoteByServiceId.biz.ext";
var visitModeCtrlUrl = baseUrl + "com.hsapi.system.dict.dictMgr.queryDict.biz.ext?dictid=DDT20130703000021&fromDb=true";
var mainReasonUrl = baseUrl + "com.hsapi.system.dict.dictMgr.queryDict.biz.ext?dictid=DDT20130705000008&fromDb=true";
var detailReasonUrl = baseUrl + "com.hsapi.system.dict.dictMgr.queryDict.biz.ext?dictid=DDT20130705000009&fromDb=true";

var gridCar = null;
var tabForm = null; 
var rpsPackageGrid = null;
var rpsItemGrid = null;
var mainId_ctrl = null;
var visitMode_ctrl = null;
var mainReason_ctrl = null;
var subReason_ctrl = null;
var tcarNo_ctrl = null;
var loseParam_ctrl = null;
var memList = [];
var mtAdvisorIdEl = null;
var mtAdvisorEl = null;
var visitManEl = null;
var visitIdEl = null;
var table1Form = null;

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
	loseParam_ctrl = nui.get("loseParam");
	setLoseParams();
	visitMode_ctrl = nui.get("mode");
	visitMode_ctrl.setUrl(visitModeCtrlUrl);

	mainReason_ctrl = nui.get("mainReason");
	mainReason_ctrl.setUrl(mainReasonUrl);
	subReason_ctrl = nui.get("subReason");
	subReason_ctrl.setUrl(detailReasonUrl);
	
	gridCar = nui.get("gridCar");
	gridCar.setUrl(gridCarUrl);
	gridCar.load();

	gridCar.on("rowclick",function(e){
		var record = e.record;
		SetData(record);
	});

	initMember("mtAdvisor",function(){
		memList = mtAdvisorEl.getData();
		nui.get("scoutMan").setData(memList); 
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
	if(!rowData.lastServiceId){
		showMsg("找不到对应的工单！","E");
		tabForm.setData([]);
		table1Form.setData([]);
		rpsPackageGrid.setData([]);
		rpsItemGrid.setData([]);
		return;
	}
	var params = {
		data: {
			id: rowData.lastServiceId
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
					var visitdetaildata = searchVisitDetail(rowData.guestId);
					if(visitdetaildata){
						form.mode = visitdetaildata.mode;
						form.scoutMan = visitdetaildata.scoutMan;
						form.scoutDate = visitdetaildata.scoutDate;
						form.content = visitdetaildata.content;
						form.nextScoutDate = visitdetaildata.nextScoutDate;
						form.predComeDate = visitdetaildata.predComeDate;
						form.mainReason = visitdetaildata.mainReason;
						form.subReason = visitdetaildata.subReason;
						form.isContinueScout = visitdetaildata.isContinueScout;
						form.nowMtComp = visitdetaildata.nowMtComp;
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
	var record = {
		id:data.detailId,
		mode:data.mode,
		scoutMan:data.scoutMan,
		scoutDate:data.scoutDate,
		content:data.content,
		nextScoutDate:data.nextScoutDate,
		predComeDate:data.predComeDate,
		mainReason:data.mainReason,
		subReason:data.subReason,
		isContinueScout:data.isContinueScout,
		nowMtComp:data.nowMtComp,
		carId:data.carId,
		guestId:data.guestId
	};
	nui.ajax({
		url:baseUrl + "com.hsapi.crm.svr.visit.saveVisitLoseDetail.biz.ext",
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

function searchVisitDetail(gid){
	var ret = null;
	var p ={
		id:"",
		guestId:gid,
		carId:""
	};
	nui.ajax({
		url:baseUrl + "com.hsapi.crm.svr.visit.QueryCrmVisitLoseDetail.biz.ext",
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
	var lparam = loseParam_ctrl.value;
	var  p = null;
	if(e == 0){//车牌号
		p = {
			carNo:tcarNo_ctrl.value,
			sloseDay:120,
		};
	}
	if(e == 1){//今日计划跟进客户
		p ={
			loseDay:120
		};
	}
	if(e == 2){//新流失客户
		p ={
			sloseDay:120,
			eloseDay:180
		};
	}
	if(e == 3){//流失超过半年客户
		p = {
			sloseDay:182
		};
	}
		if(e == 4){//流失超过一年的客户
			p = {
				sloseDay:365
			};
		}
		gridCar.load({params:p});
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


	function setLoseParams(){
		nui.ajax({
			url:baseUrl + "com.hsapi.crm.svr.visit.queryRemindParams.biz.ext",
			type:"post",
			async: false,
			data:{
				token:token
			},
			success:function(text){
				if(text.errCode == "S"){
					var tdata = text.data;
					if(tdata.length == 1){
						loseParam_ctrl.setValue(tdata[0].param9);
					}else if(tdata.length > 1 ){
						showMsg("未设置流失客户相关参数！","W");
					}else{}
				}

			}
		});
	}