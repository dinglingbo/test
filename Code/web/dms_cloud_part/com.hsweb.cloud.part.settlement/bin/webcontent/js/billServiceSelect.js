
var baseUrl = apiPath + cloudPartApi + "/";
var notStatementUrl = baseUrl + "com.hsapi.cloud.part.settle.svr.queryOrderBill.biz.ext";
var innerPchsGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjPchsOrderDetailList.biz.ext";
var innerSellGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjSellOrderDetailList.biz.ext";
var innerAllotEnterGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.allotsettle.getAllotApplyDetail.biz.ext";
var innerAllotOutGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.allotsettle.getAllotAcceptDetailById.biz.ext";
var notStatementGrid = null;
var leftGrid = null;
var rightGrid = null;
var editFormPchsEnterDetail = null;
var innerPchsEnterGrid = null;
var editFormPchsRtnDetail = null;
var innerPchsRtnGrid = null;
var editFormSellOutDetail = null;
var innerSellOutGrid = null;

var editFormAllotEnterDetail = null;
var innerAllotEnterGrid = null;
var editFormAllotOutDetail = null;
var innerAllotOutGrid = null;

var orderTypeId = 1;

var brandHash = {};
var brandList = [];
var storehouse = null;
var storeHash={};
var billTypeIdEl = null;
var settleTypeIdEl = null;
var billTypeIdHash = {};
var settTypeIdHash = {};
var billTypeIdList = [];
var settTypeIdList = [];

var sBillAuditDateEl = null;
var eBillAuditDateEl = null;
var billSearchGuestIdEl = null;
var billServiceIdEl = null;
var billServiceManEl = null;
$(document).ready(function(v)
{
    notStatementGrid = nui.get("notStatementGrid");
    notStatementGrid.setUrl(notStatementUrl);   

    innerPchsEnterGrid = nui.get("innerPchsEnterGrid");
    editFormPchsEnterDetail = document.getElementById("editFormPchsEnterDetail");
    innerPchsEnterGrid.setUrl(innerPchsGridUrl);

    innerPchsRtnGrid = nui.get("innerPchsRtnGrid");
    editFormPchsRtnDetail = document.getElementById("editFormPchsRtnDetail");
    innerPchsRtnGrid.setUrl(innerSellGridUrl);
    
    innerSellOutGrid = nui.get("innerSellOutGrid");
    editFormSellOutDetail = document.getElementById("editFormSellOutDetail");
    innerSellOutGrid.setUrl(innerSellGridUrl);

    innerAllotEnterGrid = nui.get("innerAllotEnterGrid");
    editFormAllotEnterDetail = document.getElementById("editFormAllotEnterDetail");
    innerAllotEnterGrid.setUrl(innerAllotEnterGridUrl);

    innerAllotOutGrid = nui.get("innerAllotOutGrid");
    editFormAllotOutDetail = document.getElementById("editFormAllotOutDetail");
    innerAllotOutGrid.setUrl(innerAllotOutGridUrl);

    billTypeIdEl = nui.get("billTypeId");
    settleTypeIdEl = nui.get("settleTypeId");
    sBillAuditDateEl = nui.get("sBillAuditDate");
    eBillAuditDateEl = nui.get("eBillAuditDate");
    billSearchGuestIdEl = nui.get("searchBillGuestId");
    billServiceIdEl = nui.get("billServiceId");
    billServiceManEl = nui.get("billServiceMan");

    sBillAuditDateEl.setValue(getMonthStartDate());//上月开始日期
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
        storehouse.forEach(function(v){
        	storeHash[v.id]=v;
        })
    });

    getAllPartBrand(function(data) {
        brandList = data.brand;
        brandList.forEach(function(v) {
            brandHash[v.id] = v;
        });
    });

    

});
function setInitData(data,orderTypeIdList, ck, cck){
    callback = ck;
    checkcallback = cck;
    billSearchGuestIdEl.setValue(data);
    nui.get('orderTypeIdList').setValue(orderTypeIdList);
    searchBill();
}

