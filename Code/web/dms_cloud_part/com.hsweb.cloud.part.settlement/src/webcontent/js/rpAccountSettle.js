/**
 * Created by Administrator on 2018/2/1.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.settle.svr.queryRPAccountList.biz.ext";
/*var innerPchsGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjEnterDetailList.biz.ext";
var innerSellGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjSellOutDetailList.biz.ext";
*/
var innerPchsGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjPchsOrderDetailList.biz.ext";
var innerSellGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjSellOrderDetailList.biz.ext";
var innerStateGridUrl = baseUrl+"com.hsapi.cloud.part.settle.svr.getPJStatementDetailById.biz.ext";

var innerAllotAcceptGridUrl= baseUrl+"com.hsapi.cloud.part.invoicing.allotsettle.queryAllotAcceptDetails.biz.ext";
var innerAllotApplyGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.allotsettle.queryAllotApplyDetails.biz.ext";

var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var basicInfoForm = null;
var rpRightGrid = null;
var rRightGrid = null;
var pRightGrid = null;
var qRightGrid = null;
var searchBeginDate = null;
var searchEndDate = null;
var comPartNameAndPY = null;
var comPartCode = null;
var comServiceId = null;
var comSearchGuestId = null;
//var editFormPchsEnterDetail = null;
var innerPchsEnterGrid = null;
//var editFormPchsRtnDetail = null;
var innerPchsRtnGrid = null;
//var editFormSellOutDetail = null;
var innerSellOutGrid = null;
//var editFormSellRtnDetail = null;
var innerSellRtnGrid = null;
var innerStatementGrid = null;
var innerExpenseGrid = null;
var editFormExpenseDetail = null;

var innerAllotAcceptGrid = null;
var innerAllotAcceptRtnGrid = null;
var innerAllotApplyGrid = null;
var innerAllotApplyRtnGrid = null;

var auditWin = null;
var settleWin = null;
var gprows = null;
var mainTabs = null;
var settleAccountGrid = null;

var pchsEnterWin = null;
var pchsRtnWin = null;
var sellOutWin = null;
var sellRtnWin = null;

var allotInWin =null;
var allotOutRtnWin =null;
var allotOutWin =null;
var allotInRtnWin =null;

var storehouseHash = {};
var billTypeIdHash = {};
var settTypeIdHash = {};
var enterTypeIdList = [];
var enterTypeIdHash = {};
var partBrandIdHash = {};
var compBrandList = [];
var compBrandHash = {};
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
    {id:0,text:"未对"},
    {id:1,text:"已对"},
    {id:2,text:"全部"}
];
var settleStatusList = [
    {id:4,text:"全部"},
    {id:0,text:"未结算"},
    {id:1,text:"部分结算"},
    {id:2,text:"已结算"},
    {id:3,text:"未结算&部分结算"}
];
var typeIdHash = {1:"采购订单",2:"销售订单",3:"采购退货",4:"销售退货",5:"调拨申请",6:"调拨受理",7:"调出退回",8:"调入退回"};

$(document).ready(function(v)
{
    rpRightGrid = nui.get("rpRightGrid");
    rRightGrid = nui.get("rRightGrid");
    pRightGrid = nui.get("pRightGrid");
    qRightGrid = nui.get("qRightGrid");
    rpRightGrid.setUrl(rightGridUrl);
    rRightGrid.setUrl(rightGridUrl);
    pRightGrid.setUrl(rightGridUrl);
    qRightGrid.setUrl(rightGridUrl);
    searchBeginDate = nui.get("beginDate");
    searchEndDate = nui.get("endDate");
    searchServiceId = nui.get("serviceId");
    comSearchGuestId = nui.get("searchGuestId");
    mainTabs = nui.get("mainTabs");
    settleAccountGrid = nui.get("settleAccountGrid");

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

    innerStatementGrid = nui.get("innerStatementGrid");
    editFormStatementDetail = document.getElementById("editFormStatementDetail");
    innerStatementGrid.setUrl(innerStateGridUrl);
    
    innerExpenseGrid = nui.get("innerExpenseGrid");
    editFormExpenseDetail = document.getElementById("editFormExpenseDetail");
    innerExpenseGrid.setUrl(innerStateGridUrl);
    
    innerAllotAcceptGrid = nui.get("innerAllotAcceptGrid");
    innerAllotAcceptGrid.setUrl(innerAllotAcceptGridUrl);
    
    innerAllotAcceptRtnGrid = nui.get("innerAllotAcceptRtnGrid");
    innerAllotAcceptRtnGrid.setUrl(innerAllotAcceptGridUrl);
        
    innerAllotApplyGrid = nui.get("innerAllotApplyGrid");
    innerAllotApplyGrid.setUrl(innerAllotApplyGridUrl);
    
    innerAllotApplyRtnGrid = nui.get("innerAllotApplyRtnGrid");
    innerAllotApplyRtnGrid.setUrl(innerAllotApplyGridUrl);
    
    

    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    auditWin = nui.get("auditWin");
    settleWin = nui.get("settleWin");

    pchsEnterWin = nui.get("pchsEnterWin");
    pchsRtnWin = nui.get("pchsRtnWin");
    sellOutWin = nui.get("sellOutWin");
    sellRtnWin = nui.get("sellRtnWin");
    
    allotInWin = nui.get("allotInWin");
    allotOutRtnWin = nui.get("allotOutRtnWin");
    allotOutWin = nui.get("allotOutWin");
    allotInRtnWin = nui.get("allotInRtnWin");

    searchBeginDate.setValue(getNowStartDate());
    searchEndDate.setValue(addDate(getNowEndDate(), 1));

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
        dictIdList.push('10444');//入库类型
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
                compBrandList = dataItems.filter(function(v)
                {
                    if(v.dictid == "10444")
                    {
                    	compBrandHash[v.customid] = v;
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
            
            getAllPartBrand(function(data)
    	    {
    	        var partBrandList = data.brand;
    	        partBrandList.forEach(function(v)
    	        {
    	            partBrandIdHash[v.id] = v;
    	        });
    	        
    	        getItemType(function(data) {
    	            enterTypeIdList = data.list || [];
    	            enterTypeIdList.filter(function(v){
    	                enterTypeIdHash[v.id] = v;
    	            });


        	        quickSearch(currType);
        	        
    	        });
    	        
    	        
    	    });
            
        });
    });
    

    mainTabs.on("activechanged",function(e){
    	onSearch();
    });
    
});
var queryUrl = baseUrl
        + "com.hsapi.cloud.part.settle.svr.queryFibInComeExpenses.biz.ext";
