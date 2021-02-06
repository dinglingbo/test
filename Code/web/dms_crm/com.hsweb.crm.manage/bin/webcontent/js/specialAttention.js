var baseUrl = apiPath + repairApi + "/";
var querybusinessUrl = baseUrl + "com.hsapi.repair.repairService.query.querybusiness.biz.ext";
var queryRemindSUrl = baseUrl + "com.hsapi.repair.repairService.query.queryRemindS.biz.ext";
var business = null; //商业险
var compulsoryInsurance = null; //交强险
var drivingLicense = null; //驾照年审
var car = null; //车辆年检提醒
var guestBirthday = null; //客户生日
var serviceType = null; //6商业险到期   7; //交强险到期   8; //驾照到期   9; //车检到期   10; //客户生日  
var params = {};
var tabs = {};
var statusList = [{id:0,name:"未关怀"},{id:1,name:"已关怀"}];
var birthdayTypeList = [{id:0,name:"农历"},{id:1,name:"阴历"}];
$(document).ready(function (v) {
    tabs = nui.get("tabs");
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
    
    initInsureComp("insureCompCode");//保险公司
//    var filter = new HeaderFilter(business, {
//        columns: [
//            { name: 'carModel' },
//            { name: 'annualInspectionCompName' },
//            { name: 'annualStatus' }
//        ],
//        callback: function (column, filtered) {
//        },
//        tranCallBack: function (field) {
//        	var value = null;
//        	switch(field){
//        		case "annualStatus" :
//        			var arr = [];
//        			for (var i in statusList) {
//        			    var o = {};
//        			    o.name = statusList[i].name;
//        			    o.id = statusList[i].id;
//        			    arr.push(o);
//        			}
//        			value = arr;
//        			break;			
//        	}
//        	return value;
//        }
//    });
//    
//    var filter = new HeaderFilter(compulsoryInsurance, {
//        columns: [
//            { name: 'carModel' },
//            { name: 'insureCompName' },
//            { name: 'insureStatus' }
//        ],
//        callback: function (column, filtered) {
//        },
//        tranCallBack: function (field) {
//        	var value = null;
//        	switch(field){
//        		case "insureStatus" :
//        			var arr = [];
//        			for (var i in statusList) {
//        			    var o = {};
//        			    o.name = statusList[i].name;
//        			    o.id = statusList[i].id;
//        			    arr.push(o);
//        			}
//        			value = arr;
//        			break;			
//        	}
//        	return value;
//        }
//    });
//    
//    var filter = new HeaderFilter(drivingLicense, {
//        columns: [
//            { name: 'guestName' },
//            { name: 'licenseStatus' }
//        ],
//        callback: function (column, filtered) {
//        },
//        tranCallBack: function (field) {
//        	var value = null;
//        	switch(field){
//        		case "licenseStatus" :
//        			var arr = [];
//        			for (var i in statusList) {
//        			    var o = {};
//        			    o.name = statusList[i].name;
//        			    o.id = statusList[i].id;
//        			    arr.push(o);
//        			}
//        			value = arr;
//        			break;			
//        	}
//        	return value;
//        }
//    });
//    
//    var filter = new HeaderFilter(car, {
//        columns: [
//            { name: 'veriStatus' },
//            { name: 'carModel' }
//        ],
//        callback: function (column, filtered) {
//        },
//        tranCallBack: function (field) {
//        	var value = null;
//        	switch(field){
//        		case "veriStatus" :
//        			var arr = [];
//        			for (var i in statusList) {
//        			    var o = {};
//        			    o.name = statusList[i].name;
//        			    o.id = statusList[i].id;
//        			    arr.push(o);
//        			}
//        			value = arr;
//        			break;			
//        	}
//        	return value;
//        }
//    });
    
//    var filter = new HeaderFilter(guestBirthday, {
//        columns: [
//            { name: 'guestName' },
//            { name: 'birthdayType' },
//            { name: 'birStatus' }
//        ],
//        callback: function (column, filtered) {
//        },
//        tranCallBack: function (field) {
//        	var value = null;
//        	switch(field){
//        		case "birStatus" :
//        			var arr = [];
//        			for (var i in statusList) {
//        			    var o = {};
//        			    o.name = statusList[i].name;
//        			    o.id = statusList[i].id;
//        			    arr.push(o);
//        			}
//        			value = arr;
//        			break;	
//        		case "birthdayType" :
//        			var arr = [];
//        			for (var i in birthdayTypeList) {
//        			    var o = {};
//        			    o.name = birthdayTypeList[i].name;
//        			    o.id = birthdayTypeList[i].id;
//        			    arr.push(o);
//        			}
//        			value = arr;
//        			break;	
//        	}
//        	return value;
//        }
//    });
//    
    
    business.on("select", function (e) {
//        visitHistoryList(e.record);
        isButtonEnable(e.record.wechatOpenId, tabs.getActiveTab());
        $("#showMonile").show();
        document.getElementById("mobileText").innerHTML = e.record.mobile;
    }); 
    compulsoryInsurance.on("select", function (e) {
//        visitHistoryList(e.record);
        isButtonEnable(e.record.wechatOpenId, tabs.getActiveTab());
        $("#showMonile2").show();
        document.getElementById("mobileText2").innerHTML = e.record.mobile;
    }); 
    drivingLicense.on("select", function (e) {
//        visitHistoryList(e.record);
        isButtonEnable(e.record.wechatOpenId, tabs.getActiveTab());
        $("#showMonile3").show();
        document.getElementById("mobileText3").innerHTML = e.record.mobile;
    }); 
    car.on("select", function (e) {
//        visitHistoryList(e.record); 
        isButtonEnable(e.record.wechatOpenId, tabs.getActiveTab());
        $("#showMonile4").show();
        document.getElementById("mobileText4").innerHTML = e.record.mobile;
    }); 
    guestBirthday.on("select", function (e) {
//        visitHistoryList(e.record);
        isButtonEnable(e.record.wechatOpenId, tabs.getActiveTab());
        $("#showMonile5").show();
        document.getElementById("mobileText5").innerHTML = e.record.mobile;
    }); 

    business.on("drawcell", function (e) {
    	if (e.field == "mobile") {
            e.cellHtml = changedTel(e);
        }else if (e.field == "annualInspectionCompCode") {
            e.cellHtml = setColVal('insureCompCode', 'code', 'fullName', e.value);
        }
    });
    compulsoryInsurance.on("drawcell", function (e) {
    	if (e.field == "mobile") {
            e.cellHtml = changedTel(e);
        }else if (e.field == "insureCompCode") {
            e.cellHtml = setColVal('insureCompCode', 'code', 'fullName', e.value);
        }
    });
    drivingLicense.on("drawcell", function (e) {
    	if (e.field == "mobile") {
            e.cellHtml = changedTel(e);
        }
    });
    car.on("drawcell", function (e) {
    	if (e.field == "mobile") {
            e.cellHtml = changedTel(e);
        }
    });

    guestBirthday.on("drawcell", function (e) {
    	if (e.field == "mobile") {
            e.cellHtml = changedTel(e);
        }
        if (e.field == "birthdayType") {
            if (e.value == 0) {
                e.cellHtml = "农历";
            } else {
                e.cellHtml = "阴历";
            }
        }
    });
});

