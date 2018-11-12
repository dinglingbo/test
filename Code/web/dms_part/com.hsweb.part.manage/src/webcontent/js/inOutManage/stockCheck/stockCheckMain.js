/**
 * Created by Administrator on 2018/2/1.
 */
var partApiUrl  = apiPath + partApi + "/";
var rightGridUrl = partApiUrl+"com.hsapi.part.invoice.svr.queryPjStockCheckMainList.biz.ext";
var getDetailPartUrl=partApiUrl+"com.hsapi.part.invoice.svr.queryPjStockCheckDetailList.biz.ext";
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

var auditSignHash = {
		"0" : "草稿",
		"1" : "已审",

	};
var dcHash={
		"-1" : "盘亏",
		"0"  : "无盈亏",
		"1"  : "盘盈",
};
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
    advancedSearchWin = nui.get("advancedSearchWin");
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
    innerPartGrid.on("drawcell", function (e) {
        var grid = e.sender;
        var record = e.record;
        var uid = record._uid;
        var rowIndex = e.rowIndex;
        
        switch (e.field) {
            case "storeId":
                if(storehouseHash && storehouseHash[e.value])
                {
                    e.cellHtml = storehouseHash[e.value].name;
                }
                break;
            case "comPartBrandId":
            	if(partBrandIdHash && partBrandIdHash[e.value]){
            		e.cellHtml = partBrandIdHash[e.value].name;
            	}
            	break;
            case "dc":
            	if(dcHash && dcHash[e.value]){
            		e.cellHtml = dcHash[e.value];
            	}
            	break;
            default:
                break;
        }
    });
    
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
                quickSearch(currType);
            }
        });
    });
});
function getSearchParam(){
    var params = {};
    params.serviceId = comServiceId.getValue();
    params.auditSign=nui.get('auditSign').getValue();
    params.storeId=nui.get('storeId').getValue();
	params.endDate = searchEndDate.getValue();
	params.startDate = searchBeginDate.getValue();
    return params;
}
var currType = 2;
function quickSearch(type){
    var params = getSearchParam();
    var querysign = 1;
    var queryname = "本日";
    var querystatusname = "全部";
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
        	params.auditSign=0;
        	querysign = 2;
        	querystatusname = "草稿";
        	break;
        //已审
        case 13:
        	params.auditSign=1;
        	querysign = 2;
        	querystatusname = "已审";
        	break;
        case 14:
        	params.auditSign="";
        	querysign = 2;
        	querystatusname = "全部";
        	break;
        default:
            break;
    }
    searchBeginDate.setValue(params.startDate);
    searchEndDate.setValue(params.endDate);
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
//	params.sortField = "audit_date";
//    params.sortOrder = "desc";
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
        nui.get("sCreateDate").setValue(getWeekStartDate());
        nui.get("eCreateDate").setValue(addDate(getWeekEndDate(), 1));
    }
}
//function onAdvancedSearchOk()
//{
//	var searchData = advancedSearchForm.getData();
//    advancedSearchFormData = {};
//    for(var key in searchData)
//    {
//        advancedSearchFormData[key] = searchData[key];
//    }
//    var i;
//    if(searchData.sOrderDate)
//    {
//        searchData.sOrderDate = searchData.sOrderDate.substr(0,10);
//    }
//    if(searchData.eOrderDate)
//    {
//        var date = searchData.eOrderDate;
//        searchData.eOrderDate = addDate(date, 1);
//        searchData.eOrderDate = searchData.eOrderDate.substr(0,10);
//    }
//    //创建日期
//    if(searchData.sCreateDate)
//    {
//        searchData.sCreateDate = searchData.sCreateDate.substr(0,10);
//    }
//    if(searchData.eCreateDate)
//    {
//        var date = searchData.eCreateDate;
//        searchData.eCreateDate = addDate(date, 1);
//        searchData.eCreateDate = searchData.eCreateDate.substr(0,10);
//    }
//    //供应商
//    if(searchData.guestId)
//    {
//        searchData.guestId = nui.get("btnEdit2").getValue();
//    }
//    //订单单号
//    if(searchData.serviceIdList)
//    {
//        var tmpList = searchData.serviceIdList.split("\n");
//        for(i=0;i<tmpList.length;i++)
//        {
//            tmpList[i] = "'"+tmpList[i]+"'";
//        }
//        searchData.serviceIdList = tmpList.join(",");
//     
//    }
//    //配件编码
//    if(searchData.partCodeList)
//    {
//        var tmpList = searchData.partCodeList.split("\n");
//        for(i=0;i<tmpList.length;i++)
//        {
//            tmpList[i] = "'"+tmpList[i]+"'";
//        }
//        searchData.partCodeList = tmpList.join(",");
//    }
//    /*if(searchData.outableQtyGreaterThanZero == 0)
//    {
//        delete searchData.outableQtyGreaterThanZero;
//    }*/
//    advancedSearchWin.hide();
//    doSearch(searchData);
//}
function onAdvancedSearchCancel(){
    advancedSearchForm.clear();
    advancedSearchWin.hide();
}
var supplier = null;
function selectSupplier(elId)
{
    supplier = null;
    nui.open({
        targetWindow: window,
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
                el.setValue(text);
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
	        if(partBrandIdHash && partBrandIdHash[e.value])
	        {
	            e.cellHtml = partBrandIdHash[e.value].name;
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
        case "receiveStoreId":
            if(storehouseHash && storehouseHash[e.value])
            {
                e.cellHtml = storehouseHash[e.value].name;
            }
            break;
    	case "auditSign":
			if (auditSignHash && auditSignHash[e.value]) {
				e.cellHtml = auditSignHash[e.value];
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

function onShowRowDetail(e) {
    var row = e.record;
    
    //将editForm元素，加入行详细单元格内
    var td = rightGrid.getRowDetailCellEl(row);
    td.appendChild(editFormDetail);
    editFormDetail.style.display = "";
    innerPartGrid.setData([]);
    var mainId = row.id;
    var params={
    	mainId:mainId,
    	token:token
    };
    innerPartGrid.load({params:params});
    
}

function add(){
    var item={};
    item.id = "6400";
    item.text = "盘点单详情";
    item.url = webPath + contextPath + "/com.hsweb.part.manage.stockCheck.flow";
    item.iconCls = "fa fa-file-text";
    //window.parent.activeTab(item);
    var params = {};
    window.parent.activeTabAndInit(item,params)

}

function edit(){
    var row = rightGrid.getSelected();
    if(!row) return; 
    var item={};
    item.id = "6400";
    item.text = "盘点单详情";
    item.url = webPath + contextPath + "/com.hsweb.part.manage.stockCheck.flow";
    item.iconCls = "fa fa-file-text";
    //window.parent.activeTab(item);
    var params = row; 
    window.parent.activeTabAndInit(item,params);
}