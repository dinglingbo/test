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
var cType = 0;
var form=null;
var billTypeHash=[{name:"综合"},{name:"检查"},{name:"洗美"},{name:"销售"},{name:"理赔"},{name:"退货"}];
var statusList = [{id:"0",name:"车牌号"},{id:"1",name:"项目名称"}];
$(document).ready(function ()
{
	 form=new nui.Form("#form1");
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
     mainGrid.on("drawcell", function (e) {
         if(e.field =="groupName" && cType == 3){
        	 e.cellHtml = servieTypeHash[e.value].name;
         }else if(e.field =="groupName" && cType == 4){
        	 e.cellHtml = billTypeHash[e.value].name;
         }
     });
    quickSearch(2);  
});




var currType = 2;
function quickSearch(type){
   var params = form.getData();
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
    queryname="本年";
    break;
    case 11:
    params.lastYear = 1;
    params.startDate = getPrevYearStartDate();
    params.endDate = getPrevYearEndDate();
    queryname="上年";
    break;
    default:
    break;
}
currType = type;
startDateEl.setValue(params.startDate);
endDateEl.setValue(addDate(params.endDate,-1));
var menunamedate = nui.get("menunamedate");
menunamedate.setText(queryname);
params.groupByType = cType;
params.mtAdvisorId = nui.get("mtAdvisorId").getValue();
    mainGrid.load({params:params});
    updateGridColoumn(cType);
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


function load(e){
    if(e != undefined){
        cType = e;
    }
    
    var data= form.getData();
	data.endDate = formatDate(data.endDate) +" 23:59:59";
    data.groupByType = cType;
    updateGridColoumn(cType);
    mainGrid.load({params:data,token :token});
}

function updateGridColoumn(e){
    var column = mainGrid.getColumn("groupName");
    if(e == 0){
    	mainGrid.updateColumn(column,{header:"日期"});
    }else if(e == 1){
    	mainGrid.updateColumn(column,{header:"服务顾问"});
    }else if(e == 2){
    	mainGrid.updateColumn(column,{header:"品牌车型"});
    }else if(e == 3){
    	mainGrid.updateColumn(column,{header:"工单类型"});
    }
}