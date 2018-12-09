/**
 * Created by Administrator on 2018/2/23.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var leftGridUrl = baseUrl
		+ "com.hsapi.cloud.part.invoicing.svr.queryPjPchsOrderMainList.biz.ext";
var rightGridUrl = baseUrl
		+ "com.hsapi.cloud.part.invoicing.svr.queryPjPchsOrderDetailList.biz.ext";
var advancedSearchWin = null;
var advancedMorePartWin = null;
var advancedAddWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var basicInfoForm = null;
var bottomInfoForm = null;
var advancedAddForm = null;
var leftGrid = null;
var rightGrid = null;
var formJson = null;
var brandHash = {};
var brandList = [];
var storehouse = null;
var gsparams = {};
var sOrderDate = null;
var eOrderDate = null;
var mainTabs = null;
var billmainTab = null;
var partInfoTab = null;
var fastPartEntryEl = null;
var dataList = null;
var morePartGrid = null;
var FStoreId = null;
var isNeedSet = false;
var oldValue = null;
var oldRow = null;
var partShow = 0;
var quickAddShow=0;
var provinceList = [];
var cityList = [];
var advancedTipWin = null;


// 单据状态
var AuditSignList = [ {
	customid : '0',
	name : '未审'
}, {
	customid : '1',
	name : '已审'
}, {
	customid : '2',
	name : '已过账'
}, {
	customid : '3',
	name : '已取消'
} ];
var AuditSignHash = {
	"0" : "未审",
	"1" : "已审",
	"2" : "已过账",
	"3" : "已取消"
};
$(document).ready(function(v) {
	nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '加载中...'
	});
	
	leftGrid = nui.get("leftGrid");
	leftGrid.setUrl(leftGridUrl);

	rightGrid = nui.get("rightGrid");
	rightGrid.setUrl(rightGridUrl);
	advancedSearchWin = nui.get("advancedSearchWin");
	advancedMorePartWin = nui.get("advancedMorePartWin");
	advancedAddWin = nui.get("advancedAddWin");
	morePartGrid = nui.get("morePartGrid");
	advancedSearchForm = new nui.Form("#advancedSearchForm");
	basicInfoForm = new nui.Form("#basicInfoForm");
	advancedAddForm  = new nui.Form("#advancedAddForm");
	//bottomInfoForm = new nui.Form("#bottomForm");
	//fastPartEntryEl = nui.get("fastPartEntry");

	gsparams.startDate = getNowStartDate();
	gsparams.endDate = addDate(getNowEndDate(), 1);

	sOrderDate = nui.get("sOrderDate");
	eOrderDate = nui.get("eOrderDate");

	mainTabs = nui.get("mainTabs");
	billmainTab = mainTabs.getTab("billmain");
	partInfoTab = mainTabs.getTab("partInfoTab");

	advancedTipWin = nui.get("advancedTipWin");

	//setTimeout(function(){ 
	document.getElementById("formIframe").src=webPath + contextPath + "/common/embedJsp/containBottom.jsp";
	document.getElementById("formIframePart").src=webPath + contextPath + "/common/embedJsp/containPartInfo.jsp";
		//document.getElementById("formIframeStock").src=webPath + contextPath + "/common/embedJsp/containStock.jsp";
		//document.getElementById("formIframePchs").src=webPath + contextPath + "/common/embedJsp/containPchsAdvance.jsp";
	//}, 3000);


	//document.getElementById("formIframePart").contentWindow.setInitTab('purchase');

	$("#guestId").bind("keydown", function (e) {
        /*if (e.keyCode == 13) {
            var orderMan = nui.get("orderMan");
            orderMan.focus();
        }*/
        if (e.keyCode == 13) {
			//addNewRow(true);
        }
    });
    $("#orderMan").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            var remark = nui.get("remark");
            remark.focus();
        }
    });
    /*$("#planArriveDate").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            var remark = nui.get("remark");
            remark.focus();
        }
    });*/
    $("#remark").bind("keydown", function (e) {
    	//新增一条明细
    	/*var event=e||window.e;
    	var keyCode=event.keyCode||event.which;
    	if(keyCode==13){
    		addInsertRow();
    	}*/
    	if (e.keyCode == 13) {
            addNewRow(true);
        }

        
    	
	});
	
	morePartGrid.on("drawcell",function(e){
        switch (e.field)
        {
            case "partBrandId":
                if(brandHash[e.value])
                {
                    e.cellHtml = brandHash[e.value].name||"";
                }
                else{
                    e.cellHtml = "";
                }
                break;
            default:
                break;
        }
    });

    document.onkeyup=function(event){
	    var e=event||window.event;
	    var keyCode=e.keyCode||e.which;
	  
	    if((keyCode==78)&&(event.altKey))  {  //新建
			add();	
	    } 
	  
	    if((keyCode==83)&&(event.altKey))  {   //保存
			save();
	    } 
	  
	    if((keyCode==80)&&(event.altKey))  {   //打印
			onPrint();
	    } 
	    if((keyCode==113))  {  
			addMorePart();
		} 
		
		if((keyCode==13))  {  //新建
            if(partShow == 1) {
				var row = morePartGrid.getSelected();
				if(row){
					addSelectPart();
				}
			}
        } 

        if((keyCode==27))  {  //ESC
            if(partShow == 1){
                onPartClose();
            }
            if(quickAddShow==1){
            	onAdvancedAddCancel();
            }
        }
	 
	}

	$("partTempId").focus(function(){
		$("orderMan").css("background-color","#FFFFCC");
		addNewRow(true);
	});


	// 绑定表单
	// var db = new nui.DataBinding();
	// db.bindForm("basicInfoForm", leftGrid);
	var dictDefs ={"billTypeId":"DDT20130703000008", "settleTypeId":"DDT20130703000035"};
	initDicts(dictDefs, function(){
		getStorehouse(function(data) {
			storehouse = data.storehouse || [];
			if(storehouse && storehouse.length>0){
				FStoreId = storehouse[0].id;
			}else{
				isNeedSet = true;
			}
	
			getAllPartBrand(function(data) {
				brandList = data.brand;
				brandList.forEach(function(v) {
					brandHash[v.id] = v;
				});
		
				gsparams.billStatusId = 2;
				gsparams.auditSign = 1;
				quickSearch(0);

				nui.unmask();
			});
			
		});
	});

});
var StatusHash = {
	"0" : "草稿",
	"1" : "待发货",
	"2" : "待收货",
	//"3" : "部分入库",
	"4" : "已入库",
	"5" : "已退回",
	"6" : "已关闭"
};
function addNewRow(check){
	var data = basicInfoForm.getData();

    if(data.auditSign == 1){
        e.cancel = true;
        return;
    }
    
	var rows = [];
	if(check){
		rows = rightGrid.findRows(function(row) {
			if (row.partId == null || row.partId == "" || row.partId == undefined)
				return true;
		});

	}

	var focusGuest = true;
	var guestId = data.guestId;
	if(guestId){
		focusGuest = false;
	}

	var newRow = {};
	if(rows && rows.length > 0){
		var row = rows[0];
		rightGrid.updateRow(row, newRow);
		if(focusGuest){
			var guestId = nui.get("guestId");
			guestId.focus();
		}else{
			rightGrid.beginEditCell(row, "comPartCode");
		}
		
	}else{
		rightGrid.addRow(newRow);
		if(focusGuest){
			var guestId = nui.get("guestId");
			guestId.focus();
		}else{
			rightGrid.beginEditCell(newRow, "comPartCode");
		}
		
	}
}
function ontopTabChanged(e){
	var tab = e.tab;
	var name = tab.name;
	var url = tab.url;
	if(!url){
		if(name == "partInfoTab"){
			//mainTabs.loadTab(webPath + contextPath + "/common/embedJsp/containPartInfo.jsp", tab);
		}else if(name == "partStockInfoTab"){
			mainTabs.loadTab(webPath + contextPath + "/common/embedJsp/containStock.jsp", tab);
		}else if(name == "purchaseAdvanceTab"){
			mainTabs.loadTab(webPath + contextPath + "/common/embedJsp/containOrderCart.jsp", tab);
			
		}else if(name == "billmain"){
			var data = rightGrid.getChanges();
			if(data && data.length > 0){
				addNewRow(true);
			}else{
				add();
			}
		}
	}else{
		if(name == "billmain"){
			var data = rightGrid.getChanges();
			if(data && data.length > 0) {
				addNewRow(true);
			}else{
				add();
			}
			
		}
	}
	
}
//返回类型给srvBottom，用于srvBottom初始化
function confirmType(){
	return "pchs";
}
function getParentStoreId(){
	return FStoreId;
}
function loadMainAndDetailInfo(row) {
	if (row) {
		basicInfoForm.setData(row);
		//bottomInfoForm.setData(row);
		nui.get("guestId").setText(row.guestFullName);

		var row = leftGrid.getSelected();
		if (row.auditSign == 1) {
			document.getElementById("basicInfoForm").disabled = true;
			setBtnable(false);
			setEditable(false);
		} else {
			document.getElementById("basicInfoForm").disabled = false;
			setBtnable(true);
			setEditable(true);
		}

		// 序列化入库主表信息，保存时判断主表信息有没有修改，没有修改则不需要保存
		var data = basicInfoForm.getData();
		data.orderAmt = data.orderAmt||0;
		formJson = nui.encode(data);

		// 加载采购订单明细表信息
		var mainId = row.id;
		if(!mainId){
			mainId = -1;
		}
		var auditSign = data.auditSign||0;
		loadRightGridData(mainId, auditSign);
	} else {
	}

}
function onLeftGridBeforeDeselect(e)
{
    var row = leftGrid.getSelected(); 
    if(row.serviceId == '新采购订单'){

        leftGrid.removeRow(row);
    }
}
function onLeftGridSelectionChanged() {
	var row = leftGrid.getSelected();

	loadMainAndDetailInfo(row);
}
/*function onRightGridSelectionChanged(){    
    var row = rightGrid.getSelected(); 
   
	if(row){
	}else{
		row = {};
		row.guestId = null;
		row.partId = null;
		row.storeId = null;
		//addInsertRow();
	}
	row.guestId = nui.get('guestId').getValue();

    document.getElementById("formIframe").contentWindow.setInitEmbedParams(row);

    //如果是最后一行，则新增一行；最后一行的备注填写完后也新增一行；保存时如果存在配件内码为空则删除
}*/
function setBottomData(row){
	var type = row.type;
	document.getElementById("formIframe").contentWindow.setInitEmbedParams(row);
}
function loadRightGridData(mainId, auditSign) {
	editPartHash = {};
	var params = {};
	params.mainId = mainId;
	params.auditSign = auditSign;
	rightGrid.load({
		params : params,
		token : token
	},function(){

		var tab = mainTabs.getActiveTab();
		if(tab.name == "billmain"){
			var data = rightGrid.getData();
			if(data && data.length <= 0){
				addNewRow(false);
			}	
		}

	});



	
}
function onLeftGridDrawCell(e) {
	switch (e.field) {
		case "auditSign":
			if (AuditSignHash && AuditSignHash[e.value]) {
				e.cellHtml = AuditSignHash[e.value];
			}
			break;
		case "billStatusId":
			if (StatusHash && StatusHash[e.value]) {
				e.cellHtml = StatusHash[e.value];
			}
			break;
	}

}
var currType = 2;
function quickSearch(type) {
	var params = {};
	var querysign = 1;
	var queryname = "本日";
	var querytypename = "未审";
	var querystatusname = "草稿";
	switch (type) {
	case 0:
		params.today = 1;
		params.startDate = getNowStartDate();
		params.endDate = addDate(getNowEndDate(), 1);
		queryname = "本日";
		querysign = 1;
		gsparams.startDate = getNowStartDate();
		gsparams.endDate = addDate(getNowEndDate(), 1);
		break;
	case 1:
		params.yesterday = 1;
		params.startDate = getPrevStartDate();
		params.endDate = addDate(getPrevEndDate(), 1);
		queryname = "昨日";
		querysign = 1;
		gsparams.startDate = getPrevStartDate();
		gsparams.endDate = addDate(getPrevEndDate(), 1);
		break;
	case 2:
		params.thisWeek = 1;
		params.startDate = getWeekStartDate();
		params.endDate = addDate(getWeekEndDate(), 1);
		queryname = "本周";
		querysign = 1;
		gsparams.startDate = getWeekStartDate();
		gsparams.endDate = addDate(getWeekEndDate(), 1);
		break;
	case 3:
		params.lastWeek = 1;
		params.startDate = getLastWeekStartDate();
		params.endDate = addDate(getLastWeekEndDate(), 1);
		queryname = "上周";
		querysign = 1;
		gsparams.startDate = getLastWeekStartDate();
		gsparams.endDate = addDate(getLastWeekEndDate(), 1);
		break;
	case 4:
		params.thisMonth = 1;
		params.startDate = getMonthStartDate();
		params.endDate = addDate(getMonthEndDate(), 1);
		queryname = "本月";
		querysign = 1;
		gsparams.startDate = getMonthStartDate();
		gsparams.endDate = addDate(getMonthEndDate(), 1);
		break;
	case 5:
		params.lastMonth = 1;
		params.startDate = getLastMonthStartDate();
		params.endDate = addDate(getLastMonthEndDate(), 1);
		queryname = "上月";
		querysign = 1;
		gsparams.startDate = getLastMonthStartDate();
		gsparams.endDate = addDate(getLastMonthEndDate(), 1);
		break;
	case 6:
		params.auditSign = 0;
		querytypename = "未审";
		querysign = 2;
		//gsparams.auditSign = 0;
		break;
	case 7:
		params.auditSign = 1;
		querytypename = "已审";
		querysign = 2;
		//gsparams.auditSign = 1;
		break;
	case 10:
		querystatusname = "草稿";
		gsparams.billStatusId = 0;
		gsparams.auditSign = 0;
		querysign = 3;
		break;
	case 11:
		querystatusname = "待发货";
		gsparams.billStatusId = 1;
		gsparams.auditSign = 1;
		querysign = 3;
		break;
	case 12:
		querystatusname = "待收货";
		gsparams.billStatusId = 2;
		gsparams.auditSign = 1;
		querysign = 3;
		break;
	// case 13:
	// 	querystatusname = "部分入库";
	// 	gsparams.billStatusId = 3;
	// 	gsparams.auditSign = 1;
	// 	querysign = 3;
	// 	break;
	case 14:
		querystatusname = "已入库";
		gsparams.billStatusId = 4;
		gsparams.auditSign = 1;
		querysign = 3;
		break;
	case 15:
		querystatusname = "已退回";
		gsparams.billStatusId = 5;
		gsparams.auditSign = 1;
		querysign = 3;
		break;
	case 16:
		querystatusname = "已关闭";
		gsparams.billStatusId = 6;
		gsparams.auditSign = 1;
		querysign = 3;
		break;
	/*case 17:
		querystatusname = "全部";
		gsparams.billStatusId = null;
		gsparams.auditSign = null;
		querysign = 3;
		break;*/
	/*case 9:
		querytypename = "全部";
		querysign = 2;
		gsparams.auditSign = null;
		break;*/
	default:
		params.today = 1;
		params.startDate = getNowStartDate();
		params.endDate = addDate(getNowEndDate(), 1);
		querytypename = "未审";
		gsparams.startDate = getNowStartDate();
		gsparams.endDate = addDate(getNowEndDate(), 1);
		//gsparams.auditSign = 0;
		gsparams.billStatusId = 0;
		break;
	}
	currType = type;
	/*if ($("a[id*='type']").length > 0) {
		$("a[id*='type']").css("color", "black");
	}
	if ($("#type" + type).length > 0) {
		$("#type" + type).css("color", "blue");
	}*/
	if(querysign == 1){
		var menunamedate = nui.get("menunamedate");
		menunamedate.setText(queryname);
	}else if(querysign == 2){
		var menunametype = nui.get("menunametype");
		menunametype.setText(querytypename);
	}else if(querysign == 3){
		var menubillstatus = nui.get("menubillstatus");
		menubillstatus.setText(querystatusname);
	}

	doSearch(gsparams);
}
function onSearch() {
	search();
}
function search() {
	var param = getSearchParam();
	doSearch(param);
}
function getSearchParam() {
	var params = {};
	params = gsparams;
	params.guestId = nui.get("searchGuestId").getValue();
	return params;
}
function setBtnable(flag) {
	if (flag) {
		nui.get("saveBtn").enable();
		nui.get("auditBtn").enable();
		//nui.get("printBtn").enable();
	} else {
		nui.get("saveBtn").disable();
		nui.get("auditBtn").disable();
		//nui.get("printBtn").disable();
	}
}
function setEditable(flag) {
	if (flag) {
		document.getElementById("fd1").disabled = false;
	} else {
		document.getElementById("fd1").disabled = true;
	}
}
function doSearch(params) {
	// 目前没有区域采购订单，销退受理 params.enterTypeId = '050101';
	params.orderTypeId = 1;
	params.isDiffOrder = 0;
	leftGrid.load({
		params : params,
		token : token
	}, function() {
		// onLeftGridRowDblClick({});
		var data = leftGrid.getData().length;
		if (data <= 0) {
			basicInfoForm.reset();
			rightGrid.clearRows();

			setBtnable(false);
			setEditable(false);

		} else {
			var row = leftGrid.getSelected();
			if (row.auditSign == 1) {
				document.getElementById("basicInfoForm").disabled = true;
				setBtnable(false);
				setEditable(false);
			} else {
				document.getElementById("basicInfoForm").disabled = false;
				setBtnable(true);
				setEditable(true);
			}
		}
	});
}
function advancedSearch() {
	advancedSearchWin.show();
	// advancedSearchForm.clear();
	if (advancedSearchFormData) {
		advancedSearchForm.setData(advancedSearchFormData);
	}else{
		sOrderDate.setValue(getWeekStartDate());
		eOrderDate.setValue(addDate(getWeekEndDate(), 1));
	}
}
function onAdvancedSearchOk() {
	var searchData = advancedSearchForm.getData();
	var i;
	// 订货日期
	if (searchData.sOrderDate) {
		searchData.sOrderDate = searchData.sOrderDate.substr(0, 10);
	}
	if (searchData.eOrderDate) {
		var date = searchData.eOrderDate;
		searchData.eOrderDate = addDate(date, 1);
		searchData.eOrderDate = searchData.eOrderDate.substr(0, 10);
	}
	// 创建日期
	if (searchData.sCreateDate) {
		searchData.sCreateDate = searchData.sCreateDate.substr(0, 10);
	}
	if (searchData.eCreateDate) {
		var date = searchData.eCreateDate;
		searchData.eCreateDate = addDate(date, 1);
		searchData.eCreateDate = searchData.eCreateDate.substr(0, 10);
	}
	// 审核日期
	if (searchData.sAuditDate) {
		searchData.sAuditDate = searchData.sAuditDate.substr(0, 10);
	}
	if (searchData.eAuditDate) {
		var date = searchData.eAuditDate;
		searchData.eAuditDate = addDate(date, 1);
		searchData.eAuditDate = searchData.eAuditDate.substr(0, 10);
	}
	// 供应商
	if (searchData.guestId) {
		searchData.guestId = nui.get("advanceGuestId").getValue();
	}
	// 订单单号
	if (searchData.serviceIdList) {
		var tmpList = searchData.serviceIdList.split("\n");
		for (i = 0; i < tmpList.length; i++) {
			tmpList[i] = "'" + tmpList[i] + "'";
		}
		searchData.serviceIdList = tmpList.join(",");
	}
	// 配件编码
	if (searchData.partCodeList) {
		var tmpList = searchData.partCodeList.split("\n");
		for (i = 0; i < tmpList.length; i++) {
			tmpList[i] = "'" + tmpList[i] + "'";
		}
		searchData.partCodeList = tmpList.join(",");
	}
	searchData.billStatusId = gsparams.billStatusId;
	advancedSearchFormData = advancedSearchForm.getData();
	advancedSearchWin.hide();
	doSearch(searchData);
}
function onAdvancedSearchCancel() {
	// advancedSearchForm.clear();
	advancedSearchWin.hide();
}
function checkNew() {
	var rows = leftGrid.findRows(function(row) {
		if (row.serviceId == "新采购订单")
			return true;
	});

	return rows.length;
}

