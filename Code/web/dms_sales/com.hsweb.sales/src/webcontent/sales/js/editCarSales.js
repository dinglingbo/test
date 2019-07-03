var webBaseUrl = webPath + contextPath + "/";
//var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var baseUrl = apiPath + saleApi + "/"; 
var billForm = null;
var jpGrid = null;
var frmUrl =  apiPath + frmApi + "/";
var repairUrl = apiPath + repairApi + "/";
var jpUrl = baseUrl + "com.hsapi.sales.svr.search.searchCsbGiftMsg.biz.ext";
var jpDetailGrid = null;
var jpDetailGridUrl = baseUrl + "com.hsapi.sales.svr.search.searchSaleGiftApply.biz.ext";
var queryUrl = frmUrl + "com.hsapi.frm.frmService.crud.queryFibInComeExpenses.biz.ext";
var costGrid = null;
var costDetailGrid = null;
var costDetailGrid2 = null;
var costDetailGridUrl = baseUrl + "com.hsapi.sales.svr.search.searchSaleCostList.biz.ext";
var form = null;
var is_not = [{ id: 0, text: '未审' }, { id: 1, text: '已审' }];
var insuranceForm = null;
var detailGrid = null;
var searchKeyEl = null;
var searchNameEl = null;
var detailGridUrl = repairUrl + "com.hsapi.repair.repairService.insurance.queryRpsInsuranceDetailList.biz.ext";
var guestInfoUrl = baseUrl + "com.hsapi.sales.svr.search.searchGuest.biz.ext";
var settleTypeIdList = [{ id: 1, name: "保司直收" }, { id: 2, name: "门店代收全款" }, { id: 3, name: "代收减返点" }];
var costList = [{ id: 0, name: "免费" }, { id: 1, name: "收费" }];

$(document).ready(function(v) {

    document.getElementById("caCalculation").src = webBaseUrl + "sales/sales/caCalculation.jsp";
    billForm = new nui.Form("#billForm");
    form = new nui.Form("#form1");
    insuranceForm = new nui.Form("#insuranceForm");
    var fields = insuranceForm.getFields();
    for (var i = 0, l = fields.length; i < l; i++) {
        var c = fields[i];
        if (c.setReadOnly) c.setReadOnly(true); //只读
        if (c.setIsValid) c.setIsValid(true); //去除错误提示
    };
    detailGrid = nui.get("detailGrid");
    detailGrid.setReadOnly(true);
    detailGrid.setUrl(detailGridUrl);

    jpGrid = nui.get("jpGrid");
    jpGrid.setUrl(jpUrl);
    
    jpDetailGrid = nui.get("jpDetailGrid");
    jpDetailGrid.setUrl(jpDetailGridUrl);

    costGrid = nui.get("costGrid");
    costGrid.setUrl(queryUrl);
    var params = { isSale: 1 };
    costGrid.load({ params: params,token:token},function(){
    	
    });

    costDetailGrid = nui.get("costDetailGrid");
    costDetailGrid2 = nui.get("costDetailGrid2");
    costDetailGrid.setUrl(costDetailGridUrl);
    costDetailGrid2.setUrl(costDetailGridUrl);
     
    jpGrid.load();
    jpGrid.on("select", function(e) {
        selectJPGrid();
    });

    jpGrid.on("deselect", function(e) {
        selectJPGrid();
    });

    jpGrid.on("load", function(e) {
        var data = jpDetailGrid.getData();
        var data1 = jpGrid.getData();
        for (var i = 0, l = data.length; i < l; i++) {
            for (var j = 0, k = data1.length; j < k; j++) {
                if (data[i].giftId == data1[j].id) {
                    var row = jpGrid.getRow(j);
                    jpGrid.select(row, false);
                };
            };
        };
    });

    jpDetailGrid.on("drawcell", function(e) {
        var field = e.field;
        if (field == "receType") {
            if (e.value == 0 || e.value == 1) {
               // e.cellHtml = costList.find((costList > costList.id == e.value) || (costList == (costList.id == e.value))).name;
            	e.cellHtml = costList.find(costList => costList.id == e.value).name;
            }
        }
    });

    jpDetailGrid.on("load", function(e) {
        var data = jpDetailGrid.getData();
        var data1 = jpGrid.getData();
        for (var i = 0, l = data.length; i < l; i++) {
            for (var j = 0, k = data1.length; j < k; j++) {
                if (data[i].giftId == data1[j].id) {
                    var row = jpGrid.getRow(j);
                    jpGrid.select(row, false);
                };
            };
        };
    });

    jpDetailGrid.on("cellendedit", function(e) {
        var row = e.row,
        field = e.field;
        if (field == "price" || field == "qty" ) {
            var price = row.price || 0;
            var qty = row.qty || 0;
            var value = (price * qty).toFixed(2);
            var newRow = { amt: value };
            jpDetailGrid.updateRow(row, newRow);
            //编辑完成后调用购车计算表将精品加装金额赋值上去
            var data = jpDetailGrid.getData();
            var decrAmt = 0;
            var amt = 0;
            for (var i = 0, l = data.length; i < l; i++) {
                if (data[i].receType == 1) {
                	amt = data[i].amt || 0;
                    decrAmt = parseFloat(decrAmt) + parseFloat(amt);
                    decrAmt.toFixed(2);
                    
                }
            }
           document.getElementById("caCalculation").contentWindow.setDecrAmt(decrAmt);
           //dataF.decrAmt = decrAmt;
        };
        if(field == "receType"){
        	var data = jpDetailGrid.getData();
        	var decrAmt = 0;
        	var amt = 0;
            for (var i = 0, l = data.length; i < l; i++) {
                if (data[i].receType == 1) {
                	amt = data[i].amt || 0;
                    decrAmt = parseFloat(decrAmt) + parseFloat(amt);
                    decrAmt.toFixed(2);
                }
            }
            document.getElementById("caCalculation").contentWindow.setDecrAmt(decrAmt);
            //dataF.decrAmt = decrAmt;
        }
    });

    jpGrid.on("beforedeselect", function(e) {
        var billFormData = billForm.getData(true); //主表信息
        if (billFormData.status != 0) {
            e.cancel = true;
        }
    });

    jpGrid.on("beforeselect", function(e) {
        var billFormData = billForm.getData(true); //主表信息
        if (billFormData.status != 0) {
            e.cancel = true;
        }
    });

    costGrid.on("load", function(e) {
        var data = costGrid.getData();
        var data1 = costDetailGrid.getData();
        var data2 = costDetailGrid2.getData();
        var arr = data1.concat(data2);
        if (arr.length > 0 && data.length > 0) {
            for (var i = 0, l = data.length; i < l; i++) {
                for (var j = 0, k = arr.length; j < k; j++) {
                    if (data[i].id == arr[j].costId) {
                        var row = costGrid.getRow(j);
                        costGrid.select(row, false);
                    };
                };
            };
        };
    });

    //已经审核的费用不能删除
   /* costGrid.on("beforedeselect", function(e) {
    	 var billFormData = billForm.getData(true); //主表信息
         if (billFormData.status != 0 && billFormData.status != 3) {
         	e.cancel = true;
         }
    });

    costGrid.on("beforeselect", function(e) {
        var billFormData = billForm.getData(true); //主表信息
        if (billFormData.status != 0 && billFormData.status != 3) {
        	e.cancel = true;
        }
    });*/

    costDetailGrid.on("load", function(e) {
        var costData = costGrid.getData();
        var data = costDetailGrid.getData();
        if (costData.length > 0 && data.length > 0) {
            for (var i = 0, l = data.length; i < l; i++) {
                for (var j = 0, k = costData.length; j < k; j++) {
                    if (data[i].costId == costData[j].id) {
                        var row = costGrid.getRow(j);
                        costGrid.select(row, false);
                    };
                };
            };
        };
    });

    costDetailGrid.on("drawcell", function(e) {
        var field = e.field;
        var row = e.row;
        if (field == "action") {
            if (nui.get("typeMsg").value == 2) {
                if (row.auditSign == 0) {
                    e.cellHtml = '<a class="optbtn" iconCls="" onclick="checkCost(costDetailGrid,1)"><span class="fa fa-check fa-lg"></span>&nbsp;审核</a>';
                } else {
                    e.cellHtml = '<a class="optbtn" iconCls="" onclick="checkCost(costDetailGrid,0)"><span class="fa fa-close fa-lg"></span>&nbsp;反审</a>';
                }
            }
        }
    });

    costDetailGrid2.on("drawcell", function(e) {
        var field = e.field;
        var row = e.row;
        if (field == "action") {
            if (nui.get("typeMsg").value == 2) {
                if (row.auditSign == 0) {
                    e.cellHtml = '<a class="optbtn" iconCls="" onclick="checkCost(costDetailGrid2,1)"><span class="fa fa-check fa-lg"></span>&nbsp;审核</a>';
                } else {
                    e.cellHtml = '<a class="optbtn" iconCls="" onclick="checkCost(costDetailGrid2,0)"><span class="fa fa-close fa-lg"></span>&nbsp;反审</a>';
                }
            }
        }
    });

    costDetailGrid2.on("load", function(e) {
        var costData = costGrid.getData();
        var data = costDetailGrid2.getData();
        if (costData.length > 0 && data.length > 0) {
            for (var i = 0, l = data.length; i < l; i++) {
                for (var j = 0, k = costData.length; j < k; j++) {
                    if (data[i].costId == costData[j].id) {
                        var row = costGrid.getRow(j);
                        costGrid.select(row, false);
                    };
                };
            };
        };
    });

    //在编辑销售管理中，费用信息没有审核之前不能编辑，并且交车过后也不能编辑。已经审核的费用也不能编辑
    //行取消选中前发生
    costGrid.on("beforedeselect", function(e) {
    	var row = e.record;
        var billFormData = billForm.getData(true); //主表信息，交车之后都不能编辑
        if (billFormData.isSubmitCar != 1 ) {
            if (billFormData.status == 2 && nui.get("typeMsg").value == 1) {
            	var data1 = costDetailGrid.getData();
                var data2 = costDetailGrid2.getData();
                var arr = data1.concat(data2);
                if (arr.length > 0) {
                    for (var i = 0, l = arr.length; i < l; i++) {
                    	var temp = arr[i]
                        if (row.id == temp.costId) {
                        	if(temp.auditSign == 1){
                        		e.cancel = true;
                        		break;
                        	}else{
                        		e.cancel = false;
                        		break;
                        	}
                        };
                    };
                };
            } else {
                e.cancel = true;
            }
        }else {
            e.cancel = true;
        }
        
    });
  
    costGrid.on("beforeselect", function(e) {
    	var row = e.record;
        var billFormData = billForm.getData(true); //主表信息
        if (billFormData.isSubmitCar != 1) {
            if (billFormData.status == 2 && nui.get("typeMsg").value == 1) {
            	var data1 = costDetailGrid.getData();
                var data2 = costDetailGrid2.getData();
                var arr = data1.concat(data2);
                if (arr.length > 0) {
                    for (var i = 0, l = arr.length; i < l; i++) {
                    	var temp = arr[i]
                        if (row.id == temp.costId) {
                        	if(temp.auditSign == 1){
                        		e.cancel = true;
                        		break;
                        	}else{
                        		e.cancel = false;
                        	}
                        };
                    };
                };
            } else {
                e.cancel = true;
            }
        }else {
            e.cancel = true;
        }
    });

    //行取消选中时发生
    costGrid.on("deselect", function(e) {
        selectCostGrid();
    });
    costGrid.on("select", function(e) {
        selectCostGrid();
    });

    

    var dictDefs = { "billTypeId": "DDT20130703000008", "saleType": 10392 };
    initDicts(dictDefs, function() {});

    initMember("saleAdvisorId", function() {
        nui.get("saleAdvisorId").setValue(currEmpId);
        nui.get("saleAdvisorId").setText(currUserName);
        var data = nui.get("saleAdvisorId").getData();
        nui.get("submitCarMen").setData(data);
        nui.get("saleManIds").setData(data);
    });

    searchKeyEl = nui.get("search_key");
    searchNameEl = nui.get("search_name");
    searchKeyEl.setUrl(guestInfoUrl);

    searchKeyEl.on("beforeload", function(e) {
    	var data = billForm.getData();
    	if(!data.id){
    		if(typeF==1){
    			typeF = 0;
    			document.getElementById("caCalculation").contentWindow.setEmpty();
    		}
    	}
        var data = {};
        var params = {};
        var value = e.data.key;
        value = value.replace(/\s+/g, "");
        params.isDisabled = 0;
        if (value.length < 2) {
            e.cancel = true;
            return;
        } else {
            var reg = /^[0-9]*$/; //纯数字
            if (reg.test(value)) {
                params.mobile = value;

                data.params = params;
                e.data = data;
                return;
            }
            //包含中文
            var reg = /[\u4E00-\u9FA5\uF900-\uFA2D]/;
            if (reg.test(value)) {
                params.fullName = value;

                data.params = params;
                e.data = data;
                return;
            }
        }

    });

    searchKeyEl.on("itemclick", function(e) {
        var item = e.item;
        if(item){
        	 var fullName = item.fullName || "";
             var mobile = item.mobile || "";
             var msg = fullName + "/" + mobile
             if (fullName && mobile) {
                 searchNameEl.setValue(msg);
             }
             if (fullName && !mobile) {
                 searchNameEl.setValue(fullName);
             }
             if (mobile && !fullName) {
                 searchNameEl.setValue(mobile);
             }
             searchNameEl.setEnabled(false);
             searchNameEl.setVisible(true);
             var sk = document.getElementById("search_key");
             sk.style.display = "none";
             var billFormData = billForm.getData(true); //主表信息
             billFormData.guestId = item.id;
             billFormData.guestFullName = item.fullName;
             billFormData.contactor = item.fullName;
             billFormData.contactorTel = item.mobile;
             billForm.setData(billFormData);
        }
       
    });
    
    searchKeyEl.on("valuechanged",function(e){
    	var item = e.item;
    	if(item){
       	    var fullName = item.fullName || "";
            var mobile = item.mobile || "";
            var msg = fullName + "/" + mobile
            if (fullName && mobile) {
                searchNameEl.setValue(msg);
            }
            if (fullName && !mobile) {
                searchNameEl.setValue(fullName);
            }
            if (mobile && !fullName) {
                searchNameEl.setValue(mobile);
            }
            searchNameEl.setEnabled(false);
            searchNameEl.setVisible(true);
            var sk = document.getElementById("search_key");
            sk.style.display = "none";
            var billFormData = billForm.getData(true); //主表信息
            billFormData.guestId = item.id;
            billFormData.guestFullName = item.fullName;
            billFormData.contactor = item.fullName;
            billFormData.contactorTel = item.mobile;
            billForm.setData(billFormData);
       }
    });
    
    //document.getElementById("showA1").style.display = "";
	document.getElementById("repairStatus").style.display='none';
});

