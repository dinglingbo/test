var baseUrl = apiPath + sysApi + "/";;
var scoutModeHash = [];
var scoutResutHash = [];
var saveUrl = baseUrl + "com.hsapi.repair.repairService.booking.queryBookingList.biz.ext";
      
$(document).ready(function(v){
    init();
});

function init() {
    initDicts({
        scoutMode: SCOUT_MODE, //跟进方式
        isUsabled: IS_USABLED //跟踪状态
    }, function () {
        var data = nui.get("scoutMode").getData();
        data.forEach(function (v) {
            scoutModeHash[v.customid] = v;
        });
        var data = nui.get("isUsabled").getData();
        data.forEach(function (v) {
            scoutResutHash[v.customid] = v;
        });
    });    
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
	
//只允许选择今日之后的日期
function onDrawDate(e) {
    var date = e.date;
    var d = new Date();

    if (date.getTime() < d.getTime()) {
        e.allowSelect = false;
    }
}
