var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var contactInfoForm = null;
var carInfoFrom = null;
var basicInfoForm = null;
var provice;
var cityId;
var data;
var carview = null;
var cardatagrid = null;
var contactview = null;
var contactdatagrid = null;
var contactInfoForm = null;
var lyData = [];
var sfData = [];
var fullName = null;
var mobile = null;
var resultGuest = {};
var resultCar = {};
var resultContact= {};
$(document).ready(function()
{
	carview = nui.get("carview");
	carview.hide();
	contactview = nui.get("contactview");
	contactview.hide();
	cardatagrid = nui.get("cardatagrid");
	contactdatagrid = nui.get("contactdatagrid");
	carInfoFrom = new nui.Form("#carInfoFrom");
	contactInfoForm = new nui.Form("#contactInfoForm");
	basicInfoForm = new nui.Form("#basicInfoForm");
	//nui.get("name").focus();
	
	if(currRepairBillCmodelFlag == "1"){
        nui.get("carModel").disable();
    }else{
        nui.get("carModel").enable();
    }
	
	nui.get("name").focus();
	document.onkeyup=function(event){
        
		var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下
        if((keyCode==27))  {  //ESC
            onCancel();
            
        }
      };
	
});
function init(callback)
{
	var addEditCustomerPage = nui.get("addEditCustomerPage");
    basicInfoForm = new nui.Form("#basicInfoForm");
    contactInfoForm = new nui.Form("#contactInfoForm");
    carInfoFrom = new nui.Form("#carInfoFrom");
    provice = nui.get("provice");
    cityId = nui.get("cityId");
    
    var hash = {};
    addEditCustomerPage.mask({
        html:'数据加载中..'
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
        addEditCustomerPage.unmask();
        callback && callback();
    };
/*    initInsureComp("insureCompCode",function(){
        hash.initInsureComp = true;
        checkComplete();
    });*/
    initInsureComp("annualInspectionCompCode",function(){
        hash.initInsureComp = true;
        checkComplete();
    	var inlist = nui.get("annualInspectionCompCode").getData();
    	nui.get("insureCompCode").setData(inlist);
    });
    initDicts({
        //carSpec:CAR_SPEC,//车辆规格
        //kiloType:KILO_TYPE,//里程类别
        source:GUEST_SOURCE,//客户来源
        identity:IDENTITY //客户身份
    },function(data){
        hash.initDicts = true;
        checkComplete();
        lyData  = nui.get("source").data;
        sfData = nui.get("identity").data;
    });
    
    initProvince("provice");
}
var carList = [{}];
var carHash = {};
var currCarIdx = 0;

function setCarByIdx(idx)
{
    if(currCarIdx>=0 && currCarIdx<carList.length)
    {
        carList[currCarIdx] = carInfoFrom.getData();
        //carList[currCarIdx].carModel = nui.get("carModelId").getText();
        carList[currCarIdx].isChanged = carInfoFrom.isChanged();
        currCarIdx = idx;
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
    }
}
function addContact()
{
    //添加联系人
    contactList.push({});
    setContactByIdx(contactList.length-1);
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

/*var carRequiredField ={
    "carNo":"车牌号",
    "vin":"车架号"
};*/
/*var contactRequiredField ={
    "name":"联系人姓名",
    "mobile":"联系人手机",
    "identity":"联系人身份",
    "source":"联系人来源"
};*/

var saveUrl = baseUrl+"com.hsapi.repair.repairService.crud.saveCustomerInfo.biz.ext";
function onOk()
{
    var guest = basicInfoForm.getData();
    guest.guestType = "01020103";
  
    for(key in basicRequiredField){
        //tmp = nui.get(key).getText();
        if(!nui.get(key).value){
            showMsg(basicRequiredField[key]+"不能为空", "W");
            return;
        }
    }
    
    if(!checkMobile(nui.get("mobile").value)){
        return;
    }
    
/*    var insCarList = carList.filter(function(v)
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
    });*/

    var insCarList = [];
    var updCarList = [];
    var insContactList = [];
    var updContactList = [];
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
                showMsg("保存成功","S");
                resultGuest = data.retData;
                nui.get("guestId").setValue(resultGuest.guestId);
                //CloseWindow("ok");
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
var queryUrl = baseUrl+"com.hsapi.repair.repairService.svr.getGuestCarContactInfoById.biz.ext";
function setData(data)
{
	var carNo = null;
	var guestFullName = null;
	if(data.guest){
		resultGuest.guestId=data.guest.guestId;
		carNo =data.guest.carNo;
	    guestFullName =data.guest.guestFullName;
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
                        initCityByParent('cityId', data.guest.provinceId || -1);
                        initCityByParent('areaId', data.guest.cityId || -1);
                        contactList = data.contactList||[{}];
                        carList = data.carList||[{}];
                        cardatagrid.addRows(carList);
                        contactdatagrid.addRows(contactList);

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
function onParseUnderpanNo()
{
    var vin = nui.get("vin").getValue();
    if(!vin)
    {
        return;
    }
    getCarVinModel(vin,function(data)
    {
        data = data||{};
        if(data.errCode == "S")
        {
            //var list = data.rs||[];
            var carVinModel = data.data.SuitCar||[];//list[0];
            var carModelId = data.data.carModelId;
            carVinModel = carVinModel[0]||{};
            carVinModel.vin = vin;
         //   nui.get("carBrandId").setValue(carVinModel.carBrandId);
         //   nui.get("carModelId").setValue(carVinModel.carModelId);
         //   nui.get("carModelId").setText(carVinModel.carModelName);
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
        }
    });
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
function onannualInsureChange(e){
	//var value = e.value;
	var row = e.selected;
	var shortName = row.shortName;
	nui.get('annualInspectionCompName').setValue(shortName);
}
function getCarModel(callBack) {
	nui.open({
		targetWindow : window,
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

function onChanged(id){
	if(id=="fullName"){
		fullName = nui.get("fullName").value;
		nui.get("shortName").setValue(fullName);
		
	}
	if(id=="mobile"){
		mobile = nui.get("mobile").value;
		
	}
	
	
}

function addCar() {
	var id = basicInfoForm.getData().id;
	if(id==""||id==null){
		showMsg("请先保存客户信息!","W");
		return;
	}
	nui.get("carNo").enable();
	nui.get("vin").enable();
	carInfoFrom.setData("");
	carview.show();
}

function addContact() {
	var id = basicInfoForm.getData().id;
	if(id==""||id==null){
		showMsg("请先保存客户信息!","W");
		return;
	}
	contactview.show();
	contactInfoForm.setData("");
	nui.get("name").setValue(fullName);
	nui.get("mobile2").setValue(mobile);
}

function addCarList(){
	var guest = {};
	nui.get("carNo").enable();
	nui.get("vin").enable();
	var updCarList=[];
	var insCarList = [];
	var insContactList=[];
	var updContactList = [];
	var car = carInfoFrom.getData();
	if(car.carNo==""||car.vin==""){
		showMsg("车牌号和车架号(VIN)不能为空!","W");
		return;
	}else{

		 guest = basicInfoForm.getData();
    	guest.id = resultGuest.guestId;
    for(key in basicRequiredField){
        if(!nui.get(key).value){
            showMsg(basicRequiredField[key]+"不能为空!", "W");
            return;
        }
    }
    
    if(!checkMobile(nui.get("mobile").value)){
        return;
    }
    
    if(car.id==""||car.id==null){
    	 insCarList = [car];

    }else{
    	 updCarList = [car];
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
                showMsg("保存成功","S");
                resultCar = data.retData;
                var newRow = {
            	id : resultCar.carId,
            	guestId : resultCar.guestId,
				carNo : car.carNo,
				vin : car.vin,
				carModel : car.carModel,
				engineNo :car.engineNo,
				annualVerificationDueDate :car.annualVerificationDueDate,
				insureCompCode:car.insureCompCode,
				insureCompName:car.insureCompName,
				annualInspectionCompCode :car.annualInspectionCompCode,
				annualInspectionCompName :car.annualInspectionCompName,
				annualInspectionNo:car.annualInspectionNo,
				annualInspectionDate:car.annualInspectionDate,
				insureNo:car.insureNo,
				insureDueDate:car.insureDueDate,
				produceDate:car.produceDate,	
				firstRegDate:car.firstRegDate,
				issuingDate:car.issuingDate
			};
                var cargrid = cardatagrid.getData();
                for(var i = 0 ;i<cargrid.length;i++){
                	if(cargrid[i].id==car.id){
                		cardatagrid.removeRow(cargrid[i]);
                	}
                }
                cardatagrid.addRow(newRow);
       			carview.hide();
                //CloseWindow("ok");
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

}

function addContactList(){
	var updCarList=[];
	var insCarList = [];
	var insContactList=[];
	var updContactList = [];
	var contact = contactInfoForm.getData();
	if(contact.identity==""||contact.source==""){
		showMsg("身份和来源不能为空!","W");
		return;
	}else{

		var guest = basicInfoForm.getData();
    	guest.id = resultGuest.guestId;
    for(key in basicRequiredField){
        if(!nui.get(key).value){
            showMsg(basicRequiredField[key]+"不能为空", "W");
            return;
        }
    }
    
    if(!checkMobile(nui.get("mobile").value)){
        return;
    }
    
    if(contact.id==""||contact.id==null){
    	insContactList = [contact];

    }else{
    	updContactList = [contact];
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
                showMsg("保存成功","S");
                resultContact = data.retData;
        		var newRow = {
        				id:resultContact.contactorId,
        				guestId:resultContact.guestId,
        				name : contact.name,
        				sex : contact.sex,
        				mobile : contact.mobile,
        				identity :contact.identity,
        				source :contact.source,
        				drivingLicenceDueDate:contact.drivingLicenceDueDate,	
        				birthdayType:contact.birthdayType,
        				birthday:contact.birthday,
        				idNo:contact.idNo,
        				remark:contact.remark

        			};
                var contactid = contactdatagrid.getData();
                for(var i = 0 ;i<contactid.length;i++){
                	if(contactid[i].id==contact.id){
                		contactdatagrid.removeRow(contactid[i]);
                	}
                }
        		contactdatagrid.addRow(newRow);
        		contactview.hide();
                //CloseWindow("ok");
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


}

function remove(){
	var row = cardatagrid.getSelected();
	cardatagrid.removeRow(row);
	
}
function eaidCar(){
	var row = cardatagrid.getSelected();
	if(row==null){
		showMsg("请选择车辆!","W");
		return;
	}
	//cardatagrid.removeRow(row);
	carview.show();
	carInfoFrom.setData(row);
	nui.get("carNo").disable();
	nui.get("vin").disable();
	
}

function eaidContact(){
	var row = contactdatagrid.getSelected();
	if(row==null){
		showMsg("请选择联系人!","W");
		return;
	}
	//contactdatagrid.removeRow(row);
	contactview.show();
	contactInfoForm.setData(row);
}

function onDrawCell(e) {
	var sexList = new Array("男", "女", "未知");
	var birthdayTypeList = new Array("农历", "阴历");
	switch (e.field) {
	case "sex":
		e.cellHtml = sexList[e.value];
		break;
	case "birthdayType":
		e.cellHtml = birthdayTypeList[e.value];
		break;


	}
	if(e.field=="source"){
		for(var i=0;i<lyData.length;i++){
			if(e.value==lyData[i].customid){
				e.cellHtml = lyData[i].name;
			}
		}
	}
	if(e.field=="identity"){
		for(var i=0;i<sfData.length;i++){
			if(e.value==sfData[i].customid){
				e.cellHtml =sfData[i].name;
			}
		}
	}
}

function onClose(e){
	if(e==1){		
		contactview.hide();
	}else{	
		carview.hide();
	}
}

function onCarNoChanged(e){
	var falge = isVehicleNumber(e.value);
	if(!falge){
		nui.get("#carNo").setValue("");
		showMsg("请输入正确的车牌号","W");
		return;
	}
}

function isVehicleNumber(vehicleNumber) {
    var result = false;
    if (vehicleNumber.length == 7){
      var express = /^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$/;
      result = express.test(vehicleNumber);
    }
    return result;
}







