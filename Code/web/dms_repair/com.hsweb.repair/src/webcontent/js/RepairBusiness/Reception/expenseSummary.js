 var baseUrl = apiPath + repairApi + "/";
var statusList = [{id:"0",name:"车牌号"},{id:"1",name:"客户名称"},{id:"2",name:"手机号"}];
var mainGrid = null;
var mainGridUrl = baseUrl+"com.hsapi.repair.repairService.query.queryExpenseSummaryList.biz.ext";
var beginDateEl = null;
var endDateEl = null;
var typeIdHash = {};
$(document).ready(function ()
{
	mainGrid = nui.get("mainGrid"); 
	mainGrid.setUrl(mainGridUrl);
	beginDateEl = nui.get("sRecordDate");
    endDateEl = nui.get("eRecordDate");
	nui.get("search-type").setData(statusList);
	var params = {isMain:0};
	svrInComeExpenses(params,function(data) {
		var list = data.list||{};
		list.forEach(function(v) {
			typeIdHash[v.id] = v;
        });
    });
	mainGrid.on("drawcell",function(e){
		if(e.field=="typeId"){
			var num = parseInt(e.value);
			 e.cellHtml = typeIdHash[num].name;
		}
		if(e.field=="dc"){
		  e.cellHtml = (e.value == 1 ?"应收":"应付"); 
		}
	});
	
	quickSearch(4);
});

function quickSearch(type){
    var params = getSearchParams();
    var querysign = 1;
    var queryname = "本日";
    switch (type)
    {
        case 0:
            params.today = 1;
            params.sOutDate = getNowStartDate();
            params.eOutDate = addDate(getNowEndDate(), 1);
            querysign = 1;
            queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.sOutDate = getPrevStartDate();
            params.eOutDate = addDate(getPrevEndDate(), 1);
            querysign = 1;
            queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.sOutDate = getWeekStartDate();
            params.eOutDate = addDate(getWeekEndDate(), 1);
            querysign = 1;
            queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.sOutDate = getLastWeekStartDate();
            params.eOutDate = addDate(getLastWeekEndDate(), 1);
            querysign = 1;
            queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.sOutDate = getMonthStartDate();
            params.eOutDate = addDate(getMonthEndDate(), 1);
            querysign = 1;
            queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.sOutDate = getLastMonthStartDate();
            params.eOutDate = addDate(getLastMonthEndDate(), 1);
            querysign = 1;
            queryname = "上月";
            break;
        case 6:
            params.thisYear = 1;
            params.sOutDate = getYearStartDate();
            params.eOutDate = getYearEndDate();
            querysign = 1;
            queryname = "本年";
            break;
        case 7:
            params.lastYear = 1;
            params.sOutDate = getPrevYearStartDate();
            params.eOutDate = getPrevYearEndDate();
            querysign = 1;
            queryname = "上年";
            break;
       
        default:
            break;
    }
    
    beginDateEl.setValue(params.sOutDate);
    endDateEl.setValue(addDate(params.eOutDate,-1));
    if(querysign == 1){
    	var menunamedate = nui.get("menunamedate");
    	menunamedate.setText(queryname); 	
    }
    
    onSearch();
}

function getSearchParams()
{
    var params = {};
    params.sRecordDate = beginDateEl.getFormValue();
    params.eRecordDate = addDate(endDateEl.getFormValue(),1);
    params.checkMan = nui.get("checkMan").getValue();
    var type = nui.get("search-type").getValue();
    var typeValue = nui.get("carNo-search").getValue();
    if(type==0){
        params.carNo = typeValue;
    }else if(type==1){
        params.name = typeValue;
    }else if(type==2){
        params.mobile = typeValue;
    }
    return params;
}
function onSearch()
{
	var params=getSearchParams();
    doSearch(params);
} 
function doSearch(params) {
    params.orgid = currOrgid;
    mainGrid.load({
        token:token, 
        params: params
    });
}
