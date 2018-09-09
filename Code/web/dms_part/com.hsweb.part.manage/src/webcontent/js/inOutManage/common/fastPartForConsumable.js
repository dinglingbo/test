var partApiUrl = apiPath +  partApi + "/";

var partInfoUrl = partApiUrl + "com.hsapi.part.invoice.paramcrud.queryBillPartChoose.biz.ext";
                               
var enterUrl = partApiUrl + "com.hsapi.part.invoice.stockcal.queryOutableEnterGridWithPage.biz.ext";
var priceGridUrl = partApiUrl+"com.hsapi.part.invoice.pricemanage.getPartPriceInfo.biz.ext";

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

var FStoreId = null;

var mainId = 0;
var guestId = null;
var optTabs = null;
var priceGrid = null;
var mainTabs = null;
var gpartId = 0;
var detail=null;
var serviceId=null;

$(document).ready(function(v)
{
 
    enterGrid = nui.get("enterGrid");
    morePartCodeEl = nui.get("morePartCode");
    morePartNameEl = nui.get("morePartName");
    moreServiceIdEl = nui.get("moreServiceId");
    showStockEl = nui.get("showStock");
    sortTypeEl = nui.get("sortType");
    sortTypeEl.setData(sortTypeList);
    tempIdEl = nui.get("tempId");
 
    optTabs = nui.get("optTabs");
    mainTabs = nui.get("mainTabs");

    morePartTabs = nui.get("morePartTabs");
    enterTab = morePartTabs.getTab("enterTab");
    partInfoTab = morePartTabs.getTab("partInfoTab");
    priceGrid = nui.get("priceGrid");
    priceGrid.setUrl(priceGridUrl);
    
	

    optTabs.on("activechanged",function(e){
        showTabInfo();
    });

    priceGrid.on("CellCommitEdit",function(e) {
        var editor = e.editor;
        var record = e.record;
        var row = e.row;
        editor.validate();
        if (editor.isValid() == false) {
            showMsg("请输入数字!","W");
            e.cancel = true;
        }
    });

   
    enterGrid.on("selectionchanged",function(e){
        var row = enterGrid.getSelected();
        gpartId = row.partId||0;
//        showBottomTabInfo(gpartId);
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

//    mainTabs.on("activechanged",function(e){
//        showBottomTabInfo(gpartId);
//    });

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

      

        if((keyCode==13))  {  //新建

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
      
                onPartClose();

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
        nui.get('partBrandId').setData(brandList);
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

    var tab = morePartTabs.getActiveTab();
    if(tab.name == "enterTab"){
        params.sortField = "B.ENTER_DATE";
        params.sortOrder = "asc";
        enterGrid.load({params:params},function(e){
            enterGrid.focus();
        });
    }
    
}
function morePartSearch(){
    var params = {}; 
    params.partCode = morePartCodeEl.getValue();
    params.partName = morePartNameEl.getValue();
    params.showStock = showStockEl.getValue();
    params.serviceId = moreServiceIdEl.getValue();
    params.partBrandId = nui.get('partBrandId').getValue();
    var sortTypeValue = sortTypeEl.getValue();

    if(!params.partCode && !params.partName && !params.serviceId && !params.partBrandId){
        showMsg("请输入查询条件!","W");
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
           
            nui.get("storeId").setValue(record.storeId);
            nui.get("qty").setValue(1);
            nui.get("qty").focus();

            params.partId = record.partId;
            params.guestId = guestId;
            var price = getPartPrice(params);
            if(price == 0){
                price = record.enterPrice||0;
            }
            nui.get("price").setValue(price);
            nui.get("amt").setValue(price);

            nui.get("storeId").enabled = false;

            rowc.isMarkBatch = 1;
            rowc.batchSourceId = record.id;

            resultData = rowc;
            //advancedAddWin.showAtEl(enterGrid._getCellEl(record,column), {xAlign:"outright",yAlign:"bottom"});
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

function getRtnData(){
    return resultData;
}
function onAdvancedAddCancel(){
    priceGrid.setData([]);
    morePartCodeEl.focus();
}
var requiredField = {
    storeId:"仓库",
    qty:"数量",
    price:"单价",
    amt:"金额"
};
function onAdvancedAddOk(){

    for(var key in requiredField)
    {
        if(!data[key] || data[key].toString().trim().length==0)
        {
            showMsg(requiredField[key]+"不能为空!","W");
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
            showMsg("出库数量超出此批次可出库数量","W");
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
var partPriceUrl = partApiUrl + "com.hsapi.part.invoice.pricemanage.getSellDefaultPrice.biz.ext";
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
function showTabInfo(){
//	var tab = optTabs.getActiveTab();
//	var name = tab.name;
//    var url = tab.url;
//    if(name == 'priceTab'){
//        var data = priceGrid.getData();
//        if(data && data.length>0) return;
//        var partId = 0;
//        var mtab = morePartTabs.getActiveTab();
//        if(mtab.name == "enterTab"){
//            var row = enterGrid.getSelected();
//            partId = row.partId;
//        }
//        var params = {partId:partId,show:1};
//        if(!params.partId || params.partId<=0){
//            priceGrid.setData([]);
//            return;
//        }
//    
//        priceGrid.load({
//            params:params,
//            token:token
//        });
//    }
}

function getMainData()
{
 
    //汇总明细数据到主表
    var isFinished = 0;
    var auditSign = 0;
    var billStatusId = '';
    var printTimes = 0;
    var orderTypeId = 5;
    var isDiffOrder = 1;
    var date=new Date();
    var operateDate = format(date, 'yyyy-MM-dd HH:mm:ss') + '.0';
    var data = {
    	guestId		: 5,
    	isFinished	: isFinished,
    	auditSign	: auditSign,
    	billStatusId: billStatusId,
    	printTimes  : printTimes, 
    	orderTypeId : orderTypeId,
    	isDiffOrder : isDiffOrder,
    	operateDate : operateDate
    };
    
//
//    rightGrid.findRow(function(row){
//        var partId = row.partId;
//        var partCode = row.comPartCode;
//        if(partId == null || partId == "" || partId == undefined || partCode == null || partCode == "" || partCode == undefined){
//            rightGrid.removeRow(row);
//        }
//    });

    return data;
}
function removeChanges(added, modified, removed, all) {
    for(var i=0; i<added.length; i++) {
    
       var val = added[i];
       for(var j=0; j<all.length; j++) {
        
           if(all[j] == val)
           all.splice(j, 1);
        }
    }
    
    for(var i=0; i<modified.length; i++) {
    
       var val = modified[i];
       for(var j=0; j<all.length; j++) {
        
           if(all[j] == val)
           all.splice(j, 1);
        }
    }
    
    for(var i=0; i<removed.length; i++) {
    
       var val = removed[i];
       for(var j=0; j<all.length; j++) {
        
           if(all[j] == val)
           all.splice(j, 1);
        }
    }

    return all;
}

//新增单据时，取单据ID
var saveAddUrl = partApiUrl + "com.hsapi.part.invoice.crud.saveAddSellOrder.biz.ext";
function getSellOrderBillNO(callback){
    var data = getMainData();
    data.isDiffOrder = 1;
    nui.ajax({
        url : saveAddUrl,
        type : "post",
        async:false,
        data : JSON.stringify({
            main : data,
            token : token
        }),
        success : function(data) {
            data = data || {};
            if (data.errCode == "S") {
                var main = data.main;
                serviceId=data.main.serviceId;
                var row=enterGrid.getSelected();
                var newRow={serviceId:serviceId};
                enterGrid.updateRow(row,newRow);
                callback && callback(main)
            } else {
                showMsg(data.errMsg || "请先保存单据添加配件","W");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
//判断库存

var saveStepUrl = partApiUrl + "com.hsapi.part.invoice.crud.insertPjSellOrderStepTran.biz.ext";
function saveDetail(detail){
	detail=enterGrid.getSelected();
    nui.ajax({
		url : saveStepUrl,
		type : "post",
		async:false,
		data : JSON.stringify({
			sellOrderDetail : detail,
			serviceId :detail.serviceId,
            token : token
		}),
		success : function(data) {
			data = data || {};
			if (data.errCode == "S") {
                var sellOrderDetail = data.sellOrderDetail;
                callback && callback(sellOrderDetail,data.p);
			} else {
				alert(data.errMsg || "新增数据失败!");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}

var saveUrl = partApiUrl + "com.hsapi.part.invoice.crud.savePjSellOrder.biz.ext?token"+token;
function save() {
//	var data = basicInfoForm.getData();
//	for ( var key in requiredField) {
//		if (!data[key] || $.trim(data[key]).length == 0) {
//            showMsg(requiredField[key] + "不能为空!","W");
//			return;
//		}
//	}
//
//    var row = leftGrid.getSelected();
//    if(row){
//        if(row.auditSign == 1) {
//            showMsg("此单已出库!","W");
//            return;
//        } 
//    }else{
//        return;
//    }
//    

    data = getMainData();
   
    /*var enterDetailAdd = rightGrid.getChanges("added")||[];
    var enterDetailUpdate = [];
    for(var key in editPartHash)
    {
        if(typeof editPartHash[key] == 'object')
        {
            enterDetailUpdate.push(editPartHash[key]);
        }
    }
    var enterDetailDelete = rightGrid.getChanges("removed")||[];
    enterDetailDelete = enterDetailDelete.filter(function(v)
    {
        return v.detailId;
    });*/

    var sellOrderDetailAdd = enterGrid.getChanges("added");
    var sellOrderDetailUpdate = enterGrid.getChanges("modified");
    var sellOrderDetailDelete = enterGrid.getChanges("removed");
    var sellOrderDetailList = enterGrid.getData();
    sellOrderDetailList = removeChanges(sellOrderDetailAdd, sellOrderDetailUpdate, sellOrderDetailDelete, sellOrderDetailList);

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });

	nui.ajax({
		url : saveUrl,
		type : "post",
		async:false,
		data : JSON.stringify({
			sellOrderMain : data,
			sellOrderDetailAdd : sellOrderDetailAdd,
			sellOrderDetailUpdate : sellOrderDetailUpdate,
			sellOrderDetailDelete : sellOrderDetailDelete,
            sellOrderDetailList : sellOrderDetailList,
            token : token
		}),
		success : function(data) {
            nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
                showMsg("保存成功!","S");
                var pjSellOrderMainList = data.pjSellOrderMainList;
                if(pjSellOrderMainList && pjSellOrderMainList.length>0) {
                    var leftRow = pjSellOrderMainList[0];
                    var row = leftGrid.getSelected();
                    leftGrid.updateRow(row,leftRow);

                    //保存成功后重新加载数据
                    loadMainAndDetailInfo(leftRow);

                    
                }
				//onLeftGridRowDblClick({});
                
			} else {
                showMsg(data.errMsg || "保存失败!","W");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
            nui.unmask(document.body);
			console.log(jqXHR.responseText);
		}
	});
}
function onOut(){
	var row=enterGrid.getSelected();
	
	if(row){
		nui.open({
			url:webPath + partDomain +"/manage/inOutManage/common/fastPartForConsumableAdd.jsp?token"+token,
			title: "出库", width: 250, height: 150,
			allowDrag : true,
	        allowResize : true,
			onload: function(){
			},
			ondestroy: function(action){
				if(action == 'ok'){
					var iframe = this.getIFrameEl();
					var data=iframe.contentWindow.getData();
					var	part=data.data;
					var orderMan=part.orderMan;
					var remark=part.remark;
					var orderQty=part.orderQty;
					var row=enterGrid.getSelected();
					var newRow={orderMan:orderMan,remark:remark,orderQty:orderQty};
					enterGrid.updateRow(row,newRow);
					getSellOrderBillNO();
					saveDetail();
					save();
//					saveAndOut();
//					enterGrid.setData(data);
//					enterGrid.reload();
//					nui.alert("确定出库？");
//					CloseWindow("ok");
				}
			}
		});
	}else{
		showMsg("请选择一条记录","W");
	}
}
function saveAndOut(){
	getSellOrderBillNO();
	saveDetail();
	save();
}

