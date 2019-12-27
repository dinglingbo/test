/**
 * Created by Administrator on 2018/2/23.
 */
var webBaseUrl = webPath + contextPath + "/";
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
var storeHash={};
var gsparams = {};
var sOrderDate = null;
var eOrderDate = null;
var dataList = null;
var morePartGrid = null;
var FStoreId = null;
var isNeedSet = false;
var oldValue = null;
var oldRow = null;
var mainTabs = null;
var billmainTab = null;
var partInfoTab = null;
var guestIdEl=null;
var autoNew = 0;
var advancedSearchShow=0;
var StatusHash={
	"0"	:"草稿",
	"1":"已提交",
	"2":"已提交",
	"3":"部分入库",
	"4":"已入库"
}
var partIn =null;
var partShow=0;
var storeLimitMap={};
var storeShelfList=[];
var storeShelfHash={}
var partHash={};
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
    guestIdEl=nui.get('guestId');
    guestIdEl.setUrl(getGuestInfo);
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
    	params.isClient = 1;

        data.params = params;
        e.data =data;
        return;
            
       
        
    });

    gsparams.startDate = getNowStartDate();
    gsparams.endDate = addDate(getNowEndDate(), 1);

    sOrderDate = nui.get("sOrderDate");
    eOrderDate = nui.get("eOrderDate");

    mainTabs = nui.get("mainTabs");
    billmainTab = mainTabs.getTab("billmain");

    document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;
        if((keyCode==83)&&(event.altKey))  {   //保存
            save();
        } 
        
        if((keyCode==73)&&(event.altKey))  {   //选择销售出库单  Alt+I
        	addPart();
        } 
        
        if((keyCode==84)&&(event.altKey))  {   //提交 Alt+T
        	audit();
        } 
      
        if((keyCode==89)&&(event.altKey))  {   //入库 Alt+Y
        	auditToEnter();
        } 
      
        if((keyCode==80)&&(event.altKey))  {   //打印
            onPrint();
        } 
        if((keyCode==27))  {  
        	if(partShow == 1){
                onPartClose();
            }
            if(advancedSearchShow==1){
            	onAdvancedSearchCancel();
            }
        }
        
        if((keyCode==13))  {  //新建
            if(partShow == 1) {
            	if(partIn!=false){
            		var row = morePartGrid.getSelected();
    				if(row){
    					addSelectPart();
    				}
    				
            	}
            	partIn=true;
			}
        } 
    }
    
    
    var dictDefs ={"rtnReasonId":"DDT20130703000073", "settleTypeId":"DDT20130703000035"};
    initDicts(dictDefs, function(){
        getStorehouse(function(data) {
            storehouse = data.storehouse || [];
            if(storehouse && storehouse.length>0){
                FStoreId = storehouse[0].id;
                storehouse.forEach(function(v){
            		storeHash[v.id]=v;
            	});
                nui.get('storeId').setData(storehouse);
            }else{
                isNeedSet = true;
            }
    
            getAllPartBrand(function(data) {
                brandList = data.brand;
                brandList.forEach(function(v) {
                    brandHash[v.id] = v;
                });
        
                gsparams.auditSign = 0;
                quickSearch(15);

                nui.unmask();
            });
            
        });
    });
    

    $("#guestId").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            var rtnReasonId = nui.get("rtnReasonId");
            rtnReasonId.focus();
        }
    });
    $("#rtnReasonId").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            addNewRow(true);
        }
    });
    
    if(currIsCommission ==1){
    	nui.get('chooseMemBtn').setVisible(true);
    }
    
    //启用APP
    if(currIsOpenApp==1){
    	nui.get('auditToEnterBtn').setVisible(false);
    	nui.get('auditBtn').setVisible(true);
        getStoreLocation();
    }else{
    	nui.get('auditToEnterBtn').setVisible(true);
    	nui.get('auditBtn').setVisible(false);
    }
    rightGrid.on("preload",function(e){
		var result=e.result;
		var resultList=result.data;
		
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
	    //开启APP，处理仓位
	    if(currIsOpenApp ==1){
	    	var shelfObj={};
	    	var editor={};
	    	var flag=null;
	    	for(var i=0;i<columnsObjList.length;i++){
	 	    	if(columnsObjList[i].field=="storeShelf"){
	 	    		shelfObj=columnsObjList[i];
	 	    		editor=shelfObj.editor;
	 	    		flag =i;
	 	    		break;
	 	    	}
	 	    }
	    	editor.cls="nui-combobox";
	    	editor.data="storeShelfList";
	    	editor.dataField="storeShelfList";
	    	editor.enabled=true;
	    	editor.id ="storeShelf";
	    	editor.name="storeShelf";
	    	editor.textField="name";
	    	editor.type="combobox";
	    	editor.valueField="name";
	    	columnsObjList[flag].editor=editor;
	    	
	    }
	   
		rightGrid.set({
	        columns: columnsList
	    });
	});
});
var AuditSignHash = {
    "0" : "未审",
    "1" : "已审",
    "2" : "已过账",
    "3" : "已取消"
};
//返回类型给srvBottom，用于srvBottom初始化
function confirmType(){
    return "orderRtn";
}
function getParentStoreId(){
    return FStoreId;
}
function loadMainAndDetailInfo(row) {
    if (row) {
        basicInfoForm.setData(row);
        var billStatusId=row.billStatusId;
		$('#status').text(StatusHash[billStatusId]);
        //bottomInfoForm.setData(row);
        nui.get("guestId").setText(row.guestFullName);

        var row = leftGrid.getSelected();

        if(row.codeId && data.codeId>0){
            //可以编辑票据类型和结算方式，是否需要打包，备注，业务员；明细不能修改；如果需要，则退回
            nui.get("guestId").disable();
            nui.get("code").disable();
        }else{
            nui.get("guestId").enable();
            nui.get("code").enable();
            if (row.auditSign == 1) {
                document.getElementById("basicInfoForm").disabled = true;
                setBtnable(false);
                setEditable(false);
            } else {
                document.getElementById("basicInfoForm").disabled = false;
                setBtnable(true);
                setEditable(true);
            }
            if(currIsSalesman ==1 && currIsCanSubmitOtherBill ==1 && row.creator !=currUserName ){
   				nui.get("auditBtn").disable();
	   		}else {
	   			nui.get("auditBtn").enable();
	   		}
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
function onLeftGridSelectionChanged() {
    var row = leftGrid.getSelected();

    loadMainAndDetailInfo(row);
}
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
        if(autoNew == 0){
			add();
			autoNew = 1;
		}
        if(data && data.length <= 0){
            addNewRow(false);
        }else{
            var guestId = nui.get("guestId").getValue();
            var changeData = rightGrid.getChanges();
            if(changeData.length == 0 && guestId){
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
        params.billStatusId = 0;
        gsparams.billStatusId=0;
        querytypename = "草稿";
        querysign = 2;
        gsparams.auditSign = 0;
        break;
//    case 7:
//        params.auditSign = 1;
//        params.billStatusId = 1;
//        gsparams.billStatusId=1;
//        querytypename = "已提交";
//        querysign = 2;
//        gsparams.auditSign = 1;
//        break;
    case 7:
        params.auditSign = 1;
        gsparams.billStatusId = null;
        gsparams.billStatusIdList= "1,2";
        querytypename = "已提交";
        querysign = 2;
        gsparams.auditSign = 1;
        break;
    case 8:
        params.auditSign = 1;
        params.billStatusId = 3;
        gsparams.billStatusId=3;
        querytypename = "部分入库";
        querysign = 2;
        gsparams.auditSign = 1;
        break;
    case 14:
        params.auditSign = 1;
        params.billStatusId = 4;
        gsparams.billStatusId=4;
        querytypename = "已入库";
        querysign = 2;
        gsparams.auditSign = 1;
        break;
    case 15:
        params.auditSign = -1;
        params.billStatusId = null;
        gsparams.billStatusId=null;
        querytypename = "所有";
        querysign = 2;
        gsparams.auditSign = -1;
        break;
    default:
        params.today = 1;
        params.startDate = getNowStartDate();
        params.endDate = addDate(getNowEndDate(), 1);
        params.auditSign = 0;
        params.billStatusId = 0;
        querytypename = "草稿";
        gsparams.startDate = getNowStartDate();
        gsparams.endDate = addDate(getNowEndDate(), 1);
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
    }
    gsparams.isDiffOrder =0;
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
	if(currIsSalesman ==1 && currIsCanViewOtherBill ==1){
		params.creator= currUserName;
	}
    return params;
}
function setBtnable(flag) {
    if (flag) {
        nui.get("saveBtn").enable();
        //nui.get("auditToEnterBtn").disable();
        nui.get("auditBtn").enable();
        nui.get("selectSupplierBtn").enable();
    } else {
        nui.get("saveBtn").disable();
        //nui.get("auditToEnterBtn").enable();
        nui.get("auditBtn").disable();
        nui.get("selectSupplierBtn").disable();
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
    //销售退货;
    params.orderTypeId = 4;
  //是业务员且业务员禁止可见
	if(currIsSalesman ==1 && currIsOnlySeeOwn==1){
		params.creator= currUserName;
	}
	if(currIsSalesman ==1 && currIsCanViewOtherBill ==1){
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
            if(currIsSalesman ==1 && currIsCanSubmitOtherBill ==1 && row.creator !=currUserName ){
				nui.get("auditBtn").disable();
			}else {
				nui.get("auditBtn").enable();
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
        sOrderDate.setValue(getWeekStartDate());
        eOrderDate.setValue(addDate(getWeekEndDate(), 1));
    }
}
function onAdvancedSearchOk() {
    var searchData = advancedSearchForm.getData();
    var i;
    // 退货日期
    if (searchData.sOrderDate) {
        searchData.sCreateDate = formatDate(searchData.sCreateDate);
    }
    if (searchData.eOrderDate) {
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
    searchData.auditSign = gsparams.auditSign;
  //去除空格
	for(var key in searchData){
		searchData[key]=searchData[key].replace(/(^\s*)|(\s*$)/g, "");
    }
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
        if (row.serviceId == "新销售退货")
            return true;
    });

    return rows.length;
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

                nui.get("guestId").enable();
                nui.get("code").enable();

                basicInfoForm.reset();
                rightGrid.clearRows();


                var newRow = {
                    serviceId : '新销售退货',
                    auditSign : 0
                };
                leftGrid.addRow(newRow, 0);
                leftGrid.clearSelect(false);
                leftGrid.select(newRow, false);

                nui.get("serviceId").setValue("新销售退货");
                nui.get("billTypeId").setValue("010103"); // 010101 收据 010102 普票 010103 增票
//                nui.get("createDate").setValue(new Date());
                nui.get("orderDate").setValue(new Date());
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

        nui.get("guestId").enable();
        nui.get("code").enable();

        basicInfoForm.reset();
        rightGrid.clearRows();


        var newRow = {
            serviceId : '新销售退货',
            auditSign : 0
        };
        leftGrid.addRow(newRow, 0);
        leftGrid.clearSelect(false);
        leftGrid.select(newRow, false);

        nui.get("serviceId").setValue("新销售退货");
        nui.get("billTypeId").setValue("010103"); // 010101 收据 010102 普票 010103 增票
//        nui.get("createDate").setValue(new Date());
        nui.get("orderDate").setValue(new Date());
        nui.get("orderMan").setValue(currUserName);

        addNewRow();

        var guestId = nui.get("guestId");
        guestId.focus();

    }

    
}
function addNewRow(check){
	rightGridSet();
    var data = basicInfoForm.getData();

    if(data.auditSign == 1){
        return;
    }

    if(data.codeId && data.codeId>0) return;
    
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
function getMainData() {
    var data = basicInfoForm.getData();
    // 汇总明细数据到主表
    data.isFinished = 0;
    data.auditSign = 0;
    data.billStatusId = 0;
    data.printTimes = 0;
    data.orderTypeId = 4;
    delete data.createDate;	
    if (data.operateDate) {
        data.operateDate = format(data.operateDate, 'yyyy-MM-dd HH:mm:ss')
                + '.0';// 用于后台判断数据是否在其他地方已修改
        // data.versionNo = format(data.versionNo, 'yyyy-MM-dd HH:mm:ss');
    }
    if (data.orderDate) {
  	  data.orderDate = format(data.orderDate, 'yyyy-MM-dd HH:mm:ss');
  	}

    if(!data.billTypeId){
        data.billTypeId = "010103";
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
    guestId : "客户",
    orderMan : "退货员",
    orderDate : "退货日期",
    rtnReasonId : "退货原因",
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

    var rightRow =rightGrid.getData();
	var orderMan =nui.get('orderMan').value;
//	if(orderMan !=currUserName){
		getStoreLimit();
//	}
	for(var i=0;i<rightRow.length;i++){
		if(Object.getOwnPropertyNames(storeLimitMap ).length >0){
			if(!storeLimitMap.hasOwnProperty(rightRow[i].storeId) && storeHash[rightRow[i].storeId]){
				showMsg("没有选择"+storeHash[rightRow[i].storeId].name+"的权限","W");
				return;
			}
		}
	}
	
	if(currIsOpenApp ==1){
		// set集合
	    var set =new  Set();
		for(var i=0;i<rightRow.length;i++){
			if(!rightRow[i].partId){
				rightGrid.removeRow(rightRow[i]);
				continue;
			}
			set.add(rightRow[i].partId+"-"+rightRow[i].storeId);
		}
		if(set.size <rightGrid.getData().length){
			showMsg("订单明细不能出现相同配件同个仓库两次以上","W");
			return;
		}

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
        // targetWindow: window,,
        url : webPath+contextPath+"/com.hsweb.cloud.part.common.guestSelect.flow?token="+token,
        title : "客户资料",
        width : 980,
        height : 560,
        allowDrag : true,
        allowResize : true,
        onload : function() {
            var iframe = this.getIFrameEl();
            var params = {
                isClient: 1,
                guestType:'01020102'
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
function deletePart() {
    var row = leftGrid.getSelected();
    if (row) {
        if (row.auditSign == 1) {
            return;
        }
    }

    if(row.codeId && data.codeId>0) return;

    var part = rightGrid.getSelected();
    if (!part) {
        return;
    }
    if (part.detailId && editPartHash[part.detailId]) {
        delete editPartHash[part.detailId];
    }
    rightGrid.removeRow(part, true);
}
function checkRightData() {
    var msg = '';
    var rows = rightGrid.findRows(function(row) {
        if(row.partId){  
            if (row.orderQty) {
                if (row.orderQty <= 0)
                    return true;
            } else {
                return true;
            }
            
            if (row.orderPrice < 0)
                return true;
            
            if (row.orderAmt < 0)
                return true;

            if (row.storeId) {
            } else {
                return true;
            }
        }
    });

    if (rows && rows.length > 0) {
        msg = "请完善退货配件的数量，单价，金额，仓库等信息！";
    }
    return msg;
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
    //if(isInner == 0 && billStatusId == 0){
        var flagSign = 1; 
        var flagStr = "入库中...";
        var flagRtn = "入库成功!";
        auditOrder(flagSign, flagStr, flagRtn);     
    //}else if(isInner == 1 && billStatusId != 2){
        //showMsg("请等待对方出库后再入库!","W");
        //return;
    //}else if(billStatusId == 2){
        //如果是内部的销售退货，对方出库后，才会更新billStatusId == 2
        //var id = data.id||0;
        //orderEnter(id); 
    //}

}
var auditUrl = baseUrl + "com.hsapi.cloud.part.invoicing.crud.auditPjSellOrderRtn.biz.ext";
        //+ "com.hsapi.cloud.part.invoicing.crud.auditPjPchsOrder.biz.ext";
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
    var msg = checkRightData();
    if (msg) {
        showMsg(msg,"W");
        return;
    }

    var str = "提交";
    if(flagSign == 1){
        str = "入库";
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
	
	if(currIsOpenApp ==1){
		// set集合
	    var set =new  Set();
		for(var i=0;i<rightRow.length;i++){
			if(!rightRow[i].partId){
				rightGrid.removeRow(rightRow[i]);
				continue;
			}
			set.add(rightRow[i].partId+"-"+rightRow[i].storeId);
		}
		if(set.size <rightGrid.getData().length){
			showMsg("订单明细不能出现相同配件同个仓库两次以上","W");
			return;
		}

	}

    nui.confirm("是否确定"+str+"?", "友情提示", function(action) {
        if (action == "ok") {

            data = getMainData();

            //由于票据类型可能修改，所以除了新建和删除，其他都应该是修改
            var detailData = rightGrid.getData();

            var pchsOrderDetailAdd = rightGrid.getChanges("added");
            var pchsOrderDetailUpdate = rightGrid.getChanges("modified");
            var pchsOrderDetailDelete = rightGrid.getChanges("removed");
            var pchsOrderDetailUpdate = getModifyData(detailData, pchsOrderDetailAdd, pchsOrderDetailDelete);
            //先注释
            var cangHash ="";
			if(currIsOpenApp ==1){
				cangHash=getCangHash(data,detailData);
			}
            
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
                    cangHash:cangHash,
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

                            if(leftRow.isInner == 1){
                                //更新采购退货isRtnSign=1
                                updatePchsRtnStatus(leftRow.codeId);
                            }

                            var row = leftGrid.getSelected();
                            leftGrid.updateRow(row, leftRow);

                            // 保存成功后重新加载数据
                            loadMainAndDetailInfo(leftRow);
                            nui.confirm("是否打印？", "友情提示", function(action) {
    							if(action== 'ok'){
    								onPrint();
    							}else{
    								
    							}
    						});

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
var enterUrl = baseUrl
        + "com.hsapi.cloud.part.invoicing.ordersettle.generateNewSellRtnToEnter.biz.ext";
function orderEnter(mainId) {
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

                        basicInfoForm.setData(newRow);
                        nui.confirm("是否打印？", "友情提示", function(action) {
							if(action== 'ok'){
								onPrint();
							}else{
								if(checkNew() > 0){
							    	return;
							    }
							    rightGrid.setData([]);
								add();
							}
						});

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
var updatePchsRtnStatusUrl = baseUrl
        + "com.hsapi.cloud.part.invoicing.crud.updatePchsRtnOrderStatus.biz.ext";
function updatePchsRtnStatus(mainId) {

    nui.ajax({
        url : updatePchsRtnStatusUrl,
        type : "post",
        data : JSON.stringify({
            isRtnSign : 1,
            mainId: mainId,
            token: token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
            } else {
                onsole.log(data.errMsg || "入库失败!");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });

    
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

function onStoreIdValueChange(e){
	var data = e.selected;
	var rows =rightGrid.getData();
	var changes=[];
	if(data){
		if(rows.length>0){
			for(var i=0;i<rows.length;i++){
				if(rows[i].partId){
					rows[i].storeId =data.id;
				}
			}
			rightGrid.setData(rows);
		}
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
			if(!storeLimitMap.hasOwnProperty(id) && storeHash[id].name){
				showMsg("没有选择"+storeHash[id].name+"的权限","W");
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
//                    var data = supplier[0];
//                    var value = data.id;
//                    var text = data.fullName;
//                    var el = nui.get('guestId');
//                    el.setValue(value);
//                    el.setText(text);

                    var row = leftGrid.getSelected();
                    var newRow = {
                        guestFullName : text
                    };
                    leftGrid.updateRow(row, newRow);

                    var billTypeIdV = data.billTypeId;
                    var settTypeIdV = data.settTypeId;

                    nui.get("billTypeId").setValue(billTypeIdV);
                    nui.get("settleTypeId").setValue(settTypeIdV);
                    
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
            }

        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}

function onPrint(){
	var from = basicInfoForm.getData();
	var params={
			id : from.id,
		auditSign:from.auditSign,
		guestId :from.guestId,
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
			mainId :from.id,
		  auditSign:from.auditSign	
	};
	var openUrl = webPath + contextPath+"/purchase/sellOrderRtn/sellOrderRtnPrint.jsp";

    nui.open({
       url: openUrl,
       width: "10%",
       title : "销售退货打印",
       height: "10%",
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
//    var row = leftGrid.getSelected();
//
//    var data = rightGrid.getData();
//    if(data && data.length<=0) return;
//
//    if (row) {
//
//        if(!row.id) return;
//
//		var auditSign = row.auditSign||0;
//
//        nui.open({
//
//            url : webPath + contextPath + "/com.hsweb.cloud.part.purchase.sellOrderRtnPrint.flow?ID="
//                    + row.id+"&printMan="+currUserName+"&auditSign="+auditSign,// "view_Guest.jsp",
//            title : "销售退货打印",
//            width : 900,
//            height : 600,
//            onload : function() {
//                var iframe = this.getIFrameEl();
//                // iframe.contentWindow.setInitData(storeId, 'XSD');
//            }
//        });
//    }
//
//}
function ontopTabChanged(e){
    var tab = e.tab;
    var name = tab.name;
    var url = tab.url;
    if(!url){
        if(name == "guestOrdrTab"){
            mainTabs.loadTab(webPath + contextPath + "/purchase/sellOrderRtn/pchsRtnOrderSettle_view0.jsp", tab);
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

    if(e.field == 'storeId'){
    	editor.setData(storehouse);
    }
    if(data.codeId && data.codeId>0){
        e.cancel = true;
    }
    if(advancedMorePartWin.visible) {
		e.cancel = true;
		morePartGrid.focus();
		var row = morePartGrid.getRow(0);   //默认不能选中，回车事件会有影响
        if(row){
            morePartGrid.select(row,true);
        }
        partIn=false;
	}

    if (field == "storeShelf") {
	    var value = e.record.storeId;
	    var value = e.record.storeId;
	    var editor = e.editor;
	    if(editor.type=='textbox'){
	    	return;
	    }
	    getLocationListByStoreId(value,function(data) {
			storeShelfList = data.locationList || [];
			nui.get('storeShelf').setData(storeShelfList);
			
	
		});
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
                    //rightGrid.beginEditCell(row, "comUnit");
                }
            }*/
            
        }else if(e.field == "remark"){
            //addNewKeyRow();
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
        }
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
function addInsertRow(value,row) {    
    var params = {partCode:value};
    var part = getPartInfo(params);
    var storeId = nui.get("storeId").getValue();

    if(part){
        params.partId = part.id;
        params.storeId = storeId;
        params.guestId = nui.get("guestId").getValue();//取客户最近销价
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
        }else{
            rightGrid.addRow(newRow);
        }
        rightGrid.beginEditCell(row, "orderQty");
    
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
var partInfoUrl = baseUrl
        + "com.hsapi.cloud.part.invoicing.paramcrud.queryPartInfoByParam.biz.ext";
function getPartInfo(params){
	if(currIsOpenApp==1){
		params.onlyOrgid =currOrgid;
	}
    var part = null;
    nui.ajax({
        url : partInfoUrl,
        type : "post",
        async: false,
        data : {
            params: params,
            token: token
        },
        success : function(data) {
            var partlist = data.partlist;
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
                rightGrid.removeRow(row);
                addNewRow(false);
            }

        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });

    return part;
}
function addSelectPart(){
    var row = morePartGrid.getSelected();
    if(row){
        var params = {partCode:row.code};
        params.partId = row.id;
        params.storeId = nui.get("storeId").getValue();
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
            storeId : nui.get("storeId").getValue(),
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

        advancedMorePartWin.hide();
        morePartGrid.setData([]);
    }else{
        showMsg("请选择配件!","W");
        return;
    }
}
function onPartClose(){
    advancedMorePartWin.hide();
    morePartGrid.setData([]);

    var newRow = {comPartCode: oldValue};
    rightGrid.updateRow(oldRow, newRow);
    rightGrid.beginEditCell(oldRow, "comPartCode");
}
function addMorePart(){
    var row = leftGrid.getSelected();
    if(row.auditSign == 1){
        showMsg("此单已审核!","W");
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
    partShow = 1;
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

            partObj.partCode = partTmpList[0].replace(/(^\s*)|(\s*$)/g, "");
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
                storeId : nui.get("storeId").getValue(),
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
var partPriceUrl = baseUrl
        + "com.hsapi.cloud.part.invoicing.pricemanage.getGuestRecentSellPrice.biz.ext";
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
                if(priceRecord.sellPrice){
                    price = priceRecord.sellPrice;
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
function selectPart(callback,checkcallback)
{
    nui.open({
        // targetWindow: window,
        url: webPath + contextPath + "/com.hsweb.cloud.part.common.orderBillChoose.flow?token="+token,
        title: "销售订单选择", width: 930, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var data = {
                orderTypeId: 2,
                guestId: nui.get("guestId").getValue()
            };
            iframe.contentWindow.setInitData(data,callback,checkcallback);
        },
        ondestroy: function (action)
        {
        }
    });
}
function addPart() {
    var row = leftGrid.getSelected();
    if(row){
        if(row.auditSign == 1) {
            return;
        } 
    }

    rightGrid.findRow(function(row){
        var partId = row.partId;
        var partCode = row.comPartCode;
        if(partId == null || partId == "" || partId == undefined || partCode == null || partCode == "" || partCode == undefined){
            rightGrid.removeRow(row);
        }
    });

    var guestId = nui.get("guestId").getValue();
    if(!guestId) {
        showMsg("请选择客户!","W");
        return;
    }

    var storeId = nui.get("storeId").getValue();
//    if(!storeId){
//    	showMsg("请选择仓库!","W");
//        return;
//    }
    
    selectPart(function(data) {
        addDetail(data);
    },function(data) {
        var part = data.part;
        var partid = part.id;
        //var rtn = checkPartIDExists(partid);
        return rtn;
    });
}
function checkPartIDExists(partid){
    var row = rightGrid.findRow(function(row){
        if(row.partId == partid) {
            return true;
        }
        return false;
    });
    
    if(row) 
    {
        return "配件编码："+row.comPartCode+"在销售退货列表中已经存在，是否继续？";
    }
    
    return null;
    
}
function addDetail(rows)
{
    //var iframe = this.getIFrameEl();
    //var data = iframe.contentWindow.getData();
	if(rows.length<0){
		return;
	}
	var storeId= rows[0].storeId;
	var settleTypeId = rows[0].settleTypeId;
	nui.get("storeId").setValue(storeId);
	nui.get("settleTypeId").setValue(settleTypeId);
	var mainId = 0;
    for(var i=0; i<rows.length; i++){
        var row = rows[i];
        var newRow = {
            partId : row.partId,
            comPartCode : row.comPartCode,
            comPartName : row.comPartName,
            comPartBrandId : row.comFullName,
            comApplyCarModel : row.comApplyCarModel,
            comUnit : row.comUnit,
            orderQty : row.orderQty,
            orderPrice : row.showPrice,
            orderAmt : row.showAmt,
            storeId : nui.get("storeId").getValue(),
            storeShelf : row.storeShelf,
            comOemCode : row.comOemCode,
            comSpec : row.comSpec,
            partCode : row.comPartCode,
            partName : row.comPartName,
            fullName : row.comFullName,
            systemUnitId : row.comUnit,
            enterUnitId : row.comUnit
        };


        rightGrid.addRow(newRow);
        mainId = row.mainId;
    }
    
    if(mainId) {
    	getPchsMain(mainId);
    }
}

var pchsMainUrl=baseUrl +"com.hsapi.cloud.part.invoicing.svr.getPjSellOrderMainChkById.biz.ext";
function getPchsMain(mainId){
  var params={};
  nui.ajax({
        url : pchsMainUrl,
        type : "post",
        async:false,
        data : JSON.stringify({
        	mainId : mainId,
            token : token
        }),
        success : function(text) {
            var main = text.main || {};
            if(main && main.orderMan) {
            	nui.get("orderMan").setValue(main.orderMan);
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
        }
    });
}

function getCangHash(data,detailData){
	getGuest(data.guestId);
	var cangHash ={};
	var dataList=[];
	var stockHash={};
	var partIdList ="";
	if(currAgencyId && currAgencyId>0){
		cangHash.agency_id= currAgencyId;
		cangHash.stock_id =data.id;
		cangHash.stock =data.serviceId;
		cangHash.stock_type_name ="销售退货订单";
		cangHash.stock_type_id =4;
		cangHash.stock_args ="";
		cangHash.direct ="in";
	}
	for(var i =0;i<detailData.length;i++){
		partIdList=partIdList+detailData[i].partId+",";
	}
	partIdList=partIdList.substring(0,partIdList.length-1);
	getPart(partIdList);
	for(var i =0;i<detailData.length;i++){
		var temp={};
		var warehouse=[];
		var warehousetemp={};
		var part_id=detailData[i].partId;
		/*2019.11.2不考虑cangPartId
		 * if(!partHash[part_id].cangPartId){
			showMsg("该配件未同步仓先生","W");
			return;
		}
		temp.part_id=partHash[part_id].cangPartId || "";
		if(!temp.part_id){
			showMsg("该配件未同步仓先生","W");
			return;
		}*/
		temp.detailId = detailData[i].id;
		warehousetemp.num =detailData[i].orderQty;
		if(storeHash && storeHash[detailData[i].storeId]){
			warehousetemp.wid =storeHash[detailData[i].storeId].cangStoreId || "";
		}
		if(storeShelfHash && storeShelfHash[detailData[i].storeId+"-"+detailData[i].storeShelf]){
			warehousetemp.cid =storeShelfHash[detailData[i].storeId+"-"+detailData[i].storeShelf].cangShelfId
		}else{
			warehousetemp.cid ="";
		}
		warehouse.push(warehousetemp);
		temp.warehouse =warehouse;
		dataList.push(temp);
	}
	stockHash.data= dataList;
	stockHash.company= company;
	stockHash.phone= phone;
	stockHash.addr= addr;
	stockHash.stock_create_time= format(new Date(), 'yyyy-MM-dd HH:mm:ss');
	cangHash.stock_args=JSON.stringify(stockHash);
	return cangHash;
}

var company="";
var phone ="";
var addr ="";
var supplierUrl=baseUrl +"com.hsapi.cloud.part.baseDataCrud.crud.queryGuestList.biz.ext";
function getGuest(guestId){
	$.ajaxSettings.async = false;
	$.post(supplierUrl+"?params/guestId="+guestId+"&token="+token,{},function(text){
		var guest=text.guest[0];
		company =guest.fullName || "";
		phone =guest.mobile ||"";
		addr =guest.addr || "";
	});
}
var storeLoactionUrl=baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.queryStoreLocation.biz.ext";
function getStoreLocation(){
	$.ajaxSettings.async = false;
	$.post(storeLoactionUrl+"?orgid="+currOrgid+"&token="+token,{},function(text){
		var locations=text.locations;
		locations.forEach(function(v){
			storeShelfHash[v.storeId+"-"+v.name]=v;			
		});
	});
}

var partUrl=baseUrl +"com.hsapi.cloud.part.baseDataCrud.crud.queryPartListByOrgid.biz.ext";
function getPart(partIdList){
//	$.ajaxSettings.async = false;
//	$.post(partUrl+"?params/orgid="+currOrgid+"&params/noPage="+1+"&token="+token,{},function(text){
//		var parts=text.parts;
//		parts.forEach(function(v){
//			partHash[v.id]=v;			
//		});
//	});
	var params={};
	var page ={};
	page.length =1000;
  params.partIdList =partIdList;
  params.orgid = currOrgid;
  nui.ajax({
        url : partUrl,
        type : "post",
        async:false,
        data : JSON.stringify({
        	params : params,
        	page  : page,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
            	var parts=data.parts;
        		parts.forEach(function(v){
        			partHash[v.id]=v;			
        		});
            } else {
            	 nui.unmask(document.body);
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
//  return partHash;
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
    
    //开启APP，处理仓位
    if(currIsOpenApp ==1){
    	var shelfObj={};
    	var editor={};
    	var flag=null;
    	for(var i=0;i<columnsObjList.length;i++){
 	    	if(columnsObjList[i].field=="storeShelf"){
 	    		shelfObj=columnsObjList[i];
 	    		editor=shelfObj.editor;
 	    		flag =i;
 	    		break;
 	    	}
 	    }
    	editor.cls="nui-combobox";
    	editor.data="storeShelfList";
    	editor.dataField="storeShelfList";
    	editor.enabled=true;
    	editor.id ="storeShelf";
    	editor.name="storeShelf";
    	editor.textField="name";
    	editor.type="combobox";
    	editor.valueField="name";
    	columnsObjList[flag].editor=editor;
    	
    }
    
    rightGrid.set({
        columns: columnsList
    });
}

function onLeftGridBeforeDeselect(e)
{
    var row = leftGrid.getSelected(); 
    if(row.serviceId == '新销售退货'){

        leftGrid.removeRow(row);
    }
}

function chooseMember(){
	  //销售单
	  var serviceType=2;
	  var row = leftGrid.getSelected();
	    if(row){
	    	if(row.auditSign ==1){
	    		showMsg("单据已审核,不能修改");
	    		return;
	    	}
	        if(row.id) {
	            nui.open({
	                // targetWindow: window,
	                url: webBaseUrl+"com.hsweb.cloud.part.basic.selectMember.flow?token="+token,
	                title: "选择提成成员", 
	                width: 880, height: 650,
	                showHeader:true,
	                allowDrag:true,
	                allowResize:true,
	                onload: function ()
	                {
	                    var iframe = this.getIFrameEl();
	                    iframe.contentWindow.setData(row.id,serviceType);
	                },
	                ondestroy: function (action)
	                {

	                }
	            });
	        }else{
	            showMsg("请先选择订单!","W");
	            return;
	        }
	    }else{
	        return;
	    }
}

