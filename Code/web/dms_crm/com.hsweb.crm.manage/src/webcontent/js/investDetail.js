var investForm = null;
var baseUrl = apiPath + crmApi + "/";
$(document).ready(function(){
	investForm = new nui.Form("#investForm");
	initMember("visitId",function(){});
});

function setData(data){
	if(data){
		investForm.setData(data);
	}
	nui.get("carType").disable();
	nui.get("serviceCode").disable();
}


function onCancel() {
    CloseWindow("cancel");
}

function CloseWindow(action){
    if (window.CloseOwnerWindow) 
    	return window.CloseOwnerWindow(action);
    else 
    	window.close();
}

function checkFrm(){
	investForm.validate();
    if (!investForm.isValid()){
        return false;
    }
    return true;
}

function save(){
	if(!checkFrm()){
        return false;
    }
	var data = investForm.getData();
	nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '正在加载...'
    });

    nui.ajax({
        url : baseUrl+"com.hsapi.crm.svr.svr.saveInvest.biz.ext",
        type : "post",
        data : {
        	invest:data,
        	token:token
        },
        success : function(data) {
            nui.unmask();
            data = data || {};
            if (data.errCode == "S") {
                var errMsg = data.errMsg;
                if(errMsg){
                	nui.alert(errMsg);
                }
                CloseWindow("ok");
            } else {
            	nui.alert(data.errMsg || "保存失败!");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
        	nui.unmask();
            console.log(jqXHR.responseText);
        }
    });
}

function visitChange(){
	nui.get("visitMan").setValue(nui.get("visitId").getText());
}

function carNoChange(){
	nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '正在加载...'
    });
    nui.ajax({
        url : apiPath + repairApi + "/com.hsapi.repair.repairService.query.getRecentRepairByCar.biz.ext",
        type : "post",
        data : {
        	carNo:nui.get("carNo").getValue(),
        	token:token
        },
        success : function(result) {
            nui.unmask();
            result = result || {};
            if (result.errCode == "S") {
            	if(result.data.serviceCode==null){
            		nui.alert("此车牌无记录","提示");
            		nui.get("ok").disable();
            		return;
            	}else{
                    nui.get("serviceCode").setValue(result.data.serviceCode);
                    nui.get("serviceId").setValue(result.data.id);
                    nui.get("carId").setValue(result.data.carId);
                    nui.get("guestId").setValue(result.data.guestId);
                    nui.get("ok").enable();
            	}

            } else {
				nui.alert(result.errMsg || "工单号生成失败!");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
        	nui.unmask();
            console.log(jqXHR.responseText);
        }
    });
}