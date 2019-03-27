/**
 * Created by Administrator on 2018/2/1.
 */
var partApiUrl  = apiPath +partApi + "/";
var rightGridUrl = partApiUrl+"com.hsapi.part.invoice.settle.queryPJStatementList.biz.ext";
var getDetailPartUrl=partApiUrl+"com.hsapi.part.invoice.settle.getPJStatementDetailById.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var basicInfoForm = null;
var rightGrid = null;
var gsparams = null;
var searchBeginDate = null;
var searchEndDate = null;
var comPartNameAndPY = null;
var comPartCode = null;
var comServiceId = null;
var comSearchGuestId = null;
var serviceTypeIdEl = null;
var gsparams = {};
var storehouseHash = {};
var billTypeIdHash = {};
var settTypeIdHash = {};
var enterTypeIdHash = {};
var partBrandIdHash = {};
var servieTypeHash = {};
var billStatusHash = {
    "0":"未审",
    "1":"已审",
    "2":"已过账",
    "3":"已取消"
};

var StatusHash = {
		"0" : "草稿",
		"1" : "待发货",
		"2" : "待收货",
		"4" : "已入库",
	};
var typeIdHash = {
		1 : "采购订单",
		2 : "销售订单",
		3 : "采购退货",
		4 : "销售退货"
	};

//单据状态
var AuditSignList = [
  {
      customid:'0',
      name:'未审'
  },
  {
      customid:'1',
      name:'已审'
  }
];
var AuditSignHash = {
  "0":"未审",
  "1":"已审"
};
var accountSignHash = {
    "0":"未对账",
    "1":"已对账"
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
    serviceTypeIdEl = nui.get("serviceTypeId");
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
    initServiceType("serviceTypeId",function(data) {
        servieTypeList = nui.get("serviceTypeId").getData();
        servieTypeList.forEach(function(v) {
            servieTypeHash[v.id] = v;
        });
    });
	  var filter = new HeaderFilter(rightGrid, {
	        columns: [
	            { name: 'stateMan' },
		            { name: 'guestName' },
	            { name: 'auditor' },
	        ],
	        callback: function (column, filtered) {
	        },

	        tranCallBack: function (field) {
	        	var value = null;
	        	switch(field){
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
        	case "typeCode":
        		if (typeIdHash && typeIdHash[e.value]) {
        			e.cellHtml = typeIdHash[e.value];
        		}
        		break;
            case "comPartBrandId":
            	if(partBrandIdHash && partBrandIdHash[e.value]){
            		e.cellHtml = partBrandIdHash[e.value].name;
            	}
            	break;
            default:
                break;
        }
    });
    rightGrid.on("drawcell", function (e) {
        var grid = e.sender;
        var record = e.record;
        var uid = record._uid;
        var rowIndex = e.rowIndex;
        switch (e.field){
           case "auditSign":
            if(AuditSignHash && AuditSignHash[e.value])
              {
                e.cellHtml = AuditSignHash[e.value];
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
	 params.auditSign=nui.get('auditSign').getValue();
	// params.billStatusId=nui.get('billStatusId').getValue();
	 if(params.auditSign=="" || ! params.auditSign){
	    params.auditSign=0;
	  }
	 params.serviceId = comServiceId.getValue(); 
	 params.billServiceId = nui.get("billServiceId").getValue();
	 params.settleTypeId = nui.get("settleTypeId").getValue();
 	 params.guestId=comSearchGuestId.getValue();
	 params.endDate = searchEndDate.getValue();
	 params.startDate = searchBeginDate.getFormValue();
	// params.isDiffOrder = 0;
	 
	/* gsparams.guestName=comSearchGuestId.getValue();
	 gsparams.serviceId = comServiceId.getValue();     
	 gsparams.endDate = searchEndDate.getValue();
	 gsparams.startDate = searchBeginDate.getFormValue();*/
	 return params;
}
var currType = 0;
function quickSearch(type){
    var params = getSearchParam();
    
	/*var params = {};
	params.auditSign = params1.auditSign;*/
    var querysign = 1;
    var queryname = "本日";
    var querystatusname = "未审";
    switch (type)
    {
        case 0:
            params.today = 1;
            params.startDate = getNowStartDate();
            params.endDate = getNowEndDate();
            querysign = 1;
            queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.startDate = getPrevStartDate();
            params.endDate = getPrevEndDate();
            querysign = 1;
            queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.startDate = getWeekStartDate();
            params.endDate = getWeekEndDate();
            querysign = 1;
            queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.startDate = getLastWeekStartDate();
            params.endDate = getLastWeekEndDate();
            querysign = 1;
            queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.startDate = getMonthStartDate();
            params.endDate = getMonthEndDate();
            querysign = 1;
            queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.startDate = getLastMonthStartDate();
            params.endDate = getLastMonthEndDate();
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
        	querystatusname = "未审";
        	break;
        //待发货
        case 13:
        	params.auditSign=1;
        	querysign = 2;
        	querystatusname = "已审";
        	break;
        default:
            break;
    }
    searchBeginDate.setValue(params.startDate);
    searchEndDate.setValue(params.endDate);
    nui.get('auditSign').setValue(params.auditSign);
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
	params.endDate = addDate(params.endDate, 1);
	//params.sortField = "audit_date";
   // params.sortOrder = "desc";
   // params.orderTypeId = 1;
  //  params.isFinished = 0;
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
//        searchData.sCreateDate = formatDate(searchData.sCreateDate);
//    }
//    if(searchData.eCreateDate)
//    {
//        var date = searchData.eCreateDate;
//        searchData.eCreateDate = addDate(date, 1);
//        
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
        case "billTypeId":
            if(billTypeIdHash && billTypeIdHash[e.value])
            {
                e.cellHtml = billTypeIdHash[e.value].name;
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
    item.id = "16200";
    item.text = "月对账详情";
    item.url = webPath + contextPath + "/com.hsweb.frm.manage.billStatementDetail.flow?token="+token;
    item.iconCls = "fa fa-file-text";
    //window.parent.activeTab(item);
    var params = {};
    window.parent.activeTabAndInit(item,params)

}

function edit(){
    var row = rightGrid.getSelected();
    if(!row) return; 
    var item={};
    item.id = "16200";
    item.text = "月对账详情";
    item.url = webPath + contextPath + "/com.hsweb.frm.manage.billStatementDetail.flow?token="+token;
    item.iconCls = "fa fa-file-text";
    //window.parent.activeTab(item);
    var params = row; 
    window.parent.activeTabAndInit(item,params);
}