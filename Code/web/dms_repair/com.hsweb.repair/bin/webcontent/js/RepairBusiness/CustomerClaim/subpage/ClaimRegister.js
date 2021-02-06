/**
 * Created by Administrator on 2018/4/16.
 */
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var serviceTypeIdHash = {};
var mtTypeHash = {};
var carBrandHash = {};
var insuranceCompanyHash = {};
var orgHash = {};
var receTypeHash = {};
var itemKindHash = {};
var claimsItemGrid = null;
var claimsItemGridUrl = baseUrl+"com.hsapi.repair.repairService.claims.getClaimsItems.biz.ext";
var claimsPartGrid = null;
var claimsPartGridUrl = baseUrl+"com.hsapi.repair.repairService.claims.getClaimsParts.biz.ext";
var basicInfoForm = null;
var deductRateHash = {};
$(document).ready(function ()
{

});
function init(callback)
{
	claimsItemGrid = nui.get("claimsItemGrid");
    claimsItemGrid.setUrl(claimsItemGridUrl);
    claimsItemGrid.on("drawcell",onDrawCell);
    claimsPartGrid = nui.get("claimsPartGrid");
    claimsPartGrid.setUrl(claimsPartGridUrl);
    claimsPartGrid.on("drawcell",onDrawCell);
    basicInfoForm = new nui.Form("#basicInfoForm");
    var hash = {};
    nui.mask({
        html: '数据加载中..'
    });
    var checkComplete = function () {
        var keyList = ['initDicts','initCarBrand','getDatadictionaries',"getDeductRate"];
        for (var i = 0; i < keyList.length; i++) {
            if (!hash[keyList[i]]) {
                return;
            }
        }
        nui.unmask();
        callback && callback();
    };
    var itemKindList = [];
    itemKindList.push("040701");
    itemKindList.push("040702");
    itemKindList.push("040703");
    getDeductRate(itemKindList,function(data)
    {
        data = data || {};
        var list = data.list || [];
        list.forEach(function (v) {
            deductRateHash[v.itemKind] = v;
        });
        hash.getDeductRate = true;
        checkComplete();
    });
    var pId2 = ITEM_KIND;
    getDatadictionaries(pId2, function (data) {
        data = data || {};
        var list = data.list || [];
        hash.getDatadictionaries = true;
        checkComplete();
    });
    initDicts({
        receType1:RECE_TYPE_1,//收费类型,收费
        receType2:RECE_TYPE_2,//收费类型,免费
        claimsType:CLAIMS_TYPE//索赔类型
    },function(){
        hash.initDicts = true;
        checkComplete();
    });
    initCarBrand("carBrandId",function()
    {
        hash.initCarBrand = true;
        checkComplete();
    });
}


