/**
 * Created by Administrator on 2018/2/1.
 */
var baseUrl = apiPath + cloudPartApi + "/";//apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.query.queryPjSellOutRtnMainDetailList.biz.ext";
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
		rtnPrice : "退货单价",
		rtnAmt : "退货金额",
		settleGuestRebateAmt : "结算单位返点",
		businessTypeRebateAmt : "销售类型返点",
		showPrice : "开单单价",
		showAmt : "开单金额",
		maoLi : "毛利",
		maoLiRate : "毛利率",
		enterPrice : "成本单价",
		enterAmt : "成本金额",
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
        dictIdList.push('10444');//入库类型
        dictIdList.push('10445');//入库类型
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
                
                compBrandList = dataItems.filter(function(v)
                {
                    if(v.dictid == "10444")
                    {
                    	compBrandHash[v.customid] = v;
                        return true;
                    }
                });
                nui.get("orgCarBrandId").setData(compBrandList);
                
                businessTypeList = dataItems.filter(function(v)
                {
                    if(v.dictid == "10445")
                    {
                    	businessTypeHash[v.customid] = v;
                        return true;
                    }
                });
                nui.get("businessTypeId").setData(businessTypeList);
                
                getAllPartBrand(function(data)
        	    {
        	        var partBrandList = data.brand;
        	        partBrandList.forEach(function(v)
        	        {
        	            partBrandIdHash[v.id] = v;
        	        });
        	        
        	        getResBtnAuth("cloudSellRtnQuery_set",function(data) {
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
        	        
        	    });
                
            }
        });
    });
});
function getSearchParam(){
    var params = {};
    var outableQty = nui.get("outableQty").getValue();
    if(outableQty == 1)
    {
        params.outableQty = 1;
    }
    params.serviceId = comServiceId.getValue().replace(/\s+/g, "");
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
    if(searchData.outableQty == 0)
    {
        delete searchData.outableQty;
    }
  //去除空格
    for(var key in searchData){
    	if(searchData[key]!=null && searchData[key]!="" && typeof(searchData[key])=='string'){    		
    		searchData[key]=searchData[key].replace(/\s+/g, "");
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
        title: "供应商资料", width: 980, height: 560,
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


function onExport(){
	var detail = nui.clone(rightGrid.getData());
	//多级
	exportMultistage(rightGrid.columns)
	//单级
	//exportNoMultistage(rightGrid.columns)
	for(var i=0;i<detail.length;i++){
		if(storehouseHash[detail[i].storeId]){
			detail[i].storeId=storehouseHash[detail[i].storeId].name;
		}
		if(partBrandIdHash[detail[i].partBrandId]){
			detail[i].partBrandId = partBrandIdHash[detail[i].partBrandId].name;
		}
		if(compBrandHash[detail[i].orgCarBrandId]){
			detail[i].orgCarBrandId=compBrandHash[detail[i].orgCarBrandId].name;
		}
		if(billTypeIdHash[detail[i].billTypeId]){
			detail[i].billTypeId = billTypeIdHash[detail[i].billTypeId].name;
		}
		if(settTypeIdHash[detail[i].settleTypeId]){
			detail[i].settleTypeId = settTypeIdHash[detail[i].settleTypeId].name;
		}
		if(detail[i].taxSign == 1){
			detail[i].taxSign = "是";
		}else {
			detail[i].taxSign = "否";
		}
		
	}
	if(detail && detail.length > 0){
		//多级表头类型
		setInitExportData( detail,rightGrid.columns,"销售退货明细表");
		//单级表头类型 与上二选一
		//setInitExportDataNoMultistage( detail,rightGrid.columns,"调拨受理明细表导出");
	}
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
        case "maoLiRate":
            e.cellHtml = (e.value).toFixed(2) + '%';
            break;
        default:
            break;
    }
}