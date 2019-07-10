/*
    1、套餐选择界面
    2、工时选择界面
    3、配件选择界面

    4、添加次卡接口调用
    5、添加/修改/删除套餐接口调用
    6、添加/修改/删除工时接口调用
    7、添加/修改/删除配件接口调用

    8、工单数据查询判断接口调用

    9、工单主表数据查询接口调用，分不同工单类型

    10、车辆信息，客户信息，维修记录

    11、车况查询

	12、充值，办卡
	
	13、确定维修

	14、质检&完工     完工

	15、返工

	16、结算

	17、打印报价单，派工单，结算单，小票，领料单

	18、购买计次卡，充值

	19、报销单
	
	20、获取收支项目

*/

var mUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.svr.getRpsMaintainByParams.biz.ext";
function checkRpsMaintain(params, callback){
	doPost({
		url : mUrl,
		data : params,
		success : function(data) {
			callback && callback(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
			callback && callback(null);
		}
	});
}

var getGuestContactorCarUrl =  window._rootRepairUrl + "com.hsapi.repair.repairService.svr.getGuestContactorCar.biz.ext";
function getGuestContactorCar(params, callback, unmaskcall){
    var data = params.data||{};
    doPost({
		url : getGuestContactorCarUrl,
		data : data,
		success : function(data) {
            unmaskcall && unmaskcall();
			callback && callback(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
            unmaskcall && unmaskcall();
			console.log(jqXHR.responseText);
			callback && callback(null);
		}
	});
}

var getdRpsMaintainUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.sureMt.getRpsMaintainById.biz.ext";
function getMaintain(params, callback, unmaskcall){
    var data = params.data||{};

    doPost({
		url : getdRpsMaintainUrl,
		data : data,
		success : function(data) {
            unmaskcall && unmaskcall();
			callback && callback(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
            unmaskcall && unmaskcall();
			console.log(jqXHR.responseText);
			callback && callback(null);
		}
	});
}

var getdRpsPackageUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.svr.getRpsPackagePItemPPart.biz.ext";
//var getRpsItemUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.svr.getRpsMainItem.biz.ext";
var getRpsItemUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.svr.getRpsItemPPart.biz.ext";
var getRpsPartUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.svr.getRpsMainPart.biz.ext";
function getBillDetail(params, callback, unmaskcall){
    var interType = params.interType||"";// package item part
    var data = params.data||{};
    var url = "";
    if(interType == "package"){
        url = getdRpsPackageUrl;
    }else if(interType == "item"){
        url = getRpsItemUrl;
    }else if(interType == "part"){
        url = getRpsPartUrl;
    }

    doPost({
		url : url,
		data : data,
		success : function(data) {
            unmaskcall && unmaskcall();
			callback && callback(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
            unmaskcall && unmaskcall();
			console.log(jqXHR.responseText);
		}
	});
}


var addRpsPackageUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.insRpsPackage.biz.ext";
var updRpsPackageUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.updRpsPackage.biz.ext";
var delRpsPackageUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.deleteRpsPackage.biz.ext";

var addRpsPartUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.insRpsPart.biz.ext";
var updRpsPartUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.saveRpsPart.biz.ext";
var delRpsPartUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.deleteRpsPart.biz.ext";


var addRpsItemUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.insRpsItem.biz.ext";
var updRpsItemUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.saveRpsItem.biz.ext";
var delRpsItemUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.deleteRpsItemAndPart.biz.ext";

function svrCRUD(params, callback, unmaskcall){
    var type = params.type||""; // insert update delete
    var interType = params.interType||"";// package item part
    var data = params.data||{};
    var url = "";
    if(type == "insert"){
        if(interType == "package"){
            url = addRpsPackageUrl;
        }else if(interType == "item"){
            url = addRpsItemUrl;
        }else if(interType == "part"){
            url = addRpsPartUrl;
        }
    }else if(type == "update"){
        if(interType == "package"){
            url = updRpsPackageUrl;
        }else if(interType == "item"){
            url = updRpsItemUrl;
        }else if(interType == "part"){
            url = updRpsPartUrl;
        }
    }else if(type == "delete"){
        if(interType == "package"){
            url = delRpsPackageUrl;
        }else if(interType == "item"){
            url = delRpsItemUrl;
        }else if(interType == "part"){
            url = delRpsPartUrl;
        }
    }

    doPost({
		url : url,
		data : data,
		success : function(data) {
            unmaskcall && unmaskcall();
			callback && callback(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
            unmaskcall && unmaskcall();
			console.log(jqXHR.responseText);
			callback && callback(null);
		}
	});
}

//保存工单主表信息
var svrSaveMaintainUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.saveRpsMaintain.biz.ext";
function svrSaveMaintain(params, callback, unmaskcall){
    var data = params.data||{};
    doPost({
		url : svrSaveMaintainUrl,
		data : data,
		success : function(data) {
			callback && callback(data);
			unmaskcall && unmaskcall(null);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
			unmaskcall && unmaskcall(null);
		}
	});
}

//确定维修
var svrSureMTUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.sureMt.repairSureMt.biz.ext";
function svrSureMT(params, callback, unmaskcall){
    var data = params.data||{};
    doPost({
		url : svrSureMTUrl,
		data : data,
		success : function(data) {
			callback && callback(data);
			unmaskcall && unmaskcall(null);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
			unmaskcall && unmaskcall(null);
		}
	});
}

//质检&完工
var svrRepairAuditUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.work.repairAudit.biz.ext";
function svrRepairAudit(params, callback, unmaskcall){
    var data = params.data||{};
    doPost({
		url : svrRepairAuditUrl,
		data : data,
		success : function(data) {
			callback && callback(data);
			unmaskcall && unmaskcall(null);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
			unmaskcall && unmaskcall(null);
		}
	});
}

//返单
var svrUnRepairAuditUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.work.unRepairAudit.biz.ext";
function svrUnRepairAudit(params, callback, unmaskcall){
    var data = params.data||{};
    doPost({
		url : svrUnRepairAuditUrl,
		data : data,
		success : function(data) {
			callback && callback(data);
			unmaskcall && unmaskcall(null);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
			unmaskcall && unmaskcall(null);
		}
	});
}

//删除工单
var svrDelBillUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.updateRpsDisabled.biz.ext";
function svrDelBill(params, callback, unmaskcall){
    var data = params.data||{};
    doPost({
		url : svrDelBillUrl,
		data : data,
		success : function(data) {
			callback && callback(data);
			unmaskcall && unmaskcall(null);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
			unmaskcall && unmaskcall(null);
		}
	});
}

//批量设置套餐优惠率
var svrSetPkgRateBatchUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.setPkgRateBatch.biz.ext";
function svrSetPkgRateBatch(params, callback, unmaskcall){
    var data = params.data||{};
    doPost({
		url : svrSetPkgRateBatchUrl,
		data : data,
		success : function(data) {
			callback && callback(data);
			unmaskcall && unmaskcall(null);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
			unmaskcall && unmaskcall(null);
		}
	});
}

//批量设置施工员
var svrSetPkgWorkersBatchUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.setItemWorkersBatch.biz.ext";
function svrSetWorkersBatch(params, callback, unmaskcall){
    var data = params.data||{};
    doPost({
		url : svrSetPkgWorkersBatchUrl,
		data : data,
		success : function(data) {
			callback && callback(data);
			unmaskcall && unmaskcall(null);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
			unmaskcall && unmaskcall(null);
		}
	});
}

//批量设置销售员
var svrSetSaleMansBatchUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.setSalersBatch.biz.ext";
function svrSetPkgSaleMansBatch(params, callback, unmaskcall){
    var data = params.data||{};
    doPost({
		url : svrSetSaleMansBatchUrl,
		data : data,
		success : function(data) {
			callback && callback(data);
			unmaskcall && unmaskcall(null);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
			unmaskcall && unmaskcall(null);
		}
	});
}

//批量设置工时或是配件优惠率
var svrSetItemPartRateBatchUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.setItemPartRateBatch.biz.ext";
function svrSetItemPartRateBatch(params, callback, unmaskcall){
    var data = params.data||{};
    doPost({
		url : svrSetItemPartRateBatchUrl,
		data : data,
		success : function(data) {
			callback && callback(data);
			unmaskcall && unmaskcall(null);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
			unmaskcall && unmaskcall(null);
		}
	});
}

var inComeExpensesUrl = window._rootFrmUrl + "com.hsapi.frm.frmService.crud.queryFibInComeExpenses.biz.ext";
function svrInComeExpenses(params, callback) {
    //var params = {itemTypeId : 1, isMain: 0};
    nui.ajax({
        url : inComeExpensesUrl,
        data : {
            params: params,
            token: token
        },
        type : "post",
        success : function(data) {
            if (data && data.list) {
                callback && callback(data);
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}

//新增客户
function doApplyCustomer(params,callback){
    nui.open({
        url: webPath + contextPath + "/com.hsweb.repair.DataBase.AddEditCustomer.flow?token="+token,
        title:"新增客户资料",
        width:560,
        height:600,
        onload:function(){
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData(params);
        },
        ondestroy:function(action)
        {
            callback && callback(action);
        }
    });
}

function doSelectCustomer(callback) {
    nui.open({
        url: webBaseUrl + "com.hsweb.RepairBusiness.Customer.flow?token="+token,
        title: "客户选择", width: 800, height: 450,
        onload: function () {
        },
        ondestroy: function (action) {
            if ("ok" == action) {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                var guest = data.guest;
                callback && callback(guest);
            }
        }
    });
}

function doShowCarInfo(params) {
    nui.open({
        url: webBaseUrl + "com.hsweb.RepairBusiness.carDetails.flow?token="+token,
        width: 1000, height: 600,
		allowResize: false,
		showHeader: true,
        onload: function () {
			var iframe = this.getIFrameEl();
			iframe.contentWindow.SetData(params);
        },
        ondestroy: function (action) {
            if ("ok" == action) {
            }
        }
    });
}

function doSelectPart(itemId,dock, dodelck, docck, callback) {
	nui.open({
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
            iframe.contentWindow.setViewData(itemId,dock, dodelck, docck);
		},
		ondestroy : function(action) {
            var iframe = this.getIFrameEl();
            var data = iframe.contentWindow.getData();
            data = data || {};
            data.action = action;
            callback && callback(data);
		}
	});
}


//com.hsweb.repair.DataBase.RepairItemMain.flow
function doSelectItem(dock, dodelck, docck, param, callback) {
	nui.open({
		url : webPath + contextPath + "/com.hsweb.repair.DataBase.itemChoose.flow?token=" + token,
		title : "维修项目",
		width : 1000,
		height : 560,
		allowDrag : true,
		allowResize : true,
		onload : function() {
			var iframe = this.getIFrameEl();
			var params = {
				carModelIdLy : param.carModelIdLy,
				serviceId: param.serviceId,
				carNo:param.carNo
			};
            iframe.contentWindow.setData(params);//显示该显示的功能
            iframe.contentWindow.setViewData(dock, dodelck, docck);
		},
		ondestroy : function(action) {
            var iframe = this.getIFrameEl();
            var data = iframe.contentWindow.getData();
            data = data || {};
            data.action = action;
            callback && callback(data);
		}
	});
}

function doSelectPackage(dock, dodelck, docck, param, callback) {
	nui.open({
		url : webPath + contextPath + "/repair/DataBase/Card/packageList.jsp?token=" + token,
		title : "套餐项目",
		width : 1000,
		height : 560,
		allowDrag : true,
		allowResize : true,
		onload : function() {
			var iframe = this.getIFrameEl();
			var params = {
				carModelIdLy : param.carModelIdLy,
				serviceId: param.serviceId,
				carNo:param.carNo
			};

            iframe.contentWindow.setViewData(dock, dodelck, docck, params);
		},
		ondestroy : function(action) {
            var iframe = this.getIFrameEl();
            var data = iframe.contentWindow.getData();
            data = data || {};
            data.action = action;
            callback && callback(data);
		}
	});
}

function doAddcardTime(xyguest){
    var item={};
    item.id = "timesCard";
    item.text = "计次卡销售";
    item.url = webPath + contextPath + "/com.hsweb.frm.manage.cardTimesSettlement.flow?token="+token;
    item.iconCls = "fa fa-file-text";
    var params = {
    		xyguest:xyguest,
    			cardType:1 //计次卡
    		};
    window.parent.activeTabAndInit(item,params);
}

function doAddcard(xyguest){
    var item={};
    item.id = "card";
    item.text = "储值卡充值";
    item.url = webPath + contextPath + "/com.hsweb.frm.manage.cardSettlement.flow?token="+token;
    item.iconCls = "fa fa-file-text";
    var params = {
    		xyguest:xyguest,
    			cardType:2 
    		};
    window.parent.activeTabAndInit(item,params);
}

/*var addcardTimeUrl = webPath + contextPath  + "/repair/DataBase/Card/timesCardList.jsp?token="+token;
function doAddcardTime(params,callback){	
	
	nui.open({
		url : addcardTimeUrl,
		title : "计次卡选择",
		width : 965,
		height : 573,
		onload : function() {
		    var iframe = this.getIFrameEl();
			iframe.contentWindow.setStely();
			iframe.contentWindow.setData(params);
		},
		ondestroy : function(action) {// 弹出页面关闭前
            var iframe = this.getIFrameEl();
            var data = iframe.contentWindow.getData();
            data = data || {};
            data.action = action;
            callback && callback(data);
		}
	});
	
}*/

/*var addcardTimeUrl = webPath + contextPath  + "/com.hsweb.frm.manage.cardSettlement.flow?token="+token;
function doAddcardTime(params,callback){	
	
	nui.open({
		url : addcardTimeUrl,
		title : "计次卡购买",
		width : "100%",
		height : "100%",
		onload : function() {
		    var iframe = this.getIFrameEl();
		    params.cardType=1;//计次卡
			iframe.contentWindow.setData(params);
		},
		ondestroy : function(action) {// 弹出页面关闭前
            var iframe = this.getIFrameEl();
            var data = iframe.contentWindow.getData();
            if(data.action == "ok"){
                showMsg("结算成功!","S");
            }else if(data.action == "onok"){
            	showMsg("转预结算成功!","S");
            }
		}
	});
	
}*/

/*function doAddcard(params,callback){

	nui.open({
		url:webPath + contextPath +"/com.hsweb.repair.DataBase.cardList.flow?token"+token,
		title: "储值卡充值", width: 1100, height: 573,
		onload: function(){
			var iframe=this.getIFrameEl();	
			iframe.contentWindow.setStely();
			iframe.contentWindow.setData(params);		
		},
		onedestroy: function(action){
            var iframe = this.getIFrameEl();
            var data = iframe.contentWindow.getData();
            data = data || {};
            data.action = action;
            callback && callback(data);
		}
	});

}*/

/*function doAddcard(params,callback){
	nui.open({
		url:webPath + contextPath +"/com.hsweb.frm.manage.cardSettlement.flow?token?token"+token,
		title: "储值卡充值",
		width : "100%",
		height : "100%",
		onload: function(){
			var iframe=this.getIFrameEl();	
			 params.cardType=2;//储值卡卡
			iframe.contentWindow.setData(params);		
		},
		onedestroy: function(action){
            var iframe = this.getIFrameEl();
            var data = iframe.contentWindow.getData();
            if(data.action == "ok"){
                showMsg("结算成功!","S");
            }else if(data.action == "onok"){
            	showMsg("转预结算成功!","S");
            }
		}
	});

}*/

//产品录入
function addPackage(data,callback){
	//获取到套餐的数据
	var pkg = data.pkg;
}

function doFinishWork(params,callback){
	nui.open({
        url: webPath + contextPath +"/com.hsweb.RepairBusiness.checkFinish.flow?token="+token,
        title: "完工", width: 700, height: 400, allowDrag:false, allowResize:false,
        onload: function () {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action) {
			var iframe = this.getIFrameEl();
			var data = iframe.contentWindow.getRtnData();
			data = data || {};
			data.action = action;
			callback && callback(data);
        }
    });
}
function doSelectBasicData(BasicDataUrl,title,params,callback){
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


function doSetStyle(status, isSettle){
	status = status||0;
    isSettle = isSettle||0;
	if(isSettle == 1){
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
	}
}


function doNoPay(serviceId,allowanceAmt){
	var json = {
			serviceId:serviceId,
			allowanceAmt:allowanceAmt,
			token:token
	};
	
    nui.confirm("确定将此单加入待结算", "友情提示",function(action){
	       if(action == "ok"){
			    nui.mask({
			        el : document.body,
				    cls : 'mini-mask-loading',
				    html : '处理中...'
			    });
				nui.ajax({
					url : window._rootRepairUrl + "com.hsapi.repair.repairService.settlement.preReceiveSettle.biz.ext" ,
					type : "post",
					data : json,
					success : function(data) {
						if(data.errCode=="S"){
							nui.unmask(document.body);
							nui.alert("待结算成功","提示");
						}else{
							nui.unmask(document.body);
							nui.alert(data.errMsg,"提示");
						}

					},
					error : function(jqXHR, textStatus, errorThrown) {
						// nui.alert(jqXHR.responseText);
						console.log(jqXHR.responseText);
					}
				});		
	     }else {
				return;
		 }
	});
}

function doPrint(params){
	var source = params.source||0;
	var serviceId = params.serviceId||0;
	var sourceUrl = "";
	var printName = currRepairSettorderPrintShow||currOrgName;
	var p = {
		serviceId : serviceId,
		comp : printName,
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
        currIsCanfreeCarnovin:currIsCanfreeCarnovin,
		token : token 
	};
	if(source == 1){  //打印报价单
		sourceUrl = webPath + contextPath + "/com.hsweb.print.settlement.flow?token="+token;
		p.name = "报价单";
		p.currRepairEntrustPrintContent = currRepairEntrustPrintContent;
	}else if(source == 2){  //打印派工单
		sourceUrl = webPath + contextPath + "/com.hsweb.print.repairOrder.flow?token="+token;
		p.name = "派工单";
	}else if(source == 3){  //打印结算单
		sourceUrl = webPath + contextPath + "/com.hsweb.print.settlement.flow?token="+token;
		p.name = "结账单";
		p.currRepairSettPrintContent = currRepairSettPrintContent;
	}else if(source == 4){  //打印小票
		sourceUrl = webPath + contextPath + "/com.hsweb.print.smallSettlement.flow?token="+token;
		p.name = "结账单";
	}else if(source == 5){  //打印领料单
		sourceUrl = webPath + contextPath + "/com.hsweb.print.materialRequisition.flow?token="+token;
		p.name = "领料单";
	}else if(source == 6){  //打印报销单
		sourceUrl = webPath + contextPath + "/com.hsweb.print.settlement.flow?token="+token;
		p.name = "报销单";
	}else if(source == 7){  //打印查车单
		sourceUrl = webPath + contextPath + "/com.hsweb.print.checkCar.flow?token="+token;
		p.name = "查车单";
	}else if(source == 8){
		sourceUrl = webPath + contextPath + "/com.hsweb.print.settlementPart.flow?token="+token;
		p.name = "报价单";
		p.currRepairEntrustPrintContent = currRepairEntrustPrintContent;
	}else if(source == 9){
		sourceUrl = webPath + contextPath + "/com.hsweb.print.settlementPart.flow?token="+token;
		p.name = "结账单";
		p.currRepairSettPrintContent = currRepairSettPrintContent;
	}else if(source == 10){
		sourceUrl = webPath + contextPath + "/com.hsweb.print.smallSettlementPart.flow?token="+token;
		p.name = "结账单";
	}else if(source == 11){
		sourceUrl = webPath + contextPath + "/com.hsweb.print.repairOrderPart.flow?token="+token;
		p.name = "派工单";
	}
	
	nui.open({
        url: sourceUrl,
        title: p.name + "打印",
		width: "100%",
		height: "100%",
        onload: function () {
            var iframe = this.getIFrameEl();
           iframe.contentWindow.SetData(p);
        },
        ondestroy: function (action){
        }
    });
}
function doBillExpenseDetail(params,callback){
	nui.open({
        url: webPath + contextPath +"/com.hsweb.RepairBusiness.billExpenseDetail.flow?token="+token,
        title: "费用登记", width: "60%", height: "60%", 
        onload: function () {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action) {
			var iframe = this.getIFrameEl();
			callback && callback();
        }
    });
}
function doBillPay(params,callback){
	nui.open({
        url: webPath + contextPath +"/com.hsweb.RepairBusiness.billSettle.flow?token="+token,
        title: "工单结算", width: "100%", height: "100%", 
        onload: function () {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action) {
			var iframe = this.getIFrameEl();
			var data = iframe.contentWindow.getRtnData();
			data = data || {};
			data.action = action;
			callback && callback(data);
        }
    });
}

//出车报告
//repair/DataBase/OutCar/OutCarReport.jsp
function doOutCarMainExpenseDetail(params,callback){
	nui.open({
        url: webPath + contextPath +"/repair/DataBase/OutCar/SelectOutCarReport.jsp?token="+token,
        title: "出车报告", width: "30%", height: "40%", 
        onload: function () {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action) {
			/*var iframe = this.getIFrameEl();
			callback && callback();*/
        }
    });
}
//预览
function preview(url){
	var str = url.substr(url.length-8, 4);
	if(str=="logo"){
		return;
	}
	isOpen = false;
	nui.open({
	    url: webPath + contextPath
		+ "/com.hsweb.repair.repoart.preview.flow?token="+token,
	    title: "预览图片",
		width: "700px",
		height: "600px",
		allowResize : false,
	    onload: function () {
	        var iframe = this.getIFrameEl();
	        iframe.contentWindow.setData(url);
	    },
	    ondestroy: function (action){
	    	isOpen = true;
	    }
	});
}

function completionWeChat(maintain){
	 var completionWeChatUrl = baseUrl + "com.hsapi.repair.repairService.sendWeChat.sendFinishMTInfo.biz.ext";
		var json = nui.encode({
			"maintain":maintain,
			token : token
		});
	  nui.ajax({
			url : completionWeChatUrl,
			type : 'POST',
			data : json,
			cache : alse,
			contentType : 'text/json',
			success : function(text) {
				var returnJson = nui.decode(text);
			}
		});
}
/*function importTimeLimit(){
	var d2=new Date();
	var fullYear = d2.getFullYear();
	var month = d2.getMonth()+1;
	var date = d2.getDate();
	
	var limitMinData = fullYear+"-"+month+"-"+date+" 23:00:00"  
	var limitMaxData = fullYear+"-"+month+"-"+(date+1)+" 05:00:00" 
	limitMinData = limitMinData.replace("-","/");//替换字符，变成标准格式  
	limitMaxData = limitMaxData.replace("-","/");//替换字符，变成标准格式   
	var d1 = new Date(Date.parse(limitMinData)); 
	var d3 = new Date(Date.parse(limitMaxData)); 
	if(d2>d1&&d2<d3){
		return true;
	}else{
		return false;
	}
}*/
