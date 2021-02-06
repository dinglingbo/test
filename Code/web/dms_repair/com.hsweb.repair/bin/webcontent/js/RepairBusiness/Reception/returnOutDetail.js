var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
var partUrl = apiPath + partApi + "/";

var mainGrid = null;
var repairOutGrid = null;
var mid = null;//主表ID
var mainRow = null;  
var outParams={};
var status=null; //主表状态 1待归库2归库
var mainIdStr=null;
var mainIdList=null;
var advancedPartWin=null;
 
var servieTypeList = [];
var servieTypeHash = {};
var mtAdvisorIdEl = null; 
var searchKeyEl = null; 
var servieIdEl = null; 
var searchNameEl = null;
var billForm = null;
var guestInfoUrl = baseUrl + "com.hsapi.repair.repairService.svr.queryCustomerWithContactList.biz.ext";
var mainGridUrl =  baseUrl + "com.hsapi.repair.repairService.query.getRpsPartByServiceId.biz.ext";
var repairOutGridUrl =  baseUrl + "com.hsapi.repair.repairService.query.queryRepairOut.biz.ext";
var fserviceId = 0;
var returnSignData = [{id:0,text:"未归库"},{id:1,text:"已归库"}];
$(document).ready(function(){


	mainGrid = nui.get("mainGrid");
	repairOutGrid = nui.get("repairOutGrid");
	mainGrid.setUrl(mainGridUrl);
	repairOutGrid.setUrl(repairOutGridUrl);
	billForm = new nui.Form("#billForm");
	mtAdvisorIdEl = nui.get("mtAdvisorId");
	servieIdEl = nui.get("servieIdEl");
	searchKeyEl = nui.get("search_key");
	searchNameEl = nui.get("search_name");
	
	advancedPartWin=nui.get('advancedPartWin');


	initMember("mtAdvisorId",function(){
		memList = mtAdvisorIdEl.getData();
	});

	mtAdvisorIdEl.on("valueChanged",function(e){
		var text = mtAdvisorIdEl.getText();
		nui.get("mtAdvisor").setValue(text);
	});

    initServiceType("serviceTypeId",function(data) {
        servieTypeList = nui.get("serviceTypeId").getData();
        servieTypeList.forEach(function(v) {
          servieTypeHash[v.id] = v;
      });
    });

    mainGrid.on("drawcell", function (e) {
        if (e.field == "serviceTypeId") {
            if (servieTypeHash && servieTypeHash[e.value]) {
                e.cellHtml = servieTypeHash[e.value].name;
            }
        }

    });
    
    repairOutGrid.on("drawcell", function (e) {
        if(e.field =="stockQty"){
        	if(!e.row.outReturnQty){
        		e.cellHtml=e.row.stockQty-0;
        	}else{
        		e.cellHtml=e.row.stockQty-e.row.outReturnQty;
        	}
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
        onOut();
    });
    
    document.onkeyup = function(event) {
        var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下
        

        if ((keyCode == 27)) { // ESC
        	onCancel();
        }

    }
});


function setInitData(params){
	mid = params.id;
	status=params.row.status;
	//serviceCode = params.row.serviceCode;
	mainRow = params.row;
	mainIdStr=params.row.mainIdStr;
	mainIdList =params.row.mainIdList;
	outParams={
        	returnSign :0,
        	mainId :params.row.detailId	
        };
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
    					data.carBrandModel=mainRow.carBrandModel;
    					data.mtAdvisorId=mainRow.mtAdvisorId;
    					data.mtAdvisor=mainRow.mtAdvisor;
    					data.sureMtMan =mainRow.sureMtMan;

                        billForm.setData(data);
//                        nui.ajax({
//                            url: mainGridUrl,
//                            type : "post",
//                            data : {
//                            	serviceId : params.id,
//            	                	token : token
//                            },
//                            async: false,
//                            success: function (text) {
//                               var maintain = nui.decode(text.maintain);
//                               if(text.errCode == "S"){
//                               		var data=text.data;
//                               		mainGrid.load({id:mainIdStr,token:token},function(){
//                               			vaildUpdate();
//                               		});
//                               }
//                            },
//                            error: function (jqXHR, textStatus, errorThrown) {
//                                console.log(jqXHR.responseText);
//                                showMsg("网络出错", "W");
//                            }
//                        });
                        mainGrid.load({serviceId:params.id,token:token},function(){
                        	vaildUpdate();
                        });
                   

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


function THSave(){

	var rows = repairOutGrid.getChanges('modified');
	 for(var i=0;i<rows.length;i++){
     	if(!rows[i].outQty2 || rows[i].outQty2==="0" ){
     		rows.splice(i,1);
     		i=i-1;
     	}
     }
	var mainData = mainGrid.getData();
	for(var i=0;i<mainData.length;i++){
		for(var j=0;j<rows.length;j++){
			if(rows[j].mainId==mainData[i].detailId){
				rows[j].mId=mainData[i].id;
				var qty=mainData[i].qty;
	      		var pickQty=mainData[i].pickQty;
				if(rows[j].outQty2>qty - pickQty || rows[j].outQty2>rows[j].outQty-rows[j].outReturnQty){
			      	showMsg("归库数量超过可归数量","W");
			      	return;
			      }
			}			
		}
	}
	if (rows.length > 0) {
		for (var i = 0; i < rows.length; i++) {
			if(rows[i].outQty2==0 || !rows[i].outQty2){
				showMsg("归库数量不能为0","W");
				return;
			}
	
			if(rows[i].returnSign == 0){
//				memberSelect(rows[i]);
//				onBlack(rows[i]);
				
			}else{
				showMsg('该条数据已归库!','W');
				return;
			}
		}
	}else{
		showMsg('请先选择需要归库的配件!','W');
		return;
	}
	
	savepartOutRtn(rows);
}

function  savepartOutRtn(data){
	if(data){
		var paramsDataArr = [];
            //var paramsData = nui.clone(data);
		 for (var i = 0; i < data.length; i++) { 
            var paramsData = {};
            paramsData.serviceId = data[i].serviceId;
//            paramsData.mId=data.mId//待出库-配件信息的ID
            paramsData.id = data[i].id;
            paramsData.mainId = data[i].mId;//待出库-配件信息的ID
            paramsData.sourceId = data[i].id;
            paramsData.serviceId = mainRow.id;
            paramsData.serviceCode = mainRow.serviceCode;
            paramsData.carNo = mainRow.carNO;
            paramsData.vin = mainRow.carVin;
            paramsData.guestId = mainRow.guestId;
            paramsData.guestName = mainRow.guestFullName;
            paramsData.partId = data[i].partId;
            paramsData.partCode = data[i].partCode;
            paramsData.oemCode = data[i].oemCode;
            paramsData.partName = data[i].partName;
            paramsData.partNameId = data[i].partNameId;
            paramsData.partFullName = data[i].partFullName;
            paramsData.stockQty = data[i].stockQty;
            paramsData.outQty = data[i].outQty2;
            paramsData.enterPrice = data[i].enterPrice;
            paramsData.billTypeId = '050108';
            paramsData.storeId = data[i].storeId;
            paramsData.unit = data[i].unit;
            paramsData.returnMan = currUserName;
            paramsData.remark = data[i].remark;
//            paramsData.pickType = "维修出库-领料";
            paramsData.taxUnitPrice = data[i].taxUnitPrice;
            paramsData.taxAmt = data[i].taxAmt;
            paramsData.noTaxUnitPrice = data[i].noTaxUnitPrice;
            paramsData.noTaxAmt = data[i].noTaxAmt;
            paramsData.trueUnitPrice = data[i].trueUnitPrice;
            paramsData.trueCost = data[i].trueCost;
            paramsData.sellUnitPrice = data[i].sellUnitPrice;
            paramsData.sellAmt = data[i].sellAmt;
            if(!paramsData.partNameId){
            	paramsData.partNameId = "0";
            }
      
            paramsDataArr.push(paramsData);
		 }

            //console.log(paramsData);
            //console.log(tdata);
            //return;
            nui.ajax({
            	url:baseUrl + "com.hsapi.repair.repairService.work.repairOutRtn.biz.ext",
            	type:"post",
            	async: false,
            	data:{
            		data:paramsDataArr,
            		billTypeId:"050206", 
            		flag :"1",
            		token:token
            	},
            	success:function(text){
            		var errCode = text.errCode; 
            		if(errCode == "S"){
            			showMsg('归库成功!','S');
            			mainGrid.load({serviceId:mid,token:token},function(){
            				vaildUpdate();
            			});
            			
            			repairOutGrid.load({params:outParams,token:token}); 
            			advancedPartWin.hide();
            		}else{
            			showMsg(text.errMsg ||'归库失败!','W');
            		}
            	}
            });
        }else{
        	showMsg('没有需要归库的配件!','W');
        }
    }
	


    function onGenderRenderer(e) {
    	for (var i = 0, l = returnSignData.length; i < l; i++) {
    		var g = returnSignData[i];
    		if (g.id == e.value) return g.text;
    	}
    	return "";
    }


    
    //判断mainGrid已归库数量和归库数量一致时改变状态为已归库
    function vaildUpdate(){
    	var count=0;
    	var data=mainGrid.getData();
    	if(status==2){
    		return;
    	}
    	for(var i=0;i<data.length;i++){
    		if(data[i].qty==data[i].pickQty){
    			count=count+1;
    		}
    		if(count==data.length){
    			update();
    			
    		}
    	}
    }

    function update(){
        nui.ajax({
        	url:baseUrl + "com.hsapi.repair.repairService.sureMt.updateMaintainStatus.biz.ext",
        	type:"post",
        	data:{
        		id:mid,
        		token: token
        	},
        	success:function(text){
        		var errCode = text.errCode; 
        		if(errCode == "S"){
//        			showMsg('更新成功!','S');
        			status=2;
        		}else{
        			showMsg('更新失败!','E');
        		}
        	}
        });
    }
    function onOut(){
    	
    	var data=mainGrid.getSelected();
    	
    	if(!data){
    		showMsg('请先选择一条记录',"W");
    		return;
    	}
    	if(status==2 ||data.status==2){
    		showMsg("配件已归库","W");
    		return;
    	}
    	outParams={
            	returnSign :0,
            	mainId :data.detailId	
            };
    	if(data && status==1){
    		repairOutGrid.load({params:outParams,token:token});
    	 	advancedPartWin.show();
    	}
    }
    
    function onCancel(){
    	advancedPartWin.hide();
    }
//    function onPrint(e){
//        var main = billForm.getData();
//        var openUrl = null;
//        if(main.id){
//            var params = {
//                source : e,
//                serviceId : mainRow.id,
//                isSettle : mainRow.isSettle
//            };
//            
//            doPrint(params);
//        }else{
//            showMsg("请先保存工单,再打印!","W");
//            return;
//        }
//    }