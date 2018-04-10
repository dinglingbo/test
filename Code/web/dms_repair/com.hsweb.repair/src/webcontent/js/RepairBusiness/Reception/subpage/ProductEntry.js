/**
 * Created by Administrator on 2018/3/27.
 */

var baseUrl = window._rootSysUrl || "http://127.0.0.1:8080/default/";
var tree = null;
var carBrandIdEl = null;
var carModelIdEL = null;
var vinEl = null;
var carInfoForm = null;
var queryTabIdEl = null;
var mainTabEl = null;
var packageGrid = null;
var packageDetail = null;
var detailGrid_Form = null;
var itemGrid = null;
var treeHash={};
var partGrid = null;
var brandPartGrid = null;
var itemKindHash = {
    JD:"机电",
    BJ:"钣金",
    PQ:"喷漆",
    MR:"洗美"
};
$(document).ready(function ()
{
    init();
});
function init()
{
    var treeUrl = baseUrl+"com.hsapi.system.product.items.getPrdtType.biz.ext";
    tree = nui.get("tree");
    tree.on("load",function(e)
    {
        var list = tree.getList();
        treeHash = {};
        list.forEach(function(v){
            treeHash[v.id] = v;
        });
    });
    tree.setUrl(treeUrl);
    tree.on("nodedblclick",function(e)
    {
        var node = e.node;
        var nodeList = tree.getAncestors(node);
        var customId = node.customId;
        if(nodeList.length>0)
        {
            customId = nodeList[0].customId;
        }
        var carInfo = carInfoForm.getData();
        var params = {
            carBrandId:carInfo.carBrandId,
            carLevelId:carInfo.carLevelId,
            carLineId:carInfo.carLineId,
            carModelId:carInfo.carModelId
        };
        if(customId.indexOf("01") == 0)
        {
            queryTabIdEl.setValue(0);
            queryTabIdEl.doValueChanged();
            params.packageTypeId = node.id;
            doSearchPackage(params);
        }
        if(customId.indexOf("02") == 0 || customId.indexOf("03") == 0)
        {
            queryTabIdEl.setValue(1);
            queryTabIdEl.doValueChanged();
            params.typeId = node.id;
            doSearchItem(params);
        }
        if(customId.indexOf("04") == 0)
        {
            queryTabIdEl.setValue(2);
            queryTabIdEl.doValueChanged();
            params.groupId = node.id;
            doSearchPart(params);
        }
    });
    var packageGridUrl = baseUrl+"com.hsapi.system.product.items.getPackage.biz.ext";
    packageGrid = nui.get("packageGrid");
    packageGrid.setUrl(packageGridUrl);
    packageGrid.on("beforeload",function(e)
    {
        e.data["token"] = "";
        e.data["page/isCount"] = true;
    });
    packageGrid.on("drawcell",function(e)
    {
        if(e.field == "packageTypeId" && treeHash[e.value])
        {
            e.cellHtml = treeHash[e.value].name.split(" ")[1];
        }
    });
    var packageDetailUrl = baseUrl+"com.hsapi.system.product.items.getPkgDetail.biz.ext";
    packageDetail = nui.get("packageDetail");
    packageDetail.setUrl(packageDetailUrl);
    detailGrid_Form = document.getElementById("detailGrid_Form");
    packageGrid.on("showrowdetail",function(e)
    {
        var grid = e.sender;
        var row = e.record;

        var td = grid.getRowDetailCellEl(row);
        td.appendChild(detailGrid_Form);
        detailGrid_Form.style.display = "block";
        packageDetail.clearRows();
        loadPackageDetailByPkgId(row.packageId,function(){});
    });
    var itemGridUrl = baseUrl+"com.hsapi.system.product.items.getItem.biz.ext";
    itemGrid = nui.get("itemGrid");
    itemGrid.setUrl(itemGridUrl);
    itemGrid.on("beforeload",function(e)
    {
        e.data["token"] = "";
        e.data["page/isCount"] = true;
    });
    itemGrid.on("drawcell",function(e)
    {
        if(e.field == "typeId" && treeHash[e.value])
        {
            e.cellHtml = treeHash[e.value].name.split(" ")[1];
        }
        if(e.field == "itemKind")
        {
            e.cellHtml = itemKindHash[e.value];
        }
    });
    var brandPartGridUrl = baseUrl+"com.hsapi.system.product.items.getBrandPart.biz.ext";
    brandPartGrid = nui.get("brandPartGrid");
    brandPartGrid.setUrl(brandPartGridUrl);
    brandPartGrid.on("beforeload",function(e)
    {
        e.data["token"] = "";
        e.data["page/isCount"] = true;
    });
    var partGridUrl = baseUrl+"com.hsapi.system.product.items.getPart.biz.ext";
    partGrid = nui.get("partGrid");
    partGrid.on("rowdblclick",function(e)
    {
        var row = e.record;
        brandPartGrid.load({
            partId:row.id,
            token:token,
        });
    });
    partGrid.on("beforeload",function(e)
    {
        e.data["token"] = "";
        e.data["page/isCount"] = true;
    });
    partGrid.setUrl(partGridUrl);
    carBrandIdEl = nui.get("carBrandId");
    queryCarBrand(function(data)
    {
        data = data||{};
        if(data.errCode == "S")
        {
            var list = data.rs||[];
            carBrandIdEl.setData(list);
        }
    });
    carModelIdEL = nui.get("carModelId");
    carBrandIdEl.on("valuechanged",function()
    {
        var carBrandId = carBrandIdEl.getValue();
        queryCarModel(carBrandId,function(data)
        {
            data = data||{};
            if(data.errCode == "S")
            {
                var list = data.rs||[];
                carModelIdEL.setData(list);
            }
        });
    });

    carInfoForm = new nui.Form("#carInfoForm");
    vinEl = nui.get("vin");
    vinEl.on("valuechanged",function()
    {
        var vin = vinEl.getValue();
        getCarVinModel(vin,function(data)
        {
            data = data||{};
            if(data.errCode == "S")
            {
                var list = data.rs||[];
                var carVinModel = list[0];
                carVinModel = carVinModel||{};
                carVinModel.vin = vin;
                carInfoForm.setData(carVinModel);
                carBrandIdEl.doValueChanged();
                tree.load({
                    carBrandId:carVinModel.carBrandId
                });
            }
        });

    });
    queryTabIdEl = nui.get("queryTabId");
    mainTabEl = nui.get("mainTab");
    queryTabIdEl.on("valuechanged",function()
    {
        var tabIdx = queryTabIdEl.getValue();
        var tab = mainTabEl.getTab(parseInt(tabIdx));
        mainTabEl.activeTab(tab);
    });
}
function loadPackageDetailByPkgId(pkgId,callback)
{
    packageDetail.load({
        pkgCarMtId:pkgId
    },callback);
}
function getSearchParams()
{
    var carInfo = carInfoForm.getData();
    var params = {
        carBrandId:carInfo.carBrandId,
        carLevelId:carInfo.carLevelId,
        carLineId:carInfo.carLineID,
        carModelId:carInfo.carModelId
    };
    var queryItem = nui.get("queryItem").getValue();
    var queryValue = nui.get("queryValue").getValue();
    if(queryItem == 0)
    {
        params.code = queryValue
    }
    else if(queryItem == 1)
    {
        params.name = queryValue
    }
    else if(queryItem == 2)
    {
        params.pyCode = queryValue
    }
    return params;
}
function onSearch()
{
    var params = getSearchParams();
    var tabIdx = queryTabIdEl.getValue();
    if(tabIdx == 0)
    {
        doSearchPackage(params);
    }
    else if(tabIdx == 1)
    {
        doSearchItem(params);
    }
    else if(tabIdx == 2)
    {
        doSearchPart(params);
    }
}
function doSearchPackage(params)
{
    params.packageId = params.code;
    params.packageName = params.name;
    packageGrid.load({
    	token:token,
        p:params
    });
}
function doSearchItem(params)
{
    params.itemCode = params.code||"";
    params.itemName = params.name||"";
    itemGrid.load({
    	token:token,
        p:params
    });
}
function doSearchPart(params)
{
    brandPartGrid.clearRows();
    partGrid.load({
    	token:token,
        p:params
    });
}
var callback = null;
function setData(data,ck)
{
    data = data||{};
    callback = ck;
    var vin = data.vin||"";
    init();
    vinEl.setValue(vin);
    vinEl.doValueChanged();
}
function doSelect(idx)
{
    var result = {};
    var row = null;
    if(idx == 0)
    {
        result.pkg = packageGrid.getSelected();
        row = result.pkg;
    }
    else if(idx == 1){
        result.item = itemGrid.getSelected();
        row = result.item;
    }
    if(!row)
    {
        return;
    }
    if(result.pkg)
    {
        var list = packageDetail.getData();
        var doCallback = function()
        {
            list.forEach(function(v)
            {
                if(v.itemKind)
                {
                    var item_kind = v.itemKind;
                    item_kind = item_kind == 'JD' ? '040701' : item_kind == 'BJ' ? '040702' : item_kind == 'PQ' ? '040703' : item_kind == 'MR' ? '040705' : '040701';
                    v.itemKind = item_kind;
                }
            });
            var itemList = list.filter(function(v)
            {
                return v.type == "工时";
            });
            var partList = list.filter(function(v){
                return v.type == "配件";
            });
            result.itemList = itemList;
            result.partList = partList;
            callback && callback(result);
        };
        if(list.length > 0)
        {
            doCallback();
        }
        else{
            loadPackageDetailByPkgId(row.packageId,function()
            {
                list = packageDetail.getData();
                doCallback();
            });
        }
    }
    else{
        callback && callback(result);
    }
}
function onOk()
{
    var getActiveTab = mainTabEl.getActiveTab();
    console.log(getActiveTab);
    var _id = getActiveTab._id;
    doSelect(_id-1);
}
//关闭窗口
function CloseWindow(action) {
    if (action == "close" && form.isChanged()) {
        if (confirm("数据被修改了，是否先保存？")) {
            saveData();
        }
    }
    if (window.CloseOwnerWindow)
        return window.CloseOwnerWindow(action);
    else window.close();
}
//取消
function onCancel() {
    CloseWindow("cancel");
}

