/**
* Created by Administrator on 2018/4/25.
*/
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var detailGrid = null;
var insurance = [];
var mainListUrl = baseUrl+"com.hsapi.repair.repairService.insurance.QueryRpsInsuranceListById.biz.ext";
var detailGridUrl = baseUrl+"com.hsapi.repair.repairService.insurance.queryRpsInsuranceDetailList.biz.ext";
var guestInfoUrl = baseUrl + "com.hsapi.repair.repairService.svr.queryCustomerWithContactList.biz.ext";
var insuranceInfoUrl = baseUrl + "com.hsapi.repair.baseData.insurance.InsuranceQuery.biz.ext?params/orgid="+currOrgId+"&params/isDisabled=0";
var servieIdEl = null;
var searchNameEl = null; 
var searchKeyEl = null;
var mtAdvisorIdEl = null;
var mtAdvisorEl = null;
var insuranceComp = null;
//var insuranceForm = null;
var saleManIds = null;
var fserviceId = 0;
var fguestId = 0;
var carCheckInfo = null;
var mainData = null;
var settleTypeIdList = [{id:1,name:"保司直收"},{id:2,name:"门店代收全款"},{id:3,name:"代收减返点"}];
var detailData = [{insureTypeId:1,insureTypeName:"交强险"},{insureTypeId:2,insureTypeName:"商业险"},{insureTypeId:3,insureTypeName:"车船税"}];
$(document).ready(function ()
{
   
    
    basicInfoForm = new nui.Form("#basicInfoForm");
//    insuranceForm = new nui.Form("#insuranceForm");
    mtAdvisorIdEl = nui.get("mtAdvisorId");
    mtAdvisorEl = nui.get("mtAdvisor");
    saleManIds = nui.get("saleManIds");
    insuranceComp = nui.get("insureCompName");
    searchKeyEl = nui.get("search_key");
    searchNameEl = nui.get("search_name");
    searchKeyEl = nui.get("search_key");
    searchKeyEl.setUrl(guestInfoUrl);
    insuranceComp.setUrl(insuranceInfoUrl);
    searchKeyEl.on("beforeload",function(e){
        if(fserviceId){
            e.cancel = true;
            return;
        }
        var data = {};
        var params = {};
        var value = e.data.key;
        value = value.replace(/\s+/g, "");
        params.isDisabled = 0;
        if(value.length<3){
            e.cancel = true;
            return;
        }else{
            var reg = /^[0-9]*$/;//纯数字
            if(reg.test(value)){
                params.nums = value;

                data.params = params;
                e.data =data;
                return;
            }

            //包含字母
            var reg = /[a-z]/i;
            if(reg.test(value)){
                params.letters = value;

                data.params = params;
                e.data =data;
                return;
            }

            //包含中文
            var reg = /[\u4E00-\u9FA5\uF900-\uFA2D]/;
            if(reg.test(value)){
                params.chis = value;

                data.params = params;
                e.data =data;
                return;
            }
        }
    });
    searchKeyEl.on("valuechanged",function(e){
        var item = e.selected;
        if(fserviceId){
            return;
        }
        if (item) {
        	if(item.guestMobile == "10000"){
        		addOrEdit(item);
        	}else{
        		setGuest(item);
          }
       }
    });

    searchKeyEl.on("itemclick",function(e){
        var item = e.item;
        if(fserviceId){
            return;
        }
        if (item) {
        	if(item.guestMobile == "10000"){
        		addOrEdit(item);
        	}else{
        		setGuest(item);
		    }
       }
    });
   
    detailGrid = nui.get("detailGrid");
    detailGrid.setUrl(detailGridUrl);
    detailGrid.setData(detailData);
    detailGrid.on("drawcell",function(e){
        var field = e.field;
        var row = e.record;
    });

    detailGrid.on("cellcommitedit",function(e){
        var record = e.record;
        var value = e.value;
        var column = e.column;
        var field = e.field;
        var editor = e.editor;
        if(column.field == "amt" ||column.field == "rtnCompRate" ||column.field == "rtnGuestRate"){
            editor.validate();
            if (editor.isValid() == false) {
                showMsg("请输入有效数字!","W");
                e.cancel = true;
            }else{
            	if (e.field == "amt") {
        			var amt = e.value;
        			if (e.value == null || e.value == '') {
        				e.value = 0;
        				amt = 0;
        			} else if (e.value < 0) {
        				e.value = 0;
        				amt = 0;
        			}
        		}
            	if (e.field == "rtnCompRate") {
        			var rtnCompRate = e.value;
        			if (e.value == null || e.value == '') {
        				e.value = 0;
        				rtnCompRate = 0;
        			} else if (e.value < 0) {
        				e.value = 0;
        				rtnCompRate = 0;
        			}
        		}
            	if (e.field == "rtnGuestRate") {
        			var rtnGuestRate = e.value;
        			if (e.value == null || e.value == '') {
        				e.value = 0;
        				rtnGuestRate = 0;
        			} else if (e.value < 0) {
        				e.value = 0;
        				rtnGuestRate = 0;
        			}
        		}

            }

        }
    });

    initMember("mtAdvisorId",function(){
        var memList = mtAdvisorIdEl.getData();
        var memArr = nui.clone(memList);
        saleManIds.setData(memArr);
    });

    nui.get("recordDate").setValue(new Date());
    document.getElementById("showA1").style.display = "";
	document.getElementById("showA").style.display='none';
    document.getElementById("search_key$text").setAttribute("placeholder","请输入...(车牌号/客户名称/手机号/VIN码)");
    InsuranceQuery();//查出保险公司，用于带出返点

    
});

