var baseUrl = apiPath + repairApi + "/";;
var scoutModeHash = [];
var scoutResutHash = [];
var saveUrl = baseUrl + "com.hsapi.repair.repairService.booking.queryBookingList.biz.ext";
      
$(document).ready(function(v){
    init();
    nui.get('scoutMode').focus();
    document.onkeyup = function(event) {
        var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下
        

        if ((keyCode == 27)) { // ESC
        	onClose();
        }

    }
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

var rowData = null;
function SetData(params) {
    basicInfoForm = new nui.Form("#basicInfoForm");	
    basicInfoForm.setData(params.data);
    rowData = params.data;
    nui.get("serviceId").setValue(params.data.id);
}

function onOk() {
	basicInfoForm = new nui.Form("#basicInfoForm");	
    var data = basicInfoForm.getData();
    if (!data || data == undefined) return;

    data.serviceId = nui.get("serviceId").getValue();

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });

    nui.ajax({
        url: baseUrl + "com.hsapi.repair.repairService.booking.saveBookScout.biz.ext",
        type: 'post',
        data:JSON.stringify({
            rpsPrebookTelScout: data,
            token: token
        }),        
        success: function(data) {
            if (data.errCode == "S") {                
                window.CloseOwnerWindow("ok");
            } else {
                nui.unmask();
                showMsg(data.errMsg || "保存失败","E");
            }
        },
        error: function(jqXHR, textStatus, errorThrown) {
            nui.unmask();
            console.log(jqXHR.responseText);   
            showMsg(data.errMsg || "网络出错，保存失败","E");
        }
    });
}

function onClose() {
	window.CloseOwnerWindow("onClose");	
}
	
//只允许选择今日之后的日期
function onDrawDate(e) {
    var date = e.date;
    var d = new Date();

    if (date.getTime() < d.getTime()) {
        e.allowSelect = false;
    }
}
//发送短信
function sendInfo(){
	var data = basicInfoForm.getData();
	var phones = data.contactorTel || "";
	if(phones=="" && phones==null){
		showMsg("联系人电话为空!","W");
		return;
	}
	nui.open({
		url: webPath + contextPath  + "/com.hsweb.crm.manage.sendInfo.flow?token="+token,
		title: "发送短信", width: 655, height: 386,
		onload: function () {
			var iframe = this.getIFrameEl();
			iframe.contentWindow.setData(rowData);
		},
		ondestroy: function (action) {
            //重新加载
            //query(tab);
        }
    });
}