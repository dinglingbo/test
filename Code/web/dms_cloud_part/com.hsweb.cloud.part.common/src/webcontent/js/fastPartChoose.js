var baseUrl = apiPath + cloudPartApi + "/";
var partInfoUrl = baseUrl + "com.hsapi.cloud.part.invoicing.paramcrud.queryBillPartChoose.biz.ext";
var enterUrl = baseUrl + "com.hsapi.cloud.part.invoicing.stockcal.queryOutableEnterGridWithPage.biz.ext";

var morePartTabs = null;
var enterTab = null;
var partInfoTab = null;
var morePartCodeEl = null;
var morePartNameEl = null;
var moreServiceIdEl = null;
var showStockEl = null;
var sortTypeEl = null;
var tempIdEl = null;
var brandHash = {};
var brandList = [];
var storehouse = null;
var billTypeHash = {};
var storeHash = {};
var advancedAddWin = null;
var FStoreId = null;
var advancedAddForm = null;
var mainId = 0;
var guestId = null;

$(document).ready(function(v)
{
    morePartGrid = nui.get("morePartGrid");
    enterGrid = nui.get("enterGrid");
    morePartCodeEl = nui.get("morePartCode");
    morePartNameEl = nui.get("morePartName");
    moreServiceIdEl = nui.get("moreServiceId");
    showStockEl = nui.get("showStock");
    sortTypeEl = nui.get("sortType");
    sortTypeEl.setData(sortTypeList);
    tempIdEl = nui.get("tempId");
    advancedAddWin = nui.get("advancedAddWin");
    advancedAddForm  = new nui.Form("#advancedAddForm");

    morePartTabs = nui.get("morePartTabs");
    enterTab = morePartTabs.getTab("enterTab");
    partInfoTab = morePartTabs.getTab("partInfoTab");

    morePartGrid.setUrl(partInfoUrl);
    morePartGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    morePartGrid.on("load", function(e) {
        var row = morePartGrid.getRow(0);
        if(row){
            morePartGrid.select(row,true);
        }
    });
    morePartGrid.on("rowdblclick", function(e) {
        var row = morePartGrid.getSelected();
        var rowc = nui.clone(row);
        if(!rowc) return;

        addSelectPart();

        nui.get("qty").focus();
    });
    morePartGrid.on("drawcell",function(e){
        switch (e.field)
        {
            case "partBrandId":
                if(brandHash[e.value])
                {
                    e.cellHtml = brandHash[e.value].name||"";
                }
                else{
                    e.cellHtml = "";
                }
                break;
            default:
                break;
        }
    });

    enterGrid.setUrl(enterUrl);
    enterGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    enterGrid.on("load", function(e) {
        var row = enterGrid.getRow(0);
        if(row){
            enterGrid.select(row,true);
            //enterGrid.setCurrentCell([0,0]);
        }
    });
    enterGrid.on("rowdblclick", function(e) {
        var row = enterGrid.getSelected();
        var rowc = nui.clone(row);
        if(!rowc) return;

        addSelectPart();

        nui.get("qty").focus();
        
    });
    enterGrid.on("drawcell",function(e){
        switch (e.field)
        {
            case "partBrandId":
                if(brandHash[e.value])
                {
                    e.cellHtml = brandHash[e.value].name||"";
                }
                else{
                    e.cellHtml = "";
                }
                break;
            case "storeId":
                if(storeHash[e.value])
                {
                    e.cellHtml = storeHash[e.value].name||"";
                }
                else{
                    e.cellHtml = "";
                }
                break;
            case "billTypeId":
                if(billTypeHash[e.value])
                {
                    e.cellHtml = billTypeHash[e.value].name||"";
                }
                else{
                    e.cellHtml = "";
                }
                break;
            default:
                break;
        }
    });

    $("#morePartCode").bind("keydown", function (e) {

        if (e.keyCode == 13) {
            var value = morePartCodeEl.getValue();
            value = value.replace(/\s+/g, "");
            if(value.length>=3){
                morePartSearch();
            }
        }  
        
    });

    $("#morePartName").bind("keydown", function (e) {

        if (e.keyCode == 13) {
            var value = morePartNameEl.getValue();
            value = value.replace(/\s+/g, "");
            if(value.length>=3){
                morePartSearch();
            }
        }
        
    });

    $("#moreServiceId").bind("keydown", function (e) {

        if (e.keyCode == 13) {
            var value = moreServiceIdEl.getValue();
            value = value.replace(/\s+/g, "");
            if(value.length>=3){
                morePartSearch();
            }
        }
        
    });

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
        var keyCode=e.keyCode||e.which;//38向上 40向下

        // if(keyCode==40){
        //     var tab = morePartTabs.getActiveTab();
        //     if(tab.name == "enterTab"){
        //         var row = enterGrid.getSelected();
        //         if(row){
        //             var uid = row._uid + 1;
        //             var row = enterGrid.getRowByUID(uid);
        //             if(row){
        //                 enterGrid.select(row,true);
        //             }
        //         }
        //     }else if(tab.name == "partInfoTab"){
        //         var row = morePartGrid.getSelected();
        //         if(row){
        //             var uid = row._uid + 1;
        //             var row = morePartGrid.getRowByUID(uid);
        //             if(row){
        //                 morePartGrid.select(row,true);
        //             }
        //         }
        //     } 
        // }

        // if(keyCode==38){
        //     var tab = morePartTabs.getActiveTab();
        //     if(tab.name == "enterTab"){
        //         var row = enterGrid.getSelected();
        //         if(row){
        //             var uid = row._uid - 1;
        //             var row = enterGrid.getRowByUID(uid);
        //             if(row){
        //                 enterGrid.select(row,true);
        //             }
        //         }
        //     }else if(tab.name == "partInfoTab"){
        //         var row = morePartGrid.getSelected();
        //         if(row){
        //             var uid = row._uid - 1;
        //             var row = morePartGrid.getRowByUID(uid);
        //             if(row){
        //                 morePartGrid.select(row,true);
        //             }
        //         }
        //     } 
        // }

        if((keyCode==13))  {  //新建
            if(advancedAddWin.visible) return;
            var targetName = $(e.target).attr("name")||"";
            if(targetName=="morePartCode" || targetName=="morePartName" || targetName=="moreServiceId") return;
            var tab = morePartTabs.getActiveTab();
            if(tab.name == "enterTab"){
                addSelectPart();
            }else if(tab.name == "partInfoTab"){
                addSelectPart();
            }
        } 

        if((keyCode==27))  {  //ESC
            if(advancedAddWin.visible){
                onAdvancedAddCancel();
            }else{
                onPartClose();
            }
        }
        
        if((keyCode==120))  {  //F9
            morePartCodeEl.focus();
        }

        if((keyCode==121))  {  //F10
            morePartNameEl.focus();
        }
     
    }

    //绑定表单
    //var db = new nui.DataBinding();
    //db.bindForm("basicInfoForm", leftGrid);
    var dictDefs ={"billTypeId":"DDT20130703000008"};
    initDicts(dictDefs, function(e){
        var billTypeList = nui.get("billTypeId").getData();
        billTypeList.forEach(function(v) {
            billTypeHash[v.customid] = v;
        });
    });
    getStorehouse(function(data)
    {
        storehouse = data.storehouse||[];
        if(storehouse && storehouse.length>0){
            nui.get("storeId").setData(storehouse);
            FStoreId = storehouse[0].id;
            storehouse.forEach(function(v) {
                storeHash[v.id] = v;
            });
        }
    });

    getAllPartBrand(function(data) {
        brandList = data.brand;
        brandList.forEach(function(v) {
            brandHash[v.id] = v;
        });
    });

});
//库存数量↑，库存数量↓；入库日期↑，入库日期↓；成本↑，成本↓
var sortTypeList = [
    {id:"1",text:"入库日期↑"},{id:"2",text:"入库日期↓"},
    {id:"3",text:"库存数量↑"},{id:"4",text:"库存数量↓"},
    {id:"5",text:"成本↑"},{id:"6",text:"成本↓"}
];
var resultData = {};
var callback = null;
var checkcallback = null;
function setInitData(params, ck, cck){
    var value = params.value;
    mainId = params.mainId;
    guestId = params.guestId;
    callback = ck;
    checkcallback = cck;

    var type = judgeConditionType(value);//1代表编码，2代表名称，3代表拼音，-1输入信息有误
    var params = {};
    //params.showStock = 1;
    //showStockEl.setValue(1);
    if(type == 1){
        morePartCodeEl.setValue(value);
        params.partCode = value.replace(/\s+/g, "");
    }else if(type == 2){
        morePartNameEl.setValue(value);
        params.partName = value;
    }else if(type == 3){
        params.namePy = value.replace(/\s+/g, "");
    }

    params.sortField = "B.ENTER_DATE";//默认按日期升序
    params.sortOrder = "asc";

    enterGrid.load({params:params},function(e){
        enterGrid.focus();
    });
}
function morePartSearch(){
    var params = {}; 
    params.partCode = morePartCodeEl.getValue();
    params.partName = morePartNameEl.getValue();
    params.showStock = showStockEl.getValue();
    params.serviceId = moreServiceIdEl.getValue();
    var sortTypeValue = sortTypeEl.getValue();

    if(!params.partCode && !params.partName && !params.serviceId){
        nui.alert("请输入查询条件");
        return;
    }

    var tab = morePartTabs.getActiveTab();
    if(tab.name == "enterTab"){
        if(sortTypeValue == 1){
            params.sortField = "B.ENTER_DATE";
            params.sortOrder = "asc";
        }else if(sortTypeValue == 2){
            params.sortField = "B.ENTER_DATE";
            params.sortOrder = "desc";
        }else if(sortTypeValue == 3){
            params.sortField = "b.OUTABLE_QTY";
            params.sortOrder = "asc";
        }else if(sortTypeValue == 4){
            params.sortField = "b.OUTABLE_QTY";
            params.sortOrder = "desc";
        }else if(sortTypeValue == 5){
            params.sortField = "B.ENTER_PRICE";
            params.sortOrder = "asc";
        }else if(sortTypeValue == 6){
            params.sortField = "B.ENTER_PRICE";
            params.sortOrder = "desc";
        }
        enterGrid.load({params:params},function(e){
            enterGrid.focus();
        });
    }else if(tab.name == "partInfoTab"){
        params.showStock = showStockEl.getValue();
        if(sortTypeValue == 1){
            params.sortField = "b.last_enter_date";
            params.sortOrder = "asc";
        }else if(sortTypeValue == 2){
            params.sortField = "b.last_enter_date";
            params.sortOrder = "desc";
        }else if(sortTypeValue == 3){
            params.sortField = "b.stock_qty";
            params.sortOrder = "asc";
        }else if(sortTypeValue == 4){
            params.sortField = "b.stock_qty";
            params.sortOrder = "desc";
        }else if(sortTypeValue == 5){
            params.sortField = "b.cost_price";
            params.sortOrder = "asc";
        }else if(sortTypeValue == 6){
            params.sortField = "b.cost_price";
            params.sortOrder = "desc";
        }

        morePartGrid.load({params:params},function(e){
            morePartGrid.focus();
        });
    }
    
}

