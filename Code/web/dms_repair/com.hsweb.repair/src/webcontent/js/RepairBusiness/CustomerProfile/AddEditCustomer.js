var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var webBaseUrl = webPath + contextPath + "/";
var contactInfoForm = null;
var carInfoFrom = null;
var basicInfoForm = null;
var prebookF = null;
var prebookInfo = {};
var PreBook = {};
var provice;
var cityId;
var data;
var empty = 0;//是否清空
var guestTypeList = [];
var guestTypeHash = {};
$(document).ready(function()
{
	if(currRepairBillCmodelFlag == "1"){
        nui.get("carModel").disable();
    }else{
        nui.get("carModel").enable();
    }
	 initGuestType("guestTypeId",function(data) {
	  	guestTypeList = nui.get("guestTypeId").getData();
	  	guestTypeList.forEach(function(v) {
	  		guestTypeHash[v.id] = v;
	      });
	  });
	    
    //init();
});
function init(callback)
{
    basicInfoForm = new nui.Form("#basicInfoForm");
    contactInfoForm = new nui.Form("#contactInfoForm");
    carInfoFrom = new nui.Form("#carInfoFrom");
    provice = nui.get("provice");
    cityId = nui.get("cityId");
    var hash = {};
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '数据加载中...'
    });
   
    var checkComplete = function()
    {
    	var keyList = ['initInsureComp','initDicts'];
        for(var i=0;i<keyList.length;i++)
        {
            if(!hash[keyList[i]])
            {
                return;
            }
        }
        setContactByIdx(0);
        setCarByIdx(0);
        nui.unmask(document.body);
        callback && callback();
    };
    initInsureComp("insureCompCode",function(){
        hash.initInsureComp = true;
        checkComplete();
    	var inlist = nui.get("insureCompCode").getData();
    	nui.get("annualInspectionCompCode").setData(inlist);
    });
    initDicts({
        //carSpec:CAR_SPEC,//车辆规格
        //kiloType:KILO_TYPE,//里程类别
        source:GUEST_SOURCE,//客户来源
        identity:IDENTITY //客户身份
    },function(){
        hash.initDicts = true;
        checkComplete();
    });
    
   
    initProvince("provice");
    nui.get("fullName").focus();
    document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27))  {  //ESC
            onCancel();
        }
     
    }
    
    
}
var carList = [{}];
var carHash = {};
var currCarIdx = 0;
function updateCarBtnState()
{
    var car = carList[currCarIdx];
    carInfoFrom.setData(car);
    //nui.get("carModelId").setText(car.carModel);
    if(car.id)
    {
        nui.get("carNo").disable();
        nui.get("vin").disable();
    }
    else{
        nui.get("carNo").enable();
        nui.get("vin").enable();
    }
    if(currCarIdx<=0)
    {
        nui.get("preCarBtn").disable();
    }
    else{
        nui.get("preCarBtn").enable();
    }
    if(currCarIdx>=(carList.length-1))
    {
        nui.get("nextCarBtn").disable();
    }
    else{
        nui.get("nextCarBtn").enable();
    }
}
function setCarByIdx(idx)
{
    if(currCarIdx>=0 && currCarIdx<carList.length)
    {
        carList[currCarIdx] = carInfoFrom.getData();
        //carList[currCarIdx].carModel = nui.get("carModelId").getText();
        carList[currCarIdx].isChanged = carInfoFrom.isChanged();
        currCarIdx = idx;
        updateCarBtnState();
    }
}
function preCar()
{
    setCarByIdx(currCarIdx-1);
}
function nextCar()
{
    setCarByIdx(currCarIdx+1);
}

