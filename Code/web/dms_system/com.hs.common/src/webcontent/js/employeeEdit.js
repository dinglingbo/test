/**
 * Created by steven on 2018/1/31.
 */

var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var gridUrl = baseUrl + "com.hsapi.system.employee.employeeMgr.employeeQuery.biz.ext";
nui.parse();

var sexlist = [{id:0, name:"女"}, {id:1, name:"男"}];
var dimissionlist = [{id:0, name:"在职"}, {id:1, name:"离职"}];

function SetData(data) {
	alter(1);
}