function changedTel(e) {
    var uid = e.record._uid;
    var value = e.value
    var res = {};
    value = "" + value;
    var reg=/(\d{3})\d{4}(\d{4})/;
    value = value.replace(reg, "$1****$2");
    if(e.value){
        if(e.record.wechatOpenId){
            res =  '<a href="javascript:bindWechat(\'' + uid + '\')" id="showA" ><span id="wechatTag" class="fa fa-wechat fa-lg"></span></a>&nbsp;'+value;
                /*e.cellHtml = "<span id='wechatTag' class='fa fa-wechat fa-lg'></span>"+value;*/
        }else{
            res =  '<a href="javascript:bindWechat(\'' + uid + '\')" id="showA1" ><span id="wechatTag1" class="fa fa-wechat fa-lg"></span></a>&nbsp;'+value;
        }
    }else{
        res="";
    }
    return res;
}

function setInitData(params) {
    var params = {};
    var tab = tabs.getTab(params.id - 1);
    tabs.activeTab(tabs.getTab(params.id - 1));
    query(tab);
}

function change(e) {
    var tab = tabs.getActiveTab();
    query(tab);

}

function query(tab) {
    if (tab) {
        if (tab.title == "商业险到期提醒") {
            params = {
                isAnnualRemind: 1,
                annualStatus: 0,
                startDate:nui.get('startDate').getFormValue(),
                endDate: nui.get('endDate').getFormValue(),
                dateType:'syx'
            };
            business.load({
                params: params,
                token: token
            });
        } else if (tab.title == "交强险到期提醒") {
            params = {
                isInsureRemind: 1,
                insureStatus: 0,
                startDate:nui.get('startDate2').getFormValue(),
                endDate: nui.get('endDate2').getFormValue(),
                dateType:'jqx'
            };
            compulsoryInsurance.load({
                params: params,
                token: token
            });

        } else if (tab.title == "驾照年审提醒") {
            params = {
                isLicenseRemind: 1,
                licenseStatus: 0,
                startDate:nui.get('startDate3').getFormValue(),
                endDate: nui.get('endDate3').getFormValue(),
                dateType:'jzns'
            };
            drivingLicense.load({
                params: params,
                token: token
            });

        } else if (tab.title == "车辆年检提醒") {
            params = {
                isVeriRemind: 1,
                veriStatus: 0,
                startDate:nui.get('startDate4').getFormValue(),
                endDate: nui.get('endDate4').getFormValue(),
                dateType:'clnj'
            };
            car.load({
                params: params,
                token: token
            });

        } else if (tab.title == "客户生日提醒") {
            params = {
                isBirRemind: 1,
                birStatus: 0,
//                tday:nui.get("bir").value,
//                dateType:'khsr'
            };
            guestBirthday.load({
                params: params,
                token: token
            });

        }
    }
}

