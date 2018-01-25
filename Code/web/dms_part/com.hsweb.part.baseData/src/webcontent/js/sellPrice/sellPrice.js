/**
 * Created by Administrator on 2018/1/24.
 */
var baseUrl = "";
var gridUrl = baseUrl+"";
var grid = null;
$(document).ready(function(v)
{
    grid = nui.get("datagrid1");
    grid.setUrl(gridUrl);
    //console.log("xxx");
});
function onSearch(){
    search();
}
function search()
{
    var param = getSearchParam();
    doSearch(param);
}
function getSearchParam(){
    var param = {};
    param.brand = nui.get("brand");
    param.key = nui.get("key");
    return param;
}
function doSearch(params)
{
    grid.load(params);
}