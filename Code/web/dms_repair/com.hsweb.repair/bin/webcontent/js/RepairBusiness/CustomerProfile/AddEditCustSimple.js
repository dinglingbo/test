var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
$(document).ready(function()
{
//    init();
});
var contactInfoForm = null;
var carInfoFrom = null;
var basicInfoForm = null;
function init(callback)
{
	var addEditCustomerPage = nui.get("addEditCustomerPage");
    basicInfoForm = new nui.Form("#basicInfoForm");
    contactInfoForm = new nui.Form("#contactInfoForm");
    carInfoFrom = new nui.Form("#carInfoFrom");
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
}
var carList = [{}];
var carHash = {};
var currCarIdx = 0;
function updateCarBtnState()
{
    var car = carList[currCarIdx];
    carInfoFrom.setData(car);
    nui.get("carModelId").setText(car.carModel);
    if(car.id)
    {
        nui.get("carNo").disable();
    }
    else{
        nui.get("carNo").enable();
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
        carList[currCarIdx].carModel = nui.get("carModelId").getText();
        carList[currCarIdx].isChanged = carInfoFrom.isChanged();
        currCarIdx = idx;
        updateCarBtnState()
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
    nui.get("carModelId").setText(contactList[currContactIdx].carModel);
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
var carRequiredField ={
    "carNo":"车牌号",
    "underpanNo":"车架号"
};
var contactRequiredField ={
    "name":"姓名",
    "mobile":"手机",
    "identity":"身份",
    "source":"来源"
};
var saveUrl = baseUrl+"com.hsapi.repair.repairService.crud.saveCustomerInfo.biz.ext";
function onOk()
{
    var guest = basicInfoForm.getData();
    guest.guestType = "01020103";
    carList[currCarIdx] = carInfoFrom.getData();
    carList[currCarIdx].carModel = nui.get("carModelId").getText();
    var i,key,tmp;
    for(i=0;i<carList.length;i++)
    {
        tmp = carList[i];
        for(key in carRequiredField)
        {
            if(typeof carRequiredField[key] == "string" && !tmp[key])
            {
            	showMsg(carRequiredField[key]+"不能为空","W");
                setCarByIdx(i);
                return;
            }
        }
    }
    contactList[currContactIdx] = contactInfoForm.getData();
    for(i=0;i<contactList.length;i++)
    {
        tmp = contactList[i];
        for(key in contactRequiredField)
        {
            if(typeof contactRequiredField[key] == "string" && !tmp[key])
            {
            	showMsg(contactRequiredField[key]+"不能为空","W");
                setContactByIdx(i);
                return;
            }
        }
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
            data = data||{};
            if(data.errCode == "S")
            {
            	showMsg("保存成功","S");
                CloseWindow("ok");
            }
            else{
                showMsg(data.errMsg||"保存失败","E");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            showMsg("网络出错","E");
        }
    });
}
var queryUrl = baseUrl+"com.hsapi.repair.repairService.svr.getGuestCarContactInfoById.biz.ext";
function setData(data)
{
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
                        contactList = data.contactList||[{}];
                        carList = data.carList||[{}];
                        var i;
                        for(i=0;i<carList.length;i++)
                        {
                            carInfoFrom.setData(carList[i]);
                            nui.get("carModelId").setText(carList[0].carModel);
                            carList[i] = carInfoFrom.getData();
                            carList[i].carModel = nui.get("carModelId").getText();
                            carHash[carList[i].id] = JSON.stringify(carList[i]);
                        }
                        carInfoFrom.setData(carList[0]);
                        nui.get("carModelId").setText(carList[0].carModel);
                        contactInfoForm.setData(contactList[0]);
                        for(i=0;i<contactList.length;i++)
                        {
                            contactInfoForm.setData(contactList[i]);
                            contactList[i] = contactInfoForm.getData();
                            contactHash[contactList[i].id] = JSON.stringify(contactList[i]);
                        }
                        contactInfoForm.setData(contactList[0]);
                        setCarByIdx(0);
                        setContactByIdx(0);
                    }
                    else{
                    	showMsg("获取客户信息失败","E");
                    }
                },
                error : function(jqXHR, textStatus, errorThrown) {
                    //  nui.alert(jqXHR.responseText);
                    console.log(jqXHR.responseText);
                    showMsg("网络出错","E");
                }
            });
        }
    });

}
function onParseUnderpanNo()
{
    var vin = nui.get("underpanNo").getValue();
    if(!vin)
    {
        return;
    }
    getCarVinModel(vin,function(data)
    {
        data = data||{};
        if(data.errCode == "S")
        {
            var list = data.rs||[];
            var carVinModel = list[0];
            carVinModel = carVinModel||{};
            carVinModel.vin = vin;
            console.log(carVinModel);
         //   nui.get("carBrandId").setValue(carVinModel.carBrandId);
         //   nui.get("carModelId").setValue(carVinModel.carModelId);
         //   nui.get("carModelId").setText(carVinModel.carModelName);
            var carModelInfo = "品牌:"+carVinModel.carBrandName+"\n";
            carModelInfo += "车型:"+carVinModel.carModelName+"\n";
            carModelInfo += "车系:"+carVinModel.carLineName+"\n";
            nui.get("carModelInfo").setValue(carModelInfo);
            //getCarModelByBrandId(carVinModel.carBrandId,function(data){
            //    console.log(data);
            //},carVinModel.carModelId);
        }
    });
}