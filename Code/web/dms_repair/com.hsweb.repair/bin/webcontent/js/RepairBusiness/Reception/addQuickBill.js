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
var lastItemSubtotal = null;
var lastItemQty = null;
var lastItemRate = null;
var lastItemUnitPrice = null;
var lastPkgSubtotal = null;
var lastPkgRate = null;
var carBrandHash = [];
var carSeriesHash = [];
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
	//品牌
	initCarSeries("carSeriesId", "", function () {
	        var data = nui.get("carSeriesId").getData();
	        data.forEach(function (v) {
	        	//车系信息
	            carSeriesHash[v.id] = v;
	        });
	});
    initCarBrand("carBrandId", function () {
        var data = nui.get("carBrandId").getData();
        data.forEach(function (v) {
            carBrandHash[v.id] = v;
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
	                e.cellHtml = s;
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
	rpsItemGrid.setData([]);
	nui.get("recordDate").setValue(now);
	nui.get("billTypeId").setValue(1);
	
}
function onCarBrandChange(e){     
    initCarSeries("carSeriesId", e.value, function () {
        var data = nui.get("carSeriesId").getData();
        data.forEach(function (v) {
            carSeriesHash[v.id] = v;
        });
    });
}

function setInitData(params){
	var data = params.data;
	
	if(!data.id){
		add();
	}else{
		
		if(data.carBrandId){
	        initCarSeries("carSeriesId", data.carBrandId, function () {
	            var data2 = nui.get("carSeriesId").getData();
	            data2.forEach(function (v) {
	                carSeriesHash[v.id] = v;
	            });
	        });
	    }
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
            row.rate = rate;
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

function deletePackRow(row_uid){
    var data = rpsPackageGrid.getData();
    var row = rpsPackageGrid.getRowByUID(row_uid);
    var prdtId = row.id;
    if(data && data.length==1){
        row = data[0];
    }
    var pkgModel = {
        modelId:row.modelId,
        id:row.id,
    };
    var params = {
        type:"delete",
        interType:"package",
        data:{
            pkgModel: pkgModel
        }
    };
    svrCRUD(params,function(text){
        var errCode = text.errCode||"";
        var errMsg = text.errMsg||"";
        if(errCode == 'S'){   
            var rows = rpsPackageGrid.findRows(function(row){
                if(row.modelPackageId == prdtId || row.id == prdtId){
                    return true;
                }
            });
            rpsPackageGrid.removeRows(rows);
        }else{
            showMsg(errMsg||"删除套餐信息失败!","W");
            return;
        }
    });
}

function editRpsItem(row_uid){
    var row = rpsItemGrid.getRowByUID(row_uid);
    lastItemQty = row.qty;
    lastItemRate = row.rate;
    lastItemSubtotal = row.subtotal;
    lastItemUnitPrice = row.unitPrice;
    if (row) {
        rpsItemGrid.cancelEdit();
        rpsItemGrid.beginEditRow(row);
    }
}


function updateRpsItem(row_uid){
    var rowc = rpsItemGrid.getRowByUID(row_uid);
    if (rowc) {
        rpsItemGrid.commitEdit();
        var rows = rpsItemGrid.getChanges();
        if(rows && rows.length>0){
            var row = rows[0];
            var params = {
                type:"update",
                interType:"item",
                data:{
                    itemModel : row
                }
            };
            svrCRUD(params,function(text){
                var errCode = text.errCode||"";
                var errMsg = text.errMsg||"";
                if(errCode == 'S'){   
                    rpsItemGrid.accept();
                }else{
                	rpsItemGrid.reject();
                    rpsItemGrid.accept();
                    showMsg(errMsg||"修改数据失败!","W");
                    return;
                }
            });
        }
    }
}

function deleteItemRow(row_uid){
    var data = rpsItemGrid.getData();
    var row = rpsItemGrid.getRowByUID(row_uid);
    var id = row.id;
    if(data && data.length==1){
        row = data[0];
    }
    var itemModel = {
        id:row.id,
    };
    var params = {
        type:"delete",
        interType:"item",
        data:{
        	itemModel: itemModel
        }
    };
    svrCRUD(params,function(text){
        var errCode = text.errCode||"";
        var errMsg = text.errMsg||"";
        if(errCode == 'S'){   
        	var rows = rpsItemGrid.findRows(function(row){
                if(row.id == id || row.modelItemId == id){
                    return true;
                }
            });
        	rpsItemGrid.removeRows(rows);
        }else{
            showMsg(errMsg||"删除项目信息失败!","W");
            return;
        }
    });
}


function editItemRpsPart(row_uid){
    var row = rpsItemGrid.getRowByUID(row_uid);
    lastItemQty = row.qty;
    lastItemRate = row.rate;
    lastItemSubtotal = row.subtotal;
    lastItemUnitPrice = row.unitPrice;
    if (row) {
        rpsItemGrid.cancelEdit();
        rpsItemGrid.beginEditRow(row);
    }
}

function updateItemRpsPart(row_uid){
    var rowc = rpsItemGrid.getRowByUID(row_uid);
    if (rowc) {
    	rpsItemGrid.commitEdit();
        var rows = rpsItemGrid.getChanges();
        if(rows && rows.length>0){
            var row = rows[0];
            var params = {
                type:"update",
                interType:"part",
                data:{
                    part : row
                }
            };
            svrCRUD(params,function(text){
                var errCode = text.errCode||"";
                var errMsg = text.errMsg||"";
                if(errCode == 'S'){   
                    rpsItemGrid.accept();
                }else{
                	rpsItemGrid.reject();
                	rpsItemGrid.accept();
                    showMsg(errMsg||"修改数据失败!","W");
                    return;
                }
            });
        }
    }
}

function deletePartRow(row_uid){
    var data = rpsItemGrid.getData();
    var row = rpsItemGrid.getRowByUID(row_uid);
    if(data && data.length==1){
        row = data[0];
    }
    var part = {
        id:row.id,
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
            rpsItemGrid.removeRow(row);
        }else{
        	rpsItemGrid.reject();
        	rpsItemGrid.accept();
            showMsg(errMsg||"删除配件信息失败!","W");
            return;
        }
    });
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
				showMsg("添加失败，请重试!","W");
			}
		}
	});	
}

