/**
 * Created by Administrator on 2018/4/3.
 */
 var statusList = [{id: 0,text: '草稿'}, {id: 1,text: '已完工'}];
 var isBackList = [{ id: 0,text: '未返工'}, {id: 1,text: '已返工'}];
 var billTypeIdList=[{name:"综合"},{name:"检查"},{name:"洗美"},{name:"销售"},{name:"理赔"},{name:"退货"},{name:"计次卡"},{name:"充值"},{name:"保险"}];
 var statusList = [{id:"0",name:"车牌号"},{id:"1",name:"工单号"}];
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var webBaseUrl = webPath + contextPath + "/";
var gridUrl = apiPath + repairApi + '/com.hsapi.repair.repairService.report.querysaleDetail.biz.ext';
var mtAdvisorIdEl = null;
var grid = null;
var form = null;
var startDateEl = null;
var endDateEl = null;
var serviceTypeIdEl = null;
var servieTypeList = [];
var servieTypeHash = {};
var orgidsEl = null;
$(document).ready(function (v)
{
    mtAdvisorIdEl = nui.get("mtAdvisorId");
    grid = nui.get("grid");
    form = new nui.Form("#form1");
	startDateEl = nui.get("startDate");
	endDateEl = nui.get("endDate");
	serviceTypeIdEl = nui.get("serviceTypeId");
	 
	orgidsEl = nui.get("orgids");
    orgidsEl.setData(currOrgList);
    if(currOrgList.length==1){
    	orgidsEl.hide();
    }else{
    	orgidsEl.setValue(currOrgid);
    }

     initMember("mtAdvisorId", function () {
         //memList = mtAdvisorIdEl.getData();
         //nui.get("checkManId").setData(memList);
     });

     initServiceType("serviceTypeId", function (data) {
         servieTypeList = nui.get("serviceTypeId").getData();
         servieTypeList.forEach(function (v) {
             servieTypeHash[v.id] = v;
         });
     });
     
     grid.on("drawcell", function (e) {
    	 if (e.field == "serviceTypeId") {
    		 if(e.value){
    			 e.cellHtml = servieTypeHash[e.value].name; 
    		 }else{
    			 e.cellHtml = "";
    		 }
         }else if (e.field == "billTypeId") {
             e.cellHtml = billTypeIdList[e.value].name;
     }else if (e.field == "orgid"){
     	for(var i=0;i<currOrgList.length;i++){
    		if(currOrgList[i].orgid==e.value){
    			e.cellHtml = currOrgList[i].shortName;
    		}
    	}
    }
    	 
     document.onkeyup = function (event) {
         var e = event || window.event;
         var keyCode = e.keyCode || e.which; // 38向上 40向下


         if ((keyCode == 13)) { // F9
             onSearch();
         }
     }
   });    

	  var filter = new HeaderFilter(grid, {
	        columns: [
	            { name: 'serviceCode' },
	            { name: 'worker' },
	            { name: 'carNo' }
	            
	        ],
	        callback: function (column, filtered) {
	        },

	        tranCallBack: function (field) {
	        	var value = null;
	        	switch(field){
		    	}
	        	return value;
	        }
	    });
	 
    grid.setUrl(gridUrl);
    quickSearch(4);
});



function onStatusRenderer(e) {
    for (var i = 0, l = statusList.length; i < l; i++) {
        var g = statusList[i];
        if (g.id == e.value) return g.text;
    }
    return "";
}

function onIsBackRenderer(e) {
    for (var i = 0, l = isBackList.length; i < l; i++) {
        var g = isBackList[i];
        if (g.id == e.value) return g.text;
    }
    return "";
}

function onSearch()
{
    doSearch();
}
function doSearch() {
    var gsparams = getSearchParam();
    /*if(gsparams.billTypeIds && gsparams.billTypeIds==5){
    	gsparams.billTypeIds = "0,2,4";
    }*/
    gsparams.isSettle = 1;
   // gsparams.billTypeId = 0;
    gsparams.isDisabled = 0;
    gsparams.deductMode = 3;
    grid.load({
        token:token,
        params: gsparams
    });
}
function quickSearch(type){
    var params = getSearchParam();
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
        case 10:
            params.thisYear = 1;
            params.sOutDate = getYearStartDate();
            params.eOutDate = getYearEndDate();
            querysign = 1;
            queryname = "本年";
            break;
        case 11:
            params.lastYear = 1;
            params.sOutDate = getPrevYearStartDate();
            params.eOutDate = getPrevYearEndDate();
            querysign = 1;
            queryname = "上年";
            break;
       
        default:
            break;
    }
	 startDateEl.setValue(params.sOutDate);
	 endDateEl.setValue(addDate(params.eOutDate,-1));
    if(querysign == 1){
    	var menunamedate = nui.get("menunamedate");
    	menunamedate.setText(queryname); 	
    }
    
    doSearch(params);
}

function getSearchParam() {
    var params = {};
    params.sOutDate = nui.get("startDate").getValue();
    params.eOutDate = addDate(endDateEl.getValue(),1);  
    params.mtAuditorId = mtAdvisorIdEl.getValue();

   /* if((nui.get("billTypeId").getValue())==5){
    	
    }else{
        params.billTypeIds = nui.get("billTypeId").getValue();
    }*/
    var type = nui.get("search-type").getValue();
    var typeValue = nui.get("carNo-search").getValue();
    if(type==0){
        params.carNo = typeValue;
    }else if(type==1){
        params.serviceCode = typeValue;
    }
    var orgidsElValue = orgidsEl.getValue();
    if(orgidsElValue==null||orgidsElValue==""){
    	 params.orgids =  currOrgs;
    }else{
    	params.orgid=orgidsElValue;
    }
    return params;
}

function onExport(){
	var detail = nui.clone(grid.getData());
//多级
	exportMultistage(grid.columns)
//单级
       //exportNoMultistage(grid.columns)
	for(var i=0;i<detail.length;i++){
		detail[i].id=1;
		if(detail[i].serviceTypeId){
			detail[i].serviceTypeId = servieTypeHash[detail[i].serviceTypeId].name; 
		}else{
			detail[i].serviceTypeId = "";
		}
		detail[i].billTypeId=billTypeIdList[detail[i].billTypeId].name;
		
	}
	if(detail && detail.length > 0){
//多级表头类型
		setInitExportData( detail,grid.columns,"销售业绩明细表导出");
//单级表头类型  与上二选一
//setInitExportDataNoMultistage( detail,grid.columns,"已结算工单明细表导出");
	}
	
}