function checkMsg(e) { //统一数据验证  
    //0为草稿  1为提交  2为审核  3为作废  11为返单    
    //4为结案按钮  5为费用信息保存 6为交车按钮 7为费用信息审核反审 8为车辆上牌  9为选车
    var boolean = false;
    isTabs = 0;
    var billFormData = billForm.getData(true); //主表信息
   /* if (billFormData.id) {
    	if(e!=6 && e!=4){
    		searchSalesMain(billFormData.id, 1);
    	}
    }*/
    if (billFormData.status == 3) {
        showMsg("当前工单已作废！", "W");
        return boolean;
    }
    if (!billFormData.guestId) {
        showMsg("客户信息不能为空！", "W");
        return boolean;
    }
    if (billFormData.isSettle == 1) {
        showMsg("当前工单已结算！", "W");
        return;
    }
    var params = document.getElementById("caCalculation").contentWindow.getValue(); //购车信息
    if (params.isValid == false) {
        showMsg("购车信息填写有误，请检查后再保存", "W");
        return boolean;
    }
    var caCalculationData = params.data;
    if (parseFloat(caCalculationData.saleAmt) < parseFloat(caCalculationData.advanceChargeAmt)) {
        showMsg("预付款不能大于车型销价", "W");
        return boolean;
    }
    if (caCalculationData.saleType == "" || caCalculationData.saleType == null) {
        showMsg("请选择购车计算表中的购车方式后再保存", "W");
        return boolean;
    }

    if (e == 1 && nui.get("carModelName").value == "") {
        showMsg("意向车型尚未选择！", "W");
        return boolean;
    }
    if (e == 2 && billFormData.status == 2) {
        showMsg("当前工单已审核！", "W");
        return boolean;
    }
    if (e == 3) {
        if (billFormData.status == "") {
            showMsg("当前工单尚未保存，无需作废！", "W");
            return boolean;
        }
        if (billFormData.status != 0) {
            showMsg("请返单后再作废！", "W");
            return boolean;
        }
    }
    if (e == 4) {
        if (!billFormData.enterId || billFormData.enterId == 0) {
            showMsg("当前工单尚未选车！", "W");
            return boolean;
        }
    }
    if (e == 6) {
        if (nui.get("submitTrueDate").value == "") {
            showMsg("请填写交车时间后再进行交车！", "W");
            return boolean;
        }
        if (form.isValid() == false) {
            showMsg("交车信息有误，请检查后再保存！", "W");
            return boolean;
        }
    }
    if (e == 5 || e == 6 || e == 7 || e == 9) {
        if (billFormData.status != 2) {
            showMsg("当前工单尚未审核！", "W");
            return boolean;
        }
        if (billFormData.isSubmitCar == 1) {
            showMsg("当前工单已交车！", "W");
            return boolean;
        }
    }
    if (e == 9) {
        if (billFormData.enterId != 0) {
            showMsg("当前工单已选车！", "W");
            return boolean;
        }
    }
    return true;
}

