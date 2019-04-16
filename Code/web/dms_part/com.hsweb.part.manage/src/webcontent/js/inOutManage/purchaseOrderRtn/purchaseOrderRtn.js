/**
 * Created by Administrator on 2018/2/23.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
//var leftGridUrl = baseUrl+"com.hsapi.part.invoice.svr.queryPjSellOrderMainList.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.part.invoice.svr.queryPjSellOrderDetailList.biz.ext";
//var advancedSearchWin = null;
var advancedMorePartWin = null;
var advancedAddWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var basicInfoForm = null;
var bottomInfoForm = null;
var bottomInfoForm = null;
var advancedAddForm = null;
//var leftGrid = null;
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
var partShow=0;
var moreSearchShow=0;
var autoNew = 0;
var memList=[];

var AuditSignHash = {
  "0":"草稿",
  "1":"已退货"
};


$(document).ready(function(v)
{
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '加载中...'
    });
    
//    leftGrid = nui.get("leftGrid");
//    leftGrid.setUrl(leftGridUrl);

    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
//    advancedSearchWin = nui.get("advancedSearchWin");
//    advancedSearchForm = new nui.Form("#advancedSearchWin");
    basicInfoForm = new nui.Form("#basicInfoForm");
    advancedMorePartWin = nui.get("advancedMorePartWin");
    advancedAddWin = nui.get("advancedAddWin");
    morePartGrid = nui.get("morePartGrid");

    gsparams.startDate = getNowStartDate();
    gsparams.endDate = addDate(getNowEndDate(), 1);
    //gsparams.isOut = 0;

    sOrderDate = nui.get("sOrderDate");
    eOrderDate = nui.get("eOrderDate");
    nui.get('orderMan').setValue(currEmpId);
    nui.get('orderMan').setText(currUserName);
    
	initMember("orderMan",function(){
		memList = nui.get('orderMan').getData();
  });

    var dictDefs ={"rtnReasonId":"DDT20130703000072", "settleTypeId":"DDT20130703000035"};
    initDicts(dictDefs, function(){
        getStorehouse(function(data)
        {
            storehouse = data.storehouse||[];
            
            if(storehouse && storehouse.length>0){
                FStoreId = storehouse[0].id;
                nui.get('storehouse').setData(storehouse);
            }else{
                isNeedSet = true;
            }

            getAllPartBrand(function(data) {
                brandList = data.brand;
                brandList.forEach(function(v) {
                    brandHash[v.id] = v;
                });
    
                gsparams.auditSign = 0;
//                quickSearch(0);

                nui.unmask();
            });
        });
    });
    
    document.ondragstart = function() {
        return false;
    };
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
            if(moreSearchShow==1){
            	onAdvancedSearchCancel();
            }
        }
	}

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
    add();
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
    	nui.get("orderMan").setText(row.orderMan);
		row.orderMan=row.orderManId; 
		basicInfoForm.setData(row);
       //bottomInfoForm.setData(row);
       nui.get("guestId").setText(row.guestFullName);

       var data = basicInfoForm.getData();
       var text=AuditSignHash[row.auditSign];
//       nui.get('AuditSign').setValue(text);
		if(AuditSignHash){
			
			nui.get('AuditSign').setValue(text);
	    }
       if(data.auditSign == 1) {
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
//function onLeftGridSelectionChanged(){    
//   var row = leftGrid.getSelected(); 
//   
//   loadMainAndDetailInfo(row);
//} 
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
        
//        if(autoNew == 0){
//			add();
//			autoNew = 1;
//		}
        if(data && data.length <= 0){
            addNewRow(false);
        }
//        else{
//            var guestId = nui.get("guestId").getValue();
//            var changeData = rightGrid.getChanges();
//            if(changeData.length == 0 && guestId){
//                addNewRow(false);
//            }
//        }   

    });
}
//function onLeftGridDrawCell(e)
//{
//    var record = e.record;
//    switch (e.field){
//        case "auditSign":
//            if(AuditSignHash && AuditSignHash[e.value])
//            {
//                e.cellHtml = AuditSignHash[e.value];
//            }
//            break;
//        // case "guestFullName":
//        //     if(e.value){
//        //         if(record.auditSign == 0)
//        //         {
//        //             e.cellHtml = "<span class='fa fa-save'></span>"+(e.value||"");
//        //         }else{
//        //             if(record.isRtnSign == 1)
//        //             {
//        //                 e.cellHtml = "<span class='fa fa-hand-o-right'></span>"+(e.value||"");
//        //             }else if(record.isRtnSign == 0)
//        //             {
//        //                 e.cellHtml = "<span class='fa fa-spinner fa-spin'></span>"+(e.value||"");
//        //             }
//        //         }
//        //         if(record.billStatusId==2){
//        //             e.cellHtml = "<span class='fa fa-check'></span>"+(e.value||"");
//        //         }
//        //     }
//        //     break;
//    }
//}
//var currType = 2;
//function quickSearch(type){
//    var params = {};
//    var querysign = 1;
//    var queryname = "本日";
//    var querytypename = "草稿";
//    switch (type)
//    {
//        case 0:
//            params.today = 1;
//            params.startDate = getNowStartDate();
//            params.endDate = addDate(getNowEndDate(), 1);
//            queryname = "本日";
//            querysign = 1;
//            gsparams.startDate = getNowStartDate();
//            gsparams.endDate = addDate(getNowEndDate(), 1);
//            break;
//        case 1:
//            params.yesterday = 1;
//            params.startDate = getPrevStartDate();
//            params.endDate = addDate(getPrevEndDate(), 1);
//            queryname = "昨日";
//            querysign = 1;
//            gsparams.startDate = getPrevStartDate();
//            gsparams.endDate = addDate(getPrevEndDate(), 1);
//            break;
//        case 2:
//            params.thisWeek = 1;
//            params.startDate = getWeekStartDate();
//            params.endDate = addDate(getWeekEndDate(), 1);
//            queryname = "本周";
//            querysign = 1;
//            gsparams.startDate = getWeekStartDate();
//            gsparams.endDate = addDate(getWeekEndDate(), 1);
//            break;
//        case 3:
//            params.lastWeek = 1;
//            params.startDate = getLastWeekStartDate();
//            params.endDate = addDate(getLastWeekEndDate(), 1);
//            queryname = "上周";
//            querysign = 1;
//            gsparams.startDate = getLastWeekStartDate();
//            gsparams.endDate = addDate(getLastWeekEndDate(), 1);
//            break;
//        case 4:
//            params.thisMonth = 1;
//            params.startDate = getMonthStartDate();
//            params.endDate = addDate(getMonthEndDate(), 1);
//            queryname = "本月";
//            querysign = 1;
//            gsparams.startDate = getMonthStartDate();
//            gsparams.endDate = addDate(getMonthEndDate(), 1);
//            break;
//        case 5:
//            params.lastMonth = 1;
//            params.startDate = getLastMonthStartDate();
//            params.endDate = addDate(getLastMonthEndDate(), 1);
//            queryname = "上月";
//            querysign = 1;
//            gsparams.startDate = getLastMonthStartDate();
//            gsparams.endDate = addDate(getLastMonthEndDate(), 1);
//            break;
//        case 6:
//            params.billStatusId = 0;
//            querytypename = "草稿";
//            querysign = 2;
//            gsparams.auditSign = 0;
//            break;
//        case 7:
//            params.billStatusId = 1;
//            querytypename = "已提交";
//            querysign = 2;
//            gsparams.auditSign = 1;
//            break;
//        case 8:
//            params.billStatusId = 2;
//            querytypename = "已退货";
//            querysign = 2;
//            gsparams.auditSign = 1;
//            break;
//        default:
//            params.today = 1;
//            params.startDate = getNowStartDate();
//            params.endDate = addDate(getNowEndDate(), 1);
//            querytypename = "草稿";
//            gsparams.startDate = getNowStartDate();
//            gsparams.endDate = addDate(getNowEndDate(), 1);
//            gsparams.auditSign = 0;
//            break;
//    }
//    currType = type;
//    if(querysign == 1){
//        var menunamedate = nui.get("menunamedate");
//        menunamedate.setText(queryname);
//    }else if(querysign == 2){
//            var menunametype = nui.get("menunametype");
//            menunametype.setText(querytypename);
//    }
//    doSearch(gsparams);
//}
//function onSearch(){
//    search();
//}
//function search()
//{
//    var param = getSearchParam();
//    doSearch(param);
//}
//function getSearchParam(){
//    var params = {};
//    params = gsparams;
//    params.guestId = nui.get("searchGuestId").getValue();
//    return params;
//}
function setBtnable(flag)
{
    if(flag)
    {
        //nui.get("unAuditBtn").disable();
        nui.get("auditBtn").enable();
        nui.get("saveBtn").enable();
        //nui.get("auditToOutBtn").disable();
        //nui.get("printBtn").enable();
    }
    else
    {
        //nui.get("unAuditBtn").enable();
        nui.get("auditBtn").disable();
        //nui.get("auditToOutBtn").enable();
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
var saveUrl = baseUrl + "com.hsapi.part.invoice.crud.savePjSellOrder.biz.ext";
function save() {
    var data = basicInfoForm.getData();
    for ( var key in requiredField) {
        if (!data[key] || $.trim(data[key]).length == 0) {
            showMsg(requiredField[key] + "不能为空!","W");
            return;
        }
    }


    if(data){
        if(data.auditSign == 1) {
            showMsg("此单已提交!","W");
            return;
        } 
    }else{
        return;
    }
    
    var msg = checkRightData();
    if(msg){
        showMsg(msg,"W");
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
                showMsg("保存成功!","S");
                //onLeftGridRowDblClick({});
                var pjSellOrderMainList = data.pjSellOrderMainList;
                if(pjSellOrderMainList && pjSellOrderMainList.length>0) {
                    var leftRow = pjSellOrderMainList[0];
//                    var row = leftGrid.getSelected();
//                    leftGrid.updateRow(row,leftRow);
                   
                    //保存成功后重新加载数据
                    loadMainAndDetailInfo(leftRow);
                    $('#bServiceId').text("采退单号："+leftRow.serviceId);
                    
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
    data.isFinished = 0;
    data.auditSign = 0;
    data.billStatusId = '';
    data.printTimes = 0;
    data.orderTypeId = 3;

    data.orderManId=nui.get('orderMan').getValue();
	data.orderMan=nui.get('orderMan').getText();
	delete data.createDate;
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
        nui.get('guestId').enabled=true;
		nui.get('orderMan').enabled=true;
		nui.get('settleTypeId').enabled=true;
		nui.get('rtnReasonId').enabled=true;
    }
    else
    {
        document.getElementById("fd1").disabled = true;
        nui.get('guestId').enabled=false;
		nui.get('orderMan').enabled=false;
		nui.get('settleTypeId').enabled=false;
		nui.get('rtnReasonId').enabled=false;
    }
}
//function doSearch(params) 
//{
//    //目前没有区域销售订单，采退受理  params.enterTypeId = '050101';
//    params.orderTypeId = 3;
//    leftGrid.load({
//        params : params,
//        token : token
//    }, function() {
//        //onLeftGridRowDblClick({});
//        var data = leftGrid.getData().length;
//        if(data <= 0){
//            basicInfoForm.reset();
//            rightGrid.clearRows();
//            
//            setBtnable(false);
//            setEditable(false);
//            
//            if(autoNew == 0){
//				add();
//				autoNew = 1;
//			}
//            
//        }else {
//            var row = leftGrid.getSelected();
//            if(row.auditSign == 1) {
//                setBtnable(false);
//                setEditable(false);
//                document.getElementById("basicInfoForm").disabled=true;
//            }else {
//                setBtnable(true);
//                setEditable(true);
//                document.getElementById("basicInfoForm").disabled=false;
//            }
//        }
//    });
//}
//function advancedSearch()
//{
//    advancedSearchWin.show();
//    moreSearchShow=1;
////    advancedSearchForm.clear();
//    if(advancedSearchFormData)
//    {
//        advancedSearchForm.setData(advancedSearchFormData);
//    }else{
//        sOrderDate.setValue(getWeekStartDate());
//        eOrderDate.setValue(addDate(getWeekEndDate(), 1));
//    }
//}
//function onAdvancedSearchOk()
//{
//    var searchData = advancedSearchForm.getData();
//    var i;
//    //订货日期
//    if(searchData.sOrderDate)
//    {
//        searchData.sCreateDate = formatDate(searchData.sCreateDate);
//    }
//    if(searchData.eOrderDate)
//    {
//        var date = searchData.eCreateDate;
//        searchData.eCreateDate = addDate(date, 1);
//        
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
//    //审核日期
//    if(searchData.sAuditDate)
//    {
//        searchData.sAuditDate = formatDate(searchData.sAuditDate);
//    }
//    if(searchData.eAuditDate)
//    {
//        var date = searchData.eAuditDate;
//        searchData.eAuditDate = addDate(date, 1);
//        
//    }
//    //供应商
//    if(searchData.guestId)
//    {
//        if(typeof searchData.guestId !== 'number'){
//        	searchData.guestName= searchData.guestId;
//        	searchData.guestId=null;
//        }
//        else{
//        	searchData.guestId = nui.get("guestId").getValue();
//        }
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
//    searchData.auditSign = gsparams.auditSign;
//    advancedSearchFormData = advancedSearchForm.getData();
//    advancedSearchWin.hide();
//    doSearch(searchData);
//}
//function onAdvancedSearchCancel()
//{
////    advancedSearchForm.clear();
//    advancedSearchWin.hide();
//}
//function checkNew() 
//{
//    var rows = leftGrid.findRows(function(row){
//        if(row.serviceId == "新采购退货") return true;
//    });
//    
//    return rows.length;
//}
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

var auditUrl = baseUrl+"com.hsapi.part.invoice.crud.auditPjSellOrder.biz.ext";
function audit()
{
    var data = basicInfoForm.getData();
    for ( var key in requiredField) {
        if (!data[key] || $.trim(data[key]).length == 0) {
            showMsg(requiredField[key] + "不能为空!","W");
            return;
        }
    }

//    var row = leftGrid.getSelected();
    if(data){
        if(data.auditSign == 1) {
            showMsg("此单已出库!","W");
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

    data = getMainData();

    var sellOrderDetailAdd = rightGrid.getChanges("added");
    var sellOrderDetailUpdate = rightGrid.getChanges("modified");
    var sellOrderDetailDelete = rightGrid.getChanges("removed");
    var sellOrderDetailList = rightGrid.getData();
    if(sellOrderDetailList.length <= 0) {
        showMsg("订单明细为空，不能退货!","W");
        rightGrid.addRow({});
        return;
    }
    sellOrderDetailList = removeChanges(sellOrderDetailAdd, sellOrderDetailUpdate, sellOrderDetailDelete, sellOrderDetailList);


    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '处理中...'
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
            operateFlag:1,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                showMsg("退货成功!","S");
                //onLeftGridRowDblClick({});
                var pjSellOrderMainList = data.pjSellOrderMainList;
                if(pjSellOrderMainList && pjSellOrderMainList.length>0) {
                    var leftRow = pjSellOrderMainList[0];
//                    var row = leftGrid.getSelected();
//                    leftGrid.updateRow(row,leftRow);

                    //保存成功后重新加载数据
                    loadMainAndDetailInfo(leftRow);
                    $('#bServiceId').text("采退单号："+leftRow.serviceId);
                    
//                    rightGrid.setData([]);
//					add();
                }
            } else {
                showMsg(data.errMsg || "退货失败!","W");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
var auditToOutUrl = baseUrl+"com.hsapi.part.invoice.crud.auditSellOrderToOutTran.biz.ext";
function auditToOut()
{

    var row = leftGrid.getSelected();
    if(row){
        if(row.auditSign == 1) {
            showMsg("此单已退货!","W");
            return;
        } 
    }else{
        return;
    }

    if(row.auditSign != 1) {
        showMsg("请先提交，再出库!","W");
        return;
    } 

    // var isRtnSign = row.isRtnSign;
    // if(isRtnSign == 0){
    //     showMsg("待供应商受理后才可出库!","W");
    //     return;
    // }

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
                showMsg("出库成功!","S");
                var newRow = {isOut: 1};
                leftGrid.updateRow(row, newRow);

                setBtnable(false);
                
            } else {
                showMsg(data.errMsg || "出库失败!","W");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function onPrint() {
//	var main = leftGrid.getSelected();
//	if(!main){
//		showMsg("请选择一条记录");
//	}
	var detail=rightGrid.getData();
	var form=basicInfoForm.getData();
	var mainParams={
			currUserName :currUserName,
			currRepairSettorderPrintShow :currRepairSettorderPrintShow,
			currCompAddress :currCompAddress,
			currCompLogoPath : currCompLogoPath,
			currCompTel :currCompTel,
			currOrgName : currOrgName
	};
	var billTypeId=nui.get('billTypeId').text;
	var settleTypeId=nui.get('settleTypeId').text;
	var rtnReasonId= nui.get('rtnReasonId').text;
	var createDate = nui.get('createDate').getValue();
	var guestFullName=nui.get('guestId').text;
	var guestId =form.guestId;
	var serviceId = $('#bServiceId').text().substr(6);
	var formParms={
			guestId :guestId,
			settleTypeId :settleTypeId,
			rtnReasonId:rtnReasonId,
			guestFullName : guestFullName,
			createDate :createDate,
			serviceId :serviceId
	};
	var detailParms=detail;

	for(var i=0;i<detailParms.length;i++){
		for(var j=0;j<storehouse.length;j++){
			if(detailParms[i].storeId==storehouse[j].id){
				detailParms[i].storehouse=storehouse[j].name;
			}
		}
	}
	
	for(var i=0;i<detailParms.length;i++){	
		var comPartBrindId=detailParms[i].comPartBrandId;
		if(comPartBrindId){
			detailParms[i].comPartBrindId=brandHash[comPartBrindId].name;
		}
	}
	
	var openUrl = webPath + contextPath+"/manage/inOutManage/purchaseOrderRtn/PurchaseOrderRtnPrint.jsp";

     nui.open({
        url: openUrl,
        width: "100%",
        height: "100%",
        title : "采购退货单打印",
        showMaxButton: false,
        allowResize: false,
        showHeader: true,
        onload: function() {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.SetData(mainParams,detailParms,formParms);
        },
    });

}
function add()
{
    if(isNeedSet){
        showMsg("请先到仓库定义功能设置仓库!","W");
        return;
    }

//    if(checkNew() > 0) 
//    {
//        showMsg("请先保存数据!","W");
//        return;
//    }

    var formJsonThis = nui.encode(basicInfoForm.getData());
    var len = rightGrid.getData().length;
    var orderMan=nui.get('orderMan').getText()
	var orderManId=nui.get('orderMan').getValue();

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
                    
                    var newRow = { serviceId: '新采购退货单', auditSign: 0};
//                    leftGrid.addRow(newRow, 0);
//                    leftGrid.clearSelect(false);
//                    leftGrid.select(newRow, false);
//                    
//                    nui.get("serviceId").setValue("新采购退货");
                    $('#bServiceId').text("采退单号: 新采购退货单");
                    nui.get("billTypeId").setValue("010103");  //010101  收据   010102  普票  010103  增票
                    nui.get("createDate").setValue(new Date());

                    if(!orderMan || orderMan==""){
    					for(var i=0;i<memList.length;i++){
    						if(currEmpId==memList[i].empId){
    							nui.get("orderMan").setValue(currEmpId);
    							nui.get("orderMan").setText(currEmpId);
    						}
    					}
    				
    				}else{
    					nui.get("orderMan").setValue(orderManId);
    					nui.get("orderMan").setText(orderMan);
    				}
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
        
        var newRow = { serviceId: '新采购退货单', auditSign: 0};
//        leftGrid.addRow(newRow, 0);
//        leftGrid.clearSelect(false);
//        leftGrid.select(newRow, false);
        
//        nui.get("serviceId").setValue("新采购退货");
    	$('#bServiceId').text("采退单号: 新采购退货单");
        nui.get("billTypeId").setValue("010103");  //010101  收据   010102  普票  010103  增票
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
// var auditUrl = baseUrl+"com.hsapi.part.invoice.crud.auditPjSellOrder.biz.ext";
// function audit()
// {
//     var data = basicInfoForm.getData();
//     for ( var key in requiredField) {
//         if (!data[key] || $.trim(data[key]).length == 0) {
//             showMsg(requiredField[key] + "不能为空!","W");
//             return;
//         }
//     }

//     var row = leftGrid.getSelected();
//     if(row){
//         if(row.auditSign == 1) {
//             showMsg("此单已提交!","W");
//             return;
//         } 
//     }else{
//         return;
//     }

//     //审核时，数量，单价，金额，仓库不能为空
//     var msg = checkStockOutQty();
//     if(msg){
//         showMsg(msg,"W");
//         return;
//     }
//     //审核时，判断是否存在缺货信息
//     var msg = checkRightData();
//     if(msg){
//         showMsg(msg,"W");
//         return;
//     }

//     data = getMainData();

//     var sellOrderDetailAdd = rightGrid.getChanges("added");
//     var sellOrderDetailUpdate = rightGrid.getChanges("modified");
//     var sellOrderDetailDelete = rightGrid.getChanges("removed");
//     var sellOrderDetailList = rightGrid.getData();
//     if(sellOrderDetailList.length <= 0) {
//         showMsg("退货明细为空，不能提交!","W");
//         return;
//     }
//     sellOrderDetailList = removeChanges(sellOrderDetailAdd, sellOrderDetailUpdate, sellOrderDetailDelete, sellOrderDetailList);


//     nui.mask({
//         el: document.body,
//         cls: 'mini-mask-loading',
//         html: '提交中...'
//     });

//     nui.ajax({
//         url : auditUrl,
//         type : "post",
//         data : JSON.stringify({
//             sellOrderMain : data,
//             sellOrderDetailAdd : sellOrderDetailAdd,
//             sellOrderDetailUpdate : sellOrderDetailUpdate,
//             sellOrderDetailDelete : sellOrderDetailDelete,
//             sellOrderDetailList : sellOrderDetailList,
//             token : token
//         }),
//         success : function(data) {
//             nui.unmask(document.body);
//             data = data || {};
//             if (data.errCode == "S") {
//                 showMsg("提交成功!","S");
//                 var pjSellOrderMainList = data.pjSellOrderMainList;
//                 if(pjSellOrderMainList && pjSellOrderMainList.length>0) {
//                     var leftRow = pjSellOrderMainList[0];
//                     var row = leftGrid.getSelected();
//                     leftGrid.updateRow(row,leftRow);

//                     //保存成功后重新加载数据
//                     loadMainAndDetailInfo(leftRow);
//                 }
//                 //onLeftGridRowDblClick({});
                
//             } else {
//                 showMsg(data.errMsg || "提交失败!","W");
//             }
//         },
//         error : function(jqXHR, textStatus, errorThrown) {
//             // nui.alert(jqXHR.responseText);
//             console.log(jqXHR.responseText);
//         }
//     });
// }
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
        + "com.hsapi.part.invoice.paramcrud.queryBillPartChoose.biz.ext";
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
var partPriceUrl = baseUrl
        + "com.hsapi.part.invoice.pricemanage.getSellDefaultPrice.biz.ext";
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
	
	 var data = basicInfoForm.getData();
	    for ( var key in requiredField) {
	        if (!data[key] || $.trim(data[key]).length == 0) {
	            showMsg(requiredField[key] + "不能为空!","W");
	            return;
	        }
	    }
    var guestId = nui.get("guestId").getValue();
    if(!guestId) {
        showMsg("请先选择供应商再添加配件!","W");
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
	var data = basicInfoForm.getData();
	if (data) {
		if (data.auditSign == 1) {
			return;
		}
	}

//    if(row.codeId && data.codeId>0) return;

    var part = rightGrid.getSelected();
    if(!part)
    {
        return;
    }
    if(part.detailId && editPartHash[part.detailId])
    {
        delete editPartHash[part.detailId];
    }
//    rightGrid.removeRow(part,true);
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
var getGuestInfo = baseUrl+"com.hsapi.part.baseDataCrud.crud.querySupplierList.biz.ext";
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

//                    var row = leftGrid.getSelected();
//                    var newRow = {guestFullName: text};
//                    leftGrid.updateRow(row,newRow);

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

//                    var row = leftGrid.getSelected();
//                    var newRow = {guestFullName: null};
//                    leftGrid.updateRow(row,newRow);
                    //nui.get("isNeedPack").setValue(0);

                    nui.get("billTypeId").setValue("010103"); // 010101 收据 010102 普票 010103 增票
                }
            }
            else
            {
                var el = nui.get('guestId');
                el.setValue(null);
                el.setText(null);

//                var row = leftGrid.getSelected();
//                var newRow = {guestFullName: null};
//                leftGrid.updateRow(row,newRow);
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
        showMsg("请先选择供应商再添加配件!","W");
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

    if(data.codeId && data.codeId>0){
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

}
function addMorePart(){
	 var main = basicInfoForm.getData();
    if(main.auditSign == 1){
        showMsg("此单已提交!","W");
        return;
    }

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
        url: webPath + contextPath + "/com.hsweb.part.manage.orderBillChoose.flow?token="+token,
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

function selectEnterPart(callback,checkcallback)
{
    nui.open({
        // targetWindow: window,
        url: webPath + contextPath + "/com.hsweb.part.manage.orderEnerChoose.flow?token="+token,
        title: "入库单选择", width: 930, height: 560,
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
	var data = basicInfoForm.getData();

    for ( var key in requiredField) {
        if (!data[key] || $.trim(data[key]).length == 0) {
            showMsg(requiredField[key] + "不能为空!","W");
            return;
        }
    }
	if (data) {
		if (data.auditSign == 1) {
			return;
		}
	}
	
    var guestId = nui.get("guestId").getValue();
    if(!guestId) {
        showMsg("请选择供应商!","W");
        return;
    }

//    rightGrid.findRow(function(row){
//        var partId = row.partId;
//        var partCode = row.comPartCode;
//        if(partId == null || partId == "" || partId == undefined || partCode == null || partCode == "" || partCode == undefined){
//            rightGrid.removeRow(row);
//        }
//    });

    selectPart(function(data) {
        addDetail(data);
    },function(data) {
        var part = data.part;
        var partid = part.id;
        //var rtn = checkPartIDExists(partid);
        return rtn;
    });
}

function addEnterPart() {
	var data = basicInfoForm.getData();

    for ( var key in requiredField) {
        if (!data[key] || $.trim(data[key]).length == 0) {
            showMsg(requiredField[key] + "不能为空!","W");
            return;
        }
    }
	if (data) {
		if (data.auditSign == 1) {
			return;
		}
	}
	
    var guestId = nui.get("guestId").getValue();
    if(!guestId) {
        showMsg("请选择供应商!","W");
        return;
    }

//    rightGrid.findRow(function(row){
//        var partId = row.partId;
//        var partCode = row.comPartCode;
//        if(partId == null || partId == "" || partId == undefined || partCode == null || partCode == "" || partCode == undefined){
//            rightGrid.removeRow(row);
//        }
//    });

    selectEnterPart(function(data) {
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
            comPartBrandId : row.comPartBrandId,
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
        var gridData=rightGrid.getData();
        for(var j=0;j<gridData.length;j++){
			if(!gridData[j].partId){
				rightGrid.removeRow(gridData[j]);
			}
		}

        rightGrid.addRow(newRow);
    }

}

function setInitData(params){
	if(params.id){
		basicInfoForm.setData(params);
		nui.get('orderMan').setText(params.orderMan);
		nui.get('orderMan').setValue(params.orderManId);
		$('#bServiceId').text("采退单号："+params.serviceId);
		nui.get("guestId").setText(params.guestFullName);
//		nui.get('storehouse').setValue(params.storeId);
		
		if(AuditSignHash)
	       {
				var text=AuditSignHash[params.auditSign];
				nui.get('AuditSign').setValue(text);
	       }
		
		var mainId=params.id;
		var auditSign=params.auditSign;
		if(params.id){		
			loadRightGridData(mainId);	
		}
		if(params.auditSign == 0){
			
			document.getElementById("fd1").disabled = false;
			nui.get("guestId").enable();
		}
		if(params.auditSign != 0){
			
			document.getElementById("fd1").disabled = true;
			nui.get("guestId").disable();
		}
	}else{
		formJson = nui.encode(basicInfoForm.getData());
		add();	
	}
}

var supplier = null;
function selectSupplier(elId) {
    supplier = null;
    nui.open({
        // targetWindow: window,,
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