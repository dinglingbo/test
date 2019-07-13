

var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
var mainGrid1 = null;
var rpsItemGrid = null;
var mainGrid1Url = baseUrl + "com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext";
var mainGrid2Url = baseUrl + "com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext";

var queryRepairOutListGridUrl = baseUrl + "com.hsapi.repair.repairService.report.queryRepairOutList.biz.ext";
var queryPjPchsOrderEnterDetailChkListGridUrl = apiPath + repairApi + "/com.hsapi.part.invoice.paramcrud.queryPjPchsOrderEnterDetailChkList.biz.ext";
var queryPartStoreStockGridUrl = apiPath + repairApi + "/com.hsapi.part.invoice.query.queryPartStoreStock.biz.ext";
var xyguest = {};
var billForm = null;
var servieTypeHash = {};
var mtAdvisorIdEl = null;
var fserviceId = null;//仓库点去报价才有值
var pickName = null;//点击配件才会有.用于tables
var storeHash = {};
$(document).ready(function (){	
	queryRepairOutListGrid = nui.get("queryRepairOutListGrid");
	queryRepairOutListGrid.setUrl(queryRepairOutListGridUrl);
	queryPjPchsOrderEnterDetailChkListGrid = nui.get("queryPjPchsOrderEnterDetailChkListGrid");
	queryPjPchsOrderEnterDetailChkListGrid.setUrl(queryPjPchsOrderEnterDetailChkListGridUrl);
	queryPartStoreStockGrid = nui.get("queryPartStoreStockGrid");
	queryPartStoreStockGrid.setUrl(queryPartStoreStockGridUrl);
	billForm = new nui.Form("#billForm");
	mainGrid1 = nui.get("mainGrid1");
	mainGrid1.setUrl(mainGrid1Url);
	mtAdvisorIdEl = nui.get("mtAdvisorId");
	var p={
			noMtType : 1,
			isDisabled: 0,
			page : {
				pageSize:9999
			}
	}
	mainGrid1.load({
		params:p,
    	token:token
	});
	rpsItemGrid = nui.get("rpsItemGrid");
    getMtadvisor(function(text){
    	mtAdvisorIdEl.setData(text.data);
    });
    mtAdvisorIdEl.on("valueChanged",function(e){
        var text = mtAdvisorIdEl.getText();
        nui.get("mtAdvisor").setValue(text);
    });
	getStorehouse(function(data) {
		storehouse = data.storehouse || [];
		if(storehouse && storehouse.length>0){
			storehouse.forEach(function(v) {
				storeHash[v.id] = v;
			});
		}
	});
    initServiceType("serviceTypeId",function(data) {
        servieTypeList = nui.get("serviceTypeId").getData();
        servieTypeList.forEach(function(v) {
            servieTypeHash[v.id] = v;
        });
    });
    mainGrid1.on("rowdblclick",function(e){
    	var row = mainGrid1.getSelected();
    	setBillForm(row);
	});
    rpsItemGrid.on("rowdblclick",function(e){
    	var row = rpsItemGrid.getSelected();
    	pickName = row.prdtName;
    	activechangedmain();
	});

	mainGrid1.on("drawcell", function (e) {
        var grid = e.sender;
        var record = e.record;
        var uid = record._uid;
        var rowIndex = e.rowIndex;

        switch (e.field) {
            case "noMtFileSign":
                if(e.value==0){
                    e.cellHtml = "未报价";
                }else{
                    e.cellHtml = "已报价";
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
/*                if(cardDetailId>0){
                    s = s+"<font color='red'>(预存)</font>";
                }*/
                if(record.noMtType>0){
                    s =s+ "<font color='red'>(请报价)</font>";
                }
                if(pid == 0){
                    e.cellHtml = '<a href="javascript:choosePart(\'' + uid + '\')" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;配件</a>' + e.value + s;	
                }else{
                	e.cellHtml = e.value + s;
                }
                break;
            case "itemOptBtn":
            	if(pid == 0){
            		var cardDetailId = record.cardDetailId||0;
/*                  	s = ' <a class="optbtn" href="javascript:deleteItemRow(\'' + uid + '\')">删除</a>';*/
/*                  	if(cardDetailId<=0){
                  		s = s + ' <a class="optbtn" href="javascript:updateItemRow(\'' + uid + '\')">修改项目</a>';
                  	}*/
                    
                 }else{
                	 s = ' <a class="optbtn" href="javascript:deletePartRow(\'' + uid + '\')">删除</a>';
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
            case "workers":
                var type = record.type||0;
                if(type != 2){
                    e.cellHtml = "--";
                }else{
                    e.cellHtml = e.value;
                }
                break;
            case "rate":
                var value = e.value||"";
                if(value&&value!="0"){
                    e.cellHtml = e.value + '%';
                }
                break;
            case "qty":
                var value = e.value||"";
                if(value&&value=="0"){
                    e.cellHtml = 1;
                    record.qty=1;
                }
                break;
            case "saleMan":
                var cardDetailId = record.cardDetailId||0;
                if(cardDetailId> 0){
                    e.cellHtml = "--";
                }
                break;
            default:
                break;
        }
        
    });
    queryRepairOutListGrid.on("drawcell",function(e){
		var record = e.record;
		switch (e.field) {
		case "serviceCode":
			e.cellHtml ='<a href="##" onclick="editSell()">'+e.value+'</a>';
			break;
		 case "storeId" :
		     if(storeHash[e.value])
	            {
	                e.cellHtml = storeHash[e.value].name||"";
	            }
	            else{
	                e.cellHtml = "";
	            }
			 break;
		 case "serviceTypeId":
			 if(servieTypeHash[record.serviceTypeId]){		 
				 e.cellHtml = servieTypeHash[record.serviceTypeId].name ||"";
			 }else{
				 e.cellHtml = '';
			 }
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
        if(field == 'workers'){
            if(row.type == 3){
                e.cancel = true;
            }
        }
        if(field == 'unitPrice' || field == 'subtotal' || field == 'rate' || field == 'saleMan' || field == 'qty'){
            if(row.cardDetailId > 0){
                e.cancel = true;
            }
        }
    });
	if(fserviceId){
		var mainList = mainGrid1.getData();
		for(var i =0;i<mainList.length;i++){
			if(mainList[i].serviceId =fserviceId ){
				mainGrid1.select( mainList[i], true )
			}
		}
	}
});

function addPrdt(data){
    var main = billForm.getData();
    if(!main.id){
        showMsg("请先保存工单!","E");
        return;
    }
    var type = data.type;
    var rtnRow = data.rtnRow||{};
    if(type == 0){
        if(rtnRow){
            var t = rtnRow.prdtType||0;
            var interType = "";
            if(t == 1){
                interType = "package";
            }else if(t == 2){
                interType = "item";
            }else if(t == 3){
                interType = "part";
            }
            if(!interType){
                showMsg("次卡类型有误!","W");
                return;
            }
            var data = {};
            if(interType == 'package'){
                var pkg = {
                    serviceId:main.id,
                    packageId:rtnRow.prdtId,
                    cardDetailId:rtnRow.id||0
                };
                data.pkg = pkg;
            }else if(interType == 'item'){
                var insItem = {
                    serviceId:main.id||0,
                    itemId:rtnRow.prdtId,
                    cardDetailId:rtnRow.id||0
                };
                data.insItem = insItem;
                data.serviceId = main.id||0;
            }else if(interType == 'part'){
                var insPart = {
                    serviceId:main.id||0,
                    partId:rtnRow.prdtId,
                    cardDetailId:rtnRow.id||0,
                    partCode:rtnRow.prdtCode
                };
                data.insPart = insPart;
                data.serviceId = main.id||0;
            }
            var params = {
                type:"insert",
                interType:interType,
                data:data
            };
            nui.mask({
                el: document.body,
                cls: 'mini-mask-loading',
                html: '数据加载中...'
            });
            if(interType == 'package'){
            	nui.unmask(document.body);
            	savePkg(function(){
            		svrCRUD(params,function(text){
                        var errCode = text.errCode||"";
                        var errMsg = text.errMsg||"";
                        if(errCode == 'S'){
                        	nui.unmask(document.body);
                            var params = {
                                interType: interType,
                                data:{
                                    serviceId: main.id||0
                                }
                            }
                            getBillDetail(params, function(text){
                                var errCode = text.errCode;
                                var data = text.data||[];
                                if(errCode == "S"){
                                    if(interType == 'package'){
                                        rpsPackageGrid.clearRows();
                                        rpsPackageGrid.addRows(data);
                                        rpsPackageGrid.accept();
                                        if(main.status<2){
                                        	var row = rpsPackageGrid.findRow(function(row){
                                        		rpsPackageGrid.beginEditRow(row);
                                            });
                                        }
                                    }else if(interType == 'item'){
                                        rpsItemGrid.clearRows();
                                        rpsItemGrid.addRows(data);
                                        rpsItemGrid.accept();
                                        if(main.status<2){
                                        	var row = rpsItemGrid.findRow(function(row){
                                        		rpsItemGrid.beginEditRow(row);
                                            });
                                        }
                                    }
                                }
                            }, function(){});
                        }else{
                            showMsg(errMsg||"添加预存信息失败!","E");
                            nui.unmask(document.body);
                            return;
                        }
                    });
            	});
            }
            
            if(interType == 'part' || interType == 'item'){
            	saveItem(function(){
            		nui.unmask(document.body);
            		svrCRUD(params,function(text){
		            var errCode = text.errCode||"";
		            var errMsg = text.errMsg||"";
		            if(errCode == 'S'){
		            	nui.unmask(document.body);
		                var params = {
		                    interType: interType,
		                    data:{
		                        serviceId: main.id||0
		                    }
		                }
		                getBillDetail(params, function(text){
		                    var errCode = text.errCode;
		                    var data = text.data||[];
		                    if(errCode == "S"){
		                        if(interType == 'package'){
		                            rpsPackageGrid.clearRows();
		                            rpsPackageGrid.addRows(data);
		                            rpsPackageGrid.accept();
		                            if(main.status<2){
		                            	var row = rpsPackageGrid.findRow(function(row){
		                            		rpsPackageGrid.beginEditRow(row);
		                                });
		                            }
		                        }else if(interType == 'item'){
		                            rpsItemGrid.clearRows();
		                            rpsItemGrid.addRows(data);
		                            rpsItemGrid.accept();
		                            if(main.status<2){
		                            	var row = rpsItemGrid.findRow(function(row){
		                            		rpsItemGrid.beginEditRow(row);
		                                });
		                            }
		                        }
		                    }
		                }, function(){});
		            }else{
		                showMsg(errMsg||"添加预存信息失败!","E");
		                nui.unmask(document.body);
		                return;
		            }
                   });
            	});
            }
            
        }else{
            showMsg("请选择记录!","W");
            return;
        }
    }else if(type == 1){
        var data = {};
        var pkg = {
            serviceId:main.id,
            packageId:rtnRow.id,
            cardDetailId:0
        };
        data.pkg = pkg;

        var params = {
            type:"insert",
            interType:'package',
            data:data
        };
        nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '数据加载中...'
        });
        savePkg(function(){
        	nui.unmask(document.body);
        	 svrCRUD(params,function(text){
                 var errCode = text.errCode||"";
                 var errMsg = text.errMsg||"";
                 if(errCode == 'S'){
                	 nui.unmask(document.body);
                     var params = {
                         interType: 'package',
                         data:{
                             serviceId: main.id||0
                         }
                     }
                     getBillDetail(params, function(text){
                         var errCode = text.errCode;
                         var data = text.data||[];
                         if(errCode == "S"){
                             rpsPackageGrid.clearRows();
                             rpsPackageGrid.addRows(data);
                             rpsPackageGrid.accept();
                             if(main.status<2){
                             	var row = rpsPackageGrid.findRow(function(row){
                             		rpsPackageGrid.beginEditRow(row);
                                 });
                             }
                         }
                     }, function(){});
                 }else{
                     showMsg(errMsg||"添加套餐失败!","E");
                     nui.unmask(document.body);
                     return;
                 }
             });
        });
       
    }else if(type == 2){
        var data = {};
        var insItem = {
            serviceId:main.id||0,
            itemId:rtnRow.id,
            cardDetailId:0
        };
        data.insItem = insItem;
        data.serviceId = main.id||0;

        var params = {
            type:"insert",
            interType:'item',
            data:data
        };
        nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '数据加载中...'
        });
        saveItem(function(){
        	nui.unmask(document.body);
        	svrCRUD(params,function(text){
                var errCode = text.errCode||"";
                var errMsg = text.errMsg||"";
                if(errCode == 'S'){
                	nui.unmask(document.body);
                    var params = {
                        interType: 'item',
                        data:{
                            serviceId: main.id||0
                        }
                    }
                    getBillDetail(params, function(text){
                        var errCode = text.errCode;
                        var data = text.data||[];
                        if(errCode == "S"){
                            rpsItemGrid.clearRows();
                            rpsItemGrid.addRows(data);
                            rpsItemGrid.accept();
                            if(main.status<2){
                            	var row = rpsItemGrid.findRow(function(row){
                            		rpsItemGrid.beginEditRow(row);
                                });
                            }
                        }
                    }, function(){});
                }else{
                    showMsg(errMsg||"添加项目信息失败!","E");
                    nui.unmask(document.body);
                    return;
                }
            });
        }); 
    }else if(type == 3){
        var data = {};
        var insPart = {
            serviceId:main.id||0,
            partId:rtnRow.id,
            cardDetailId:0,
            partCode:rtnRow.code
        };
        data.insPart = insPart;
        data.serviceId = main.id||0;

        var params = {
            type:"insert",
            interType:'part',
            data:data
        };
        nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '数据加载中...'
        });
        saveItem(function(){
        	nui.unmask(document.body);
        	svrCRUD(params,function(text){
                var errCode = text.errCode||"";
                var errMsg = text.errMsg||"";
                if(errCode == 'S'){
                	nui.unmask(document.body);
                    var params = {
                        interType: 'part',
                        data:{
                            serviceId: main.id||0
                        }
                    }
                    getBillDetail(params, function(text){
                        var errCode = text.errCode;
                        var data = text.data||[];
                        if(errCode == "S"){
                            //rpsPartGrid.clearRows();
                            //rpsPartGrid.addRows(data);
                        }
                    }, function(){});
                }else{
                    showMsg(errMsg||"添加预存信息失败!","E");
                	nui.unmask(document.body);
                    return;
                }
            });
        });
        
    }
}

