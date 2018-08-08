/**
 * Created by Administrator on 2018/6/23.
 */
var webBaseUrl = webPath + repairDomain + "/";
var baseUrl = apiPath + repairApi + "/";

var webBaseUrl = webPath + repairDomain + "/";
var baseUrl = apiPath + repairApi + "/";
var rpsPackageGrid = null;
var rpsItemGrid = null;
var rpsPartGrid = null;
var morePartGrid = null;

var billForm = null;
var sendGuestForm = null;
var insuranceForm = null;
var describeForm = null;
var advancedMorePartWin = null;
var mainTabs = null;

var enterDateEl = null;
var planFinishDateEl = null;
var carNoEl = null;
var contactNameEl = null;

var servieTypeList = [];
var servieTypeHash = {};
var receTypeIdList = [];
var receTypeIdHash = {};

var contactList = [];
var contactHash = {};

var fguestId = 0;
var fcarId = 0;
var mpackageRate = 0;
var mitemRate = 0;
var mpartRate = 0;

$(document).ready(function ()
{
    rpsPackageGrid = nui.get("rpsPackageGrid");
    rpsItemGrid = nui.get("rpsItemGrid");
    rpsPartGrid = nui.get("rpsPartGrid");
    morePartGrid = nui.get("rpsPartGrid");

    billForm = new nui.Form("#billForm");
    sendGuestForm = new nui.Form("#sendGuestForm");
    insuranceForm = new nui.Form("#insuranceForm");
    describeForm = new nui.Form("#describeForm");
    advancedMorePartWin = nui.get("advancedMorePartWin");
    mainTabs = nui.get("mainTabs");

    enterDateEl = nui.get("enterDate");
    planFinishDateEl = nui.get("planFinishDate");
    carNoEl = nui.get("carNo");
    contactNameEl = nui.get("contactName");

    initMember("mtAdvisorId",null);
    initServiceType("serviceTypeId",function(data) {
        servieTypeList = nui.get("serviceTypeId").getData();
        servieTypeList.forEach(function(v) {
            servieTypeHash[v.id] = v;
        });
    });
    initCustomDicts("receTypeId", "0415",function(data) {
        receTypeIdList = nui.get("receTypeId").getData();
        receTypeIdList.forEach(function(v) {
            receTypeIdHash[v.customid] = v;
        });
    });
    initDicts({
        enterOilMass: "DDT20130703000051"//进厂油量
    },null);

    add();

    rpsPackageGrid.on("drawcell", function (e) {
        switch (e.field) {
            case "packageOptBtn":
                    e.cellHtml = //'<span class="fa fa-close fa-lg" onClick="javascript:deletePart()" title="删除行">&nbsp;&nbsp;&nbsp;&nbsp;</span>';
                                '<span class="fa fa-plus" onClick="javascript:addPackNewRow()" title="添加行">&nbsp;&nbsp;</span>' +
                                ' <span class="fa fa-close" onClick="javascript:deletePackRow()" title="删除行"></span>';
                    break;
            default:
                break;
        }
    });
    rpsItemGrid.on("drawcell", function (e) {
        switch (e.field) {
            case "itemOptBtn":
                    e.cellHtml = //'<span class="fa fa-close fa-lg" onClick="javascript:deletePart()" title="删除行">&nbsp;&nbsp;&nbsp;&nbsp;</span>';
                                '<span class="fa fa-plus" onClick="javascript:addItemNewRow()" title="添加行">&nbsp;&nbsp;</span>' +
                                ' <span class="fa fa-close" onClick="javascript:deleteItemRow()" title="删除行"></span>';
                    break;
            default:
                break;
        }
    });
    rpsPartGrid.on("drawcell", function (e) {
        switch (e.field) {
            case "partOptBtn":
                    e.cellHtml = //'<span class="fa fa-close fa-lg" onClick="javascript:deletePart()" title="删除行">&nbsp;&nbsp;&nbsp;&nbsp;</span>';
                                '<span class="fa fa-plus" onClick="javascript:addPartNewRow()" title="添加行">&nbsp;&nbsp;</span>' +
                                ' <span class="fa fa-close" onClick="javascript:deletePartRow()" title="删除行"></span>';
                    break;
            case "receTypeId":
                if (receTypeIdHash && receTypeIdHash[e.value]) {
                    e.cellHtml = receTypeIdHash[e.value].name;
                }
            default:
                break;
        }
    });    
    rpsPartGrid.on("cellcommitedit", function (e) {
        var editor = e.editor;
        var record = e.record;
        var row = e.row;

        editor.validate();
        if (editor.isValid() == false) {
            nui.alert("请输入数字！");
            e.cancel = true;
        } else {
            var newRow = {};
            if (e.field == "qty") {
                var qty = e.value;
                var unitPrice = record.unitPrice;

                if (e.value == null || e.value == '') {
                    e.value = 0;
                    qty = 0;
                } else if (e.value < 0) {
                    e.value = 0;
                    qty = 0;
                }

                var amt = qty * unitPrice;

                newRow = {
                    amt : amt
                };
                rpsPartGrid.updateRow(e.row, newRow);
            } else if (e.field == "unitPrice") {
                var qty = record.qty;
                var unitPrice = e.value;
                
                if (e.value == null || e.value == '') {
                    e.value = 0;
                    unitPrice = 0;
                } else if (e.value < 0) {
                    e.value = 0;
                    unitPrice = 0;
                }

                var amt = qty * unitPrice;

                newRow = {
                    amt : amt
                };
                rpsPartGrid.updateRow(e.row, newRow);     

            } else if (e.field == "amt") {
                var qty = record.qty;
                var amt = e.value;

                if (e.value == null || e.value == '') {
                    e.value = 0;
                    amt = 0;
                } else if (e.value < 0) {
                    e.value = 0;
                    amt = 0;
                }
                var unitPrice = amt * 1.0 / qty;


                if (qty) {
                    newRow = {
                        unitPrice : unitPrice
                    };
                    rpsPartGrid.updateRow(e.row, newRow);
                }

            }else if(e.field == "partName"){
                oldValue = e.oldValue;
                oldRow = row;
                
            }
        }
    });
    rpsPartGrid.on("celleditenter", function (e) {
        var record = e.record;
        var cell = rpsPartGrid.getCurrentCell();//行，列
        if(cell && cell.length >= 2){
            var column = cell[1];
            if(column.field == "partName"){  
                advancedMorePartWin.showAtEl(rpsPartGrid._getCellEl(record,column), {xAlign:"outright",yAlign:"bottom"});
            }
        }
    });
    mainTabs.on("activechanged", function (e) {
        var tab = e.tab;
        var name = tab.name;
        //如果为空则重新查询，如果不为空判断ID是否相同，不相同重新查询，相同不用处理
        var maindata = billForm.getData();
        if(name == "contactorTab"){
            var contactorId = maindata.contactorId||0;
            if(contactorId == 0){
                sendGuestForm.setData([]);
            }else{
                var data = sendGuestForm.getData();
                var name = data.name || "";
                if(name == ""){
                    getContactor(maindata.guestId,function(rdata){
                        var contact = contactHash[contactorId];
                        if(contact){
                            data.id = contact.id;
                            data.guestId = contact.guestId;
                            data.name = contact.name;
                            data.sex = contact.sex;
                            data.mobile = contact.mobile;
                            data.idNo = contact.idNo;
                            data.remark = contact.remark;
                            sendGuestForm.setData(data);
                        }
                    });
                }else{
                    var id = data.guestId||0;
                    if(fguestId != id){
                        getContactor(maindata.guestId,function(rdata){
                            var contact = contactHash[contactorId];
                            if(contact){
                                data.id = contact.id;
                                data.guestId = contact.guestId;
                                data.name = contact.name;
                                data.sex = contact.sex;
                                data.mobile = contact.mobile;
                                data.idNo = contact.idNo;
                                data.remark = contact.remark;
                                sendGuestForm.setData(data);
                            }
                        });
                    }
                }
            }
        }else if(name == "insuranceTab"){
            var carId = maindata.carId||0;
            if(carId == 0){
                insuranceForm.setData([]);
            }else{
                var data = insuranceForm.getData();
                var id = data.id || 0;
                if(id == 0){
                    getCarInsure(carId,function(rdata){
                        if(data){
                            data.id = rdata.id;
                            data.insuranceName = rdata.insureCompName;
                            data.insureNo = rdata.insureNo;
                            data.insureDueDate = rdata.insureDueDate;
                            insuranceForm.setData(data);
                        }
                    });
                }else{
                    var id = data.id||0;
                    if(fcarId != id){
                        getCarInsure(carId,function(rdata){
                            if(data){
                                data.id = rdata.id;
                                data.insuranceName = rdata.insureCompName;
                                data.insureNo = rdata.insureNo;
                                data.insureDueDate = rdata.insureDueDate;
                                insuranceForm.setData(data);
                            }
                        });
                    }
                }
            }
        }
    });
});
var getContactUrl = apiPath + repairApi + "/com.hsapi.repair.repairService.query.getContacterByGuestId.biz.ext";
function getContactor(guestId,callback) {
    contactList = [];
    contactHash = {};

    nui.ajax({
        url : getContactUrl,
        async:false,
        data : {
            token: token, 
            guestId: guestId
        },
        type : "post",
        success : function(data) {
            if (data && data.data && data.data.contacter) {
                var contact = data.data.contacter;
                contactList = contact;
                contact.forEach(function(v) {
                    contactHash[v.id] = v;
                });
                callback && callback(contact);
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });

    contactNameEl.setData(contactList);
}
var getCarInsureUrl = apiPath + repairApi + "/com.hsapi.repair.repairService.query.getInsureByCarId.biz.ext";
function getCarInsure(carId,callback) {
    nui.ajax({
        url : getCarInsureUrl,
        async:false,
        data : {
            token: token, 
            carId: carId
        },
        type : "post",
        success : function(data) {
            if (data && data.data && data.data.car) {
                var car = data.data.car;
                callback && callback(car);
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });

    contactNameEl.setData(contactList);
}
function onContactorChanged(e){
    var v = e.selected;
    var data = sendGuestForm.getData();
    data.id = v.id;
    data.name = v.name;
    data.sex = v.sex;
    data.mobile = v.mobile;
    data.idNo = v.idNo;
    data.remark = v.remark;
    sendGuestForm.setData(data);

    var mdata = billForm.getData();
    mdata.contactorId = v.id;
}
function setInitData(params){
    add();
}
function add(){
    $("#servieIdEl").html("综合开单详情");
    $("#carNoEl").html("");
    //$("#wechatTag").css("color","#62b900");
    $("#guestNameEl").html("");
    $("#guestTelEl").html("");
    $("#cardPackageEl").html("次卡套餐(0)");
    $("#clubCardEl").html("会员卡(0)");
    $("#creditEl").html("挂账:0");
    $("#carHealthEl").html("车况:0");

    rpsPackageGrid.setData([]);
    rpsItemGrid.setData([]);
    rpsPartGrid.setData([]);
    billForm.setData([]);
    sendGuestForm.setData([]);
    insuranceForm.setData([]);
    describeForm.setData([]);

    enterDateEl.setValue(now);
    planFinishDateEl.setValue(addDate(now,1));

    var row = {};
    rpsPackageGrid.addRow(row);
    rpsItemGrid.addRow(row);
    rpsPartGrid.addRow(row);
}
function onApplyClick(){
    nui.open({
        url: webPath + repairDomain + "/com.hsweb.repair.DataBase.AddEditCustomer.flow?token="+token,
        title:"新增客户资料",
        width:500,
        height:630,
        onload:function(){
            var iframe = this.getIFrameEl();
            var params = {};
            iframe.contentWindow.setData(params);
        },
        ondestroy:function(action)
        {
            if(action  == "ok")
            {
                var iframe = this.getIFrameEl();
                var guest = iframe.contentWindow.getSaveData();
                if(guest){
                    var maintain = billForm.getData();
                    maintain.carId = guest.carId||0;
                    maintain.carNo = guest.carNo;
                    maintain.carVin = guest.vin;
                    maintain.engineNo = guest.engineNo;
                    maintain.contactorId = guest.contactorId||0;
                    maintain.contactorName = guest.contactName;
                    maintain.identity = guest.identity;
                    maintain.mobile = guest.mobile;
                    maintain.guestFullName = guest.guestFullName;
                    maintain.guestId = guest.guestId;
                    maintain.carModel = guest.carModel;
                    carNoEl.setText(guest.carNo);
                    billForm.setData(maintain);

                    fguestId = guest.guestId||0;
                    fcarId = guest.carId||0;

                    mpackageRate = 0;
                    mitemRate = 0;
                    mpartRate = 0;

                    $("#carNoEl").html(car.carNo);
                    $("#guestNameEl").html(car.guestFullName);
                    $("#guestTelEl").html(car.mobile);
                }
            }
        }
    });
}
function onSearchClick(){
    var maintain = billForm.getData();
    selectCustomer(function (car) {
        maintain.carId = car.id;
        maintain.carNo = car.carNo;
        maintain.carVin = car.vin;
        maintain.engineNo = car.engineNo;
        maintain.contactorId = car.contactorId;
        maintain.contactorName = car.contactName;
        maintain.identity = car.identity;
        maintain.mobile = car.mobile;
        maintain.guestFullName = car.guestFullName;
        maintain.guestId = car.guestId;
        maintain.carModel = car.carModel;

        mpackageRate = 0;
        mitemRate = 0;
        mpartRate = 0;

        carNoEl.setText(car.carNo);
        billForm.setData(maintain);

        fguestId = car.guestId||0;
        fcarId = car.id||0;

        $("#carNoEl").html(car.carNo);
        $("#guestNameEl").html(car.guestFullName);
        $("#guestTelEl").html(car.mobile);
    });
}
function selectCustomer(callback) {
    nui.open({
        url: webBaseUrl + "com.hsweb.RepairBusiness.Customer.flow?token="+token,
        title: "客户选择", width: 800, height: 450,
        onload: function () {
        },
        ondestroy: function (action) {
            if ("ok" == action) {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                var guest = data.guest;
                callback && callback(guest);
            }
        }
    });
}
function addPackNewRow(){
    var newRow = {};
    rpsPackageGrid.addRow(newRow);
}
function addItemNewRow(){
    var newRow = {};
    rpsItemGrid.addRow(newRow);
}
function addPartNewRow(){
    var newRow = {};
    rpsPartGrid.addRow(newRow);
}
function deletePackRow(){
    var data = rpsPackageGrid.getData();
    if(data && data.length==1){
        var row = rpsPackageGrid.getSelected();
        rpsPackageGrid.removeRow(row);
        var newRow = {};
        rpsPackageGrid.addRow(newRow);
    }else{
        var row = rpsPackageGrid.getSelected();
        rpsPackageGrid.removeRow(row);
    }
}
function deleteItemRow(){
    var data = rpsItemGrid.getData();
    if(data && data.length==1){
        var row = rpsItemGrid.getSelected();
        rpsItemGrid.removeRow(row);
        var newRow = {};
        rpsItemGrid.addRow(newRow);
    }else{
        var row = rpsItemGrid.getSelected();
        rpsItemGrid.removeRow(row);
    }
}
function deletePartRow(){
    var data = rpsPartGrid.getData();
    if(data && data.length==1){
        var row = rpsPartGrid.getSelected();
        rpsPartGrid.removeRow(row);
        var newRow = {};
        rpsPartGrid.addRow(newRow);
    }else{
        var row = rpsPartGrid.getSelected();
        rpsPartGrid.removeRow(row);
    }
}
function save(){
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });
    saveMaintain(function(data){
        billForm.setData(data);
        showMsg("保存成功!");
    },function(){ 
        nui.unmask(document.body);
    });
}
var requiredField = {
    carNo : "车牌号",
    serviceTypeId : "业务类型",
    mtAdvisorId : "服务顾问",
	enterOilMass : "进厂油量",
    enterKilometers : "进厂里程",
    enterDate : "进厂日期",
    planFinishDate : "预计交车"
};
var saveMaintainUrl = baseUrl + "com.hsapi.repair.repairService.crud.saveRpsMaintain.biz.ext";
function saveMaintain(callback,unmaskcall){
    var data = billForm.getData();
	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
            showMsg(requiredField[key] + "不能为空!","W");
			return;
		}
    }
    
    nui.ajax({
        url : saveMaintainUrl,
        type : "post",
        data : JSON.stringify({
            maintain : data,
            token : token
        }),
        success : function(data) {
            data = data || {};
            if (data.errCode == "S") {
                unmaskcall && unmaskcall();
                var main = data.data;
                callback && callback(main);
            } else {
                unmaskcall && unmaskcall();
                showMsg(data.errMsg || "请先保存单据添加配件","W");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            unmaskcall && unmaskcall();
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function entry(){
    var maintain = billForm.getData();
    if(!maintain.id)
    {
        saveMaintain(function(){
            chooseStdPrd();
        },null);
    }else{
        chooseStdPrd();
    }
}
function chooseStdPrd(){
    nui.open({
        url: webBaseUrl + "com.hsweb.RepairBusiness.ProductEntry.flow?token="+token,
        title: "标准化产品查询", width: 900, height: 600,
        onload: function () {
            var iframe = this.getIFrameEl();
            var carVin = maintain.carVin;
            var data = {
                vin:carVin
            };
            iframe.contentWindow.setData(data,function(data,callback)
            {
                if(data.item)
                {
                    var tmpItem = data.item;
                    addItem(tmpItem);
                }
                else{
                    addPackage(data,callback);
                }

            });
        },
        ondestroy: function (action)
        {
        }
    });
}
function addItem(tmpItem)
{
    var insList = [];
    var item = {
        itemCode:tmpItem.itemCode,
        itemId:tmpItem.itemId,
        itemName:tmpItem.itemName,
        itemNameId:tmpItem.itemNameId,
        itemCarId:tmpItem.carModelId,
        itemIsNeed:1,
        itemTime:tmpItem.astandTime,
        unitPrice:tmpItem.price,
        amt:tmpItem.astandSum,
        pkgitemamt:0,
        rate:mitemRate||0,
        discountAmt:0,
        status:0
    };
    insList.push(item);
    saveItem(insList,[],function(data)
    {
        data = data||{};
        if(data.errCode=="S")
        {
        }
    });
}
function addPackage(data,callback)
{
    var maintain = billForm.getData();
    var _package = {};
    var tmpPkg = data.pkg;
    _package.serviceId = maintain.id;
    _package.packageCarmtId = tmpPkg.id;
    _package.packageId = tmpPkg.packageId;
    _package.packageName = tmpPkg.packageName;
    _package.packageTypeId = tmpPkg.packageTypeId;
    _package.receTypeId = "04150101";
    _package.pkgamt = tmpPkg.packageAmt;
    _package.amt = tmpPkg.packageAmt;
    _package.detailAmt = tmpPkg.packageTotal;
    _package.subtotal = tmpPkg.packageAmt;
    _package.amt4s = tmpPkg.package4sAmt;
    _package.differAmt = tmpPkg.packageAmt - tmpPkg.packageTotal;
    _package.costAmt = 0;
    _package.discountAmt = 0;
    _package.rate = 0;
    _package.status = 0;
    _package.isDisabled = 0;
    var tmpItemList = data.itemList;
    var itemList = tmpItemList.map(function (v) {
        return {
            itemId: v.itemId,
            itemCode: v.itemCode,
            itemName: v.itemName,
            itemIsNeed: 1,
            receTypeId: _package.receTypeId,
            serviceId: _package.serviceId,
            itemKind: v.itemKind,
            itemTime: v.qty||0,
            unitPrice: v.price||0,
            pkgitemamt: v.amt||0,
            amt: v.amt||0,
            rate: 0,
            discountAmt: 0,
            subtotal: v.amt||0,
            status: 0
        }
    });
    var tmpPartList = data.partList;
    var partList = tmpPartList.map(function (v) {
        return {
            receTypeId: _package.receTypeId,
            serviceId: _package.serviceId,
            partId: v.partId,
            partCode: v.itemCode,
            partName: v.itemName,
            partNameId:v.itemNameId,
            partBrandId:v.partBrandId,
            partIsNeed: 1,
            qty: v.qty||0,
            unit: v.unit,
            unitPrice: v.price||0,
            amt: v.amt||0,
            rate: 0,
            discountAmt: 0,
            subtotal: v.amt||0,
            status: 0
        };
    });
  //itemList.forEach(function(v){
    //    _package.detailAmt += v.amt;
    //});
    //partList.forEach(function(v){
    //    _package.detailAmt += v.amt;
    //});
    //_package.differAmt = _package.amt - _package.detailAmt;
    var par = {
        pkg: _package,
        itemList: itemList,
        partList: partList
    };
    savePackage(par, function (data) {
        data = data || {};
        if (data.errCode == "S")
        {
            callback && callback();
            loadPackageGridData();
        }
        else {
        }
    });
}
function saveItem(insList, updList, callback) {
    var maintain = billForm.getData();
    if (!maintain.id) {
        showMsg("请先保存数据再添加!","W");
        return;
    }
    insList = insList || [];
    updList = updList || [];
    var saveItemUrl = baseUrl + "com.hsapi.repair.repairService.crud.saveRpsItem.biz.ext";
    doPost({
        url: saveItemUrl,
        data: {
            insList: insList,
            updList: updList,
            serviceId: maintain.id
        },
        success: function (data) {
            callback && callback(data);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            callback({});
        }
    });
}
function savePackage(params, callback) {
    var maintain = billForm.getData();
    if (!maintain.id) {
        nui.alert("数据错误");
        return;
    }
    var saveItemUrl = baseUrl + "com.hsapi.repair.repairService.crud.insRpsPackage.biz.ext";
    doPost({
        url: saveItemUrl,
        data: params,
        success: function (data) {
            callback && callback(data);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            callback({});
        }
    });
}