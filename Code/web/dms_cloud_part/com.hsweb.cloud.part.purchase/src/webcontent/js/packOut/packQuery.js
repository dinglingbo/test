var baseUrl = apiPath + cloudPartApi + "/";
var packGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.paramcrud.queryPJPackList.biz.ext";
var getDetailUrl=baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjSellOrderDetailList.biz.ext";
var innnerGridUrl=baseUrl+"com.hsapi.cloud.part.invoicing.paramcrud.getPJPackDetailById.biz.ext";
var basicInfoForm = null;
var packGrid=null;
var innerGrid=null;
var detailGrid=null;

var brandHash = {};
var brandList = [];
var storehouse = null;
var storeHash={};
var billTypeIdHash = {};
var settTypeIdHash = {};
var billTypeIdList = [];
var settTypeIdList = [];
var payTypeHash={};
var payTypeList=[];
var payTypeEl=null;
var billTypeIdEl = null;
var settleTypeIdEl = null;
var stratDateEl=null;
var endDateEl=null;
var billStatusHash={
		"0"	 :"已打包",
		"1"	 :"已发货",
		"2"	 :"已到货"
	};
var editFormDetail = null;

$(document).ready(function(v){
	packGrid=nui.get('packGrid');
	packGrid.setUrl(packGridUrl);
	innerGrid=nui.get('innerGrid');
	innerGrid.setUrl(innnerGridUrl);
	editFormDetail = document.getElementById("editFormDetail");
	detailGrid =nui.get('detailGrid');
	detailGrid.setUrl(getDetailUrl);
	
	billTypeIdEl = nui.get("billTypeId");
    settleTypeIdEl = nui.get("settleTypeId");
    payTypeEl =nui.get("payType");
    startDateEl = nui.get("startDate");
    endDateEl = nui.get("endDate");
    startDateEl.setValue(getNowStartDate());
    endDateEl.setValue(addDate(getNowEndDate(), 1));
	
	var dictDefs ={"billTypeId":"DDT20130703000008", "settleTypeId":"DDT20130703000035","payType":"10221"};
	
	document.onkeyup = function(event) {
		var e = event || window.event;
		var keyCode = e.keyCode || e.which;// 38向上 40向下
		

		if ((keyCode == 13)) { // F9
			onSearch();
		}
	}
    initDicts(dictDefs,function()
    {
        var billTypeIdList = billTypeIdEl.getData();
        var settTypeIdList = settleTypeIdEl.getData();
        var payTypeList = payTypeEl.getData();
        billTypeIdList.filter(function(v)
        {
            billTypeIdHash[v.customid] = v;
            return true;
        });

        settTypeIdList.filter(function(v)
        {
            settTypeIdHash[v.customid] = v;
            return true;
        });
        payTypeList.filter(function(v)
        {
        	payTypeHash[v.customid] = v;
            return true;
        });

    });
    getStorehouse(function(data)
    {
        storehouse = data.storehouse||[];
        if(storehouse && storehouse.length>0){
            storehouse.forEach(function(v) {
                storeHash[v.id] = v;
            });
        }
    });

    getAllPartBrand(function(data) {
        brandList = data.brand;
        brandList.forEach(function(v) {
            brandHash[v.id] = v;
        });
    });
    
    innerGrid.on("rowclick",function(e){
        onRowClick(e);
     });
	quickSearch(8);
});

