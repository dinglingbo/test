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

var addRpsPackageUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.insRpsPackage.biz.ext";
var updRpsPackageUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.updRpsPackage.biz.ext";
var delRpsPackageUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.deleteRpsPackage.biz.ext";

var addRpsItemUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.insRpsItem.biz.ext";
var updRpsItemUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.saveRpsItem.biz.ext";
var delRpsItemUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.deleteRpsItem.biz.ext";

var addRpsPartUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.insRpsPart.biz.ext";
var updRpsPartUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.saveRpsPart.biz.ext";
var delRpsPartUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.deleteRpsPart.biz.ext";
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
var getRpsItemUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.svr.getRpsMainItem.biz.ext";
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

//新增客户
function doApplyCustomer(params,callback){
    nui.open({
        url: webPath + contextPath + "/com.hsweb.repair.DataBase.AddEditCustomer.flow?token="+token,
        title:"新增客户资料",
        width:560,
        height:570,
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

function doSelectItem(dock, dodelck, docck, callback) {
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
			var list = [];
			var params = {
				list : list
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


function doSelectPart(dock, dodelck, docck, callback) {
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
			var list = [];
			var params = {
				list : list
			};
            iframe.contentWindow.setData(params);
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


function doSelectPackage(dock, dodelck, docck, callback) {
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
			var list = [];
			var params = {
				list : list
			};

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






var addcardTimeUrl = webPath + contextPath  + "/repair/DataBase/Card/timesCardList.jsp?token="+token;
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
	
}

function doAddcard(params,callback){
		params={
				data:params
		}
		nui.open({
			url:webPath + contextPath +"/repair/RepairBusiness/CustomerProfile/CardUp.jsp?token"+token,
			title: "储值卡充值", width: 600, height: 460,
			onload: function(){
				var iframe=this.getIFrameEl();	
				iframe.contentWindow.SetData(params);		
			},
			onedestroy: function(action){
	            var iframe = this.getIFrameEl();
	            var data = iframe.contentWindow.getData();
	            data = data || {};
	            data.action = action;
	            callback && callback(data);
			}
		});

}
//产品录入


function addPackage(data,callback){
	//获取到套餐的数据
	var pkg = data.pkg;
}

function doSelectBasicData(params,callback){
	nui.open({
        url: webPath + contextPath +"/com.hsweb.RepairBusiness.ProductEntry.flow?token="+token,
        title: "标准化产品查询", width: 900, height: 600,
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

function doFinishWork(params,callback){
	nui.open({
        url: webPath + contextPath +"/com.hsweb.RepairBusiness.checkFinish.flow?token="+token,
        title: "质检&完工", width: 800, height: 270, allowDrag:false, allowResize:false,
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
    nui.mask({
        el : document.body,
	    cls : 'mini-mask-loading',
	    html : '处理中...'
    });
	// 跨页面传递的数据对象，克隆后才可以安全使用
	
	var json = {
			serviceId:serviceId,
			allowanceAmt:allowanceAmt
	}
	
	nui.ajax({
		url : baseUrl
		+ "com.hsapi.repair.repairService.settlement.preReceiveSettle.biz.ext" ,
		type : "post",
		data : json,
		async: false,
		success : function(data) {
			if(data.errCode=="S"){
				nui.unmask(document.body);
				nui.alert("保存转待结算成功","提示");
			}else{
				nui.unmask(document.body);
				nui.alert("保存转待结算失败","提示");
			}

		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});

}