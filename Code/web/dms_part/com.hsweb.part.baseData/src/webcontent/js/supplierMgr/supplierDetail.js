/**
 * Created by Administrator on 2018/1/23.
 */

var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var basicInfoForm = null;
var contactInfoForm = null;
var financeInfoForm = null;
var otherInfoForm = null;

function initForm(){
    basicInfoForm = new nui.Form("#basicInfoForm");
    contactInfoForm = new nui.Form("#contactInfoForm");
    financeInfoForm = new nui.Form("#financeInfoForm");
    otherInfoForm = new nui.Form("#otherInfoForm");
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
});

function onValueChanged(){

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
    fullName:"供应商全称",
    billTypeId:"票据类型",
    settTypeId:"结算方式",
    manager:"联系人",
    mobile:"手机",
    provinceId:"省份",
    cityId:"城市"
};
var saveUrl = baseUrl + "com.hsapi.part.baseDataCrud.crud.saveSupplier.biz.ext";
function onOk()
{
    var dataList = [];
    dataList[0] = basicInfoForm.getData();
    dataList[1] = contactInfoForm.getData();
    dataList[2] = financeInfoForm.getData();
    dataList[3] = otherInfoForm.getData();
    var data = {};
    for(var i=0;i<dataList.length;i++)
    {
        for(var key in dataList[i])
        {
            if(typeof dataList[i][key] == "string"){
                data[key] = dataList[i][key]
            }
        }
    }
    data.isClient = nui.get("isClient").getValue();
    data.isSupplier = nui.get("isSupplier").getValue();
    data.isDisabled = nui.get("isDisabled").getValue();
    console.log(data);
    for(var key in requiredField)
    {
        if(!data[key] || data[key].trim().length==0)
        {
            nui.alert(requiredField[key]+"不能为空");
            return;
        }
    }
    nui.mask({
        html:'保存中...'
    });
    nui.ajax({
        url:saveUrl,
        type:"post",
        data:JSON.stringify({
            supplier:data
        }),
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                nui.alert("保存成功");
                CloseWindow("ok");
            }
            else{
                nui.alert(data.errMsg||"保存失败");
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
var supplierTypeList = [];
var supplierTypeHash = {};
function setData(data)
{
    provinceList = data.province||[];
    provinceList.forEach(function(v){
        provinceHash[v.id] = v;
    });
    if(!provinceEl)
    {
        provinceEl = nui.get("provinceId");
    }
    provinceEl.setData(provinceList);
    cityList = data.city||[];
    cityList.forEach(function(v){
        cityHash[v.id] = v;
    });
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
    supplierTypeList = data.supplierType||[];
    supplierTypeList.forEach(function(v){
        supplierTypeHash[v.customid] = v;
    });
    billTypeId.setData(billTypeIdList);
    settTypeId.setData(settTypeIdList);
    supplierType.setData(supplierTypeList);
    managerDuty.setData(managerDutyList);
    tgrade.setData(tgradeList);
    console.log(data);
    if(data.supplier)
    {
        if(!basicInfoForm)
        {
            initForm();
        }
        var supplier = data.supplier;
        basicInfoForm.setData(supplier);
        contactInfoForm.setData(supplier);
        financeInfoForm.setData(supplier);
        otherInfoForm.setData(supplier);
        onProvinceSelected("cityId");
        contactInfoForm.setData(supplier);
        nui.get("isClient").setValue(supplier.isClient);
        nui.get("isSupplier").setValue(supplier.isSupplier);
        nui.get("isDisabled").setValue(supplier.isDisabled);
    }
}