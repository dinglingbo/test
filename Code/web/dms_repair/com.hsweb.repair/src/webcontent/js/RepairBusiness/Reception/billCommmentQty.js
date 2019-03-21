/**
 * Created by Administrator on 2018/2/1.
 */
var baseUrl = apiPath + repairApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.repair.repairService.report.queryBillComment.biz.ext";
var basicInfoForm = null;
var rightGrid = null; 
var servieTypeList=[];
var servieTypeHash={};
var pointList=[{"id":1,"type":"good","name" :"好评" },{"id":2,"type":"nice","name" :"中评" },{"id":3,"type":"bad","name" :"差评" }];
var nextComeHash={"0":"否","1":"是"};
$(document).ready(function(v)
{
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    sRecordDateEl =nui.get('sRecordDate');
    eRecordDateEl = nui.get('eRecordDate');

    initServiceType("serviceTypeId",function(data) {
        servieTypeList = nui.get("serviceTypeId").getData();
        servieTypeList.forEach(function(v) {
          servieTypeHash[v.id] = v;
      });
    })
    
    var filter = new HeaderFilter(rightGrid, {
        columns: [
            { name: 'recorder' },
            { name: 'carModel' },
            { name: 'serviceTypeId' },
            { name: 'isNextCome' },
            { name: 'mtAdvisor' }
        ],
        callback: function (column, filtered) {
        },
        tranCallBack: function (field) {
        	var value = null;
        	switch(field){
        		case "serviceTypeId" :
        			var arr = [];
        			for (var i in servieTypeList) {
        			    var o = {};
        			    o.name = servieTypeList[i].name;
        			    o.id = servieTypeList[i].id;
        			    arr.push(o);
        			}
        			value = arr;
        			break;			
        		case "isNextCome" :
        			var arr = [];
        			for (var i in nextComeHash) {
        			    var o = {};
        			    o.name = nextComeHash[i].name;
        			    o.id = nextComeHash[i].id;
        			    arr.push(o);
        			}
        			value = arr;
        			break;		
        	}
        	return value;
        }
    });
    
	rightGrid.on("drawcell",function(e){
		switch (e.field) {
			case "serviceTypeId" :
		     if(servieTypeHash[e.value])
	            {
	                e.cellHtml = servieTypeHash[e.value].name||"";
	            }
	            else{
	                e.cellHtml = "";
	            }
			 break;
			case "isNextCome" :
			     if(nextComeHash[e.value])
		            {
		                e.cellHtml = nextComeHash[e.value] ||"";
		            }
		            else{
		                e.cellHtml = "";
		            }
				 break;
		default:
			break;
		}
	});
	
	document.onkeyup = function(event) {
		var e = event || window.event;
		var keyCode = e.keyCode || e.which;// 38向上 40向下
		
		if ((keyCode == 13)) { // F9
			onSearch();
		}

	}
    quickSearch(4);

});
function getSearchParams(){
    var params = {};
    params.carNo=nui.get("carNo").getValue();
    params.mobile=nui.get("mobile").getValue();
    var type=nui.get("point").getValue();
    if(type=="good"){
    	params.good=1;
    }
    if(type=="nice"){
    	params.nice=1;
    }
    if(type=="bad"){
    	params.bad=1;
    }
    params.sRecordDate=nui.get("sRecordDate").getFormValue();
    params.eRecordDate=nui.get("eRecordDate").getFormValue();
    return params;
}
var currType = 2;
function quickSearch(type){
    var params = getSearchParams();
    var queryname = "本日";
    switch (type)
    {
        case 0:
            params.today = 1;
            params.sOutDate = getNowStartDate();
            params.eOutDate = addDate(getNowEndDate(), 1);
            queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.sOutDate = getPrevStartDate();
            params.eOutDate = addDate(getPrevEndDate(), 1);
            queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.sOutDate = getWeekStartDate();
            params.eOutDate = addDate(getWeekEndDate(), 1);
            queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.sOutDate = getLastWeekStartDate();
            params.eOutDate = addDate(getLastWeekEndDate(), 1);
            queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.sOutDate = getMonthStartDate();
            params.eOutDate = addDate(getMonthEndDate(), 1);
            queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.sOutDate = getLastMonthStartDate();
            params.eOutDate = addDate(getLastMonthEndDate(), 1);
            queryname = "上月";
            break;

        case 10:
            params.thisYear = 1;
            params.sOutDate = getYearStartDate();
            params.eOutDate = getYearEndDate();
            queryname="本年";
            break;
        case 11:
            params.lastYear = 1;
            params.sOutDate = getPrevYearStartDate();
            params.eOutDate = getPrevYearEndDate();
            queryname="上年";
            break;
        default:
            break;
    }
    currType = type;
    sRecordDateEl.setValue(params.sOutDate);
    eRecordDateEl.setValue(addDate(params.eOutDate,-1));
    var menunamedate = nui.get("menunamedate");
    menunamedate.setText(queryname);
    doSearch(params);
}

function onSearch(){
	var params=getSearchParams();
	doSearch(params);
}
function doSearch(params)
{
	params.orgid = currOrgid;
    if(params.eRecordDate){
        params.eRecordDate = params.eRecordDate+" 23:59:59";
    }
    rightGrid.load({
        params:params,
        token :token     
    });
}
