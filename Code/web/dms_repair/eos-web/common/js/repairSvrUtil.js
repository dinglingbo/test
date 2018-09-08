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
		url : webPath + contextPath + "/com.hsweb.part.baseData.partMgr.flow?token=" + token,
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
