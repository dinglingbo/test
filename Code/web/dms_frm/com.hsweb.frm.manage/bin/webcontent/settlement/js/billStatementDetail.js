/**
 * Created by Administrator on 2018/2/23.
 */
var baseUrl = apiPath + frmApi + "/"; 
var partBaseUrl = apiPath + partApi + "/";
//var leftGridUrl = partBaseUrl+"com.hsapi.part.invoice.settle.queryPJStatementList.biz.ext";
var rightGridUrl = partBaseUrl+"com.hsapi.part.invoice.settle.getPJStatementDetailById.biz.ext";
var innerPchsGridUrl = partBaseUrl+"com.hsapi.part.invoice.svr.queryPjPchsOrderDetailList.biz.ext";
var innerSellGridUrl = partBaseUrl+"com.hsapi.part.invoice.svr.queryPjSellOrderDetailList.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var basicInfoForm = null;
var bottomInfoForm = null;
var rightGrid = null;
var formJson = null;
var brandHash = {};
var brandList = [];
var storehouse = null;
var gsparams = {};
var sOrderDate = null;
var eOrderDate = null;
var billTypeIdHash = {};
var settTypeIdHash = {};
var billTypeIdList = [];
var settTypeIdList = [];
var billTypeIdEl = null;
var settleTypeIdEl = null;
var guestIdEl = null;

var editFormPchsEnterDetail = null;
var innerPchsEnterGrid = null;
var editFormPchsRtnDetail = null;
var innerPchsRtnGrid = null;
var editFormSellOutDetail = null;
var innerSellOutGrid = null;
var editFormSellRtnDetail = null;
var innerSellRtnGrid = null;

//单据状态
var AuditSignList = [
  {
      customid:'0',
      name:'未审'
  },
  {
      customid:'1',
      name:'已审'
  }
];
var AuditSignHash = {
  "0":"未审",
  "1":"已审"
};
var accountSignHash = {
    "0":"未对账",
    "1":"已对账"
};
var enterTypeIdHash = {1:"采购订单",2:"销售订单",3:"采购退货",4:"销售退货",5:"调拨申请",6:"调拨受理"};

$(document).ready(function(v)
{
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    basicInfoForm = new nui.Form("#basicInfoForm");

    innerPchsEnterGrid = nui.get("innerPchsEnterGrid");
    editFormPchsEnterDetail = document.getElementById("editFormPchsEnterDetail");
    innerPchsEnterGrid.setUrl(innerPchsGridUrl);

    innerPchsRtnGrid = nui.get("innerPchsRtnGrid");
    editFormPchsRtnDetail = document.getElementById("editFormPchsRtnDetail");
    innerPchsRtnGrid.setUrl(innerSellGridUrl);

/*    innerSellOutGrid = nui.get("innerSellOutGrid");
    editFormSellOutDetail = document.getElementById("editFormSellOutDetail");
    innerSellOutGrid.setUrl(innerSellGridUrl);

    innerSellRtnGrid = nui.get("innerSellRtnGrid");
    editFormSellRtnDetail = document.getElementById("editFormSellRtnDetail");
    innerSellRtnGrid.setUrl(innerPchsGridUrl);*/

    gsparams.startDate = getNowStartDate();
    gsparams.endDate = addDate(getNowEndDate(), 1);
    gsparams.auditSign = 0;

    billTypeIdEl = nui.get("billTypeId");
    settleTypeIdEl = nui.get("settleTypeId");
    sCreateDate = nui.get("sCreateDate");
    eCreateDate = nui.get("eCreateDate");
    guestIdEl = nui.get("guestId");

    var dictDefs ={"billTypeId":"DDT20130703000008", "settleTypeId":"DDT20130703000035"};
    initDicts(dictDefs,function()
    {
        var billTypeIdList = billTypeIdEl.getData();
        var settTypeIdList = settleTypeIdEl.getData();
        billTypeIdList.filter(function(v)
        {
            billTypeIdHash[v.customid] = v;
            return true;
        });

        settTypeIdList.filter(function(v)
        {
            settTypeIdHash[v.customid] = v;
            return true;
        });

    });
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
   // quickSearch(0);

    $("#guestId").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            var voidAmt = nui.get("voidAmt");
            voidAmt.focus();
        }
    });

    $("#voidAmt").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            var remark = nui.get("remark");
            remark.focus();
        }
    });
});


