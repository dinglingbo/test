var baseUrl = apiPath + repairApi + "/";
var webBaseUrl = webPath + contextPath + "/";  
var servieTypeHash = {};
var rpsPackageGrid = null;
var rpsItemGrid = null;
var billForm = null;
var advancedMorePartWin = null;
var FItemRow = null;
var prdtTypeHash = {
	    "1":"套餐",
	    "2":"项目",
	    "3":"配件"
	};
/*document.onmousemove = function(e){
    if(advancedMorePartWin.visible){
        var mx = e.pageX;
        var my = e.pageY;
        var loc = "当前位置 x:"+e.pageX+",y:"+e.pageY
        var x = advancedMorePartWin.x;
        var y = advancedMorePartWin.y;
        if(x - mx > 10 || mx - x > 180){
            advancedMorePartWin.hide();
            FItemRow = {};
            return;
        }
        if(y - my > 10 || my - y > 130){
            advancedMorePartWin.hide();
            FItemRow = {};
            return;
        }
    }
};*/

$(document).ready(function () {	
	rpsPackageGrid = nui.get("rpsPackageGrid");
	rpsItemGrid = nui.get("rpsItemGrid");
	billForm = new nui.Form("#billForm");
	//advancedMorePartWin = nui.get("advancedMorePartWin");
	initServiceType("serviceTypeId",function(data) {
        servieTypeList = nui.get("serviceTypeId").getData();
        servieTypeList.forEach(function(v) {
            servieTypeHash[v.id] = v;
        });
    });
	
	rpsPackageGrid.on("drawcell", function (e) {
        var grid = e.sender;
        var record = e.record;
        var uid = record._uid;
        var rowIndex = e.rowIndex;

        switch (e.field) {
            case "serviceTypeId":
                var type = record.type||0;
                if(type>1){
                    e.cellHtml = "--";
                }else{
                    e.cellHtml = servieTypeHash[e.value].name;
                }
                break;
            case "type":
                if(e.value == 1){
                    e.cellHtml = "--";
                }else{
                    e.cellHtml = prdtTypeHash[e.value];
                }
                break;
            case "packageOptBtn":
                var modelPackageId = record.modelPackageId ||0;
                if(modelPackageId == 0){
                    var s = '<a class="optbtn" href="javascript:editRpsPackage(\'' + uid + '\')">修改</a>'
                    + ' <a class="optbtn" href="javascript:deletePackRow(\'' + uid + '\')">删除</a>';

                    if (grid.isEditingRow(record)) {
                        s = '<a class="optbtn" href="javascript:updateRpsPackage(\'' + uid + '\')">确定</a>'
                            + ' <a class="optbtn" href="javascript:deletePackRow(\'' + uid + '\')">删除</a>';
                    }
                }else{
                    s = "--";
                }
                e.cellHtml = s;
                break;
            case "rate":
                var value = e.value||"";
                if(value&&value!="0"){
                    e.cellHtml = e.value + '%';
                }
                break;
            default:
                break;
        }
    });
	
	 rpsItemGrid.on("drawcell", function (e) {
	        var grid = e.sender;
	        var record = e.record;
	        var uid = record._uid;
	        var rowIndex = e.rowIndex;
	        //获取到配件ID
	    	var pid = record.pid||0;
	        switch (e.field) {
	            case "prdtName":
	                var s = "";
	                if(pid == 0){
	                      e.cellHtml = '<a href="javascript:choosePart(\'' + uid + '\')" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;配件</a>' + e.value + s;	
	                }else{
	                	e.cellHtml ='<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>' + e.value;
	                }
	                break;
	            case "itemOptBtn":
	            	if(pid == 0){
	            	    var s = '<a class="optbtn" href="javascript:editRpsItem(\'' + uid + '\')">修改</a>'
	                     + ' <a class="optbtn" href="javascript:deleteItemRow(\'' + uid + '\')">删除</a>';
	                  if (grid.isEditingRow(record)) {
	                    s = '<a class="optbtn" href="javascript:updateRpsItem(\'' + uid + '\')">确定</a>'
	                     + ' <a class="optbtn" href="javascript:deleteItemRow(\'' + uid + '\')">删除</a>';
	                   }
	                 }else{
	                	 //修改配件信息
	                	 var s = '<a class="optbtn" href="javascript:editItemRpsPart(\'' + uid + '\')">修改</a>'
	                           + ' <a class="optbtn" href="javascript:deletePartRow(\'' + uid + '\')">删除</a>';
	                     if (grid.isEditingRow(record)) {
	                         s = '<a class="optbtn" href="javascript:updateItemRpsPart(\'' + uid + '\')">确定</a>'
	                           + ' <a class="optbtn" href="javascript:deletePartRow(\'' + uid + '\')">删除</a>';
	                     }
	                  }
	                e.cellHtml = s
	                break;
	            case "serviceTypeId":
	                var type = record.type||0;
	                if(type>2){
	                    e.cellHtml = "--";
	                    e.cancel = false;
	                }else{
	                    e.cellHtml = servieTypeHash[e.value].name;
	                }
	                break;
	            case "rate":
	                var value = e.value||"";
	                if(value&&value!="0"){
	                    e.cellHtml = e.value + '%';
	                }
	                break;
	            default:
	                break;
	        }
	        
	    });
	
	
});

