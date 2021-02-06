/**
 * Created by Administrator on 2018/1/24.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var gridUrl = baseUrl+"com.hsapi.part.purchase.svr.getSellPriceList.biz.ext";
var grid = null;

var brandList = [
    {
        id:"AUDI",
        text:"AUDI"
    },
    {
        id:"BENZ",
        text:"BENZ"
    },
    {
        id:"BMW",
        text:"BMW"
    },
    {
        id:"LAND-ROVER",
        text:"LAND-ROVER"
    },
    {
        id:"PORSCHE",
        text:"PORSCHE"
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