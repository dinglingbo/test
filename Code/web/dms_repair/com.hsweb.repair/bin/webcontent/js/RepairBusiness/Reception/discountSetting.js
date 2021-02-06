/**
 * Created by Administrator on 2018/3/30.
 */


var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";

$(document).ready(function (v)
{
    //setData({
    //    id:1
    //});
});
var basicInfoForm = null;
var itemGrid = null;
var partGrid = null;
var itemBillGrid = null;
var partBillGrid = null;
function init()
{
    basicInfoForm = new nui.Form("#basicInfoForm");
    itemGrid = nui.get("itemGrid");
    var itemGridUrl = baseUrl+"com.hsapi.repair.repairService.svr.getRpsItemByServiceId.biz.ext";
    itemGrid.setUrl(itemGridUrl);
    itemGrid.on("cellbeginedit",onCellBeginEdit);
    itemGrid.on("cellendedit",function(e){
        onCellCommitEdit(e);
        calculateItemPartDiscountAmt();
    });
    itemGrid.on("load",function(){
        calculateItemPartDiscountAmt();
    });

    partGrid = nui.get("partGrid");
    var partGridUrl = baseUrl+"com.hsapi.repair.repairService.svr.getRpsPartByServiceId.biz.ext";
    partGrid.setUrl(partGridUrl);
    partGrid.on("cellbeginedit",onCellBeginEdit);
    partGrid.on("cellendedit",function(e){
        onCellCommitEdit(e);
        calculateItemPartDiscountAmt();
    });
    partGrid.on("load",function(){
        calculateItemPartDiscountAmt();
    });

    itemBillGrid = nui.get("itemBillGrid");
    var itemBillGridUrl = baseUrl+"com.hsapi.repair.repairService.svr.getRpsItemBillByServiceId.biz.ext";
    itemBillGrid.setUrl(itemBillGridUrl);
    itemBillGrid.on("cellbeginedit",onCellBeginEdit);
    itemBillGrid.on("cellendedit",onCellCommitEdit);

    partBillGrid = nui.get("partBillGrid");
    var partBillGridUrl = baseUrl+"com.hsapi.repair.repairService.svr.getRpsPartBillByServiceId.biz.ext";
    partBillGrid.setUrl(partBillGridUrl);
    partBillGrid.on("cellbeginedit",onCellBeginEdit);
    partBillGrid.on("cellendedit",onCellCommitEdit);

    normalDiscount = nui.get("normalDiscount");
    outDiscount = nui.get("outDiscount");
    itemDiscount = nui.get("itemDiscount");
    partDiscount = nui.get("partDiscount");
    itemRate = nui.get("itemRate");
    partRate = nui.get("partRate");
}
function getGuest(serviceId,callback)
{
    var url = baseUrl+"com.hsapi.repair.repairService.settlement.getGuestByServiceId.biz.ext";
    doPost({
        url:url,
        data:{
            serviceId:serviceId
        },
        success:function(data)
        {
            callback && callback(data);
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            callback && callback(null);
        }
    });
}
function calculateItemPartDiscountAmt()
{
    var itemList = itemGrid.getData();
    var partList = partGrid.getData();
    var itemAmt = 0;
    var partAmt = 0;
    var itemDiscountAmt = 0;
    var partDiscountAmt = 0;
    itemList.forEach(function(v){
        itemDiscountAmt += v.discountAmt;
        itemAmt += v.amt;
    });
    partList.forEach(function(v){
        partDiscountAmt += v.discountAmt;
        partAmt += v.amt;
    });
    var itemRate = itemDiscountAmt / itemAmt * 100;
    itemRate = itemRate.toFixed(2);
    var partRate = partDiscountAmt / partAmt * 100;
    partRate = partRate.toFixed(2);
    $("#itemAmtRate").html(itemRate+"%");
    $("#partAmtRate").html(partRate+"%");
    var discountAmt = itemDiscountAmt + partDiscountAmt;
    discountAmt = discountAmt.toFixed(2);
    $("#discountAmt").html(discountAmt);
}
function onCellBeginEdit(e)
{
    e.value = e.value * 100;
    e.value = e.value.toFixed(2);
}
function onCellCommitEdit(e)
{
    var grid = e.sender;
    var row = e.record;
    e.value = e.value / 100;
    e.value = e.value.toFixed(2);
    row[e.field] = e.value;
    calculateDiscountAmt(row);
    grid.updateRow(row,row);
}

