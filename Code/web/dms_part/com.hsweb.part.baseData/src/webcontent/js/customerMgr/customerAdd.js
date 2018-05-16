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
var managerDuty = null;
var tgrade = null;
function initComboBox()
{
    provinceEl = nui.get("provinceId");
    billTypeId = nui.get("billTypeId");
    settTypeId = nui.get("settTypeId");
    //managerDuty = nui.get("managerDuty");
    tgrade = nui.get("tgrade");
}
$(document).ready(function(v)
{
	initComboBox();
    initForm();
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
	    code:"客户编码",
	    shortName:"客户简称",
	    fullName:"客户全称",
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
	    if(data.isInternal == 1)
	    {
	    	if(!data.fullName1)
	        {
	            nui.alert("请选择公司");
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
	            nui.alert(requiredField[key]+"不能为空");
	            return;
	        }
	    }

	    if (data.modifyDate) {
	        data.modifyDate = format(data.modifyDate, 'yyyy-MM-dd HH:mm:ss');
	    }
	    /*if(data.isEdit != "Y")
	    {
	        data.guestType = '01020102';
	    }*/

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
	//var managerDutyList = [];
	//var managerDutyHash = {};
	function setData(data)
	{
	    provinceList = data.province||[];
	    provinceList.forEach(function(v){
	        provinceHash[v.code] = v;
	    });
	    if(!provinceEl)
	    {
	        initComboBox();
	    }
	    provinceEl.setData(provinceList);
	    cityList = data.city||[];
	    cityList.forEach(function(v){
	        cityHash[v.code] = v;
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
	    /*managerDutyList = data.managerDuty||[];
	    managerDutyList.forEach(function(v){
	        managerDutyHash[v.customid] = v;
	    });*/
	    billTypeId.setData(billTypeIdList);
	    settTypeId.setData(settTypeIdList);
	    /*managerDuty.setData(managerDutyList);*/
	    tgrade.setData(tgradeList);
	 
	    if(!mainForm)
	    {
	        initForm();
	    }
	    if(data.supplier)
	    {
	        var supplier = data.supplier;
	        supplier.isEdit="Y";
	        mainForm.setData(supplier);
	        otherForm.setData(supplier);

	        onProvinceSelected("cityId");
	      
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