var contactList = [{}];
var contactHash = {};
var currContactIdx = 0;
function updateContactBtnState()
{
    contactInfoForm.setData(contactList[currContactIdx]);
    //nui.get("carModelId").setText(contactList[currContactIdx].carModel);
    if(currContactIdx<=0)
    {
        nui.get("preContactBtn").disable();
    }
    else{
        nui.get("preContactBtn").enable();
    }
    if(currContactIdx>=(contactList.length-1))
    {
        nui.get("nextContactBtn").disable();
    }
    else{
        nui.get("nextContactBtn").enable();
    }
}
function preContact()
{
    //上一个联系人
    setContactByIdx(currContactIdx-1);
}
function nextContact()
{
    //下一个联系人
    setContactByIdx(currContactIdx+1);
}
function setContactByIdx(idx)
{
    if(idx>=0 && idx<contactList.length)
    {
        var contact = contactInfoForm.getData();
        contact.isChanged = contactInfoForm.isChanged();
        contactList[currContactIdx] = contact;
        currContactIdx = idx;
        updateContactBtnState();
    }
}
function addContact()
{
    //添加联系人
    contactList.push({});
    setContactByIdx(contactList.length-1);
}
function addCar()
{
    //添加联系人
    carList.push({});
    setCarByIdx(carList.length-1);
}
//关闭窗口
function CloseWindow(action) {
    if (action == "close" && form.isChanged()) {
        if (confirm("数据被修改了，是否先保存？")) {
            saveData();
        }
    }
    if (window.CloseOwnerWindow)
        return window.CloseOwnerWindow(action);
    else window.close();
}
//取消
function onCancel() {
    CloseWindow("cancel");
}

var basicRequiredField = {
    "fullName":"客户名称",
    "mobile":"手机号码"
}

