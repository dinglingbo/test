/**
 * Created by Administrator on 2018/4/12.
 */
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var grid = null;
var gridUrl = baseUrl + "com.hsapi.repair.repairService.report.queryRepairAnaylsisList.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var servieTypeList = [];
var servieTypeHash = {};
var memList = [];
var mtAdvisorIdEl = null;
var mtTypeHash = {};
var guestSourceHash = {};
var orgHash = {};
var mtAdvisorIdHash = {};
var carBrandHash = {};
var insuranceHash = {};
var sRecordDate = null;
var eRecordDate = null;
var orgidsEl = null;
$(document).ready(function (v)
{
	advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    grid = nui.get("datagrid1");
    grid.setUrl(gridUrl);
    mtAdvisorIdEl = nui.get("mtAdvisorId");
    sRecordDate = nui.get("sRecordDate");
    eRecordDate = nui.get("eRecordDate");
    
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
    initMember("mtAdvisorId",function(){
        memList = mtAdvisorIdEl.getData();
        //nui.get("checkManId").setData(memList);
    });
    
    grid.on("drawcell", function (e) {
        if(e.field == "orgid"){
        	for(var i=0;i<currOrgList.length;i++){
        		if(currOrgList[i].orgid==e.value){
        			e.cellHtml = currOrgList[i].shortName;
        		}
        	}
        	
        }
    });
    quickSearch(0);
});

var searchByDateBtnTextHash = ["本日","昨日","本周","上周","本月","上月","本年","上年"];
var currType = 0;
function quickSearch(type) {
    currType = type;
    var btn = nui.get("menunamestatus");
    if(btn)
    {
        var text = searchByDateBtnTextHash[type];
        btn.setText(text);
    }
    onSearch();
}

function onSearch()
{
    var d = currType;
    if (d == 0) {
    	/* params.today = 1;
        params.startDate = getNowStartDate();
        params.endDate = addDate(getNowEndDate(), 1);*/
        sRecordDate.setValue(getNowStartDate());
        eRecordDate.setValue(getNowStartDate());
    } else if (d == 1) {
    	/*params.yesterday = 1;
        params.startDate = getPrevStartDate();
        params.endDate = addDate(getPrevEndDate(), 1);*/
        sRecordDate.setValue(getPrevStartDate());
        eRecordDate.setValue(getPrevEndDate());
        
    } else if (d == 2) {
    	/*params.thisWeek = 1;
        params.startDate = getWeekStartDate();
        params.endDate = addDate(getWeekEndDate(), 1);*/
        sRecordDate.setValue(getWeekStartDate());
        eRecordDate.setValue(getWeekEndDate());
    } else if (d == 3) {
      /*params.lastWeek = 1;
        params.startDate = getLastWeekStartDate();
        params.endDate = addDate(getLastWeekEndDate(), 1);*/
        sRecordDate.setValue(getLastWeekStartDate());
        eRecordDate.setValue(getLastWeekEndDate());
        
    } else if (d == 4) {
    	/* params.thisMonth = 1;
        params.startDate = getMonthStartDate();
        params.endDate = addDate(getMonthEndDate(), 1);*/
        sRecordDate.setValue(getMonthStartDate());
        eRecordDate.setValue(getMonthEndDate());
        
    } else if (d == 5) {
    	/*params.lastMonth = 1;
        params.startDate = getLastMonthStartDate();
        params.endDate = addDate(getLastMonthEndDate(), 1);*/
        sRecordDate.setValue(getLastMonthStartDate());
        eRecordDate.setValue(getLastMonthEndDate());
    }else if (d == 6) {
    	/* params.lastMonth = 1;
        params.startDate = getYearStartDate();
        params.endDate = getYearEndDate();*/
        sRecordDate.setValue(getYearStartDate());
        eRecordDate.setValue(getYearEndDate());
    }else if (d == 7) {
    	/*params.lastMonth = 1;
        params.startDate = getPrevYearStartDate();
        params.endDate = getPrevYearEndDate();*/
        sRecordDate.setValue(getPrevYearStartDate());
        eRecordDate.setValue(getPrevYearEndDate());
    }
    doSearch();
}

function doSearch() {
   var params = getSearchParams();
    grid.load({
        token:token,
        params: params
    });
}

function getSearchParams()
{
    var params = {};
    /*switch (currType) {
        case 0:
            params.today = 1;
            break;
        case 1:
            params.yesterday = 1;
            break;
        case 2:
            params.thisWeek = 1;
            break;
        case 3:
            params.lastWeek = 1;
            break;
        case 4:
            params.thisMonth = 1;
            break;
        case 5:
            params.lastMonth = 1;
            break;
        case 6:
            params.thisYear = 1;
            break;
        case 7:
            params.lastYear = 1;
            break;
        default:
            break;
    }*/
	params.startDate = sRecordDate.getValue();
    params.endDate = addDate(eRecordDate.getValue(), 1);
    params.mtAdvisorId = nui.get("mtAdvisorId").getValue();
    var orgidsElValue = orgidsEl.getValue();
    if(orgidsElValue==null||orgidsElValue==""){
    	 params.orgids =  currOrgs;
    }else{
    	params.orgid=orgidsElValue;
    }
   // params = getAnayType(params);
    return params;
   
}


