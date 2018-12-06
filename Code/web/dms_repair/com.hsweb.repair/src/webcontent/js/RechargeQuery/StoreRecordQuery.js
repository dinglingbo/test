/**
 * Created by Administrator on 2018/8/8.
 */

var dataList=[{id:"0",text:"客户名称"},{id:"1",text:"卡号"}];
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var grid = null;
var gridUrl = baseUrl + "com.hsapi.repair.repairService.report.queryStoreRecord.biz.ext";
var queryInfoForm = null;
var periodValidity=null;
$(document).ready(function (v)
{
	
  queryInfoForm = new nui.Form("#queryInfoForm").getData(false, false);
  
    grid = nui.get("grid");
    grid.load(queryInfoForm);
    grid.setUrl(gridUrl);
    grid.on("drawcell",onDrawCell);
    getNowFormatDate();
    onSearch();
});


function getSearchParams()
{
    var params = {};
    params.startDate = nui.get("startDate").getFormValue();
    params.endDate = nui.get("endDate").getFormValue();
    var data=nui.get("data").getValue();
    var search=nui.get("search").getValue();
    if(data==0){
    	params.fullName=search;
    }else if(data==1){
    	params.cardId=search;
    }
    return params;
}
function onSearch()
{
    var params = getSearchParams();
    doSearch(params);
}
function doSearch(params) {

    grid.load({
        token:token,
        params: params
    });
}
function getNowFormatDate(){
	   var date = new Date();
	    var seperator1 = "-";
	    var seperator2 = ":";
	    var month = date.getMonth() + 1;
	    var strDate = date.getDate();
	    if (month >= 1 && month <= 9) {
	        month = "0" + month;
	    }
	    if (strDate >= 0 && strDate <= 9) {
	        strDate = "0" + strDate;
	    }

	    var startDate = date.getFullYear() + seperator1 + month + seperator1 + "01";
	    var endDate=date.getFullYear() + seperator1 + month+seperator1+strDate;
	    nui.get('startDate').setValue(startDate);
	    nui.get('endDate').setValue(endDate);
}

function onDrawCell(e) {

	if(e.field=="periodValidity"){
		if( e.value == -1){
			e.cellHtml="永久有效";
		}
	}
	else if(e.field=="packageRate" || e.field=="itemRate" ||e.field=="partRate"){
		e.cellHtml=e.value+"%";
	}

}