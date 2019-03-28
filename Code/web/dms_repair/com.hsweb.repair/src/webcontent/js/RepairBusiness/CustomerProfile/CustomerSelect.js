/**
 * Created by Administrator on 2018/3/19.
 */
var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
$(document).ready(function()
{
    init();

    document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27))  {  //ESC
            onCancel();
        }
     
    }
    nui.get("key").focus();
    grid.on("rowdblclick",function(e){
    	onOk();
	});
});
var grid = null;
var gridUrl = baseUrl+"com.hsapi.repair.repairService.svr.queryCustomerWithContactList.biz.ext";
var queryForm = null;
var identityTypeHash = {
	    "060301":"车主",
	    "060302":"车管",
	    "060303":"司机",
	    "060304":"其他"
};
function init()
{
    grid = nui.get("datagrid1");
    grid.setUrl(gridUrl);
    queryForm = new nui.Form("#queryForm");
    grid.on("drawcell",function(e){
         switch (e.field) {
             case "identity":
            	 e.cellHtml = identityTypeHash[e.value];
                 break;
        }
    });

    var keyList = [
        {
            id:"lcarNo",
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
            id:"carVin",
            text:"车架号(VIN)"
        },
        {
            id:"mobile",
            text:"手机号码"
        }
    ];
    nui.get("key").setData(keyList);
}
function setCarNo(carNo){
	mini.get("setValue").setValue(carNo);
	onSearch();
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
    params.isDisabled = 0;
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
        width:560,
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

function onenterSearch(){
	onSearch();
}
