var baseUrl = apiPath + cloudPartApi + "/";
var companyUrl = apiPath + sysApi + "/"+"com.hsapi.system.basic.organization.getCompanyAll.biz.ext";
var mainGridUrl = baseUrl+"com.hsapi.cloud.part.settle.svr.queryNoSettleBill.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.query.queryPjPchsEnterMainDetailList.biz.ext";
var leftGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.query.queryReceiveMainDetails.biz.ext";
var exportUrl= baseUrl + "com.hsapi.cloud.part.invoicing.query.exportReceiveMainDetails.biz.ext";
var orgidsEl =null;
var orgids="";
var mainGrid =null;
var searchBeginDate = null;
var searchEndDate = null;
var leftGrid = null;
var rightGrid =null;
var mainTabs =null;
var allotPayGrid = null;
var allotReceiveGrid = null;
var allotPayGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.allotsettle.queryAllotApplyDetails.biz.ext";
var allotReceiveGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.allotsettle.queryAllotAcceptDetails.biz.ext";

var storehouseHash = {};
var billTypeIdHash = {};
var settTypeIdHash = {};
var enterTypeIdHash = {};
var partBrandIdHash = {};
$(document).ready(function(v) {
	orgidsEl = nui.get("orgids");
	if(currIsMaster!=1){
		orgidsEl.setVisible(false);
	}
	else{
		getCompany();
	}
	
	mainGrid =nui.get("mainGrid");
	mainGrid.setUrl(mainGridUrl);
    searchBeginDate = nui.get("beginDate");
    searchEndDate = nui.get("endDate");
    leftGrid =nui.get("leftGrid");
    rightGrid = nui.get("rightGrid");
    leftGrid.setUrl(leftGridUrl);
    rightGrid.setUrl(rightGridUrl);
    
    allotReceiveGrid =nui.get("allotReceiveGrid");
    allotPayGrid = nui.get("allotPayGrid");
    allotReceiveGrid.setUrl(allotReceiveGridUrl);
    allotPayGrid.setUrl(allotPayGridUrl);
    
    mainTabs =nui.get("mainTabs");
    mainTabs.on("activechanged",function(e){
    	var tab = mainTabs.getActiveTab();
    	var name = tab.name;
        var url = tab.url;

        var params = getSearchParam();
        if(mainGrid.getSelected()){
        	 params.guestId=mainGrid.getSelected().guestId;
        }
        if(name == 'receiveTab'){
        	loadLeftGridData(params);
        }
        else if(name== 'payTab'){
        	loadRightGridData(params);
        }
        else if(name== 'allotReceiveTab'){
        	loadAllotReceiveGridData(params);
        }
        else if(name== 'allotPayTab'){
        	loadAllotPayGridData(params);
        }
    });
    
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
     //   nui.get("storeId").setData(storehouse);
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
            }
        });
    });
    quickSearch(2);
});

