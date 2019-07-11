/**
 * Created by Administrator on 2018/2/1.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.report.report.queryDeductDetailSum.biz.ext";

var basicInfoForm = null;
var rightGrid = null;
var searchBeginDate = null;
var searchEndDate = null;
var comPartNameAndPY = null;
var comPartCode = null;
var orderCodeEl = null;
var outCodeEl = null;
var comSearchGuestId = null;

var storehouseHash = {};
var billTypeIdHash = {};
var settTypeIdHash = {};
var enterTypeIdHash = {};
var partBrandIdHash = {};
var deductTypeHash={1:"单据提成",2:"特定产品提成"};
var typeHash ={1:"按销售金额分成",2:"按销售毛利分成"};
$(document).ready(function(v)
{
	rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    rightGrid.on("load", function () {
        rightGrid.mergeColumns(["serviceId"]);
    });
    searchBeginDate = nui.get("startDate");
    searchEndDate = nui.get("endDate");
 	comPartNameAndPY = nui.get("partName");
	comPartCode = nui.get("partCode");
	orderCodeEl = nui.get("orderCode");
	outCodeEl = nui.get("outCode");
	quickSearch(2);
 
});
function getSearchParam(){
    var params = {};
    params.orderCode = orderCodeEl.getValue().replace(/\s+/g, "");
    params.outCode = outCodeEl.getValue().replace(/\s+/g, "");
	params.partCode = comPartCode.getValue().replace(/\s+/g, "");
	params.partName = comPartNameAndPY.getValue().replace(/\s+/g, "");
	params.endDate = searchEndDate.getFormValue();
	params.startDate = searchBeginDate.getFormValue();
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
            params.startDate = getNowStartDate();
            params.endDate = addDate(getNowEndDate(), 1);
            queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.startDate = getPrevStartDate();
            params.endDate = addDate(getPrevEndDate(), 1);
            queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.startDate = getWeekStartDate();
            params.endDate = addDate(getWeekEndDate(), 1);
            queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.startDate = getLastWeekStartDate();
            params.endDate = addDate(getLastWeekEndDate(), 1);
            queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.startDate = getMonthStartDate();
            params.endDate = addDate(getMonthEndDate(), 1);
            queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.startDate = getLastMonthStartDate();
            params.endDate = addDate(getLastMonthEndDate(), 1);
            queryname = "上月";
            break;
        case 10:
            params.thisYear = 1;
            params.startDate = getYearStartDate();
            params.endDate = getYearEndDate();
            queryname = "本年";
            break;
        case 11:
            params.lastYear = 1;
            params.startDate = getPrevYearStartDate();
            params.endDate = getPrevYearEndDate();
            queryname = "上年";
            break;
        default:
            break;
    }
    searchBeginDate.setValue(params.startDate);
    searchEndDate.setValue(params.endDate);
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
    params.orderTypeId = 2;
    params.isDiffOrder = 0;
	params.sortField = "audit_date";
	params.sortOrder = "desc";
    rightGrid.load({
        params:params,
        token:token
    },function(){
        rightGrid.mergeColumns(["serviceId"]);
    });
}

function onDrawCell(e)
{
    switch (e.field)
    {
	   
        case "deductType":
            if(deductTypeHash && deductTypeHash[e.value])
            {
                e.cellHtml = deductTypeHash[e.value];
            }
            break;
        case "type":
            if(typeHash && typeHash[e.value])
            {
                e.cellHtml = typeHash[e.value];
            }
     
        default:
            break;
    }
}