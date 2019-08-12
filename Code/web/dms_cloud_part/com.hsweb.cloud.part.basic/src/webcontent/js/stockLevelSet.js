/**
 * Created by Administrator on 2018/1/24.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var rightUnifyGrid = null;
var straGrid = null;

var rightUnifyGridUrl = baseUrl+"com.hsapi.cloud.part.baseDataCrud.query.queryStockLevelPart.biz.ext";
var straGridUrl =  apiPath +sysApi+"/"+"com.hsapi.system.dict.dictMgr.queryDict.biz.ext";

var salesDeductTypeEl= null;
var DICTID="10443";
var statuList = [{id:"0",name:"编码"},{id:"1",name:"名称"}];
var statusList = [{id:0,name:"启用"},{id:1,name:"禁用"}];
var statusHash = { 0: "启用", 1: "禁用" };
$(document).ready(function(v)
{
    rightUnifyGrid = nui.get("rightUnifyGrid");
    rightUnifyGrid.setUrl(rightUnifyGridUrl);
    advancedDecuetSetWin=nui.get('advancedDecuetSetWin');
    straGrid = nui.get("straGrid");
    straGrid.setUrl(straGridUrl);
    doSearch();

    $("#partNameSearch").bind("keydown", function (e) {

        if (e.keyCode == 13) {
            onUnifySearch();
        }
        
    });
    straGrid.on("drawcell",function(e){
        switch (e.field) {
            case "isDisabled":
                if (statusHash[e.value]) {
                    e.cellHtml = statusHash[e.value] || "";
                } else {
                    e.cellHtml = "";
                }
				break;
			
            default:
                break;
        }
    });
    
    rightUnifyGrid.on("drawcell",function(e){
    	switch(e.field){

    		case "type":
    			if(e.row.type){
    				for(var i=0;i<typeList.length;i++){
    					if(e.row.type==typeList[i].id){    						
    						e.cellHtml = typeList[i].text || "";
    					}
    				}
    			}
    			break;
    		default:
    			break;
    	}
    });
});

function onAddNode()
{
    var newRow = {};
    straGrid.addRow(newRow);
}

var saveStraUrl =apiPath +sysApi+"/" + "com.hsapi.system.dict.dictMgr.saveDictList.biz.ext";
function onSaveNode(){
    var addList = straGrid.getChanges("added");
    var updateList = straGrid.getChanges("modified");
    for (var k = 0; k < updateList.length; k++) {
        var uptemp = updateList[k];
        if (uptemp.name == null || uptemp.name == "" || uptemp.name == undefined) {
            parent.showMsg('修改行的'+nullMsg,"W");
            return;
        }
    }
    var addArr = [];
    for (var i = 0; i < addList.length; i++) {
        var temp = addList[i];
        if (temp.name) {
            addArr.push(temp)
        }
    }
    nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '保存中...'
	});

	nui.ajax({
		url : saveStraUrl,
		type : "post",
		data : JSON.stringify({
			addList : addArr,
			updateList : updateList,
			dictid : DICTID,
			token: token
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
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});

}

function doSearch(){
	straGrid.load({
    	params:{
			sortField:"record_date",
			sortOrder:"asc"
		},
		tenantId:currTenantId,
		dictid:DICTID,
		fromDb:true,
		token:token
		});
    
}
//var saveStraUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.saveStockLevel.biz.ext";
//function onSaveNode(){
//    var data = straGrid.getChanges();
//    if(data.length<=0) return;
//    var addList = straGrid.getChanges("added");
//    var updateList = straGrid.getChanges("modified");
//
//    nui.mask({
//        el : document.body,
//        cls : 'mini-mask-loading',
//        html : '保存中...'
//    });
//
//    nui.ajax({
//        url : saveStraUrl,
//        type : "post",
//        data : JSON.stringify({
//            addList : addList,
//            updateList : updateList,
//            token: token
//        }),
//        success : function(data) {
//            nui.unmask(document.body);
//            data = data || {};
//            if (data.errCode == "S") {
//                showMsg("保存成功!","S");
//                straGrid.reload();
//                
//            } else {
//                showMsg(data.errMsg || "保存失败!","E");
//            }
//        },
//        error : function(jqXHR, textStatus, errorThrown) {
//            // nui.alert(jqXHR.responseText);
//            console.log(jqXHR.responseText);
//        }
//    });
//}
//删除策略价格节点
var delNodeUrl=baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.deleteStockLevel.biz.ext";
function onDeleteNode(){
	var data = straGrid.getSelected();
	var id=data.id;
	nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '删除中...'
    });
	
	nui.ajax({
        url : delNodeUrl,
        type : "post",
        data : JSON.stringify({
            id : id,
            token: token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                showMsg("删除成功!","S");
                straGrid.reload();
                
            } else {
                showMsg(data.errMsg || "删除失败!","E");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
	
}


function onUnifySearch() {
    var params = {};
    var type = nui.get("search-type").getValue();
    var typeValue = nui.get("carNo-search").getValue();
    if(type==0){
    	params.partCode = typeValue;
    }else if(type==1){
    	params.partName = typeValue;
    }
    rightUnifyGrid.load({params:params,token:token});
}


function selectPart(callback, checkcallback) {
    nui.open({
        // targetWindow: window,,
        url : webPath+contextPath+"/com.hsweb.cloud.part.common.partSelectView.flow?token="+token,
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
   if(e.field == "deductRate"){
	   editor.validate();
	    if (editor.isValid() == false) {
	        showMsg("请输入数字!","W");
	        e.cancel = true;
	    } 
	    if(editor.value >100 || editor.value<0 ){
	    	 showMsg("请输入0-100的数字!","W");
		     e.cancel = true;
	    }
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
	var strRow = straGrid.getSelected();
	var data =rightUnifyGrid.getData();
	for(var i=0;i<data.length;i++){
		if(row.id==data[i].partId){
			showMsg("已经存在该配件","W");
			return;
		}
	}
    var newRow = {
    	levelId :strRow.id,
        partId: row.id,
        partCode: row.code,
        partName: row.name,
        fullName: row.fullName
    };
    rightUnifyGrid.addRow(newRow);
}

var saveUnifyUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.saveStockLevelPart.biz.ext";
function saveUnifyPart(){
	var row = straGrid.getSelected();
	 if(!row) {
        showMsg("请先选择对应备货级别再操作!","W");
        return;
    }
    if(!row.id) {
        showMsg("请先保存备货级别再操作!","W");
        return;
    }
	rightUnifyGrid.validate();
    if (rightUnifyGrid.isValid() == false) return;

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

function onSearch(){
	onUnifySearch();
}

function onStraGridClick(e){
	var params={};
	var row = e.row;
	var levelId = row.id ||0;
	var params = {levelId: levelId,token:token};	
	rightUnifyGrid.load({params:params,token:token});
}