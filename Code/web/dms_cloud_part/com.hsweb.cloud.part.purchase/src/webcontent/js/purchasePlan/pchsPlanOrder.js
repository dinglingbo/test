/**
 * Created by Administrator on 2018/2/23.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var leftGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.pchsplan.queryPjPchsPlanMainList.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.pchsplan.queryPjPchsPlanDetailList.biz.ext";
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
var storehouse = [];
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
var guestIdEl=null;
var partShow=0;
var moreSearchShow=0;
var autoNew = 0;
var partIn=null;

var AuditSignHash = {
  "0":"草稿",
  "1":"已退货"
};
var StatusHash={
		"0"	:"草稿",
		"1"	:"已提交",
		"2"	:"已出库",
		"6" :"部分出库"
	};
var storeLimitMap={};
var storeShelfList=[];
var storeShelfHash={}
var partHash={};
$(document).ready(function(v)
{
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
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    basicInfoForm = new nui.Form("#basicInfoForm");
    advancedMorePartWin = nui.get("advancedMorePartWin");
    advancedAddWin = nui.get("advancedAddWin");
    morePartGrid = nui.get("morePartGrid");
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
    	params.isSupplier = 1;

        data.params = params;
        e.data =data;
        return;
            
       
        
    });
	
    gsparams.startDate = getNowStartDate();
    gsparams.endDate = addDate(getNowEndDate(), 1);
    //gsparams.isOut = 0;

    sOrderDate = nui.get("sOrderDate");
    eOrderDate = nui.get("eOrderDate");

    getAllPartBrand(function(data) {
        brandList = data.brand;
        brandList.forEach(function(v) {
            brandHash[v.id] = v;
        });

        gsparams.auditSign = 0;
        quickSearch(10);

        nui.unmask();
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
            	if(partIn!=false){
            		var row = morePartGrid.getSelected();
    				if(row){
    					addSelectPart();
    				}
    				
            	}
            	partIn=true;
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
            ow(true);
        }
    });
    add();

    
    //启用APP
    if(currIsOpenApp==1){
    	nui.get('auditBtn').setVisible(false);
    	nui.get('submitBtn').setVisible(true);
    	getStoreLocation();
    }else{
    	nui.get('auditBtn').setVisible(true);
    	nui.get('submitBtn').setVisible(false);
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
  /*     var auditSign=row.auditSign;
       if(auditSign==0){
    	   $('#status').text("草稿");	   
       }else if(auditSign==1){
    	   $('#status').text("已退货");
       }*/
       var billStatusId=row.billStatusId;
	   $('#status').text(StatusHash[billStatusId]);
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
        case "billStatusId":
            if(StatusHash && StatusHash[e.value])
            {
                e.cellHtml = StatusHash[e.value];
            }
            break;
        // case "guestFullName":
        //     if(e.value){
        //         if(record.auditSign == 0)
        //         {
        //             e.cellHtml = "<span class='fa fa-save'></span>"+(e.value||"");
        //         }else{
        //             if(record.isRtnSign == 1)
        //             {
        //                 e.cellHtml = "<span class='fa fa-hand-o-right'></span>"+(e.value||"");
        //             }else if(record.isRtnSign == 0)
        //             {
        //                 e.cellHtml = "<span class='fa fa-spinner fa-spin'></span>"+(e.value||"");
        //             }
        //         }
        //         if(record.billStatusId==2){
        //             e.cellHtml = "<span class='fa fa-check'></span>"+(e.value||"");
        //         }
        //     }
        //     break;
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
        	gsparams.billStatusId = 0;
            querytypename = "草稿";
            querysign = 2;
            gsparams.auditSign = 0;
            break;
        case 7:
        	gsparams.billStatusId = 1;
            querytypename = "已提交";
            querysign = 2;
            gsparams.auditSign = 1;
            break;
        case 8:
        	gsparams.billStatusId = 6;
            querytypename = "部分出库";
            querysign = 2;
            gsparams.auditSign = 1;
            break;
        case 9:
        	gsparams.billStatusId = 2;
            querytypename = "已出库";
            querysign = 2;
            gsparams.auditSign = 1;
            break;
        case 10:
        	gsparams.billStatusId = null;
            querytypename = "所有";
            querysign = 2;
            gsparams.auditSign = -1;
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
    gsparams.isDiffOrder = 0;
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
    params.isDiffOrder = 1;
  //是业务员且业务员禁止可见
	if(currIsSalesman ==1 && currIsOnlySeeOwn==1){
		params.creator= currUserName;
	}
    return params;
}
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
    orderDate : "退货日期",
    rtnReasonId : "退货原因",
    settleTypeId : "结算方式"
};
var saveUrl = baseUrl + "com.hsapi.cloud.part.invoicing.crud.savePjSellOrder.biz.ext";
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
            showMsg("此单已提交!","W");
            return;
        } 
    }else{
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
    data.isFinished = 0;
    data.auditSign = 0;
    data.billStatusId = '';
    data.printTimes = 0;
    data.orderTypeId = 3;
    delete data.createDate;	
    if(data.operateDate) {
        data.operateDate = format(data.operateDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
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
  //是业务员且业务员禁止可见
	if(currIsSalesman ==1 && currIsOnlySeeOwn==1){
		params.creator= currUserName;
	}
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
            
            if(autoNew == 0){
				add();
				autoNew = 1;
			}
            
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
    moreSearchShow=1;
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
        case "operateBtn":
            e.cellHtml = //'<span class="icon-remove" onClick="javascript:deletePart()" title="删除行">&nbsp;&nbsp;&nbsp;&nbsp;</span>';/*'<span class="icon-add" onClick="javascript:addPart()" title="添加行">&nbsp;&nbsp;&nbsp;&nbsp;</span>' +
                        '<span class="fa fa-plus" onClick="javascript:addNewRow(true)" title="添加行">&nbsp;&nbsp;</span>' +
                        ' <span class="fa fa-close" onClick="javascript:deletePart()" title="删除行"></span>';
            break;
        case "storeId":
        	if(storeHash[e.value])
            {
//                e.cellHtml = brandHash[e.value].name||"";
            
            		
            		e.cellHtml =storeHash[e.value].name; 
            }
            else{
                e.cellHtml = "";
            }
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
            showMsg(requiredField[key] + "不能为空!","W");
            return;
        }
    }

    var row = leftGrid.getSelected();
    if(row){
        if(row.auditSign == 1) {
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
        showMsg("销售明细为空，不能提交!","W");
        return;
    }
    
    getStoreLimit();
	var rightRow =rightGrid.getData();
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
                    var row = leftGrid.getSelected();
                    leftGrid.updateRow(row,leftRow);

                    //保存成功后重新加载数据
                    loadMainAndDetailInfo(leftRow);
                    nui.confirm("是否打印？", "友情提示", function(action) {
    					if(action== 'ok'){
    						onPrint();
    					}else{
    						rightGrid.setData([]);
    						add();
    					}
    				});
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

function submit()
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
            showMsg("此单已提交!","W");
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
        showMsg("销售明细为空，不能提交!","W");
        return;
    }
    
    getStoreLimit();
	var rightRow =rightGrid.getData();
	for(var i=0;i<rightRow.length;i++){
		if(Object.getOwnPropertyNames(storeLimitMap ).length >0){
			if(!storeLimitMap.hasOwnProperty(rightRow[i].storeId) && storeHash[rightRow[i].storeId]){
				showMsg("没有选择"+storeHash[rightRow[i].storeId].name+"的权限","W");
				return;
			}
		}
	}

    sellOrderDetailList = removeChanges(sellOrderDetailAdd, sellOrderDetailUpdate, sellOrderDetailDelete, sellOrderDetailList);
    var cangHash ="";
	if(currIsOpenApp ==1){
		cangHash=getCangHash(data,sellOrderDetailList);
	}

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
            cangHash :cangHash,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                showMsg("提交成功!","S");
                //onLeftGridRowDblClick({});
                var pjSellOrderMainList = data.pjSellOrderMainList;
                if(pjSellOrderMainList && pjSellOrderMainList.length>0) {
                    var leftRow = pjSellOrderMainList[0];
                    var row = leftGrid.getSelected();
                    leftGrid.updateRow(row,leftRow);

                    //保存成功后重新加载数据
                    loadMainAndDetailInfo(leftRow);
                    nui.confirm("是否打印？", "友情提示", function(action) {
    					if(action== 'ok'){
    						onPrint();
    					}else{
    						rightGrid.setData([]);
    						add();
    					}
    				});
                }
            } else {
                showMsg(data.errMsg || "提交失败!","W");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}

