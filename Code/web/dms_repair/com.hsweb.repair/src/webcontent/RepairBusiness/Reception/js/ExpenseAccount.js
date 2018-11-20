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
		        			var remark = data[i].remark || "";
		        			var discountAmt = data[i].discountAmt || "";
		        			var backageId = 0;
		        			//表示是套餐
		        			if(data[i].billPackageId==0){
			        			 backageId = data[i].id;
		        			}
		        			var newRow = {
		        					billPackageId : billPackageId,
		        					packageName : packageName,
		        					subtotal : subtotal,
		        					rate : rate,
		        					amt : amt,
		        					orderindex : data[i].orderIndex,
		        					remark : remark,
		        					discountAmt : discountAmt,
		        					backageId : backageId
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
		        			var billItemId = data[i].billItemId;
		        			var discountAmt = data[i].discountAmt;
		        			var remark = data[i].remark;
		        			var unitPrice = data[i].unitPrice;
		        			var orderindex = data[i].orderIndex;
		        			var itemId = 0;
		        			if(data[i].billItemId == 0){
		        				itemId = data[i].id;
		        			}
		        			var newRow = {
		        					itemName : itemName,
		        					itemTime : itemTime,
		        					unitPrice : unitPrice,
		        					rate : rate,
		        					subtotal : subtotal,
		        					billItemId : billItemId,
		        					itemId : itemId,
		        					discountAmt : discountAmt,
		        					remark : remark,
		        					unitPrice : unitPrice,
		        					orderindex : orderindex
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
				rate = 100 - (parseFloat(row.subtotal)/parseFloat(row.amt/100));
				rate = rate.toFixed(2);
			}else{
				rate = 100;
			}
			;
			var newRow = {rate : rate};
			rpsPackageGrid.updateRow(row,newRow);
		}
		if(field == "rate"){
			var subtotal = null;
			if(row.rate){
				subtotal = parseFloat(row.amt) * parseFloat(100-row.rate)/100;
				subtotal = subtotal.toFixed(2);
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
			subtotal = subtotal.toFixed(2);
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
		if(field == "itemName"){
			if(row.billItemId == 0){
                e.cellHtml = '<a href="javascript:showMorePart(\'' + uid + '\')" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;配件</a>' + e.value;	
            }else{
            	e.cellHtml ='<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>' + e.value;
            }
		}
	});
});

function showBasicData(type){
    var BasicDataUrl = null;
    var title = null;
    var maintain = billForm.getData();
    if(type=="pkg"){
    	BasicDataUrl = "/com.hsweb.RepairBusiness.ProductEntryPkg.flow?token=";
    	title = "标准套餐查询";
    }
    if(type=="item"){
    	BasicDataUrl = "/com.hsweb.RepairBusiness.ProductEntryItem.flow?token=";
    	title = "标准工时查询";
    }
    
    var carVin = billForm.carVin;
    var params = {
        vin:carVin,
        serviceId:maintain.id,
        type1 : 1
    };
    nui.open({
        url: webPath + contextPath +BasicDataUrl+token,
        title: title,width: 900, height: 600,
        onload: function () {
        	var iframe = this.getIFrameEl();
            iframe.contentWindow.setData(params,""); 
        },
        ondestroy: function (action)
        {
        	var iframe = this.getIFrameEl();
            var data = iframe.contentWindow.getSelectedRow();
            var dataAll = rpsItemGrid.getData();
        	var orderindex = null;
        	for(var j = 0 , k = dataAll.length ; j < k ; j ++){
        		if(dataAll[j].pid == 0){
        			orderindex = dataAll[j].orderindex;
        		}
        	}
        	if(!orderindex){
        		orderindex = 1;
        	}else{
        		orderindex = parseInt(orderindex) + 1;
        	}
        	var newRow = {
        				itemName : data.itemName,
        				itemTime :0,
        				unitPrice : data.astandTime,
        				subtotal : 0,
        				pid : 0,
        				orderindex : orderindex
        				};
        	var dataAll = rpsItemGrid.getData();
        	rpsItemGrid.addRow(newRow,dataAll.length);
        }
    });
}

