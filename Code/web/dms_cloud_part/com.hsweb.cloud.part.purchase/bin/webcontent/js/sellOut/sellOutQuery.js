/**
 * Created by Administrator on 2018/2/1.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.query.queryPjSellOutMainDetailList.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var basicInfoForm = null;
var rightGrid = null;
var searchBeginDate = null;
var searchEndDate = null;
var comPartNameAndPY = null;
var comPartCode = null;
var comServiceId = null;
var comSearchGuestId = null;
var compBrandList = [];
var compBrandHash = {};
var businessTypeList = [];
var businessTypeHash = {};

var storehouseHash = {};
var billTypeIdHash = {};
var settTypeIdHash = {};
var enterTypeIdHash = {};
var partBrandIdHash = {};
var billStatusHash = {
    "0":"未审",
    "1":"已审",
    "2":"已过账",
    "3":"已取消"
};
var columnField = {
		sellPrice : "销售单价",
		sellAmt : "销售金额",
		settleGuestRebateAmt : "结算单位返点",
		businessTypeRebateAmt : "销售类型返点",
		showPrice : "开单单价",
		showAmt : "开单金额",
		enterPrice : "成本单价",
		enterAmt : "成本金额",
		lossPrice : "损益",
		maoLi : "毛利",
		costRate : "成本率",
		maoLiRate : "毛利率",
		taxPrice : "含税单价",
		taxAmt : "含税金额",
		noTaxPrice : "不含税单价",
		noTaxAmt:"不含税金额",
		taxCostPrice:"人进价单价",
		taxCostAmt:"人进价金额",
		expEnterPrice:"采购成本单价",
		expEnterAmt:"采购成本金额",
		setCostPrice:"定价成本单价",
		setCostAmt:"定价成本金额",
		noTaxCostPrice:"库存商品单价",
		noTaxCostAmt:"库存商品金额"
};
$(document).ready(function(v)
{
	rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    rightGrid.on("load", function () {
        rightGrid.mergeColumns(["serviceId"]);
    });
    searchBeginDate = nui.get("beginDate");
    searchEndDate = nui.get("endDate");
 	comPartNameAndPY = nui.get("partNameAndPY");
	comPartCode = nui.get("partCode");
	comServiceId = nui.get("serviceId");
	comSearchGuestId = nui.get("searchGuestId");
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    //console.log("xxx");
    
    var dictDefs ={"billTypeId":"DDT20130703000008", "settleTypeId":"DDT20130703000035", "orgCarBrandId": "10444", "businessTypeId": "10445"};
    initDicts(dictDefs, function() {
    	compBrandList = nui.get("orgCarBrandId").getData();
		compBrandList.forEach(function(v){
			compBrandHash[v.customid]=v;
    	});
		
		businessTypeList = nui.get("businessTypeId").getData();
		businessTypeList.forEach(function(v){
			businessTypeHash[v.customid]=v;
    	});
		
		billTypeIdList = nui.get("billTypeId").getData();
		billTypeIdList.forEach(function(v){
			billTypeIdHash[v.customid]=v;
    	});
		
		settTypeIdList = nui.get("settleTypeId").getData();
		settTypeIdList.forEach(function(v){
			settTypeIdHash[v.customid]=v;
    	});
		
    	getStorehouse(function(data)
	    {
    		var storehouse = data.storehouse||[];
            nui.get("storeId").setData(storehouse);
            storehouse.forEach(function(v)
            {
                if(v && v.id)
                {
                    storehouseHash[v.id] = v;
                }
            });

	        getAllPartBrand(function(data) {
	        	partBrandList = data.brand;
	        	partBrandList.forEach(function(v) {
	        		partBrandIdHash[v.id] = v;
	            });
	        	
	        	getResBtnAuth("cloudSellOutQuery_set",function(data) {
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
	            	
	            	quickSearch(currType);
	            	
	            });

	            nui.unmask();
	        });
	    });
    });
    
    /*getAllPartBrand(function(data)
    {
        var partBrandList = data.brand;
        partBrandList.forEach(function(v)
        {
            partBrandIdHash[v.id] = v;
        });
    });
    getStorehouse(function(data)
    {
        var storehouse = data.storehouse||[];
        nui.get("storeId").setData(storehouse);
        storehouse.forEach(function(v)
        {
            if(v && v.id)
            {
                storehouseHash[v.id] = v;
            }
        });
        var dictIdList = [];
        dictIdList.push('DDT20130703000008');//票据类型
        dictIdList.push('DDT20130703000035');//结算方式
        dictIdList.push('DDT20130703000064');//入库类型
        getDictItems(dictIdList,function(data)
        {
            if(data && data.dataItems)
            {
                var dataItems = data.dataItems||[];
                var billTypeIdList = dataItems.filter(function(v)
                {
                    if(v.dictid == "DDT20130703000008")
                    {
                        billTypeIdHash[v.customid] = v;
                        return true;
                    }
                });
          //      nui.get("billTypeId").setData(billTypeIdList);
                var settTypeIdList = dataItems.filter(function(v)
                {
                    if(v.dictid == "DDT20130703000035")
                    {
                        settTypeIdHash[v.customid] = v;
                        return true;
                    }
                });
          //      nui.get("settType").setData(settTypeIdList);
                var enterTypeIdList = dataItems.filter(function(v)
                {
                    if(v.dictid == "DDT20130703000064")
                    {
                        enterTypeIdHash[v.customid] = v;
                        return true;
                    }
                });
                quickSearch(currType);
            }
        });
    });*/
});
function getSearchParam(){
    var params = {};
    var rtnableQty = nui.get("rtnableQty").getValue();
    if(rtnableQty == 1)
    {
        params.rtnableQty = 1;
    }
    params.serviceId = comServiceId.getValue().replace(/\s+/g, "");
    params.orderMan = nui.get("orderMan").getValue().replace(/\s+/g, "");
	params.partCode = comPartCode.getValue().replace(/\s+/g, "");//.replace(/(^\s*)|(\s*$)/g, "");
	params.partNameAndPY = comPartNameAndPY.getValue().replace(/\s+/g, "");
	params.manualCode = nui.get("manualCode").getValue();
	params.guestId = comSearchGuestId.getValue();
	params.storeId = nui.get("storeId").getValue();
	params.endDate = addDate(searchEndDate.getFormValue(), 1);
	params.startDate = searchBeginDate.getFormValue();
    return params;
}
var currType = 0;
function quickSearch(type){
    var params = getSearchParam();
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
            queryname = "本年";
            break;
        case 11:
            params.lastYear = 1;
            params.startDate = getPrevYearStartDate();
            params.endDate = getPrevYearEndDate();
            queryname = "上年";
            break;
        default:
            break;
    }
    searchBeginDate.setValue(params.startDate);
    searchEndDate.setValue(params.endDate);
    currType = type;
    var menunamedate = nui.get("menunamedate");
    menunamedate.setText(queryname);
    doSearch(params);
}
function onSearch(){
	var params = getSearchParam();

    doSearch(params);
}
function doSearch(params)
{
	params.sortField = "audit_date";
	params.sortOrder = "desc";
	params.orderTypeId=2;
    rightGrid.load({
        params:params,
        token:token
    },function(){
        rightGrid.mergeColumns(["serviceId"]);
    });
}
function advancedSearch()
{
    advancedSearchWin.show();
    advancedSearchForm.clear();
    if(advancedSearchFormData)
    {
        advancedSearchForm.setData(advancedSearchFormData);
    }else{
        nui.get("sAuditDate").setValue(getWeekStartDate());
        nui.get("eAuditDate").setValue(addDate(getWeekEndDate(), 1));
    }
}
function onAdvancedSearchOk()
{
	var searchData = advancedSearchForm.getData();
    advancedSearchFormData = {};
    for(var key in searchData)
    {
        advancedSearchFormData[key] = searchData[key];
    }
    var i;
    if(searchData.sOrderDate)
    {
        searchData.sOrderDate = formatDate(searchData.sOrderDate);
    }
    if(searchData.eOrderDate)
    {
        var date = searchData.eOrderDate;
        searchData.eOrderDate = addDate(date, 1);
//        searchData.eOrderDate = searchData.eOrderDate.substr(0,10);
    }
    //审核日期
    if(searchData.sAuditDate)
    {
        searchData.sAuditDate = formatDate(searchData.sAuditDate);
    }
    if(searchData.eAuditDate)
    {
        var date = searchData.eAuditDate;
        searchData.eAuditDate = addDate(date, 1);
        
    }
    //供应商
    if(searchData.guestId)
    {
        searchData.guestId = nui.get("btnEdit2").getValue();
    }
    //订单单号
    if(searchData.serviceIdList)
    {
        var tmpList = searchData.serviceIdList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i].replace(/\s+/g, "")+"'";
        }
        searchData.serviceIdList = tmpList.join(",");
    }
    //订单单号
    if(searchData.manualCodeList)
    {
        var tmpList = searchData.manualCodeList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i].replace(/\s+/g, "")+"'";
        }
        searchData.manualCodeList = tmpList.join(",");
    }
    //配件编码
    if(searchData.partCodeList)
    {
        var tmpList = searchData.partCodeList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i].replace(/(^\s*)|(\s*$)/g, "")+"'";
        }
        searchData.partCodeList = tmpList.join(",");
    }
    if(searchData.rtnableQty == 0)
    {
        delete searchData.rtnableQty;
    }
  //去除空格
    for(var key in searchData){
    	if(searchData[key]!=null && searchData[key]!="" && typeof(searchData[key])=='string'){    		
    		searchData[key]=searchData[key].replace(/(^\s*)|(\s*$)/g, "");
    	}
    }
    advancedSearchWin.hide();
    doSearch(searchData);
}
function onAdvancedSearchCancel(){
    advancedSearchForm.clear();
    advancedSearchWin.hide();
}
var supplier = null;
function selectSupplier(elId)
{
    supplier = null;
    nui.open({
        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.cloud.part.common.customerSelect.flow",
        title: "客户资料", width: 980, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {

        },
        ondestroy: function (action)
        {
            if(action == 'ok')
            {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                supplier = data.customer;
                var value = supplier.id;
                var text = supplier.fullName;
                var el = nui.get(elId);
                el.setValue(value);
                el.setText(text);
            }
        }
    });
}

