/**
 * Created by Administrator on 2018/2/1.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
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
    rightGrid.on("beforeload",function(e){
        e.data.token = token;
    });
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
                if(list[i].code == beginList[j].code)
                {
                    list[i].beginCount = beginList[j].balaAmt;
                    break;
                }
            }
            list[i].currCount = 0;
            for(j=0;j<currList.length;j++)
            {
                if(list[i].code == currList[j].code)
                {
                    list[i].currCount = currList[j].balaAmt;
                    break;
                }
            }
            list[i].endCount = 0;
            for(j=0;j<endList.length;j++)
            {
                if(list[i].code == endList[j].code)
                {
                    list[i].endCount = endList[j].balaAmt;
                    break;
                }
            }
        }
        rightGrid.setData(list);
    });
    var countWayEl = nui.get("countWay");
    countWayEl.on("valuechanged",function(){
        quickSearch(currType);
    });
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    //console.log("xxx");
    getStorehouse(function(data)
    {
        var storehouse = data.storehouse||[];
        //   nui.get("storeId").setData(storehouse);
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
    params.org = 1;
    if(countWay == 2)
    {
    	delete params.org;
        params.partBrand = 1;
    }
    else if(countWay == 3)
    {
    	delete params.org;
        params.carTypeIdF = 1;
    }
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
    params.orgid = currOrgid;
    rightGrid.load({
        params:params
    });
}
function advancedSearch()
{
    advancedSearchWin.show();
  //  advancedSearchForm.clear();
    if(advancedSearchFormData)
    {
        advancedSearchForm.setData(advancedSearchFormData);
    }
}
function onAdvancedSearchOk()
{
    var searchData = advancedSearchForm.getData();
    var params = getSearchParams();
    if(searchData.startDate)
    {
        params.startDate = searchData.startDate.substr(0,10);
    }
    if(searchData.endDate)
    {
        params.endDate = searchData.endDate.substr(0,10);
    }
    advancedSearchWin.hide();
    doSearch(params);
}
function onAdvancedSearchCancel(){
 //   advancedSearchForm.clear();
    advancedSearchWin.hide();
}
