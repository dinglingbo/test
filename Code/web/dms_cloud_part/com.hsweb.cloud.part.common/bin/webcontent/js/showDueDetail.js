/**
 * Created by Administrator on 2018/2/1.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.settle.svr.queryBillDueDetail.biz.ext";

var innerStateGridUrl = baseUrl+"com.hsapi.cloud.part.settle.svr.getPJStatementDetailById.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var basicInfoForm = null;
var rightGrid = null;
var searchBeginDate = null;
var searchEndDate = null;
var comPartNameAndPY = null;
var comPartCode = null;
var comServiceId = null;
var comSearchGuestId = null;

var editFormStatementDetail = null;
var innerStatementGrid = null;
var auditWin = null;
var settleWin = null;
var gprows = null;

var storehouseHash = {};
var billTypeIdHash = {};
var settTypeIdHash = {};
var enterTypeIdList = [];
var enterTypeIdHash = {};
var partBrandIdHash = {};
var billStatusHash = {
    "0":"未审",
    "1":"已审",
    "2":"已过账",
    "3":"已取消"
};
var settleStatusHash = {
    "0":"未结算",
    "1":"部分结算",
    "2":"已结算"
};
var balanceList = [
    {id:0,text:"未对帐 "},
    {id:1,text:"已对帐"}
];
var settleStatusList = [
    {id:0,text:"未结算"},
    {id:1,text:"部分结算"},
    {id:2,text:"已结算"}
];
var typeIdHash = {1:"采购订单",2:"销售订单",3:"采购退货",4:"销售退货"};

var guestId =null;
$(document).ready(function(v)
{
	rightGrid = nui.get("rightGrid");
	rightGrid.setUrl(rightGridUrl);

    innerStatementGrid = nui.get("innerStatementGrid");
    editFormStatementDetail = document.getElementById("editFormStatementDetail");
    innerStatementGrid.setUrl(innerStateGridUrl);

    searchBeginDate = nui.get("beginDate");
    searchEndDate = nui.get("endDate");
    
    getAllPartBrand(function(data)
    {
        var partBrandList = data.brand;
        partBrandList.forEach(function(v)
        {
            partBrandIdHash[v.id] = v;
        });
    });
    getStorehouse(function(data)
    {
        var storehouse = data.storehouse||[];
     //   nui.get("storeId").setData(storehouse);
        storehouse.forEach(function(v)
        {
            if(v && v.id)
            {
                storehouseHash[v.id] = v;
            }
        });
        var dictIdList = [];
        dictIdList.push('DDT20130703000064');//入库类型
        getDictItems(dictIdList,function(data)
        {
            if(data && data.dataItems)
            {
                var dataItems = data.dataItems||[];
                var billTypeIdList = dataItems.filter(function(v)
                {
                    if(v.dictid == "DDT20130703000008")
                    {
                        billTypeIdHash[v.customid] = v;
                        return true;
                    }
                });
          //      nui.get("billTypeId").setData(billTypeIdList);
                var settTypeIdList = dataItems.filter(function(v)
                {
                    if(v.dictid == "DDT20130703000035")
                    {
                        settTypeIdHash[v.customid] = v;
                        return true;
                    }
                });
          //      nui.get("settType").setData(settTypeIdList);
                /*var enterTypeIdList = dataItems.filter(function(v)
                {
                    if(v.dictid == "DDT20130703000064")
                    {
                        enterTypeIdHash[v.customid] = v;
                        return true;
                    }
                });*/
                //quickSearch(currType);
            }
        });
    });

    getItemType(function(data) {
        enterTypeIdList = data.list || [];
        enterTypeIdList.filter(function(v){
            enterTypeIdHash[v.id] = v;
        });

    });
    
    quickSearch(4);
});
var queryUrl = baseUrl
        + "com.hsapi.cloud.part.settle.svr.queryFibInComeExpenses.biz.ext";
