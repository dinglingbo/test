var rpsItemGrid = null;
var billForm = null;
var servieTypeList = [];
var servieTypeHash = {};
var mtAdvisorIdEl = null;
var FItemRow = {};
//var advancedMorePartWin = null;
var baseUrl = apiPath + repairApi + "/";
var webBaseUrl = webPath + contextPath + "/";  

$(document).ready(function () {
	rpsItemGrid = nui.get("rpsItemGrid");
	billForm = new nui.Form("#billForm");
	mtAdvisorIdEl = nui.get("mtAdvisorId");
	//advancedMorePartWin = nui.get("advancedMorePartWin");
	initCarBrand("carBrandId",function(){
		 
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
	var itemInsert = rpsItemGrid.getChanges("added");
	var itemRemoved = rpsItemGrid.getChanges("removed");
	var itemModifiy = rpsItemGrid.getChanges("modified");
	nui.ajax({
        url: baseUrl+"com.hsapi.repair.baseData.crud.saveExpenseAccount.biz.ext",
        type: "post",
        cache: false,
        data: {
        	 maintainBill : maintainBill,
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
	
	var printUrl = "/com.hsweb.bx.quotationPrint.flow";
	if(main.id){
		print = e;
		nui.open({
	        url: webPath + contextPath+printUrl,
	        title: "打印",
			width: "100%",
			height: "100%",
	        onload: function () {
	            var iframe = this.getIFrameEl();
	           iframe.contentWindow.SetData(main.id,print,main.sourceServiceId);
	        },
	        ondestroy: function (action){
	        }
	    });
	}else{
		showMsg("请先保存工单","W");
	}
}

function showGridMsg(serviceId){
		rpsItemGrid.setUrl(baseUrl+"com.hsapi.repair.baseData.query.searchExpenseItemBill.biz.ext");
		rpsItemGrid.load({serviceId : serviceId,token : token});
}

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




