/**
 * Created by Administrator on 2018/2/23.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var leftGridUrl = baseUrl
        + "com.hsapi.cloud.part.invoicing.svr.queryPjPchsOrderMainList.biz.ext";
var rightGridUrl = baseUrl
        + "com.hsapi.cloud.part.invoicing.svr.queryPjPchsOrderDetailList.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var basicInfoForm = null;
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
var dataList = null;
var FStoreId = null;
var isNeedSet = false;
var oldValue = null;
var oldRow = null;

$(document).ready(function(v) {
    leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);

    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    advancedSearchWin = nui.get("advancedSearchWin");

    advancedSearchForm = new nui.Form("#advancedSearchForm");
    basicInfoForm = new nui.Form("#basicInfoForm");


    gsparams.startDate = getNowStartDate();
    gsparams.endDate = addDate(getNowEndDate(), 1);

    sOrderDate = nui.get("sOrderDate");
    eOrderDate = nui.get("eOrderDate");

    document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;
        if((keyCode==83)&&(event.altKey))  {   //保存
            save();
        } 
      
        if((keyCode==80)&&(event.altKey))  {   //打印
            onPrint();
        } 
     
    }

    $("partTempId").focus(function(){
        $("orderMan").css("background-color","#FFFFCC");
        addNewRow(true);
    });

    var dictDefs ={"billTypeId":"DDT20130703000008", "settleTypeId":"DDT20130703000035"};
    initDicts(dictDefs, null);
    getStorehouse(function(data) {
        storehouse = data.storehouse || [];
        if(storehouse && storehouse.length>0){
            FStoreId = storehouse[0].id;
        }else{
            isNeedSet = true;
        }
        
    });

    getAllPartBrand(function(data) {
        brandList = data.brand;
        brandList.forEach(function(v) {
            brandHash[v.id] = v;
        });
    });

    gsparams.billStatusId = 2;
    gsparams.auditSign = 1;
    quickSearch(0);
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

        if(row.billStatusId && row.billStatusId == 2){
            nui.get("auditToEnterBtn").enable();
        }else{
            nui.get("auditToEnterBtn").disable();
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
    }); 
}
function onLeftGridDrawCell(e) {
    switch (e.field) {
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
    case 13:
        querystatusname = "部分入库";
        gsparams.billStatusId = 3;
        gsparams.auditSign = 1;
        querysign = 3;
        break;
    case 14:
        querystatusname = "全部入库";
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
        nui.get("selectSupplierBtn").enable();
        //nui.get("auditBtn").enable();
        //nui.get("printBtn").enable();
    } else {
        nui.get("saveBtn").disable();
        nui.get("selectSupplierBtn").disable();
        //nui.get("auditBtn").disable();
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
    searchData.billStatusId = gsparams.billStatusId;
  //去除空格
    for(var key in searchData){
    	if(searchData[key]!=null && searchData[key]!="" && typeof(searchData[key])=='string'){    		
    		searchData[key]=searchData[key].replace(/\s+/g, "");
    	}
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
function getMainData() {
    var data = basicInfoForm.getData();
    // 汇总明细数据到主表
    data.isFinished = 0;
    data.auditSign = 0;
    data.billStatusId = 0;
    data.printTimes = 0;
    data.orderTypeId = 1;

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
        // targetWindow: window,,
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
                        '<span class="fa fa-plus" onClick="" title="添加行">&nbsp;&nbsp;</span>' +
                        ' <span class="fa fa-close" onClick="" title="删除行"></span>';
            break;
    default:
        break;
    }
}
function checkRightData() {
    var msg = '';
    var rows = rightGrid.findRows(function(row) {
        if (row.orderQty) {
            if (row.orderQty <= 0)
                return true;
        } else {
            return true;
        }
        if (row.orderPrice) {
            if (row.orderPrice <= 0)
                return true;
        } else {
            return true;
        }
        if (row.orderAmt) {
            if (row.orderAmt <= 0)
                return true;
        } else {
            return true;
        }

        if (row.storeId) {
        } else {
            return true;
        }
    });

    if (rows && rows.length > 0) {
        msg = "请完善采购配件的数量，单价，金额，仓库等信息！";
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
    if(isInner == 0 && billStatusId == 0){
        var flagSign = 1; 
        var flagStr = "入库中...";
        var flagRtn = "入库成功!";
        auditOrder(flagSign, flagStr, flagRtn);     
    }else if(billStatusId == 2){
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
                            loadMainAndDetailInfo(leftRow);

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
var enterUrl = baseUrl
        + "com.hsapi.cloud.part.invoicing.ordersettle.generatePchsOrderToEnter.biz.ext";
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
				url: webPath+contextPath+"/com.hsweb.cloud.part.basic.supplierDetail.flow?token=" + token,
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

        var orderTypeId = row.orderTypeId;
        if(orderTypeId == 1){
            nui.open({

                url : webPath + contextPath + "/com.hsweb.cloud.part.purchase.pchsOrderEnterPrint.flow?ID="
                        + row.id+"&printMan="+currUserName,// "view_Guest.jsp",
                title : "进货单打印",
                width : 900,
                height : 600,
                onload : function() {
                    var iframe = this.getIFrameEl();
                    // iframe.contentWindow.setInitData(storeId, 'XSD');
                }
            });
        }else if(orderTypeId == 4){
            nui.open({

                url : webPath + contextPath + "/com.hsweb.cloud.part.purchase.sellOrderRtnPrint.flow?ID="
                        + row.id+"&printMan="+currUserName,// "view_Guest.jsp",
                title : "销售退货打印",
                width : 900,
                height : 600,
                onload : function() {
                    var iframe = this.getIFrameEl();
                    // iframe.contentWindow.setInitData(storeId, 'XSD');
                }
            });
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