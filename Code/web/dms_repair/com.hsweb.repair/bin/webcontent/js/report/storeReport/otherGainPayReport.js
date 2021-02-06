/**
 * Created by Administrator on 2018/4/3.
 */

var webBaseUrl = webPath + contextPath + "/";
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/"; 
var grids = null;
var gridz = null;
var form = null;
var startDateEl = null;
var endDateEl = null;
var serviceTypeIdEl = null;
var servieTypeList = [];
var servieTypeHash = {};
var cType = 0;
var orgidsEl = null;
var gridsUrl = apiPath + repairApi+'/com.hsapi.frm.setting.queryOtherIncomeAndExpenditureSummaryshou.biz.ext';
var gridzUrl = apiPath + repairApi+'/com.hsapi.frm.setting.queryOtherIncomeAndExpenditureSummaryzhi.biz.ext';
$(document).ready(function (v)
{

	grids = nui.get("grids");
	gridz = nui.get("gridz");
    form=new nui.Form("#form1");
    startDateEl = nui.get("startDate");
    endDateEl = nui.get("endDate");
    serviceTypeIdEl = nui.get("serviceTypeId");
    
    //判断是否有兼职门店,是否显示门店选择框
    orgidsEl = nui.get("orgids");
    orgidsEl.setData(currOrgList);
    if(currOrgList.length==1){
    	orgidsEl.hide();
    }else{
    	orgidsEl.setValue(currOrgid);
    }
    
    initServiceType("serviceTypeId",function(data) {
        servieTypeList = nui.get("serviceTypeId").getData();
        servieTypeList.forEach(function(v) {
            servieTypeHash[v.id] = v;
        });
    });



    quickSearch(4);
});

function load(e){
    if(e != undefined){
        cType = e;
    }
    
    var data= form.getData();
	data.endDate = formatDate(data.endDate) +" 23:59:59";
    data.groupByType = cType;
    updateGridColoumn(cType);
    var orgidsElValue = orgidsEl.getValue();
    if(orgidsElValue==null||orgidsElValue==""){
    	data.orgids =  currOrgs;
    }else{
    	data.orgid=orgidsElValue;
    }

    nui.ajax({
    	url : gridsUrl,
    	type : 'POST',
    	data : {params:data},
    	cache : false,
    	contentType : 'text/json',
    	success : function(text) {
    		nui.unmask(document.body);
    		grids.setData(text.list);
    	}
    });
    nui.ajax({
    	url : gridzUrl,
    	type : 'POST',
    	data : {params:data},
    	cache : false,
    	contentType : 'text/json',
    	success : function(text) {
    		nui.unmask(document.body);
    		gridz.setData(text.list);
    	}
    });
}


function updateGridColoumn(e){
    var columns = grids.getColumn("groupName");
    var columnz = gridz.getColumn("groupName");
    if(e == 0){
        grids.updateColumn(columns,{header:"日期"});
        gridz.updateColumn(columnz,{header:"日期"});
    }else if(e == 1){
        grids.updateColumn(columns,{header:"收支项目"});
        gridz.updateColumn(columnz,{header:"收支项目"});

    }else if(e == 2){
        grids.updateColumn(columns,{header:"往来单位名称"});
        gridz.updateColumn(columnz,{header:"往来单位名称"});

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
 
 var orgidsElValue = orgidsEl.getValue();
 if(orgidsElValue==null||orgidsElValue==""){
 	 params.orgids =  currOrgs;
 }else{
 	params.orgid=orgidsElValue;
 }
 // doSearch(params);

//  if(params.endDate){
//  params.endDate = params.endDate +" 23:59:59";
//}

nui.ajax({
	url : gridsUrl,
	type : 'POST',
	data : {params:params},
	cache : false,
	contentType : 'text/json',
	success : function(text) {
		nui.unmask(document.body);
		grids.setData(text.list);
	}
});
nui.ajax({
	url : gridzUrl,
	type : 'POST',
	data : {params:params},
	cache : false,
	contentType : 'text/json',
	success : function(text) {
		nui.unmask(document.body);
		gridz.setData(text.list);
	}
});
updateGridColoumn(cType);
}