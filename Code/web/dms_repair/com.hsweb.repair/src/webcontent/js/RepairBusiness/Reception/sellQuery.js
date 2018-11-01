var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
var mainGrid = null;
var mainGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext";
var getRpsPartUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsMainPart.biz.ext";
var beginDateEl = null;
var endDateEl = null;
var statusList = [{id:"0",name:"车牌号"},{id:"1",name:"VIN码"},{id:"2",name:"客户名称"},{id:"3",name:"手机号"}];
var brandList = [];
var brandHash = {};
var servieTypeList = [];
var servieTypeHash = {};
var advancedMore = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var editFormDetail = null;
var innerPartGrid = null;
var mainTabs = null;
var settleWin = null;

$(document).ready(function ()
{
    mainGrid = nui.get("mainGrid");
    mainGrid.setUrl(mainGridUrl);
    beginDateEl = nui.get("sRecordDate");
    endDateEl = nui.get("eRecordDate");
    var date = new Date();
    var sdate = new Date();
    sdate.setMonth(date.getMonth()-3);
    endDateEl.setValue(date);
    beginDateEl.setValue(sdate);
    editFormDetail = document.getElementById("editFormDetail");
    innerPartGrid = nui.get("innerPartGrid");
    innerPartGrid.setUrl(getRpsPartUrl);
    
    mainTabs = nui.get("mainTabs");
	settleAccountGrid = nui.get("settleAccountGrid");
	settleWin = nui.get("settleWin");
    mainGrid.on("drawcell", function (e) {
        if (e.field == "status") {
            e.cellHtml = statusHash[e.value];
        }else if(e.field == "isSettle"){
            if(e.value == 1){
                e.cellHtml = "已结算";
            }else{
                e.cellHtml = "未结算";
            }
        }
    });

    innerPartGrid.on("drawcell", function (e) {
        var record = e.record;
        switch (e.field) {
            case "partName":
                var cardDetailId = record.cardDetailId||0;
                if(cardDetailId>0){
                    e.cellHtml = e.value + "<font color='red'>(预存)</font>";
                }
                break;
            case "rate":
                var value = e.value||"";
                if(value){
                    e.cellHtml = e.value + '%';
                }
                break;
            default:
                break;
        }
    });  
    quickSearch(4);
});
var statusHash = {
    "0" : "草稿",
    "1" : "待出库",
    "2" : "已出库",
    "3" : "待结算",
    "4" : "已结算",
    "5" : "全部"
    
};

function clear(){
    advancedSearchForm.setData([]); 
    beginDateEl.setValue(getMonthStartDate());
    endDateEl.setValue(addDate(getMonthEndDate(), 1));
}
function onShowRowDetail(e) {
    var row = e.record;
    
    //将editForm元素，加入行详细单元格内
    var td = mainGrid.getRowDetailCellEl(row);
    td.appendChild(editFormDetail);
    editFormDetail.style.display = "";

    innerPartGrid.setData([]);
    
    var serviceId = row.id;
    innerPartGrid.load({
    	serviceId:serviceId,
        token: token
    });
}
function quickSearch(type){
    var params = getSearchParam();
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
            queryname = "本年";
            break;
        case 11:
            params.lastYear = 1;
            params.startDate = getPrevYearStartDate();
            params.endDate = getPrevYearEndDate();
            queryname = "上年";
            break;
        default:
            break;
    }
    beginDateEl.setValue(params.startDate);
    endDateEl.setValue(params.endDate);
    currType = type;
    var menunamedate = nui.get("menunamedate");
    menunamedate.setText(queryname);
    doSearch(params);
}
function onSearch()
{
    var params = {};
   /* var value = nui.get("carNo-search").getValue()||"";
    value = value.replace(/\s+/g, "");
    if(!value){
        showMsg("请输入查询条件!","W");
        return;
    }*/
//    var menunamestatus = nui.get("menunamestatus");
//    var title = menunamestatus.getText();
//    switch (title) {
//    case "草稿":
//    	params.status = 0;
//        break;
//    case "待出库":
//        params.status = 1;  //报价
//        break;
//    case "已出库":
//        params.status = 2;  //施工
//        break;
//    case "待结算":
//    	params.isSettle = 0;
//        break;
//    case "已结算":
//        params.status = 2;
//        params.isSettle = 1;
//        break;
//    default:
//        break;
//  }
    doSearch(params);
}
function doSearch(params) {
    var gsparams = getSearchParam();
//    gsparams.status = params.status;
//    gsparams.isSettle = params.isSettle;
   
    //洗美
    //gsparams.billTypeId = 2;
    
    mainGrid.load({
        token:token,
        params: gsparams
    });
}
function getSearchParam() {
    var params = {};
    params.sRecordDate = beginDateEl.getValue();
    params.eRecordDate = endDateEl.getValue();
    params.isSettle=1;
    var type = nui.get("search-type").getValue();
    var typeValue = nui.get("carNo-search").getValue();
    if(type==0){
        params.carNo = typeValue;
    }else if(type==1){
        params.vin = typeValue;
    }else if(type==2){
        params.name = typeValue;
    }else if(type==3){
        params.mobile = typeValue;
    }
    
    return params;
}