function onComboValidation(e){
	var items = this.findItems(e.value);
    if (!items || items.length == 0) {
    	var sender = e.sender;
    	var id = sender.id;
    	if(id == "storeId") {
    		//nui.get("storeId").setValue(null);
    	}
    	if(id == "billTypeId") {
    		nui.get("billTypeId").setValue(null);
    	}
    	if(id == "settleTypeId") {
    		nui.get("settleTypeId").setValue(null);
    	}
        
    }
}

function add() {

	if(isNeedSet){
		showMsg("请先到仓库定义功能设置仓库!","W");
		return;
	}
	mainTabs.activeTab(billmainTab);
	if (checkNew() > 0) {
		showMsg("请先保存数据!","W");
		return;
	}

	var formJsonThis = nui.encode(basicInfoForm.getData());
	var len = rightGrid.getData().length;

	if (formJson != formJsonThis && len > 0) {// 
		nui.confirm("您正在编辑数据,是否要继续?", "友情提示", function(action) {
			if (action == "ok") {

				setBtnable(true);
				setEditable(true);

				basicInfoForm.reset();
				rightGrid.clearRows();


				var newRow = {
					serviceId : '新采购订单',
					auditSign : 0
				};
				leftGrid.addRow(newRow, 0);
				leftGrid.clearSelect(false);
				leftGrid.select(newRow, false);

				nui.get("serviceId").setValue("新采购订单");
				nui.get("billTypeId").setValue("010103"); // 010101 收据 010102 普票 010103 增票
				nui.get("createDate").setValue(new Date());
				nui.get("orderMan").setValue(currUserName);

				addNewRow();

				var guestId = nui.get("guestId");
				guestId.focus();

			} else {
				return;
			}
		});
	}else{
		setBtnable(true);
		setEditable(true);

		basicInfoForm.reset();
		rightGrid.clearRows();


		var newRow = {
			serviceId : '新采购订单',
			auditSign : 0
		};
		leftGrid.addRow(newRow, 0);
		leftGrid.clearSelect(false);
		leftGrid.select(newRow, false);

		nui.get("serviceId").setValue("新采购订单");
		nui.get("billTypeId").setValue("010103"); // 010101 收据 010102 普票 010103 增票
		nui.get("createDate").setValue(new Date());
		nui.get("orderMan").setValue(currUserName);

		addNewRow();

		var guestId = nui.get("guestId");
		guestId.focus();

	}

	
}
function getMainData() {
	var data = basicInfoForm.getData();
	// 汇总明细数据到主表
	data.isFinished = 0;
	data.auditSign = 0;
	data.billStatusId = 0;
	data.printTimes = 0;
	data.orderTypeId = 1;
	data.isDiffOrder = 0;

	if (data.operateDate) {
		data.operateDate = format(data.operateDate, 'yyyy-MM-dd HH:mm:ss')
				+ '.0';// 用于后台判断数据是否在其他地方已修改
		// data.versionNo = format(data.versionNo, 'yyyy-MM-dd HH:mm:ss');
	}

	rightGrid.findRow(function(row){
		var partId = row.partId;
		var partCode = row.comPartCode;
		if(partId == null || partId == "" || partId == undefined || partCode == null || partCode == "" || partCode == undefined){
			rightGrid.removeRow(row);
		}
	});

	return data;
}
function getModifyData(data, addList, delList){
	var arr = [];
    if(data==addList) return arr;
	for(var i=0; i<addList.length; i++) {
	
	   var val = addList[i];
	   for(var j=0; j<data.length; j++) {
    	
    	   if(data[j] == val)
		   data.splice(j, 1);
		}
	}
			
	for(var i=0; i<delList.length; i++) {
	
	   var val = delList[i];
	   for(var j=0; j<data.length; j++) {
    	
    	   if(data[j] == val)
		   data.splice(j, 1);
		}
	}

	return data;
}
var requiredField = {
	guestId : "供应商",
	orderMan : "采购员",
	createDate : "订货日期",
	billTypeId : "票据类型",
	settleTypeId : "结算方式"
};
var saveUrl = baseUrl
		+ "com.hsapi.cloud.part.invoicing.crud.savePjPchsOrder.biz.ext";
