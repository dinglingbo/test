/**
 * Created by Administrator on 2018/1/24.
 */
var baseUrl = apiPath + repairApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var rightUnifyGrid = null;

var rightUnifyGridUrl = baseUrl+"com.hsapi.repair.baseData.query.queryRpbPart.biz.ext";
$(document).ready(function(v)
{


    rightUnifyGrid = nui.get("rightUnifyGrid");
    rightUnifyGrid.setUrl(rightUnifyGridUrl);

//    $("#queryCode").bind("keydown", function (e) {
//
//        if (e.keyCode == 13) {
//            onPartSearch();
//        }
//        
//    });
//    $("#namePy").bind("keydown", function (e) {
//
//        if (e.keyCode == 13) {
//            onPartSearch();
//        }
//        
//    });
    $("#partName").bind("keydown", function (e) {

        if (e.keyCode == 13) {
            onPartSearch();
        }
        
    });
    $("#partCodeSearch").bind("keydown", function (e) {

        if (e.keyCode == 13) {
            onUnifySearch();
        }
        
    });
    $("#namePySearch").bind("keydown", function (e) {

        if (e.keyCode == 13) {
            onUnifySearch();
        }
        
    });
    $("#partNameSearch").bind("keydown", function (e) {

        if (e.keyCode == 13) {
            onUnifySearch();
        }
        
    });
    
    onUnifySearch();
});

function onUnifySearch() {
    var params = {};
    params.partCode = nui.get("partCodeSearch").getValue();
    params.namePy = nui.get("namePySearch").getValue();
    params.partName = nui.get("partNameSearch").getValue();
    rightUnifyGrid.load({params:params,token:token});
 
}

function onActionRenderer(e) {
    var grid = e.sender;
    var record = e.record;
    var uid = record._uid;
    var rowIndex = e.rowIndex;

    var s =  '<a class="Edit_Button" href="javascript:editRow(\'' + uid + '\')">修改提成</a> ';
           
    return s;
}
function selectPart(callback, checkcallback) {
    nui.open({
        targetWindow : window,
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
        partName: row.name
    };
    rightUnifyGrid.addRow(newRow);
}

var saveUnifyUrl = baseUrl + "com.hsapi.repair.baseData.crud.saveRpbPart.biz.ext";
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
//                showMsg("保存成功!","S");
                rightUnifyGrid.reload();
                
            } else {
                showMsg(data.errMsg || "保存失败!","W");
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
        targetWindow: window,
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