function setInitData(params) {
    if (params.id == '' || params.id == null) {
        tabs.activeTab(0);
    } else if (isNaN(params.id) == true) {
        tabs.activeTab(0);
    } else {
        tabs.activeTab(tabs.getTab(params.id - 1 - 2));
    }
}

function remind() {
    var row = getRow();
    if (row) {
        mini.open({
            url: webPath + contextPath + "/manage/maintainRemind/maintainRemMainDetail.jsp?token=" + token,
            title: "提醒信息",
            width: 600,
            height: 300,
            onload: function () {
                var iframe = this.getIFrameEl();
                iframe.contentWindow.setData(row);
            },
            ondestroy: function (action) {
                change();
            }
        });
    } else {
        showMsg("请选中一条数据", "W");
    }
}

function sendInfo(){
    var row = getRow();
    if (!row) {
        showMsg("请选中一条数据","W");
        return;
    }
    nui.open({
        url: webPath + contextPath  + "/com.hsweb.crm.manage.sendInfo.flow?token="+token,
        title: "发送短信", width: 655, height: 280,
        onload: function () {
        var iframe = this.getIFrameEl();
        iframe.contentWindow.setData(row);
    },
    ondestroy: function (action) {
            //重新加载
            //query(tab);
        change();
        }
    });
}

function sendWcText(){//发送微信消息
    var row = getRow();
    
    if (!row) {
    showMsg("请选中一条数据","W");
    return;
    }
    // var tit = "发送微信[" + row.guestName + '/' + row.mobile + '/' + row.carModel + ']';
    var tit = "发送微信";
    nui.open({
        url: webPath + contextPath  + "/"+row.sendWcUrl+"?token="+token,
        title: tit, width: 800, height: 350,
        onload: function () {
        var iframe = this.getIFrameEl();
        iframe.contentWindow.setData(row);
    },
    ondestroy: function (action) {
            //重新加载 
            // query(tab);
            change();
        }
    });
}



