var baseUrl = apiPath + repairApi + "/";;
var scoutModeHash = [];
var scoutResutHash = [];
var saveUrl = baseUrl + "com.hsapi.repair.repairService.booking.queryBookingList.biz.ext";
var rowData = null;

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


function SetData(params) {
    basicInfoForm = new nui.Form("#basicInfoForm");	
    basicInfoForm.setData(params.data);
    rowData = params.data;
    nui.get("serviceId").setValue(params.data.id);
    if(!rowData.wechatOpenId){
    	//nui.get("btn_model").disable();
    	nui.get("btn_coupon").disable();
    }
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
		showMsg("联系人手机号为空!","W");
		return;
	}
	var p = rowData;
	if(p.carId== 0){
		p .guestSource =1;//电销客户
	}else{
		p .guestSource = 0;//系统客户
	}
	p.mobile =  rowData.contactorTel;
	p.guestId = rowData.contactorId;
	p.serviceType = 2;//预约
	nui.open({
		url: webPath + contextPath  + "/com.hsweb.crm.manage.sendInfo.flow?token="+token,
		title: "发送短信", width: 655, height: 386,
		onload: function () {
			var iframe = this.getIFrameEl();
			iframe.contentWindow.setData(p);
		},
		ondestroy: function (action) {
            //重新加载
            //query(tab);
        }
    });
}


function telVisit(){
	var row = rowData;
	row .serviceType = 2;//预约
	if(row.carId== 0){
		row .guestSource =1;//电销客户
	}else{
		row .guestSource = 0;//系统客户
	}
	row .guestId = rowData.contactorId;
	row.mainId=row.id;
    nui.open({
        url: webPath + contextPath + "/manage/maintainRemind/maintainRemMainDetail.jsp?token="+ token,
        title: "提醒信息", 
        width: 600, height: 300,
        onload: function () {
            var iframe = this.getIFrameEl(); 
            iframe.contentWindow.setData(rowData);
        },
        ondestroy: function (action) {
     }
 });
}

function sendWcCoupon() {
	var row = rowData;
    row.userNickname = row.contactorName;
    row.userMarke = row.wechatServiceId;
    row.storeName = currOrgName;
	row.userOpid = row.wechatOpenId;
	row.guestId = row.contactorId;//(回访历史表 guestId 存联系人id)
	row.serviceType = 2;//客户回访
	if(row.carId== 0){
		row .guestSource =1;//电销客户
	}else{
		row .guestSource = 0;//系统客户
	}
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
    	gridCar.reload();
        }
    });
}
