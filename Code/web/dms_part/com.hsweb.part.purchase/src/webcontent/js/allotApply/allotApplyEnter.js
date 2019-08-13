/**
 * Created by Administrator on 2018/2/23.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var leftGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.allotsettle.queryPjAllotApplyMainList.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.allotsettle.queryPjAllotApplyDetailList.biz.ext";
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
    
            getAllPartBrand(function(data) {
                brandList = data.brand;
                nui.get("partBrandId").setData(brandList);
                brandList.forEach(function(v) {
                    brandHash[v.id] = v;
                });
            });
                quickSearch(6);

                nui.unmask();
            
            
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
function onLeftGridBeforeDeselect(e)
{
    var row = leftGrid.getSelected(); 
    if(row.serviceId == '新调拨申请'){

        leftGrid.removeRow(row);
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
                if(record.status == 0) {
                    e.cellHtml = "草稿";
                } else if(record.settleStatus == 1) {
                    e.cellHtml = "部分入库";
                } else if(record.settleStatus == 2) {
                    e.cellHtml = "已入库";
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
            gsparams.auditSign = 0;
            break;
        case 7:
            querytypename = "已入库";
            querysign = 2;
            gsparams.isDisabled = 0;
            gsparams.auditSign = 1;
            break;
        case 8:
            querytypename = "已作废";
            querysign = 2;
            gsparams.isDisabled = 1;
            gsparams.auditSign = null;
            break;
        case 9:
            gsparams.billStatusId = null;
            querytypename = "所有";
            querysign = 2;
            gsparams.isDisabled = null;
            gsparams.auditSign = null;
            break;
        default:
            params.today = 1;
            params.startDate = getNowStartDate();
            params.endDate = addDate(getNowEndDate(), 1);
            querytypename = "草稿";
            gsparams.startDate = getNowStartDate();
            gsparams.endDate = addDate(getNowEndDate(), 1);
            gsparams.isDisabled = 0;
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
        nui.get("auditBtn").enable();
        nui.get("saveBtn").enable();
        nui.get("deletePartBtn").enable();
    }
    else
    {
        nui.get("auditBtn").disable();
        nui.get("saveBtn").disable();
        nui.get("deletePartBtn").disable();
    }
}
var requiredField = {
    guestId : "调出方",
    orderDate : "调拨申请日期"
};
var saveUrl = baseUrl + "com.hsapi.cloud.part.invoicing.allotsettle.savePjAllotApply.biz.ext";
function save(type) {
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
    if(type == 1) {
        stip = "提交成功";
        etip = "提交失败";
    }

    nui.ajax({
        url : saveUrl,
        type : "post",
        data : JSON.stringify({
            main : data,
            detailAdd : detailAdd,
            detailUpdate : detailUpdate,
            detailDelete : detailDelete,
            auditSign : type,
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
    data.isDiffOrder = 1;
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
    params.orderTypeId = 1;
    params.isDiffOrder= 1;
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
        default:
            break;
    }
}

var delUrl = baseUrl+"com.hsapi.cloud.part.invoicing.allotsettle.updatePjAllotApplyDisabled.biz.ext";
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

var auditUrl = baseUrl+"com.hsapi.cloud.part.invoicing.allotsettle.auditAllotApplyEnter.biz.ext";
function submit()
{
    var formJsonThis = nui.encode(basicInfoForm.getData());
    var rows = rightGrid.getChanges();

    if(formJson != formJsonThis) {
        showMsg("请先保存数据再入库","W");
        return;
    }
    if(rows && rows.length > 0) {
        if(rows.length > 1 || (rows.length == 1 && rows[0].partId)) {
            showMsg("请先保存数据再入库","W");
            return;
        }
    }

    var row = leftGrid.getSelected();
    if(row){
        if(row.auditSign == 1) {
            showMsg("此单已入库!","W");
            return;
        } 
    }else{
        return;
    }

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '数据处理中...'
    });

    nui.ajax({
        url : auditUrl,
        type : "post",
        data : JSON.stringify({
            mainId : row.id,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                showMsg("入库成功","S");
                //onLeftGridRowDblClick({});
                var pjAllotApplyMainList = data.pjAllotApplyMainList;
                if(pjAllotApplyMainList && pjAllotApplyMainList.length>0) {
                    var leftRow = pjAllotApplyMainList[0];
                    var row = leftGrid.getSelected();
                    leftGrid.updateRow(row,leftRow);

                    //保存成功后重新加载数据
                    loadMainAndDetailInfo(leftRow);

                    
                }
            } else {
                showMsg(data.errMsg || "入库失败","E");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            nui.unmask(document.body);
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
    var openUrl = webPath + contextPath+"/purchase/allotPrint/allotApplyInPrint.jsp";

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
//    rightGrid.setData([]);
//    add();
    
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
                    
                    var guestId = nui.get("guestId");
                    guestId.focus();

                    selectApply();

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

        var guestId = nui.get("guestId");
        guestId.focus();

        selectApply();
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
    }
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

function selectApply() {
    var data = basicInfoForm.getData();
    var mainId = data.id;
    var row = leftGrid.getSelected();
    if(row){
        if(row.auditSign == 1) {
            showMsg("此单已提交!","W");
            return;
        } 
    }else{
        return;
    }

    nui.open({
        // targetWindow: window,,
        url : webPath+contextPath+"/com.hsweb.cloud.part.purchase.allotApplyChoose.flow?token="+token,
        title : "调拨申请单选择",
        width : 980,
        height : 560,
        allowDrag : true,
        allowResize : true,
        onload : function() {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setInitData();
        },
        ondestroy : function(action) {
            if (action == 'ok') {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();

                generateApplyToEnter(data.apply.id, mainId);

            }
        }
    });
}

var geneUrl = baseUrl+"com.hsapi.cloud.part.invoicing.allotsettle.allotApplyEnter.biz.ext";
function generateApplyToEnter(mainId, id) {
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '处理中...'
    });

    nui.ajax({
        url : geneUrl,
        type : "post",
        data : JSON.stringify({
            mainId : mainId,
            id : id,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                var pjAllotApplyMainList = data.pjAllotApplyMainList;
                if(pjAllotApplyMainList && pjAllotApplyMainList.length>0) {
                    var leftRow = pjAllotApplyMainList[0];
                    var row = leftGrid.getSelected();
                    leftGrid.updateRow(row,leftRow);

                    //保存成功后重新加载数据
                    loadMainAndDetailInfo(leftRow);

                    
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
