/**
 * Created by Administrator on 2018/2/1.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.report.report.queryPjStoreInvoingDetail.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var basicInfoForm = null;
var rightGrid = null;
var brandHash = {};
var brandList = [];
var storehouse = null;
var storeHash = {};

var billTypeIdHash = {
		"050101" :"采购入库",
		"050102" :"销售退货",
		"050201" :"采购退货",
		"050202" : "销售出库",
		"050103" :"盘盈入库",
		"050203" :"盘亏出库",
		"050104" :"调拨入库",
		"050204" :"调拨出库",
		"050105" :"期初入库",
		"050107" : "移仓入库",
		"050207" :"移仓出库",
		"050111" :"调出退货",
		"050211" :"调入退货",
		"050112" :"组装入库",
		"050212" :"组装出库",
		"050113" :"拆分入库",
		"050213" :"拆分出库"

	};
var billTypeIdHashType = [
		{name:"采购入库",id:"050101"},
		{name:"销售退货",id:"050102"},
		{name:"销售出库",id:"050202"},
		{name:"采购退货",id:"050201"},
		{name:"盘盈入库",id:"050103"},
		{name:"盘亏出库" ,id:"050203"},
		{name:"期初入库" ,id:"050105"},
		{name:"调拨入库",id:"050104"},
		{name:"调拨出库",id:"050204"},
		{name:"移仓入库",id:"050104"},
		{name:"移仓出库",id:"050204"},
		{naem:"调出退货",id:"050111"},
		{naem:"调入退货",id:"050211"},
		{name:"组装入库",id:"050112"},
		{name:"组装出库",id:"050212"},
		{naem:"拆分入库",id:"050113"},
		{naem:"拆分出库",id:"050213"}
	];
var settTypeIdHash = {};
var outTypeIdHash = {};
var orgidsEl = null;
$(document).ready(function(v)
{
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    startDateEl =nui.get('OstartDate');
    endDateEl = nui.get('OendDate');
    
    initMember("operatorId",function(){
    	
    });



	getAllPartBrand(function(data) {
		brandList = data.brand;
		nui.get('partBrandId').setData(brandList);
		brandList.forEach(function(v) {
			brandHash[v.id] = v;
		});
	});
	
	getStorehouse(function(data) {
		storehouse = data.storehouse || [];
		if(storehouse && storehouse.length>0){
			nui.get('storehouse').setData(storehouse);
			nui.get('storehouse').setValue(storehouse[0].id);
			nui.get('storehouse').setText(storehouse[0].name);
			storehouse.forEach(function(v) {
				storeHash[v.id] = v;
			});
			quickSearch(4);
		}
	});
	rightGrid.on("drawcell",function(e){
		switch (e.field) {
		case "billTypeId" :
			if(billTypeIdHash[e.value]){
				e.cellHtml = billTypeIdHash[e.value]|| "";
			}			
			break;
		case "dc" :
			if(e.value==1){
				e.cellHtml = "入库";
			}else{
				e.cellHtml = "出库";
			}
			break;
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
   var filter = new HeaderFilter(rightGrid, {
	        columns: [
	            { name: 'partName' },
	            { name: 'applyCarModel' },
	            { name: 'billTypeId' },
	            { name: 'operator' }
	            
	        ],
	        callback: function (column, filtered) {
	        },

	        tranCallBack: function (field) {
	        	var value = null;
	        	switch(field){
		    		case "billTypeId" ://状态 
		    			value = billTypeIdHashType;// [{ name: '待确认', id: '0' }, { name: '已确认', id: '1' }, {name: '已取消' , id: '2' }, { name: '已开单', id: '3' }, { name: '已评价', id: '4' }];
		    			break;
		    	}
	        	return value;
	        }
	    });
	
    


});
function getSearchParams(){
    var params = {};
    params.storeId=nui.get('storehouse').getValue();
    params.partCodeOrName=nui.get("partCodeOrName").getValue();
    params.partId=nui.get("morePartId").getValue();
    params.partBrandId=nui.get("partBrandId").getValue();
    params.guestName=nui.get("guestName").getValue();
    params.operator=nui.get("operatorId").getText();
    params.OstartDate=nui.get("OstartDate").getFormValue();
    params.OendDate=addDate(endDateEl.getValue(),1);
    

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
            params.OstartDate = getNowStartDate();
            params.OendDate = addDate(getNowEndDate(), 1);
            queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.OstartDate = getPrevStartDate();
            params.OendDate = addDate(getPrevEndDate(), 1);
            queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.OstartDate = getWeekStartDate();
            params.OendDate = addDate(getWeekEndDate(), 1);
            queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.OstartDate = getLastWeekStartDate();
            params.OendDate = addDate(getLastWeekEndDate(), 1);
            queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.OstartDate = getMonthStartDate();
            params.OendDate = addDate(getMonthEndDate(), 1);
            queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.OstartDate = getLastMonthStartDate();
            params.OendDate = addDate(getLastMonthEndDate(), 1);
            queryname = "上月";
            break;

        case 10:
            params.thisYear = 1;
            params.OstartDate = getYearStartDate();
            params.OendDate = getYearEndDate();
            queryname="本年";
            break;
        case 11:
            params.lastYear = 1;
            params.OstartDate = getPrevYearStartDate();
            params.OendDate = getPrevYearEndDate();
            queryname="上年";
            break;
        default:
            break;
    }
    currType = type;
    startDateEl.setValue(params.OstartDate);
    endDateEl.setValue(addDate(params.OendDate,-1));
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
function onExport(){
	var detail = nui.clone(rightGrid.getData());
//多级
	exportMultistage(rightGrid.columns)
//单级
       //exportNoMultistage(rightGrid.columns)
	for(var i=0;i<detail.length;i++){
		detail[i].id=1;
		if(detail[i].dc==1){
			detail[i].dc = "入库";
		}else{
			detail[i].dc = "出库";
		}	
		detail[i].billTypeId=billTypeIdHash[detail[i].billTypeId]|| "";
		for(var j in brandHash) {
			if(detail[i].partBrandId ==brandHash[j].id ){
				detail[i].partBrandId=brandHash[j].name;
			}
		}		
	}
	if(detail && detail.length > 0){
//多级表头类型
		setInitExportData( detail,rightGrid.columns,"分仓进销存明细表导出");
//单级表头类型  与上二选一
//setInitExportDataNoMultistage( detail,rightGrid.columns,"已结算工单明细表导出");
	}
	
}