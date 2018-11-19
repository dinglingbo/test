var baseUrl = apiPath + repairApi + "/";
var querybusinessUrl = baseUrl+"com.hsapi.repair.repairService.query.querybusiness.biz.ext";
var queryRemindSUrl = baseUrl+"com.hsapi.repair.repairService.query.queryRemindS.biz.ext";
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
	drivingLicense.setUrl(queryRemindSUrl);
	car.setUrl(querybusinessUrl);
	guestBirthday.setUrl(queryRemindSUrl);
	

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
                e.cellHtml = "未关怀";
            }else{
                e.cellHtml = "已关怀";
            }
         }
     });
	drivingLicense.on("drawcell", function (e) {
        if(e.field == "licenseStatus"){
            if(e.value == 0){
                e.cellHtml = "未关怀";
            }else{
                e.cellHtml = "已关怀";
            }
         }
     });
	car.on("drawcell", function (e) {
        if(e.field == "readSign"){
            if(e.value == 0){
                e.cellHtml = "未关怀";
            }else{
                e.cellHtml = "已关怀";
            }
         }
     });

	guestBirthday.on("drawcell", function (e) {
        if(e.field == "birStatus"){
            if(e.value == 0){
                e.cellHtml = "未关怀";
            }else{
                e.cellHtml = "已关怀";
            }
         }
    if(e.field == "birthdayType"){
        if(e.value == 0){
            e.cellHtml = "农历";
        }else{
            e.cellHtml = "阴历";
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
				isLicenseRemind:1,
				licenseStatus:0
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
				isBirRemind:1,
				birStatus:0
		};
		guestBirthday.load({
			params:params,
			token:token
		});
		
	}
}

function Care(){
	var rows ;
	var type=0;//醒类型(1保养提醒；2商业险提醒；3交强险提醒；4年检提醒；5客户生日提醒；6驾照年审提醒)
	var tabs = nui.get("tabs");
	var tab = tabs.getActiveTab();
	if(tab.title=="商业险到期提醒"){
		rows = business.getSelecteds();
		type =2;
	}else if(tab.title=="交强险到期提醒"){
		rows = compulsoryInsurance.getSelecteds();	
		type =3;
	}else if(tab.title=="驾照年审提醒"){
		rows = drivingLicense.getSelecteds();
		type =6;
	}else if(tab.title=="车辆年检提醒"){
		rows = car.getSelecteds();	
		type =4;
	}else if(tab.title=="客户生日提醒"){
		rows = guestBirthday.getSelecteds();
		type =5;
	}

	if(rows.length==0){
		showMsg("请先选择记录","W");
		return;
	}
    nui.open({
        url: webPath + contextPath  + "/com.hsweb.crm.manage.Care.flow?token="+token,
        title: "关怀内容", width: 655, height: 386,
        onload: function () {
        	var iframe = this.getIFrameEl();
        	iframe.contentWindow.setData(rows,type);
        },
        ondestroy: function (action) {
        	//重新加载
        	query(tab);
        }
    });
}

function setInitData(params){
	var tab = nui.get("tabs");
	tab.activeTab (tab.getTab ( params.id-1-2 ) );

	
	
}