//草稿和提交调用该方法(草稿和提交可以改变主表信息、精品信息、购车预算)
function save(e) { //保存（主表信息+精品加装+购车信息+费用信息）
	if(isTabs==1){
    	isTabs = 0;
	    changeValueMsg(1);
	    document.getElementById("caCalculation").contentWindow.setSelectCarValue(dataF.handcartAmt, dataF.carCost);
	    document.getElementById("caCalculation").contentWindow.SetDataMsg(dataF.id, dataF.frameColorId, dataF.interialColorId); //查询购车计算表，如果购车计算表车身颜色和内饰颜色为空，则将主表信息赋值上去
	    document.getElementById("caCalculation").contentWindow.setReadOnlyMsg();
    }
	var boolean = checkMsg(e);
    if (!boolean) {
        return;
    }
    var billFormData = billForm.getData(true); //主表信息
   
    if (e == 0) {
        billFormData.enterId = 0;
        billFormData.isSubmitCar = 0;
        billFormData.isSettle = 0;
    }
    var params = document.getElementById("caCalculation").contentWindow.getValue(); //购车信息
    var caCalculationData = params.data;
    var jpDetailGridAdd = jpDetailGrid.getChanges("added"); //精品加装
    var jpDetailGridEdit = jpDetailGrid.getChanges("modified");
    var jpDetailGridDel = jpDetailGrid.getChanges("removed");
    
    //判断jpDetailGridAdd,jpDetailGridDel里面有没有已存在的值
	   if(giftData.length>0 && jpDetailGridAdd.length>0){
	       for(var i = 0;i<giftData.length;i++){
	           var old = giftData[i];
	           for(var j = 0;j<jpDetailGridAdd.length;j++){
	               var add = jpDetailGridAdd[j];
	               if(old.giftId == add.giftId){
	                   var updat = add;
	                   updat.id = old.id;
	                   updat.serviceId = old.serviceId;
	                   jpDetailGridEdit.push(updat);
	                   for(var n = 0;n<jpDetailGridDel.length;n++){
	                        var del = jpDetailGridDel[n];
	                       if(del.giftId == old.giftId){
	                         // delete jpDetailGridDel[n];
	                         jpDetailGridDel.splice(n,1);
	                       }
	                   }
	                    jpDetailGridAdd.splice(j,1);
	               }
	           }
	           
	       }
    }	
    
    caCalculationData.billType = 2;
    var saleExtend = caCalculationData;
    //agentGrossProfit:保险毛利
    if (nui.get("agentGrossProfit").value != "") {
        saleExtend.agentGrossProfit = parseFloat(nui.get("agentGrossProfit").value);
    } else {
        saleExtend.agentGrossProfit = 0;
    }
    billFormData.saleAdvisor = nui.get("saleAdvisorId").text;
    billFormData.status = e; //0 草稿 、1提交（待审）、2已审、3作废
    
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });
    nui.ajax({
        url: baseUrl + "com.hsapi.sales.svr.save.saveSaleMainAll.biz.ext",
        data: {
            billFormData: billFormData,
            caCalculationData: caCalculationData,
            jpDetailGridAdd: jpDetailGridAdd,
            jpDetailGridEdit: jpDetailGridEdit,
            jpDetailGridDel: jpDetailGridDel,
            saleExtend: saleExtend
        },
        cache: false,
        async: false,
        success: function(text ) {
            if (text.errCode == "S") {
                var serviceId = text.serviceId;
                var data = text.billFormData;
                dataF = text.billFormData;
                billForm.setData(data);
                $("#servieIdEl").html(data.serviceCode);
                document.getElementById("caCalculation").contentWindow.SetDataMsg(serviceId);
               // searchSalesMain(serviceId, 0);
                jpDetailGrid.load({ billType: 2, serviceId: serviceId },function(){
                	giftData = jpDetailGrid.getData();
                });
                costDetailGrid.load({ serviceId: serviceId, type: 1 });
                costDetailGrid2.load({ serviceId: serviceId, type: 2 });
                changeValueMsg(1);
                nui.get("carModelName").setValue(data.carModelName);
                nui.get("carModelName").setText(data.carModelName);
               
               if (data.status != 0) {
                  nui.get("saveBtn").disable();
                  nui.get("submitBtn").disable();
                  setReadOnlyMsg();
                  document.getElementById("caCalculation").contentWindow.setReadOnlyMsg();
              } else {
                 nui.get("saveBtn").enable();
                 nui.get("submitBtn").enable();
                 setInputModel();
                 document.getElementById("caCalculation").contentWindow.setInputModel();
            }
             if(data.guestId) {
            	 if(data.enterId !=0 ){
            		 insuranceMsg(data.guestId,data.enterId);
            	 }
             }
             setReadOnlySubmitCar(1);
             var msg = (data.contactor || "") + "/" + (data.contactorTel || "");
             if(data.contactor && data.contactorTel) {
                searchNameEl.setValue(msg);
             }
             if(!data.contactor && data.contactorTel) {
                searchNameEl.setValue(data.contactorTel);
            }
            if(data.contactor && !data.contactorTel) {
                searchNameEl.setValue(data.contactor);
             }
            searchNameEl.setEnabled(false);
            searchNameEl.setVisible(true);
            var sk = document.getElementById("search_key");
            sk.style.display = "none";
            doSetStyle(data);          
           // showMsg(text.errMsg, "S");
            if(e==0){
            	showMsg("保存成功", "S");
            }else{
            	showMsg("提交成功", "S");
            }
            nui.unmask(document.body);
            } else {
                showMsg(text.errMsg, "E");
                nui.unmask(document.body);
            }
        }
    });
}
   