function deleteItemRow(row_uid){
    var main = billForm.getData();
    var isSettle = main.isSettle||0;
    if(!main.id){
        showMsg("请选择保存工单!","W");
        return;
    }
    var status = main.status||0;
    if(status == 2){
        showMsg("工单已完工,不能删除项目!","W");
        return;
    }
    if(isSettle == 1){
        showMsg("工单已结算,不能删除项目!","W");
        return;
    }

    var data = rpsItemGrid.getData();
    var row = rpsItemGrid.getRowByUID(row_uid);
    var id = row.id;
    if(data && data.length==1){
        row = data[0];
    }
    var item = {
        serviceId:row.serviceId,
        id:row.id,
        cardDetailId:row.cardDetailId||0
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
        	var rows = rpsItemGrid.findRows(function(row){
                if(row.id == id || row.billItemId == id){
                    return true;
                }
            });
        	rpsItemGrid.removeRows(rows);
        	//rpsItemGrid.accept();
        }else{
            showMsg(errMsg||"删除项目信息失败!","E");
            return;
        }
    });
}


function setBillForm(params){
    fserviceId = params.id;
    if(!params.id){
        add();
    }else{
        nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '数据加载中...'
        });
        var params = {
            data: {
                id: params.id
            }
        };
        getMaintain(params, function(text){
            var errCode = text.errCode||"";
            var data = text.maintain||{};
            var lastEnterKilometers = data.lastEnterKilometers || 0;
            $("#lastComeKilometers").html(lastEnterKilometers);
            if(errCode == 'S'){
            	xyguest = data;
                var p = {
                    data:{
                        guestId: data.guestId||0,
                        contactorId: data.contactorId||0,
                        carId:data.carId || 0,
                    }
                };
                getGuestContactorCar(p, function(text){
                    var errCode = text.errCode||"";
                    var guest = text.guest||{};
                    var car = text.car || {};
                    var carExtend = text.carExtend || {};
                    var contactor = text.contactor||{};
                    contactorF = contactor;
                    if(errCode == 'S'){
/*                        $("#servieIdEl").html(data.serviceCode);
                        if(currIsOpenElectronics == "1") {
	                        if(data.isElectronics == 1) {
		                        document.getElementById("showE1").style.display = 'none';
		                    	document.getElementById("showE").style.display="";
	                        }else {
	                        	document.getElementById("showE1").style.display = "";
	                        	document.getElementById("showE").style.display='none';
	                        }
                        }*/
                    	
/*                        var carNo = data.carNo||"";
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

                        var sk = document.getElementById("search_key");*/
/*                        sk.style.display = "none";
                        if(contactor.wechatOpenId){
                        	document.getElementById("showA").style.display = "";
                        	document.getElementById("showA1").style.display='none';
                        }else{
                        	document.getElementById("showA").style.display='none';
                        	document.getElementById("showA1").style.display = "";
                        }*/
/*                        searchNameEl.setVisible(true);

                        searchNameEl.setValue(t);
                        searchNameEl.setEnabled(false);*/
    
                        data.guestFullName = guest.fullName;
                        data.guestMobile = guest.mobile;
                        data.contactorName = contactor.name;
                        data.sex = contactor.sex;
                        data.mobile = contactor.mobile;
                        data.carModel = car.carModel;
                        data.carModelIdLy = car.carModelIdLy||"";
                        data.insureCompName = car.insureCompName || "";
                        data.insureDueDate = car.insureDueDate || "";
                        data.insureNo = car.insureNo || "";
                        data.annualInspectionCompName = car.annualInspectionCompName || "";
                        data.annualInspectionNo = car.annualInspectionNo || "";
                        data.annualInspectionDate = car.annualInspectionDate || "";
                        data.idNo = contactor.idNo;
                        data.remark = contactor.remark;
                        
                        $("#guestNameEl").html(guest.fullName);
                        $("#showCarInfoEl").html(data.carNo);
                        $("#guestTelEl").html(guest.mobile);

                        fguestId = data.guestId||0;
                        fcarId = data.carId||0;

/*                        doSearchCardTimes(fguestId,fcarId);
                        doSearchItemTimes(fguestId,fcarId);
                        doSearchMemCard(fguestId);
                        doSearchSell(fguestId);*/
                        
                        billForm.setData(data);
/*                        insuranceForm.setData(data);*/
                        var status = data.status||0;
                        var balaAuditSign = data.balaAuditSign||0;
                        if(balaAuditSign==1){                    	
                        	doSetStyle(status, balaAuditSign);
                        }else{
                        	var isSettle = data.isSettle||0;
                        	doSetStyle(status, isSettle);                       	
                        }                    
/*                        sendGuestForm.setData(data);
                        //设置联系人姓名
                        nui.get("contactorName").setText(contactor.name);
                        describeForm.setData(data);*/

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
                        var p3 = {
                            interType: "part",
                            data:{
                                serviceId: data.id||0
                            }
                        }
                        loadDetail(p1, p2, p3,data.status);
                    }else{
                        showMsg("数据加载失败,请重新打开工单!","W");
                    }
    
                }, function(){});
            }else{
                showMsg('数据加载失败!','W');
            }
        }, function(){
            nui.unmask(document.body);
        })
    }
}

