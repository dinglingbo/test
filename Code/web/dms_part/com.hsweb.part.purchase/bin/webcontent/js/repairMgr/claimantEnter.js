/**
 * Created by Administrator on 2018/3/7.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"";
var basicInfoForm = null;
var rightGrid = null;

var storehouseHash = {};
var billTypeIdHash = {};
var settTypeIdHash = {};
var outTypeIdHash = {};
var partBrandIdHash = {};
$(document).ready(function(v)
{
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    rightGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    //console.log("xxx");
});
var currType = 2;
function quickSearch(type){
    var params = {};
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
            params.auditStatus = 1;
            break;
        case 8:
            params.postStatus = 1;
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
    params.outTypeId = '050202';//销售出库
    rightGrid.load({
        params:params
    });
}