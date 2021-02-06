/**
 * Created by Administrator on 2018/1/23.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var treeUrl = baseUrl+"com.hsapi.cloud.part.common.svr.getPartTypeTree.biz.ext";
var partGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.stockcal.queryRtnableOutGridWithPage.biz.ext";
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
$(document).ready(function() {
    queryForm = new nui.Form("#queryForm");
    partGrid = nui.get("partGrid");
    partGrid.setUrl(partGridUrl);
    /*partGrid.on("load", function() {
        onPartGridRowClick({});
    });*/
    tree = nui.get("tree1");
    tree.setUrl(treeUrl);

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
                
            });
        });

    });

    getStorehouse(function(data)
    {
        storehouse = data.storehouse||[];
        nui.get("storeId").setData(storehouse);
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
//                e.cellHtml = brandHash[e.value].name||"";
            	if(brandHash[e.value].imageUrl){
            		
            		e.cellHtml = "<img src='"+ brandHash[e.value].imageUrl+ "'alt='配件图片' height='25px' width=' '/><br> "+brandHash[e.value].name||"";
            	}else{
            		e.cellHtml = brandHash[e.value].name||"";
            	}
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
        case "rtnableQty":
            if(e.value > 0)
            {
                e.cellHtml = "<font color='blue'>" + e.value + "</font>";
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
    return params;
}
function onSearch()
{
    var params = getSearchParams();
    doSearch(params);
}
function doSearch(params)
{
    if(!params.storeId && !params.code && !params.name && !params.serviceId && !params.namePy && !params.partBrandId){
        showMsg("请输入查询条件!","W");
        return;
    }
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
        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.cloud.part.basic.partDetail.flow?token="+token,
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
    if(!callback)
    {
        CloseWindow("ok");
    }
    else{
        //需要判断是否已经添加了此配件
        var checkMsg = checkcallback(resultData);
        if(checkMsg) 
        {
            nui.confirm(checkMsg, "友情提示",
                function (action) { 
                    if (action == "ok") {
                        callback(resultData);
                    }else {
                        return;
                    }
                }
            );
        }else
        {
            //弹出数量，单价和金额的编辑界面
            callback(resultData);
        }

    }
}
function getData(){
    return resultData;
}
function setData(data,ck,cck){
    callback = ck;
    checkcallback = cck;

    data = data||{};
    nui.get("storeId").setValue(data.storeId);
    nui.get("search-guestId").setValue(data.guestId);

    if(data.storeId){
        onSearch();
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
function onRowDblClick()
{
    onOk();
}