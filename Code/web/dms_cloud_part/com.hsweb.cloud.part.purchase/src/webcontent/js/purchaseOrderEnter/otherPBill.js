/**
 * Created by Administrator on 2018/2/23.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.settle.svr.queryRPAccountList.biz.ext";

var searchBeginDate = null;
var searchEndDate = null;
var comSearchGuestId = null;
var auditSignEl = null;
var mainGrid = null;
var list = null;
var auditSignHash = {
    "0":"否",
    "1":"是"
};
var settleStatusHash = {
    "0":"未结算",
    "1":"部分结算",
    "2":"已结算"
};
var auditSignList = [
    {id:0,text:"未审"},
    {id:1,text:"已审"}
];
//var guestId =0;
var code ="";
var codeId =0;
var orderTypeId = 0;
//var guestName ="";
$(document).ready(function(v)
{

    mainGrid = nui.get("mainGrid");
    mainGrid.setUrl(rightGridUrl);
   
    getInComeExpenses(function(data) {
        list = data.list;
        //billTypeListEl.setUrl(list);
    });

   

});
function OnrpMainGridCellBeginEdit(e){
    var field=e.field; 
    var editor = e.editor;
    var row = e.row;
    if(field=="billTypeId"){
         editor.setData(list);
    }
    if(row.auditSign == 1){
        e.cancel = true;
    }
}
var queryUrl = baseUrl + "com.hsapi.cloud.part.settle.svr.queryFibInComeExpenses.biz.ext";
function getInComeExpenses(callback) {
    var params = {itemTypeId : -1, isMain: 0};
    nui.ajax({
        url : queryUrl,
        data : {
            params: params,
            token: token
        },
        type : "post",
        success : function(data) {
            if (data && data.list) {
                callback && callback(data);
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function doSearch() {
    var params = {};
    params.billDc = -1;
    //params.auditSign = 0;
    params.rpTypeId = 2;
    params.codeId =codeId;
//    params.guestId = comSearchGuestId.getValue();
    


    mainGrid.load({
        params: params,
        pageSize: 1000,
        token : token
    });
}
//提交单元格编辑数据前激发
function onCellCommitEdit(e) {
    var editor = e.editor;
    var record = e.record;
    
    editor.validate();
    if (editor.isValid() == false) {
    	 showMsg("请输入数字！","W");
//        nui.alert("请输入数字！");
        e.cancel = true;
    }
}
function onDrawCell(e)
{
    switch (e.field)
    {
        case "settleStatus":
            if(settleStatusHash && settleStatusHash[e.value])
            {
                e.cellHtml = settleStatusHash[e.value];
            }
            break;
        case "auditSign":
            if(auditSignHash && auditSignHash[e.value])
            {
                e.cellHtml = auditSignHash[e.value];
            }
            break;
            
        case "optBtn":
                e.cellHtml = '<span class="fa fa-plus" onClick="javascript:addNewRow()" title="添加行">&nbsp;&nbsp;</span>' +
                            ' <span class="fa fa-close" onClick="javascript:deleteRow()" title="删除行"></span>';
            break;
        default:
            break;
    }
}
function onbillTypeChange(e){
    var se = e.selected;
    var billTypeCode = se.code;
    var row = mainGrid.getSelected();
    var newRow = {billTypeCode: billTypeCode};
    mainGrid.updateRow(row, newRow);

}
//function addGuest(){
//    var supplier = null;
//    nui.open({
//        // targetWindow: window,
//        url: "com.hsweb.cloud.part.common.supplierSelect.flow",
//        title: "选择往来单位", width: 980, height: 560,
//        allowDrag:true,
//        allowResize:true,
//        onload: function ()
//        {
//            var iframe = this.getIFrameEl();
//            var params = {
//                isSupplier: 1,
//                isClient: 0
//            };
//            iframe.contentWindow.setData(params);
//        },
//        ondestroy: function (action)
//        {
//            if(action == 'ok')
//            {
//                var iframe = this.getIFrameEl();
//                var data = iframe.contentWindow.getData();
//               
//                supplier = data.supplier;
//                if(supplier){
//                    var guestId = supplier.id;
//                    var fullName = supplier.fullName;
//                    var shortName  = supplier.shortName;
//                    var code = supplier.code;
//
//                    var newRow = {guestId: guestId, guestName: fullName, billDc: -1, rpTypeId: 2};
//                    mainGrid.addRow(newRow);
//                }
//                
//            }
//        }
//    });
//}
function deleteRow(){
    var record = mainGrid.getSelected();
    if(record.auditSign == 1) return;
    if(!record)
    {
        return;
    }
    mainGrid.removeRow(record,true);
}
var saveUrl = baseUrl
        + "com.hsapi.cloud.part.settle.svr.saveInitRpBill.biz.ext";
function save(){
    var data = mainGrid.getData();

    if(data && data.length <= 0) return;

    var rows = mainGrid.findRow(function(row){
        var billTypeId = row.billTypeId;
        if(billTypeId){
            return false;
        }else{
            return true;
        }
    });

    if(rows) {
    	showMsg("请选择收支项目后再保存!","W");
//        nui.alert("请选择收支项目后再保存!");
        return;
    }
    
    var status = checkBillStatus(codeId);
    if(status) {
    	showMsg("此单已入库，不能修改费用!","W");
    	return;
    }

    var rpAdd = mainGrid.getChanges("added");
    var rpUpdate = mainGrid.getChanges("modified");
    var rpDelete = mainGrid.getChanges("removed");
    var rpAddList = [];
    var rpUpdateList = [];
    if(rpAdd){
        for(var i=0; i<rpAdd.length; i++){
            var temp = rpAdd[i];
            temp.billDc=-1;
            if(temp.createDate) {
                temp.createDate = format(temp.createDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
            }
            if(temp.operateDate) {
                temp.operateDate = format(temp.operateDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
            }
            rpAddList.push(temp);
        }

    }

    if(rpUpdate){
        for(var i=0; i<rpUpdate.length; i++){
            var temp = rpUpdate[i];
            if(temp.createDate) {
                temp.createDate = format(temp.createDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
            }
            if(temp.operateDate) {
                temp.operateDate = format(temp.operateDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
            }
            rpUpdateList.push(temp);

        }

    }
    
    nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '保存中...'
    });

    nui.ajax({
        url : saveUrl,
        type : "post",
        data : JSON.stringify({
            rpAdd: rpAddList,
            rpUpdate: rpUpdateList,
            rpDelete: rpDelete,
            token: token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
            	showMsg("保存成功!","S");
//                nui.alert("保存成功!");
                
                doSearch();
            } else {
            	showMsg(data.errMsg || "保存失败!","E");
//                nui.alert(data.errMsg || "保存失败!");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
        }
    });

    
}

function refresh(){
    doSearch();
}
function selectSupplier(elId)
{
    supplier = null;
    nui.open({
        // targetWindow: window,
        url: "com.hsweb.cloud.part.common.supplierSelect.flow",
        title: "结算单位资料", width: 980, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {

        },
        ondestroy: function (action)
        {
            if(action == 'ok')
            {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                supplier = data.supplier;
                var value = supplier.id;
                var text = supplier.fullName;
                var el = nui.get(elId);
                el.setValue(value);
                el.setText(text);
            }
        }
    });
}

function onCancel(){
	 CloseWindow("cancel");
}
function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function addNewRow(){
	
	supplier = null;
    nui.open({
        // targetWindow: window,,
        url : webPath+contextPath+"/com.hsweb.cloud.part.common.guestSelect.flow?token="+token,
        title : "选择往来单位",
        width : 880,
        height : 560,
        allowDrag : true,
        allowResize : true,
        onload : function() {
            var iframe = this.getIFrameEl();
            var params = {
//                isSupplier: 1,
//                guestType:'01020202'
            };
            iframe.contentWindow.setGuestData(params);
        },
        ondestroy : function(action) {
            if (action == 'ok') {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();

                supplier = data.supplier;
                var guestId = supplier.id;
                var guestName = supplier.fullName;
                var newRow={
            			guestId :guestId,
            			code : code,
            			codeId :codeId,
            			orderTypeId :orderTypeId,
            			guestName :guestName,
            			billDc: -1,
            			rpTypeId: 2
            		};
        		mainGrid.addRow(newRow);
            }

        }
    });

	
}

function deleteRow(){
	mainGrid.removeRow(mainGrid.getSelected());
}

function setData(params){
//	guestId =params.guestId;
	code =params.code;
	codeId =params.codeId;
	orderTypeId = params.orderTypeId;
//	guestName = params.guestName;
	doSearch();
	
	var status = checkBillStatus(codeId);
	if(status) {
		nui.get('addBtn').disable();
		nui.get('saveBtn').disable();
	}else {
		nui.get('addBtn').enable();
		nui.get('saveBtn').enable();
	}
}

function checkBillStatus(mainId) {
	var status = false;
	nui.ajax({
        url : baseUrl + "com.hsapi.cloud.part.invoicing.svr.getPjPchsOrderMainChkById.biz.ext",
        type : "post",
        async: false,
        data : JSON.stringify({
        	mainId: mainId,
        	token:token
        }),
        success : function(text) {
            var main = text.main || {};
            if(main.isFinished && main.isFinished == 1) {
            	status = true;
            }else {
            	status = false;
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
        }
    });
	return status;

}

