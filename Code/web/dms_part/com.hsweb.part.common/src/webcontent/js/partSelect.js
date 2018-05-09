/**
 * Created by Administrator on 2018/1/23.
 */
var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var treeUrl = baseUrl+"com.hsapi.part.common.svr.getPartTypeTree.biz.ext";
var partGridUrl = baseUrl+"com.hsapi.part.baseDataCrud.crud.queryPartList.biz.ext";
var partGrid = null;

var qualityList = [];
var qualityHash = {};
var brandHash = {};
var brandList = [];
var unitList = [];
var abcTypeList = [];
var carBrandList = [];

var queryForm = null;
$(document).ready(function(v)
{
    queryForm = new nui.Form("#queryForm");
    partGrid = nui.get("partGrid");
    partGrid.setUrl(partGridUrl);
    partGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    partGrid.on("drawcell",function(e)
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
        var field = e.field;
        if("isUniform" == field)
        {
            e.cellHtml = e.value == 1?"是":"否";
        }
        else if("isDisabled" == field)
        {
            e.cellHtml = e.value == 1?"失效":"有效";
        }
        else if("carTypeIdF" == field || "carTypeIdS" == field || "carTypeIdT" == field)
        {
            if(partTypeHash && partTypeHash[e.value])
            {
                e.cellHtml = partTypeHash[e.value].name||"";
            }
        }
        else if("qualityTypeId" == field)
        {
            if(qualityHash[e.value])
            {
                e.cellHtml = qualityHash[e.value].name||"";
            }
        }
        else if("partBrandId" == field)
        {
            if(brandHash[e.value])
            {
                e.cellHtml = brandHash[e.value].name||"";
            }
        }
        else{
            onDrawCell(e);
        }
    });
    tree = nui.get("tree1");
    tree.setUrl(treeUrl);
    tree.on("beforeload",function(e){
        e.data.token = token;
    });
    //console.log("xxx");

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
        initCarBrand("applyCarBrandId",function(){
            initDicts({
                unit:UNIT,// --单位
                abcType:ABC_TYPE // --ABC分类
            },function(){
                onSearch();
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
        carTypeIdF:cartypef,
        carTypeIdS:cartypes,
        carTypeIdT:cartypet
    };
    doSearch(partName);
}
var partTypeHash = null;


function reloadData()
{
    if(partGrid)
    {
        partGrid.reload();
    }
}
function getSearchParams()
{
    var params = queryForm.getData();
    return params;
}
function onSearch()
{
    var params = getSearchParams();
    doSearch(params);
}
function doSearch(params)
{
	params.sortOrder = "ASC";
    params.sortField = "is_host";
    if(params.namePy)
    {
        params.namePy = params.namePy.toUpperCase();
    }
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
        url: "com.hsweb.part.baseData.partDetail.flow?token=" + token,
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
    var tmp = list.filter(function(v){
        return v.partId == node.id;
    });
    if(tmp && tmp.length>0)
    {
        nui.alert("此配件已在明细中，不能重复选择");
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
function setData(data,ck)
{
	data = data||{};
	list = data.list||[];
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