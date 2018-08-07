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

var enterDateEl = null;
var planFinishDateEl = null;
var carNoEl = null;

var servieTypeList = [];
var servieTypeHash = {};
var receTypeIdList = [];
var receTypeIdHash = {};

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

    enterDateEl = nui.get("enterDate");
    planFinishDateEl = nui.get("planFinishDate");
    carNoEl = nui.get("carNo");

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
});
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
    nui.alert("apply");
}
function onSearchClick(){
    var maintain = billForm.getData();
    selectCustomer(function (car) {
        maintain.carId = car.id;
        maintain.carNo = car.carNo;
        maintain.carVin = car.underpanNo;
        maintain.engineNo = car.engineNo;
        maintain.contactorId = car.contactorId;
        maintain.contactorName = car.contactName;
        maintain.identity = car.identity;
        maintain.mobile = car.mobile;
        maintain.guestFullName = car.guestFullName;
        maintain.guestId = car.guestId;
        maintain.carModel = car.carModel;
        carNoEl.setText(car.carNo);
        billForm.setData(maintain);

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
function entry(){
	/*
    var maintain = billForm.getData();
    if(!maintain.id)
    {
        nui.alert("请先保存工单信息");
        return;
    }*/
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
                    addItemQuote(tmpItem);
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
function addItemQuote(tmpItem)
{
    var insList = [];
    var item = {
        itemCode:tmpItem.itemCode,
        itemId:tmpItem.itemId,
        itemKind:tmpItem.itemKind,
        itemName:tmpItem.itemName,
        itemNameId:tmpItem.itemNameId,
        itemCarId:tmpItem.carModelId,
        itemIsNeed:1,
        receTypeId:"04150101",
        itemTime:tmpItem.astandTime,
        unitPrice:tmpItem.price,
        amt:tmpItem.astandSum,
        pkgitemamt:0,
        rate:0,
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
        nui.alert("数据错误");
        return;
    }
    insList = insList || [];
    updList = updList || [];
    var saveItemUrl = baseUrl + "com.hsapi.repair.repairService.crud.saveRpsItemQuote.biz.ext";
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