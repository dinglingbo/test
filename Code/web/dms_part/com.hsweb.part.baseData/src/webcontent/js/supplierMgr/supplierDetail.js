/**
 * Created by Administrator on 2018/1/23.
 */

var baseUrl = apiPath + partApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var mainForm = null;
var otherForm = null;

function initForm(){
    mainForm = new nui.Form("#mainForm");
    otherForm = new nui.Form("#otherForm");
}
var billTypeId = null;
var settTypeId = null;
var supplierType = null;
var managerDuty = null;
var tgrade = null;
function initComboBox()
{
    provinceEl = nui.get("provinceId");
    billTypeId = nui.get("billTypeId");
    settTypeId = nui.get("settTypeId");
    supplierType = nui.get("supplierType");
    managerDuty = nui.get("managerDuty");
    tgrade = nui.get("tgrade");
}
$(document).ready(function(v)
{
	initComboBox();
    initForm();
    nui.get("code").focus();
	document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27))  {  //ESC
            onCancel();
        }
      };
});

function onValueChanged(){
	var value = nui.get("isInternal").getValue();
    if(value == 1)
    {
        nui.get("fullName").hide();
        nui.get("fullName1").show();
    }
    else{
        nui.get("fullName1").hide();
        nui.get("fullName").show();
    }
}

function format(time, format) {
    var t = new Date(time);
    var tf = function (i) { return (i < 10 ? '0' : '') + i; };
    return format.replace(/yyyy|MM|dd|HH|mm|ss/g, function(a) {
    switch (a) {
    case 'yyyy':
    return tf(t.getFullYear());
    break;
    case 'MM':
    return tf(t.getMonth() + 1);
    break;
    case 'mm':
    return tf(t.getMinutes());
    break;
    case 'dd':
    return tf(t.getDate());
    break;
    case 'HH':
    return tf(t.getHours());
    break;
    case 'ss':
    return tf(t.getSeconds());
    break;
    }
    });
}
function CloseWindow(action) {
    //if (action == "close" && form.isChanged()) {
    //    if (confirm("数据被修改了，是否先保存？")) {
    //        return false;
    //    }
    //}
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}
var requiredField = {
    code:"供应商编码",
    shortName:"供应商简称",
    fullName:"供应商全称",
    billTypeId:"票据类型",
    settTypeId:"结算方式",
    manager:"联系人",
    mobile:"联系人手机",
    provinceId:"省份",
    cityId:"城市"
};
var saveUrl = baseUrl + "com.hsapi.part.baseDataCrud.crud.saveSupplier.biz.ext";
function onOk()
{
	mainForm.validate();
	if (mainForm.isValid() == false)
		return;
    var dataList = [];
    dataList[0] = mainForm.getData();
    dataList[1] = otherForm.getData();
    var data = {};
    for(var i=0;i<dataList.length;i++)
    {
        for(var key in dataList[i])
        {
        	if(typeof dataList[i][key] != "function"){
                data[key] = dataList[i][key]
            }
        }
    }
    data.isClient = nui.get("isClient").getValue();
    data.isSupplier = nui.get("isSupplier").getValue();
    data.isDisabled = nui.get("isDisabled").getValue();
    data.isInternal = nui.get("isInternal").getValue();
    data.mobile=nui.get('mobile').getValue();
    
    
    if(data.isInternal == 1)
    {
        if(!data.fullName1)
        {
            parent.showMsg("请选择公司","W");
            return;
        }
        data.isInternalId = data.fullName1;
        data.fullName = nui.get("fullName1").getText();
    }
    else{
        data.isInternalId = "";
    }
    
    for(var key in requiredField)
    {
        if(!data[key] || data[key].trim().length==0)
        {
            parent.showMsg(requiredField[key]+"不能为空","W");
            return;
        }
    }

    /*var reg=/^[1](3|4|5|7|8)\d{9}$/;
    if(data.mobile.length!=11 ||!reg.test(data.mobile) ){
    	parent.showMsg("请输入正确的联系人手机号码","W");
    	return;
    }*/
    
    if(data.contactorTel.length>0){    	
    	if(data.contactorTel.length!=11 ||!reg.test(data.contactorTel) ){
    		parent.showMsg("请输入正确的业务员手机号码","W");
    		return;
    	}
    }
    
    if (data.modifyDate) {
        data.modifyDate = format(data.modifyDate, 'yyyy-MM-dd HH:mm:ss');
    }

    nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '保存中...'
    });
    nui.ajax({
        url:saveUrl,
        type:"post",
        data:JSON.stringify({
            supplier:data,
            token:token
        }),
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                parent.showMsg("保存成功","S");
                CloseWindow("ok");
            }
            else{
                parent.showMsg(data.errMsg||"保存失败","E");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}

var tgradeList = [];
var tgradeHash = {};
var billTypeIdList = [];
var billTypeIdHash = {};
var settTypeIdList = [];
var settTypeIdHash = {};
var managerDutyList = [];
var managerDutyHash = {};
var guestTypeList = [];
var guestTypeHash = {};
function setData(data)
{

    provinceList = data.province||[];
    if(provinceList.length == 0){
        getProvinceAndCity(function(data){
            provinceList.forEach(function(v){
                provinceHash[v.code] = v;
            });
            if(!provinceEl)
            {
                provinceEl = nui.get("provinceId");
            }
            provinceEl.setData(provinceList);
            cityList.forEach(function(v){
                cityHash[v.code] = v;
            });
        });
    }else {
        provinceList.forEach(function(v){
            provinceHash[v.code] = v;
        });
        if(!provinceEl)
        {
            provinceEl = nui.get("provinceId");
        }
        provinceEl.setData(provinceList);
        cityList = data.city||[];
        cityList.forEach(function(v){
            cityHash[v.code] = v;
        });
    }
    tgradeList = data.tgrade||[];
    tgradeList.forEach(function(v){
        tgradeHash[v.customid] = v;
    });
    billTypeIdList = data.billTypeId||[];
    billTypeIdList.forEach(function(v){
        billTypeIdHash[v.customid] = v;
    });
    settTypeIdList = data.settTypeId||[];
    settTypeIdList.forEach(function(v){
        settTypeIdHash[v.customid] = v;
    });
    managerDutyList = data.managerDuty||[];
    managerDutyList.forEach(function(v){
        managerDutyHash[v.customid] = v;
    });
    guestTypeList = data.supplierType||[];
    guestTypeList.forEach(function(v){
        guestTypeHash[v.customid] = v;
    });
    billTypeId.setData(billTypeIdList);
    settTypeId.setData(settTypeIdList);
    supplierType.setData(guestTypeList);
    managerDuty.setData(managerDutyList);
    tgrade.setData(tgradeList);

    if(!mainForm)
    {
        initForm();
    }
    if(data.supplier)
    {
        var supplier = data.supplier;
        mainForm.setData(supplier);
        otherForm.setData(supplier);

        onProvinceSelected("cityId");
        //contactInfoForm.setData(supplier);
        nui.get('cityId').setValue(supplier.cityId);
        nui.get("isClient").setValue(supplier.isClient);
        nui.get("isSupplier").setValue(supplier.isSupplier);
        nui.get("isDisabled").setValue(supplier.isDisabled);
        nui.get("isInternal").setValue(supplier.isInternal);
        if(supplier.isInternal == 1)
        {
            nui.get("fullName").hide();
            nui.get("fullName1").show();
            nui.get("fullName1").setValue(supplier.isInternalId);
            nui.get("fullName1").setText(supplier.fullName);
        }
    }
    else{
        mainForm.setData({
            code:currentTimeMillis
        });
    }
}