function save2(e) { //保存（主表信息+精品加装+购车信息+费用信息）
	if(isTabs==1){
    	isTabs = 0;
	    changeValueMsg(1);
	    document.getElementById("caCalculation").contentWindow.setSelectCarValue(dataF.handcartAmt, dataF.carCost);
	    document.getElementById("caCalculation").contentWindow.SetDataMsg(dataF.id, dataF.frameColorId, dataF.interialColorId); //查询购车计算表，如果购车计算表车身颜色和内饰颜色为空，则将主表信息赋值上去
	    document.getElementById("caCalculation").contentWindow.setReadOnlyMsg();
    }
    if (e != 10) { //关闭选车界面后，不再刷新表格，因为选车后enterId还没保存到主表，刷新后enterId为0
        var boolean = checkMsg(e);
        if (!boolean) {
            return;
        }
    }
    var billFormData = billForm.getData(true); //主表信息
    if (e == 9 || e == 10) {
        e = 2;
    }
    if (e == 0) {
        if (billFormData.enterId != 0 && billFormData.enterId != "") {
            updateCheckEnter(billFormData.enterId);
        }
        billFormData.enterId = 0;
        billFormData.isSubmitCar = 0;
        billFormData.isSettle = 0;
    }
    var params = document.getElementById("caCalculation").contentWindow.getValue(); //购车信息
    var caCalculationData = params.data;
    var jpDetailGridAdd = jpDetailGrid.getChanges("added"); //精品加装
    var jpDetailGridEdit = jpDetailGrid.getChanges("modified");
    var jpDetailGridDel = jpDetailGrid.getChanges("removed");
    
    //判断jpDetailGridAdd,jpDetailGridDel里面有没有已存在的值
	   if(giftData.length>0 && jpDetailGridAdd.length>0){
	       for(var i = 0;i<giftData.length;i++){
	           var old = giftData[i];
	           for(var j = 0;j<jpDetailGridAdd.length;j++){
	               var add = jpDetailGridAdd[j];
	               if(old.giftId == add.giftId){
	                   var updat = add;
	                   updat.id = old.id;
	                   updat.serviceId = old.serviceId;
	                   jpDetailGridEdit.push(updat);
	                   for(var n = 0;n<jpDetailGridDel.length;n++){
	                        var del = jpDetailGridDel[n];
	                       if(del.giftId == old.giftId){
	                         // delete jpDetailGridDel[n];
	                         jpDetailGridDel.splice(n,1);
	                       }
	                   }
	                    jpDetailGridAdd.splice(j,1);
	               }
	           }
	           
	       }
    }	
    
    caCalculationData.billType = 2;
    var saleExtend = caCalculationData;
    if (nui.get("agentGrossProfit").value != "") {
        saleExtend.agentGrossProfit = parseFloat(nui.get("agentGrossProfit").value);
    } else {
        saleExtend.agentGrossProfit = 0;
    }
    billFormData.saleAdvisor = nui.get("saleAdvisorId").text;
    billFormData.status = e; //0 草稿 、1提交（待审）、2已审、3作废
    if (e == 6) {
        billFormData.status = 2;
        var formData = form.getData();
        billFormData.submitCarMen = formData.submitCarMen;
        billFormData.submitTrueDate = formData.submitTrueDate;
        billFormData.submitCarKeyQty = formData.submitCarKeyQty;
        billFormData.submitCarRemark = formData.submitCarRemark;
        billFormData.isSubmitCar = 1;
        saleExtend.handcartAmt = billFormData.handcartAmt;
        saleExtend.carCost = billFormData.carCost;
    }
    var addMsg = costDetailGrid.getChanges("added");
    var editMsg = costDetailGrid.getChanges("modified");
    var deleteMsg = costDetailGrid.getChanges("removed");
    var addMs2 = costDetailGrid2.getChanges("added");
    var editMsg2 = costDetailGrid2.getChanges("modified");
    var deleteMsg2 = costDetailGrid2.getChanges("removed");
    var addArr = addMsg.concat(addMs2);
    var editArr = editMsg.concat(editMsg2);
    var deleteArr = deleteMsg.concat(deleteMsg2);
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });
    if (e == 11) {
        nui.ajax({
            url: baseUrl + "com.hsapi.sales.svr.save.backSingle.biz.ext",
            data: {
                data: billFormData
            },
            cache: false,
            async: false,
            success: function(text) {
                if (text.errCode == "E") {
                    showMsg(text.errMsg, "E");
                    nui.unmask(document.body);
                    return;
                };
            }
        });
        billFormData.status = 0;
        billFormData.isSubmitCar = 0;
        billFormData.enterId = 0;
    }
    nui.ajax({
        url: baseUrl + "com.hsapi.sales.svr.save.saveSaleMainAll.biz.ext",
        data: {
            billFormData: billFormData,
            caCalculationData: caCalculationData,
            jpDetailGridAdd: jpDetailGridAdd,
            jpDetailGridEdit: jpDetailGridEdit,
            jpDetailGridDel: jpDetailGridDel,
            saleExtend: saleExtend,
            addArr: addArr,
            editArr: editArr,
            deleteArr: deleteArr
        },
        cache: false,
        async: false,
        success: function(text) {
            if (text.errCode == "S") {
                var serviceId = text.serviceId;
                document.getElementById("caCalculation").contentWindow.SetDataMsg(serviceId);
                searchSalesMain(serviceId, 0);
                jpDetailGrid.load({ billType: 2, serviceId: serviceId },function(){
                	giftData = jpDetailGrid.getData();
                });
                costDetailGrid.load({ serviceId: serviceId, type: 1 });
                costDetailGrid2.load({ serviceId: serviceId, type: 2 });
                if (e == 2) {
                    var billFormData = billForm.getData(true); //主表信息
                    var params = document.getElementById("caCalculation").contentWindow.getValue(); //购车信息
                    var caCalculationData = params.data;
                    showAdvanceChargeAmt(billFormData, caCalculationData);
                    
                }
                showMsg(text.errMsg, "S");
                nui.unmask(document.body);

            } else {
                showMsg(text.errMsg, "E");
                nui.unmask(document.body);
            }
        }
    });
}





function showAdvanceChargeAmt(billFormData, caCalculationData) {
    nui.ajax({
        url: baseUrl + "com.hsapi.sales.svr.save.generatingAdvancePayment.biz.ext",
        data: {
            billFormData: billFormData,
            caCalculationData: caCalculationData
        },
        cache: false,
        async: false,
        success: function(text) {
            if (text.errCode == "S") {
                showMsg(text.errMsg, "S");
            } else {
                showMsg(text.errMsg, "W");
            };
        }
    });
}

function costMsg() { //保存费用信息
	if(isTabs==1){
    	isTabs = 0;
	    changeValueMsg(1);
	    document.getElementById("caCalculation").contentWindow.setSelectCarValue(dataF.handcartAmt, dataF.carCost);
	    document.getElementById("caCalculation").contentWindow.SetDataMsg(dataF.id, dataF.frameColorId, dataF.interialColorId); //查询购车计算表，如果购车计算表车身颜色和内饰颜色为空，则将主表信息赋值上去
	    document.getElementById("caCalculation").contentWindow.setReadOnlyMsg();
    }
    var boolean = checkMsg(5);
    if (!boolean) {
        return;
    }
    var billFormData = billForm.getData(true); //主表信息
    var addMsg = costDetailGrid.getChanges("added");
    var editMsg = costDetailGrid.getChanges("modified");
    var deleteMsg = costDetailGrid.getChanges("removed");
    var addMs2 = costDetailGrid2.getChanges("added");
    var editMsg2 = costDetailGrid2.getChanges("modified");
    var deleteMsg2 = costDetailGrid2.getChanges("removed");
    var addArr = addMsg.concat(addMs2);
    var editArr = editMsg.concat(editMsg2);
    var deleteArr = deleteMsg.concat(deleteMsg2);
    nui.ajax({
        url: baseUrl + "com.hsapi.sales.svr.save.saveSaleCostLIst.biz.ext",
        data: {
            serviceId: billFormData.id,
            addArr: addArr,
            editArr: editArr,
            deleteArr: deleteArr,
            type:1,
            token:token
        },
        cache: false,
        async: false,
        success: function(text) {
            if (text.errCode == "S") {
                showMsg(text.errMsg, "S");
                costDetailGrid.load({ serviceId: billFormData.id, type: 1 });
                costDetailGrid2.load({ serviceId: billFormData.id, type: 2 });
            } else {
                showMsg(text.errMsg, "E");
            };
        }
    });
}
var giftData = {}
var isTabs = 0;
function setInitData(params) { //初始化
	isTabs = 1;
	dataF = {};
	//定位到精品加装tabs页
	nui.get("saveBtn").setVisible(false);
    nui.get("submitBtn").setVisible(false);
    nui.get("submitCarBtn").setVisible(false);
    nui.get("audit").setVisible(false);
    nui.get("selectBtn").setVisible(false);
    nui.get("case").setVisible(false);
    nui.get("invalidBtn").setVisible(false);
  
	var gift = nui.get("mainTabs").getTab("gift");
	nui.get("mainTabs").activeTab(gift);
    nui.get("typeMsg").setValue(params.typeMsg);
    if (params.typeMsg == 1) {
        nui.get("saveBtn").setVisible(true);
        nui.get("submitBtn").setVisible(true);
        nui.get("invalidBtn").setVisible(true);
        nui.get("submitCarBtn").setVisible(true);
    } else if (params.typeMsg == 2) {
        nui.get("audit").setVisible(true);
        nui.get("selectBtn").setVisible(true);
    } else if (params.typeMsg == 3) {
        nui.get("case").setVisible(true);
    }
    if (params.id) {
        
        jpGrid.clearRows();
        jpDetailGrid.clearRows();
        jpGrid.load();
        jpDetailGrid.load({ billType: 2, serviceId: params.id,token:token},function(){
        	//获取数据
            giftData = jpDetailGrid.getData();
        });
        searchSalesMain(params.id, 0);
        costGrid.clearRows();
    	var params2 = { isSale: 1 };
        costGrid.load({ params: params2,token:token});
        costDetailGrid.clearRows();
        costDetailGrid2.clearRows();
        costDetailGrid.load({ serviceId: params.id, type: 1,token:token});
        costDetailGrid2.load({ serviceId: params.id, type: 2,token:token});
    } else {
    	add();
    }
}

