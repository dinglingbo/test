var baseUrl = apiPath + repairApi + "/";
var gridUrl = baseUrl + 'com.hsapi.repair.repairService.guestReport.queryGuestBySql.biz.ext';


var gridkhsr = null; //客户生日
var gridjzns = null; //驾照年审
var gridclnj = null; //车辆年检
var gridbydq = null; //保养到期
var gridjqx = null; //交强险
var gridsyx = null; //商业险
var gridwxgw = null; //维修顾问
var gridxslc = null; //x行驶里程
var gridxfcs = null; //消费次数
var gridxfje = null; //消费金额
var gridlcts = null; //离厂天数
var gridkhlx = null; //客户类型
var tabs = null;

var gType = [{ id: 1, text: "首修客户 (最近一个月的首次消费车辆)" },
    { id: 2, text: "活跃期 (来店至少2次且30天内消费过的车辆)" },
    { id: 3, text: "稳定期 (来店至少2次且31-90天内消费过车辆)" },
    { id: 4, text: "睡眠期 (来店至少1次且离店天数在91-180天内)" },
    { id: 5, text: "流失期 (来店至少1次且离店天数超181天以上)" },
    { id: 6, text: "未分类 (未来过店)" }]

$(document).ready(function (v) {
    tabs = nui.get("tabs1");
    gridkhsr = nui.get("gridkhsr");
    gridjzns = nui.get("gridjzns");
    gridclnj = nui.get("gridclnj");
    gridbydq = nui.get("gridbydq");
    gridjqx = nui.get("gridjqx");
    gridsyx = nui.get("gridsyx");
    gridwxgw = nui.get("gridwxgw");
    gridxslc = nui.get("gridxslc");
    gridxfcs = nui.get("gridxfcs");
    gridxfje = nui.get("gridxfje");
    gridlcts = nui.get("gridlcts");
    gridkhlx = nui.get("gridkhlx");
    gridkhsr.setUrl(gridUrl);
    gridjzns.setUrl(gridUrl);
    gridclnj.setUrl(gridUrl);
    gridbydq.setUrl(gridUrl);
    gridjqx.setUrl(gridUrl);
    gridsyx.setUrl(gridUrl);
    gridwxgw.setUrl(gridUrl);
    gridxslc.setUrl(gridUrl);
    gridxfcs.setUrl(gridUrl);
    gridxfje.setUrl(gridUrl);
    gridlcts.setUrl(gridUrl);
    gridkhlx.setUrl(gridUrl);




    initMember("mta", function () { });
});

 

function queryTab(e) {

}