function onDrawCell(e)
{
    switch (e.field)
    {
	    case "partBrandId":
	        if(partBrandIdHash[e.value])
	        {
	//            e.cellHtml = partBrandIdHash[e.value].name||"";
	        	if(partBrandIdHash[e.value].imageUrl){
	        		
	        		e.cellHtml = "<img src='"+ partBrandIdHash[e.value].imageUrl+ "'alt='配件图片' height='25px' width=' '/><br> "+partBrandIdHash[e.value].name||"";
	        	}else{
	        		e.cellHtml =partBrandIdHash[e.value].name||"";
	        	}
	        }
	        else{
	            e.cellHtml = "";
	        }
	        break;
        case "billTypeId":
            if(billTypeIdHash && billTypeIdHash[e.value])
            {
                e.cellHtml = billTypeIdHash[e.value].name;
            }
            break;
	    case "billStatus":
	        if(billStatusHash && billStatusHash[e.value])
	        {
	            e.cellHtml = billStatusHash[e.value];
	        }
	        break;
        case "enterTypeId":
            if(enterTypeIdHash && enterTypeIdHash[e.value])
            {
                e.cellHtml = enterTypeIdHash[e.value].name;
            }
            break;
        case "settleTypeId":
            if(settTypeIdHash && settTypeIdHash[e.value])
            {
                e.cellHtml = settTypeIdHash[e.value].name;
            }
            break;
        case "storeId":
            if(storehouseHash && storehouseHash[e.value])
            {
                e.cellHtml = storehouseHash[e.value].name;
            }
            break;
        case "orgCarBrandId":
            if(compBrandHash  && compBrandHash[e.value])
            {
                e.cellHtml = compBrandHash[e.value].name;
            }
            break;
        case "businessTypeId":
            if(businessTypeHash && businessTypeHash[e.value])
            {
                e.cellHtml = businessTypeHash[e.value].name;
            }
            break;
        case "enterDayCount":
            var row = e.record;
            var enterTime = (new Date(row.enterDate)).getTime();
            var nowTime = (new Date()).getTime();
            var dayCount = parseInt((nowTime - enterTime) / 1000 / 60 / 60 / 24);
            e.cellHtml = dayCount+1;
            break;
        /*case "costRate":
            e.cellHtml = (e.value).toFixed(2) + '%';
            break;*/
        case "maoLiRate":
            e.cellHtml = (e.value).toFixed(2) + '%';
            break;
        default:
            break;
    }
}