function onGuestValueChanged(e)
{
    //供应商中直接输入名称加载供应商信息
    var params = {};
    params.pny = e.value;
    setGuestInfo(params);

    var data = rightGrid.getData();
    rightGrid.removeRows(data);
}

var supplier = null;    
function selectSupplier(elId)
{
	 /*nui.get("serviceId").setValue("新对账单");
     nui.get("createDate").setValue(new Date());
     nui.get("stateMan").setValue(currUserName);*/
    supplier = null;
    nui.open({
        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.part.common.guestSelect.flow?token="+token,
        title: "往来单位", width: 980, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var params = {
            	isSupplier: 1,
                guestType:'01020202'
            };
            iframe.contentWindow.setGuestData(params);
        },
        ondestroy: function (action)
        {
            if(action == 'ok')
            {
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
            }
        }
    });
}

function setInitData(params){
	
	if(!params.id){
        add();
    }else{
        nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '数据加载中...'
        });
        basicInfoForm.setData(params);
        
        nui.get("guestId").disable();
        $('#bServiceId').text("订单号："+params.serviceId);
        loadMainAndDetailInfo(params);
        nui.unmask(document.body);
    }
}

function addBill(){
	
    /*var row = leftGrid.getSelected();
    if(row){
        if(row.auditSign == 1) {
            return;
        } 
    }*/
    var data = basicInfoForm.getData();
    if(data.auditSign == 1) {
    	showMsg("此账单已审核，不能添加","W");
        return;
    } 
    var guestId = guestIdEl.getValue();
    if(!guestId){
        showMsg("请选择往来单位!","W");
        return;
    }
    selectPart(guestId,function(rows) {
        
        addDetail(rows);

    },function(serviceId) {
        var rtn = checkBillExists(serviceId);
        return rtn;
    });
}
function selectPart(guestId,callback,checkcallback)
{
    nui.open({
        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.frm.manage.billServiceSelect.flow?token="+token,
        title: "业务单选择", width: 930, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setInitData(guestId,callback,checkcallback);
        },
        ondestroy: function (action)
        {
        }
    });
}
function add()
{
   /*if(checkNew()) 
    {
        showMsg("请先保存数据!","W");
        return;
    }*/
	nui.get("guestId").enable();
    var formJsonThis = nui.encode(basicInfoForm.getData());
    var len = rightGrid.getData().length;

    if(formJson != formJsonThis && len > 0)
    {
        nui.confirm("您正在编辑数据,是否要继续?", "友情提示",
            function (action) { 
                if (action == "ok") {

                  //  setBtnable(true);
                   // setEditable(true);

                    basicInfoForm.reset();
                    rightGrid.clearRows();
                    
                   /* var newRow = { serviceId: '新对账单', auditSign: 0};
                    leftGrid.addRow(newRow, 0);
                    leftGrid.clearSelect(false);
                    leftGrid.select(newRow, false);*/
                    $('#bServiceId').text("订单号: 新对账单");
                   // nui.get("serviceId").setValue("新对账单");
                    nui.get("createDate").setValue(new Date());
                    nui.get("stateMan").setValue(currUserName);
                    
                    var guestId = nui.get("guestId");
                    guestId.focus();

                }else {
                    return;
                }
            }
        );
    }else{
        basicInfoForm.reset();
        rightGrid.clearRows();
        $('#bServiceId').text("订单号: 新对账单");
        nui.get("createDate").setValue(new Date());
        nui.get("stateMan").setValue(currUserName);
        
        var guestId = nui.get("guestId");
        guestId.focus();
    } 
}


