var baseUrl = apiPath + sysApi + "/";;
var basicInfoForm;
var prebookCategoryHash = [{ name: '客户主动预约', id: '0' }, { name: '客户被动预约', id: '1' }];
var serviceTypeHash = [];
var carBrandHash = [];
var carSeriesHash = [];
var mtAdvisorHash = [];

var listUrl= baseUrl + "com.hsapi.repair.repairService.booking.queryBookingList.biz.ext";
      
$(document).ready(function(v){
    init();
});

function init() {
    initCarBrand("carBrandId", function () {
        var data = nui.get("carBrandId").getData();
        data.forEach(function (v) {
            carBrandHash[v.id] = v;
        });
    });

    initCarSeries("carSeriesId", "", function () {
        var data = nui.get("carSeriesId").getData();
        data.forEach(function (v) {
            carSeriesHash[v.id] = v;
        });
    });

    initMember("mtAdvisorId", function () {
        var data = nui.get("mtAdvisorId").getData();
        data.forEach(function (v) {
            mtAdvisorHash[v.id] = v;
        });
    });

    initServiceType("serviceTypeId", function () {
        var data = nui.get("serviceTypeId").getData();
        data.forEach(function (v) {
            serviceTypeHash[v.id] = v;
        });
    });   
    
    nui.get("prebookCategory").setData(prebookCategoryHash);
}


function SetData(params) {
	basicInfoForm = new nui.Form("#basicInfoForm");	
	basicInfoForm.setData(params.data);
}

function onOk() {
	basicInfoForm = new nui.Form("#basicInfoForm");	
    var main = basicInfoForm.getData();
    if (!main || main == undefined) return;

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });

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

    nui.ajax({
        url: baseUrl + "com.hsapi.repair.repairService.booking.updateBooking.biz.ext",
        type: 'post',
        data:JSON.stringify({
            param: main,
            token:token
        }),        
        success: function(data) {
            if (data.errCode == "S") {                
                window.CloseOwnerWindow("ok");
            } else {
                nui.alert(data.errMsg || "保存失败");
            }
        },
        error: function(jqXHR, textStatus, errorThrown) {
            nui.unmask();
            nui.alert("网络出错");            
        }
    });
}

function onClose() {
	window.CloseOwnerWindow("ok");	
}
	
function selectCustomer() {
    openCustomerWindow(function (v) {
        basicInfoForm = new nui.Form("#basicInfoForm");	
        var main = basicInfoForm.getData();
        main.guestId = v.guestId;
        main.contactorName = v.guestFullName;
        main.carId = v.carId;
        main.carNo = v.carNo;
        main.carBrandId = v.carBrandId;
        main.carSeriesId = v.carSeriesId;
        main.contactorId = v.contactorId;
        main.contactorTel = v.mobile;
        var params = {};
        params.data = main;
        SetData(params);
    });
}

function openCustomerWindow(callback) {
    nui.open({
        url: "com.hsweb.RepairBusiness.Customer.flow",
        title: "客户选择", width: 800, height: 450,
        onload: function () {
        },
        ondestroy: function (action) {
            if ("ok" == action) {
                var iframe = this.getIFrameEl();
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