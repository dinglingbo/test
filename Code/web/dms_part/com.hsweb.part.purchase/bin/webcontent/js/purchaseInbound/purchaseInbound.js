/**
 * Created by Administrator on 2018/1/24.
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
var partBrandIdHash = {};
$(document).ready(function(v)
{
	leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);
    leftGrid.on("beforeload",function(e){
    	e.data.token = token;
    });
    leftGrid.on("drawcell",function(e){
        var record = e.record,
            column = e.column,
            field = e.field,
            value = e.value;

        //将单据状态文本替换成图片
        if (field == "billStatus") {

            if (e.value == 0) {
                console.log('OK' + e.value);
                e.cellHtml = "<span class='icon-edit' style='width:20px;height:20px;display:block;'></span>"
            } else if (e.value == 1) {
                e.cellHtml = "<span class='icon-ok' style='width:20px;height:20px;display:block;'></span>"
            } else if (e.value == 2) {
                e.cellHtml = "<span class='icon-lock' style='width:20px;height:20px;display:block;'></span>"
            }
        }
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
        var billTaxRate = nui.get("billTaxRate").getValue();
        if(value == "010101")
        {
            nui.get("taxSign").setValue(0);
            billTaxRate = "0.07";
        }
        else{
            nui.get("taxSign").setValue(1);
            if(value == "010103")
            {
                billTaxRate = "0.17";
            }
            else{
                billTaxRate = "0.07";
            }
        }
        nui.get("billTaxRate").setValue(billTaxRate);
        reCalculateRightGridData();
    });
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
            billTypeId:BILL_TYPE,//票据类型
            settType:SETT_TYPE //结算方式
        },function(){
            initRoleMembers({
                buyer:"010806",
                checker:"010810"
            },function(){
                quickSearch(menuBtnDateQuickSearch, currType, '本日');
                var checkerEl = nui.get("checker");
                var buyerEl = nui.get("buyer");
                checkerEl.on("valuechanged",function()
                {
                    var checkerEl = nui.get("checker");
                    if(!checkerEl.getValue()){
                        checkerEl.setValue(currUserName);
                        checkerEl.setText(currUserName);
                    }
                });
                buyerEl.on("valuechanged",function()
                {
                    var buyerEl = nui.get("buyer");
                    if(!buyerEl.getValue()){
                        buyerEl.setValue(currUserName);
                        buyerEl.setText(currUserName);
                    }
                });
            });
        });
    });
});
function calculateAmt(part)
{
    var taxSign = nui.get("taxSign").getValue();
    var billTaxRate = nui.get("billTaxRate").getValue();
    billTaxRate = parseFloat(billTaxRate);
    if(taxSign === 0 || taxSign === "0")
    {
        part.noTaxUnitPrice = parseFloat(part.noTaxUnitPrice);
        part.taxUnitPrice = part.noTaxUnitPrice * (1+billTaxRate);
    }
    else{
        part.taxUnitPrice = parseFloat(part.taxUnitPrice);
        part.noTaxUnitPrice = part.taxUnitPrice / (1+billTaxRate);

    }
    part.taxSign = taxSign;
    part.taxRate = billTaxRate;
    part.taxAmt = part.taxUnitPrice * part.enterQty;
    part.noTaxAmt = part.noTaxUnitPrice * part.enterQty;
    part.taxRateAmt = part.taxAmt - part.noTaxAmt;
    part.outableQty = part.enterQty;
    part.noTaxAmt = part.noTaxAmt.toFixed(2);
    part.taxAmt = part.taxAmt.toFixed(2);
    part.taxRateAmt = part.taxRateAmt.toFixed(2);
    part.noTaxUnitPrice = part.noTaxUnitPrice.toFixed(2);
    part.taxUnitPrice = part.taxUnitPrice.toFixed(2);
}
function reCalculateRightGridData()
{
    var data = rightGrid.getData();
    for(var i=0;i<data.length;i++)
    {
        var tmp = data[i];
        calculateAmt(tmp);
        editPartHash[tmp.detailId] = tmp;
    }
    rightGrid.setData(data);
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
    var buyerEl = nui.get("buyer");
    checkerEl.setValue(row.storeKeeper);
    checkerEl.setText(row.storeKeeper);
    buyerEl.setValue(row.buyer);
    buyerEl.setText(row.buyer);
    nui.get("guestId").setText(row.guestFullName);
    if(row.billTypeId == "010101")
    {
        nui.get("taxSign").setValue(0);
    }
    else{
        nui.get("taxSign").setValue(1);
    }
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
	params.enterTypeId = '050101';
	leftGrid.load({
		params : params
	}, function() {
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
//    advancedSearchForm.clear();
    advancedSearchWin.hide();
}
function addInbound()
{
	basicInfoForm.clear();
	var storeList = nui.get("storeId").getData()||[];
    var billTypeIdList = nui.get("billTypeId").getData()||[];
    var settTypeList = nui.get("settType").getData()||[];
    var billTaxRate = "0.07";
    var taxSign = 1;
    if(billTypeIdList[0].customid == "010101")
    {
        taxSign = 0;
    }
    else if(billTypeIdList[0].customid == "010103")
    {
        billTaxRate = "0.17";
    }
    var data = {
        enterDate:(new Date()),
        totalAmt:0,
        settType:settTypeList[0].customid,
        billTypeId:billTypeIdList[0].customid,
        storeId:storeList[0].id,
        billTaxRate:billTaxRate,
        taxSign:taxSign
    };
    basicInfoForm.setData(data);
    var checkerEl = nui.get("checker");
    var buyerEl = nui.get("buyer");
    checkerEl.setValue(currUserName);
    checkerEl.setText(currUserName);
    buyerEl.setValue(currUserName);
    buyerEl.setText(currUserName);
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
	storeId : "仓库",
	guestId : "供应商",
	billTypeId : "票据类型",
	billCode:"票据号"
};
var saveUrl = baseUrl + "com.hsapi.part.purchase.crud.savePtsEnter.biz.ext";
function save() {
	var data = basicInfoForm.getData();
	for ( var key in requiredField) {
		if(!data[key] || data[key].toString().trim().length==0)
        {
            nui.alert(requiredField[key]+"不能为空");
            return;
        }
	}
	if(supplier)
    {
        data.guestFullName = supplier.fullName;
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
    data.payableAmt = data.taxSign==0?data.goodsAmt:data.taxAmt;
    data.totalAmt = data.payableAmt;
    data.billStatus = data.billStatus||0;
    data.enterTypeId = '050101';
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
        title: "选择配件", width: 900, height: 600,
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
            part.partCode = part.code;
            part.partName = part.name;
            part.partFullName = part.fullName;
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
                console.log(enterDetail);
                var detail = {};
                detail.partId = part.id;
                detail.partCode = part.code;
                detail.partName = part.name;
                detail.partNameId = part.partNameId;
                detail.partFullName = part.fullName;
                detail.applyCarModel = part.applyCarModel;
                detail.unit = part.unit;
                detail.partBrandId = part.partBrandId;
                detail.storeLocation = enterDetail.storeLocation;
                detail.storeLocationId = enterDetail.storeLocationId;
                detail.remark = enterDetail.remark;
                detail.enterQty = enterDetail.enterQty;
                detail.noTaxUnitPrice = enterDetail.unitPrice;
                detail.taxAmt = enterDetail.unitPrice;
                calculateAmt(detail);
                console.log(detail);
                rightGrid.addRow(detail);
            }
        }
    });
}
function addPart() {
	selectPart(function(data) {
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
            if(part.taxSign == 0)
            {
                part.unitPrice = part.noTaxUnitPrice;
            }
            else{
                part.unitPrice = part.taxUnitPrice;
            }
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
                var billTypeId = nui.get("billTypeId").getValue();
                console.log(enterDetail);
                part.enterQty = enterDetail.enterQty;
                part.noTaxUnitPrice = enterDetail.unitPrice;
                part.taxUnitPrice = enterDetail.unitPrice;
                calculateAmt(part);
                part.storeLocation = enterDetail.storeLocation;
                part.storeLocationId = enterDetail.storeLocationId;
                console.log(part);
                rightGrid.updateRow(part,part);
                editPartHash[part.detailId] = part;
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
    var billTypeCode = "RKD";
    getCompBillNO(billTypeCode,function(data)
    {
        data = data||{};
        var code = data.serviceno;
        callback({
            code:code
        });
    });
}