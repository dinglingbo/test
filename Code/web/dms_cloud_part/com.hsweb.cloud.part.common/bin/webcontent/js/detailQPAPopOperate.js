/**
 * Created by Administrator on 2018/1/24.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var basicInfoForm = null;
var qtyEdit = null;
var guestId = null;
var qtyEl = null;
var priceEl = null;
var amtEl = null;
$(document).ready(function(v)
{

    qtyEl = nui.get("qty");
    priceEl = nui.get("price");
    amtEl = nui.get("amt");

    $("#qty").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            var price = nui.get("price");
            price.focus();
        }
    });

    $("#price").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            var amt = nui.get("amt");
            amt.focus();
        }
    });
    $("#amt").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            var remark = nui.get("remark");
            remark.focus();
        }
    });

    $("#remark").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            var chooseBtn = nui.get("chooseBtn");
            chooseBtn.focus();
        }
    });

    document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;

        switch(keyCode){
            case 27:
            window.CloseOwnerWindow("");
            break; 
        } 
    }
});
function init()
{
    basicInfoForm = new nui.Form("#basicInfoForm");
    //qtyEdit = nui.get("qty");
    qtyEl.setValue(1);
    qtyEl.focus();

    getStorehouse(function(data)
    {
        var storehouse = data.storehouse||[];
        nui.get("storeId").setData(storehouse);
        
    });
}
var partPchsPriceUrl = baseUrl
        + "com.hsapi.cloud.part.invoicing.pricemanage.getPchsDefaultPrice.biz.ext";
function getPchsPartPrice(params){
    var price = 0;
    var shelf = null;
    nui.ajax({
        url : partPchsPriceUrl,
        type : "post",
        async: false,
        data : {
            params: params,
            token:token
        },
        success : function(data) {
            var errCode = data.errCode;
            if(errCode == "S"){
                var priceRecord = data.priceRecord;
                if(priceRecord.pchsPrice){
                    price = priceRecord.pchsPrice;
                }
                if(priceRecord.shelf){
                    shelf = priceRecord.shelf;
                }
            }

        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });

    var dInfo = {price: price, shelf: shelf};

    return dInfo;
}
var partSellPriceUrl = baseUrl
        + "com.hsapi.cloud.part.invoicing.pricemanage.getSellDefaultPrice.biz.ext";
function getSellPartPrice(params){
    var price = 0;
    nui.ajax({
        url : partSellPriceUrl,
        type : "post",
        async: false,
        data : {
            params: params,
            token: token
        },
        success : function(data) {
            var errCode = data.errCode;
            if(errCode == "S"){
                var priceRecord = data.priceRecord;
                if(priceRecord.sellPrice){
                    price = priceRecord.sellPrice;
                }
            }

        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });

    return price;
}
function setData(data)
{
    init();
    
    data = data||{};
    var part = data.part;
    var price = 0;
    var shelf = null;
    guestId = part.guestId;

    if(part.editType && part.editType == 'storeId') {
        nui.get("storeId").disable();
    }

    if(part){
        if(data.priceType && data.priceType == 'pchsIn') {
            var params = {partId: part.id, storeId: part.storeId};
            var dInfo = getPchsPartPrice(params);
            price = dInfo.price;
            shelf = dInfo.shelf;
        }

        if(data.priceType && data.priceType == 'sellOut') {
            var params = {partId: part.id, guestId: guestId};
            price = getSellPartPrice(params);
        }

        basicInfoForm.setData(part);

        if(data.priceType){
            qtyEl.setValue(1);
            priceEl.setValue(price);
            amtEl.setValue(price);
        }
        
        /*if(part.enterTypeId && part.enterTypeId == '050101') {
            var storeShelfEl = nui.get("storeShelf");
            var dc = document.getElementById("storeShelf");
            dc.innerHTML=shelf;
            //storeShelfEl.setValue(shelf);
            var store = document.getElementById("store");
            store.innerHTML = dc;
        }*/

        qtyEl.focus();
    }

    if(part.enterTypeId && part.enterTypeId == '050101') {
        var currentRows = document.getElementById("list_table").rows.length; 
        var insertTr = document.getElementById("list_table").insertRow(currentRows);
        var insertTd = insertTr.insertCell(0);
        insertTd.style.textAlign="right";
        insertTd.style.width="60px";
        insertTd.innerHTML = "仓位：";
        
        insertTd = insertTr.insertCell(1);
        insertTd.id="store";
        insertTd.innerHTML = '<input id="storeShelf" name="storeShelf" value='+shelf+' class="nui-textbox" selectOnFocus="true" enabled="true" width="100%"/>';
    
    }
    
}
var resultData = {};
var callback = null;
function getData(){
    var dc = document.getElementById("storeShelf");
    if(dc){
        resultData.storeShelf = dc.value;
    }
    return resultData;
}

