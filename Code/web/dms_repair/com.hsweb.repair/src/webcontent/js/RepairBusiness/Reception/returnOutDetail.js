var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
var partUrl = apiPath + partApi + "/";

var mainGrid = null;
var repairOutGrid = null;
var mid = null;//主表ID
var mainRow = null;  
var outParams={};
var status=null; //主表状态 1待归库2归库

var servieTypeList = [];
var servieTypeHash = {};
var mtAdvisorIdEl = null; 
var searchKeyEl = null; 
var servieIdEl = null; 
var searchNameEl = null;
var billForm = null;
var guestInfoUrl = baseUrl + "com.hsapi.repair.repairService.svr.queryCustomerWithContactList.biz.ext";
var mainGridUrl =  baseUrl + "com.hsapi.repair.repairService.query.getRpsPartByServiceId.biz.ext";
var repairOutGridUrl =  partUrl + "com.hsapi.repair.repairService.query.queryRepairOut.biz.ext";
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
/*	if(actionType == "ll"){
		mainGrid.load({serviceId:mid});
	}
	if(actionType == "th"){

	}*/

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


//    mainGrid.on("celldblclick",function(e){
//        var field = e.field;
//        var record = e.record;
//        var column = e.column;
//        LLSave();
//    });

    repairOutGrid.on("celldblclick",function(e){
        var field = e.field;
        var record = e.record;
        var column = e.column;
        THSave();
    });

});


function setInitData(params){
	mid = params.id;
	status=params.row.status;
	//serviceCode = params.row.serviceCode;
	mainRow = params.row;
	outParams={
        	returnSign :0,
        	mainIdList :params.row.mainIdList	
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

                        //$("#guestNameEl").html(guest.guestFullName);
                        //$("#showCarInfoEl").html(data.carNo);
                        //$("#guestTelEl").html(guest.mobile);

                        //fguestId = data.guestId||0;
                        //fcarId = data.carId||0;

                       // doSearchCardTimes(fguestId);
                        //doSearchMemCard(fguestId);

                        billForm.setData(data);
                        //mainGrid.setUrl("com.hsapi.repair.baseData.query.QueryRpsCheckDetailList.biz.ext");
                        //mainGrid.load({mainId:params.id});
                        mainGrid.load({serviceId:params.id,token:token},function(){
                        	vaildUpdate();
                        });
                   
                        if(status==1){
                        	repairOutGrid.load({params:outParams,token:token});                   	
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

//
//function LLSave(argument) {
//	var rows = mainGrid.getSelecteds();
//	if (rows.length > 0) {
//		for (var i = 0, l = rows.length; i < l; i++) {
//			var r = rows[i].partId;
//			var c = rows[i].partCode;
//			var recordId = rows[i].id;
//			if(r){
//				openPartSelect(r,"Id",recordId,mainRow);
//			}else if(c){ 
//				openPartSelect(c,"Code",recordId,mainRow);
//			}else{
//				showMsg('部分配件需单独领取!','W');
//				return;
//			}
//		}
//
//	}else{
//		showMsg('请先选择配件!','W');
//	}
//}

function openPartSelect(par,type,id,row){
	nui.open({
		url: webBaseUrl + "com.hsweb.RepairBusiness.partSelect.flow?token="+token,
		title:"选择配件",
		height:"400px",
		width:"900px",
		onload:function(){
			var iframe = this.getIFrameEl();
			iframe.contentWindow.SetData(par,type,id,row);
		},
		ondestroy:function(action){ 
            mainGrid.load({serviceId:mid,token:token});
            repairOutGrid.load({params:outParams,token:token});
        }

    });
}


 
function THSave(){
	var rows = repairOutGrid.getSelecteds();
	var data = mainGrid.getData();
	for(var i=0;i<data.length;i++){
		for(var j=0;j<rows.length;j++){
			if(rows[j].mainId==data[i].detailId){
				rows[j].mId=data[i].id;
			}			
		}
	}
	if (rows.length > 0) {
		for (var i = 0; i < rows.length; i++) {
			if(rows[i].returnSign == 0){
//				memberSelect(rows[i]);
				onBlack(rows[i]);
			}else{
				showMsg('该条数据已归库!','W');
				return;
			}
		}
	}else{
		showMsg('请先选择需要归库的配件!','W');
	}
}

function  savepartOutRtn(data,childdata){
	if(data){
		var paramsDataArr = [];
            //var paramsData = nui.clone(data);
            var paramsData = {};
            paramsData.serviceId = data.serviceId;
            paramsData.mId=data.mId//待出库-配件信息的ID
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
            paramsData.outQty = childdata.outQty;
            paramsData.enterPrice = data.enterPrice;
            paramsData.billTypeId = '050206';
            paramsData.storeId = data.storeId;
            paramsData.unit = data.unit;
            paramsData.returnMan = childdata.returnMan;
            paramsData.returnRemark = childdata.returnRemark;
            //paramsData.pickType = "维修出库-领料";
            paramsData.taxUnitPrice = data.taxUnitPrice;
            paramsData.taxAmt = data.taxAmt;
            paramsData.noTaxUnitPrice = data.noTaxUnitPrice;
            paramsData.noTaxAmt = data.noTaxAmt;
            paramsData.trueUnitPrice = data.trueUnitPrice;
            paramsData.trueCost = data.trueCost;
            paramsData.sellUntiPrice = data.sellUntiPrice;
            paramsData.sellAmt = data.sellAmt;
            if(!paramsData.partNameId){
            	paramsData.partNameId = "0";
            }
            if(paramsData.outQty>data.outQty){
            	showMsg("归库数量超过可归数量","W");
            	return;
            }
            paramsDataArr.push(paramsData);


            //console.log(paramsData);
            //console.log(tdata);
            //return;
            nui.ajax({
            	url:baseUrl + "com.hsapi.repair.repairService.work.repairOutRtn.biz.ext",
            	type:"post",
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
            		}else{
            			showMsg('归库失败!','E');
            		}
            	}
            });
        }else{
        	showMsg('没有需要归库的配件!','W');
        }
    }
	
	function onBlack(row) {	
		nui.open({
			url : webPath+ partDomain+ "/manage/inOutManage/common/fastPartForConsumableAdd2.jsp?token"+ token,
			title : "归库",
			width : 430,
			height : 230,
			allowDrag : false,
			allowResize : false,
			onload : function() {
				var iframe = this.getIFrameEl();
				var params = {
					data : row
				};
	
				iframe.contentWindow.SetData(params);
			},
			ondestroy : function(action) {
				if (action == 'ok') {
	
    				var iframe = this.getIFrameEl();
    				var childdata = iframe.contentWindow.GetFormData();
    				savepartOutRtn(row,childdata);
				}
			}
		});
	
	}

    function memberSelect(row){
    	nui.open({
    		url: webBaseUrl + "com.hsweb.RepairBusiness.partSelectMember.flow?token="+token,
    		title:"选择归库人",
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
//        			mainGrid.load({serviceId:mid,token:token});
//        			repairOutGrid.load({params:outParams,token:token});
        			showMsg('更新成功!','S');
        		}else{
        			showMsg('更新失败!','E');
        		}
        	}
        });
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