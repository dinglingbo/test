var baseUrl = apiPath + repairApi + "/";
var gridUrl = baseUrl + 'com.hsapi.repair.repairService.guestReport.queryGuestBySql.biz.ext';
var modelUrl = baseUrl + 'com.hsapi.repair.common.svr.queryCarBrandSeriesTree.biz.ext';


var form = null; //
var gridkhsr = null; //客户生日
var gridjzns = null; //驾照年审
var gridclnj = null; //车辆年检
var gridbydq = null; //保养到期
var gridjqx = null; //交强险
var gridsyx = null; //商业险
var gridkhlx = null; //客户类型
var cbrand = null; //车辆品牌
var cmodel = null; //车辆车系

var tabs = null;
var levelList = [];  
var levelHash = [];

var gType = [{ id: 1, text: "首修客户 (最近一个月的首次消费车辆)" },
{ id: 2, text: "活跃期 (来店至少2次且30天内消费过的车辆)" },
{ id: 3, text: "稳定期 (来店至少2次且31-90天内消费过车辆)" },
{ id: 4, text: "睡眠期 (来店至少1次且离店天数在91-180天内)" },
{ id: 5, text: "流失期 (来店至少1次且离店天数181天及以上)" },
{ id: 6, text: "未分类 (未来过店)" }];

$(document).ready(function (v) {
    tabs = nui.get("tabs1");
    form = new nui.Form("#form1");
    gridkhsr = nui.get("gridkhsr");
    gridjzns = nui.get("gridjzns");
    gridclnj = nui.get("gridclnj");
    gridbydq = nui.get("gridbydq");
    gridjqx = nui.get("gridjqx");
    gridsyx = nui.get("gridsyx");
   
    gridkhlx = nui.get("gridkhlx");
    cbrand = nui.get("cbrand");
    cmodel = nui.get("cmodel");
    gridkhsr.setUrl(gridUrl);
    gridjzns.setUrl(gridUrl);
    gridclnj.setUrl(gridUrl);
    gridbydq.setUrl(gridUrl);
    gridjqx.setUrl(gridUrl);
    gridsyx.setUrl(gridUrl);
    gridkhlx.setUrl(gridUrl);
    cbrand.setUrl(modelUrl);
  
    gridkhlx.on("drawcell", function (e) {
        if (e.field == "tgrade") {
            e.cellHtml = (levelHash[e.value] == undefined ? "" : levelHash[e.value].name);
        } else if (e.field == "mobile") { 
            e.cellHtml = changedTel(e);
        }
    });

    gridkhsr.on("drawcell", function (e) {
        if (e.field == "mobile") { 
            e.cellHtml = changedTel(e);
        }
    });
    
    gridjzns.on("drawcell", function (e) {
        if (e.field == "mobile") { 
            e.cellHtml = changedTel(e);
        }
    });
    gridclnj.on("drawcell", function (e) {
        if (e.field == "mobile") { 
            e.cellHtml = changedTel(e);
        }
    });
    gridbydq.on("drawcell", function (e) {
        if (e.field == "mobile") { 
            e.cellHtml = changedTel(e);
        }
    });
    gridsyx.on("drawcell", function (e) {
        if (e.field == "mobile") { 
            e.cellHtml = changedTel(e);
        }
    });
    gridjqx.on("drawcell", function (e) {
        if (e.field == "mobile") { 
            e.cellHtml = changedTel(e);
        }
    });
    

    initGuestType("level", function (data) {
        levelList = nui.get("level").getData();
        levelList.forEach(function(v) {
	        levelHash[v.id] = v;
	    });//客户级别 
    });
    initMember("mta", function () { });//维修顾问
});



function queryTab(e) {
 
}


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

function onBrandChanged(e) {
    var id = cbrand.getValue();
    var mUrl = null;
    
    if(id){
        mUrl = modelUrl + "?nodeId=" + id;
        cmodel.setUrl(mUrl);
    }
}

function onCloseClick(e) {
    var obj = e.sender;
    obj.setText("");
    obj.setValue("");
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
            case "type":
            if (form.validate()) {
                var type = nui.get("type");
                params = form.getData();
                if (type.value == 1) {
                    params.sqlUrl = "com.hsapi.repair.repairService.guestTypeSql.getGuestTypeA";
                } else if (type.value == 2) {
                    params.sqlUrl = "com.hsapi.repair.repairService.guestTypeSql.getGuestTypeB";
                } else if (type.value == 3) {
                    params.sqlUrl = "com.hsapi.repair.repairService.guestTypeSql.getGuestTypeC";
                } else if (type.value == 4) {
                    params.sqlUrl = "com.hsapi.repair.repairService.guestTypeSql.getGuestTypeD";
                } else if (type.value == 5) {
                    params.sqlUrl = "com.hsapi.repair.repairService.guestTypeSql.getGuestTypeE";
                } else if (type.value == 6) {
                    params.sqlUrl = "com.hsapi.repair.repairService.guestTypeSql.getGuestTypeF";
                } else {
                    params.sqlUrl = "com.hsapi.repair.repairService.guestTypeSql.getGuestTypeG";
                }
                if (params.cmodel) {
                    params.cbrand = "";
                    params.cmodel = params.cmodel.replace(/\,/g,"|");
                }
                gridkhlx.load({
                    params: params, 
                    token: token
                });
            } else {
                showMsg("请填写正确内容", "E");
            }
            break;
           
        default:
            break;
    }

}