//commonRepair
function doPost(opt) {
    var url = opt.url;
    var data = opt.data;
    var success = opt.success || function () {
        };
    var error = opt.error || function () {
        };
    data.orgid = currOrgid;
    data.userName = currUserName;
    nui.ajax({
        url: url,
        type: "post",
        data: JSON.stringify(data),
        success: success,
        error: error
    });
}
var queryCarBrandUrl = baseUrl
    + "com.hsapi.system.product.cars.carBrand.biz.ext";
function queryCarBrand(callback)
{
    var params = {};
    doPost({
        url: queryCarBrandUrl,
        data: params,
        success: function (data) {
            //data.rs
            callback && callback(data);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            callback && callback(null);
        }
    });
}

var queryCarModelUrl = baseUrl
    + "com.hsapi.system.product.cars.carModel.biz.ext";
function queryCarModel(carBrandId, callback) {
    var params = {};
    params.carBrandId = carBrandId;
    doPost({
        url: queryCarModelUrl,
        data: params,
        success: function (data)
        {
            //data.rs
            callback && callback(data);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            callback && callback(null);
        }
    });
}
var getCarVinModelUrl = baseUrl
    + "com.hsapi.system.product.cars.carVinModel.biz.ext";
function getCarVinModel(vin, callback) {
    var params = {};
    params.vin = vin;
    doPost({
        url: getCarVinModelUrl,
        data: params,
        success: function (data)
        {
            //data.rs;
            callback && callback(data);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            callback && callback(null);
        }
    });
}
var currOrgid = 2;
var currUserName = '刘阳';