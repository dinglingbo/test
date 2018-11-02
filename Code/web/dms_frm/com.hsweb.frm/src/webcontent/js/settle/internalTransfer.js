/**
 * Created by Administrator on 2018/2/23.
 */
var baseUrl = apiPath + frmApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.frm.others.queryInternalTransfer.biz.ext";

var searchBeginDate = null;
var searchEndDate = null;
var auditSignEl = null;
var mainGrid = null;
var list = null;
var accountList = null;
var accountTypeHash = {};
var auditSignHash = {
    "0":"否",
    "1":"是"
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
    auditSignEl = nui.get("postStatus");

    searchBeginDate.setValue(getNowStartDate());
    searchEndDate.setValue(addDate(getNowEndDate(), 1));

    getInComeExpenses(function(data) {
        list = data.list;
    });

    getAccountList(function(data) {
        accountList = data.settleAccount;
    });

    getSettleType(function(data) {
        var d = data.list || [];
        d.filter(function(v)
        {
            accountTypeHash[v.customid] = v;
            return true;
        });
    });

    doSearch();

});
var querySettleTypeUrl = baseUrl
        + "com.hsapi.frm.setting.querySettleType.biz.ext";
function getSettleType(callback) {
    nui.ajax({
        url : querySettleTypeUrl,
        data : {
            dictId: 'DDT20130703000031',
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
var queryUrl = baseUrl + "com.hsapi.frm.setting.queryFibInComeExpenses.biz.ext";
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
var queryAccountUrl = baseUrl + "com.hsapi.frm.setting.queryFiSettleAccount.biz.ext";
function getAccountList(callback) {
    nui.ajax({
        url : queryAccountUrl,
        data : {
            token: token
        },
        type : "post",
        success : function(data) {
            if (data && data.settleAccount) {
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
    params.auditSign = auditSignEl.getValue();
    
    params.sCreateDate = searchBeginDate.getValue();
    params.eCreateDate = searchEndDate.getValue();
    
    mainGrid.load({
        params: params,
        pageSize: 1000,
        token : token
    });
    mainGrid.on("drawcell", function (e){
    	onDrawCell(e);
    });
}
//提交单元格编辑数据前激发
function onCellCommitEdit(e) {
    var editor = e.editor;
    var record = e.record;
    
    editor.validate();
    if (editor.isValid() == false) {
        nui.alert("请输入数字！");
        e.cancel = true;
    }
}
function onDrawCell(e)
{
    switch (e.field)
    {
        case "postStatus":
            if(auditSignHash && auditSignHash[e.value])
            {
                e.cellHtml = auditSignHash[e.value];
            }
            break;
        case "balaTypeCode":
            if(accountTypeHash && accountTypeHash[e.value])
            {
                e.cellHtml = accountTypeHash[e.value].name;
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
    var newRow = {itemTypeCode: billTypeCode};
    mainGrid.updateRow(row, newRow);

}
function onRAccountChange(e){
    var se = e.selected;
    var code = se.code;
    var name = se.name;
    var row = mainGrid.getSelected();
    var newRow = {toAccountCode: code, toSettAccountName: name};
    mainGrid.updateRow(row, newRow);

}
function onPAccountChange(e){
    var se = e.selected;
    var code = se.code;
    var name = se.name;
    var row = mainGrid.getSelected();
    var newRow = {settAccountCode: code, settAccountName: name, balaTypeCode: null};
    mainGrid.updateRow(row, newRow);

}
function addInternalTransfer(){
    var newRow = {auditSign: 0};
    mainGrid.addRow(newRow);
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
        + "com.hsapi.frm.others.saveInternalTransferList.biz.ext";
function save(){
    var data = mainGrid.getData();

    if(data && data.length <= 0) return;

    var rows = mainGrid.findRow(function(row){
        var toSettAccountId = row.toSettAccountId;
        if(toSettAccountId){
            return false;
        }else{
            return true;
        }
    });

    if(rows) {
        nui.alert("请选择收款账户后再保存!");
        return;
    }

    var rows = mainGrid.findRow(function(row){
        var rpAmt = row.rpAmt;
        if(rpAmt){
            return false;
        }else{
            return true;
        }
    });

    if(rows) {
        nui.alert("请填写收款金额后再保存!");
        return;
    }

    var rows = mainGrid.findRow(function(row){
        var settAccountId = row.settAccountId;
        if(settAccountId){
            return false;
        }else{
            return true;
        }
    });

    if(rows) {
        nui.alert("请选择付款账户后再保存!");
        return;
    }

    var rows = mainGrid.findRow(function(row){
        var balaTypeCode = row.balaTypeCode;
        if(balaTypeCode){
            return false;
        }else{
            return true;
        }
    });

    if(rows) {
        nui.alert("请选择付款账户对应的付款方式后再保存!");
        return;
    }

    var rows = mainGrid.findRow(function(row){
        var itemTypeId = row.itemTypeId;
        if(itemTypeId){
            return false;
        }else{
            return true;
        }
    });

    if(rows) {
        nui.alert("请选择费用科目后再保存!");
        return;
    }

    var tranAdd = mainGrid.getChanges("added");
    var tranUpdate = mainGrid.getChanges("modified");
    var tranDelete = mainGrid.getChanges("removed");
    var tranAddList = [];
    var tranUpdateList = [];
    if(tranAdd){
        for(var i=0; i<tranAdd.length; i++){
            var temp = tranAdd[i];
            if(temp.createDate) {
                temp.createDate = format(temp.createDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
            }
            if(temp.operateDate) {
                temp.operateDate = format(temp.operateDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
            }
            tranAddList.push(temp);
        }

    }

    if(tranUpdate){
        for(var i=0; i<tranUpdate.length; i++){
            var temp = tranUpdate[i];
            if(temp.createDate) {
                temp.createDate = format(temp.createDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
            }
            if(temp.operateDate) {
                temp.operateDate = format(temp.operateDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
            }
            tranUpdateList.push(temp);

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
            tranAdd: tranAddList,
            tranUpdate: tranUpdateList,
            tranDelete: tranDelete
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                nui.alert("保存成功!");
                
                doSearch();
            } else {
                nui.alert(data.errMsg || "保存失败!");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
        }
    });

    
}
var auditUrl = baseUrl
        + "com.hsapi.frm.others.auditInternalTransferList.biz.ext";
function audit(){
    var rpAdd = mainGrid.getChanges("added");
    if(rpAdd && rpAdd.length > 0){
        nui.alert("请先保存数据再审核!");
        return;
    }

    var rpUpdate = mainGrid.getChanges("modified");
    if(rpUpdate && rpUpdate.length > 0){
        nui.alert("请先保存数据再审核!");
        return;
    }

    var rpDelete = mainGrid.getChanges("removed");
    if(rpDelete && rpDelete.length > 0){
        nui.alert("请先保存数据再审核!");
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
                tranBill: dataList
            }),
            success : function(data) {
                nui.unmask(document.body);
                data = data || {};
                if (data.errCode == "S") {
                    nui.alert("审核成功!");
                    
                    doSearch();
                } else {
                    nui.alert(data.errMsg || "审核失败!");
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
function OnrpMainGridCellBeginEdit(e){
    var column = e.column;
    var row = e.row;
    var column = e.column;
    var editor = e.editor;

    if(row.auditSign == 1){
        e.cancel = true;
    }

    if (column.field == "balaTypeCode") {
        var str = "accountId="+row.settAccountId;
        var url = baseUrl+"com.hsapi.frm.setting.queryAccountSettleType.biz.ext?" + str;
        editor.setUrl(url);
    }
}