function loadDetail(p1, p2, p3,status){
/*    if(p1 && p1.interType){
        getBillDetail(p1, function(text){
            var errCode = text.errCode;
            var data = text.data||[];
            if(errCode == "S"){
                rpsPackageGrid.clearRows();
                for(var i=0;i<data.length;i++){
                	if(data[i].qty==0){
                  		data[i].qty=1;
                  	}
                }
                rpsPackageGrid.addRows(data);
                rpsPackageGrid.accept();
                if(status<2){
                	var row = rpsPackageGrid.findRow(function(row){
                		rpsPackageGrid.beginEditRow(row);
                    });
                }
            }
        }, function(){});
    }*/
    if(p2 && p2.interType){
        getBillDetail(p2, function(text){
            var errCode = text.errCode;
            var data = text.data||[];
            if(errCode == "S"){
                rpsItemGrid.clearRows();
                for(var i=0;i<data.length;i++){
                	if(data[i].qty==0){
                  		data[i].qty=1;
                  	}
                }
                rpsItemGrid.addRows(data);
                rpsItemGrid.accept();
                if(status<2){
                	 var row = rpsItemGrid.findRow(function(row){
                		 rpsItemGrid.beginEditRow(row);
                     });
                }
            }
        }, function(){});
    }
}
var sumItemSubtotal = 0;
var sumItemPrefAmt = 0;
var sumPartSubtotal = 0;
var sumPartPrefAmt = 0;


