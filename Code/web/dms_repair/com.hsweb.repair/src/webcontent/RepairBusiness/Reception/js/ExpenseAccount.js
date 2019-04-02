var rpsPackageGrid = null;
var rpsItemGrid = null;
var billForm = null;
var servieTypeList = [];
var servieTypeHash = {};
var mtAdvisorIdEl = null;
var FItemRow = {};
var sellForm = {};
//var advancedMorePartWin = null;
var baseUrl = apiPath + repairApi + "/";
var webBaseUrl = webPath + contextPath + "/";  

 
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
	sellForm = new nui.Form("#sellForm");
	rpsItemGrid = nui.get("rpsItemGrid");
	billForm = new nui.Form("#billForm");
	mtAdvisorIdEl = nui.get("mtAdvisorId");
	//advancedMorePartWin = nui.get("advancedMorePartWin");
	initServiceType("serviceTypeId",function(data) {
	    servieTypeList = nui.get("serviceTypeId").getData();
	    servieTypeList.forEach(function(v) {
	        servieTypeHash[v.id] = v;
	    });
	 });
	
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
		        			var packageId = 0;
		        			//表示是套餐
		        			if(data[i].billPackageId==0){
			        			 packageId = data[i].id;
		        			}
		        			var newRow = {
		        					billPackageId : billPackageId,
		        					packageName : packageName,
		        					subtotal : subtotal,
		        					rate : rate,
		        					amt : amt,
		        					orderIndex : data[i].orderIndex,
		        					remark : remark,
		        					discountAmt : discountAmt,
		        					packageId : packageId
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
		        			var itemTime = data[i].qty || 0;
		        			var unitPrice = data[i].unitPrice || 0;
		        			var rate = data[i].rate || "";
		        			var subtotal = data[i].subtotal || 0;
		        			var amt = data[i].amt || 0;
		        			var billItemId = data[i].billItemId;
		        			var discountAmt = data[i].discountAmt;
		        			var remark = data[i].remark;
		        			var unitPrice = data[i].unitPrice;
		        			var orderIndex = data[i].orderIndex;
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
		        					amt : amt,
		        					orderIndex : orderIndex
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
	/*rpsPackageGrid.on("cellendedit",function(e){
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
	});*/
	rpsPackageGrid.on("drawcell",function(e){
		var field = e.field,
		value = e.value;
		var record = e.record;
		var uid = record._uid;
		if(field=="packageName"){
            var billPackageId = record.billPackageId || 0;
            if(billPackageId != 0){
            	e.cellHtml ='<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>' + e.value;
            }
		}
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
			if(record.billPackageId==0){
				e.cellHtml = ' <a class="optbtn" href="javascript:deleteRowRpsPackageGrid(\'' + uid + '\')">删除</a>';
			}else{
				e.cellHtml = "--"
			}
		}
	});
	/*rpsItemGrid.on("cellendedit",function(e){
		var row = e.row,
		field = e.field;
		if(field == "itemTime" || field == "unitPrice" || field == "rate"){
			var subtotal = parseFloat(row.itemTime) * parseFloat(row.unitPrice) * parseFloat(100-row.rate) * 0.01;
			subtotal = subtotal.toFixed(2);
			var newRow = {subtotal : subtotal};
			rpsItemGrid.updateRow(row,newRow);
		}
	});*/
	rpsItemGrid.on("drawcell",function(e){
		var field = e.field,
		value = e.value,
		row = e.row;
		var record = e.record;
		var uid = record._uid;
		if(field=="itemName"){
            var billItemId = record.billItemId||0;
            if(billItemId != 0){
            	e.cellHtml ='<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>' + e.value;
            }
		}
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
			if(record.billItemId == 0){
				e.cellHtml = ' <a class="optbtn" href="javascript:deleteRowRpsItemGrid(\'' + uid + '\')">删除</a>'+'<a href="javascript:choosePart(\'' + uid + '\')" class="optbtn" ><span class="fa fa-plus"></span>&nbsp;配件</a>';
			}else{
				e.cellHtml = ' <a class="optbtn" href="javascript:deletePartRow(\'' + uid + '\')">删除</a>';
			}
			
		}
	});
});