function onPrint(){
	var data=rightGrid.getSelected();
	var params={
			id : data.id,
		auditSign:1,
		guestId : data.guestId,
		currUserName :currUserName,
		currRepairSettorderPrintShow :currRepairSettorderPrintShow,
		currCompAddress :currCompAddress,
		currCompLogoPath : currCompLogoPath,
		currCompTel :currCompTel,
		currOrgName : currOrgName,
		brandHash : partBrandIdHash,
		storeHash : storehouseHash,
		printName : "销售出库单"
	};
	var detailParams={
			mainId :data.id
	};
	var openUrl = webPath + contextPath+"/purchase/sellOrderOut/sellOrderOutPrint.jsp";

    nui.open({
       url: openUrl,
       width: "100%",
       height: "100%",
       showMaxButton: false,
       allowResize: false,
       showHeader: true,
       onload: function() {
           var iframe = this.getIFrameEl();
           iframe.contentWindow.SetData(params,detailParams);
       },
   });
}

function onExport(){
	var detail = nui.clone(rightGrid.getData());
	//多级
	exportMultistage(rightGrid.columns)
	//单级
	//exportNoMultistage(rightGrid.columns)
	for(var i=0;i<detail.length;i++){
		if(businessTypeHash[detail[i].businessTypeId]){
			detail[i].businessTypeId=businessTypeHash[detail[i].businessTypeId].name;
		}
		if(compBrandHash[detail[i].orgCarBrandId]){
			detail[i].orgCarBrandId=compBrandHash[detail[i].orgCarBrandId].name;
		}
		if(storehouseHash[detail[i].storeId]){
			detail[i].storeId=storehouseHash[detail[i].storeId].name;
		}
		if(partBrandIdHash[detail[i].partBrandId]){
			detail[i].partBrandId = partBrandIdHash[detail[i].partBrandId].name;
		}
		if(billTypeIdHash[detail[i].billTypeId]){
			detail[i].billTypeId = billTypeIdHash[detail[i].billTypeId].name;
		}
		if(settTypeIdHash[detail[i].settleTypeId]){
			detail[i].settleTypeId = settTypeIdHash[detail[i].settleTypeId].name;
		}
		if(detail[i].isBilling == 1){
			detail[i].isBilling = "是";
		}else {
			detail[i].isBilling = "否";
		}
		
		
	}
	if(detail && detail.length > 0){
		//多级表头类型
		setInitExportData( detail,rightGrid.columns,"销售出库明细表");
		//单级表头类型 与上二选一
		//setInitExportDataNoMultistage( detail,rightGrid.columns,"调拨受理明细表导出");
	}
}