function onDrawSummaryCellItem(e){
/*	  var data = sellForm.getData();*/
	  var rows = e.data;
	  sumItemSubtotal = 0;
	  sumItemPrefAmt = 0;
	  var sumItemAmt = 0;
	  sumPartSubtotal = 0;
	  sumPartPrefAmt = 0;
	  var sumPartAmt = 0;
	  // || e.field == "amt"
	  if(e.field == "subtotal") 
	  {   
		  gsAmt = 0;
		  for (var i = 0; i < rows.length; i++)
		  {
			  if(rows[i].cardDetailId>0){
				  gsAmt=gsAmt+rows[i].subtotal;
			  }
			 if(rows[i].billItemId=="0"){
				 sumItemSubtotal += parseFloat(rows[i].subtotal);
				 sumItemAmt  += parseFloat(rows[i].amt); 
			 }else{
				 sumPartSubtotal += parseFloat(rows[i].subtotal);
				 sumPartAmt  += parseFloat(rows[i].amt); 
			 }
			   
		  }
		  
	  }  
}

function save(){
	itemF = "S";
	pkgF = "S";
	partF = "S";
	//判断里程
	var last =  $("#lastComeKilometers").text() || 0;
	var enterKilometers = nui.get("enterKilometers").getValue() || 0;
	if(enterKilometers>0 && enterKilometers < last){
		showMsg("进厂里程不能小于上次里程","W");
		return;
	}
	var data = billForm.getData(true);
	
	if(data.status == 2){
		showMsg("工单已完工","W");
        return;        
    }
	if(data.isSettle == 1){
		showMsg("工单已结算","W");
        return;        
    }
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });
    
    saveMaintain(function(data){
    	saveItem(function(){
    	});       
    },function(){ 
        nui.unmask(document.body);
    });
}

