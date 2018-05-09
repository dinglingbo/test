/**
 * Created by Administrator on 2018/1/23.
 * There must be a query condition
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var treeUrl = baseUrl+"com.hsapi.cloud.part.common.svr.getPartTypeTree.biz.ext";
var partGridUrl = baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.queryPartList.biz.ext";
var partGrid = null;

var qualityList = [];
var qualityHash = {};
var brandHash = {};
var brandList = [];
var unitList = [];
var abcTypeList = [];
var abcTypeHash = {};
var carBrandList = [];
var queryForm = null;
var codeEl = null;
$(document).ready(function() {
    queryForm = new nui.Form("#queryForm");
    partGrid = nui.get("partGrid");
    partGrid.setUrl(partGridUrl);
    /*partGrid.on("load", function() {
        onPartGridRowClick({});
    });*/
    codeEl = nui.get("search-code");
    codeEl.focus();

    getAllPartBrand(function(data) {
        qualityList = data.quality;
        qualityList.forEach(function(v) {
            qualityHash[v.id] = v;
        });
        brandList = data.brand;
        brandList.forEach(function(v) {
            brandHash[v.id] = v;
        });

        nui.get("partBrandId").setData(brandList);

        getAllCarBrand(function(data) {
            data = data || {};
            carBrandList = data.carBrands || [];
            
            var dictIdList = [];
            dictIdList.push('DDT20130703000016');// --单位
            dictIdList.push('DDT20130703000067');// --ABC分类
            getDictItems(dictIdList, function(data) {
                if (data && data.dataItems) {
                    var dataItems = data.dataItems || [];
                    unitList = dataItems.filter(function(v) {
                        return v.dictid == 'DDT20130703000016';
                    });
                    abcTypeList = dataItems.filter(function(v) {
                        return v.dictid == 'DDT20130703000067';
                    });
                    abcTypeList.forEach(function(v) {
                        abcTypeHash[v.id] = v;
                    });
                }
                //onSearch();
            });
        });

    });
    
    getAllPartType(function(data) {
    	partTypeList = data.partTypes;
    	partTypeList.forEach(function(v)
        {
            partTypeHash[v.id] = v;
        });


    });

    $("#search-code").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });

    $("#search-name").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });

    $("#search-applyCarModel").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });

    $("#search-namePy").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });

    $("#partBrandId").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });

});
var partTypeHash = null;
function onPartGridDraw(e)
{
    if(!partTypeHash)
    {
        partTypeHash = {};
        //var partTypeList = tree.getList();
        //partTypeList.forEach(function(v)
        //{
       //     partTypeHash[v.id] = v;
        //});
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
        case "abcType":
            if(abcTypeHash[e.value])
            {
                e.cellHtml = abcTypeHash[e.value].name||"";
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
    var params = queryForm.getData();
    //params.code = nui.get("search-code").getValue();
    //params.name = nui.get("search-name").getValue();
    //params.applyCarModel = nui.get("search-applyCarModel").getValue();
    //params.namePy = nui.get("search-namePy").getValue();
    //params.partBrandId = nui.get("partBrandId").getValue();
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
        params:params,
        token:token
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

var resultData = {};
var callback = null;
var checkcallback = null;
function onOk()
{
    var node = partGrid.getSelected();
    var nodec = nui.clone(node);
    
    if(!nodec)
    {
        return;
    }
    resultData = {
        part:nodec
    };
    if(!parent.addDetail)
    {
        return;
    }
    else{
        //需要判断是否已经添加了此配件
        var checkMsg = parent.checkPartIDExists(nodec.id);
        if(checkMsg) 
        {
            nui.confirm(checkMsg, "友情提示",
                function (action) { 
                    if (action == "ok") {
                        parent.addDetail(nodec);
                    }else {
                        return;
                    }
                }
            );
        }else
        {
            //弹出数量，单价和金额的编辑界面
            parent.addDetail(resultData.part);
        }

    }
}
function getData(){
    return resultData;
}
function onRowDblClick()
{
    onOk();
}
function initData(partCode){
    codeEl.setValue(partCode);
    onSearch();
    codeEl.focus();
}