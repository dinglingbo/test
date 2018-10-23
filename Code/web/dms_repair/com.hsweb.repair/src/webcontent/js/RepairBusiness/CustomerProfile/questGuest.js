/**
 * Created by Administrator on 2018/3/17.
 */
var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var grid = null;
var gridUrl = baseUrl+"com.hsapi.repair.repairService.svr.queryCustomerList.biz.ext";
var queryForm = null;


$(document).ready(function(v){
    grid = nui.get("datagrid1");
    grid.setUrl(gridUrl);
    grid.on("drawcell",onDrawCell);
    queryForm = new nui.Form("#queryForm");

    init();

});
function init(){

    var hash = {};
    nui.mask({
        html: '数据加载中..'
    });


        nui.unmask();
        onSearch();



}


 
function doSearch(params)
{
    grid.load({
        token:token,
        params:params
    });
}

function onSearch()
{
    var params = queryForm.getData();
    params.mobile=document.getElementsByName('mobile')[0].value;
    doSearch(params);
}


function add()
{
    addOrEditCustomer();
}

function onchoice() {
    var row = grid.getSelected();
    if (row)
    {
        resultData = {
                guest:row
            };

                CloseWindow(resultData);
    } else {
        showMsg("请选中一条数据", "W");
    }
}

function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}