var rpsPackageGrid = null;
var rpsItemGrid = null;
var billForm = null;
var servieTypeList = [];
var servieTypeHash = {};
var mtAdvisorIdEl = null;
var FItemRow = {};
var advancedMorePartWin = null;
var baseUrl = apiPath + repairApi + "/";
var webBaseUrl = webPath + contextPath + "/";  

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
};

$(document).ready(function () {
	rpsPackageGrid = nui.get("rpsPackageGrid");
	rpsItemGrid = nui.get("rpsItemGrid");
	billForm = new nui.Form("#billForm");
	mtAdvisorIdEl = nui.get("mtAdvisorId");
	advancedMorePartWin = nui.get("advancedMorePartWin");
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
		        	serviceId : nui.get("sourceServiceId").value,
		        	token : token
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
		        url: baseUrl+"com.hsapi.repair.repairService.svr.getRpsItemPPart.biz.ext",
		        type: "post",
		        cache: false,
		        data: {
		        	serviceId : nui.get("sourceServiceId").value,
		        	token : token
		        },
		        success: function(text) {
		        	var data = nui.decode(text.data);
		        	if(data.length > 0){
		        		for(var i = 0 , l = data.length ; i < l ; i ++){
		        			var itemName = data[i].prdtName || "";
		        			var itemTime = data[i].qty || "";
		        			var unitPrice = data[i].unitPrice || "";
		        			var rate = data[i].rate || "";
		        			var subtotal = data[i].subtotal || "";
		        			var pid = data[i].pid || "0";
		        			var newRow = {
		        					itemName : itemName,
		        					itemTime : itemTime,
		        					unitPrice : unitPrice,
		        					rate : rate,
		        					subtotal : subtotal,
		        					pid : pid,
		        					myId : data[i].id,
		        					orderIndex : data[i].orderIndex
		        			};
		        			var dataAll = rpsItemGrid.getData();
		        			rpsItemGrid.addRow(newRow,dataAll.length);
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
		/*if(field == "rate"){
			if(value){
				e.cellHtml = value.toFixed(2) + "%";
			}else{
				e.cellHtml = 0 + "%";
			}
		}*/
		if(field == "subtotal"){
			if(!value){
				e.cellHtml = 0;
			}
		}
		if(field == "action"){
			e.cellHtml = ' <a class="optbtn" href="javascript:deleteRow(rpsPackageGrid)">删除</a>';
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
		value = e.value,
		row = e.row;
		var record = e.record;
		var uid = record._uid;
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
		if(field == "itemName"){
			if(row.pid == 0){
                e.cellHtml = '<a href="javascript:showMorePart(\'' + uid + '\')" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;配件</a>' + e.value;	
            }else{
            	e.cellHtml ='<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>' + e.value;
            }
		}
	});
});

function showBasicData(type){
    var maintain = billForm.getData();
    var isSettle = maintain.isSettle||0;
    var status = maintain.status||0;
    var BasicDataUrl = null;
    var title = null;
    if(!maintain.id){
        showMsg("请选择保存工单!","W");
        return;
    }
    if(status==2){
        showMsg("本单已完工,不能录入!","W");
        return;
    }
    if(isSettle == 1){
        showMsg("本单已结算,不能录入!","W");
        return;
    }
    var carVin = billForm.carVin;
    var params = {
        vin:carVin,
        serviceId:maintain.id
    };
    if(type=="pkg"){
    	BasicDataUrl = "/com.hsweb.RepairBusiness.ProductEntryPkg.flow?token=";
    	title = "标准套餐查询";
    }
    if(type=="item"){
    	BasicDataUrl = "/com.hsweb.RepairBusiness.ProductEntryItem.flow?token=";
    	title = "标准工时查询";
    }
    
    
    nui.open({
        url: webPath + contextPath +BasicDataUrl+token,
        title: title,width: 900, height: 600,
        onload: function () {
        	var iframe = this.getIFrameEl();
            //var carVin = maintain.carVin;
            //var data = {
            //    vin:carVin
            //};
            
           /* iframe.contentWindow.setData(params,function(data,callback)
            {
            	//如果选择的是套餐，没有item属性
               if(data.item)
                {
                    var tmpItem = data.item;
                    addItem(tmpItem);
                }
                else{
                    addPackage(data,callback);
                }

            });*/ 
           iframe.contentWindow.setData(params,callback); 
        },
        ondestroy: function (action)
        {
        	        	
        }
    });
}

function showBasicDataPart(){
    var row = FItemRow;//rpsItemGrid.getRowByUID(row_uid);
	//获取到工时中的ID,不确定是否是这个字段,把工时ID传到添加配件的页面中,考虑能不能直接在本页面把ID传到addToBillPart函数中
    var itemId = null;
    if(row){
   	 itemId = row.id;
    }else{
        return;
    }
    var main = billForm.getData();
    var isSettle = main.isSettle||0;
    if(!main.id){
        showMsg("请选择保存工单!","S");
        return;
    }
    var status = main.status||0;
    if(status == 2){
        showMsg("本工单已完工,不能添加配件!","W");
        return;
    }
    if(isSettle == 1){
        showMsg("此单已结算,不能添加配件!","S");
        return;
    }  
    var BasicDataUrl = "/com.hsweb.RepairBusiness.ProductEntryPart.flow?token=";
    var title = "标准配件查询";
    //添加回调函数，进行显示
    nui.open({
        url: webPath + contextPath +BasicDataUrl+token,
        title: title,width: 900, height: 600,
        onload: function () {
        	var iframe = this.getIFrameEl();
            //var carVin = maintain.carVin;
            //var data = {
            //    vin:carVin
            //};
            
           /* iframe.contentWindow.setData(params,function(data,callback)
            {
            	//如果选择的是套餐，没有item属性
               if(data.item)
                {
                    var tmpItem = data.item;
                    addItem(tmpItem);
                }
                else{
                    addPackage(data,callback);
                }

            });*/ 
           iframe.contentWindow.setData(params,callback); 
        },
        ondestroy: function (action)
        {
        	        	
        }
    });
   
}

function choosePart(){//配件
    //var row = rpsItemGrid.getRowByUID(row_uid);
    //获取到工时中的ID
    var row = FItemRow||{};
    advancedMorePartWin.hide();
    var selectRow = rpsItemGrid.getSelected();
    var index = 0;
    nui.open({
		targetWindow : window,
		url : webPath + contextPath + "/com.hsweb.part.common.partSelectView.flow?token=" + token,
		title : "配件管理",
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
            iframe.contentWindow.setData(params);
		},
		ondestroy : function(action) {
            var iframe = this.getIFrameEl();
            var data = iframe.contentWindow.getData();
            data = data.part || {};
        	var name = data.name || "";
        	data = rpsItemGrid.getData();
        	var num = null;
        	for(var i = 0 , l = data.length ; i < l ; i ++){
        		if(data[i].pid == selectRow.myId){
        			num = data[i].orderIndex;
        			index = i;
        		}
        	}
        	num = parseFloat(num)+0.1;
        	num = num.toFixed(1);
        	var newRow = {
        			itemName : name,
        			itemTime : 0,
        			unitPrice : 0,
        			rate : 0,
        			subtotal : 0,
        			pid : selectRow.myId,
        			orderIndex : num
        	};
        	rpsItemGrid.addRow(newRow,index+1);
		}
	});
}

function showMorePart(row_uid){
    var row = rpsItemGrid.getRowByUID(row_uid); 
    if(FItemRow == row) {
        advancedMorePartWin.hide();
        FItemRow = {};
        return;
    }      
    FItemRow = row;    
    var atEl = rpsItemGrid._getCellEl(row,"itemName");
    advancedMorePartWin.showAtEl(atEl, {xAlign:"left",yAlign:"above"});
   	
}

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
            				subtotal : subtotal,
            				pid : 0
            				};
            	var dataAll = rpsItemGrid.getData();
            	rpsItemGrid.addRow(newRow,dataAll.length);
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
	var params = {
            serviceId : main.id,
            comp : currOrgName,
            baseUrl : baseUrl,
            type : 1,
            token : token
        };
	if(main.id){
		nui.open({
	        url: webBaseUrl +"com.hsweb.print.settlement.flow",
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
		if(main.isSettle){//已结算
			params.serviceId = main.sourceServiceId;
			nui.open({
		        url: webBaseUrl +"com.hsweb.print.settlement.flow",
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
}

function showGridMsg(serviceId){
	rpsPackageGrid.setUrl(baseUrl+"com.hsapi.repair.baseData.query.searchExpense.biz.ext");
	rpsPackageGrid.load({serviceId : serviceId,token : token});
	rpsItemGrid.setUrl(baseUrl+"com.hsapi.repair.baseData.query.searchExpense.biz.ext");
	rpsItemGrid.load({serviceId : serviceId,token : token});
}


function setInitData(params){
	if(!params.isOutBill){//未保存过一次报销单
		params.sourceServiceId = params.id;
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