/**
 * Created by Administrator on 2018/4/3.
 */

var mainGrid = null;
var startDateEl = null;
var endDateEl = null;
var company = [];
var queryCompanyUrl =apiPath + sysApi +"/com.hsapi.system.tenant.tenant.queryCompany.biz.ext";

var queryChainCashWaterSummaryUrl = apiPath + repairApi+'/com.hsapi.repair.report.dataStatistics.queryChainCashWaterSummary.biz.ext';


$(document).ready(function (v)
{

	mainGrid = nui.get("mainGrid");
	mainGrid.setUrl(queryChainCashWaterSummaryUrl);
	form=new nui.Form("#form1");
    startDateEl = nui.get("startDate");
    endDateEl = nui.get("endDate");
    
    mainGrid.on("drawcell", function (e) {
        if (e.field == "orgid") {
        	for(var i=0;i<company.length;i++){
        		if(e.value==company[i].orgid){
        			e.cellHtml = company[i].name;
        		}
        	}
            
        }else if (e.field == "qtAmt") {
                e.cellHtml = e.row.zongAmt-e.row.repairAmt-e.row.cardTimesAmt-e.row.cardAmt;
        }
    });
    

    quickSearch(4);
});

function getQueryCompany(){
	var params={
			page: {begin: 0, length: 999},
			
	}
	  var orgidList="";
  nui.ajax({
    url:queryCompanyUrl,
    type:"post",
    data:params,
    async:false,
    success:function(data)
    {
        nui.unmask();
        data = data.rs||{};
        company = data;
        for(var i = 0;i<data.length;i++){
        	if(i==0){
        		orgidList = data[i].orgid;
        	}else{
        		orgidList = orgidList +","+data[i].orgid;
        	}
        }
        
    },
    error:function(jqXHR, textStatus, errorThrown){
        //  nui.alert(jqXHR.responseText);
    	  nui.unmask();
        closeWindow("cal");
    }
});
return orgidList;
};

function onSearch(){
	var data= form.getData();    
	data.endDate = formatDate(data.endDate) +" 23:59:59";
	data.orgidList = getQueryCompany();
	data.billDc = 1;
	mainGrid.load({params:data,token :token});
}





function quickSearch(type){
    var params = {};
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
 onSearch();
}