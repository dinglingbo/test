var baseUrl = apiPath + cloudPartApi + "/";
var packGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.paramcrud.queryPJPackList.biz.ext";
var getDetailUrl=baseUrl+"com.hsapi.cloud.part.invoice.svr.queryPjPchsOrderDetailList.biz.ext";
var innnerGridUrl=baseUrl+"com.hsapi.cloud.part.invoice.svr.queryPjSellOrderDetailList.biz.ext";
var basicInfoForm = null;
var packGrid=null;
var innerGrid=null;
var detailGrid=null;

$(document).ready(function(v){
	packGrid=nui.get('packGrid');
	packGrid.setUrl(packGridUrl);
	innerGrid=nui.get('innerGrid');
	innerGrid.setUrl(innnerGridUrl);
	detailGrid =nui.get('detailGrid');
	detailGrid.setUrl(getDetailUrl);
	packGrid.load({params:{},token:token});
});

ar currType = 2;
function quickSearch(type){
    var params = {};
    var querysign = 1;
    var queryname = "本日";
    var querytypename = "未审";
    switch (type)
    {
        case 0:
            params.today = 1;
            params.startDate = getNowStartDate();
            params.endDate = addDate(getNowEndDate(), 1);
            queryname = "本日";
            querysign = 1;
            break;
        case 1:
            params.yesterday = 1;
            params.startDate = getPrevStartDate();
            params.endDate = addDate(getPrevEndDate(), 1);
            queryname = "昨日";
            querysign = 1;
            break;
        case 2:
            params.thisWeek = 1;
            params.startDate = getWeekStartDate();
            params.endDate = addDate(getWeekEndDate(), 1);
            queryname = "本周";
            querysign = 1;
            break;
        case 3:
            params.lastWeek = 1;
            params.startDate = getLastWeekStartDate();
            params.endDate = addDate(getLastWeekEndDate(), 1);
            queryname = "上周";
            querysign = 1;
  
            break;
        case 4:
            params.thisMonth = 1;
            params.startDate = getMonthStartDate();
            params.endDate = addDate(getMonthEndDate(), 1);
            queryname = "本月";
            querysign = 1;
            break;
        case 5:
            params.lastMonth = 1;
            params.startDate = getLastMonthStartDate();
            params.endDate = addDate(getLastMonthEndDate(), 1);
            queryname = "上月";
            querysign = 1;
            break;
        case 6:
            params.auditSign = 0;
            querytypename = "未审";
            querysign = 2;
            params.auditSign = 0;
            break;
        case 7:
            params.auditSign = 1;
            querytypename = "已审";
            querysign = 2;
            params.auditSign = 1;
            break;
        case 8:
            params.postStatus = 1;
            break;
        default:
            params.today = 1;
            params.startDate = getNowStartDate();
            params.endDate = addDate(getNowEndDate(), 1);
            querytypename = "未审";
            params.auditSign = 0;
            break;
    }
    currType = type;
    if(querysign == 1){
        var menunamedate = nui.get("menunamedate");
        menunamedate.setText(queryname);
    }else if(querysign == 2){
            var menunametype = nui.get("menunametype");
            menunametype.setText(querytypename);
    }
    doSearch(params);
}
function onSearch(){
    search();
}
function search()
{
    var param = getSearchParam();
    doSearch(param);
}
function getSearchParam(){
    var params = {};
    params.guestId = nui.get("searchGuestId").getValue();
    return params;
}

function doSearch(params) 
{
    //目前没有区域销售订单，采退受理  params.enterTypeId = '050101';
	packGrid.load({
        params : params,
        token : token
    }, function() {
        //onLeftGridRowDblClick({});
  
    });
    //默认新增
}