function save(){
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });
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
				 nui.unmask(document.body);
				 var data = returnJson.billModel
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
				showMsg("保存成功","S");
			} else {
				showMsg("添加失败，请重试!","W");
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
            	modelId: main.id||0
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
		// targetWindow: window,,
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

            iframe.contentWindow.setViewData(dock, dodelck, docck,params);
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
		// targetWindow: window,,
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
var delRpsPackageUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.deleteRpbPackageModel.biz.ext";

var addRpsPartUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.insRpbPartModel.biz.ext";
var updRpsPartUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.updRpbPartModel.biz.ext";
var delRpsPartUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.deleteRpbPartModel.biz.ext";


var addRpsItemModelUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.insRpbItemModel.biz.ext";
var updRpsItemUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.updRpbItemModel.biz.ext";
var delRpsItemUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.deleteRpbItemAndPartModel.biz.ext";

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


//数据改变时触发
function onPkgSubtotalValuechanged(e) {
	var el = e.sender;
	var flag = isNaN(e.value);
	var row = rpsPackageGrid.getEditorOwnerRow(el);
    var setPKgSubtotal = rpsPackageGrid.getCellEditor("pkgSubtotal", row);
    var subtotal = el.getValue();
	if (flag) {
		showMsg("请输入数字!","W");
		setPKgSubtotal.setValue(lastPkgSubtotal);
		e.cancel = true; 
	}else if(subtotal<0){
		showMsg("金额不能小于0","W");
		setPKgSubtotal.setValue(lastPkgSubtotal);
		e.cancel = true; 
		return;
	}else if(subtotal == "" || subtotal == null){	
		setPKgSubtotal.setValue(lastPkgSubtotal);
		e.cancel = true; 
		return;
	}else{
	    //获取指定列和行的编辑器控件对象
	    var editor = rpsPackageGrid.getCellEditor("pkgRate", row);
	    var amt = row.amt||0;
	    var rate = 0;
	    if(amt>0){
	    	rate = (amt - subtotal)*1.0/amt;
	    }
	    rate = rate * 100;
	    rate = rate.toFixed(2);
	    editor.setValue(rate);
	    setPKgSubtotal.setValue(subtotal);
	    lastPkgSubtotal = subtotal;
	    lastPkgRate = rate;
	}
}


function onPkgRateValuechanged(e){
	var el = e.sender;
	var flag = isNaN(e.value);
	var rate = el.getValue();
	var row = rpsPackageGrid.getEditorOwnerRow(el);
    var setPkgRate = rpsPackageGrid.getCellEditor("pkgRate", row);
	if (flag) {
		showMsg("请输入数字!","W");
		e.cancel = true; 
		setPkgRate.setValue(lastPkgRate);
		return;
	} else if(rate<0 || rate>100){	
		showMsg("请输入0到100之间的数!","W");
		setPkgRate.setValue(lastPkgRate);
		e.cancel = true; 
		return;
	}else if(rate == "" || rate == null){	
		setPkgRate.setValue(lastPkgRate);
		e.cancel = true; 
		return;
	}else{
	    //获取指定列和行的编辑器控件对象
	    var editor = rpsPackageGrid.getCellEditor("pkgSubtotal", row);
	    var amt = row.amt||0;
	    var subtotal = 0;
	    if(amt>0){
	    	subtotal = amt - rate*1.0/100*amt;
	        subtotal = subtotal.toFixed(2);
	    }
	    editor.setValue(subtotal);
	    setPkgRate.setValue(rate);
	    lastPkgRate = rate;
	    lastPkgSubtotal = subtotal;
	}
}

function onValueChangedComQty(e){
	var el = e.sender;
	var flag = isNaN(e.value);
	var rowtime = rpsItemGrid.getEditorOwnerRow(el);
	var setItemTime = rpsItemGrid.getCellEditor("itemItemTime", rowtime);
	var itemTime = el.getValue();
	if (flag) {
		showMsg("请输入数字!","W");
		setItemTime.setValue(lastItemQty);
		e.cancel = true; 
	}else if(itemTime<0){
		showMsg("工时/数量不能小于0","W");
		setItemTime.setValue(lastItemQty);
		e.cancel = true; 
		return;
	}else if(itemTime == "" || itemTime == null){	
		setItemTime.setValue(lastItemQty);
		e.cancel = true; 
		return;
	}else{		
		//获取指定列和行的编辑器控件对象
		var setSubtotal = rpsItemGrid.getCellEditor("itemSubtotal", rowtime);
		var setRate = rpsItemGrid.getCellEditor("itemRate", rowtime);
		var setUnitPrice = rpsItemGrid.getCellEditor("itemUnitPrice", rowtime);
		var unitPrice = setUnitPrice.getValue()||0;
		var itamt = 0;
		var subtotal = 0;
		/*var type = row.type;
		if(type==2){
			
		}*/
		//设置工时总金额
		if(unitPrice>0 && itemTime>0){
		   itamt = itemTime*unitPrice;
		   itamt = itamt.toFixed(2);
		   rowtime.amt = itamt;
		   subtotal = itamt;
		}else{
			rowtime.amt = 0;
		}
		//设置小计金额
		var rate = setRate.getValue()||0;
		if(rate>0 && itamt>0){
			subtotal = itamt - rate*1.0/100*itamt;
			subtotal = subtotal.toFixed(2);
		}
		setSubtotal.setValue(subtotal);
		setItemTime.setValue(itemTime);
		lastItemSubtotal = subtotal;
		lastItemQty = itemTime;
  }
}

function onValueChangedItemUnitPrice(e){
	var el = e.sender;
	var unitPrice = el.getValue();
	var flag = isNaN(e.value);
	var row = rpsItemGrid.getEditorOwnerRow(el);
	var setUnitPrice = rpsItemGrid.getCellEditor("itemUnitPrice", row);
	if (flag) {
		showMsg("请输入数字!","W");
		setUnitPrice.setValue(lastItemUnitPrice);
		e.cancel = true; 
	}else if(unitPrice<0){
		
		showMsg("单价不能小于0","W");
		setUnitPrice.setValue(lastItemUnitPrice);
		e.cancel = true; 
		return;
	}else if(unitPrice == "" || unitPrice == null){	
		setUnitPrice.setValue(lastItemUnitPrice);
		e.cancel = true; 
		return;
   }else{
		//获取指定列和行的编辑器控件对象
		var setSubtotal = rpsItemGrid.getCellEditor("itemSubtotal", row);
		
		var setItemTime = rpsItemGrid.getCellEditor("itemItemTime", row);
		var setRate = rpsItemGrid.getCellEditor("itemRate", row);
		var itemTime = setItemTime.getValue()||0;
		var itamt = 0;
		var subtotal = 0;
		//设置工时总金额
		if(unitPrice>0 && itemTime>0){
		   itamt = itemTime*unitPrice;
		   itamt = itamt.toFixed(2);
		   row.amt = itamt;
		   subtotal = itamt;
		}else{
		   row.amt = 0;
		}
		//设置小计金额
		var rate = setRate.getValue()||0;
		if(rate>0){
			subtotal = itamt - rate*1.0/100*itamt;
			subtotal = subtotal.toFixed(2);
		}		
		setSubtotal.setValue(subtotal);
		setUnitPrice.setValue(unitPrice);
		lastItemSubtotal = subtotal;
		lastItemUnitPrice = unitPrice;
  }
	
}

function onValueChangedItemRate(e){
	var el = e.sender;
	var flag = isNaN(e.value);
	var rate = el.getValue();
	var row = rpsItemGrid.getEditorOwnerRow(el);
	var setRate = rpsItemGrid.getCellEditor("itemRate", row);
	if (flag) {
		showMsg("请输入数字!","W");
		e.cancel = true; 
		setRate.setValue(lastItemRate);
		return;
	} else if(rate<0 || rate>100){	
		showMsg("请输入0到100之间的数!","W");
		setRate.setValue(lastItemRate);
		e.cancel = true; 
		return;
	}else if(rate == "" || rate == null){	
		setRate.setValue(lastItemRate);
		e.cancel = true; 
		return;
	}else{
		//获取指定列和行的编辑器控件对象
		var setSubtotal = rpsItemGrid.getCellEditor("itemSubtotal", row);	
		var setRate = rpsItemGrid.getCellEditor("itemRate", row);
		var setUnitPrice = rpsItemGrid.getCellEditor("itemUnitPrice", row);	
		var setItemTime = rpsItemGrid.getCellEditor("itemItemTime", row);	


		var unitPrice = setUnitPrice.getValue()||0;
		var itemTime = setItemTime.getValue()||0;

		var itamt = 0;
		var subtotal = 0;
		//设置工时总金额
		if(unitPrice>0 && itemTime>0){
		   itamt = itemTime*unitPrice;
		   itamt = itamt.toFixed(2);
		   row.amt = itamt;
		   subtotal = itamt;
		}else{
			row.amt = 0;
		}
		//设置小计金额
		if(rate>0){
			subtotal = itamt - rate*1.0/100*itamt;
			subtotal = subtotal.toFixed(2);
		}
		setSubtotal.setValue(subtotal);
		setRate.setValue(rate);	
		lastItemSubtotal = subtotal;
		lastItemRate = rate;
		
  }	
}

//修改了小计，只会修改优惠率
function onValueChangedItemSubtotal(e){	
	var el = e.sender;
	var flag = isNaN(e.value);
	var subtotal = el.getValue();
	var row = rpsItemGrid.getEditorOwnerRow(el);
	var setSubtotal = rpsItemGrid.getCellEditor("itemSubtotal", row);
	if (flag) {
		showMsg("请输入数字!","W");
		setSubtotal.setValue(lastItemSubtotal);
		e.cancel = true; 
	}else if(subtotal<0){
		showMsg("金额不小于0","W");
		setSubtotal.setValue(lastItemSubtotal);
		e.cancel = true; 
		return;
	}else if(subtotal == "" || subtotal == null){
		setSubtotal.setValue(lastItemSubtotal);
		e.cancel = true; 
		return;
	}else{
		//获取指定列和行的编辑器控件对象
		var setRate = rpsItemGrid.getCellEditor("itemRate", row);
		var setUnitPrice = rpsItemGrid.getCellEditor("itemUnitPrice", row);	
		var setItemTime = rpsItemGrid.getCellEditor("itemItemTime", row);	

		var unitPrice = setUnitPrice.getValue()||0;
		var itemTime = setItemTime.getValue()||0;
		var itamt = 0;
		var rate = 0;
		//设置工时总金额
		if(unitPrice>0 && itemTime>0){
		   itamt = itemTime*unitPrice;
		   itamt = itamt.toFixed(2);
		   row.amt = itamt;
		 //设置小计金额
		    if(itamt>0){
		    	rate = (itamt - subtotal)*1.0/itamt;
		    } 
		    rate = rate * 100;
			rate = rate.toFixed(2);    
		    setRate.setValue(rate);
		    setSubtotal.setValue(subtotal);
		    lastItemSubtotal = subtotal;
		    lastItemRate = rate;
		}else{
			subtotal = 0;
			setSubtotal.setValue(subtotal);
		    lastItemSubtotal = subtotal;
		    lastItemRate = rate;
		}
		
	}	
}





