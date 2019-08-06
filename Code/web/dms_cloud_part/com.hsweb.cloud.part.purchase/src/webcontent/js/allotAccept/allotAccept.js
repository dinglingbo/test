/**
 * Created by Administrator on 2018/2/23.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var leftGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.allotsettle.queryPjAllotAcceptMainList.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.allotsettle.queryPjAllotAcceptDetailList.biz.ext";
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
var oldValue = null;
var oldRow = null;
var guestIdEl=null;
var partShow=0;
var moreSearchShow=0;
var autoNew = 0;
var partIn=null;
var isNeedSet = false;

var AuditSignHash = {
  "0":"草稿",
  "1":"待受理",
  "2":"部分受理",
  "3":"全部受理",
  "4":"已拒绝"
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
        params.isInternal = 1;

        data.params = params;
        e.data =data;
        return;
        
    });
    
    gsparams.startDate = getNowStartDate();
    gsparams.endDate = addDate(getNowEndDate(), 1);
    //gsparams.isOut = 0;

    sOrderDate = nui.get("sOrderDate");
    eOrderDate = nui.get("eOrderDate");

    var dictDefs ={"billTypeId":"DDT20130703000008", "settleTypeId":"DDT20130703000035"};
    initDicts(dictDefs, function(){
        getStorehouse(function(data) {
            storehouse = data.storehouse || [];
            nui.get('storeId').setData(storehouse);
            
            if(storehouse && storehouse.length>0){
                FStoreId = storehouse[0].id;
                nui.get('storeId').setValue(FStoreId);
                storehouse.forEach(function(v){
                    storeHash[v.id]=v;
                });
            }else{
                isNeedSet = true;
            }
    
            //getAllPartBrand(function(data) {
            //    brandList = data.brand;
            //    nui.get("partBrandId").setData(brandList);
            //    brandList.forEach(function(v) {
            //        brandHash[v.id] = v;
            //    });

                quickSearch(6);

                nui.unmask();
            //});
            
        });
        
    });
    
    
    $("#guestId").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            var remark = nui.get("remark");
            remark.focus();
        }
    });

    //add();
    
});

function loadMainAndDetailInfo(row)
{
    if(row) {    
       basicInfoForm.setData(row);
       if(row.isDisabled == 1) {
            $('#status').text("已作废");
       }else {
           $('#status').text(AuditSignHash[row.status]);
       }
       //bottomInfoForm.setData(row);
       nui.get("guestId").setText(row.guestFullName);

       var row = leftGrid.getSelected();
       if(row.auditSign == 1 || row.isDisabled == 1) {
            setBtnable(false);
            document.getElementById("basicInfoForm").disabled=true;
            setEditable(false);
       }else {
            setBtnable(true);
            document.getElementById("basicInfoForm").disabled=false;
            setEditable(true);
       }

       if(row.isDisabled == 1) {
            nui.get("delBtn").setVisible(false);
            nui.get("undelBtn").setVisible(true);
            //document.getElementById("delBtn").childNodes[0].innerHTML = '<span class="fa fa-reply fa-lg"></span>&nbsp;反作废';
       }else {
            nui.get("delBtn").setVisible(true);
            nui.get("undelBtn").setVisible(false);
            //document.getElementById("delBtn").childNodes[0].innerHTML = '<span class="fa fa-remove fa-lg"></span>&nbsp;作废';
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
            //add();
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
        case "status":
            if(record.isDisabled == 1) {
                e.cellHtml = "已作废";
            }else {
                if(AuditSignHash && AuditSignHash[e.value])
                {
                    e.cellHtml = AuditSignHash[e.value];
                }else {
                    e.cellHtml = "草稿";
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
            querytypename = "草稿";
            querysign = 2;
            gsparams.isDisabled = 0;
            gsparams.status = 0;
            gsparams.auditSign = null;
            break;
        case 7:
            querytypename = "已提交";
            querysign = 2;
            gsparams.isDisabled = 0;
            gsparams.status = null;
            gsparams.auditSign = 1;
            break;
        case 8:
            querytypename = "已作废";
            querysign = 2;
            gsparams.isDisabled = 1;
            gsparams.status = null;
            gsparams.auditSign = null;
            break;
        case 9:
            querytypename = "待受理";
            querysign = 2;
            gsparams.isDisabled = null;
            gsparams.status = 1;
            gsparams.auditSign = null;
            break;
        case 10:
            gsparams.billStatusId = 2;
            querytypename = "部分受理";
            querysign = 2;
            gsparams.isDisabled = null;
            gsparams.status = 2;
            gsparams.auditSign = null;
            break;
        case 11:
            gsparams.billStatusId = null;
            querytypename = "全部受理";
            querysign = 2;
            gsparams.isDisabled = null;
            gsparams.status = 3;
            gsparams.auditSign = null;
            break;
        case 12:
            gsparams.billStatusId = null;
            querytypename = "已拒绝";
            querysign = 2;
            gsparams.isDisabled = null;
            gsparams.status = 4;
            gsparams.auditSign = null;
            break;
        case 13:
            gsparams.billStatusId = null;
            querytypename = "所有";
            querysign = 2;
            gsparams.isDisabled = 0;
            gsparams.status = null;
            gsparams.auditSign = null;
            break;
        default:
            params.today = 1;
            params.startDate = getNowStartDate();
            params.endDate = addDate(getNowEndDate(), 1);
            querytypename = "草稿";
            gsparams.startDate = getNowStartDate();
            gsparams.endDate = addDate(getNowEndDate(), 1);
            gsparams.auditSign = 0;
            gsparams.status = null;
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
        nui.get("auditBtn").enable();
        nui.get("saveBtn").enable();
        nui.get("addPartBtn").enable();
        nui.get("deletePartBtn").enable();
        nui.get("selectSupplierBtn").enable();
        //nui.get("genePartBtn").enable();
        nui.get("adjustPartBtn").disable();
    }
    else
    {
        nui.get("auditBtn").disable();
        nui.get("saveBtn").disable();
        nui.get("addPartBtn").disable();
        nui.get("deletePartBtn").disable();
        nui.get("selectSupplierBtn").disable();
        //nui.get("genePartBtn").disable();
        nui.get("adjustPartBtn").enable();
    }
}
var requiredField = {
    guestId : "调入方",
    orderDate : "调拨受理日期"
};
var saveUrl = baseUrl + "com.hsapi.cloud.part.invoicing.allotsettle.savePjAllotAccept.biz.ext";
function save() {
    var data = basicInfoForm.getData();
    var flag=false;
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

    if(type == 1) {
        var msg = checkRightData();
        if(msg){
            showMsg(msg,"W");
            return;
        }
    }
    
    var rightRow =rightGrid.getData();

    data = getMainData();

    var detailAdd = rightGrid.getChanges("added");
    var detailUpdate = rightGrid.getChanges("modified");
    var detailDelete = rightGrid.getChanges("removed");

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '数据处理中...'
    });

    var stip = "保存成功";
    var etip = "保存失败";
    nui.ajax({
        url : saveUrl,
        type : "post",
        async: false,
        data : JSON.stringify({
            main : data,
            detailAdd : detailAdd,
            detailUpdate : detailUpdate,
            detailDelete : detailDelete,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                showMsg(stip,"S");
                //onLeftGridRowDblClick({});
                var pjAllotApplyMainList = data.pjAllotApplyMainList;
                if(pjAllotApplyMainList && pjAllotApplyMainList.length>0) {
                    var leftRow = pjAllotApplyMainList[0];
                    var row = leftGrid.getSelected();
                    leftGrid.updateRow(row,leftRow);

                    //保存成功后重新加载数据
                    loadMainAndDetailInfo(leftRow);
                    flag =true;
                    return flag;

                    
                }
            } else {
                showMsg(data.errMsg || etip,"E");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function getMainData()
{
    var data = basicInfoForm.getData();
    data.orderTypeId = 1;
    data.isDiffOrder = 0;
    delete data.createDate; 
    if(data.operateDate) {
        data.operateDate = format(data.operateDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
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
    params.orderTypeId = 2;
    params.isDiffOrder= 0;
    leftGrid.load({
        params : params,
        token : token
    }, function() {
        nui.unmask();
        //onLeftGridRowDblClick({});
        var data = leftGrid.getData().length;
        if(data <= 0){
            basicInfoForm.reset();
            rightGrid.clearRows();
            
            setBtnable(false);
            setEditable(false);
            
            if(autoNew == 0){
                //add();
                autoNew = 1;
            }
            
        }else {
            var row = leftGrid.getSelected();
            if(row.auditSign == 1 || row.isDisabled == 1) {
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
    searchData.status = gsparams.status;
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
        if(row.serviceId == "新调拨申请") return true;
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
        default:
            break;
    }
}

var delUrl = baseUrl+"com.hsapi.cloud.part.invoicing.allotsettle.updatePjAllotAcceptDisabled.biz.ext";
function del()
{
    var data = basicInfoForm.getData();
    var isDisabled = 1;
    if(data.isDisabled == 1){
        isDisabled = 0;
    }
   
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '处理中...'
    });

    nui.ajax({
        url : delUrl,
        type : "post",
        data : JSON.stringify({
            mainId : data.id,
            isDisabled : isDisabled,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                showMsg("操作成功!","S");
                data.isDisabled = isDisabled;
                var row = leftGrid.getSelected();
                leftGrid.updateRow(row,data);
                basicInfoForm.setData(row);

                if(isDisabled == 1) {
                    //document.getElementById("delBtn").childNodes[0].innerHTML = '<span class="fa fa-reply fa-lg"></span>&nbsp;反作废';
                    nui.get("delBtn").setVisible(false);
                    nui.get("undelBtn").setVisible(true);
                    setBtnable(false);
                    setEditable(false);
                    document.getElementById("basicInfoForm").disabled=false;
                }else {
                    //document.getElementById("delBtn").childNodes[0].innerHTML = '<span class="fa fa-remove fa-lg"></span>&nbsp;作废';
                    nui.get("delBtn").setVisible(true);
                    nui.get("undelBtn").setVisible(false);
                    setBtnable(true);
                    setEditable(true);
                    document.getElementById("basicInfoForm").disabled=true;
                }

            } else {
                showMsg(data.errMsg || "操作失败!","W");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
        }
    });
}

function submit()
{
    save(1);
}

var auditUrl= baseUrl+"com.hsapi.cloud.part.invoicing.allotsettle.updatePjAllotAcceptDisabled.biz.ext";
function audit(){
	 var data = basicInfoForm.getData();
	 var flag =save();
	 if(flag !=true){
		 return;
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
	            mainId : data.id,
	            token : token
	        }),
	        success : function(data) {
	            nui.unmask(document.body);
	            data = data || {};
	            if (data.errCode == "S") {
	                showMsg("出库成功!","S");

	                var row = leftGrid.getSelected();
	                leftGrid.updateRow(row,data);
	                basicInfoForm.setData(row);


	            } else {
	                showMsg(data.errMsg || "出库失败!","W");
	            }
	        },
	        error : function(jqXHR, textStatus, errorThrown) {
	            console.log(jqXHR.responseText);
	        }
	    });

}

function addGuest(){
    nui.open({
        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.cloud.part.basic.supplierDetail.flow?token=" + token,
        title: "供应商资料", width: 570, height: 530,
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
    //add();
    
}
function add()
{
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
                    
                    var newRow = { serviceId: '新调拨申请', auditSign: 0, status: 0, isDisabled: 0};
                    leftGrid.addRow(newRow, 0);
                    leftGrid.clearSelect(false);
                    leftGrid.select(newRow, false);
                    
                    nui.get("serviceId").setValue("新调拨申请");
                    nui.get("status").setValue(0); 
                    nui.get("orderDate").setValue(new Date());
                    nui.get("orderMan").setValue(currUserName);
                    nui.get("storeId").setValue(FStoreId);
                    
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
        
        var newRow = { serviceId: '新调拨申请', auditSign: 0, status: 0, isDisabled: 0};
        leftGrid.addRow(newRow, 0);
        leftGrid.clearSelect(false);
        leftGrid.select(newRow, false);
        
        nui.get("serviceId").setValue("新调拨申请");
        nui.get("status").setValue(0);  
        nui.get("orderDate").setValue(new Date());
        nui.get("orderMan").setValue(currUserName);
        nui.get("storeId").setValue(FStoreId);

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
        if(e.field == "comPartCode"){
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
        if(column.field == "applyQty"){
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
function addInsertRow(value, row) {    
    var guestId = nui.get("guestId").getValue();
    if(!guestId) {
        showMsg("请先选择调出方再添加配件!","W");
        return;
    }
    var params = {partCode:value};
    var part = getPartInfo(params);
    if(part){
        params.partId = part.id;
        params.guestId = guestId;
        var newRow = {
            partId : part.id,
            comPartCode : part.code,
            comPartName : part.name,
            comPartBrandId : part.partBrandId,
            comApplyCarModel : part.applyCarModel,
            comUnit : part.unit,
            applyQty : 1,
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
            if(row.applyQty){
                if(row.applyQty <= 0) return true;
            }else{
                return true;
            }
                    
        }

    });
    
    if(rows && rows.length > 0){
        msg = "请填写申请数量！";
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

        nui.get("guestOrgid").setValue(data.orgid);

        addNewRow(true);
    }
}
var getGuestInfo = baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.querySupplierList.biz.ext";
function setGuestInfo(params)
{
    params.isInternal = 1;
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
        showMsg("请先选择调出方再添加配件!","W");
        return;
    }
    var row = morePartGrid.getSelected();
    if(row){
        var params = {partCode:row.code};
        params.partId = row.id;
        params.guestId = guestId;
        var newRow = {
            partId : row.id,
            comPartCode : row.code,
            comPartName : row.name,
            comPartBrandId : row.partBrandId,
            comApplyCarModel : row.applyCarModel,
            comUnit : row.unit,
            applyQty : 1,
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
        rightGrid.beginEditCell(rightGrid.getSelected(), "applyQty");
        
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
        url: webPath + contextPath + "/com.hsweb.cloud.part.common.partSelectView.flow?token="+token,
        title: "配件选择", width: 930, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var data = {
                orderTypeId: 1,
                guestId: nui.get("guestId").getValue()
            };
            iframe.contentWindow.setCloudPartData("cloudPart",callback,checkcallback);
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
        showMsg("请选择调出方!","W");
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
        var rtn = checkPartIDExists(partid);
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
        return "配件编码："+row.comPartCode+"在计划列表中已经存在，是否继续？";
    }
    
    return null;
    
}
function addDetail(rows)
{
    //var iframe = this.getIFrameEl();
    //var data = iframe.contentWindow.getData();
    var row = rows.part||{};
    if(row) {
        var newRow = {
            partId : row.id,
            comPartCode : row.code,
            comPartName : row.name,
            comPartBrandId : row.fullName,
            comApplyCarModel : row.applyCarModel,
            comUnit : row.unit,
            applyQty : 1,
            orderPrice : 0,
            orderAmt : 0,
            comOemCode : row.oemCode,
            comSpec : row.spec,
            partCode : row.code,
            partName : row.name,
            fullName : row.fullName,
            systemUnitId : row.unit,
            outUnitId : row.unit
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
                guestType:'01020202',
                isInternal: 1
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
                var el = nui.get(elId);
                el.setValue(value);
                el.setText(text);
                nui.get('guestOrgid').setValue(data.orgid);

                if (elId == 'guestId') {
                    var row = leftGrid.getSelected();
                    var newRow = {
                        guestFullName : text
                    };
                    leftGrid.updateRow(row, newRow);

                }
            }
        }
    });
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

var partUrl=baseUrl +"com.hsapi.cloud.part.baseDataCrud.crud.queryPartListByOrgid.biz.ext";
function getPart(partIdList){
//  $.ajaxSettings.async = false;
//  $.post(partUrl+"?params/orgid="+currOrgid+"&params/noPage="+1+"&token="+token,{},function(text){
//      var parts=text.parts;
//      parts.forEach(function(v){
//          partHash[v.id]=v;           
//      });
//  });
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
function adjustPart(){
    var row = leftGrid.getSelected();
    if(row){
        if(row.auditSign != 1) {
            showMsg("此单未提交,不能调整!","W");
            return;
        } 
        if(row.status == 2) {
            showMsg("此单已全部转订单,不能调整!","W");
            return; 
        }

        nui.open({
            // targetWindow: window,
            url: webPath + contextPath + "/com.hsweb.cloud.part.purchase.adjustApplyQty.flow?token=" + token,
            title: "调拨申请调整",
            width: 900, height: 400,
            allowDrag:true,
            allowResize:false,
            onload: function ()
            {
                var iframe = this.getIFrameEl();
                iframe.contentWindow.setInitData(row.id);
            },
            ondestroy: function (action)
            {
              
            }
        });
    }else{
        return;
    }
}