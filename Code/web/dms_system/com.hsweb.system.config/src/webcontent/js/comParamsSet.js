var baseUrl = apiPath + repairApi + "/";
var clientGridUrl = baseUrl + "com.hsapi.cloud.part.report.report.querySellClient.biz.ext";
var basicInfoForm = null;
var repairBillControlFlag = null;
var repairBillPartFlag = null;
var repairPartAuditFlag = null;
var repairBillQrcodeFlag = null;
var repairBillQrSettleFlag = null;
var repairBillCmodelFlag = null;
var repairBillCmodelFlagT = null;
var repairBillMobileFlag = null;
var editParice = null;
var rate = null;
var openToArchives = null;
var openToGuestQrcode = null;
var repairDefaultStore = null;
var repairPchsRtnFlag = null;
var repairStoreControlFlag = null;
 
$(document).ready(function(v) {
    basicInfoForm = new nui.Form("#basicInfoForm");
    //repairBillControlFlag = nui.get("repairBillControlFlag");
    repairBillPartFlag = nui.get("repairBillPartFlag");
    repairPartAuditFlag = nui.get("repairPartAuditFlag");
    repairBillQrcodeFlag = nui.get("repairBillQrcodeFlag");
    repairBillQrSettleFlag = nui.get("repairBillQrSettleFlag");
    repairBillCmodelFlag = nui.get("repairBillCmodelFlag");
    repairBillCmodelFlagT = nui.get("repairBillCmodelFlagT");
    repairBillMobileFlag = nui.get("repairBillMobileFlag");
    repairStoreControlFlag = nui.get("repairStoreControlFlag");
    editParice = nui.get("editParice");
    repairPchsRtnFlag = nui.get("repairPchsRtnFlag");
    //rate = nui.get("rate");
    openToArchives = nui.get("openToArchives");
    openToGuestQrcode = nui.get("openToGuestQrcode");
    repairDefaultStore = nui.get("repairDefaultStore");
    nui.get("repairSettorderPrintShowT").disable();
    
    //repairBillControlFlag.setData(radioList);
    repairPchsRtnFlag.setData(radioList);
    repairBillPartFlag.setData(radioList);
    repairBillQrcodeFlag.setData(radioList);
    repairBillQrSettleFlag.setData(radioList);
    repairBillCmodelFlag.setData(radioList);
    repairBillCmodelFlagT.setData(radioList);
    repairBillMobileFlag.setData(radioList);
    repairStoreControlFlag.setData(radioList);
    openToArchives.setData(typeList);
    openToGuestQrcode.setData(typeList);
    
    getStore();

    getServiceTypeList(function(data){
        editParice.setData(data);
        repairPartAuditFlag.setData(data);
    });

    getComParamsList();

});
var radioList = [{id:1,text:"开启"},{id:0,text:"关闭"}];
var typeList = [{id:1,text:"正常服务"},{id:2,text:"理赔"},{id:3,text:"返工"},{id:4,text:"索赔"},{id:5,text:"免单"}];
function doSearch()
{
    getComParamsList();
	
}
/*
{id:1,text:"保养"},{id:0,text:"钣金"},{id:0,text:"喷漆"},{id:0,text:"美容"},{id:0,text:"洗车"},
                       {id:0,text:"机修"},{id:0,text:"精品"},{id:0,text:"改装"},{id:0,text:"轮胎"},{id:0,text:"其他"}]
*/
var serviceTypeList = [];
var serviceTypeUrl = baseUrl + "com.hsapi.repair.common.common.getBusinessType.biz.ext";
function getServiceTypeList(callback){
    var params = {sortField:'id',sortOrder:'asc',isDisabled:0};
    nui.ajax({
		url : serviceTypeUrl,
        type : "post",
        async:false,
		data : JSON.stringify({
			params : params,
			token: token
		}),
		success : function(data) {
			nui.unmask(document.body);
            data = data || {};
            var list = data.list;
			if (list && list.length>0) {
				for(var i=0; i<list.length; i++){
                    var type = list[i];
                    var serviceTypeObj = {id:(i+1), text:type.name};
                    serviceTypeList.push(serviceTypeObj);
                    callback && callback(serviceTypeList);
                }
			} else {
				parent.showMsg("工单设置信息读取失败,请联系管理员!","W");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}
var billParams = {};
var comParamsUrl = apiPath + sysApi + "/com.hsapi.system.config.paramSet.queryBillParams.biz.ext";
function getComParamsList(){
    var params = {isDisabled:0};
    nui.ajax({
		url : comParamsUrl,
        type : "post",
        async:false,
		data : JSON.stringify({
			params : params,
			token: token
		}),
		success : function(data) {
			nui.unmask(document.body);
            data = data || {};
            billParams = data.billParams;
			if (billParams) {
                basicInfoForm.setData(billParams);
                if(!billParams.repairBillMobileFlag){
                	repairBillMobileFlag.setValue("0");
                }
			} 
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}
/*function onRateValidation(e){
    if (e.isValid) {
        var reg=/(^[1-9][0-9]$|^[0-9]$|^100$)/;
        if (!reg.test(e.value)) {
            e.errorText = "输入0~100的整数";
            e.isValid = false;
        }
    }
}*/
var saveUrl = apiPath + sysApi + "/com.hsapi.system.config.paramSet.saveBillParams.biz.ext";
function save(){
    basicInfoForm.validate();
    if (basicInfoForm.isValid() == false) {
        parent.showMsg("税率:请输入0~100的整数!","W");
        return;
    }

    var data = basicInfoForm.getData();
    var paramsList = [];
    for(var key in data){
        var value = data[key];
        if(billParams[key] != value){
            var paramsObj = {keyidId:key, keyidValue:value};
            paramsList.push(paramsObj);
        }
    }

    nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '保存中...'
	});

	nui.ajax({
		url : saveUrl,
		type : "post",
		data : {
			billParams: paramsList,
			token: token
		},
		success : function(data) {
			nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
				parent.showMsg("保存成功!","S");
				
			} else {
				parent.showMsg(data.errMsg || "保存失败!","E");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
            nui.unmask(document.body);
			console.log(jqXHR.responseText);
		}
	});
}
var storeUrl = apiPath + partApi + "/com.hsapi.part.baseDataCrud.crud.getStorehouse.biz.ext";
function getStore(){
    nui.ajax({
		url : storeUrl,
        type : "post",
        async:false,
		data : JSON.stringify({
            token:token
        }),
		success : function(data) {
			nui.unmask(document.body);
            data = data || {};
			if (data.storehouse) {
                
                repairDefaultStore.setData(data.storehouse);
                
			} else{
                parent.showMsg("添加仓库后才可以设置默认仓库!","W");
            }
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}