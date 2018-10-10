/**
 * Created by Administrator on 2018/1/24.
 */
var baseUrl = apiPath + repairApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var rightUnifyGrid = null;

var rightUnifyGridUrl = baseUrl+"com.hsapi.repair.baseData.query.queryRpbPart.biz.ext";
var typeList = [{id:"1",text:"按原价比例"},{id:"2",text:"按折后价比例"},{id:"3",text:"按产值比例"},{id:"4",text:"固定金额"}];
var salesDeductTypeList=[{id:"1",text:"原价"},{id:"2",text:"折后价"},{id:"3",text:"产值"}];
var salesDeductTypeEl= null;
//var advancedDecuetSetWin = null;
//var basicInfoForm=null;
var requiredField = {
		sellPrice 		: "售价",
		salesDeductType: "提成类型",
		salesDeductValue: "提成金额"
	};
$(document).ready(function(v)
{
    rightUnifyGrid = nui.get("rightUnifyGrid");
    rightUnifyGrid.setUrl(rightUnifyGridUrl);
    advancedDecuetSetWin=nui.get('advancedDecuetSetWin');
//    salesDeductTypeEl = nui.get("salesDeductType");
//    basicInfoForm=new nui.Form("#basicInfoForm"); 
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
    
    rightUnifyGrid.on("drawcell",function(e){
    	switch(e.field){
    		case "salesDeductValue":
    			if(e.row.salesDeductType && e.row.salesDeductValue){
    				for(var i=0;i<salesDeductTypeList.length;i++){
    					if(e.row.salesDeductType==salesDeductTypeList[i].id){    						
    						e.cellHtml = e.row.salesDeductValue+"%"+salesDeductTypeList[i].text;
    					}else if(e.row.salesDeductType==4){
    						e.cellHtml = e.row.salesDeductValue+"元"+"固定金额";
    					}
    				}
    			}
    			break;
    		case "salesDeductType":
    			if(e.row.salesDeductType){
    				for(var i=0;i<typeList.length;i++){
    					if(e.row.salesDeductType==typeList[i].id){    						
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
    params.partCode = nui.get("partCodeSearch").getValue();
    params.namePy = nui.get("namePySearch").getValue();
    params.partName = nui.get("partNameSearch").getValue();
    rightUnifyGrid.load({params:params,token:token});
 
}

//function onActionRenderer(e) {
//    var grid = e.sender;
//    var record = e.record;
//    var uid = record._uid;
//    var rowIndex = e.rowIndex;
//
//    var s =  '<a class="Edit_Button" href="javascript:editRow(\'' + uid + '\')">修改提成</a> ';
//           
//    return s;
//}

//function editRow(row_uid){
//	advancedDecuetSetWin.show();
//	var row= rightUnifyGrid.getSelected();
//	if(row.salesDeductType || row.salesDeductValue){
//		nui.get('salesDeductType').setValue(row.salesDeductType);
//		nui.get('salesDeductValue').setValue(row.salesDeductValue);
//	}
//
//}

//function onAdvancedAddCancel(){
//	advancedDecuetSetWin.hide();
//}
//function onAdvancedAddOk(){
//	var data=basicInfoForm.getData();
//	for(var key in requiredField){
//		if(!data[key] || data[key].trim().length==0)
//        {
//            showMsg(requiredField[key]+"不能为空", "W");
//            return;
//        }
//	}
//	var row = rightUnifyGrid.getSelecteds();
//	var salesDeductType= nui.get('salesDeductType').getValue();
//	var salesDeductValue=nui.get('salesDeductValue').getValue();
//	var newRow={
//			salesDeductType : salesDeductType,
//			salesDeductValue :salesDeductValue
//	};
//	for(var i=0;i<row.length;i++){
//		rightUnifyGrid.updateRow(row[i],newRow);
//	}
//	advancedDecuetSetWin.hide();
//}
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
	
	rightUnifyGrid.validate();
    if (rightUnifyGrid.isValid() == false) return;
    
	var data=rightUnifyGrid.getData();
	for(var i=0;i<data.length;i++){
		if(!data[i].sellPrice )
        {
            showMsg("售价不能为空", "W");
            return;
        }
		if(!data[i].salesDeductType )
        {
            showMsg("提成类型不能为空", "W");
            return;
        }
		if(!data[i].salesDeductValue )
        {
            showMsg("提成金额不能为空", "W");
            return;
        }
		
	}
//	for(var key in requiredField){
//		if(!data[key] || data[key].trim().length==0)
//        {
//            showMsg(requiredField[key]+"不能为空", "W");
//            return;
//        }
//	}
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

//function onRateValidation(e){
//	var el = e.sender.id;
//	var value = 0;
//	if(el == "salesDeductValue"){
//		value = salesDeductTypeEl.getValue();
//		if(value == 4){
//			if(e.value == "" || e.value == null){
//
//			}else{
//				var reg=/(^[1-9]{1}[0-9]*$)|(^[0-9]*\.[0-9]{2}$|0$)/;
//				if (!reg.test(e.value)) {
//					e.errorText = "请输入大于等于0的整数或者保留两位小数";
//					e.isValid = false;
//					showMsg("请输入大于0的整数或者保留两位小数","W");
//				}
//			}
//		}else {
//			if (e.isValid) {
//				//var reg=/(^[1-9][0-9]$|^[0-9]$|^100$)/;
//				if(e.value == "" || e.value == null){
//
//				}else{
//					var reg=/^(\d|[1-9]\d)(\.\d{1,2})?$|100$/;
//					if (!reg.test(e.value)) {
//						e.errorText = "请输入0~100的数,最多可保留两位小数";
//						e.isValid = false;
//						showMsg("请输入0~100的数,最多可保留两位小数","W");
//					}
//				}
//			}
//		}
//	}
//}
//
//function hidePercent(e){
//	var value = e.value;
//	var el = e.sender.id;
//	if(el == "salesDeductType"){
//		if(value == 4){
//			$("#salesDeductValue").next().hide();
//		}else {
//			$("#salesDeductValue").next().show();
//		}
//	}
//}