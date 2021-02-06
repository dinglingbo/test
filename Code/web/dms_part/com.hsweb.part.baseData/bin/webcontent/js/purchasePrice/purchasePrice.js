/**
 * Created by Administrator on 2018/1/24.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var gridUrl = baseUrl+"com.hsapi.part.purchase.svr.getGoodsPriceList.biz.ext";
var grid = null;

var brandList = [
    {
        id:"宝马",
        text:"宝马"
    },
    {
        id:"奔驰",
        text:"奔驰"
    },
    {
        id:"奥迪",
        text:"奥迪"
    },
    {
        id:"保时捷",
        text:"保时捷"
    },
    {
        id:"陆虎",
        text:"陆虎"
    }
];
$(document).ready(function(v)
{
    grid = nui.get("datagrid1");
    grid.setUrl(gridUrl);
    grid.on("beforeload",function(e){
        e.data.token = token;
    });

    nui.get("brand").setData(brandList);
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
    param.CarPlate = nui.get("brand").getValue();
    param.keywords = nui.get("key").getValue();
    return param;
}
function doSearch(params)
{
    grid.load(params);
}