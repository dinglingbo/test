/**
 * Created by Administrator on 2018/2/1.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.part.invoice.svr.queryPjInvoing.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var basicInfoForm = null;
var rightGrid = null;
var brandHash = {};
var brandList = [];
var storehouseHash = {};

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

	getAllPartBrand(function(data) {
		brandList = data.brand;
		brandList.forEach(function(v) {
			brandHash[v.id] = v;
		});
	});
	
	rightGrid.on("drawcell",function(e){
		switch (e.field) {
		
		case "partBrandId":
			 if(brandHash[e.value])
             {
//                 e.cellHtml = brandHash[e.value].name||"";
             	if(brandHash[e.value].imageUrl){
             		
             		e.cellHtml = "<img src='"+ brandHash[e.value].imageUrl+ "'alt='配件图片' height='25px' width=' '/><br> "+brandHash[e.value].name||"";
             	}else{
             		e.cellHtml = brandHash[e.value].name||"";
             	}
             }
             else{
                 e.cellHtml = "";
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
    quickSearch(4);


});
function getSearchParams(){
    var params = {};
    params.startDate=nui.get("startDate").getFormValue();
    params.endDate= addDate(endDateEl.getValue(),1);
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

function onExport(){
	

	var detail = nui.clone(rightGrid.getData());
	
	for(var i=0;i<detail.length;i++){
		for(var j in brandHash) {
			if(detail[i].partBrandId ==brandHash[j].id ){
				detail[i].partBrandId=brandHash[j].name;
			}
		}		
/*		for(var j in billTypeIdHash) {
			if(detail[i].billTypeId ==billTypeIdHash[j].id ){
				detail[i].billTypeId=billTypeIdHash[j].name;
			}
		}	
		if(detail[i].dc==1){
			detail[i].dc="入库";
		}else if(detail[i].dc==-1){
			detail[i].dc="出库";
		}*/
	}
	if(detail && detail.length > 0){
		setInitExportData( detail);
	}
	
}

