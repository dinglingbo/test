var statusList = [{id:"0",name:"联系人"},{id:"1",name:"联系电话"},{id:"2",name:"车架号（VIN）"}];
var saleApiUrl  = apiPath + saleApi + "/";
var rightGridUrl = saleApiUrl+"com.hsapi.sales.svr.inventory.queryFactoryReturnList.biz.ext";

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
var StatusHash = {
		"0" : "草稿",
		"1" : "已退货"
	};
$(document).ready(function(v){
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
    editFormDetail = document.getElementById("editFormDetail");
//    advancedSearchForm = new nui.Form("#advancedSearchWin");
    //console.log("xxx");
    
    
    
    rightGrid.on("rowdblclick", function(e) {
		var row = rightGrid.getSelected();
		var rowc = nui.clone(row);
		if (!rowc)
			return;
		edit();

	});
    


    
    document.ondragstart = function() {
        return false;
    };
	document.onkeyup = function(event) {
		var e = event || window.event;
		var keyCode = e.keyCode || e.which;// 38向上 40向下
		

		if ((keyCode == 13)) { // F9
			onSearch();
		}
	}
    
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
                var settTypeIdList = dataItems.filter(function(v)
                {
                    if(v.dictid == "DDT20130703000035")
                    {
                        settTypeIdHash[v.customid] = v;
                        return true;
                    }
                });
                var enterTypeIdList = dataItems.filter(function(v)
                {
                    if(v.dictid == "DDT20130703000064")
                    {
                        enterTypeIdHash[v.customid] = v;
                        return true;
                    }
                });
                quickSearch(4);
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
    params.serviceId = comServiceId.getValue();
     
    
    params.auditSign=nui.get('auditSign').getValue();
    params.billStatusId=nui.get('billStatusId').getValue();
    if(params.auditSign===""){
    	params.auditSign=-1;
    }
//	params.partCode = comPartCode.getValue();
//	params.partNameAndPY = comPartNameAndPY.getValue();
//	params.guestId = comSearchGuestId.getValue();
	if(typeof comSearchGuestId.getValue() !== 'number'){
    	params.guestId=null;
    	params.guestName = comSearchGuestId.getValue();
    }else{
    	params.guestId = comSearchGuestId.getValue();
    }
	params.endDate = addDate(searchEndDate.getValue(),1);
	params.startDate = searchBeginDate.getFormValue();
	params.isDiffOrder = 0;
    return params;
}
var currType = 2;
function quickSearch(type){
    var params = getSearchParam();
    var querysign = 1;
    var queryname = "本日";
    var querystatusname = "所有";
    switch (type)
    {
        case 0:
            params.today = 1;
            params.startDate = getNowStartDate();
            params.endDate = addDate(getNowEndDate(), 1);
            querysign = 1;
            queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.startDate = getPrevStartDate();
            params.endDate = addDate(getPrevEndDate(), 1);
            querysign = 1;
            queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.startDate = getWeekStartDate();
            params.endDate = addDate(getWeekEndDate(), 1);
            querysign = 1;
            queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.startDate = getLastWeekStartDate();
            params.endDate = addDate(getLastWeekEndDate(), 1);
            querysign = 1;
            queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.startDate = getMonthStartDate();
            params.endDate = addDate(getMonthEndDate(), 1);
            querysign = 1;
            queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.startDate = getLastMonthStartDate();
            params.endDate = addDate(getLastMonthEndDate(), 1);
            querysign = 1;
            queryname = "上月";
            break;
        case 10:
            params.thisYear = 1;
            params.startDate = getYearStartDate();
            params.endDate = getYearEndDate();
            querysign = 1;
            queryname = "本年";
            break;
        case 11:
            params.lastYear = 1;
            params.startDate = getPrevYearStartDate();
            params.endDate = getPrevYearEndDate();
            querysign = 1;
            queryname = "上年";
            break;
        //草稿
        case 12:
        	params.status=0;
        	querysign = 2;
        	querystatusname = "草稿";
        	break;
        //待发货
        case 13:
        	params.status=1;
        	querysign = 2;
        	querystatusname = "已退货";
        	break;
        //待收货
        case 14:
        	params.billStatusId=2;
        	params.auditSign=1;
        	querysign = 2;
        	querystatusname = "待收货";
        	break;
        //已入库
        case 15:
        	params.billStatusId=4;
        	params.auditSign=1;
        	querysign = 2;
        	querystatusname = "已入库";
        	break;
        default:
        	querysign = 2;
        	querystatusname = "所有";
        	params.auditSign=-1;
            break;
    }
    
    searchBeginDate.setValue(params.startDate);
    searchEndDate.setValue(addDate(params.endDate,-1));
    nui.get('auditSign').setValue(params.auditSign);
    nui.get('billStatusId').setValue(params.billStatusId);
    currType = type;
    if(querysign == 1){
    	var menunamedate = nui.get("menunamedate");
    	menunamedate.setText(queryname); 	
    }
    else if(querysign == 2){
    	var menubillstatus = nui.get("menubillstatus");
		menubillstatus.setText(querystatusname);
    }
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
//    params.isFinished = 0;
    rightGrid.load({
        params:params,
        token:token
    },function(){
        rightGrid.mergeColumns(["serviceId"]);
    });
}

var supplier = null;
function selectSupplier(elId)
{
    supplier = null;
    nui.open({
        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.part.common.guestSelect.flow?token="+token,
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


function add(){
    var item={};
    item.id = "carSalesReturnDetails";
    item.text = "采购退货详情";
    item.url = webPath + contextPath + "/inventory.carSalesReturnDetails.flow";
    item.iconCls = "fa fa-file-text";
    //window.parent.activeTab(item);
    var params = {};
    window.parent.activeTabAndInit(item,params);

}

function edit(){
    var row = rightGrid.getSelected();
    if(!row) return; 
    var item={};
    item.id = "carSalesReturnDetails";
    item.text = "采购退货详情";
    item.url = webPath + contextPath + "/inventory.carSalesReturnDetails.flow";
    item.iconCls = "fa fa-file-text";
    //window.parent.activeTab(item);
    var params = row; 
    window.parent.activeTabAndInit(item,params);
}

function onDrawCell(e)
{
    switch (e.field)
    {	
        case "billTypeId":
            if(billTypeIdHash && billTypeIdHash[e.value])
            {
                e.cellHtml = billTypeIdHash[e.value].name;
            }
            break;
        case "payMode":
            if(settTypeIdHash && settTypeIdHash[e.value])
            {
                e.cellHtml = settTypeIdHash[e.value].name;
            }
            break;
    	case "status":
			if (StatusHash && StatusHash[e.value]) {
				e.cellHtml = StatusHash[e.value];
			}
			break;
        case "serviceCode":
        	e.cellHtml ='<a href="##" onclick="edit()">'+e.value+'</a>'
           break; 			
        default:
            break;
    }
}