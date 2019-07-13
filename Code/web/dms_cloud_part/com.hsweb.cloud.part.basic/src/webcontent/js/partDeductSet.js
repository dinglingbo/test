/**
 * Created by Administrator on 2018/1/24.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var rightUnifyGrid = null;

var rightUnifyGridUrl = baseUrl+"com.hsapi.cloud.part.baseDataCrud.query.queryDeductPart.biz.ext";
var typeList = [{id:"1",text:"按销售金额分成"},{id:"2",text:"按销售毛利分成"}];
var statusList = [{id:"0",name:"编码"},{id:"1",name:"名称"}];
//var salesDeductTypeList=[{id:"1",text:"原价"},{id:"2",text:"折后价"},{id:"3",text:"产值"}];
var salesDeductTypeEl= null;

//var requiredField = {
//		sellPrice 		: "售价",
//		salesDeductType: "提成类型",
//		salesDeductValue: "提成金额"
//	};
$(document).ready(function(v)
{
    rightUnifyGrid = nui.get("rightUnifyGrid");
    rightUnifyGrid.setUrl(rightUnifyGridUrl);
    advancedDecuetSetWin=nui.get('advancedDecuetSetWin');

    /*$("#partName").bind("keydown", function (e) {

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
        
    });*/
    $("#partNameSearch").bind("keydown", function (e) {

        if (e.keyCode == 13) {
            onUnifySearch();
        }
        
    });
    
    onUnifySearch();
    
    rightUnifyGrid.on("drawcell",function(e){
    	switch(e.field){
//    		case "salesDeductValue":
//    			if(e.row.salesDeductType && e.row.salesDeductValue){
//    				for(var i=0;i<salesDeductTypeList.length;i++){
//    					if(e.row.salesDeductType==salesDeductTypeList[i].id){    						
//    						e.cellHtml = e.row.salesDeductValue+"%";
//    					}else if(e.row.salesDeductType==4){
//    						e.cellHtml = e.row.salesDeductValue+"元";
//    					}
//    				}
//    			}
//    			break;
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
    /*editor.validate();
    if (editor.isValid() == false) {
        showMsg("请输入数字!","W");
        e.cancel = true;
    }  */
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
	var data =rightUnifyGrid.getData();
	for(var i=0;i<data.length;i++){
		if(row.id==data[i].partId){
			showMsg("已经存在该配件","W");
			return;
		}
	}
    var newRow = {
        partId: row.id,
        partCode: row.code,
        partName: row.name,
        fullName: row.fullName
    };
    rightUnifyGrid.addRow(newRow);
}

var saveUnifyUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.savePjdeductPart.biz.ext";
function saveUnifyPart(){
	
	rightUnifyGrid.validate();
    if (rightUnifyGrid.isValid() == false) return;
    
	var data=rightUnifyGrid.getData();
	for(var i=0;i<data.length;i++){
//		if(!data[i].sellPrice )
//        {
//            showMsg("售价不能为空", "W");
//            return;
//        }
		if(!data[i].type )
        {
            showMsg("提成类型不能为空", "W");
            return;
        }
		if(!data[i].deductRate )
        {
            showMsg("提成比例不能为空", "W");
            return;
        }
		
	}

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