function add(){
    nui.get("submitBtn").setVisible(true);
    nui.get("invalidBtn").setVisible(true);
    nui.get("submitCarBtn").setVisible(true);
    nui.get("saveBtn").enable();
    nui.get("submitBtn").enable();
    nui.get("invalidBtn").enable();
    nui.get("submitCarBtn").enable();
	$("#servieIdEl").html("");
	searchNameEl.setVisible(false);
    searchNameEl.setEnabled(false);
    searchNameEl.setValue("");
    var sk = document.getElementById("search_key");
    sk.style.display = "";
    searchKeyEl.focus();
    searchKeyEl.setValue("");//点增加给输入框个值，防止触发不了onchanged方法，不能放入客户
    document.getElementById("repairStatus").style.display='none';
    //主表信息
	billForm.setData([]);
	nui.get("carModelName").setText("");
	//购车预算
	//form.setData([]);
	//document.getElementById("caCalculation").contentWindow.setEmpty();
	//精品加装
	jpDetailGrid.clearRows();
	//加载精品信息
	jpGrid.clearRows();
	jpGrid.load();
	//保险信息表头
	insuranceForm.setData([]);
	detailGrid.setData([]);
	//费用信息
	costGrid.clearRows();
	var params = { isSale: 1 };
    costGrid.load({ params: params,token:token});
    //费用信息右边
    costDetailGrid.clearRows();
    costDetailGrid2.clearRows();
	var date = new Date();
	nui.get("saleAdvisorId").setValue(currEmpId);
    nui.get("saleAdvisorId").setText(currUserName);
    nui.get("orderDate").setValue(date);
    setReadOnlySubmitCar(1);
    //表格输入
    setInputModel();
    //购车计算表可填写
    //document.getElementById("caCalculation").contentWindow.setInputModel();
}


function updateCheckEnter(enterId) { //返单 修改库存表车辆状态
    var data = {
        id: enterId,
        carStatus: 0
    };
    nui.ajax({
        url: baseUrl + "com.hsapi.sales.svr.save.updateCheckEnter.biz.ext",
        data: {
            data: data
        },
        cache: false,
        async: false,
        success: function(text) {
            if (text.errCode == "S") {
                showMsg(text.errMsg, "S");
            } else {
                showMsg(text.errMsg, "E");
            }
        }
    });
}

function checkCost(grid, value) { //费用信息  审核反审
	if(isTabs==1){
    	isTabs = 0;
	    changeValueMsg(1);
	    document.getElementById("caCalculation").contentWindow.setSelectCarValue(dataF.handcartAmt, dataF.carCost);
	    document.getElementById("caCalculation").contentWindow.SetDataMsg(dataF.id, dataF.frameColorId, dataF.interialColorId); //查询购车计算表，如果购车计算表车身颜色和内饰颜色为空，则将主表信息赋值上去
	    document.getElementById("caCalculation").contentWindow.setReadOnlyMsg();
    }
    var boolean = checkMsg(7);
    if (!boolean) {
        return;
    }
    var billFormData = billForm.getData(true);
    var row = grid.getSelected();
    var newRow = {
        auditSign: value
    };
    grid.updateRow(row, newRow);
    nui.ajax({
        url: baseUrl + "com.hsapi.sales.svr.save.checkMoneyForAuditAndUpdate.biz.ext",
        data: {
            data: row
        },
        cache: false,
        async: false,
        success: function(text) {
            if (text.errCode == "S") {
            	if(value){
            		showMsg(text.errMsg, "S");
            	}else{
            		showMsg("反审成功", "S");
            	}
                
            } else {
                showMsg(text.errMsg, "E");
            }
            costDetailGrid.load({ serviceId: billFormData.id, type: 1 });
            costDetailGrid2.load({ serviceId: billFormData.id, type: 2 });
        }
    });
}

/////////////////////////////////////////////////////////////////////////////////数据读取
var dataF = {};//销售主表的信息，点击购车预算tab时用到
function searchSalesMain(serviceId, type) { //查询主表信息
    var params = {
        id: serviceId
    };
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '加载中...'
    });
    nui.ajax({
        url: baseUrl + "com.hsapi.sales.svr.search.searchSalesMain.biz.ext",
        data: {
            params: params
        },
        cache: false,
        async: false,
        success: function(text) {
            if (text.errCode == "S") {
                var data = text.data[0];
                dataF = data;
                dataF.type = type;
                if (!type) {
                    billForm.setData(data);
                    form.setData(data);
                    //保存或者提交需要执行的
                    if(isTabs == 0){
                    	changeValueMsg(1);
                    }
                    
                    nui.get("carModelName").setValue(data.carModelName);
                    nui.get("carModelName").setText(data.carModelName);
                    if(isTabs == 0){
                    	document.getElementById("caCalculation").contentWindow.setSelectCarValue(data.handcartAmt, data.carCost);
                        document.getElementById("caCalculation").contentWindow.SetDataMsg(data.id, data.frameColorId, data.interialColorId); //查询购车计算表，如果购车计算表车身颜色和内饰颜色为空，则将主表信息赋值上去
                    }
                   // document.getElementById("caCalculation").contentWindow.setSelectCarValue(data.handcartAmt, data.carCost);
                   // document.getElementById("caCalculation").contentWindow.SetDataMsg(data.id, data.frameColorId, data.interialColorId); //查询购车计算表，如果购车计算表车身颜色和内饰颜色为空，则将主表信息赋值上去
                } else {
                    var billFormData = billForm.getData(true);
                    billFormData.isSettle = data.isSettle;
                    billFormData.enterId = data.enterId;
                    billFormData.status = data.status;
                    billFormData.carModelId = data.carModelId;
                    billFormData.isSubmitCar = data.isSubmitCar;
                    billFormData.handcartAmt = data.handcartAmt;
                    billFormData.carCost = data.carCost;
                    billForm.setData(billFormData);
                }
                $("#servieIdEl").html(data.serviceCode);
                if (data.isSubmitCar == 1) {
                    nui.get("submitCarBtn").disable();
                } else {
                    nui.get("submitCarBtn").enable();
                }

                if (data.status != 0) {
                    nui.get("saveBtn").disable();
                    nui.get("submitBtn").disable();
                    setReadOnlyMsg();
                    if(isTabs == 0){
                    	document.getElementById("caCalculation").contentWindow.setReadOnlyMsg();
                    }
                    //document.getElementById("caCalculation").contentWindow.setReadOnlyMsg();
                    if (nui.get("typeMsg").value == 2) {
                        if (data.isSubmitCar == 0) {
                            if (data.status == 1 || data.status == 2) {
                                costDetailGrid.showColumn("action");
                                costDetailGrid2.showColumn("action");
                            }
                        }
                    }
                } else {
                    nui.get("saveBtn").enable();
                    nui.get("submitBtn").enable();
                    setInputModel();
                    if(isTabs == 0){
                    	document.getElementById("caCalculation").contentWindow.setInputModel();
                    }
                   // document.getElementById("caCalculation").contentWindow.setInputModel();
                }
                if(data.guestId) {
			       	 if(data.enterId !=0 ){
			       		 insuranceMsg(data.guestId,data.enterId);
			       	 }
                }
                if (nui.get("typeMsg").value != 1) {
                    setReadOnlySubmitCar(1);
                    nui.get("toolbar").setVisible(false);
                } else {
                	//交车之后，交车信息不能编辑，费用信息也不编辑
                    if (data.enterId && data.isSettle != 1 && data.isSubmitCar == 0) {
                        setReadOnlySubmitCar(0);
                    } else {
                        setReadOnlySubmitCar(1);
                    }
                }
                if (data.status == 3) {
                    setReadOnlySubmitCar(1);
                }
                var msg = (data.contactor || "") + "/" + (data.contactorTel || "");
                if (data.contactor && data.contactorTel) {
                    searchNameEl.setValue(msg);
                }
                if (!data.contactor && data.contactorTel) {
                    searchNameEl.setValue(data.contactorTel);
                }
                if (data.contactor && !data.contactorTel) {
                    searchNameEl.setValue(data.contactor);
                }
                searchNameEl.setEnabled(false);
                searchNameEl.setVisible(true);
                var sk = document.getElementById("search_key");
                sk.style.display = "none";
                doSetStyle(data);
            };
            nui.unmask(document.body);
        }
       
    });
}

function insuranceMsg(guestId,enterId) { //获取保险信息
	if(enterId==0){
		return;
	}
    var params = { guestId: guestId,
    		      enterId : enterId
    		      };
    nui.ajax({
        url: repairUrl + "com.hsapi.repair.repairService.svr.searchInsuranceMsg.biz.ext",
        data: {
            params: params,
            token:token
        },
        cache: false,
        async: false,
        success: function(text) {
            if (text.errCode == "S") {
                var list = text.list;
                var data = text.data;
                if(data.id){
                	detailGrid.setData(list);
                    insuranceForm.setData(data);
                    nui.get("agentGrossProfit").setValue(text.grossProfit);
                }else{
                	detailGrid.setData([]);
                    insuranceForm.setData([]);
                    nui.get("agentGrossProfit").setValue(0);
                }
                
            };
        }
    });
}
/////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////弹窗
function addGuest() { //新增客户资料
    nui.open({
        url: webPath + contextPath + "/sales/customer/addGuest.jsp?token=" + token,
        title: "新增客户资料",
        width: 900,
        height: 460,
        allowDrag: true,
        allowResize: true,
        onload: function() {
            var iframe = this.getIFrameEl();
            // iframe.contentWindow.setViewData(dock, dodelck, docck);
        }
    });
}

