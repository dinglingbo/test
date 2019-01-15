
var baseUrl = apiPath + partApi + "/";
var notSettleUrl = baseUrl + "com.hsapi.part.invoice.ordersettle.queryNotSettlePchsRtnOrderMainList.biz.ext";
var innerPchsGridUrl = baseUrl+"com.hsapi.part.invoice.svr.queryPjSellOrderDetailList.biz.ext";
var notSettleGrid = null;
var leftGrid = null;
var rightGrid = null;
var editFormPchsOrderDetail = null;
var innerPchsOrderGrid = null;
var brandHash = {};
var brandList = [];
var storehouse = null;
var billTypeIdEl = null;
var settleTypeIdEl = null;
var billTypeIdHash = {};
var settTypeIdHash = {};
var billTypeIdList = [];
var settTypeIdList = [];
var FStoreId = null;
var billStatusIdEl = null;

var sBillAuditDateEl = null;
var eBillAuditDateEl = null;
var billSearchGuestIdEl = null;
var billServiceIdEl = null;
var billServiceManEl = null;
var accountSignEl = null;
var billStatusIdList = [
    {id:0,text:"待受理"},
    {id:1,text:"已受理"}
];
$(document).ready(function(v)
{
	notSettleGrid = nui.get("notSettleGrid");
    notSettleGrid.setUrl(notSettleUrl);	

    innerPchsOrderGrid = nui.get("innerPchsOrderGrid");
    editFormPchsOrderDetail = document.getElementById("editFormPchsOrderDetail");
    innerPchsOrderGrid.setUrl(innerPchsGridUrl);

    billTypeIdEl = nui.get("billTypeId");
    settleTypeIdEl = nui.get("settleTypeId");
    sBillAuditDateEl = nui.get("sBillAuditDate");
	eBillAuditDateEl = nui.get("eBillAuditDate");
	billSearchGuestIdEl = nui.get("searchBillGuestId");
	billServiceIdEl = nui.get("billServiceId");
	billServiceManEl = nui.get("billServiceMan");
    billStatusIdEl = nui.get("billStatusId");
    billStatusIdEl.setData(billStatusIdList);

	sBillAuditDateEl.setValue(getLastMonthStartDate());//上月开始日期
	eBillAuditDateEl.setValue(getMonthEndDate());//本月结束日期

    var dictDefs ={"billTypeId":"DDT20130703000008", "settleTypeId":"DDT20130703000035"};
    initDicts(dictDefs,function()
    {
    	var billTypeIdList = billTypeIdEl.getData();
    	var settTypeIdList = settleTypeIdEl.getData();
    	billTypeIdList.filter(function(v)
        {
            billTypeIdHash[v.customid] = v;
            return true;
        });

        settTypeIdList.filter(function(v)
        {
            settTypeIdHash[v.customid] = v;
            return true;
        });

    });
    getStorehouse(function(data)
    {
        storehouse = data.storehouse||[];
        if(storehouse && storehouse.length>0){
            FStoreId = storehouse[0].id;
        }else{
            isNeedSet = true;
        }
    });

    getAllPartBrand(function(data) {
        brandList = data.brand;
        brandList.forEach(function(v) {
            brandHash[v.id] = v;
        });
    });

    /*if(parent.getParentStoreId){
        FStoreId = parent.getParentStoreId();
    }*/

    
    searchBill();
});
var billStatusIdHash = {
    "0" : "待受理",
    "1" : "已受理"
};
function setInitData(guestId, ck, cck){
    callback = ck;
    checkcallback = cck;

    billSearchGuestIdEl.setValue(guestId);

    searchBill();
}
function onDrawCell(e)
{
    switch (e.field)
    {
        case "comPartBrandId":
            if(brandHash && brandHash[e.value])
            {
                e.cellHtml = brandHash[e.value].name;
            }
            break;
        case "billTypeId":
            if(billTypeIdHash && billTypeIdHash[e.value])
            {
                e.cellHtml = billTypeIdHash[e.value].name;
            }
            break;
        case "settleTypeId":
            if(settTypeIdHash && settTypeIdHash[e.value])
            {
                e.cellHtml = settTypeIdHash[e.value].name;
            }
            break;
        case "storeId":
            if(storehouse && storehouse[e.value])
            {
                e.cellHtml = storehouse[e.value].name;
            }
            break;
        case "isRtnSign":
            if(billStatusIdHash && billStatusIdHash[e.value])
            {
                e.cellHtml = billStatusIdHash[e.value];
            }
            break;
        default:
            break;
    }
}
var supplier = null;    
function selectSupplier(elId)
{
    supplier = null;
    nui.open({
        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.part.common.guestSelect.flow?token="+token,
        title: "客户选择", width: 980, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var params = {
                isClient:1,
                guestType:'01020102'
            };
            iframe.contentWindow.setGuestData(params);
        },
        ondestroy: function (action)
        {
            if(action == 'ok')
            {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
               
                supplier = data.supplier;
                var value = supplier.id;
                var text = supplier.fullName;
                var el = nui.get(elId);
                el.setValue(value);
                el.setText(text);
            }
        }
    });
}
function getBillSearchParam(){

	var params = {};
    params.sAuditDate = sBillAuditDateEl.getValue();
    params.eAuditDate = addDate(eBillAuditDateEl.getValue(), 1);
    params.serviceId = billServiceIdEl.getValue();
    params.orderMan = billServiceManEl.getValue();
    params.guestId = billSearchGuestIdEl.getValue();
    params.isRtnSign = billStatusIdEl.getValue();
    return params;
}
function searchBill()
{
    var param = getBillSearchParam();
    doNotStatement(param);
}
function doNotStatement(params){
    params.orderTypeId = 3;
    notSettleGrid.load({
        params:params,
        token: token
    });
}
function onShowRowDetail(e) {
    var row = e.record;
    var mainId = row.id;
    
    //将editForm元素，加入行详细单元格内
    var td = notSettleGrid.getRowDetailCellEl(row);   

    td.appendChild(editFormPchsOrderDetail);
    editFormPchsOrderDetail.style.display = "";

    var params = {};
    params.mainId = mainId;
    innerPchsOrderGrid.load({
        params:params,
        token: token
    });
}
function backPchsOrder(){
    var row = notSettleGrid.getSelected();
    if(row){
        var billStatusId = row.billStatusId;
        if(billStatusId != 1){
            showMsg("只能退回【待发货】状态下的订单!","W");
            return;
        }
        backPchsOrder(row.id);
    }
}
function addSellOrder(){
    var row = notSettleGrid.getSelected();
    if(row){
        var isRtnSign = row.isRtnSign;
        if(isRtnSign != 0){
            showMsg("只能受理【待受理】状态下的订单!","W");
            return;
        }
        generateSellOrder(row.id);
    }
}
//根据采购订单内容生成销售订单
function generateSellOrder(mainId){
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '处理中...'
    });
    nui.ajax({
        url : baseUrl + "com.hsapi.part.invoice.ordersettle.generateSellRtnOrder.biz.ext",
        type : "post",
        async: false,
        data : {
            sellMainId: mainId,
            dStoreId: FStoreId,
            token: token
        },
        success : function(data) {
            nui.unmask(document.body);
            var errCode = data.errCode;
            if(errCode == "S"){
                var serviceId = data.serviceId;
                if(serviceId){
                    showMsg("生成销售退货成功!单号为："+serviceId,"S");
                }

                searchBill();
            }else {
                showMsg(data.errMsg || "保存失败!","E");
            }

        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
//退回采购订单
function backPchsOrder(mainId){
    /*nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '处理中...'
    });
    nui.ajax({
        url : baseUrl + "com.hsapi.cloud.part.invoicing.ordersettle.generateSellOrder.biz.ext",
        type : "post",
        async: false,
        data : {
            pchsMainId: mainId,
            dStoreId: FStoreId,
            token: token
        },
        success : function(data) {
            nui.unmask(document.body);
            var errCode = data.errCode;
            if(errCode == "S"){
                var serviceId = data.serviceId;
                if(serviceId){
                    nui.alert("生成销售退货成功!单号为："+serviceId);
                }

                searchBill();
            }else {
                nui.alert(data.errMsg || "保存失败!");
            }

        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });*/
}
var resultData = {};
var callback = null;
var checkcallback = null;
function addStatement()
{
    var rows = notSettleGrid.getSelecteds();
    //var nodec = nui.clone(node);
    
    if(!rows){
        return;
    }else if(rows && rows.length<=0){
        return;
    }


    if(!callback)
    {
        CloseWindow("ok");
    }
    else{
        //需要判断是否已经添加了此单据
        for(var i=0; i<rows.length; i++){
            var row = rows[i];
            var checkMsg = checkcallback(row.serviceId);
            if(checkMsg){
                showMsg(checkMsg,"W");
                return;
            }
        }

        callback(rows);

        CloseWindow("ok");
    }
}
function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