function setGuest(item){
	var carNo = item.carNo||"";
    var tel = item.guestMobile||"";
    var guestName = item.guestFullName||"";
    var carVin = item.vin||"";
    var carModel = item.carModel||"";
    var sdata = {
        carNo:carNo,
        carVin:carVin,
        carId:item.carId,
        guestMobile:tel,
        contactName:item.contactName,
        contactorId:item.contactorId,
        guestId:item.guestId,
        enterKilometers:"",
        guestFullName:guestName,
        recordDate: nui.get("recordDate").value,
        mtAdvisorId:""
    };
    basicInfoForm.setData(sdata);
    nui.get('mtAdvisorId').setValue(currEmpId);
    nui.get('mtAdvisorId').setText(currUserName);
    nui.get('mtAdvisor').setValue(currUserName);
    $("#guestNameEl").html(guestName);
    $("#guestCarEl").html(carNo);
    $("#guestTelEl").html(tel);
    if(tel){
        tel = "/"+tel;
    }
    if(guestName){
        guestName = "/"+guestName;
    }
    if(carVin){
        carVin = "/"+carVin;
    }
    var sk = document.getElementById("search_key");
    sk.style.display = "none";
    searchNameEl.setVisible(true);
    var t = carNo + tel + guestName + carVin;
    searchNameEl.setValue(t);
}

function ManChanged(e){
    var sel = e.selected;
    mtAdvisorEl.setValue(sel.empName);

}


function drawSummaryCell(e){
    var data = e.data;
    var value = e.value;
    var column = e.column;
    var field = e.field;
    var editor = e.editor;
    var rtn_comp_amt_sum = 0;
    var rtn_guest_amt_sum = 0;
    var amt = 0;
    var rtnCompRate = 0;
    var rtnGuestRate = 0;
    for (var i = 0; i < data.length; i++) {
        amt = data[i].amt || 0;
        rtnCompRate = data[i].rtnCompRate || 0;
        rtnGuestRate = data[i].rtnGuestRate || 0;
        rtn_comp_amt_sum +=(amt*rtnCompRate)/100;
        rtn_guest_amt_sum +=(amt*rtnGuestRate)/100;
    }
    if(column.field == "insureTypeName" ){
        e.cellHtml = "合计";
        e.cellStyle = "text-align:center";
    }
    if(column.field == "amt" ){
        e.cellHtml = value;
        e.cellStyle = "text-align:center";
    }

    if(column.field == "rtnCompRate" ){
        e.cellHtml = rtn_comp_amt_sum.toFixed(4);
        e.cellStyle = "text-align:center";
    }

    if(column.field == "rtnGuestRate" ){
        e.cellHtml = rtn_guest_amt_sum.toFixed(4);
        e.cellStyle = "text-align:center";
    }
}


