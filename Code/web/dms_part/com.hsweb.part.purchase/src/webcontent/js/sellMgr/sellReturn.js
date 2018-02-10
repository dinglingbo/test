/**
 * Created by Administrator on 2018/1/31.
 */
var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var leftGridUrl = baseUrl+"com.hsapi.part.purchase.svr.queryPtsEnterMainList.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.part.purchase.svr.queryPtsEnterDetailByEnterId.biz.ext";
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
        var dictList = [];
        dictList.push("DDT20130703000072");
        getDictItems(dictList,function(data)
        {
            var dataItems = data.dataItems||[];
            var backReasonId = dataItems.filter(function(v){
                return v.dictid == "DDT20130703000072";
            });
            nui.get("backReasonId").setData(backReasonId);
            quickSearch(2);
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
    var enterId = row.id;
    loadRightGridData(enterId);
}
function loadRightGridData(enterId)
{
    editPartHash={};
    rightGrid.load({
        enterId:enterId
    });
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
var currType = 3;
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
    params.guestId = nui.get("searchGuestId").getValue();
    return params;
}
function doSearch(params)
{
    params.enterTypeId = '050104';//销售退货
    leftGrid.load({
        params:params
    },function(){
        onLeftGridRowDblClick({});
    });
}
function advancedSearch()
{
    advancedSearchWin.show();
  //  advancedSearchForm.clear();
    if(advancedSearchFormData)
    {
        advancedSearchForm.setData(advancedSearchFormData);
    }
}
function onAdvancedSearchOk()
{
    var searchData = advancedSearchForm.getData();
    advancedSearchWin.hide();
    if(searchData.startDate)
    {
        searchData.startDate = searchData.startDate.substr(0,10);
    }
    if(searchData.endDate)
    {
        searchData.endDate = searchData.endDate.substr(0,10);
    }
    if(searchData.enterIdList)
    {
        var tmpList = searchData.enterIdList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i]+"'";
        }
        searchData.enterIdList = tmpList.join(",");
    }
    doSearch(searchData);
}
function onAdvancedSearchCancel(){
  //  advancedSearchForm.clear();
    advancedSearchWin.hide();
}
function addInbound()
{
    basicInfoForm.clear();
    var storeList = nui.get("storeId").getData()||[];
    var data = {
        enterDate:(new Date()),
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
            onLeftGridRowDblClick({});
        }
    });
}
var requiredField = {
    storeId:"仓库",
    guestId:"客户名称"
};
var saveUrl = baseUrl+"com.hsapi.part.purchase.crud.savePtsEnter.biz.ext";
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
    if(customer)
    {
        data.guestFullName = customer.fullName;
    }
    data.enterTotalQty = 0;
    data.taxAmt = 0;
    data.goodsAmt = 0;
    data.payableAmt = 0;
    data.totalAmt = 0;
    var list = rightGrid.getData();
    for(var i=0;i<list.length;i++)
    {
        var tmp = list[i];
        data.enterTotalQty += parseInt(tmp.enterQty);
        data.taxAmt += parseFloat(tmp.taxAmt||0);
        data.totalAmt += parseFloat(tmp.noTaxAmt);
    }
    data.payableAmt = data.totalAmt;
    data.goodsAmt = data.payableAmt;
    data.enterTypeId = '050104';//销售退货
    data.billCode = "1";
    console.log(data);
    var enterDetailAdd = rightGrid.getChanges("added")||[];
    var enterDetailUpdate = [];
    for(var key in editPartHash)
    {
        if(typeof editPartHash[key] == 'object')
        {
            enterDetailUpdate.push(editPartHash[key]);
        }
    }
    var enterDetailDelete = rightGrid.getChanges("removed")||[];
    enterDetailDelete = enterDetailDelete.filter(function(v)
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
            enterMain:data,
            enterDetailAdd:enterDetailAdd,
            enterDetailUpdate:enterDetailUpdate,
            enterDetailDelete:enterDetailDelete
        }),
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                nui.alert("保存成功");
                onLeftGridRowDblClick({});
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
var customer = null;
function selectCustomer(elId)
{
    customer = null;
    nui.open({
        targetWindow: window,
        url: "com.hsweb.part.common.customerSelect.flow",
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
	var storeId = nui.get("storeId").getValue();
    if(!storeId)
    {
        nui.alert("请选择仓库");
        return;
    }
    var guestId = nui.get("guestId").getValue();
    if(!guestId)
    {
        nui.alert("请选择客户");
        return;
    }
    var guestFullName = nui.get("guestId").getText();
    nui.open({
        targetWindow: window,
        url: "../common/sellOutSelectView.html",
        title: "供应商资料", width: 930, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var params = {};
            var storeList = nui.get("storeId").getData();
            params.guestId = guestId;
            params.guestFullName = guestFullName;
            params.storeList = storeList;
            params.store = {
                id:storeId
            };
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
	var enterDetail = {};

    enterDetail.partId = part.partId;
    enterDetail.partCode = part.partCode;
    enterDetail.partName = part.partName;
    enterDetail.applyCarModel = part.applyCarModel;
    enterDetail.unit = part.unit;
    enterDetail.enterQty = part.outBackableQty;
    enterDetail.outableQty = part.outQty;
    enterDetail.taxSign = part.taxSign;
    enterDetail.taxRate = part.taxRate;
    enterDetail.taxRateAmt = part.taxRateAmt;
    enterDetail.noTaxUnitPrice = part.sellUnitPrice;
    enterDetail.noTaxAmt = enterDetail.noTaxUnitPrice * enterDetail.enterQty;
    enterDetail.taxUnitPrice = enterDetail.noTaxUnitPrice * (1 + parseFloat(enterDetail.taxRate));
    enterDetail.taxAmt = enterDetail.taxUnitPrice *  enterDetail.enterQty;

    enterDetail.suggestPrice = 0;
    enterDetail.suggestAmt = 0;
    rightGrid.addRow(enterDetail);
}

function addPart()
{
    selectPart(function(data)
    {
        var part = data.part;
        console.log(part);
        addEnterDetail(part);
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
                console.log(enterDetail);

                part.outableQty = enterDetail.outableQty;
                part.enterQty = enterDetail.enterQty;

                part.noTaxUnitPrice = enterDetail.noTaxUnitPrice;
                part.noTaxAmt = part.noTaxUnitPrice*part.enterQty;

                part.taxUnitPrice = part.noTaxUnitPrice*(1+parseFloat(part.taxRate));
                part.taxAmt = part.taxUnitPrice*part.enterQty;

            //    part.noTaxUnitPrice = part.noTaxUnitPrice.toFixed(2);
                part.noTaxAmt = part.noTaxAmt.toFixed(2);
                part.taxUnitPrice = part.taxUnitPrice.toFixed(2);
                part.taxAmt = part.taxAmt.toFixed(2);

                part.taxRateAmt = part.taxAmt - part.noTaxAmt;
                part.taxRateAmt = part.taxRateAmt.toFixed(2);
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

var reviewUrl = baseUrl+"com.hsapi.part.purchase.crud.auditEnter.biz.ext";
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