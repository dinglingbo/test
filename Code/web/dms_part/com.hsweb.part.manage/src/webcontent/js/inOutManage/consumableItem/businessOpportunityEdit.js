var gridUrl = apiPath + repairApi
		+ "/com.hsapi.repair.baseData.crud.queryTimesCardDetail.biz.ext";
var gridUrl1 = apiPath + repairApi
+ "/com.hsapi.repair.baseData.crud.syncTimesCard.biz.ext";
var basicInfoForm = null;
var carNoEl = null;
$(document).ready(function(v) {
    carNoEl = nui.get("carNo");
    carNoEl.focus();
    basicInfoForm = new nui.Form("#basicInfoForm");
    initDicts({
    	chanceType:SELL_TYPE//商机
    },function(){
        //hash.initDicts = true;
       // checkComplete();
    });

});

function selectCustomer() {
	var carNo = nui.get("carNo").getText();
    openCustomerWindow(carNo,function (v) {
        basicInfoForm = new nui.Form("#basicInfoForm");	
        var main = basicInfoForm.getData();
        main.guestId = v.guestId;
        main.guestName = v.guestFullName;
        main.carId = v.carId;
        main.carNo = v.carNo;
        /*main.carVin = v.vin;*/
        main.carModel = v.carModel;
        main.carBrandId = v.carBrandId;
        main.carSeriesId = v.carSeriesId;
        main.contactorId = v.contactorId;
        main.guestMobile = v.mobile;
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
                var data = iframe.contentWindow.getData();
                var guest = data.guest;
                callback && callback(guest);
            }
        }
    });
}

var requiredField = {
	name : "计次卡名称:",
	sellAmt : "销售价格",
	totalAmt : "总价值",
	periodValidity : "有效期",
	salesDeductValue : "提成值"
};


var falg = null;
var type = null;




function onCancel() {
	CloseWindow("cancel");
}

function CloseWindow(action) {
	if (action == "close") {

	} else if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else
		return window.close();
}



function SetData(params) {

    basicInfoForm = new nui.Form("#basicInfoForm");
    basicInfoForm.setData(params.data);

    
}


function setData(params) {



    
}
