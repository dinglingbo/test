var rpsPackageGrid = null;
var rpsItemGrid = null;
var rpsPartGrid = null;
var billForm = null;
var servieTypeList = [];
var servieTypeHash = {};
var mtAdvisorIdEl = null;
var baseUrl = apiPath + repairApi + "/";
$(document).ready(function () {
	rpsPackageGrid = nui.get("rpsPackageGrid");
	rpsItemGrid = nui.get("rpsItemGrid");
	rpsPartGrid = nui.get("rpsPartGrid");
	billForm = new nui.Form("#billForm");
	mtAdvisorIdEl = nui.get("mtAdvisorId");
	initServiceType("serviceTypeId",function(data) {
	    servieTypeList = nui.get("serviceTypeId").getData();
	    servieTypeList.forEach(function(v) {
	        servieTypeHash[v.id] = v;
	    });
	 });
	
	if(nui.get("sourceServiceId").value){
		nui.ajax({
	        url: baseUrl+"com.hsapi.repair.repairService.query.searchRpsMaintainBill.biz.ext",
	        type: "post",
	        cache: false,
	        data: {
	        	sourceServiceId : nui.get("sourceServiceId").value
	        },
	        success: function(text) {
	        	var list = nui.decode(text.list);
	        	if(list.length  == 0){
	        		showGridMsg(0);
	        	}else{
	        		showGridMsg(list[0].id);
	        	}
	        }
	    });
	}
	
	rpsPackageGrid.on("load",function(e){
		var data = rpsPackageGrid.getData();
		if(data.length == 0){
			rpsPackageGrid.setData([]);
			nui.ajax({
		        url: baseUrl+"com.hsapi.repair.repairService.svr.getRpsPackagePItemPPart.biz.ext",
		        type: "post",
		        cache: false,
		        data: {
		        	serviceId : nui.get("sourceServiceId").value
		        },
		        success: function(text) {
		        	var data = nui.decode(text.data);
		        	if(data.length > 0){
		        		for(var i = 0 , l = data.length ; i < l ; i ++){
		        			var billPackageId = data[i].billPackageId;
		        			var packageName = data[i].prdtName || "";
		        			var subtotal = data[i].subtotal || "";
		        			var rate = data[i].rate || "";
		        			var amt = data[i].amt || "";
		        			var newRow = {
		        					billPackageId : billPackageId,
		        					packageName : packageName,
		        					subtotal : subtotal,
		        					rate : rate,
		        					amt : amt
		        			};
		        			var dataAll = rpsPackageGrid.getData();
		        			rpsPackageGrid.addRow(newRow,dataAll.length);
		        		}
		        	}
		        }
		    });
		}
	});
	
	rpsItemGrid.on("load",function(e){
		var data = rpsItemGrid.getData();
		if(data.length == 0){
			rpsItemGrid.setData([]);
			nui.ajax({
		        url: baseUrl+"com.hsapi.repair.repairService.svr.getRpsMainItem.biz.ext",
		        type: "post",
		        cache: false,
		        data: {
		        	serviceId : nui.get("sourceServiceId").value
		        },
		        success: function(text) {
		        	var data = nui.decode(text.data);
		        	if(data.length > 0){
		        		for(var i = 0 , l = data.length ; i < l ; i ++){
		        			var itemName = data[i].itemName || "";
		        			var itemTime = data[i].itemTime || "";
		        			var unitPrice = data[i].unitPrice || "";
		        			var rate = data[i].rate || "";
		        			var subtotal = data[i].subtotal || "";
		        			var newRow = {
		        					itemName : itemName,
		        					itemTime : itemTime,
		        					unitPrice : unitPrice,
		        					rate : rate,
		        					subtotal : subtotal
		        			};
		        			var dataAll = rpsItemGrid.getData();
		        			rpsItemGrid.addRow(newRow,dataAll.length);
		        		}
		        	}
		        }
		    });
		}
	});
	
	rpsPartGrid.on("load",function(e){
		var data = rpsPartGrid.getData();
		if(data.length == 0){
			rpsPartGrid.setData([]);
			nui.ajax({
		        url: baseUrl+"com.hsapi.repair.repairService.svr.getRpsMainPart.biz.ext",
		        type: "post",
		        cache: false,
		        data: {
		        	serviceId : nui.get("sourceServiceId").value
		        },
		        success: function(text) {
		        	var data = nui.decode(text.data);
		        	if(data.length > 0){
		        		for(var i = 0 , l = data.length ; i < l ; i ++){
		        			var partName = data[i].partName || "";
		        			var unitPrice = data[i].unitPrice || "";
		        			var rate = data[i].rate || "";
		        			var subtotal = data[i].subtotal || "";
		        			var newRow = {
		        					partName : partName,
		        					qty : 1,
		        					unitPrice : unitPrice,
		        					rate : rate,
		        					subtotal : subtotal
		        			};
		        			var dataAll = rpsPartGrid.getData();
		        			rpsPartGrid.addRow(newRow,dataAll.length);
		        		}
		        	}
		        }
		    });
		}
	});
	
	
	initMember("mtAdvisorId",function(){
        memList = mtAdvisorIdEl.getData();
    });
	mtAdvisorIdEl.on("valueChanged",function(e){
        var text = mtAdvisorIdEl.getText();
        nui.get("mtAdvisor").setValue(text);
    });
	rpsPackageGrid.on("cellendedit",function(e){
		var row = e.row,
		field = e.field;
		if(field == "subtotal"){
			var rate = null;
			if(row.amt){
				rate = 1 - (parseFloat(row.subtotal)/parseFloat(row.amt/100));
			}else{
				rate = 1;
			}
			var newRow = {rate : rate};
			rpsPackageGrid.updateRow(row,newRow);
		}
		if(field == "rate"){
			var subtotal = null;
			if(row.rate){
				subtotal = parseFloat(row.amt) * parseFloat(100-row.rate)/100;
			}else{
				subtotal = 0;
			}
			var newRow = {subtotal : subtotal};
			rpsPackageGrid.updateRow(row,newRow);
		}
	});
	rpsPackageGrid.on("drawcell",function(e){
		var field = e.field,
		value = e.value;
		if(field == "rate"){
			if(value){
				e.cellHtml = value.toFixed(2) + "%";
			}else{
				e.cellHtml = 0 + "%";
			}
		}
		if(field == "subtotal"){
			if(!value){
				e.cellHtml = 0;
			}
		}
		if(field == "action"){
			e.cellHtml = ' <a class="optbtn" href="javascript:deleteRow(rpsPackageGrid)">删除</a>';
		}
	});
	rpsPartGrid.on("cellendedit",function(e){
		var row = e.row,
		field = e.field;
		if(field == "qty" || field == "unitPrice" || field == "rate"){
			var subtotal = parseFloat(row.qty) * parseFloat(row.unitPrice) * parseFloat(100-row.rate) * 0.01;
			var newRow = {subtotal : subtotal};
			rpsPartGrid.updateRow(row,newRow);
		}
	});
	rpsPartGrid.on("drawcell",function(e){
		var field = e.field,
		value = e.value;
		if(field == "rate"){
			if(value){
				e.cellHtml = value.toFixed(2) + "%";
			}else{
				e.cellHtml = 0 + "%";
			}
		}
		if(field == "itemTime" || field == "unitPrice"){
			if(!value){
				e.cellHtml = 0;
			}
		}
		if(field == "action"){
			e.cellHtml = ' <a class="optbtn" href="javascript:deleteRow(rpsPartGrid)">删除</a>';
		}
	});
	rpsItemGrid.on("cellendedit",function(e){
		var row = e.row,
		field = e.field;
		if(field == "itemTime" || field == "unitPrice" || field == "rate"){
			var subtotal = parseFloat(row.itemTime) * parseFloat(row.unitPrice) * parseFloat(100-row.rate) * 0.01;
			var newRow = {subtotal : subtotal};
			rpsItemGrid.updateRow(row,newRow);
		}
	});
	rpsItemGrid.on("drawcell",function(e){
		var field = e.field,
		value = e.value;
		if(field == "rate"){
			if(value){
				e.cellHtml = value.toFixed(2) + "%";
			}else{
				e.cellHtml = 0 + "%";
			}
		}
		if(field == "itemTime" || field == "unitPrice"){
			if(!value){
				e.cellHtml = 0;
			}
		}
		if(field == "action"){
			e.cellHtml = ' <a class="optbtn" href="javascript:deleteRow(rpsItemGrid)">删除</a>';
		}
	});
});