function getItemType(callback) {
    nui.ajax({
        url : queryUrl,
        data : {
            token: token
        },
        async:false,
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
function getSearchParam(){
    var params = {};

//    params.billServiceId = searchServiceId.getValue().replace(/\s+/g, "");
//    //params.guestId = comSearchGuestId.getValue();
//    
    params.sCreateDate = searchBeginDate.getFormValue();
    params.eCreateDate = searchEndDate.getFormValue();
    params.guestId =guestId;
    params.balanceSign =nui.get("balanceSign").getValue();
    params.settleStatus = nui.get("settleStatus").getValue();
    return params;
}
var currType = 2;
function quickSearch(type){
    var params = getSearchParam();
    var queryname = "本月";
    switch (type)
    {
        case 0:
//            params.today = 1;
            params.sCreateDate =  null;
            params.eCreateDate = null;
            var queryname = "全部";
            break;
        case 1:
            params.yesterday = 1;
            params.sCreateDate = getPrevStartDate();
            params.eCreateDate = addDate(getPrevEndDate(), 1);
            var queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.sCreateDate = getWeekStartDate();
            params.eCreateDate = addDate(getWeekEndDate(), 1);
            var queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.sCreateDate = getLastWeekStartDate();
            params.eCreateDate = addDate(getLastWeekEndDate(), 1);
            var queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.sCreateDate = getMonthStartDate();
            params.eCreateDate = addDate(getMonthEndDate(), 1);
            var queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.sCreateDate = getLastMonthStartDate();
            params.eCreateDate = addDate(getLastMonthEndDate(), 1);
            var queryname = "上月";
            break;
        case 10:
            params.thisYear = 1;
            params.sCreateDate = getYearStartDate();
            params.eCreateDate = getYearEndDate();
            var queryname = "本年";
            break;
        case 11:
            params.lastYear = 1;
            params.sCreateDate = getPrevYearStartDate();
            params.eCreateDate = getPrevYearEndDate();
            var queryname = "上年";
            break;
        default:
            break;
    }
    searchBeginDate.setValue(params.sCreateDate);
    searchEndDate.setValue(params.eCreateDate);
    currType = type;
    var menunamedate = nui.get("menunamedate");
    menunamedate.setText(queryname);
    doSearch(params);
}
function onSearch(){
    var params = getSearchParam();

    doSearch(params);
}
function doSearch(params)
{
	rightGrid.load({
        params:params,
        token: token
    });
}


function onStateDrawCell(e)
{
    switch (e.field){
        case "typeCode":
            if(typeIdHash && typeIdHash[e.value])
            {
                e.cellHtml = typeIdHash[e.value];
            }
            break;
       
    }
}
function onDrawCell(e)
{
    switch (e.field)
    {
        case "comPartBrandId":
        	 if(partBrandIdHash[e.value])
             {
//                 e.cellHtml = partBrandIdHash[e.value].name||"";
             	if(partBrandIdHash[e.value].imageUrl){
             		
             		e.cellHtml = "<img src='"+ partBrandIdHash[e.value].imageUrl+ "'alt='配件图片' height='25px' width=' '/><br> "+partBrandIdHash[e.value].name||"";
             	}else{
             		e.cellHtml =partBrandIdHash[e.value].name||"";
             	}
             }
             else{
                 e.cellHtml = "";
             }
             break;
        case "billTypeId":
            if(enterTypeIdHash && enterTypeIdHash[e.value])
            {
                e.cellHtml = enterTypeIdHash[e.value].name;
            }
            break;
        case "billStatus":
            if(billStatusHash && billStatusHash[e.value])
            {
                e.cellHtml = billStatusHash[e.value];
            }
            break;
        case "settleTypeId":
            if(settTypeIdHash && settTypeIdHash[e.value])
            {
                e.cellHtml = settTypeIdHash[e.value].name;
            }
            break;
        case "storeId":
            if(storehouseHash && storehouseHash[e.value])
            {
                e.cellHtml = storehouseHash[e.value].name;
            }
            break;
        case "enterDayCount":
            var row = e.record;
            var enterTime = (new Date(row.enterDate)).getTime();
            var nowTime = (new Date()).getTime();
            var dayCount = parseInt((nowTime - enterTime) / 1000 / 60 / 60 / 24);
            e.cellHtml = dayCount+1;
            break;
        case "settleStatus":
            if(settleStatusHash && settleStatusHash[e.value])
            {
                e.cellHtml = settleStatusHash[e.value];
            }
            break;
        case "nowAmt":
            e.cellStyle= 'background-color:#90EE90';
            break;
        case "nowVoidAmt":
            e.cellStyle= 'background-color:#90EE90';
            break;
//        case "rpAmt":
//        	//付
//        	if(e.record.billDc== -1){
//        		e.cellHtml = -(e.value);
//        		e.value = -(e.value);
//        	}
//        	break;
        default:
            break;
    }
}
function onrpRightGridDrawCell(e){
    switch (e.field)
    {
        case "billTypeId":
            if(enterTypeIdHash && enterTypeIdHash[e.value])
            {
                e.cellHtml = enterTypeIdHash[e.value].name;
            }
            break;
        case "amt1":
            var row = e.row;
            if(row.billDc == 1) {
                e.cellHtml = row.rpAmt;
            }else{
                e.cellHtml = 0;
            }
            break;
        case "amt2":
            var row = e.row;
            if(row.billDc == 1){
                e.cellStyle= 'background-color:#90EE90';
            }
            break;
        case "amt3":
            var row = e.row;
            if(row.billDc == 1){
                e.cellStyle= 'background-color:#90EE90';
            }
            break;
        case "amt4":
            var row = e.row;
            if(row.billDc == 1) {
                e.cellHtml = row.charOffAmt;
            }else{
                e.cellHtml = 0;
            }
            break;
        case "amt11":
            var row = e.row;
            if(row.billDc == -1) {
                e.cellHtml = row.rpAmt;
            }else{
                e.cellHtml = 0;
            }
            break;
        case "amt12":
            var row = e.row;
            if(row.billDc == -1){
                e.cellStyle= 'background-color:#90EE90';
            }
            break;
        case "amt13":
            var row = e.row;
            if(row.billDc == -1){
                e.cellStyle= 'background-color:#90EE90';
            }
            break;
        case "amt14":
            var row = e.row;
            if(row.billDc == -1) {
                e.cellHtml = row.charOffAmt;
            }else{
                e.cellHtml = 0;
            }
            break;
        case "settleStatus":
            if(settleStatusHash && settleStatusHash[e.value])
            {
                e.cellHtml = settleStatusHash[e.value];
            }
            break;
        default:
            break;
    }
}
function onShowRowDetail(e) {
    var row = e.record;
    var mainId = row.billMainId;
    
    //将editForm元素，加入行详细单元格内

    var td = rightGrid.getRowDetailCellEl(row);
    var billTypeId = row.billTypeId;
    var rpTypeId = row.rpTypeId;

    switch (billTypeId)
    {
        case 1://"050101"
            if(rpTypeId != 1) return;
            td.appendChild(editFormPchsEnterDetail);
            editFormPchsEnterDetail.style.display = "";

            var params = {};
            params.mainId = mainId;
            innerPchsEnterGrid.load({
                params:params,
                token: token
            });
            break;
        case 4://"050102"
            if(rpTypeId != 1) return;
            td.appendChild(editFormSellRtnDetail);
            editFormSellRtnDetail.style.display = "";
            
            var params = {};
            params.mainId = mainId;
            innerSellRtnGrid.load({
                params:params,
                token: token
            });

            break;
        case 3://"050201"
            if(rpTypeId != 1) return;
            td.appendChild(editFormPchsRtnDetail);
            editFormPchsRtnDetail.style.display = "";
            
            var params = {};
            params.mainId = mainId;
            innerPchsRtnGrid.load({
                params:params,
                token: token
            });
            break;
        case 2://"050202"
            if(rpTypeId != 1) return;
            td.appendChild(editFormSellOutDetail);
            editFormSellOutDetail.style.display = "";
            
            var params = {};
            params.mainId = mainId;
            innerSellOutGrid.load({
                params:params,
                token: token
            });

            break;
        case 101:
        case 102:
        case 201:
        case 202://"050202"
            td.appendChild(editFormStatementDetail);
            editFormStatementDetail.style.display = "";
            
            var params = {};
            params.mainId = mainId;
            innerStatementGrid.load({
                params:params,
                token: token
            });

            break;
        default:
            break;
    }
}

function setData(params){
	guestId =params.guestId;
	getItemType(function(data) {
        enterTypeIdList = data.list || [];
        enterTypeIdList.filter(function(v){
            enterTypeIdHash[v.id] = v;
        });

    });
	doSearch(params);
}

