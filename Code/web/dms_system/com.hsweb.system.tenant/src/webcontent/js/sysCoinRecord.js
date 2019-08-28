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
        case "content":
            if (row.dc==1) {
            	//1功能购买，2充值，3调用接口，4赠送
                if(row.type == 1){
                    e.cellHtml = "购买产品："+row.productName+",成功";
                }else if(row.type == 2){
                	 e.cellHtml = "充值链车币成功";
                }else if(row.type == 3){
                	 e.cellHtml = row.productName+"，扣费成功";
                }else if(row.type == 4){
                	 e.cellHtml = row.productName+"赠送成功";
                }
            } else {
            	//1功能购买，2充值，3调用接口，4赠送
                if(row.type == 1){
                    e.cellHtml = "产品："+row.productName+"到期";
                }else if(row.type == 2){
                	 e.cellHtml = "扣减链车币成功";
                }else if(row.type == 3){
                	 e.cellHtml = row.productName+"，扣费成功";
                }else if(row.type == 4){
                	 e.cellHtml = row.productName+"扣减成功";
                }
            }
            break;             
        default:
            break;
    }
}