function insuranceChange(e){
	var data=detailGrid.getData();
	var  detailData2=[];
	var carNo=nui.get('carNo').getValue();
	if(!carNo){
		showMsg("请先添加客户信息!","W");
		return;
	}
    var selected = e.selected;
    nui.get("insureCompId").setValue(selected.id);
    for(var i =0;i<insurance.length;i++){
    	if(insurance[i].id==selected.id){
    		detailData2 = [
    		              {insureTypeId:1,rtnCompRate:insurance[i].rebateAgentToCompany1,rtnGuestRate:insurance[i].rebateCompanyToGuest1,insureTypeName:"交强险"},
    		              {insureTypeId:2,rtnCompRate:insurance[i].rebateAgentToCompany2,rtnGuestRate:insurance[i].rebateCompanyToGuest2,insureTypeName:"商业险"},
    		              {insureTypeId:3,rtnCompRate:insurance[i].rebateAgentToCompany3,rtnGuestRate:insurance[i].rebateCompanyToGuest3,insureTypeName:"车船税"}];
    	}
    }
    if(detailData2.length>0){
    	for(var i=0;i<detailData2.length;i++){
    		detailGrid.updateRow(data[i],detailData2[i]);
    	}
    	
    }
}
function saleManChange(e){
    var val = nui.get("saleManIds").text;
    nui.get("saleMans").setValue(val);
}


function searchMainData(tid){
    var val = null;
    nui.ajax({
        url:baseUrl + "com.hsapi.repair.repairService.insurance.QueryRpsInsuranceListById.biz.ext",
        tupe:"post",
        async:false, 
        data:{
            id:tid
        },
        success:function(text){
            if(text.errCode == "S"){
                val = text.list[0];
            }

        }

    });
    return val;
}

//查出保险公司，用于带出返点
function InsuranceQuery(){
    nui.ajax({
        url:insuranceInfoUrl,
        tupe:"post",
        async:false, 
        success:function(text){
        	insurance=text.list;

        }

    });
}

