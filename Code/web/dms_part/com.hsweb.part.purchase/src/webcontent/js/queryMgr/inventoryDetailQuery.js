/**
 * Created by Administrator on 2018/2/1.
 */
var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.part.purchase.svr.queryInventoryDetailList.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var basicInfoForm = null;
var rightGrid = null;

var storehouseHash = {};
var billTypeIdHash = {};
var settTypeIdHash = {};
var outTypeIdHash = {};
$(document).ready(function(v)
{
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    rightGrid.on("preload",function(e)
    {
        console.log(e);
        var result = e.result;
        var beginList = result.beginList;
        var currList = result.currList;
        var endList = result.endList;
        var list = result.list;
        var j;
        for(var i=0;i<list.length;i++)
        {
            list[i].beginCount = 0;
            for(j=0;j<beginList.length;j++)
            {
                if(list[i].partId == beginList[j].partId)
                {
                    list[i].beginCount = beginList[j].balaAmt;
                    break;
                }
            }
            list[i].currCount = 0;
            for(j=0;j<currList.length;j++)
            {
                if(list[i].partId == currList[j].partId)
                {
                    list[i].currCount = currList[j].balaAmt;
                    break;
                }
            }
            list[i].endCount = 0;
            for(j=0;j<endList.length;j++)
            {
                if(list[i].partId == endList[j].partId)
                {
                    list[i].endCount = endList[j].balaAmt;
                    break;
                }
            }
        }
        rightGrid.setData(list);
    });
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    //console.log("xxx");
    getStorehouse(function(data)
    {
        var storehouse = data.storehouse||[];
        nui.get("storeId").setData(storehouse);
        nui.get("storeId").setValue(storehouse[0].id);
        storehouse.forEach(function(v)
        {
            if(v && v.customid)
            {
                storehouseHash[v.customid] = v;
            }
        });
        quickSearch(currType);

    });

});
function getSearchParams(){
    var params = {};

    var countWay = nui.get("countWay").getValue();
    if(countWay == 1)
    {
        params.amt = 1;
    }
    else if(countWay == 2)
    {
        params.qty = 1;
    }
    params.storeId = nui.get("storeId").getValue();
    return params;
}
var currType = 2;
function quickSearch(type){
    var params = getSearchParams();
    switch (type)
    {
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
            params.auditStatus = 0;
            break;
        case 7:
            params.billStatus = 1;
            break;
        case 8:
            params.billStatus = 2;
            break;
        case 10:
            params.thisYear = 1;
            break;
        case 11:
            params.lastYear = 1;
            break;
        default:
            break;
    }
    currType = type;
    if($("a[id*='type']").length>0)
    {
        $("a[id*='type']").css("color","black");
    }
    if($("#type"+type).length>0)
    {
        $("#type"+type).css("color","blue");
    }
    doSearch(params);
}

function doSearch(params)
{
    rightGrid.load({
        params:params
    });
}
function advancedSearch()
{
    advancedSearchWin.show();
//    advancedSearchForm.clear();
    if(advancedSearchFormData)
    {
        advancedSearchForm.setData(advancedSearchFormData);
    }
}
function onAdvancedSearchOk()
{
    var searchData = advancedSearchForm.getData();
    if(searchData.startDate)
    {
        searchData.startDate = searchData.startDate.substr(0,10);
    }
    if(searchData.endDate)
    {
        searchData.endDate = searchData.endDate.substr(0,10);
    }
    advancedSearchWin.hide();
    doSearch(searchData);
}
function onAdvancedSearchCancel(){
//    advancedSearchForm.clear();
    advancedSearchWin.hide();
}