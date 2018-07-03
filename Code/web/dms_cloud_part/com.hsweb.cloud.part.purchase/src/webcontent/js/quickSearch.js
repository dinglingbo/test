/**
 * Created by Administrator on 2018/1/23.
 * There must be a query condition
 */
var baseUrl = apiPath + cloudPartApi + "/";
var partGridUrl = baseUrl+"com.hsapi.part.baseDataCrud.crud.queryPartListByOrgid.biz.ext";
var partGrid = null;

var queryConditionsEl = null;
var conditoinsValueEl = null;
var partCodeListEl = null;
var resListEl = null;

var qualityList = [];
var qualityHash = {};
var brandHash = {};
var brandList = [];

var conList = [
    {id:"0",name:"配件编码"},
    {id:"1",name:"配件名称"},
    {id:"2",name:"编码尾号"},
    {id:"3",name:"首字拼音"}
];
$(document).ready(function() {
    partGrid = nui.get("partGrid");
    partGrid.setUrl(partGridUrl);

    queryConditionsEl = nui.get("queryConditions");
    conditoinsValueEl = nui.get("conditoinsValue");
    partCodeListEl = nui.get("partCodeList");
    resListEl = nui.get("resList");

    queryConditionsEl.setData(conList);

    partGrid.on("drawcell",function(e){
        var row = e.record;
        switch (e.field)
        {
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
            case "code":
                if(row.commonId && row.commonId > 0)
                {
                    e.cellHtml = e.value+"(<a style='color:blue;'>有替换</a>)";
                }
                break;
            default:
                break;
        }
    });

    getAllPartBrand(function(data) {
        qualityList = data.quality;
        qualityList.forEach(function(v) {
            qualityHash[v.id] = v;
        });
        brandList = data.brand;
        brandList.forEach(function(v) {
            brandHash[v.id] = v;
        });

    });

    $("#conditoinsValue").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });

    var clipboard = new ClipboardJS('.btnCopy');

    clipboard.on('success', function(e) {
        console.log(e);
        showMsg("复制成功！","S");
    });

    clipboard.on('error', function(e) {
        console.log(e);
        showMsg("复制出错！","E");
    });

});
function getSearchParams()
{
    var params = {};
    var qCon = queryConditionsEl.getValue();
    var qVal = conditoinsValueEl.getValue();
    if(!qVal){
        nui.alert("请输入查询条件!");
        return;
    }
    if(qCon == 0){
        params.code = qVal.replace(/\s+/g, "");;
    }else if(qCon == 1){
        params.name = qVal.replace(/\s+/g, "");;
    }else if(qCon == 2){
        params.rcode = qVal.replace(/\s+/g, "");;
    }else if(qCon == 3){
        params.namePy = qVal.replace(/\s+/g, "");;
    }else{
        params.code = qVal.replace(/\s+/g, "");;
    }

    var partCodeList = partCodeListEl.getValue();
    if (partCodeList) {
        var tmpList = partCodeList.split("\n");
        for (i = 0; i < tmpList.length; i++) {
            tmpList[i] = "'" + (tmpList[i]).replace(/\s+/g, "") + "'";
        }
        params.partCodeList = tmpList.join(",");
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
    //在GRID属性中设置每页查询的记录条数
    params.sortField = "b.stock_qty";
    params.sortOrder = "desc";
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
        url: webPath+partDomain+"/com.hsweb.part.baseData.partDetail.flow?token=" + token,
        title: "配件资料",
        width: 740, height: 250,
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
function onClear(){
    conditoinsValueEl.setValue("");
    partCodeListEl.setValue("");
    resListEl.setValue("");
}
function onGridSelectionChanged(){    
    var row = partGrid.getSelected(); 
    if(row){
        row.partId = row.id;  
    }else{
        row.partId = 0;
    }

    row.storeId = null;
    row.guestId = null;
    row.type = "pchs";

    parent.setBottomData(row);
    /*if(row){
    }else{
        row = {};
        row.guestId = null;
        row.partId = null;
        row.storeId = null;
        //addInsertRow();
    }
    //row.guestId = nui.get('guestId').getValue();

    document.getElementById("formIframe").contentWindow.setInitEmbedParams(row);*/

    //如果是最后一行，则新增一行；最后一行的备注填写完后也新增一行；保存时如果存在配件内码为空则删除
}
function openGeneratePop(partList, type, title){
    nui.open({
        targetWindow : window,
        url : webPath+cloudPartDomain+"/com.hsweb.cloud.part.common.shopCarPop.flow?token="+token,
        title : title,
        width : 600,
        height : 400,
        allowDrag : true,
        allowResize : true,
        onload : function() {
            var iframe = this.getIFrameEl();
            var params = {
                storeId: FStoreId,
                partList: partList,
                type: type
            };
            iframe.contentWindow.setInitData(params);
        },
        ondestroy : function(action) {
            if (action == 'ok') {
                var iframe = this.getIFrameEl();
                //var data = iframe.contentWindow.getData();
            }
        }
    });
}
function addPchsOrder(){
    var rows = partGrid.getSelecteds();
    if(rows && rows.length > 0){

        openGeneratePop(rows, "pchsOrder", "新增采购订单");

    }else{
        nui.alert("请选择配件信息!");
        return;
    }
}
function addSellOrder(){
    var rows = partGrid.getSelecteds();
    if(rows && rows.length > 0){

        openGeneratePop(rows, "sellOrder", "新增销售订单");

    }else{
        nui.alert("请选择配件信息!");
        return;
    }
}
function addPchsShop(){
    var rows = partGrid.getSelecteds();
    if(rows && rows.length > 0){
    
        openGeneratePop(rows, "pchsCart", "添加采购车");

    }else{
        nui.alert("请选择配件信息!");
        return;
    }

}
function addSellShop(){
    var rows = partGrid.getSelecteds();
    if(rows && rows.length > 0){
    
        openGeneratePop(rows, "sellCart", "添加销售车");

    }else{
        nui.alert("请选择配件信息!");
        return;
    }

}