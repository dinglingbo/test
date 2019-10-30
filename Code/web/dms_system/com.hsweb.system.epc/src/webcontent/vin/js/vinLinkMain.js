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
    $("#query3").css("color","black");
    $("#query4").css("color","black");
    
    if($("#query"+type).length>0){
        $("#query"+type).css("color","blue");
        $("#query"+type).css("font-weight","true");
    }
    
    if(catchs[type]){
        return;
    }
    
    switch (type){
        case 0:
            document.getElementById("mainFrame0").src=webPath + contextPath + "/com.hsweb.system.epc.vinQuery.flow?token="+token;
            break;
        case 1:
            document.getElementById("mainFrame1").src=webPath + contextPath + "/com.hsweb.system.epc.brandQuery.flow?token="+token+"&brand=" + brand;
            break;
        case 2:
            document.getElementById("mainFrame2").src=webPath + contextPath + "/com.hsweb.system.epc.partQuery.flow?token="+token;
            break;
        case 3:
            document.getElementById("mainFrame3").src=webPath + contextPath + "/com.hsweb.system.epc.partQuery.flow?token="+token;
            break;  
        case 4:
            document.getElementById("mainFrame4").src=webPath + contextPath + "/com.hsweb.system.epc.partQuery.flow?token="+token;
            break;            
        /* default:
        	document.getElementById("mainFrame").src=webPath + contextPath + "/com.hsweb.system.llqv2.vinQuery.flow.ext?token=214e2f71-4237-4601-9a1a-538bf982b995";
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
    var quantity = row.quantity||0;
    quantity = quantity.replace(/\s+/g, "");
    var reg = /^[0-9]*$/;//纯数字
    if(!reg.test(quantity)){
        quantity = 1;
    }
    if(row && row.flag){//1添加；-1删除
        if(row.flag == 1){
            if(data && data.length>0){
                var rows = cartGrid.findRows(function(r){
                    if(row.pid == r.pid) return true;
                });
                if(rows && rows.length>0){
                    showMsg("此零件号已经添加到购物车!","W");
                    return;
                }else{
                    var newRow = {pid: row.pid, label: row.label, orderQty: quantity, orderPrice: 0};
                    cartGrid.addRow(newRow);       
                }
            }else{
                var newRow = {pid: row.pid, label: row.label, orderQty: quantity, orderPrice: 0};
                cartGrid.addRow(newRow);       
            }
        }else{
            var rows = cartGrid.findRows(function(r){
                if(row.pid == r.pid) return true;
            });
            if(rows && rows.length>0){
                cartGrid.removeRows(rows,true);
            }
        }
    }else{
        if(data && data.length>0){
            var rows = cartGrid.findRows(function(r){
                if(row.pid == r.pid) return true;
            });
            if(rows && rows.length>0){
                showMsg("此零件号已经添加到购物车!","W");
                return;
            }else{
                var newRow = {pid: row.pid, label: row.label, orderQty: quantity, orderPrice: 0};
                cartGrid.addRow(newRow);       
            }
        }else{
            var newRow = {pid: row.pid, label: row.label, orderQty: quantity, orderPrice: 0};
            cartGrid.addRow(newRow);       
        }
    }


}
// 提交单元格编辑数据前激发
function onCellCommitEdit(e) {
    var editor = e.editor;
    var record = e.record;
    var row = e.row;

    editor.validate();
    if (editor.isValid() == false) {
        showMsg("请输入数字!","W");
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
        showMsg("请选择配件信息!","w");
        return;
    }
}
function addToSellCart(){
    var rows = cartGrid.getSelecteds();
    if(rows && rows.length > 0){

        openGeneratePop(rows, "sellCartEpc", "添加销售车");

    }else{
        showMsg("请选择配件信息!","w");
        return;
    }
}
function generatePchsOrder(){
    var rows = cartGrid.getSelecteds();
    if(rows && rows.length > 0){

        openGeneratePop(rows, "pchsOrderEpc", "生成采购订单");

    }else{
        showMsg("请选择配件信息!","w");
        return;
    }
}
function generateSellOrder(){
    var rows = cartGrid.getSelecteds();
    if(rows && rows.length > 0){

        openGeneratePop(rows, "sellOrderEpc", "生成销售订单");

    }else{
        showMsg("请选择配件信息!","w");
        return;
    }
}

function copyEmbed() {
    var clipboard = new ClipboardJS('#copyBtn',{
        text: function (trigger) {
//            var value = document.getElementById('bar').value;\
        	var data=cartGrid.getData();
        	var value='';
        	for(var i=0;i<data.length;i++){
        		value+=data[i].pid+'\r\n';
        	}
            return value;
        }
    });
    clipboard.on('success',function (e) {
        showMsg("复制成功","S");
        e.clearSelection();
        clipboard.destroy();
    });
    clipboard.on('error',function (e) {
    	showMsg("复制失败,请重新复制","W");
        clipboard.destroy();
    });
}
