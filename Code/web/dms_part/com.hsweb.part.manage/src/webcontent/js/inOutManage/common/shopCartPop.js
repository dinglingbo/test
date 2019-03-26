/**
 * Created by Administrator on 2018/1/24.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var batchInfoForm = null;
var mainGrid = null;
var FStoreId = null;
var partList = null;
var type = null;
var isSupplier = 0;
var isClient = 0;
var shortNameEl = null;
var billTypeIdEl = null;
var settleTypeIdEl = null;
var guestIdEl = null;
var TStoreId = null;
var memList=null;
$(document).ready(function(v)
{
    mainGrid = nui.get("mainGrid");
    batchInfoForm = new nui.Form("#batchInfoForm");
    shortNameEl = nui.get("shortName");
    billTypeIdEl = nui.get("billTypeId");
    settleTypeIdEl = nui.get("settleTypeId");
    guestIdEl = nui.get("guestId");

    var dictDefs ={"billTypeId":"DDT20130703000008", "settleTypeId":"DDT20130703000035"};
    initDicts(dictDefs, null);
    initMember("orderManId",function(){
        //memList = nui.get('orderMan').getData();
    });
    guestIdEl.focus();

    $("#guestId").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            var remark = nui.get("remark");
            remark.focus();
        }
    });

});

function setInitData(data)
{
    FStoreId = data.storeId;
    partList = data.partList;
    type = data.type;//采购订单  销售订单  采购车  销售车    EPC采购订单，EPC销售订单，EPC采购车，EPC销售车
    
    if(type == "pchsOrder" || type == "pchsCart"){
        isSupplier = 1;
        initGridData(partList);
    }

    if(type == "sellOrder" || type == "sellCart"){
        isClient = 1;
        initGridData(partList);
    }

    //如果是从采购车生成采购订单，或是从销售车生成销售订单
    if(type == "fromPchsCart"){
        type = "pchsOrder";
        isSupplier = 1;

        initGridDataTwo(partList);
    }

    if(type == "fromSellCart"){
        type = "sellOrder";
        isClient = 1;
        initGridDataTwo(partList);
    }

    if(type == "pchsOrderEpc" || type == "pchsCartEpc"){
        getStorehouse(function(data) {
            storehouse = data.storehouse || [];
            if(storehouse && storehouse.length>0){
                FStoreId = storehouse[0].id;
            }
            
        });

        isSupplier = 1;
        initGridDataThree(partList);
        if(type == "pchsOrderEpc"){
            type = "pchsOrder";
        }else if(type == "pchsCartEpc"){
            type = "pchsCart";
        }
    }

    if(type == "sellOrderEpc" || type == "sellCartEpc"){
        getStorehouse(function(data) {
            storehouse = data.storehouse || [];
            if(storehouse && storehouse.length>0){
                FStoreId = storehouse[0].id;
            }
            
        });
        isClient = 1;
        initGridDataThree(partList);
        if(type == "sellOrderEpc"){
            type = "sellOrder";
        }else if(type == "sellCartEpc"){
            type = "sellCart";
        }
    }
    
}
function initGridData(data){
    var rows = [];
    if(data && data.length>0){
        for(var i=0; i<data.length; i++){
            var part = data[i];
            var partId = part.id;
            var partCode = part.code;
            var partName = part.name;
            var fullName = part.fullName;
            var unit = part.unit;
            var orderQty = part.orderQty||1;
            var orderPrice = part.orderPrice||0;
            var row = {partId: partId, partCode: partCode, partName: partName, 
                       fullName: fullName, unit: unit, orderQty: orderQty, orderPrice: orderPrice};
            rows.push(row);
        }
    }

    mainGrid.setData(rows);
}
function initGridDataTwo(data){
    var rows = [];
    if(data && data.length>0){
        for(var i=0; i<data.length; i++){
            var part = data[i];
            var partId = part.partId;
            var partCode = part.partCode;
            var partName = part.partName;
            var fullName = part.fullName;
            var unit = part.unit;
            var orderQty = part.orderQty||1;
            var orderPrice = part.orderPrice||0;
            if(part.goodsCode){       	
            	var goodsCode = part.goodsCode || "";
            } 
            if(part.storeCode){
            	 var storeCode = part.storeCode|| "";
            }
            var row = {storeCode:storeCode, goodsCode : goodsCode,partId: partId, partCode: partCode, partName: partName, 
                       fullName: fullName, unit: unit, orderQty: orderQty, orderPrice: orderPrice};
            rows.push(row);
        }

        var main = data[0];

        guestIdEl.setValue(main.guestId);
        guestIdEl.setText(main.guestName);
        shortNameEl.setValue(main.shortName);
        billTypeIdEl.setValue(main.billTypeId);
        settleTypeIdEl.setValue(main.settleTypeId);
        nui.get('orderManId').setValue(currEmpId);
        nui.get('orderManId').setText(currUserName);
        nui.get('orderMan').setValue(currUserName);
    }

    mainGrid.setData(rows);
}
function initGridDataThree(data){
    var rows = [];
    if(data && data.length>0){
        for(var i=0; i<data.length; i++){
            var part = data[i];
            var partId = -1;
            var partCode = part.pid;
            var partName = part.label;
            var fullName = part.label + " 原厂";  //000070 365原厂件  00000327 241原厂
            var unit = "PCS";
            var orderQty = part.orderQty||1;
            var orderPrice = part.orderPrice||0;
            var row = {partId: partId, partCode: partCode, partName: partName, 
                       fullName: fullName, unit: unit, orderQty: orderQty, orderPrice: orderPrice};
            rows.push(row);
        }
    }

    mainGrid.setData(rows);
}
var supplier = null;
function selectSupplier(elId) {
    supplier = null;
    nui.open({
        // targetWindow: window,,
        url : webPath+contextPath+"/com.hsweb.part.common.guestSelect.flow?token="+token,
        title : "往来单位资料",
        width : 980,
        height : 560,
        allowDrag : true,
        allowResize : true,
        onload : function() {
            var iframe = this.getIFrameEl();
            var params = {};
            if(isSupplier == 1) {
                params.isSupplier = 1;
            }
            if(isClient == 1) {
                params.isClient = 1;
            }
            iframe.contentWindow.setGuestData(params);
        },
        ondestroy : function(action) {
            if (action == 'ok') {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();

                supplier = data.supplier;
                var value = supplier.id;
                var text = supplier.fullName;
                var billTypeIdV = supplier.billTypeId;
                var settTypeIdV = supplier.settTypeId;
                var el = nui.get(elId);
                el.setValue(value);
                el.setText(text);
                billTypeIdEl.setValue(supplier.billTypeId);
                settleTypeIdEl.setValue(supplier.settTypeId);
                shortNameEl.setValue(supplier.shortName);

            }
        }
    });
}
function onGuestValueChanged(e) {
    // 供应商中直接输入名称加载供应商信息
    var params = {};
    params.pny = e.value;
    if(isSupplier == 1) {
        params.isSupplier = 1;
    }
    if(isClient == 1) {
        params.isClient = 1;
    }
    setGuestInfo(params);
}
var getGuestInfo = baseUrl
        + "com.hsapi.part.baseDataCrud.crud.querySupplierList.biz.ext";
function setGuestInfo(params) {
    nui.ajax({
        url : getGuestInfo,
        data : {
            params : params,
            token : token
        },
        type : "post",
        success : function(text) {
            if (text) {
                var supplier = text.suppliers;
                if (supplier && supplier.length > 0) {
                    var data = supplier[0];
                    var value = data.id;
                    var text = data.fullName;
                    var el = nui.get('guestId');
                    el.setValue(value);
                    el.setText(text);
                    billTypeIdEl.setValue(data.billTypeId);
                    settleTypeIdEl.setValue(data.settTypeId);
                    shortNameEl.setValue(data.shortName);
                    
                } else {
                    var el = nui.get('guestId');
                    el.setValue(null);
                    el.setText(null);
                    billTypeIdEl.setValue(null);
                    settleTypeIdEl.setValue(null);
                    shortNameEl.setValue(null);
                }
            } else {
                el.setValue(null);
                el.setText(null);
                billTypeIdEl.setValue(null);
                settleTypeIdEl.setValue(null);
                shortNameEl.setValue(null);
            }

        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function onMainGridDrawCell(e) {
    switch (e.field) {
    case "operateBtn":
            e.cellHtml = '<span class="fa fa-close" onClick="javascript:deletePart()" title="删除行"></span>';
            break;
    default:
        break;
    }
}
function deletePart() {
    var row = mainGrid.getSelected();
    if (row) {
        mainGrid.removeRow(row, true);
    }
}
function onCellCommitEdit(e) {
    var editor = e.editor;
    var record = e.record;
    var row = e.row;
    var qty=row.orderQty
    editor.validate();
    if(e.field =='orderQty'){
    	//不是电商自营
    	if(row.storeCode!='000000'){
    		if(e.value > qty){
    			parent.parent.showMsg("数量不能大于库存!","W");
    	        e.cancel = true;
    		}
    	}
    }
    if (editor.isValid() == false) {
    	parent.parent.showMsg("请输入数字!","W");
        e.cancel = true;
    }
}
function OnrpMainGridCellBeginEdit(e){
	 var editor = e.editor;
	 var record = e.record;
	 var row = e.row;
	 //有电商编码
	 if(row.goodsCode){
    	if(e.field == "orderPrice"){
    		 e.cancel = true;
    	}
    }	
}
var generateOrderUrl = baseUrl
        + "com.hsapi.part.invoice.paramcrud.generateOrderByBatch.biz.ext";
function generateOrderByBatch(main,detail,type){
    nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '保存中...'
    });
    nui.ajax({
        url : generateOrderUrl,
        type : "post",
        async: false,
        data : {
            main: main,
            detail: detail,
            type: type,
            token:token
        },
        success : function(data) {
            nui.unmask(document.body);
            var errCode = data.errCode;
            if(errCode == "S"){
            	parent.parent.showMsg("操作成功!","S");
                if(type == "pchsOrder" || type == "sellOrder"){
                    //更新采购车或是销售车的状态
                }
                CloseWindow("ok");
            } else {
            	parent.parent.showMsg(data.errMsg || "操作失败!","W");
            }

        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function onOk()
{
    var data = batchInfoForm.getData();
    if(!data.guestId){
    	parent.parent.showMsg("请选择往来单位!","W");
        return;
    }
    if(!data.orderManId || !data.orderMan){
    	parent.parent.showMsg("请选择采购员!","W");
        return;
    }
    if(!data.planArriveDate){
    	parent.parent.showMsg("请填写预计到货日期!","W");
        return;
    }
    var detail = mainGrid.getData();
    if(detail.length <= 0){
    	parent.parent.showMsg("明细为空!","W");
        return;
    }

    var guestIdEl = nui.get("guestId");
    var main = {};
    main.guestId = guestIdEl.getValue();
    main.guestName = guestIdEl.getText();
    main.shortName = shortNameEl.getValue();
    main.storeId = FStoreId;
    if(type == "pchsCart"){
        main.shopType = 1;
    }
    if(type == "sellCart"){
        main.shopType = -1;
    }
    main.remark = data.remark;
    main.billTypeId = data.billTypeId;
    main.settleTypeId = data.settleTypeId;
    main.orderManId=data.orderManId;
    main.orderMan=data.orderMan;
    main.planArriveDate =nui.get('planArriveDate').getFormValue();
    var rows = mainGrid.findRows(function(row) {
        if (row.partId == -1)
            return true;
    });
    if(rows && rows.length>0){
        main.type = "EPC";
    }

    generateOrderByBatch(main, detail, type);

}

function CloseWindow(action) {
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}


