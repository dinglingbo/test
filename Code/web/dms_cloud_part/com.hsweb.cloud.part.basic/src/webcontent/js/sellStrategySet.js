/**
 * Created by Administrator on 2018/1/24.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var straGrid = null;
var rightGuestGrid = null;
var rightPartGrid = null;
var rightUnifyGrid = null;
var mainTabs = null;
var straGridUrl = baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.querySellStrategy.biz.ext";
var rightGuestGridUrl = baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.queryStrategyGuest.biz.ext";
var rightPartGridUrl = baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.queryStrategyPrice.biz.ext";
var rightUnifyGridUrl = baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.queryUnifyPrice.biz.ext";
$(document).ready(function(v)
{
    mainTabs = nui.get("mainTabs");
	straGrid = nui.get("straGrid");
    straGrid.setUrl(straGridUrl);
    straGrid.load({token:token});

    rightGuestGrid = nui.get("rightGuestGrid");
    rightGuestGrid.setUrl(rightGuestGridUrl);

    rightPartGrid = nui.get("rightPartGrid");
    rightPartGrid.setUrl(rightPartGridUrl);

    rightUnifyGrid = nui.get("rightUnifyGrid");
    rightUnifyGrid.setUrl(rightUnifyGridUrl);


});
function onStraGridClick(e){
    var row = e.row;
    var tab = mainTabs.getActiveTab();
    var strategyId = row.id||0;
    var params = {strategyId: strategyId,token:token};
    if(tab.name == "guestInfo"){
        rightGuestGrid.load({params:params});
    }else if(tab.name == "partInfo"){
        rightPartGrid.load({params:params});  
    }
}

function onGuestSearch() {
    var row = straGrid.getSelected();
    if(row && row.id){
        var params = {};
        params.strategyId = row.id;
        params.namePy = nui.get("GuestNamePy").getValue();
        params.fullName = nui.get("GuestFullName").getValue();
        rightGuestGrid.load({params:params,token:token});
    }
}
function onPartSearch() {
    var row = straGrid.getSelected();
    if(row && row.id){
        var params = {};
        params.strategyId = row.id;
        params.queryCode = nui.get("queryCode").getValue();
        params.namePy = nui.get("namePy").getValue();
        params.fullName = nui.get("fullName").getValue();
        rightPartGrid.load({params:params,token:token});
    }
}
function onUnifySearch() {
    var params = {};
    params.queryCode = nui.get("queryCode").getValue();
    params.namePy = nui.get("namePy").getValue();
    params.fullName = nui.get("fullName").getValue();
    rightUnifyGrid.load({params:params,token:token});
 
}
function onAddNode()
{
    var newRow = {};
    straGrid.addRow(newRow);
}
var saveStraUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.saveSellStrategy.biz.ext";
function onSaveNode(){
    var data = rightPartGrid.getChanges();
    if(data.length<=0) return;
    var addList = straGrid.getChanges("added");
    var updateList = straGrid.getChanges("modified");

    nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '保存中...'
    });

    nui.ajax({
        url : saveStraUrl,
        type : "post",
        data : JSON.stringify({
            addList : addList,
            updateList : updateList,
            token: token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                nui.alert("保存成功!","",function(e){
                    straGrid.reload();
                });
                
            } else {
                nui.alert(data.errMsg || "保存失败!");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
var supplier = null;
function selectSupplier(elId) {
    var row = straGrid.getSelected();
    if(!row.id) {
        nui.alert("请选择对应级别再添加客户!");
        return;
    }
    supplier = null;
    nui.open({
        targetWindow : window,
        url : webPath+partDomain+"/com.hsweb.part.common.guestSelect.flow?token="+token,
        title : "客户资料",
        width : 980,
        height : 560,
        allowDrag : true,
        allowResize : true,
        onload : function() {
            var iframe = this.getIFrameEl();
            var params = {
                isClient: 1
            };
            iframe.contentWindow.setGuestData(params);
        },
        ondestroy : function(action) {
            if (action == 'ok') {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();

                supplier = data.supplier;
                var value = supplier.id;
                var text = supplier.fullName;
                

                var row = straGrid.getSelected();
                var newRow = {
                    strategyId : row.id,
                    guestId: value,
                    fullName: text,
                    shortName: supplier.shortName
                };
                rightGuestGrid.addRow(newRow);

            }
        }
    });
}
var saveStraGuestUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.saveStrategyGuest.biz.ext";
function saveStraGuest(){
    var row = straGrid.getSelected();
    if(!row.id) {
        nui.alert("请先选择对应级别再操作!");
        return;
    }
    var data = rightGuestGrid.getChanges();
    if(data.length<=0) return;
    var addList = rightGuestGrid.getChanges("added");
    var deleteList = rightGuestGrid.getChanges("removed");

    nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '保存中...'
    });

    nui.ajax({
        url : saveStraGuestUrl,
        type : "post",
        data : JSON.stringify({
            stragegyId: row.id,
            addList : addList,
            deleteList : deleteList,
            token: token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                nui.alert("保存成功!","",function(e){
                    rightGuestGrid.reload();
                });
                
            } else {
                nui.alert(data.errMsg || "保存失败!");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function delStraGuest(){
    var row = straGrid.getSelected();
    if(!row.id) {
        nui.alert("请先选择对应级别再操作!");
        return;
    }

    var rows = rightGuestGrid.getSelecteds();
    if(rows && rows.length>0){
        rightGuestGrid.removeRows(rows);
    }
}
function importPart(){
    var row = straGrid.getSelected();
    if(!row.id) {
        nui.alert("请先选择对应级别再操作!");
        return;
    }

    var changes = rightPartGrid.getChanges();
    if(changes.length>0){
        nui.alert("请先保存数据!");
        return;
    }

    nui.open({
        targetWindow: window,
        url: webPath + cloudPartDomain + "/com.hsweb.cloud.part.basic.importPartPrice.flow?token="+token,
        title: "价格导入", 
        width: 930, 
        height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var data = {};
            data.strategyId = row.id;
            data.type = "strategy";
            iframe.contentWindow.initData(data);
        },
        ondestroy: function (action)
        {
            rightPartGrid.reload();
        }
    });
}
function selectPart(callback, checkcallback) {
    nui.open({
        targetWindow : window,
        url : webPath+cloudPartDomain+"/com.hsweb.cloud.part.common.partSelectView.flow?token="+token,
        title : "配件选择",
        width : 930,
        height : 560, 
        allowDrag : true,
        allowResize : true,
        onload : function() {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData({}, callback, checkcallback);
        },
        ondestroy : function(action) {
        }
    });
}
function addPart() {

    var row = straGrid.getSelected();
    if(!row.id) {
        nui.alert("请选择对应级别再添加客户!");
        return;
    }

    selectPart(function(data) {
        var part = data.part;
        addPartDetail(part, row.id);
    },function(data) {
        var part = data.part;
        var partid = part.id;
        var rtn = checkPartIDExists(partid);
        return rtn;
    });
}
function checkPartIDExists(partid){
    var row = rightPartGrid.findRow(function(row){
        if(row.partId == partid) {
            return true;
        }
        return false;
    });
    
    if(row) 
    {
        return "配件ID："+partid+"在盘盈订单列表中已经存在，是否继续？";
    }
    
    return null;
    
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
    } 
}
function addPartDetail(row, strategyId){
    var newRow = {
        strategyId : strategyId,
        partId: row.id,
        partCode: row.code,
        fullName: row.fullName
    };
    rightPartGrid.addRow(newRow);
}
function delStraPart(){
    var row = straGrid.getSelected();
    if(!row.id) {
        nui.alert("请先选择对应级别再操作!");
        return;
    }

    var rows = rightPartGrid.getSelecteds();
    if(rows && rows.length>0){
        rightPartGrid.removeRows(rows);
    }
}
var saveStraPartUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.saveStrategyPart.biz.ext";
function saveStraPart(){
    var row = straGrid.getSelected();
    if(!row.id) {
        nui.alert("请先选择对应级别再操作!");
        return;
    }
    var data = rightPartGrid.getChanges();
    if(data.length<=0) return;
    var addList = rightPartGrid.getChanges("added");
    var deleteList = rightPartGrid.getChanges("removed");
    var updateList = rightPartGrid.getChanges("modified");

    nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '保存中...'
    });

    nui.ajax({
        url : saveStraPartUrl,
        type : "post",
        data : JSON.stringify({
            stragegyId: row.id,
            addList : addList,
            deleteList : deleteList,
            updateList: updateList,
            token: token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                nui.alert("保存成功!","",function(e){
                    rightPartGrid.reload();
                });
                
            } else {
                nui.alert(data.errMsg || "保存失败!");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function addUnifyPart() {

    selectPart(function(data) {
        var part = data.part;
        addUnifyDetail(part);
    },function(data) {
        var part = data.part;
        var partid = part.id;
        

    });
}
function addUnifyDetail(row){
    var newRow = {
        partId: row.id,
        partCode: row.code,
        fullName: row.fullName
    };
    rightUnifyGrid.addRow(newRow);
}
function delStraGuest(){

    var rows = rightUnifyGrid.getSelecteds();
    if(rows && rows.length>0){
        rightUnifyGrid.removeRows(rows);
    }
}
var saveUnifyUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.savePartPrice.biz.ext";
function saveUnifyPart(){

    var data = rightUnifyGrid.getChanges();
    if(data.length<=0) return;
    var addList = rightUnifyGrid.getChanges("added");
    var deleteList = rightUnifyGrid.getChanges("removed");
    var updateList = rightUnifyGrid.getChanges("modified");

    nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '保存中...'
    });

    nui.ajax({
        url : saveUnifyUrl,
        type : "post",
        data : JSON.stringify({
            addList : addList,
            deleteList : deleteList,
            updateList: updateList,
            token: token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                nui.alert("保存成功!","",function(e){
                    rightUnifyGrid.reload();
                });
                
            } else {
                nui.alert(data.errMsg || "保存失败!");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function importUnifyPart(){
    var changes = rightUnifyGrid.getChanges();
    if(changes.length>0){
        nui.alert("请先保存数据!");
        return;
    }
    nui.open({
        targetWindow: window,
        url: webPath + cloudPartDomain + "/com.hsweb.cloud.part.basic.importPartPrice.flow?token="+token,
        title: "价格导入", 
        width: 930, 
        height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var data = {};
            data.type = "unify";
            iframe.contentWindow.initData(data);
        },
        ondestroy: function (action)
        {
            rightUnifyGrid.reload();
        }
    });
}