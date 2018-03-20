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
    queryForm = new nui.Form("#queryForm");


});
function getSearchParams()
{
    var params = queryForm.getData();
    return params;
}
function onSearch()
{
    var params = getSearchParams();
    doSearch(params);
}
function doSearch(params)
{
    grid.load({
        params:params
    });
}

function addOrEditCustomer(guest)
{
    var title = "新增客户资料";
    if(guest)
    {
        title = "修改客户资料";
    }
    nui.open({
        url: "com.hsweb.repair.DataBase.AddEditCustomer.flow",
        title: title, width: 500, height: 630,
        onload: function () {
            var iframe = this.getIFrameEl();
            var params = {};
            if(guest)
            {
                params.guest = guest;
            }
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action)
        {
            if("ok" == action)
            {
                grid.reload();
            }
        }
    });
}
function add()
{
    addOrEditCustomer();
}
function edit() {
    var row = grid.getSelected();
    if (row)
    {
        addOrEditCustomer(row);
    } else {
        nui.alert("请选中一条数据", "系统提示");
    }
}

function amalgamate() {
    nui.open({
        url: "Amalgamate.jsp",
        title: "资料合并", width: 600, height: 400,
        onload: function () {
            var iframe = this.getIFrameEl();
            var data = {pageType: "amalgamate"};
            iframe.contentWindow.setData(data);
        },

        ondestroy: function (action) {
            grid.reload();
        }
    });
}

function split() {
    nui.open({
        url: "Split.jsp",
        title: "资料拆分", width: 800, height: 430,
        onload: function () {
            var iframe = this.getIFrameEl();
            var data = {pageType: "split"};
            iframe.contentWindow.setData(data);
        },

        ondestroy: function (action) {
            grid.reload();
        }
    });
}

function history() {
    nui.open({
        url: "../../common/History.jsp",
        title: "维修历史", width: 850, height: 640,
        onload: function () {
            var iframe = this.getIFrameEl();
            var data = {pageType: "history"};
            iframe.contentWindow.setData(data);
        },

        ondestroy: function (action) {
            grid.reload();
        }
    });
}
function onMore() {
    nui.open({
        url: "./subpage/More.jsp",
        title: "高级查询", width: 450, height: 300,
        onload: function () {
            var iframe = this.getIFrameEl();
            var data = {pageType: "more"};
            iframe.contentWindow.setData(data);
        },

        ondestroy: function (action) {
            grid.reload();
        }
    });
}

//重新刷新页面
function refresh() {
    var form = new nui.Form("#form1");
    var json = form.getData(false, false);
    grid.load(json);
    nui.get("update").enable();
}
//查询
function search() {
    var form = new nui.Form("#form1");
    var json = form.getData(false, false)
    grid.load(json);
}
//重置查询条件
function reset() {
    var form = new nui.Form("#form1");
    grid.reset();
}
//enter键触发
function onKeyEnter(e) {
    search();
}
//选择列（判定，大于一编辑禁用）
function selectionChanged() {
    var rows = grid.getSelecteds();
    if (rows.length > 1) {
        nui.get("update").disable();
    } else {
        nui.get("update").enable();
    }
}
function onIsDisabled(e) {
    if (e.value == 1) return "禁用";
    if (e.value == 0) return "启用";
}