function setInitExportData( detail){

    var tds = '<td  colspan="1" align="left">[partCode]</td>' +
        "<td  colspan='1' align='left'>[partName]</td>" +
        "<td  colspan='1' align='left'>[oemCode]</td>" +
        "<td  colspan='1' align='left'>[partBrandId]</td>" +
        "<td  colspan='1' align='left'>[qcQty]</td>" +       
        "<td  colspan='1' align='left'>[qcAmt]</td>" +
        
        "<td  colspan='1' align='left'>[purchaseEnterQty]</td>" +
        "<td  colspan='1' align='left'>[purchaseEnterAmt]</td>" +

        "<td  colspan='1' align='left'>[purchaseOutQty]</td>" +
        "<td  colspan='1' align='left'>[purchaseOutAmt]</td>" +
        
        "<td  colspan='1' align='left'>[repairEnterQty]</td>" +
        "<td  colspan='1' align='left'>[repairEnterAmt]</td>" +
        
        "<td  colspan='1' align='left'>[repairOutQty]</td>" +
        "<td  colspan='1' align='left'>[repairOutAmt]</td>" +
        
        "<td  colspan='1' align='left'>[returnOutQty]</td>" +
        "<td  colspan='1' align='left'>[returnOutAmt]</td>" +
        
        "<td  colspan='1' align='left'>[shiftEnterQty]</td>" +
        "<td  colspan='1' align='left'>[shiftEnterAmt]</td>" +
        
        "<td  colspan='1' align='left'>[shiftOutQty]</td>" +
        "<td  colspan='1' align='left'>[shiftOutAmt]</td>" +
        
/*        "<td  colspan='1' align='left'>[purchaseEnterQty]</td>" +
        "<td  colspan='1' align='left'>[purchaseEnterAmt]</td>" +
        
        "<td  colspan='1' align='left'>[purchaseEnterQty]</td>" +
        "<td  colspan='1' align='left'>[purchaseEnterAmt]</td>" +*/
        
        "<td  colspan='1' align='left'>[consumableEnterQty]</td>" +
        "<td  colspan='1' align='left'>[consumableEnterAmt]</td>" +
        
        "<td  colspan='1' align='left'>[consumableOutQty]</td>" +
        "<td  colspan='1' align='left'>[consumableOutAmt]</td>" +
        
        "<td  colspan='1' align='left'>[inventoryProfitQty]</td>" +
        "<td  colspan='1' align='left'>[inventoryProfitAmt]</td>" +
        
        "<td  colspan='1' align='left'>[inventoryLossQty]</td>" +
        "<td  colspan='1' align='left'>[inventoryLossAmt]</td>" +
        
        "<td  colspan='1' align='left'>[balaQty]</td>" +
        "<td  colspan='1' align='left'>[balaAmt]</td>";
        
        
    var tableExportContent = $("#tableExportContent");
    tableExportContent.empty();
    for (var i = 0; i < detail.length; i++) {
        var row = detail[i];
        if(row.orgid){
            var tr = $("<tr></tr>");
            tr.append(tds.replace("[partCode]", detail[i].partCode?detail[i].partCode:"")
                          .replace("[partName]", detail[i].partName?detail[i].partName:"")
                         .replace("[oemCode]", detail[i].oemCode?detail[i].oemCode:"")
                         .replace("[partBrandId]", detail[i].partBrandId?detail[i].partBrandId:"")
                         
                         .replace("[qcQty]", detail[i].qcQty?detail[i].qcQty:0)
                         .replace("[qcAmt]", detail[i].qcAmt?detail[i].qcAmt:0)
                         
                         .replace("[purchaseEnterQty]", detail[i].purchaseEnterQty?detail[i].purchaseEnterQty:0)
                         .replace("[purchaseEnterAmt]", detail[i].purchaseEnterAmt?detail[i].purchaseEnterAmt:0)
                         
                         .replace("[purchaseOutQty]", detail[i].purchaseOutQty?detail[i].purchaseOutQty:0)
                         .replace("[purchaseOutAmt]", detail[i].purchaseOutAmt?detail[i].purchaseOutAmt:0)
                         
                         .replace("[repairEnterQty]", detail[i].repairEnterQty?detail[i].repairEnterQty:0)
                         .replace("[repairEnterAmt]", detail[i].repairEnterAmt?detail[i].repairEnterAmt:0)
                         
                         .replace("[repairOutQty]", detail[i].repairOutQty?detail[i].repairOutQty:0)
                         .replace("[repairOutAmt]", detail[i].repairOutAmt?detail[i].repairOutAmt:0)
                         
                         .replace("[returnOutQty]", detail[i].returnOutQty?detail[i].returnOutQty:0)
                         .replace("[returnOutAmt]", detail[i].returnOutAmt?detail[i].returnOutAmt:0)
                         
                         .replace("[shiftEnterQty]", detail[i].shiftEnterQty?detail[i].shiftEnterQty:0)
                         .replace("[shiftEnterAmt]", detail[i].shiftEnterAmt?detail[i].shiftEnterAmt:0)
                         
                         .replace("[shiftOutQty]", detail[i].shiftOutQty?detail[i].shiftOutQty:0)
                         .replace("[shiftOutAmt]", detail[i].shiftOutAmt?detail[i].shiftOutAmt:0)
                         
                         .replace("[consumableEnterQty]", detail[i].consumableEnterQty?detail[i].consumableEnterQty:0)
                         .replace("[consumableEnterAmt]", detail[i].consumableEnterAmt?detail[i].consumableEnterAmt:0)
                         
                         .replace("[consumableOutQty]", detail[i].consumableOutQty?detail[i].consumableOutQty:0)
                         .replace("[consumableOutAmt]", detail[i].consumableOutAmt?detail[i].consumableOutAmt:0)
                         
                         .replace("[inventoryProfitQty]", detail[i].inventoryProfitQty?detail[i].inventoryProfitQty:0)
                         .replace("[inventoryProfitAmt]", detail[i].inventoryProfitAmt?detail[i].inventoryProfitAmt:0)
                         
                         .replace("[inventoryLossQty]", detail[i].inventoryLossQty?detail[i].inventoryLossQty:0)
                         .replace("[inventoryLossAmt]", detail[i].inventoryLossAmt?detail[i].inventoryLossAmt:0)
                         
                         .replace("[balaQty]", detail[i].balaQty?detail[i].balaQty:0)
                         .replace("[balaAmt]", detail[i].balaAmt?detail[i].balaAmt:0));
            tableExportContent.append(tr);
        }
    }

 
    method5('tableExcel',"门店进销存明细表导出",'tableExportA');
}