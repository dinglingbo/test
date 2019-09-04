/**
 * Created by Administrator on 2018/5/5.
 */
var queryUrl =apiPath + sysApi + "/com.hsapi.system.tenant.carCoin.querySysCoinRecord.biz.ext";
var statusList = [{id:"0",name:"全部"},{id:"1",name:"功能购买"},{id:"2",name:"充值链车币"},{id:"3",name:"调用接口"},{id:"4",name:"赠送链车币"}];
var mainGrid = null;
var beginDateEl = null;
var endDateEl = null;


$(document).ready(function(v) {
	mainGrid = nui.get("mainGrid");
	mainGrid.setUrl(queryUrl);

	beginDateEl = nui.get("beginDate");
	endDateEl = nui.get("endDate");

	beginDateEl.setValue(getMonthStartDate());
	endDateEl.setValue(addDate(getMonthEndDate(), 1));
	quickSearch(2);

});

function quickSearch(type){
	var params = getSearchParam();
    var querysign = 1;
    var queryname = "本日";
    switch (type)
    {
        case 0:
            params.today = 1;
            params.startDate = getNowStartDate();
            params.endDate = addDate(getNowEndDate(), 1);
            querysign = 1;
            queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.startDate = getPrevStartDate();
            params.endDate = addDate(getPrevEndDate(), 1);
            querysign = 1;
            queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.startDate = getWeekStartDate();
            params.endDate = addDate(getWeekEndDate(), 1);
            querysign = 1;
            queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.startDate = getLastWeekStartDate();
            params.endDate = addDate(getLastWeekEndDate(), 1);
            querysign = 1;
            queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.startDate = getMonthStartDate();
            params.endDate = addDate(getMonthEndDate(), 1);
            querysign = 1;
            queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.startDate = getLastMonthStartDate();
            params.endDate = addDate(getLastMonthEndDate(), 1);
            querysign = 1;
            queryname = "上月";
            break;
        case 10:
            params.thisYear = 1;
            params.startDate = getYearStartDate();
            params.endDate = getYearEndDate();
            querysign = 1;
            queryname = "本年";
            break;
        case 11:
            params.lastYear = 1;
            params.startDate = getPrevYearStartDate();
            params.endDate = getPrevYearEndDate();
            querysign = 1;
            queryname = "上年";
            break;      
        default:
            break;
    }
    beginDateEl.setValue(params.startDate);
    endDateEl.setValue(addDate(params.endDate,-1));
    currType = type;
    if(querysign == 1){
        var menunamedate = nui.get("menunamedate");
        menunamedate.setText(queryname);    
    }
    doSearch(params);
}

function getSearchParam(){
	var params = {};
	params.startDate = beginDateEl.getFormValue();
    params.endDate = addDate(endDateEl.getValue(),1);
    params.productName = nui.get("productName").getValue();
    if(nui.get("search-type").getValue()!=0){
    	params.type = nui.get("search-type").getValue();
    	
    }
    return params;
}

function onSearch(){
	var params=getSearchParam();
	doSearch(params);
}
function doSearch(params) {
	mainGrid.load({
		params:params,
		token : token
	});
}


function onDrawCell(e){
	var row = e.row;
    switch (e.field) {
        case "callStatus":
            if (e.value==1) {
            	e.cellHtml = "成功";
            } else {
            	e.cellHtml = "失败";
            }
            break;    
        case "costCoin":
            	e.cellHtml = e.value*row.dc;
            break;   
        case "orgid":
        	for(var i=0;i<currOrgList.length;i++){
        		if(currOrgList[i].orgid==e.value){
        			e.cellHtml = currOrgList[i].shortName;
        		}
        	}
        break;            
        default:
            break;
    }
}

