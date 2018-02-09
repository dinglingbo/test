/**
 * Created by Administrator on 2018/1/31.
 */
var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var leftGridUrl = baseUrl+"com.hsapi.part.purchase.svr.queryPtsOutMainList.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.part.purchase.svr.queryPtsOutDetailByOutId.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var basicInfoForm = null;
var leftGrid = null;
var rightGrid = null;

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
    leftGrid.on("load",function(){
        onLeftGridRowDblClick({});
    });
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    basicInfoForm = new nui.Form("#basicInfoForm");
    //console.log("xxx");

    nui.get("billStatus").setData(billStatusList);
    getStorehouse(function(data)
    {
        var storehouse = data.storehouse||[];
        nui.get("storeId").setData(storehouse);

        var dictIdList = [];
        dictIdList.push('DDT20130703000072');//采购退货原因
        getDictItems(dictIdList,function(data)
        {
            if(data && data.dataItems)
            {
                var dataItems = data.dataItems||[];
                var backReasonIdList = dataItems.filter(function(v)
                {
                    if(v.dictid == "DDT20130703000072")
                    {
                        //    billTypeIdHash[v.customid] = v;
                        return true;
                    }
                });
                nui.get("backReasonId").setData(backReasonIdList);
                quickSearch(currType);
            }
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
var currType = 2;
function quickSearch(type){
    var params = {};
    switch (type)
    {
        case 0:
            params.today = 1;
            break;
        case 1:
            params.yesterday = 1;
            break;
        case 2:
            params.thisWeek = 1;
            break;
        case 3:
            params.lastWeek = 1;
            break;
        case 4:
            params.thisMonth = 1;
            break;
        case 5:
            params.lastMonth = 1;
            break;
        case 6:
            params.billStatus = 0;
            break;
        case 7:
            params.billStatus = 1;
            break;
        case 8:
            params.billStatus = 2;
            break;
        default:
            break;
    }
    currType = type;
    if($("a[id*='type']").length>0)
    {
        $("a[id*='type']").css("color","black");
    }
    if($("#type"+type).length>0)
    {
        $("#type"+type).css("color","blue");
    }
    doSearch(params);
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
        billStatus:0,
        storeId:storeList[0].id
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
        if(!data[key] || data[key].trim().length==0)
        {
            nui.alert(requiredField[key]+"不能为空");
            return;
        }
    }
    if(supplier)
    {
        data.guestFullName = supplier.fullName;
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
        data.outTotalQty += parseFloat(row.outQty);
        data.trueCost += parseFloat(row.costAmt);
        // data.taxAmt += parseFloat(row.taxAmt);
        data.totalDiscountAmt += parseFloat(row.discountAmt);
        data.goodsAmt += parseFloat(row.noTaxCostAmt);
        data.totalAmt += parseFloat(row.sellAmt);
    }
    data.receivableAmt = data.totalAmt;
    data.outTypeId = '050205';//盘亏出库
    data.billTypeId = '010101';
    data.guestId = "aaa";
    data.guestFullName = "aaa";
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
    nui.ajax({
        url:saveUrl,
        type:"post",
        data:JSON.stringify({
            outMain:data,
            outDetailAdd:outDetailAdd,
            outDetailUpdate:outDetailUpdate,
            outDetailDelete:outDetailDelete
        }),
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                nui.alert("保存成功");
                reloadLeftGrid();
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
        targetWindow: window,
        url: "com.hsweb.part.common.enterDetailSelect.flow",
        title: "选择入库明细", width: 930, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData({
                storeList:storeList,
                enterTypeId:"050105",
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
            applyCarModel:enterDetail.applyCarModel,
            unit:enterDetail.unit,
            outQty:parseInt(enterDetail.enterQty),
            outBackableQty:parseInt(enterDetail.enterQty),
            taxSign:enterDetail.taxSign,
            taxRate:enterDetail.taxRate,
            taxRateAmt:enterDetail.taxRateAmt,
            taxAmt:enterDetail.taxAmt,
            sellUnitPrice:enterDetail.noTaxUnitPrice,
            sellAmt:enterDetail.noTaxAmt,
            discountRate:100,
            discountAmt:0,
            discountLastUnitPrice:enterDetail.taxUnitPrice,
            discountLastAmt:enterDetail.noTaxAmt,
            costUnitPrice:enterDetail.taxUnitPrice,
            costAmt:enterDetail.taxAmt,
            noTaxCostUnitPrice:enterDetail.noTaxUnitPrice,
            noTaxCostAmt:enterDetail.noTaxAmt,
            taxCostUnitPrice:enterDetail.taxUnitPrice,
            taxCostAmt:enterDetail.taxAmt,
            prevEnterDetailId:enterDetail.detailId,
            rootOutDetailId:enterDetail.detailId
        };
        rightGrid.addRow(outDetail)
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
    nui.open({
        targetWindow: window,
        url: "com.hsweb.part.purchase.enterDetailEdit.flow",
        title: "数量金额", width: 430, height:210,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            part.noTaxUnitPrice = part.sellUnitPrice;
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
                var enterDetail = data.enterDetail;
                var billTypeId = nui.get("billTypeId").getValue();
                console.log(enterDetail);
                //       rightGrid.addRow(enterDetail);
                enterDetail.taxSign = 0;
                enterDetail.taxRate = 0.07;
                if(billTypeId == "010103")
                {
                    enterDetail.taxRate = 0.17;
                }
                var totalTaxRate = 1+enterDetail.taxRate;
                enterDetail.taxUnitPrice = (totalTaxRate*enterDetail.noTaxUnitPrice).toFixed(2);//含税单价=税率*
                enterDetail.taxAmt = (enterDetail.taxUnitPrice*enterDetail.enterQty).toFixed(2);//含税总额
                enterDetail.noTaxAmt = (enterDetail.noTaxUnitPrice*enterDetail.enterQty).toFixed(2);//不含税总额
                enterDetail.taxRateAmt = (enterDetail.taxAmt-enterDetail.noTaxAmt).toFixed(2);//税额
                enterDetail.outableQty = enterDetail.enterQty;
                enterDetail.suggestPrice = 0;
                enterDetail.suggestAmt = 0;

                part.taxSign = enterDetail.taxSign;
                part.taxRate = enterDetail.taxRate;
                part.taxUnitPrice = enterDetail.taxUnitPrice;
                part.taxAmt = enterDetail.taxAmt;
                part.noTaxAmt = enterDetail.noTaxAmt;
                part.outableQty = enterDetail.outableQty;
                part.enterQty = enterDetail.enterQty;
                part.noTaxUnitPrice = enterDetail.noTaxUnitPrice;
                part.suggestAmt = enterDetail.suggestAmt;
                part.suggestPrice = enterDetail.suggestPrice;
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
var reviewUrl = baseUrl+"com.hsapi.part.purchase.crud.auditOut.biz.ext";
function review()
{
    var row = leftGrid.getSelected();
    if(!row || !row.id)
    {
        return;
    }
    var params = {
        id:row.id
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