function init(){
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
}

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
    	title = "标准项目查询";
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
        	/*var iframe = this.getIFrameEl();
            var data = iframe.contentWindow.getSelectedRow();
            var dataAll = rpsItemGrid.getData();
        	var orderIndex = null;
        	for(var j = 0 , k = dataAll.length ; j < k ; j ++){
        		if(dataAll[j].pid == 0){
        			orderIndex = dataAll[j].orderIndex;
        		}
        	}
        	if(!orderIndex){
        		orderIndex = 1;
        	}else{
        		orderIndex = parseInt(orderIndex) + 1;
        	}
        	var newRow = {
        				itemName : data.itemName,
        				itemTime :0,
        				unitPrice : data.astandTime,
        				subtotal : 0,
        				pid : 0,
        				orderIndex : orderIndex
        				};
        	var dataAll = rpsItemGrid.getData();
        	rpsItemGrid.addRow(newRow,dataAll.length);*/ 	
        	var iframe = this.getIFrameEl();
            var data = iframe.contentWindow.getSelectedRow();
            for(var i = 0 , l = data.length; i < l ; i++){
            	var itemName = data[i].name || "";
            	var type = data[i].type || "";
            	var subtotal = data[i].amt || "";
            	var itemTime = data[i].itemTime || "";
            	var unitPrice = data[i].unitPrice || "";
            	var itemId = data[i].id;
            	var dataAll = rpsItemGrid.getData();
            	var orderIndex = null;
            	for(var j = 0 , k = dataAll.length ; j < k ; j ++){
            		if(dataAll[j].billItemId == 0){
            			orderIndex = dataAll[j].orderIndex;
            		}
            	}
            	if(!orderIndex){
            		orderIndex = 1;
            	}else{
            		orderIndex = parseInt(orderIndex) + 1;
            	}
            	var newRow = {
            				itemName : itemName,
            				type : type,
            				itemTime :itemTime,
            				unitPrice : unitPrice,
            				subtotal : subtotal,
            				itemId : itemId,
            				billItemId:0,
            				orderIndex : orderIndex
            				};
            	var dataAll = rpsItemGrid.getData();
            	rpsItemGrid.addRow(newRow,dataAll.length);
            }
        	
        	
        	
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

function choosePart(row_uid){//配件
    //var row = rpsItemGrid.getRowByUID(row_uid);
    //获取到工时中的ID
    var row = rpsItemGrid.getRowByUID(row_uid);
   // advancedMorePartWin.hide();
    var selectRow = rpsItemGrid.getSelected();
    var index = 0;
    nui.open({
		// targetWindow: window,,
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
			var orderIndex = 0;
			//获取这一工时下有多少个配件
			var itemPart = rpsItemGrid.getData();
			var index = rpsItemGrid.indexOf(selectRow);
			for(var i=0;i<itemPart.length;i++){
				if(itemPart[i].billItemId == row.itemId){
					orderIndex = parseInt(orderIndex) + 1;
				}
			}
			if(orderIndex){
				orderIndex = parseInt(orderIndex) + 1;
				index = parseInt(index)+parseInt(orderIndex);
				orderIndex = row.orderIndex + "." + orderIndex;
			}else{
				orderIndex = row.orderIndex + ".1";
				index = parseInt(index)+1;
			}		
            var iframe = this.getIFrameEl();
            var data = null;
            data = iframe.contentWindow.getData();
            var falg = isEmptyObject(data);
            if(falg){
            	data = data.part;
            	var name = data.name || "";
            	var newRow = {
            			itemName : name,
            			itemTime : 1,
            			unitPrice : 0,
            			rate : 0,
            			subtotal : 0,
            			billItemId: row.itemId,
            			orderIndex : orderIndex,
            			amt:0
            	};
            	rpsItemGrid.addRow(newRow,index);
            }
		}
	});
}

