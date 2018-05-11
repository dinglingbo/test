/**
 * Created by Administrator on 2018/1/23.
 */
var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var partListUrl = baseUrl+"com.hsapi.part.baseDataCrud.crud.queryPartList.biz.ext";
var partGrid = null;
var tree = null;
var treeUrl = baseUrl+"com.hsapi.part.common.svr.getPartTypeTree.biz.ext";

var qualityList = [];
var qualityHash = {};
var brandHash = {};
var brandList = [];
var unitList = [];
var abcTypeList = [];
var carBrandList = [];
var queryForm = null;
$(document).ready(function() {
    queryForm = new nui.Form("#queryForm");
    partGrid = nui.get("partGrid");
    partGrid.setUrl(partListUrl);
    partGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    partGrid.on("load", function() {
        onPartGridRowClick({});
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
    // console.log("xxx");

    getAllPartBrand(function(data) {
        qualityList = data.quality;
        qualityList.forEach(function(v) {
            qualityHash[v.id] = v;
        });
        brandList = data.brand;
        brandList.forEach(function(v) {
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

    var params = {
        carTypeIdF:cartypef,
        carTypeIdS:cartypes,
        carTypeIdT:cartypet
    };
    doSearch(params);
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
    if(params.showDisabled == 0)
    {
        params.isDisabled = 0;
    }
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
    params.sortField = "id";
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
    if(row && row.orgid == currOrgid)
    {
        addOrEditPart(row);
    }

}
function onPartGridRowDblClick(){
    editPart();
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
            var carBrandList = nui.get("applyCarBrandId").getData();
            var params = {
                qualityTypeIdList:qualityList,
                partBrandIdList:brandList,
                unitList:unitList,
                abcTypeList:abcTypeList,
                applyCarModelList:carBrandList
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
                reloadData();
            }
        }
    });
}
function onPartGridRowClick(e)
{
    var row = e.record||partGrid.getSelected();
    if(!row)
    {
        return;
    }
    if(row.isDisabled == 1)
    {
        nui.get("disableBtn").hide();
        nui.get("enableBtn").show();
    }
    else{
        nui.get("enableBtn").hide();
        nui.get("disableBtn").show();
    }
    if(row.orgid != currOrgid)
    {
        nui.get("editBtn").disable();
        nui.get("disableBtn").disable();
        nui.get("enableBtn").disable();
    }
    else{
        nui.get("editBtn").enable();
        nui.get("disableBtn").enable();
        nui.get("enableBtn").enable();
    }
}
function disablePart()
{
    var row = partGrid.getSelected();
    console.log(row);
    if(!row)
    {
        nui.alert("请选择要禁用的配件");
        return;
    }

    savePart({
        id:row.id,
        isDisabled:1
    },"禁用成功","禁用失败");
}
function enablePart()
{
    var row = partGrid.getSelected();
    console.log(row);
    if(!row)
    {
        nui.alert("请选择要启用的配件");
        return;
    }
    savePart({
        id:row.id,
        isDisabled:0
    },"启用成功","启用失败");
}
var saveUrl = baseUrl+"com.hsapi.part.baseDataCrud.crud.savePart.biz.ext";
function savePart(part,successTip,errorTip)
{
    nui.ajax({
        url:saveUrl,
        type:"post",
        data:JSON.stringify({
            part:part,
            token:token
        }),
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                nui.alert(successTip||"保存成功");
                reloadData();
            }
            else{
                nui.alert(data.errMsg||errorTip||"保存失败");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