function sendWcCoupon() {
    var row = getRow();
    row.userNickname = row.guestName;
    row.userMarke = row.wechatServiceId;
    row.storeName = currOrgName;
    row.userOpid = row.wechatOpenId;
    var list = [];
    list.push(row);

    nui.open({                        
        url: webPath + contextPath  + "/manage/sendWechatWindow/sWcInfoCoupon.jsp?token="+token,
        title: "发送卡券", width: 800, height: 350,
        onload: function () {
        var iframe = this.getIFrameEl();
        iframe.contentWindow.setData(list);
    },
    ondestroy: function (action) {
            //重新加载
            //query(tab);
        }
    });
}


function getRow() {
    var sRow = {};
    var tab = tabs.getActiveTab();
    if (tab.title == "商业险到期提醒") {
        sRow = business.getSelected();
        if (sRow != null) {
            sRow.serviceType = 6;
            sRow.sendWcUrl = "manage/sendWechatWindow/sWcInfoInsurces.jsp";
        }
    } else if (tab.title == "交强险到期提醒") {
        sRow = compulsoryInsurance.getSelected();
        if (sRow != null) {
            sRow.serviceType = 7;
            sRow.sendWcUrl = "manage/sendWechatWindow/sWcInfoInsurces.jsp";
        }
    } else if (tab.title == "驾照年审提醒") {
        sRow = drivingLicense.getSelected();
        if (sRow != null) {
            sRow.serviceType = 8;
            sRow.sendWcUrl = 'manage/sendWechatWindow/sWcInfoLicense.jsp'
        }
    } else if (tab.title == "车辆年检提醒") {
        sRow = car.getSelected();
        if (sRow != null) {
            sRow.serviceType = 9;
            sRow.sendWcUrl = "manage/sendWechatWindow/sWcYearCheck.jsp";
        }
    } else if (tab.title == "客户生日提醒") {
        sRow = guestBirthday.getSelected();
        if (sRow != null) {
            sRow.serviceType = 10;
            sRow.sendWcUrl = "";
        }
    }
    sRow.guestSource = 0;
    return sRow||0;
}