function setInitData(params){
    mainData= params;
    if(!params.id){
    	add();
    }else{
     nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '数据加载中...'
    });
     var pid ={
        id:params.id
    };

    nui.ajax({
        url:mainListUrl,
        type:"post",
        data:{id:params.id},
        success:function(text){
            var list = text.list;
            if (list.length == 1) {
                var ldata = list[0];
             var p = {
                data:{
                    guestId: ldata.guestId||0,
                    contactorId: ldata.contactorId||0
                }
            };
            getGuestContactorCar(p, function(text){
                var errCode = text.errCode||"";
                var guest = text.guest||{};
                var contactor = text.contactor||{};
                if(errCode == 'S'){
                    $("#servieIdEl").html(ldata.serviceCode);
                    var carNo = ldata.carNo||"";
                    var tel = guest.mobile||"";
                    var guestName = guest.fullName||"";
                    var carVin = ldata.carVin||"";
                    fguestId = ldata.guestId;
                    if(tel){
                        tel = "/"+tel;
                    }
                    if(guestName){
                        guestName = "/"+guestName;
                    }
                    if(carVin){
                        carVin = "/"+carVin;
                    }
                    var t = carNo + tel + guestName + carVin;

                    var sk = document.getElementById("search_key");
                    sk.style.display = "none";
                    searchNameEl.setVisible(true);

                    searchNameEl.setValue(t);
                    searchNameEl.setEnabled(false);

                    if(contactor.wechatOpenId){
                    	document.getElementById("showA").style.display = "";
                    	document.getElementById("showA1").style.display='none';
                    }else{
                    	document.getElementById("showA").style.display='none';
                    	document.getElementById("showA1").style.display = "";
                    }
                    $("#guestNameEl").html(guest.fullName);
                    $("#guestCarEl").html(ldata.carNo);
                    $("#guestTelEl").html(guest.mobile);
                    var sdata = {
                        id:ldata.id,
                        carNo:ldata.carNo,
                        carVin:ldata.carVin,
                        carId:ldata.carId,
                        guestMobile:guest.mobile,
                        carBrandId : ldata.carBrandId,
                        carModel : ldata.carModel,
                        //contactName:item.contactName,
                        contactorId:ldata.contactorId,
                        guestId:ldata.guestId,
                        enterKilometers:ldata.enterKilometers,
                        guestFullName:guest.fullName,
                        recordDate:ldata.recordDate,
                        insureCompId:ldata.insureCompId,
                        insureCompName:ldata.insureCompName,
                        saleMans:ldata.saleMans,
                        saleManIds:ldata.saleManIds,
                        beginDate:ldata.beginDate,
                        endDate:ldata.endDate,
                        mtAdvisorId:ldata.mtAdvisorId,
                        mtAdvisor:ldata.mtAdvisor,
                        settleTypeId :ldata.settleTypeId
                    };
                
            basicInfoForm.setData(sdata);
            if(!sdata.mtAdvisorId){
            	nui.get('mtAdvisorId').setValue(currEmpId);
            	nui.get('mtAdvisorId').setText(currUserName); 
            	nui.get('mtAdvisor').setValue(currUserName);
            }
            
//            insuranceForm.setData(sdata);
            detailGrid.load({serviceId:params.id,token:token});

//            if(ldata.settleTypeId == 1){
//                $("#radio1").attr("checked", "checked");
//            }
//            if(ldata.settleTypeId == 2){
//                $("#radio2").attr("checked", "checked");
//            }
//            if(ldata.settleTypeId == 3){
//                $("#radio3").attr("checked", "checked");
//            }

        }else{
            showMsg("数据加载失败,请重新打开工单!","E");
        }

    }, function(){
        nui.unmask(document.body);
    });


        }

    }
});


}
}

function add(){

	searchNameEl.setVisible(false);
    searchNameEl.setEnabled(false);
    searchNameEl.setValue("");
    $("#servieIdEl").html("");
    var sk = document.getElementById("search_key");
    sk.style.display = "";
    searchKeyEl.focus();
    searchKeyEl.setValue("");//点增加给输入框个值，防止触发不了onchanged方法，不能放入客户
//    insuranceForm.setData([]);
    basicInfoForm.setData([]);
    nui.get("recordDate").setValue(new Date());
    nui.get("mtAdvisorId").setValue(currEmpId);
    nui.get("mtAdvisor").setValue(currUserName);

    fguestId = 0;
    fcarId = 0;
    fserviceId = 0;

    $("#servieIdEl").html("");
    $("#guestNameEl").html("");
    $("#guestTelEl").html("");
    $("#guestCarEl").html("");
    detailGrid.setData([]);
    detailGrid.setData(detailData);
    document.getElementById("showA1").style.display = "";
	document.getElementById("showA").style.display='none';
}


function addGuest(){
    doApplyCustomer({},function(adction){
        if("ok" == action)
        {
            var iframe = this.getIFrameEl();
            var data = iframe.contentWindow.getSaveData();
            var carNo = data.carNo||"";
            var mobile = data.mobile||"";
            var guestName = data.guestFullName||"";
            if(carNo){
                searchKeyEl.setValue(carNo);
                searchKeyEl.setText(carNo);
                searchKeyEl.doQuery();
                return;
            }
            if(mobile){
                searchKeyEl.setValue(mobile);
                searchKeyEl.setText(mobile);
                searchKeyEl.doQuery();
                return;
            }
            if(guestName){
                searchKeyEl.setValue(guestName);
                searchKeyEl.setText(guestName);
                searchKeyEl.doQuery();
                return;
            }

        }
    });
}

