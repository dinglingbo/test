var isTrue = [ {id : 1,text : "是"}, {id : 0,text : "否"} ];
var typeList = [{id:0,name:"功能模块"},{id:1,name:"接口调用"}];
var form = null;

$(document).ready(function(v) {
	form = new nui.Form("#form1");
/*	nui.get("type").setValue(0);
	nui.get("isDisabled").setValue(0);*/
	typeChanged();
});
function typeChanged() {
	var type = nui.get("type").getValue();
	if (type == 1) {
		$("#proUrl").show();
		$("#callNeedCoin").show();
		$("#sellPrice").hide();
		$("#periodValidity").hide();
		$("#proUrlAll").show();
		$("#callNeedCoinAll").show();
		$("#sellPriceAll").hide();
		$("#periodValidityAll").hide();
		
		nui.get("sellPrice").setValue("");
		nui.get("periodValidity").setValue("");
	} else {
		$("#proUrlAll").hide();
		$("#callNeedCoinAll").hide();
		$("#sellPriceAll").show();
		$("#periodValidityAll").show();
		$("#proUrl").hide();
		$("#callNeedCoin").hide();
		$("#sellPrice").show();
		$("#periodValidity").show();
		
		nui.get("proUrl").setValue("");
		nui.get("callNeedCoin").setValue("");
	}
}

var requiredField1 = {
		name : "产品名称",
		type : "产品类型",
		sellPrice : "销售价",
		periodValidity : "有效期"
	};

var requiredField2 = {
		name : "产品名称",
		type : "产品类型",
		proUrl : "接口地址",
		callNeedCoin : "单次扣减链车币"
	};
function save() {
	var data = form.getData(true);
	var type = nui.get("type").getValue();
	if(type == 0) {
		for ( var key in requiredField1) {
			if (!data[key] || $.trim(data[key]).length == 0) {
	            showMsg(requiredField1[key] + "不能为空!","W");
				return;
			}
	    }
	}else {
		for ( var key in requiredField2) {
			if (!data[key] || $.trim(data[key]).length == 0) {
	            showMsg(requiredField2[key] + "不能为空!","W");
				return;
			}
	    }
	}
	
	var saveProductUrl = apiPath + sysApi + "/com.hsapi.system.tenant.product.saveProduct.biz.ext";
	var comSysProduct = new nui.Form("#form1").getData();
	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '保存中...'
	});
	nui.ajax({
		url : saveProductUrl,
		type : 'post',
		data : nui.encode({
			comSysProduct : comSysProduct
		}),
		cache : false,
		success : function(data) {
			if (data.errCode == "S") {
				nui.unmask(document.body);
				showMsg("保存成功！","S");
				CloseOwnerWindow('ok');
			} else {
				nui.unmask(document.body);
				showMsg("保存失败！","W");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			nui.alert(jqXHR.responseText);
		}
	});

}

function onCancel(e) {
	if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow('ok');
	else
		window.close();
}

function setData(row){
	form.setData(row);
	typeChanged();
	
	
	if(!row) {
		nui.get('type').setValue(0);
		nui.get('isDisabled').setValue(0);
	}
	
	
}