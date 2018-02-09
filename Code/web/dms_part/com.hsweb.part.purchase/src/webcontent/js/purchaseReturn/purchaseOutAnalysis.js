/**
 * Created by Administrator on 2018/2/7.
 */
var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var grid = null;
var gridUrl = baseUrl+"com.hsapi.part.purchase.svr.queryPurOutAnalysis.biz.ext";
$(document).ready(function(v)
{
    grid = nui.get("datagrid1");
    grid.setUrl(gridUrl);
    quickSearch2(currAtype);
    //console.log("xxx");
});
var currAtype = -1;
function quickSearch2(type)
{
    currAtype = type;
    if($("a[id*='atyp']").length>0)
    {
        $("a[id*='atyp']").css("color","black");
    }
    if($("#atyp"+type).length>0)
    {
        $("#atyp"+type).css("color","blue");
    }
    quickSearch(currType);
}
var currType = 10;
function quickSearch(type){
    var params = {};
    currType = type;
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
        case 12:
            if(nowMonth<3)
            {
                params.quarter = 1;
            }
            if(2<nowMonth && nowMonth<6){
                params.quarter = 2;
            }
            if(5<nowMonth && nowMonth<9){
                params.quarter = 3;
            }
            if(nowMonth>8){
                params.quarter = 4;
            }
            params.thisYear = 1;
            break;
        case 13:
            var now = new Date();
            var nowMonth = now.getMonth();
            if(nowMonth<3)
            {
                params.quarter = 4;
                params.lastYear = 1;
            }
            if(2<nowMonth && nowMonth<6){
                params.quarter = 1;
                params.thisYear = 1;
            }
            if(5<nowMonth && nowMonth<9){
                params.quarter = 2;
                params.thisYear = 1;
            }
            if(nowMonth>8){
                params.quarter = 3;
                params.thisYear = 1;
            }
            break;
        default:
            break;
    }
    switch (currAtype)
    {
        case 0:
            params.groupbyGuestId = 1;
            grid.updateColumn(grid.getColumn(2), {header: "供应商"});
            break;
        case 1:
            params.groupbyPartId = 1;
            break;
        case 2:
            params.groupbyPartId = 1;
            break;
        default:
            params.groupbyPartId = 1;
            break;
    }
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
    params.outTypeId = '050201';
    grid.load({
        params:params
    },function(){
        //rightGrid.mergeColumns(["enterId"]);
    });
}