function getCompany(){
	var params = {};
	nui.ajax({
        url: companyUrl,
        type: 'post',
        async:false,
        data: nui.encode({
        	params: params,
            token: token
        }),
        cache: false,
        success: function (data) {
            if (data.errCode == "S"){
            	var orgList =data.companyList;
            	orgidsEl = nui.get("orgids");
                orgidsEl.setData(data.companyList);
                orgList.forEach(function(v){
                	orgids =orgids+v.orgid+","
                });
                orgids = orgids.substring(0,orgids.length-1);
            }else {
            	orgidsEl = nui.get("orgids");
                orgidsEl.setData([]);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
        }
	});
}

function getSearchParam(){
    var params = {};

    params.sCreateDate = searchBeginDate.getFormValue();
    params.eCreateDate = searchEndDate.getFormValue();
    params.guestName =nui.get('guestName').getValue().replace(/\s+/g, "");
    params.orgid =nui.get('orgids').getValue();
    if(!params.orgid){
    	params.orgid =null;
    	params.orgids=orgids;
    }
    params.tenantId =currTenantId;
    //非总部
    if(orgidsEl.visible==false){
    	params.orgid =currOrgid;
    	params.orgids=null;
    	params.tenantId =null;
    }
    params.isState = 0;
//    params.settleTypeId='020502';
	params.auditSign=1;
    return params;
}
var currType = 2;
function quickSearch(type){
    var params = getSearchParam();
    var queryname = "全部";
    switch (type)
    {
        case 0:
//            params.today = 1;
            params.sCreateDate =  null;
            params.eCreateDate = null;
            var queryname = "全部";
            break;
        case 1:
            params.yesterday = 1;
            params.sCreateDate = getPrevStartDate();
            params.eCreateDate = addDate(getPrevEndDate(), 1);
            var queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.sCreateDate = getWeekStartDate();
            params.eCreateDate = addDate(getWeekEndDate(), 1);
            var queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.sCreateDate = getLastWeekStartDate();
            params.eCreateDate = addDate(getLastWeekEndDate(), 1);
            var queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.sCreateDate = getMonthStartDate();
            params.eCreateDate = addDate(getMonthEndDate(), 1);
            var queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.sCreateDate = getLastMonthStartDate();
            params.eCreateDate = addDate(getLastMonthEndDate(), 1);
            var queryname = "上月";
            break;
        case 10:
            params.thisYear = 1;
            params.sCreateDate = getYearStartDate();
            params.eCreateDate = getYearEndDate();
            var queryname = "本年";
            break;
        case 11:
            params.lastYear = 1;
            params.sCreateDate = getPrevYearStartDate();
            params.eCreateDate = getPrevYearEndDate();
            var queryname = "上年";
            break;
        default:
            break;
    }
    searchBeginDate.setValue(params.sCreateDate);
    searchEndDate.setValue(params.eCreateDate);
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
	mainGrid.load({
        params:params,
        token: token
    },function(){
    	var tab = mainTabs.getActiveTab();
    	var name = tab.name;
        var url = tab.url;

        if(mainGrid.getSelected()){
       	 	params.guestId=mainGrid.getSelected().guestId;
        }
        if(name == 'receiveTab'){
        	loadLeftGridData(params);
        }
        else if(name== 'payTab'){
        	loadRightGridData(params);
        }
        else if(name== 'allotReceiveTab'){
        	loadAllotReceiveGridData(params);
        }
        else if(name== 'allotPayTab'){
        	loadAllotPayGridData(params);
        }
    });
	
	
}

function loadRightGridData(params){
	params.sortField ="a.audit_date";
	params.sortOrder ="desc";
    rightGrid.load({
        params:params,
        token:token
    });
}

function loadLeftGridData(params){
	params.sortField ="a.audit_date";
	params.sortOrder ="desc";
    leftGrid.load({
        params:params,
        token:token
    });
}

function loadAllotReceiveGridData(params){
    params.isDiffOrder = 1;
	params.sortField = "audit_date";
	params.sortOrder = "desc";
	allotReceiveGrid.load({
        params:params,
        token:token
    });
}
function loadAllotPayGridData(params){
    params.isDiffOrder = 1;
	params.sortField = "audit_date";
	params.sortOrder = "desc"
    allotPayGrid.load({
        params:params,
        token:token
    });
}

function onDrawCell(e){
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
        case "enterDayCount":
            var row = e.record;
            var enterTime = (new Date(row.enterDate)).getTime();
            var nowTime = (new Date()).getTime();
            var dayCount = parseInt((nowTime - enterTime) / 1000 / 60 / 60 / 24);
            e.cellHtml = dayCount+1;
            break;
        default:
            break;
    }
}

function onMainDrawCell(e){
	switch (e.field)
    {
	    case "rAmt":
	    	if(e.value==null || e.value==""){
	    		 e.cellHtml = 0;
	    	     e.value = 0;
	    	}
	    		
	        break;
        case "pAmt":
        	if(e.value==null || e.value==""){
        		 e.cellHtml = 0;
	    	     e.value = 0;
        	}
	    		
            break;
        case "billAmt":
        	if(e.value==null || e.value==""){
       		 	e.cellHtml = 0;
	    	    e.value = 0;
        	}
        	e.cellHtml = (e.record.rAmt + e.record.pAmt).toFixed(2);
   	        e.value = (e.record.rAmt + e.record.pAmt).toFixed(2);
            break;
        default:
            break;
    }
}
var sumPAmt ="";
var sumRAmt = "";
function onDrawSummaryCell(e) {
	var rows = e.data;// rightGrid.getData();
	
	if (e.field == "rAmt") {
		sumRAmt=e.value;
	}
	if (e.field == "pAmt") {
		sumPAmt =e.value;
	}
	if (e.field == "billAmt") {
		e.value= sumRAmt + sumPAmt;
		e.cellHtml=e.value;  
	}
}

function onMainGridClick(e){
	var row = e.row;
	var guestId = row.guestId ||0;
	if(guestId>0){
		var tab = mainTabs.getActiveTab();
		var name = tab.name;
	    var url = tab.url;
	    var params = getSearchParam();
	    params.guestId = guestId;
	    if(name == 'receiveTab'){
	    	loadLeftGridData(params);
	    }
	    else if(name== 'payTab'){
	    	loadRightGridData(params);
	    }
	    else if(name== 'allotReceiveTab'){
	    	loadAllotReceiveGridData(params);
	    }
	    else if(name== 'allotPayTab'){
	    	loadAllotPayGridData(params);
	    }
	}else{
		rightUnifyGrid.setData([]);
	}
}


