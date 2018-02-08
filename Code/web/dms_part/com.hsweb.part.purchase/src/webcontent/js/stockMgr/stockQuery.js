/**
 * Created by Administrator on 2018/1/31.
 */
var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var treeUrl = baseUrl+"com.hsapi.part.common.svr.getPartTypeTree.biz.ext";
var partGridUrl = baseUrl+"com.hsapi.part.purchase.svr.queryPtsStockCycVListWithPage.biz.ext";
var partGrid = null;
var queryForm = null;
var qualityList = [];
var qualityHash = {};
var brandHash = {};
var brandList = [];
var unitList = [];
var abcTypeList = [];
var carBrandList = [];
var storehouseHash = {};
$(document).ready(function(v)
{
    partGrid = nui.get("partGrid");
    partGrid.setUrl(partGridUrl);

    tree = nui.get("tree1");
    tree.setUrl(treeUrl);
    //console.log("xxx");
    queryForm = new nui.Form("#queryForm");
  //仓库
    getStorehouse(function(data)
    {
        var storehouse = data.storehouse||[];
        nui.get("storeId").setData(storehouse);
        storehouse.forEach(function(v)
        {
            storehouseHash[v.id] = v;
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
                getAllCarBrand(function(data)
                {
                    data = data||{};
                    carBrandList = data.carBrands||[];
                    nui.get("carBrand").setData(carBrandList);
                    onSearch();
                });
            });
        });
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
    doSearch(partName);
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
	    case "storeId":
	        if(storehouseHash && storehouseHash[e.value])
	        {
	            e.cellHtml = storehouseHash[e.value].name;
	        }
	        break;
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