function deleteRow(grid){
	var row = grid.getSelected();
	grid.removeRow(row);
}

function choosePackage(){
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
            iframe.contentWindow.setValueData();
		},
		ondestroy : function(action) {
			var iframe = this.getIFrameEl();
            var data = iframe.contentWindow.getDataAll();
            for(var i = 0 , l = data.length ; i < l ; i++){
            	var packageName = data[i].name || "";
            	var subtotal = data[i].amount || 0;
            	var packageId = data[i].id || "";
            	var amt = data[i].total || 0;
            	var rpsPackageGridData = rpsPackageGrid.getData();
            	var newRow = {
            			packageName : packageName,
            			subtotal : subtotal,
            			amt : amt,
            			packageId : packageId
            	};
            	rpsPackageGrid.addRow(newRow,rpsPackageGridData.length);
            }
		}
	});
}

function chooseItem(){
	nui.open({
		targetWindow : window,
		url : webPath + contextPath + "/com.hsweb.repair.DataBase.RepairItemMain.flow?token=" + token,
		title : "维修工时",
		width : 1000,
		height : 560,
		allowDrag : true,
		allowResize : true,
		onload : function() {
			var iframe = this.getIFrameEl();
			iframe.contentWindow.showCheckcolumn();
		},
		ondestroy : function(action) {
			var iframe = this.getIFrameEl();
            var data = iframe.contentWindow.getDataAll();
            for(var i = 0 , l = data.length; i < l ; i++){
            	var itemName = data[i].name || "";
            	var type = data[i].type || "";
            	var subtotal = data[i].amt || "";
            	var itemTime = data[i].itemTime || "";
            	var unitPrice = data[i].unitPrice || "";
            	var newRow = {
            				itemName : itemName,
            				type : type,
            				itemTime :itemTime,
            				unitPrice : unitPrice,
            				subtotal : subtotal
            				};
            	var dataAll = rpsItemGrid.getData();
            	rpsItemGrid.addRow(newRow,dataAll.length);
            }
		}
	});
}