function sendInfoWin(list){
    if (list.length < 1) {
        showMsg("客户列表为空","E");
        return;
    }
    nui.open({
        url: webPath + contextPath  + "/com.hsweb.crm.manage.sendInfoMore.flow?token="+token,
        title: "发送短信", width: 655, height: 280,
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


function sendInfo(e) {
    var tab = tabs.getActiveTab();
    var gridList = [];
    var sendWcUrl = {};
    switch (tab.name) {
        case "bir":
             gridList = addServiceType(gridkhsr.getData(),10);
            break;
        case "lic":
        	gridList = addServiceType(gridjzns.getData(),8);
            sendWcUrl = 'manage/sendWechatWindow/sWcInfoMoreLicense.jsp';
            break;
        case "due":
        	gridList = addServiceType(gridclnj.getData(),9);
            sendWcUrl = 'manage/sendWechatWindow/sWcInfoMoreYearCheck.jsp';
            break;
        case "care":
        	gridList = addServiceType(gridbydq.getData(),5);
            sendWcUrl = 'manage/sendWechatWindow/sWcInfoMoreRemind.jsp';
            break;
        case "insure":
        	gridList = addServiceType(gridjqx.getData(),7);
            sendWcUrl = 'manage/sendWechatWindow/sWcInfoMoreInsurance.jsp';
            break;
        case "annual":
        	gridList = addServiceType(gridsyx.getData(),6);
            sendWcUrl = 'manage/sendWechatWindow/sWcInfoMoreInsurance.jsp';
            break;
        case "type":
        	gridList = addServiceType(gridkhlx.getData(),11);//其他
            break;
        default:
            break;
    }
    if (e == 1) {// 1发送短信

        var dataArr = [];
        for(var i=0;i<gridList.length;i++){
            if(gridList[i].mobile){
                dataArr.push(gridList[i]);
            }
        }
        if(dataArr.length <1){
            showMsg("筛选至少包含一位有手机联系方式的客户","W");
            return;
        }else{
            sendInfoWin(dataArr);
        }

    }else if (e == 2) {// 2发送微信
        var dataArr = [];
        for(var i=0;i<gridList.length;i++){
            if(gridList[i].wechatOpenId){
                dataArr.push(gridList[i]);
            }
        }
        if(dataArr.length <1){
            showMsg("筛选至少包含一位已绑定微信号的客户","W");
            return;
        }else{
            sendWcText(dataArr,sendWcUrl);
        }
    }else if (e == 3) {// 3发送微信图文
        var dataArr = [];
        for(var i=0;i<gridList.length;i++){
            if(gridList[i].wechatOpenId){
                dataArr.push(gridList[i]);
            }
        }
        if(dataArr.length <2){ 
            showMsg("筛选至少包含两位已绑定微信号的客户","W");
            return;
        }else {
            sendWcPic(dataArr);
        }
    } else if (e == 4) {// 4发送微信卡券
        var dataArr = [];
        for(var i=0;i<gridList.length;i++){
        	var data = gridList[i];
            if(data.wechatOpenId){
            	data.userNickname = data.guestName;
            	data.userMarke = data.wechatServiceId;
            	data.storeName = currOrgName;
            	data.userOpid = data.wechatOpenId;
                dataArr.push(data);
            }
        }
        if(dataArr.length <2){
            showMsg("筛选至少包含一位已绑定微信号的客户","W");
            return;
        }else{
            sendWcCoupon(dataArr);
        }
    }
}

function sendWcPic(list) {
    if (list.length < 1) {
        showMsg("没有可发送微信的客户","E");
        return;
    }
    nui.open({                        
        url: webPath + contextPath  + "/manage/sendWechatWindow/sWcPicInfoMore.jsp?token="+token,
        title: "发送微信图文", width: 800, height: 350,
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


function sendWcText(list,sendWcUrl){//发送微信消息
    if (list.length < 1) {
        showMsg("没有可发送微信的客户","E");
        return;
    }
    // var tit = "发送微信[" + row.guestName + '/' + row.mobile + '/' + row.carModel + ']';
    var tit = "发送微信";
    nui.open({
        url: webPath + contextPath  + "/"+sendWcUrl+"?token="+token,
        title: tit, width: 800, height: 350,
        onload: function () {
        var iframe = this.getIFrameEl();
        iframe.contentWindow.setData(list);
    },
    ondestroy: function (action) {
      
        }
    });
}



function sendWcCoupon(list) {
    nui.open({                        
        url: webPath + contextPath  + "/manage/sendWechatWindow/sWcInfoCouponMore.jsp?token="+token,
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

function addServiceType(list,type){
	if(list.length <1){
		return;
	}
	var Arr = [];
	for(var i =0;i<list.length;i++){
		var  data = list[i];
		data.serviceType = type;
		data.guestId=data.conId;
    	data.guestSource = 0;//系统客户
		Arr.push(data);
	}
	return Arr;
} 