function save() {
	var data = basicInfoForm.getData();
	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
			showMsg(requiredField[key] + "不能为空!","W");
			//如果检测到有必填字段未填写，切换到主表界面
			mainTabs.activeTab(billmainTab);

			return;
		}
	}

	var row = leftGrid.getSelected();
	if (row) {
		if (row.auditSign == 1) {
			showMsg("此单已审核!","W");
			return;
		}
	} else {
		return;
	}

	data = getMainData();

	//由于票据类型可能修改，所以除了新建和删除，其他都应该是修改
	var detailData = rightGrid.getData();

	var pchsOrderDetailAdd = rightGrid.getChanges("added");
	var pchsOrderDetailUpdate = rightGrid.getChanges("modified");
	var pchsOrderDetailDelete = rightGrid.getChanges("removed");
	var pchsOrderDetailUpdate = getModifyData(detailData, pchsOrderDetailAdd, pchsOrderDetailDelete);

	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '保存中...'
	});

	nui.ajax({
		url : saveUrl,
		type : "post",
		data : JSON.stringify({
			pchsOrderMain : data,
			pchsOrderDetailAdd : pchsOrderDetailAdd,
			pchsOrderDetailUpdate : pchsOrderDetailUpdate,
			pchsOrderDetailDelete : pchsOrderDetailDelete,
			token: token
		}),
		success : function(data) {
			nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
				showMsg("保存成功!","S");
				// onLeftGridRowDblClick({});
				var pjPchsOrderMainList = data.pjPchsOrderMainList;
				if (pjPchsOrderMainList && pjPchsOrderMainList.length > 0) {
					var leftRow = pjPchsOrderMainList[0];
					var row = leftGrid.getSelected();
					leftGrid.updateRow(row, leftRow);

					// 保存成功后重新加载数据
					loadMainAndDetailInfo(leftRow);

				}
			} else {
				showMsg(data.errMsg || "保存失败!","E");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}
var supplier = null;
function selectSupplier(elId) {
	supplier = null;
	nui.open({
		targetWindow : window,
		url : webPath+contextPath+"/com.hsweb.part.common.guestSelect.flow?token="+token,
		title : "供应商资料",
		width : 980,
		height : 560,
		allowDrag : true,
		allowResize : true,
		onload : function() {
			var iframe = this.getIFrameEl();
			// var params = {
            //     isSupplier: 1,
            //     guestType:'01020202'
			// };
			var params = {
                isSupplier: 1
            };
            iframe.contentWindow.setGuestData(params);
		},
		ondestroy : function(action) {
			if (action == 'ok') {
				var iframe = this.getIFrameEl();
				var data = iframe.contentWindow.getData();

				supplier = data.supplier;
				var value = supplier.id;
				var text = supplier.fullName;
				var billTypeIdV = supplier.billTypeId;
				var settTypeIdV = supplier.settTypeId;
				var el = nui.get(elId);
				el.setValue(value);
				el.setText(text);

				if (elId == 'guestId') {
					var row = leftGrid.getSelected();
					var newRow = {
						guestFullName : text,
						billTypeId: billTypeIdV,
						settleTypeId: settTypeIdV
					};
					leftGrid.updateRow(row, newRow);

					nui.get("billTypeId").setValue(billTypeIdV);
					nui.get("settleTypeId").setValue(settTypeIdV);

				}
			}
		}
	});
}
function onRightGridDraw(e) {
	switch (e.field) {
	case "comPartBrandId":
		if (brandHash[e.value]) {
			e.cellHtml = brandHash[e.value].name || "";
		} else {
			e.cellHtml = "";
		}
		break;
	case "operateBtn":
            e.cellHtml = //'<span class="fa fa-close fa-lg" onClick="javascript:deletePart()" title="删除行">&nbsp;&nbsp;&nbsp;&nbsp;</span>';
            			'<span class="fa fa-plus" onClick="javascript:addNewRow(true)" title="添加行">&nbsp;&nbsp;</span>' +
                        ' <span class="fa fa-close" onClick="javascript:deletePart()" title="删除行"></span>';
            break;
	default:
		break;
	}
}
function onCellEditEnter(e){
	var record = e.record;
	var cell = rightGrid.getCurrentCell();//行，列
	var orderPrice = record.orderPrice;
	if(cell && cell.length >= 2){
		var column = cell[1];
		if(column.field == "orderQty"){
			if(orderPrice){
				addNewKeyRow();
			}
		}else if(column.field == "orderPrice"){
			addNewKeyRow();
		}else if(column.field == "remark"){
			addNewKeyRow();
		}else if(column.field == "comPartCode"){
			var partCode = record.comPartCode||"";
            partCode = partCode.replace(/\s+/g, "");
			if(!partCode){
				showMsg("请输入编码!","W");
				var row = rightGrid.getSelected();
				rightGrid.removeRow(row);
				addNewRow(false);
				return;
			}else{
				var rs = addInsertRow(partCode,record);
				if(!rs){
					var newRow = {comPartCode: ""};
					rightGrid.updateRow(record, newRow);
					rightGrid.beginEditCell(record, "comPartCode");
					return;
				}else{
					rightGrid.beginEditCell(record, "comUnit");
				}
			}
		}
	}
}
// 提交单元格编辑数据前激发
function onCellCommitEdit(e) {
	var editor = e.editor;
	var record = e.record;
	var row = e.row;

	editor.validate();
	if (editor.isValid() == false) {
		showMsg("请输入数字!","W");
		e.cancel = true;
	} else {
		var newRow = {};
		if (e.field == "orderQty") {
			var orderQty = e.value;
			var orderPrice = record.orderPrice;

			if (e.value == null || e.value == '') {
				e.value = 0;
				orderQty = 0;
			} else if (e.value < 0) {
				e.value = 0;
				orderQty = 0;
			}

			var orderAmt = orderQty * orderPrice;

			newRow = {
				orderAmt : orderAmt
			};
			rightGrid.updateRow(e.row, newRow);

			// record.enteramt.cellHtml = enterqty * enterprice;
		} else if (e.field == "orderPrice") {
			var orderQty = record.orderQty;
			var orderPrice = e.value;
			
			if (e.value == null || e.value == '') {
				e.value = 0;
				orderPrice = 0;
			} else if (e.value < 0) {
				e.value = 0;
				orderPrice = 0;
			}

			var orderAmt = orderQty * orderPrice;

			newRow = {
				orderAmt : orderAmt
			};
			rightGrid.updateRow(e.row, newRow);		

			/*var newRow = {comPartCode:""};
            rightGrid.addRow(newRow);

            rightGrid.cancelEdit();
            //rightGrid.beginEditRow(newRow);	
            rightGrid.beginEditCell(newRow, "operateBtn");*/
            //addNewKeyRow();

		} else if (e.field == "orderAmt") {
			var orderQty = record.orderQty;
			var orderAmt = e.value;

			if (e.value == null || e.value == '') {
				e.value = 0;
				orderAmt = 0;
			} else if (e.value < 0) {
				e.value = 0;
				orderAmt = 0;
			}

			// e.cellHtml = enterqty * enterprice;
			var orderPrice = orderAmt * 1.0 / orderQty;


			if (orderQty) {
				newRow = {
					orderPrice : orderPrice
				};
				rightGrid.updateRow(e.row, newRow);
			}

			//addNewKeyRow();

		}else if(e.field == "comPartCode"){
			oldValue = e.oldValue;
			oldRow = row;
			/*if(!e.value){
				nui.alert("请输入编码!","提示",function(){
					var row = rightGrid.getSelected();
					rightGrid.removeRow(row);
					addNewRow(false);
				});
				return;
			}else{
				var rs = addInsertRow(e.value,row);
				if(!rs){
					var newRow = {comPartCode: ""};
					rightGrid.updateRow(row, newRow);
					rightGrid.beginEditCell(row, "comPartCode");
					return;
				}else{
					rightGrid.beginEditCell(row, "comUnit");
				}
			}*/
    		
		}else if(e.field == "remark"){
			//addNewKeyRow();
		}
	}
}
var partInfoUrl = baseUrl + "com.hsapi.cloud.part.invoicing.paramcrud.queryBillPartChoose.biz.ext";
		//+ "com.hsapi.cloud.part.invoicing.paramcrud.queryPartInfoByParam.biz.ext";
function getPartInfo(params){
	var part = null;
	var page = {size:100,length:100};
	params.sortField = "b.stock_qty";
    params.sortOrder = "desc";
	nui.ajax({
		url : partInfoUrl,
		type : "post",
		async: false,
		data : {
			params: params,
			token: token
		},
		success : function(data) {
			var partlist = data.parts;
			if(partlist && partlist.length>0){
				//如果只返回一条数据，直接添加；否则切换到配件选择界面按输入的条件输出
				if(partlist.length==1){
					part = partlist[0];
					
				}else{
					advancedMorePartWin.show();
					morePartGrid.setData(partlist);
					partShow = 1;
					//mainTabs.activeTab(partInfoTab);
					//var partCode = params.partCode;
					//var partName = params.partName;
					//var param = {code:partCode, name:partName};
					//document.getElementById("formIframePart").contentWindow.initData(params.partCode);
					//mainTabs.getTabIFrameEl(partInfoTab).contentWindow.initData(params.partCode);
				}
				
			}else{
				//清空行数据
				// nui.confirm("没有搜索到配件信息，是否需要新增?", "友情提示", function(action) {
				// 	if (action == "ok") {

				// 		var row = rightGrid.getSelected();
				// 		rightGrid.removeRow(row);
				// 		addNewRow(false);
				// 	} else {
				// 		var row = rightGrid.getSelected();
				// 		rightGrid.removeRow(row);
				// 		addNewRow(false);
				// 		return;
				// 	}
				// });
				showMsg("没有搜索到配件信息!","W");
				var row = rightGrid.getSelected();
				rightGrid.removeRow(row);
				addNewRow(false);
				/*var row = rightGrid.getSelected();
				var newRow = {comPartCode: ""};

				rightGrid.cancelEdit();
				rightGrid.updateRow(row, newRow);
				rightGrid.beginEditCell(row,"comPartCode");*/
			}

		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});

	return part;
}
function selectPart(callback, checkcallback) {
	nui.open({
		targetWindow : window,
		url : webPath+contextPath+"/com.hsweb.cloud.part.common.partSelectView.flow?token="+token,
		title : "配件选择",
		width : 930,
		height : 560,
		allowDrag : true,
		allowResize : true,
		onload : function() {
			var iframe = this.getIFrameEl();
			iframe.contentWindow.setData({}, callback, checkcallback);
		},
		ondestroy : function(action) {
		}
	});
}
function addDetail(part) {
	var data = basicInfoForm.getData();
	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
			showMsg(requiredField[key] + "不能为空!","W");
			//如果检测到有必填字段未填写，切换到主表界面
			mainTabs.activeTab(billmainTab);

			return;
		}
	}

	var row = leftGrid.getSelected();
	if (row) {
		if (row.auditSign == 1) {
			showMsg("此单已审核!","W");
			return;
		}
	} else {
		return;
	}
	
	nui.open({
				targetWindow : window,
				url : webPath+contextPath+"/com.hsweb.cloud.part.common.detailQPAPopOperate.flow?token="+token,
				title : "入库数量金额",
				width : 430,
				height : 210,
				allowDrag : true,
				allowResize : false,
				onload : function() {
					var iframe = this.getIFrameEl();
					part.storeId = FStoreId;//nui.get("storeId").getValue();
					iframe.contentWindow.setData({
						part : part,
						priceType : "pchsIn"
					});
				},
				ondestroy : function(action) {
					if (action == "ok") {
						var iframe = this.getIFrameEl();
						var data = iframe.contentWindow.getData();
						var enterDetail = {};
						enterDetail.partId = data.id;
						enterDetail.comPartCode = data.code;
						enterDetail.comPartName = data.name;
						enterDetail.comPartBrandId = data.partBrandId;
						enterDetail.comApplyCarModel = data.applyCarModel;
						enterDetail.comUnit = data.unit;
						enterDetail.orderQty = data.qty;
						enterDetail.orderPrice = data.price;
						enterDetail.orderAmt = data.amt;
						enterDetail.remark = data.remark;
						enterDetail.storeId = data.storeId;
						enterDetail.comOemCode = data.oemCode;
						enterDetail.comSpec = data.spec;
						enterDetail.partCode = data.code;
						enterDetail.partName = data.name;
						enterDetail.fullName = data.fullName;
						enterDetail.systemUnitId = data.unit;
						enterDetail.enterUnitId = data.unit;

						rightGrid.addRow(enterDetail);
					}
				}
			});
}
var partPriceUrl = baseUrl
		+ "com.hsapi.cloud.part.invoicing.pricemanage.getPchsDefaultPrice.biz.ext";
function getPartPrice(params){
	var price = 0;
	var shelf = null;
	nui.ajax({
		url : partPriceUrl,
		type : "post",
		async: false,
		data : {
			params: params,
			token: token
		},
		success : function(data) {
			var errCode = data.errCode;
			if(errCode == "S"){
				var priceRecord = data.priceRecord;
				if(priceRecord.pchsPrice){
					price = priceRecord.pchsPrice;
				}
				if(priceRecord.shelf){
					shelf = priceRecord.shelf;
				}
			}

		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});

	var dInfo = {price: price, shelf: shelf};

	return dInfo;
}
function addInsertRow(value,row) {    
    /*var rows = checkAddNewRow();
    if(rows && rows.length > 0) {
    	var row = rows[0];
    	rightGrid.beginEditCell(row, "comPartCode");
    	return;
    }   
	var data = rightGrid.getData();
	var index = data.length;
    var newRow = { comPartCode: "" };
    rightGrid.addRow(newRow,index);

    rightGrid.beginEditCell(newRow, "comPartCode");*/


    var params = {partCode:value};
	var part = getPartInfo(params);
	var storeId = FStoreId;

	if(part){
		params.partId = part.id;
		params.storeId = storeId;
		var dInfo = getPartPrice(params);
		var price = dInfo.price;
		var shelf = dInfo.shelf;
					
		var newRow = {
			partId : part.id,
			comPartCode : part.code,
			comPartName : part.name,
			comPartBrandId : part.partBrandId,
			comApplyCarModel : part.applyCarModel,
			comUnit : part.unit,
			orderQty : 1,
			orderPrice : price,
			orderAmt : price,
			storeId : storeId,
			storeShelf : shelf,
			comOemCode : part.oemCode,
			comSpec : part.spec,
			partCode : part.code,
			partName : part.name,
			fullName : part.fullName,
			systemUnitId : part.unit,
			enterUnitId : part.unit
		};

		if(row){
			rightGrid.updateRow(row,newRow);
			//rightGrid.beginEditCell(row, "comUnit");
		}else{
			rightGrid.addRow(newRow);
			//rightGrid.beginEditCell(row, "comUnit");
		}
	
		return true;
	}else{
		var newRow = {};
		if(row){
			rightGrid.updateRow(row,newRow);
			rightGrid.beginEditCell(row, "comPartCode");
		}
		return true;
	}

	return false;
}
function addPart() {
	var row = leftGrid.getSelected();
	if (row) {
		if (row.auditSign == 1) {
			return;
		}
	}

	selectPart(function(data) {
		var part = data.part;
		addDetail(part);
	}, function(data) {
		var part = data.part;
		var partid = part.id;
		var rtn = checkPartIDExists(partid);
		return rtn;
	});
}
function checkAddNewRow() {
	var rows = rightGrid.findRows(function(row) {
		if (row.comPartCode == ""||row.comPartCode == null||row.comPartCode == undefined)
			return true;
	});

	return rows;
}
function checkPartIDExists(partid) {
	var row = rightGrid.findRow(function(row) {
		if (row.partId == partid) {
			return true;
		}
		return false;
	});

	if (row) {
		return "配件编码：" + row.comPartCode + "在采购订单列表中已经存在，是否继续？";
	}

	return null;

}
var editPartHash = {};
function deletePart() {
	var row = leftGrid.getSelected();
	if (row) {
		if (row.auditSign == 1) {
			return;
		}
	}

	var part = rightGrid.getSelected();
	if (!part) {
		return;
	}
	if (part.detailId && editPartHash[part.detailId]) {
		delete editPartHash[part.detailId];
	}
	var data = rightGrid.getData();
    if(data && data.length==1){
        var row = rightGrid.getSelected();
        rightGrid.removeRow(row);
        var newRow = {};
        rightGrid.addRow(newRow);
        rightGrid.beginEditCell(newRow, "comPartCode");
    }else{
        var row = rightGrid.getSelected();
        rightGrid.removeRow(row);
    }
}
function checkRightData() {
	var msg = '';
	var qtyArr = [];
	var priceArr = [];
	var rows = rightGrid.findRows(function(row) {
		if(row.partId){
			if (row.orderQty) {
				if (row.orderQty <= 0){
					var newRow = {partCode: row.comPartCode};
					qtyArr.push(newRow);
					return true;
				}
			} else {
				if (row.orderQty <= 0){
					var newRow = {partCode: row.comPartCode};
					qtyArr.push(newRow);
					return true;
				}
			}
			if (row.orderPrice) {
				if (row.orderPrice <= 0){
					var newRow = {partCode: row.comPartCode};
					priceArr.push(newRow);
					return true;
				}
			} else {
				if (row.orderPrice <= 0){
					var newRow = {partCode: row.comPartCode};
					priceArr.push(newRow);
					return true;
				}
			}
			if (row.orderAmt) {
				if (row.orderAmt <= 0){
					var newRow = {partCode: row.comPartCode};
					priceArr.push(newRow);
					return true;
				}
			} else {
				if (row.orderAmt <= 0){
					var newRow = {partCode: row.comPartCode};
					priceArr.push(newRow);
					return true;
				}
			}

			if (row.storeId) {
			} else {
				return true;
			}	
		}

	});

	var p = {};
	if(qtyArr && qtyArr.length>0){
		p.qtyPartCode = qtyArr[0].partCode;
	}
	if(priceArr && priceArr.length>0){
		p.pricePartCode = priceArr[0].partCode;
	}
	// if (rows && rows.length > 0) {
	// 	msg = "请完善采购配件的数量，单价，金额，仓库等信息！";
	// }
	return p;
}
function audit(){
	var data = basicInfoForm.getData();
	var flagSign = 0; 
	var flagStr = "提交中...";
	var flagRtn = "提交成功!";
	auditOrder(flagSign, flagStr, flagRtn);
}
function auditToEnter(){
	//如果是内部订单，直接入库时需要判断 bill_status_id = 2（待收货）
	var data = basicInfoForm.getData();
	var isInner = data.isInner||0;
	var billStatusId = data.billStatusId||0;
	if(billStatusId == 0){
		showMsg("请先提交再入库!","W");
		return;
	}else if(billStatusId == 2 || billStatusId == 1){  //待发货和待收货状态下都可以入库
		var id = data.id||0;
		orderEnter(id);	
	}

	

}
var auditUrl = baseUrl
		+ "com.hsapi.cloud.part.invoicing.crud.auditPjPchsOrder.biz.ext";
function auditOrder(flagSign, flagStr, flagRtn) {
	var data = basicInfoForm.getData();
	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
			showMsg(requiredField[key] + "不能为空!","W");

			mainTabs.activeTab(billmainTab);
			return;
		}
	}

	var row = leftGrid.getSelected();
	if (row) {
		if (row.auditSign == 1) {
			showMsg("此单已审核!","W");
			return;
		}
	} else {
		return;
	}

	// 审核时，数量，单价，金额，仓库不能为空,单价可以为0，只需要提示
	var p = checkRightData();
	if (p && p.qtyPartCode) {
		var partCode = p.qtyPartCode;
		showMsg("配件编码:"+partCode+"数量为0","W");
		return;
	}

	var str = "提交";
	if(flagSign == 1){
		str = "入库";
	}

	if (p && p.pricePartCode) {
		var partCode = p.pricePartCode;
		nui.confirm("存在单价为0信息，是否继续?", "友情提示", function(action) {
			if (action == "ok") {
	
				data = getMainData();
	
				//由于票据类型可能修改，所以除了新建和删除，其他都应该是修改
				var detailData = rightGrid.getData();
	
				var pchsOrderDetailAdd = rightGrid.getChanges("added");
				var pchsOrderDetailUpdate = rightGrid.getChanges("modified");
				var pchsOrderDetailDelete = rightGrid.getChanges("removed");
				var pchsOrderDetailUpdate = getModifyData(detailData, pchsOrderDetailAdd, pchsOrderDetailDelete);
	
	
				nui.mask({
					el : document.body,
					cls : 'mini-mask-loading',
					html : flagStr
				});
	
				nui.ajax({
					url : auditUrl,
					type : "post",
					data : JSON.stringify({
						pchsOrderMain : data,
						pchsOrderDetailAdd : pchsOrderDetailAdd,
						pchsOrderDetailUpdate : pchsOrderDetailUpdate,
						pchsOrderDetailDelete : pchsOrderDetailDelete,
						operateFlag : flagSign,
						token: token
					}),
					success : function(data) {
						nui.unmask(document.body);
						data = data || {};
						if (data.errCode == "S") {
							showMsg(str+"成功!","S");
							// onLeftGridRowDblClick({});
							var pjPchsOrderMainList = data.pjPchsOrderMainList;
							if (pjPchsOrderMainList && pjPchsOrderMainList.length > 0) {
								var leftRow = pjPchsOrderMainList[0];
								var row = leftGrid.getSelected();
								leftGrid.updateRow(row, leftRow);
	
								// 保存成功后重新加载数据
								//loadMainAndDetailInfo(leftRow);
								rightGrid.setData([]);
								add();
	
								mainTabs.activeTab(billmainTab);
							}
						} else {
							showMsg(data.errMsg || (str+"失败!"),"W");
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						// nui.alert(jqXHR.responseText);
						console.log(jqXHR.responseText);
					}
				});
	
			} else {
				return;
			}
		});
	}else {
		nui.confirm("是否确定"+str+"?", "友情提示", function(action) {
			if (action == "ok") {
	
				data = getMainData();
	
				//由于票据类型可能修改，所以除了新建和删除，其他都应该是修改
				var detailData = rightGrid.getData();
	
				var pchsOrderDetailAdd = rightGrid.getChanges("added");
				var pchsOrderDetailUpdate = rightGrid.getChanges("modified");
				var pchsOrderDetailDelete = rightGrid.getChanges("removed");
				var pchsOrderDetailUpdate = getModifyData(detailData, pchsOrderDetailAdd, pchsOrderDetailDelete);
	
	
				nui.mask({
					el : document.body,
					cls : 'mini-mask-loading',
					html : flagStr
				});
	
				nui.ajax({
					url : auditUrl,
					type : "post",
					data : JSON.stringify({
						pchsOrderMain : data,
						pchsOrderDetailAdd : pchsOrderDetailAdd,
						pchsOrderDetailUpdate : pchsOrderDetailUpdate,
						pchsOrderDetailDelete : pchsOrderDetailDelete,
						operateFlag : flagSign,
						token: token
					}),
					success : function(data) {
						nui.unmask(document.body);
						data = data || {};
						if (data.errCode == "S") {
							showMsg(str+"成功!","S");
							// onLeftGridRowDblClick({});
							var pjPchsOrderMainList = data.pjPchsOrderMainList;
							if (pjPchsOrderMainList && pjPchsOrderMainList.length > 0) {
								var leftRow = pjPchsOrderMainList[0];
								var row = leftGrid.getSelected();
								leftGrid.updateRow(row, leftRow);
	
								// 保存成功后重新加载数据
								//loadMainAndDetailInfo(leftRow);
								rightGrid.setData([]);
								add();
	
								mainTabs.activeTab(billmainTab);
							}
						} else {
							showMsg(data.errMsg || (str+"失败!"),"W");
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						// nui.alert(jqXHR.responseText);
						console.log(jqXHR.responseText);
					}
				});
	
			} else {
				return;
			}
		});
	}

}

var enterUrl = baseUrl
		+ "com.hsapi.cloud.part.invoicing.ordersettle.generateNewPchsOrderEnter.biz.ext";
function orderEnter(mainId) {
	var row = leftGrid.getSelected();
	if(row.auditSign!=1){
		showMsg("请先提交再入库!","W");
		return;
	}
	if (row) {
		if (row.auditSign == 1 && row.billStatusId == 4) {
			showMsg("此单已入库!","W");
			return;
		}
	} else {
		return;
	}

	nui.confirm("是否确定入库?", "友情提示", function(action) {
		if (action == "ok") {

			nui.mask({
				el : document.body,
				cls : 'mini-mask-loading',
				html : '入库中...'
			});

			nui.ajax({
				url : enterUrl,
				type : "post",
				data : JSON.stringify({
					orderMainId : mainId,
					token: token
				}),
				success : function(data) {
					nui.unmask(document.body);
					data = data || {};
					if (data.errCode == "S") {
						showMsg("入库成功!","S");
						// onLeftGridRowDblClick({});
						var newRow = {billStatusId: 4};
						var row = leftGrid.getSelected();
						leftGrid.updateRow(row, newRow);

						//basicInfoForm.setData(newRow);
						rightGrid.setData([]);
						add();

					} else {
						showMsg(data.errMsg || "入库失败!","W");
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					// nui.alert(jqXHR.responseText);
					console.log(jqXHR.responseText);
				}
			});

		} else {
			return;
		}
	});

	
}
function onDrawSummaryCell(e) {
	var rows = e.data;// rightGrid.getData();
	if (e.field == "orderAmt") {
		var orderAmt = 0;
		for (var i = 0; i < rows.length; i++) {
			orderAmt += parseFloat(rows[i].orderAmt);
		}
		//nui.get("orderAmt").setValue(orderAmt);
	}
}
function onGuestValueChanged(e) {
	// 供应商中直接输入名称加载供应商信息
	var params = {};
	params.pny = e.value;
	params.isSupplier = 1;
	setGuestInfo(params);
}
var getGuestInfo = baseUrl
		+ "com.hsapi.cloud.part.baseDataCrud.crud.querySupplierList.biz.ext";
function setGuestInfo(params) {
	nui.ajax({
		url : getGuestInfo,
		async:false,
		data : {
			params : params,
			token : token
		},
		type : "post",
		success : function(text) {
			if (text) {
				var supplier = text.suppliers;
				if (supplier && supplier.length > 0) {
					var data = supplier[0];
					var value = data.id;
					var text = data.fullName;
					var el = nui.get('guestId');
					el.setValue(value);
					el.setText(text);

					var row = leftGrid.getSelected();
					var newRow = {
						guestFullName : text
					};
					leftGrid.updateRow(row, newRow);

					var billTypeIdV = data.billTypeId;
					var settTypeIdV = data.settTypeId;

					nui.get("billTypeId").setValue(billTypeIdV);
					nui.get("settleTypeId").setValue(settTypeIdV);

					addNewRow(true);
					
				} else {
					var el = nui.get('guestId');
					el.setValue(null);
					el.setText(null);

					var row = leftGrid.getSelected();
					var newRow = {
						guestFullName : null
					};
					leftGrid.updateRow(row, newRow);

					nui.get("billTypeId").setValue("010103"); // 010101 收据 010102 普票 010103 增票

					addGuest();
				}
			} else {
				var el = nui.get('guestId');
				el.setValue(null);
				el.setText(null);

				var row = leftGrid.getSelected();
				var newRow = {
					guestFullName : null
				};
				leftGrid.updateRow(row, newRow);

				nui.get("billTypeId").setValue("010103");

				addGuest();
			}

		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}
function addGuest(){
	nui.confirm("此供应商不存在，是否新增?", "友情提示", function(action) {
		if (action == "ok") {
			nui.open({
				targetWindow: window,
				url: webPath+contextPath+"/com.hsweb.part.baseData.supplierDetail.flow?token=" + token,
				title: "供应商资料", width: 530, height: 480,
				allowDrag:true,
				allowResize:false,
				onload: function ()
				{
					var iframe = this.getIFrameEl();
					iframe.contentWindow.setData({
						province:[],
						city:[],
						supplierType:[],
						billTypeId:nui.get("billTypeId").getData(),
						settTypeId:nui.get("settleTypeId").getData(),
						tgrade:[],
						managerDuty:[]
					});
				},
				ondestroy: function (action)
				{
					if(action == "ok")
					{
						
					}
					nui.get("guestId").focus();
				}
			});

		}else{
			nui.get("guestId").focus();
		}
	});
}
function onPrint() {
	var row = leftGrid.getSelected();

	var data = rightGrid.getData();
	if(data && data.length<=0) return;

	if (row) {

		if(!row.id) return;

		var auditSign = row.auditSign||0;

		nui.open({

			url : webPath + contextPath + "/com.hsweb.cloud.part.purchase.purchaseOrderPrint.flow?ID="
					+ row.id+"&printMan="+currUserName+"&auditSign="+auditSign,// "view_Guest.jsp",
			title : "采购订单打印",
			width : 900,
			height : 600,
			onload : function() {
				var iframe = this.getIFrameEl();
				// iframe.contentWindow.setInitData(storeId, 'XSD');
			}
		});
	}
	// }else if(row && type == 1){
	// 	if(!row.id) return;

	// 	if(row.isFinished != 1) {
	// 		showMsg("全部入库后才能打印进货单!","W");
	// 		return;
	// 	}

	// 	nui.open({

	// 		url : webPath + contextPath + "/com.hsweb.cloud.part.purchase.pchsOrderEnterPrint.flow?ID="
	// 				+ row.id+"&printMan="+currUserName,// "view_Guest.jsp",
	// 		title : "进货单打印",
	// 		width : 900,
	// 		height : 600,
	// 		onload : function() {
	// 			var iframe = this.getIFrameEl();
	// 			// iframe.contentWindow.setInitData(storeId, 'XSD');
	// 		}
	// 	});
	// }

}
function addSelectPart(){
	var row = morePartGrid.getSelected();
	if(row){
		var params = {partCode:row.code};
		params.partId = row.id;
		params.storeId = FStoreId;
		var dInfo = getPartPrice(params);
		var price = dInfo.price;
		var shelf = dInfo.shelf;
					
		var newRow = {
			partId : row.id,
			comPartCode : row.code,
			comPartName : row.name,
			comPartBrandId : row.partBrandId,
			comApplyCarModel : row.applyCarModel,
			comUnit : row.unit,
			orderQty : 1,
			orderPrice : price,
			orderAmt : price,
			storeId : FStoreId,
			comOemCode : row.oemCode,
			comSpec : row.spec,
			partCode : row.code,
			partName : row.name,
			fullName : row.fullName,
			systemUnitId : row.unit,
			enterUnitId : row.unit
		};

		advancedMorePartWin.hide();
		morePartGrid.setData([]);
		partShow = 0;

		if(rightGrid.getSelected()){
			rightGrid.updateRow(rightGrid.getSelected(),newRow);
		}else{
			rightGrid.addRow(newRow);
		}
		rightGrid.beginEditCell(rightGrid.getSelected(), "orderQty");

		
	}else{
		showMsg("请选择配件!","W");
		return;
	}
}
function onPartClose(){
	advancedMorePartWin.hide();
	morePartGrid.setData([]);
	partShow = 0;

	var newRow = {comPartCode: oldValue};
	rightGrid.updateRow(oldRow, newRow);
	rightGrid.beginEditCell(oldRow, "comPartCode");
}
function OnrpMainGridCellBeginEdit(e){
    var field=e.field; 
    var editor = e.editor;
    var row = e.row;
    var column = e.column;
    var editor = e.editor;

    var data = basicInfoForm.getData();

    if(data.auditSign == 1){
        e.cancel = true;
	}
	if(advancedMorePartWin.visible) {
		e.cancel = true;
		morePartGrid.focus();
	}

}
function addMorePart(){
	var row = leftGrid.getSelected();
	if(row.auditSign == 1){
		showMsg("此单已审核!","W");
		return;
	}

	var main = basicInfoForm.getData();
	if(!main.id){
		showMsg("请先保存单据!","W");
		return;
	}
	advancedAddForm.setData([]);
	advancedAddWin.show();
	quickAddShow=1;

	var fastCodeList = nui.get("fastCodeList");
	fastCodeList.focus();
}

function onAdvancedAddOk(){
	var data = advancedAddForm.getData();
	var fastCodeList = nui.get("fastCodeList");
	fastCodeList.focus();
	if(data && data.fastCodeList) {
		var partList = [];
		var fastCodeList = data.fastCodeList;
		var tmpList = fastCodeList.split("\n");
		for (i = 0; i < tmpList.length; i++) {
			var partObj = {};
			partTmpList = tmpList[i].split("*")||[];
			if(partTmpList.length != 3){
				showMsg("第"+(i+1)+"条录入信息格式有问题!","W");
				return;
			}

			partObj.partCode = partTmpList[0].replace(/\s+/g, "");
			partObj.orderQty = partTmpList[1];
			partObj.orderPrice = partTmpList[2];
			partList.push(partObj);
		}

		if(partList && partList.length>0){
			nui.mask({
				el : document.body,
				cls : 'mini-mask-loading',
				html : '处理中,请稍等...'
			});

			nui.ajax({
				url : baseUrl + "com.hsapi.cloud.part.invoicing.paramcrud.getPartInfoByCodes.biz.ext",
				type : "post",
				data : JSON.stringify({
					list : partList,
					token: token
				}),
				success : function(data) {
					nui.unmask(document.body);
					data = data || {};
					var rtnList = data.rtnList;
					if (data.errCode == "S") {
						addRtnList(rtnList);
						var msg = data.errMsg;
						if(msg){
							showMsg(msg,"S");
						}
						
					} else {
						showMsg(data.errMsg || "添加数据失败!","W");
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					// nui.alert(jqXHR.responseText);
					console.log(jqXHR.responseText);
				}
			});
		}


	}else{
		showMsg("请按格式输入信息!","W");
		return;
	}

	advancedAddWin.hide();
	advancedAddForm.setData([]);
}
function onAdvancedAddCancel(){
	advancedAddWin.hide();
	advancedAddForm.setData([]);
}
function addRtnList(partList){
	if(partList && partList.length>0){		
		var rows = [];
		for (var i = 0; i < partList.length; i++) {
			var part = partList[i];
			var orderQty = parseFloat(part.orderQty);
			var orderPrice = parseFloat(part.orderPrice);
			var newRow = {
				partId : part.partId,
				comPartCode : part.partCode,
				comPartName : part.partName,
				comPartBrandId : part.partBrandId,
				comApplyCarModel : part.applyCarModel,
				comUnit : part.unit,
				orderQty : orderQty,
				orderPrice : orderPrice,
				orderAmt : orderQty * orderPrice,
				storeId : FStoreId,
				comOemCode : part.oemCode,
				comSpec : part.spec,
				partCode : part.partCode,
				partName : part.partName,
				fullName : part.fullName,
				systemUnitId : part.unit,
				enterUnitId : part.unit
			};

			rows.push(newRow);
		}	

		rightGrid.addRows(rows);		
		
	}
}
function addNewKeyRow(){
	var data = basicInfoForm.getData();

    if(data.auditSign == 1){
        e.cancel = true;
    }
    
	var rows = [];
	if(check){
		rows = rightGrid.findRows(function(row) {
			if (row.partId == null || row.partId == "" || row.partId == undefined)
				return true;
		});

	}

	var newRow = {};
	if(rows && rows.length > 0){
		var row = rows[0];

		rightGrid.cancelEdit();	
    	rightGrid.beginEditCell(row, "operateBtn");		

		
	}else{
		var newRow = {comPartCode:""};
	    rightGrid.addRow(newRow);

	    rightGrid.cancelEdit();
	    //rightGrid.beginEditRow(newRow);	
	    rightGrid.beginEditCell(newRow, "operateBtn");
		
	}

}
var unAuditUrl = baseUrl+"com.hsapi.cloud.part.invoicing.crud.unAuditPjPchsOrder.biz.ext";
function unAudit()
{
    var data = basicInfoForm.getData();
    var billStatusId = data.billStatusId;
    var isInner = data.isInner;
    var mainId = data.id;
    if(isInner && isInner == 1){
	    if(billStatusId != 1 && billStatusId != 5){
			showMsg("【待发货】和【已退回】状态下的单才可以返单!","W");
	        return;
	    }
    }else{
    	if(billStatusId != 2){
			showMsg("【待收货】状态下的单才可以返单!","W");
	        return;
	    }
    }


    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '返单中...'
    });

    nui.ajax({
        url : unAuditUrl,
        type : "post",
        data : JSON.stringify({
            mainId : mainId,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
				showMsg("返单成功!","S");
				leftGrid.removeRow(row, true);
				var newRow = {auditSign:0, billStatusId: 0};
				var row = leftGrid.getSelected();
				leftGrid.updateRow(row, newRow);
				var leftRow = leftGrid.getSelected();

				// 保存成功后重新加载数据
				loadMainAndDetailInfo(leftRow);
                
            } else {
				showMsg(data.errMsg || "审核失败!","W");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function importPart(){
    var row = leftGrid.getSelected();
	if(row.auditSign == 1){
		showMsg("此单已审核!","W");
		return;
	}

	var main = basicInfoForm.getData();
	if(!main.id){
		showMsg("请先保存单据!","W");
		return;
	}

    nui.open({
        targetWindow: window,
        url: webPath + contextPath + "/com.hsweb.cloud.part.purchase.getPartInfoImoprt.flow?token="+token,
        title: "配件导入", 
        width: 930, 
        height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.initData(function(data,msg){
				if(data && data.length > 0){
					addImportRtnList(data,msg);
				}
			});
        },
        ondestroy: function (action)
        {
            var mainId = data.id;
            loadRightGridData(mainId);
        }
    });
}
function addImportRtnList(partList,msg){
	if(partList && partList.length>0){		
		var rows = [];
		for (var i = 0; i < partList.length; i++) {
			var part = partList[i];
			var orderQty = parseFloat(part.orderQty);
			var orderPrice = parseFloat(part.orderPrice);
			var newRow = {
				partId : part.partId,
				comPartCode : part.partCode,
				comPartName : part.partName,
				comPartBrandId : part.partBrandId,
				comApplyCarModel : part.applyCarModel,
				comUnit : part.unit,
				orderQty : orderQty,
				orderPrice : orderPrice,
				orderAmt : orderQty * orderPrice,
				storeId : FStoreId,
				comOemCode : part.oemCode,
				comSpec : part.spec,
				partCode : part.partCode,
				partName : part.partName,
				fullName : part.fullName,
				systemUnitId : part.unit,
				enterUnitId : part.unit,
				storeShelf: part.shelf,
				remark: part.remark
			};

			rows.push(newRow);
		}	

		rightGrid.addRows(rows);		
		
	}
	if(msg){
		nui.get("imprtPastCodeList").setValue("");
		nui.get("imprtPastCodeList").setValue(msg);
		advancedTipWin.show();
	}
}
function onExport(){
	if (checkNew() > 0) {
		showMsg("请先保存数据！!","W");
		return;
	}
	var changes = rightGrid.getChanges();
	if(changes.length>0){
        var len = changes.length;
        var row = changes[0];
        if(len == 1 && !row.partId){
        }else{
		  showMsg("请先保存数据！!","W");
          return;  
        }
	}

	var main = leftGrid.getSelected();
	if(!main) return;

	var detail = rightGrid.getData();
	if(detail && detail.length > 0){
		setInitExportData(main, detail);
	}
}
function setInitExportData(main, detail){
	document.getElementById("eServiceId").innerHTML = main.serviceId?main.serviceId:"";
	document.getElementById("eGuestName").innerHTML = main.guestFullName?main.guestFullName:"";
	document.getElementById("eRemark").innerHTML = main.remark?main.remark:"";
    var tds = '<td  colspan="1" align="left">[comPartCode]</td>' +
        "<td  colspan='1' align='left'>[comFullName]</td>" +
        "<td  colspan='1' align='left'>[comApplyCarModel]</td>" +
        "<td  colspan='1' align='left'>[comUnit]</td>" +
        "<td  colspan='1' align='left'>[orderQty]</td>" +
        "<td  colspan='1' align='left'>[orderPrice]</td>" +
        "<td  colspan='1' align='left'>[orderAmt]</td>" +
        "<td  colspan='1' align='left'>[remark]</td>";
    var tableExportContent = $("#tableExportContent");
    tableExportContent.empty();
    for (var i = 0; i < detail.length; i++) {
        var row = detail[i];
        if(row.partId){
            var tr = $("<tr></tr>");
            tr.append(tds.replace("[comPartCode]", detail[i].comPartCode?detail[i].comPartCode:"")
                         .replace("[comFullName]", detail[i].comFullName?detail[i].comFullName:"")
                         .replace("[comApplyCarModel]", detail[i].comApplyCarModel?detail[i].comApplyCarModel:"")
                         .replace("[comUnit]", detail[i].comUnit?detail[i].comUnit:"")
                         .replace("[orderQty]", detail[i].orderQty?detail[i].orderQty:"")
                         .replace("[orderPrice]", detail[i].orderPrice?detail[i].orderPrice:"")
                         .replace("[orderAmt]", detail[i].orderAmt?detail[i].orderAmt:"")
                         .replace("[remark]", detail[i].remark?detail[i].remark:""));
            tableExportContent.append(tr);
        }
    }

    var serviceId = main.serviceId?main.serviceId:"";
    method5('tableExcel',"采购订单"+serviceId,'tableExportA');
}
