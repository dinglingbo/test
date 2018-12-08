var basicInfoForm = null;
var repairMemLevelDeductFlag = null;
var repairDeductKpiFlag = null;
 
$(document).ready(function(v) {
    basicInfoForm = new nui.Form("#basicInfoForm");
    repairMemLevelDeductFlag = nui.get("repairMemLevelDeductFlag");
    repairDeductKpiFlag = nui.get("repairDeductKpiFlag");
    
    repairMemLevelDeductFlag.setData(radioList);
    repairDeductKpiFlag.setData(deductList);
   
    getComParamsList();

});
var radioList = [{id:1,text:"开启"},{id:0,text:"关闭"}];
var deductList = [{id:1,text:"原价"},{id:2,text:"理赔"},{id:3,text:"产值"}];
function doSearch()
{
    getComParamsList();
	
}
var billParams = {};
var comParamsUrl = apiPath + sysApi + "/com.hsapi.system.config.paramSet.queryBasicDeductParams.biz.ext";
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

    var data = basicInfoForm.getData();
    var paramsList = [];
    for(var key in data){
        var value = data[key];
        var paramsObj = {keyidId:key, keyidValue:value};
        paramsList.push(paramsObj);
        
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