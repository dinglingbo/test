var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
var partUrl = apiPath + partApi + "/";

var mainGrid = null;
var repairOutGrid = null;
var mid = null;//主表ID
var mainRow = null;  

var servieTypeList = [];
var servieTypeHash = {};
//var mtAdvisorIdEl = null; 
var searchKeyEl = null; 
var servieIdEl = null; 
var searchNameEl = null;
var billForm = null;
var guestInfoUrl = baseUrl + "com.hsapi.repair.repairService.svr.queryCustomerWithContactList.biz.ext";
var mainGridUrl =  baseUrl + "com.hsapi.repair.repairService.query.getRpsPartByServiceId.biz.ext";
var repairOutGridUrl =  partUrl + "com.hsapi.part.invoice.partInterface.queryEnbleRtnPart.biz.ext";
var fserviceId = 0;
var returnSignData = [{id:0,text:"否"},{id:1,text:"是"}];
var rpsPackageGrid = null;
var rpsItemGrid = null;
var showOut=null;
var storehouse = null;
var advancedMorePartWin = null;
var storeHash = {};
var FStoreId = null;
var status=0;
var FItemRow = null;
var prdtTypeHash = {
	    "1":"套餐",
	    "2":"项目",
	    "3":"配件"
	};

$(document).ready(function(){


	mainGrid = nui.get("mainGrid");
	repairOutGrid = nui.get("repairOutGrid");
	mainGrid.setUrl(mainGridUrl);
	repairOutGrid.setUrl(repairOutGridUrl);
	rpsPackageGrid = nui.get("rpsPackageGrid");
	rpsItemGrid = nui.get("rpsItemGrid");
    advancedMorePartWin = nui.get("advancedMorePartWin");
	billForm = new nui.Form("#billForm");
	//mtAdvisorIdEl = nui.get("mtAdvisorId");
	servieIdEl = nui.get("servieIdEl");
	searchKeyEl = nui.get("search_key");
	searchNameEl = nui.get("search_name");
	showOut=nui.get("showOut");
/*	if(actionType == "ll"){
		mainGrid.load({serviceId:mid});
	}
	if(actionType == "th"){

	}*/

//	initMember("mtAdvisorId",function(){
//		memList = mtAdvisorIdEl.getData();
//	});
//
//	mtAdvisorIdEl.on("valueChanged",function(e){
//		var text = mtAdvisorIdEl.getText();
//		nui.get("mtAdvisor").setValue(text);
//	});

    initServiceType("serviceTypeId",function(data) {
        servieTypeList = nui.get("serviceTypeId").getData();
        servieTypeList.forEach(function(v) {
          servieTypeHash[v.id] = v;
      });
    });
    
    getAllStorehouse(function(data) {
		storehouse = data.storehouse || [];
		if (storehouse && storehouse.length > 0) {
			FStoreId = storehouse[0].id;
			storehouse.forEach(function(v) {
				storeHash[v.id] = v;
			});
		}
	});
	
    mainGrid.on("drawcell", function (e) {
        var ll = '<a class="optbtn" href="javascript:LLSave()">领料</a>';
    	var value = e.value;
        if (e.field == "serviceTypeId") {
            if (servieTypeHash && servieTypeHash[e.value]) {
                e.cellHtml = servieTypeHash[e.value].name;
            }
        }else if(e.field == "rate"){
        	if(!value){
        		e.cellHtml = 0;
        	}else{
        		value = (value * 100).toFixed(2);
        		e.cellHtml = value + '%';
        	}
        }else if(e.field == "action"){
        	 e.cellHtml = ll;
        }
    });
    
    repairOutGrid.on("drawcell", function (e) {
        var th = '<a class="optbtn" href="javascript:THSave()">退货</a>';
        if (e.field == "storeId") {
        	if (storeHash[e.value]) {
				e.cellHtml = storeHash[e.value].name || "";
			} else {
				e.cellHtml = "";
			}
        }else if(e.field == "action"){
        	 e.cellHtml = th;
        }
        
    });


    searchKeyEl.on("valuechanged",function(e){
      var item = e.selected;

      if(fserviceId){
         return;
     }
     if (item) {
         var carNo = item.carNo||"";
         var tel = item.guestMobile||"";
         var guestName = item.guestFullName||"";
         var carVin = item.vin||"";



         if(tel){
            tel = "/"+tel;
        }
        if(guestName){
            guestName = "/"+guestName;
        }
        if(carVin){
            carVin = "/"+carVin;
        }
        var t = carNo + tel + guestName + carVin;

        var sk = document.getElementById("search_key");
        sk.style.display = "none";
        searchNameEl.setVisible(true);


        searchNameEl.setValue(t);
            //searchNameEl.setEnabled(false);

        }
    });


    mainGrid.on("celldblclick",function(e){
        var field = e.field;
        var record = e.record;
        var column = e.column;
        LLSave();
    });

    repairOutGrid.on("celldblclick",function(e){
        var field = e.field;
        var record = e.record;
        var column = e.column;
        THSave();
    });
    
    rpsPackageGrid.on("drawcell", function (e) {
        var grid = e.sender;
        var record = e.record;
        var uid = record._uid;
        var rowIndex = e.rowIndex;
        var pid = record.pid||0;
        switch (e.field) {
            case "serviceTypeId":
                var type = record.type||0;
                if(type>1){
                    e.cellHtml = "--";
                }else{
                    e.cellHtml = servieTypeHash[e.value].name;
                }
                break;
            case "qty":
            	 var type = record.type||0;
                 if(type==1){
                     e.cellHtml = "--";
                 }else{
                     e.cellHtml = e.value;
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
            	var type = record.type||0;

                if(type == 3){
                    var s = '<a class="optbtn" href="javascript:pkgPick(\'' + uid + '\')">领料</a>';
                }else{
                    var s = '--';
                }
                
                e.cellHtml = s;
                break;
            case "rate":
                var value = e.value||"";
                if(value&&value!="0"){
                    e.cellHtml = e.value + '%';
                }
                break;
            case "restQty":
                var value = record.qty-record.pickQty||"";
                if(value&&value!="0" && pid!=0){
                    e.cellHtml = value ;
                    e.cellStyle = "background:#54FF9F";
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
                var cardDetailId = record.cardDetailId||0;
                var s = "";
                if(cardDetailId>0){
                    s = "<font color='red'>(预存)</font>";
                }
                if(pid == 0){
                    e.cellHtml = '<a href="javascript:choosePart(\'' + uid + '\')" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;配件</a>' + e.value + s;	
                    
                }else{
                	e.cellHtml ='<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>' + e.value;
                }
                break;
            case "itemOptBtn":
            	if(pid == 0){
            	    var s = '--';
                 }else{
                	 //修改配件信息
                	 var s = ' <a class="optbtn" href="javascript:editItemRpsPart(\'' + uid + '\')">修改</a>'
                           + ' <a class="optbtn" href="javascript:deletePartRow(\'' + uid + '\')">删除</a>'
                           + ' <a class="optbtn" href="javascript:itemPick(\'' + uid + '\')">领料</a>';
                     if (grid.isEditingRow(record)) {
                         s = ' <a class="optbtn" href="javascript:updateItemRpsPart(\'' + uid + '\')">确定</a>'
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
                    e.cellHtml = e.value ;
                }
                break;
            case "restQty":
                var value = record.qty-record.pickQty||"";
                if(value&&value!="0" && pid!=0){
                    e.cellHtml = value ;
                    e.cellStyle = "background:#54FF9F";
                }
                break;
            default:
                break;
        }
        
    });
     
    rpsItemGrid.on("cellbeginedit",function(e){
        var field=e.field; 
        var editor = e.editor;
        var row = e.row;
        var column = e.column;
        var editor = e.editor;
        //配件type=3
        if(field == 'serviceTypeId'){
            if(row.type > 2) {
                e.cancel = true;
            }
        }
        if(field == 'unitPrice' || field == 'subtotal' || field == 'rate'){
            if(row.cardDetailId > 0){
                e.cancel = true;
            }
        }
    });

});

document.onmousemove = function(e){
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
}
function setInitData(params){
	mid = params.id;
	//serviceCode = params.row.serviceCode;
	mainRow = params.row;
	status=mainRow.status;
	if(!params.id){
        //add();
    }else{
    	nui.mask({ 
    		el: document.body,
    		cls: 'mini-mask-loading',
    		html: '数据加载中...'
    	});

    	var mparams = {
    		data: {
    			id: params.id
    		}
    	};
    	getMaintain(mparams, function(text){
    		var errCode = text.errCode||"";
    		var data = text.maintain||{};
    		if(errCode == 'S'){
    			var p = {
    				data:{
    					guestId: data.guestId||0,
    					contactorId: data.contactorId||0
    				}
    			};
    			getGuestContactorCar(p, function(text){
    				var errCode = text.errCode||"";
    				var guest = text.guest||{};
    				var contactor = text.contactor||{};
    				if(errCode == 'S'){
    					$("#servieIdEl").html(data.serviceCode);
    					var carNo = data.carNo||"";
    					var tel = guest.mobile||"";
    					var guestName = guest.fullName||"";
    					var carVin = data.carVin||"";
    					if(tel){
    						tel = "/"+tel;
    					}
    					if(guestName){
    						guestName = "/"+guestName; 
    					}
    					if(carVin){
    						carVin = "/"+carVin;
    					}
    					var t = carNo + tel + guestName + carVin;

    					var sk = document.getElementById("search_key");
    					sk.style.display = "none";
    					searchNameEl.setVisible(true);

    					searchNameEl.setValue(t);
    					searchNameEl.setEnabled(false);

    					data.guestFullName = guest.fullName;
    					data.guestMobile = guest.mobile;
    					data.contactorName = contactor.name;
    					data.mobile = contactor.mobile;
    					data.carModel=mainRow.carModel;
    					if(mainRow.planFinishDate){
    						
    						data.timeDaff=timeDiff(mainRow.planFinishDate);
    					}
                        //$("#guestNameEl").html(guest.guestFullName);
                        //$("#showCarInfoEl").html(data.carNo);
                        //$("#guestTelEl").html(guest.mobile);

                        //fguestId = data.guestId||0;
                        //fcarId = data.carId||0;

                       // doSearchCardTimes(fguestId);
                        //doSearchMemCard(fguestId);

                        billForm.setData(data);
                        if(nui.get('partAuditSign').value==0){
                        	nui.get('partAuditSign').setValue("未审核");
                        	$('#audit').text("配件审核");
                        }
                        else{
                        	nui.get('partAuditSign').setValue("已审核");
                        	$('#audit').text("配件返审");
                        }
                        //mainGrid.setUrl("com.hsapi.repair.baseData.query.QueryRpsCheckDetailList.biz.ext");
                        //mainGrid.load({mainId:params.id});
                        
                        var billTypeId = data.billTypeId||0;
                        if(billTypeId==0 || billTypeId==2 || billTypeId==4 || billTypeId==6) {
	                        var p1 = {
	                            interType: "package",
	                            data:{
	                                serviceId: data.id||0
	                            }
	                        }
	                        var p2 = {
	                            interType: "item",
	                            data:{
	                                serviceId: data.id||0
	                            }
	                        }
	                        loadDetail(p1, p2);
                        }else {
                        	rpsPackageGrid.hide();
                        	rpsItemGrid.hide();
                        	mainGrid.show();
                        	mainGrid.load({serviceId:params.id,token:token});
                        }
                        
                        if(showOut.getValue == 1) {
                        	repairOutGrid.load({serviceId:params.id,token:token});
                        }else {
                        	repairOutGrid.load({serviceId:params.id,returnSign:0,token:token});
                        }

                    }else{
                    	showMsg("数据加载失败,请重新打开工单!","W");
                    }

                }, function(){});
    		}else{
    			showMsg('数据加载失败!','W');
    		}
    	}, function(){
    		nui.unmask(document.body);
    	});
    }
}

function loadDetail(p1, p2){
	mainGrid.hide();
    if(p1 && p1.interType){
        getBillDetail(p1, function(text){
            var errCode = text.errCode;
            var data = text.data||[];
            if(errCode == "S"){
                rpsPackageGrid.clearRows();
                rpsPackageGrid.addRows(data);
                rpsPackageGrid.accept();
                if(data && data.length>0){
                	rpsPackageGrid.show();
                }else{
                	rpsPackageGrid.hide();
                }
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
                if(data && data.length>0){
                	rpsItemGrid.show();
                }else{
                	rpsItemGrid.hide();
                }
            }
        }, function(){});
    }
}
function pkgPick(row_uid){
    var main = billForm.getData();
    var isSettle = main.isSettle||0;
    if(!main.id){
        showMsg("工单信息有误，请重新打开当前单据!","W");
        return;
    }
    var nstatus = main.status||0;
    if(nstatus == 2){
        showMsg("工单已完工,不能领料","W");
        return;
    }
	if(nstatus==0){
		showMsg("草稿状态下的单据不能领料","W");
		return;
	}
    if(isSettle == 1){
        showMsg("工单已结算,不能修改配件","W");
        return;
    }

    var row = rpsPackageGrid.getRowByUID(row_uid);
    if(!row) return;
    var r = row.prdtId;
	var c = row.prdtCode;
	var recordId = row.id;
	if(r){
		openPartSelect(r,"Id",recordId,mainRow,row, 'PICK');
	}else if(c){ 
		openPartSelect(c,"Code",recordId,mainRow,row, 'PICK');
	}else{
		openPartSelect(c,"Name",recordId,mainRow,row, 'PICK');
	}
}
function itemPick(row_uid){
    var main = billForm.getData();
    var isSettle = main.isSettle||0;
    if(!main.id){
        showMsg("工单信息有误，请重新打开当前单据!","W");
        return;
    }
    var nstatus = main.status||0;
    if(nstatus == 2){
        showMsg("工单已完工,不能领料","W");
        return;
    }
	if(nstatus==0){
		showMsg("草稿状态下的单据不能领料","W");
		return;
	}
    if(isSettle == 1){
        showMsg("工单已结算,不能修改配件","W");
        return;
    }

    var row = rpsItemGrid.getRowByUID(row_uid);
    if(!row) return;
    var r = row.prdtId;
	var c = row.prdtCode;
	var recordId = row.id;
	if(r){
		openPartSelect(r,"Id",recordId,mainRow,row, 'PICK');
	}else if(c){ 
		openPartSelect(c,"Code",recordId,mainRow,row, 'PICK');
	}else{
		openPartSelect(c,"Name",recordId,mainRow,row, 'PICK');
	}
}
function LLSave(argument) {
	if(status==2){
		showMsg("单据已完工,不能领料","W");
		return;
	}
	if(status==0){
		showMsg("草稿状态下的单据不能领料","W");
		return;
	}
	var rows = mainGrid.getSelecteds();
	if (rows.length > 0) {
		for (var i = 0, l = rows.length; i < l; i++) {
			var r = rows[i].partId;
			var c = rows[i].partCode;
			var recordId = rows[i].id;
			if(r){
				openPartSelect(r,"Id",recordId,mainRow,rows[i], 'PICK');
			}else if(c){ 
				openPartSelect(c,"Code",recordId,mainRow,rows[i], 'PICK');
			}else{
				openPartSelect(c,"Name",recordId,mainRow,rows[i], 'PICK');
			}
		}

	}else{
		showMsg('请先选择配件!','W');
	}
}

function openPartSelect(par,type,id,row,srow,pickType){
	var qty = srow.qty||0;
	var pickQty = srow.pickQty||0;
	var restQty = parseFloat(qty - pickQty).toFixed(2);
	nui.open({
		url: webBaseUrl + "com.hsweb.RepairBusiness.partSelect.flow?token="+token,
		title:"选择配件--待领料数量："+restQty,
		height:"400px",
		width:"1150px",
		onload:function(){
			var iframe = this.getIFrameEl();
			iframe.contentWindow.SetData(par,type,id,row,srow,pickType);
		},
		ondestroy:function(action){ 
			var p1 = {};
			var p2 = {};
			var bill = false;
			if(rpsPackageGrid.visible){
				p1.interType = "package";
				var data = {
					serviceId: mid
                }
				p1.data = data;
				bill = true;
			}
			if(rpsItemGrid.visible){
				p2.interType = "item";
				var data = {
					serviceId: mid
                }
				p2.data = data;
				bill = true;
			}
			if(bill) {
				loadDetail(p1, p2);
			}else {
				mainGrid.load({serviceId:mid,token:token});
			}
			if(showOut.value == 1) {
            	repairOutGrid.load({serviceId:mid,token:token});
            }else {
            	repairOutGrid.load({serviceId:mid,returnSign:0,token:token});
            }
        }

    });
}

function onValueChangShowOut(){
	var main = billForm.getData();
	if(showOut.value==1){
		repairOutGrid.load({serviceId:main.id,token:token});
	}else if(showOut.value==0){
		repairOutGrid.load({serviceId:main.id,returnSign:0,token:token});
	}
}

function THSave(){
	if(status==2){
		showMsg("单据已完工，维修出库不能退货","W");
		return;
	}
	if(status==0){
		showMsg("草稿状态下的单据不能领料","W");
		return;
	}
	var rows = repairOutGrid.getSelecteds();
	if (rows.length > 0) {
		for (var i = 0; i < rows.length; i++) {
			if(rows[i].returnSign == 0){
				memberSelect(rows[i]);
			}else{
				showMsg('该条数据已归库!','W');
				return;
			}
		}
	}else{
		showMsg('请先选择需要归库的配件!','W');
	}

}

//配件
function choosePart(row_uid){
    var row = rpsItemGrid.getRowByUID(row_uid);
    FItemRow = row;
    var itemId = null;
    if(row){
    	itemId = row.id;
    }else{
        return;
    }
    var main = billForm.getData();
    var isSettle = main.isSettle||0;
    if(!main.id){
        showMsg("工单信息有误，请重新打开当前单据!","W");
        return;
    }
    var status = main.status||0;
    if(status == 2){
        showMsg("工单已完工,不能添加配件!","W");
        return;
    }
    if(isSettle == 1){
        showMsg("工单已结算,不能添加配件!","W");
        return;
    }

    if(advancedMorePartWin.visible){
    	FItemRow = {};
    	advancedMorePartWin.hide();
    	return;
    } 
    var atEl = rpsItemGrid.getCellEl(row,"prdtName");
    advancedMorePartWin.showAtEl(atEl, {xAlign:"left",yAlign:"above"});
   	
    
    /*openPartSelect("", "", itemId, mainRow, row, 'ADD');
    doSelectPart(itemId,addToBillPart, delFromBillPart, null, function(text){
        var p1 = { };
        var p2 = {
            interType: "item",
            data:{
                serviceId: main.id||0
            }
        };
        
        loadDetail(p1, p2);
    });*/
}
function chooseStock() {
	advancedMorePartWin.hide();
	if(!FItemRow.id) {
		showMsg("请重新选择","W");
		return;
	}
	openPartSelect("", "", FItemRow.id, mainRow, FItemRow, 'ADD');
	
	var p1 = { };
    var p2 = {
        interType: "item",
        data:{
            serviceId: FItemRow.serviceId||0
        }
    };
    
    loadDetail(p1, p2);
}
function chooseBasic() {
	advancedMorePartWin.hide();
	if(!FItemRow.id) {
		showMsg("请重新选择","W");
		return;
	}
	doSelectPart(FItemRow.id,addToBillPart, delFromBillPart, null, function(text){
        var p1 = { };
        var p2 = {
            interType: "item",
            data:{
                serviceId: FItemRow.serviceId||0
            }
        };
        
        loadDetail(p1, p2);
    });
}

function addToBillPart(row, callback, unmaskcall){
    var main = billForm.getData();
    var data = {};
    var insPart = {
        serviceId:main.id||0,
        partId:row.id,
        billItemId:row.billItemId,     
        cardDetailId:0,
        qty:1
    };
    data.insPart = insPart;
    data.serviceId = main.id||0;
    
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
            showMsg(errMsg||"添加配件失败!","E");
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
            showMsg(errMsg||"删除配件信息失败!","E");
            return;
        }
    });
}
function editItemRpsPart(row_uid){
    var main = billForm.getData();
    var isSettle = main.isSettle||0;
    if(!main.id){
        showMsg("工单信息有误，请重新打开当前单据!","W");
        return;
    }
    var status = main.status||0;
    if(status == 2){
        showMsg("工单已完工,不能修改配件!","W");
        return;
    }
    if(isSettle == 1){
        showMsg("工单已结算,不能修改配件!","W");
        return;
    }

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
    var main = billForm.getData();
    var isSettle = main.isSettle||0;
    if(!main.id){
        showMsg("工单信息有误，请重新打开当前单据!","W");
        return;
    }
    var status = main.status||0;
    if(status == 2){
        showMsg("工单已完工,不能修改配件!","W");
        return;
    }
    if(isSettle == 1){
        showMsg("工单已结算,不能修改配件!","W");
        return;
    }
    var rowc = rpsItemGrid.getRowByUID(row_uid);
    if (rowc) {
    	rpsItemGrid.commitEdit();
        var rows = rpsItemGrid.getChanges();

        if(rows && rows.length>0){
            var row = rows[0];
            var serviceId = row.serviceId||0;
            var cardDetailId = row.cardDetailId||0;
            
            var updList = [];
            if(cardDetailId > 0){ //预存的
                var part = {};
                part.id = row.id;
                part.serviceId = row.serviceId;
                part.serviceTypeId = row.serviceTypeId;
                updList.push(part);
            }else{
                var part = {};
                part.id = row.id;
                part.serviceId = row.serviceId;
                part.prdtName = row.prdtName;
                part.qty = row.qty;
                part.subtotal = row.subtotal;
                part.serviceTypeId = row.serviceTypeId;
                part.unitPrice = row.unitPrice;
                part.amt = row.amt;
                var rate = row.rate/100;
                rate = rate.toFixed(4);
                part.rate = rate;
                updList.push(part);
            }
            var params = {
                type:"update",
                interType:"part",
                data:{
                    serviceId: serviceId,
                    updList : updList
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
                    showMsg(errMsg||"修改数据失败!","E");
                    return;
                }
            });
        }
    }
}
function deletePartRow(row_uid){
    var main = billForm.getData();
    var isSettle = main.isSettle||0;
    if(!main.id){
        showMsg("工单信息有误，请重新打开当前单据!","W");
        return;
    }
    var status = main.status||0;
    if(status == 2){
        showMsg("工单已完工,不能删除配件!","W");
        return;
    }
    if(isSettle == 1){
        showMsg("工单已结算,不能删除配件!","W");
        return;
    }

    var data = rpsItemGrid.getData();
    var row = rpsItemGrid.getRowByUID(row_uid);
    if(data && data.length==1){
        row = data[0];
    }
    var part = {
        serviceId:row.serviceId,
        id:row.id,
        cardDetailId:row.cardDetailId||0
    };
    
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '数据处理中...'
    });
    nui.ajax({
    	url:baseUrl + "com.hsapi.repair.repairService.crud.deleteRpsPartByKeeper.biz.ext",
    	type:"post",
    	data:{
    		part:part,
    		token:token
    	},
    	success:function(text){
    		var errCode = text.errCode;
    		nui.unmask(document.body);
    		if(errCode == 'S'){   
                if(data && data.length==1){
                    rpsItemGrid.removeRow(data[0]);
                }else{
                    rpsItemGrid.removeRow(row);
                }
            }else{
                showMsg(errMsg||"删除配件信息失败!","E");
                return;
            }
    	}
    });
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
		showMsg("数量不能小于0","W");
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