var saveUrl = partBaseUrl + "com.hsapi.part.invoice.settle.savePjStatement.biz.ext";
function save() {
    basicInfoForm.validate();
    if (basicInfoForm.isValid() == false) {
        showMsg("请输入数字!","W");
        return;
    }

    var data = basicInfoForm.getData();
    for ( var key in requiredField) {
        if (!data[key] || $.trim(data[key]).length == 0) {
            showMsg(requiredField[key] + "不能为空!","W");
            return;
        }
    }

    var row = basicInfoForm.getData();
    if(row){
        if(row.auditSign == 1) {
            showMsg("此单已审核!","W");
            return;
        } 
    }
    
    data = getMainData();

    var stateDetailAdd = rightGrid.getChanges("added");
    var stateDetailDelete = rightGrid.getChanges("removed");
    var stateDetailList = rightGrid.getData();
    stateDetailList = removeChanges(stateDetailAdd, [], stateDetailDelete, stateDetailList);

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });

    nui.ajax({
        url : saveUrl,
        type : "post",
        data : JSON.stringify({
            stateMain : data,
            stateDetailAdd : stateDetailAdd,
            stateDetailDelete : stateDetailDelete,
            stateDetailList : stateDetailList,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                showMsg("保存成功!","S");
            var list = data.list;
            if(list && list.length>0) {
                var leftRow = list[0];
              basicInfoForm.setData(leftRow);
              nui.get("guestId").disable();
                //保存成功后重新加载数据
               loadMainAndDetailInfo(leftRow);
               $('#bServiceId').text("订单号："+leftRow.serviceId);
            }
            
                //onLeftGridRowDblClick({});
                
            } else {
                showMsg(data.errMsg || "保存失败!","E");
            } 
        },
        error : function(jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
        }
    });
}


//返回类型给srvBottom，用于srvBottom初始化
function confirmType(){
    return "sell";
}
function getParentStoreId(){
    return FStoreId;
}
function loadMainAndDetailInfo(row)
{
    if(row) {    
       basicInfoForm.setData(row);
       //bottomInfoForm.setData(row);
       nui.get("guestId").setText(row.guestName);

       //var row = leftGrid.getSelected();
      /* if(row.auditSign == 1) {
            setBtnable(false);

           document.getElementById("basicInfoForm").disabled=true;
           setEditable(false);
       }else {
            setBtnable(true);

           document.getElementById("basicInfoForm").disabled=false;
           setEditable(true);
       }*/
        
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
   //var row = leftGrid.getSelected(); 
   
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
    });
}
function onLeftGridDrawCell(e)
{
    switch (e.field){
        case "auditSign":
            if(AuditSignHash && AuditSignHash[e.value])
            {
                e.cellHtml = AuditSignHash[e.value];
            }
            break;
    }
}

function setBtnable(flag)
{
    if(flag)
    {
        nui.get("addBillBtn").enable();
        nui.get("deleteBillBtn").enable();
        nui.get("saveBtn").enable();
        nui.get("auditBtn").enable();
    }
    else
    {
        nui.get("addBillBtn").disable();
        nui.get("deleteBillBtn").disable();
        nui.get("saveBtn").disable();
        nui.get("auditBtn").disable();
    }
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
            tmpList[i] = "'"+tmpList[i]+"'";
        }
        searchData.serviceIdList = tmpList.join(",");
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
function onRightGridDraw(e)
{
    switch (e.field)
    {
        case "comPartBrandId":
            if(brandHash && brandHash[e.value])
            {
                e.cellHtml = brandHash[e.value].name;
            }
            break;
        case "billTypeId":
            if(billTypeIdHash && billTypeIdHash[e.value])
            {
                e.cellHtml = billTypeIdHash[e.value].name;
            }
            break;
        case "typeCode":
            if(enterTypeIdHash && enterTypeIdHash[e.value])
            {
                e.cellHtml = enterTypeIdHash[e.value];
            }
            break;
        case "settleTypeId":
            if(settTypeIdHash && settTypeIdHash[e.value])
            {
                e.cellHtml = settTypeIdHash[e.value].name;
            }
            break;
        case "storeId":
            if(storehouse && storehouse[e.value])
            {
                e.cellHtml = storehouse[e.value].name;
            }
            break;
        case "accountSign":
            if(accountSignHash && accountSignHash[e.value])
            {
                e.cellHtml = accountSignHash[e.value];
            }
            break;
        default:
            break;
    }
}
//======
var auditUrl = partBaseUrl+"com.hsapi.part.invoice.settle.auditPjStatement.biz.ext";
function audit()
{
    basicInfoForm.validate();
    if (basicInfoForm.isValid() == false) {
        showMsg("请输入数字!","W");
        return;
    }

    var row = basicInfoForm.getData();
    if(row){
        if(row.auditSign == 1) {
        	showMsg("此单已审核!","W");
            return;
        } 
    }else{
        return;
    }
    var data = getMainData();
    var stateDetailAdd = rightGrid.getChanges("added");
    var stateDetailDelete = rightGrid.getChanges("removed");
    var stateDetailList = rightGrid.getData();
    if(stateDetailList.length<=0){
        showMsg("请添加对账明细!","W");
        return;
    }

    stateDetailList = removeChanges(stateDetailAdd, [], stateDetailDelete, stateDetailList);

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '审核中...'
    });

    nui.ajax({
        url : auditUrl,
        type : "post",
        data : JSON.stringify({
            stateMain : data,
            stateDetailAdd : stateDetailAdd,
            stateDetailDelete : stateDetailDelete,
            stateDetailList : stateDetailList,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
            	var stateMain = data.stateMain;
                //row.auditSign = 1;
                basicInfoForm.setData(stateMain);
                $('#bServiceId').text("订单号："+stateMain.serviceId);
                nui.get("guestId").disable();
                showMsg("审核成功!","S");
            } else {
                showMsg(data.errMsg || "审核失败!","E");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
        }
    });
}