var accountList = [
    {id:0,text:"未对账"},
    {id:1,text:"已对账"},
    {id:2,text:"全部"}
];
var orderTypeIdHash = {1:"采购订单",2:"销售订单",3:"采购退货",4:"销售退货",
                       5:"调拨申请",6:"调拨受理",7:"调出退回",8:"调入退回"};
var accountSignHash = {
    "0":"未对账",
    "1":"已对账"
};
function onDrawCell(e)
{
    switch (e.field)
    {
        case "comPartBrandId":
        	 if(brandHash[e.value])
             {
//                 e.cellHtml = brandHash[e.value].name||"";
             	if(brandHash[e.value].imageUrl){
             		
             		e.cellHtml = "<img src='"+ brandHash[e.value].imageUrl+ "'alt='配件图片' height='25px' width=' '/><br> "+brandHash[e.value].name||"";
             	}else{
             		e.cellHtml = brandHash[e.value].name||"";
             	}
             }
             else{
                 e.cellHtml = "";
             }
             break;
        case "billTypeId":
            if(billTypeIdHash && billTypeIdHash[e.value])
            {
                e.cellHtml = billTypeIdHash[e.value].name;
            }
            break;
        /*case "billStatus":
            if(billStatusHash && billStatusHash[e.value])
            {
                e.cellHtml = billStatusHash[e.value];
            }
            break;*/
        case "orderTypeId":
            if(orderTypeIdHash && orderTypeIdHash[e.value])
            {
                e.cellHtml = orderTypeIdHash[e.value];
            }
            break;
        case "settleTypeId":
            if(settTypeIdHash && settTypeIdHash[e.value])
            {
                e.cellHtml = settTypeIdHash[e.value].name;
            }
            break;
        case "storeId":
            if(storeHash && storeHash[e.value])
            {
                e.cellHtml = storeHash[e.value].name;
            }
            break;
        case "accountSign":
            if(accountSignHash && accountSignHash[e.value])
            {
                e.cellHtml = accountSignHash[e.value];
            }
            break;
        default:
            break;
    }
}
function getBillSearchParam(){

    var params = {};
    params.sAuditDate = sBillAuditDateEl.getFormValue();
    params.eAuditDate = addDate(eBillAuditDateEl.getValue(), 1);
    params.serviceId = billServiceIdEl.getValue().replace(/\s+/g, "");
    var guestId = billSearchGuestIdEl.getValue();
    //params.guestIdList = getConnncetGuest(guestId);
    //if(params.guestIdList==""){
    	params.settleGuestId = guestId;
    //}
    	params.guestId = nui.get("searchGuestId").getValue();
    params.orderTypeIdList = nui.get('orderTypeIdList').getValue();
    return params;
}
function searchBill()
{
    var param = getBillSearchParam();
    doNotStatement(param);
}
function doNotStatement(params){
    params.auditSign = 1;
    params.sortField = "auditDate";
    params.sortOrder = "desc";
    params.settleTypeId = "020502";
    params.stateSign = 0;
    params.isState = 0;
    
//    params.isState = 0;
    notStatementGrid.load({
        params:params,
        token: token
    });
}
function onShowRowDetail(e) {
    var row = e.record;
    var mainId = row.mainId;
    
    //将editForm元素，加入行详细单元格内
    var td = notStatementGrid.getRowDetailCellEl(row);
    var dc = row.dc;    
    var orderTypeId =row.orderTypeId;
    switch (orderTypeId)
    {
        case 1:
        case 4:
            td.appendChild(editFormPchsEnterDetail);
            editFormPchsEnterDetail.style.display = "";

            var params = {};
            params.mainId = mainId;
            params.auditSign = 1;
            innerPchsEnterGrid.load({
                params:params,
                token: token
            });
            break;
        case 2:
        case 3:
        	//销售
        	if(orderTypeId ==2){
        		td.appendChild(editFormSellOutDetail);
        		editFormSellOutDetail.style.display = "";

                var params = {};
                params.mainId = mainId;
                params.auditSign = 1;
                innerSellOutGrid.load({
                    params:params,
                    token: token
                });
        	}else{
        		td.appendChild(editFormPchsRtnDetail);
                editFormPchsRtnDetail.style.display = "";

                var params = {};
                params.mainId = mainId;
                params.auditSign = 1;
                innerPchsRtnGrid.load({
                    params:params,
                    token: token
                });
        	}           
            break;
        case 5:
        case 7:
            td.appendChild(editFormAllotEnterDetail);
            editFormAllotEnterDetail.style.display = "";

            innerAllotEnterGrid.load({
                mainId:mainId,
                token: token
            });
            break;
        case 6:
        case 8:
            td.appendChild(editFormAllotOutDetail);
            editFormAllotOutDetail.style.display = "";

            innerAllotOutGrid.load({
                mainId:mainId,
                token: token
            });
            break;
        default:
            break;
    }
}

