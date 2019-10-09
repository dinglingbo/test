
var baseUrl = apiPath + cloudPartApi + "/";
var notStatementUrl = baseUrl + "com.hsapi.cloud.part.settle.svr.queryRPBill.biz.ext";
var innerPchsGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjEnterDetailList.biz.ext";
var innerSellGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjSellOutDetailList.biz.ext";
var notStatementGrid = null;
var leftGrid = null;
var rightGrid = null;
var editFormPchsEnterDetail = null;
var innerPchsEnterGrid = null;
var editFormPchsRtnDetail = null;
var innerPchsRtnGrid = null;
var editFormSellOutDetail = null;
var innerSellOutGrid = null;
var editFormSellRtnDetail = null;
var innerSellRtnGrid = null;
var brandHash = {};
var brandList = [];
var storehouse = null;
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
var accountSignEl = null;

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

    innerSellRtnGrid = nui.get("innerSellRtnGrid");
    editFormSellRtnDetail = document.getElementById("editFormSellRtnDetail");
    innerSellRtnGrid.setUrl(innerPchsGridUrl);

    billTypeIdEl = nui.get("billTypeId");
    settleTypeIdEl = nui.get("settleTypeId");
    sBillAuditDateEl = nui.get("sBillAuditDate");
	eBillAuditDateEl = nui.get("eBillAuditDate");
	billSearchGuestIdEl = nui.get("searchBillGuestId");
	billServiceIdEl = nui.get("billServiceId");
	billServiceManEl = nui.get("billServiceMan");
	accountSignEl = nui.get("accountSign");

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
    });

    getAllPartBrand(function(data) {
        brandList = data.brand;
        brandList.forEach(function(v) {
            brandHash[v.id] = v;
        });
    });

    

});
function setInitData(guestId, ck, cck){
    callback = ck;
    checkcallback = cck;

    billSearchGuestIdEl.setValue(guestId);

    searchBill();
}

var accountList = [
    {id:0,text:"未对账"},
    {id:1,text:"已对账"},
    {id:2,text:"全部"}
];
var enterTypeIdHash = {"050101":"采购入库","050102":"销售退货","050201":"采购退货","050202":"销售出库"};
var orderTypeIdHash ={"1":"采购入库","2":"销售出库","3":"采购退货","4":"销售退货"};
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
//                e.cellHtml = brandHash[e.value].name||"";
            	if(brandHash[e.value].imageUrl){
            		
            		e.cellHtml = "<img src='"+ brandHash[e.value].imageUrl+ "'alt='配件图片' height='25px' width=' '/><br> "+brandHash[e.value].name||"";
            	}else{
            		e.cellHtml = brandHash[e.value].name||"";
            	}
            }
            else{
                e.cellHtml = "";
            }
            break;;
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
        case "enterTypeId":
            if(enterTypeIdHash && enterTypeIdHash[e.value])
            {
                e.cellHtml = enterTypeIdHash[e.value];
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
        case "storeId":
            if(storehouse && storehouse[e.value])
            {
                e.cellHtml = storehouse[e.value].name;
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
	var accountSign = accountSignEl.getValue();
	if(accountSign == 2){
		accountSign = null;
	}
	var params = {};
    params.sAuditDate = sBillAuditDateEl.getValue();
    params.eAuditDate = addDate(eBillAuditDateEl.getValue(), 1);
    params.serviceId = billServiceIdEl.getValue();
    params.serviceMan = billServiceManEl.getValue();
    params.accountSign = accountSign;
    var guestId = billSearchGuestIdEl.getValue();
    params.guestIdList = getConnncetGuest(guestId);
    return params;
}
function searchBill()
{
    var param = getBillSearchParam();
    doNotStatement(param);
}
function doNotStatement(params){
	params.sortField = "auditDate";
    params.sortOrder = "desc";
    params.settleTypeId = "020502";
    params.enterTypeIdList="'050101','050102','050201','050202'";
    params.accountSign = 0;
//    params.isState=0;
    params.stateSign=0;
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
    var enterTypeId = row.enterTypeId;    

    switch (enterTypeId)
    {
        case "050101":
            td.appendChild(editFormPchsEnterDetail);
            editFormPchsEnterDetail.style.display = "";

            var params = {};
            params.mainId = mainId;
            innerPchsEnterGrid.load({
                params:params,
                token: token
            });
            break;
        case "050102":
            td.appendChild(editFormSellRtnDetail);
            editFormSellRtnDetail.style.display = "";

            var params = {};
            params.mainId = mainId;
            innerSellRtnGrid.load({
                params:params,
                token: token
            });

            break;
        case "050201":
            td.appendChild(editFormPchsRtnDetail);
            editFormPchsRtnDetail.style.display = "";

            var params = {};
            params.mainId = mainId;
            innerPchsRtnGrid.load({
                params:params,
                token: token
            });
            break;
        case "050202":
            td.appendChild(editFormSellOutDetail);
            editFormSellOutDetail.style.display = "";

            var params = {};
            params.mainId = mainId;
            innerSellOutGrid.load({
                params:params,
                token: token
            });
            break;
        default:
            break;
    }
}
/*function addStatement(){

    var msg = checkAccountRow(1);
    if(msg){
        nui.alert(msg);
        return;
    }
        
    var rows = notStatementGrid.getSelecteds();
    var s = rows.length;
    if(s > 0){
        //生成新的对账单

    }else{
        nui.alert("请选择单据！");
        return;
    }
}*/
function checkAccountRow(flag){
    var firstRow = {};
    var guestId = null;

    var rows = notStatementGrid.getSelecteds();
    var msg = "";
    var s = rows.length;
    if(s > 0){
        for(var i=0; i<s; i++){
            var row = rows[i];
            if(i == 0){
                firstRow = row;
                guestId = firstRow.guestId;
            }else{
                var rowGuestId = row.guestId;
                if(guestId != rowGuestId){
                    return "请选择相同往来单位的单据!";
                }
            }
        }

        for(var i=0; i<s; i++){
            var row = rows[i];
            var accountSign = row.accountSign;
            var serviceId = row.serviceId;
            if(accountSign == 1) {
                msg += "业务单据："+serviceId+ "已对账；</br>";
            }else if(accountSign  == 0) {
                msg += "业务单据："+serviceId+ "未对账；</br>";
            }
        }
    }else{
        msg = "请选择单据!";
    }

    return msg;
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
                nui.alert(checkMsg);
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

var guestConUrl = baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.queryGuestCon.biz.ext";
function getConnncetGuest(guestId){
	var guestIdList ="";
	$.ajaxSettings.async = false;
	$.post(guestConUrl+"?guestId="+guestId+"&token="+token,{},function(text){
		var data =text.data;
		for(var i=0;i<data.length;i++){
			guestIdList+=data[i].guestConnectId+","+data[i].guestId;
		}
		guestIdList=guestIdList+guestId;
	});
	return guestIdList;
}