function onPackGridDrawCell(e)
{
    switch (e.field){
        case "billStatusId":
        	if(billStatusHash && billStatusHash[e.value])
            {
                e.cellHtml = billStatusHash[e.value];
            }
        	break;
        case "settleTypeId":
            if(settTypeIdHash && settTypeIdHash[e.value])
            {
                e.cellHtml = settTypeIdHash[e.value].name;
            }
            break;
        case "payType":
            if(payTypeHash && payTypeHash[e.value])
            {
                e.cellHtml = payTypeHash[e.value].name;
            }
            break;
         default:
        	 break;
    }
}
function onDetailGridDrawCell(e)
{
    switch (e.field){
	    case "storeId":
	        if(storeHash && storeHash[e.value])
	        {
	            e.cellHtml = storeHash[e.value].name;
	        }
	        break;
	    case "comPartBrandId":
        	if(brandHash[e.value])
            {
//                e.cellHtml = brandHash[e.value].name||"";
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
	    default:
            break;
    }
}
var currType = 2;
function quickSearch(type){
	 var params = getSearchParam();
    var querysign = 1;
    var queryname = "本日";
    var querytypename = "所有";
    switch (type)
    {
        case 0:
            params.today = 1;
            params.startDate = getNowStartDate();
            params.endDate = addDate(getNowEndDate(), 1);
            queryname = "本日";
            querysign = 1;
            break;
        case 1:
            params.yesterday = 1;
            params.startDate = getPrevStartDate();
            params.endDate = addDate(getPrevEndDate(), 1);
            queryname = "昨日";
            querysign = 1;
            break;
        case 2:
            params.thisWeek = 1;
            params.startDate = getWeekStartDate();
            params.endDate = addDate(getWeekEndDate(), 1);
            queryname = "本周";
            querysign = 1;
            break;
        case 3:
            params.lastWeek = 1;
            params.startDate = getLastWeekStartDate();
            params.endDate = addDate(getLastWeekEndDate(), 1);
            queryname = "上周";
            querysign = 1;
  
            break;
        case 4:
            params.thisMonth = 1;
            params.startDate = getMonthStartDate();
            params.endDate = addDate(getMonthEndDate(), 1);
            queryname = "本月";
            querysign = 1;
            break;
        case 5:
            params.lastMonth = 1;
            params.startDate = getLastMonthStartDate();
            params.endDate = addDate(getLastMonthEndDate(), 1);
            queryname = "上月";
            querysign = 1;
            break;
        case 6:
        	
            break;
        case 7:

            break;
        case 8:
        	querystatusname = "所有";
            querysign = 2;
            params.billStatusId = null;
            params.billStatusIdList="0,1,2";
            break;
        case 9:
        	querystatusname = "已打包";
            querysign = 2;
            params.billStatusId = 0;
            params.billStatusIdList=null;
            break;
        case 10:
        	querystatusname = "已发货";
            querysign = 2;
            params.billStatusId = 1;
            params.billStatusIdList=null;
            break;
        case 11:
        	querystatusname = "已到货";
            querysign = 2;
            params.billStatusId = 2;
            params.billStatusIdList=null;
            break;
        default:
        	params.today = 1;
	        params.startDate = getNowStartDate();
	        params.endDate = addDate(getNowEndDate(), 1);
	        querystatusname = "所有";
            break;
    }
    startDateEl.setValue(params.startDate);
    endDateEl.setValue(params.endDate);
    currType = type;
    if(querysign == 1){
        var menunamedate = nui.get("menunamedate");
        menunamedate.setText(queryname);
    }else if(querysign == 2){
    	var menubillstatus = nui.get("menubillstatus");
        menubillstatus.setText(querystatusname);
    }
    doSearch(params);
}
function onSearch(){
    search();
}
function search()
{
    var param = getSearchParam();
    doSearch(param);
}
function getSearchParam(){
    var params = {};
    params.serviceId = nui.get('serviceId').getValue();
	params.startDate = startDateEl.getFormValue();
	params.endDate = endDateEl.getFormValue();
    params.guestName = nui.get("guestName").getValue();
    return params;
}

function doSearch(params) 
{
    //目前没有区域销售订单，采退受理  params.enterTypeId = '050101';
	packGrid.load({
        params : params,
        token : token
    }, function() {
        //onLeftGridRowDblClick({});
  
    });
    //默认新增
}

function onShowRowDetail(e) {
    var row = e.record;
    
    //将editForm元素，加入行详细单元格内
    var td = packGrid.getRowDetailCellEl(row);
    td.appendChild(editFormDetail);
    editFormDetail.style.display = "";
    innerGrid.setData([]);
    var mainId = row.id;
    var params={
    	mainId:mainId,
    	token:token
    };
    innerGrid.load({params:params});
    
}

function onRowClick(e){
	var row = e.record;
	var params={};
	params.mainId=row.billMainId;
	detailGrid.load({params:params,token:token});
}