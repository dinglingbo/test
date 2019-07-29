var baseUrl = apiPath + cloudPartApi + "/";
var companyUrl = apiPath + sysApi + "/"+"com.hsapi.system.basic.organization.getCompanyAll.biz.ext";
var mainGridUrl = baseUrl+"com.hsapi.cloud.part.settle.svr.queryGuestReceiveAmt.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.query.queryPjPchsEnterMainDetailList.biz.ext";
var leftGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.query.queryReceiveMainDetails.biz.ext";
var orgidsEl =null;
var orgids="";
var mainGrid =null;
var searchBeginDate = null;
var searchEndDate = null;
var leftGrid = null;
var rightGrid =null;
var mainTabs =null;
$(document).ready(function(v) {
	orgidsEl = nui.get("orgids");
	getCompany();
	mainGrid =nui.get("mainGrid");
	mainGrid.setUrl(mainGridUrl);
    searchBeginDate = nui.get("beginDate");
    searchEndDate = nui.get("endDate");
    leftGrid =nui.get("leftGrid");
    rightGrid = nui.get("rightGrid");
    leftGrid.setUrl(leftGridUrl);
    rightGrid.setUrl(rightGridUrl);
    mainTabs =nui.get("mainTabs");
    mainTabs.on("activechanged",function(e){
    	var tab = mainTabs.getActiveTab();
    	var name = tab.name;
        var url = tab.url;
        if(name == 'receiveTab'){
        	loadLeftGridData();
        }else{
        	loadRightGridData();
        }
    });
    
    quickSearch(0);
    loadLeftGridData();
});

function getCompany(){
	var params = {};
	nui.ajax({
        url: companyUrl,
        type: 'post',
        async:false,
        data: nui.encode({
        	params: params,
            token: token
        }),
        cache: false,
        success: function (data) {
            if (data.errCode == "S"){
            	var orgList =data.companyList;
            	orgidsEl = nui.get("orgids");
                orgidsEl.setData(data.companyList);
                orgList.forEach(function(v){
                	orgids =orgids+v.orgid+","
                });
                orgids = orgids.substring(0,orgids.length-1);
            }else {
            	orgidsEl = nui.get("orgids");
                orgidsEl.setData([]);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
        }
	});
}

function getSearchParam(){
    var params = {};

    params.sCreateDate = searchBeginDate.getFormValue();
    params.eCreateDate = searchEndDate.getFormValue();
    params.guestName =nui.get('guestName').getValue().replace(/\s+/g, "");
    params.orgid =nui.get('orgids').getValue();
    if(!params.orgid){
    	params.orgid =null;
    	params.orgids = orgids;
    }
    params.tenantId =currTenantId;
    return params;
}
var currType = 2;
function quickSearch(type){
    var params = getSearchParam();
    var queryname = "全部";
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
	mainGrid.load({
        params:params,
        token: token
    });
}

function loadRightGridData(){
	var params = getSearchParam();
	params.sortField ="a.audit_date";
	params.sortOrder ="desc";
    rightGrid.load({
        params:params,
        token:token
    });
}

function loadLeftGridData(){
	var params = getSearchParam();
	params.sortField ="a.audit_date";
	params.sortOrder ="desc";
    leftGrid.load({
        params:params,
        token:token
    });
}

function onRightGridDraw (e){
	
}

function onDrawCell(e){
	
}