function selectCar() { //点击选车时触发
	if(isTabs==1){
    	isTabs = 0;
	    changeValueMsg(1);
	    document.getElementById("caCalculation").contentWindow.setSelectCarValue(dataF.handcartAmt, dataF.carCost);
	    document.getElementById("caCalculation").contentWindow.SetDataMsg(dataF.id, dataF.frameColorId, dataF.interialColorId); //查询购车计算表，如果购车计算表车身颜色和内饰颜色为空，则将主表信息赋值上去
	    document.getElementById("caCalculation").contentWindow.setReadOnlyMsg();
    }
    var boolean = checkMsg(9);
    if (!boolean) {
        return;
    }
    var billFormData = billForm.getData(true);
    
    var params = document.getElementById("caCalculation").contentWindow.getValue(); //购车信息
    var caCalculationData = params.data;
    caCalculationData.billType = 2;
    var saleExtend = caCalculationData;
    nui.open({
        url: webPath + contextPath + "/sales/sales/selectCar.jsp?token=" + token,
        title: "选择库存车",
        width: "70%",
        height: "50%",
        onload: function() {
            var iframe = this.getIFrameEl();
            var data = {
                carModelId: billFormData.carModelId,
                carLock: 0,
                carStatus: 1
            }
            params = {
            		data:data,
            		saleExtend:saleExtend,
            		billFormData:billFormData
            }
            iframe.contentWindow.SetData(params);
        },
        ondestroy: function(action) {
            if (action == "ok") {
                var iframe = this.getIFrameEl();
                var result = iframe.contentWindow.getSelectedValue();
                
                var handcartAmt = result.handcartAmt || 0; //运输成本
                var carCost = result.carCost || 0; //购买成本
               
                billForm.setData(result);
                document.getElementById("caCalculation").contentWindow.setSelectCarValue(handcartAmt, carCost);
                //修改了购车预算中的运输成本和购买成本，需要把dataF重新赋值这两个值，要不然会显示之前的值(换成了另一种方式)
                //dataF.handcartAmt = handcartAmt;
               // dataF.carCost = carCost;
             //   save(10); //避免 enterId赋值 导致触发表格验证判断
                doSetStyle(result);
            }
        }
    });
}

function registration() { //车辆上牌
	if(isTabs==1){
    	isTabs = 0;
	    changeValueMsg(1);
	    document.getElementById("caCalculation").contentWindow.setSelectCarValue(dataF.handcartAmt, dataF.carCost);
	    document.getElementById("caCalculation").contentWindow.SetDataMsg(dataF.id, dataF.frameColorId, dataF.interialColorId); //查询购车计算表，如果购车计算表车身颜色和内饰颜色为空，则将主表信息赋值上去
	    document.getElementById("caCalculation").contentWindow.setReadOnlyMsg();
    }
    var boolean = checkMsg(8);
    if (!boolean) {
        return;
    }
    var billFormData = billForm.getData(true); //主表信息
    if(billFormData.enterId==0){
    	showMsg("销售单未选车","W");
    	return;
    }
    nui.open({
        url: webPath + contextPath + "/sales/sales/vehicleRegistration.jsp?token=" + token,
        title: "车辆上牌",
        width: "550px",
        height: "450px",
        onload: function() {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.SetData(billFormData);
        }
    });
}

function caseMsg() { //销售结案审核
	if(isTabs==1){
    	isTabs = 0;
	    changeValueMsg(1);
	    document.getElementById("caCalculation").contentWindow.setSelectCarValue(dataF.handcartAmt, dataF.carCost);
	    document.getElementById("caCalculation").contentWindow.SetDataMsg(dataF.id, dataF.frameColorId, dataF.interialColorId); //查询购车计算表，如果购车计算表车身颜色和内饰颜色为空，则将主表信息赋值上去
	    document.getElementById("caCalculation").contentWindow.setReadOnlyMsg();
    }
    var type = 1;
    var billFormData = billForm.getData(true);
    if (billFormData.isSettle != 1) {
        var boolean = checkMsg(4);
        if (!boolean) {
            return;
        }
        type = 2;
    }
    var billFormData = billForm.getData(true); //主表信息
    nui.open({
        url: webPath + contextPath + "/sales/sales/salesReview.jsp?token=" + token,
        title: "销售结案审核",
        width: "880px",
        height: "700px",
        onload: function() {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.SetData(billFormData, type);
        },
        ondestroy: function(action) {
        	if(action=="ok"){
        		var billFormData = billForm.getData(true);
        		billFormData.isSettle = 1;
        		billForm.setData(billFormData);
        		doSetStyle(billFormData);
        	}
           // searchSalesMain(billFormData.id, 0);
        }
    });
}

function salesOnPrint(p) {
	if(isTabs==1){
    	isTabs = 0;
	    changeValueMsg(1);
	    document.getElementById("caCalculation").contentWindow.setSelectCarValue(dataF.handcartAmt, dataF.carCost);
	    document.getElementById("caCalculation").contentWindow.SetDataMsg(dataF.id, dataF.frameColorId, dataF.interialColorId); //查询购车计算表，如果购车计算表车身颜色和内饰颜色为空，则将主表信息赋值上去
    }
    var billFormData = billForm.getData(true); //主表信息
   // searchSalesMain(billFormData.id, 1);
    var billFormData = billForm.getData(true); //主表信息
    if (billFormData.status == 3) {
        showMsg("当前工单已作废！", "W");
        return;
    }
    if (p == 3 || p == 5) {
        if (billFormData.isSubmitCar != 1) {
            showMsg("当前工单尚未交车，暂时无法打印！", "W");
            return;
        }
    }
    if (p == 4 && billFormData.status != 2) {
        showMsg("当前工单尚未审核，暂时无法打印！", "W");
        return;
    }
    if (!billFormData.id) {
        showMsg("请保存后再进行打印操作！", "W");
        return;
    }
    var url = webPath + contextPath;
    switch (p) {
        case 1:
            url = url + "/sales/sales/print/cashPurchases.jsp";
            break;
        case 2:
            url = url + "/sales/sales/print/printLoanDetail .jsp";
            break;
        case 3:
            url = url + "/sales/sales/print/printJCDetail.jsp";
            break;
        case 4:
            url = url + "/sales/sales/print/printSalesContract.jsp";
            break;
        case 5:
            url = url + "/sales/sales/print/printOutstore.jsp";
            break;
    }
    nui.open({
        url: url,
        title: "打印",
        width: "100%",
        height: "100%",
        onload: function() {
            var iframe = this.getIFrameEl();
            if (p == 1 || p == 2) {
                var params = {
                    serviceId: billFormData.id,
                    billType: 2,
                    carModelId: billFormData.carModelId
                };
                iframe.contentWindow.SetData(params);
            } else {
                iframe.contentWindow.SetData(billFormData.id);
            }

        }
    });
}

function onButtonEdit(e) {
    var billFormData = billForm.getData(true); //主表信息
    nui.open({
        url: webPath + contextPath + '/sales/base/selectCarModel.jsp',
        title: '选择车型',
        width: 1000,
        height: 500,
        onload: function() {
            var iframe = this.getIFrameEl();
            //iframe.contentWindow.setData(row);
        },
        ondestroy: function(action) {
            var iframe = this.getIFrameEl();
            if (action == 'ok') {
                var row = iframe.contentWindow.getRow();
                billFormData.carModelId = row.id;
                nui.get("carModelName").setValue(row.fullName);
                nui.get("carModelName").setText(row.fullName);
                nui.get("carModelId").setValue(row.id);
                billFormData.carModelName = row.fullName;
                billForm.setData(billFormData);

            }
        }
    });
}
/////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////表格控制/数据处理
function setInputModel() { //恢复表格为输入模式
    var fields = billForm.getFields();
    for (var i = 0, l = fields.length; i < l; i++) {
        var c = fields[i];
        if (c.setReadOnly) c.setReadOnly(false);
    };
    jpGrid.setReadOnly(false);
    jpDetailGrid.setReadOnly(false);
    costGrid.setReadOnly(false);
}

function setReadOnlyMsg() { //设置表格信息为只读
    var fields = billForm.getFields();
    for (var i = 0, l = fields.length; i < l; i++) {
        var c = fields[i];
        if (c.setReadOnly) c.setReadOnly(true); //只读
        if (c.setIsValid) c.setIsValid(true); //去除错误提示
    };
    jpGrid.setReadOnly(true);
    jpDetailGrid.setReadOnly(true);
    costGrid.setReadOnly(true);
}

