var baseUrl = apiPath + repairApi + "/";
var mainUrl = baseUrl + "com.hsapi.repair.baseData.query.queryAppointmentParams.biz.ext";//type=2查询预约和预约时间段
var stationUrl = baseUrl + "com.hsapi.repair.baseData.query.queryAppointmentStation.biz.ext";
var advancedDeductWin = null;
var guestVarEl = null;
var timeStartEl = null;
var timeEndEl = null;
var intervalTimeEl = null;
var statusEl = null;
var basicInfoForm = null;
var basicNoticeForm = null;
var prdtRateEditEl = null;
var isNoticeEl = null;
var msgContentEl = null;
var stationGrid = null;
var mainTabs = null;

var varList = [{id:1,name:"车主姓名"},{id:2,name:"手机号"},{id:3,name:"预约时间"},{id:4,name:"服务方式"},{id:5,name:"车牌信息"}];
var timeList = [{id:"06:00",name:"06:00"},{id:"07:00",name:"07:00"},{id:"08:00",name:"08:00"},{id:"09:00",name:"09:00"},{id:"10:00",name:"10:00"},
                {id:"11:00",name:"11:00"},{id:"12:00",name:"12:00"},{id:"13:00",name:"13:00"},{id:"14:00",name:"14:00"},{id:"15:00",name:"15:00"},
                {id:"16:00",name:"16:00"},{id:"17:00",name:"17:00"},{id:"18:00",name:"18:00"},{id:"19:00",name:"19:00"},{id:"20:00",name:"20:00"},
                {id:"21:00",name:"21:00"},{id:"22:00",name:"22:00"},{id:"23:00",name:"23:00"},{id:"24:00",name:"24:00"}];