var carRequiredField ={
    "carNo":"车牌号"
};
var contactRequiredField ={
    "name":"联系人姓名",
    "mobile":"联系人手机",
    "identity":"联系人身份",
    "source":"联系人来源"
};
var resultData = {};
var saveUrl = baseUrl+"com.hsapi.repair.repairService.crud.saveCustomerInfo.biz.ext";
function onOk()
{
	var carNo = nui.get("carNo").getValue();
	var vin = nui.get("vin").getValue();
/*    //判断VIN
    var data = {};
    data = validation(vin);
    if(data.isNo){
    	vin = data.vin//返回转化好的vin
    	nui.get("vin").setValue(vin);
    }else{
    	showMsg("VIN不规范，请确认！","W");
    	return;
    }*/
    //判断车牌号,返回是否正确，和转化后的车牌
/*	var falge = isVehicleNumber(carNo);
	nui.get("carNo").setValue(falge.vehicleNumber);
	if(!falge.result){
		showMsg("请输入正确的车牌号","W");
		return;
	}*/
		    var guest = basicInfoForm.getData();
		    guest.tgrade = guest.guestTypeId;
		    var name = guest.fullName || "";
		    if(name=="散客"){
		    	showMsg("请修改客户名称!","W");
		    	return;
		    }
		    guest.guestType = "01020103";
		    carList[currCarIdx] = carInfoFrom.getData();
		    //carList[currCarIdx].carModel = nui.get("carModelId").getText();
		    var i,key,tmp;
		    contactList[currContactIdx] = contactInfoForm.getData();
		    
		    for(key in basicRequiredField){
		        //tmp = nui.get(key).getText();
		        if(!nui.get(key).value){
		            showMsg(basicRequiredField[key]+"不能为空", "W");
		            return;
		        }
		    }
		    
		    for(i=0;i<carList.length;i++)
		    {
		        tmp = carList[i];
		        for(key in carRequiredField)
		        {
		            if(typeof carRequiredField[key] == "string" && !tmp[key])
		            {
		                showMsg(carRequiredField[key]+"不能为空", "W");
		                setCarByIdx(i);
		                return;
		            }
		        }
		    }
		    
		    for(i=0;i<contactList.length;i++)
		    {
		        tmp = contactList[i];
		        for(key in contactRequiredField)
		        {
		            if(typeof contactRequiredField[key] == "string" && !tmp[key])
		            {
		                showMsg(contactRequiredField[key]+"不能为空", "W");
		                setContactByIdx(i);
		                return;
		            }
		        }
		    }
		    
		    if(!checkMobile(nui.get("mobile").value)){
		        return;
		    }
		    
		    if(!checkMobile(nui.get("mobile2").value)){
		        return;
		    }
		    
		    var insCarList = carList.filter(function(v)
		    {
		        return !v.id;
		    });
		    var updCarList = carList.filter(function(v)
		    {
		        if(v.id)
		        {
		            var oldJson =carHash[v.id];
		            var newJson = JSON.stringify(v);
		            return oldJson !== newJson;
		        }
		    });
		    var insContactList = contactList.filter(function(v)
		    {
		        return !v.id;
		    });
		    var updContactList = contactList.filter(function(v)
		    {
		        if(v.id)
		        {
		            var oldJson = contactHash[v.id];
		            var newJson = JSON.stringify(v);
		            return oldJson !== newJson;
		        }
		    });
		    //循环判断VIN,车牌号,并判断车辆数组有没有重复车牌
		    for(var i = 0;i<insCarList.length;i++){
		    	var num = 0;//两层循环，等于2就有重复
		    	//禁用的车辆不判断车牌号Vin
		    	if(insCarList[i].isDisabled==0){
				        //判断VIN
				       var data = validation(insCarList[i].vin);
				        if(data.isNo){
				        	insCarList[i].vin = data.vin//返回转化好的vin
				        }else{
				        	showMsg("VIN不规范，请确认！","W");
				        	return;
				        }
				      //判断车牌号,返回是否正确，和转化后的车牌
				        	var falge = isVehicleNumber(insCarList[i].carNo);
				        	insCarList[i].carNo = falge.vehicleNumber//返回转化好的车牌
				        	if(!falge.result){
				        		showMsg("请输入正确的车牌号","W");
				        		return;
				        	}
		    	}
		        //循环判断车牌是否重复
		    	for(var j = 0;j<insCarList.length;j++){
		    		if(insCarList[i].carNo==insCarList[j].carNo){
		    			num = num+1;
		    			if(num==2){
			    			showMsg(insCarList[i].carNo+"在本次添加的车辆列表里存在重复","W");
			    			return;
		    			}

		    		}
		    	}
		    }

		    nui.mask({
				el : document.body,
				cls : 'mini-mask-loading',
				html : '保存中...'
			});
		    
		    $("#btnGroup").hide();
		    doPost({
		        url : saveUrl,
		        data : {
		            guest:guest,
		            insCarList:insCarList,
		            updCarList:updCarList,
		            insContactList:insContactList,
		            updContactList:updContactList
		        },
		        success : function(data)
		        {
		        	nui.unmask(document.body);
		            data = data||{};
		            if(data.errCode == "S")
		            { 
		            	var retData = data.retData;
		            	if(prebookF == "prebookF"){
		            		prebookInfo.guestId = retData.guestId;
		            	    prebookInfo.carId = retData.carId;
		            	    prebookInfo.contactorId = retData.contactorId;
		            	    prebookInfo.contactorName = retData.contactName;
		            	    prebookInfo.contactorTel = retData.mobile;
		            	    prebookInfo.carNo = retData.carNo;
		      				nui.ajax({ 
		      				      url: baseUrl + "com.hsapi.repair.repairService.booking.setBookingGuestId.biz.ext",
		      				      type: 'post',
		      				      data:JSON.stringify({
		      				          rpsPrebook:prebookInfo ,
		      				          token: token
		      				      }),        
		      				      success: function(data) {
		      				          if (data.errCode == "S") {
		      				        	  PreBook = data.rpsPrebook;
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
		                 }else{
		                	 showMsg("保存成功","S");
		                     resultData = data.retData;
		                     CloseWindow("ok");
		                 }          		
		            }
		            else{
		                showMsg(data.errMsg||"保存失败", "E");
		            }
		            $("#btnGroup").show();
		        },
		        error : function(jqXHR, textStatus, errorThrown) {
		        	nui.unmask(document.body);
		            showMsg("网络出错", "E");
		            $("#btnGroup").show();
		        }
		    });    

   
}
function getSaveData(){
	return resultData;
}
function getPreBook(){
	return PreBook;
}
var queryUrl = baseUrl+"com.hsapi.repair.repairService.svr.getGuestCarContactInfoById.biz.ext";
function setData(data)
{
	
	var carNo = null;
	var guestFullName = null;
	if(data.guest){
		carNo =data.guest.carNo;
	    guestFullName =data.guest.contactName;
	}
	if(data.hidden){
		nui.get("tabs").removeTab(0);
	}
	var count = 0;
    init(function()
    {
        if(data.guest)
        {
            var guest = data.guest;
            doPost({
                url : queryUrl,
                data : {
                    guestId:guest.guestId
                },
                success : function(data)
                {
                    data = data||{};
                    if(data.guest && data.guest.id)
                    {
                        basicInfoForm.setData(data.guest);
                        var tgrade = data.guest.tgrade;
                	    if(tgrade){
                	    	var num = parseInt(tgrade);
                	    	var tgradeName = guestTypeHash[num].name;
                	    	nui.get("guestTypeId").setText(tgradeName);
                	    	nui.get("guestTypeId").setValue(tgrade);
                	    }
                        contactList = data.contactList||[{}];
                        carList = data.carList||[{}];
                        var i;
                        for(i=0;i<carList.length;i++)
                        {
                        	if(carNo==carList[i].carNo){
                        		
                        		carInfoFrom.setData(carList[i]);
                        		currCarIdx = i;
                        	}
                            //nui.get("carModelId").setText(carList[0].carModel);
                            //carList[i] = carInfoFrom.getData();
                            //carList[i].carModel = nui.get("carModelId").getText();
                            carHash[carList[i].id] = JSON.stringify(carList[i]);
                        }
                        //nui.get("carModelId").setText(carList[0].carModel);
                        contactInfoForm.setData(contactList[0]);
                        for(i=0;i<contactList.length;i++)
                        {
                        	if(guestFullName==contactList[i].name){
                        		contactInfoForm.setData(contactList[i]);
                        		currContactIdx = i;
                        		count = 1;
                        	}
                        	
                           // contactList[i] = contactInfoForm.getData();
                            contactHash[contactList[i].id] = JSON.stringify(contactList[i]);
                        }
                        if(count==0){
                        	
                        	contactInfoForm.setData(contactList[0]);
                        }
                        setCarByIdx(currCarIdx);
                        setContactByIdx(currContactIdx);
                        
                        provice.doValueChanged();
                        cityId.doValueChanged();
                    }
                    else{
                        showMsg("获取客户信息失败", "E");
                    }
                },
                error : function(jqXHR, textStatus, errorThrown) {
                    console.log(jqXHR.responseText);
                    showMsg("网络出错", "E");
                }
            });
        }
    });
}

function setGuest(data,row){
	init(function(){
	prebookF = "prebookF";
	prebookInfo = row;
	data = data.guest;
	var guest = {
		"shortName":data.shortName,
		"fullName":data.guestFullName,
		"mobile":data.mobile
	};
	var carIn = {
		"carNo":data.carNo	
	};
	var contact = {
		"name":data.guestFullName,
		"mobile":data.mobile
	};
	basicInfoForm.setData(guest);
	carInfoFrom.setData(carIn);
	contactInfoForm.setData(contact);
	});
}


function onParseUnderpanNo()
{
    var vin = nui.get("vin").getValue();
    //判断VIN
    var data = {};
    data = validation(vin);
    nui.get("vin").setValue(data.vin);
    if(data.isNo){
        nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '车型解析中...'
        });
        getCarVinModel(vin,function(data)
        {
            data = data||{};
            if(data.errCode == "S")
            {
            	var carVinModel = data.data.SuitCar||[];//list[0];
            	var carModelId = data.data.carModelId;
                carVinModel = carVinModel[0]||{};
                carVinModel.vin = vin;
                var carModelInfo = "品牌:"+carVinModel.carBrandName+"\n";
                carModelInfo += "车型:"+carVinModel.carModelName+"\n";
                carModelInfo += "车系:"+carVinModel.carLineName+"\n";
                var name1 = carVinModel.grandParentName||"";
                name1 = name1?(name1+" "):"";
                var name2 = carVinModel.parentName || "";
                name2 = name2?(name2+" "):"";
                var name3 = carVinModel.name||"";
                nui.get("carModel").setValue(name1 + name2 + name3);
                nui.get("carBrandId").setValue("");
                nui.get("carModelId").setValue(carVinModel.id);
                nui.get("carModelIdLy").setValue(carModelId);
                nui.unmask(document.body);
            }else{
            	nui.unmask(document.body);
            	showMsg("车型解析失败，请手工维护车型信息！","W");
            }
        });
    }else{
    	showMsg("VIN不规范，请确认！","W");
    	return;
    }


}

//手机号处理
function processMobile(mobile){
    if(checkMobile(mobile)){
        if(!nui.get("mobile2").value){
            nui.get("mobile2").setValue(mobile);
        }
    }
}
function onInsureChange(e){
	//var value = e.value;
	var row = e.selected;
	var shortName = row.shortName;
	nui.get('insureCompName').setValue(shortName);
}

function getCarModel(callBack) {
	nui.open({
		//// targetWindow: window,,
		url : "com.hsweb.repair.common.carModelSelect.flow",
		title : "选择车型",
		width : 900,
		height : 600,
		allowDrag : true,
		allowResize : false,
		onload : function() {
		},
		ondestroy : function(action) {
			if (action == "ok") {
				var iframe = this.getIFrameEl();
				var data = iframe.contentWindow.getData();
				if (data && data.carModel) {
					var carModel = data.carModel || {};
                    callBack && callBack(carModel);
					/*if (elId && nui.get(elId)) {
						nui.get(elId).setValue(carModel.id);
						nui.get(elId).setText(carModel.carModel);
					}
					if (carBrandId && nui.get(carBrandId)) {
						nui.get(carBrandId).setValue(carModel.carBrandId);
						if (nui.get(carBrandId).doValueChanged) {
							nui.get(carBrandId).doValueChanged();
						}
					}
					if (carModelId && nui.get(carModelId)) {
						nui.get(carModelId).setValue(carModel.id);
					}*/
				}
			}
		}
	});
}


//设置车型
function setCarModel(data){
	var d = data.carModel;
    nui.get("carModel").setValue(data.carModel);
}

/*function onCarNoChanged(e){
	var falge = isVehicleNumber(e.value);
	if(!falge){
		nui.get("#carNo").setValue("");
		showMsg("请输入正确的车牌号","W");
		return;
	}
}*/

/*function isVehicleNumber(vehicleNumber) {
    var result = false;
    if (vehicleNumber.length == 7){
      var express = /^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$/;
      result = express.test(vehicleNumber);
    }
    return result;
}*/

var queryGuestUrl = apiPath + repairApi + "/com.hsapi.repair.repairService.svr.queryCustomerList.biz.ext";
var queryGuestListUrl = apiPath + repairApi + "/com.hsapi.repair.repairService.svr.queryCustomerListByMobile.biz.ext";
var mobileF = null;
var n = 1;
function onChanged(id){
	if(id=="fullName"){
		fullName = nui.get("fullName").value;
		nui.get("shortName").setValue(fullName);
		nui.get("name2").setValue(fullName);
	}
	if(id=="mobile"){
		var mobile = nui.get("mobile").value;
		mobile = mobile.replace(/\s*/g,"");
		nui.get("mobile2").setValue(mobile);
		if(mobileF == mobile && n==0){
			return;
		}else{
			mobileF = mobile;
			n = 0;
		}
		var params = 
		      {
		        "mobile":mobile
		      };
		if(mobile.length==11){
			nui.mask({
		        el : document.body,
			    cls : 'mini-mask-loading',
			    html : '加载中...'
		    });
			nui.ajax({
				url : queryGuestListUrl,
				type : "post",
				data : JSON.stringify({
					params:params,
					token: token
				}),
			success:function(data) {
					nui.unmask(document.body);
					var list = data.list;
					if(list.length){
						nui.confirm("是否添加到手机号为"+mobile+"的客户下？", "友情提示",function(action){
							if(action == "ok"){
								if(list.length>1){
									nui.open({
										//// targetWindow: window,,
										url :webBaseUrl + "repair/common/subpage/customerSubpage/guestShow.jsp",
										title : "选择客户",
										width : 900,
										height : 300,
										allowDrag : true,
										allowResize : false,
										onload : function() {
											var iframe = this.getIFrameEl();
											var data = iframe.contentWindow.setData(list);
										},
										ondestroy : function(action) {
											if (action == "ok") {
												var iframe = this.getIFrameEl();
												var data = iframe.contentWindow.getData();
												setDataQuery(data);
												}
											}
									})
								}else{
									var data = list[0];
									setDataQuery(data);
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
  }
}
function setDataQuery(data)
{
	carList = [{}];
	carHash = {};
	currCarIdx = 0;
	var guestFullName = null;
	if(data){
	    guestFullName =data.guestFullName;
	}
	var count = 0;
	if(data)
    {
        var guest = data;
        doPost({
            url : queryUrl,
            data : {
                guestId:guest.id
            },
            success : function(data)
            {
                data = data||{};
                if(data.guest && data.guest.id)
                {
                    basicInfoForm.setData(data.guest);
                    var tgrade = data.guest.tgrade;
            	    if(tgrade){
            	    	var num = parseInt(tgrade);
            	    	var tgradeName = guestTypeHash[num].name;
            	    	nui.get("guestTypeId").setText(tgradeName);
            	    	nui.get("guestTypeId").setValue(tgrade);
            	    }
                    contactList = data.contactList||[{}];
                    carList = data.carList||[{}];
                    var i;
                    for(i=0;i<carList.length;i++)
                    {
                    	if(i==0){
                    		carInfoFrom.setData(carList[i]);
                    		currCarIdx = i;
                    	}
                        carHash[carList[i].id] = JSON.stringify(carList[i]);
                    }
                    contactInfoForm.setData(contactList[0]);
                    for(i=0;i<contactList.length;i++)
                    {
                    	if(guestFullName==contactList[i].name){
                    		contactInfoForm.setData(contactList[i]);
                    		currContactIdx = i;
                    		count = 1;
                    	}
                        contactHash[contactList[i].id] = JSON.stringify(contactList[i]);
                    }
                    if(count==0){
                    	contactInfoForm.setData(contactList[0]);
                    }
                    setCarByIdx(currCarIdx);
                    setContactByIdx(currContactIdx);
                    
                    provice.doValueChanged();
                    cityId.doValueChanged();
                }
                else{
                    showMsg("获取客户信息失败", "E");
                }
            },
            error : function(jqXHR, textStatus, errorThrown) {
                console.log(jqXHR.responseText);
                showMsg("网络出错", "E");
            }
        });
    }

}

function getWalkGuest(){
	var car = carList[0];
	var guest = basicInfoForm.getData();
	var data = {};
	data.guestId = guest.id;
	data.guestFullName = guest.fullName;
	data.mobile = guest.mobile;
	if(car){
		data.carNo = car.carNo;
		data.carVin = car.carVin;
	}
	return data;
} 

function delet(){
	carList = [{}];
	carHash = {};
	currCarIdx = 0;
	contactList = [{}];
	contactHash = {};
	currContactIdx = 0;
	contactInfoForm.setData([]);
	nui.get("#identity").setValue("060301");
	nui.get("#source").setValue("060110");
	nui.get("#sex").setValue("0");
	carInfoFrom.setData([]);
    basicInfoForm.setData([]);
    nui.get("#guestSex").setValue("0");
}
