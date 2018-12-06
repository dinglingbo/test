/**
 * Created by Administrator on 2018/8/8.
 */

var dataList=[{id:"0",text:"客户名称"},{id:"1",text:"卡号"},{id:"2",text:"车牌号"},{id:"3",text:"手机号"}];
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var grid = null;
var gridUrl = baseUrl + "com.hsapi.repair.repairService.report.queryStoreConsume.biz.ext";
var type=[{id: 0,text:'消费抵款'},{id:1,text:'退款'}];
var isClearGiveAmt=[{id:0,text :'否',id:1,text :"是"}];

var queryInfoForm = null;

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
    if(data==0 ){
    	params.fullName=search;
    }else if(data==1){
    	params.cardNo=search;
    }else if(data==2){
    	params.carNo=search;
    }else if(data==3){
    	params.tel=search;
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

function onRenderer(e){
	for(var i = 0, l = type.length; i < l; i++) {
		var g=type[i];
		if(g.id==e.value){
			return g.text;
		}
	}
	return "";
}
function onRenderer2(e){
	for(var i = 0, l = isClearGiveAmt.length; i < l; i++) {
		var g=isClearGiveAmt[i];
		if(g.id==e.value){
			return g.text;
		}
	}
	return "";
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