var saveMaintainUrl = baseUrl + "com.hsapi.repair.repairService.crud.saveRpsMaintain.biz.ext";
function saveMaintain(callback,unmaskcall){
    var data = billForm.getData(true);
    var status = data.status;
    var serviceId = data.id;
/*    var desData = describeForm.getData(true);*/
/*    for(var v in desData){
        data[v] = desData[v];
    }*/
    if(data.planFinishDate) {
		data.planFinishDate = format(data.planFinishDate, 'yyyy-MM-dd HH:mm:ss');
	}
    if(data.enterDate) {
		data.enterDate = format(data.enterDate, 'yyyy-MM-dd HH:mm:ss');
	}
/*	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
            unmaskcall && unmaskcall();
            nui.get(key).focus();
            showMsg(requiredField[key] + "不能为空!","W");
			return;
		}
    }*/
    /*if(data.id) {
    	delete data.enterDate;
    }*/
    data.billTypeId = 0;
    data.lastEnterKilometers = $("#lastComeKilometers").text() || 0;
    var params = {
        data:{
            maintain:data
        }
    };
    svrSaveMaintain(params, function(text){
        var errCode = text.errCode||"";
        if(errCode == "S") {
        	//工单保存成功之后,设置表单的值
        	var main = text.data||{};
            fserviceId = main.id||0;
        	var carModel = nui.get("carModel").value || "";
        	if(carModel != ""){
        		main.carModel = carModel;
        	}
        	billForm.setData(main);      	
           // unmaskcall && unmaskcall();
            callback && callback(main);
        } else {
            unmaskcall && unmaskcall();
            showMsg(data.errMsg || "保存单据失败","E");
        }
    }, function(){
        unmaskcall && unmaskcall();
    })
}