/*function showMorePart(row_uid){
    var row = rpsItemGrid.getRowByUID(row_uid); 
    if(FItemRow == row) {
        advancedMorePartWin.hide();
        FItemRow = {};
        return;
    }      
    FItemRow = row;    
    var atEl = rpsItemGrid._getCellEl(row,"prdtName");
    advancedMorePartWin.showAtEl(atEl, {xAlign:"left",yAlign:"above"});
   	
}*/



function add(){
	billForm.setData([]);
	rpsPackageGrid.setData([]);
	nui.get("recordDate").setValue(now);
	nui.get("billTypeId").setValue(1);
	
}

function setInitData(params){
	var data = params.data;
	if(!data.id){
		add();
	}else{
		//设置表格值
		billForm.setData(data);
		//加载表格明细
		var p1 = {
                interType: "package",
                data:{
                    modelId: data.id||0
                }
            }
            var p2 = {
                interType: "item",
                data:{
                	modelId: data.id||0
                }
            }
            var p3 = {
                interType: "part",
                data:{
                	modelId: data.id||0
                }
            }
            loadDetail(p1, p2, p3);
	}
	
}

function editRpsPackage(row_uid){
    var row = rpsPackageGrid.getRowByUID(row_uid);
    lastPkgSubtotal = row.subtotal;
    lastPkgRate = row.rate;
    if (row) {
        rpsPackageGrid.cancelEdit();
        rpsPackageGrid.beginEditRow(row);
    }
}


function updateRpsPackage(row_uid){
    var rowc = rpsPackageGrid.getRowByUID(row_uid);
    if (rowc) {
        rpsPackageGrid.commitEdit();
        var rows = rpsPackageGrid.getChanges();
        if(rows && rows.length>0){
            var row = rows[0];
            if(row.type == 3){
                rpsPackageGrid.accept();
                return;
            }
            var modelId = row.modelId||0;
            var rate = row.rate/100;
            rate = rate.toFixed(4);
            var pkg = {
                modelId:row.modelId,
                //优惠率除以100
                rate:rate,
                id:row.id,
                serviceTypeId:row.serviceTypeId,
                subtotal:row.subtotal
            };
            var params = {
                type:"update",
                interType:"package",
                data:{
                    pkg: pkg,
                }
            };
            svrCRUD(params,function(text){
                var errCode = text.errCode||"";
                var errMsg = text.errMsg||"";
                if(errCode == 'S'){   
                    rpsPackageGrid.accept();
                    var p1 = {
                            interType: "package",
                            data:{
                            	modelId: modelId
                            }
                        }
                     loadDetail(p1, {}, {});
                     rpsPackageGrid.reject();
                }else{
                	rpsPackageGrid.reject();
                    rpsPackageGrid.accept();
                    showMsg(errMsg||"修改数据失败!","W");
                    return;
                }
            });
        }
    }
}






