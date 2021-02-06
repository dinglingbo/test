/**
 * Created by Administrator on 2018/2/23.
 */
var baseUrl = apiPath + frmApi + "/"; 
var partBaseUrl = apiPath + partApi + "/";
var rightGridUrl = baseUrl+"com.hsapi.frm.frmService.crud.queryRPAccountList.biz.ext";

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
    "0":"未付款",
    "1":"部分付款",
    "2":"已付款"
};
var auditSignList = [
    {id:0,text:"未审"},
    {id:1,text:"已审"}
];
$(document).ready(function(v)
{

    mainGrid = nui.get("mainGrid");
    mainGrid.setUrl(rightGridUrl);
    searchBeginDate = nui.get("beginDate");
    searchEndDate = nui.get("endDate");
    comSearchGuestId = nui.get("searchGuestId");
    auditSignEl = nui.get("auditSign");

    searchBeginDate.setValue(getNowStartDate());
    searchEndDate.setValue(getNowEndDate());
	  var filter = new HeaderFilter(mainGrid, {
	        columns: [
	            { name: 'auditor' },
		            { name: 'guestName' },
	            { name: 'carNo' },
	        ],
	        callback: function (column, filtered) {
	        },

	        tranCallBack: function (field) {
	        	var value = null;
	        	switch(field){
		    	}
	        	return value;
	        }
	    });
    getInComeExpenses(function(data) {
        list = data.list;
        //billTypeListEl.setUrl(list);
    });

    doSearch();

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
var queryUrl = baseUrl + "com.hsapi.frm.frmService.crud.queryFibInComeExpenses.biz.ext";
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
            console.log(jqXHR.responseText);
        }
    });
}
function doSearch() {
    var params = {};
    params.billDc = -1;
    params.auditSign = auditSignEl.getValue();
    params.rpTypeId = 2;
    params.guestId = comSearchGuestId.getValue();
    
    params.sCreateDate = searchBeginDate.getFormValue();
    params.eCreateDate = (addDate(searchEndDate.getValue(), 1));
	var settleStatus = nui.get("settleStatus").getValue();
	if(settleStatus != 3) {
		params.settleStatus = settleStatus;
	}
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
        showMsg("请输入数字!","W");
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
function addGuest(){
    var supplier = null;
    nui.open({
        // targetWindow: window,
//        url: "com.hsweb.frm.arap.supplierSelect.flow",
        url: webPath+contextPath+"/com.hsweb.part.common.guestSelect.flow?token="+token,
        title: "选择往来单位", width: 980, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var params = {
                isSupplier: 1,
                isClient: 0
            };
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action)
        {
            if(action == 'ok')
            {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
               
                supplier = data.supplier;
                if(supplier){
                    var guestId = supplier.id;
                    var fullName = supplier.fullName;
                    var shortName  = supplier.shortName;
                    var code = supplier.code;

                    var newRow = {guestId: guestId, guestName: fullName, billDc: -1, rpTypeId: 2};
                    mainGrid.addRow(newRow);
                }
                
            }
        }
    });
}
function deleteGuest(){
    var record = mainGrid.getSelected();
    if(record.auditSign == 1) return;
    if(!record)
    {
        return;
    }
    mainGrid.removeRow(record,true);
}
var saveUrl = baseUrl
        + "com.hsapi.frm.frmService.crud.saveInitRpBill.biz.ext";
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
            rpDelete: rpDelete
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                showMsg("保存成功!","S");
                
                doSearch();
            } else {
                showMsg(data.errMsg || "保存失败!","E");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
        }
    });

    
}
var auditUrl = baseUrl
        + "com.hsapi.frm.frmService.crud.auditInitRpBill.biz.ext";
function audit(){
    var rpAdd = mainGrid.getChanges("added");
    if(rpAdd && rpAdd.length > 0){
        showMsg("请先保存数据再审核!","W");
        return;
    }

    var rpUpdate = mainGrid.getChanges("modified");
    if(rpUpdate && rpUpdate.length > 0){
        showMsg("请先保存数据再审核!","W");
    }

    var rpDelete = mainGrid.getChanges("removed");
    if(rpDelete && rpDelete.length > 0){
        showMsg("请先保存数据再审核!","W");
        return;
    }

    var data = mainGrid.getSelecteds();
    var dataList = [];
    if(data){
        for(var i=0; i<data.length; i++){
            var temp = data[i];
            if(temp.createDate) {
                temp.createDate = format(temp.createDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
            }
            if(temp.operateDate) {
                temp.operateDate = format(temp.operateDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
            }
            dataList.push(temp);
        }

    }

    if(data) {
        nui.mask({
            el : document.body,
            cls : 'mini-mask-loading',
            html : '审核中...'
        });

        nui.ajax({
            url : auditUrl,
            type : "post",
            data : JSON.stringify({
                rpBill: dataList
            }),
            success : function(data) {
                nui.unmask(document.body);
                data = data || {};
                if (data.errCode == "S") {
                    showMsg("审核成功!","S");
                    
                    doSearch();
                } else {
                    showMsg(data.errMsg || "审核失败!","E");
                }
            },
            error : function(jqXHR, textStatus, errorThrown) {
                console.log(jqXHR.responseText);
            }
        });
    }
}
function refresh(){
    doSearch();
}
function selectSupplier(elId)
{
    supplier = null;
    nui.open({
        // targetWindow: window,
//        url: "com.hsweb.frm.arap.supplierSelect.flow",
        url: webPath+contextPath+"/com.hsweb.part.common.guestSelect.flow?token="+token,
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