var complainFrom = null;
$(document).ready(function(){
	complainFrom = new nui.Form("#complainFrom");
	nui.get("ok").disable();
});

function onOk(){
	var complain = complainFrom.getData();
	nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '正在加载...'
    });
	complain.complaintReason=nui.get("complaintReason").getValue();
	complain.complaintReamrk=nui.get("complaintReamrk").getValue();
	
	 nui.ajax({
	        url : apiPath + repairApi + "/com.hsapi.crm.telsales.crmTelsales.saveComplain.biz.ext",
	        type : "post",
	        data : {
	        	data:complain,
	        	token:token
	        },
	        success : function(data) {
	            nui.unmask();
	            data = data || {};
	            if (data.errCode == "S") {
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

function setData(data){
	nui.get("mobile").disable();
	nui.get("fullName").disable();
	nui.get("serviceCode").disable();
	nui.get("mtAdvisor").disable();
}

function carNoChange(e){
	nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '正在加载...'
    });
    nui.ajax({
        url : apiPath + repairApi + "/com.hsapi.repair.repairService.query.getRecentRepairByCar.biz.ext",
        type : "post",
        data : {
        	carNo:e,
        	token:token
        },
        success : function(result) {
            nui.unmask();
            result = result || {};
            if (result.errCode == "S") {
            	if(result.data.serviceCode==null){
            		nui.alert("此车牌无记录","提示");
            		nui.get("ok").disable();
	            	nui.get("serviceCode").setValue("");
	            	nui.get("mtAdvisor").setValue("");
	            	nui.get("mobile").setValue("");
	            	nui.get("fullName").setValue("");
            		return;
            	}else{
            		nui.get("ok").enable();
	            	nui.get("serviceCode").setValue(result.data.serviceCode);
	            	nui.get("mtAdvisor").setValue(result.data.mtAdvisor);
            	    nui.ajax({
            	        url : apiPath + repairApi + "/com.hsapi.repair.repairService.svr.getGuestById.biz.ext",
            	        type : "post",
            	        data : {
            	        	id:result.data.guestId,
            	        	token:token
            	        },
            	        success : function(data) {
            	            nui.unmask();
            	            data = data || {};
            	            if (data.errCode == "S") {
            	            	nui.get("mobile").setValue(data.guest.mobile);
            	            	nui.get("fullName").setValue(data.guest.fullName);


            	            } else {
            					nui.alert(data.errMsg || "信息获取失败!");
            	            }
            	        },
            	        error : function(jqXHR, textStatus, errorThrown) {
            	        	nui.unmask();
            	            console.log(jqXHR.responseText);
            	        }
            	    });
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

function CloseWindow(action) {
	if (action == "close") {

	} else if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else
		return window.close();
}