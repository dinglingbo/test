var baseUrl = apiPath + repairApi + "/";
var queryRemindSUrl = baseUrl + "com.hsapi.repair.repairService.query.queryRemindByDate.biz.ext";
var hisUrl = apiPath + crmApi+ "/com.hsapi.crm.svr.visit.queryCrmVisitRecordSql.biz.ext";
var reminding = null; //保养提醒
var business = null; //商业险
var compulsoryInsurance = null; //交强险
var drivingLicense = null; //驾照年审
var car = null; //车辆年检提醒
var guestBirthday = null; //客户生日
var visitHis = null; //回放历史
var serviceType = null; //5保养提醒 //6商业险到期   7; //交强险到期   8; //驾照到期   9; //车检到期   10; //客户生日  
var params = {};
var tabs = {};
var serviceTypeList = [{},{ id: 1, text: '电销' }, { id: 2, text: '预约' }, { id: 3, text: '客户回访' }, { id: 4, text: '流失回访' }, { id: 5, text: '保养提醒' }, { id: 6, text: '商业险到期' }, { id: 7, text: '交强险到期' }, { id: 8, text: '驾照年审' }, { id: 9, text: '车辆年检' }, { id: 1, text: '生日' }];

$(document).ready(function (v) {
    tabs = nui.get("tabs");
    reminding = nui.get("reminding");
    business = nui.get("business");
    compulsoryInsurance = nui.get("compulsoryInsurance");
    drivingLicense = nui.get("drivingLicense");
    car = nui.get("car");
    guestBirthday = nui.get("guestBirthday"); 
    visitHis = nui.get("visitHis"); 

    reminding.setUrl(queryRemindSUrl);
    business.setUrl(queryRemindSUrl);
    compulsoryInsurance.setUrl(queryRemindSUrl);
    drivingLicense.setUrl(queryRemindSUrl);
    car.setUrl(queryRemindSUrl);
    guestBirthday.setUrl(queryRemindSUrl);
    visitHis.setUrl(hisUrl);

    var startTime =new Date();
    var today = nui.formatDate(startTime, 'yyyy-MM-dd');

    var tday = new Date(startTime);
    tday.setDate(tday.getDate() + 30);
    var thirdty = nui.formatDate(new Date(tday), 'yyyy-MM-dd');
    nui.get('startDate0').setValue(today);
    nui.get('startDate').setValue(today);
    nui.get('startDate2').setValue(today);
    nui.get('startDate3').setValue(today);
    nui.get('startDate4').setValue(today);
    nui.get('endDate0').setValue(thirdty);
    nui.get('endDate').setValue(thirdty);
    nui.get('endDate2').setValue(thirdty); 
    nui.get('endDate3').setValue(thirdty);
    nui.get('endDate4').setValue(thirdty);

    initDicts({
        visitMode: "DDT20130703000021",//跟踪方式
        // visitStatus: "DDT20130703000081",//跟踪状态
        //query_visitStatus: "DDT20130703000081",//跟踪状态
        //artType: "DDT20130725000001"//话术类型        
    });


    reminding.on("select", function (e) {
        loadVisitHis(e.record.conId);
        isButtonEnable(e.record.wechatOpenId, tabs.getActiveTab());
     
    }); 
    business.on("select", function (e) {
        loadVisitHis(e.record.conId);
        isButtonEnable(e.record.wechatOpenId, tabs.getActiveTab());
    }); 
    compulsoryInsurance.on("select", function (e) {
        loadVisitHis(e.record.conId);
        isButtonEnable(e.record.wechatOpenId, tabs.getActiveTab());
    }); 
    drivingLicense.on("select", function (e) {
        loadVisitHis(e.record.conId);
        isButtonEnable(e.record.wechatOpenId, tabs.getActiveTab());
    }); 
    car.on("select", function (e) {
        loadVisitHis(e.record.conId);
        isButtonEnable(e.record.wechatOpenId, tabs.getActiveTab());
    }); 
    guestBirthday.on("select", function (e) {
        loadVisitHis(e.record.conId);
        isButtonEnable(e.record.wechatOpenId, tabs.getActiveTab());
    }); 

    reminding.on("drawcell", function (e) {
        if (e.field == "mobile") {
            e.cellHtml = changedTel(e);
        } else if (e.field == 'guestType') {
            if (e.value == 'ZS') {
                e.cellHtml = '系统客户';
            } else {
                e.cellHtml = '电销客户';
            }
        }
    });
    business.on("drawcell", function (e) {
        if (e.field == "mobile") {
            e.cellHtml = changedTel(e);
        } else if (e.field == 'guestType') {
            if (e.value == 'ZS') {
                e.cellHtml = '系统客户';
            } else {
                e.cellHtml = '电销客户';
            }
        }
    });
    compulsoryInsurance.on("drawcell", function (e) {
        if (e.field == "mobile") {
            e.cellHtml = changedTel(e);
        } else if (e.field == 'guestType') {
            if (e.value == 'ZS') {
                e.cellHtml = '系统客户';
            } else {
                e.cellHtml = '电销客户';
            }
        }
    });
    drivingLicense.on("drawcell", function (e) {
        if (e.field == "mobile") {
            e.cellHtml = changedTel(e);
        } else if (e.field == 'guestType') {
            if (e.value == 'ZS') {
                e.cellHtml = '系统客户';
            } else {
                e.cellHtml = '电销客户';
            }
        }
    });
    car.on("drawcell", function (e) {
        if (e.field == "mobile") {
            e.cellHtml = changedTel(e);
        } else if (e.field == 'guestType') {
            if (e.value == 'ZS') {
                e.cellHtml = '系统客户';
            } else {
                e.cellHtml = '电销客户';
            }
        }
    });
    guestBirthday.on("drawcell", function (e) {
        if (e.field == "mobile") {
            e.cellHtml = changedTel(e);
        } else if (e.field == 'guestType') {
            if (e.value == 'ZS') {
                e.cellHtml = '系统客户';
            } else {
                e.cellHtml = '电销客户';
            }
        }
    });
    visitHis.on("drawcell", function (e) {
        if (e.field == "serviceType") {
            e.cellHtml = serviceTypeList[e.value].text;
        } else if(e.field == "visitMode"){//跟踪方式
            e.cellHtml = setColVal('visitMode', 'customid', 'name', e.value);
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

function loadVisitHis(guestId) {
    var params = {
        token: token,
        guestId:guestId
    }
    visitHis.load({ params: params });
}

function isButtonEnable(openId,tab) {
    if (openId) {
        if (tab.name == 'bytx') {
            nui.get("wcBtn13").enable();
            nui.get("wcBtn14").enable();
            nui.get("wcBtn15").enable();
        } else if(tab.name == 'syx'){
            nui.get("wcBtn23").enable();
            nui.get("wcBtn24").enable();
            nui.get("wcBtn25").enable();
        }else if(tab.name == 'jqx'){
            nui.get("wcBtn33").enable();
            nui.get("wcBtn34").enable();
            nui.get("wcBtn35").enable();
        }else if(tab.name == 'jzns'){
            nui.get("wcBtn43").enable();
            nui.get("wcBtn44").enable();
            nui.get("wcBtn45").enable();
        }else if(tab.name == 'clnj'){
            nui.get("wcBtn53").enable();
            nui.get("wcBtn54").enable();
            nui.get("wcBtn55").enable();
        }else if(tab.name == 'khsr'){
            nui.get("wcBtn63").enable();
            nui.get("wcBtn64").enable();
            nui.get("wcBtn65").enable();
        }
    } else {
        if (tab.name == 'bytx') {
            nui.get("wcBtn13").disable();
            nui.get("wcBtn14").disable();
            nui.get("wcBtn15").disable();
        } else if(tab.name == 'syx'){
            nui.get("wcBtn23").disable();
            nui.get("wcBtn24").disable();
            nui.get("wcBtn25").disable();
        }else if(tab.name == 'jqx'){
            nui.get("wcBtn33").disable();
            nui.get("wcBtn34").disable();
            nui.get("wcBtn35").disable();
        }else if(tab.name == 'jzns'){
            nui.get("wcBtn43").disable();
            nui.get("wcBtn44").disable();
            nui.get("wcBtn45").disable();
        }else if(tab.name == 'clnj'){
            nui.get("wcBtn53").disable();
            nui.get("wcBtn54").disable();
            nui.get("wcBtn55").disable();
        }else if(tab.name == 'khsr'){
            nui.get("wcBtn63").disable();
            nui.get("wcBtn64").disable();
            nui.get("wcBtn65").disable();
        }
    }
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
        if (tab.title == "保养提醒") {
            params = {
                startDate:nui.get('startDate0').getFormValue(),
                endDate: nui.get('endDate0').getFormValue(),
                dateType:'bytx'
            };
            reminding.load({
                params: params,
                token: token
            });
        }else if (tab.title == "商业险到期提醒") {
            params = {
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
                bir:nui.get('bir').value,
                dateType:'khsr'
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


function getRow() {
    var sRow = {};
    var tab = tabs.getActiveTab();
    if (tab.name == "bytx") {
        sRow = reminding.getSelected();
        if (sRow != null) {
            sRow.serviceType = 5;
            sRow.sendWcUrl = "com.hsweb.crm.manage.sWcInfoRemind.flow";
            sRow.updateDate = sRow.careDueDate;//修改日期页面用
        }
    } else if (tab.name == "syx") {
        sRow = business.getSelected();
        if (sRow != null) {
            sRow.serviceType = 6;
            sRow.sendWcUrl = "manage/sendWechatWindow/sWcInfoInsurces.jsp";
            sRow.updateDate = sRow.annualInspectionDate;//修改日期页面用
        }
    } else if (tab.name == "jqx") {
        sRow = compulsoryInsurance.getSelected();
        if (sRow != null) {
            sRow.serviceType = 7;
            sRow.sendWcUrl = "manage/sendWechatWindow/sWcInfoInsurces.jsp";
            sRow.updateDate = sRow.insureDueDate;//修改日期页面用
        }
    } else if (tab.name == "jzns") {
        sRow = drivingLicense.getSelected();
        if (sRow != null) {
            sRow.serviceType = 8;
            sRow.sendWcUrl = 'manage/sendWechatWindow/sWcInfoLicense.jsp'
            sRow.updateDate = sRow.licenseOverDate;//修改日期页面用
        }
    } else if (tab.name == "clnj") {
        sRow = car.getSelected();
        if (sRow != null) {
            sRow.serviceType = 9;
            sRow.sendWcUrl = "manage/sendWechatWindow/sWcYearCheck.jsp";
            sRow.updateDate = sRow.dueDate;//修改日期页面用
        }
    } else if (tab.name == "khsr") {
        sRow = guestBirthday.getSelected();
        if (sRow != null) {
            sRow.serviceType = 10;
            sRow.sendWcUrl = "";
            sRow.updateDate = sRow.birthday;//修改日期页面用
        }
    }
    sRow.title = tab.title;
    sRow.name = sRow.guestName;//发送微信界面用到
    sRow.guestId = sRow.conId;//电话回访界面用到
    sRow.annualVerificationDueDate = sRow.dueDate;//车辆年检发送微信界面用到

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
        case 'bytx'://保养提醒
        var menunamedate0 = nui.get("menunamedate0");
        var startDateEl0 = nui.get("startDate0");
        var endDateEl0 = nui.get("endDate0");
        startDateEl0.setValue(params.startDate);
        endDateEl0.setValue(addDate(params.endDate, -1));
        menunamedate0.setText(queryname);
        params.isNeedRemind = 1;
        params.remindStatus = 0;
        params.dateType = gridType;
        business.load({params:params});
        break;
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
            car.load({params:params});
            break;
            case 'khsr'://客户生日
            params.isBirRemind = 1;
            params.birStatus = 0;
            params.bir = nui.get("bir").value;
            params.dateType = gridType;
            guestBirthday.load({params:params});
            break;
        default:
            break;
    }

}

function updateDate() {
    var row = getRow();
    if(row){
        var tit = '修改 '+row.title+'日期';
        nui.open({
            url: webPath + contextPath + "/manage/maintainRemind/updateGuestDate.jsp?token="+token,
            title: tit, width: 350, height: 370,
            onload: function () {
                var iframe = this.getIFrameEl();
                iframe.contentWindow.setData(row);
            },
            ondestroy: function (action) {
                gridReload(row.serviceType);
            }
        });
    } else {
        showMsg("请选中一条数据", "W");
    }
}

function gridReload(e) {
    if (e == 5) {
        reminding.reload();
    } else if(e == 6){
        business.reload();
    } else if(e == 7){
        compulsoryInsurance.reload();
    } else if(e == 8){
        drivingLicense.reload();
    } else if(e == 9){
        car.reload();
    } else if(e == 10){
        guestBirthday.reload();
    }
}