function getItemType(callback) {
    nui.ajax({
        url : queryUrl,
        data : {
            token: token
        },
        type : "post",
        success : function(data) {
            if (data && data.list) {
            	nui.get("elBillTypeId").setData(data.list);
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

    params.billServiceId = searchServiceId.getValue().replace(/\s+/g, "");
    params.guestId = comSearchGuestId.getValue();
    params.guestName =nui.get('guestName').getValue().replace(/\s+/g, "");
    params.sCreateDate = searchBeginDate.getFormValue();
    params.eCreateDate = searchEndDate.getFormValue();
    //params.settleStatus = nui.get("settleStatus").getValue();
    params.auditSign=1;
    
    params.settleStatus = nui.get("settleStatus").getValue();
    if(params.settleStatus == 4){
    	params.settleStatus =null;
    }
    if(params.settleStatus == 3) {
    	params.settleStatus =null;
    	params.settleSign = 0;
    }
    
    /*if(params.settleStatus ==4){
    	params.settleStatus =null;
    }*/

    return params;
}
var currType = 2;
function quickSearch(type){
    var params = getSearchParam();
    var queryname = "本日";
    switch (type)
    {
        case 0:
            params.today = 1;
            params.sCreateDate = getNowStartDate();
            params.eCreateDate = addDate(getNowEndDate(), 1);
            var queryname = "本日";
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
	
    
    var tab = mainTabs.getActiveTab();
    var name = tab.name;
    switch (name)
    {
        case "rpRightTab":
            rpRightGrid.load({
                params:params,
                token: token
            });
            break;
        case "pRightTab":
            params.billDc = -1;
            pRightGrid.load({
                params:params,
                token: token
            });
            break;
        case "rRightTab":
            params.billDc = 1;
            rRightGrid.load({
                params:params,
                token: token
            });
            break;
        case "qRightTab":
            qRightGrid.load({
                params:params,
                token: token
            });
            break;
        default:
            break;
    }

}
function advancedSearch()
{
    advancedSearchWin.show();
    advancedSearchForm.clear();
    if(advancedSearchFormData)
    {
        advancedSearchForm.setData(advancedSearchFormData);
    }else{
		nui.get("sCreateDate").setValue(getWeekStartDate());
		nui.get("eCreateDate").setValue(addDate(getWeekEndDate(), 1));
	}
}
function onAdvancedSearchOk()
{
    var searchData = advancedSearchForm.getData();
    advancedSearchFormData = {};
    for(var key in searchData)
    {
        advancedSearchFormData[key] = searchData[key];
    }
    var i;
    if(searchData.sCreateDate)
    {
        searchData.sCreateDate = formatDate(searchData.sCreateDate);
    }
    if(searchData.eCreateDate)
    {
        var date = searchData.eCreateDate;
        searchData.eCreateDate = addDate(date, 1);
        
    }
    //审核日期
    if(searchData.sBalanceDate)
    {
        searchData.sBalanceDate = searchData.sBalanceDate.substr(0,10);
    }
    if(searchData.eBalanceDate)
    {
        var date = searchData.eBalanceDate;
        searchData.eBalanceDate = addDate(date, 1);
        searchData.eBalanceDate = searchData.eBalanceDate.substr(0,10);
    }
    //供应商
    if(searchData.guestId)
    {
    	searchData.guestId = nui.get("btnEdit2").getValue();
    }
    if(searchData.elBillTypeId)
    {
    	searchData.billTypeId = searchData.elBillTypeId;
    }
    if(searchData.elRemark)
    {
    	searchData.remark = searchData.elRemark;
    }
    //订单单号
    if(searchData.billServiceIdList)
    {
        var tmpList = searchData.billServiceIdList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i].replace(/\s+/g, "")+"'";
        }
        searchData.billServiceIdList = tmpList.join(",");
    }
    if(searchData.balanceSign){
        if(searchData.balanceSign == 2){
            searchData.balanceSign = null;
        }
    }
    /*for(var key in searchData){
    	if(searchData[key]!=null && searchData[key]!="" && typeof(searchData[key])=='string'){    		
    		searchData[key]=searchData[key].replace(/\s+/g, "");
    	}
    }*/
    
    //searchData.settleStatus = nui.get("settleStatus").getValue();
    if(searchData.settleStatus == 4){
    	searchData.settleStatus =null;
    }
    if(searchData.settleStatus == 3) {
    	searchData.settleStatus =null;
    	searchData.settleSign = 0;
    }
    
    advancedSearchWin.hide();
    doSearch(searchData);
}
function onAdvancedSearchCancel(){
    advancedSearchForm.clear();
    advancedSearchWin.hide();
}
var supplier = null;
function selectSupplier(elId)
{
    supplier = null;
    nui.open({
        // targetWindow: window,
        url: "com.hsweb.cloud.part.common.supplierSelect.flow",
        title: "结算单位资料", width: 980, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {

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
function onStateDrawCell(e)
{
    switch (e.field){
        case "typeCode":
            if(typeIdHash && typeIdHash[e.value])
            {
                e.cellHtml = typeIdHash[e.value];
            }
            break;
        case "expenseTypeCode":
            if(enterTypeIdHash && enterTypeIdHash[e.value])
            {
                e.cellHtml = enterTypeIdHash[e.value].name;
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
        case "orgCarBrandId":
        	if(compBrandHash[e.value]) {
    			e.cellHtml = compBrandHash[e.value].name;
    		}else {
    			e.cellHtml = "";
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
        case "amt5":
            var row = e.row;
            if(row.billDc == 1) {
                e.cellHtml = row.noCharOffAmt;
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
        case "amt15":
            var row = e.row;
            if(row.billDc == -1) {
                e.cellHtml = row.noCharOffAmt;
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
    var rightGrid = null;
    var tab = mainTabs.getActiveTab();
    var name = tab.name;
    switch (name)
    {
        case "rpRightTab":
            rightGrid = rpRightGrid;
            break;
        case "pRightTab":
            rightGrid = pRightGrid;
            break;
        case "rRightTab":
            rightGrid = rRightGrid;
            break;
        case "qRightTab":
            rightGrid = qRightGrid;
            break;
        default:
            break;
    }

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
        case 205:
        	td.appendChild(editFormExpenseDetail);
        	editFormExpenseDetail.style.display = "";
            
            var params = {};
            params.mainId = mainId;
            innerExpenseGrid.load({
                params:params,
                token: token
            });
            break;
        default:
            break;
    }
}
function onStatementDbClick(e){
    var row = e.record;
    var mainId = row.billMainId;
    var rpDc = row.rpDc;
    /*switch (rpDc)
  	{
        case -1:
            pchsEnterWin.show();

            var params = {};
            params.mainId = mainId;
            innerPchsEnterGrid.load({
                params:params,
                token: token
            });
            break;
        case 1://"050201"
            pchsRtnWin.show();
            
            var params = {};
            params.mainId = mainId;
            innerPchsRtnGrid.load({
                params:params,
                token: token
            });
            break;
        default:
            break;
    }**/
    var typeCode = row.typeCode;
   
    switch (typeCode)
    {
        case "1":
            pchsEnterWin.show();

            var params = {};
            params.mainId = mainId;
            innerPchsEnterGrid.load({
                params:params,
                token: token
            });
            break;
        case "4"://"050102"
            sellRtnWin.show();
            
            var params = {};
            params.mainId = mainId;
            innerSellRtnGrid.load({
                params:params,
                token: token
            });

            break;
        case "3"://"050201"
            pchsRtnWin.show();
            
            var params = {};
            params.mainId = mainId;
            innerPchsRtnGrid.load({
                params:params,
                token: token
            });
            break;
        case "2"://"050202"
            sellOutWin.show();
            
            var params = {};
            params.mainId = mainId;
            innerSellOutGrid.load({
                params:params,
                token: token
            });
            
            break;
        case "5":
        	allotInWin.show();
            
            var params = {};
            params.mainId = mainId;
            innerAllotApplyGrid.load({
                params:params,
                token: token
            });      
            
            break;
        case "6":
        	
        	allotOutWin.show();
            var params = {};
            params.mainId = mainId;
            innerAllotAcceptGrid.load({
                params:params,
                token: token
            });     
            
            break;
        case "7":        	
        	allotOutRtnWin.show();
        	
            var params = {};
            params.mainId = mainId;
            innerAllotApplyRtnGrid.load({
                params:params,
                token: token
            });      
            
            break;
        case "8":
        	allotInRtnWin.show();
            
            var params = {};
            params.mainId = mainId;
            innerAllotAcceptRtnGrid.load({
                params:params,
                token: token
            });     
            
            break;
       
        default:
            break;
    }
}
function doBalance(){
    var rightGrid = null;
    var firstRow = {};
    var guestId = null;
    var tab = mainTabs.getActiveTab();
    var name = tab.name;
    switch (name)
    {
        case "rpRightTab":
            rightGrid = rpRightGrid;
            break;
        case "pRightTab":
            rightGrid = pRightGrid;
            break;
        case "rRightTab":
            rightGrid = rRightGrid;
            break;
        case "qRightTab":
            rightGrid = qRightGrid;
            break;
        default:
            break;
    }
    var msg = checkAuditRow(1);
    if(msg){
        showMsg(msg,"W");
        return;
    }
        
    var rows = rightGrid.getSelecteds();
    var s = rows.length;
    if(s > 0){
        auditWin.show();

        var rtn = getRPAmount(rows);
        var guestName = rows[0].guestName;
        document.getElementById('balanceGuestName').innerHTML="对账单位："+guestName;
        document.getElementById('balanceBillCount').innerHTML="对账单据数："+s;
        document.getElementById('pAmt').innerHTML=rtn.pAmount;
        document.getElementById('rAmt').innerHTML=rtn.rAmount;

    }else{
        showMsg("请选择单据!","W");
        return;
    }
}
function getRPAmount(rows){
    var s = rows.length;
    var pAmount = 0;
    var rAmount = 0;
    if(s>0){

        for(var i=0; i<s; i++){
            var row = rows[i];
            var dc = row.billDc;
            if(dc == -1) {
                pAmount += row.rpAmt;
            }else{
                rAmount += row.rpAmt;
            }
        }
    }
    var rtnMsg = {};
    rtnMsg.pAmount = pAmount;
    rtnMsg.rAmount = rAmount;
    return rtnMsg;
}
function balanceCancel(){
    document.getElementById('balanceGuestName').innerHTML="对账单位：";
    document.getElementById('balanceBillCount').innerHTML="对账单据数：";
    document.getElementById('pAmt').innerHTML=0;
    document.getElementById('rAmt').innerHTML=0;
    auditWin.hide();
}
function checkAuditRow(flag){
    var rightGrid = null;
    var firstRow = {};
    var guestId = null;
    var tab = mainTabs.getActiveTab();
    var name = tab.name;
    switch (name)
    {
        case "rpRightTab":
            rightGrid = rpRightGrid;
            break;
        case "pRightTab":
            rightGrid = pRightGrid;
            break;
        case "rRightTab":
            rightGrid = rRightGrid;
            break;
        case "qRightTab":
            rightGrid = qRightGrid;
            break;
        default:
            break;
    }
    var rows = rightGrid.getSelecteds();
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
                    return "请选择相同结算单位的单据!";
                }
            }
        }

        for(var i=0; i<s; i++){
            var row = rows[i];
            var balanceSign = row.balanceSign;
            var billServiceId = row.billServiceId;
            if(balanceSign == flag && balanceSign == 1) {
                msg += "业务单据："+billServiceId+ "已对账；</br>";
            }else if(balanceSign == flag && balanceSign == 0) {
                msg += "业务单据："+billServiceId+ "未对账；</br>";
            }
        }
    }else{
        msg = "请选择单据!";
    }

    return msg;
}
var balanceAuditUrl = baseUrl+"com.hsapi.cloud.part.settle.rpsettle.balanceRPAccount.biz.ext";
function balanceOK(){
    var rightGrid = null;
    var tab = mainTabs.getActiveTab();
    var name = tab.name;
    switch (name)
    {
        case "rpRightTab":
            rightGrid = rpRightGrid;
            break;
        case "pRightTab":
            rightGrid = pRightGrid;
            break;
        case "rRightTab":
            rightGrid = rRightGrid;
            break;
        case "qRightTab":
            rightGrid = qRightGrid;
            break;
        default:
            break;
    }
    var rows = rightGrid.getSelecteds();
    var remark = null;
    var s = rows.length;
    if(s > 0){

        nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '数据处理中...'
        });

       nui.ajax({
            url : balanceAuditUrl,
            type : "post",
            data : JSON.stringify({
                billList : rows,
                token : token
            }),
            success : function(data) {
                nui.unmask(document.body);
                data = data || {};
                if (data.errCode == "S") {
                    showMsg("对账成功!","S");

                    balanceCancel();
                    rightGrid.reload();
                    
                } else {
                    showMsg(data.errMsg || "对账失败!","W");
                }
            },
            error : function(jqXHR, textStatus, errorThrown) {
                // nui.alert(jqXHR.responseText);
                console.log(jqXHR.responseText);
            }
        }); 

    }else{
        showMsg("请选择单据!","W");
        return;
    }
}
var billUnAuditUrl = baseUrl+"com.hsapi.cloud.part.settle.rpsettle.unBalanceRPAccount.biz.ext";
function doUnBalance(){

    var msg = checkAuditRow(0);
    if(msg){
        showMsg(msg,"W");
        return;
    }

    var rightGrid = null;
    var tab = mainTabs.getActiveTab();
    var name = tab.name;
    switch (name)
    {
        case "rpRightTab":
            rightGrid = rpRightGrid;
            break;
        case "pRightTab":
            rightGrid = pRightGrid;
            break;
        case "rRightTab":
            rightGrid = rRightGrid;
            break;
        case "qRightTab":
            rightGrid = qRightGrid;
            break;
        default:
            break;
    }
        
    var rows = rightGrid.getSelecteds();
    var remark = null;
    var s = rows.length;
    if(s > 0){

        nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '数据处理中...'
        });

       nui.ajax({
            url : billUnAuditUrl,
            type : "post",
            data : JSON.stringify({
                billList : rows,
                token : token
            }),
            success : function(data) {
                nui.unmask(document.body);
                data = data || {};
                if (data.errCode == "S") {
                    showMsg("取消对账成功!","S");

                    rightGrid.reload();
                    
                } else {
                    showMsg(data.errMsg || "取消对账失败!","E");
                }
            },
            error : function(jqXHR, textStatus, errorThrown) {
                // nui.alert(jqXHR.responseText);
                console.log(jqXHR.responseText);
            }
        }); 

    }else{
        showMsg("请选择单据!","W");
        return;
    }
}
function OnrpRightGridCellBeginEdit(e){
    var column = e.column;
    var editor = e.editor;
    var row = e.row;
    if(row.billDc == 1){
        if (column.field == "amt12" || column.field == "amt13") {
            e.cancel = true;
        }
    }else{
        if (column.field == "amt2" || column.field == "amt3") {
            e.cancel = true;
        }
    }


}
function checkSettleRow(){
    var rightGrid = null;
    var firstRow = {};
    var guestId = null;
    var billTypeId = null;
    var rpTypeId = 1;
    var rtnBillSign = 0;
    /*
     * rpTypeId = 1 只能同时为  A应收现结101，应收月结102   B应付现结201，应付月结202  C费用月结205，运费206
     * A B 是正常收付款凭证 C是费用月结或费用现结凭证
     * rpTypeId = 2 是其他应收，其他应付的收付款凭证 
     * */
    var tab = mainTabs.getActiveTab();
    var name = tab.name;
    switch (name)
    {
        case "rpRightTab":
            rightGrid = rpRightGrid;
            break;
        case "pRightTab":
            rightGrid = pRightGrid;
            break;
        case "rRightTab":
            rightGrid = rRightGrid;
            break;
        case "qRightTab":
            rightGrid = qRightGrid;
            break;
        default:
            break;
    }
    var rows = rightGrid.getSelecteds();
    var msg = "";
    var s = rows.length;
    if(s > 0){
        for(var i=0; i<s; i++){
            var row = rows[i];
            if(i == 0){
                firstRow = row;
                guestId = firstRow.guestId;
                billTypeId = firstRow.billTypeId;
                rpTypeId = firstRow.rpTypeId;
                rtnBillSign = firstRow.rtnBillSign;
            }else{
            	var rc = i + 1;
                var rowGuestId = row.guestId;
                var rowBillTypeId = row.billTypeId;
                var rowRpTypeId = row.rpTypeId;
                var rowRtnBillSign = row.rtnBillSign;
                if(guestId != rowGuestId){
                    return "请选择相同结算单位的单据!";
                }
                
                if(rpTypeId != rowRpTypeId){
                	
                    return "第" + rc + "行与第一行不能同时结算，单据来源不同";
                }
                
                if(rtnBillSign != rowRtnBillSign) {
                	return "第" + rc + "行与第一行不能同时结算，单据类型不同";
                }
                
                if((billTypeId == 101 || billTypeId == 102) && rowBillTypeId != 101 && rowBillTypeId != 102 ) {
                	return "第" + rc + "行与第一行不能同时结算，收支项目不匹配";
                }
                
                if((billTypeId == 201 || billTypeId == 202) && rowBillTypeId != 201 && rowBillTypeId != 202 ) {
                	return "第" + rc + "行与第一行不能同时结算，收支项目不匹配";
                }
                
                if((billTypeId == 205 || billTypeId == 206  || billTypeId == 213 || billTypeId == 245
                		 || billTypeId == 246 || billTypeId == 340 || billTypeId == 341 || billTypeId == 342
                		 || billTypeId == 343 || billTypeId == 344 || billTypeId == 345 || billTypeId == 346
                		 || billTypeId == 347) && rowBillTypeId != 205 && rowBillTypeId != 206 
                		 && rowBillTypeId != 213 && rowBillTypeId != 245 && rowBillTypeId != 246
                		 && rowBillTypeId != 340 && rowBillTypeId != 341 && rowBillTypeId != 342
                		 && rowBillTypeId != 343 && rowBillTypeId != 344 && rowBillTypeId != 345
                		 && rowBillTypeId != 346 && rowBillTypeId != 347) {
                	return "第" + rc + "行与第一行不能同时结算，收支项目不匹配";
                }
                /*  结算时按 费用月结/费用现结 凭证模板生成
                 *  205	0	205	费用月结
                 *  206	0	206	运费
					213	0	204	采购木箱费
					245	0	6601.05.01	采购运费
					246	0	6601.05.02	销售运费
					340	0	208	代理报关费
					341	0	209	采购费
					342	0	6601.05.02	销售木箱费
					343	0	6601.05.01	采购退货木箱费
					344	0	6601.05.01	采购退货运费
					345	0	6601.05.01	盘亏采购运费
					346	0	6601.05.01	盘亏采购木箱费
					347	0	6601.05.02	预销售运费
                 */
                
            }
        }

        /*for(var i=0; i<s; i++){
            var row = rows[i];
            var balanceSign = row.balanceSign;
            var billServiceId = row.billServiceId;
            if(name == "rpRightTab"){
                var amt1 = row.amt1||0;
                var amt2 = row.amt2||0;
                var amt3 = row.amt3||0;
                var amt4 = row.amt4||0;
                var amt11 = row.amt11||0;
                var amt12 = row.amt12||0;
                var amt13 = row.amt13||0;
                var amt14 = row.amt14||0;
                if(amt1+amt2+amt3+amt4+amt11+amt12+amt13+amt14<=0){
                    msg += "请填写业务单据："+billServiceId+ "的结算金额；</br>";
                }
            }else{
                var nowAmt = row.nowAmt || 0;
                var nowVoidAmt = row.nowVoidAmt || 0;
                if(nowAmt+nowVoidAmt<=0){
                    msg += "请填写业务单据："+billServiceId+ "的结算金额；</br>";
                }
            }
        }*/
    }else{
        msg = "请选择单据!";
    }

    return msg;
}
function doSettle(){
    var msg = checkSettleRow();
    if(msg){
        showMsg(msg,"W");
        return;
    }
    
    var rightGrid = null;
    var firstRow = {};
    var guestId = null;
    var tab = mainTabs.getActiveTab();
    var name = tab.name;
    switch (name)
    {
        case "rpRightTab":
            rightGrid = rpRightGrid;
            break;
        case "pRightTab":
            rightGrid = pRightGrid;
            break;
        case "rRightTab":
            rightGrid = rRightGrid;
            break;
        case "qRightTab":
            rightGrid = qRightGrid;
            break;
        default:
            break;
    }
        
    var rows = rightGrid.getSelecteds();
    var s = rows.length;
    if(s > 0){
        if(name == "pRightTab"){
            document.getElementById('rtTr').style.display = "none";
            document.getElementById('rcTr').style.display = "none";
            document.getElementById('ptTr').style.display = "";
            document.getElementById('pcTr').style.display = "";
        }else if(name == "rRightTab"){
            document.getElementById('rtTr').style.display = "";
            document.getElementById('rcTr').style.display = "";
            document.getElementById('ptTr').style.display = "none";
            document.getElementById('pcTr').style.display = "none";
        }else{
            document.getElementById('rtTr').style.display = "";
            document.getElementById('rcTr').style.display = "";
            document.getElementById('ptTr').style.display = "";
            document.getElementById('pcTr').style.display = "";
        }
        var rtn = getSettleAmount(rows);
        var errCode = rtn.errCode;
        if(errCode != 'S') {
            showMsg(rtn.errMsg || "结算数据填写有问题!","W");
            return;
        }

        settleWin.show();
        
        var guestName = rows[0].guestName;
        document.getElementById('settleGuestName').innerHTML="结算单位："+guestName;
        document.getElementById('settleBillCount').innerHTML="结算单据数："+s;
        document.getElementById('rRPAmt').innerHTML=rtn.rRPAmt;
        document.getElementById('rTrueAmt').innerHTML=rtn.rTrueAmt;
        document.getElementById('rVoidAmt').innerHTML=rtn.rVoidAmt;
        document.getElementById('rNoCharOffAmt').innerHTML=rtn.rNoCharOffAmt;
        document.getElementById('rCharOffAmt').innerHTML=rtn.rCharOffAmt;
        document.getElementById('pRPAmt').innerHTML=rtn.pRPAmt;
        document.getElementById('pTrueAmt').innerHTML=rtn.pTrueAmt;
        document.getElementById('pVoidAmt').innerHTML=rtn.pVoidAmt;
        document.getElementById('pNoCharOffAmt').innerHTML=rtn.pNoCharOffAmt;
        document.getElementById('pCharOffAmt').innerHTML=rtn.pCharOffAmt;
        document.getElementById('rpAmt').innerHTML=rtn.rpAmt;
        nui.get("rpSettleDate").setValue(now);

        settleAccountGrid.setData([]);
        addSettleAccountRow();
    }else{
        showMsg("请选择单据!","W");
        return;
    }
}
function getSettleAmount(rows){
    var tab = mainTabs.getActiveTab();
    var name = tab.name;

    var rRPAmt=0;    //应收金额
    var rTrueAmt=0;  //实收应收
    var rVoidAmt=0;  //优惠金额
    var rNoCharOffAmt =0;  //未结金额
    var rCharOffAmt =0;   //应收已结金额
    
    var pRPAmt=0;       //应付金额
    var pTrueAmt=0;     //实付金额
    var pVoidAmt=0;     //免付金额
    var pNoCharOffAmt=0; //未结金额
    var pCharOffAmt =0; //应付已结金额 
    
    var rpAmt=0;          //合计金额

    var s = rows.length;
    var pAmount = 0;
    var rAmount = 0;
    var s1 = 0;  //合计收
    var s2 = 0;  //合计付
    var billServiceId = null;
    var errCode = 'S';
    var errMsg = null;
    if(s>0){

        for(var i=0; i<s; i++){
            var row = rows[i];
            billServiceId = row.billServiceId;
            if(name=="rpRightTab"){
                var billDc = row.billDc;
                var charOffAmt = row.charOffAmt||0; //已结金额
                var rpAmt = row.rpAmt||0;   //应结金额
                var amt2 = row.amt2||0;
                var amt3 = row.amt3||0;
                var amt12 = row.amt12||0;
                var amt13 = row.amt13||0;
                var noCharOffAmt = rpAmt - charOffAmt;
                amt2 = parseFloat(amt2);
                amt3 = parseFloat(amt3);
                amt12 = parseFloat(amt12);
                amt13 = parseFloat(amt13);

                if(billDc == 1){
                    if((amt2 + amt3)>noCharOffAmt) {
                        errCode = 'E';
                        errMsg = "业务单：" + billServiceId +"的结算金额超出未结金额";
                        break;
                    }

                    rRPAmt += rpAmt;
                    rTrueAmt += amt2;
                    rVoidAmt += amt3;
                    rNoCharOffAmt += noCharOffAmt;
                    rCharOffAmt +=charOffAmt;
                    s1 += (amt2 + amt3);
                }else if(billDc == -1){
                    if((amt12 + amt13)>noCharOffAmt) {
                        errCode = 'E';
                        errMsg = "业务单：" + billServiceId +"的结算金额超出未结金额";
                        break;
                    }

                    pRPAmt += rpAmt;
                    pTrueAmt += amt12;
                    pVoidAmt += amt13;
                    pNoCharOffAmt += noCharOffAmt;
                    pCharOffAmt +=charOffAmt;
                    s2 += (amt12 + amt13)*-1;
                }
            }else if(name=="pRightTab"){
            	var charOffAmt = row.charOffAmt||0; //已结金额
                var noCharOffAmt = row.noCharOffAmt||0; //未结金额

                

                var rpAmt = row.rpAmt||0;   //应结金额
                var nowAmt = row.nowAmt||0;
                var nowVoidAmt = row.nowVoidAmt||0;
                nowAmt = parseFloat(nowAmt);
                nowVoidAmt = parseFloat(nowVoidAmt);
                
                if((nowAmt + nowVoidAmt)>noCharOffAmt) {
                    errCode = 'E';
                    errMsg = "业务单：" + billServiceId +"的结算金额超出未结金额";
                    break;
                }
                
                pRPAmt += rpAmt;
                pTrueAmt += nowAmt;
                pVoidAmt += nowVoidAmt;
                pNoCharOffAmt += noCharOffAmt;
                pCharOffAmt +=charOffAmt;
                s1 += (nowAmt + nowVoidAmt);
            }else if(name=="rRightTab"){
            	var charOffAmt = row.charOffAmt||0; //已结金额
                var noCharOffAmt = row.noCharOffAmt||0; //未结金额

                

                var rpAmt = row.rpAmt||0;   //应结金额
                var nowAmt = row.nowAmt||0;
                var nowVoidAmt = row.nowVoidAmt||0;
                nowAmt = parseFloat(nowAmt);
                nowVoidAmt = parseFloat(nowVoidAmt);
                
                if((nowAmt + nowVoidAmt)>noCharOffAmt) {
                    errCode = 'E';
                    errMsg = "业务单：" + billServiceId +"的结算金额超出未结金额";
                    break;
                }
                
                rRPAmt += rpAmt;
                rTrueAmt += nowAmt;
                rVoidAmt += nowVoidAmt;
                rNoCharOffAmt += noCharOffAmt;
                rCharOffAmt +=charOffAmt;
                s1 += (nowAmt + nowVoidAmt);
            }
        }

        s1 += s2;
    }
    var rtnMsg = {};
    rtnMsg.rRPAmt=rRPAmt.toFixed(4);    //应收金额
    rtnMsg.rTrueAmt=rTrueAmt.toFixed(4);  //实收应收
    rtnMsg.rVoidAmt=rVoidAmt.toFixed(4);  //优惠金额
    rtnMsg.rNoCharOffAmt =rNoCharOffAmt.toFixed(4);  //未结金额
    rtnMsg.rCharOffAmt =rCharOffAmt.toFixed(4);  //已结金额
    rtnMsg.pRPAmt=pRPAmt.toFixed(4);       //应付金额
    rtnMsg.pTrueAmt=pTrueAmt.toFixed(4);     //实付金额
    rtnMsg.pVoidAmt=pVoidAmt.toFixed(4);     //免付金额
    rtnMsg.pNoCharOffAmt=pNoCharOffAmt.toFixed(4); //未结金额
    rtnMsg.pCharOffAmt =pCharOffAmt.toFixed(4);  //已结金额
    rtnMsg.rpAmt=s1.toFixed(4);          //合计金额
    rtnMsg.errCode = errCode;
    rtnMsg.errMsg = errMsg;
    return rtnMsg;
}
function settleCancel(){
    document.getElementById('settleGuestName').innerHTML="结算单位：";
    document.getElementById('settleBillCount').innerHTML="结算单据数：";
    document.getElementById('rRPAmt').innerHTML=0;
    document.getElementById('rTrueAmt').innerHTML=0;
    document.getElementById('rVoidAmt').innerHTML=0;
    document.getElementById('rNoCharOffAmt').innerHTML=0;
    document.getElementById('rCharOffAmt').innerHTML=0;
    document.getElementById('pRPAmt').innerHTML=0;
    document.getElementById('pTrueAmt').innerHTML=0;
    document.getElementById('pVoidAmt').innerHTML=0;
    document.getElementById('pNoCharOffAmt').innerHTML=0;
    document.getElementById('pCharOffAmt').innerHTML=0;
    document.getElementById('rpAmt').innerHTML=0;
    nui.get('rpTextRemark').setValue("");
    nui.get("rpSettleDate").setValue(now);
    settleWin.hide();

    settleAccountGrid.setData([]);
}
var settleAuditUrl = baseUrl+"com.hsapi.cloud.part.settle.rpsettle.rpAccountSettle.biz.ext";
function settleOK(){
    var msg = checkSettleRow();
    if(msg){
        showMsg(msg,"W");
        return;
    }

    var rAmt = document.getElementById('rTrueAmt').innerHTML;
    var pAmt = document.getElementById('pTrueAmt').innerHTML;
    var rpAmt = document.getElementById('rpAmt').innerHTML;
    if(rAmt) {
        rAmt = parseFloat(rAmt);
    }else{
        rAmt = 0;
    }
    if(pAmt) {
        pAmt = parseFloat(pAmt);
    }else{
        pAmt = 0;
    }
    rpAmt = Math.abs(rAmt - pAmt);
    msg = checkSettleAccountAmt(rpAmt);
    if(!msg) {
        return;
    }
    
    var rightGrid = null;
    var firstRow = {};
    var guestId = null;
    var tab = mainTabs.getActiveTab();
    var name = tab.name;
    switch (name)
    {
        case "rpRightTab":
            rightGrid = rpRightGrid;
            break;
        case "pRightTab":
            rightGrid = pRightGrid;
            break;
        case "rRightTab":
            rightGrid = rRightGrid;
            break;
        case "qRightTab":
            rightGrid = qRightGrid;
            break;
        default:
            break;
    }

    //account  accountDetailList
    //guest_id, guest_name bala_type_id空 bala_account空 rp_dc  char_off_amt  void_amt  item_qty  settle_type  remark
    //bill_rp_id, bill_main_id  bill_service_id  bill_type_id  rp_dc  char_off_amt  void_amt
    var account = {};
    var accountDetailList = [];
    var stateMentList=[];
    var rows = rightGrid.getSelecteds();
    //更新对账单的回款
    for(var i=0;i<rows.length;i++){
    	
    	if(rows[i].billTypeId == '102' || rows[i].billTypeId == '202') {        	
        	var stateHash ={};
        	stateHash.id =rows[i].billMainId;
        	stateHash.amt =rows[i].nowAmt;
        	if(name =='rpRightTab'){
        		if(rows[i].amt2){
        			stateHash.amt =rows[i].amt2;
        		}else{
        			stateHash.amt =rows[i].amt12;
        		}
        		
        	}
        	stateMentList.push(stateHash);
        }
    	
    }
    var s = rows.length;
    if(s > 0){
    	
    	var accountTypeList = settleAccountGrid.getData();
        
    	var frow = rows[0];
    	if(frow.rpTypeId == 2 && accountTypeList.length > 1) {
    		showMsg("只能选择一个结算账户进行结算!","W");
            return;
    	}
    	if((frow.billTypeId == 205 || frow.billTypeId == 206) && accountTypeList.length > 1) {
    		showMsg("只能选择一个结算账户进行结算!","W");
            return;
    	}

        var rRPAmt=0;    //应收金额
        var rTrueAmt=0;  //实收应收
        var rVoidAmt=0;  //优惠金额
        var rNoCharOffAmt =0;  //未结金额
        var pRPAmt=0;       //应付金额
        var pTrueAmt=0;     //实付金额
        var pVoidAmt=0;     //免付金额
        var pNoCharOffAmt=0; //未结金额
        var rpAmt=0;          //合计金额

        var s = rows.length;
        var pAmount = 0;
        var rAmount = 0;
        var s1 = 0;  //合计收
        var s2 = 0;  //合计付
        
        firstRow = rows[0];
        account.orgid = currOrgid;
        account.guestId = firstRow.guestId;
        account.guestName = firstRow.guestName;
        account.itemQty = s;
        account.remark = nui.get('rpTextRemark').getValue().replace(/\s+/g, "");

        for(var i=0; i<s; i++){
            var row = rows[i];
            var accountDetail = {};
            accountDetail.billRpId = row.id;
            accountDetail.billMainId = row.billMainId;
            accountDetail.billServiceId = row.billServiceId;
            accountDetail.billTypeId = row.billTypeId;
            if(name=="rpRightTab"){
                var billDc = row.billDc;
                var charOffAmt = row.charOffAmt||0; //已结金额
                var rpAmt = row.rpAmt||0;   //应结金额
                var amt2 = row.amt2||0;
                var amt3 = row.amt3||0;
                var amt12 = row.amt12||0;
                var amt13 = row.amt13||0;
                var noCharOffAmt = rpAmt - charOffAmt;
                amt2 = parseFloat(amt2);
                amt3 = parseFloat(amt3);
                amt12 = parseFloat(amt12);
                amt13 = parseFloat(amt13);
                if(billDc == 1){
                    accountDetail.rpDc = 1;
                    rRPAmt += rpAmt;
                    rTrueAmt += amt2;
                    rVoidAmt += amt3;
                    rNoCharOffAmt += noCharOffAmt;
                    s1 += (amt2 + amt3);
                    accountDetail.charOffAmt = amt2;
                    accountDetail.voidAmt = amt3;
                }else if(billDc == -1){
                    accountDetail.rpDc = -1;
                    pRPAmt += rpAmt;
                    pTrueAmt += amt12;
                    pVoidAmt += amt13;
                    pNoCharOffAmt += noCharOffAmt;
                    s2 += (amt12 + amt13)*-1;
                    accountDetail.charOffAmt = amt12;
                    accountDetail.voidAmt = amt13;
                }
            }else if(name=="pRightTab"){
                var noCharOffAmt = row.noCharOffAmt||0; //已结金额
                var rpAmt = row.rpAmt||0;   //应结金额
                var nowAmt = row.nowAmt||0;
                var nowVoidAmt = row.nowVoidAmt||0;
                accountDetail.rpDc = -1;
                nowAmt = parseFloat(nowAmt);
                nowVoidAmt = parseFloat(nowVoidAmt);
                pRPAmt += rpAmt;
                pTrueAmt += nowAmt;
                pVoidAmt += nowVoidAmt;
                pNoCharOffAmt += noCharOffAmt;
                s1 += (nowAmt + nowVoidAmt);
                accountDetail.charOffAmt = nowAmt;
                accountDetail.voidAmt = nowVoidAmt;
            }else if(name=="rRightTab"){
                var noCharOffAmt = row.noCharOffAmt||0; //已结金额
                var rpAmt = row.rpAmt||0;   //应结金额
                var nowAmt = row.nowAmt||0;
                var nowVoidAmt = row.nowVoidAmt||0;
                accountDetail.rpDc = 1;
                nowAmt = parseFloat(nowAmt);
                nowVoidAmt = parseFloat(nowVoidAmt);
                rRPAmt += rpAmt;
                rTrueAmt += nowAmt;
                rVoidAmt += nowVoidAmt;
                rNoCharOffAmt += noCharOffAmt;
                s1 += (nowAmt + nowVoidAmt);
                accountDetail.charOffAmt = nowAmt;
                accountDetail.voidAmt = nowVoidAmt;
            }

            accountDetailList.push(accountDetail);
        }

        if(name=="rpRightTab"){
            s1+=s2;
            if(s1<0){
                account.rpDc = -1;
            }else{
                account.rpDc = 1;
            }
            account.settleType = "综合";
            account.voidAmt = Math.abs(rVoidAmt - pVoidAmt).toFixed(4);;
            account.trueCharOffAmt = Math.abs(rTrueAmt - pTrueAmt).toFixed(4);;
            account.charOffAmt =  (account.voidAmt + account.trueCharOffAmt).toFixed(4);;
        }else if(name=="pRightTab"){;
            account.rpDc = -1;
            account.settleType = "应付";
            account.voidAmt = pVoidAmt;
            account.trueCharOffAmt = pTrueAmt.toFixed(4);;
            account.charOffAmt =  (pVoidAmt + pTrueAmt).toFixed(4);;
        }else if(name=="rRightTab"){
            account.rpDc = 1;
            account.settleType = "应收";
            account.voidAmt = rVoidAmt;
            account.trueCharOffAmt = rTrueAmt.toFixed(4);;
            account.charOffAmt =  (rVoidAmt + rTrueAmt).toFixed(4);;
        }
        if(nui.get("rpSettleDate") == null) {
        	showMsg("请选择结算日期!","W");
        	return;
        }
        account.settleDate = nui.get("rpSettleDate").getValue();

        
        nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '数据处理中...'
        });

       nui.ajax({
            url : settleAuditUrl,
            type : "post",
            data : JSON.stringify({
                account : account,
                accountDetailList : accountDetailList,
                accountTypeList: accountTypeList,
                stateMentList  : stateMentList,
                token : token
            }),
            success : function(data) {
                nui.unmask(document.body);
                data = data || {};
                if (data.errCode == "S") {
                    showMsg("结算成功!","S");
                	
                    /*
                     * rpTypeId = 1 只能同时为  A应收现结101，应收月结102   B应付现结201，应付月结202  C费用月结205，运费206
                     * A B 是正常收付款凭证 
                     * C是费用月结或费用现结凭证
                     * rpTypeId = 2 是其他应收，其他应付的收付款凭证 
                     * */
                    if(frow.rtnBillSign == 0) {
	                    if(frow.rpTypeId == 2) {
	                    	settleOtherVoucher(data.mainId, account.rpDc);
	                	}else {
	                    	if(frow.billTypeId == 205 || frow.billTypeId == 206 || frow.billTypeId == 213
	                    			 || frow.billTypeId == 340 || frow.billTypeId == 341 || frow.billTypeId == 342
	                    			 || frow.billTypeId == 246 || frow.billTypeId == 343 || frow.billTypeId == 344
	                    			 || frow.billTypeId == 345 || frow.billTypeId == 346 || frow.billTypeId == 347) {
	                    		billExpenseVoucher(data.mainId);
	                    	}else {
	                    		settleVoucher(data.mainId, account.rpDc);
	                    	}
	                	}
                    }else {
                    	rtnVoucher(data.mainId, frow.rtnBillSign);
                    }
                    
                    settleCancel();

                    balanceCancel();
                    rightGrid.reload();

                    
                } else {
                    showMsg(data.errMsg || "结算失败!","w");
                }
            },
            error : function(jqXHR, textStatus, errorThrown) {
                // nui.alert(jqXHR.responseText);
                console.log(jqXHR.responseText);
            }
        }); 

    }else{
        showMsg("请选择单据!","W");
        return;
    }

}
function onGridbeforeselect(e){
    var field=e.field;
    var row = e.row;
    var column = e.column;
    if( column.name=="check" ){
        var row = e.row;
        var billDc = row.billDc;
        var newRow = {};
        if(billDc == 1) {
            if(row.amt2){
                newRow.amt2 = "";
            }else{
                newRow.amt2 = row.noCharOffAmt;
            }
        }else{
            if(row.amt12){
                newRow.amt12 = "";
            }else{
                newRow.amt12 = row.noCharOffAmt;
            }
        }
        rpRightGrid.updateRow(row, newRow);
    }


}
function onPGridbeforeselect(e){
    var field=e.field;
    var row = e.row;
    var column = e.column;
    if( column.name=="check" ){
        var row = e.row;
        var billDc = row.billDc;
        var newRow = {nowAmt: row.noCharOffAmt};
        if(row.nowAmt){
            newRow.nowAmt = "";
        }else{
            newRow.nowAmt = row.noCharOffAmt;
        }
        pRightGrid.updateRow(row, newRow);
    }

}
function onRGridbeforeselect(e){
    var field=e.field;
    var row = e.row;
    var column = e.column;
    if( column.name=="check" ){
        var row = e.row;
        var billDc = row.billDc;
        var newRow = {nowAmt: row.noCharOffAmt};
        if(row.nowAmt){
            newRow.nowAmt = "";
        }else{
            newRow.nowAmt = row.noCharOffAmt;
        }
        rRightGrid.updateRow(row, newRow);
    }
}
function onGridheadercellclick(e){
    rpRightGrid.findRows(function(row){
        var newRow = {};
        var billDc = row.billDc;
        var newRow = {};
        if(billDc == 1) {
            if(row.amt2){
                newRow.amt2 = "";
            }else{
                newRow.amt2 = row.noCharOffAmt;
            }
            
        }else{
            if(row.amt12){
                newRow.amt12 = "";
            }else{
                newRow.amt12 = row.noCharOffAmt;
            }
        }
        rpRightGrid.updateRow(row, newRow);  
        
    });
}
function onPGridheadercellclick(e){
    pRightGrid.findRows(function(row){
        var newRow = {};
        var billDc = row.billDc;
        var newRow = {};
        if(row.nowAmt){
            newRow.nowAmt = "";
        }else{
            newRow.nowAmt = row.noCharOffAmt;
        }
        pRightGrid.updateRow(row, newRow);  
        
    });
}
function onRGridheadercellclick(e){
    rRightGrid.findRows(function(row){
        var newRow = {};
        var billDc = row.billDc;
        var newRow = {};
        if(row.nowAmt){
            newRow.nowAmt = "";
        }else{
            newRow.nowAmt = row.noCharOffAmt;
        }
        rRightGrid.updateRow(row, newRow);  
        
    });
}
function onActionRenderer(e) {
    var grid = e.sender;
    var record = e.record;
    var uid = record._uid;
    var rowIndex = e.rowIndex;

    var s = '<a class="" href="javascript:addSettleAccountRow()">新增</a> '
            + '<a class="" href="javascript:delRow(\'' + uid + '\')">删除</a> ';
               
    return s;
}
function addSettleAccountRow() {            
    var row = {};
    settleAccountGrid.addRow(row, 0);
}
function delRow(row_uid) {
    var data = settleAccountGrid.getData();
    if(data && data.length == 1) {
        return;
    }
    var row = settleAccountGrid.getRowByUID(row_uid);
    if (row) {
        settleAccountGrid.removeRow(row);
    }
}
//提交单元格编辑数据前激发
function onCellCommitEdit(e) {
    var editor = e.editor;
    var record = e.record;
    
    editor.validate();
    if (editor.isValid() == false) {
        showMsg("请输入数字!","W");
        e.cancel = true;
    }else {
    	if(e.value==null || e.value=='') {
            e.value = 0;
        }else if(e.value < 0) {
            e.value = 0;
        }
    }
}
function checkSettleAccountAmt(charOffAmt){
    var tAmt = 0;
    var rows = settleAccountGrid.findRows(function(row){
        var settAccountId = row.settAccountId;
        var charOffAmt = row.charOffAmt;
        if(charOffAmt){
            charOffAmt = parseFloat(charOffAmt);
        }
        tAmt += charOffAmt;

        if(!row.settAccountId){
            return true;
        }
    });
    
    tAmt = tAmt.toFixed(4);

    if(rows && rows.length > 0) {
        showMsg("请选择结算账户!","W");
        return false;
    }

    if(tAmt!=charOffAmt){
        showMsg("请确定结算金额与合计金额一致!","W");
        return false;
    }

    return true;
}
function OnModelCellBeginEdit(e) {
    var row = settleAccountGrid.getSelected();

    var column = e.column;
    var editor = e.editor;
    var row = settleAccountGrid.getSelected();

    if (column.field == "settAccountId") {
        var url = baseUrl + "com.hsapi.cloud.part.settle.svr.queryFiSettleAccount.biz.ext?token="+token;
        editor.setUrl(url);
    }


    if (column.field == "balaTypeCode") {
        var str = "accountId="+row.settAccountId+"&token="+token;
        var url = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.queryAccountSettleType.biz.ext?" + str;
        editor.setUrl(url);
    }

}
function onAccountValueChanged(e){

    var r = settleAccountGrid.getSelected();
    var newRow = {balaTypeCode:null};
    settleAccountGrid.updateRow(r,newRow);

}
function onDrawSummaryCell(e){
	var rows = e.data;//rightGrid.getData();
	var rrpAmt = 0;
	var rcharOffAmt = 0;
	var rnoCharOffAmt = 0;
	var prpAmt = 0;
	var pcharOffAmt = 0;
	var pnoCharOffAmt = 0;
	for (var i = 0; i < rows.length; i++) {
		var row = rows[i];
		if(row.billDc == 1) {
			rrpAmt = rrpAmt + row.rpAmt;
			rcharOffAmt = rcharOffAmt + row.charOffAmt;
			rnoCharOffAmt = rnoCharOffAmt + row.noCharOffAmt;
		} else if(row.billDc == -1) {
			prpAmt = prpAmt + row.rpAmt;
			pcharOffAmt = pcharOffAmt + row.charOffAmt;
			pnoCharOffAmt = pnoCharOffAmt + row.noCharOffAmt;
		}
	}
	

    if (e.field == "amt1") {
    	e.cellHtml = rrpAmt;
    }
    if (e.field == "amt4") {
    	e.cellHtml = rcharOffAmt;
    }
    if (e.field == "amt5") {
    	e.cellHtml = rnoCharOffAmt;
    }
    
    if (e.field == "amt11") {
    	e.cellHtml = prpAmt;
    }
    if (e.field == "amt14") {
    	e.cellHtml = pcharOffAmt;
    }
    if (e.field == "amt15") {
    	e.cellHtml = pnoCharOffAmt;
    }
	  
    if (e.field == "rpAmt") { 
        var rpAmt = 0;
        for (var i = 0; i < rows.length; i++) {
        	rpAmt += parseFloat(rows[i].rpAmt*rows[i].rpDc);
        }
        var value =Math.abs(rpAmt)
        e.value=value;
        e.cellHtml =value;
    }
}
var settleVoucherUrl = baseUrl+"com.hsapi.cloud.part.invoicing.ordersettle.generateKingSettle.biz.ext";
function settleVoucher(mainId, dc){
	nui.ajax({
		url : settleVoucherUrl,
		type : "post",
		async:true,
		data : JSON.stringify({
			id: mainId,
			dc: dc,
			isAdvance: 0,
			settleDate: nui.get("rpSettleDate").getValue()
		}),
		success : function(data) {
			console.log(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
}
var settleOtherVoucherUrl = baseUrl+"com.hsapi.cloud.part.invoicing.ordersettle.generateKingSettleOther.biz.ext";
function settleOtherVoucher(mainId, dc){
	nui.ajax({
		url : settleOtherVoucherUrl,
		type : "post",
		async:true,
		data : JSON.stringify({
			id: mainId,
			dc: dc,
			settleDate: nui.get("rpSettleDate").getValue()
		}),
		success : function(data) {
			console.log(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
}
var billExpenseVoucherUrl = baseUrl+"com.hsapi.cloud.part.invoicing.ordersettle.generateKingBillExpense.biz.ext";
function billExpenseVoucher(mainId){
	nui.ajax({
		url : billExpenseVoucherUrl,
		type : "post",
		async:true,
		data : JSON.stringify({
			id: mainId,
			settleDate: nui.get("rpSettleDate").getValue()
		}),
		success : function(data) {
			console.log(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
}
//1采购退货 2销售退货
var rtnVoucherUrl = baseUrl+"com.hsapi.cloud.part.invoicing.ordersettle.generateKingRtn.biz.ext";
function rtnVoucher(mainId, dc){
	nui.ajax({
		url : rtnVoucherUrl,
		type : "post",
		async:true,
		data : JSON.stringify({
			id: mainId,
			dc: dc,
			settleDate: nui.get("rpSettleDate").getValue()
		}),
		success : function(data) {
			console.log(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
}


function onExport(){
	var tab = mainTabs.getActiveTab();
    var name = tab.name;
    switch (name)
    {
        case "rpRightTab":
            
            break;
        case "pRightTab":
        	var detail = nui.clone(pRightGrid.getData());
        	//多级
        	//exportMultistage(rightGrid.columns);
        	//单级
        	exportNoMultistage(pRightGrid.columns)
        	for(var i=0;i<detail.length;i++){
        		if(enterTypeIdHash[detail[i].billTypeId]){
        			detail[i].billTypeId = enterTypeIdHash[detail[i].billTypeId].name;
        		}
        		
        		if(settleStatusHash[detail[i].settleStatus]){
        			detail[i].settleStatus=settleStatusHash[detail[i].settleStatus];
        		}
        		
        	}
        	if(detail && detail.length > 0){
        		//多级表头类型
        		//setInitExportData( detail,rightGrid.columns,"采购入库明细表");
        		//单级表头类型 与上二选一
        		setInitExportDataNoMultistage( detail,pRightGrid.columns,"应付结算");
        	}
            break;
        case "rRightTab":
        	var detail = nui.clone(rRightGrid.getData());
        	//多级
        	//exportMultistage(rightGrid.columns);
        	//单级
        	exportNoMultistage(rRightGrid.columns)
        	for(var i=0;i<detail.length;i++){
        		if(enterTypeIdHash[detail[i].billTypeId]){
        			detail[i].billTypeId = enterTypeIdHash[detail[i].billTypeId].name;
        		}
        		
        		if(settleStatusHash[detail[i].settleStatus]){
        			detail[i].settleStatus=settleStatusHash[detail[i].settleStatus];
        		}
        		
        		
        	}
        	if(detail && detail.length > 0){
        		//多级表头类型
        		//setInitExportData( detail,rightGrid.columns,"采购入库明细表");
        		//单级表头类型 与上二选一
        		setInitExportDataNoMultistage( detail,rRightGrid.columns,"应收结算");
        	}
            break;
        case "qRightTab":
            
            break;
        default:
            break;
    }
    
	
}