/**
 * Created by Administrator on 2018/2/1.
 */
var rightGridUrl = cloudPartApiUrl+"com.hsapi.cloud.part.invoicing.query.queryPjPchsOrderMainDetailList.biz.ext";
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
    getAllPartBrand(function(data)
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
                var settTypeIdList = dataItems.filter(function(v)
                {
                    if(v.dictid == "DDT20130703000035")
                    {
                        settTypeIdHash[v.customid] = v;
                        return true;
                    }
                });
                quickSearch(currType);
            }
        });
    });
});
function getSearchParam(){
    var params = {};
    /*var outableQtyGreaterThanZero = nui.get("outableQtyGreaterThanZero").getValue();
    if(outableQtyGreaterThanZero == 1)
    {
        params.outableQtyGreaterThanZero = 1;
    }*/
    params.serviceId = comServiceId.getValue().replace(/\s+/g, "");
	params.partCode = comPartCode.getValue().replace(/\s+/g, "");
	params.partNameAndPY = comPartNameAndPY.getValue().replace(/\s+/g, "");
	params.guestId = comSearchGuestId.getValue();
	params.endDate = searchEndDate.getFormValue();
	params.startDate = searchBeginDate.getFormValue();
    return params;
}
var currType = 2;
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
    params.orderTypeId = 1;
    params.isFinished = 1;
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
    if(searchData.sCreateDate)
    {
        searchData.sCreateDate = formatDate(searchData.sCreateDate);
    }
    if(searchData.eCreateDate)
    {
        var date = searchData.eCreateDate;
        searchData.eCreateDate = addDate(date, 1);
        
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
    //配件编码
    if(searchData.partCodeList)
    {
        var tmpList = searchData.partCodeList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i].replace(/\s+/g, "")+"'";
        }
        searchData.partCodeList = tmpList.join(",");
    }
    /*if(searchData.outableQtyGreaterThanZero == 0)
    {
        delete searchData.outableQtyGreaterThanZero;
    }*/
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
        url: webPath+contextPath+"/com.hsweb.cloud.part.common.guestSelect.flow?token="+token,
        title: "供应商资料", width: 980, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var params = {
                isSupplier: 1,
                guestType:'01020202'
            };
            iframe.contentWindow.setGuestData(params);
        },
        ondestroy: function (action)
        {
            if(action == 'ok')
            {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                supplier = data.supplier;
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
        case "billTypeId":
            if(billTypeIdHash && billTypeIdHash[e.value])
            {
                e.cellHtml = billTypeIdHash[e.value].name;
            }
            break;
        case "settelTypeId":
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
        default:
            break;
    }
}

function onPrint(){
	var data=rightGrid.getSelected();
	var params={
			id : data.codeId,
		auditSign:1,
		guestId : data.guestId,
		currUserName :currUserName,
		currRepairSettorderPrintShow :currRepairSettorderPrintShow,
		currCompAddress :currCompAddress,
		currCompLogoPath : currCompLogoPath,
		currCompTel :currCompTel,
		currOrgName : currOrgName,
		brandHash : partBrandIdHash,
		storeHash : storehouseHash
	};
	var detailParams={
			mainId :data.codeId
	};
	var openUrl = webPath + contextPath+"/purchase/purchaseOrderEnter/purchaseOrderEnterPrint.jsp";

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
	var data = rightGrid.getData();
	if(data && data.length > 0){
		setInitExportData(data);
	}
}

function setInitExportData(data){
	var tds = '<td  colspan="1" align="left">[index]</td>' +
    "<td  colspan='1' align='left'>[manualCode]</td>" +
    "<td  colspan='1' align='left'>[guestFullName]</td>" +
    "<td  colspan='1' align='left'>[orderMan]</td>" +
    "<td  colspan='1' align='left'>[billTypeId]</td>" +
    "<td  colspan='1' align='left'>[settleTypeId]</td>" +
    "<td  colspan='1' align='left'>[enterDate]</td>" +
    "<td  colspan='1' align='left'>[storeId]</td>" +
    
    "<td  colspan='1' align='left'>[comPartCode]</td>" +
    "<td  colspan='1' align='left'>[comPartName]</td>" +
    "<td  colspan='1' align='left'>[comOemCode]</td>" +
    "<td  colspan='1' align='left'>[partBrandId]</td>" +
    "<td  colspan='1' align='left'>[applyCarModel]</td>"+
    "<td  colspan='1' align='left'>[enterUnitId]</td>"+
    
    "<td  colspan='1' align='left'>[enterQty]</td>"+
    "<td  colspan='1' align='left'>[enterPrice]</td>"+      
    "<td  colspan='1' align='left'>[enterAmt]</td>" +
    "<td  colspan='1' align='left'>[outableQty]</td>" +
    "<td  colspan='1' align='left'>[detailRemark]</td>" +
    
    "<td  colspan='1' align='left'>[suggSellPrice]</td>" +                     
    "<td  colspan='1' align='left'>[auditor]</td>" +
    "<td  colspan='1' align='left'>[auditDate]</td>" +
    "<td  colspan='1' align='left'>[orgid]</td>";
	
	var tableExportContent = $("#tableExportContent");
    tableExportContent.empty();
    
    for(var i = 0 , l = data.length; i < l ; i++){
    	var row = data[i];
    	var orgid = null;
    	for(var j=0;j<currOrgList.length;j++){
    		if(currOrgList[j].orgid==row.orgid){
    			orgid = currOrgList[j].shortName || "";
    		}
    	}
    	
    	var tr = $("<tr></tr>");
    	tr.append(tds.replace("[index]", i+1)
                .replace("[manualCode]", row.manualCode || "")
                .replace("[guestFullName]", row.guestFullName || "")
                .replace("[orderMan]", row.orderMan  || "")
                .replace("[billTypeId]", row.billTypeId?billTypeIdHash[row.billTypeId].name :"")
                .replace("[settleTypeId]", row.settleTypeId?settTypeIdHash[row.settleTypeId].name :"")     
                .replace("[enterDate]", nui.formatDate(row.enterDate?row.enterDate:"",'yyyy-MM-dd HH:mm') )
                .replace("[storeId]", row.storeId?storehouseHash[row.storeId].name : "")
                
                .replace("[comPartCode]", row.comPartCode || "")                        
                .replace("[comPartName]", row.comPartName || "")
                .replace("[comOemCode]", row.comOemCode || "")
                .replace("[partBrandId]", row.partBrandId?partBrandIdHash[row.partBrandId].name : "")
                .replace("[applyCarModel]", row.applyCarModel || "")
                .replace("[enterUnitId]", row.enterUnitId || "")
                
                .replace("[enterQty]", row.enterQty ||  0)
                .replace("[enterPrice]", row.enterPrice || 0)
                .replace("[enterAmt]", row.enterAmt || 0)         
                .replace("[outableQty]", row.outableQty || 0)
                .replace("[detailRemark]", row.detailRemark || "")
                
                .replace("[suggSellPrice]", row.suggSellPrice || 0)
                .replace("[auditor]", row.auditor || "")    
                .replace("[auditDate]", nui.formatDate(row.auditDate?row.auditDate:"",'yyyy-MM-dd HH:mm') )
                .replace("[orgid]", orgid || ""));
    			tableExportContent.append(tr);
    }
    var date = new Date();
    var title = "采购入库明细表";
    title = title + nui.formatDate(date,'yyyy-MM-dd HH:mm');
    method5('tableExcel',title,'tableExportA');
}