function showBasicDataPart(){
    var row = FItemRow;//rpsItemGrid.getRowByUID(row_uid);
	//获取到工时中的ID,不确定是否是这个字段,把工时ID传到添加配件的页面中,考虑能不能直接在本页面把ID传到addToBillPart函数中
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
			var orderindex = 0;
			//获取这一工时下有多少个配件
			var itemPart = rpsItemGrid.getData();
			var index = rpsItemGrid.indexOf(selectRow);
			for(var i=0;i<itemPart.length;i++){
				if(itemPart[i].billItemId == row.itemId){
					orderindex = parseInt(orderindex) + 1;
				}
			}
			if(orderindex){
				orderindex = parseInt(orderindex) + 1;
				index = parseInt(index)+parseInt(orderindex);
				orderindex = row.orderindex + "." + orderindex;
			}else{
				orderindex = row.orderindex + ".1";
				index = parseInt(index)+1;
			}		
            var iframe = this.getIFrameEl();
            var data = iframe.contentWindow.getData();
            data = data.part || {};
        	var name = data.name || "";
        	/*data = rpsItemGrid.getData();
        	
        	
        	var itemName = data.name || "";
        	var num = null;
        	for(var i = 0 , l = data.length ; i < l ; i ++){
        		if(data[i].pid == selectRow.myId){
        			num = data[i].orderindex;
        			index = i;
        		}
        	}
        	if(num){
        		num = parseFloat(num)+0.1;
            	num = num.toFixed(1);
        	}else{//没有配件 index == 0
        		num = selectRow.orderindex;
        		num = parseFloat(num)+0.1;
            	num = num.toFixed(1);
            	index = rpsItemGrid.indexOf(selectRow);
        	}*/
        	var newRow = {
        			itemName : name,
        			itemTime : 1,
        			unitPrice : 0,
        			rate : 0,
        			subtotal : 0,
        			billItemId: row.itemId,
        			orderindex : orderindex
        	};
        	rpsItemGrid.addRow(newRow,index);
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

var PackageDetailUrl = baseUrl + "repairApi/com.hsapi.repair.baseData.crud.queryPackageDetail.biz.ext";
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
            var orderindex = null;
            for(var i = 0 , l = data.length ; i < l ; i ++){
            	var id = null;
    			var packageName = data[i].name || "";
    			var subtotal = data[i].total || "";
    			var rate = 0;
    			var amt = data[i].amount || "";
    			var remark = data[i].remark || "";
    			var discountAmt = data[i].discountAmt || "";
    			var backageId = data[i].id;
   			    id = data[i].id || 0;
    			var rpsPackageGridData = rpsPackageGrid.getData();
    			
            	for(var j = 0 , k = rpsPackageGridData.length ; j < k ; j ++){
            		if(rpsPackageGridData[j].billPackageId == 0){
            			orderindex = rpsPackageGridData[j].orderindex;
            		}
            	}
            	if(!orderindex){
            		orderindex = 1;
            	}else{
            		orderindex = parseInt(orderindex) + 1;
            	}
    			var newRow = {
    					billPackageId : 0,
    					packageName : packageName,
    					subtotal : subtotal,
    					rate : rate,
    					amt : amt,
    					orderindex : orderindex,
    					remark : remark,
    					discountAmt : discountAmt,
    					backageId : backageId
    			};
    			rpsPackageGrid.addRow(newRow,rpsPackageGridData.length);
    			 //查找明细
                var package1 = {};
                package1.id = id;
                nui.ajax({
                    url:PackageDetailUrl,
                    type: "post",
                    cache: false,
                    data: {
                    	package1:package1 
                    },
                    success: function(text) {
                    	var items = text.item;
                    	for(var m = 0;m<items.length;m++){
                    		var amt =  items[m].amt;
                    		var packageName = items[m].itemName;
                    		var subtotal = items[m].trueAmt;
                    		var remark = items[m].remark;
                    		var inx = parseInt(m)+1;
                    		var orderindexs = orderindex+"."+ inx;
                    		var newRow = {
                					billPackageId : id,
                					packageName : packageName,
                					subtotal : subtotal,
                					rate : 0,
                					amt : amt,
                					orderindex : orderindexs,
                					remark : remark,
                					discountAmt : 0,
                					backageId : 0
                			};
                    		var rpsPackageGridData = rpsPackageGrid.getData();
                			rpsPackageGrid.addRow(newRow,rpsPackageGridData.length);
                        } 
                    	var parts = text.part;
                    	for(var n = 0;n<parts.length;n++){
                    		var amt =  parts[n].amt;
                    		var packageName = parts[n].partName;
                    		var subtotal = parts[n].trueAmt;
                    		var remark = parts[n].remark;
                    		var inx = parseInt(items.length)+parseInt(n)+1;
                    		var orderindexs = orderindex+"."+ inx;
                    		var newRow = {
                					billPackageId : id,
                					packageName : packageName,
                					subtotal : subtotal,
                					rate : 0,
                					amt : amt,
                					orderindex : orderindexs,
                					remark : remark,
                					discountAmt : 0,
                					backageId : 0
                			};
                    		var rpsPackageGridData = rpsPackageGrid.getData();
                			rpsPackageGrid.addRow(newRow,rpsPackageGridData.length);
                        } 
                   }
                });
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
            	var itemId = data[i].id;
            	var dataAll = rpsItemGrid.getData();
            	var orderindex = null;
            	for(var j = 0 , k = dataAll.length ; j < k ; j ++){
            		if(dataAll[j].billItemId == 0){
            			orderindex = dataAll[j].orderindex;
            		}
            	}
            	if(!orderindex){
            		orderindex = 1;
            	}else{
            		orderindex = parseInt(orderindex) + 1;
            	}
            	var newRow = {
            				itemName : itemName,
            				type : type,
            				itemTime :itemTime,
            				unitPrice : unitPrice,
            				subtotal : subtotal,
            				itemId : itemId,
            				billItemId:0,
            				orderindex : orderindex
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
	        //cache: false,
	        async: false,
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