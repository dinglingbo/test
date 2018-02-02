/**
 * Created by Administrator on 2018/1/31.
 */
var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var treeUrl = baseUrl+"com.hsapi.part.common.svr.getPartTypeTree.biz.ext";
var partGridUrl = baseUrl+"";
var partGrid = null;
var queryForm = null;
var qualityList = [];
var qualityHash = {};
var brandHash = {};
var brandList = [];
var unitList = [];
var abcTypeList = [];
var carBrandList = [];
$(document).ready(function(v)
{
    partGrid = nui.get("partGrid");
    partGrid.setUrl(partGridUrl);

    tree = nui.get("tree1");
    tree.setUrl(treeUrl);
    //console.log("xxx");
    queryForm = new nui.Form("#queryForm");
    getAllPartBrand(function(data)
    {
        data = data||{};
        qualityList = data.quality;
        qualityList.forEach(function(v)
        {
            qualityHash[v.id] = v;
        });
        brandList = data.brand;
        brandList.forEach(function(v)
        {
            brandHash[v.id] = v;
        });
    });
    getAllCarBrand(function(data)
    {
        data = data||{};
        carBrandList = data.carBrands||[];
        nui.get("carBrand").setData(carBrandList);
    });

    var dictIdList = [];
    dictIdList.push('DDT20130703000016');//--单位
    dictIdList.push('DDT20130703000067');//--ABC分类
    getDictItems(dictIdList,function(data)
    {
        if(data && data.dataItems)
        {
            var dataItems = data.dataItems||[];
            unitList = dataItems.filter(function(v){
                return v.dictid == 'DDT20130703000016';
            });
            abcTypeList = dataItems.filter(function(v){
                return v.dictid == 'DDT20130703000067';
            });
        }
    });
//仓库
    getStorehouse(function(data)
    {
        var storehouse = data.storehouse||[];
        nui.get("storeId").setData(storehouse);
   //     doSearch({});
    });
});
function onDrawNode(e)
{
    var node = e.node;
    e.nodeHtml = node.code + " " + node.name;
}
function onNodeDblClick(e)
{
    var currTree = e.sender;
    var currNode = e.node;
    var level = currTree.getLevel(currNode);
    var list = [];
    var tmpNode = currNode;
    do{
        list[level] = tmpNode.id;
        tmpNode = currTree.getParentNode(tmpNode);
        level = currTree.getLevel(tmpNode);
    }while(tmpNode&&tmpNode.id);

    var cartypef = list[0]||"";
    var cartypes = list[1]||"";
    var cartypet = list[2]||"";

    var partName = {
        cartypef:cartypef,
        cartypes:cartypes,
        cartypet:cartypet
    };
    doSearch({
        partName:partName
    });
}
var partTypeHash = null;
function onPartGridDraw(e)
{
    if(!partTypeHash)
    {
        partTypeHash = {};
        var partTypeList = tree.getList();
        partTypeList.forEach(function(v)
        {
            partTypeHash[v.id] = v;
        });
    }

    switch (e.field)
    {
        case "isDisabled":
            e.cellHtml = e.value == 1?"失效":"有效";
            break;
        case "carTypeIdF":
        case "carTypeIdS":
        case "carTypeIdT":
            if(partTypeHash[e.value])
            {
                e.cellHtml = partTypeHash[e.value].name||"";
            }
            else{
                e.cellHtml = "";
            }
            break;
        case "qualityTypeId":
            if(qualityHash[e.value])
            {
                e.cellHtml = qualityHash[e.value].name||"";
            }
            else{
                e.cellHtml = "";
            }
            break;
        case "partBrandId":
            if(brandHash[e.value])
            {
                e.cellHtml = brandHash[e.value].name||"";
            }
            else{
                e.cellHtml = "";
            }
            break;
        default:
            break;
    }
}


function reloadData()
{
    if(partGrid)
    {
        partGrid.reload();
    }
}
function getSearchParams()
{
    var params = {};
    params = queryForm.getData();
    return params;
}
function onSearch()
{
    var params = getSearchParams();
    doSearch(params);
}
function doSearch(params)
{
    partGrid.load({
        params:params
    });
}

function addPart(){
    addOrEditPart();
}
function editPart(){
    var row = partGrid.getSelected();
    if(row)
    {
        addOrEditPart(row);
    }

}
function addOrEditPart(row)
{
    nui.open({
        targetWindow: window,
        url: "../partMgr/partDetailView.html",
        title: "配件资料",
        width: 740, height: 350,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var params = {
                qualityTypeIdList:qualityList,
                partBrandIdList:brandList,
                unitList:unitList,
                abcTypeList:abcTypeList
            };
            if(row)
            {
                params.partData = row;
            }
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action)
        {
            if(action == "ok")
            {
                partGrid.reload();
            }
        }
    });
}

var resultData = {};
var callback = null;
function onOk()
{
    var node = partGrid.getSelected();
    console.log(node);
    if(!node)
    {
        return;
    }
    resultData = {
        part:node
    };
    if(!callback)
    {
        CloseWindow("ok");
    }
    else{
        callback(resultData);
    }
}
function getData(){
    return resultData;
}
function setData(data,ck){
    callback = ck;
}
function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}

//-----------------------commonPart
//--commonPart
var getStorehouseUrl = baseUrl+"com.hsapi.part.baseDataCrud.crud.getStorehouse.biz.ext";
function getStorehouse(callback)
{
    nui.ajax({
        url:getStorehouseUrl,
        type:"post",
        success:function(data)
        {
            if(data && data.storehouse)
            {
                callback && callback(data);
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
var getDictItemsUrl = baseUrl+"com.hsapi.part.common.svr.getDictItems.biz.ext";
function getDictItems(dictIdList,callback)
{
    var params = {};
    params.dictIdList = dictIdList;
    nui.ajax({
        url:getDictItemsUrl,
        type:"post",
        data:JSON.stringify(params),
        success:function(data)
        {
            if(data && data.dataItems)
            {
                callback && callback({
                    code:"S",
                    dataItems:data.dataItems
                });
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
var getAllPartBrandUrl = baseUrl+"com.hsapi.part.common.svr.getAllPartBrand.biz.ext";
function getAllPartBrand(callback)
{
    nui.ajax({
        url:getAllPartBrandUrl,
        type:"post",
        success:function(data)
        {
            if(data && data.quality && data.brand)
            {
                callback && callback(data);
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
var getAllCarBrandUrl = baseUrl+"com.hsapi.part.common.svr.getAllCarBrand.biz.ext";
function getAllCarBrand(callback)
{
    nui.ajax({
        url:getAllCarBrandUrl,
        type:"post",
        success:function(data)
        {
            if(data && data.carBrands)
            {
                callback && callback(data);
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