function setReadOnlySubmitCar(e) { //交车信息  编辑/只读
    if (e == 1) {
        var fields = form.getFields();
        for (var i = 0, l = fields.length; i < l; i++) {
            var c = fields[i];
            if (c.setReadOnly) c.setReadOnly(true); //只读
            if (c.setIsValid) c.setIsValid(true); //去除错误提示
        };
    } else {
        var fields = form.getFields();
        for (var i = 0, l = fields.length; i < l; i++) {
            var c = fields[i];
            if (c.setReadOnly) c.setReadOnly(false);
        };
    }
}

function onIsNotRenderer(e) {
    for (var i = 0, l = is_not.length; i < l; i++) {
        var g = is_not[i];
        if (g.id == e.value) return g.text;
    };
    return "";
}

function onCellCommitEdit(e) {
    var editor = e.editor;
    if (e.field == "qty" || e.field == "price" || e.field == "costAmt") {
        if (editor.isValid() == false) {
            showMsg("请输入数字!", "W");
            e.cancel = true;
        };
    };
}

function costCommitEdit(e) {
    var editor = e.editor;
    var row = e.row;
    if (e.field == "costAmt") {
        if (editor.isValid() == false) {
            showMsg("请输入数字!", "W");
            e.cancel = true;
        }
    };
    nui.ajax({
        url: baseUrl + "com.hsapi.sales.svr.search.searchSaleCostList.biz.ext",
        data: {
            id: row.id
        },
        cache: false,
        async: false,
        success: function(text) {
            if (text.errCode == "S") {
                var data = text.data[0];
                if (data.auditSign == 1) {
                    showMsg("当前修改的数据已审核", "W");
                    costDetailGrid.updateRow(row, { auditSign: 1, costAmt: data.costAmt });
                    costDetailGrid2.updateRow(row, { auditSign: 1, costAmt: data.costAmt });
                    e.cancel = true;
                }
            };
        }
    });
}

function OnModelCellBeginEdit(e) {
    var field = e.field;
    var row = e.row;
    if (field == "costAmt" || field == "remark") {
        if (nui.get("typeMsg").value != 1) {
            e.cancel = true;
        };
    };
    if (row.auditSign == 1) {
        e.cancel = true;
    }
};

function changeValueMsg(e) {
    var saleType = nui.get("saleType").value;
    document.getElementById("caCalculation").contentWindow.setSaleType(saleType);
    if (nui.get("saleType").value == "1558580770894") {
        document.getElementById("loan").style.display = "none";
        document.getElementById("cash").style.display = "";
    } else {
        document.getElementById("cash").style.display = "none";
        document.getElementById("loan").style.display = "";
    }
}

function selectJPGrid() {
    var billFormData = billForm.getData(true); //主表信息
    if (billFormData.status != 0) {
        return;
    }
    var jpdata = jpGrid.getSelecteds();
    var jpDetailData = jpDetailGrid.getData();
    for (var i = 0, l = jpdata.length; i < l; i++) {
        var msg = jpDetailData.find(jpDetailData => jpDetailData.giftId == jpdata[i].id);
        if (!msg) {
            var newRow = {
                giftId: jpdata[i].id,
                giftName: jpdata[i].name,
                receType:1,
                billType: 2
            };
            jpDetailGrid.addRow(newRow, jpDetailData.length);
        };
    }
    jpDetailData = jpDetailGrid.getData();
    for (var i = 0, l = jpDetailData.length; i < l; i++) {
        var row = jpDetailGrid.getRow(i);
        var msg = jpdata.find(jpdata => jpdata.id == jpDetailData[i].giftId);
        if (!msg) {
            jpDetailGrid.commitEdit();
            jpDetailGrid.removeRow(row, false);
        };
    };
}

function selectCostGrid() {
    var billFormData = billForm.getData(true); //主表信息
    if (billFormData.status == 2 && nui.get("typeMsg").value == 1) {
        var data = costGrid.getSelecteds();
        var data1 = costDetailGrid.getData();
        var data2 = costDetailGrid2.getData();
        for (var i = 0, l = data.length; i < l; i++) {
            var newRow = {
                costName: data[i].name,
                costId: data[i].id,
                auditSign: 0
            };
            if (data[i].name == "购置税" || data[i].name == "保险费") {
                var msg = data1.find(data1 => data1.costId == data[i].id);
                if (!msg) {
                    newRow.type = 1;
                    costDetailGrid.addRow(newRow, costDetailGrid.length);
                };
            } else {
                var msg = data2.find(data2 => data2.costId == data[i].id);
                if (!msg) {
                    newRow.type = 2;
                    costDetailGrid2.addRow(newRow, costDetailGrid2.length);
                };
            };
        }
        data1 = costDetailGrid.getData();
        for (var i = 0, l = data1.length; i < l; i++) {
            var row = costDetailGrid.getRow(i);
            var msg = data.find(data => data.id == data1[i].costId);
            if (!msg) {
                costDetailGrid.commitEdit();
                costDetailGrid.removeRow(row, false);
            };
        }
        data2 = costDetailGrid2.getData();
        for (var i = 0, l = data2.length; i < l; i++) {
            var row = costDetailGrid2.getRow(i);
            var msg = data.find(data => data.id == data2[i].costId);
            if (!msg) {
                costDetailGrid2.commitEdit();
                costDetailGrid2.removeRow(row, false);
            };
        };
    }
}

function onDrawDate(e) {
    var date = e.date;
    var d = new Date();

    if (date.getTime() < d.getTime()) {
        e.allowSelect = false;
    }
}

function onDrawSubmitTrueDate(e) {
    var date = e.date;
    var d = new Date(nui.get("submitPlanDate").value);

    if (date.getTime() < d.getTime()) {
        e.allowSelect = false;
    }
}

function changeFrameColorId(value) {
    nui.get("frameColorId").setValue(value);
}

function changeInterialColorId(value) {
    nui.get("interialColorId").setValue(value);
}


//点击购车预算tab页时，加载
function activechangedmain(){
	var tabs = nui.get("mainTabs").getActiveTab();
	if(tabs.name=="editForm"){
		var data = billForm.getData();
		if(!data.id){
			if(typeF==1){
				type == 0;
				document.getElementById("caCalculation").contentWindow.setEmpty();
			}
			
		}
	   if(isTabs==1){
		    isTabs = 0;
			if(dataF.type==0){
				changeValueMsg(1);
			    document.getElementById("caCalculation").contentWindow.setSelectCarValue(dataF.handcartAmt, dataF.carCost);
	            document.getElementById("caCalculation").contentWindow.SetDataMsg(dataF.id, dataF.frameColorId, dataF.interialColorId); //查询购车计算表，如果购车计算表车身颜色和内饰颜色为空，则将主表信息赋值上去
	            if(dataF.status != 0){
					document.getElementById("caCalculation").contentWindow.setReadOnlyMsg()
				}else{
					document.getElementById("caCalculation").contentWindow.setInputModel();
				}
			}else{
				document.getElementById("caCalculation").contentWindow.setInputModel();
			}
			
		}
	}
}

//主表购车方式改变时
var typeF = 1;
function changeBuyType(){
	var data = billForm.getData();
	if(!data.id){
		if(typeF==1){
			type == 0;
			document.getElementById("caCalculation").contentWindow.setEmpty();
		}
		
	}
	isTabs = 0;
	changeValueMsg(1);
}

//销售单审核
function auditingSales(){
	if(isTabs==1){
    	isTabs = 0;
	    changeValueMsg(1);
	    document.getElementById("caCalculation").contentWindow.setSelectCarValue(dataF.handcartAmt, dataF.carCost);
	    document.getElementById("caCalculation").contentWindow.SetDataMsg(dataF.id, dataF.frameColorId, dataF.interialColorId); //查询购车计算表，如果购车计算表车身颜色和内饰颜色为空，则将主表信息赋值上去
	    document.getElementById("caCalculation").contentWindow.setReadOnlyMsg();
    }
	var billFormData = billForm.getData(true); //主表信息
	if(billFormData.status<1){
		showMsg("销售单未提交,不能审核","W");
		return;
	}
	if(billFormData.status==2){
		showMsg("销售单已审核","W");
		return;
	}
	var params = document.getElementById("caCalculation").contentWindow.getValue(); //购车信息
    var caCalculationData = params.data;
	nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });
	 nui.ajax({
        url: baseUrl + "com.hsapi.sales.svr.save.auditingSales.biz.ext",
        data: {
            billFormData: billFormData,
            caCalculationData: caCalculationData,
            token:token
        },
        cache: false,
        async: false,
        success: function(text) {
            if (text.errCode == "S") {
            	billFormData.status = 2;
            	billForm.setData(billFormData)
            	showMsg("审核成功" || text.errMsg, "S");
                nui.unmask(document.body);
                doSetStyle(billFormData);
            } else {
                showMsg(text.errMsg, "E");
                nui.unmask(document.body);
            }
        }
    });
}

