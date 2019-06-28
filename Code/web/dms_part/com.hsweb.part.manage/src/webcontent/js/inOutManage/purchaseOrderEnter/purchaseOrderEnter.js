/**
 * Created by Administrator on 2018/2/23.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var leftGridUrl = baseUrl
		+ "com.hsapi.part.invoice.svr.queryPjPchsOrderMainList.biz.ext";
var rightGridUrl = baseUrl
		+ "com.hsapi.part.invoice.svr.queryPjPchsOrderDetailList.biz.ext";
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
var fastPartEntryEl = null;
var dataList = null;
var morePartGrid = null;
var FStoreId = null;
var isNeedSet = false;
var oldValue = null;
var oldRow = null;
var partShow = 0;
var qucikAddShow=0;
var autoNew = 0;
var memList=[];
var storeShelfList=[];

// 单据状态
var AuditSignList = [ {
	customid : '0',
	name : '草稿'
}, {
	customid : '1',
	name : '已入库'
}];
var AuditSignHash = {
	"0" : "草稿",
	"1" : "已入库"
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

	sCreateDate = nui.get("sCreateDate");
	eCreateDate = nui.get("eCreateDate");
	
	initMember("orderMan",function(){
		memList = nui.get('orderMan').getData();
  });
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
//                      e.cellHtml = brandHash[e.value].name||"";
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
            if(quickAddShow ==1){
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
				nui.get('storehouse').setData(storehouse);
				nui.get("storeIdE").setData(storehouse);
		        if(currRepairStoreControlFlag == "1") {
		        	nui.get("storeIdE").setValue(FStoreId);
		        }else {
		        	nui.get("storeIdE").setAllowInput(true);
		        }
		        
			}else{
				isNeedSet = true;
			}
			
			
	
			getAllPartBrand(function(data) {
				brandList = data.brand;
				brandList.forEach(function(v) {
					brandHash[v.id] = v;
				});
		
				gsparams.isFinished = 0;
				gsparams.auditSign = 0;
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
	"3" : "部分入库",
	"4" : "全部入库",
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
//返回类型给srvBottom，用于srvBottom初始化
function confirmType(){
	return "pchs";
}
function getParentStoreId(){
	return FStoreId;
}
function loadMainAndDetailInfo(row) {
	if (row) {
//		var orderMan=row.orderMan;
//		
//		row.orderMan=row.orderManId; 
		basicInfoForm.setData(row);
		//bottomInfoForm.setData(row);
		nui.get("orderMan").setValue(row.orderManId);
		nui.get('orderMan').setText(row.orderMan);
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
    if(row.serviceId == '新采购入库'){

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
	
		var data = rightGrid.getData();
		if(data && data.length <= 0){
			addNewRow(false);
		}	

		if(autoNew == 0){
			add();
			autoNew = 1;
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
	var querytypename = "草稿";
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
		querytypename = "草稿";
		querysign = 2;
		//gsparams.auditSign = 0;
		break;
	case 7:
		params.auditSign = 1;
		querytypename = "已入库";
		querysign = 2;
		//gsparams.auditSign = 1;
		break;
	case 10:
		querystatusname = "草稿";
		gsparams.auditSign = 0;
		gsparams.isFinished = 0;
		querysign = 3;
		break;
	case 14:
		querystatusname = "已入库";
		gsparams.isFinished = 1;
		gsparams.auditSign = 1;
		querysign = 3;
		break;
	default:
		params.today = 1;
		params.startDate = getNowStartDate();
		params.endDate = addDate(getNowEndDate(), 1);
		querytypename = "草稿";
		gsparams.startDate = getNowStartDate();
		gsparams.endDate = addDate(getNowEndDate(), 1);
		gsparams.auditSign = 0;
		gsparams.isFinished = 0;
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
		nui.get('guestId').enabled=true;
		nui.get('orderMan').enabled=true;
		nui.get('settleTypeId').enabled=true;

	} else {
		document.getElementById("fd1").disabled = true;
		nui.get('guestId').enabled=false;
		nui.get('orderMan').enabled=false;
		nui.get('settleTypeId').enabled=false;
	}
}
function doSearch(params) {
	params.orderTypeId = 1;
	params.isDiffOrder = 1;
	params.storeId = nui.get("storeIdE").value;
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

			if(autoNew == 0){
				add();
				autoNew = 1;
			}

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
		sCreateDate.setValue(getWeekStartDate());
		eCreateDate.setValue(addDate(getWeekEndDate(), 1));
	}
}
function onAdvancedSearchOk() {
	var searchData = advancedSearchForm.getData();
	var i;
	// 订货日期
	if (searchData.sOrderDate) {
		searchData.sOrderDate = searchData.sOrderDate;
	}
	if (searchData.eOrderDate) {
		var date = searchData.eOrderDate;
		searchData.eOrderDate = addDate(date, 1);
	}
	// 创建日期
	if (searchData.sCreateDate) {
		searchData.sCreateDate = formatDate(searchData.sCreateDate);
	}
	if (searchData.eCreateDate) {
		var date = searchData.eCreateDate;
		searchData.eCreateDate = addDate(date, 1);
	}
	// 审核日期
	if (searchData.sAuditDate) {
		searchData.sAuditDate = formatDate(searchData.sAuditDate);
	}
	if (searchData.eAuditDate) {
		var date = searchData.eAuditDate;
		searchData.eAuditDate = addDate(date, 1);
	}
	// 供应商
	if (searchData.guestId) {
//		searchData.guestId = nui.get("advanceGuestId").getValue();
		if(typeof searchData.guestId !== 'number'){
        	searchData.guestName= searchData.guestId;
        	searchData.guestId=null;
        }
        else{
        	searchData.guestId = nui.get("advanceGuestId").getValue();
        }
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
	advancedSearchFormData = advancedSearchForm.getData();
	advancedSearchWin.hide();
	searchData.auditSign = gsparams.auditSign || 0;
	doSearch(searchData);
}
function onAdvancedSearchCancel() {
	// advancedSearchForm.clear();
	advancedSearchWin.hide();
}
function checkNew() {
	var rows = leftGrid.findRows(function(row) {
		if (row.serviceId == "新采购入库")
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
	
	if (checkNew() > 0) {
		showMsg("请先保存数据!","W");
		return;
	}

	var formJsonThis = nui.encode(basicInfoForm.getData());
	var len = rightGrid.getData().length;
	var orderMan=nui.get('orderMan').getText();
	var orderManId=nui.get('orderMan').getValue();

	if (formJson != formJsonThis && len > 0) {// 
		nui.confirm("您正在编辑数据,是否要继续?", "友情提示", function(action) {
			if (action == "ok") {

				setBtnable(true);
				setEditable(true);
				
				basicInfoForm.reset();
				rightGrid.clearRows();


				var newRow = {
					serviceId : '新采购入库',
					auditSign : 0,
					createDate: new Date()
				};
				leftGrid.addRow(newRow, 0);
				leftGrid.clearSelect(false);
				leftGrid.select(newRow, false);

				nui.get("serviceId").setValue("新采购入库");
				nui.get("billTypeId").setValue("010103"); // 010101 收据 010102 普票 010103 增票
				nui.get("createDate").setValue(new Date());
//				nui.get("orderMan").setValue(orderMan);
				nui.get("sourceType").setValue(0);
				
				if(!orderMan || orderMan==""){
					for(var i=0;i<memList.length;i++){
						if(currEmpId==memList[i].empId){
							nui.get("orderMan").setValue(currEmpId);
							nui.get("orderMan").setText(currUserName);
						}
					}
				
				}else{
					nui.get("orderMan").setValue(orderManId);
					nui.get("orderMan").setText(orderMan);
				}
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
			serviceId : '新采购入库',
			auditSign : 0,
			createDate: new Date()
		};
		leftGrid.addRow(newRow, 0);
		leftGrid.clearSelect(false);
		leftGrid.select(newRow, false);

		nui.get("serviceId").setValue("新采购入库");
		nui.get("billTypeId").setValue("010103"); // 010101 收据 010102 普票 010103 增票
		nui.get("createDate").setValue(new Date());
		
		if(!orderMan || orderMan==""){
			for(var i=0;i<memList.length;i++){
				if(currEmpId==memList[i].empId){
					nui.get("orderMan").setValue(currEmpId);
					nui.get("orderMan").setText(currUserName);
				}
			}
		
		}else{
			nui.get("orderMan").setValue(orderManId);
			nui.get("orderMan").setText(orderMan);
		}
		
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
	data.isDiffOrder = 1;
	delete data.createDate;
	data.orderManId=nui.get('orderMan').getValue();
	data.orderMan=nui.get('orderMan').getText();

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
		+ "com.hsapi.part.invoice.crud.savePjPchsOrder.biz.ext";
function save() {
	var data = basicInfoForm.getData();
	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
			showMsg(requiredField[key] + "不能为空!","W");

			return;
		}
	}
	
	var row = leftGrid.getSelected();
	if (row) {
		if (row.auditSign == 1) {
			showMsg("此单已入库!","W");
			return;
		}
	} else {
		return;
	}

	data = getMainData();

	//由于票据类型可能修改，所以除了新建和删除，其他都应该是修改
	var detailData = rightGrid.getData();
	
	for(var i=0;i<detailData.length;i++){
		var comPartCode=detailData[i].comPartCode;
		if(!detailData[i].orderQty || detailData[i].orderQty==="0" || detailData[i].orderQty==null){
			showMsg("配件编码为"+comPartCode+"的数量不能为0","W");
			return ;
		}
		if(!detailData[i].storeId){
			showMsg("配件编码为"+comPartCode+"的仓库不能为空","W");
			return ;
		}
	}
	
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
//		// targetWindow: window,,
		url : webPath+contextPath+"/com.hsweb.part.common.guestSelect.flow?token="+token,
		title : "供应商资料",
		width : 980,
		height : 560,
		allowDrag : true,
		allowResize : true,
		onload : function() {
			var iframe = this.getIFrameEl();
			var params = {
                isSupplier: 1,
                guestType:'01020202'
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
			if(!record.comPartCode){
				showMsg("请输入编码!","W");
				var row = rightGrid.getSelected();
				rightGrid.removeRow(row);
				addNewRow(false);
				return;
			}else{
				var rs = addInsertRow(record.comPartCode,record);
				if(!rs){
					var newRow = {comPartCode: ""};
					rightGrid.updateRow(record, newRow);
					rightGrid.beginEditCell(record, "comPartCode");
					return;
				}else{
					rightGrid.beginEditCell(record, "comUnit");
				}
			}
		}else if(column.field == "comPartName"){
			if(!record.comPartName){
				showMsg("请输入配件名称!","W");
				var row = rightGrid.getSelected();
				rightGrid.removeRow(row);
				addNewRow(false);
				return;
			}else{
				var rs = addInsertRowPartName(record.comPartName,record);
				if(!rs){
					var newRow = {comPartName: ""};
					rightGrid.updateRow(record, newRow);
					rightGrid.beginEditCell(record, "comPartName");
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
			if(currCompType == "GEARBOX"){
				var row = e.row;
				var orderPrice = e.value || "";
				var sellPrice = 0;
				var newRow = {};
				if(orderPrice){
					sellPrice = orderPrice *1.35;
				}
				newRow.sellPrice = sellPrice;
				rightGrid.updateRow(row,newRow);
		}
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
var partInfoUrl = baseUrl + "com.hsapi.part.invoice.paramcrud.queryBillPartChoose.biz.ext";
		//+ "com.hsapi.part.invoice.paramcrud.queryPartInfoByParam.biz.ext";
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
			page:page,
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
					event.keyCode = null;
				}
				
			}else{
				//清空行数据
				showMsg("没有搜索到配件信息!","W");
				var row = rightGrid.getSelected();
//				rightGrid.removeRow(row);
//				addNewRow(false);
				nui.confirm("是否添加配件?", "友情提示", function(action) {
					if (action == "ok") {
						addOrEditPart(row);
					}else{
						return;
					}
					});
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
//		// targetWindow: window,,
		url : webPath+contextPath+"/com.hsweb.part.common.partSelectView.flow?token="+token,
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

			return;
		}
	}

	var row = leftGrid.getSelected();
	if (row) {
		if (row.auditSign == 1) {
			showMsg("此单已入库!","W");
			return;
		}
	} else {
		return;
	}
	
	nui.open({
//				// targetWindow: window,,
				url : webPath+contextPath+"/com.hsweb.part.manage.detailQPAPopOperate.flow?token="+token,
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
						var sellPrice = 0;
						if(currCompType == "GEARBOX"){
							if(data.price){
								sellPrice = data.price *1.35;
								enterDetail.sellPrice = sellPrice;
							}
						}
						rightGrid.addRow(enterDetail);
					}
				}
			});
}
var partPriceUrl = baseUrl
		+ "com.hsapi.part.invoice.pricemanage.getPchsDefaultPrice.biz.ext";
function getPartPrice(params){
	var price = 0;
	var shelf = null;
	var sellPrice = null;
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
				if(priceRecord.sellPrice){
					sellPrice = priceRecord.sellPrice;
				}
			}

		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});

	var dInfo = {price: price, shelf: shelf, sellPrice: sellPrice};

	return dInfo;
}

function addInsertRowPartName(value,row){
	var data = basicInfoForm.getData();
	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
			showMsg(requiredField[key] + "不能为空!","W");
			//如果检测到有必填字段未填写，切换到主表界面
//			mainTabs.activeTab(billmainTab);

			return;
		}
	}
    var params = {partName:value};
	var part = getPartInfo(params);
	var storeId = FStoreId;

	if(part){
		params.partId = part.id;
		params.storeId = storeId;
		var dInfo = getPartPrice(params);
		var price = dInfo.price;
		var shelf = dInfo.shelf;
		var sellPrice = dInfo.sellPrice;
		
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
			enterUnitId : part.unit,
			sellPrice : sellPrice
		};
		if(currCompType == "GEARBOX"){
			if(price){
				sellPrice = price*1.35;
				newRow.sellPrice = sellPrice;
			}
		}
		if(row){
			rightGrid.updateRow(row,newRow);
		}else{
			rightGrid.addRow(newRow);
		}
	
		return true;
	}else{
		var newRow = {};
		if(row){
			rightGrid.updateRow(row,newRow);
			rightGrid.beginEditCell(row, "comPartName");
		}
		return true;
	}

	return false;
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

	var data = basicInfoForm.getData();
	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
			showMsg(requiredField[key] + "不能为空!","W");
			//如果检测到有必填字段未填写，切换到主表界面
//			mainTabs.activeTab(billmainTab);

			return;
		}
	}
    var params = {partCode:value};
	var part = getPartInfo(params);
	var storeId = FStoreId;
	var sellPrice = 0;
	if(part){
		params.partId = part.id;
		params.storeId = storeId;
		var dInfo = getPartPrice(params);
		var price = dInfo.price;
		var shelf = dInfo.shelf;
		var sellPrice = dInfo.sellPrice;
					
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
			enterUnitId : part.unit,
			sellPrice: sellPrice
		};
		if(currCompType == "GEARBOX"){
			if(price){
				sellPrice = price*1.35;
				newRow.sellPrice = sellPrice;
			}
		}
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
	var data = basicInfoForm.getData();
	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
			showMsg(requiredField[key] + "不能为空!","W");

			return;
		}
	}
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
		return "配件编码：" + row.comPartCode + "在采购入库列表中已经存在，是否继续？";
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
//	 if (rows && rows.length > 0) {
//	 	msg = "请完善采购配件的数量，单价，金额，仓库等信息！";
//	 }
	return p;
}
function audit(){
	var data = basicInfoForm.getData();
	var flagSign = 1; 
	var flagStr = "入库中...";
	var flagRtn = "入库成功!";
	auditOrder(flagSign, flagStr, flagRtn);
}
function auditToEnter(){
	

}
var auditUrl = baseUrl
		+ "com.hsapi.part.invoice.crud.auditPjPchsOrder.biz.ext";
function auditOrder(flagSign, flagStr, flagRtn) {
	var data = basicInfoForm.getData();
	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
			showMsg(requiredField[key] + "不能为空!","W");

			return;
		}
	}

	var row = leftGrid.getSelected();
	if (row) {
		if (row.auditSign == 1) {
			showMsg("此单已入库!","W");
			return;
		}
	} else {
		return;
	}
	
	// 审核时，数量，单价，金额，仓库不能为空
//	 var msg = checkRightData();
//	 if (msg) {
//	 	showMsg(msg,"W");
//	 	return;
//	 }
	var p = checkRightData();
	if (p && p.qtyPartCode) {
		var partCode = p.qtyPartCode;
		showMsg("配件编码:"+partCode+"数量为0","W");
		return;
	}

	if (p && p.pricePartCode) {
		var partCode = p.pricePartCode;
		nui.confirm("存在单价为0信息，是否继续?", "友情提示", function(action) {
			if (action == "ok") {
	
				data = getMainData();
	
				//由于票据类型可能修改，所以除了新建和删除，其他都应该是修改
				var detailData = rightGrid.getData();
				
				 if(detailData.length <=0) {
				        showMsg("入库单明细为空，不能入库!","W");
				        rightGrid.addRow({});
				        return;
				    }
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
						operateFlag : 1,
						token: token
					}),
					success : function(data) {
						nui.unmask(document.body);
						data = data || {};
						if (data.errCode == "S") {
							showMsg("入库成功!","S");
							// onLeftGridRowDblClick({});
							var pjPchsOrderMainList = data.pjPchsOrderMainList;
							if (pjPchsOrderMainList && pjPchsOrderMainList.length > 0) {
								var leftRow = pjPchsOrderMainList[0];
								var row = leftGrid.getSelected();
								leftGrid.updateRow(row, leftRow);
								loadMainAndDetailInfo(leftRow);
								nui.confirm("是否打印？", "友情提示", function(action) {
									if(action== 'ok'){
										onPrint();
									}else{
										
									}
									
								});
								// 保存成功后重新加载数据
//								loadMainAndDetailInfo(leftRow);
//								rightGrid.setData([]);
//								add();
	
							}
						} else {
							showMsg(data.errMsg || ("入库失败!"),"W");
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
		nui.confirm("是否确定入库?", "友情提示", function(action) {
			if (action == "ok") {
	
				data = getMainData();
				
				
				//由于票据类型可能修改，所以除了新建和删除，其他都应该是修改
				var detailData = rightGrid.getData();
				
				 if(detailData.length <=0) {
				        showMsg("入库单明细为空，不能入库!","W");
				        rightGrid.addRow({});
				        return;
				    }
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
						operateFlag : 1,
						token: token
					}),
					success : function(data) {
						nui.unmask(document.body);
						data = data || {};
						if (data.errCode == "S") {
							showMsg("入库成功!","S");
							// onLeftGridRowDblClick({});
							var pjPchsOrderMainList = data.pjPchsOrderMainList;
							if (pjPchsOrderMainList && pjPchsOrderMainList.length > 0) {
								var leftRow = pjPchsOrderMainList[0];
								var row = leftGrid.getSelected();
								leftGrid.updateRow(row, leftRow);
								loadMainAndDetailInfo(leftRow);
								nui.confirm("是否打印？", "友情提示", function(action) {
									if(action== 'ok'){
										onPrint();
									}else{
										
									}
									
								});
								// 保存成功后重新加载数据
//								loadMainAndDetailInfo(leftRow);
//								rightGrid.setData([]);
//								add();
	
							}
						} else {
							showMsg(data.errMsg || ("入库失败!"),"W");
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
		+ "com.hsapi.part.baseDataCrud.crud.querySupplierList.biz.ext";
function setGuestInfo(params) {
	nui.ajax({
		url : getGuestInfo,
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
				// targetWindow: window,
				url: webPath+contextPath+"/com.hsweb.part.baseData.supplierDetail.flow?token=" + token,
				title: "供应商资料", width: 580, height: 500,
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

function onPrint(){
	var from = basicInfoForm.getData();
	var mainParams={
		id : from.id,
		auditSign:from.auditSign,
		guestId :from.guestId,
		currUserName :currUserName,
		currRepairSettorderPrintShow :currRepairSettorderPrintShow,
		currCompAddress :currCompAddress,
		currCompLogoPath : currCompLogoPath,
		currCompTel :currCompTel,
		currOrgName : currOrgName
	};
	var detailParams={
			mainId :from.id
	};
	var openUrl = webPath + contextPath+"/manage/inOutManage/purchaseOrderEnter/purchaseOrderEnterPrint.jsp";

    nui.open({
       url: openUrl,
       width: "100%",
       height: "100%",
       showMaxButton: false,
       allowResize: false,
       showHeader: true,
       onload: function() {
           var iframe = this.getIFrameEl();
           iframe.contentWindow.SetData(mainParams,detailParams);
       },
   });
}
//function onPrint() {
//	
//	
//	var main = leftGrid.getSelected();
//	var from = basicInfoForm.getData();
//	if(!main){
//		showMsg("请选择一条记录");
//	}
//	var detail=rightGrid.getData();
//	var mainParams=main;
//	var billTypeId=nui.get('billTypeId').text;
//	var settleTypeId=nui.get('settleTypeId').text;
//	var guestId = from.guestId;
//	var formParms={
//			billTypeId :billTypeId,
//			settleTypeId:settleTypeId,
//			guestId	: guestId
//	};
//	var detailParms=detail;
//
//	for(var i=0;i<detailParms.length;i++){
//		for(var j=0;j<storehouse.length;j++){
//			if(detailParms[i].storeId==storehouse[j].id){
//				detailParms[i].storehouse=storehouse[j].name;
//			}
//		}
//	}
//	
//	for(var i=0;i<detailParms.length;i++){	
//		var comPartBrindId=detailParms[i].comPartBrandId;
//		detailParms[i].comPartBrindId=brandHash[comPartBrindId].name;
//	}
//	
//	var openUrl = webPath + contextPath+"/manage/inOutManage/purchaseOrderEnter/purchaseOrderEnterPrint.jsp";
//
//     nui.open({
//        url: openUrl,
//        width: "100%",
//        height: "100%",
//        title : "入库单打印",
//        showMaxButton: false,
//        allowResize: false,
//        showHeader: true,
//        onload: function() {
//            var iframe = this.getIFrameEl();
//            iframe.contentWindow.SetData(mainParams,detailParms,formParms);
//        },
//    });
//
//}
function addSelectPart(){
	var row = morePartGrid.getSelected();
	if(row){
		var params = {partCode:row.code};
		params.partId = row.id;
		params.storeId = FStoreId;
		var dInfo = getPartPrice(params);
		var price = dInfo.price;
		var shelf = dInfo.shelf;
		var sellPrice = dInfo.sellPrice;
		if(currCompType == "GEARBOX"){
			if(price){
				sellPrice = price*1.35;
			}
		}
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
			storeShelf : shelf,
			sellPrice : sellPrice,
			comOemCode : row.oemCode,
			comSpec : row.spec,
			partCode : row.code,
			partName : row.name,
			fullName : row.fullName,
			systemUnitId : row.unit,
			enterUnitId : row.unit,
			sellPrice: sellPrice
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
		//var row = morePartGrid.getRow(0);   默认不能选中，回车事件会有影响
        //if(row){
        //    morePartGrid.select(row,true);
        //}
	}
	if (field == "storeShelf") {
        var value = e.record.storeId;
        getLocationListByStoreId(value,function(data) {
			storeShelfList = data.locationList || [];
			nui.get('storeShelf').setData(storeShelfList);

		});
    }else if(field == "storeId") {
    	
    }
}
function addMorePart(){
	var row = leftGrid.getSelected();
	if(row.auditSign == 1){
		showMsg("此单已入库!","W");
		return;
	}

	var main = basicInfoForm.getData();
	if(!main.id){
		showMsg("请先保存数据!","W");
		return;
	}
	var data = rightGrid.getChanges()||[];
	if (data.length>0) {
		showMsg("请先保存数据!","W");
		return;
	}
	advancedAddForm.setData([]);
	advancedAddWin.show();
	quickAddShow=1;
	partShow = 1;

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
				url : baseUrl + "com.hsapi.part.invoice.paramcrud.getPartInfoByCodes.biz.ext",
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
	partShow = 0;
}
function onAdvancedAddCancel(){
	advancedAddWin.hide();
	advancedAddForm.setData([]);
	partShow = 0;
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
function onExport(){
	if (checkNew() > 0) {
		showMsg("请先保存数据!","W");
		return;
	}
	var changes = rightGrid.getChanges();
	if(changes.length>0){
        var len = changes.length;
        var row = changes[0];
        if(len == 1 && !row.partId){
        }else{
		  showMsg("请先保存数据!","W");
            return;  
        }
	}

	var main = leftGrid.getSelected();
	if(!main) return;

	var detail = rightGrid.getData();
	for(var i=0;i<detail.length;i++){
		for(var j=0;j<storehouse.length;j++){
			if(detail[i].storeId==storehouse[j].id){
				detail[i].storeId=storehouse[j].name;
			}
		}
	}
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
        "<td  colspan='1' align='left'>[remark]</td>" +
        "<td  colspan='1' align='left'>[storeId]</td>"+
        "<td  colspan='1' align='left'>[storeShelf]</td>"+
        "<td  colspan='1' align='left'>[comOemCode]</td>"+
        "<td  colspan='1' align='left'>[comSpec]</td>";
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
                         .replace("[remark]", detail[i].remark?detail[i].remark:"")
                         .replace("[storeId]", detail[i].storeId?detail[i].storeId:"")
                         .replace("[storeShelf]", detail[i].storeShelf?detail[i].storeShelf:"")
                         .replace("[comOemCode]", detail[i].comOemCode?detail[i].comOemCode:"")
                         .replace("[comSpec]", detail[i].comSpec?detail[i].comSpec:""));
            tableExportContent.append(tr);
        }
    }

    var serviceId = main.serviceId?main.serviceId:"";
    method5('tableExcel',"采购入库"+serviceId,'tableExportA');
}
function addPchsOrder(type)
{

    setBtnable(true);
	setEditable(true);

	basicInfoForm.reset();
	rightGrid.clearRows();
	var title="单据选择";
	if(type == 'order'){
		title="采购订单选择";
	}else if(type == 'sell'){
		title="销售单选择";
	}

	nui.open({
		// targetWindow: window,
		url: webPath+contextPath+"/com.hsweb.part.manage.pchsOrderSelect.flow?token="+token,
		title: title, width: 1000, height: 560,
		allowDrag:true,
		allowResize:true,
		onload: function ()
		{
			var iframe = this.getIFrameEl();
			var data = {
				guestId: nui.get("guestId").getValue(),
				guestName: nui.get("guestId").getText(),
				type:type
			};
			iframe.contentWindow.setInitData(data);
		},
		ondestroy: function (action)
		{
			if(action == 'ok')
			{
				var iframe = this.getIFrameEl();
				var data = iframe.contentWindow.getData();
				
				if(data.orderMainId) {
					var orderMainId = data.orderMainId;
					addOrderToEnter(data);
				}
			}
		}
	});

}

function addOrderToEnter(data){

    setBtnable(true);
	setEditable(true);

	basicInfoForm.reset();
	rightGrid.clearRows();
	
	var newRow = { serviceId: '新采购入库', auditSign: 0};
	leftGrid.addRow(newRow, 0);
	leftGrid.clearSelect(false);
	leftGrid.select(newRow, false);
	
	nui.get("serviceId").setValue("新采购入库");
	nui.get("codeId").setValue(data.orderMainId);
	nui.get("code").setValue(data.orderServiceId);
	nui.get("billTypeId").setValue(data.billTypeId);  //010101  收据   010102  普票  010103  增票
	nui.get("settleTypeId").setValue(data.settleTypeId);
	nui.get("taxRate").setValue(data.taxRate);
	nui.get("taxSign").setValue(data.taxSign);
	nui.get("createDate").setValue(new Date());
	nui.get("orderMan").setValue(data.orderMan);
	
	var guestId = nui.get("guestId");
	guestId.setValue(data.guestId);
	guestId.setText(data.fullName);

	var params = {mainId: data.orderMainId};
	if(data && data.type == 'pchs'){
		nui.get("sourceType").setValue(1);
		getOrderDetail(params);
	}else{
		nui.get("sourceType").setValue(2);
		getSellDetail(params);
	}
	guestId.focus();


}
var orderDetailUrl = baseUrl+"com.hsapi.part.invoice.paramcrud.queryPjPchsOrderDetailChkList.biz.ext";
function getOrderDetail(params)
{
    //params.notFinished = 0;
    nui.ajax({
        url:orderDetailUrl,
        data: {params: params, token: token},
        type:"post",
        success:function(text)
        {
            if(text)
            {
                var pjPchsOrderDetailList = text.pjPchsOrderDetailList;
                if(pjPchsOrderDetailList && pjPchsOrderDetailList.length>0) {
                    for(var i = 0; i<pjPchsOrderDetailList.length; i++){
						var row = pjPchsOrderDetailList[i];
						
						var enterDetail = {
							partId : row.partId,
							comPartCode : row.comPartCode,
							comPartName : row.comPartName,
							comPartBrandId : row.comPartBrandId,
							comApplyCarModel : row.comApplyCarModel,
							comUnit : row.comUnit,
							orderQty : row.orderQty,
							orderPrice : row.orderPrice,
							orderAmt : parseFloat(row.orderQty) * parseFloat(row.orderPrice),
							remark	: row.remark,
							storeId : row.storeId,
							storeShelf : row.shelf,
							comOemCode : row.comOemCode,
							comSpec : row.comSpec,
							partCode : row.partCode,
							partName : row.partName,
							fullName : row.fullName,
							systemUnitId : row.systemUnitId,
							enterUnitId : row.enterUnitId,
							taxSign : row.taxSign,
							taxRate : row.taxRate,
							noTaxAmt : parseFloat(row.orderQty) * parseFloat(row.noTaxPrice),
							noTaxPrice : row.noTaxPrice,
							taxAmt : parseFloat(row.orderQty) * parseFloat(row.taxPrice),
							taxPrice : row.taxPrice
						};
                   
                        rightGrid.addRow(enterDetail);
                    }
                }
            }

        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
var sellDetailUrl = baseUrl+"com.hsapi.part.invoice.paramcrud.queryPjSellOrderDetailChkList.biz.ext";
function getSellDetail(params)
{
    //params.notFinished = 0;
    nui.ajax({
        url:sellDetailUrl,
        data: {params: params, token: token},
        type:"post",
        success:function(text)
        {
            if(text)
            {
                var pjSellOrderDetailList = text.pjSellOrderDetailList;
                if(pjSellOrderDetailList && pjSellOrderDetailList.length>0) {
                    for(var i = 0; i<pjSellOrderDetailList.length; i++){
						var row = pjSellOrderDetailList[i];
						
						var enterDetail = {
							partId : row.partId,
							comPartCode : row.comPartCode,
							comPartName : row.comPartName,
							comPartBrandId : row.comPartBrandId,
							comApplyCarModel : row.comApplyCarModel,
							comUnit : row.comUnit,
							orderQty : row.orderQty,
							orderPrice : row.orderPrice,
							orderAmt : parseFloat(row.orderQty) * parseFloat(row.orderPrice),
							remark  :row.remark,
							storeId : FStoreId,
							comOemCode : row.comOemCode,
							comSpec : row.comSpec,
							partCode : row.partCode,
							partName : row.partName,
							fullName : row.fullName,
							systemUnitId : row.systemUnitId,
							enterUnitId : row.outUnitId,
							taxSign : row.taxSign,
							taxRate : row.taxRate,
							noTaxAmt : parseFloat(row.orderQty) * parseFloat(row.noTaxPrice),
							noTaxPrice : row.noTaxPrice,
							taxAmt : parseFloat(row.orderQty) * parseFloat(row.taxPrice),
							taxPrice : row.taxPrice
						};
                   
                        rightGrid.addRow(enterDetail);
                    }
                }
            }

        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}

function addOrEditPart(row)
{
    nui.open({
        // targetWindow: window,
        url: webPath + contextPath + "/com.hsweb.part.baseData.partDetail.flow?token=" + token,
        title: "配件资料",
        width: 470, height: 320,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var params={};
//            params.qualityTypeIdList=null;
//            params.partBrandIdList=null;
//            params.unitList=null;
//            params.abcTypeList=null;
//            params.applyCarModelList=null;
            if(row)
            {
                params.comPartCode= row.comPartCode;
            }
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action)
        {
          	var iframe = this.getIFrameEl();
        	var data = iframe.contentWindow.getData();
        	console.log(data);
        	var enterDetail={
        		comPartCode : data.code
        	};
            if(action == "ok")
            {	
            	addInsertRow(enterDetail.comPartCode,row);
            }
        }
    });

}

function onStoreChange(e){
	var value = e.value;
	getLocationListByStoreId(value,function(data) {
		storeShelfList = data.locationList || [];
		nui.get('storeShelf').setData(storeShelfList);

	});
}

function setInitData(params){
	if(params.id){
//		basicInfoForm.setData(params);
//		nui.get('orderMan').setText(params.orderMan);
//		nui.get('orderMan').setValue(params.orderManId);
//		$('#bServiceId').text("订单号："+params.serviceId);
//		nui.get("guestId").setText(params.guestFullName);
//		nui.get('storehouse').setValue(params.storeId);
		
//		if(StatusHash)
//	       {
//				var text=StatusHash[params.billStatusId];
//				nui.get('AbillStatusId').setValue(text);
//	       }
//		
//		var mainId=params.id;
//		var auditSign=params.auditSign;
		if(params.id){	
			var data={};
			data.id=params.id;
			data.auditSign=params.auditSign;
			autoNew=1;
			doSearch(data);
			
		}
		if(params.billStatusId == 0){
			
			document.getElementById("fd1").disabled = false;
			nui.get("guestId").enable();
		}
		if(params.billStatusId != 0){
			
			document.getElementById("fd1").disabled = true;
			nui.get("guestId").disable();
		}
	}else{
		formJson = nui.encode(basicInfoForm.getData());
		add();	
	}
}


//查看入库记录
function onEnter(){
	var row ={};
	row = rightGrid.getSelected();
	if(!row){
		showMsg("请选择一条记录","W");
		return;
	}
	var partId = row.partId;
	onEnterRecord(partId);
	
}

//查看出库记录
function onOut(){
	var row ={};
	row = rightGrid.getSelected();
	if(!row){
		showMsg("请选择一条记录","W");
		return;
	}
	var partId = row.partId;
	onOutRecord(partId);
}


