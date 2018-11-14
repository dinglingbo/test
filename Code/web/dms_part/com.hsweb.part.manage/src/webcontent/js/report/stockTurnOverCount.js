/**
 * Created by Administrator on 2018/2/1.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.part.invoice.svr.queryTurnOverCount.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var basicInfoForm = null;
var rightGrid = null;
var storehouse = [];
var storeHash={};
var billTypeIdHash = {};
var settTypeIdHash = {};
var outTypeIdHash = {};

$(document).ready(function(v)
{
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    startDateEl =nui.get('startDate');
    endDateEl = nui.get('endDate');
    
	
	getStorehouse(function(data) {
		storehouse = data.storehouse || [];
		if(storehouse && storehouse.length>0){
			storehouse.forEach(function(v) {
				storeHash[v.id] = v;
			});
		}
	});
	rightGrid.on("drawcell",function(e){
		switch (e.field) {
		case "storeId":
			if (storeHash[e.value]) {
				e.cellHtml = storeHash[e.value].name || "";
			} else {
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
    quickSearch(0);


});
function getSearchParams(){
    var params = {};
    params.startDate=nui.get("startDate").getValue().substr(0, 10);
    params.endDate=nui.get("endDate").getValue().substr(0, 10);
    var countWay = nui.get("countWay").getValue();
    if(countWay == 1)
    {

    }
    else if(countWay == 2)
    {
        params.store = 1;
    }
    return params;
}
var currType = 2;
function quickSearch(type){
	var params = getSearchParams();
    var queryname = "最近七天";
    switch (type)
    {
        case 0:
            params.startDate = getDate(7);
            params.endDate = getDate(0);
            queryname = "最近七天";
            break;
        case 1:
            params.startDate = getDate(30);
            params.endDate = getDate(0);
            queryname = "最近30天";
            break;
        case 2:
            params.startDate = getDate(90);
            params.endDate = getDate(0);
            queryname = "最近90天";
            break;
        case 3:
            params.startDate = getDate(180);
            params.endDate = getDate(0);
            queryname = "最近180天";
            break; 
        default:
            break;
    }
    currType = type;
    startDateEl.setValue(params.startDate);
    endDateEl.setValue(params.endDate);
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
    rightGrid.load({
        params:params,
        token :token     
    });
}

function getDate(wantDay){
	var date=new Date();
	var returnDate=new Date(date-1000*60*60*24*wantDay);
	var year=returnDate.getFullYear();
	var month=returnDate.getMonth()+1;
	var day=returnDate.getDate();
	var returnSting=year+"-"+(month<10 ? "0"+month :month)+"-"+(day<10 ?"0"+day:day);
	return returnSting;
}