function onShowRowDetail(e) {
    var row = e.record;
    var mainId = row.billMainId;
    
    //将editForm元素，加入行详细单元格内
    var td = rightGrid.getRowDetailCellEl(row);
    var rpDc = row.rpDc;    

    switch (rpDc)
    {
        case -1:
            td.appendChild(editFormPchsEnterDetail);
            editFormPchsEnterDetail.style.display = "";

            var params = {};
            params.mainId = mainId;
            innerPchsEnterGrid.load({
                params:params,
                token: token
            });
            break;
        case 1:
            td.appendChild(editFormPchsRtnDetail);
            editFormPchsRtnDetail.style.display = "";

            var params = {};
            params.mainId = mainId;
            innerPchsRtnGrid.load({
                params:params,
                token: token
            });
            break;
        default:
            break;
    }
}

function checkNew() 
{
    /*var rows = leftGrid.findRows(function(row){
        if(row.serviceId == "新对账单") return true;
    });*/
	var serviceId =$('#bServiceId').text().substr(4);
    if(serviceId == "新对账单"){
    	return true;
    }
    return false;
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
    data.settleTypeId = "020502";
    //汇总明细数据到主表

    if(data.operateDate) {
        data.operateDate = format(data.operateDate, ' yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
    }

    return data;
}
var requiredField = {
    guestId : "往来单位",
    stateMan : "对账员",
    createDate : "对账日期"
};

var getGuestInfo = partBaseUrl+"com.hsapi.part.baseDataCrud.crud.querySupplierList.biz.ext";
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

                    /*var row = leftGrid.getSelected();
                    var newRow = {guestName: text};
                    leftGrid.updateRow(row,newRow);*/

                }
                else
                {
                    var el = nui.get('guestId');
                    el.setValue(null);
                    el.setText(null);

                   /* var row = leftGrid.getSelected();
                    var newRow = {guestName: null};
                    leftGrid.updateRow(row,newRow);*/
                }
            }
            else
            {
                var el = nui.get('guestId');
                el.setValue(null);
                el.setText(null);

                /*var row = leftGrid.getSelected();
                var newRow = {guestName: null};
                leftGrid.updateRow(row,newRow);*/
            }


        },
        error:function(jqXHR, textStatus, errorThrown){
            console.log(jqXHR.responseText);
        }
    });
}


