/**
 * Created by Administrator on 2018/2/1.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.part.invoice.svr.queryPjInvoingDetail.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var basicInfoForm = null;
var rightGrid = null;
var brandHash = {};
var brandList = [];
var storehouseHash = {};
var billTypeIdHash = {
		"050101" :"采购入库",
		"050201" :"采购退货",
		"050103" :"盘盈入库",
		"050203" :"盘亏出库",
		"050105" :"期初入库",
		"050106" : "配件归库",
		"050206" :"配件领料",
		"050107" : "耗材入库",
		"050207" :"耗材归库",
		"050104" :"移仓入库",
		"050204" :"移仓出库",
		"050108" :"退货归库",
	    "050109" :"成品入库"
	};
var billTypeIdHashType = [
		{name:"采购入库",id:"050101"},
		{name:"采购退货",id:"050201"},
		{name:"盘盈入库",id:"050103"},
		{name:"盘亏出库" ,id:"050203"},
		{name:"期初入库" ,id:"050105"},
		{name:"配件归库",id:"050106"},
		{name:"配件领料",id:"050206"},
		{name:"耗材入库",id:"050107"},
		{name:"耗材归库",id:"050207"},
		{name:"移仓入库",id:"050104"},
		{name:"移仓出库",id:"050204"},
		{naem:"退货归库",id:"050108"},
		{naem:"成品入库",id:"050109"}
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
    
    orgidsEl = nui.get("orgids");
    orgidsEl.setData(currOrgList);
    if(currOrgList.length==1){
    	orgidsEl.hide();
    }else{
    	orgidsEl.setValue(currOrgid);
    }

    initMember("operatorId",function(){
    	
    });

    
	getAllPartBrand(function(data) {
		brandList = data.brand;
		nui.get('partBrandId').setData(brandList);
		brandList.forEach(function(v) {
			brandHash[v.id] = v;
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
	
    quickSearch(4);


});
function getSearchParams(){
    var params = {};
    params.partCodeOrName=nui.get("partCodeOrName").getValue();
    params.partId=nui.get("morePartId").getValue();
    params.partBrandId=nui.get("partBrandId").getValue();
    params.guestName=nui.get("guestName").getValue();
    params.operator=nui.get("operatorId").getText();
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
	
	for(var i=0;i<detail.length;i++){
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
	}
	if(detail && detail.length > 0){
		setInitExportData( detail);
	}
	
}

function setInitExportData( detail){

    var tds = '<td  colspan="1" align="left">[partCode]</td>' +
        "<td  colspan='1' align='left'>[partName]</td>" +
        "<td  colspan='1' align='left'>[partBrandId]</td>" +
        "<td  colspan='1' align='left'>[applyCarModel]</td>" +
        "<td  colspan='1' align='left'>[dc]</td>" +       
        "<td  colspan='1' align='left'>[operateDate]</td>" +
        
        "<td  colspan='1' align='left'>[qty]</td>" +
        "<td  colspan='1' align='left'>[costPrice]</td>" +
        "<td  colspan='1' align='left'>[costAmt]</td>" +
        
        "<td  colspan='1' align='left'>[balaQty]</td>" +
        "<td  colspan='1' align='left'>[balaPrice]</td>" +
        "<td  colspan='1' align='left'>[balaAmt]</td>"+
        "<td  colspan='1' align='left'>[billTypeId]</td>"+
        "<td  colspan='1' align='left'>[operator]</td>"+
        "<td  colspan='1' align='left'>[guestName]</td>";
        
        
    var tableExportContent = $("#tableExportContent");
    tableExportContent.empty();
    for (var i = 0; i < detail.length; i++) {
        var row = detail[i];
        if(row.orgid){
            var tr = $("<tr></tr>");
            tr.append(tds.replace("[partCode]", detail[i].partCode?detail[i].partCode:"")
                          .replace("[partName]", detail[i].partName?detail[i].partName:"")
                         .replace("[partBrandId]", detail[i].partBrandId?detail[i].partBrandId:"")
                         .replace("[applyCarModel]", detail[i].applyCarModel?detail[i].applyCarModel:"")
                         .replace("[dc]", detail[i].dc?detail[i].dc:"")
                         //.replace("[collectMoneyDate]", nui.formatDate(detail[i].collectMoneyDate?detail[i].collectMoneyDate:"",'yyyy-MM-dd HH:mm'))
                         
                         .replace("[operateDate]", nui.formatDate(detail[i].operateDate?detail[i].operateDate:"",'yyyy-MM-dd HH:mm'))
                         .replace("[qty]", detail[i].qty?detail[i].qty:"")
                         .replace("[costPrice]", detail[i].costPrice?detail[i].costPrice:"") 
                         .replace("[costAmt]", detail[i].costAmt?detail[i].costAmt:"") 
                         .replace("[balaQty]", detail[i].balaQty?detail[i].balaQty:"")                        
                         .replace("[balaPrice]", detail[i].balaPrice?detail[i].balaPrice:"")
                         .replace("[balaAmt]", detail[i].balaAmt?detail[i].balaAmt:"")
                         
                         .replace("[billTypeId]", detail[i].billTypeId?detail[i].billTypeId:"")
                         .replace("[operator]", detail[i].operator?detail[i].operator:"")
                         .replace("[guestName]", detail[i].guestName?detail[i].guestName:""));
            tableExportContent.append(tr);
        }
    }

 
    method5('tableExcel',"门店进销存明细表导出",'tableExportA');
}