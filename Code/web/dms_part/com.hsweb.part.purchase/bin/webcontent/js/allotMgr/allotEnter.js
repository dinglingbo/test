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
    rightGrid.on("beforeload",function(e){
    	e.data.token = token;
    });
    rightGrid.setUrl(rightGridUrl);

    menuBtnDateQuickSearch = nui.get("menuBtnDateQuickSearch");
    menuBtnStatusQuickSearch = nui.get("menuBtnStatusQuickSearch");
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    basicInfoForm = new nui.Form("#basicInfoForm");
    //console.log("xxx");

    nui.get("billStatus").setData(billStatusList);
    getStorehouse(function(data)
    {
        var storehouse = data.storehouse||[];
        nui.get("storeId").setData(storehouse);

        initComp("guestId",function(){
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
    params.id = nui.get("enterId").getValue();

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
    params.enterTypeId = '050106';//调拨入库
    leftGrid.load({
        params:params
    },function(){
        //onLeftGridRowDblClick({});
    });
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
    if(searchData.enterIdList)
    {
        var tmpList = searchData.enterIdList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i]+"'";
        }
        searchData.enterIdList = tmpList.join(",");
        //console.log(tmpList);
    }
 //   advancedSearchWin.hide();
    doSearch(searchData);
}
function onAdvancedSearchCancel(){
    advancedSearchForm.clear();
    advancedSearchWin.hide();
}
function addInbound()
{
    basicInfoForm.clear();
    var storeList = nui.get("storeId").getData();
    var data = {
        enterDate:(new Date()),
        totalAmt:0,
        billStatus:0,
        guestId:currOrgid,
        buyer:currUserName,
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
    storeId:"仓库"
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
    data.guestFullName = nui.get("guestId").getText();
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
        data.taxAmt += parseFloat(tmp.taxAmt);
        data.goodsAmt += parseFloat(tmp.noTaxAmt);
        data.totalAmt += tmp.taxSign == 0?parseFloat(tmp.noTaxAmt):parseFloat(tmp.taxAmt);
    }
    data.payableAmt = data.totalAmt;
    data.enterTypeId = '050106';
    data.billCode = "0";
    data.billTaxRate = 0;
    data.billTypeId = "010101";
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

function selectPart(callback)
{
    var guestId = nui.get("guestId").getValue();
    var guestFullName = nui.get("guestId").getText();
    nui.open({
        // targetWindow: window,
        url: "com.hsweb.part.common.allotOutSelect.flow",
        title: "选择调拨出库明细", width: 930, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
        	var iframe = this.getIFrameEl();
            iframe.contentWindow.setData({
                guestId:guestId,
                guestFullName:guestFullName,
                partBrandIdHash:partBrandIdHash
            },callback);
        },
        ondestroy: function (action)
        {
        }
    });
}
function calculateAmt(part)
{
	part.taxAmt = part.taxUnitPrice * part.enterQty;
    part.noTaxAmt = part.noTaxUnitPrice * part.enterQty;
    part.taxRateAmt = part.taxAmt - part.noTaxAmt;
    part.outableQty = part.enterQty;
    part.taxAmt = part.taxAmt.toFixed(2);
    part.noTaxAmt = part.noTaxAmt.toFixed(2);
    part.taxRateAmt = part.taxRateAmt.toFixed(2);
}
function addEnterDetail(part)
{
    var enterDetail = {};

    enterDetail.partId = part.partId;
    enterDetail.partCode = part.partCode;
    enterDetail.partName = part.partName;
    enterDetail.partNameId = part.partNameId;
    enterDetail.partFullName = part.partFullName;
    enterDetail.applyCarModel = part.applyCarModel;
    enterDetail.unit = part.unit;
    enterDetail.enterQty = part.outBackableQty;
    enterDetail.taxSign = part.taxSign;
    enterDetail.taxRate = part.taxRate;
    enterDetail.noTaxUnitPrice = part.noTaxCostUnitPrice;
    enterDetail.taxUnitPrice = part.taxCostUnitPrice;
    enterDetail.prevOutDetailId = part.detailId;
    enterDetail.rootEnterDetailId = part.rootEnterDetailId;
    enterDetail.suggestPrice = 0;
    enterDetail.suggestAmt = 0;
    calculateAmt(enterDetail);
    var sourceId = nui.get("sourceId").getValue();
    if(!sourceId || sourceId != part.outId)
    {
        rightGrid.clearRows();
        nui.get("sourceId").setValue(part.outId);
    }
    rightGrid.addRow(enterDetail);
}

function addPart()
{
    selectPart(function(data)
    {
        var part = data.outDetail;
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
    var billTypeCode = "DRD";
    getCompBillNO(billTypeCode,function(data)
    {
        data = data||{};
        var code = data.serviceno;
        callback({
            code:code
        });
    });
}