function addDetail(rows)
{
    //var iframe = this.getIFrameEl();
    //var data = iframe.contentWindow.getData();
    for(var i=0; i<rows.length; i++){
        var row = rows[i];
        row.auditDate = format(row.auditDate, 'yyyy-MM-dd HH:mm:ss');
        var newRow = {
            billMainId:row.mainId,
            billServiceId:row.serviceId,
            typeCode:row.orderTypeId,
            rpDc:row.dc,
            billAmt:row.billAmt,
            billTypeId:row.billTypeId,
            settleTypeId:row.settleTypeId,
            orderMan:row.orderMan,
            billDate:row.auditDate,
            remark:row.remark
        };


        rightGrid.addRow(newRow);
    }

}
function checkBillExists(serviceId){
    var row = rightGrid.findRow(function(row){
        if(row.billServiceId == serviceId) {
            return true;
        }
        return false;
    });
    
    if(row) 
    {
        return "业务单"+row.billServiceId+"在对账列表中已经存在!";
    }
    
    return null;
    
}
function deleteBill(){
    var row = basicInfoForm.getData();
    if(row){
        if(row.auditSign == 1) {
        	showMsg("此单已审核，不能删除","W");
            return;
        } 
    }

    var rows = rightGrid.getSelecteds();
    if(rows<=0){
    	showMsg("请选择要删除的数据","W");
    	return;
    }
    rightGrid.removeRows(rows);
}
function onDrawCell(e)
{
    switch (e.field)
    {
        case "comPartBrandId":
            if(brandHash && brandHash[e.value])
            {
                e.cellHtml = brandHash[e.value].name;
            }
            break;
        case "billTypeId":
            if(billTypeIdHash && billTypeIdHash[e.value])
            {
                e.cellHtml = billTypeIdHash[e.value].name;
            }
            break;
        case "enterTypeId":
            if(enterTypeIdHash && enterTypeIdHash[e.value])
            {
                e.cellHtml = enterTypeIdHash[e.value];
            }
            break;
        case "settleTypeId":
            if(settTypeIdHash && settTypeIdHash[e.value])
            {
                e.cellHtml = settTypeIdHash[e.value].name;
            }
            break;
        case "storeId":
            if(storehouse && storehouse[e.value])
            {
                e.cellHtml = storehouse[e.value].name;
            }
            break;
        case "accountSign":
            if(accountSignHash && accountSignHash[e.value])
            {
                e.cellHtml = accountSignHash[e.value];
            }
            break;
        default:
            break;
    }
}
function onLeftGridBeforeDeselect(e)
{
    var row = leftGrid.getSelected(); 
    if(row.serviceId == '新对账单'){

        leftGrid.removeRow(row);
    }
}
//导出
/*function onExport(){
	if (checkNew()) {
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
*/

function onExport(){
	
	var main=basicInfoForm.getData();
	/*if(main.auditSign==0){
		showMsg("清先保存数据!","W");
		return;
	}*/
	var detail = nui.clone(rightGrid.getData());
	
	/*for(var i=0;i<detail.length;i++){
		for(var j=0;j<storehouse.length;j++){
			if(detail[i].storeId==storehouse[j].id){
				detail[i].storeId=storehouse[j].name;
			}
		}
	}
	*/
	if(detail && detail.length > 0){
		setInitExportData(main, detail);
	}else{
		showMsg("请添加对账明细!","W");
	}
}



function setInitExportData(main, detail){
	document.getElementById("eServiceId").innerHTML = main.serviceId?main.serviceId:"";
	document.getElementById("eGuestName").innerHTML = main.guestName?main.guestName:"";
	document.getElementById("eRemark").innerHTML = main.remark?main.remark:"";
    var tds = '<td  colspan="1" align="left">[typeCode]</td>' +
        "<td  colspan='1' align='left'>[billAmt]</td>" +
        "<td  colspan='1' align='left'>[orderMan]</td>" +
        "<td  colspan='1' align='left'>[billDate]</td>" +
        "<td  colspan='1' align='left'>[remark]</td>" +
        "<td  colspan='1' align='left'>[billServiceId]</td>" ;
    var tableExportContent = $("#tableExportContent");
    tableExportContent.empty();
    for (var i = 0; i < detail.length; i++) {
        var row = detail[i];
        
        var tr = $("<tr></tr>");
        tr.append(tds.replace("[typeCode]", detail[i].typeCode?detail[i].typeCode:"")
                     .replace("[billAmt]", detail[i].billAmt?detail[i].billAmt:"")
                     .replace("[orderMan]", detail[i].orderMan?detail[i].orderMan:"")
                     .replace("[billDate]", detail[i].billDate?format(detail[i].billDate, 'yyyy-MM-dd HH:mm:ss'):"")
                     .replace("[remark]", detail[i].remark?detail[i].remark:"")
                     .replace("[billServiceId]", detail[i].billServiceId?detail[i].billServiceId:""));
        tableExportContent.append(tr);
    
    }

    var serviceId = main.serviceId?main.serviceId:"";
    method5('tableExcel',"月结对账"+serviceId,'tableExportA');
} 

