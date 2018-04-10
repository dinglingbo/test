/**
 * Created by Administrator on 2018/3/19.
 */
var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
$(document).ready(function()
{
    init();
});
var grid = null;
var gridUrl = baseUrl+"com.hsapi.repair.repairService.svr.queryCustomerWithContactList.biz.ext";
var queryForm = null;
function init()
{
    grid = nui.get("datagrid1");
    grid.setUrl(gridUrl);
    queryForm = new nui.Form("#queryForm");

    var keyList = [
        {
            id:"carNo",
            text:"车牌号"
        },
        {
            id:"guestFullName",
            text:"客户名称"
        },
        {
            id:"carModel",
            text:"车型"
        },
        {
            id:"underpanNo",
            text:"底盘号"
        },
        {
            id:"mobile",
            text:"手机号码"
        }
    ];
    nui.get("key").setData(keyList);
}
function getSearchParams()
{
    var par = queryForm.getData();
    var params = {};
    params.value = par.value;
    params[par.key] = par.value;
    if(par.searchArea == 0)
    {
        params.orgid = currOrgid;
    }
    return params;
}
function onSearch()
{
    var params = getSearchParams();
    doSearch(params);
}
function doSearch(params)
{
    if(!params.value)
    {
        nui.alert("请输入查询值");
        return;
    }
    delete params.value;
    grid.load({
    	token:token,
        params:params
    });
}
function addOrEdit(guest)
{
    var title = "新增客户资料";
    if(guest)
    {
        title = "修改客户资料";
    }
    nui.open({
        url:"com.hsweb.repair.DataBase.AddEditCustomer.flow",
        title:title,
        width:500,
        height:630,
        onload:function(){
            var iframe = this.getIFrameEl();
            var params = {};
            if(guest)
            {
                params.guest = guest;
            }
            iframe.contentWindow.setData(params);
        },
        ondestroy:function(action)
        {
            if(action  == "ok")
            {
                grid.reload();
            }
        }
    });
}
function onAdd()
{
    addOrEdit();
}
function onEdit(){
    var row = grid.getSelected();
    if(row) {
        addOrEdit(row);
    }else {
        nui.alert("请选中一条数据", "系统提示");
    }
}
var reusltData = {};
function getData()
{
    return reusltData;
}
function onOk()
{
    var row = grid.getSelected();
    if(row) {
        reusltData.guest = row;
        CloseWindow("ok");
    }else {
        nui.alert("请选中一条数据", "系统提示");
    }
}
//关闭窗口
function CloseWindow(action)
{
    if (window.CloseOwnerWindow)
        return window.CloseOwnerWindow(action);
    else window.close();
}
//取消
function onCancel() {
    CloseWindow("cancel");
}