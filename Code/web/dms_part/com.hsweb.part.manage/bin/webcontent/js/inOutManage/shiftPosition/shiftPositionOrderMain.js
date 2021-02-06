/**
 * Created by Administrator on 2018/2/1.
 */
var partApiUrl  = apiPath + partApi + "/";
var rightGridUrl = partApiUrl+"com.hsapi.part.invoice.svr.queryPjShiftOrderMainList.biz.ext";
var getDetailPartUrl=partApiUrl+"com.hsapi.part.invoice.svr.queryPjShiftOrderDetailList.biz.ext";

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
var headerHash =[{ name: '草稿', id: '0' },{ name: '已审', id: '0' }];
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
    
    var filter = new HeaderFilter(rightGrid, {
        columns: [
            { name: 'orderMan' },
            { name: 'auditor' },
            { name: 'auditSign' }
        ],
        callback: function (column, filtered) {
        },

        tranCallBack: function (field) {
        	var value = null;
        	switch(field){
    		case "auditSign": 
    			value = headerHash;
    			break;
	    	}
        	return value;
        }
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
            	   if(partBrandIdHash[e.value])
                   {
//                       e.cellHtml = partBrandIdHash[e.value].name||"";
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
        nui.get("receiveStoreId").setData(storehouse);
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
    params.endDate = addDate(searchEndDate.getValue(),1);
	params.startDate = searchBeginDate.getFormValue();
	params.storeId=nui.get('storeId').getValue();
    params.receiveStoreId=nui.get('receiveStoreId').getValue();
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
        //全部
        case 14:
        	params.auditSign="";
        	querysign = 2;
        	querystatusname = "所有";
        	break;
        default:
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
//	params.sortField = "audit_date";
//    params.sortOrder = "desc";
//    params.orderTypeId = 1;
//    params.isFinished = 0;
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
//                 e.cellHtml = partBrandIdHash[e.value].name||"";
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
                e.cellHtml = storehouseHash[e.value].name ||"";
            }
            break;       
        case "receiveStoreId":
            if(storehouseHash && storehouseHash[e.value])
            {
                e.cellHtml = storehouseHash[e.value].name || "";
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
    item.id = "6300";
    item.text = "移仓单详情";
    item.url = webPath + contextPath + "/com.hsweb.part.manage.shiftPosition.flow";
    item.iconCls = "fa fa-file-text";
    //window.parent.activeTab(item);
    var params = {};
    window.parent.activeTabAndInit(item,params)

}

function edit(){
    var row = rightGrid.getSelected();
    if(!row) return; 
    var item={};
    item.id = "6300";
    item.text = "移仓单详情";
    item.url = webPath + contextPath + "/com.hsweb.part.manage.shiftPosition.flow";
    item.iconCls = "fa fa-file-text";
    //window.parent.activeTab(item);
    var params = row; 
    window.parent.activeTabAndInit(item,params);
}