var intervalList = [{id:15,name:"15分钟"},{id:20,name:"20分钟"},{id:30,name:"30分钟"},{id:60,name:"1个小时"},{id:120,name:"2个小时"},{id:240,name:"4个小时"}];
var radioList = [{id:1,name:"是"},{id:0,name:"否"}];
var noticeList = [{id:1,name:"启用"},{id:0,name:"禁用"}];
var statusList = [{id:0,name:"启用"},{id:1,name:"禁用"}];
var statusHash = {0:"启用",1:"禁用"};
var current;
$(document).ready(function(v) {
    advancedDeductWin = nui.get("advancedDeductWin");
    guestVarEl = nui.get("guestVar");
    guestVarEl.setData(varList);
    timeStartEl = nui.get("timeStart");
    timeEndEl = nui.get("timeEnd");
    timeStartEl.setData(timeList);
    timeEndEl.setData(timeList);
    intervalTimeEl = nui.get("intervalTime");
    intervalTimeEl.setData(intervalList);
    statusEl = nui.get("status");
    statusEl.setData(radioList);
    prdtRateEditEl = nui.get("prdtRateEdit");
    isNoticeEl = nui.get("isNotice");
    isNoticeEl.setData(noticeList);
    msgContentEl = nui.get("msgContent");
    stationGrid = nui.get("stationGrid");
    stationGrid.setUrl(stationUrl);
    mainTabs = nui.get("mainTabs");

    basicInfoForm = new nui.Form("#basicInfoForm");
    basicNoticeForm = new nui.Form("#basicNoticeForm");

    loadParams();

    bind();

    stationGrid.on("drawcell",function(e){
        switch (e.field) {
            case "status":
                if (statusHash[e.value]) {
                    e.cellHtml = statusHash[e.value] || "";
                } else {
                    e.cellHtml = "";
                }
                break;
            default:
                break;
            }
    });
    
    document.onkeyup=function(event){
	    var e=event||window.event;
	    var keyCode=e.keyCode||e.which;
        if((keyCode==27))  {  //ESC
        	advancedDeductWin.hide();
	   };
     };
});
function loadParams(){
    nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '加载中...'
	});

	nui.ajax({
		url : mainUrl,
		type : "post",
		data : JSON.stringify({
            type: 2,
			token: token
		}),
		success : function(data) {
			nui.unmask(document.body);
            data = data || {};
            var params = data.params;
            var times = data.times;
			if (params) {
                if(params.timeStart){
                    var index = params.timeStart.lastIndexOf(":");
                    params.timeStart = params.timeStart.substring(0,index);
                }
                if(params.timeEnd){
                    var index = params.timeEnd.lastIndexOf(":");
                    params.timeEnd = params.timeEnd.substring(0,index);
                }

                basicInfoForm.setData(params);
                basicNoticeForm.setData(params);

                
            }
            if (times && times.length>0) {
				setInitTimeList(times);
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
}
function bind() {
    $(".sjd li[name=time]").click(function () {
        if ($(this).hasClass("yyh")) {
            $(this).attr("class", "无优惠");
            $(this).find("span[name=comment]").text("无优惠").attr("discount", "");
        }
        else if ($(this).hasClass("hui")) {
            $(this).attr("class", "");
            $(this).find("span[name=comment]").text("无优惠").attr("discount", "");
        }
        else {
            $(this).attr("class", "hui");
            $(this).find("span[name=comment]").text("不可预约").attr("discount", "");
        }
    });
    $(".sjd li[name=time]").find("a").click(function () {
        var li = $(this).parents("li[name=time]");
        current = li;
        var time = li.find("font").text();
        var discount = li.find("span[name=comment]").attr("discount");
        discount = discount*10;
        $("#timeIdEdit").text(time);
        //$("#txtdiscount").val(discount);
        prdtRateEditEl.setValue(discount);
        //$(".popbox,.boxbg").show();

        advancedDeductWin.show();

        return false;
    });
}
$("#prdtRateEdit").on("input", function () {
    var val = $.trim($(this).val());
    if (val != "" && isNaN(val)) {
        Ewewo.Tips('项目折扣请输入数字');
        $(this).val("");
    }
});
function add_zero(temp) {
    if (temp < 10) return "0" + temp;
    else return temp;
}
function setTimeChange(){
    var start = timeStartEl.getValue();
    var end = timeEndEl.getValue();
    var interval = intervalTimeEl.getValue();

    setTimeList(start, end, interval);
}
function setTimeList(start, end, interval){

    if (parseInt(start) > parseInt(end)&&end!=0) {
        showMsg('开始时间不能大于结束时间','W');
        timeEndEl.setValue(start);
        //return false;
    }
    $(".sjd").empty();
    end=end==0?24:end;
    var n = (parseInt(end) - parseInt(start)) * 60 / parseInt(interval);
    var interValueStarttime = new Date();
    for (var i = 0; i < n; i++) {
        var m = i * parseInt(interval);
        var k = 0;
        if (m > 60) {
            interValueStarttime.setHours(parseInt(start) + m / 60);
            k = m % 60;
        }
        else {
            interValueStarttime.setHours(parseInt(start));
            k = m;
        }
        interValueStarttime.setMinutes(k);
        var newtime = add_zero(interValueStarttime.getHours()) + ':' + add_zero(interValueStarttime.getMinutes());
        //无优惠class="";有优惠class="yyh"; 不可预约class="hui"
        $(".sjd").append('<li name="time"><font>' + newtime + '</font>' +
                            '<p><a href="javascript:;"></a><span name="comment" discount="">无优惠</span></p>' +
                        '</li>');
    }
    bind();
}
function gettime() {
    var list = new Array();
    $(".sjd li[name=time]").each(function () {
        var item = {timeId: "00:00", prdtRate: 0, status: 0 };
        item.timeId = $(this).find("font").text() + ":00";
        //var prdtRate = $(this).find("span[name=comment]").attr("discount")||0;
       // item.prdtRate = parseFloat(prdtRate);
        var prdtRate = $(this).find("span[name=comment]").attr("discount")||"";
        item.prdtRate = prdtRate*10;
        if ($(this).hasClass("hui")) {
            item.status = 1;
        }
        else {
            item.status = 0;
        }
        list.push(item);
    });
    return list;
}
function advancedDeductCancel(){
    advancedDeductWin.hide();
}
function advancedDeductOk(){
    var discount = prdtRateEditEl.getValue();
    discount = Math.round(discount);
    discount=discount/10;
    if (discount == "") {
        showMsg('请输入项目折扣','W');
        return;
    }
    $(current).find("span[name=comment]").attr("discount", discount).text("折扣：" + discount + "折");
    $(current).attr("class", "yyh");
    advancedDeductWin.hide();
}
function setInitTimeList(data){
    $(".sjd").empty();
    for (var i = 0; i < data.length; i++) {
        var timeRecord = data[i];
        var timeId = timeRecord.timeId;
        if(timeId){
            var index = timeId.lastIndexOf(":");
            timeId = timeId.substring(0,index);
        }
        var prdtRate = timeRecord.prdtRate;
        var status = timeRecord.status||0;
        //无优惠class="";有优惠class="yyh"; 不可预约class="hui"
        var htmlStr = "";
        if(status==0){
            if(prdtRate>0){
                $(".sjd").append('<li name="time" class="yyh"><font>' + timeId + '</font>' +
                            '<p><a href="javascript:;"></a><span name="comment" discount="'+prdtRate+'">折扣：' + prdtRate + '折</span></p>' +
                        '</li>');
            }else{
                $(".sjd").append('<li name="time"><font>' + timeId + '</font>' +
                            '<p><a href="javascript:;"></a><span name="comment" discount="">无优惠</span></p>' +
                        '</li>');
            }
        }else{
            $(".sjd").append('<li name="time" class="hui"><font>' + timeId + '</font>' +
                        '<p><a href="javascript:;"></a><span name="comment" discount="">不可预约</span></p>' +
                    '</li>');
            }
    }
    bind();
}
var requiredField = {
	advanceDay: "可提前几天预约",
	advanceTimes: "多长时间不能预约",
	timeStart: "可预约时间段",
	timeEnd: "可预约时间段",
	intervalTime: "预约间隔"
};
var saveParamsUrl = baseUrl + "com.hsapi.repair.baseData.crud.saveAppointmentParams.biz.ext";
function saveParams(){
    var data = basicInfoForm.getData();
    var timeData = basicNoticeForm.getData();
    for(var key in timeData){
        data[key] = timeData[key];
    }

    for(var key in requiredField){
		if(!data[key] || data[key].length==0)
        {
            showMsg(requiredField[key]+"不能为空", "W");
            return;
        }
    }
    
    var start = timeStartEl.getValue();
    var end = timeEndEl.getValue();
    if(start==end){
    	 showMsg("预约时间段相同，不能保存!", "W");
         return;
    }
    
    if(data.timeStart){
        data.timeStart = data.timeStart + ":00";
    }
    if(data.timeEnd){
        data.timeEnd = data.timeEnd + ":00";
    }
    
    var times = gettime();

    nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '保存中...'
	});

	nui.ajax({
		url : saveParamsUrl,
		type : "post",
		data : JSON.stringify({
			params : data,
			times : times,
			type : 2,
			token: token
		}),
		success : function(data) {
			nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
                showMsg("保存成功!","S");
                var params = data.params;
                if(params.timeStart){
                    var index = params.timeStart.lastIndexOf(":");
                    params.timeStart = params.timeStart.substring(0,index);
                }
                if(params.timeEnd){
                    var index = params.timeEnd.lastIndexOf(":");
                    params.timeEnd = params.timeEnd.substring(0,index);
                }

                basicInfoForm.setData(params);
                basicNoticeForm.setData(params);
			} else {
				showMsg(data.errMsg || "保存失败!","E");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});

}
//var varList = [{id:1,name:"车主姓名"},{id:2,name:"手机号"},{id:3,name:"预约时间"},{id:4,name:"服务方式"},{id:5,name:"车牌信息"}];
function setVar(e){
    var value = e.value;
    var content = msgContentEl.getValue();
    if(value == 1){
        content = content+"{车主姓名}";
        msgContentEl.setValue(content);
    }else if(value == 2){
        content = content+"{手机号}";
        msgContentEl.setValue(content);
    }else if(value == 3){
        content = content+"{预约时间}";
        msgContentEl.setValue(content);
    }else if(value == 4){
        content = content+"{服务方式}";
        msgContentEl.setValue(content);
    }else if(value == 5){
        content = content+"{车牌信息}";
        msgContentEl.setValue(content);
    }
}
function showInfo(){
    var tab = mainTabs.getActiveTab();
    if(tab.name == "stationTab"){
        queryStation();	
    }
}
function queryStation(){
    var name = nui.get("stationName").getValue()||"";
    var param = {name:name,sortField:"orderIndex",sortOrder:"asc"};
    stationGrid.load({
        param:param,
        token:token
    });
}
function addStation(){
    var newRow = {status:0};
    stationGrid.addRow(newRow);
}
function delStation(){
    //var row = stationGrid.getSelected();
    //if(row){
    //    stationGrid.removeRow(row,true);
    //}
}
var saveStationUrl = baseUrl + "com.hsapi.repair.baseData.crud.saveStation.biz.ext";
function saveStation(){
    var addList = stationGrid.getChanges("added");
	var updateList = stationGrid.getChanges("modified");
	var deleteList = stationGrid.getChanges("removed");

    nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '保存中...'
	});

	nui.ajax({
		url : saveStationUrl,
		type : "post",
		data : JSON.stringify({
			addList : addList,
			updateList : updateList,
			deleteList : deleteList,
			token: token
		}),
		success : function(data) {
			nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
				showMsg("保存成功!","S");
                queryStation();
			} else {
				showMsg(data.errMsg || "保存失败!","E");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});

}
function queryStationName(){
	queryStation();
}