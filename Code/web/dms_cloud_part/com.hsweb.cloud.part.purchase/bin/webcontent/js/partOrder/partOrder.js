var baseUrl = apiPath + cloudPartApi + "/";
var companyUrl = apiPath + sysApi + "/"+"com.hsapi.system.basic.organization.getCompanyAll.biz.ext";
var mainGridUrl =baseUrl+"com.hsapi.cloud.part.invoicing.partOrder.queryPartOrderMainList.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.partOrder.getPartOrderDetailListByMainId.biz.ext";
var orgidsEl =null;
var orgids="";
var orgHash={};
var mainGrid =null;
var searchBeginDate = null;
var searchEndDate = null;
var rightGrid =null;
var FGuestId = -1;

var storehouseHash = {};
var billTypeIdHash = {};
var settTypeIdHash = {};
var enterTypeIdHash = {};
var partBrandIdHash = {};
var statusList=[{"id":0,"name":"未受理"},{"id":1,"name":"已受理"},{"id":2,"name":"已拒绝"},{"id":3,"name":"全部"}];
var statusHash={"0":"未受理","1":"已受理","2":"已拒绝"};
var FStoreId = null;

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
    nui.get("status").setValue(0);
   
    getStorehouse(function(data)
    {
        var storehouse = data.storehouse||[];
     //   nui.get("storeId").setData(storehouse);
        if(storehouse.length>0){
        	  FStoreId = storehouse[0].id;
        }      
        storehouse.forEach(function(v)
        {
            if(v && v.id)
            {
                storehouseHash[v.id] = v;
            }
        });
        
        getAllPartBrand(function(data)
	    {
	        var partBrandList = data.brand;
	        partBrandList.forEach(function(v)
	        {
	            partBrandIdHash[v.id] = v;
	        });
	        
	        getGuestId(null, function() {
	        	 quickSearch(2);
	        });
	        
	       
	        
	    });

        /*var dictIdList = [];
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
            
            
            
        });*/
    });
    
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
                	orgHash[v.orgid]=v;
                });
                //orgids = orgids.substring(0,orgids.length-1);
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
    params.guestId = FGuestId;
    params.sAuditDate = searchBeginDate.getFormValue();
    params.eAuditDate  = searchEndDate.getFormValue();
    params.orgid =nui.get('orgids').getValue();
    params.acceptStatus = nui.get("status").getValue();
    //全部
    if(params.acceptStatus == 3){
    	params.acceptStatus = null;
    }
    params.auditSign=1;
    //params.tenantId =currTenantId;
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
	/*if(currIsMaster !=1){
		showMsg("总部才可以查看此界面","W");
		return;
	}*/
	mainGrid.load({
        params:params,
        token: token
    });
	rightGrid.clearRows();
    
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

function audit(){
	var row =mainGrid.getSelected();
	if(!row){
		showMsg("请选择一条单据","W");
		return;
	}

	if(row.acceptStatus !=0){
		showMsg("未受理状态才可以受理","W");
		return;
	}
	

	var guestId = getGuestId(row.orgid, null);
	if(guestId == null) {
		showMsg("客户未添加到往来单位，不能受理","W");
		return;
	}
	
	var rows =rightGrid.getData();
	for(var i=0;i<rows.length;i++){
		rows[i].unit = rows[i].enterUnitId;	
	}
	
	var main={};
	main.guestId = guestId;
	main.storeId = FStoreId;
	main.billTypeId = row.billTypeId;
	main.settleTypeId = row.settleTypeId;
	main.remark = row.remark;

	generateSell(row.id, "agree", main, rows);
}


function del()
{
	var row =mainGrid.getSelected();
	if(!row){
		showMsg("请选择一条单据","W");
		return;
	}
	if(row.acceptStatus != 0){
		showMsg("未受理状态才可以拒绝","W");
		return;
	}
   
	generateSell(row.id, "refuse", null, null);
}


var geneUrl = baseUrl+"com.hsapi.cloud.part.invoicing.partOrder.acceptPartOrder.biz.ext";
function generateSell(orderId, type, main, detail)
{
	
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '处理中...'
    });

    nui.ajax({
        url : geneUrl,
        type : "post",
        data : JSON.stringify({
        	orderId : orderId,
        	type: type,
        	main: main,
        	detail: detail,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                showMsg("操作成功!","S");
               
                onSearch();

            } else {
                showMsg(data.errMsg || "操作失败!","W");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
        	nui.unmask(document.body);
            console.log(jqXHR.responseText);
        }
    });
}

var guestUrl = baseUrl + "com.hsapi.cloud.part.common.svr.getGuestByInternalId.biz.ext";
function getGuestId(orgid, callback) {
	var guestId = null;
    nui.ajax({
        url : guestUrl,
        async:false,
        type : "post",
        data : JSON.stringify({
        	params:{
        		orgid:orgid
        	},
        	token:token
        }),
        success : function(data) {
            data = data || {};
            if (data.guest) {
                var guest = data.guest;
                if(orgid == null) {
	                FGuestId = guest.id;
	            }
                
                guestId = guest.id;
                
                if(callback) {
	                callback();
	            }

            } else {
                console.log(data.errMsg);
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
        }
    });
    return guestId;
}

function onMainDrawCell(e){
	switch (e.field)
    {
	    case "orgid":
	        if(orgHash && orgHash[e.value])
	        {
	            e.cellHtml = orgHash[e.value].shortName;
	        }
	        break;
        case "acceptStatus":
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
