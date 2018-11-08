var baseUrl = apiPath + repairApi + "/";;
var basicInfoForm;
var prebookCategoryHash = [{ name: '客户主动预约', id: '0' }, { name: '客户被动预约', id: '1' }];
var serviceTypeHash = [];
var carBrandHash = [];
var carSeriesHash = [];
var mtAdvisorHash = [];
var timeStartEl = null;
var carNoEl = null;
var timeData = [];
var todayDate = "";

var listUrl= baseUrl + "com.hsapi.repair.repairService.booking.queryBookingList.biz.ext";

$(document).ready(function(v){
    init();
    carNoEl = nui.get("carNo");
    carNoEl.focus();
    document.onkeyup = function(event) {
		var e = event || window.event;
		var keyCode = e.keyCode || e.which;// 38向上 40向下
		

		if ((keyCode == 27)) { // ESC
			CloseWindow('cancle');
		}
	}
  
});

function init() {
	
	//品牌
    initCarBrand("carBrandId", function () {
        var data = nui.get("carBrandId").getData();
        data.forEach(function (v) {
            carBrandHash[v.id] = v;
        });
    });

    initCarSeries("carSeriesId", "", function () {
        var data = nui.get("carSeriesId").getData();
        data.forEach(function (v) {
        	//车系信息
            carSeriesHash[v.id] = v;
        });
    });

    //服务顾问
    initMember("mtAdvisorId", function () {
        var data = nui.get("mtAdvisorId").getData();
        data.forEach(function (v) {
            mtAdvisorHash[v.id] = v;
        });
    });

    //业务类型
    initServiceType("serviceTypeId", function () {
        var data = nui.get("serviceTypeId").getData();
        data.forEach(function (v) {
            serviceTypeHash[v.id] = v;
        });
    });   
    
    //预约类型
    nui.get("prebookCategory").setData(prebookCategoryHash);

}

function onenterSelect(e){
	 var carNo = e;
	 openCustomerWindow(carNo,function (v) {
	        basicInfoForm = new nui.Form("#basicInfoForm");	
	        var main = basicInfoForm.getData();
	        main.guestId = v.guestId;
	        main.contactorName = v.guestFullName;
	        main.carId = v.carId;
	        main.carNo = v.carNo;
	        /*main.carVin = v.vin;*/
	        main.carBrandId = v.carBrandId;
	        main.carSeriesId = v.carSeriesId;
	        main.contactorId = v.contactorId;
	        main.contactorTel = v.mobile;
	        var params = {};
	        params.data = main;
	        SetData(params);
	    });
}
function initTimeData(){
    nui.ajax({
        url: baseUrl + "com.hsapi.repair.repairService.booking.getAppointmentDate.biz.ext",
        type: 'post',
        async:false,
        data:JSON.stringify({
            token: token
        }),        
        success: function(data) {
            if (data.errCode == "S") {              
                var nowMinute = data.nowMinute;
                var endMinute = data.endMinute;
                var nowDateStr = data.nowDateStr;
                var advanceDay = data.advanceDay;
                todayDate = nowDateStr;
                if(endMinute>nowMinute){
                    var newObj = {
                        id:nowDateStr,
                        name:nowDateStr
                    };
                    timeData.push(newObj);
                }
                for(var i=0; i<advanceDay; i++){
                    nowDateStr = addDate(nowDateStr,1);
                    var newObj = {
                        id:nowDateStr,
                        name:nowDateStr
                    };
                    timeData.push(newObj);
                }

                timeStartEl.setData(timeData);
            }
        },
        error: function(jqXHR, textStatus, errorThrown) {
            nui.unmask();
            console.log(jqXHR.responseText);
            nui.alert("网络出错，保存失败");           
        }
    });
}

function SetData(params) {
    timeStartEl = nui.get("timeStart");
    initTimeData();

    basicInfoForm = new nui.Form("#basicInfoForm");
    basicInfoForm.setData(params.data);

    if(params.data.carBrandId){
        initCarSeries("carSeriesId", params.data.carBrandId, function () {
            var data = nui.get("carSeriesId").getData();
            data.forEach(function (v) {
                carSeriesHash[v.id] = v;
            });
        });
    }
    
    //预约时间处理
    var predictComeDate = params.data.predictComeDate;
    var predictComeDateTime = "";
    var predictComeTime = "";
    if(predictComeDate){
        predictComeDateTime = format(predictComeDate,"yyyy-MM-dd");
        predictComeTime = format(predictComeDate,"HH:mm");
        if(predictComeDateTime>=todayDate){
            timeStartEl.setValue(predictComeDateTime);
            setTimeChange();

            var classStr = $("a[itemid='"+predictComeTime+"']").attr("class");
            if(classStr == 'hui') return;

            $("a[itemid='"+predictComeTime+"']").siblings().removeClass("xz");
            $("a[itemid='"+predictComeTime+"']").toggleClass("xz");
        }
    }
    
}