function addSelectPart(){
    var tab = morePartTabs.getActiveTab();
    var record = null;
    var column = null;
    var rowc = null;
    var params = {};
    if(tab.name == "enterTab"){
        record = enterGrid.getSelected();
        rowc = nui.clone(record);
        if(record){
            column = enterGrid.getColumn("stockQty");
            advancedAddWin.show();
            nui.get("storeId").setValue(record.storeId);
            nui.get("qty").setValue(1);
            nui.get("qty").focus();

            params.partId = record.partId;
            params.guestId = guestId;
            var price = getPartPrice(params);
            nui.get("price").setValue(price);
            nui.get("amt").setValue(price);

            nui.get("storeId").enabled = false;

            rowc.isMarkBatch = 1;
            rowc.batchSourceId = record.id;

            resultData = rowc;
            //advancedAddWin.showAtEl(enterGrid._getCellEl(record,column), {xAlign:"outright",yAlign:"bottom"});
        }
    }else if(tab.name == "partInfoTab"){
        record = morePartGrid.getSelected();
        rowc = nui.clone(record);
        if(record){
            column = morePartGrid.getColumn("outableQty");
            advancedAddWin.show();
            nui.get("storeId").setValue(FStoreId);
            nui.get("qty").setValue(1);
            nui.get("qty").focus();
            nui.get("storeId").enabled = true;

            params.partId = record.id;
            params.guestId = guestId;
            var price = getPartPrice(params);
            nui.get("price").setValue(price);
            nui.get("amt").setValue(price);

            nui.

            rowc.isMarkBatch = 0;
            resultData = rowc;
            //advancedAddWin.showAtEl(morePartGrid._getCellEl(record,column), {xAlign:"outright",yAlign:"bottom"});
        }
    }
}