var requiredField={
	carNo				:"车牌号",
	enterKilometers		:"本次里程",
	mtAdvisorId 		:"服务顾问",
	insureCompName 		:"保险公司",
	saleManIds			:"销售人员",
	beginDate			:"有效开始日期",
	endDate				:"有效结束日期",
	settleTypeId		:"保费收取方式"	
	
};
function saveData(e){
    var tid = nui.get("id").value;
    if(tid){
        var main = searchMainData(tid);
            if(main.status != 0){
            showMsg("该工单已转入预结算或已结算，不能再进行此操作!","W");
            return false;
        }
    }
    var data = basicInfoForm.getData(true);
    basicInfoForm.validate();
    if(basicInfoForm.isValid()==false){
		showMsg("本次里程请填写正整数!","W");
		return false;
	}
    for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
			showMsg(requiredField[key] + "不能为空!","W");
			return false;
		}
	}
    /*if(data.id){
    	delete data.recordDate;
    }*/
//    var data2 = getData2();
    if(data.recordDate){
    	data.recordDate = format(data.recordDate, 'yyyy-MM-dd HH:mm:ss');

    }
    var gridData = detailGrid.getData();

    nui.ajax({
        url:baseUrl +"com.hsapi.repair.repairService.insurance.saveInsuranceMain.biz.ext",
        type:"post",
        async: false,
        data:{
            data:data,
            detailData:gridData
        },
        success:function(text){
            if(text.errCode=='S'){	
	        	var mainData = text.mainData;
	        	nui.get("id").setValue(mainData.id);
	        	detailGrid.load({serviceId:mainData.id,token:token});
	        	
	        	if(e == 1){
	        		showMsg("保存成功!","S");
	        		$("#servieIdEl").html(mainData.serviceCode);
	        	}
            }else{
            	showMsg("保存失败!","E");
           
            }

        }

    });
}

//function getData2() {
//    var data2 = insuranceForm.getData();
//    var b1= document.getElementsByName('settleTypeId');
//    for (var i = 0; i < b1.length; i++) {
//        if (b1[i].checked == true) {//如果选中，
//            data2.settleTypeId = b1[i].value;
//        }
//
//    }
//    return data2;
//}


function pay() {
    var tid = nui.get("id").value;
    if(!tid){
        showMsg("请先保存工单!","W");
        return;
    }
    var main = searchMainData(tid);
        if(main.status != 0){
        showMsg("该工单已转入预结算或已结算，不能再进行此操作!","W");
        return;
    }
    var msg = null;
    var moneyCost = 0;
    var sTypeId = null;

    var data1 = basicInfoForm.getData();
//    var data2 = getData2();
    var gridData = detailGrid.getData();
    var b1= nui.get('settleTypeId').getValue();
    sTypeId = b1;
    t_amt= detailGrid.getSummaryCellEl("amt").textContent;
    t_rtnCompRate= detailGrid.getSummaryCellEl("rtnCompRate").textContent;
    t_rtnGuestRate= detailGrid.getSummaryCellEl("rtnGuestRate").textContent;
    if (sTypeId == 3){
        moneyCost = parseFloat(t_amt - t_rtnGuestRate).toFixed(2);
    }else{
        moneyCost = parseFloat(t_amt).toFixed(2);
    }
    var params ={
        data1:data1,
        gridData:gridData,
        t_amt:t_amt,
        t_rtnCompRate:t_rtnCompRate,
        t_rtnGuestRate:t_rtnGuestRate,
        moneyCost:moneyCost,
        sTypeId:sTypeId
    };
    saveData(2);//转入结算和预结算都要保存
    if(saveData(2)==false){
    	return;
    }
    nui.open({
        url: webBaseUrl + "com.hsweb.RepairBusiness.insuranceSettlement.flow?token="+token,
        title:"保险结算",
        height:"100%",
        width:"100%",
        allowResize:false,
        onload:function(){
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData(params);
        },
        ondestroy:function(action){
            if(action == "ok"){
            	main.status =2;
                showMsg("结算成功!","S");
            }else if(action == "onok"){
            	main.status =2;
                showMsg("转预结算成功!","S");
            }else{
                if(data.errCode){
                    showMsg("结算失败!","W");
                    return;
                }
            }
    }

});

}



