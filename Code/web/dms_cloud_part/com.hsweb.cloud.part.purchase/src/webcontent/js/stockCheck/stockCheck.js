/**
 * Created by Administrator on 2018/2/23.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var leftGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjStockCheckMainList.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjStockCheckDetailList.biz.ext";
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
var storeHash={};
var morePartGrid = null;
var gsparams = {};
var sOrderDate = null;
var eOrderDate = null;
var dataList = null;
var FStoreId = null;
var isNeedSet = false;
var oldValue = null;
var oldRow = null;
var FGuestId = null;

var storeIdEl = null;

var AuditSignHash = {
  "0":"草稿",
  "1":"已审核"
};

var storeLimitMap={};
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

    storeIdEl = nui.get("storeId");

    gsparams.startDate = getNowStartDate();
    gsparams.endDate = addDate(getNowEndDate(), 1);

    sOrderDate = nui.get("sOrderDate");
    eOrderDate = nui.get("eOrderDate");

    getStorehouse(function(data)
    {
        storehouse = data.storehouse||[];
        if(storehouse && storehouse.length>0){
            FStoreId = storehouse[0].id;
            storehouse.forEach(function(v){
        		storeHash[v.id]=v;
        	});
        }else{
            isNeedSet = true;
        }

        storeIdEl.setData(storehouse);
    });

    getAllPartBrand(function(data) {
        brandList = data.brand;
        brandList.forEach(function(v) {
            brandHash[v.id] = v;
        });
    });

    getGuestId();

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
            addNewRow(true);
        }else{
            var changeData = rightGrid.getChanges();
            if(changeData.length == 0 && FGuestId != null){
                addNewRow(true);
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
            querytypename = "已审";
            querysign = 2;
            gsparams.auditSign = 1;
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
    return params;
}
function setBtnable(flag)
{
    if(flag)
    {
        nui.get("auditBtn").enable();
        nui.get("saveBtn").enable();
    }
    else
    {
        nui.get("auditBtn").disable();
        nui.get("saveBtn").disable();
    }
}
var requiredField = {
    storeId : "盘点仓库",
    orderMan : "盘点员",
    createDate : "盘点日期"
};
var saveUrl = baseUrl + "com.hsapi.cloud.part.invoicing.crud.savePjStockCheck.biz.ext";
function save() {
    var data = basicInfoForm.getData();
    for ( var key in requiredField) {
        if (!data[key] || $.trim(data[key]).length == 0) {
            showMsg(requiredField[key] + "不能为空!","W");
            return;
        }
    }

    var row = leftGrid.getSelected();
    if(row){
        if(row.auditSign == 1) {
            showMsg("此单已审!","W");
            return;
        } 
    }else{
        return;
    }
    

	var orderMan =nui.get('orderMan').value;
//	if(orderMan !=currUserName){
		getStoreLimit();
//	}
	var storeId =nui.get('storeId').value;
	if(Object.getOwnPropertyNames(storeLimitMap ).length >0){
		if(!storeLimitMap.hasOwnProperty(storeId) && storeHash[storeId]){
			showMsg("没有选择"+storeHash[storeId].name+"的权限","W");
			return;
		}
	}

	
    data = getMainData();

    var orderDetailAdd = rightGrid.getChanges("added");
    var orderDetailUpdate = rightGrid.getChanges("modified");
    var orderDetailDelete = rightGrid.getChanges("removed");
    var orderDetailList = rightGrid.getData();
    orderDetailList = removeChanges(orderDetailAdd, orderDetailUpdate, orderDetailDelete, orderDetailList);

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });

    nui.ajax({
        url : saveUrl,
        type : "post",
        data : JSON.stringify({
            orderMain : data,
            orderDetailAdd : orderDetailAdd,
            orderDetailUpdate : orderDetailUpdate,
            orderDetailDelete : orderDetailDelete,
            orderDetailList : orderDetailList,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                showMsg("保存成功!","S");
                //onLeftGridRowDblClick({});
                var list = data.list;
                if(list && list.length>0) {
                    var leftRow = list[0];
                    var row = leftGrid.getSelected();
                    leftGrid.updateRow(row,leftRow);

                    //保存成功后重新加载数据
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
    data.auditSign = 0;
    data.printTimes = 0;

    if(data.operateDate) {
        data.operateDate = format(data.operateDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
    }

    data.guestId = FGuestId;

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

            add();
            
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
        searchData.sCreateDate = formatDate(searchData.sCreateDate);
    }
    if(searchData.eOrderDate)
    {
        var date = searchData.eCreateDate;
        searchData.eCreateDate = addDate(date, 1);
        
    }
    //创建日期
    if(searchData.sCreateDate)
    {
        searchData.sCreateDate = formatDate(searchData.sCreateDate);
    }
    if(searchData.eCreateDate)
    {
        var date = searchData.eCreateDate;
        searchData.eCreateDate = addDate(date, 1);
        
    }
    //审核日期
    if(searchData.sAuditDate)
    {
        searchData.sAuditDate = formatDate(searchData.sAuditDate);
    }
    if(searchData.eAuditDate)
    {
        var date = searchData.eAuditDate;
        searchData.eAuditDate = addDate(date, 1);
        
    }
    //订单单号
    if(searchData.serviceIdList)
    {
        var tmpList = searchData.serviceIdList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i].replace(/\s+/g, "")+"'";
        }
        searchData.serviceIdList = tmpList.join(",");
    }
    //配件编码
    if(searchData.partCodeList)
    {
        var tmpList = searchData.partCodeList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i].replace(/\s+/g, "")+"'";
        }
        searchData.partCodeList = tmpList.join(",");
    }
    searchData.auditSign = gsparams.auditSign;
    for(var key in searchData){
    	if(searchData[key]!=null && searchData[key]!="" && typeof(searchData[key])=='string'){    		
    		searchData[key]=searchData[key].replace(/\s+/g, "");
    	}
    }
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
        if(row.serviceId == "新盘点单") return true;
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
        case "stockOutQty":
            if(e.value > 0)
            {
                e.cellHtml = '<a style="color:red;">' + e.value + '</a>';
            }
            break;
        case "dc":
            if(e.value == -1)
            {
                e.cellHtml = '<a style="color:red;">盘亏</a>';
            }
            if(e.value == 0)
            {
                e.cellHtml = '无盈亏';
            }
            if(e.value == 1)
            {
                e.cellHtml = '<a style="color:green;">盘盈</a>';
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

var auditUrl = baseUrl+"com.hsapi.cloud.part.invoicing.crud.auditPjStockCheckOut.biz.ext";
function audit()
{
    var data = basicInfoForm.getData();
    for ( var key in requiredField) {
        if (!data[key] || $.trim(data[key]).length == 0) {
            showMsg(requiredField[key] + "不能为空!","W");
            return;
        }
    }

    var row = leftGrid.getSelected();
    if(row){
        if(row.auditSign == 1) {
            showMsg("此单已审!","W");
            return;
        } 
    }else{
        return;
    }

    //审核时，数量，单价，金额，仓库不能为空
    var msg = checkStockOutQty();
    if(msg){
        showMsg(msg,"W");
        return;
    }
    //审核时，判断是否存在缺货信息
    var msg = checkRightData();
    if(msg){
        showMsg(msg,"W");
        return;
    }

    var orderMan =nui.get('orderMan').value;
//	if(orderMan !=currUserName){
		getStoreLimit();
//	}
	var storeId =nui.get('storeId').value;
	if(Object.getOwnPropertyNames(storeLimitMap ).length >0){
		if(!storeLimitMap.hasOwnProperty(storeId) && storeHash[storeId]){
			showMsg("没有选择"+storeHash[storeId].name+"的权限","W");
			return;
		}
	}
	
    data = getMainData();

    var orderDetailAdd = rightGrid.getChanges("added");
    var orderDetailUpdate = rightGrid.getChanges("modified");
    var orderDetailDelete = rightGrid.getChanges("removed");
    var orderDetailList = rightGrid.getData();
    if(orderDetailList.length <= 0) {
        showMsg("盘点明细为空，不能审核!","W");
        return;
    }
    orderDetailList = removeChanges(orderDetailAdd, orderDetailUpdate, orderDetailDelete, orderDetailList);


    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '审核中...'
    });

    nui.ajax({
        url : auditUrl,
        type : "post",
        data : JSON.stringify({
            orderMain : data,
            orderDetailAdd : orderDetailAdd,
            orderDetailUpdate : orderDetailUpdate,
            orderDetailDelete : orderDetailDelete,
            orderDetailList : orderDetailList,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                showMsg("审核成功!","S");
                //onLeftGridRowDblClick({});
                var list = data.list;
                if(list && list.length>0) {
                    var leftRow = list[0];
                    var row = leftGrid.getSelected();
                    leftGrid.updateRow(row,leftRow);

                    //保存成功后重新加载数据
                    loadMainAndDetailInfo(leftRow);
                }
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
function add()
{
    if(isNeedSet){
        showMsg("请先到仓库定义功能设置仓库!","W");
        return;
    }

    if(checkNew() > 0) 
    {
        showMsg("请先保存数据!","W");
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

                    basicInfoForm.reset();
                    rightGrid.clearRows();
                    
                    var newRow = { serviceId: '新盘点单', orderMan:currUserName, createDate: (new Date()), auditSign: 0};
                    leftGrid.addRow(newRow, 0);
                    leftGrid.clearSelect(false);
                    leftGrid.select(newRow, false);
                    
                    nui.get("serviceId").setValue("新盘点单");
                    nui.get("createDate").setValue(new Date());
                    nui.get("orderMan").setValue(currUserName);
                    
                    addNewRow();

                }else {
                    return;
                }
            }
        );
    }else{
        setBtnable(true);
        setEditable(true);

        basicInfoForm.reset();
        rightGrid.clearRows();
        
        var newRow = { serviceId: '新盘点单', orderMan:currUserName, createDate: (new Date()), auditSign: 0};
        leftGrid.addRow(newRow, 0);
        leftGrid.clearSelect(false);
        leftGrid.select(newRow, false);
        
        nui.get("serviceId").setValue("新盘点单");
        nui.get("createDate").setValue(new Date());
        nui.get("orderMan").setValue(currUserName);

        addNewRow();
        
    }
    getStoreLimit();
    
}
//提交单元格编辑数据前激发
function onCellCommitEdit(e) {
    var editor = e.editor;
    var record = e.record;
    var row = e.row;
    
    editor.validate();
    if (editor.isValid() == false) {
        showMsg("请输入数字!","W");
        e.cancel = true;
    }else {
        var newRow = {};
        if (e.field == "trueQty") {
            if(e.value < 0){
                e.cancel = true;
                return;
            }
            var trueQty = e.value||0;
            var sysQty = record.sysQty||0;
            var sysAmt = record.sysAmt||0;
            var dc = 0;
            var exhibitQty = trueQty - sysQty;
            var truePrice = record.truePrice||0;
            var trueAmt = trueQty*truePrice; 
            
            
            if(exhibitQty<0){
                dc = -1;
            }
            if(exhibitQty>0){
                dc = 1;
            }

            exhibitQty=Math.abs(exhibitQty);
            var exhibitAmt = exhibitQty*truePrice;

                               
            newRow = { trueAmt: trueAmt, exhibitPrice:truePrice,exhibitQty: exhibitQty, exhibitAmt: exhibitAmt, dc: dc};
            rightGrid.updateRow(e.row, newRow);
            
            //record.enteramt.cellHtml = enterqty * enterprice;
        }else if (e.field == "truePrice") {
            if(e.value < 0){
                e.cancel = true;
                return;
            }
            var trueQty = record.trueQty;
            var truePrice = e.value;
            var sysAmt = record.sysAmt||0;
            var exhibitQty = record.exhibitQty||0;
            
            var trueAmt = trueQty*truePrice; 
            var exhibitAmt = exhibitQty*truePrice;
            var exhibitPrice = truePrice;
                           
            newRow = { trueAmt: trueAmt, exhibitPrice:exhibitPrice, exhibitAmt: exhibitAmt};
            rightGrid.updateRow(e.row, newRow);

            
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
        if(column.field == "trueQty"){
            if(orderPrice){
                addNewKeyRow();
            }
        }else if(column.field == "truePrice"){
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
                    rightGrid.beginEditCell(record, "sysQty");
                }
            }
        }
    }
}
function addNewRow(check){
    var data = basicInfoForm.getData();

    if(data.auditSign == 1){
        return;
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
        rightGrid.updateRow(row, newRow);
        rightGrid.beginEditCell(row, "comPartCode");
    }else{
        rightGrid.addRow(newRow);
        rightGrid.beginEditCell(newRow, "comPartCode");
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
function addInsertRow(value, row) {    
    if(!FGuestId) {
        showMsg("请先完善本公司往来单位信息!","W");
        return;
    }

    if(!storeIdEl.getValue()){
        showMsg("请先选择盘点仓库!","W");
        return;
    }
    var params = {partCode:value};
    var part = getPartInfo(params);
    if(part){
        params.partId = part.id;

        var check = checkPartIDExists(part.id);
        if(check){
            showMsg("此编码在盘点列表中已经存在!","W");
            return;
        }

        var p = {partId:part.id, storeId: storeIdEl.getValue()};
        var stock = getPartPrice(p);
        var stockQty = stock.stockQty;
        var stockPrice = stock.stockPrice;

        var newRow = {
            partId : part.id,
            comPartCode : part.code,
            comPartName : part.name,
            comPartBrandId : part.partBrandId,
            comApplyCarModel : part.applyCarModel,
            comUnit : part.unit,
            sysQty : stockQty,
            sysPrice : stockPrice,
            sysAmt : stockQty*stockPrice,
            trueQty : stockQty,
            truePrice : stockPrice,
            trueAmt : stockQty*stockPrice,
            dc : 0,
            exhibitQty : 0,
            exhibitPrice : 0,
            exhibitAmt : 0,
            storeId : storeIdEl.getValue(),
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
            //rightGrid.beginEditCell(row, "enterQty");
            rightGrid.beginEditCell(row, "sysQty");
        }else{
            rightGrid.addRow(newRow);
            //rightGrid.beginEditCell(newRow, "enterQty");
            rightGrid.beginEditCell(row, "sysQty");
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

//    rightGrid.removeRow(part,true);
}
function checkRightData()
{
    var msg = '';
    var rows = rightGrid.findRows(function(row){
        if(row.partId){
            if(row.trueQty){
                if(row.trueQty <= 0) return true;
            }else{
                return true;
            }       
        }

    });
    
    if(rows && rows.length > 0){
        msg = "请完善实盘数量！";
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
        msg = "配件：" + comPartCode + "缺货，不能审核！";
    }
    return msg;
}
function addSelectPart(){
    if(!FGuestId) {
        showMsg("请先完善本公司往来单位信息!","W");
        return;
    }

    if(!storeIdEl.getValue()){
        showMsg("请先选择盘点仓库!","W");
        return;
    }
    var row = morePartGrid.getSelected();
    if(row){
        var params = {partCode:row.code};
        params.partId = row.id;

        var check = checkPartIDExists(row.id);
        if(check){
            showMsg("此编码在盘点列表中已经存在!","W");
            return;
        }

        var p = {partId:row.id, storeId: storeIdEl.getValue()};
        var stock = getPartPrice(p);
        var stockQty = stock.stockQty;
        var stockPrice = stock.stockPrice;
                    
        var newRow = {
            partId : row.id,
            comPartCode : row.code,
            comPartName : row.name,
            comPartBrandId : row.partBrandId,
            comApplyCarModel : row.applyCarModel,
            comUnit : row.unit,
            orderQty : 1,
            sysQty : stockQty,
            sysPrice : stockPrice,
            sysAmt : stockQty*stockPrice,
            trueQty : stockQty,
            truePrice : stockPrice,
            trueAmt : stockQty*stockPrice,
            dc : 0,
            exhibitQty : 0,
            exhibitPrice : 0,
            exhibitAmt : 0,
            storeId : storeIdEl.getValue(),
            comOemCode : row.oemCode,
            comSpec : row.spec,
            partCode : row.code,
            partName : row.name,
            fullName : row.fullName,
            systemUnitId : row.unit,
            enterUnitId : row.unit
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
        // targetWindow: window,
        url: webPath + contextPath + "/com.hsweb.cloud.part.common.orderBillChoose.flow?token="+token,
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
var guestUrl = baseUrl + "com.hsapi.cloud.part.common.svr.getGuestByInternalId.biz.ext";
function getGuestId() {

    nui.ajax({
        url : guestUrl,
        type : "post",
        data : JSON.stringify({}),
        success : function(data) {
            data = data || {};
            if (data.guest) {
                var guest = data.guest;
                FGuestId = guest.id;

            } else {
                console.log(data.errMsg);
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
        }
    });
}
var partPriceUrl = baseUrl
        + "com.hsapi.cloud.part.invoicing.pricemanage.getPartStoreStockByPartId.biz.ext";
function getPartPrice(params){
    var rtn = {};
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
                
                rtn.stockQty = priceRecord.stockQty||0;
                rtn.stockPrice = priceRecord.costPrice||0;
            }

        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });

    return rtn;
}
function checkPartIDExists(partid){
    if(!partid) return false;
    var row = rightGrid.findRow(function(row){
        if(row.partId == partid) {
            return true;
        }
        return false;
    });
    
    if(row) 
    {
        return true;
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
    if(detail && detail.length > 0){
        setInitExportData(main, detail);
    }
}
function setInitExportData(main, detail){
    var storeName = nui.get("storeId").getText();
    document.getElementById("eServiceId").innerHTML = main.serviceId?main.serviceId:"";
    document.getElementById("eStoreName").innerHTML = storeName?storeName:"";
    document.getElementById("eOrderMan").innerHTML = main.orderMan?main.orderMan:"";
    var tds = '<td  colspan="1" align="left">[comPartCode]</td>' +
        "<td  colspan='1' align='left'>[comFullName]</td>" +
        "<td  colspan='1' align='left'>[comApplyCarModel]</td>" +
        "<td  colspan='1' align='left'>[comUnit]</td>" +
        "<td  colspan='1' align='left'>[sysQty]</td>"+
        "<td  colspan='1' align='left'>[trueQty]</td>"+
        "<td  colspan='1' align='center' style='color:red'>[dc]</td>" +
        "<td  colspan='1' align='left'>[exhibitQty]</td>";
    var tableExportContent = $("#tableExportContent");
    tableExportContent.empty();
    for (var i = 0; i < detail.length; i++) {
        var row = detail[i];
        if(row.partId){
            var tr = $("<tr></tr>");
            var dc = row.dc;
            var exhState = "";
            var color = 'green';
            var tdst = "";

            if(dc==1){
                exhState = "盘盈";
                tdst = tds.replace("[comPartCode]", detail[i].comPartCode?detail[i].comPartCode:"")
                         .replace("[comFullName]", detail[i].comFullName?detail[i].comFullName:"")
                         .replace("[comApplyCarModel]", detail[i].comApplyCarModel?detail[i].comApplyCarModel:"")
                         .replace("[comUnit]", detail[i].comUnit?detail[i].comUnit:"")
                         .replace("[sysQty]", detail[i].sysQty?detail[i].sysQty:"")
                         .replace("[trueQty]", detail[i].trueQty?detail[i].trueQty:"")
                         .replace("[dc]", exhState)
                         .replace("red", color)
                         .replace("[exhibitQty]", detail[i].exhibitQty?detail[i].exhibitQty:"");
            }else if(dc==-1){
                exhState = "盘亏";
                tdst.replace("[dc]", exhState).replace("red", color);
                tdst = tds.replace("[comPartCode]", detail[i].comPartCode?detail[i].comPartCode:"")
                         .replace("[comFullName]", detail[i].comFullName?detail[i].comFullName:"")
                         .replace("[comApplyCarModel]", detail[i].comApplyCarModel?detail[i].comApplyCarModel:"")
                         .replace("[comUnit]", detail[i].comUnit?detail[i].comUnit:"")
                         .replace("[sysQty]", detail[i].sysQty?detail[i].sysQty:"")
                         .replace("[trueQty]", detail[i].trueQty?detail[i].trueQty:"")
                         .replace("[dc]", exhState)
                         .replace("[exhibitQty]", detail[i].exhibitQty?detail[i].exhibitQty:"");
            }else {
                tdst = tds.replace("[comPartCode]", detail[i].comPartCode?detail[i].comPartCode:"")
                         .replace("[comFullName]", detail[i].comFullName?detail[i].comFullName:"")
                         .replace("[comApplyCarModel]", detail[i].comApplyCarModel?detail[i].comApplyCarModel:"")
                         .replace("[comUnit]", detail[i].comUnit?detail[i].comUnit:"")
                         .replace("[sysQty]", detail[i].sysQty?detail[i].sysQty:"")
                         .replace("[trueQty]", detail[i].trueQty?detail[i].trueQty:"")
                         .replace("[dc]", "")
                         .replace("[exhibitQty]", detail[i].exhibitQty?detail[i].exhibitQty:"");
            }
            
            tr.append(tdst);
            tableExportContent.append(tr);
        }
        
    }

    var serviceId = main.serviceId?main.serviceId:"";
    method5('tableExcel',"盘点单"+serviceId,'tableExportA');
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