var auditToOutUrl = baseUrl+"com.hsapi.cloud.part.invoicing.crud.auditSellOrderToOutTran.biz.ext";
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
				loadMainAndDetailInfo(leftRow);
                nui.confirm("是否打印？", "友情提示", function(action) {
					if(action== 'ok'){
						onPrint();
					}else{
						rightGrid.setData([]);
						add();
					}
				});
                
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
	var openUrl = webPath + contextPath+"/purchase/purchaseOrderRtn/purchaseOrderRtnPrint.jsp";

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
//    var row = leftGrid.getSelected();
//    if (row) {
//
//        if(!row.id) return;
//
//		var auditSign = row.auditSign||0;
//
//        nui.open({
//
//            url : webPath + contextPath + "/com.hsweb.cloud.part.purchase.pchsOrderRtnPrint.flow?ID="
//                    + row.id+"&printMan="+currUserName+"&auditSign="+auditSign,// "view_Guest.jsp",
//            title : "采购退货打印",
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

                    nui.get("guestId").enable();

                    basicInfoForm.reset();
                    rightGrid.clearRows();
                    
                    var newRow = { serviceId: '新采退退货', auditSign: 0};
                    leftGrid.addRow(newRow, 0);
                    leftGrid.clearSelect(false);
                    leftGrid.select(newRow, false);
                    
                    nui.get("serviceId").setValue("新采购退货");
                    nui.get("billTypeId").setValue("010103");  //010101  收据   010102  普票  010103  增票
