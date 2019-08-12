var baseUrl = apiPath + cloudPartApi + "/";
var mainGridUrl =baseUrl+"com.hsapi.cloud.part.invoicing.paramcrud.queryPchsOrderMain.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.paramcrud.queryPjPchsOrderDetailChkList.biz.ext";
var mainGrid =null;
var searchBeginDate = null;
var searchEndDate = null;
var rightGrid =null;

var storehouseHash = {};
var billTypeIdHash = {};
var settTypeIdHash = {};
var enterTypeIdHash = {};
var partBrandIdHash = {};
var statusList=[{"id":0,"name":"全部"},{"id":1,"name":"待受理"},{"id":2,"name":"已受理"}];
var billStatusHash = {
    "0":"待受理",
    "1":"已受理"
};

$(document).ready(function(v) {
	mainGrid =nui.get("mainGrid");
	mainGrid.setUrl(mainGridUrl);
    searchBeginDate = nui.get("beginDate");
    searchEndDate = nui.get("endDate");
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    nui.get("status").setData(statusList);
    nui.get("status").setValue(1);
   
    var dictDefs ={"billTypeId":"DDT20130703000008", "settleTypeId":"DDT20130703000035"};
    initDicts(dictDefs, function(){
        var billTypeIdList = nui.get("billTypeId").getData();
        var settTypeIdList = nui.get("settleTypeId").getData();
        billTypeIdList.forEach(function(v)
        {
            billTypeIdHash[v.customid] = v;
        });
        settTypeIdList.forEach(function(v)
        {
            settTypeIdHash[v.customid] = v;
        });

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

        getAllPartBrand(function(data)
        {
            var partBrandList = data.brand;
            partBrandList.forEach(function(v)
            {
                partBrandIdHash[v.id] = v;
            });
        });

        quickSearch(2);

    });
    
    
});

function getSearchParam(){
    var params = {};

    if(searchBeginDate.getFormValue())
    {
        params.sAuditDate = formatDate(new Date(searchBeginDate.getFormValue()));
    }
    if(searchEndDate.getFormValue())
    {
        var date = new Date(searchEndDate.getFormValue());
        params.eAuditDate = addDate(date, 1);
        
    }

    params.serviceId = nui.get('serviceId').getValue().replace(/\s+/g, "");
    params.directOrgid = currOrgId;
    params.isDiffOrder = 0;

    if(nui.get('status').getValue() == 1) {
        params.notFinished = 0;
    }else if(nui.get('status').getValue() == 2) {
        params.notFinished = 1;
    }

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
    rightGrid.setData([]);
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
    rightGrid.load({
        params:params,
        token:token
    });
}



function onDrawCell(e){
	switch (e.field)
    {
	   
	    case "comPartBrandId":
	        if(partBrandIdHash[e.value])
	        {
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
        case "isFinished":
            if(billStatusHash && billStatusHash[e.value])
            {
                e.cellHtml = billStatusHash[e.value];
            }
            break;  
        default:
            break;
    }
}

var auditUrl = baseUrl+"com.hsapi.cloud.part.invoicing.allotsettle.generatePchsAllotIn.biz.ext";
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
	
	if(row.isFinished != 0){
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
			id :  row.id,
            storeId : nui.get('storeId').getValue(),
			token: token
		}),
		success : function(data) {
			nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
				showMsg("受理成功，生成的调拨入库单号为：" + data.serviceId,"S");
				var newRow = {isFinished: 1};
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

