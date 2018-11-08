/**
 * Created by Administrator on 2018/2/1.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.part.invoice.svr.queryPjInvoingDetail.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var basicInfoForm = null;
var rightGrid = null;
var brandHash = {};
var brandList = [];
var storehouseHash = {};
var billTypeIdHash = {};
var settTypeIdHash = {};
var outTypeIdHash = {};
$(document).ready(function(v)
{
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    startDateEl =nui.get('OstartDate');
    endDateEl = nui.get('OendDate');
    
    initMember("operatorId",function(){
    	
    });

    
	getAllPartBrand(function(data) {
		brandList = data.brand;
		nui.get('partBrandId').setData(brandList);
		brandList.forEach(function(v) {
			brandHash[v.id] = v;
		});
	});
	
	rightGrid.on("drawcell",function(e){
		switch (e.field) {
		case "partBrandId":
			if (brandHash[e.value]) {
				e.cellHtml = brandHash[e.value].name || "";
			} else {
				e.cellHtml = "";
			}
			break;
		default:
			break;
		}
	});
	
	document.onkeyup = function(event) {
		var e = event || window.event;
		var keyCode = e.keyCode || e.which;// 38向上 40向下
		
		if ((keyCode == 13)) { // F9
			onSearch();
		}

	}
    quickSearch(4);


});
function getSearchParams(){
    var params = {};
    params.partCodeOrName=nui.get("partCodeOrName").getValue();
    params.partId=nui.get("morePartId").getValue();
    params.partBrandId=nui.get("partBrandId").getValue();
    params.guestName=nui.get("guestName").getValue();
    params.operator=nui.get("operatorId").getText();
    params.OstartDate=nui.get("OstartDate").getValue().substr(0, 10);
    params.OendDate=nui.get("OendDate").getValue().substr(0, 10);
    return params;
}
var currType = 2;
function quickSearch(type){
	var params = getSearchParams();
    var queryname = "本日";
    switch (type)
    {
        case 0:
            params.today = 1;
            params.OstartDate = getNowStartDate();
            params.OendDate = addDate(getNowEndDate(), 1);
            queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.OstartDate = getPrevStartDate();
            params.OendDate = addDate(getPrevEndDate(), 1);
            queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.OstartDate = getWeekStartDate();
            params.OendDate = addDate(getWeekEndDate(), 1);
            queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.OstartDate = getLastWeekStartDate();
            params.OendDate = addDate(getLastWeekEndDate(), 1);
            queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.OstartDate = getMonthStartDate();
            params.OendDate = addDate(getMonthEndDate(), 1);
            queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.OstartDate = getLastMonthStartDate();
            params.OendDate = addDate(getLastMonthEndDate(), 1);
            queryname = "上月";
            break;

        case 10:
            params.thisYear = 1;
            params.OstartDate = getYearStartDate();
            params.OendDate = getYearEndDate();
            queryname="本年";
            break;
        case 11:
            params.lastYear = 1;
            params.OstartDate = getPrevYearStartDate();
            params.OendDate = getPrevYearEndDate();
            queryname="上年";
            break;
        default:
            break;
    }
    currType = type;
    startDateEl.setValue(params.OstartDate);
    endDateEl.setValue(params.OendDate);
    var menunamedate = nui.get("menunamedate");
    menunamedate.setText(queryname);
    doSearch(params);
}

function onSearch(){
	var params=getSearchParams();
	doSearch(params);
}
function doSearch(params)
{
	params.orgid = currOrgid;
    rightGrid.load({
        params:params,
        token :token     
    });
}
