var baseUrl = apiPath + repairApi + "/";
var querybusinessUrl = baseUrl+"com.hsapi.repair.repairService.query.querybusiness.biz.ext";

var business = null;//商业险
var compulsoryInsurance = null;//交强险
var drivingLicense = null;//驾照年审
var car = null;//车辆年检提醒
var guestBirthday = null;//客户生日

$(document).ready(function(v){
	business = nui.get("business");
	compulsoryInsurance = nui.get("compulsoryInsurance");
	drivingLicense = nui.get("drivingLicense");
	car = nui.get("car");
	guestBirthday = nui.get("guestBirthday");
	
	business.setUrl(querybusinessUrl);
	compulsoryInsurance.setUrl(querybusinessUrl);
	drivingLicense.setUrl(querybusinessUrl);
	car.setUrl(querybusinessUrl);
	guestBirthday.setUrl(querybusinessUrl);
	

	business.on("drawcell", function (e) {
        if(e.field == "annualStatus"){
             if(e.value == 0){
                 e.cellHtml = "未关怀";
             }else{
                 e.cellHtml = "已关怀";
             }
         }
     });
	compulsoryInsurance.on("drawcell", function (e) {
        if(e.field == "readSign"){
             if(e.value == 0){
                 e.cellHtml = "已读";
             }else{
                 e.cellHtml = "未读";
             }
         }
     });
	drivingLicense.on("drawcell", function (e) {
        if(e.field == "readSign"){
             if(e.value == 0){
                 e.cellHtml = "已读";
             }else{
                 e.cellHtml = "未读";
             }
         }
     });
	car.on("drawcell", function (e) {
        if(e.field == "readSign"){
             if(e.value == 0){
                 e.cellHtml = "已读";
             }else{
                 e.cellHtml = "未读";
             }
         }
     });

	guestBirthday.on("drawcell", function (e) {
        if(e.field == "readSign"){
             if(e.value == 0){
                 e.cellHtml = "已读";
             }else{
                 e.cellHtml = "未读";
             }
         }
     });


var params = {
	    	readSign : 1,
	    	readerTargetId : currEmpId
};
	
});
/*function query (params){
	var queryMaintainUrl = baseUrl+"com.hsapi.repair.repairService.query.querybusiness.biz.ext";
	nui.ajax({
		url : queryMaintainUrl,
		type : "post",
		cache : false,
		data :{
			params:params,
			token:token
		},
		success : function(text) {
			var list = text.data||0;
			queryRemind(list); 
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
}*/


function setInitData(params){
	var params = {};
	var tabs = nui.get("tabs");
	var tab = tabs.getTab ( params.id-1 );
	tabs.activeTab (tabs.getTab ( params.id-1 ) );
	query(tab);

}

function change(){
	var tabs = nui.get("tabs");
	var tab = tabs.getActiveTab();
	query(tab);

}

function query(tab){
	if(tab.title=="商业险到期提醒"){
		params={
				isAnnualRemind:1,
				annualStatus:0
		};
		business.load({
			params:params,
			token:token
		});
	}else if(tab.title=="交强险到期提醒"){
		params={
				isInsureRemind:1,
				insureStatus:0
		};
		compulsoryInsurance.load({
			params:params,
			token:token
		});
		
	}else if(tab.title=="驾照年审提醒"){
		params={
				isAnnualRemind:1,
				annualStatus:0
		};
		drivingLicense.load({
			params:params,
			token:token
		});
		
	}else if(tab.title=="车辆年检提醒"){
		params={
				isVeriRemind:1,
				veriStatus:0
		};
		car.load({
			params:params,
			token:token
		});
		
	}else if(tab.title=="客户生日提醒"){
		params={
				isAnnualRemind:1,
				annualStatus:0
		};
		guestBirthday.load({
			params:params,
			token:token
		});
		
	}
}