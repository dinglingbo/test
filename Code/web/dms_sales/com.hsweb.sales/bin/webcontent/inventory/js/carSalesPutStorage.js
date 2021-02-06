/**
 * Created by Administrator on 2018/2/1.
 */
var statusList = [{id:"0",name:"联系人"},{id:"1",name:"联系电话"}];
var saleApiUrl  = apiPath +saleApi + "/";
var rightGridUrl = saleApiUrl+"com.hsapi.sales.svr.inventory.queryCheckEnter.biz.ext";
var getDetailPartUrl=saleApiUrl+"com.hsapi.sales.svr.inventory.queryPchsOrderDetailList.biz.ext";

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
//var billStatusHash = {
//    "0":"未审",
//    "1":"已审",
//    "2":"已过账",
//    "3":"已取消"
//};
var frameColorIdList = []//车身颜色
var interialColorIdList = []//内饰颜色
var StatusHash = {
		"0" : "草稿",
		"1" : "待发货",
		"2" : "待收货",
		"4" : "已入库",
	};
var headerHash = [{ name: '草稿', id: '0' }, { name: '已入库', id: '1' },{ name: '已退货', id: '2' }];
var innerPartGrid=null;
var editFormDetail = null;

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

    innerPartGrid = nui.get("innerPartGrid");
    innerPartGrid.setUrl(getDetailPartUrl);
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
    


    rightGrid.on("drawcell", function (e) {      
        switch (e.field) {
            case "billStatus":
            	 e.cellHtml = headerHash[e.value].name;
                break;
            case "frameColorId":
            	e.cellHtml = setColVal('frameColorId', 'customid', 'name', e.value);
               break;
            case "interialColorId":
            	e.cellHtml = setColVal('interialColorId', 'customid', 'name', e.value);
               break;
            case "serviceCode":
            	e.cellHtml ='<a href="##" onclick="edit()">'+e.value+'</a>'
               break;               
            default:
                break;
        }
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
	var dictDefs ={"frameColorId":"DDT20130726000003","interialColorId":"10391"};
	initDicts(dictDefs, function(){
		getStorehouse(function(data) {
			getAllPartBrand(function(data) {
		 	 	frameColorIdList = nui.get('frameColorId').getData();
 	 			interialColorIdList = nui.get('interialColorId').getData();
 	 			quickSearch(4);
			});
			
		});
	});
});
function getSearchParam(){
    var params = {};
    params.serviceId = comServiceId.getValue();
    params.carModelName = nui.get("carModelName").getValue();
	if(typeof comSearchGuestId.getValue() !== 'number'){
    	params.guestId=null;
    	params.guestName = comSearchGuestId.getValue();
    }else{
    	params.guestId = comSearchGuestId.getValue();
    }
	params.endDate = addDate(searchEndDate.getValue(),1);
	params.startDate = searchBeginDate.getFormValue();
    return params;
}
var currType = 4;
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
        	params.billStatus=0;
        	params.auditSign=0;
        	querysign = 2;
        	querystatusname = "草稿";
        	break;
        //待发货
        case 13:
        	params.billStatus=1;
        	querysign = 2;
        	querystatusname = "已入库";
        	break;
        //待收货
        case 14:
        	params.billStatus=2;
        	querysign = 2;
        	querystatusname = "已退货";
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
                    guestType :"01020201"
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
    	case "serviceId":
    		e.cellHtml ='<a href="##" onclick="edit()">'+e.value+'</a>';
    		break;
	    case "partBrandId":
	    	if(partBrandIdHash[e.value])
            {
//                e.cellHtml = partBrandIdHash[e.value].name||"";
            	if(partBrandIdHash[e.value].imageUrl){
            		
            		e.cellHtml = "<img src='"+ partBrandIdHash[e.value].imageUrl+ "'alt='配件图片' height='25px' weight=' '/><br> "+partBrandIdHash[e.value].name||"";
            	}else{
            		e.cellHtml =partBrandIdHash[e.value].name||"";
            	}
            }
            else{
                e.cellHtml = "";
            }
            break;
//	    case "billStatus":
//	        if(billStatusHash && billStatusHash[e.value])
//	        {
//	            e.cellHtml = billStatusHash[e.value];
//	        }
//	        break;
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
        case "payMode":
            if(settTypeIdHash && settTypeIdHash[e.value])
            {
                e.cellHtml = settTypeIdHash[e.value].name;
            }
            break;
    	case "billStatusId":
			if (StatusHash && StatusHash[e.value]) {
				e.cellHtml = StatusHash[e.value];
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


function edit(){
	var row = rightGrid.getSelected();
	if(!row){
		showMsg("请选择单据","W");
	}
    var item={};
    item.id = "carSalesPutStorageDetails";
    item.text = "验车入库详情";
    item.url = webPath + contextPath + "/com.hsweb.inventory.carSalesPutStorageDetails.flow";
    item.iconCls = "fa fa-file-text";
    //window.parent.activeTab(item);
    var params = row; 
    window.parent.activeTabAndInit(item,params);
}
function carCheck(){
    var item={};
    item.id = "carSalesPutStorageDetails";
    item.text = "验车入库详情";
    item.url = webPath + contextPath + "/com.hsweb.inventory.carSalesPutStorageDetails.flow";
    item.iconCls = "fa fa-file-text";
    //window.parent.activeTab(item);
    var params = {}; 
    window.parent.activeTabAndInit(item,params);
}

