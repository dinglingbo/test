/**
 * Created by Administrator on 2018/4/3.
 */

var webBaseUrl = webPath + contextPath + "/";
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/"; 
var grid1 = null;
var form = null;
var startDateEl = null;
var endDateEl = null;
var serviceTypeIdEl = null;
var servieTypeList = [];
var servieTypeHash = {};
var cType = 0;
var orgidsEl = null;
var gridUrl = apiPath + repairApi+'/com.hsapi.repair.report.dataStatistics.queryTechnicianSummary.biz.ext';
$(document).ready(function (v)
{

	grid1 = nui.get("grid1");
    form=new nui.Form("#form1");
    startDateEl = nui.get("startDate");
    endDateEl = nui.get("endDate");
    serviceTypeIdEl = nui.get("serviceTypeId");
    initServiceType("serviceTypeId",function(data) {
        servieTypeList = nui.get("serviceTypeId").getData();
        servieTypeList.forEach(function(v) {
            servieTypeHash[v.id] = v;
        });
    });
    
    orgidsEl = nui.get("orgids");
    orgidsEl.setData(currOrgList);
    if(currOrgList.length==1){
    	orgidsEl.hide();
    }else{
    	orgidsEl.setValue(currOrgid);
    }

    grid1.on("drawcell", function (e) {
        if(e.field =="groupName" && cType == 1){
        	if(e.value){
        		e.cellHtml = servieTypeHash[e.value].name;
        	}else{
        		e.cellHtml = "";
        	}
            
        }

    });
    
    grid1.setUrl(gridUrl);

    quickSearch(4);
});

function load(e){
    if(e != undefined){
        cType = e;
    }
    grid1.setData([]);
    var data= form.getData();
	data.endDate = formatDate(data.endDate) +" 23:59:59";
    data.groupByType = cType;
    updateGridColoumn(cType);
    data.deductMode = 1;
    var orgidsElValue = orgidsEl.getValue();
    if(orgidsElValue==null||orgidsElValue==""){
    	data.orgids =  currOrgs;
    }else{
    	data.orgid=orgidsElValue;
    }
    grid1.load({params:data,token :token});
}


function updateGridColoumn(e){
    var column = grid1.getColumn("groupName");
    if(e == 0){
        grid1.updateColumn(column,{header:"日期"});
    }else if(e == 1){
        grid1.updateColumn(column,{header:"业务类型"});

    }else if(e == 2){
        grid1.updateColumn(column,{header:"提成人"});

    }

}

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
 // doSearch(params);

//  if(params.endDate){
//  params.endDate = params.endDate +" 23:59:59";
//}
 var orgidsElValue = orgidsEl.getValue();
 if(orgidsElValue==null||orgidsElValue==""){
 	 params.orgids =  currOrgs;
 }else{
 	params.orgid=orgidsElValue;
 }
params.deductMode = 1;
grid1.load({params:params});
updateGridColoumn(cType);
}

function onExport(){
	var detail = nui.clone(grid1.getData());
	exportNoMultistage(grid1.columns)
	for(var i=0;i<detail.length;i++){
		detail[i].id=1;
	    if(cType == 1){
	    	detail[i].groupName=servieTypeHash[detail[i].groupName].name;
	    }
	}
	if(detail && detail.length > 0){
		setInitExportDataNoMultistage( detail,grid1.columns,"服务顾问提成汇总表导出");
	}
	
}