function onValueChangedComQty(e){
	var el = e.sender;
	var flag = isNaN(e.value);
	var rowtime = rpsItemGrid.getEditorOwnerRow(el);
	var setItemTime = rpsItemGrid.getCellEditor("itemItemTime", rowtime);
	var itemTime = el.getValue();
	if (flag) {
		showMsg("请输入数字!","W");
		setItemTime.setValue(e.oldValue);
		e.cancel = true; 
	}else if(itemTime<0){
		showMsg("工时/数量不能小于0","W");
		setItemTime.setValue(e.oldValue);
		e.cancel = true; 
		return;
	}else if(itemTime == "" || itemTime == null){	
		setItemTime.setValue(e.oldValue);
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
		setUnitPrice.setValue(e.oldValue);
		e.cancel = true; 
	}else if(unitPrice<0){
		
		showMsg("单价不能小于0","W");
		setUnitPrice.setValue(e.oldValue);
		e.cancel = true; 
		return;
	}else if(unitPrice == "" || unitPrice == null){	
		setUnitPrice.setValue(e.oldValue);
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
		setRate.setValue(e.oldValue);
		return;
	} else if(rate<0 || rate>100){	
		showMsg("请输入0到100之间的数!","W");
		setRate.setValue(e.oldValue);
		e.cancel = true; 
		return;
	}else if(rate == "" || rate == null){	
		setRate.setValue(e.oldValue);
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
		setSubtotal.setValue(e.oldValue);
		e.cancel = true; 
	}else if(subtotal<0){
		showMsg("金额不小于0","W");
		setSubtotal.setValue(e.oldValue);
		e.cancel = true; 
		return;
	}else if(subtotal == "" || subtotal == null){
		setSubtotal.setValue(e.oldValue);
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
		}else{
			subtotal = 0;
			setSubtotal.setValue(subtotal);
		}
		
	}	
}

