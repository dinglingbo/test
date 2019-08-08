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
var orgidsEl = null;
$(document).ready(function(v)
{
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    startDateEl =nui.get('startDate');
    endDateEl = nui.get('endDate');
    
    orgidsEl = nui.get("orgids");
    orgidsEl.setData(currOrgList);
    if(currOrgList.length==1){
    	orgidsEl.hide();
    }else{
    	orgidsEl.setValue(currOrgid);
    }

	getStorehouse(function(data) {
		storehouse = data.storehouse || [];
		if(storehouse && storehouse.length>0){
			storehouse.forEach(function(v) {
				storeHash[v.id] = v;
			});
		}
	});
	rightGrid.on("drawcell",function(e){
		var countWay = nui.get("countWay").getValue();
		switch (e.field) {
		case "storeId":
			if(countWay==1){
				e.cellHtml ="汇总";
			}
			else{
				if (storeHash[e.value]) {
					e.cellHtml = storeHash[e.value].name || "";
				} 
			}
			
			break;
		case  "orgid":
        	for(var i=0;i<currOrgList.length;i++){
        		if(currOrgList[i].orgid==e.value){
        			e.cellHtml = currOrgList[i].shortName || "";
        		}
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
    params.startDate=nui.get("startDate").getFormValue();
    params.endDate=addDate(nui.get("endDate").getValue(),1);
    var countWay = nui.get("countWay").getValue();
    if(countWay == 1)
    {

    }
    else if(countWay == 2)
    {
        params.store = 1;
    }
    var orgidsElValue = orgidsEl.getValue();
    if(orgidsElValue==null||orgidsElValue==""){
    	 params.orgids =  currOrgs;
    }else{
    	params.orgid=orgidsElValue;
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
            params.endDate = getDate(-1);
            queryname = "最近七天";
            break;
        case 1:
            params.startDate = getDate(30);
            params.endDate = getDate(-1);
            queryname = "最近30天";
            break;
        case 2:
            params.startDate = getDate(90);
            params.endDate = getDate(-1);
            queryname = "最近90天";
            break;
        case 3:
            params.startDate = getDate(180);
            params.endDate = getDate(-1);
            queryname = "最近180天";
            break; 
        default:
            break;
    }
    currType = type;
    startDateEl.setValue(params.startDate);
    endDateEl.setValue(addDate(params.endDate,-1));
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
//	params.orgid = currOrgid;
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
function onExport(){
	var detail = nui.clone(rightGrid.getData());
	exportNoMultistage(rightGrid.columns)
	for(var i=0;i<detail.length;i++){
		detail[i].id=1;
/*		for(var j in partTypeHash) {
			if(detail[i].carTypeIdF==partTypeHash[j].id){
				detail[i].carTypeIdF=partTypeHash[j].name;
			}
			if(detail[i].carTypeIdS==partTypeHash[j].id){
				detail[i].carTypeIdS=partTypeHash[j].name;
			}
			if(detail[i].carTypeIdT==partTypeHash[j].id){
				detail[i].carTypeIdT=partTypeHash[j].name;
			}
		}
		for(var j in brandHash) {
			if(detail[i].partBrandId ==brandHash[j].id ){
				detail[i].partBrandId=brandHash[j].name;
			}
		}*/
	}
	if(detail && detail.length > 0){
		setInitExportDataNoMultistage( detail,rightGrid.columns,"库存周转汇总表导出");
	}
	
}