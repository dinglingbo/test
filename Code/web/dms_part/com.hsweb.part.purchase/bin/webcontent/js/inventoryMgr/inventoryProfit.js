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

    nui.get("billStatus").setData(billStatusList);
    getStorehouse(function(data)
    {
        var storehouse = data.storehouse||[];
        nui.get("storeId").setData(storehouse);
        initRoleMembers({
            buyer:"010806"//盘点人
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
    //nui.get("guestId").setText(row.guestFullName);
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
function reloadLeftGrid(){
    leftGrid.reload();
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
	params.enterTypeId = '050105';//盘盈入库
    leftGrid.load({
        params:params
    },function(){
        //onLeftGridRowDblClick({});
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
    }
    data.payableAmt = data.goodsAmt;
    data.totalAmt = data.goodsAmt;
    data.enterTypeId = "050105";
    data.billCode = "0";
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
	nui.open({
        // targetWindow: window,
        url: "com.hsweb.part.common.partSelectView.flow?token=" + token,
        title: "选择配件", width: 930, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData({},callback);
        },
        ondestroy: function (action)
        {
        }
    });
}
function addEnterDetail(part)
{
	var storeId = nui.get("storeId").getValue();
    if(!storeId)
    {
        nui.alert("请先选择仓库");
        return;
    }
	nui.open({
        // targetWindow: window,
        url: "com.hsweb.part.purchase.inBoundCountView.flow?token=" + token,
        title: "入库数量金额", width: 430, height:210,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
        	var iframe = this.getIFrameEl();
            part.partCode = part.partCode||part.code;
            part.partName = part.partName||part.name;
            part.partFullName = part.partFullName||part.fullName;
            part.unitPrice = 0;
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
                enterDetail.taxSign = 0;
                enterDetail.taxRate = 0.07;
                enterDetail.outableQty = enterDetail.enterDetail;
                enterDetail.noTaxUnitPrice = enterDetail.unitPrice;
                delete enterDetail.unitPrice;
                enterDetail.taxUnitPrice = enterDetail.noTaxUnitPrice * (1+enterDetail.taxRate);
                enterDetail.noTaxAmt = enterDetail.noTaxUnitPrice * enterDetail.enterQty;
                enterDetail.taxAmt = enterDetail.taxUnitPrice * enterDetail.enterQty;
                enterDetail.taxRateAmt = enterDetail.taxAmt - enterDetail.noTaxAmt;
                enterDetail.partId = part.id;
                enterDetail.partNameId = part.partNameId;
                enterDetail.unit = part.unit;

          //      enterDetail.noTaxUnitPrice = enterDetail.noTaxUnitPrice.toFixed(2);
                enterDetail.noTaxAmt = enterDetail.noTaxAmt.toFixed(2);
                enterDetail.taxAmt = enterDetail.taxAmt.toFixed(2);
                enterDetail.taxUnitPrice = enterDetail.taxUnitPrice.toFixed(2);
                enterDetail.taxRateAmt = enterDetail.taxRateAmt.toFixed(2);
                console.log(enterDetail);
                rightGrid.addRow(enterDetail);
            }
        }
    });
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
            part.unitPrice = part.noTaxUnitPrice;
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
            //     part.noTaxUnitPrice = part.noTaxUnitPrice.toFixed(2);
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
                quickSearch(menuBtnDateQuickSearch, 0, '本日');
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
    var billTypeCode = "PYD";
    getCompBillNO(billTypeCode,function(data)
    {
        data = data||{};
        var code = data.serviceno;
        callback({
            code:code
        });
    });
}