//选择配件业务，修改优惠率和小计金额
function onValueChangedItemTypeId(e){
   var maintain = billForm.getData();
   var el = e.sender;
   var row = rpsItemGrid.getEditorOwnerRow(el);
	//获取指定列和行的编辑器控件对象
	var setSubtotal = rpsItemGrid.getCellEditor("itemSubtotal", row);
	var setUnitPrice = rpsItemGrid.getCellEditor("itemUnitPrice", row);
	var setItemTime = rpsItemGrid.getCellEditor("itemItemTime", row);
	var setRate = rpsItemGrid.getCellEditor("itemRate", row);	  
	var json = nui.encode({
		"serviceTypeId" : el.getValue(),
		"guestId":maintain.guestId,
		token : token
	});
	//item_discount_rate
	nui.ajax({
		url : scTyIdUrl,
		type : 'POST',
		data : json,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			var returnJson = nui.decode(text);
			if (returnJson.errCode == "S") {
				var cardRate = returnJson.cardRate;
				var itemDiscountRate = cardRate.itemDiscountRate;
				var unitPrice = setUnitPrice.getValue()||0;
				var itemTime = setItemTime.getValue()||0;
				var amt = 0;
				if(unitPrice>0 && itemTime>0){
					amt = unitPrice*itemTime;
					amt = amt.toFixed(2);
				}	
				var subtotal = 0;
			    if(amt>0){
			    	subtotal = amt - itemDiscountRate*1.0*amt;
			    	subtotal = subtotal.toFixed(2);
			    }
			    itemDiscountRate = (itemDiscountRate*100).toFixed(2);
			    setRate.setValue(itemDiscountRate);
			    setSubtotal.setValue(subtotal);				
			} else {
				//showMsg("出库失败");
			}			
		}
	});
}

function saveItem(callback){
	var main = billForm.getData();
	var status = main.status||0;
    var isSettle = main.isSettle||0;
    if(!main.id){
        showMsg("请选择保存工单!","W");
        return;
    }
    if(status == 2){
        showMsg("工单已完工,不能修改项目!","W");
        return;
    }
    if(isSettle == 1){
        showMsg("工单已结算,不能修改项目!","W");
        return;
    }
    rpsItemGrid.commitEdit();
    var rows = rpsItemGrid.getChanges("modified");
    if(status<2){
    	var row = rpsItemGrid.findRow(function(row){
    		rpsItemGrid.beginEditRow(row);
        });
    }
    var updList = [];
    var updPartList = [];
    if(rows && rows.length>0){
    	var serviceId = null;
    	for(var i = 0;i<rows.length;i++){
    		var row = rows[i];
    		serviceId = row.serviceId||0;
            var cardDetailId = row.cardDetailId||0;
            if(cardDetailId > 0){ //预存的
                var item = {};
                item.id = row.id;
                item.remark = row.remark;
                item.serviceId = row.serviceId;
                item.serviceTypeId = row.serviceTypeId;
                item.workerIds = row.workersId;
                item.workers = row.workers;
                if(row.planFinishDate){
                	item.planFinishDate = row.planFinishDate;
                }
                if(row.billItemId == "0"){
                	updList.push(item);
                }else{
                	updPartList.push(item);
                }
                
            }else{
                var item = {};
                item.id = row.id;
                item.remark = row.remark;
                //row.serviceId,可能会获取不到值，接口里面会重新赋值
                item.serviceId = row.serviceId;
                item.amt = row.amt;
                item.subtotal = row.subtotal;
                var rate = row.rate/100;
                rate = rate.toFixed(4);
                item.rate = rate;
                item.unitPrice = row.unitPrice;
                item.serviceTypeId = row.serviceTypeId;
                if(row.workersId){
                	item.workerIds = row.workersId;
                    item.workers = row.workers;
                }
                item.saleMan = row.saleMan;
                item.saleManId = row.saleManId;
                if(row.planFinishDate){
                	item.planFinishDate = row.planFinishDate;
                }
                if(row.billItemId == "0"){
                	item.itemTime = row.qty;
                	updList.push(item);
                }else{
                	item.qty = row.qty;
                	updPartList.push(item);
                }
            }
            
    	}
    	var params = {
                type:"update",
                interType:"item",
                data:{
                    serviceId: serviceId,
                    updList : updList
                }
        };
    	 var params1 = {
                 type:"update",
                 interType:"part",
                 data:{
                     serviceId: serviceId,
                     updList : updPartList
                 }
             };
    	   /* console.log("updItem:");
    	    console.log(updList);
    	    console.log("updPartList:");
    	    console.log(updPartList);*/
    	 if(updList && updList.length>0){
    		 svrCRUD(params,function(text){
                 var errCode = text.errCode||"";
                 var errMsg = text.errMsg||"";
                 if(errCode == 'S'){   
                	 itemF = "S";
                	 showMsg("保存成功","W");
                 }else{
                	 itemF = "E";
                 	/*rpsItemGrid.reject();
                     rpsItemGrid.accept();
                     showMsg(errMsg||"修改数据失败!","E");
                     return;*/
                 }
                 if(updPartList && updPartList.length>0){
                	 svrCRUD(params1,function(text){
                         var errCode = text.errCode||"";
                         var errMsg = text.errMsg||"";
                         if(errCode == 'S'){   
                        	 partF = "S";
                        	 showMsg("保存成功","W");
                         }else{
                        	 partF = "E";
                         }
                         callback && callback();
                     }); 
                 }else{
                	 callback && callback();
                 }
             });
    	 }else if(updPartList && updPartList.length>0){
    		 svrCRUD(params1,function(text){
                 var errCode = text.errCode||"";
                 var errMsg = text.errMsg||"";
                 if(errCode == 'S'){   
                	 partF = "S";
                	 showMsg("保存成功","S");
                 }else{
                	 partF = "E";
                 }
                 callback && callback();
             });
    	 }
      }else{
    	  callback && callback();
      }
   /* var endData = rpsItemGrid.getData();
    console.log("end:");
    console.log(endData);*/
}


