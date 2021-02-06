/**
 * Created by Administrator on 2018/1/23.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var logisticsUrl = baseUrl + "com.hsapi.part.baseDataCrud.crud.getLogisticsByGuestId.biz.ext";
var mainForm = null;
var otherForm = null;
var logisticsGrid = null;
var editLogisticsForm = null;

var provinceHash = {};
var cityHash = {};
var countyHash = {};
var aprovinceEl = null;
var acityEl = null;
var acountyEl = null;
var astreetAddressEl = null;
var aaddressEl = null;
var nrow = null;

function initForm(){
    mainForm = new nui.Form("#mainForm");
    otherForm = new nui.Form("#otherForm");
    //editLogisticsForm = new nui.Form("#editLogisticsForm");   
    editLogisticsForm = document.getElementById("editLogisticsForm");

    aprovinceEl = nui.get("aprovinceId");
	acityEl = nui.get("acityId");
	acountyEl = nui.get("acountyId");
	astreetAddressEl = nui.get("astreetAddress");
	aaddressEl = nui.get("addressA");

	/*getRegion(null,function(data) {
		//provinceHash = data.rs || [];
		//provinceEl.setData(provinceHash);

	});*/
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
    logisticsGrid = nui.get("logisticsGrid");
    logisticsGrid.setUrl(logisticsUrl);
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
/*    data.moblie=nui.get('mobile').getValue();
    var pattern = /^[1][3,4,5,7,8]\d{9}$/;
    if(data.mobile !=pattern || data.mobile.length!=11){
    	parent.showMsg("请输入正确的手机号");
    	return;
    }*/

  
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
            	saveLogistics(data.guestId);
                parent.showMsg("保存成功","S");
                CloseWindow("ok");
            }
            else{
                parent.showMsg(data.errMsg||"保存失败","W");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
var saveLogisticsUrl = baseUrl + "com.hsapi.part.baseDataCrud.crud.saveGuestLogistics.biz.ext";
function saveLogistics(guestId){
	var logisticsAdd = logisticsGrid.getChanges("added");
	var logisticsUpdate = logisticsGrid.getChanges("modified");
	var logisticsDelete = logisticsGrid.getChanges("removed");
	nui.ajax({
        url:saveLogisticsUrl,
        type:"post",
        data:JSON.stringify({
            guestId:guestId,
            logisticsAdd:logisticsAdd,
            logisticsUpdate:logisticsUpdate,
            logisticsDelete:logisticsDelete,
            token:token
        }),
        success:function(data)
        {
            if(data.errCode == "S"){
            }else{
                parent.showMsg(data.errMsg||"收货信息保存失败","W");
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

        logisticsGrid.load({
        	guestId:supplier.id,
        	token:token
        });
    }
    else{
        mainForm.setData({
            code:currentTimeMillis
        });
    }
}
/*function onActionRenderer(e) {
    var grid = e.sender;
    var record = e.record;
    var uid = record._uid;
    var rowIndex = e.rowIndex;

    var s = '<a class="nui-button" href="javascript:newRow()">新增</a> '
            + '<a class="nui-button" href="javascript:editRow(\'' + uid + '\')">修改</a> '
            + '<a class="nui-button" href="javascript:delRow(\'' + uid + '\')">删除</a> ';
               
    return s;
}*/
function newRow() {            
    var row = {};
    logisticsGrid.addRow(row, 0);
    nrow = row;

    edit(row);
}
function editRow(){
	var row = logisticsGrid.getSelected();
	nrow = row;
	edit(row);
}
function edit(row) {

	aprovinceEl.setData(provinceList);

    if (row) {
        //显示行详细
        logisticsGrid.hideAllRowDetail();
        logisticsGrid.showRowDetail(row);

        //将editForm元素，加入行详细单元格内
        var td = logisticsGrid.getRowDetailCellEl(row);
        td.appendChild(editLogisticsForm);
        editLogisticsForm.style.display = "";

        //表单加载员工信息
        var form = new nui.Form("editLogisticsForm");
        form.setData(row);

        var province = aprovinceEl.getValue();
        getRegion(province,function(data) {
			cityHash = data.rs || [];
			acityEl.setData(cityHash);

		});

        var city = acityEl.getValue();
		getRegion(city,function(data) {
			countyHash = data.rs || [];
			acountyEl.setData(countyHash);
		});
        /*if (logisticsGrid.isNewRow(row)) {                    
            form.reset();
        } else {
            form.loading();
            $.ajax({
                url: "../data/AjaxService.aspx?method=GetEmployee&id=" + row.id,
                success: function (text) {
                    var o = mini.decode(text);
                    form.setData(o);                            

                    form.unmask();
                }
            });
        }*/

        //logisticsGrid.doLayout();

    }
}
function cancelRow() {
    //logisticsGrid.reload();
    editLogisticsForm.style.display = "none";

    var form = new nui.Form("editLogisticsForm");
    form.setData([]);

    nrow = null;
}
function delRow(row_uid) {
	var row = logisticsGrid.getSelected();
	
    logisticsGrid.removeRow(row);
}

function updateRow() {
    var form = new nui.Form("editLogisticsForm");
    var newRow = form.getData();
    if(nrow){
    	logisticsGrid.updateRow(nrow, newRow);
    }
    
    cancelRow();
}

var getRegionUrl = apiPath + sysApi + "/" + "com.hs.common.region.getRegin.biz.ext";
function getRegion(parentId,callback) {
	nui.ajax({
		url : getRegionUrl,
		data : {
			token: token, 
			parentId: parentId
		},
		type : "post",
		success : function(data) {
			if (data && data.rs) {
				callback && callback(data);
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			//  nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}
function onProvinceChange(e){
	var value = e.value;
	acityEl.setValue(null);
	acountyEl.setValue(null);
	getRegion(value,function(data) {
		cityHash = data.rs || [];
		acityEl.setData(cityHash);

	});
	setAddress();
}
function onCityChange(e){
	var value = e.value;
	acountyEl.setValue(null);
	getRegion(value,function(data) {
		countyHash = data.rs || [];
		acountyEl.setData(countyHash);

	});
	setAddress();
}
function onCountyChange(e){
	setAddress();
}
function onStreetChange(e){
	setAddress();
}
function setAddress() {
	var provinceT = aprovinceEl.getText()||'';
	var cityT = acityEl.getText()||'';
	var countyT = acountyEl.getText()||'';
	var streetAddressT = astreetAddressEl.getValue()||'';
	var address = provinceT + cityT + countyT + streetAddressT;
	aaddressEl.setValue(address);
	aaddressEl.getValue();
}
