/**
 * Created by steven on 2018/1/31.
 */
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var gridUrl = baseUrl + "com.hsapi.system.employee.employeeMgr.employeeQuery.biz.ext";
nui.parse();
var grid = nui.get("datagrid1");

function search() {
    var param = getSearchParam();
    doSearch(param);
}

function getSearchParam() {
    var params = {};
    params.name = nui.get("name").getValue();
    params.mobile = nui.get("mobile").getValue();

    return params;
}

function doSearch(params) {
    grid.load({
        params:params
    });
}

function onDrawCell(e) {
    switch (e.field) {
        case "sex":
            e.cellHtml = e.value== 1 ? "男" : "女";
        break;
    }
}