function search() {
    var params = {};
    var tab = tabs.getActiveTab();
    switch (tab.name) {
        case "bir":
            var dayNum = nui.get("birday");
            if (dayNum.value && dayNum.validate()) {
                params = {
                    tday: dayNum.value,
                    sqlUrl:"com.hsapi.repair.repairService.guestTypeSql.getGuestbyBir"
                };
                gridkhsr.load({
                    params: params,
                    token: token
                });
            } else {
                showMsg("请输入正确天数", "E");
            }
            break;
        case "lic":
            var dayNum = nui.get("license");
            if (dayNum.value && dayNum.validate()) {
                params = {
                    tday: dayNum.value,
                    sqlUrl:"com.hsapi.repair.repairService.guestTypeSql.getGuestbyLicense"
                };
                gridjzns.load({
                    params: params,
                    token: token
                });
            } else {
                showMsg("请输入正确天数", "E");
            }
            break;
            case "due":
            var dayNum = nui.get("due");
            if (dayNum.value && dayNum.validate()) {
                params = {
                    tday: dayNum.value,
                    sqlUrl:"com.hsapi.repair.repairService.guestTypeSql.getGuestbyDue"
                };
                gridclnj.load({
                    params: params,
                    token: token
                });
            } else {
                showMsg("请输入正确天数", "E");
            }
            break;
            case "care":
            var dayNum = nui.get("care");
            if (dayNum.value && dayNum.validate()) {
                params = {
                    tday: dayNum.value,
                    sqlUrl:"com.hsapi.repair.repairService.guestTypeSql.getGuestbyCare"
                };
                gridbydq.load({
                    params: params,
                    token: token
                });
            } else {
                showMsg("请输入正确天数", "E");
            }
            break;
            case "insure":
            var dayNum = nui.get("insure");
            if (dayNum.value && dayNum.validate()) {
                params = {
                    tday: dayNum.value,
                    sqlUrl:"com.hsapi.repair.repairService.guestTypeSql.getGuestbyInsure"
                };
                gridjqx.load({
                    params: params,
                    token: token
                });
            } else {
                showMsg("请输入正确天数", "E");
            }
            break;
            case "annual":
            var dayNum = nui.get("annual");
            if (dayNum.value && dayNum.validate()) {
                params = {
                    tday: dayNum.value,
                    sqlUrl:"com.hsapi.repair.repairService.guestTypeSql.getGuestbyAnnual"
                };
                gridsyx.load({
                    params: params,
                    token: token
                });
            } else {
                showMsg("请输入正确天数", "E");
            }
            break;
            case "mta":
            var dayNum = nui.get("mta");
            if (dayNum.value && dayNum.validate()) {
                params = {
                    mtAdvisorIds: dayNum.value,
                    sqlUrl:"com.hsapi.repair.repairService.guestTypeSql.getGuestbyMtAdvisor"
                };
                gridwxgw.load({
                    params: params,
                    token: token
                });
            } else {
                showMsg("请选择维修顾问", "E");
            }
            break;
            case "kilo":
            var startKilo = nui.get("startKilo");
            var endKilo = nui.get("endKilo");
            if (startKilo.value && startKilo.validate()&&endKilo.value && endKilo.validate()) {
                params = {
                    startKilo: startKilo.value,
                    endKilo: endKilo.value,
                    sqlUrl:"com.hsapi.repair.repairService.guestTypeSql.getGuestbyKilo"
                };
                gridxslc.load({
                    params: params,
                    token: token
                });
            } else {
                showMsg("请输入正确公里数", "E");
            }
            break;
            case "time":
            var startTime = nui.get("startTime");
            var endTime = nui.get("endTime");
            if (startTime.value && startTime.validate()&&endTime.value && endTime.validate()) {
                params = {
                    startTime: startTime.value,
                    endTime: endTime.value,
                    sqlUrl:"com.hsapi.repair.repairService.guestTypeSql.getGuestbyTime"
                };
                gridxfcs.load({
                    params: params,
                    token: token
                });
            } else {
                showMsg("请输入正确的消费次数", "E");
            }
            break; 
            case "amt":
            var startAmt = nui.get("startAmt");
            var endAmt = nui.get("endAmt");
            if (startAmt.value && startAmt.validate()&&endAmt.value && endAmt.validate()) {
                params = {
                    startAmt: startAmt.value,
                    endAmt: endAmt.value,
                    sqlUrl:"com.hsapi.repair.repairService.guestTypeSql.getGuestbyAmt"
                };
                gridxfje.load({
                    params: params,
                    token: token
                });
            } else {
                showMsg("请输入正确的消费金额", "E");
            }
            break;
            case "leave":
            var startDay = nui.get("startDay");
            var endDay = nui.get("endDay");
            if (startDay.value && startDay.validate() && endDay.value && endDay.validate()) {
                params = {
                    startDay: startDay.value,
                    endDay: endDay.value,
                    sqlUrl:"com.hsapi.repair.repairService.guestTypeSql.getGuestbyLeave"
                };
                gridlcts.load({
                    params: params,
                    token: token
                });
            } else {
                showMsg("请输入正确的离厂天数", "E");
            }
            break;
            case "type":
            var type = nui.get("type");
            if (type.value && type.validate()) {
                if (type.value == 1) {
                    params.sqlUrl = "com.hsapi.crm.data.guest.getGuestTypeA";
                } else if (type.value == 2) {
                    params.sqlUrl = "com.hsapi.crm.data.guest.getGuestTypeB";
                } else if (type.value == 3) {
                    params.sqlUrl = "com.hsapi.crm.data.guest.getGuestTypeC";
                } else if (type.value == 4) {
                    params.sqlUrl = "com.hsapi.crm.data.guest.getGuestTypeD";
                } else if (type.value == 5) {
                    params.sqlUrl = "com.hsapi.crm.data.guest.getGuestTypeE";
                } else if (type.value == 6) {
                    params.sqlUrl = "com.hsapi.crm.data.guest.getGuestTypeF";
                }
                gridkhlx.load({
                    params: params,
                    token: token
                });
            } else {
                showMsg("请输入正确的离厂天数", "E");
            }
            break;
        default:
            break;
    }

}