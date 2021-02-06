/**
 * Created by Administrator on 2018/1/24.
 */

var basicInfoForm = null;
function init()
{
    basicInfoForm = new nui.Form("#basicInfoForm");
}

function setData(data)
{
    init();
    console.log(data);
    data = data||{};
    var part = data.part;
    var editQtyOnly = !!data.editQtyOnly;
    if(part)
    {
        basicInfoForm.setData(part);
        nui.get("outQty").setMaxValue(part.outableQty);
        onUnitPriceChange();
        if(editQtyOnly)
        {
        	var list = basicInfoForm.getFields();
            //console.log(list);
            list.forEach(function(v)
            {
                if(v.enabled && v.name != "outQty")
                {
                    v.disable();
                }
            });
        }
    }
}
var resultData = {};
var callback = null;
function getData(){
    return resultData;
}

var requiredField = {
    outQty:"数量",
    sellUnitPrice:"单价"
};
function onOk()
{
    var data = basicInfoForm.getData();
    console.log(data);
    //return;
    for(var key in requiredField)
    {
        if(!data[key] || data[key].toString().trim().length==0)
        {
            nui.alert(requiredField[key]+"不能为空");
            return;
        }
    }
    var qty = data.outQty;
    data.sellAmt = data.sellUnitPrice * qty;
    data.discountAmt = data.sellAmt - data.discountLastAmt;
    data.sellAmt = data.sellAmt.toFixed(2);
    data.discountAmt = data.discountAmt.toFixed(2);
    resultData.enterDetail = data;
    CloseWindow("ok");
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
function onUnitPriceChange()
{
    var unitPrice = nui.get("sellUnitPrice").getValue();
    var discountRate = nui.get("discountRate").getValue();
    var outQty = nui.get("outQty").getValue();
    var discountLastUnitPriceEl = nui.get("discountLastUnitPrice");
    var discountLastAmtEl = nui.get("discountLastAmt");

    var discountLastUnitPrice = unitPrice * discountRate / 100;
    var discountLastAmt = discountLastUnitPrice * outQty;
    discountLastUnitPriceEl.setValue(discountLastUnitPrice);
    discountLastAmtEl.setMaxValue(unitPrice*outQty);
    discountLastAmtEl.setValue(discountLastAmt);
    $("#totalAmt").html("RMB "+ unitPrice*outQty +"元");
    $("#discountLastAmt1").html("RMB "+ discountLastAmt.toFixed(2) +"元");
    $("#youhui").html("RMB "+ (unitPrice*outQty - discountLastAmt).toFixed(2) +"元");
}
function onAmtChange(){
    var unitPrice = nui.get("sellUnitPrice").getValue();
    var discountLastAmt = nui.get("discountLastAmt").getValue();
    var discountRateEl = nui.get("discountRate");
    var outQty = nui.get("outQty").getValue();
    var discountLastUnitPriceEl = nui.get("discountLastUnitPrice");

    var discountLastUnitPrice = discountLastAmt / outQty;
    var discountRate = discountLastUnitPrice / unitPrice * 100;
    discountLastUnitPriceEl.setValue(discountLastUnitPrice);
    discountRateEl.setValue(discountRate);

    $("#totalAmt").html("RMB "+ unitPrice*outQty +"元");
    $("#discountLastAmt1").html("RMB "+ discountLastAmt.toFixed(2) +"元");
    $("#youhui").html("RMB "+(unitPrice*outQty - discountLastAmt).toFixed(2) +"元")
}