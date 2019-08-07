 var baseUrl = apiPath + repairApi + "/";
var statusList = [{id:"0",name:"车牌号"},{id:"1",name:"客户名称"}];
var mainGrid = null;
var mainGridUrl = baseUrl+"com.hsapi.repair.repairService.query.queryExpenseDetailList.biz.ext";
var beginDateEl = null;
var endDateEl = null;
var typeIdHash = {};
var plist = [];
var mtAdvisorIdEl = null;
$(document).ready(function ()
{
	mainGrid = nui.get("mainGrid"); 
	mainGrid.setUrl(mainGridUrl);
	beginDateEl = nui.get("sRecordDate");
    endDateEl = nui.get("eRecordDate");
	nui.get("search-type").setData(statusList);
	mtAdvisorIdEl = nui.get("mtAdvisorId");
	initMember("mtAdvisorId",function(){
    });
	
	/*var params = {isMain:0};
	svrInComeExpenses(params,function(data) {
	    var list = data.list||{};
		list.forEach(function(v) {
			plist.push(v);
			typeIdHash[v.id] = v;
        });
		nui.get("billTypeList").setData(plist);
		quickSearch(4);
    });*/
	mainGrid.on("drawcell",function(e){
		if(e.field=="typeId"){
			var num = parseInt(e.value);
			 e.cellHtml = typeIdHash[num].name;
		}
		if(e.field=="dc"){
		  e.cellHtml = (e.value == 1 ?"应收":"应付"); 
		}
		if(e.field == "expenseOptBtn"){
			var uid = null;
			var s =  '<a class="optbtn" href="javascript:openExpense(\'' + uid + '\')">查看明细</a>'; 
			e.cellHtml = s;
		}
	});
	var filter = new HeaderFilter(mainGrid, {
        columns: [
            { name: 'contactName' },
	        { name: 'mtAdvisor' },
            { name: 'carNo' },
            {name: 'serviceCode'},
            {name: 'amt'}
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
    //params.typeId = typeId;
    params.mtAdvisorId = nui.get("mtAdvisorId").getValue();
    params.remark = nui.get("remark").getValue();
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
    params.orgid = currOrgid;
    mainGrid.load({
        token:token, 
        params: params
    });
}

function setInitData(data){
	var typeId = null;
	beginDateEl.setValue(data.sRecordDate);
	endDateEl.setValue(addDate(data.eRecordDate,-1));
	var params=getSearchParams();
	typeId = data.typeId;
	params.typeId = typeId;
	var params2 = {isMain:0};
	svrInComeExpenses(params2,function(data) {
	    var list = data.list||{};
		list.forEach(function(v) {
			plist.push(v);
			typeIdHash[v.id] = v;
        });
		nui.get("billTypeList").setData(plist);
		nui.get("billTypeList").setValue(typeId)
		doSearch(params);
    });
	
}

function onExport(){
	
	//var billTypeIdHash = [{name:"综合",id:"0"},{name:"检查",id:"1"},{name:"洗美",id:"2"},{name:"销售",id:"3"},{name:"理赔",id:"4"},{name:"退货",id:"5"}];

	var detail = nui.clone(mainGrid.getData());
	
	for(var i=0;i<detail.length;i++){
		for(var j=0;j<plist.length;j++){
			if(detail[i].typeId==plist[j].id){
				detail[i].typeId=plist[j].name;
			}
			if(detail[i].typeId==1){
				detail[i].dc="应收";
			}else{
				detail[i].dc="应付";	
			}
		}
	}
		
	if(detail && detail.length > 0){
		setInitExportData(detail);
	}
}

function setInitExportData( detail){

    var tds = '<td  colspan="1" align="left">[serviceCode]</td>' +
        "<td  colspan='1' align='left'>[contactName]</td>" +
        "<td  colspan='1' align='left'>[carNo]</td>" +
        "<td  colspan='1' align='left'>[outDate]</td>" +
        "<td  colspan='1' align='left'>[mtAdvisor]</td>" +
        
        "<td  colspan='1' align='left'>[dc]</td>" +
        "<td  colspan='1' align='left'>[typeId]</td>" +
        "<td  colspan='1' align='left'>[guestName]</td>" +
        "<td  colspan='1' align='left'>[amt]</td>" +
        "<td  colspan='1' align='left'>[remark]</td>";
        
       
        
    var tableExportContent = $("#tableExportContent");
    tableExportContent.empty();
    for (var i = 0; i < detail.length; i++) {
        var row = detail[i];
        if(row.id){
            var tr = $("<tr></tr>");
            tr.append(tds.replace("[serviceCode]", detail[i].serviceCode?detail[i].serviceCode:"")
                         .replace("[contactName]", detail[i].contactName?detail[i].contactName:"")
                         .replace("[carNo]", detail[i].carNo?detail[i].carNo:"")
                         .replace("[outDate]", nui.formatDate(detail[i].outDate?detail[i].outDate:"",'yyyy-MM-dd HH:mm'))
                         
                         .replace("[mtAdvisor]", detail[i].mtAdvisor?detail[i].mtAdvisor:"")                        
                         .replace("[dc]", detail[i].dc?detail[i].dc:"")
                         .replace("[typeId]", detail[i].typeId?detail[i].typeId:"")                       
                         .replace("[guestName]", detail[i].guestName?detail[i].guestName:"")
                         
                         .replace("[amt]", detail[i].amt?detail[i].amt:0)                        
                         .replace("[remark]", detail[i].remark?detail[i].remark:"") );
                         
            tableExportContent.append(tr);
        }
    }
    method5('tableExcel',"费用明细表导出",'tableExportA');
}