var requiredField = {
    qty:"数量",
    price:"单价",
    amt:"金额"
};
function onOk()
{
    basicInfoForm.validate();
    if (basicInfoForm.isValid() == false) {
        showMsg("请输入数字!","W");
        return;
    }

    var data = basicInfoForm.getData();
    
/*    data.taxSign = 0;
    data.taxRate = ".07";
    var totalTaxRate = parseFloat(1+data.taxRate);
    data.taxUnitPrice = (totalTaxRate*data.noTaxUnitPrice).toFixed(2);//含税单价=税率*
    data.taxAmt = (data.taxUnitPrice*data.enterQty).toFixed(2);//含税总额
    data.noTaxAmt = (data.noTaxUnitPrice*data.enterQty).toFixed(2);//不含税总额
    data.taxRateAmt = (data.taxAmt-data.noTaxAmt).toFixed(2);//税额
    data.outableQty = data.enterQty;
    data.suggestPrice = 0;
    data.suggestAmt = 0;*/
    //return;
    for(var key in requiredField)
    {
        if(!data[key] || data[key].toString().trim().length==0)
        {
            nui.alert(requiredField[key]+"不能为空");
            if(key == "qty") {
                var qty = nui.get("qty");
                qty.focus();
            }
            if(key == "price") {
                var price = nui.get("price");
                price.focus();
            }
            if(key == "amt") {
                var amt = nui.get("amt");
                amt.focus();
            }
            return;
        }
    }
    resultData = data; 
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
function calc(type){
    var qty = nui.get("qty").getValue().replace(/\s+/g, "");
    var price = nui.get("price").getValue().replace(/\s+/g, "");
    var amt = nui.get("amt").getValue().replace(/\s+/g, "");
    
    if(qty == null || qty == '') {
        nui.get("qty").setValue(0);
    }else if(qty < 0) {
        nui.get("qty").setValue(0);
    }
    
    if(price == null || price == '') {
        nui.get("price").setValue(0);
    }else if(price < 0) {
        nui.get("price").setValue(0);
    }
    
    if(amt == null || amt == '') {
        nui.get("amt").setValue(0);
    }else if(amt < 0) {
        nui.get("amt").setValue(0);
    }
    
    qty = nui.get("qty").getValue().replace(/\s+/g, "");
    price = nui.get("price").getValue().replace(/\s+/g, "");
    amt = nui.get("amt").getValue().replace(/\s+/g, "");
    
    if(type == 'qty'){
        nui.get("amt").setValue(qty * price);
    }
    
    if(type == 'price'){
        nui.get("amt").setValue(qty * price);
    }
    
    if(type == 'amt'){
        if(qty > 0) {
            nui.get("price").setValue(amt / qty);
        }else {
            nui.get("qty").setValue(0);
            nui.get("amt").setValue(0);
        }
    }
}
$("#qty").bind("keyup", function (e) {
    if (e.keyCode == 13) {
        var priceEdit = nui.get("price");
        priceEdit.focus();
    }
});

$("#price").bind("keydown", function (e) {
    if (e.keyCode == 13) {
        var amtEdit = nui.get("amt");
        amtEdit.focus();
    }
});

$("#amt").bind("keydown", function (e) {
    if (e.keyCode == 13) {
        var remarkEdit = nui.get("remark");
        remarkEdit.focus();
    }
});

$("#remark").bind("keydown", function (e) {
    if (e.keyCode == 13) {
        var chooseBtn = nui.get("chooseBtn");
        chooseBtn.focus();
    }
});