function onPrint(argument) {
	if(!nui.get("id").value){
		showMsg("清先保存保险开单!","W");
		return;
	}
    var params={
        comp:"",
        baseUrl:baseUrl,
        serviceId:nui.get("id").value,
        currRepairSettorderPrintShow : currRepairSettorderPrintShow,
        currOrgName : currOrgName,
        currCompAddress : currCompAddress,
        currCompTel : currCompTel,
        currCompLogoPath : currCompLogoPath,
        token:token
    };
    nui.open({
        url: webBaseUrl + "repair/RepairBusiness/Reception/insurnacePrint.jsp?token="+token,
        title:"保险单打印",
        height:"100%",
        width:"100%",
        allowResize:false,
        onload:function(){
            var iframe = this.getIFrameEl();
            iframe.contentWindow.SetData(params);
        },
        ondestroy:function(action){

        }

    });
}

function checkGuest(){
	var data = basicInfoForm.getData();
	 nui.open({
         url: webPath + contextPath + "/com.hsweb.repair.DataBase.AddEditGuest.flow?token="+token,
         title: '客户详情',
         width: 750, height: 570,
         onload: function () {
             var iframe = this.getIFrameEl();
             var params = {};	
             params.guest=data;
             iframe.contentWindow.setData(params);
         },
         ondestroy: function (action)
         {
             if("ok" == action)
             {
                 grid.reload();
             }
         }
     });
}

function addOrEdit(item)
{
    title = "完善散客信息";
    var guest = {};
    guest.guestId = item.guestId;
    guest.carNo = item.carNo;
    if(!item.guestId){
    	showMsg("数据获取失败,请重新操作!","W");
    	return;
    }
    nui.open({
        url:"com.hsweb.repair.DataBase.AddEditCustomer.flow",
        title:title,
        width:560,
        height:630,
        onload:function(){
            var iframe = this.getIFrameEl();
            var params = {};
            params.guest = guest;
            iframe.contentWindow.setData(params);
        },
        ondestroy:function(action)
        {
            if(action  == "ok")
            {  
            	var params = {};
            	params.carNo = item.carNo;
            	var json = nui.encode({
            		params:params
            	});
            	 //查找上次里程
                nui.ajax({
            		url :guestInfoUrl,
            		type : 'POST',
            		data : json,
            		cache : false,
            		contentType : 'text/json',
            		success : function(text) {
            			var returnJson = nui.decode(text);
            			if (returnJson.errCode == "S") {
            				var data = returnJson.list;
            				if(data && data.length>0){
            					setGuest(data[0]);
            				}
            			}else {
            				showMsg("数据加载失败,请重新操作!","E");
            				return;
            		    }
            		}
            	 });
            }
        }
    });
}


var binUrl = webBaseUrl + "repair/RepairBusiness/Reception/bindWechatContactor.jsp";
function bindWechat(){
	var data = basicInfoForm.getData();
	//var guestId = data.guestId;
	if(!data.guestId){
		return;
	}
	nui.open({
        url:binUrl,
        title:"绑定联系人",
        width:750, 
        height:300,
        onload:function(){
        	var iframe = this.getIFrameEl();
            var params = {};	
            params.guestId=data.guestId;
            params.carNo = data.carNo;
            iframe.contentWindow.setData(params);
        },
        ondestroy:function(action)
        {
        	var iframe = this.getIFrameEl();
            var params = {};	
            var params = iframe.contentWindow.getData();
            if(params){
            	if(params.success && params.success==1){
            		document.getElementById("showA").style.display = "";
                	document.getElementById("showA1").style.display='none';
            	}
            }
        	
        }
    });
}


