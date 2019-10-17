/**
 * Created by Administrator on 2018/1/23.
 * Query what not done
 */
var baseUrl = apiPath + cloudPartApi + "/";
var cartGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.query.queryOrderCartSql.biz.ext";
var cartGrid = null;
var type = null;
var pchsOrderBtn = null;
var pchsCartBtn = null;
var sellOrderBtn = null;
var sellCartBtn = null;
var FStoreId = null;

var queryForm = null;
$(document).ready(function() {
    queryForm = new nui.Form("#queryForm");
    cartGrid = nui.get("cartGrid");
    cartGrid.setUrl(cartGridUrl);

    pchsOrderBtn = nui.get("pchsOrderBtn");
    pchsCartBtn = nui.get("pchsCartBtn");
    sellOrderBtn = nui.get("sellOrderBtn");
    sellCartBtn = nui.get("sellCartBtn");
   
    if(parent.confirmType){
        type = parent.confirmType();
        if(type) {
            if(type == 'pchs'){
                pchsOrderBtn.setVisible(true);
                pchsCartBtn.setVisible(true);
            }else{
                sellOrderBtn.setVisible(true);
                sellCartBtn.setVisible(true);
            }
        }else {
            pchsOrderBtn.setVisible(true);
            pchsCartBtn.setVisible(true);
        }
    }

    if(parent.getParentStoreId){
        FStoreId = parent.getParentStoreId();
    }

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

});

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
    for(var key in params){
    	params[key]=params[key].replace(/\s+/g, "");
    }
    if(type == 'pchs'){
    	params.shopType=1;
       
    }else{
    	params.shopType=-1;
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
    params.isConfirm = 0;
    cartGrid.load({
        params:params,
        token:token
    });
}
function deleteCartShop(){
    var rows = cartGrid.getSelecteds();
    if(rows && rows.length>0){
        nui.mask({
            el : document.body,
            cls : 'mini-mask-loading',
            html : '删除中...'
        });

        nui.ajax({
            url : baseUrl+"com.hsapi.cloud.part.invoicing.paramcrud.deleteOrderCart.biz.ext",
            type : "post",
            data : JSON.stringify({
                list : rows,
                token: token
            }),
            success : function(data) {
                nui.unmask(document.body);
                data = data || {};
                if (data.errCode == "S") {
                    nui.alert("删除成功!","",function(e){
                        cartGrid.removeRows(rows,true);
                    });
                    
                } else {
                    nui.alert(data.errMsg || "删除失败!");
                }
            },
            error : function(jqXHR, textStatus, errorThrown) {
                // nui.alert(jqXHR.responseText);
                console.log(jqXHR.responseText);
            }
        });
    }
}
function openGeneratePop(partList, type, title){
    nui.open({
        // targetWindow: window,,
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
                updateOrderCart(partList);
            }
        }
    });
}

var updateOrderUrl = baseUrl
        + "com.hsapi.cloud.part.invoicing.paramcrud.updateOrderCart.biz.ext";
function updateOrderCart(list){
    nui.ajax({
        url : updateOrderUrl,
        type : "post",
        async: false,
        data : {
            list: list,
            token:token
        },
        success : function(data) {
            var errCode = data.errCode;
            if(errCode == "S"){
                cartGrid.removeRows(list);
            }

        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function generatePchsOrder(){
    var rows = cartGrid.getSelecteds();
    if(rows && rows.length > 0){

    }else{
        nui.alert("请选择配件信息!");
        return;
    }

    openGeneratePop(rows, "fromPchsCart", "新增采购订单");
}
function generateSellOrder(){
    var rows = cartGrid.getSelecteds();
    if(rows && rows.length > 0){

    }else{
        nui.alert("请选择配件信息!");
        return;
    }

    openGeneratePop(rows, "fromSellCart", "新增销售订单");
}