function choosePart(){
	nui.open({
		targetWindow : window,
		url : webPath + contextPath + "/com.hsweb.repair.DataBase.partSelectView.flow?token=" + token,
		title : "配件管理",
		width : 1300,
		height : 560,
		allowDrag : true,
		allowResize : true,
		onload : function() {
			var iframe = this.getIFrameEl();
			iframe.contentWindow.setValueData();
		},
		ondestroy : function(action) {
			var iframe = this.getIFrameEl();
            var data = iframe.contentWindow.getDataAll();
            for(var i = 0 , l = data.length; i < l ; i++){
            	var partName = data[i].name || "";
            	var newRow = {
            			partName : partName,
            			qty : 1,
            			unitPrice : 0,
            			subtotal : 0
            	};
            	var dataAll = rpsPartGrid.getData();
            	rpsPartGrid.addRow(newRow,dataAll.length);
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
	var maintainBill = billForm.getData();
	if(nui.get("mtAdvisorId").text){
		maintainBill.mtAdvisor = nui.get("mtAdvisorId").text;
	}
	var packageInsert = rpsPackageGrid.getChanges("added");
	var packageRemoved = rpsPackageGrid.getChanges("removed");
	var packageModifiy = rpsPackageGrid.getChanges("modified");
	var itemInsert = rpsItemGrid.getChanges("added");
	var itemRemoved = rpsItemGrid.getChanges("removed");
	var itemModifiy = rpsItemGrid.getChanges("modified");
	var partInsert = rpsPartGrid.getChanges("added");
	var partRemoved = rpsPartGrid.getChanges("removed");
	var partModifiy = rpsPartGrid.getChanges("modified");
	nui.ajax({
        url: baseUrl+"com.hsapi.repair.baseData.crud.saveExpenseAccount.biz.ext",
        type: "post",
        cache: false,
        data: {
        	 maintainBill : maintainBill,
        	 packageInsert: packageInsert,
        	 packageRemoved: packageRemoved,
        	 packageModifiy: packageModifiy,
        	 itemInsert : itemInsert,
        	 itemRemoved :itemRemoved,
        	 itemModifiy : itemModifiy,
        	 partInsert : partInsert,
        	 partRemoved : partRemoved,
        	 partModifiy : partModifiy,
             token : token,
             sourceServiceId : nui.get("sourceServiceId").value
        },
        success: function(text) {
        	nui.unmask(document.body);
        	if(text.errMsg){
        		showMsg(text.errMsg,"W");
        	}else{
        		nui.get("rid").setValue(text.mainId);
            	showGridMsg(text.mainId);
        	}
        }
    });
}

function onPrint(e){
	var main = billForm.getData();
	if(main.id){
		var params = {
            serviceId : main.id,
            comp : currOrgName,
            baseUrl : baseUrl,
            type : 1,
            token : token
        };
		nui.open({
	        url: "com.hsweb.print.settlement.flow",
	        width: "100%",
	        height: "100%",
	        showMaxButton: false,
	        allowResize: false,
	        showHeader: true,
	        onload: function() {
	            var iframe = this.getIFrameEl();
	            iframe.contentWindow.SetData(params);
	        },
	    });
	}else{
		showMsg("请先保存数据","W");
	}
}

function showGridMsg(serviceId){
	rpsPackageGrid.setUrl(baseUrl+"com.hsapi.repair.baseData.query.searchExpense.biz.ext");
	rpsPackageGrid.load({serviceId : serviceId,token : token});
	rpsItemGrid.setUrl(baseUrl+"com.hsapi.repair.baseData.query.searchExpense.biz.ext");
	rpsItemGrid.load({serviceId : serviceId,token : token});
	rpsPartGrid.setUrl(baseUrl+"com.hsapi.repair.baseData.query.searchExpense.biz.ext");
	rpsPartGrid.load({serviceId : serviceId,token : token});
}


function setInitData(params){
	if(!params.isOutBill){//未保存过一次报销单
		params.id = "";
		billForm.setData(params);
	}else{
		nui.ajax({
	        url: baseUrl+"com.hsapi.repair.repairService.svr.billqyeryMaintainList.biz.ext",
	        type: "post",
	        cache: false,
	        data: {
	        	sourceServiceId : params.id
	        },
	        success: function(text) {
	        	var list = nui.decode(text.list);
	        	billForm.setData(list[0]);
	        }
	    });
	}
}