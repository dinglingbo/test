/**
 * Created by Administrator on 2018/2/1.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.report.report.queryPjInvoingDetail.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var basicInfoForm = null;
var rightGrid = null;
var brandHash = {};
var brandList = [];
var storehouseHash = {};
var compBrandList = [];
var compBrandHash = {};
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

var columnField = {
		costPrice : "单价",
		costAmt : "金额",
		taxCostPrice:"人进价单价",
		taxCostAmt:"人进价金额",
		expPrice:"采购成本单价",
		expAmt:"采购成本金额",
		noTaxCostPrice:"库存商品单价",
		noTaxCostAmt:"库存商品金额",
		balaPrice : "单价",
		balaAmt : "金额",
		balaTaxCostPrice:"人进价单价",
		balaTaxCostAmt:"人进价金额",
		balaExpPrice:"采购成本单价",
		balaExpAmt:"采购成本金额",
		balaNoTaxCostPrice:"库存商品单价",
		balaNoTaxCostAmt:"库存商品金额"
};
$(document).ready(function(v)
{
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    startDateEl =nui.get('OstartDate');
    endDateEl = nui.get('OendDate');
    
    orgidsEl = nui.get("orgids");
    orgidsEl.setData(currOrgList);
    if(currOrgList.length==1){
    	orgidsEl.hide();
    }else{
    	orgidsEl.setValue(currOrgid);
    }

    initMember("operatorId",function(){
    	
    });

    var dictDefs ={"orgCarBrandId": "10444"};
    initDicts(dictDefs, function() {
    	compBrandList = nui.get("orgCarBrandId").getData();
		compBrandList.forEach(function(v){
			compBrandHash[v.customid]=v;
    	});
		
		getStorehouse(function(data)
	    {
	        var storehouse = data.storehouse||[];

	        storehouse.forEach(function(v)
	        {
	            if(v && v.id)
	            {
	                storehouseHash[v.id] = v;
	            }
	        });
	        
	    	getAllPartBrand(function(data) {
	    		brandList = data.brand;
	    		nui.get('partBrandId').setData(brandList);
	    		brandList.forEach(function(v) {
	    			brandHash[v.id] = v;
	    		});
	    		
	    		
	    		getResBtnAuth("cloudInvoingDetail_set",function(data) {
	            	if(data != null) {
	            		for(var i=0; i<data.length; i++) {
	            			var rd = data[i];
	            			var code = rd.code || "";
	            			for ( var key in columnField) {
	            				if (key == code) {
	            					rightGrid.showColumn(key);
	            				}
	            			}
	            		}
	            	}
	            	
	            	quickSearch(4);
	            	
	            });
	    		
	    	});
	        
	    });
		
    	
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
        case "orgCarBrandId":
            if(compBrandHash  && compBrandHash[e.value])
            {
                e.cellHtml = compBrandHash[e.value].name;
            }
            break;
        case "storeId":
            if(storehouseHash  && storehouseHash[e.value])
            {
                e.cellHtml = storehouseHash[e.value].name;
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
    params.partCodeOrName=nui.get("partCodeOrName").getValue();
    params.partId=nui.get("morePartId").getValue();
    params.partBrandId=nui.get("partBrandId").getValue();
    params.guestName=nui.get("guestName").getValue();
    params.operator=nui.get("operatorId").getText();
	params.orgCarBrandId = nui.get("orgCarBrandId").getValue();
    params.OstartDate=startDateEl.getFormValue();;
    params.OendDate=addDate(endDateEl.getValue(),1);
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
		for(var j in billTypeIdHash) {
			if(detail[i].billTypeId ==billTypeIdHash[j].id ){
				detail[i].billTypeId=billTypeIdHash[j].name;
			}
		}	
		for(var j in brandHash) {
			if(detail[i].partBrandId ==brandHash[j].id ){
				detail[i].partBrandId=brandHash[j].name;
			}
		}		
		if(detail[i].dc==1){
			detail[i].dc="入库";
		}else if(detail[i].dc==-1){
			detail[i].dc="出库";
		}
		if(compBrandHash[detail[i].orgCarBrandId]){
			detail[i].orgCarBrandId=compBrandHash[detail[i].orgCarBrandId].name;
		}
	}
	if(detail && detail.length > 0){
//多级表头类型
		setInitExportData( detail,rightGrid.columns,"进销存明细表导出");
//单级表头类型  与上二选一
//setInitExportDataNoMultistage( detail,rightGrid.columns,"已结算工单明细表导出");
	}
	
}