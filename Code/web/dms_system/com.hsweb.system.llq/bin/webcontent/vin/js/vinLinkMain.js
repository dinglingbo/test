var mainFrame = null
var brand = "";
var lastBrand = "";
var catchs = {};
var win = null;
var cartGrid = null;

$(document).ready(function(v) {
    query_vin(0);
	//$("#query0").css("color","blue");
	//document.getElementById("mainFrame").src=webPath + contextPath + "/com.hsweb.system.llq.vin.vinQuery.flow.ext?token=214e2f71-4237-4601-9a1a-538bf982b995";
    /*if(parent && parent.setBottomInit){
    	mainrow = parent.setBottomInit();
    	if(mainrow && mainrow.showTool == -1){
    		//document.getElementById("bottomFormIframeStock").contentWindow.setToolBar('hide');
    	}
    }*/

    win = nui.get("win");
    //win.showAtPos("left", "bottom");
    cartGrid = nui.get("cartGrid");
    
});
function showPanel(type){
    if(type == 'PART'){
        win.showAtPos("left", "bottom");  
    }else{    
        if(win.visible == true){
            win.hide();
        }else{
            win.showAtPos("left", "bottom");  
        }
    }
}
function query_vin(type){
	$(".theIframe").hide();
    $("#mainFrame" + type).show();
    
    if(type==1 && brand != lastBrand){//定位指定品牌
        catchs[type] = null;
    }
    
    $("#query0").css("color","black");
    $("#query1").css("color","black");
    $("#query2").css("color","black");

    if($("#query"+type).length>0){
        $("#query"+type).css("color","blue");
        $("#query"+type).css("font-weight","true");
    }
    
    if(catchs[type]){
        //return;
    }
    
    switch (type){
        case 0:
            document.getElementById("mainFrame0").src=webPath + contextPath + "/com.hsweb.system.llq.vin.vinQuery.flow.ext?token=214e2f71-4237-4601-9a1a-538bf982b995";
            break;
        case 1:
            document.getElementById("mainFrame1").src=webPath + contextPath + "/com.hsweb.system.llq.vin.brandQuery.flow.ext?token=214e2f71-4237-4601-9a1a-538bf982b995&brand=" + brand;
            break;
        case 2:
            document.getElementById("mainFrame2").src=webPath + contextPath + "/com.hsweb.system.llq.vin.partQuery.flow.ext?token=214e2f71-4237-4601-9a1a-538bf982b995";
            break;
        /* default:
        	document.getElementById("mainFrame").src=webPath + contextPath + "/com.hsweb.system.llq.vin.vinQuery.flow.ext?token=214e2f71-4237-4601-9a1a-538bf982b995";
            break; */
    }
    catchs[type] = 1;
}

function queryBrand(currBrand){
    brand = currBrand;
    query_vin(1);
    lastBrand = brand;
    brand = "";
}

function addToCartGrid(type, row){
    var data = cartGrid.getData();
    if(data && data.length>0){
        var rows = cartGrid.findRows(function(r){
            if(row.pid == r.pid) return true;
        });
        if(rows && rows.length>0){
            nui.alert("此零件号已经添加到购物车!");
            return;
        }else{
            var newRow = {pid: row.pid, label: row.label, orderQty: 1, orderPrice: 0};
            cartGrid.addRow(newRow);       
        }
    }else{
        var newRow = {pid: row.pid, label: row.label, orderQty: 1, orderPrice: 0};
        cartGrid.addRow(newRow);       
    }

}
// 提交单元格编辑数据前激发
function onCellCommitEdit(e) {
    var editor = e.editor;
    var record = e.record;
    var row = e.row;

    editor.validate();
    if (editor.isValid() == false) {
        nui.alert("请输入数字！");
        e.cancel = true;
    } else {
        var newRow = {};
        if (e.field == "orderQty") {
            var orderQty = e.value;
            var orderPrice = record.orderPrice;

            if (e.value == null || e.value == '') {
                e.value = 0;
                orderQty = 0;
            } else if (e.value < 0) {
                e.value = 0;
                orderQty = 0;
            }

            // record.enteramt.cellHtml = enterqty * enterprice;
        } else if (e.field == "orderPrice") {
            var orderQty = record.orderQty;
            var orderPrice = e.value;
            
            if (e.value == null || e.value == '') {
                e.value = 0;
                orderPrice = 0;
            } else if (e.value < 0) {
                e.value = 0;
                orderPrice = 0;
            }

        }
    }
}
function deleteCartShop(){
    var rows = cartGrid.getSelecteds();
    cartGrid.removeRows(rows);
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
                storeId: "",
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
function addToPchsCart(){
    var rows = cartGrid.getSelecteds();
    if(rows && rows.length > 0){

        openGeneratePop(rows, "pchsCartEpc", "添加采购车");

    }else{
        nui.alert("请选择配件信息!");
        return;
    }
}
function addToSellCart(){
    var rows = cartGrid.getSelecteds();
    if(rows && rows.length > 0){

        openGeneratePop(rows, "sellCartEpc", "添加销售车");

    }else{
        nui.alert("请选择配件信息!");
        return;
    }
}
function generatePchsOrder(){
    var rows = cartGrid.getSelecteds();
    if(rows && rows.length > 0){

        openGeneratePop(rows, "pchsOrderEpc", "生成采购订单");

    }else{
        nui.alert("请选择配件信息!");
        return;
    }
}
function generateSellOrder(){
    var rows = cartGrid.getSelecteds();
    if(rows && rows.length > 0){

        openGeneratePop(rows, "sellOrderEpc", "生成销售订单");

    }else{
        nui.alert("请选择配件信息!");
        return;
    }
}