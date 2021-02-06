var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + frmApi + "/";// window._rootUrl||"http://127.0.0.1:8080/default/";
var partBaseUrl = apiPath + partApi + "/";
var gridUrl = baseUrl
		+ "com.hsapi.frm.frmService.query.queryFisPreBill.biz.ext";
var grid = null;
var searchBeginDate = null;
var searchEndDate = null;
$(document).ready(function(v) {
	searchBeginDate = nui.get("beginDate");
	searchEndDate = nui.get("endDate");
	grid = nui.get("datagrid1");
	grid.setUrl(gridUrl);
	quickSearch(4);
	
	grid.on("drawcell", function (e) {
        var record = e.record;
        if (e.field == "settleStatus") {
        	if(e.value==1) {
        		e.cellHtml = "已收款";
        	}else if(e.value==0) {
            	e.cellHtml = "未收款";
            }else if(e.value==2) {
            	e.cellHtml = "已作废";
            }
        }
    });
});
function quickSearch(type) {
	var params = getSearchParam();
	var currType = 2;
	var queryname = "本日";
	switch (type) {
	case 0:
		params.today = 1;
		params.sCreateDate = getNowStartDate();
		params.eCreateDate = getNowEndDate();
		var queryname = "本日";
		break;
	case 1:
		params.yesterday = 1;
		params.sCreateDate = getPrevStartDate();
		params.eCreateDate = getPrevEndDate();
		var queryname = "昨日";
		break;
	case 2:
		params.thisWeek = 1;
		params.sCreateDate = getWeekStartDate();
		params.eCreateDate = getWeekEndDate();
		var queryname = "本周";
		break;
	case 3:
		params.lastWeek = 1;
		params.sCreateDate = getLastWeekStartDate();
		params.eCreateDate = getLastWeekEndDate();
		var queryname = "上周";
		break;
	case 4:
		params.thisMonth = 1;
		params.sCreateDate = getMonthStartDate();
		params.eCreateDate = getMonthEndDate();
		var queryname = "本月";
		break;
	case 5:
		params.lastMonth = 1;
		params.sCreateDate = getLastMonthStartDate();
		params.eCreateDate = getLastMonthEndDate();
		var queryname = "上月";
		break;
	case 10:
		params.thisYear = 1;
		params.sCreateDate = getYearStartDate();
		params.eCreateDate = getYearEndDate();
		var queryname = "本年";
		break;
	case 11:
		params.lastYear = 1;
		params.sCreateDate = getPrevYearStartDate();
		params.eCreateDate = getPrevYearEndDate();
		var queryname = "上年";
		break;
	default:
		break;
	}
	searchBeginDate.setValue(params.sCreateDate);
	searchEndDate.setValue(params.eCreateDate);
	currType = type;
	var menunamedate = nui.get("menunamedate");
	menunamedate.setText(queryname);
	
	doSearch(params);
}

function search(){
	var params = getSearchParam();
	doSearch(params);
	
}
function doSearch(params){
	params.guestName = nui.get("guestName").getValue();
	params.carNo = nui.get("carNo").getValue();
	grid.load({params : params,token:token});
}

function getSearchParam() {
	var params = {};
	params.sCreateDate = searchBeginDate.getFormValue();
	params.eCreateDate = searchEndDate.getValue();
	var settleStatus = nui.get("settleStatus").getValue();
	if(settleStatus != 3) {
		params.settleStatus = settleStatus;
	}
	return params;
}
function invalid(){
	var row = grid.getSelected();
	if(row){
	    nui.mask({
	        el : document.body,
	        cls : 'mini-mask-loading',
	        html : '操作中...'
	    });
		var saveFisPreBillUrl =  baseUrl +"com.hsapi.frm.frmService.crud.saveFisPreBill.biz.ext";
	    nui.ajax({
	        url:saveFisPreBillUrl,
	        type:"post",
	        data:JSON.stringify({
	        	fispreBillId : row.id,
	        	token: token
	        }),
	        success:function(data)
	        {
	            nui.unmask();
	            if (data.errCode == 'S') {
	                showMsg(data.errMsg,"S");
	                search();
	            }else{
	                showMsg(data.errMsg,"W");
	                //basicInfoForm.setData([]); 
	            }
	        },
	        error:function(jqXHR, textStatus, errorThrown){
	            //  nui.alert(jqXHR.responseText);
	           
	            closeWindow("cal");
	        }
	    });

	}else{
		showMsg("请选择行！","W");
		return;
	}
}