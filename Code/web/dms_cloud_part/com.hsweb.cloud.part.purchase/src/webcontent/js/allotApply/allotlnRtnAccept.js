var baseUrl = apiPath + cloudPartApi + "/";
var companyUrl = apiPath + sysApi + "/"+"com.hsapi.system.basic.organization.getCompanyAll.biz.ext";
var mainGridUrl =baseUrl+"com.hsapi.cloud.part.invoicing.allotsettle.queryPjAllotAcceptMains.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.allotsettle.getAllotAcceptDetailById.biz.ext";
var orgidsEl =null;
var orgids="";
var mainGrid =null;
var searchBeginDate = null;
var searchEndDate = null;
var rightGrid =null;

var storehouseHash = {};
var billTypeIdHash = {};
var settTypeIdHash = {};
var enterTypeIdHash = {};
var partBrandIdHash = {};
var statusList=[{"id":0,"name":"全部"},{"id":1,"name":"待受理"},{"id":2,"name":"部分受理"},{"id":3,"name":"全部受理"},{"id":4,"name":"已拒绝"}];
var statusHash={"1":"待受理","2":"部分受理","3":"全部受理","4":"已拒绝"};

$(document).ready(function(v) {
	orgidsEl = nui.get("orgids");
	getCompany();
	mainGrid =nui.get("mainGrid");
	mainGrid.setUrl(mainGridUrl);
    searchBeginDate = nui.get("beginDate");
    searchEndDate = nui.get("endDate");
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    nui.get("status").setData(statusList);
    nui.get("status").setValue(1);
   
    
    getStorehouse(function(data)
    {
        var storehouse = data.storehouse||[];
        nui.get("storeId").setData(storehouse);

        if(storehouse && storehouse.length>0){
            nui.get('storeId').setValue(storehouse[0].id);
            storehouse.forEach(function(v){
                storehouseHash[v.id]=v;
            });
        }
        
    });
    quickSearch(3);
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

    //params.sAuditDate = searchBeginDate.getFormValue();
    //params.eAuditDate  = searchEndDate.getFormValue();
    //审核日期
    if(searchBeginDate.getFormValue())
    {
        params.sAuditDate = formatDate(new Date(searchBeginDate.getFormValue()));
    }
    if(searchEndDate.getFormValue())
    {
        var date = new Date(searchEndDate.getFormValue());
        params.eAuditDate = addDate(date, 1);
        
    }

    params.guestName =nui.get('guestName').getValue().replace(/\s+/g, "");
    params.orgid =nui.get('orgids').getValue();
    params.status = nui.get("status").getValue();
    if(params.status ==0){
    	 params.status=null;
    }
    params.auditSign=1;
    params.guestOrgId = currOrgId;
    params.tenantId =currTenantId;
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
            params.sAuditDate  =  null;
            params.eAuditDate  = null;
            var queryname = "全部";
            break;
        case 1:
            params.yesterday = 1;
            params.sAuditDate  = getPrevStartDate();
            params.eAuditDate  = addDate(getPrevEndDate(), 1);
            var queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.sAuditDate  = getWeekStartDate();
            params.eAuditDate  = addDate(getWeekEndDate(), 1);
            var queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.sAuditDate  = getLastWeekStartDate();
            params.eAuditDate  = addDate(getLastWeekEndDate(), 1);
            var queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.sAuditDate  = getMonthStartDate();
            params.eAuditDate  = addDate(getMonthEndDate(), 1);
            var queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.sAuditDate  = getLastMonthStartDate();
            params.eAuditDate  = addDate(getLastMonthEndDate(), 1);
            var queryname = "上月";
            break;
        case 10:
            params.thisYear = 1;
            params.sAuditDate = getYearStartDate();
            params.eAuditDate = getYearEndDate();
            var queryname = "本年";
            break;
        case 11:
            params.lastYear = 1;
            params.sAuditDate = getPrevYearStartDate();
            params.eAuditDate = getPrevYearEndDate();
            var queryname = "上年";
            break;
        default:
            break;
    }
    searchBeginDate.setValue(params.sAuditDate);
    searchEndDate.setValue(params.eAuditDate);
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
    });
	
    
}

function onMainGridSelectionChanged() {
	var row = mainGrid.getSelected();

	loadRightGridData(row);
}

function loadRightGridData(row){
	var params ={};
	params.mainId = row.id;
	params.sortField ="a.audit_date";
	params.sortOrder ="desc";
    rightGrid.load({
        mainId:row.id,
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

var auditUrl = baseUrl+"com.hsapi.cloud.part.invoicing.allotsettle.generateAllotOutRtn.biz.ext";
function audit(){
	var row =mainGrid.getSelected();
	if(!row){
		showMsg("请选择一条单据","W");
		return;
	}

    if(!nui.get('storeId').getValue()) {
        showMsg("请选择受理仓库","W");
        return;
    }
	
	if(row.status != 1){
		showMsg("单据状态为待受理时才可以受理","W");
		return;
	}
	
	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : "受理中"
	});
	nui.ajax({
		url : auditUrl,
		type : "post",
		data : JSON.stringify({
			mainId :  row.id,
            storeId : nui.get('storeId').getValue(),
			token: token
		}),
		success : function(data) {
			nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
				showMsg("受理成功，生成的受理单号为：" + data.serviceId ||data.errMsg,"S");
				var newRow = {status: 3};
				mainGrid.updateRow(row, newRow);
			} else {
				showMsg(data.errMsg || ("受理失败!"),"W");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}

var refuseUrl=baseUrl+"com.hsapi.cloud.part.invoicing.allotsettle.refuseAllotInRtn.biz.ext";
function refuse(){
	var row =mainGrid.getSelected();
	if(row.status !=1){
		showMsg("单据状态为待受理才可以拒绝","W");
		return;
	}
	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : "拒绝中"
	});
	nui.ajax({
		url : refuseUrl,
		type : "post",
		data : JSON.stringify({
			mainId : row.id,
			token: token
		}),
		success : function(data) {
			nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
				showMsg("拒绝成功!"||data.errMsg,"S");
				var newRow = {status: 4};
                mainGrid.updateRow(row, newRow);
			} else {
				showMsg(data.errMsg || ("拒绝失败!"),"W");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}

function onMainDrawCell(e){
	switch (e.field)
    {
	   
        case "status":
            if(statusHash && statusHash[e.value])
            {
                e.cellHtml = statusHash[e.value];
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