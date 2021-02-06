/**
 * Created by Administrator on 2018/4/17.
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
var claimsRepairOutGrid = null;
var claimsRepairOutGridUrl = baseUrl+"com.hsapi.repair.repairService.claims.getClaimsRepairOut.biz.ext";
var leftGrid = null;
var leftGridUrl = baseUrl+"com.hsapi.repair.repairService.claims.queryClaimsList4Part.biz.ext";
var repairOutGrid = null;
var repairOutGridUrl = window._rootPartUrl+"com.hsapi.part.purchase.repair.getRepairOutByServiceId.biz.ext";
$(document).ready(function()
{
    repairOutGrid = nui.get("repairOutGrid");
    repairOutGrid.setUrl(repairOutGridUrl);
    claimsRepairOutGrid = nui.get("claimsRepairOutGrid");
    claimsRepairOutGrid.setUrl(claimsRepairOutGridUrl);
    claimsItemGrid = nui.get("claimsItemGrid");
    claimsItemGrid.setUrl(claimsItemGridUrl);
    claimsItemGrid.on("drawcell",onDrawCell);
    claimsPartGrid = nui.get("claimsPartGrid");
    claimsPartGrid.setUrl(claimsPartGridUrl);
    leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);
    leftGrid.on("load",function(){
        var row = leftGrid.getSelected();
        if(row)
        {
            doGetClaimsMainById(row);
        }
    });
    leftGrid.on("rowdblclick",function(e){
        var row = e.record;
        doGetClaimsMainById(row);
    });
    basicInfoForm = new nui.Form("#basicInfoForm");
    var hash = {};
    nui.mask({
        html: '数据加载中..'
    });
    var checkComplete = function () {
        var keyList = ['initDicts','initCarBrand','getDatadictionaries'];
        for (var i = 0; i < keyList.length; i++) {
            if (!hash[keyList[i]]) {
                return;
            }
        }
        nui.unmask();
        onSearch();
    };
    var pId2 = ITEM_KIND;//工种
    getDatadictionaries(pId2, function (data) {
        data = data || {};
        var list = data.list || [];
        hash.getDatadictionaries = true;
        checkComplete();
    });
    initDicts({
        claimsType: CLAIMS_TYPE,//索赔类型
        receType1:RECE_TYPE_1,//收费类型
        receType2:RECE_TYPE_2 //免费类型
    },function(){
        hash.initDicts = true;
        checkComplete();
    });
    initCarBrand("carBrandId",function()
    {
        hash.initCarBrand = true;
        checkComplete();
    });
});
function doGetClaimsMainById(row)
{
    getClaimsMainById(row.id,function(data){
        data = data||{};
        var main = data.claimsMain||{};
        if(main.id)
        {
            basicInfoForm.setData(main);
            nui.get("serviceId").setText(main.maintainServiceCode);
            nui.get("clientDescription").setValue(main.clientDescription);
            nui.get("processDescription").getValue(main.processDescription);
            nui.get("precautions").getValue(main.precautions);
            loadClaimsItemGrid();
            loadClaimsPartGrid();
            loadRepairOutGrid();
            loadClaimsRepairOutGrid()
        }
    });
}
function getSearchParams()
{
    var params = {};

    return params;
}
function onSearch()
{
    var params = getSearchParams();
    doSearch(params);
}
function doSearch(params)
{
    params.orgid = currOrgid;
    leftGrid.load({
        params:params
    });
}
function getClaimsMainById(claimsId,callback)
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
            callback && callback(data);
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
function loadClaimsRepairOutGrid()
{
    var main = basicInfoForm.getData();
    if(main.id)
    {
        claimsRepairOutGrid.load({
            claimsId:main.id
        });
    }

}function loadRepairOutGrid()
{
    var main = basicInfoForm.getData();
    if(main.serviceId)
    {
        repairOutGrid.load({
            serviceId:main.serviceId
        });
    }
}
function addClaimsRepariOut()
{
    var row = repairOutGrid.getSelected();
    if(row)
    {
        var old = claimsRepairOutGrid.findRow(function(v){
            return v.id == row.repairOutId;
        });
        if(old)
        {
            return;
        }
        var main = basicInfoForm.getData();
        var obj = {
            claimId:main.id,
            repairOutId:row.id,
            sourceId:row.sourceId,
            rootId:row.rootId,
            serviceId:row.serviceId,
            carId:row.carId,
            carNo:row.carNo,
            partId:row.partId,
            partCode:row.partCode,
            partName:row.partName,
            unit:row.unit,
            qty:row.outQty,
            costPrice:row.trueUnitPrice,
            costAmt:row.trueCost,
            sellPrice:row.sellUnitPrice,
            sellAmt:row.sellAmt,
            backPrice:row.sellUnitPrice,
            backAmt:row.sellAmt
        };
        nui.mask({
            html: '保存中..'
        });
        var saveUrl = baseUrl + "com.hsapi.repair.repairService.claims.addClaimsRepairOut.biz.ext";
        doPost({
            url: saveUrl,
            data: {
                out:obj
            },
            success: function (data)
            {
                nui.unmask();
                data = data||{};
                if(data.errCode == "S")
                {
                    nui.alert("保存成功");
                    claimsRepairOutGrid.reload();
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
}
function delClaimsRepariOut()
{
    var row = claimsRepairOutGrid.getSelected();
    if(row)
    {
        nui.mask({
            html: '删除中..'
        });
        var delUrl = baseUrl + "com.hsapi.repair.repairService.claims.delClaimsRepairOut.biz.ext";
        doPost({
            url: delUrl,
            data: {
                out:row
            },
            success: function (data)
            {
                nui.unmask();
                data = data||{};
                if(data.errCode == "S")
                {
                    nui.alert("删除成功");
                    claimsRepairOutGrid.reload();
                }
                else
                {
                    nui.alert(data.errMsg||"删除失败")
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
}
function doReturn()
{
    var row = basicInfoForm.getData();
    getClaimsMainById(row.id,function(data){
        data = data||{};
        var main = data.claimsMain||{};
        if(main.id)
        {
            if(main.partAudit != 0)
            {
                nui.alert("单据已经过账，不允许再过账！");
                return;
            }
            var parts = claimsRepairOutGrid.getData();
            if(parts.length == 0)
            {
                nui.confirm("没有索赔归库配件,是否过账！","温馨提示",function(action)
                {
                    if("ok" == action)
                    {
                        updateClaimPartAudit(main.id);
                    }
                });
            }
            else{
                partClaimOutReturn(parts,main,function(data)
                {
                    data = data||{};
                    if(data.errCode == "S")
                    {
                        updateClaimPartAudit(main.id);
                    }
                    else{
                        nui.alert(data.errMsg||"过账失败");
                    }
                });
            }
        }
    });
}
function updateClaimPartAudit(claimId)
{
    nui.mask({
        html: '过账中..'
    });
    var url = baseUrl + "com.hsapi.repair.repairService.claims.updateClaimPartAudit.biz.ext";
    doPost({
        url: url,
        data: {
            claimId:claimId
        },
        success: function (data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                nui.alert("过账成功");
                basicInfoForm.clear();
                claimsRepairOutGrid.clearRows();
                claimsItemGrid.clearRows();
                claimsPartGrid.clearRows();
                leftGrid.reload();
            }
            else
            {
                nui.alert("过账失败")
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
function partClaimOutReturn(claimParts,claimMian,callback)
{
    nui.mask({
        html: '过账中..'
    });
    var delUrl = window._rootPartUrl + "com.hsapi.part.purchase.repair.partClaimOutReturn.biz.ext";
    doPost({
        url: delUrl,
        data: {
            claimParts:claimParts,
            serviceCode:claimMian.serviceCode
        },
        success: function (data)
        {
            nui.unmask();
            callback && callback(data);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            nui.unmask();
            nui.alert("网络出错");
        }
    });
}