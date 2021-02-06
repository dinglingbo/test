/**
 * Created by steven on 2018/1/31.
 */
var baseUrl = apiPath + sysApi + "/";
var storeUrl = baseUrl + "com.hsapi.system.confi.paramSet.getStoreList.biz.ext";

var displayRemindTagEl = null;
var displayBusinessTagEl = null;
var displayBillTagEl = null;
var empidEl = null;

$(document).ready(function(v) {
    displayRemindTagEl = nui.get("displayRemindTag");
    displayBusinessTagEl = nui.get("displayBusinessTag");
	displayBillTagEl = nui.get("displayBillTag");
	empidEl = nui.get("empid");
    

    getMemParamsList();

});

var paramsUrl = baseUrl + "com.hsapi.system.config.paramSet.queryMemberParms.biz.ext";
function getMemParamsList(){
	var params = {userId:currUserId};
	nui.ajax({
		url : paramsUrl,
        type : "post",
        async:false,
		data : JSON.stringify({
			params : params,
			token: token
		}),
		success : function(data) {
			nui.unmask(document.body);
			data = data || {};
			var mem = data.mem;
			if (mem && mem.length>0) {
                var memObj = mem[0];
				var displayRemindTag = memObj.displayRemindTag;
				var displayBusinessTag = memObj.displayBusinessTag;
				var displayBillTag = memObj.displayBillTag;

				displayRemindTagEl.setValue(displayRemindTag);
				displayBusinessTagEl.setValue(displayBusinessTag);
				displayBillTagEl.setValue(displayBillTag);
				empidEl.setValue(memObj.empid);

                
			} else{
				showMsg("信息读取失败!","W");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}
var saveUrl = apiPath + sysApi + "/com.hsapi.system.config.paramSet.saveMemberParams.biz.ext";
function save(){

	var empid = empidEl.getValue();
	var emp = {};
	emp.displayRemindTag = displayRemindTagEl.getValue();
	emp.displayBusinessTag = displayBusinessTagEl.getValue();
	emp.displayBillTag = displayBillTagEl.getValue();

    nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '保存中...'
	});

	nui.ajax({
		url : saveUrl,
		type : "post",
		data : {
			emp: emp,
			empid: empid,
			token: token
		},
		success : function(data) {
			nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
				showMsg("保存成功!","S");
				
			} else {
				showMsg(data.errMsg || "保存失败!","E");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
            nui.unmask(document.body);
			console.log(jqXHR.responseText);
		}
	});
}