function quickSearch(type,gridType) {
    var params = {};
    var queryname = "本日";
    switch (type) {
        case 0:
            params.today = 1;
            params.startDate = getNowStartDate();
            params.endDate = addDate(getNowEndDate(), 1);
            queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.startDate = getPrevStartDate();
            params.endDate = addDate(getPrevEndDate(), 1);
            queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.startDate = getWeekStartDate();
            params.endDate = addDate(getWeekEndDate(), 1);
            queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.startDate = getLastWeekStartDate();
            params.endDate = addDate(getLastWeekEndDate(), 1);
            queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.startDate = getMonthStartDate();
            params.endDate = addDate(getMonthEndDate(), 1);
            queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.startDate = getLastMonthStartDate();
            params.endDate = addDate(getLastMonthEndDate(), 1);
            queryname = "上月";
            break;

        case 10:
            params.thisYear = 1;
            params.startDate = getYearStartDate();
            params.endDate = getYearEndDate();
            queryname = "本年";
            break;
        case 11:
            params.lastYear = 1;
            params.startDate = getPrevYearStartDate();
            params.endDate = getPrevYearEndDate();
            queryname = "上年";
            break;
        default:
            break;
    }
    switch (gridType) {
        case 'syx'://商业险
            var menunamedate = nui.get("menunamedate");
            var startDateEl = nui.get("startDate");
            var endDateEl = nui.get("endDate");
            startDateEl.setValue(params.startDate);
            endDateEl.setValue(addDate(params.endDate, -1));
            menunamedate.setText(queryname);
            params.isAnnualRemind = 1;
            params.annualStatus = 0;
            params.dateType = gridType;
            params.endDate = addDate(params.endDate, -1);
            business.load({params:params});
            break;
            case 'jqx'://交强险
            var menunamedate2 = nui.get("menunamedate2");
            var startDateEl2 = nui.get("startDate2");
            var endDateEl2 = nui.get("endDate2");
            startDateEl2.setValue(params.startDate);
            endDateEl2.setValue(addDate(params.endDate, -1));
            menunamedate2.setText(queryname);
            params.isInsureRemind = 1;
            params.insureStatus = 0;
            params.dateType = gridType;
            params.endDate = addDate(params.endDate, -1);
            compulsoryInsurance.load({params:params});
            break;
            case 'jzns'://驾照年审
            var menunamedate3 = nui.get("menunamedate3");
            var startDateEl3 = nui.get("startDate3");
            var endDateEl3 = nui.get("endDate3");
            startDateEl3.setValue(params.startDate);
            endDateEl3.setValue(addDate(params.endDate, -1));
            menunamedate3.setText(queryname);
            params.isLicenseRemind = 1;
            params.licenseStatus = 0;
            params.dateType = gridType;
            params.endDate = addDate(params.endDate, -1);
            drivingLicense.load({params:params});
            break;
            case 'clnj'://车辆年检 
            var menunamedate4 = nui.get("menunamedate4");
            var startDateEl4 = nui.get("startDate4");
            var endDateEl4 = nui.get("endDate4");
            startDateEl4.setValue(params.startDate);
            endDateEl4.setValue(addDate(params.endDate, -1));
            menunamedate4.setText(queryname);
            params.isVeriRemind = 1;
            params.veriStatus = 0;
            params.dateType = gridType;
            params.endDate = addDate(params.endDate, -1);
            car.load({params:params});
            break;
            case 'khsr'://客户生日
            params.isBirRemind = 1;
            params.birStatus = 0;
//            params.tday = nui.gfet("bir").value;
//            params.dateType = gridType;
            guestBirthday.load({params:params});
            break;
        default:
            break;
    }

}



function isButtonEnable(openId,tab) {
    if (openId) {
    	if(tab.name == 'syx'){
            nui.get("wcBtn13").enable();
            nui.get("wcBtn14").enable();
            nui.get("wcBtn12").enable();
        }else if(tab.name == 'jqx'){
            nui.get("wcBtn23").enable();
            nui.get("wcBtn24").enable();
            nui.get("wcBtn22").enable();
        }else if(tab.name == 'jzns'){
            nui.get("wcBtn33").enable();
            nui.get("wcBtn34").enable();
            nui.get("wcBtn32").enable();
        }else if(tab.name == 'clnj'){
            nui.get("wcBtn43").enable();
            nui.get("wcBtn44").enable();
            nui.get("wcBtn42").enable();
        }else if(tab.name == 'khsr'){
            nui.get("wcBtn53").enable();
            nui.get("wcBtn54").enable();
            nui.get("wcBtn52").enable();
        }
    } else {
        if(tab.name == 'syx'){
            nui.get("wcBtn13").disable();
            nui.get("wcBtn14").disable();
            nui.get("wcBtn12").disable();
        }else if(tab.name == 'jqx'){
            nui.get("wcBtn23").disable();
            nui.get("wcBtn24").disable();
            nui.get("wcBtn22").disable();
        }else if(tab.name == 'jzns'){
            nui.get("wcBtn33").disable();
            nui.get("wcBtn34").disable();
            nui.get("wcBtn32").disable();
        }else if(tab.name == 'clnj'){
            nui.get("wcBtn43").disable();
            nui.get("wcBtn44").disable();
            nui.get("wcBtn42").disable();
        }else if(tab.name == 'khsr'){
            nui.get("wcBtn53").disable();
            nui.get("wcBtn54").disable();
            nui.get("wcBtn52").disable();
        }
    }
}