function onPartClose(){
    CloseWindow("cancel");
}
function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onMoreTabChanged(e){
    var tab = e.tab;
    var name = tab.name;
  
    if(name == "enterTab"){
        //nui.get("showStock").hide();
        
    }else if(name == "partInfoTab"){
        //nui.get("showStock").show();
        nui.get("showStock").setValue(1);
    }
    
}
function getRtnData(){
    return resultData;
}
function onAdvancedAddCancel(){
    advancedAddWin.hide();
    advancedAddForm.setData([]);
    morePartCodeEl.focus();
}
var requiredField = {
    storeId:"仓库",
    qty:"数量",
    price:"单价",
    amt:"金额"
};
function onAdvancedAddOk(){
    advancedAddForm.validate();
    if (advancedAddForm.isValid() == false) {
        nui.alert("请输入数字");
        return;
    }

    var data = advancedAddForm.getData();

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
    resultData.storeId = data.storeId;
    resultData.qty = data.qty;
    resultData.price = data.price;
    resultData.amt = data.amt;
    resultData.remark = data.remark;
    
    var tab = morePartTabs.getActiveTab();

    if(tab.name == "enterTab"){
        var row = enterGrid.getSelected();
        var stockQty = row.stockQty;
        var preOutQty = row.preOutQty||0;
        var price = row.enterPrice;
        if(data.qty > stockQty - preOutQty){
            nui.alert("出库数量超出此批次可出库数量");
            return;
        }
        if(data.price < price){
            nui.confirm("单价低于成本，是否继续？", "友情提示",
                function (action) { 
                    if (action == "ok") {
                        doAdd();
                    }else {
                        return;
                    }
                }
            );
        }else{
            doAdd();
        }
    }else{
        doAdd();

    }
}
function doAdd(){
    if(!resultData) return;
    if(!callback) {
        CloseWindow("ok");
        return;
    }else{
        var tab = morePartTabs.getActiveTab();
        //需要判断是否已经添加了此配件
        var checkMsg = checkcallback(resultData);
        if(checkMsg) 
        {
            nui.confirm(checkMsg, "友情提示",
                function (action) { 
                    if (action == "ok") {
                        callback(resultData,function(p){
                            if(tab.name == "enterTab"){
                                var outableqty = p.outableqty;
                                var preoutqty = p.preoutqty;
                                if(preoutqty>=outableqty){
                                    enterGrid.removeRow(enterGrid.getSelected());
                                }else{
                                    var newRow = {stockQty: outableqty,preOutQty: preoutqty};
                                    enterGrid.updateRow(enterGrid.getSelected(), newRow);
                                }
                            }
                        });
                        onAdvancedAddCancel()
                    }else {
                        onAdvancedAddCancel();
                        return;
                    }
                }
            );
        }else
        {
            //弹出数量，单价和金额的编辑界面
            callback(resultData,function(p){
                if(tab.name == "enterTab"){
                    var outableqty = p.outableqty;
                    var preoutqty = p.preoutqty;
                    if(preoutqty>=outableqty){
                        enterGrid.removeRow(enterGrid.getSelected());
                    }else{
                        var newRow = {stockQty: outableqty,preOutQty: preoutqty};
                        enterGrid.updateRow(enterGrid.getSelected(), newRow);
                    }
                }
            });
            onAdvancedAddCancel();
        }
    }
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
            price = (amt / qty).toFixed(4);
            nui.get("price").setValue(price);
        }else {
            nui.get("qty").setValue(0);
            nui.get("amt").setValue(0);
        }
    }
}
var partPriceUrl = baseUrl
        + "com.hsapi.cloud.part.invoicing.pricemanage.getSellDefaultPrice.biz.ext";
function getPartPrice(params){
    var price = 0;
    nui.ajax({
        url : partPriceUrl,
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