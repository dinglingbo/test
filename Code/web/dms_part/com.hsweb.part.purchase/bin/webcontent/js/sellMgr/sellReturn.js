
/**
 * Created by Administrator on 2018/1/31.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var leftGridUrl = baseUrl+"com.hsapi.part.purchase.svr.queryPtsEnterMainList.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.part.purchase.svr.queryPtsEnterDetailByEnterId.biz.ext";
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
function reloadLeftGrid(){
    leftGrid.reload();
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
    params.enterTypeId = '050110';//销售退货
    leftGrid.load({
        params:params
    },function(){
        //onLeftGridRowDblClick({});
    });

    nui.get("searchGuestId").setText("");
    nui.get("searchGuestId").setValue("");
    nui.get("btnEditSupplierAvd").setText("");
    nui.get("btnEditSupplierAvd").setValue("");
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
        storeId:storeList[0].id,
        buyer:currUserName
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
        data.goodsAmt += parseFloat(tmp.noTaxAmt);
        data.payableAmt += parseFloat(tmp.suggestAmt);
    }
    data.totalAmt = data.payableAmt;
    data.enterTypeId = '050110';//销售退货
    data.billCode = "0";
    data.billTypeId = "010101";
    data.billTaxRate = 0;
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
    var main = data;
    var doSave = function()
    {
        nui.ajax({
            url:saveUrl,
            type:"post",
            data:JSON.stringify({
                enterMain:main,
                enterDetailAdd:enterDetailAdd,
                enterDetailUpdate:enterDetailUpdate,
                enterDetailDelete:enterDetailDelete,
                token:token
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
    };
    if(!main.id)
    {
        getEnterCode(function(data)
        {
            data = data||{};
            var enterCode = data.code;
            if(!enterCode)
            {
                nui.unmask();
                nui.alert("获取单号失败，无法保存");
                return;
            }
            main.enterCode = enterCode;
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
        // targetWindow: window,
        url: "com.hsweb.part.common.sellOutSelect.flow?token=" + token,
        title: "选择销售明细", width: 930, height: 560,
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
function calculateAmt(part)
{
    part.suggestAmt = part.suggestPrice * part.enterQty;
    part.noTaxAmt = part.noTaxUnitPrice * part.enterQty;
    part.taxAmt = part.taxUnitPrice * part.enterQty;
    part.taxRateAmt = part.taxAmt - part.noTaxAmt;
    part.outableQty = part.enterQty;

    part.taxAmt = part.taxAmt.toFixed(2);
    part.noTaxAmt = part.noTaxAmt.toFixed(2);
    part.taxRateAmt = part.taxRateAmt.toFixed(2);
    part.suggestAmt = part.suggestAmt.toFixed(2);
}
function addEnterDetail(part)
{
    var enterDetail = {};

    enterDetail.partId = part.partId;
    enterDetail.partCode = part.partCode;
    enterDetail.partName = part.partName;
    enterDetail.partFullName = part.partFullName;
    enterDetail.partNameId = part.partNameId;
    enterDetail.applyCarModel = part.applyCarModel;
    enterDetail.unit = part.unit;
    enterDetail.enterQty = part.outBackableQty;
    enterDetail.taxSign = part.taxSign;
    enterDetail.taxRate = part.taxRate;
    enterDetail.suggestPrice = part.discountLastUnitPrice;
    enterDetail.noTaxUnitPrice = part.noTaxCostUnitPrice;
    enterDetail.taxUnitPrice = part.taxCostUnitPrice;
    enterDetail.prevOutDetailId = part.detailId;
    enterDetail.rootEnterDetailId = part.rootEnterDetailId;
    calculateAmt(enterDetail);
    rightGrid.addRow(enterDetail);
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
    if(!part)
    {
        return;
    }
    nui.open({
        // targetWindow: window,
        url: "com.hsweb.part.purchase.enterDetailEdit.flow?token=" + token,
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

var reviewUrl = baseUrl+"com.hsapi.part.purchase.enterAudit.auditPtsEnterMain.biz.ext";
function review()
{
    var row = leftGrid.getSelected();
    if(!row || !row.id)
    {
        return;
    }
    var params = {
        param:{
            enterId:row.id,
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
function getEnterCode(callback)
{
    var billTypeCode = "XST";
    getCompBillNO(billTypeCode,function(data)
    {
        data = data||{};
        var code = data.serviceno;
        callback({
            code:code
        });
    });
}