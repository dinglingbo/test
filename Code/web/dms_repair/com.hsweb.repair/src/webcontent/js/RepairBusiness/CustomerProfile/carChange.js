var guest = {};
var yCar = null;
var xCar = null;
$(document).ready(function(v) {
	yCar = new nui.Form("#yCar");
	xCar = new nui.Form("#xCar");
	nui.get("carNo").disable();
	nui.get("guestFullName").disable();
	nui.get("mobile").disable();
	nui.get("vin").disable();
	nui.get("xmobile").disable();
	
});


function setData(data)
{
	guest= data.guest;
	yCar.setData(guest);
	xCar.setData(guest);
	updateType();
}
function updateType()
{
		if (nui.get('changeType').getValue() == "0"){
			nui.get("xcarNo").enable();
			nui.get("xvin").enable();
			nui.get("xguestFullName").disable();
			nui.get("xguestFullName").setValue(guest.guestFullName);
			nui.get("xguestFullName").setText(guest.guestFullName);
		} else {
			$('#xcarNo').attr("disabled",false);
			nui.get("xcarNo").disable();
			nui.get("xvin").disable();
			nui.get("xguestFullName").enable();
			nui.get("xguestFullName").setText("请选择...");
		}

}

var requiredField = {
		GuestId : "请选择客户",
		carNo : "车牌号",
		vin : "车架号(VIN)",
		guestFullName : "客户名称",
		mobile : "电话号码"
		
	};

function onOk(){
	var car = xCar.getData();
	for ( var key in requiredField) {
		if (!car[key] || $.trim(car[key]).length == 0) {
			showMsg(requiredField[key] + "不能为空!", "W");
			return;
		}
	}
	if(nui.get('changeType').getValue() == "0"){
		changeCarNo();
	}else{
		changeCarGuest();
	}
}

var changeCarNoUrl = apiPath + repairApi+ "/com.hsapi.repair.repairService.crud.saveCarNoChange.biz.ext";
function changeCarNo()
{
	var car = xCar.getData();
	var data = {
			carId:car.id,
			carNo:guest.carNo,
			carVin:car.vin,
			newCarNo:car.carNo

	}
	var json = {
			data:data,
			token:token
	}
	nui.ajax({
		url : changeCarNoUrl,
		type : 'POST',
		data : json,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
            data = text||{};
            if(data.errCode == "S"){
            	CloseWindow("ok");
            }else{
            	nui.alert("变更车牌失败","提示");
            }

		}
	});
}

var changeCarGuestUrl = apiPath + repairApi+ "/com.hsapi.repair.repairService.crud.saveCarGuestChange.biz.ext";
function changeCarGuest()
{
	var car = xCar.getData();
	var data = {
			carId:car.id,
			carNo:guest.carNo,
			carVin:car.vin,
			guestId:guest.guestId,
			guestName:guest.guestFullName,
			newGuestId:car.xGuestId,
			newGuestName:car.guestFullName
	}
	var json = {
			data:data,
			token:token
	}
	nui.ajax({
		url : changeCarGuestUrl,
		type : 'POST',
		data : json,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
            data = text||{};
            if(data.errCode == "S"){
            	CloseWindow("ok");
            }else{
            	nui.alert(data.errMsg,"提示");
            }

		}
	});
}

function onButtonEdit(e) {
	var nGuest ={};
    nui.open({
        targetWindow: window,
        url: webPath + contextPath + "/com.hsweb.RepairBusiness.questGuest.flow?token="+token,
        title: "客户查询", 
        width: 600, 
        height: 500,
        allowDrag:true,
        allowResize:true,
        onload: function () {
           
        },
        ondestroy: function (action)
        {
        	 nGuest = action.guest;
        	 nui.get("xguestFullName").setText(nGuest.guestFullName);
        	 nui.get("xguestFullName").setValue(nGuest.guestFullName);
        	 nui.get("xGuestId").setValue(nGuest.guestId);
        	 nui.get("xmobile").setValue(nGuest.mobile);
        }
    });
}

function CloseWindow(action) {
	if (action == "close") {

	} else if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else
		return window.close();
}
