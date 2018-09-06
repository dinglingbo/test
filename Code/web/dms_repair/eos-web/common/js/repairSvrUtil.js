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
			// nui.alert(jqXHR.responseText);
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
function svrCRUD(params,callback){
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
			callback && callback(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
			callback && callback(null);
		}
	});
}