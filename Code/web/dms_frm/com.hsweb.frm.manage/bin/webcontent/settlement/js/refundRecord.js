/**
 * Created by Administrator on 2018/4/27.
 */                                       

var queryFormUrl = apiPath + repairApi + "/com.hsapi.repair.baseData.cardTimes.queryRefundRecord.biz.ext";

var grid = null;
var queryForm = null;
var statusList = [{id:"0",name:"客户名称"},{id:"1",name:"车牌号"},{id:"2",name:"客户电话"}];
var billType = [{id:"0",name:"全部退款"},{id:"1",name:"计次卡退款"},{id:"2",name:"储值卡退款"}];
var hash = new Array("计次卡退款","储值卡退款");
var beginDateEl = null;
var endDateEl = null;
$(document).ready(function (v)
{
    grid  = nui.get("datagrid1");
    queryForm = new nui.Form("#queryForm");
    var date = new Date();
    var sdate = new Date();
    sdate.setMonth(date.getMonth()-3);
   
    beginDateEl = nui.get("sOutDate");
	endDateEl = nui.get("eOutDate");
    beginDateEl.setValue(getMonthStartDate());
    endDateEl.setValue(addDate(getMonthEndDate(), 1));
    onSearch();
    
    grid.setUrl(queryFormUrl);
    
	  var filter = new HeaderFilter(grid, {     
	        columns: [
	            { name: 'code' },
	            { name: 'fullName' },
		            { name: 'carNo' },
	            { name: 'mobile' },
	            { name: 'recorder' },
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
    quickSearch(4);
});

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
    
    beginDateEl.setValue(params.sOutDate);
    endDateEl.setValue(addDate(params.eOutDate,-1));
    if(querysign == 1){
    	var menunamedate = nui.get("menunamedate");
    	menunamedate.setText(queryname); 	
    }
    
    doSearch(params);
}
    
function onSearch()
{
    doSearch();
}
function doSearch() {
    var gsparams = getSearchParam();
    grid.load({
        token:token,
        params: gsparams
    });
}
function getSearchParam() {
    var params = {};
    params.sOutDate = nui.get("sOutDate").getValue();
    params.eOutDate = addDate(endDateEl.getValue(),1);  
    var type = nui.get("search-type").getValue();
    var typeValue = nui.get("carNo-search").getValue();
    if(type==0){
        params.fullName = typeValue||"";
    }else if(type==1){
        params.carNo = typeValue||"";
    }else if(type==2){
        params.mobile = typeValue||"";
    }
    var billType = nui.get("search-billType").getValue();
    if(billType==0){
    	
    }else if(billType==1){
    	params.type=1;
    }else if(billType==2){
    	params.type=2;
    }
    return params;
}




 function onDrawCell(e)
  {

    switch (e.field)
    {
        

    case "type":
    	e.cellHtml = hash[e.value-1];
        break; 

    default:
        break;
    }
}


 

 function onExport(){
		var detail = grid.getData();
		
		for(var i=0;i<detail.length;i++){
			detail[i].type=hash[detail[i].type-1];
		}
	//多级
		//exportMultistage(datagrid1.columns)
	//单级
	       exportNoMultistage(grid.columns)
		if(detail && detail.length > 0){
	//多级表头类型
			//setInitExportData( detail,grid.columns,"客户计次卡明细表导出");
	//单级表头类型  与上二选一
	setInitExportDataNoMultistage( detail,grid.columns,"客户退款明细表导出");
		}
		
	}