saveUrl = baseUrl + "com.hsapi.repair.repairService.crud.saveBillModel.biz.ext"
function saveNoShowMsg(){
	var billModel = billForm.getData();
	var json = nui.encode({
		billModel:billModel,
		token : token
	});
	nui.ajax({
		url : saveUrl,
		type : 'POST',
		data : json,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			var returnJson = nui.decode(text);
			if (returnJson.errCode == "S") {
				billForm.setData(returnJson.billModel);
			} else {
				//showMsg("出库失败");
			}
				
		}
	});	
}
function loadDetail(p1, p2, p3){
    if(p1 && p1.interType){
        getBillDetail(p1, function(text){
            var errCode = text.errCode;
            var data = text.data||[];
            if(errCode == "S"){
                rpsPackageGrid.clearRows();
                rpsPackageGrid.addRows(data);
                rpsPackageGrid.accept();
            }
        }, function(){});
    }
    if(p2 && p2.interType){
        getBillDetail(p2, function(text){
            var errCode = text.errCode;
            var data = text.data||[];
            if(errCode == "S"){
                rpsItemGrid.clearRows();
                rpsItemGrid.addRows(data);
                rpsItemGrid.accept();
            }
        }, function(){});
    }
   /* if(p3 && p3.interType){
        getBillDetail(p3, function(text){
        }, function(){});
    }*/
}

var getdRpsPackageUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.svr.getRpsPackagePItemPPartModel.biz.ext";
var getRpsItemUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.svr.getRpsItemPPartModel.biz.ext";
var getRpsPartUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.svr.getRpsMainPart.biz.ext";
function getBillDetail(params, callback, unmaskcall){
  var interType = params.interType||"";// package item part
  var data = params.data||{};
  var url = "";
  if(interType == "package"){
      url = getdRpsPackageUrl;
  }else if(interType == "item"){
      url = getRpsItemUrl;
  }else if(interType == "part"){
      url = getRpsPartUrl;
  }
  doPost({
		url : url,
		data : data,
		success : function(data) {
          unmaskcall && unmaskcall();
			callback && callback(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
          unmaskcall && unmaskcall();
			console.log(jqXHR.responseText);
		}
	});
}


var requiredField = {
		modelName : "模板名称",
		billTypeId : "开单类型",
	    serviceTypeId : "业务类型"
	};

function choosePackage(){
    var main = billForm.getData();
    if(!main.id){
    	 var data = billForm.getData();
    	for ( var key in requiredField) {
    		if (!data[key] || $.trim(data[key]).length == 0) {
    	          nui.get(key).focus();
    	          showMsg(requiredField[key] + "不能为空!","W");
    			return;
    		}
    	 }
    	saveNoShowMsg();
    }      
    doSelectPackage(addToBillPackage, delFromBillPackage, checkFromBillPackage, function(text){
        main = billForm.getData();
        var p1 = { 
    		interType: "package",
            data:{
            	modelId: billForm.id||0
            }
        };
        var p2 = {};
        var p3 = {};
        loadDetail(p1, p2, p3);
    });
}

function addToBillPackage(row, callback, unmaskcall){
    var main = billForm.getData();
    var data = {};
    var pkg = {
        modelId:main.id,
        packageId:row.id,
    };
    data.pkgModel = pkg;
    data.modelId = main.id||0;
    
    var params = {
        type:"insert",
        interType:'package',
        data:data
    };
    svrCRUD(params,function(text){
        var errCode = text.errCode||"";
        var errMsg = text.errMsg||"";
        var res = text.data||{};
        if(errCode == 'S'){
            unmaskcall && unmaskcall();
            callback && callback(res);
        }else{
            unmaskcall && unmaskcall();
            showMsg(errMsg||"添加套餐失败!","W");
            return;
        }
    },function(){
        unmaskcall && unmaskcall();
    });
}

function delFromBillPackage(data, callback){
    var pkg = {
    	modelId:data.modelId,
        id:data.id,
    };
    var params = {
        type:"delete",
        interType:"package",
        data:{
        	pkg: pkg
        }
    };
    svrCRUD(params,function(text){
        var errCode = text.errCode||"";
        var errMsg = text.errMsg||"";
        if(errCode == 'S'){   
            callback && callback();
        }else{
            showMsg(errMsg||"删除套餐信息失败!","W");
            return;
        }
    });
}

function checkFromBillPackage(data){
    var packageId= data.id;
    var rows = rpsPackageGrid.findRows(function(row){
        if(row && row.prdtId == packageId){
            return true;
        }
    });
    if(rows && rows.length>0){
        return true;
    }
    return false;
}

function doSelectPackage(dock, dodelck, docck, callback) {
	nui.open({
		targetWindow : window,
		url : webPath + contextPath + "/repair/DataBase/Card/packageList.jsp?token=" + token,
		title : "套餐项目",
		width : 1000,
		height : 560,
		allowDrag : true,
		allowResize : true,
		onload : function() {
			var iframe = this.getIFrameEl();
			var list = [];
			var params = {
				list : list
			};

            iframe.contentWindow.setViewData(dock, dodelck, docck);
		},
		ondestroy : function(action) {
            var iframe = this.getIFrameEl();
            var data = iframe.contentWindow.getData();
            data = data || {};
            data.action = action;
            callback && callback(data);
		}
	});
}

function chooseItem(){
	 var main = billForm.getData();
	    if(!main.id){
	    	 var data = billForm.getData();
	    	for ( var key in requiredField) {
	    		if (!data[key] || $.trim(data[key]).length == 0) {
	    	          nui.get(key).focus();
	    	          showMsg(requiredField[key] + "不能为空!","W");
	    			return;
	    		}
	    	 }
	    	saveNoShowMsg();
	    }    
	 doSelectItem(addToBillItem, delFromBillItem, checkFromBillItem, function(text){
		    main = billForm.getData();
	        var p1 = { }
	        var p2 = {
	            interType: "item",
	            data:{
	                modelId: main.id||0
	            }
	        };
	        var p3 = {};
	        loadDetail(p1, p2, p3);
	    }); 
}

function addToBillItem(row, callback, unmaskcall){
    var main = billForm.getData();
    var data = {};
    var itemModel = {
        modelId:main.id||0,
        itemId:row.id,
    };
    data.itemModel = itemModel;
    data.modelId = main.id||0;
    
    var params = {
        type:"insert",
        interType:'item',
        data:data
    };
    svrCRUD(params,function(text){
        var errCode = text.errCode||"";
        var errMsg = text.errMsg||"";
        var res = text.data||{};
        if(errCode == 'S'){
            unmaskcall && unmaskcall();
            callback && callback(res);
        }else{
            unmaskcall && unmaskcall();
            showMsg(errMsg||"添加项目失败!","W");
            return;
        }
    },function(){
        unmaskcall && unmaskcall();
    });
}

function delFromBillItem(data, callback){
    var item = {
        modelId:data.modelId,
        id:data.id,
    };
    var params = {
        type:"delete",
        interType:"item",
        data:{
            item: item
        }
    };
    svrCRUD(params,function(text){
        var errCode = text.errCode||"";
        var errMsg = text.errMsg||"";
        if(errCode == 'S'){   
            callback && callback();
        }else{
            showMsg(errMsg||"删除项目信息失败!","W");
            return;
        }
    });
}

function checkFromBillItem(data){
    var itemId= data.id;
    var rows = rpsItemGrid.findRows(function(row){
        if(row && row.prdtId == itemId){
            return true;
        }
    });
    if(rows && rows.length>0){
        return true;
    }
    return false;
}


function doSelectItem(dock, dodelck, docck, callback) {
	nui.open({
		targetWindow : window,
		url : webPath + contextPath + "/com.hsweb.repair.DataBase.RepairItemMain.flow?token=" + token,
		title : "维修项目",
		width : 1000,
		height : 560,
		allowDrag : true,
		allowResize : true,
		onload : function() {
			var iframe = this.getIFrameEl();
			var list = [];
			var params = {
				list : list
			};
            iframe.contentWindow.setData(params);//显示该显示的功能
            iframe.contentWindow.setViewData(dock, dodelck, docck);
		},
		ondestroy : function(action) {
            var iframe = this.getIFrameEl();
            var data = iframe.contentWindow.getData();
            data = data || {};
            data.action = action;
            callback && callback(data);
		}
	});
}

//配件
function choosePart(row_uid){
	var row = rpsItemGrid.getRowByUID(row_uid);
    var itemId = null;
    if(row){
    	itemId = row.id;
    }else{
        return;
    }
    doSelectPart(itemId,addToBillPart, delFromBillPart, null, function(text){
    	main = billForm.getData();
    	var p1 = { };
        var p2 = {
            interType: "item",
            data:{
                modelId: main.id||0
            }
        };
        var p3 = {};
        loadDetail(p1, p2, p3);
    });
}

function addToBillPart(row, callback, unmaskcall){
    var main = billForm.getData();
    var data = {};
    var insPart = {
        modelId:main.id||0,
        partId:row.id,
        modelItemId:row.billItemId,     
        qty:1
    };
    data.insPart = insPart;
    data.modelId = main.id||0;
    
    var params = {
        type:"insert",
        interType:'part',
        data:data
    };
    svrCRUD(params,function(text){
        var errCode = text.errCode||"";
        var errMsg = text.errMsg||"";
        var res = text.data||{};
        if(errCode == 'S'){
            unmaskcall && unmaskcall();
            callback && callback(res);
        }else{
            unmaskcall && unmaskcall();
            showMsg(errMsg||"添加配件失败!","W");
            return;
        }
    },function(){
        unmaskcall && unmaskcall();
    });
}

function delFromBillPart(data, callback){
    var part = {
        serviceId:data.serviceId,
        id:data.id,
        cardDetailId:data.cardDetailId||0
    };
    var params = {
        type:"delete",
        interType:"part",
        data:{
        	part: part
        }
    };
    svrCRUD(params,function(text){
        var errCode = text.errCode||"";
        var errMsg = text.errMsg||"";
        if(errCode == 'S'){   
            callback && callback();
        }else{
            showMsg(errMsg||"删除配件信息失败!","W");
            return;
        }
    });
}

var addRpbPackageModelUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.insRpbPackageModel.biz.ext";
var updRpsPackageUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.updRpbPackageModl.biz.ext";
var delRpsPackageUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.deleteRpsPackage.biz.ext";

var addRpsPartUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.insRpbPartModel.biz.ext";
var updRpsPartUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.saveRpsPart.biz.ext";
var delRpsPartUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.deleteRpsPart.biz.ext";


var addRpsItemModelUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.insRpbItemModel.biz.ext";
var updRpsItemUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.saveRpsItem.biz.ext";
var delRpsItemUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.deleteRpsItemAndPart.biz.ext";

function svrCRUD(params, callback, unmaskcall){
    var type = params.type||""; // insert update delete
    var interType = params.interType||"";// package item part
    var data = params.data||{};
    var url = "";
    if(type == "insert"){
        if(interType == "package"){
            url = addRpbPackageModelUrl;
        }else if(interType == "item"){
            url = addRpsItemModelUrl;
        }else if(interType == "part"){
            url = addRpsPartUrl;
        }
    }else if(type == "update"){
        if(interType == "package"){
            url = updRpsPackageUrl;
        }else if(interType == "item"){
            url = updRpsItemUrl;
        }else if(interType == "part"){
            url = updRpsPartUrl;
        }
    }else if(type == "delete"){
        if(interType == "package"){
            url = delRpsPackageUrl;
        }else if(interType == "item"){
            url = delRpsItemUrl;
        }else if(interType == "part"){
            url = delRpsPartUrl;
        }
    }

    doPost({
		url : url,
		data : data,
		success : function(data) {
            unmaskcall && unmaskcall();
			callback && callback(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
            unmaskcall && unmaskcall();
			console.log(jqXHR.responseText);
			callback && callback(null);
		}
	});
}
