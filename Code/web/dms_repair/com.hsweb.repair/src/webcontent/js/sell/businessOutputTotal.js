/**
 * Created by Administrator on 2018/3/21.
 */
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
var mainGrid = null;
var mainGridUrl = baseUrl + "com.hsapi.repair.report.dataStatistics.queryOutputAnalysis.biz.ext";
var startDateEl = null ;
var endDateEl = null;
var mainGrid = null;
var mtAdvisorIdEl = null;
var serviceTypeIdEl = null;
var servieTypeHash = {};
$(document).ready(function ()
{
	mainGrid = nui.get("mainGrid");
	mtAdvisorIdEl = nui.get("mtAdvisorId");
	 serviceTypeIdEl = nui.get("serviceTypeId");
	mainGrid.setUrl(mainGridUrl);
     startDateEl = nui.get('startDate');
     endDateEl = nui.get('endDate');
     
     initMember("mtAdvisorId",function(){
         memList = mtAdvisorIdEl.getData();
         nui.get("mtAdvisorId").setData(memList);
     });
     mtAdvisorIdEl.on("valueChanged",function(e){
         var text = mtAdvisorIdEl.getText();
     });
     
     initServiceType("serviceTypeId",function(data) {
         servieTypeList = nui.get("serviceTypeId").getData();
         servieTypeList.forEach(function(v) {
             servieTypeHash[v.id] = v;
         });
     });
     
    quickSearch(0);  
});




function quickSearch(type) {
    //var params = getSearchParams();
    var params = {};
    var queryname = "本日";
    switch (type) {
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
    currType = type;
    startDateEl.setValue(params.startDate);
    endDateEl.setValue(addDate(params.endDate, -1));
    var menunamedate = nui.get("menunamedate");
    menunamedate.setText(queryname);
    

  doSearch(params);
}


function onSearch()
{
    doSearch();
}
function doSearch() {
    var gsparams = getSearchParam();
    mainGrid.load({
        token:token,
        params: gsparams
    });
}



function getSearchParam() {
    var params = {};
    params.startDate = nui.get("startDate").getValue();
    params.endDate = addDate(endDateEl.getValue(),1);  
    params.mtAdvisorId = mtAdvisorIdEl.getValue();
    params.serviceTypeId = nui.get("serviceTypeId").getValue();
    return params;
}



