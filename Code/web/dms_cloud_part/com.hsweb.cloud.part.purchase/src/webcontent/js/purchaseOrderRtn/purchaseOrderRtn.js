/**
 * Created by Administrator on 2018/2/23.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var leftGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjSellOrderMainList.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjSellOrderDetailList.biz.ext";
var advancedSearchWin = null;
var advancedMorePartWin = null;
var advancedAddWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var basicInfoForm = null;
var bottomInfoForm = null;
var bottomInfoForm = null;
var advancedAddForm = null;
var leftGrid = null;
var rightGrid = null;
var formJson = null;
var brandHash = {};
var brandList = [];
var storehouse = null;
var morePartGrid = null;
var gsparams = {};
var sOrderDate = null;
var eOrderDate = null;
var dataList = null;
var FStoreId = null;
var isNeedSet = false;
var oldValue = null;
var oldRow = null;

var AuditSignHash = {
  "0":"草稿",
  "1":"已提交"
};
$(document).ready(function(v)
{
    leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);

    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    basicInfoForm = new nui.Form("#basicInfoForm");
    advancedMorePartWin = nui.get("advancedMorePartWin");
    advancedAddWin = nui.get("advancedAddWin");
    morePartGrid = nui.get("morePartGrid");

    gsparams.startDate = getNowStartDate();
    gsparams.endDate = addDate(getNowEndDate(), 1);
    gsparams.isOut = 0;

    sOrderDate = nui.get("sOrderDate");
    eOrderDate = nui.get("eOrderDate");

    var dictDefs ={"rtnReasonId":"DDT20130703000072", "settleTypeId":"DDT20130703000035"};
    initDicts(dictDefs, null);
    getStorehouse(function(data)
    {
        storehouse = data.storehouse||[];
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

    gsparams.auditSign = 0;
    quickSearch(0);

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
});
//返回类型给srvBottom，用于srvBottom初始化
function confirmType(){
    return "pcshRtn";
}
function getParentStoreId(){
    return FStoreId;
}
function loadMainAndDetailInfo(row)
{
    if(row) {    
       basicInfoForm.setData(row);
       //bottomInfoForm.setData(row);
       nui.get("guestId").setText(row.guestFullName);

       var row = leftGrid.getSelected();
       if(row.auditSign == 1) {
            setBtnable(false);
            document.getElementById("basicInfoForm").disabled=true;
            setEditable(false);
       }else {
            setBtnable(true);
            document.getElementById("basicInfoForm").disabled=false;
            setEditable(true);
       }
        
       //序列化入库主表信息，保存时判断主表信息有没有修改，没有修改则不需要保存
       formJson = nui.encode(basicInfoForm.getData());

       //加载销售订单明细表信息
       var mainId = row.id;
        if(!mainId){
            mainId = -1;
        }
       loadRightGridData(mainId);
   }else {
        //form.reset();
        //grid_details.clearRows();
   }
}
function onLeftGridSelectionChanged(){    
   var row = leftGrid.getSelected(); 
   
   loadMainAndDetailInfo(row);
} 
function loadRightGridData(mainId)
{
    editPartHash={};
    var params = {};
    params.mainId = mainId;
    rightGrid.load({
        params:params,
        token:token
    },function(){

        var data = rightGrid.getData();
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
function onLeftGridDrawCell(e)
{
    var record = e.record;
    switch (e.field){
        case "auditSign":
            if(AuditSignHash && AuditSignHash[e.value])
            {
                e.cellHtml = AuditSignHash[e.value];
            }
            break;
        case "guestFullName":
            if(e.value){
                if(record.auditSign == 0)
                {
                    e.cellHtml = "<span class='fa fa-save'></span>"+(e.value||"");
                }else{
                    if(record.isRtnSign == 1)
                    {
                        e.cellHtml = "<span class='fa fa-hand-o-right'></span>"+(e.value||"");
                    }else if(record.isRtnSign == 0)
                    {
                        e.cellHtml = "<span class='fa fa-spinner fa-spin'></span>"+(e.value||"");
                    }
                }
                if(record.billStatusId==2){
                    e.cellHtml = "<span class='fa fa-check'></span>"+(e.value||"");
                }
            }
            break;
    }
}
var currType = 2;
function quickSearch(type){
    var params = {};
    var querysign = 1;
    var queryname = "本日";
    var querytypename = "草稿";
    switch (type)
    {
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
            params.isOut = 0;
            querytypename = "草稿";
            querysign = 2;
            gsparams.auditSign = 0;
            break;
        case 7:
            params.isOut = 1;
            querytypename = "已提交";
            querysign = 2;
            gsparams.auditSign = 1;
            break;
        case 8:
            params.postStatus = 1;
            break;
        default:
            params.today = 1;
            params.startDate = getNowStartDate();
            params.endDate = addDate(getNowEndDate(), 1);
            querytypename = "草稿";
            gsparams.startDate = getNowStartDate();
            gsparams.endDate = addDate(getNowEndDate(), 1);
            gsparams.auditSign = 0;
            break;
    }
    currType = type;
    if(querysign == 1){
        var menunamedate = nui.get("menunamedate");
        menunamedate.setText(queryname);
    }else if(querysign == 2){
            var menunametype = nui.get("menunametype");
            menunametype.setText(querytypename);
    }
    doSearch(gsparams);
}
function onSearch(){
    search();
}
function search()
{
    var param = getSearchParam();
    doSearch(param);
}
function getSearchParam(){
    var params = {};
    params = gsparams;
    params.guestId = nui.get("searchGuestId").getValue();
    return params;
}
function setBtnable(flag)
{
    if(flag)
    {
        nui.get("unAuditBtn").disable();
        nui.get("auditBtn").enable();
        nui.get("saveBtn").enable();
        nui.get("auditToOutBtn").disable();
        //nui.get("printBtn").enable();
    }
    else
    {
        nui.get("unAuditBtn").enable();
        nui.get("auditBtn").disable();
        nui.get("auditToOutBtn").enable();
        nui.get("saveBtn").disable();
    }
}
var requiredField = {
    guestId : "供应商",
    orderMan : "退货员",
    createDate : "退货日期",
    rtnReasonId : "退货原因",
    settleTypeId : "结算方式"
};
var saveUrl = baseUrl + "com.hsapi.cloud.part.invoicing.crud.savePjSellOrder.biz.ext";
function save() {
    var data = basicInfoForm.getData();
    for ( var key in requiredField) {
        if (!data[key] || $.trim(data[key]).length == 0) {
            nui.alert(requiredField[key] + "不能为空!");
            return;
        }
    }

    var row = leftGrid.getSelected();
    if(row){
        if(row.auditSign == 1) {
            nui.alert("此单已提交!");
            return;
        } 
    }else{
        return;
    }
    

    data = getMainData();

    var sellOrderDetailAdd = rightGrid.getChanges("added");
    var sellOrderDetailUpdate = rightGrid.getChanges("modified");
    var sellOrderDetailDelete = rightGrid.getChanges("removed");
    var sellOrderDetailList = rightGrid.getData();
    sellOrderDetailList = removeChanges(sellOrderDetailAdd, sellOrderDetailUpdate, sellOrderDetailDelete, sellOrderDetailList);

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });

    nui.ajax({
        url : saveUrl,
        type : "post",
        data : JSON.stringify({
            sellOrderMain : data,
            sellOrderDetailAdd : sellOrderDetailAdd,
            sellOrderDetailUpdate : sellOrderDetailUpdate,
            sellOrderDetailDelete : sellOrderDetailDelete,
            sellOrderDetailList : sellOrderDetailList,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                nui.alert("保存成功!","",function(e){
                });
                //onLeftGridRowDblClick({});
                var pjSellOrderMainList = data.pjSellOrderMainList;
                if(pjSellOrderMainList && pjSellOrderMainList.length>0) {
                    var leftRow = pjSellOrderMainList[0];
                    var row = leftGrid.getSelected();
                    leftGrid.updateRow(row,leftRow);

                    //保存成功后重新加载数据
                    loadMainAndDetailInfo(leftRow);

                    
                }
            } else {
                nui.alert(data.errMsg || "保存失败!");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function removeChanges(added, modified, removed, all) {
    for(var i=0; i<added.length; i++) {
    
       var val = added[i];
       for(var j=0; j<all.length; j++) {
        
           if(all[j] == val)
           all.splice(j, 1);
        }
    }
    
    for(var i=0; i<modified.length; i++) {
    
       var val = modified[i];
       for(var j=0; j<all.length; j++) {
        
           if(all[j] == val)
           all.splice(j, 1);
        }
    }
    
    for(var i=0; i<removed.length; i++) {
    
       var val = removed[i];
       for(var j=0; j<all.length; j++) {
        
           if(all[j] == val)
           all.splice(j, 1);
        }
    }

    return all;
}
function getMainData()
{
    var data = basicInfoForm.getData();
    //汇总明细数据到主表
    data.isFinished = 0;
    data.auditSign = 0;
    data.billStatusId = '';
    data.printTimes = 0;
    data.orderTypeId = 3;

    if(data.operateDate) {
        data.operateDate = format(data.operateDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
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
function setEditable(flag)
{
    if(flag)
    {
        document.getElementById("fd1").disabled = false;
    }
    else
    {
        document.getElementById("fd1").disabled = true;
    }
}
function doSearch(params) 
{
    //目前没有区域销售订单，采退受理  params.enterTypeId = '050101';
    params.orderTypeId = 3;
    leftGrid.load({
        params : params,
        token : token
    }, function() {
        //onLeftGridRowDblClick({});
        var data = leftGrid.getData().length;
        if(data <= 0){
            basicInfoForm.reset();
            rightGrid.clearRows();
            
            setBtnable(false);
            setEditable(false);
            
        }else {
            var row = leftGrid.getSelected();
            if(row.auditSign == 1) {
                setBtnable(false);
                setEditable(false);
                document.getElementById("basicInfoForm").disabled=true;
            }else {
                setBtnable(true);
                setEditable(true);
                document.getElementById("basicInfoForm").disabled=false;
            }
        }
    });
}
function advancedSearch()
{
    advancedSearchWin.show();
//    advancedSearchForm.clear();
    if(advancedSearchFormData)
    {
        advancedSearchForm.setData(advancedSearchFormData);
    }else{
        sOrderDate.setValue(getWeekStartDate());
        eOrderDate.setValue(addDate(getWeekEndDate(), 1));
    }
}
function onAdvancedSearchOk()
{
    var searchData = advancedSearchForm.getData();
    var i;
    //订货日期
    if(searchData.sOrderDate)
    {
        searchData.sCreateDate = searchData.sCreateDate.substr(0,10);
    }
    if(searchData.eOrderDate)
    {
        var date = searchData.eCreateDate;
        searchData.eCreateDate = addDate(date, 1);
        searchData.eCreateDate = searchData.eCreateDate.substr(0,10);
    }
    //创建日期
    if(searchData.sCreateDate)
    {
        searchData.sCreateDate = searchData.sCreateDate.substr(0,10);
    }
    if(searchData.eCreateDate)
    {
        var date = searchData.eCreateDate;
        searchData.eCreateDate = addDate(date, 1);
        searchData.eCreateDate = searchData.eCreateDate.substr(0,10);
    }
    //审核日期
    if(searchData.sAuditDate)
    {
        searchData.sAuditDate = searchData.sAuditDate.substr(0,10);
    }
    if(searchData.eAuditDate)
    {
        var date = searchData.eAuditDate;
        searchData.eAuditDate = addDate(date, 1);
        searchData.eAuditDate = searchData.eAuditDate.substr(0,10);
    }
    //供应商
    if(searchData.guestId)
    {
        params.guestId = nui.get("guestId").getValue();
    }
    //订单单号
    if(searchData.serviceIdList)
    {
        var tmpList = searchData.serviceIdList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i]+"'";
        }
        searchData.serviceIdList = tmpList.join(",");
    }
    //配件编码
    if(searchData.partCodeList)
    {
        var tmpList = searchData.partCodeList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i]+"'";
        }
        searchData.partCodeList = tmpList.join(",");
    }
    searchData.auditSign = gsparams.auditSign;
    advancedSearchFormData = advancedSearchForm.getData();
    advancedSearchWin.hide();
    doSearch(searchData);
}
function onAdvancedSearchCancel()
{
//    advancedSearchForm.clear();
    advancedSearchWin.hide();
}
function checkNew() 
{
    var rows = leftGrid.findRows(function(row){
        if(row.serviceId == "新采购退货") return true;
    });
    
    return rows.length;
}
function onRightGridDraw(e)
{
    switch (e.field)
    {
        case "comPartBrandId":
            if(brandHash[e.value])
            {
                e.cellHtml = brandHash[e.value].name||"";
            }
            else{
                e.cellHtml = "";
            }
            break;
        case "stockOutQty":
            if(e.value > 0)
            {
                e.cellHtml = '<a style="color:red;">' + e.value + '</a>';
            }
            break;
        case "operateBtn":
            e.cellHtml = //'<span class="icon-remove" onClick="javascript:deletePart()" title="删除行">&nbsp;&nbsp;&nbsp;&nbsp;</span>';/*'<span class="icon-add" onClick="javascript:addPart()" title="添加行">&nbsp;&nbsp;&nbsp;&nbsp;</span>' +
                        '<span class="fa fa-plus" onClick="javascript:addNewRow(true)" title="添加行">&nbsp;&nbsp;</span>' +
                        ' <span class="fa fa-close" onClick="javascript:deletePart()" title="删除行"></span>';
            break;
        default:
            break;
    }
}

var auditUrl = baseUrl+"com.hsapi.cloud.part.invoicing.crud.auditPjSellOrder.biz.ext";
function audit()
{
    var data = basicInfoForm.getData();
    for ( var key in requiredField) {
        if (!data[key] || $.trim(data[key]).length == 0) {
            nui.alert(requiredField[key] + "不能为空!");
            return;
        }
    }

    var row = leftGrid.getSelected();
    if(row){
        if(row.auditSign == 1) {
            nui.alert("此单已提交!");
            return;
        } 
    }else{
        return;
    }

    //审核时，数量，单价，金额，仓库不能为空
    var msg = checkStockOutQty();
    if(msg){
        nui.alert(msg);
        return;
    }
    //审核时，判断是否存在缺货信息
    var msg = checkRightData();
    if(msg){
        nui.alert(msg);
        return;
    }

    data = getMainData();

    var sellOrderDetailAdd = rightGrid.getChanges("added");
    var sellOrderDetailUpdate = rightGrid.getChanges("modified");
    var sellOrderDetailDelete = rightGrid.getChanges("removed");
    var sellOrderDetailList = rightGrid.getData();
    if(sellOrderDetailList.length <= 0) {
        nui.alert("销售明细为空，不能提交！");
        return;
    }
    sellOrderDetailList = removeChanges(sellOrderDetailAdd, sellOrderDetailUpdate, sellOrderDetailDelete, sellOrderDetailList);


    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '提交中...'
    });

    nui.ajax({
        url : auditUrl,
        type : "post",
        data : JSON.stringify({
            sellOrderMain : data,
            sellOrderDetailAdd : sellOrderDetailAdd,
            sellOrderDetailUpdate : sellOrderDetailUpdate,
            sellOrderDetailDelete : sellOrderDetailDelete,
            sellOrderDetailList : sellOrderDetailList,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                nui.alert("提交成功!");
                //onLeftGridRowDblClick({});
                var pjSellOrderMainList = data.pjSellOrderMainList;
                if(pjSellOrderMainList && pjSellOrderMainList.length>0) {
                    var leftRow = pjSellOrderMainList[0];
                    var row = leftGrid.getSelected();
                    leftGrid.updateRow(row,leftRow);

                    //保存成功后重新加载数据
                    loadMainAndDetailInfo(leftRow);
                }
            } else {
                nui.alert(data.errMsg || "提交失败!");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
var auditToOutUrl = baseUrl+"com.hsapi.cloud.part.invoicing.crud.auditSellOrderToOut.biz.ext";
function auditToOut()
{

    var row = leftGrid.getSelected();
    if(row){
        if(row.isOut == 1) {
            nui.alert("此单已出库!");
            return;
        } 
    }else{
        return;
    }

    if(row.auditSign != 1) {
        nui.alert("请先提交，再出库!");
        return;
    } 

    var isRtnSign = row.isRtnSign;
    if(isRtnSign == 0){
        nui.alert("待供应商受理后才可出库!");
        return;
    }

    var data = basicInfoForm.getData();
    var mainId = data.id;

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '处理中...'
    });

    nui.ajax({
        url : auditToOutUrl,
        type : "post",
        data : JSON.stringify({
            mainId : mainId,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                nui.alert("出库成功!","",function(){
                    var newRow = {isOut: 1};
                    leftGrid.updateRow(row, newRow);

                    setBtnable(false);
                });
                
            } else {
                nui.alert(data.errMsg || "出库失败!");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function onPrint() {
    var row = leftGrid.getSelected();
    if (row) {

        nui.open({

            url : "com.hsweb.cloud.part.purchase.sellOrderPrint.flow?ID="
                    + row.id,// "view_Guest.jsp",
            title : "采购退货打印",
            width : 900,
            height : 600,
            onload : function() {
                var iframe = this.getIFrameEl();
                // iframe.contentWindow.setInitData(storeId, 'XSD');
            }
        });
    }

}
function add()
{
    if(isNeedSet){
        nui.alert("请先到仓库定义功能设置仓库!");
        return;
    }

    if(checkNew() > 0) 
    {
        nui.alert("请先保存数据！");
        return;
    }

    var formJsonThis = nui.encode(basicInfoForm.getData());
    var len = rightGrid.getData().length;

    if(formJson != formJsonThis && len > 0)
    {
        nui.confirm("您正在编辑数据,是否要继续?", "友情提示",
            function (action) { 
                if (action == "ok") {

                    setBtnable(true);
                    setEditable(true);

                    nui.get("guestId").enable();

                    basicInfoForm.reset();
                    rightGrid.clearRows();
                    
                    var newRow = { serviceId: '新采退退货', auditSign: 0};
                    leftGrid.addRow(newRow, 0);
                    leftGrid.clearSelect(false);
                    leftGrid.select(newRow, false);
                    
                    nui.get("serviceId").setValue("新采购退货");
                    nui.get("billTypeId").setValue("010103");  //010101  收据   010102  普票  010103  增票
                    nui.get("createDate").setValue(new Date());
                    nui.get("orderMan").setValue(currUserName);
                    
                    addNewRow();

                    var guestId = nui.get("guestId");
                    guestId.focus();

                }else {
                    return;
                }
            }
        );
    }else{
        setBtnable(true);
        setEditable(true);

        nui.get("guestId").enable();

        basicInfoForm.reset();
        rightGrid.clearRows();
        
        var newRow = { serviceId: '新采购退货', auditSign: 0};
        leftGrid.addRow(newRow, 0);
        leftGrid.clearSelect(false);
        leftGrid.select(newRow, false);
        
        nui.get("serviceId").setValue("新采购退货");
        nui.get("billTypeId").setValue("010103");  //010101  收据   010102  普票  010103  增票
        nui.get("createDate").setValue(new Date());
        nui.get("orderMan").setValue(currUserName);

        addNewRow();
        
        var guestId = nui.get("guestId");
        guestId.focus();
    }

    
}
//提交单元格编辑数据前激发
function onCellCommitEdit(e) {
    var editor = e.editor;
    var record = e.record;
    var row = e.row;
    
    editor.validate();
    if (editor.isValid() == false) {
        nui.alert("请输入数字！");
        e.cancel = true;
    }else {
        var newRow = {};
        if (e.field == "orderQty") {
            var orderQty = e.value;
            var orderPrice = record.orderPrice;
            
            if(e.value==null || e.value=='') {
                e.value = 0;
                orderQty = 0;
            }else if(e.value < 0) {
                e.value = 0;
                orderQty = 0;
            }
            
            var orderAmt = orderQty * orderPrice;                  
                                
            newRow = { orderAmt: orderAmt};
            rightGrid.updateRow(e.row, newRow);
            
            //record.enteramt.cellHtml = enterqty * enterprice;
        }else if (e.field == "orderPrice") {
            var orderQty = record.orderQty;
            var orderPrice = e.value;
            
            if(e.value==null || e.value=='') {
                e.value = 0;
                orderPrice = 0;
            }else if(e.value < 0) {
                e.value = 0;
                orderPrice = 0;
            }
            
            var orderAmt = orderQty * orderPrice; 
                           
            newRow = { orderAmt: orderAmt};
            rightGrid.updateRow(e.row, newRow);

            if(orderPrice){
                rightGrid.commitEditRow(row);
            }
            
        }else if (e.field == "orderAmt") {
            var orderQty = record.orderQty;
            var orderAmt = e.value;
            
            if(e.value==null || e.value=='') {
                e.value = 0;
                orderAmt = 0;
            }else if(e.value < 0) {
                e.value = 0;
                orderAmt = 0;
            }
            
            //e.cellHtml = enterqty * enterprice;
            var orderPrice = orderAmt*1.0/orderQty;

            if(orderQty) {
                newRow = { orderPrice: orderPrice};
                rightGrid.updateRow(e.row, newRow);
            }
            
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
                nui.alert("请输入编码!","提示",function(){
                    var row = rightGrid.getSelected();
                    rightGrid.removeRow(row);
                    addNewRow(false);
                });
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
var auditUrl = baseUrl+"com.hsapi.cloud.part.invoicing.crud.auditPjSellOrder.biz.ext";
function audit()
{
    var data = basicInfoForm.getData();
    for ( var key in requiredField) {
        if (!data[key] || $.trim(data[key]).length == 0) {
            nui.alert(requiredField[key] + "不能为空!");
            return;
        }
    }

    var row = leftGrid.getSelected();
    if(row){
        if(row.auditSign == 1) {
            nui.alert("此单已提交!");
            return;
        } 
    }else{
        return;
    }

    //审核时，数量，单价，金额，仓库不能为空
    var msg = checkStockOutQty();
    if(msg){
        nui.alert(msg);
        return;
    }
    //审核时，判断是否存在缺货信息
    var msg = checkRightData();
    if(msg){
        nui.alert(msg);
        return;
    }

    data = getMainData();

    var sellOrderDetailAdd = rightGrid.getChanges("added");
    var sellOrderDetailUpdate = rightGrid.getChanges("modified");
    var sellOrderDetailDelete = rightGrid.getChanges("removed");
    var sellOrderDetailList = rightGrid.getData();
    if(sellOrderDetailList.length <= 0) {
        nui.alert("退货明细为空，不能提交！");
        return;
    }
    sellOrderDetailList = removeChanges(sellOrderDetailAdd, sellOrderDetailUpdate, sellOrderDetailDelete, sellOrderDetailList);


    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '提交中...'
    });

    nui.ajax({
        url : auditUrl,
        type : "post",
        data : JSON.stringify({
            sellOrderMain : data,
            sellOrderDetailAdd : sellOrderDetailAdd,
            sellOrderDetailUpdate : sellOrderDetailUpdate,
            sellOrderDetailDelete : sellOrderDetailDelete,
            sellOrderDetailList : sellOrderDetailList,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                nui.alert("提交成功!","",function(){
                    var pjSellOrderMainList = data.pjSellOrderMainList;
                    if(pjSellOrderMainList && pjSellOrderMainList.length>0) {
                        var leftRow = pjSellOrderMainList[0];
                        var row = leftGrid.getSelected();
                        leftGrid.updateRow(row,leftRow);

                        //保存成功后重新加载数据
                        loadMainAndDetailInfo(leftRow);
                    }
                });
                //onLeftGridRowDblClick({});
                
            } else {
                nui.alert(data.errMsg || "提交失败!");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function addNewRow(check){
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
var partInfoUrl = baseUrl
        + "com.hsapi.cloud.part.invoicing.paramcrud.queryPartInfoByParam.biz.ext";
function getPartInfo(params){
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
                }
                
            }else{
                //清空行数据
                nui.alert("没有搜索到配件信息!","提示",function(){
                    var row = rightGrid.getSelected();
                    rightGrid.removeRow(row);
                    addNewRow(false);
                });
            }

        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });

    return part;
}
var partPriceUrl = baseUrl
        + "com.hsapi.cloud.part.invoicing.pricemanage.getSellDefaultPrice.biz.ext";
function getPartPrice(params){
    var price = 0;
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
            }

        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });

    return price;
}
function addInsertRow(value, row) {    
    var guestId = nui.get("guestId").getValue();
    if(!guestId) {
        nui.alert("请先选择供应商再添加配件!");
        return;
    }
    var params = {partCode:value};
    var part = getPartInfo(params);
    if(part){
        params.partId = part.id;
        params.guestId = guestId;
        var price = getPartPrice(params);
        var newRow = {
            partId : part.id,
            comPartCode : part.code,
            comPartName : part.name,
            comPartBrandId : part.partBrandId,
            comApplyCarModel : part.applyCarModel,
            comUnit : part.unit,
            orderQty : 1,
            storeId : FStoreId,
            comOemCode : part.oemCode,
            comSpec : part.spec,
            partCode : part.code,
            partName : part.name,
            fullName : part.fullName,
            systemUnitId : part.unit,
            outUnitId : part.unit
        };

        if(row){
            rightGrid.updateRow(row,newRow);
            //rightGrid.beginEditCell(row, "enterQty");
            rightGrid.beginEditCell(row, "comUnit");
        }else{
            rightGrid.addRow(newRow);
            //rightGrid.beginEditCell(newRow, "enterQty");
            rightGrid.beginEditCell(row, "comUnit");
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
var editPartHash = {
};
function deletePart(){
    var row = leftGrid.getSelected();
    if(row){
        if(row.auditSign == 1) {
            return;
        } 
    }

    if(row.codeId && data.codeId>0) return;

    var part = rightGrid.getSelected();
    if(!part)
    {
        return;
    }
    if(part.detailId && editPartHash[part.detailId])
    {
        delete editPartHash[part.detailId];
    }
    rightGrid.removeRow(part,true);
}
function checkRightData()
{
    var msg = '';
    var rows = rightGrid.findRows(function(row){
        if(row.partId){
            if(row.orderQty){
                if(row.orderQty <= 0) return true;
            }else{
                return true;
            }
            if(row.orderPrice){
                if(row.orderPrice <= 0) return true;
            }else{
                return true;
            }
            if(row.orderAmt){
                if(row.orderAmt <= 0) return true;
            }else{
                return true;
            }
            
            if(row.storeId){
            }else{
                return true;
            }         
        }

    });
    
    if(rows && rows.length > 0){
        msg = "请完善退货配件的数量，单价，金额，仓库等信息！";
    }
    return msg;
}
function checkStockOutQty(){
    var msg = '';
    var rows = rightGrid.findRows(function(row){
        if(row.stockOutQty > 0){
            return true;
        }
    });
    
    if(rows && rows.length > 0){
        var comPartCode = rows[0].comPartCode;
        msg = "配件：" + comPartCode + "缺货，不能提交！";
    }
    return msg;
}
function onGuestValueChanged(e)
{
    //供应商中直接输入名称加载供应商信息
    var params = {};
    params.pny = e.value;
    params.isSupplier = 1;
    setGuestInfo(params);
}
var getGuestInfo = baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.querySupplierList.biz.ext";
function setGuestInfo(params)
{
    nui.ajax({
        url:getGuestInfo,
        data: {params: params, token: token},
        type:"post",
        success:function(text)
        {
            if(text)
            {
                var supplier = text.suppliers;
                if(supplier && supplier.length>0) {
                    var data = supplier[0];
                    var value = data.id;
                    var text = data.fullName;

                    var el = nui.get('guestId');
                    el.setValue(value);
                    el.setText(text);

                    var row = leftGrid.getSelected();
                    var newRow = {guestFullName: text};
                    leftGrid.updateRow(row,newRow);

                    var billTypeIdV = data.billTypeId;
                    var settTypeIdV = data.settTypeId;

                    nui.get("billTypeId").setValue(billTypeIdV);
                    nui.get("settleTypeId").setValue(settTypeIdV);
                    //nui.get("isNeedPack").setValue(data.isNeedPack);

                }
                else
                {
                    var el = nui.get('guestId');
                    el.setValue(null);
                    el.setText(null);

                    var row = leftGrid.getSelected();
                    var newRow = {guestFullName: null};
                    leftGrid.updateRow(row,newRow);
                    //nui.get("isNeedPack").setValue(0);

                    nui.get("billTypeId").setValue("010103"); // 010101 收据 010102 普票 010103 增票
                }
            }
            else
            {
                var el = nui.get('guestId');
                el.setValue(null);
                el.setText(null);

                var row = leftGrid.getSelected();
                var newRow = {guestFullName: null};
                leftGrid.updateRow(row,newRow);
                //nui.get("isNeedPack").setValue(0);
            }


        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}

function addSelectPart(){
    var guestId = nui.get("guestId").getValue();
    if(!guestId) {
        nui.alert("请先选择客户再添加配件!");
        return;
    }
    var row = morePartGrid.getSelected();
    if(row){
        var params = {partCode:row.code};
        params.partId = row.id;
        params.guestId = guestId;
        var price = getPartPrice(params);
                    
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
            outUnitId : row.unit
        };

        if(rightGrid.getSelected()){
            rightGrid.updateRow(rightGrid.getSelected(),newRow);
        }else{
            rightGrid.addRow(newRow);
        }
        rightGrid.beginEditCell(rightGrid.getSelected(), "orderQty");

        advancedMorePartWin.hide();
        morePartGrid.setData([]);
    }else{
        nui.alert("请选择配件!");
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

    if(data.codeId && data.codeId>0){
        e.cancel = true;
    }

}
function addMorePart(){
    var row = leftGrid.getSelected();
    if(row.auditSign == 1){
        nui.alert("此单已提交!");
        return;
    }

    var main = basicInfoForm.getData();
    if(!main.id){
        nui.alert("请先保存数据！");
        return;
    }
    var data = rightGrid.getChanges()||[];
    if (data.length>0) {
        nui.alert("请先保存数据！");
        return;
    }
    advancedAddForm.setData([]);
    advancedAddWin.show();
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
function selectPart(callback,checkcallback)
{
    nui.open({
        targetWindow: window,
        url: webPath + cloudPartDomain + "/com.hsweb.cloud.part.common.orderBillChoose.flow?token="+token,
        title: "采购订单选择", width: 930, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var data = {
                orderTypeId: 1,
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

    var guestId = nui.get("guestId").getValue();
    if(!guestId) {
        nui.alert("请选择供应商！");
        return;
    }

    rightGrid.findRow(function(row){
        var partId = row.partId;
        var partCode = row.comPartCode;
        if(partId == null || partId == "" || partId == undefined || partCode == null || partCode == "" || partCode == undefined){
            rightGrid.removeRow(row);
        }
    });

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
            orderPrice : row.orderPrice,
            orderAmt : row.orderAmt,
            storeId : row.storeId,
            comOemCode : row.comOemCode,
            comSpec : row.comSpec,
            partCode : row.comPartCode,
            partName : row.comPartName,
            fullName : row.comFullName,
            systemUnitId : row.comUnit,
            outUnitId : row.comUnit
        };


        rightGrid.addRow(newRow);
    }

}
var supplier = null;
function selectSupplier(elId) {
    supplier = null;
    nui.open({
        targetWindow : window,
        url : webPath+partDomain+"/com.hsweb.part.common.guestSelect.flow?token="+token,
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