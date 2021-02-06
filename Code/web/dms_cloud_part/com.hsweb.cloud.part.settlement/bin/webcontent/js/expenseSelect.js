
var baseUrl = apiPath + cloudPartApi + "/";
var notStatementUrl = baseUrl + "com.hsapi.cloud.part.invoicing.expense.queryNotSettleExpenseList.biz.ext";
var mainGrid = null;
var leftGrid = null;
var rightGrid = null;

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
var incomeHash = {};

var sBillAuditDateEl = null;
var eBillAuditDateEl = null;
var billSearchGuestIdEl = null;
var billServiceIdEl = null;
var billServiceManEl = null;
$(document).ready(function(v)
{
	mainGrid = nui.get("mainGrid");
	mainGrid.setUrl(notStatementUrl);   

    billTypeIdEl = nui.get("billTypeId");
    settleTypeIdEl = nui.get("settleTypeId");
    sBillAuditDateEl = nui.get("sBillAuditDate");
    eBillAuditDateEl = nui.get("eBillAuditDate");
    billSearchGuestIdEl = nui.get("searchBillGuestId");
    billServiceIdEl = nui.get("billServiceId");
    billServiceManEl = nui.get("billServiceMan");

    sBillAuditDateEl.setValue(getMonthStartDate());//上月开始日期
    eBillAuditDateEl.setValue(getMonthEndDate());//本月结束日期

    var dictDefs ={"settleTypeId":"DDT20130703000035"};
    initDicts(dictDefs,function()
    {
        var settTypeIdList = settleTypeIdEl.getData();

        settTypeIdList.filter(function(v)
        {
            settTypeIdHash[v.customid] = v;
            return true;
        });
        
        getInComeExpenses(function(data) {
	        var list = data.list;
	        
	        list.filter(function(v)
            {
	        	incomeHash[v.id] = v;
                return true;
            });
	    });

    });

});
var queryUrl = baseUrl + "com.hsapi.cloud.part.settle.svr.queryFibInComeExpenses.biz.ext";
function getInComeExpenses(callback) {
    var params = {itemTypeId : -1, isMain: 0};
    nui.ajax({
        url : queryUrl,
        data : {
            params: params,
            token: token
        },
        type : "post",
        success : function(data) {
            if (data && data.list) {
                callback && callback(data);
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
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
        case "expenseTypeCode":
            if(incomeHash && incomeHash[e.value])
            {
                e.cellHtml = incomeHash[e.value].name;
            }
            break;
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
    params.guestIdList = getConnncetGuest(guestId);
    if(params.guestIdList==""){
    	params.guestId = guestId;
    }

    return params;
}
function searchBill()
{
    var param = getBillSearchParam();
    doNotStatement(param);
}
function doNotStatement(params){
    params.auditSign = 1;
    params.sortField = "audit_date";
    params.sortOrder = "desc";
    params.settleTypeId = "020502";
    params.stateSign = 0;
    params.isState = 0;
    
    mainGrid.load({
        params:params,
        token: token
    });
}
var resultData = {};
var callback = null;
var checkcallback = null;
function addStatement()
{
    var rows = mainGrid.getSelecteds();
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
            var checkMsg = checkcallback(row.id, row.billServiceId);
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
	var rows = mainGrid.getSelecteds();
	if(rows.length<=0){
		$('#sumAmt').html("汇总金额:"+0);
		$('#sumNoStateAmt').html("汇总未对账金额:"+0);
    	return;
    }
	var sumAmt =0;
	var sumNoStateAmt = 0;
	for(var i =0;i<rows.length;i++){
		sumAmt+=rows[i].expenseAmt;
		sumNoStateAmt +=rows[i].noStateAmt;
	}
	$('#sumAmt').html("选中汇总金额:"+sumAmt);
	$('#sumNoStateAmt').html("选中汇总未对账金额:"+sumNoStateAmt);
    
}