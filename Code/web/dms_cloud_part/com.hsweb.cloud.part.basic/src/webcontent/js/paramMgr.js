var baseUrl = apiPath + sysApi + "/";
var basicInfoForm = null;
var swithBatchFlag=null;
var repairSettorderPrintShow =null;
var cloudSellOrderPrintContent =null;
var isNeedNewLine = null;
var isOpenCredit = null;
var isOnlySeeOwn=null;
var isCanSeePrice = null;
var radioList = [{id:1,text:"开启"},{id:0,text:"关闭"}];
$(document).ready(function(v) {
	 basicInfoForm = new nui.Form("#basicInfoForm");
	 swithBatchFlag =nui.get("swithBatchFlag");
	 repairSettorderPrintShow =nui.get('repairSettorderPrintShow');
	 cloudSellOrderPrintContent = nui.get('cloudSellOrderPrintContent');
	 isNeedNewLine =nui.get('isNeedNewLine'); 
	 isOpenCredit = nui.get('isOpenCredit');
	 isOnlySeeOwn =nui.get('isOnlySeeOwn');
	 isCanSeePrice = nui.get('isCanSeePrice');
	 swithBatchFlag.setData(radioList);
	 isNeedNewLine.setData(radioList);
	 isOpenCredit.setData(radioList);
	 isOnlySeeOwn.setData(radioList);
	 isCanSeePrice.setData(radioList);
	 getComParamsList();
	 	
	 
});
function doSearch()
{
    getComParamsList();
	
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
              
			} 
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}

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


