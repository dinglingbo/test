var basicInfoForm = null;
var repairPchsRtnFlag = null;
var repairPartOutCancelFlag = null;
var repairDefaultStore = null;

 
$(document).ready(function(v) {
    basicInfoForm = new nui.Form("#basicInfoForm");
    repairPchsRtnFlag = nui.get("repairPchsRtnFlag");
    repairPartOutCancelFlag = nui.get("repairPartOutCancelFlag");
    repairDefaultStore = nui.get("repairDefaultStore");
    
    repairPchsRtnFlag.setData(radioList);
    repairPartOutCancelFlag.setData(radioList);
   
    getStore();
    getStockParamsList();

});
var radioList = [{id:1,text:"开启"},{id:0,text:"关闭"}];
function doSearch()
{
    getStockParamsList();
	
}
var billParams = {};
var stockParamsUrl = apiPath + sysApi + "/com.hsapi.system.config.paramSet.queryStockParams.biz.ext";
function getStockParamsList(){
    var params = {isDisabled:0};
    nui.ajax({
		url : stockParamsUrl,
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
var saveUrl = apiPath + sysApi + "/com.hsapi.system.config.paramSet.saveStockParams.biz.ext";
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

function aa(){
	alert("11");
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