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
        name:'已审'
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
    leftGrid.on("load",function()
    {
        onLeftGridRowDblClick({})
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
        getOrgList(function(data)
        {
            var orgList = data.orgList;
            nui.get("guestId").setData(orgList);
            quickSearch(currType);
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
    params.id = nui.get("outId").getValue();
    return params;
}
function doSearch(params)
{
    params = params||{};
    params.outTypeId = '050206';//调拨出库
    leftGrid.load({
        params:params
    },function(){
    //    onLeftGridRowDblClick({});
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
 //   advancedSearchForm.clear();
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
        guestId:currOrgid,
        seller:currUserName,
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
    storeId:"仓库",
    guestId:"接收公司"
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
    data.guestFullName = nui.get("guestId").getText();
    data.outTypeId = "050206";//调拨出库
    data.outTotalQty = 0;
    if(!data.id)
    {
        data.trueCost = 0;
    }
    data.billTypeId = '1';
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
        //    data.taxAmt += parseFloat(tmp.taxAmt);
        data.totalDiscountAmt = parseFloat(tmp.discountAmt);
        data.receivableAmt = parseFloat(tmp.discountLastAmt);
        if(!data.id)
        {
            data.trueCost += parseFloat(tmp .costAmt);
        }
    }
    data.goodsAmt = data.totalAmt;
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
function addEnterDetail(part)
{
    nui.open({
        targetWindow: window,
        url: "com.hsweb.part.purchase.sellOutDetail.flow",
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

                outDetail.outBackableQty = outDetail.outQty;
                outDetail.taxSign  = 0;
                outDetail.taxRate = 0.07;
                outDetail.taxRateAmt = 0;
                outDetail.sellAmt = outDetail.outQty * parseFloat(outDetail.sellUnitPrice);
                outDetail.discountAmt = outDetail.sellAmt - outDetail.discountLastAmt;
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
        targetWindow: window,
        url: "com.hsweb.part.purchase.sellOutDetail.flow",
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

            //    var billTypeId = nui.get("billTypeId").getValue();
                console.log(outDetail);
                outDetail.outBackableQty = outDetail.outQty;
                outDetail.sellAmt = outDetail.outQty * parseFloat(outDetail.sellUnitPrice);
                outDetail.discountAmt = outDetail.sellAmt - outDetail.discountLastAmt;

                part.outQty = outDetail.outQty;
                part.outBackableQty = outDetail.outBackableQty;
                part.sellAmt = outDetail.sellAmt;
                part.discountAmt = outDetail.discountAmt.toFixed(2);
                part.discountLastAmt = outDetail.discountLastAmt;
                part.discountRate = outDetail.discountRate;
                part.sellUnitPrice = outDetail.sellUnitPrice;
                part.discountLastUnitPrice = outDetail.discountLastUnitPrice;
                console.log(part);
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