var normalDiscount = null;
var outDiscount = null;
var itemDiscount = null;
var itemRate = null;
var partDiscount = null;
var partRate = null;
function onSet()
{
    var normal = normalDiscount.getValue();
    var out = outDiscount.getValue();
    var item = itemDiscount.getValue();
    var part = partDiscount.getValue();
    var iRate = itemRate.getValue();
    var pRate = partRate.getValue();

    if(item == 1)
    {
        if(normal == 1)
        {
            setRateBatch(itemGrid,iRate);
        }
        if(out == 1)
        {
            setRateBatch(itemBillGrid,iRate);
        }
    }
    if(part == 1)
    {
        if(normal == 1)
        {
            setRateBatch(partGrid,pRate);
        }
        if(out == 1)
        {
            setRateBatch(partBillGrid,pRate);
        }
    }
}
function calculateDiscountAmt(v)
{
    v.discountAmt = v.rate * v.amt;
    v.discountAmt = parseFloat(v.discountAmt.toFixed(2));
    v.subtotal = v.amt - v.discountAmt;
    v.subtotal = parseFloat(v.subtotal.toFixed(2));
}
function setRateBatch(grid,rate)
{
    rate = rate / 100;
    var list = grid.getData();
    list.forEach(function(v)
    {
        v.rate = rate;
        calculateDiscountAmt(v);
    });
    grid.setData(list);
}

function setData(data)
{
    init();
    var maintain = data.maintain;
    basicInfoForm.setData(maintain);
    getGuest(maintain.id,function(data)
    {
        data = data||{};
        var maintain = basicInfoForm.getData();
        var guest = data.guest;
        var memberLevel = data.memberLevel;
        maintain.guestName = guest.fullName;
        maintain.memName = memberLevel.memName;
        maintain.joinDate = memberLevel.joinDate;
        maintain.expiryDate = memberLevel.expiryDate;
        maintain.partDiscount = memberLevel.partDiscount;
        maintain.itemDiscount = memberLevel.itemDiscount;
        basicInfoForm.setData(maintain);
    });
    loadItemData();
    loadPartData();
    loadItemBillData();
    loadPartBillData();
}
function loadItemData()
{
    var maintain = basicInfoForm.getData();
    if (!maintain.id) {
        return;
    }
    var params = {
        serviceId: maintain.id
    };
    itemGrid.load({
    	token:token,
        params: params
    });
}
function loadPartData()
{
    var maintain = basicInfoForm.getData();
    if (!maintain.id) {
        return;
    }
    var params = {
        serviceId: maintain.id
    };
    partGrid.load({
    	token:token,
        params: params
    });
}
function loadItemBillData()
{
    var maintain = basicInfoForm.getData();
    if (!maintain.id) {
        return;
    }
    var params = {
        serviceId: maintain.id
    };
    itemBillGrid.load({
    	token:token,
        params: params
    });
}
function loadPartBillData()
{
    var maintain = basicInfoForm.getData();
    if (!maintain.id) {
        return;
    }
    var params = {
        serviceId: maintain.id
    };
    partBillGrid.load({
    	token:token,
        params: params
    });
}



function onOk()
{
    var itemList = itemGrid.getData();
    itemList = itemList.map(function(v){
        return {
            itemId:v.itemId,
            serviceId:v.serviceId,
            rate:v.rate*100,
            discountAmt:v.discountAmt,
            subtotal:v.subtotal
        }
    });
    var itemBillList = itemBillGrid.getData();
    itemBillList = itemBillList.map(function(v){
        return {
            itemId:v.itemId,
            serviceId:v.serviceId,
            rate:v.rate*100,
            discountAmt:v.discountAmt,
            subtotal:v.subtotal
        }
    });
    var partList = partGrid.getData();
    partList = partList.map(function(v){
        return {
            partId:v.partId,
            serviceId:v.serviceId,
            rate:v.rate*100,
            discountAmt:v.discountAmt,
            subtotal:v.subtotal
        }
    });
    var partBillList = partBillGrid.getData();
    partBillList = partBillList.map(function(v){
        return {
            partId:v.partId,
            serviceId:v.serviceId,
            rate:v.rate*100,
            discountAmt:v.discountAmt,
            subtotal:v.subtotal
        }
    });
    nui.mask({
        html:'保存中...'
    });
    var url = baseUrl+"com.hsapi.repair.repairService.work.updateRpsRate.biz.ext";
    doPost({
        url:url,
        data:{
            itemList:itemList,
            itemBillList:itemBillList,
            partList:partList,
            partBillList:partBillList
        },
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                nui.alert("保存成功","提示",function(){
                 //   CloseWindow("ok");
                });
            }
            else{
                nui.alert(data.errMsg||"保存失败");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            nui.unmask();
            nui.alert("网络出错");
        }
    });

}
function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}