function onOk() {
	basicInfoForm = new nui.Form("#basicInfoForm");	
    var main = basicInfoForm.getData();
    if (!main || main == undefined) return;

    var time = $("a[name=date][class=xz]").attr("itemid")||"";
    if (time == "" || time==null) {
        showMsg('请选择预计来厂时间',"W");
        return;
    }
    if(main.mtAdvisorId == "" || main.mtAdvisorId == undefined || main.mtAdvisorId == null){
    	 showMsg('请选择服务顾问',"W");
         return;
    }

    main.predictComeDate = timeStartEl.getValue() + ' ' + time + ":00";

    if (!main.id) {
        getServiceCode(function(data) {
            data = data || {};
            var code = data.code;
            if(!code) {
                nui.unmask();
                nui.alert("获取单号失败，无法保存");
                return;
            }
            main.serviceCode = code;
        });
    }

    if(!main.contactorName){
        showMsg("客户名称不能为空!");
        return;
    }
    

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });

    nui.ajax({
        url: baseUrl + "com.hsapi.repair.repairService.booking.updateBooking.biz.ext",
        type: 'post',
        data:JSON.stringify({
            rpsPrebook: main,
            action: "edit",
            token: token
        }),        
        success: function(data) {
            if (data.errCode == "S") {                
                window.CloseOwnerWindow("ok");
            } else {
                nui.unmask();
                nui.alert(data.errMsg || "保存失败");
            }
        },
        error: function(jqXHR, textStatus, errorThrown) {
            nui.unmask();
            console.log(jqXHR.responseText);
            nui.alert("网络出错，保存失败");           
        }
    });
}

function onClose() {
	window.CloseOwnerWindow("ok");	
}
	
function selectCustomer() {
    openCustomerWindow(null,function (v) {
        basicInfoForm = new nui.Form("#basicInfoForm");	
        var main = basicInfoForm.getData();
        main.guestId = v.guestId;
        main.contactorName = v.guestFullName;
        main.carId = v.carId;
        main.carNo = v.carNo;
        /*main.carVin = v.vin;*/
        main.carBrandId = v.carBrandId;
        main.carSeriesId = v.carSeriesId;
        main.contactorId = v.contactorId;
        main.contactorTel = v.mobile;
        var params = {};
        params.data = main;
        SetData(params);
    });
}

function openCustomerWindow(carNo,callback) {
    nui.open({
        url: "com.hsweb.RepairBusiness.Customer.flow",
        title: "客户选择", width: 800, height: 450,
        onload: function () {
        	if(carNo){
        	  var iframe = this.getIFrameEl();
        	  iframe.contentWindow.setCarNo(carNo);
        	}
        },
        ondestroy: function (action) {
        	carNoEl.focus();
            if ("ok" == action) {
              var iframe = this.getIFrameEl();
                //調用字界面的方法，返回子頁面的數據
                var data = iframe.contentWindow.getData();
                var guest = data.guest;
                callback && callback(guest);
            }
        }
    });
}

function getServiceCode(callback) {
    var billTypeCode = "YYD";
    getCompBillNO (billTypeCode, function(data) {
        data = data || {};
        var code = data.serviceno;
        callback({
            code:code
        });
    });
}

function onMTAdvisorIdChange(e){
    var value = e.selected.empName;
    nui.get("mtAdvisor").setValue(value);
}

function onCarBrandChange(e){     
    initCarSeries("carSeriesId", e.value, function () {
        var data = nui.get("carSeriesId").getData();
        data.forEach(function (v) {
            carSeriesHash[v.id] = v;
        });
    });
}

//只允许选择今日之后的日期
function onDrawDate(e) {
    var date = e.date;
    var d = new Date();

    if (date.getTime() < d.getTime()) {
        e.allowSelect = false;
    }
}
function setTimeChange(){
    var d = timeStartEl.getValue();
    var isToday = 0;
    if(d == todayDate){
        isToday = 1;
    }
    nui.ajax({
        url: baseUrl + "com.hsapi.repair.repairService.booking.getAppointmentTimes.biz.ext",
        type: 'post',
        async:false,
        data:JSON.stringify({
            isToday:isToday,
            token: token
        }),        
        success: function(data) {
            var timeList = data.timeList;
            var advanceTimes = data.advanceTimes||0;
            var nowTimeStr = data.nowTimeStr||"";
            var pn = calMinute(nowTimeStr);
            var jm = pn.ms + advanceTimes;
            if (timeList && timeList.length>0) {              
                var htmlStr = "";
                for(var i=0; i<timeList.length; i++){
                    var timeObj = timeList[i];
                    var timeId = timeObj.timeId;
                    var pt = calMinute(timeId);
                    var ms = pt.ms;
                    var timeStr = pt.timeStr;
                    var s = "";
                    if(ms<=jm && isToday == 1){
                        s = "<a href='javascript:;' itemid='"+timeStr+"' class='hui'>"+timeStr+"</a>";
                    }else{
                        s = "<a href='javascript:;' name='date' itemid='"+timeStr+"'>"+timeStr+"</a>";
                    }
                    htmlStr += s;
                }
                $(".addyytime").html(htmlStr);
                selectclick();
            }
        },
        error: function(jqXHR, textStatus, errorThrown) {
            nui.unmask();
            console.log(jqXHR.responseText);
            nui.alert("网络出错，保存失败");           
        }
    });
}
function calMinute(timeStr){
    var arr = timeStr.split(":");
    var ms = 0;
    //取总分钟
    if(arr && arr.length>2){
        var h = parseInt(arr[0]);
        var m = parseInt(arr[1]);
        ms = h*60 + m;
    }

    var index = timeStr.lastIndexOf(":");
    timeStr = timeStr.substring(0,index);

    var p = {
        ms:ms,
        timeStr:timeStr
    };
    return p;
}
function selectclick() {
    $("a[name=date]").click(function () {
        $(this).siblings().removeClass("xz");
        $(this).toggleClass("xz");
    });
}

function CloseWindow(action)
{
	if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else
		window.close();
}
