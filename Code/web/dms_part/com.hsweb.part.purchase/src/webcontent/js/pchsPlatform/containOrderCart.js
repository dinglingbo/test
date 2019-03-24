/**
 * Created by Administrator on 2018/1/23.
 * Query what not done
 */
var baseUrl = apiPath + partApi + "/";
var cartGridUrl = baseUrl+"com.hsapi.part.invoice.query.queryOrderCart.biz.ext";
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

    $("#search_code").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });

    $("#search_name").bind("keydown", function (e) {
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
            url : baseUrl+"com.hsapi.part.invoice.paramcrud.deleteOrderCart.biz.ext",
            type : "post",
            data : JSON.stringify({
                list : rows,
                token: token
            }),
            success : function(data) {
                nui.unmask(document.body);
                data = data || {};
                if (data.errCode == "S") {
                    parent.parent.showMsg("删除成功!","S");
                    cartGrid.removeRows(rows,true);
                    
                } else {
                    parent.parent.showMsg(data.errMsg || "删除失败!");
                }
            },
            error : function(jqXHR, textStatus, errorThrown) {
                // parent.parent.showMsg(jqXHR.responseText);
                console.log(jqXHR.responseText);
            }
        });
    }
}
function openGeneratePop(partList, type, title){
    nui.open({
        // targetWindow: window,,
        url : webPath+contextPath+"/com.hsweb.part.manage.shopCarPop.flow?token="+token,
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
        + "com.hsapi.part.invoice.paramcrud.updateOrderCart.biz.ext";
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
            // parent.parent.showMsg(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function generatePchsOrder(){
    var rows = cartGrid.getSelecteds();
    if(rows.length<=0){
    	parent.parent.showMsg("请选择配件信息!");
        return;
    }
    var guestId=rows[0].guestId;
    if(rows && rows.length > 0){
    	for(var i=0;i<rows.length;i++){
    		if(guestId!=rows[i].guestId){
    			parent.parent.showMsg("请选择相同供应商的配件!");
    			return;
    		}
    	}
    }

    openGeneratePop(rows, "fromPchsCart", "新增采购订单");
}
function generateSellOrder(){
    var rows = cartGrid.getSelecteds();
    if(rows && rows.length > 0){

    }else{
        parent.parent.showMsg("请选择配件信息!");
        return;
    }

    openGeneratePop(rows, "fromSellCart", "新增销售订单");
}