function isSubmitCar(){
	if(isTabs==1){
    	isTabs = 0;
	    changeValueMsg(1);
	    document.getElementById("caCalculation").contentWindow.setSelectCarValue(dataF.handcartAmt, dataF.carCost);
	    document.getElementById("caCalculation").contentWindow.SetDataMsg(dataF.id, dataF.frameColorId, dataF.interialColorId); //查询购车计算表，如果购车计算表车身颜色和内饰颜色为空，则将主表信息赋值上去
	    document.getElementById("caCalculation").contentWindow.setReadOnlyMsg();
    }
	var billFormData = billForm.getData(true); //主表信息
	if(billFormData.enterId==0){
		showMsg("销售单暂未选车","W");
		return;
	}
    //检验状态
    var boolean = checkMsg(6);
    if (!boolean) {
        return;
    }   
    
    //获取交车信息
    var formData = form.getData();
    billFormData.submitCarMen = formData.submitCarMen;
    billFormData.submitTrueDate = formData.submitTrueDate;
    billFormData.submitCarKeyQty = formData.submitCarKeyQty;
    billFormData.submitCarRemark = formData.submitCarRemark;
    billFormData.isSubmitCar = 1;
    
    //获取费用信息（其他信息在这个状态下不能修改了，只有费用信息可以修改）
    var addMsg = costDetailGrid.getChanges("added");
    var editMsg = costDetailGrid.getChanges("modified");
    var deleteMsg = costDetailGrid.getChanges("removed");
    var addMs2 = costDetailGrid2.getChanges("added");
    var editMsg2 = costDetailGrid2.getChanges("modified");
    var deleteMsg2 = costDetailGrid2.getChanges("removed");
    var addArr = addMsg.concat(addMs2);
    var editArr = editMsg.concat(editMsg2);
    var deleteArr = deleteMsg.concat(deleteMsg2);
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });
    nui.ajax({
        url: baseUrl + "com.hsapi.sales.svr.save.saveSaleMainAll.biz.ext",
        data: {
            billFormData: billFormData,
            addArr: addArr,
            editArr: editArr,
            deleteArr: deleteArr
        },
        cache: false,
        async: false,
        success: function(text) {
            if (text.errCode == "S") {
                var serviceId = text.serviceId;
                billForm.setData(billFormData)
                costDetailGrid.load({ serviceId: serviceId, type: 1 });
                costDetailGrid2.load({ serviceId: serviceId, type: 2 });
                //交车信息不能修改，交车按钮不可用
                setReadOnlySubmitCar(1);
                nui.get("submitCarBtn").disable();
                //费用信息不可填写
                showMsg("交车成功", "S");
                nui.unmask(document.body);
                doSetStyle(billFormData);
            } else {
                showMsg(text.errMsg, "E");
                nui.unmask(document.body);
            }
        }
    });
    
}

//返单，草稿的单子不需要返单，已结算的单子不需要返单,有BUG，表格读写的控制
function backSingle(){
	if(isTabs==1){
    	isTabs = 0;
	    changeValueMsg(1);
	    document.getElementById("caCalculation").contentWindow.setSelectCarValue(dataF.handcartAmt, dataF.carCost);
	    document.getElementById("caCalculation").contentWindow.SetDataMsg(dataF.id, dataF.frameColorId, dataF.interialColorId); //查询购车计算表，如果购车计算表车身颜色和内饰颜色为空，则将主表信息赋值上去
	    document.getElementById("caCalculation").contentWindow.setReadOnlyMsg();
    }
	 var billFormData = billForm.getData(true); //主表信息
	 var status = billFormData.status || 0;
	 var isSettle = billFormData.isSettle || 0;
	 if(status == 0){
		 showMsg("草稿状态的销售单不需要返单","W");
		 return ;
	 }
	 if(isSettle == 1){
		 showMsg("已结算的销售单不能返单","W");
		 return ; 
	 }
	 if(status == 3){
		 showMsg("销售单已作废不能返单","W");
		 return ; 
	 }
	 nui.ajax({
         url: baseUrl + "com.hsapi.sales.svr.save.backSingle.biz.ext",
         data: {
             data: billFormData
         },
         cache: false,
         async: false,
         success: function(text) {
             if (text.errCode == "S") {
                 showMsg("返单成功", "S");
                 billFormData.status = 0;
                 billFormData.isSubmitCar = 0;
                 billFormData.enterId = 0;
                 billForm.setData(billFormData);
                 doSetStyle(billFormData);
                 //如果是在销售管理返单，表格信息、精品加装、购车预算可编辑
                 if(nui.get("typeMsg").value ==1){
                	 setReadOnlySubmitCar(1);//交车信息只读
                	 setInputModel();//表格读写
                	 document.getElementById("caCalculation").contentWindow.setInputModel();//购车预算读写
                	 nui.get("saveBtn").enable();
                     nui.get("submitBtn").enable();
                 }
             }else{
            	 showMsg(text.errMsg, "E");
             }
             nui.unmask(document.body);
         }
     });
    
}

//工单作废,作废之后所有表格不能编辑
function delet(){
	if(isTabs==1){
    	isTabs = 0;
	    changeValueMsg(1);
	    document.getElementById("caCalculation").contentWindow.setSelectCarValue(dataF.handcartAmt, dataF.carCost);
	    document.getElementById("caCalculation").contentWindow.SetDataMsg(dataF.id, dataF.frameColorId, dataF.interialColorId); //查询购车计算表，如果购车计算表车身颜色和内饰颜色为空，则将主表信息赋值上去
	    document.getElementById("caCalculation").contentWindow.setReadOnlyMsg();
    }
	 var billFormData = billForm.getData(true); //主表信息
	 var status = billFormData.status || 0;
	 var isSettle = billFormData.isSettle || 0;
	 if(status != 0){
		 showMsg("请先返单再作废","W");
		 return ;
	 }
	 if(isSettle == 1){
		 showMsg("已结算的销售单不能作废","W");
		 return ; 
	 }
	 nui.ajax({
         url: baseUrl + "com.hsapi.sales.svr.save.deletSaleMain.biz.ext",
         data: {
        	 saleMain: billFormData
         },
         cache: false,
         async: false,
         success: function(text){
             if (text.errCode == "S") {
                 showMsg("作废成功", "S");
                 setReadOnlyMsg();//表格不可读
                 setReadOnlySubmitCar(1);//交车信息只读，读写setInputModel
                 document.getElementById("caCalculation").contentWindow.setReadOnlyMsg();
                 billFormData.status = 3;
                 billForm.getData(billFormData);
                 doSetStyle(billFormData)
             }else{
            	 showMsg(text.errMsg, "E");
             }
             nui.unmask(document.body);
         }
     });
}


//草稿、待审、已审未选车、已审未交车、未结算、已结算、作废、repairStatus
function doSetStyle(data){
	document.getElementById("repairStatus").style.display = ""
	if(data.status==0){
		document.getElementById("repairStatus").innerHTML = "草稿";
		$("#repairStatus").attr("class", "statusview");
	}else if(data.status==1){
		document.getElementById("repairStatus").innerHTML = "待审";
		$("#repairStatus").attr("class", "statusview");
	}else if(data.status==3){
		document.getElementById("repairStatus").innerHTML = "作废";
		$("#repairStatus").attr("class", "statusview");
	}else if(data.status==2 && data.enterId==0){
		document.getElementById("repairStatus").innerHTML = "已审未选车";
		$("#repairStatus").attr("class", "statusview");
	}else if(data.status==2 && data.isSubmitCar==0){
		document.getElementById("repairStatus").innerHTML = "已审未交车";
		$("#repairStatus").attr("class", "statusview");
	}else if(data.status==2 && data.isSettle==0){
		document.getElementById("repairStatus").innerHTML = "未结算";
		$("#repairStatus").attr("class", "statusview");
	}else if(data.status==2 && data.isSettle==1){
		document.getElementById("repairStatus").innerHTML = "已结算";
		$("#repairStatus").attr("class", "statusview");
	}
	
	/*if(isSettle == 1){
		$("#statustable").find("span[name=statusvi]").attr("class", "nvstatusview");
		$("#settleStatus").attr("class", "statusview");
	}else{
		$("#statustable").find("span[name=statusvi]").attr("class", "nvstatusview");
		if(status==0){
			$("#addStatus").attr("class", "statusview");
		}else if(status==1){
			$("#repairStatus").attr("class", "statusview");
		}else if(status==2){
			$("#finishStatus").attr("class", "statusview");
		}
	}*/
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////