function repairCustomer(){
    nui.open({
        url:"com.hsweb.RepairBusiness.RepairCustomer.flow",
        title:"维修客户选择",width:880,height:500,
        onload:function(){
        },
        ondestroy:function(action){
            if("ok" == action)
            {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                console.log(data);
                var repair = data.repairCustomer;
                nui.get("serviceId").setValue(repair.id);
                nui.get("serviceId").setText(repair.serviceCode);
                nui.get("carNo").setValue(repair.carNo);
                nui.get("carBrandId").setValue(repair.carBrandId);
                nui.get("carModel").setValue(repair.carModel);
                nui.get("mtAdvisor").setValue(repair.mtAdvisor);
                nui.get("contactorName").setValue(repair.contactorName);
                loadRpsItemData();
                loadRpsPartData();
            }
        }
    });
}
var rpsItemGrid = null;
function loadRpsItemData() {
    if (!rpsItemGrid) {
        rpsItemGrid = nui.get("rpsItemGrid");
        var rpsItemGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsItemByServiceId.biz.ext";
        rpsItemGrid.setUrl(rpsItemGridUrl);
        rpsItemGrid.on("drawcell",function(e)
        {
            onDrawCell(e);
        });
    }
    var id = nui.get("serviceId").getValue();
    if (!id) {
        return;
    }
    var params = {
        serviceId: id
    };
    rpsItemGrid.load({
        token:token,
        params: params
    });
}
var rpsPartGrid = null;
function loadRpsPartData() {
    if (!rpsPartGrid) {
        rpsPartGrid = nui.get("rpsPartGrid");
        var rpsItemGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsPartByServiceId.biz.ext";
        rpsPartGrid.setUrl(rpsItemGridUrl);
        rpsPartGrid.on("drawcell",function(e)
        {
            onDrawCell(e);
        });
    }
    var id = nui.get("serviceId").getValue();
    if (!id) {
        return;
    }
    var params = {
        serviceId: id
    };
    rpsPartGrid.load({
        token:token,
        params: params
    });
}
function delItem()
{
    var row = claimsItemGrid.getSelected();
    if(row)
    {
        claimsItemGrid.removeRow(row);
    }
}
function addItem()
{
    var row = rpsItemGrid.getSelected();
    if(row)
    {
        var old = claimsItemGrid.findRow(function(v){
            return v.itemId == row.itemId;
        });
        if(old && old.itemId)
        {
            return;
        }
        var item = {
            itemId:row.itemId,
            itemCode:row.itemCode,
            itemName:row.itemName,
            itemKind:row.itemKind,
            amt:row.subtotal,
            className:row.className,
            worker:row.worker
        };
        claimsItemGrid.addRow(item);
    }
}
function delPart()
{
    var row = claimsPartGrid.getSelected();
    if(row)
    {
        claimsPartGrid.removeRow(row);
    }
}
function addPart()
{
    var row = rpsPartGrid.getSelected();
    if(row)
    {
        var old = claimsPartGrid.findRow(function(v){
            return v.partId == row.partId;
        });
        if(old && old.partId)
        {
            return;
        }
        var item = {
            partId:row.partId,
            partCode:row.partCode,
            partName:row.partName,
            qty:row.qty,
            amt:row.subtotal,
            unitPrice:row.unitPrice
        };
        claimsPartGrid.addRow(item);
    }
}
function save()
{
    var main = basicInfoForm.getData();
    if(!main.claimsType)
    {
        nui.alert("请选择索赔类型!");
        return;
    }
    main.clientDescription = nui.get("clientDescription").getValue();
    main.processDescription = nui.get("processDescription").getValue();
    main.precautions = nui.get("precautions").getValue();
    if(!main.serviceCode)
    {
        getServiceCode(function(data)
        {
            var code = data.code;
            if (!code) {
                nui.unmask();
                nui.alert("获取单号失败");
                return;
            }
            main.serviceCode = code;
            saveClaims(main)
        });
    }
    else {
        saveClaims(main);
    }
}
function saveClaims(claimsMain)
{
    var partAmt = 0;
    var itemAmt = 0;
    var jdDeductAmt = 0;
    var bjDeductAmt = 0;
    var pqDeductAmt = 0;
    var partList = claimsPartGrid.getData();
    partList.forEach(function(v){
        partAmt += v.amt;
    });
    var itemList = claimsItemGrid.getData();
    itemList.forEach(function(v){
        itemAmt += v.amt;
        var tmp,rate=0;
        if(v.itemKind == "040701")
        {
            tmp = deductRateHash["040701"]||{};
            rate = tmp.deductRate||25;
            jdDeductAmt += v.amt * rate / 100;
        }
        else if(v.itemKind == "040702")
        {
            tmp = deductRateHash["040702"]||{};
            rate = tmp.deductRate||25;
            bjDeductAmt += v.amt * rate / 100;
        }
        else if(v.itemKind == "040703")
        {
            tmp = deductRateHash["040703"]||{};
            rate = tmp.deductRate||45;
            pqDeductAmt += v.amt * rate / 100;
        }
    });
    claimsMain.itemAmt = itemAmt;
    claimsMain.partAmt = partAmt;
    claimsMain.jdDeductAmt = jdDeductAmt;
    claimsMain.bjDeductAmt = bjDeductAmt;
    claimsMain.pqDeductAmt = pqDeductAmt;
    var insItems = claimsItemGrid.getChanges("added");
    var insParts = claimsPartGrid.getChanges("added");
    var delItems = claimsItemGrid.getChanges("removed");
    delItems = delItems.filter(function(v){
        return v.id;
    });
    var delParts = claimsPartGrid.getChanges("removed");
    delParts = delParts.filter(function(v){
        return v.id;
    });
    nui.mask({
        html: '保存中..'
    });
    var saveUrl = baseUrl + "com.hsapi.repair.repairService.claims.saveClaims.biz.ext";
    doPost({
        url: saveUrl,
        data: {
            claimsMain: claimsMain,
            insItems:insItems,
            insParts:insParts,
            delItems:delItems,
            delParts:delParts
        },
        success: function (data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                var main = data.claimsMain||{};
                nui.get("serviceCode").setValue(main.serviceCode);
                nui.get("id").setValue(main.id);
                loadClaimsItemGrid();
                loadClaimsPartGrid();
                nui.alert("保存成功");
            }
            else
            {
                nui.alert(data.errMsg||"保存失败")
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            nui.unmask();
            nui.alert("网络出错")
        }
    });
}
function getServiceCode(callback) {
    callback = callback || function () {
        };
    var billTypeCode = "RWD";
    getCompBillNO(billTypeCode, function (data) {
        data = data || {};
        var code = data.serviceno;
        callback && callback({
            code: code
        });
    });
}
function setData(data)
{
    if(data.type == "show")
    {
        nui.get("saveBtn").hide();
        nui.get("okBtn").hide();
    }
    init(function()
    {
        var claimsId = data.claimsId;
        if(claimsId)
        {
            getClaimsMainById(claimsId);
        }
    });

}
function getClaimsMainById(claimsId)
{
    nui.mask({
        html: '数据加载中..'
    });
    var Url = baseUrl + "com.hsapi.repair.repairService.claims.getClaimsMainById.biz.ext";
    doPost({
        url: Url,
        data: {
            params:{
                orgid:currOrgid,
                claimsId:claimsId
            }
        },
        success: function (data)
        {
            nui.unmask();
            data = data||{};
            var main = data.claimsMain||{};
            if(main.id)
            {
                basicInfoForm.setData(main);
                nui.get("serviceId").setText(main.maintainServiceCode);
                nui.get("clientDescription").setValue(main.clientDescription);
                nui.get("processDescription").getValue(main.processDescription);
                nui.get("precautions").getValue(main.precautions);
                loadRpsItemData();
                loadRpsPartData();
                loadClaimsItemGrid();
                loadClaimsPartGrid();
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            nui.unmask();
        }
    });
}
function loadClaimsPartGrid()
{
    var main = basicInfoForm.getData();
    if(main.id)
    {
        claimsPartGrid.load({
            claimsId:main.id
        });
    }

}
function loadClaimsItemGrid()
{
    var main = basicInfoForm.getData();
    if(main.id)
    {
        claimsItemGrid.load({
            claimsId:main.id
        });
    }

}
function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}
function onOk()
{
    var data = basicInfoForm.getData();
    var claimsId = data.id;
    nui.open({
        url: "com.hsweb.RepairBusiness.claimSettlement.flow",
        allowResize:false,
        title: "索赔登记", width: 400, height:320,
        onload: function () {
            var iframe = this.getIFrameEl();
            var data = {
                claimsId:claimsId
            };
            iframe.contentWindow.setData(data);
        },
        ondestroy: function (action)
        {
            if("ok" == action)
            {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                var claimMain = data.claimMain||{};
                claimsSett(claimMain);
            }
        }
    });
}
function claimsSett(claimMain)
{
    if(!claimMain.id)
    {
        return;
    }
    nui.mask({
        html: '过账中..'
    });

    var Url = baseUrl + "com.hsapi.repair.repairService.claims.claimsSett.biz.ext";
    doPost({
        url: Url,
        data: {
            claimId:claimMain.id,
            balanceAmt:claimMain.balanceAmt,
            agioAmt:claimMain.agioAmt,
            otherAmt:claimMain.otherAmt,
            remark:claimMain.remark
        },
        success: function (data)
        {
            nui.unmask();
            data = data||{};
            var main = data.claimsMain||{};
            if(data.errCode == "S")
            {
                if(main.balanceAmt>0)
                {
                    var params = {
                        rpType: -1,
                        guestId: claimMain.guestId,
                        guestFullName: claimMain.guestFullName,
                        serviceId: claimMain.id,
                        serviceCode: claimMain.serviceCode,
                        serviceTypeId: "02020220",
                        rpAmt: claimMain.balanceAmt,
                        billAmt: 0,
                        remark: claimMain.remark,
                        isPrimaryBusiness: 1,
                        rpAmtYes: 0,
                        rpAmtNo: claimMain.balanceAmt
                    };
                    spRpAccountPost(params,function(data)
                    {
                        data = data||{};
                        if(data.errCode == "S")
                        {
                            nui.alert("已经生成应付帐款单。");
                        }
                        else{
                            nui.alert("生成应付帐款单失败。");
                        }
                    });

                }
                else{
                    nui.alert("已经生成应付帐款单。");
                }
            }
            else{
                nui.alert(data.errMsg||"过账失败。");
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            nui.unmask();
        }
    });
}
function spRpAccountPost(params,callback)
{
    var url = window._rootFrmUrl+"com.hsapi.frm.arap.createArapService.biz.ext";
    doPost({
        url:url,
        data:{
            data:params
        },
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                callback && callback();
            }
            else{
                console.log(data.errMsg);
                nui.alert("提交失败");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            console.log(jqXHR.responseText);
            nui.unmask();
            nui.alert("网络出错");
        }
    });
}