function onExport(){
	$.ajaxSettings.async = false;
	var leftRows=leftGrid.getData();
	if(!mainGrid.getSelected()){
		return;
	}
	if(leftRows.length<0){
		return;	
	}
	var params = getSearchParam();
    params.guestId = mainGrid.getSelected().guestId;
    nui.ajax({
        url: exportUrl,
        type: 'post',
        async:false,
        data: nui.encode({
        	params: params,
        	page :{length:1000,size:1000},
            token: token
        }),
        cache: false,
        success: function (data) {
        	detail =data.detailList;    	
        	if(detail && detail.length > 0){
        		setInitExportData(detail);
        	}
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
        }
	});
  
}

function setInitExportData(detail){

    var tds = '<td  colspan="1" align="left">[guestFullName]</td>' +
        "<td  colspan='1' align='left'>[orgName]</td>" +
        "<td  colspan='1' align='left'>[carBrandName]</td>" +
        "<td  colspan='1' align='left'>[serviceId]</td>" +
        "<td  colspan='1' align='left'>[outDate]</td>" +
        "<td  colspan='1' align='left'>[showPartCode]</td>" +
        "<td  colspan='1' align='left'>[showFullName]</td>" +
        "<td  colspan='1' align='left'>[orderQty]</td>"+
        "<td  colspan='1' align='left'>[showPrice]</td>"+
        "<td  colspan='1' align='left'>[showAmt]</td>" ;
    var tableExportContent = $("#tableExportContent");
    tableExportContent.empty();
    for (var i = 0; i < detail.length; i++) {
        var row = detail[i];
        if(row.showPartId){
            var tr = $("<tr></tr>");
            tr.append(tds.replace("[guestFullName]", detail[i].guestFullName?detail[i].guestFullName:"")
                         .replace("[orgName]", detail[i].orgName?detail[i].orgName:"")
                         .replace("[carBrandName]", detail[i].carBrandName?detail[i].carBrandName:"")
                         .replace("[serviceId]", detail[i].serviceId?detail[i].serviceId:"")
                         .replace("[outDate]", detail[i].outDate?format(detail[i].outDate,"yyyy-MM-dd HH:mm"):"")
                         .replace("[showPartCode]", detail[i].showPartCode?detail[i].showPartCode:"")
                         .replace("[showFullName]", detail[i].showFullName?detail[i].showFullName:"")
                         .replace("[orderQty]", detail[i].orderQty?detail[i].orderQty:"")
                         .replace("[showPrice]", detail[i].showPrice?detail[i].showPrice:"")
                         .replace("[showAmt]", detail[i].showAmt?detail[i].showAmt:""));
            tableExportContent.append(tr);
        }
    }

    method5('tableExcel',"未对账应收单",'tableExportA');
}

//重写toFixed方法,解决精度问题
Number.prototype.toFixed = function (n) {
    if (n != undefined && (isNaN(n) || Number(n) > 17 || Number(n) < 0)) {
        throw new Error("输入正确的精度范围");
    }
    // 拆分小数点整数和小数
    var num = this;
    var numList = num.toString().split(".");
    // 整数
    var iN = numList[0];
    // 小数
    var dN = numList[1];
    n = parseInt(n);
    if (isNaN(n) || Number(n) === 0) {
        // 0或者不填的时候，按0来处理
        if (dN === undefined) {
            return num + '';
        }
        var idN = Number(dN.toString().substr(0, 1));
        if (idN >= 5) {
            iN += 1;
        }
        return iN;
    } else {
        var dNL = dN === undefined ? 0 : dN.length;
        if (dNL < n) {
            // 如果小数位不够的话，那就补全
             var oldN = num.toString().indexOf('.') > -1 ? num : num + '.';
            var a = Number(n) - dNL;
            while (a > 0) {
                oldN += '0';
                a--;
            }
            return oldN;
        }
        // 正常
        var dN1 = Number(dN.toString().substring(0, n));
        var dN2 = Number(dN.toString().substring(n, n + 1));
        if (dN2 >= 5) {
            dN1 += 1;
        }
        while (dN1.toString().length < n) {
            dN1 = '0' + dN1;
            dN1.toString().length++;
        }
        return iN + '.' + dN1;
    }
}
