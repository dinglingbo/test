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

    menuBtnDateQuickSearch = nui.get("menuBtnDateQuickSearch");
    menuBtnStatusQuickSearch = nui.get("menuBtnStatusQuickSearch");
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    basicInfoForm = new nui.Form("#basicInfoForm");
    //console.log("xxx");

    getStorehouse(function(data)
    {
        var storehouse = data.storehouse||[];
        nui.get("storeId").setData(storehouse);

        initDicts({
            backReasonId:BACK_REASON //采购退货原因
        },function(){
            quickSearch(menuBtnDateQuickSearch, currType, '本日');
        });
    });

});
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
function loadRightGridData(outId)
{
    editPartHash={};
    rightGrid.load({
        outId:outId
    });
}
function reloadLeftGrid(){
    leftGrid.reload();
}
function onLeftGridDrawCell(e)
{
    switch (e.field){
        case "billStatus":
            if(billStatusHash && billStatusHash[e.value])
            {
                e.cellHtml = billStatusHash[e.value];
            }
            break;
    }
}

var currType = 0;
function quickSearch(ctlid, value, text){
    ctlid.setValue(value);
    ctlid.setText(text);
    currType = value;
    onSearch();
}

function onSearch(){
    doSearch(getSearchParam())
}
function getSearchParam(){
    var params = {};
    params.id = nui.get("outId").getValue();

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
    params = params||{};
    params.outTypeId = '050205';//盘亏出库
    leftGrid.load({
        params:params
    },function(){
 //       onLeftGridRowDblClick({});
    });
}
function advancedSearch()
{
    advancedSearchWin.show();
 //   advancedSearchForm.clear();
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
//    advancedSearchForm.clear();
    advancedSearchWin.hide();
}
function addInbound()
{
	basicInfoForm.clear();
	var storeList = nui.get("storeId").getData();
    var data = {
        outDate:(new Date()),
        totalAmt:0,
        storeId:storeList[0].id,
        seller:currUserName
    };
    basicInfoForm.setData(data);
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
        	var saveEnterMainBtn = nui.get("saveEnterMainBtn");
            var cancelEditEnterMainBtn = nui.get("cancelEditEnterMainBtn");
            cancelEditEnterMainBtn.disable();
            saveEnterMainBtn.disable();

            var addPartBtn = nui.get("addPartBtn");
            var editPartBtn = nui.get("editPartBtn");
            var deletePartBtn = nui.get("deletePartBtn");
            addPartBtn.disable();
            editPartBtn.disable();
            deletePartBtn.disable();
            
            onLeftGridRowDblClick({});
        }
    });
}
var requiredField = {
    storeId:"仓库"
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
    var list = rightGrid.getData();
    data.outTotalQty = 0;
    data.trueCost = 0;
    data.taxAmt = 0;
    data.totalDiscountAmt = 0;
    data.goodsAmt = 0;
    data.totalAmt = 0;
    for(var i=0;i<list.length;i++)
    {
    	var row = list[i];
        data.outTotalQty += parseInt(row.outQty);
        data.trueCost += parseFloat(row.costAmt);
        data.taxAmt += parseFloat(row.taxAmt);
        data.totalDiscountAmt += parseFloat(row.discountAmt);
        data.goodsAmt += parseFloat(row.noTaxCostAmt);
        data.totalAmt += parseFloat(row.sellAmt);
    }
    data.receivableAmt = data.totalAmt;
    data.outTypeId = '050205';//盘亏出库
    data.billTypeId = '010101';
    data.billStatus = 0;
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

function selectPart(callback)
{
	var storeId = nui.get("storeId").getValue();
    var storeList = nui.get("storeId").getData();
    if(!storeId)
    {
        nui.alert("请选择仓库");
        return;
    }
    nui.open({
        // targetWindow: window,
        url: "com.hsweb.part.common.enterDetailSelect.flow?token=" + token,
        title: "选择入库明细", width: 930, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData({
                storeList:storeList,
                store:{
                    id:storeId
                }
            },callback);
        },
        ondestroy: function (action)
        {
        }
    });
}
function addPart()
{
    selectPart(function(data)
    {
    	var enterDetail = data.enterDetail;
        var outDetail = {
            partCode:enterDetail.partCode,
            partId:enterDetail.partId,
            partName:enterDetail.partName,
            partBrandId:enterDetail.partBrandId,
            partNameId:enterDetail.partNameId,
            partFullName:enterDetail.partFullName,
            applyCarModel:enterDetail.applyCarModel,
            unit:enterDetail.unit,
            outQty:parseInt(enterDetail.outable_qty),
            outBackableQty:parseInt(enterDetail.outable_qty),
            taxSign:enterDetail.taxSign,
            taxRate:enterDetail.taxRate,
            discountRate:100,
            discountAmt:0,
            noTaxCostUnitPrice:enterDetail.noTaxUnitPrice,
            noTaxCostAmt:enterDetail.noTaxAmt,
            taxCostUnitPrice:enterDetail.taxUnitPrice,
            taxCostAmt:enterDetail.taxAmt,
            taxRateAmt:enterDetail.taxRateAmt,
            prevEnterDetailId:enterDetail.detailId,
            rootEnterDetailId:enterDetail.rootEnterDetailId||enterDetail.detailId
        };
        if(outDetail.taxSign == 0)
        {
            outDetail.costUnitPrice = outDetail.noTaxCostUnitPrice;
            outDetail.costAmt = outDetail.noTaxCostAmt;
        }
        else{
            outDetail.costUnitPrice = outDetail.taxCostUnitPrice;
            outDetail.costAmt = outDetail.taxCostAmt;
        }
        outDetail.sellUnitPrice = outDetail.costUnitPrice;
        outDetail.sellAmt = outDetail.costAmt;
        outDetail.discountLastUnitPrice = outDetail.sellUnitPrice;
        outDetail.discountLastAmt = outDetail.sellAmt;
        rightGrid.addRow(outDetail);
    });
}
var editPartHash = {
};
function editPart()
{
    var part = rightGrid.getSelected();
    if(!part)
    {
        return;
    }
    var storeId = nui.get("storeId").getValue();
    nui.open({
        // targetWindow: window,
        url: "com.hsweb.part.purchase.enterDetailEdit.flow?token=" + token,
        title: "数量金额", width: 430, height:210,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
        	var iframe = this.getIFrameEl();
        	part.unitPrice = part.sellUnitPrice;
            iframe.contentWindow.setData({
                part:part,
                storeId:storeId
            });
        },
        ondestroy: function (action)
        {
            if(action == "ok")
            {
            	var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                var enterDetail = data.enterDetail;

                part.enterQty = enterDetail.enterQty;
                part.outableQty = part.enterQty;
                part.noTaxUnitPrice = enterDetail.unitPrice;
                part.noTaxAmt = part.noTaxUnitPrice*part.enterQty;
                part.taxUnitPrice = part.noTaxUnitPrice*(part.taxRate+1.0);
                part.taxAmt = part.taxUnitPrice*part.enterQty;
                part.taxRateAmt = part.taxAmt - part.noTaxAmt;
                //        part.noTaxUnitPrice = part.noTaxUnitPrice.toFixed(2);
                part.noTaxAmt = part.noTaxAmt.toFixed(2);
                part.taxAmt = part.taxAmt.toFixed(2);
                part.taxUnitPrice = part.taxUnitPrice.toFixed(2);
                part.taxRateAmt = part.taxRateAmt.toFixed(2);

                if(part.storeLocationId != enterDetail.storeLocationId)
                {
                    part.storeLocationId = enterDetail.storeLocationId;
                    part.storeLocation = enterDetail.storeLocation;
                }
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
    var billTypeCode = "PKD";
    getCompBillNO(billTypeCode,function(data)
    {
        data = data||{};
        var code = data.serviceno;
        callback({
            code:code
        });
    });
}
