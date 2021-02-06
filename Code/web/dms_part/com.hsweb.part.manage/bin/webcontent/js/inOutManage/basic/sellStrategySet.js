/**
 * Created by Administrator on 2018/1/24.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var straGrid = null;
var rightGuestGrid = null;
var rightPartGrid = null;
var rightUnifyGrid = null;
var mainTabs = null;
var straGridUrl = baseUrl+"com.hsapi.part.baseDataCrud.crud.querySellStrategy.biz.ext";
var rightGuestGridUrl = baseUrl+"com.hsapi.part.baseDataCrud.crud.queryStrategyGuest.biz.ext";
var rightPartGridUrl = baseUrl+"com.hsapi.part.baseDataCrud.crud.queryStrategyPrice.biz.ext";
var rightUnifyGridUrl = baseUrl+"com.hsapi.part.baseDataCrud.crud.queryUnifyPrice.biz.ext";
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

    $("#queryCode").bind("keydown", function (e) {

        if (e.keyCode == 13) {
            onPartSearch();
        }
        
    });
    $("#namePy").bind("keydown", function (e) {

        if (e.keyCode == 13) {
            onPartSearch();
        }
        
    });
    $("#fullName").bind("keydown", function (e) {

        if (e.keyCode == 13) {
            onPartSearch();
        }
        
    });
    $("#queryCodeSearch").bind("keydown", function (e) {

        if (e.keyCode == 13) {
            onUnifySearch();
        }
        
    });
    $("#namePySearch").bind("keydown", function (e) {

        if (e.keyCode == 13) {
            onUnifySearch();
        }
        
    });
    $("#fullNameSearch").bind("keydown", function (e) {

        if (e.keyCode == 13) {
            onUnifySearch();
        }
        
    });

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
    params.queryCode = nui.get("queryCodeSearch").getValue();
    params.namePy = nui.get("namePySearch").getValue();
    params.fullName = nui.get("fullNameSearch").getValue();
    rightUnifyGrid.load({params:params,token:token});
 
}
function onAddNode()
{
    var newRow = {};
    straGrid.addRow(newRow);
}
var saveStraUrl = baseUrl + "com.hsapi.part.baseDataCrud.crud.saveSellStrategy.biz.ext";
function onSaveNode(){
    var data = straGrid.getChanges();
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
                showMsg("保存成功!","S");
                straGrid.reload();
                
            } else {
                showMsg(data.errMsg || "保存失败!","E");
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
    if(!row) {
        showMsg("请选择对应级别再添加客户!","W");
        return;
    }
    supplier = null;
    nui.open({
        // targetWindow: window,,
        url : webPath+contextPath+"/com.hsweb.part.common.guestSelect.flow?token="+token,
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
                
                //判断是否已经添加
                var strategyId = checkStraGuest(value);
                if(strategyId<=0){
                    var row = straGrid.getSelected();
                    var newRow = {
                        strategyId : row.id,
                        guestId: value,
                        fullName: text,
                        shortName: supplier.shortName
                    };
                    rightGuestGrid.addRow(newRow);
                }else{
                    var row = straGrid.findRow(function(row){
                        if(row.id == strategyId){
                            return true;
                        }
                    });
                    var name = "";
                    if(row && row.name){
                        name = '--'+row.name;
                    }
                    showMsg("此客户已经添加"+name+"!","W");
                } 

            }
        }
    });
}
var checkStraGuestUrl = baseUrl + "com.hsapi.part.baseDataCrud.crud.getSellPriceGuest.biz.ext";
function checkStraGuest(guestId){
    var row = rightGuestGrid.findRow(function(row){
        if(row.guestId == guestId) {
            return true;
        }
        return false;
    });
    if(row){
        return row.strategyId||0;
    }

    var strategyId = 0;
    nui.ajax({
        url : checkStraGuestUrl,
        async:false,
        type : "post",
        data : JSON.stringify({
            guestId : guestId,
            token: token
        }),
        success : function(data) {
            data = data || {};
            var guest = data.guest;
            if (guest && guest.length>0) {
                strategyId = guest[0].strategyId;
            } else {
                strategyId = 0;
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
            strategyId = 0;
        }
    });
    return strategyId;
}
var saveStraGuestUrl = baseUrl + "com.hsapi.part.baseDataCrud.crud.saveStrategyGuest.biz.ext";
function saveStraGuest(){
    var row = straGrid.getSelected();
    if(!row) {
        showMsg("请先选择对应级别再操作!","W");
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
                showMsg("保存成功!","S");
                rightGuestGrid.reload();
                
            } else {
                showMsg(data.errMsg || "保存失败!","E");
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
        showMsg("请先选择对应级别再操作!","W");
        return;
    }

    var rows = rightGuestGrid.getSelecteds();
    if(rows && rows.length>0){
        rightGuestGrid.removeRows(rows);
    }
}
function importPart(){
    var row = straGrid.getSelected();
    row = row||{};
    if(!row || !row.id) {
        showMsg("请先选择对应级别再操作!","W");
        return;
    }

    var changes = rightPartGrid.getChanges();
    if(changes.length>0){
        showMsg("请先保存数据!","W");
        return;
    }

    nui.open({
        // targetWindow: window,
        url: webPath + contextPath + "/com.hsweb.part.manage.importPartPrice.flow?token="+token,
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
        // targetWindow: window,,
        url : webPath+contextPath+"/com.hsweb.part.common.partSelectView.flow?token="+token,
        title : "配件选择",
        width : 930,
        height : 560, 
        allowDrag : true,
        allowResize : true,
        onload : function() {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setCloudPartData("cloudPart",callback,checkcallback);
        },
        ondestroy : function(action) {
        }
    });
}
function addPart() {

    var row = straGrid.getSelected();
    if(!row) {
        showMsg("请选择对应级别再添加配件!","W");
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
    // var row = rightUnifyGrid.findRow(function(row){
    //     if(row.partId == partid) {
    //         return true;
    //     }
    //     return false;
    // });
    
    // if(row) 
    // {
    //     return "配件ID："+partid+"在列表中已经存在，是否继续？";
    // }
    
    return null;
    
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
    } 
}
function addPartDetail(row, strategyId){
    var crow = rightUnifyGrid.findRow(function(row){
        if(row.partId == row.id) {
            return true;
        }
        return false;
    });
    if(crow) return;

    var check = checkStraPart(strategyId, row.id);
    if(check > 0) {
        //showMsg("此配件已经添加，可直接查询出来修改!","W");
        return;
    }

    var newRow = {
        strategyId : strategyId,
        partId: row.id,
        partCode: row.code,
        fullName: row.fullName
    };
    rightPartGrid.addRow(newRow);
}
var checkStraPartUrl = baseUrl + "com.hsapi.part.baseDataCrud.crud.getSellPricePart.biz.ext";
function checkStraPart(strategyId, partId){
    var check = 0;
    nui.ajax({
        url : checkStraPartUrl,
        async:false,
        type : "post",
        data : JSON.stringify({
            strategyId: strategyId,
            partId : partId,
            token: token
        }),
        success : function(data) {
            data = data || {};
            var part = data.part;
            if (part && part.length>0) {
                check = 1;
            } else {
                check = 0;
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
            check = 0;
        }
    });
    return check;
}
function delStraPart(){
    var row = straGrid.getSelected();
    if(!row.id) {
        showMsg("请先选择对应级别再操作!","W");
        return;
    }

    var rows = rightPartGrid.getSelecteds();
    if(rows && rows.length>0){
        rightPartGrid.removeRows(rows);
    }
}
var saveStraPartUrl = baseUrl + "com.hsapi.part.baseDataCrud.crud.saveStrategyPart.biz.ext";
function saveStraPart(){
    var row = straGrid.getSelected();
    if(!row.id) {
        showMsg("请先选择对应级别再操作!","W");
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
                showMsg("保存成功!","S");
                rightPartGrid.reload();
                
            } else {
                showMsg(data.errMsg || "保存失败!","E");
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

    var rows = rightGuestGrid.getSelecteds();
    if(rows && rows.length>0){
        rightGuestGrid.removeRows(rows);
    }
}
var saveUnifyUrl = baseUrl + "com.hsapi.part.baseDataCrud.crud.savePartPrice.biz.ext";
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
                showMsg("保存成功!","S");
                rightUnifyGrid.reload();
                
            } else {
                showMsg(data.errMsg || "保存失败!","E");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function delUnifyPart(){
    var rows = rightUnifyGrid.getSelecteds();
    if(rows && rows.length>0){
        rightUnifyGrid.removeRows(rows,true);
    }
}
function importUnifyPart(){
    
    var changes = rightUnifyGrid.getChanges();
    if(changes.length>0){
        showMsg("请先保存数据!","W");
        return;
    }
    nui.open({
        // targetWindow: window,
        url: webPath + contextPath + "/com.hsweb.part.manage.importPartPrice.flow?token="+token,
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