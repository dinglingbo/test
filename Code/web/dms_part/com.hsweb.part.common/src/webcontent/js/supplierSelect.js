/**
 * Created by Administrator on 2018/1/23.
 */
var baseUrl = window._rootUrl||"";
var gridUrl = baseUrl+"";
var treeUrl = baseUrl+"";

var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var grid = null;
var tree = null;
$(document).ready(function(v)
{
    grid = nui.get("datagrid1");
    grid.setUrl(gridUrl);
    tree = nui.get("tree1");
  //  tree.setUrl(gridUrl);
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
function getSearchParam()
{
    var params = {};
    params.code = nui.get("code").getValue();
    params.name = nui.get("name").getValue();
    params.phone = nui.get("phone").getValue();
    params.type = nui.get("type").getValue();
    params.isDisabled = nui.get("isDisabled").getValue();
    return params;
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
    console.log(searchData);
    doSearch(searchData);
}
function onAdvancedSearchCancel(){
    advancedSearchForm.clear();
    advancedSearchWin.hide();
}

var resultData = {};
function onOk()
{
    var node = grid.getSelected();
    console.log(node);
    resultData = {
        node:node
    };
    CloseWindow("ok");
}
function getData(){
    return resultData;
}
function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}


