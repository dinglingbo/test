/**
 * Created by Administrator on 2018/1/24.
 */

var basicInfoForm = null;
var qtyEdit = null;
$(document).ready(function(v)
{
    $("#qty").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            var remark = nui.get("remark");
            remark.focus();
        }
    });

    $("#remark").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            var receiveStoreId = nui.get("receiveStoreId");
            receiveStoreId.focus();
        }
    });
    $("#receiveStoreId").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            var receiveStoreShelf = nui.get("receiveStoreShelf");
            receiveStoreShelf.focus();
        }
    });
    $("#receiveStoreShelf").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            var chooseBtn = nui.get("chooseBtn");
            chooseBtn.focus();
        }
    });
});
function init()
{
    basicInfoForm = new nui.Form("#basicInfoForm");
    qtyEdit = nui.get("qty");
    qtyEdit.setValue(1);
    qtyEdit.focus();

    getStorehouse(function(data)
    {
        var storehouse = data.storehouse||[];
        nui.get("storeId").setData(storehouse);
        nui.get("receiveStoreId").setData(storehouse);
        
    });
}

function setData(data)
{
    init();
    
    data = data||{};
    var part = data.part;

    if(part.editType && part.editType == 'storeId') {
        nui.get("storeId").disable();
    }
    if(part.enterTypeId && part.enterTypeId == '050101') {
        var currentRows = document.getElementById("list_table").rows.length; 
        var insertTr = document.getElementById("list_table").insertRow(currentRows);
        var insertTd = insertTr.insertCell(0);
        insertTd.style.textAlign="right";
        insertTd.style.width="60px";
        insertTd.innerHTML = "仓位：";
        
        insertTd = insertTr.insertCell(1);
        insertTd.innerHTML = '<input id="storeShelf" name="storeShelf" class="nui-textbox" selectOnFocus="true" enabled="true" width="100%"/>';
    }
    if(part)
    {
        basicInfoForm.setData(part);
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
            showMsg(requiredField[key]+"不能为空","W");
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
    var qty = nui.get("qty").getValue();
    var price = nui.get("price").getValue();
    var amt = nui.get("amt").getValue();
    
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
    
    qty = nui.get("qty").getValue();
    price = nui.get("price").getValue();
    amt = nui.get("amt").getValue();
    
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
document.onkeyup=function(event){
    var e=event||window.event;
    var keyCode=e.keyCode||e.which;

    switch(keyCode){
        case 27:
        window.CloseOwnerWindow("");
        break; 
    }

    if((keyCode==83)&&(event.shiftKey))  {  
        onOk();  
    } 

    if((keyCode==67)&&(event.shiftKey))  { 
        onCancel();
    }  
}