//function onExport(){
//	var data = rightGrid.getData();
//	if(data && data.length > 0){
//		setInitExportData(data);
//	}
//}

//function setInitExportData(data){
//	var tds = '<td  colspan="1" align="left">[index]</td>' +
//    "<td  colspan='1' align='left'>[manualCode]</td>" +
//    "<td  colspan='1' align='left'>[guestFullName]</td>" +
//    "<td  colspan='1' align='left'>[auditor]</td>" +
//    "<td  colspan='1' align='left'>[billTypeId]</td>" +
//    "<td  colspan='1' align='left'>[settleTypeId]</td>" +
//    "<td  colspan='1' align='left'>[outDate]</td>" +
//    "<td  colspan='1' align='left'>[storeId]</td>" +
//    
//    "<td  colspan='1' align='left'>[comPartCode]</td>" +
//    "<td  colspan='1' align='left'>[comPartName]</td>" +
//    "<td  colspan='1' align='left'>[comOemCode]</td>" +
//    "<td  colspan='1' align='left'>[partBrandId]</td>" +
//    "<td  colspan='1' align='left'>[applyCarModel]</td>"+
//    "<td  colspan='1' align='left'>[outUnitId]</td>"+
//    
//    "<td  colspan='1' align='left'>[sellQty]</td>"+
//    "<td  colspan='1' align='left'>[sellPrice]</td>"+      
//    "<td  colspan='1' align='left'>[sellAmt]</td>" +
//    "<td  colspan='1' align='left'>[rtnableQty]</td>" +
//    "<td  colspan='1' align='left'>[detailRemark]</td>" +
//                      
//    "<td  colspan='1' align='left'>[auditor]</td>" +
//    "<td  colspan='1' align='left'>[auditDate]</td>" +
//    "<td  colspan='1' align='left'>[orgid]</td>";
//	
//	var tableExportContent = $("#tableExportContent");
//    tableExportContent.empty();
//    
//    for(var i = 0 , l = data.length; i < l ; i++){
//    	var row = data[i];
//    	var orgid = null;
//    	for(var j=0;j<currOrgList.length;j++){
//    		if(currOrgList[j].orgid==row.orgid){
//    			orgid = currOrgList[j].shortName || "";
//    		}
//    	}
//    	
//    	var tr = $("<tr></tr>");
//    	tr.append(tds.replace("[index]", i+1)
//                .replace("[manualCode]", row.manualCode || "")
//                .replace("[guestFullName]", row.guestFullName || "")
//                .replace("[auditor]", row.auditor  || "")
//                .replace("[billTypeId]", row.billTypeId?billTypeIdHash[row.billTypeId].name :"")
//                .replace("[settleTypeId]", row.settleTypeId?settTypeIdHash[row.settleTypeId].name :"")     
//                .replace("[outDate]", nui.formatDate(row.outDate?row.outDate:"",'yyyy-MM-dd HH:mm') )
//                .replace("[storeId]", row.storeId?storehouseHash[row.storeId].name : "")
//                
//                .replace("[comPartCode]", row.comPartCode || "")                        
//                .replace("[comPartName]", row.comPartName || "")
//                .replace("[comOemCode]", row.comOemCode || "")
//                .replace("[partBrandId]", row.partBrandId?partBrandIdHash[row.partBrandId].name : "")
//                .replace("[applyCarModel]", row.applyCarModel || "")
//                .replace("[outUnitId]", row.outUnitId || "")
//                
//                .replace("[sellQty]", row.sellQty ||  0)
//                .replace("[sellPrice]", row.sellPrice || 0)
//                .replace("[sellAmt]", row.sellAmt || 0)         
//                .replace("[rtnableQty]", row.rtnableQty || 0)
//                .replace("[detailRemark]", row.detailRemark || "")
//                
//                .replace("[auditor]", row.auditor || "")    
//                .replace("[auditDate]", nui.formatDate(row.auditDate?row.auditDate:"",'yyyy-MM-dd HH:mm') )
//                .replace("[orgid]", orgid || ""));
//    			tableExportContent.append(tr);
//    }
//    var date = new Date();
//    var title = "销售出库明细表";
//    title = title + nui.formatDate(date,'yyyy-MM-dd HH:mm');
//    method5('tableExcel',title,'tableExportA');
//}
