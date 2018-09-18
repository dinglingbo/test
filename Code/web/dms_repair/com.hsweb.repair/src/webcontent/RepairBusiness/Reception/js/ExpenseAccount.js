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
	
	initMember("mtAdvisorId",function(){
        memList = mtAdvisorIdEl.getData();
    });
	mtAdvisorIdEl.on("valueChanged",function(e){
        var text = mtAdvisorIdEl.getText();
        nui.get("mtAdvisor").setValue(text);
    });
	/*rpsPackageGrid.on("cellendedit",function(e){
		var row = e.row,
		field = e.field;
		if(field == "subtotal" || field == "rate"){
			var amt = 0;
			if(row.rate){
				amt = parseFloat(row.subtotal)/ parseFloat(row.rate  * 0.01);
			}else{
				amt = 0;
			}
			var newRow = {amt : amt};
			rpsPackageGrid.updateRow(row,newRow);
		}
	});*/
	rpsPackageGrid.on("drawcell",function(e){
		var field = e.field,
		value = e.value;
		if(field == "rate"){
			if(value){
				e.cellHtml = value + "%";
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
			var subtotal = parseFloat(row.qty) * parseFloat(row.unitPrice) * parseFloat(row.rate) * 0.01;
			var newRow = {subtotal : subtotal};
			rpsPartGrid.updateRow(row,newRow);
		}
	});
	rpsPartGrid.on("drawcell",function(e){
		var field = e.field,
		value = e.value;
		if(field == "rate"){
			if(value){
				e.cellHtml = value + "%";
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
			var subtotal = parseFloat(row.itemTime) * parseFloat(row.unitPrice) * parseFloat(row.rate) * 0.01;
			var newRow = {subtotal : subtotal};
			rpsItemGrid.updateRow(row,newRow);
		}
	});
	rpsItemGrid.on("drawcell",function(e){
		var field = e.field,
		value = e.value;
		if(field == "rate"){
			if(value){
				e.cellHtml = value + "%";
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
	var maintainBill = billForm.getData();
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
             token : token
        },
        success: function(text) {
        	nui.get("rid").setValue(text.mainId);
        	rpsPackageGrid.setUrl(baseUrl+"com.hsapi.repair.baseData.query.searchExpense.biz.ext");
        	rpsPackageGrid.load({serviceId : text.mainId,token : token});
        	rpsItemGrid.setUrl(baseUrl+"com.hsapi.repair.baseData.query.searchExpense.biz.ext");
        	rpsItemGrid.load({serviceId : text.mainId,token : token});
        	rpsPartGrid.setUrl(baseUrl+"com.hsapi.repair.baseData.query.searchExpense.biz.ext");
        	rpsPartGrid.load({serviceId : text.mainId,token : token});
        }
    });
}


function setData(){
	nui.ajax({
        url: baseUrl+"com.hsapi.repair.repairService.query.searchRpsMaintainBill.biz.ext",
        type: "post",
        cache: false,
        data: {
        	sourceServiceId : 294
        },
        success: function(text) {
        	var list = nui.decode(text.list);
        	if(list.length > 0){
        		billForm.setData(list[0]);
        	}
        }
    });
}