function  savepartOutRtn(data,childdata){
	if(data){
		var paramsDataArr = [];
            //var paramsData = nui.clone(data);
            var paramsData = {};
            paramsData.serviceId = data.serviceId;
            paramsData.id = data.id;
            paramsData.mainId = data.mainId;
            paramsData.sourceId = data.id;
            paramsData.serviceId = mainRow.id;
            paramsData.serviceCode = mainRow.serviceCode;
            paramsData.carNo = mainRow.carNO;
            paramsData.vin = mainRow.carVin;
            paramsData.partId = data.partId;
            paramsData.partCode = data.partCode;
            paramsData.oemCode = data.oemCode;
            paramsData.partName = data.partName;
            paramsData.partNameId = data.partNameId;
            paramsData.partFullName = data.partFullName;
            paramsData.stockQty = data.stockQty;
            paramsData.outQty = data.outQty;
            paramsData.enterPrice = data.enterPrice;
            paramsData.billTypeId = '050206';
            paramsData.storeId = data.storeId;
            paramsData.unit = data.systemUnitId;
            paramsData.pickMan = data.pickMan;
            paramsData.returnMan=childdata.mtAdvisor;
            paramsData.returnRemark = childdata.remark;
            //paramsData.pickType = "维修出库-领料";
            paramsData.taxUnitPrice = data.taxUnitPrice;
            paramsData.taxAmt = data.taxAmt;
            paramsData.noTaxUnitPrice = data.noTaxUnitPrice;
            paramsData.noTaxAmt = data.noTaxAmt;
            paramsData.trueUnitPrice = data.trueUnitPrice;
            paramsData.trueCost = data.trueCost;
            paramsData.sellUnitPrice = data.sellUnitPrice; 
            paramsData.sellAmt = data.sellAmt;
            paramsData.guestId = mainRow.guestId;
            paramsData.guestName = mainRow.guestFullName;
            
            if(!paramsData.partNameId){
            	paramsData.partNameId = "0";
            }
            paramsDataArr.push(paramsData);

            nui.mask({
	            el: document.body,
	            cls: 'mini-mask-loading',
	            html: '数据处理中...'
	        });
            nui.ajax({
            	url:baseUrl + "com.hsapi.repair.repairService.work.repairOutRtn.biz.ext",
            	type:"post",
            	data:{
            		data:paramsDataArr,
            		billTypeId:"050206", 
            		token:token
            	},
            	success:function(text){
            		var errCode = text.errCode;
            		nui.unmask(document.body);
            		if(errCode == "S"){
            			var p1 = {};
            			var p2 = {};
            			var bill = false;
            			if(rpsPackageGrid.visible){
            				p1.interType = "package";
            				var data = {
            					serviceId: mid
                            }
            				p1.data = data;
            				bill = true;
            			}
            			if(rpsItemGrid.visible){
            				p2.interType = "item";
            				var data = {
            					serviceId: mid
                            }
            				p2.data = data;
            				bill = true;
            			}
            			if(bill) {
            				loadDetail(p1, p2);
            			}else {
            				mainGrid.load({serviceId:mid,token:token});
            			}
            			if(showOut.getValue == 1) {
                        	repairOutGrid.load({serviceId:mid,token:token});
                        }else {
                        	repairOutGrid.load({serviceId:mid,returnSign:0,token:token});
                        }
                        
            			showMsg('归库成功!','S');
            		}else{
            			showMsg(text.errMsg ||'归库失败!','W');
            		}
            	}
            });
        }else{
        	showMsg('没有需要归库的配件!','W');
        }
    }

    function memberSelect(row){

    	if(status==2){
    		showMsg("本工单已完工,配件不能归库","W");
    		return;
    	}
    	nui.open({
    		url: webBaseUrl + "com.hsweb.RepairBusiness.partSelectMember.flow?token="+token,
    		title:"配件归库",
    		height:"300px",
    		width:"600px",
    		onload:function(){
    			var iframe = this.getIFrameEl();
    			iframe.contentWindow.SetData("th");
    		},
    		ondestroy:function(action){
    			if (action == "ok") {
    				var iframe = this.getIFrameEl();
    				var childdata = iframe.contentWindow.GetFormData();
    				savepartOutRtn(row,childdata);
                    //savePartOut();     //如果点击“确定”
                    //CloseWindow("close");
                }
                
            }

        });

    }


    function onGenderRenderer(e) {
    	for (var i = 0, l = returnSignData.length; i < l; i++) {
    		var g = returnSignData[i];
    		if (g.id == e.value) return g.text;
    	}
    	return "";
    }


    function tt(t){
    	nui.alert(t);
    }


    function onPrint(e){
        var main = billForm.getData();
        var openUrl = null;
        if(main.id){
            var params = {
                source : e,
                serviceId : mainRow.id,
                isSettle : mainRow.isSettle
            };
            
            doPrint(params);
        }else{
            showMsg("请先保存工单,再打印!","W");
            return;
        }
    }
    
    function onDrawSummaryCell(e)
    {
        var rows = e.data;//rightGrid.getData();
        
        if (e.field == "qty") { 
        	var qty = 0;
            for (var i = 0; i < rows.length; i++) {
            	if(rows[i].type==3){
            		qty += parseFloat(rows[i].qty);
            	}
            	e.cellHtml=qty;  
            }   
        }
        if (e.field == "subtotal") { 
        	var subtotal = 0;
            for (var i = 0; i < rows.length; i++) {
            	if(rows[i].type==3){
            		subtotal += parseFloat(rows[i].subtotal);
            	}
            	e.cellHtml=subtotal;  
            }   
        }
        
    }
    
    function onDrawSummaryCell2(e)
    {
        var rows = e.data;//rightGrid.getData();
        
        if (e.field == "qty") { 
        	var qty = 0;
            for (var i = 0; i < rows.length; i++) {
            	if(rows[i].pid!=0){
            		qty += parseFloat(rows[i].qty);
            	}
            	e.cellHtml=qty;  
            }   
        }
        if (e.field == "subtotal") { 
        	var subtotal = 0;
            for (var i = 0; i < rows.length; i++) {
            	if(rows[i].pid!=0){
            		subtotal += parseFloat(rows[i].subtotal);
            	}
            	e.cellHtml=subtotal;  
            }   
        }
        
    }
    function timeDiff(planFinishDate){
    	var startTime = new Date(); // 开始时间
        var endTime = planFinishDate; // 结束时间
        var usedTime = endTime - startTime; // 相差的毫秒数
        var s = "";

        if(usedTime<0){
        	usedTime = 0 - usedTime;
        	var days = Math.floor(usedTime / (24 * 3600 * 1000)); // 计算出天数
        	if(days>0){
        		s = days + '天';
        	}
            var leavel = usedTime % (24 * 3600 * 1000); // 计算天数后剩余的时间
            var hours = Math.floor(leavel / (3600 * 1000)); // 计算剩余的小时数
            if(hours>0){
            	s = s + hours + '小时';
            }
            var leavel2 = leavel % (3600 * 1000); // 计算剩余小时后剩余的毫秒数
            var minutes = Math.floor(leavel2 / (60 * 1000)); // 计算剩余的分钟数
            if(minutes>0){
            	s = s + minutes + '分';
            }
            $('#timeDaff').attr("color","red");
            return s="已超时"+s;
        }else{
        	usedTime =  usedTime;
        	var days = Math.floor(usedTime / (24 * 3600 * 1000)); // 计算出天数
        	if(days>0){
        		s = days + '天';
        	}
            var leavel = usedTime % (24 * 3600 * 1000); // 计算天数后剩余的时间
            var hours = Math.floor(leavel / (3600 * 1000)); // 计算剩余的小时数
            if(hours>0){
            	s = s + hours + '小时';
            }
            var leavel2 = leavel % (3600 * 1000); // 计算剩余小时后剩余的毫秒数
            var minutes = Math.floor(leavel2 / (60 * 1000)); // 计算剩余的分钟数
            if(minutes>0){
            	s = s + minutes + '分';
            }
            return s;
        }
        
    }
    
    function updateBillExpense(){
        var data = billForm.getData();
        var params = {
            serviceId:data.id||0
        };
        doBillExpenseDetail(params, function(data){
            data = data||{};
            if(data.action){
                var action = data.action||"";
                if(action == 'ok'){
                }else{
                }
            }
        });
    }
    
    function auditPart(){
    	var status=null;
    	if(nui.get('partAuditSign').value=="已审核"){
    		status=0;
    	}else{
    		status=1;
    	}
        nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '数据处理中...'
        });
        nui.ajax({
        	url:baseUrl + "com.hsapi.repair.repairService.work.partAudit.biz.ext",
        	type:"post",
        	data:{
        		status :status,
        		id:mainRow.id,
        		userName:currUserName, 
        		token:token
        	},
        	success:function(text){
        		var errCode = text.errCode;
        		nui.unmask(document.body);
        		if(errCode == "S"){
        			if(status==1){
        				nui.get('partAuditSign').setValue("已审核");
            			showMsg('配件审核成功!','S');
            			$('#audit').text("配件返审");
        			}else{
        				nui.get('partAuditSign').setValue("未核");
            			showMsg('配件返审成功!','S');
            			$('#audit').text("配件审核");
        			}
        			      		
        		}else{
        			if(status==1){
        				showMsg(text.errMsg ||'配件审核失败!','W');
        			}else{
        				showMsg(text.errMsg ||'配件返审失败!','W');
        			}
        		}

        	}
        });
    }
    
    
    
    
var getStorehouseUrl = apiPath + partApi 
+ "/com.hsapi.part.baseDataCrud.crud.getStorehouse.biz.ext";
function getAllStorehouse(callback) {
	doPost({
		url : getStorehouseUrl,
		data : {token: token},
		success : function(data) {
			callback && callback(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
			callback && callback({});
		}
	});
}