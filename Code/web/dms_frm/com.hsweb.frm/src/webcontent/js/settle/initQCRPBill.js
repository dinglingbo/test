/**
 * Created by Administrator on 2018/2/23.
 */
var baseUrl =  apiPath + frmApi +  "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.frm.frmService.crud.queryQCRPBill.biz.ext";


var mainGrid = null;

$(document).ready(function(v)
{

    mainGrid = nui.get("mainGrid");
    mainGrid.setUrl(rightGridUrl);

    doSearch();

});
function doSearch() {
    var params = {};
    params.auditSign = 0;
    mainGrid.load({
        params: params,
        pageSize: 1000,
        token : token
    });
}
function onrpMainGridDrawCell(e){
    switch (e.field)
    {
        /*case "ramt":
            var row = e.row;
            if(row.billDc == 1) {
                e.cellHtml = row.rpAmt;
            }
            if(row.pamt){
                e.cancel = true;
            }
            break;
        case "pamt":
            var row = e.row;
            if(row.billDc == -1){
                e.cellHtml = row.rpAmt;
            }
            if(row.ramt){
                e.cancel = true;
            }
            break;*/
        default:
            break;
    }
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
function addGuest(){
    var supplier = null;
    nui.open({
        targetWindow: window,
        url: "com.hsweb.frm.arap.supplierSelect.flow",
        title: "往来单位", width: 980, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var params = {
                isSupplier: 1,
                isClient: 1
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

                    var newRow = {guestId: guestId, guestFullName: fullName, guestShortName: shortName, code: code, rpTypeId: 3};
                    mainGrid.addRow(newRow);
                }
                
            }
        }
    });
}
function OnMainGridCellBeginEdit(e){
    var column = e.column;
    var editor = e.editor;
    var row = e.row;
    if(row.ramt){
        if (column.field == "pamt") {
            e.cancel = true;
        }
    }else if(row.pamt){
        if (column.field == "ramt") {
            e.cancel = true;
        }
    }

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
    var rpAdd = mainGrid.getChanges("added");
    var rpUpdate = mainGrid.getChanges("modified");
    var rpDelete = mainGrid.getChanges("removed");
    var rpAddList = [];
    var rpUpdateList = [];
    var rpDeleteList = [];
    if(rpAdd){
        for(var i=0; i<rpAdd.length; i++){
            var temp = rpAdd[i];
            temp.guestName = temp.guestFullName;
            
            if(temp.ramt) {
            	nui.alert(temp.ramt);
                temp.rpAmt = temp.ramt;
                temp.rptype = 1;
                temp.rpAmtNo = temp.ramt;
            }else if(temp.pamt) {
            	nui.alert(temp.pamt);
            	temp.rpAmt = temp.pamt;
                temp.rptype = -1;
                temp.rpAmtNo = temp.pamt;
            }
            rpAddList.push(temp);
        }

    }

    if(rpUpdate){
        for(var i=0; i<rpUpdate.length; i++){
            var temp = rpUpdate[i];
            temp.guestName = temp.guestFullName;
            //如果将应收改成应付，加一个，删除一个
            if(temp.rptype == 1) {

                if(temp.ramt) {
                    temp.rpAmt = temp.ramt;
                    temp.rptype = 1;
                    temp.rpAmtNo = temp.ramt;
                    rpUpdateList.push(temp);
                }else if(temp.pamt) {
                    //先添加到删除里面
                    var t = nui.clone(temp);
                    rpDeleteList.push(t);

                    temp.id = null;
                    temp.rpAmt = temp.pamt;
                    temp.rptype = -1;
                    temp.rpAmtNo = temp.pamt;
                    rpAddList.push(temp);
                }
                

            }else if(temp.rptype == -1) {
                if(temp.pamt) {
                    temp.rpAmt = temp.pamt;
                    temp.rptype = -1;
                    temp.rpAmtNo = temp.pamt;
                    rpUpdateList.push(temp);
                }else if(temp.ramt) {
                    //先添加到删除里面
                    var t = nui.clone(temp);
                    rpDeleteList.push(t);

                    temp.id = null;
                    temp.rpAmt = temp.ramt;
                    temp.rptype = 1;
                    temp.rpAmtNo = temp.ramt;
                    rpAddList.push(temp);
                }
            }

        }

    }

    if(rpDelete){
        for(var i=0; i<rpDelete.length; i++){
            var temp = rpDelete[i];
            /*temp.guestName = temp.guestFullName;
            if(temp.ramt) {
                temp.rpAmt = temp.ramt;
                temp.billDc = 1;
                temp.noCharOffAmt = temp.ramt;
            }else if(temp.pamt) {
                temp.rpAmt = temp.ramt;
                temp.billDc = -1;
                temp.noCharOffAmt = temp.ramt;
            }*/
            rpDeleteList.push(temp);
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
            rpDelete: rpDeleteList
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
        + "com.hsapi.frm.QCRPBill.auditInitRpBill.biz.ext";
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

    var data = mainGrid.getData();
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
                rpBill: data
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
function importGuest(){

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
    

    nui.open({
        targetWindow: window,
        url: baseUrl + "com.hsweb.frm.arap.initQCRPBillImport.flow",
        title: "期初应收应付导入", 
        width: 930, 
        height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            //iframe.contentWindow.initData(data, storeId);
        },
        ondestroy: function (action)
        {
            doSearch();
        }
    });
}
