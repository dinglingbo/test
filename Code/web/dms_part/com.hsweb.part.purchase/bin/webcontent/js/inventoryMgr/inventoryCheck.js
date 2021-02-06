/**
 * Created by Administrator on 2018/3/8.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var leftGridUrl = baseUrl+"com.hsapi.part.common.svr.getLocationListByStoreId.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.part.purchase.crud.getStockListByLocIdList.biz.ext";
var basicInfoForm = null;
var leftGrid = null;
var rightGrid = null;
var storeIdEl = null;
$(document).ready(function(v)
{
    leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);
    leftGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    rightGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    basicInfoForm = new nui.Form("#basicInfoForm");
    storeIdEl = nui.get("storeId");
    storeIdEl.on("valuechanged",function()
    {
        var storeId = storeIdEl.getValue();
        loadLocationList(storeId);
    });
    rightGrid.on("cellendedit",function(e){
        console.log(e);
        if(e.field == "trueQty")
        {
            var row = e.record;
            row.invtLossQty = row.trueQty - row.paperQty;
            rightGrid.updateRow(row,row);
        }
    });
    initData();
});
function initData()
{
    nui.mask({
        html:'数据加载中...'
    });
    getStorehouse(function(data)
    {
        nui.unmask();
        var storeList = data.storehouse||[];
        storeIdEl.setData(storeList);
        addStockCheck();
    });
}
function loadLocationList(storeId)
{
    leftGrid.load({
        storeId:storeId
    });
}
function generateSelected()
{
    var rows = leftGrid.getSelecteds();
    if(rows<=0)
    {
        nui.alert("请选择要生成的仓位");
        return;
    }
    generateDetail(rows);
}
function generateAll()
{
    var rows = leftGrid.getData();
    if(rows<=0)
    {
        nui.alert("当前仓位没有仓位，请选择别的仓库");
        return;
    }
    generateDetail(rows);
}
var deleteList = [];
var deleteHash = {};
function generateDetail(locList)
{
    var idList = "";
    for(var i=0;i<locList.length;i++)
    {
        if(i>0)
        {
            idList += ",";
        }
        idList += locList[i].id;
    }
    var list = rightGrid.getData();
    if(list.length>0)
    {
        nui.confirm("生成之前将先清空盘点列表，是否继续？",function(action)
        {
            if(action == "ok")
            {
                for(var i=0;i<list.length;i++)
                {
                    var v = list[i];
                    if(v.id && !deleteHash[v.id])
                    {
                        deleteHash[v.id] = 1;
                        deleteList.push(v);
                    }
                }
                getStockListByLocIdList(idList);
            }
        });
    }
    else{
        getStockListByLocIdList(idList);
    }
}
function getStockListByLocIdList(idList)
{
	if(idList && idList.length > 0)
    {
        var data = basicInfoForm.getData();
        var generateZero = data.generateZero;
        var param = {
            idList: idList
        };
        if(generateZero == 0)
        {
            param.notGenerateZero = 1;
        }
        rightGrid.load({
            param:param
        });
    }
}

function addStockCheck()
{
	var addCheckMainBtn = nui.get("addCheckMainBtn");
    addCheckMainBtn.disable();
    var removeCheckMainBtn = nui.get("removeCheckMainBtn");
    removeCheckMainBtn.disable();
    var saveCheckMainBtn = nui.get("saveCheckMainBtn");
    saveCheckMainBtn.enable();
    var auditBtn =  nui.get("auditBtn");
    auditBtn.disable();
    nui.get("genreateBtn").enable();
    nui.get("genreateAllBtn").enable();
    nui.get("auditBtn").disable();
    var date = new Date();
    var storeList = storeIdEl.getData();
    var storeId = 0;
    if(storeList.length>0)
    {
        storeId = storeList[0].id;
    }
    var main = {
        orgid:currOrgid,
        checker:currUserName,
        storeId:storeId
    };
    basicInfoForm.setData(main);
    storeIdEl.doValueChanged();
}
function getCheckCode(callback)
{
	var billTypeCode = "PDD";
  //  var checkCode = (new Date).getTime();
    getCompBillNO(billTypeCode,function(data)
    {
     //   console.log(data);
        var checkCode = data.serviceno;
        callback({
            checkCode:checkCode
        });
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
var deleteUrl = baseUrl + "com.hsapi.part.purchase.stockCheck.deleteStockCheck.biz.ext";
function removeStockCheck()
{
    var data = basicInfoForm.getData();
    if(data.id)
    {
        nui.confirm("确定要删除当前盘点单吗？","提示",function(action)
        {
            if(action == "ok")
            {
                nui.mask({
                    html:'删除中...'
                });
                nui.ajax({
                    url:deleteUrl,
                    type:"post",
                    data:JSON.stringify({
                        checkId:data.id,
                        token:token
                    }),
                    success:function(data)
                    {
                        nui.unmask();
                        data = data||{};
                        if(data.errCode == "S")
                        {
                            nui.alert("删除成功");
                            basicInfoForm.clear();
                            rightGrid.clearRows();
                            nui.get("auditBtn").disable();
                            nui.get("genreateBtn").disable();
                            nui.get("genreateAllBtn").disable();
                            nui.get("removeCheckMainBtn").disable();
                            nui.get("saveCheckMainBtn").disable();
                        }
                        else{
                            nui.alert(data.errMsg||"删除失败");
                        }
                    },
                    error:function(jqXHR, textStatus, errorThrown){
                        //  nui.alert(jqXHR.responseText);
                        console.log(jqXHR.responseText);
                    }
                });
            }
        });
    }
}

var requiredField = {
    storeId:"仓库",
    checkName:"盘点名称",
    checker:"盘点人"
};
var saveUrl = baseUrl + "com.hsapi.part.purchase.stockCheck.saveStockCheck.biz.ext";
function save()
{
    var checkMain = basicInfoForm.getData();
    for(var key in requiredField)
    {
        if(!checkMain[key] || checkMain[key].toString().trim().length==0)
        {
            nui.alert(requiredField[key]+"不能为空");
            return;
        }
    }
    var doSave = function()
    {
        checkMain.modifier = currUserName;
        var list = rightGrid.getData();
        var insertDetailList = list.filter(function(v){
            return !v.detailId;
        });
        var upDateDetailList = rightGrid.getChanges("modified")||[];
        upDateDetailList = upDateDetailList.filter(function(v){
            return v.detailId;
        });
        var deleteDetailList = rightGrid.getChanges("removed")||[];
        deleteDetailList = deleteDetailList.filter(function(v){
            return v.detailId;
        });
        //console.log(list);
        //console.log(insertDetailList);
        //console.log(upDateDetailList);
        //console.log(deleteDetailList);
        nui.mask({
            html:'保存中...'
        });
        nui.ajax({
            url:saveUrl,
            type:"post",
            data:JSON.stringify({
                main:checkMain,
                insertDetailList:insertDetailList,
                updateDetailList:upDateDetailList,
                deleteDetailList:deleteDetailList,
                token:token
            }),
            success:function(data)
            {
                nui.unmask();
                data = data||{};
                if(data.errCode == "S")
                {
                    nui.alert("保存成功");
                    var main = data.main;
                    basicInfoForm.setData(main);
                    loadRightGridByMainId(main);
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
    if(!checkMain.id)
    {
        //新增
        checkMain.recorder = currUserName;
        checkMain.auditStatus = 0;
        nui.mask({
            html:'获取单号中...'
        });
        getCheckCode(function(data)
        {
            nui.unmask();
            if(!data || !data.checkCode)
            {
                nui.alert("获取单号失败，无法保存");
                return;
            }
            checkMain.checkCode = data.checkCode;
            doSave();
        });
    }
    else{
        doSave();
    }
}
function loadRightGridByMainId(main)
{
    if(main && main.id)
    {
    	deleteHash = {};
        deleteList = [];
        rightGrid.load({
            mainId:main.id
        });
        nui.get("addCheckMainBtn").enable();
        if(main.auditStatus == 0)
        {
            nui.get("auditBtn").enable();
            nui.get("genreateBtn").enable();
            nui.get("genreateAllBtn").enable();
            nui.get("removeCheckMainBtn").enable();
            nui.get("saveCheckMainBtn").enable();
        }
        else{
            nui.get("auditBtn").disable();
            nui.get("genreateBtn").disable();
            nui.get("genreateAllBtn").disable();
            nui.get("removeCheckMainBtn").disable();
            nui.get("saveCheckMainBtn").disable();
        }
    }
}

function removeDetail()
{
	var row = rightGrid.getSelected();
    if(row)
    {
        if(row.id && !deleteHash[row.id])
        {
            deleteHash[row.id] = row;
            deleteList.push(row);
        }
        rightGrid.removeRow(row,true);
    }
    else{
        nui.alert("请选择要删除的数据")
    }
}

var auditUrl = baseUrl + "com.hsapi.part.purchase.stockCheck.auditStockCheck.biz.ext";
function audit()
{
    var checkMain = basicInfoForm.getData();
    var params = {
        auditor:currUserName,
        checkId:checkMain.id
    };
    var list = rightGrid.getData();
    var profitList = list.filter(function(v){
        return v.invtLossQty > 0;
    });
    var lossList = list.filter(function(v){
        return v.invtLossQty < 0;
    });
    if(profitList.length <= 0  && lossList.length <= 0)
    {
        nui.alert("没有盈亏数据，无法生成盈亏单");
        return;
    }
    nui.mask({
        html:'生成中...'
    });
    getEnterCode(function(data)
    {
        var enterCode = data.code;
        if(!enterCode)
        {
            nui.unmask();
            nui.alert("获取单号失败，无法生成");
            return;
        }
        params.enterCode = enterCode;
        getOutCode(function(data)
        {
            var outCode = data.code;
            if(!outCode)
            {
                nui.unmask();
                nui.alert("获取单号失败，无法生成");
                return;
            }
            params.outCode = outCode;
            params.token = token;
            nui.ajax({
                url:auditUrl,
                type:"post",
                data:JSON.stringify(params),
                success:function(data)
                {
                    nui.unmask();
                    data = data||{};
                    if(data.errCode == "S")
                    {
                        nui.alert("生成盈亏单成功");
                        var main = data.main;
                        basicInfoForm.setData(main);
                        loadRightGridByMainId(main);
                    }
                    else{
                        nui.alert(data.errMsg||"生成盈亏单失败");
                    }
                },
                error:function(jqXHR, textStatus, errorThrown){
                    //  nui.alert(jqXHR.responseText);
                    console.log(jqXHR.responseText);
                }
            });
        });
    });
}

function addDetail()
{
	var list = rightGrid.getData();
    nui.open({
        // targetWindow: window,
        url: "com.hsweb.part.common.partSelectView.flow?token=" + token,
        title: "配件选择",
        width: 900, height: 500,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var params = {
                list:list
            };
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action)
        {
            if(action == "ok")
            {
            	var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                data = data||{};
                var part = data.part;
                console.log(part);
                getCycStoreByPartId(part.id,function(data)
                {
                	data = data||{};
                    if(data.cyc)
                    {
                        var cycStore = data.cyc;
                        var detail = {};
                        detail.applyCarModel = part.applyCarModel;
                        detail.partBrandName = part.partBrandName;
                        detail.partId = part.id;
                        detail.partName = part.name;
                        detail.partFullName = part.fullName;
                        detail.partNameId = part.partNameId;
                        detail.partCode = part.code;
                        detail.unit = part.unit;
                        detail.balaUnitPrice = 0;
                        detail.paperQty = cycStore.stockQty||0;
                        detail.trueQty = detail.paperQty;
                        detail.invtLossQty = 0;
                        detail.storeLocation = cycStore.stockLocation;
                        detail.stockLocationId = cycStore.stockLocationId;
                        rightGrid.addRow(detail);
                    }
                });
            }
        }
    });
}
var getCycStoreByPartIdUrl = baseUrl+"com.hsapi.part.purchase.stockCheck.getCycStoreByPartId.biz.ext";
function getCycStoreByPartId(partId,callback)
{
    var params = {};
    params.partId = partId;
    params.orgid = currOrgid;
    params.storeId = nui.get("storeId").getValue();
    params.token = token;
    nui.ajax({
        url:getCycStoreByPartIdUrl,
        type:"post",
        data:JSON.stringify(params),
        success:function(data)
        {
            callback && callback(data);
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}

function openCheckMain()
{
    var list = storeIdEl.getData();
    nui.open({
        // targetWindow: window,
        url: "com.hsweb.part.purchase.selectStockCheck.flow?token=" + token,
        title: "盘点单选择",
        width: 900, height: 500,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var params = {
                storeList:list
            };
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action)
        {
            if(action == "ok")
            {
            	var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                data = data||{};
                var stockCheck = data.stockCheck;
                console.log(stockCheck);
                basicInfoForm.setData(stockCheck);
                var addCheckMainBtn = nui.get("addCheckMainBtn");
                addCheckMainBtn.disable();
                var removeCheckMainBtn = nui.get("removeCheckMainBtn");
                removeCheckMainBtn.disable();
                var saveCheckMainBtn = nui.get("saveCheckMainBtn");
                saveCheckMainBtn.enable();
                var auditBtn =  nui.get("auditBtn");
                auditBtn.disable();
                nui.get("auditBtn").disable();
                if(saveCheckMainBtn.auditStatus != 1)
                {
                    nui.get("auditBtn").enable();
                }
                loadRightGridByMainId(stockCheck);
            }
        }
    });    
}