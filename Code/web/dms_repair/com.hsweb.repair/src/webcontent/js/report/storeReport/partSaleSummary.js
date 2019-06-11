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
var gridUrl = apiPath + repairApi+'/com.hsapi.repair.report.dataStatistics.queryPartSummary.biz.ext';
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


    grid1.on("drawcell", function (e) {
        if(e.field =="groupName" && cType == 1){
            e.cellHtml = servieTypeHash[e.value].name;
        }

    });
    
    grid1.setUrl(gridUrl);

    quickSearch(4);
});

function load(e){
    if(e != undefined){
        cType = e;
    }
    
    var data= form.getData();
	data.endDate = formatDate(data.endDate) +" 23:59:59";
	if(e==0){
		data.groupByQuery = "DATE_FORMAT(c.out_date,'%Y-%m-%d')  as groupName,"
		data.groupByType = "GROUP BY DATE_FORMAT(c.out_date,'%Y-%m-%d')";
	}else if(e==1){
		data.groupByQuery = "c.service_type_id as groupName,"
	    data.groupByType = "group by c.service_type_id";
	}else if(e==2){
		data.groupByQuery = "b.part_code as groupName,b.part_name as partName,"
	    data.groupByType = "group by b.part_name, b.part_code ";
	}
    updateGridColoumn(cType);
    grid1.load({params:data,token :token});
}


function updateGridColoumn(e){
    var column = grid1.getColumn("groupName");
    var partName = grid1.getColumn("partName");
    if(e == 0){
        grid1.updateColumn(column,{header:"日期"});
        grid1.hideColumn ( partName );
    }
    if(e == 1){
        grid1.updateColumn(column,{header:"业务类型"});
        grid1.hideColumn ( partName );
    }
    if(e == 2){
        grid1.updateColumn(column,{header:"配件编码"});
        grid1.showColumn ( partName );
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
grid1.load({params:params});
updateGridColoumn(cType);
}