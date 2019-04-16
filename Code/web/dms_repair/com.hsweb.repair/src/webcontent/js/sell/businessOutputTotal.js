/**
 * Created by Administrator on 2018/3/21.
 */
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
var mainGrid = null;
var mainGridUrl = baseUrl + "com.hsapi.repair.report.dataStatistics.queryOutputAnalysis.biz.ext";
var beginDateEl = null;
var endDateEl = null;
var mainGrid = null;
var mtAdvisorIdEl = null;
var serviceTypeIdEl = null;
var servieTypeHash = {};
var cType = 0;
var form=null;
var billTypeHash=[{name:"综合"},{name:"检查"},{name:"洗美"},{name:"销售"},{name:"理赔"},{name:"退货"},{name:"波箱"}];
var orgidsEl = null;
var advancedSearchWin = null;
var advancedSearchForm = null;
$(document).ready(function ()
{
	 form=new nui.Form("#form1");
	mainGrid = nui.get("mainGrid");
	mtAdvisorIdEl = nui.get("mtAdvisorId");
	 serviceTypeIdEl = nui.get("serviceTypeId");
    advancedSearchForm = new nui.Form("#advancedSearchForm");
    advancedSearchForm = new nui.Form("#advancedSearchForm");
	mainGrid.setUrl(mainGridUrl);
    beginDateEl = nui.get("sEnterDate");
	endDateEl = nui.get("eEnterDate");
	advancedSearchWin = nui.get("advancedSearchWin");    
     //判断是否有兼职门店,是否显示门店选择框
     orgidsEl = nui.get("orgids");
     orgidsEl.setData(currOrgList);
     if(currOrgList.length==1){
     	orgidsEl.hide();
     }else{
     	orgidsEl.setValue(currOrgid);
     }
     
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
        	 if(e.value){
        		 e.cellHtml = servieTypeHash[e.value].name;
        	 }else{
        		 e.cellHtml = ""; 
        	 }
         }else if(e.field =="groupName" && cType == 4){
        	 e.cellHtml = billTypeHash[e.value].name;
         }
     });
    quickSearch(4);  
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
	beginDateEl.setValue(params.startDate);
	endDateEl.setValue(addDate(params.endDate,-1));
	var menunamedate = nui.get("menunamedate");
	menunamedate.setText(queryname);
	params.groupByType = cType;
	updateGridColoumn(cType);
	doSearch();
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
    if(nui.get("isCollectMoney").getValue()==0){
    	params.isCollectMoney=1;
    }
    params.sEnterDate = nui.get("sEnterDate").getValue();
    params.eEnterDate = addDate(endDateEl.getValue(),1); 
    params.groupByType = cType;
    var orgidsElValue = orgidsEl.getValue();
    if(orgidsElValue==null||orgidsElValue==""){
    	 params.orgids =  currOrgs;
    }else{
    	params.orgid=orgidsElValue;
    }
    return params;
}


function summary(e){	
    if(e != undefined){
        cType = e;
    }
    var params = getSearchParam();
    mainGrid.setData([]);
    params.groupByType = cType;
    updateGridColoumn(cType);
    mainGrid.load({params:params,token :token});
}

function updateGridColoumn(e){
	
    var column = mainGrid.getColumn("groupName");
    if(e == 0){
    	mainGrid.updateColumn(column,{header:"进厂日期"});
    }else if(e == 1){
    	mainGrid.updateColumn(column,{header:"服务顾问"});
    }else if(e == 2){
    	mainGrid.updateColumn(column,{header:"品牌车型"});
    }else if(e == 3){
    	mainGrid.updateColumn(column,{header:"业务类型"});
    }else if(e == 4){
    	mainGrid.updateColumn(column,{header:"工单类型"});
    }
}

function advancedSearch()
{
	
    advancedSearchWin.show();
    advancedSearchForm.clear();
    nui.get("sEnterDate1").setValue(getMonthStartDate());
    nui.get("eEnterDate1").setValue(getMonthEndDate());
}

function onAdvancedSearchOk()
{   
	var searchData = {};
	searchData.outDateStart = nui.get("outDateStart").getValue();
	if(nui.get("outDateEnd").getValue()){
		searchData.outDateEnd = addDate(nui.get("outDateEnd").getValue(),1); 
	}
	searchData.collectMoneyDateStart = nui.get("collectMoneyDateStart").getValue();
	if(nui.get("collectMoneyDateEnd").getValue()){
		searchData.collectMoneyDateEnd = addDate(nui.get("collectMoneyDateEnd").getValue(),1); 
	}
	searchData.sEnterDate = nui.get("sEnterDate1").getValue();
	if(nui.get("eEnterDate1").getValue()){
		searchData.eEnterDate = addDate(nui.get("eEnterDate1").getValue(),1);  
	}

	searchData.serviceTypeIds = serviceTypeIdEl.getValue();
    searchData.mtAuditorId = mtAdvisorIdEl.getValue();
    searchData.guestProperty = nui.get("guestProperty").getValue();
    searchData.propertyFeatures = nui.get("propertyFeatures").getValue();
    var billTypeIdList =  nui.get("billTypeIdList").getValue();
    if(billTypeIdList!=""&&billTypeIdList!=null){
    	searchData.billTypeIdList = billTypeIdList;
    }
    
/*    if((nui.get("statusId").getValue())!=999){
    	searchData.status = nui.get("statusId").getValue();
    }*/
/*    var settleType = nui.get("settleType").getValue();
    if(settleType==0){
    	searchData.balaAuditSign = 0;
    }else if(settleType==1){
    	searchData.balaAuditSign = 1;
    	searchData.isSettle = 0;
    }else if(settleType==2){
    	searchData.isSettle = 1;
    	searchData.isCollectMoney = 0;
    }else if(settleType==3){
    	searchData.isCollectMoney = 1;
    }*/
    searchData.groupByType = cType;
    var settleType = nui.get("settleType").getValue();
    if(settleType==1){
    	searchData.isCollectMoney = 0;
    }else if(settleType==2){
    	searchData.balaAuditSign = 1;
    	searchData.isCollectMoney = 1;
    }
    
/*    if((nui.get("auditSign").getValue())!=999){
    	searchData.isSettle = nui.get("auditSign").getValue();
    }*/  
/*    searchData.carNo = nui.get("carNo").getValue();
    searchData.vin = nui.get("vin").getValue();
    searchData.name = nui.get("name").getValue();
    searchData.mobile = nui.get("mobile").getValue();*/
    advancedSearchWin.hide();
    doSearch2(searchData);
    advancedSearchForm.gusetId=null;
  
}
function doSearch2(params){
    mainGrid.load({
        token:token,
        params: params
    });
}
function onAdvancedSearchCancel(){
    advancedSearchForm.clear();
    advancedSearchWin.hide();

}

function cancelData(){
	advancedSearchForm.setData([]);
    nui.get("sEnterDate1").setValue(getMonthStartDate());
    nui.get("eEnterDate1").setValue(getMonthEndDate());
}