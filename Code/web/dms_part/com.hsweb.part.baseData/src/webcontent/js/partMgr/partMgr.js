/**
 * Created by Administrator on 2018/1/23.
 */
var basePath = window._rootUrl||"http://127.0.0.1:8080/default/";
var partListUrl = basePath+"com.hsapi.part.baseDataCrud.crud.queryPartList.biz.ext";
var partGrid = null;
var tree = null;
var treeUrl = basePath+"com.hsapi.repair.Item.getRepairTypeTree.biz.ext";

var qualityList = [];
var qualityHash = {};
var brandHash = {};
var brandList = [];
var unitList = [];
var abcTypeList = [];
$(document).ready(function(v)
{
	partGrid = nui.get("partGrid");
    partGrid.setUrl(partListUrl);

    tree = nui.get("tree1");
    tree.setUrl(treeUrl);
    //console.log("xxx");

    getAllPartBrand(function(data)
    {
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
    //字典
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

    var params = {
        carTypeIdF:cartypef,
        carTypeIdS:cartypes,
        carTypeIdT:cartypet
    };
    doSearch(params);
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
    params.code = nui.get("search-code").getValue();
    params.name = nui.get("search-name").getValue();
    params.namePy = nui.get("search-namePy").getValue().toUpperCase();
    params.applyCarModel = nui.get("search-applyCarModel").getValue();
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
        url: "com.hsweb.part.baseData.partDetail.flow",
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


var getAllPartBrandUrl = basePath+"com.hsapi.part.common.svr.getAllPartBrand.biz.ext";
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
