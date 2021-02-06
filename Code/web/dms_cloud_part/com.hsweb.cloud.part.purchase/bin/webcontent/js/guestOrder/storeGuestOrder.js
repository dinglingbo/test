var baseUrl = apiPath + cloudPartApi + "/";
var companyUrl = apiPath + sysApi + "/"+"com.hsapi.system.basic.organization.getCompanyAll.biz.ext";
var mainGridUrl =baseUrl+"com.hsapi.cloud.part.invoicing.guestOrder.queryGuestOrderMainList.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.guestOrder.getPjGuestOrderDetailListByMainId.biz.ext";
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
var statusList=[{"id":0,"name":"全部"},{"id":1,"name":"已提交"},{"id":2,"name":"已受理"},{"id":3,"name":"已完成"}];
var statusHash={"1":"已提交","2":"已受理","3":"已完成"};
var FStoreId = null;

$(document).ready(function(v) {
	orgidsEl = nui.get("orgids");
	//getCompany();
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
            
            getAllPartBrand(function(data)
    	    {
    	        var partBrandList = data.brand;
    	        partBrandList.forEach(function(v)
    	        {
    	            partBrandIdHash[v.id] = v;
    	        });
    	        
    	        quickSearch(2);
    	        
    	    });
            
        });
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

    params.sAuditDate = searchBeginDate.getFormValue();
    params.eAuditDate  = searchEndDate.getFormValue();
    params.guestName =nui.get('guestName').getValue().replace(/\s+/g, "");
    params.orgid =nui.get('orgids').getValue();
    params.status = nui.get("status").getValue();
    //全部
    if(params.status == 0){
    	params.status = null;
    }
    params.auditSign=1;
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
	/*if(currIsMaster !=1){
		showMsg("总部才可以受理","W");
		return;
	}*/
	if(row.status !=1){
		showMsg("单据状态为已提交才可以受理","W");
		return;
	}
	var rows =rightGrid.getData();
	for(var i=0;i<rows.length;i++){
		rows[i].prevDetailId = rows[i].id;
		//rows[i].id =rows[i].partId;
		//rows[i].name = rows[i].partName;
		//rows[i].unit = rows[i].systemUnitId;	
	}
	var main={};
	main.orderType =3;
	main.orderMan =currUserName;
	main.orderManId =currUserId;
	main.code =row.serviceId;
	main.codeId = row.id;
	main.sourceType =5;
//	main.directGuestId=row.guestId;
	main.directOrgid =row.orgid;
	main.storeId = row.storeId;
	openGeneratePop(main,rows, "pchsOrder", "受理"+row.orgName+"的预销售单");
}

function openGeneratePop(main,partList, type, title){
	
    nui.open({
//        // targetWindow: window,,
        url : webPath+contextPath+"/com.hsweb.cloud.part.common.shopCarPop.flow?token="+token,
        title : title,
        width : 600,
        height : 400,
        allowDrag : true,
        allowResize : true,
        onload : function() {
            var iframe = this.getIFrameEl();
            var params = {
            	main : main,
            	storeId : main.storeId,
                partList: partList,
                type: type
            };
            iframe.contentWindow.setInitData(params);
        },
        ondestroy : function(action) {
            if (action == 'ok') {
                var iframe = this.getIFrameEl();
                mainGrid.removeRow(mainGrid.getSelected());
                rightGrid.setData([]);
                //var data = iframe.contentWindow.getData();
            }
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


var delUrl = baseUrl+"com.hsapi.cloud.part.invoicing.guestOrder.updateGuestOrderDisabled.biz.ext";
function del()
{
	var row =mainGrid.getSelected();
	if(!row){
		showMsg("请选择一条单据","W");
		return;
	}
	if(row.status != 1){
		showMsg("单据状态为已提交才可以作废","W");
		return;
	}
   
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '处理中...'
    });

    nui.ajax({
        url : delUrl,
        type : "post",
        data : JSON.stringify({
            mainId : row.id,
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


