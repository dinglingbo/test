/**
 * Created by Administrator on 2018/2/1.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.expense.queryNotSettleExpenseList.biz.ext";
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
var comIncomeId = null;

var storehouseHash = {};
var billTypeIdHash = {};
var settTypeIdHash = {};
var enterTypeIdHash = {};
var InComeIdList = [];
var InComeIdHash = {};
var settTypeIdHash = {};
var settTypeIdList = [];

var stateStatusHash = {
    "0":"未对账",
    "1":"已对账"
};

var stateStatusList = [{
    "id":0,
    "name":"未对账"
},{
    "id":1,
    "name":"已对账"
}];

$(document).ready(function(v)
{
	rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    rightGrid.on("load", function () {
        rightGrid.mergeColumns(["serviceId"]);
    });
    searchBeginDate = nui.get("beginDate");
    searchEndDate = nui.get("endDate");

	comServiceId = nui.get("serviceId");
	comSearchGuestId = nui.get("searchGuestId");
	comIncomeId = nui.get("comIncomeId");
	
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
   
    var dictDefs ={"settleTypeId":"DDT20130703000035"};
    initDicts(dictDefs,function()
    {
    	settTypeIdList = nui.get("settleTypeId").getData();
        settTypeIdList.filter(function(v)
        {
            settTypeIdHash[v.customid] = v;
        });
        
        nui.get("stateSign").setData(stateStatusList);
        
        getItemType(function(data) {
        	InComeIdList = data.list || [];
        	InComeIdList.filter(function(v){
            	InComeIdHash[v.id] = v;
            });
        	
        	comIncomeId.setData(InComeIdList);
        	
        	quickSearch(currType);

        });


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
    /*var outableQtyGreaterThanZero = nui.get("outableQtyGreaterThanZero").getValue();
    if(outableQtyGreaterThanZero == 1)
    {
        params.outableQtyGreaterThanZero = 1;
    }*/
    params.serviceId = comServiceId.getValue().replace(/\s+/g, "");
    params.stateSign = nui.get("stateSign").getValue();
    params.logisticsNo = nui.get("elLogisticsNo").getValue();
	
	params.guestId = comSearchGuestId.getValue();
	params.eAuditDate = searchEndDate.getFormValue();
	params.sAuditDate = searchBeginDate.getFormValue();
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
            params.sAuditDate = getNowStartDate();
            params.eAuditDate = addDate(getNowEndDate(), 1);
            queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.sAuditDate = getPrevStartDate();
            params.eAuditDate = addDate(getPrevEndDate(), 1);
            queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.sAuditDate = getWeekStartDate();
            params.eAuditDate = addDate(getWeekEndDate(), 1);
            queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.sAuditDate = getLastWeekStartDate();
            params.eAuditDate = addDate(getLastWeekEndDate(), 1);
            queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.sAuditDate = getMonthStartDate();
            params.eAuditDate = addDate(getMonthEndDate(), 1);
            queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.sAuditDate = getLastMonthStartDate();
            params.eAuditDate = addDate(getLastMonthEndDate(), 1);
            queryname = "上月";
            break;
        case 10:
            params.thisYear = 1;
            params.sAuditDate = getYearStartDate();
            params.eAuditDate = getYearEndDate();
            queryname = "本年";
            break;
        case 11:
            params.lastYear = 1;
            params.sAuditDate = getPrevYearStartDate();
            params.eAuditDate = getPrevYearEndDate();
            queryname = "上年";
            break;
        default:
            break;
    }
    searchBeginDate.setValue(params.sAuditDate);
    searchEndDate.setValue(params.eAuditDate);
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
	params.sortField = "a.audit_date";
	params.sortOrder = "desc";
	params.auditSign = 1;
    rightGrid.load({
        params:params,
        token:token
    },function(){
        rightGrid.mergeColumns(["serviceId"]);
    });
}
function advancedSearch()
{
    advancedSearchWin.show();
    advancedSearchForm.clear();
    if(advancedSearchFormData)
    {
        advancedSearchForm.setData(advancedSearchFormData);
    }else{
        nui.get("sAuditDate").setValue(getWeekStartDate());
        nui.get("eAuditDate").setValue(addDate(getWeekEndDate(), 1));
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
    if(searchData.sOrderDate)
    {
        searchData.startDate = formatDate(searchData.sOrderDate);
    }
    if(searchData.eOrderDate)
    {
        var date = searchData.eOrderDate;
        searchData.endDate = addDate(date, 1);
//        searchData.eOrderDate = searchData.eOrderDate.substr(0,10);
    }
    //审核日期
    if(searchData.sAuditDate)
    {
        searchData.sAuditDate = formatDate(searchData.sAuditDate);
    }
    if(searchData.eAuditDate)
    {
        var date = searchData.eAuditDate;
        searchData.eAuditDate = addDate(date, 1);
        
    }
    //供应商
    if(searchData.guestId)
    {
        searchData.guestId = nui.get("btnEdit2").getValue();
    }
    if(searchData.comIncomeId)
    {
        searchData.expenseTypeCode = nui.get("comIncomeId").getValue();
    }
    //订单单号
    if(searchData.serviceIdList)
    {
        var tmpList = searchData.serviceIdList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i].replace(/\s+/g, "")+"'";
        }
        searchData.serviceIdList = tmpList.join(",");
    }
    for(var key in searchData){
    	if(searchData[key]!=null && searchData[key]!="" && typeof(searchData[key])=='string'){    		
    		searchData[key]=searchData[key].replace(/\s+/g, "");
    	}
    }
    advancedSearchWin.hide();
    doSearch(searchData);
}
function onAdvancedSearchCancel(){
    advancedSearchForm.clear();
    advancedSearchWin.hide();
}
var supplier = null;
function selectSupplier(elId) {
    supplier = null;
    nui.open({
        // targetWindow: window,,
        url : webPath+contextPath+"/com.hsweb.cloud.part.common.guestSelect.flow?token="+token,
        title : "物流资料",
        width : 980,
        height : 560,
        allowDrag : true,
        allowResize : true,
        onload : function() {
            var iframe = this.getIFrameEl();
            var params = {
                isClient: 1
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

function onDrawCell(e)
{
    switch (e.field)
    {
	    case "settleTypeId":
	        if(settTypeIdHash && settTypeIdHash[e.value])
	        {
	            e.cellHtml = settTypeIdHash[e.value].name;
	        }
	        break;
	    case "expenseTypeCode":
            if(InComeIdHash && InComeIdHash[e.value])
            {
                e.cellHtml = InComeIdHash[e.value].name;
            }
            break;
        case "stateSign":
            if(stateStatusHash && stateStatusHash[e.value])
            {
                e.cellHtml = stateStatusHash[e.value];
            }
            break;
        default:
            break;
    }
}

function onExport(){
	var detail = nui.clone(rightGrid.getData());
	//多级
	exportMultistage(rightGrid.columns)
	//单级
	//exportNoMultistage(rightGrid.columns)
	for(var i=0;i<detail.length;i++){
		if(settTypeIdHash[detail[i].settleTypeId]){
			detail[i].settleTypeId=settTypeIdHash[detail[i].settleTypeId].name;
		}
		if(InComeIdHash[detail[i].expenseTypeCode]){
			detail[i].expenseTypeCode = InComeIdHash[detail[i].expenseTypeCode].name;
		}
		if(stateStatusHash[detail[i].stateSign]){
			detail[i].stateSign = stateStatusHash[detail[i].stateSign];
		}
		
	}
	if(detail && detail.length > 0){
		//多级表头类型
		setInitExportData( detail,rightGrid.columns,"费用登记明细");
		//单级表头类型 与上二选一
		//setInitExportDataNoMultistage( detail,rightGrid.columns,"调拨受理明细表导出");
	}
}