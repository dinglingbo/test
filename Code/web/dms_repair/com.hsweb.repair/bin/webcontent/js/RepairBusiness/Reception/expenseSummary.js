 var baseUrl = apiPath + repairApi + "/";
var statusList = [{id:"0",name:"车牌号"},{id:"1",name:"客户名称"}];
var mainGrid = null;
var mainGridUrl = baseUrl+"com.hsapi.repair.repairService.query.queryExpenseSummaryList.biz.ext";
var beginDateEl = null;
var endDateEl = null;
var typeIdHash = {};
var plist = [];
var mtAdvisorIdEl = null;
var orgidsEl = null;
$(document).ready(function ()
{
	mainGrid = nui.get("mainGrid"); 
	mainGrid.setUrl(mainGridUrl);
	beginDateEl = nui.get("sRecordDate");
    endDateEl = nui.get("eRecordDate");
	nui.get("search-type").setData(statusList);
	mtAdvisorIdEl = nui.get("mtAdvisorId");
	   //判断是否有兼职门店,是否显示门店选择框
    orgidsEl = nui.get("orgids");
    orgidsEl.setData(currOrgList);
    if(currOrgList.length==1){
    	orgidsEl.hide();
    }else{
    	orgidsEl.setValue(currOrgid);
    }
	var params = {isMain:0};
	svrInComeExpenses(params,function(data) {
	    var list = data.list||{};
		list.forEach(function(v) {
			plist.push(v);
			typeIdHash[v.id] = v;
        });
		nui.get("billTypeList").setData(plist);
		quickSearch(4);
    });
	initMember("mtAdvisorId",function(){
    });
	
	mainGrid.on("drawcell",function(e){
        var record = e.record;
        var uid = record._uid;
		if(e.field=="typeId"){
			var num = parseInt(e.value);
			 e.cellHtml = typeIdHash[num].name;
		}
		if(e.field=="dc"){
		  e.cellHtml = (e.value == 1 ?"应收":"应付"); 
		}
		if(e.field == "expenseOptBtn"){
			var s =  '<a class="optbtn" href="javascript:openDetail(\'' + uid + '\')">查看明细</a>'; 
			e.cellHtml = s;
		}
	});
	
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
    params.dc = nui.get("typeList").getValue();
    params.typeId = nui.get("billTypeList").getValue();
    params.mtAdvisorId = nui.get("mtAdvisorId").getValue();
    var orgidsElValue = orgidsEl.getValue();
    if(orgidsElValue==null||orgidsElValue==""){
    	 params.orgids =  currOrgs;
    }else{
    	params.orgid=orgidsElValue;
    }
    var type = nui.get("search-type").getValue();
    var typeValue = nui.get("carNo-search").getValue();
    if(type==0){
        params.carNo = typeValue;
    }else if(type==1){
        params.name = typeValue;
    }
    return params;
}
function onSearch()
{
	var params=getSearchParams();
    doSearch(params);
} 
function doSearch(params) {
    mainGrid.load({
        token:token, 
        params: params
    });
}


function openDetail(row_uid){
	var row = mainGrid.getRowByUID(row_uid);
	var typeId = row.typeId || 0;
	if(typeId ){
		var data = {};
		data.typeId = typeId;
		data.sRecordDate = beginDateEl.getFormValue();
		data.eRecordDate = addDate(endDateEl.getFormValue(),1);
		var item={};
		item.id = "openDetail";
	    item.text = "费用明细表";
		item.url =webPath + contextPath + "/repair/RepairBusiness/Reception/expenseDetail.jsp?token="+token;
		item.iconCls = "fa fa-file-text";
		window.parent.parent.activeTabAndInit(item,data);
	}
	/*nui.open({
		url :  webPath + contextPath + "/repair/RepairBusiness/Reception/expenseDetail.jsp?token="+token,
		title : "费用明细",
		width : 600,
		height : 630,
		allowResize: false,
		onload : function() {
			var iframe = this.getIFrameEl(); 
			var data = {
					typeId : row.typeId
			};
			iframe.contentWindow.setData(data);
		},
		ondestroy : function(action) {
			
		}
		
		})*/
}

function onExport(){
	var detail = nui.clone(mainGrid.getData());
//多级
	//exportMultistage(mainGrid.columns)
//单级
       exportNoMultistage(mainGrid.columns)
/*	for(var i=0;i<detail.length;i++){
		var num = parseInt(detail[i].typeId);
		detail[i].typeId = typeIdHash[num].name;
		if(detail[i].dc==1){
			detail[i].dc="应收";
		}else{
			detail[i].dc="应付";
		}
		
	}*/
	if(detail && detail.length > 0){
//多级表头类型
		//setInitExportData( detail,mainGrid.columns,"费用汇总表导出");
//单级表头类型  与上二选一
setInitExportDataNoMultistage( detail,mainGrid.columns,"费用汇总表导出");
	}
	
}