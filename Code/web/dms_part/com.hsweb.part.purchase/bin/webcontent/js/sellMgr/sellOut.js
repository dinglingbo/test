/**
 * Created by Administrator on 2018/1/31.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var leftGridUrl = baseUrl+"com.hsapi.part.purchase.svr.queryPtsOutMainList.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.part.purchase.svr.queryPtsOutDetailByOutId.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var basicInfoForm = null;
var leftGrid = null;
var rightGrid = null;
var menuBtnDateQuickSearch = null;
var menuBtnStatusQuickSearch = null;

//单据状态
var billStatusList = [
    {
        customid:'0',
        name:'未审'
    },
    {
        customid:'1',
        name:'未审'
    },
    {
        customid:'2',
        name:'已过账'
    },
    {
        customid:'3',
        name:'已取消'
    }
];
var billStatusHash = {
    "0":"未审",
    "1":"已审",
    "2":"已过账",
    "3":"已取消"
};
var partBrandIdHash = {};
$(document).ready(function(v)
{
    leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);
    leftGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    leftGrid.on("load",function(){
        var data = leftGrid.getData()||[];
        var count = data.length;
        if(count>0)
        {
            onLeftGridRowDblClick({});
        }
        nui.get("leftGridCount").setValue("共"+count+"项");
    });
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    rightGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    rightGrid.on("drawcell",function(e)
    {
        switch (e.field)
        {
            case "partBrandId":
            	if(partBrandIdHash[e.value])
                {
//                    e.cellHtml = partBrandIdHash[e.value].name||"";
                	if(partBrandIdHash[e.value].imageUrl){
                		
                		e.cellHtml = "<img src='"+ partBrandIdHash[e.value].imageUrl+ "'alt='配件图片' height='25px' weight=' '/><br> "+partBrandIdHash[e.value].name||"";
                	}else{
                		e.cellHtml =partBrandIdHash[e.value].name||"";
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

    menuBtnDateQuickSearch = nui.get("menuBtnDateQuickSearch");
    menuBtnStatusQuickSearch = nui.get("menuBtnStatusQuickSearch");
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    basicInfoForm = new nui.Form("#basicInfoForm");
    //console.log("xxx");
    nui.get("billTypeId").on("valuechanged",function()
    {
        var value = nui.get("billTypeId").getValue();
        var billTaxRate = "0.07";
        if(value == "010101")
        {
            nui.get("taxSign").setValue(0);
        }
        else{
            nui.get("taxSign").setValue(1);
            if(value == "010103")
            {
                billTaxRate = "0.17";
            }
        }
        nui.get("billTaxRate").setValue(billTaxRate);
    });
    nui.get("billStatus").setData(billStatusList);
    getAllPartBrand(function(data)
    {
        var partBrandList = data.brand;
        partBrandList.forEach(function(v)
        {
            partBrandIdHash[v.id] = v;
        });
    });
    getStorehouse(function(data)
    {
        var storehouse = data.storehouse||[];
        nui.get("storeId").setData(storehouse);

        initDicts({
            billTypeId:BILL_TYPE //票据类型
        },function(){
            initRoleMembers({
                checker:"010810",//验货员
                seller:"010816"//销售员
            },function(){
                var checkerEl = nui.get("checker");
                var sellerEl = nui.get("seller");
                checkerEl.on("valuechanged",function()
                {
                    var checkerEl = nui.get("checker");
                    if(!checkerEl.getValue()){
                        checkerEl.setValue(currUserName);
                        checkerEl.setText(currUserName);
                    }
                });
                sellerEl.on("valuechanged",function()
                {
                    var sellerEl = nui.get("seller");
                    if(!sellerEl.getValue()){
                        sellerEl.setValue(currUserName);
                        sellerEl.setText(currUserName);
                    }
                });
                quickSearch(menuBtnDateQuickSearch, currType, '本日');
            });
        });
    });

});
function calculateAmt(part)
{
    part.taxCostAmt = part.taxCostUnitPrice * part.outQty;
    part.noTaxCostAmt = part.noTaxCostUnitPrice * part.outQty;
    part.taxCostAmt = part.taxCostUnitPrice * part.outQty;
    part.taxRateAmt = part.taxCostAmt - part.noTaxCostAmt;
    part.costAmt = part.costUnitPrice * part.outQty;
    part.outBackableQty = part.outQty;
    part.taxCostAmt = part.taxCostAmt.toFixed(2);
    part.noTaxCostAmt = part.noTaxCostAmt.toFixed(2);
    part.taxRateAmt = part.taxRateAmt.toFixed(2);
    part.costAmt = part.costAmt.toFixed(2);
}
function onLeftGridDrawCell(e)
{
    var record = e.record,
        column = e.column,
        field = e.field,
        value = e.value;

    //将单据状态文本替换成图片
    if (column.field == "billStatus") {

        if (e.value == 0) {
            console.log('OK' + e.value);
            e.cellHtml = "<span class='icon-edit' style='width:20px;height:20px;display:block;'></span>"
        } else if (e.value == 1) {
            e.cellHtml = "<span class='icon-ok' style='width:20px;height:20px;display:block;'></span>"
        } else if (e.value == 2) {
            e.cellHtml = "<span class='icon-lock' style='width:20px;height:20px;display:block;'></span>"
        }
    }
}
function onLeftGridRowDblClick(e)
{
    var row = e.record;
    if(!row)
    {
        row = leftGrid.getSelected();
    }
    if(!row)
    {
        return;
    }
    //   console.log(row);
    basicInfoForm.setData(row);
    var checkerEl = nui.get("checker");
    var sellerEl = nui.get("seller");
    checkerEl.setValue(row.checker);
    checkerEl.setText(row.checker);
    sellerEl.setValue(row.seller);
    sellerEl.setText(row.seller);
    nui.get("guestId").setText(row.guestFullName);
    var editEnterMainBtn = nui.get("editEnterMainBtn");
    var saveEnterMainBtn = nui.get("saveEnterMainBtn");
    var cancelEditEnterMainBtn = nui.get("cancelEditEnterMainBtn");
    var reViewBtn = nui.get("reViewBtn");
    cancelEditEnterMainBtn.disable();
    saveEnterMainBtn.disable();
    var addPartBtn = nui.get("addPartBtn");
    var editPartBtn = nui.get("editPartBtn");
    var deletePartBtn = nui.get("deletePartBtn");

    addPartBtn.disable();
    editPartBtn.disable();
    deletePartBtn.disable();
    if(row.auditStatus == 0)
    {
        editEnterMainBtn.enable();
        reViewBtn.enable();

    }
    else{
        editEnterMainBtn.disable();
        reViewBtn.disable();
    }
    var outId = row.id;
    loadRightGridData(outId);
}
function reloadLeftGrid(){
    leftGrid.reload();
}
function loadRightGridData(outId)
{
    editPartHash={};
    rightGrid.load({
        outId:outId
    });
}
var currType = 0;
function quickSearch(ctlid, value, text){
    ctlid.setValue(value);
    ctlid.setText(text);
    currType = value;
    onSearch();
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
    params.guestId = nui.get("searchGuestId").getValue();

    var d = menuBtnDateQuickSearch.getValue();

    if (d == 0) {
        params.today = 1;
    } else if (d == 1) {
        params.yesterday = 1;
    }  else if (d == 2) {
        params.thisWeek = 1;
    } else if (d == 3) {
        params.lastWeek = 1;
    } else if (d == 4) {
        params.thisMonth = 1;
    } else if (d == 5) {
        params.lastMonth = 1;
    }

    var s = menuBtnStatusQuickSearch.getValue();

    if (s == 6) {
        params.auditStatus = 0;
    } else if (s == 7) {
        params.auditStatus = 1;
    }  else if (s == 8) {
        params.postStatus = 1;
    }
    return params;
}
function doSearch(params)
{
    params.outTypeId = '050202';//销售出库
    leftGrid.load({
        params:params
    },function(){
    });

    nui.get("searchGuestId").setText("");
    nui.get("searchGuestId").setValue("");
    nui.get("btnEditSupplierAvd").setText("");
    nui.get("btnEditSupplierAvd").setValue("");
}
function advancedSearch()
{
    advancedSearchWin.show();
//    advancedSearchForm.clear();
    if(advancedSearchFormData)
    {
        advancedSearchForm.setData(advancedSearchFormData);
    }
}
function onAdvancedSearchOk()
{
	var searchData = advancedSearchForm.getData();
    var i;
    if(searchData.startDate)
    {
        searchData.startDate = searchData.startDate.substr(0,10);
    }
    if(searchData.endDate)
    {
        searchData.endDate = searchData.endDate.substr(0,10);
    }
    if(searchData.outIdList)
    {
        var tmpList = searchData.outIdList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i]+"'";
        }
        searchData.outIdList = tmpList.join(",");
    }
    advancedSearchWin.hide();
    doSearch(searchData);
}
function onAdvancedSearchCancel(){
 //   advancedSearchForm.clear();
    advancedSearchWin.hide();
}
function addInbound()
{
	basicInfoForm.clear();
    var billTypeList = nui.get("billTypeId").getData()||[];
    var storeList = nui.get("storeId").getData()||[];
    var billTaxRate = "0.07";
    var taxSign = 1;
    if(billTypeList[0].customid == "010101")
    {
        taxSign = 0;
    }
    else if(billTypeList[0].customid == "010103")
    {
        billTaxRate = "0.17";
    }
    var data = {
        outDate:(new Date()),
        totalAmt:0,
        billStatus:0,
        billTypeId:billTypeList[0].customid,
        storeId:storeList[0].id,
        billTaxRate:billTaxRate,
        taxSign:taxSign
    };
    basicInfoForm.setData(data);
    var checkerEl = nui.get("checker");
    var sellerEl = nui.get("seller");
    checkerEl.setValue(currUserName);
    checkerEl.setText(currUserName);
    sellerEl.setValue(currUserName);
    sellerEl.setText(currUserName);
    rightGrid.clearRows();
    var editEnterMainBtn = nui.get("editEnterMainBtn");
    var saveEnterMainBtn = nui.get("saveEnterMainBtn");
    var cancelEditEnterMainBtn = nui.get("cancelEditEnterMainBtn");
    var reViewBtn = nui.get("reViewBtn");
    reViewBtn.disable();
    editEnterMainBtn.disable();
    cancelEditEnterMainBtn.enable();
    saveEnterMainBtn.enable();

    var addPartBtn = nui.get("addPartBtn");
    var editPartBtn = nui.get("editPartBtn");
    var deletePartBtn = nui.get("deletePartBtn");
    addPartBtn.enable();
    editPartBtn.enable();
    deletePartBtn.enable();
}
function editInbound(){
    var editEnterMainBtn = nui.get("editEnterMainBtn");
    var saveEnterMainBtn = nui.get("saveEnterMainBtn");
    var cancelEditEnterMainBtn = nui.get("cancelEditEnterMainBtn");
    var reViewBtn = nui.get("reViewBtn");
    reViewBtn.disable();
    editEnterMainBtn.disable();
    cancelEditEnterMainBtn.enable();
    saveEnterMainBtn.enable();

    var addPartBtn = nui.get("addPartBtn");
    var editPartBtn = nui.get("editPartBtn");
    var deletePartBtn = nui.get("deletePartBtn");
    addPartBtn.enable();
    editPartBtn.enable();
    deletePartBtn.enable();
}
function cancelEditInbound(){

    nui.confirm("确认取消吗？","提示",function(action)
    {
        if(action == "ok")
        {
            onLeftGridRowDblClick({});
        }
    });
}
var requiredField = {
    storeId:"仓库",
    guestId:"供应商",
    billTypeId:"票据类型"
};
var saveUrl = baseUrl+"com.hsapi.part.purchase.crud.savePtsOut.biz.ext";
function save()
{
    var data = basicInfoForm.getData();
    for(var key in requiredField)
    {
    	if(!data[key] || data[key].toString().trim().length==0)
        {
            nui.alert(requiredField[key]+"不能为空");
            return;
        }
    }
    if(customer)
    {
        data.guestFullName = customer.fullName;
    }
    data.outTypeId = "050202";//销售出库
    data.outTotalQty = 0;
    data.trueCost = 0;
    data.taxAmt = 0;
    data.totalDiscountAmt = 0;
    data.goodsAmt = 0;
    data.totalAmt = 0;
    data.receivableAmt = 0;
    var rightGridData = rightGrid.getData();
    console.log(rightGridData);
//    debugger;
    for(var i=0;i<rightGridData.length;i++)
    {
        var tmp = rightGridData[i];
        data.totalAmt += parseFloat(tmp.sellAmt);
        data.taxAmt += parseFloat(tmp.taxCostAmt);
        data.totalDiscountAmt = parseFloat(tmp.discountAmt);
        data.receivableAmt = parseFloat(tmp.discountLastAmt);
        data.trueCost += parseFloat(tmp.costAmt);
        data.goodsAmt += parseFloat(tmp.noTaxCostAmt);
        data.outTotalQty += parseInt(tmp.outQty);
    }
    console.log(data);
    var outDetailAdd = rightGrid.getChanges("added")||[];
    var outDetailUpdate = [];
    for(var key in editPartHash)
    {
        if(typeof editPartHash[key] == 'object')
        {
            outDetailUpdate.push(editPartHash[key]);
        }
    }
    var outDetailDelete = rightGrid.getChanges("removed")||[];
    outDetailDelete = outDetailDelete.filter(function(v)
    {
        return v.detailId;
    });
  //  return;
    nui.mask({
        html:'保存中...'
    });
    var main = data;
    var doSave = function()
    {
        nui.ajax({
            url:saveUrl,
            type:"post",
            data:JSON.stringify({
                outMain:main,
                outDetailAdd:outDetailAdd,
                outDetailUpdate:outDetailUpdate,
                outDetailDelete:outDetailDelete,
                token:token
            }),
            success:function(data)
            {
                nui.unmask();
                data = data||{};
                if(data.errCode == "S")
                {
                    nui.alert("保存成功");
                    quickSearch(currType);
                }
                else{
                    nui.alert(data.errMsg||"保存失败");
                }
            },
            error:function(jqXHR, textStatus, errorThrown){
                //  nui.alert(jqXHR.responseText);
                console.log(jqXHR.responseText);
            }
        });
    };
    if(!main.id)
    {
        getOutCode(function(data)
        {
            data = data||{};
            var outCode = data.code;
            if(!outCode)
            {
                nui.unmask();
                nui.alert("获取单号失败，无法保存");
                return;
            }
            main.outCode = outCode;
            doSave();
        });
    }
    else{
        doSave();
    }
}
var customer = null;
function selectCustomer(elId)
{
    customer = null;
    nui.open({
        // targetWindow: window,
        url: "com.hsweb.part.common.customerSelect.flow?token=" + token,
        title: "客户资料", width: 980, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {

        },
        ondestroy: function (action)
        {
            if(action == 'ok')
            {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                console.log(data);
                console.log(elId);
                customer = data.customer;
                var value = customer.id;
                var text = customer.fullName;
                var el = nui.get(elId);
                el.setValue(value);
                el.setText(text);
            }
        }
    });
}

function selectPart(callback)
{
	var params = {};
	var guestId = nui.get("guestId").getValue();
    if(!guestId)
    {
        nui.alert("请选择客户");
        return;
    }
    var storeId = nui.get("storeId").getValue();
    if(!storeId){
        nui.alert("请选择仓库");
        return;
    }
    params.storeList = nui.get("storeId").getData();
    params.store = {
        id:storeId
    };
    nui.open({
        // targetWindow: window,
        url: "com.hsweb.part.common.enterDetailSelect.flow?token=" + token,
        title: "选择入库明细", width: 930, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData(params,callback);
        },
        ondestroy: function (action)
        {
        }
    });
}
function addEnterDetail(part)
{
    nui.open({
        // targetWindow: window,
        url: "com.hsweb.part.purchase.sellOutDetail.flow?token=" + token,
        title: "销售数量金额", width: 430, height:320,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            part.sellUnitPrice = part.taxSign==1?part.taxUnitPrice:part.noTaxUnitPrice;
            iframe.contentWindow.setData({
                part:part
            });
        },
        ondestroy: function (action)
        {
            if(action == "ok")
            {
            	var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                var outDetail = data.enterDetail;
                
                outDetail.partFullName = part.partFullName;
                outDetail.partNameId = part.partNameId;
                outDetail.partCode = part.partCode;
                outDetail.partName = part.partName;
                outDetail.partId = part.partId;
                outDetail.prevEnterDetailId = part.detailId;
                outDetail.rootEnterDetailId = part.rootEnterDetailId||part.detailId;
                
                outDetail.noTaxCostUnitPrice = part.noTaxUnitPrice;
                outDetail.taxCostUnitPrice = part.taxUnitPrice;
                outDetail.taxSign = part.taxSign;
                outDetail.taxRate = part.taxRate;
                outDetail.costUnitPrice = outDetail.taxSign==1?outDetail.taxCostUnitPrice:outDetail.noTaxCostUnitPrice;
                calculateAmt(outDetail);
                console.log(outDetail);
                rightGrid.addRow(outDetail);
            }
        }
    });
}

function addPart()
{
    selectPart(function(data)
    {
        var part = data.enterDetail;
        console.log(part);
        addEnterDetail(part);
    });
}
var editPartHash = {
};
function editPart()
{
	var part = rightGrid.getSelected();
    console.log(part);
    console.log(rightGrid.getData());
    if(!part)
    {
        return;
    }
    nui.open({
        // targetWindow: window,
        url: "com.hsweb.part.purchase.sellOutDetail.flow?token=" + token,
        title: "销售数量金额", width: 430, height:320,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData({
                part:part
            });
        },
        ondestroy: function (action)
        {
            if(action == "ok")
            {
            	var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                var outDetail = data.enterDetail;
                var billTypeId = nui.get("billTypeId").getValue();
                console.log(outDetail);

                part.sellUnitPrice = outDetail.sellUnitPrice;
                part.outQty = outDetail.outQty;
                part.discountRate = outDetail.discountRate;
                part.discountLastAmt = outDetail.discountLastAmt;
                part.discountLastUnitPrice = outDetail.discountLastUnitPrice;

                calculateAmt(part);
                rightGrid.updateRow(part,part);
                if(part.detailId && !editPartHash[part.detailId])
                {
                    editPartHash[part.detailId] = part;
                }
            }
        }
    });
}
function deletePart(){
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
var reviewUrl = baseUrl+"com.hsapi.part.purchase.outAudit.auditPtsOut.biz.ext";
function review()
{
    var row = leftGrid.getSelected();
    if(!row || !row.id)
    {
        return;
    }
    var params = {
        param:{
            outId:row.id,
            token:token
        }
    };
    nui.mask({
        html:'审核保存中...'
    });
    nui.ajax({
        url:reviewUrl,
        type:"post",
        data:JSON.stringify(params),
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                nui.alert("审核成功");
                quickSearch(currType);
            }
            else{
                nui.alert(data.errMsg||"审核失败");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}

function getOutCode(callback)
{
    var billTypeCode = "XSD";
    getCompBillNO(billTypeCode,function(data)
    {
        data = data||{};
        var code = data.serviceno;
        callback({
            code:code
        });
    });
}