function isEmptyObject (obj){
  for(var key in obj ){
	  return true;
	}
  return false;
}

/*function showMorePart(row_uid){
    var row = rpsItemGrid.getRowByUID(row_uid); 
    if(FItemRow == row) {
        advancedMorePartWin.hide();
        FItemRow = {};
        return;
    }      
    FItemRow = row;    
    var atEl = rpsItemGrid._getCellEl(row,"itemName");
    advancedMorePartWin.showAtEl(atEl, {xAlign:"left",yAlign:"above"});
   	
}*/

function deleteRowRpsPackageGrid(row_uid){
	var row = rpsPackageGrid.getRowByUID(row_uid);
	var data = rpsPackageGrid.getData();
	var orderIndex = row.orderIndex;
	var str1 = parseFloat(orderIndex) + 1;
	var index = rpsPackageGrid.indexOf(row);
	for(var i = index , l = data.length ; i < l ; i ++){
		var str = data[i].orderIndex;
		str = parseFloat(str);
		if(str<str1){
			//rpsPackageGrid.removeRow ( row, autoSelect )
			grow = rpsPackageGrid.getRow(index);
			rpsPackageGrid.removeRow(grow);
		}else{
			break;
		} 
	}
}


function deleteRowRpsItemGrid(row_uid){
	var row = rpsItemGrid.getRowByUID(row_uid);
	var data = rpsItemGrid.getData();
	var orderIndex = row.orderIndex;
	var str1 = parseFloat(orderIndex) + 1;
	var index = rpsItemGrid.indexOf(row);
	for(var i = index , l = data.length ; i < l ; i ++){
		var str = data[i].orderIndex;
		str = parseFloat(str);
		if(str<str1){
			//rpsPackageGrid.removeRow ( row, autoSelect )
			grow = rpsItemGrid.getRow(index);
			rpsItemGrid.removeRow(grow);
		}else{
			break;
		} 
	}
}

function deletePartRow(row_uid){
	var row = rpsItemGrid.getRowByUID(row_uid);
	rpsItemGrid.removeRow(row);
}


