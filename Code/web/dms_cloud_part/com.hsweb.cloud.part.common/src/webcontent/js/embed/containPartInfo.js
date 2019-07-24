/**
 * Created by Administrator on 2018/1/23.
 * There must be a query condition
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var treeUrl = baseUrl+"com.hsapi.cloud.part.common.svr.getPartTypeTree.biz.ext";
var partGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.paramcrud.queryPartJoinStockList.biz.ext";
var partGrid = null;
var pchsOrderAddBtn = null;
var sellOrderAddBtn = null;
var pchsShopAddBtn = null;
var sellShopAddBtn = null;
var FStoreId = null;

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

    pchsOrderAddBtn = nui.get("pchsOrderAddBtn");
    sellOrderAddBtn = nui.get("sellOrderAddBtn");
    pchsShopAddBtn = nui.get("pchsShopAddBtn");
    sellShopAddBtn = nui.get("sellShopAddBtn");
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
            carBrandList = data.data || [];
            
            var dictIdList = [];
            dictIdList.push('DDT20130703000016');// --单位
            getDictItems(dictIdList, function(data) {
                if (data && data.dataItems) {
                    var dataItems = data.dataItems || [];
                    unitList = dataItems.filter(function(v) {
                        return v.dictid == 'DDT20130703000016';
                    });
                }
                //onSearch();
            });
        });

    });

    initCarBrand("applyCarBrandId",function(){
        /*initDicts({
            unit:UNIT,// --单位
            abcType:ABC_TYPE // --ABC分类
        },function(){
            onSearch();
        });*/
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

    if(parent.confirmType){
        //控制按钮显示，生成销售订单，生成采购订单，生成销售车，生成采购车
        var type = parent.confirmType();
        if(type) {
            if(type == 'pchs'){
                pchsOrderAddBtn.setVisible(true);
                pchsShopAddBtn.setVisible(true);
            }else{
                sellOrderAddBtn.setVisible(true);
                sellShopAddBtn.setVisible(true);
            }
        }else {
            pchsOrderAddBtn.setVisible(true);
            pchsShopAddBtn.setVisible(true);
        }
    }

    if(parent.getParentStoreId){
        FStoreId = parent.getParentStoreId();
    }

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
function checkConditions(){
    var data = queryForm.getData();
    var partCode = (data.partCode||"").replace(/\s+/g, "");
    var partName = (data.partName||"").replace(/\s+/g, "");
    var applyCarModel = (data.applyCarModel||"").replace(/\s+/g, "");
    var namePy = (data.namePy||"").replace(/\s+/g, "");
    var partBrandId = (data.partBrandId||"").replace(/\s+/g, "");
    var partCodeList = (data.partCodeList||"").replace(/\s+/g, "");
    if(!partCode && !partName && !applyCarModel && !namePy && !partBrandId && !partCodeList){
        return false;
    }
    return true;
}
function getSearchParams()
{
    var params = queryForm.getData();
    params.partCode = (nui.get("search-code").getValue()).replace(/\s+/g, "");
    params.partName = nui.get("search-name").getValue().replace(/\s+/g, "");
    params.applyCarModel = nui.get("search-applyCarModel").getValue().replace(/\s+/g, "");
    params.namePy = nui.get("search-namePy").getValue().replace(/\s+/g, "");
    params.partBrandId = nui.get("partBrandId").getValue().replace(/\s+/g, "");
    params.partCodeList = nui.get("partCodeList").getValue().replace(/\s+/g, "");
    params.isDisabled = 0;
    //是否开启APP
    if(currIsOpenApp ==1){   	
    	params.onlyOrgid= currOrgid;
    }else{
    	params.orgid = currOrgid;
    }
    var partCodeList = nui.get("partCodeList").getValue().replace(/\s+/g, "");
    // 订单单号
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
    if(!checkConditions()){
        parent.showMsg("请输入查询条件!","W");
        return;
    }
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
        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.cloud.part.basic.partDetail.flow?token=" + token,
        title: "配件资料",
        width: 480, height: 350,
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
    queryForm.setData([]);
}
function onGridSelectionChanged(){    
    var row = partGrid.getSelected(); 
    if(row){
        row.partId = row.id;  
        row.storeId = null;
        row.guestId = null;
        row.type = "pchs";

        parent.setBottomData(row);
    }
  

    
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
//        // targetWindow: window,,
        url : webPath+contextPath+"/com.hsweb.cloud.part.common.shopCarPop.flow?token="+token,
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
        parent.showMsg("请选择配件信息!","W");
        return;
    }
}
function addSellOrder(){
    var rows = partGrid.getSelecteds();
    if(rows && rows.length > 0){

        openGeneratePop(rows, "sellOrder", "新增销售订单");

    }else{
        parent.showMsg("请选择配件信息!","W");
        return;
    }
}
function addPchsShop(){
    var rows = partGrid.getSelecteds();
    if(rows && rows.length > 0){
    
        openGeneratePop(rows, "pchsCart", "添加采购车");

    }else{
        parent.showMsg("请选择配件信息!","W");
        return;
    }

}
function addSellShop(){
    var rows = partGrid.getSelecteds();
    if(rows && rows.length > 0){
    
        openGeneratePop(rows, "sellCart", "添加销售车");

    }else{
        parent.showMsg("请选择配件信息!","W");
        return;
    }

}