//                    nui.get("createDate").setValue(new Date());
                    nui.get("orderDate").setValue(new Date());
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
//        nui.get("createDate").setValue(new Date());
        nui.get("orderDate").setValue(new Date());
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
// var auditUrl = baseUrl+"com.hsapi.cloud.part.invoicing.crud.auditPjSellOrder.biz.ext";
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
//                    var data = supplier[0];
//                    var value = data.id;
//                    var text = data.fullName;
//
//                    var el = nui.get('guestId');
//                    el.setValue(value);
//                    el.setText(text);

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
    if(e.field == 'storeId'){
    	editor.setData(storehouse);
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
function addMorePart(){
    var row = leftGrid.getSelected();
    if(row.auditSign == 1){
        showMsg("此单已提交!","W");
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
function addPart() {
    var row = leftGrid.getSelected();
    if(row){
        if(row.auditSign == 1) {
            return;
        } 
    }

    var guestId = nui.get("guestId").getValue();
    if(!guestId) {
        showMsg("请选择供应商!","W");
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
		cangHash.stock_type_name ="采购退货订单";
		cangHash.stock_type_id =3;
		cangHash.stock_args ="";
		cangHash.direct ="out";
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
		if(!partHash[part_id].cangPartId){
			showMsg("该配件未同步仓先生","W");
			return;
		}
		temp.part_id=partHash[part_id].cangPartId || "" ;
		if(!temp.part_id){
			showMsg("该配件未同步仓先生","W");
			return;
		}
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
        	page   : page,
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