function setInitData(params){
	if(params.serviceId){		
		fserviceId = params.serviceId;
	}
}
function onSearch(){
	var carNo = nui.get("carNo").getValue();
	var serviceCode = nui.get("serviceCode").getValue();
	var p={
			carNo : carNo,
			serviceCode:serviceCode,
			noMtType : 1,
			isDisabled: 0,
			page : {
				pageSize:9999
			}
	}
	mainGrid1.load({
		params:p,
    	token:token
	});
}

function activechangedmain(){
	var tabs = nui.get("mainTabs").getActiveTab();
	if(pickName==null||pickName==""){
		return;
	}
	if(tabs.name=="queryRepairOutList"){
		//出库
	    var params={
				pickName : pickName,
				sortField : "a.record_date",
				sortOrder : "desc"
	    }
	    queryRepairOutListGrid.load({params:params});
	}else if(tabs.name=="queryPjPchsOrderEnterDetailChkList"){
	    //入库
	    var params={
				pickName : pickName,
				sortField : "a.audit_date",
				sortOrder : "desc"
	    }
	    queryPjPchsOrderEnterDetailChkListGrid.load({params:params});
	}else if(tabs.name=="queryPartStoreStock"){
		//库存
	    var params={
				pickName : pickName
	    }
	    queryPartStoreStockGrid.load({params:params});
	}
}


function releaseOfferRemind(){
	var saveRpsPartUrl = baseUrl + "com.hsapi.repair.repairService.crud.saveOffer.biz.ext";
	
	nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '消息推送中...'
    });
	
	nui.ajax({
		url : saveRpsPartUrl,
		type : "post",
		data : {
			serviceId:fserviceId,
			updList:[],
			type:1,
			token:token
		},
		success : function(data) {
			if(data.errCode == "S"){
				//pc提醒
				var carNo = xyguest.carNo;
				var carModel = xyguest.carModel;
				var serviceCode = xyguest.serviceCode;
				var content = "您好,"+carNo + "("+carModel+"),已完成报价 !";
				var mtAdvisorId = nui.get("mtAdvisorId").getValue();
				var msg = {
					title: "配件已报价",
					serviceCode: serviceCode,
					serviceId :fserviceId,
					remindType : 2,
					url:webPath + contextPath + "//com.hsweb.RepairBusiness.repairBill.flow",
					urlId : 2000,
					content: content,
					sender: currUserName,
					sendDate: now.Format("yyyy-MM-dd HH:mm:ss")
				};
				getUserInfo(mtAdvisorId, null, function(text){
					var memberList = text.data || [];
					for(var i=0;i<memberList.length;i++){
						member = memberList[i];
						var userId = member.imCode;
						var params = {
							type: 3,
							cmd: 10,
							group: null,
							sender: "0",
							receiver: userId.toString(),
							msg: nui.encode(msg)
						};
						sendNoticeMsg(parent.socket,params);
					}
				});
			}
	});
} 