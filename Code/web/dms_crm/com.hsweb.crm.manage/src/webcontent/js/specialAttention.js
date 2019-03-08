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

    business.on("drawcell", function (e) {
        if (e.field == "annualStatus") {
            if (e.value == 0) {
                e.cellHtml = "未关怀";
            } else {
                e.cellHtml = "已关怀";
            }
        }
    });
    compulsoryInsurance.on("drawcell", function (e) {
        if (e.field == "insureStatus") {
            if (e.value == 0) {
                e.cellHtml = "未关怀";
            } else {
                e.cellHtml = "已关怀";
            }
        }
    });
    drivingLicense.on("drawcell", function (e) {
        if (e.field == "licenseStatus") {
            if (e.value == 0) {
                e.cellHtml = "未关怀";
            } else {
                e.cellHtml = "已关怀";
            }
        }
    });
    car.on("drawcell", function (e) {
        if (e.field == "veriStatus") {
            if (e.value == 0) {
                e.cellHtml = "未关怀";
            } else {
                e.cellHtml = "已关怀";
            }
        }
    });

    guestBirthday.on("drawcell", function (e) {
        if (e.field == "birStatus") {
            if (e.value == 0) {
                e.cellHtml = "未关怀";
            } else {
                e.cellHtml = "已关怀";
            }
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
                annualStatus: 0
            };
            business.load({
                params: params,
                token: token
            });
        } else if (tab.title == "交强险到期提醒") {
            params = {
                isInsureRemind: 1,
                insureStatus: 0
            };
            compulsoryInsurance.load({
                params: params,
                token: token
            });

        } else if (tab.title == "驾照年审提醒") {
            params = {
                isLicenseRemind: 1,
                licenseStatus: 0
            };
            drivingLicense.load({
                params: params,
                token: token
            });

        } else if (tab.title == "车辆年检提醒") {
            params = {
                isVeriRemind: 1,
                veriStatus: 0
            };
            car.load({
                params: params,
                token: token
            });

        } else if (tab.title == "客户生日提醒") {
            params = {
                isBirRemind: 1,
                birStatus: 0
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
    if (tab.title == "商业险到期提醒") {
        sRow = business.getSelected();
        if (sRow != null) {
            sRow.serviceType = 6;
            sRow.sendWcUrl = "";
        }
    } else if (tab.title == "交强险到期提醒") {
        sRow = compulsoryInsurance.getSelected();
        if (sRow != null) {
            sRow.serviceType = 7;
            sRow.sendWcUrl = "";
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
    return sRow||0;
}