var resultData = {};
var callback = null;
var checkcallback = null;
function addStatement()
{
    var rows = notStatementGrid.getSelecteds();
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

var guestConUrl = baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.queryGuestConnect.biz.ext";
function getConnncetGuest(guestId){
	var guestIdList ="";
	$.ajaxSettings.async = false;
	$.post(guestConUrl+"?guestId="+guestId+"&token="+token,{},function(text){
		var data =text.data;
		for(var i=0;i<data.length;i++){
			guestIdList+=data[i].guestConnectId+","+data[i].guestId+",";
		}
		guestIdList=guestIdList+guestId;
	});
	return guestIdList;
}
function onCancel(e) {
    CloseWindow("cancel");
}


function onNotStatementGridSelectionChanged(e){
	var rows = notStatementGrid.getSelecteds();
	if(rows.length<=0){
		$('#sumAmt').html("汇总金额:"+0);
		$('#sumNoStateAmt').html("汇总未对账金额:"+0);
    	return;
    }
	var sumAmt =0;
	var sumNoStateAmt = 0;
	for(var i =0;i<rows.length;i++){
		sumAmt+=rows[i].billAmt;
		sumNoStateAmt +=rows[i].noStateAmt;
	}
	$('#sumAmt').html("选中汇总金额:"+sumAmt);
	$('#sumNoStateAmt').html("选中汇总未对账金额:"+sumNoStateAmt);
    
}

var supplier = null;
function selectSupplier(elId) {
	supplier = null;
	nui.open({
//		// targetWindow: window,,
		url : webPath+contextPath+"/com.hsweb.cloud.part.common.guestSelect.flow?token="+token,
		title : "供应商资料",
		width : 980,
		height : 560,
		allowDrag : true,
		allowResize : true,
		onload : function() {
			var iframe = this.getIFrameEl();
			var params = {
                //isSupplier: 1
            };
            iframe.contentWindow.setGuestData(params);
		},
		ondestroy : function(action) {
			if (action == 'ok') {
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
//function onDrawSummaryCell(e)
//{
//    var rows = notStatementGrid.getSelecteds();//rightGrid.getData();
//    if(rows.length<=0){
//    	return;
//    }
//    if (e.field == "billAmt") { 
//        var billAmt = 0;
//        for (var i = 0; i < rows.length; i++) {
//        	billAmt += parseFloat(rows[i].billAmt);
//        }
////        nui.get("billAmt").setValue(billAmt);
//    }
//    if (e.field == "noStateAmt") { 
//        var noStateAmt = 0;
//        for (var i = 0; i < rows.length; i++) {
//        	noStateAmt += parseFloat(rows[i].noStateAmt);
//        }
////        nui.get("billAmt").setValue(billAmt);
//    }
//}