var PackageDetailUrl = baseUrl + "repairApi/com.hsapi.repair.baseData.crud.queryPackageDetail.biz.ext";
function choosePackage(){
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
            iframe.contentWindow.setValueData();
		},
		ondestroy : function(action) {
			
			var iframe = this.getIFrameEl();
            var data = iframe.contentWindow.getDataAll();
            var orderIndex = null;
            for(var i = 0 , l = data.length ; i < l ; i ++){
            	var id = null;
    			//var packageName = data[i].name || data[i].PackageName || "";
    			//var subtotal = data[i].total || data[i].packageTotal "";
            	var packageName = data[i].name ||  "";
    			var subtotal = data[i].total ||  "";
            	var rate = 0;
    			var amt = data[i].amount || "";
    			var remark = data[i].remark || "";
    			var discountAmt = data[i].discountAmt || "";
    			var packageId = data[i].id;
   			    id = data[i].id || 0;
    			var rpsPackageGridData = rpsPackageGrid.getData();
            	for(var j = 0 , k = rpsPackageGridData.length ; j < k ; j ++){
            		if(rpsPackageGridData[j].billPackageId == 0){
            			orderIndex = rpsPackageGridData[j].orderIndex;
            		}
            	}
            	if(!orderIndex){
            		orderIndex = 1;
            	}else{
            		orderIndex = parseInt(orderIndex) + 1;
            	}
    			var newRow = {
    					billPackageId : 0,
    					packageName : packageName,
    					subtotal : subtotal,
    					rate : rate,
    					amt : amt,
    					orderIndex : orderIndex,
    					remark : remark,
    					discountAmt : discountAmt,
    					packageId : packageId
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
                    		var orderIndexs = orderIndex+"."+ inx;
                    		var newRow = {
                					billPackageId : id,
                					packageName : packageName,
                					subtotal : subtotal,
                					rate : 0,
                					amt : amt,
                					orderIndex : orderIndexs,
                					remark : remark,
                					discountAmt : 0,
                					packageId : 0
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
                    		var orderIndexs = orderIndex+"."+ inx;
                    		var newRow = {
                					billPackageId : id,
                					packageName : packageName,
                					subtotal : subtotal,
                					rate : 0,
                					amt : amt,
                					orderIndex : orderIndexs,
                					remark : remark,
                					discountAmt : 0,
                					packageId : 0
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
		// targetWindow: window,,
		url : webPath + contextPath + "/com.hsweb.repair.DataBase.RepairItemMain.flow?token=" + token,
		title : "维修项目",
		width : 1000,
		height : 560,
		allowDrag : true,
		allowResize : true,
		onload : function() {
			var iframe = this.getIFrameEl();
			var params = {};
			iframe.contentWindow.setData(params);
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
            	var orderIndex = null;
            	for(var j = 0 , k = dataAll.length ; j < k ; j ++){
            		if(dataAll[j].billItemId == 0){
            			orderIndex = dataAll[j].orderIndex;
            		}
            	}
            	if(!orderIndex){
            		orderIndex = 1;
            	}else{
            		orderIndex = parseInt(orderIndex) + 1;
            	}
            	var newRow = {
            				itemName : itemName,
            				type : type,
            				itemTime :itemTime,
            				unitPrice : unitPrice,
            				subtotal : subtotal,
            				itemId : itemId,
            				billItemId:0,
            				amt:subtotal,
            				orderIndex : orderIndex
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
        	if(text.errCode=="S"){
        		nui.get("rid").setValue(text.mainId);
            	showGridMsg(text.mainId);
            	showMsg(text.errMsg,"S");
        	}else{
        		showMsg(text.errMsg,"W");
            }
        },
        error:function(jqXHR, textStatus, errorThrown) {
			nui.unmask(document.body);
			console.log(jqXHR.responseText);
		}
    });
}

function onPrint(e){
	var main = billForm.getData();
	var params = {
            serviceId : main.id,
            comp : currRepairSettorderPrintShow || currOrgName,
            type : 1,
            partApiUrl:apiPath + partApi + "/",
    		baseUrl: apiPath + repairApi + "/",
    		sysUrl: apiPath + sysApi + "/",
    		webUrl:webPath + contextPath + "/",
            bankName: currBankName,
            bankAccountNumber: currBankAccountNumber,
            currCompAddress: currCompAddress,
            currUserName :currUserName,
            currCompTel: currCompTel,
            currSlogan1: currSlogan1,
            currSlogan2: currSlogan2,
            currCompLogoPath: currCompLogoPath,
            currRepairBillMobileFlag:currRepairBillMobileFlag,
            currRepairSettPrintContent:currRepairSettPrintContent,
            currRepairEntrustPrintContent:currRepairEntrustPrintContent,
            sourceServiceId:main.sourceServiceId,
    		token : token
        };
	if(e==1 || e==3){
		params.printName = "报价单";
	}
	if(e==2 || e==4){
		params.printName = "结账单";
	}
	var url = null;
	if(e==1 || e==2){
		url = webBaseUrl +"com.hsweb.print.settlement.flow";
	}
	if(e==3 || e==4){
		url = webBaseUrl +"com.hsweb.print.settlementPart.flow";
	}
	if(main.id){
		nui.open({
	        url: url,
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
	rpsPackageGrid.setData([]);
	rpsItemGrid.setData([]);
	rpsPackageGrid.setUrl(baseUrl+"com.hsapi.repair.baseData.query.searchExpensePkgBill.biz.ext");
	rpsPackageGrid.load({serviceId : serviceId,token : token},function(e){
		rpsItemGrid.setUrl(baseUrl+"com.hsapi.repair.baseData.query.searchExpenseItemBill.biz.ext");
		rpsItemGrid.load({serviceId : serviceId,token : token});
	});

}


/*function setInitData(params){
	nui.get("sourceServiceId").setValue(params.id);
	init();
	if(!params.isOutBill){//未保存过一次报销单
		params.sourceServiceId = params.id;
		params.id = "";
		billForm.setData(params);
		//rpsPackageGrid.setData([])
		//rpsItemGrid.setData([])
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
}*/


function setInitData(params){
	nui.get("sourceServiceId").setValue(params.id);
	init();
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
        	if(list && list.length>0){
        		billForm.setData(list[0]);
        	}else{
        		params.sourceServiceId = params.id;
        		params.id = "";
        		billForm.setData(params);
        	}
        	
        }
    });
}
//oncellcommitedit="onCellCommitEditPkg"

//提交单元格编辑数据前激发
function onCellCommitEditItem(e) {
	var editor = e.editor;
	var record = e.record;
	var row = e.row;
	editor.validate();
	if (editor.isValid() == false) {
		showMsg("请输入数字!","W");
		e.cancel = true;
	} else {
		var newRow = {};
		if (e.field == "itemTime") {
			var itemTime = e.value;
			var unitPrice = record.unitPrice;
            var rate = record.rate;
            var subtotal = 0;
			if (e.value == null || e.value == '') {
				e.value = 1;
				itemTime = 1;
			} else if (e.value < 0) {
				e.value = 1;
				itemTime = 1;
			}

			var amt = itemTime * unitPrice;//toFixed(2)parseFloat
            if(rate>0){
            	rate = rate/100;
            	rate = rate.toFixed(2);
            	subtotal = amt*(1-parseFloat(rate));
            }else{
            	subtotal = amt;
            }
			newRow = {
				amt : amt,
				subtotal:subtotal
			};
			rpsItemGrid.updateRow(e.row, newRow);

			// record.enteramt.cellHtml = enterqty * enterprice;
		} else if (e.field == "unitPrice") {
			var itemTime = record.itemTime;
			var unitPrice = e.value;
			var rate = record.rate;
            var subtotal = 0;
			if (e.value == null || e.value == '') {
				e.value = 0;
				unitPrice = 0;
			} else if (e.value < 0) {
				e.value = 0;
				unitPrice = 0;
			}

			var amt = itemTime * unitPrice;
			if(rate>0){
            	rate = rate/100;
            	rate = rate.toFixed(2);
            	subtotal = amt*(1-parseFloat(rate));
            }else{
            	subtotal = amt;
            }
			newRow = {
				amt : amt,
				subtotal:subtotal
			};
			rpsItemGrid.updateRow(e.row, newRow);		

		} else if (e.field == "rate") {
			var itemTime = record.itemTime;
			var unitPrice = record.unitPrice;
			var rate = e.value;
            var amt = 0;
            var subtotal = 0;
			if (e.value == null || e.value == '') {
				e.value = 0;
				rate = 0;
			} else if (e.value < 0) {
				e.value = 0;
				rate = 0;
			}
            if(itemTime>0 && unitPrice>0){
            	amt = itemTime*unitPrice;
            	rate = rate/100;
            	rate = rate.toFixed(2);
            	subtotal = amt*(1-parseFloat(rate));
            }
            newRow = {
    				amt : amt,
    				subtotal:subtotal
    		};
			
            rpsItemGrid.updateRow(e.row, newRow);
		} 		
	}
}


function onCellCommitEditPkg(e) {
	var editor = e.editor;
	var record = e.record;
	var row = e.row;
	editor.validate();
	if (editor.isValid() == false) {
		showMsg("请输入数字!","W");
		e.cancel = true;
	} else {
		var newRow = {};
		if (e.field == "subtotal") {
			var subtotal = e.value;
            var rate = 0;
            var amt = record.amt;
			if (e.value == null || e.value == '') {
				e.value = 1;
				subtotal = 1;
			} else if (e.value < 0) {
				e.value = 1;
				subtotal = 1;
			}
			if(amt){
				rate = 100 - (parseFloat(subtotal)/parseFloat(amt/100));
				rate = rate.toFixed(2);
			}else{
				rate = 100;
			};
			var newRow = {rate : rate};
			rpsPackageGrid.updateRow(row,newRow);
			// record.enteramt.cellHtml = enterqty * enterprice;
		} else if (e.field == "rate") {
			var rate = e.value;
			var amt = record.amt;
			var subtotal = 0;
			if (e.value == null || e.value == '') {
				e.value = 0;
				rate = 0;
			} else if (e.value < 0) {
				e.value = 0;
				rate = 0;
			}
			if(row.rate){
				subtotal = parseFloat(amt) * parseFloat(100-rate)/100;
				subtotal = subtotal.toFixed(2);
			}else{
				subtotal = 0;
			}
			var newRow = {subtotal : subtotal};
			rpsPackageGrid.updateRow(row,newRow);

		} 
	}
}


function onDrawSummaryCellPack(e){ 	
	  var data = sellForm.getData();
	  var rows = e.data;
	  /*var pkgTotalAmt = 0;
	  var pkgTotalPrefAmt = 0;*/
	  var pkgSubtotal = 0;
	  var sumPkgAmt = 0;
	  if(e.field == "subtotal") 
	  {   
		  for (var i = 0; i < rows.length; i++)
		  {
			  if(rows[i].billPackageId=="0"){
				  pkgSubtotal += parseFloat(rows[i].subtotal);
				 // pkgTotalAmt  += parseFloat(rows[i].amt);
				 
			  }
		  }
		 /* pkgTotalPrefAmt =  pkgTotalAmt - pkgTotalSubtotal;
		  pkgTotalPrefAmt = pkgTotalPrefAmt.toFixed(2);*/
		  
		  /*data.pkgTotalPrefAmt = pkgTotalPrefAmt;
		  data.pkgTotalAmt = pkgTotalAmt;*/
		  pkgSubtotal = pkgSubtotal.toFixed(2);
		  data.pkgSubtotal = pkgSubtotal;
		  var total = parseFloat(data.pkgSubtotal) + parseFloat(data.itemSubtotal)+parseFloat(data.partSubtotal);
		  total = total.toFixed(2);
		  data.totalAmt = total;
		  sellForm.setData(data);
	  }
}

function onDrawSummaryCellItem(e){
	  var rows = e.data;
	  var data = sellForm.getData();
	  /*var itemTotalAmt = 0;
	  var itemTotalPrefAmt = 0;*/
	  var itemSubtotal = 0;

	 /* var partTotalAmt = 0;
	  var partTotalPrefAmt = 0;*/
	  var partSubtotal = 0;
	  if(e.field == "subtotal") 
	  {   
		  for (var i = 0; i < rows.length; i++)
		  {
			 if(rows[i].billItemId=="0"){
				 itemSubtotal += parseFloat(rows[i].subtotal);
				 //itemTotalAmt  += parseFloat(rows[i].amt); 
			 }else{
				 partSubtotal += parseFloat(rows[i].subtotal);
				 //partTotalPrefAmt  += parseFloat(rows[i].amt); 
			 }
			 
			/* itemTotalPrefAmt = itemTotalAmt - itemTotalSubtotal;
			 itemTotalPrefAmt = itemTotalPrefAmt.toFixed(2);
			
			 partTotalPrefAmt = partTotalAmt - partTotalSubtotal;
			 partTotalPrefAmt = partTotalPrefAmt.toFixed(2);*/
			 
			   
		  }
		  itemSubtotal = itemSubtotal.toFixed(2);
		  data.itemSubtotal = itemSubtotal;
		  partSubtotal = partSubtotal.toFixed(2);
		  data.partSubtotal = partSubtotal;
		  var total = parseFloat(data.pkgSubtotal) + parseFloat(data.itemSubtotal)+parseFloat(data.partSubtotal);
		  total = total.toFixed(2);
		  data.totalAmt = total;
		  sellForm.setData(data);
	  }
}







