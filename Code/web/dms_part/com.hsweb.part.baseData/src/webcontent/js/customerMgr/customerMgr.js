/**
 * Created by Administrator on 2018/1/23.
 */
var baseUrl = "";
var gridUrl = baseUrl+"";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var grid = null;
$(document).ready(function(v)
{
    grid = nui.get("datagrid1");
    grid.setUrl(gridUrl);
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
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

}
function doSearch(params)
{
    grid.load(params);
}
function advancedSearch()
{
    advancedSearchWin.show();
    advancedSearchForm.clear();
    if(advancedSearchFormData)
    {
        advancedSearchForm.setData(advancedSearchFormData);
    }
}
function onAdvancedSearchOk()
{
    var searchData = advancedSearchForm.getData();
    advancedSearchWin.hide();
    doSearch(searchData);
}
function onAdvancedSearchCancel(){
    advancedSearchForm.clear();
    advancedSearchWin.hide();
}

function addCustomer()
{
    nui.open({
        targetWindow: window,
        url: "com.hsweb.part.baseData.customerAdd.flow",
        title: "客户资料", width: 500, height: 560,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {

        },
        ondestroy: function (action)
        {

        }
    });
}

