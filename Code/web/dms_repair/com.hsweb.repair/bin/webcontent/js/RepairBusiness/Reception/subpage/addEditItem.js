/**
 * Created by Administrator on 2018/3/22.
 */
var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var basicInfoForm = null;
$(document).ready(function (v)
{
//    init(function(){});
});

function init(callback)
{
    basicInfoForm = new nui.Form("#basicInfoForm");
    var hash = {};
    nui.mask({
        html:'数据加载中..'
    });
    var checkComplete = function()
    {
        var keyList = ['getDatadictionaries','getDictItems'];
        for(var i=0;i<keyList.length;i++)
        {
            if(!hash[keyList[i]])
            {
                return;
            }
        }
        nui.unmask();
        callback && callback();
    };
    var dictIdList = [];
    dictIdList.push("DDT20130706000013");//收费
    dictIdList.push("DDT20130706000014");//免费
    getDictItems(dictIdList, function(data)
    {
        data = data||{};
        var itemList = data.dataItems||[];
        var receTypeIdList = itemList.filter(function(v)
        {
            return v.dictid == "DDT20130706000013" || v.dictid == "DDT20130706000014";
        });
        nui.get("receTypeId").setData(receTypeIdList);
        hash.getDictItems = true;
        checkComplete();
    });
    var pId = "DDT20130703000057";//工种
    getDatadictionaries(pId,function(data)
    {
        data = data||{};
        var list = data.list||[];
        nui.get("itemKind").setData(list);
        hash.getDatadictionaries = true;
        checkComplete();
    });

    itemTimeEl = nui.get("itemTime");
    itemTimeEl.on("valuechanged",function(){
        updateAmt();
    });
    unitPriceEl = nui.get("unitPrice");
    unitPriceEl.on("valuechanged",function(){
        updateAmt();
    });
    amtEl = nui.get("amt");
}
var amtEl = null;
var unitPriceEl = null;
var itemTimeEl = null;
function updateAmt()
{
    var unitPrice = unitPriceEl.getValue();
    var itemTime = itemTimeEl.getValue();
    if(itemTime == 0)
    {
        itemTime = 1;
        itemTimeEl.setValue(itemTime);
    }
    amtEl.setValue(unitPrice*itemTime);
}
function updateUnitPrice()
{
    var amt = amtEl.getValue();
    var itemTime = itemTimeEl.getValue();
    if(itemTime>0)
    {
        unitPriceEl.setValue(amt/itemTime);
    }
}
var list = [];
var currIdx = 0;
function preItem()
{
    setItemByIdx(currIdx-1);
}
function nextItem()
{
    setItemByIdx(currIdx+1);
}
function setItemByIdx(idx)
{
    if(idx>=0 && idx<list.length)
    {
        var item = basicInfoForm.getData();
        list[currIdx] = item;
        currIdx = idx;
        basicInfoForm.setData(list[currIdx]);
    }
}
function addItem()
{
    var itemKindList = nui.get("itemKind").getData();
    var receTypeIdList = nui.get("receTypeId").getData();
    list.push({
        serviceId:serviceId,
        status:0,
        itemKind:itemKindList[0].customid,
        receTypeId:receTypeIdList[0].customid,
        itemTime:1,
        unitPrice:0,
        amt:0,
        rate:0,
        discountAmt:0
    });
    setItemByIdx(list.length-1);
}
var serviceId = 0;
function setData(data)
{
    console.log(data);
    init(function()
    {
        serviceId = data.serviceId;
        var sourceCode = data.sourceCode;
        var editType = data.editType;
        if(sourceCode == "rpsItem")
        {
            saveUrl = baseUrl+"com.hsapi.repair.repairService.crud.saveRpsItem.biz.ext";
        }
        else if(sourceCode == "rpsItemQuote"){
            saveUrl = baseUrl+"com.hsapi.repair.repairService.crud.saveRpsItemQuote.biz.ext";
            nui.get("addBtn").show();
        }
        else if(sourceCode == "rpsItemBill")
        {
            saveUrl = baseUrl+"com.hsapi.repair.repairService.crud.saveRpsItemBill.biz.ext";
        }
        else{
            nui.alert("未知调用");
            return;
        }
        if(data.list && data.list.length>0)
        {
            list = data.list;
            currIdx = data.idx||0;
            basicInfoForm.setData(list[currIdx]);
        }
        if(editType == "new")
        {
            addItem();
        }
    });
}
var saveUrl = "";
var requiredField = {
    itemName:"项目名称"
};
function onOk()
{
    var item = basicInfoForm.getData();
    list[currIdx] = item;
    for(var i=0;i<list.length;i++)
    {
        var tmp = list[i];
        for(var key in requiredField)
        {
            if(!tmp[key] || tmp[key].toString().trim().length == 0)
            {
                nui.alert(requiredField[key]+"不能为空");
                setItemByIdx(i);
                return;
            }
        }
    }
    list.forEach(function(v)
    {
        v.discountAmt = v.rate*v.amt;
        v.subtotal = v.amt - v.discountAmt;
    });
    var insList = list.filter(function(v)
    {
        if(!v.itemId)
        {
            v.itemIsNeed = 1;
            return true;
        }
    });
    var updList = list.filter(function(v){
        return v.itemId;
    });
    nui.mask({
        html:'保存中..'
    });
    doPost({
        url : saveUrl,
        data : {
            serviceId:serviceId,
            insList:insList,
            updList:updList
        },
        success : function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                CloseWindow("ok");
            }
            else{
                nui.alert(data.errMsg||"保存失败");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            nui.unmask();
            console.log(jqXHR.responseText);
            nui.alert("网络出错");
        }
    });
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