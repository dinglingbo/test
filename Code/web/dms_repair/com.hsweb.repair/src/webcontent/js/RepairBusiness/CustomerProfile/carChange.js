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
	nui.get("xvin").disable();
	
	nui.get("changeType").focus();
	document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27))  {  //ESC
        	onClose();
        }
      };
});


function setData(data)
{
	guest= data.guest;
	yCar.setData(guest);
	xCar.setData(guest);
	nui.get("xGuestId").setValue(guest.guestId);
	updateType();
}
function updateType()
{
		if (nui.get('changeType').getValue() == "0"){
			reduction();
			nui.get("xcarNo").enable();
			nui.get("xguestFullName").disable();
			nui.get("xguestFullName").setValue(guest.guestFullName);
			nui.get("xguestFullName").setText(guest.guestFullName);
		}else if(nui.get('changeType').getValue() == "1"){
			reduction();
			$('#xcarNo').attr("disabled",false);
			nui.get("xcarNo").disable();
			nui.get("xguestFullName").enable();
		}else if(nui.get('changeType').getValue() == "2"){
			reduction();
			$('#xcarNo').attr("disabled",false);
			nui.get("xcarNo").disable();
			nui.get("xguestFullName").disable();
			nui.get("xvin").enable();
		}

}
//点击变更下拉是触发，还原数据
function reduction(){
	yCar.setData(guest);
	xCar.setData(guest);
	nui.get("xGuestId").setValue(guest.guestId);
}

var requiredField = {
		xGuestId : "请选择客户",
		carNo : "车牌号",
		vin : "车架号(VIN)",
		guestFullName : "客户名称",
		mobile : "电话号码",
		remark : "变更原因"
		
};

function onOk(){
	var car = xCar.getData();
	    car.remark = nui.get("remark").getValue();
	for ( var key in requiredField) {
		if (!car[key] || $.trim(car[key]).length == 0) {
			parent.showMsg(requiredField[key] + "不能为空!", "W");
			return;
		}
	}
	if(nui.get('changeType').getValue() == "0"){
		changeCarNo();
	}else if(nui.get('changeType').getValue() == "1"){
		changeCarGuest();
	}else if(nui.get('changeType').getValue() == "2"){
		changeCarVIN();
	}
}

//var changeCarNoUrl = apiPath + repairApi+ "/com.hsapi.repair.repairService.crud.saveCarNoChange.biz.ext";
var changeCarNoUrl = apiPath + repairApi+ "/com.hsapi.repair.repairService.crud.saveChangeCarNo.biz.ext";
var queryCarNo = apiPath + repairApi + "/com.hsapi.repair.repairService.crud.queryCarNoByCarNo.biz.ext";
function changeCarNo()
{
	var xcarNo = nui.get("xcarNo").value;
	var falge = isVehicleNumber(xcarNo);
	xcarNo = falge.vehicleNumber//返回转化好的车牌
	if(!falge.result){
		showMsg("请输入正确的车牌号","W");
		return;
	}
	nui.get("xcarNo").setValue(xcarNo);
	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '变更中...'
	});
	var params = {};
	params.carNo = xcarNo;
	var json = {
			params:params,
			token:token
	}
	nui.ajax({
		url : queryCarNo,
		type : 'POST',
		data : json,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			var list = text.list;
			if(list.length){
				nui.unmask(document.body);
				nui.confirm("车牌号"+xcarNo+"已存在，是否变更？", "友情提示",function(action){
					if(action == "ok"){
						nui.mask({
							el : document.body,
							cls : 'mini-mask-loading',
							html : '变更中...'
						});
						var car = xCar.getData();
						car.remark = nui.get("remark").getValue();
						var data = {
								carId:car.id,
								carNo:guest.carNo,
								carVin:car.vin,
								newCarNo:car.carNo,
								remark:car.remark
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
								nui.unmask(document.body);
					            data = text||{};
					            if(data.errCode == "S"){
					            	CloseWindow("ok");
					            }else{
					                showMsg("变更车牌失败","E");
					            }

							}
						});						
					}
				});
			}else{
				var car = xCar.getData();
				car.remark = nui.get("remark").getValue();
				var data = {
						carId:car.id,
						carNo:guest.carNo,
						carVin:car.vin,
						newCarNo:car.carNo,
						remark:car.remark
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
						nui.unmask(document.body);
			            data = text||{};
			            if(data.errCode == "S"){
			            	CloseWindow("ok");
			            }else{
			            	showMsg("变更车牌失败","E");
			            }

					}
				});	
			}
		},
		error:function(jqXHR, textStatus, errorThrown) {
			nui.unmask(document.body);
			console.log(jqXHR.responseText);
		}
	});
}

var changeCarVINUrl = apiPath + repairApi+ "/com.hsapi.repair.repairService.crud.saveCarVINChange.biz.ext";
function changeCarVIN()
{
	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '变更中...'
	});
	var car = xCar.getData();
	 car.remark = nui.get("remark").getValue();
	var data = {
			carId:car.id,
			carNo:guest.carNo,
			carVin:guest.vin,
			newCarVin:car.vin,
			guestId:guest.guestId,
			guestName:guest.guestFullName,
			remark:car.remark
	}
	var json = {
			data:data,
			token:token
	}
	nui.ajax({
		url : changeCarVINUrl,
		type : 'POST',
		data : json,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			nui.unmask(document.body);
            data = text||{};
            if(data.errCode == "S"){
            	CloseWindow("ok");
            }else{
            	showMsg(data.errMsg,"E");
            }

		}
	});
}
//var changeCarGuestUrl = apiPath + repairApi+ "/com.hsapi.repair.repairService.crud.saveCarGuestChange.biz.ext";
var changeCarGuestUrl = apiPath + repairApi+ "/com.hsapi.repair.repairService.crud.saveSplitCar.biz.ext";
function changeCarGuest(){
	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '变更中...'
	});
	 var car = xCar.getData();
	 //car.remark = nui.get("remark").getValue();
	 var carList = [];
	 var insGuest = {};
	 var oldGuest = {};
	 var remark = null;
	 var insCar = {};
	 insCar.id = car.id;
	 insCar.carNo = guest.carNo;
	 insCar.vin = car.vin;
	 carList.push(insCar);
	 remark = nui.get("remark").getValue()
	 oldGuest.id = guest.guestId;
	 oldGuest.fullName = guest.guestFullName;
	 insGuest.id = car.xGuestId;
	 insGuest.fullName = car.guestFullName; 
	/*var data = {
			carId:car.id,
			carNo:guest.carNo,
			carVin:car.vin,
			guestId:guest.guestId,
			guestName:guest.guestFullName,
			newGuestId:car.xGuestId,
			newGuestName:car.guestFullName,
			remark:car.remark
	}*/
	var json = {
			carList:carList,
			guest:insGuest,
			oldGuest:oldGuest,
			remark:remark,
			token:token
	}
	nui.ajax({
		url : changeCarGuestUrl,
		type : 'POST',
		data : json,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			nui.unmask(document.body);
           data = text||{};
           if(data.errCode == "S"){
           	CloseWindow("ok");
           }else{
           	showMsg(data.errMsg,"E");
           }

		}
	});
}

function onButtonEdit(e) {
	var nGuest ={};
    nui.open({
        //// targetWindow: window,
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

	} else if (window.CloseOwnerWindow){
		return window.CloseOwnerWindow(action);
	}else{
		return window.close();
	}
		
}

function onClose(){
	window.CloseOwnerWindow();	
}

function queryCarNo(e){
	
}