/**
 * Created by Administrator on 2018/2/23.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var leftGridUrl = baseUrl
		+ "com.hsapi.cloud.part.invoicing.svr.queryPjPchsOrderMainList.biz.ext";
var rightGridUrl = baseUrl
		+ "com.hsapi.cloud.part.invoicing.svr.queryPjPchsOrderDetailList.biz.ext";
//替换件
var partCommonUrl = cloudPartApiUrl + "com.hsapi.cloud.part.invoicing.query.queryQuickPartCommonWithStock.biz.ext";
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
var storeHash={};
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
var autoNew = 0;
var guestIdEl=null;
var partIn=null;
var quickAddShow=0;
var advancedSearchShow=0;
var priceList=[];
var partPriceList=[];
var partPriceHash = {};
var StratePrice=[];
var StrateHash={
	sellUnitPrice : {name :"统一售价"}
};
var innerPartGrid=null;
var editFormDetail=null;

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
var storeLimitMap={};
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
    guestIdEl=nui.get('guestId');
    guestIdEl.setUrl(getGuestInfo);
    
    innerPartGrid = nui.get("innerPartGrid");
    innerPartGrid.setUrl(partCommonUrl);
    editFormDetail = document.getElementById("editFormDetail");
    
    getSellStrategy();
	guestIdEl.on("beforeload",function(e){
      
        var data = {};
        var params = {};
        var value = e.data.key;
        value = value.replace(/\s+/g, "");
        if(value.length<2){
            e.cancel = true;
            return;
        }
        var params = {};
    	params.pny = e.data.key.replace(/\s+/g, "");
    	params.isSupplier = 1;

        data.params = params;
        e.data =data;
        return;
            
       
        
    });
	
	gsparams.startDate = getNowStartDate();
	gsparams.endDate = addDate(getNowEndDate(), 1);

	sCreateDate = nui.get("sCreateDate");
	eCreateDate = nui.get("eCreateDate");

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
	rightGrid.on("preload",function(e){
		var result=e.result;
		var resultList=result.data;
		
		getSellStrategy();
		var sender=e.sender;
		var columnsList = [];
	    columnsList=sender.columns;
	    for(var i=0;i<columnsList.length;i++){
	    	if(columnsList[i].header=="辅助信息"){
	    		 columnsObjList=columnsList[i].columns;
	    		 break;
	    	}
	    }
//	    columnsObjList=columnsList[3].columns;
	    //获取下标
	    var index=null;
	    for(var i=0;i<columnsObjList.length;i++){
	    	if(columnsObjList[i].header=="统一售价"){
	    		index=i+1;
	    	}
	    }
	    var params =[];
	    for(var i=0;i<resultList.length;i++){
			var partId=resultList[i].partId;
			params.push({"partId":partId,"show":1});
//			getStratePrice(partId);
		}
	    getStratePriceList(params);
	    
//	    if(priceList.length<=0)return;
	    for(var i=0;i<priceList.length;i++){
//	    	columnsObjList[index+i].field=priceList[i].id;
	    	columnsObjList[index+i].visible=true;
		    columnsObjList[index+i].header=priceList[i].name;
	    }
	    
	   

		rightGrid.set({
	        columns: columnsList
	    });
	});
	morePartGrid.on("drawcell",function(e){
        switch (e.field)
        {
	        case "partBrandId":
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
            if(partShow == 1 ) {
            	if(partIn!=false){
            		var row2=innerPartGrid.getSelected();
            		if(row2){
            			addSelectPart();
            		}else{
            			var row = morePartGrid.getSelected();
        				if(row){
        					addSelectPart();
        				}
            		}
            			
            	}
            	partIn=true;
			}
        } 
		
        if((keyCode==27))  {  //ESC
            if(partShow == 1){
                onPartClose();
            }
            if(quickAddShow==1){
            	onAdvancedAddCancel();
            }
            if(advancedSearchShow==1){
            	onAdvancedSearchCancel();
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
				storehouse.forEach(function(v){
	        		storeHash[v.id]=v;
	        	});
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
				quickSearch(8);

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

var StratePriceUrl = baseUrl+"com.hsapi.cloud.part.invoicing.pricemanage.getPartPriceInfo.biz.ext";
function getStratePrice(partId){

	partPriceList=null;
	partPriceHash={};
	nui.ajax({
		url : StratePriceUrl,
		type : "post",
		async: false,
		data : {
			params: {partId:partId,show:1},
			token: token
		},
		success: function(data) {
			partPriceList =data.price;	
			var length=partPriceList.length;
			partPriceList.forEach(function(v){
				partPriceHash[v.name]=v;			
				StratePrice[v.partId+"-"+v.name]=partPriceHash;
			});

		},error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}
var SellStrategyUrl= baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.querySellStrategy.biz.ext";
function getSellStrategy(){
	priceList=[];
	nui.ajax({
		url : SellStrategyUrl,
		type : "post",
		async: false,
		data : {
			params: {},
			token: token
		},
		success: function(data) {
			priceList =data.list;
		},error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}
function rightGridSet(){
	var columnsList = [];
    columnsList=rightGrid.columns;
    for(var i=0;i<columnsList.length;i++){
    	if(columnsList[i].header=="辅助信息"){
    		 columnsObjList=columnsList[i].columns;
    		 break;
    	}
    }
//    columnsObjList=columnsList[3].columns;
    //获取下标
    var index=null;
    for(var i=0;i<columnsObjList.length;i++){
    	if(columnsObjList[i].header=="统一售价"){
    		index=i+1;
    	}
    }
//    if(priceList.length<=0)return;
    for(var i=0;i<priceList.length;i++){
    	var field=columnsObjList[index+i].field;
    	StrateHash[field]=priceList[i];
    	columnsObjList[index+i].visible=true;
	    columnsObjList[index+i].header=priceList[i].name;
    }
    rightGrid.set({
        columns: columnsList
    });
}
function addNewRow(check){
	rightGridSet();
	var data = basicInfoForm.getData();

    if(data.auditSign == 1){
        e.cancel = true;
        return;
    }
    //来源于采购单
    if(data.sourceType ==1){
    	e.cancel = true;
    	showMsg("来源于采购订单的明细不能添加","W");
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
		basicInfoForm.setData(row);
		 var auditSign=row.auditSign;
	       if(auditSign==0){
	    	   $('#status').text("草稿");	   
	       }else if(auditSign==1){
	    	   $('#status').text("已入库");
	       }
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
function initGrid(){
	
}
function loadRightGridData(mainId, auditSign) {
	editPartHash = {};
	var params = {};
	params.mainId = mainId;
	params.auditSign = auditSign;
	initGrid();
	rightGrid.load({
		params : params,
		token : token
	},function(){

		var data=rightGrid.getData();
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
	case 8:
		querystatusname = "所有";
		gsparams.auditSign = -1;
		gsparams.isFinished = null;
		querysign = 3;
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
	//是业务员且业务员禁止可见
	if(currIsSalesman ==1 && currIsOnlySeeOwn==1){
		params.creator= currUserName;
	}
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
	params.orderTypeId = 1;
	params.isDiffOrder = 1;
	//是业务员且业务员禁止可见
	if(currIsSalesman ==1 && currIsOnlySeeOwn==1){
		params.creator= currUserName;
	}
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
	advancedSearchShow=1;
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
		searchData.sOrderDate = formatDate(searchData.sOrderDate);
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
		searchData.guestId = nui.get("advanceGuestId").getValue();
	}
	// 订单单号
	if (searchData.serviceIdList) {
		var tmpList = searchData.serviceIdList.split("\n");
		for (i = 0; i < tmpList.length; i++) {
			tmpList[i] = "'" + tmpList[i].replace(/\s+/g, "") + "'";
		}
		searchData.serviceIdList = tmpList.join(",");
	}
	// 配件编码
	if (searchData.partCodeList) {
		var tmpList = searchData.partCodeList.split("\n");
		for (i = 0; i < tmpList.length; i++) {
			tmpList[i] = "'" + tmpList[i].replace(/\s+/g, "") + "'";
		}
		searchData.partCodeList = tmpList.join(",");
	}
	advancedSearchFormData = advancedSearchForm.getData();
	advancedSearchWin.hide();
	searchData.auditSign = gsparams.auditSign || 0;
	//去除空格
	for(var key in searchData){
    	if(searchData[key]!=null && searchData[key]!="" && typeof(searchData[key])=='string'){    		
    		searchData[key]=searchData[key].replace(/\s+/g, "");
    	}
    }
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
//				nui.get("createDate").setValue(new Date());
				nui.get("orderDate").setValue(new Date());
				nui.get("orderMan").setValue(currUserName);
				nui.get("sourceType").setValue(0);

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
//		nui.get("createDate").setValue(new Date());
		nui.get("orderDate").setValue(new Date());
		nui.get("orderMan").setValue(currUserName);

		addNewRow();

		var guestId = nui.get("guestId");
		guestId.focus();

	}

	//获取业务员的仓库限制	
	getStoreLimit();
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
	if (data.operateDate) {
		data.operateDate = format(data.operateDate, 'yyyy-MM-dd HH:mm:ss')
				+ '.0';// 用于后台判断数据是否在其他地方已修改
		// data.versionNo = format(data.versionNo, 'yyyy-MM-dd HH:mm:ss');
	}
	if (data.orderDate) {
	  data.orderDate = format(data.orderDate, 'yyyy-MM-dd HH:mm:ss');
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
	orderDate : "订单日期",
	billTypeId : "票据类型",
	settleTypeId : "结算方式"
};

var savePriceUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.saveUpdatePrice.biz.ext";
function savePrice(){
	var gridData=rightGrid.getChanges();
	var data=[];
	for(var i=0;i<gridData.length;i++){
		for(var key in StrateHash){
			if(gridData[i][key]){
				var partId=gridData[i].partId;
				//匹配
				if(StratePrice[partId+"-"+StrateHash[key].name]){
					var obj=StratePrice[partId+"-"+StrateHash[key].name][StrateHash[key].name];
					obj.sellPrice=gridData[i][key];
					data.push(obj);
				}		
			}
		}
	}
	if(data.length<0)return;
	nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '保存中...'
    });
	nui.ajax({
        url : savePriceUrl,
        type : "post",
        data : JSON.stringify({
            data : data,
            token : token,
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
//                showMsg("保存成功","S");
                
            } else {
                showMsg(data.errMsg || "保存失败!","E");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
        }
    });
}
var saveUrl = baseUrl
		+ "com.hsapi.cloud.part.invoicing.crud.savePjPchsOrder.biz.ext";
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
	
	var rightRow =rightGrid.getData();
	var orderMan =nui.get('orderMan').value;
//	if(orderMan !=currUserName){
		getStoreLimit();
//	}
	for(var i=0;i<rightRow.length;i++){
		if(Object.getOwnPropertyNames(storeLimitMap ).length >0){
			if(!storeLimitMap.hasOwnProperty(rightRow[i].storeId)  && storeHash[rightRow[i].storeId]){
				showMsg("没有选择"+storeHash[rightRow[i].storeId].name+"的权限","W");
				return;
			}
		}
	}
	
	//保存价格设置
	savePrice();
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
//		// targetWindow: window,,
		url : webPath+contextPath+"/com.hsweb.cloud.part.common.guestSelect.flow?token="+token,
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
	var record=e.record;
	var header = e.column.header;

	if(e.field== "comPartBrandId"){
		if(brandHash[e.value])
        {
//            e.cellHtml = brandHash[e.value].name||"";
        	if(brandHash[e.value].imageUrl){
        		
        		e.cellHtml = "<img src='"+ brandHash[e.value].imageUrl+ "'alt='配件图片' height='25px' width=' '/><br> "+brandHash[e.value].name||"";
        	}else{
        		e.cellHtml = brandHash[e.value].name||"";
        	}
        }
        else{
            e.cellHtml = "";
        }

	}
	
	if(e.field== "operateBtn"){
            e.cellHtml = //'<span class="fa fa-close fa-lg" onClick="javascript:deletePart()" title="删除行">&nbsp;&nbsp;&nbsp;&nbsp;</span>';
            			'<span class="fa fa-plus" onClick="javascript:addNewRow(true)" title="添加行">&nbsp;&nbsp;</span>' +
                        ' <span class="fa fa-close" onClick="javascript:deletePart()" title="删除行"></span>';
	}
//	if(e.field=="sellUnitPrice"){
//    	if(StratePrice[record.partId] && !e.value){
//    		e.cellHtml = StratePrice[record.partId].统一售价.sellPrice||"";
//    		e.value= StratePrice[record.partId].统一售价.sellPrice||"";
//    	}
//	}
	if(partPriceHash[header]){
		if(header==partPriceHash[header].name){
			if(StratePrice[record.partId+"-"+header] && !e.value){
				e.cellHtml = StratePrice[record.partId+"-"+header][header].sellPrice||"";
				e.value= StratePrice[record.partId+"-"+header][header].sellPrice||"";
			}
		}
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
//				addNewKeyRow();
			}
		}else if(column.field == "orderPrice"){
			rightGrid.beginEditCell(record, "remark");;
		}else if(column.field == "remark"){
//			addNewKeyRow();
			//统一售价到下一行
		}else if(column.field == "sellUnitPrice"){
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
  //仓先生
    if(currIsOpenApp ==1){
    	params.showStock=2;
    }
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
				//如果有替换件(不直接添加)
				if(partlist.length==1 && partlist[0].commonId==0){
					part = partlist[0];
					
				}else{
					advancedMorePartWin.show();
					morePartGrid.setData(partlist);
					partShow = 1;
					event.keyCode = null;
					var row = morePartGrid.getRow(0);
			        if(row){
			            morePartGrid.select(row,true);
			        }
			        partIn=false;

				}
				
			}else{
				//清空行数据
				showMsg("没有搜索到配件信息!","W");
				var row = rightGrid.getSelected();
				
				nui.confirm("是否添加配件?", "友情提示", function(action) {
					
					if (action == "ok") {
						addOrEditPart(row);
					}
					else{
						return;
					}
					});
//				rightGrid.removeRow(row);
//				addNewRow(false);
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
				url : webPath+contextPath+"/com.hsweb.cloud.part.common.detailQPAPopOperate.flow?token="+token,
				title : "入库数量金额",
				width : 430,
				height : 230,
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

var getStoreIdAndShelfUrl= baseUrl
+ "com.hsapi.cloud.part.report.stock.queryStoreIdAndShelf.biz.ext";
function getStoreIdAndShelf(params){
	var storeId ='';
	var shelf = '';
	nui.ajax({
		url : getStoreIdAndShelfUrl,
		type : "post",
		async: false,
		data : {
			params: params,
			token: token
		},
		success : function(data) {
			var errCode = data.errCode;
			if(errCode == "S"){
				if(data.list.length>0){
					
					var row = data.list[0];
					if(row.storeId){
						storeId = row.storeId;
					}
					if(row.shelf){
						shelf = row.shelf;
					}
				}
			}else{
				storeId="";
				shelf = "";
			}

		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});

	var storeIdAndShelf = {storeId: storeId, shelf: shelf};

	return storeIdAndShelf;
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


    var params = {partCode:value.replace(/\s+/g, "")};
	var part = getPartInfo(params);

	if(part){
		params.partId = part.id;
		var p={partId :part.id};
		var storeAndShelf=getStoreIdAndShelf(p);
		var storeId='';
		if(storeAndShelf.storeId){		
			storeId = storeAndShelf.storeId ;
		}else{
			storeId = FStoreId;
		}
		getStratePrice(part.id);
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
	// if (rows && rows.length > 0) {
	// 	msg = "请完善采购配件的数量，单价，金额，仓库等信息！";
	// }
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
		+ "com.hsapi.cloud.part.invoicing.crud.auditPjPchsOrder.biz.ext";
function auditOrder(flagSign, flagStr, flagRtn) {
	var data = basicInfoForm.getData();
	var orderAmt =data.orderAmt;
	var rightRow = rightGrid.getData();
	if(data.orderAmt===""){
		orderAmt=0;
		for(var i=0;i<rightRow.length;i++){
			orderAmt=parseFloat(rightRow[i].orderAmt)+parseFloat(orderAmt);
		}
	}

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
	// var msg = checkRightData();
	// if (msg) {
	// 	showMsg(msg,"W");
	// 	return;
	// }
	var p = checkRightData();
	if (p && p.qtyPartCode) {
		var partCode = p.qtyPartCode;
		showMsg("配件编码:"+partCode+"数量为0","W");
		return;
	}
	
	getStoreLimit();
	var rightRow =rightGrid.getData();
	for(var i=0;i<rightRow.length;i++){
		if(Object.getOwnPropertyNames(storeLimitMap ).length >0){
			if(!storeLimitMap.hasOwnProperty(rightRow[i].storeId)  && storeHash[rightRow[i].storeId]){
				showMsg("没有选择"+storeHash[rightRow[i].storeId].name+"的权限","W");
				return;
			}
		}
	}
	
	if (p && p.pricePartCode) {
		var partCode = p.pricePartCode;
		nui.confirm("存在单价为0信息，是否继续?", "友情提示", function(action) {
			if (action == "ok") {
				
				//保存价格设置
				savePrice();
				
				data = getMainData();
	
				//由于票据类型可能修改，所以除了新建和删除，其他都应该是修改
				var detailData = rightGrid.getData();
	
				var pchsOrderDetailAdd = rightGrid.getChanges("added");
				var pchsOrderDetailUpdate = rightGrid.getChanges("modified");
				var pchsOrderDetailDelete = rightGrid.getChanges("removed");
				var pchsOrderDetailUpdate = getModifyData(detailData, pchsOrderDetailAdd, pchsOrderDetailDelete);
	
	
//				nui.mask({
//					el : document.body,
//					cls : 'mini-mask-loading',
//					html : flagStr
//				});
	
				nui.mask({
			        el : document.body,
			        cls : 'mini-mask-loading',
			        html : '入库中...'
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
//							showMsg("入库成功!","S");
							// onLeftGridRowDblClick({});
							var pjPchsOrderMainList = data.pjPchsOrderMainList;
							if (pjPchsOrderMainList && pjPchsOrderMainList.length > 0) {
								var leftRow = pjPchsOrderMainList[0];
								var row = leftGrid.getSelected();
								leftGrid.updateRow(row, leftRow);
								loadMainAndDetailInfo(leftRow);
								nui.confirm("本单入库成功，是否打印？", "友情提示", function(action) {
									if(action== 'ok'){
										onPrint();
									}else{
										
									}
								});

								// 保存成功后重新加载数据
								
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
		nui.confirm("本单金额"+orderAmt+"元，是否确定入库?", "友情提示", function(action) {
			if (action == "ok") {
				
				//保存价格设置
				savePrice();
				
				data = getMainData();
	
				//由于票据类型可能修改，所以除了新建和删除，其他都应该是修改
				var detailData = rightGrid.getData();
	
				var pchsOrderDetailAdd = rightGrid.getChanges("added");
				var pchsOrderDetailUpdate = rightGrid.getChanges("modified");
				var pchsOrderDetailDelete = rightGrid.getChanges("removed");
				var pchsOrderDetailUpdate = getModifyData(detailData, pchsOrderDetailAdd, pchsOrderDetailDelete);
	
	
//				nui.mask({
//					el : document.body,
//					cls : 'mini-mask-loading',
//					html : flagStr
//				});
	
				nui.mask({
			        el : document.body,
			        cls : 'mini-mask-loading',
			        html : '入库中...'
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
//							showMsg("入库成功!","S");
							// onLeftGridRowDblClick({});
							var pjPchsOrderMainList = data.pjPchsOrderMainList;
							if (pjPchsOrderMainList && pjPchsOrderMainList.length > 0) {
								var leftRow = pjPchsOrderMainList[0];
								var row = leftGrid.getSelected();
								leftGrid.updateRow(row, leftRow);
								loadMainAndDetailInfo(leftRow);
								nui.confirm("本单入库成功，是否打印？", "友情提示", function(action) {
									if(action== 'ok'){
										onPrint();
									}else{
										rightGrid.setData([]);
			    						add();
									}
								});
								// 保存成功后重新加载数据
								
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
function onGuestValueChanged(e)
{
    //供应商中直接输入名称加载供应商信息
//    var params = {};
//    params.pny = e.value;
//    params.isSupplier = 1;
//    setGuestInfo(params);
	var data = e.selected;
	if (data) { 
		var id = data.id;
		var text = data.fullName;
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
    }
}

function onStoreValueChange(e){
	var data = e.selected;
	if(data){
		var id = data.id;
		var orderMan =nui.get('orderMan').value;
		if(orderMan !=currUserName){
			getStoreLimit();
		}
		if(Object.getOwnPropertyNames(storeLimitMap ).length ==0){
			//不做限制
		}
		if(Object.getOwnPropertyNames(storeLimitMap ).length >0){
			if(!storeLimitMap.hasOwnProperty(id)){
				showMsg("没有选择"+storeHash[341].name+"的权限","W");
				return;
			}
		}
	}
		
}
var storeLimtUrl  = baseUrl +"com.hsapi.system.tenant.employee.queryStoreManOne.biz.ext";
function getStoreLimit(){
	storeLimitMap={};
	var orderMan =nui.get('orderMan').value;
	if(!orderMan){
		return;
	}
	nui.ajax({
		url : storeLimtUrl,
		async:false,
		data : {
			orgid : currOrgId,
			name : orderMan,
			token : token
		},
		type : "post",
		success : function(text) {
			var data =text.data;
			for(var i=0;i<data.length;i++){
				storeLimitMap[data[i].storeId] =data [i];
			}
			
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
	return storeLimitMap;
}

var getGuestInfo = baseUrl
		+ "com.hsapi.cloud.part.baseDataCrud.crud.querySupplierList.biz.ext";
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
//					var data = supplier[0];
//					var value = data.id;
//					var text = data.fullName;
//					var el = nui.get('guestId');
//					el.setValue(value);
//					el.setText(text);

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
//	nui.confirm("此供应商不存在，是否新增?", "友情提示", function(action) {
//		if (action == "ok") {
			nui.open({
				// targetWindow: window,
				url: webPath+contextPath+"/com.hsweb.cloud.part.basic.supplierDetail.flow?token=" + token,
				title: "供应商资料", width: 600, height: 600,
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

//		}else{
//			nui.get("guestId").focus();
//		}
//	});
}

function onPrint(){
	var tab=parent.mini.get("mainTabs").getActiveTab();
	var name=tab.name;
	
	if(name == '1568'){ //进货单1568 采购入库 1681
		var printName =tab.title;
	}else if(name == '1681'){
		var printName ='采购入库单';
	}
	var from = basicInfoForm.getData();
	var params={
			id : from.id,
		auditSign:from.auditSign,
		guestId :from.guestId,
		printName : printName,
		currRepairSettorderPrintShow : currRepairSettorderPrintShow,
		currOrgName : currOrgName,
		currUserName : currUserName,
		currCompAddress : currCompAddress,
		currCompTel : currCompTel,
		currCompLogoPath : currCompLogoPath,
		storeHash : storeHash,
		brandHash: brandHash
	};
	var detailParams={
			mainId :from.id
	};
	var openUrl = webPath + contextPath+"/purchase/purchaseOrderEnter/purchaseOrderEnterPrint.jsp";

    nui.open({
       url: openUrl,
       width: "100%",
       height: "80%",
       showMaxButton: false,
       allowResize: false,
       showHeader: true,
       onload: function() {
           var iframe = this.getIFrameEl();
           iframe.contentWindow.SetData(params,detailParams);
       },
   });
    if(checkNew() > 0){
    	return;
    }
    rightGrid.setData([]);
	add();
}
//function onPrint() {
//	var row = leftGrid.getSelected();
//
//	var data = rightGrid.getData();
//	if(data && data.length<=0) return;
//
//	if (row) {
//
//		if(!row.id) return;
//
//		var auditSign = row.auditSign||0;
//
//		nui.open({
//
//			url : webPath + contextPath + "/com.hsweb.cloud.part.purchase.pchsOrderEnterPrint.flow?ID="
//					+ row.id+"&printMan="+currUserName+"&auditSign="+auditSign,// "view_Guest.jsp",
//			title : "采购入库打印",
//			width : 900,
//			height : 600,
//			onload : function() {
//				var iframe = this.getIFrameEl();
//				// iframe.contentWindow.setInitData(storeId, 'XSD');
//			}
//		});
//
//		// nui.open({
//
//		// 	url : webPath + contextPath + "/com.hsweb.cloud.part.purchase.purchaseOrderPrint.flow?ID="
//		// 			+ row.id+"&printMan="+currUserName,// "view_Guest.jsp",
//		// 	title : "采购入库打印",
//		// 	width : 900,
//		// 	height : 600,
//		// 	onload : function() {
//		// 		var iframe = this.getIFrameEl();
//		// 		// iframe.contentWindow.setInitData(storeId, 'XSD');
//		// 	}
//		// });
//	}
//
//}
function addSelectPart(){
	//有选择替换件信息\
	var innerRow={};
	innerRow =innerPartGrid.getSelected();
	if(innerRow){
		var row =innerRow;
		if(row){
			var params = {partCode:row.partCode};
			params.partId = row.partId;
			var p={partId :row.partId};
			var storeAndShelf=getStoreIdAndShelf(p);
			if(storeAndShelf.storeId){		
				params.storeId = storeAndShelf.storeId ;
			}else{
				params.storeId =  FStoreId;
			}
			var dInfo = getPartPrice(params);
			var storeId= params.storeId;
			var price = dInfo.price;
			var shelf = dInfo.shelf;
			getStratePrice(row.partId);				
			var newRow = {
				partId : row.partId,
				comPartCode : row.partCode,
				comPartName : row.partName,
				comPartBrandId : row.partBrandId,
				comApplyCarModel : row.applyCarModel,
				comUnit : row.unit,
				orderQty : 1,
				orderPrice : price,
				orderAmt : price,
				storeId : storeId,
				storeShelf :shelf,
				comOemCode : row.oemCode,
				comSpec : row.spec,
				partCode : row.partCode,
				partName : row.partName,
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
			//取消行选中
			innerPartGrid.clearSelect();  


			
		}else{
			showMsg("请选择配件!","W");
			return;
		}
	}else{	
		var row = morePartGrid.getSelected();
		row.partId =row.id;
		if(row){
			var params = {partCode:row.code};
			params.partId = row.partId;
			var p={partId :row.partId};
			var storeAndShelf = getStoreIdAndShelf(p);
			if(storeAndShelf.storeId){		
				params.storeId = storeAndShelf.storeId ;
			}else{
				params.storeId =  FStoreId;
			}
			var dInfo = getPartPrice(params);
			var storeId= params.storeId;
			var price = dInfo.price;
			var shelf = dInfo.shelf;
			getStratePrice(row.id);				
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
				storeId : storeId,
				storeShelf :shelf,
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
    if(data.sourceType==1){
	   if(field=="comPartCode"){
		   e.cancel = true;
	   }
    }
	if(advancedMorePartWin.visible) {
		e.cancel = true;
		morePartGrid.focus();
		//var row = morePartGrid.getRow(0);   默认不能选中，回车事件会有影响
        //if(row){
        //    morePartGrid.select(row,true);
        //}
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
//	var data = rightGrid.getChanges()||[];
//	if (data.length>0) {
//		showMsg("请先保存数据!","W");
//		return;
//	}
	advancedAddForm.setData([]);
	advancedAddWin.show();
	quickAddShow = 1;

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

	var detail = nui.clone(rightGrid.getData());
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
    method5('tableExcel',"采购入库"+serviceId,'tableExportA');
}
function addPchsOrder(type)
{
	
	var row = leftGrid.getSelected();
	if(row.auditSign == 1){
		showMsg("此单已入库!","W");
		return;
	}

//	var main = basicInfoForm.getData();
//	if(!main.id){
//		showMsg("请先保存数据!","W");
//		return;
//	}
//	var data = rightGrid.getChanges()||[];
//	if (data.length>0) {
//		showMsg("请先保存数据!","W");
//		return;
//	}
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
		url: webPath+contextPath+"/com.hsweb.cloud.part.purchase.pchsOrderSelect.flow?token="+token,
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
	
	var row= leftGrid.getSelected(0);
	if(row.serviceId=='新采购入库'){
		
	}else{
		var newRow = { serviceId: '新采购入库', auditSign: 0};
		leftGrid.addRow(newRow, 0);
		leftGrid.clearSelect(false);
		leftGrid.select(newRow, false);
	}
	
	
	nui.get("serviceId").setValue("新采购入库");
	nui.get("codeId").setValue(data.orderMainId);
	nui.get("code").setValue(data.orderServiceId);
	nui.get("billTypeId").setValue(data.billTypeId);  //010101  收据   010102  普票  010103  增票
	nui.get("settleTypeId").setValue(data.settleTypeId);
	nui.get("taxRate").setValue(data.taxRate);
	nui.get("taxSign").setValue(data.taxSign);
//	nui.get("createDate").setValue(new Date());
	nui.get("orderDate").setValue(data.orderDate);
	nui.get("orderMan").setValue(data.orderMan);
	
	var guestId = nui.get("guestId");
	guestId.setValue(data.guestId);
	guestId.setText(data.fullName);

	var params = {mainId: data.orderMainId,notFinished:0};
	if(data && data.type == 'pchs'){
		nui.get("sourceType").setValue(1);
		getOrderDetail(params);
	}else{
		nui.get("sourceType").setValue(2);
		getSellDetail(params);
	}
	guestId.focus();


}
var orderDetailUrl = baseUrl+"com.hsapi.cloud.part.invoicing.paramcrud.queryPjPchsOrderDetailChkList.biz.ext";
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
							orderQty : row.canInQty,
							orderPrice : row.orderPrice,
							orderAmt : parseFloat(row.orderQty) * parseFloat(row.orderPrice),
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
							taxPrice : row.taxPrice,
							sourceMainId : row.mainId,
							sourceDetailId : row.id
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
var sellDetailUrl = baseUrl+"com.hsapi.cloud.part.invoicing.paramcrud.queryPjSellOrderDetailChkList.biz.ext";
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

//显示替换件
function onShowRowDetail(e) {
    var row = e.record;
    
    //将editForm元素，加入行详细单元格内

	var td = morePartGrid.getRowDetailCellEl(row);

    td.appendChild(editFormDetail);
    editFormDetail.style.display = "";
    innerPartGrid.setData([]);
    var partId = row.id;
    innerPartGrid.load({
    	partId:partId,
		type :"LOCAL",
    	token:token
	});
    
}

//新增配件
function addOrEditPart(row)
{
    nui.open({
        // targetWindow: window,
        url: webPath + contextPath + "/com.hsweb.cloud.part.basic.partDetail.flow?token=" + token,
        title: "配件资料",
        width: 470, height: 420,
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

var StratePriceListUrl =baseUrl+"com.hsapi.cloud.part.invoicing.pricemanage.getPartPriceInfoList.biz.ext";
function getStratePriceList(params){
	partPriceList=null;
	partPriceHash={};
	nui.ajax({
		url : StratePriceListUrl,
		type : "post",
		async: false,
		data : {
			params: params,
			token: token
		},
		success: function(data) {
			partPriceList =data.price;	
			var length=partPriceList.length;
			partPriceList.forEach(function(v){
				partPriceHash={};
				partPriceHash[v.name]=v;	
				StratePrice[v.partId+"-"+v.name]=partPriceHash;
				
			});
			partPriceList.forEach(function(v){
				partPriceHash[v.name]=v;	
			});

		},error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}


function onCost(){
	if (checkNew() > 0) {
		showMsg("请先保存数据!","W");
		return;
	}
	var data  =basicInfoForm.getData();
	var serviceId =data.serviceId;
	var id = data.id;
	var p={};
	p.code =serviceId;
	p.codeId =id;
	p.guestId = guestIdEl.getValue();
	p.guestName = guestIdEl.getText();
	nui.open({
		// targetWindow: window,,
		url : webPath+contextPath+"/com.hsweb.cloud.part.purchase.otherPBill.flow?token="+token,
		title : "其他应付单",
		width : 930,
		height : 560,
		allowDrag : true,
		allowResize : true,
		onload : function() {
			var iframe = this.getIFrameEl();	
			iframe.contentWindow.setData(p);
		},
		ondestroy : function(action) {
		}
	});
}