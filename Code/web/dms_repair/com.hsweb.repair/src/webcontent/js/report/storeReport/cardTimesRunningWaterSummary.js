/**
 * Created by Administrator on 2018/4/3.
 */

var webBaseUrl = webPath + contextPath + "/";
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/"; 
var grid1 = null;
var form = null;
var startDateEl = null;
var endDateEl = null;
var servieTypeHash=[{ name: '综合开单', id: '0' }, { name: '检查开单', id: '1' }, {name: '洗美开单' , id: '2' }, { name: '销售开单', id: '3' }, { name: '理赔开单', id: '4' }, { name: '退货开单', id: '5' }, { name: '充值开单', id: '6' }, { name: '退款开单', id: '7' }];
var cType = 0;
var queryCardTimesRunningWaterQC = apiPath + repairApi+'/com.hsapi.repair.report.dataStatistics.queryCardTimesRunningWaterQC.biz.ext';
var queryCardTimesRunningWaterSummary = apiPath + repairApi+'/com.hsapi.repair.report.dataStatistics.queryCardTimesRunningWaterSummary.biz.ext';
var queryCardTimesRunningWaterSZ = apiPath + repairApi+'/com.hsapi.repair.report.dataStatistics.queryCardTimesRunningWaterSZ.biz.ext';

$(document).ready(function (v)
{

	grid1 = nui.get("grid1");
	grid1.setUrl("queryCardTimesRunningWaterSummary");
    form=new nui.Form("#form1");
    startDateEl = nui.get("startDate");
    endDateEl = nui.get("endDate");

	  var filter = new HeaderFilter(grid1, {  
	        columns: [
	            { name: 'billServiceId' },
	            { name: 'guestName' },
		            { name: 'carNo' },
		            { name: 'times' },
	            { name: 'prdtName' },
	            { name: 'creator' },
	        ],
	        callback: function (column, filtered) {
	        },

	        tranCallBack: function (field) {
	        	var value = null;
	        	switch(field){
		    	}
	        	return value;
	        }
	    });
		var amt = grid1.getColumn("amt");
			grid1.hideColumn ( amt );
    grid1.on("drawcell", function (e) {
        if(e.field =="billTypeId"){
            e.cellHtml = servieTypeHash[e.value].name;
        }

    });
    

    quickSearch(4);
});


function onSearch(){
    
    
    var data= form.getData();
	data.endDate = formatDate(data.endDate) +" 23:59:59";
    nui.ajax({
        url:queryCardTimesRunningWaterQC,
        type:'post',
        data:{params:data,token :token},
        success:function(res){
            if(res.errCode == "S"){
                var qc = res.qc;
                var bala = res.bala;
                document.getElementById("pdata1").innerHTML = qc[0].qcAmt||0;
                document.getElementById("pdata5").innerHTML = bala[0].balaAmt||0;
            }
        }
    });
    nui.ajax({
        url:queryCardTimesRunningWaterSZ,
        type:'post',
        data:{params:data,token :token},
        success:function(res){
            if(res.errCode == "S"){
                var data = res.data;
                document.getElementById("pdata2").innerHTML = data[0].sAmt||0;
                document.getElementById("pdata3").innerHTML = data[0].zAmt||0;
                document.getElementById("pdata4").innerHTML = data[0].tAmt||0;
            }
        }
    });
}


function queryMX(e){
	var params = form.getData();
	var amt = grid1.getColumn("amt");
	var sellPrice = grid1.getColumn("sellPrice");
	params.endDate = formatDate(params.endDate) +" 23:59:59";
	if(e==0){
		params.billTypeIds = "0,1,2,3,4,5";
		grid1.hideColumn ( amt );
		grid1.showColumn ( sellPrice );
	}else{
		params.billTypeIds = e;
		grid1.hideColumn ( sellPrice );
		grid1.showColumn ( amt );
	}
	grid1.load({
        params: params,
        token: token
    });
	
}

function quickSearch(type){
    var params = form.getData();
    var queryname = "本日";
    switch (type)
    {
     case 0:
     params.today = 1;
     params.startDate = getNowStartDate();
     params.endDate = addDate(getNowEndDate(), 1);
     queryname = "本日";
     break;
     case 1:
     params.yesterday = 1;
     params.startDate = getPrevStartDate();
     params.endDate = addDate(getPrevEndDate(), 1);
     queryname = "昨日"; 
     break;
     case 2:
     params.thisWeek = 1;
     params.startDate = getWeekStartDate();
     params.endDate = addDate(getWeekEndDate(), 1);
     queryname = "本周";
     break;
     case 3: 
     params.lastWeek = 1;
     params.startDate = getLastWeekStartDate();
     params.endDate = addDate(getLastWeekEndDate(), 1);
     queryname = "上周";
     break;
     case 4:
     params.thisMonth = 1;
     params.startDate = getMonthStartDate();
     params.endDate = addDate(getMonthEndDate(), 1);
     queryname = "本月";
     break;
     case 5:
     params.lastMonth = 1;
     params.startDate = getLastMonthStartDate();
     params.endDate = addDate(getLastMonthEndDate(), 1);
     queryname = "上月";
     break;

     case 10:
     params.thisYear = 1;
     params.startDate = getYearStartDate();
     params.endDate = getYearEndDate();
     queryname="本年";
     break;
     case 11:
     params.lastYear = 1;
     params.startDate = getPrevYearStartDate();
     params.endDate = getPrevYearEndDate();
     queryname="上年";
     break;
     default:
     break;
 }
 currType = type;
 startDateEl.setValue(params.startDate);
 endDateEl.setValue(addDate(params.endDate,-1));
 var menunamedate = nui.get("menunamedate");
 menunamedate.setText(queryname);
 grid1.setData([]);
 onSearch();
}