function advancedSearch()
{
    advancedSearchWin.show();
}
function onAdvancedSearchOk()
{
    var searchData = advancedSearchForm.getData();
    var i,tmpList;
    if(!searchData.startDate || !searchData.endDate)
    {
        nui.alert("结算起始日期和终止日期不能为空");
        return;

    }
    searchData.startDate = searchData.startDate.substr(0,10);
    searchData.endDate = searchData.endDate.substr(0,10);
    if(searchData.serviceCodeList)
    {
        tmpList = searchData.serviceCodeList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i]+"'";
        }
        searchData.serviceCodeList = tmpList.join(",");
    }
    advancedSearchWin.hide();
    searchData = getAnayType(searchData);
    doSearch(searchData);
}
function onAdvancedSearchCancel()
{
    advancedSearchWin.hide();
}
function onAdvancedSearchClear()
{
    advancedSearchForm.clear();
}

function quickSearch1(type)
{
    currAnayType = type;
    var btn = nui.get("analysisByDateBtn");
    if(btn)
    {
        var text = analysisByDateBtnTextHash[type];
        btn.setText(text);
        grid.updateColumn("groupName", {header:analysisByDateBtnTextHash[type]+"分析"});
    }
    onSearch();
}

var currAnayType = 1;
var analysisByDateBtnTextHash = ["按分店","按维修顾问","按品牌","按客户来源","按业务类型","按维修类型","按来厂次数"];

function getAnayType(params)
{
    switch (currAnayType)
    {
        case 0://按分店
            params.groupField = "a.orgid";
            break;
        case 1://按维修顾问
            params.groupField = "mt_advisor";
            break;
        case 2://按品牌
            params.groupField = "car_brand_id";
            break;
        case 3://按客户来源
            params.groupField = "source";
            break;
        case 4://按业务类型
            params.groupField = "service_type_id";
            break;
        case 5://按维修类型
            params.groupField = "mt_type";
            break;
        case 6://按来厂次数
            params.groupField = "a.chain_come_times";
            break;
        case 7://按投保公司
            params.groupField = "e.insure_comp_code";
            break;
    }
    return params;
}


function query(){
	var params = {};
	params.mtAdvisorId = nui.get("mtAdvisorId").value;
	params.serviceTypeId = nui.get("serviceTypeId").value;	
	params.startDate  = nui.get("sRecordDate").value;
	params.endDate = nui.get("eRecordDate").value;
	doSearch(params);
}
function history()
{
    var row = grid.getSelected();
    if(!row)
    {
        return;
    }
    nui.open({
        url: "com.hsweb.repair.common.repairHistory.flow",
        title: "维修历史", width: 850, height: 600,
        onload: function () {
            var iframe = this.getIFrameEl();
            var params = {
                contactorId:row.contactorId
            };
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action) {
        }
    });
}
function selectCustomer(elId) {
    nui.open({
        url: "com.hsweb.RepairBusiness.Customer.flow",
        title: "客户选择", width: 800, height: 450,
        onload: function () {
        },
        ondestroy: function (action) {
            if ("ok" == action) {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                var guest = data.guest;
                console.log(guest);
                if(nui.get(elId))
                {
                    nui.get(elId).setValue(guest.guestId);
                    nui.get(elId).setText(guest.guestFullName);
                }
            }
        }
    });
}
function onExport(){
	var detail = grid.getData();
//多级
	exportMultistage(grid.columns)
//单级
       //exportNoMultistage(grid.columns)
	for(var i=0;i<detail.length;i++){
		detail[i].id=1;
/*		detail[i].status=statusHash[detail[i].status]

		detail[i].billTypeId=billTypeIdList[detail[i].billTypeId].name;
        if(detail[i].isSettle== 1){
        	detail[i].isSettle = "已结算";
        }else{
        	detail[i].isSettle = "未结算";
        }

		if(detail[i].isCollectMoney==1){
			detail[i].isCollectMoney="√";
		}else{
			detail[i].isCollectMoney="";
		}*/
	}
	if(detail && detail.length > 0){
//多级表头类型
		setInitExportData( detail,grid.columns,"已结算工单明细表导出");
//单级表头类型  与上二选一
//setInitExportDataNoMultistage( detail,grid.columns,"已结算工单明细表导出");
	}
	
}