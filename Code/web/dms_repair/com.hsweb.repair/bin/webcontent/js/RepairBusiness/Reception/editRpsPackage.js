/**
 * Created by Administrator on 2018/3/23.
 */
var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";

var itemGrid = null;
var partGrid = null;
var basicInfoForm = null;
var itemKindHash = {};
var isNeedHash = ["辅助","必要"];
$(document).ready(function (v)
{
});
function init()
{
    basicInfoForm = new nui.Form("#basicInfoForm");
    itemGrid = nui.get("itemGrid");
    itemGrid.on("drawcell",function(e){
        var field = e.field;
        if(field == "itemKind" && itemKindHash[e.value])
        {
            e.cellHtml = itemKindHash[e.value].name;
        }
        else if(field == "itemIsNeed" && isNeedHash[e.value])
        {
            e.cellHtml = isNeedHash[e.value];
        }
    });
    itemGrid.on("cellcommitedit",function(e)
    {
        var row = e.record;
        var field = e.field;
        var value = e.value;
        var oldValue = e.oldValue;
        if(value == oldValue)
        {
            return;
        }
        row[field] = value;
        row.isChanged = true;
        calculateAmt();
    });
    partGrid = nui.get("partGrid");
    partGrid.on("drawcell",function(e){
        var field = e.field;
        if(field == "partIsNeed" && isNeedHash[e.value])
        {
            e.cellHtml = isNeedHash[e.value];
        }
    });
    partGrid.on("cellcommitedit",function(e)
    {
        var row = e.record;
        var field = e.field;
        var value = e.value;
        var oldValue = e.oldValue;
        if(value == oldValue)
        {
            return;
        }
        row[field] = value;
        row.isChanged = true;
        if("unitPrice" == field)
        {
            row["amt"] = value * row.qty;
            row["amt"] = row["amt"].toFixed(2);
            row["amt"] = parseFloat(row["amt"]);
        }
        else if("amt" == field)
        {
            row["unitPrice"] = value / row.qty;
            row["unitPrice"] = row["unitPrice"].toFixed(2);
            row["unitPrice"] = parseFloat(row["unitPrice"]);
        }
        calculateAmt();
    });
}
function calculateAmt()
{
    var itemList = itemGrid.getData();
    var partList = partGrid.getData();
    var sum = 0;
    itemList.forEach(function(v)
    {
        var amt = v.amt;
        v.subtotal = amt - v.discountAmt;
        sum += amt;
    });
    partList.forEach(function(v)
    {
        var amt = v.amt;
        v.subtotal = amt - v.discountAmt;
        sum += amt;
    });
    var pkg = basicInfoForm.getData();
    sum = sum.toFixed(2);
    sum = parseFloat(sum);
    pkg.subtotal = sum;
    basicInfoForm.setData(pkg);
}
function getPackageById(id,callback)
{
    var url = baseUrl+'com.hsapi.repair.repairService.svr.getRpsPackageById.biz.ext';
    doPost({
        url:url,
        data:{
            id:id
        },
        success:function(data)
        {
            callback && callback(data);
        },
        error:function(jqXHR, textStatus, errorThrown)
        {
            console.log(jqXHR.responseText);
            callback && callback({});
        }
    });
}
function setData(data)
{
    init();
    data = data||{};
    itemKindHash = data.itemKindHash||{};
    var pkgId = data.packageId;
    nui.mask({
        html:'数据加载中..'
    });
    getPackageById(pkgId,function(data)
    {
        nui.unmask();
        data = data||{};
        if(data.pkg)
        {
            var pkg = data.pkg||{};
            basicInfoForm.setData(pkg);
            var itemList = data.itemList||[];
            itemGrid.setData(itemList);
            var partList = data.partList||[];
            partGrid.setData(partList);
        }
        else{
            nui.alert("数据加载失败");
        }
    });
}

function onOk()
{
    var pkg = basicInfoForm.getData();
    pkg.discountAmt = pkg.amt - pkg.subtotal;
    pkg.rate = pkg.discountAmt/pkg.amt;
    pkg.rate = pkg.rate.toFixed(2);
    console.log(pkg);
    var itemList = itemGrid.getData();
    itemList = itemList.filter(function(v){
        return v.isChanged;
    });
    itemList = itemList.map(function(v)
    {
        return {
            itemId:v.itemId,
            serviceId:v.serviceId,
            amt:v.amt,
            discountAmt:v.discountAmt,
            subtotal:v.amt - v.discountAmt
        };
    });
    var partList = partGrid.getData();
    partList = partList.filter(function(v){
        return v.isChanged;
    });
    partList = partList.map(function(v)
    {
        return {
            partId:v.partId,
            serviceId:v.serviceId,
            amt:v.amt,
            discountAmt:v.discountAmt,
            subtotal:v.amt - v.discountAmt
        };
    });
    var itemList2 = [];
    var partList2 = [];
    if(pkg.status == 1)
    {
        itemList2 = itemList;
        partList2 = partList;
    }
    var saveUrl = baseUrl+"com.hsapi.repair.repairService.crud.updRpsPackage.biz.ext";
    nui.mask({
        html:'保存中..'
    });
    doPost({
        url:saveUrl,
        data:{
            pkg:pkg,
            itemList:itemList,
            partList:partList,
            itemList2:itemList2,
            partList2:partList2
        },
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                nui.alert("保存成功","提示",function(){
                    CloseWindow("ok");
                });
            }
            else{
                nui.alert(data.errMsg||"保存失败");
            }
        },
        error:function(jqXHR, textStatus, errorThrown)
        {
            nui.unmask();
            console.log(jqXHR.responseText);
            nui.alert("网络出错");
        }
    });
}

function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}