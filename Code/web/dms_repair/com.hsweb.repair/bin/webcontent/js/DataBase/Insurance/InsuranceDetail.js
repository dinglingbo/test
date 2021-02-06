var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var basicInfoForm = null;

var requiredField = {
    code: "保险公司代码",
    fullName: "保险公司名称"
};

$(document).ready(function () {
	$('input[type=radio][name=deductType1]').change(function() {
        if (this.value == '1') {
        	document.getElementById("vala").innerText = "元";
        }else{
        	document.getElementById("vala").innerText = "%";
        }
    });
	
	$('input[type=radio][name=deductType2]').change(function() {
        if (this.value == '1') {
        	document.getElementById("valb").innerText = "元";
        }else{
        	document.getElementById("valb").innerText = "%";
        }
    });
	
	$('input[type=radio][name=deductType3]').change(function() {
        if (this.value == '1') {
        	document.getElementById("valc").innerText = "元";
        }else{
        	document.getElementById("valc").innerText = "%";
        }
    });
	nui.get('code').focus();
    document.onkeyup = function(event) {
        var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下
        

        if ((keyCode == 27)) { // ESC
            CloseWindow('cancle');
        }

    }
});
function init()
{
    basicInfoForm = new nui.Form("#basicInfoForm");
}
function setData(data)
{
    init();
    data = data || {};
    if(data.comguest)
    {
        var comguest = data.comguest;
        basicInfoForm.setData(comguest);
        var deductType1 = document.getElementsByName('deductType1');
        var deductType2 = document.getElementsByName('deductType2');
        var deductType3 = document.getElementsByName('deductType3');
        for (var i = 0,l = deductType1.length; i < l ;i++) {
            if (deductType1[i].value == comguest.deductType1) {
            	deductType1[i].checked = true;
            	if(comguest.deductType1 == 1){
            		document.getElementById("vala").innerText = "元";
            	}else{
            		document.getElementById("vala").innerText = "%";
            	}
            }
        }
        for (var i = 0, l = deductType2.length; i < l; i++) {
        	if (deductType2[i].value == comguest.deductType2) {
        		deductType2[i].checked = true;
        		if(comguest.deductType2 == 1){
            		document.getElementById("valb").innerText = "元";
            	}else{
            		document.getElementById("valb").innerText = "%";
            	}
            }
        }
        for (var i = 0, l = deductType3.length; i < l; i++) {
        	if (deductType3[i].value == comguest.deductType3) {
        		deductType3[i].checked = true;
        		if(comguest.deductType3 == 1){
            		document.getElementById("valc").innerText = "元";
            	}else{
            		document.getElementById("valc").innerText = "%";
            	}
            }
        }
    }
}
var saveUrl = baseUrl + "com.hsapi.repair.baseData.insurance.saveInsurance.biz.ext";
function onOk() {
    var data = basicInfoForm.getData();
    var deductType1 = document.getElementsByName('deductType1');
    var deductType2 = document.getElementsByName('deductType2');
    var deductType3 = document.getElementsByName('deductType3');
    for (var i = 0,l = deductType1.length; i < l ;i++) {
        if (deductType1[i].checked == true) {
            data.deductType1 = deductType1[i].value;
        }
    }
    for (var i = 0, l = deductType2.length; i < l; i++) {
        if (deductType2[i].checked == true) {
            data.deductType2 = deductType2[i].value;
        }
    }
    for (var i = 0, l = deductType3.length; i < l; i++) {
        if (deductType3[i].checked == true) {
            data.deductType3 = deductType3[i].value;
        }
    }
    console.log(data);
    for (var key in requiredField) {
        if (!data[key] || data[key].trim().length == 0) {
            parent.showMsg(requiredField[key] + "不能为空","W");
            return;
        }
    }
    nui.mask({
        html: '保存中...'
    });
    doPost({
        url:saveUrl,
        data:{
            comguest:data,
            rpbGuestAgentExtend : data
        },
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                parent.showMsg("保存成功", "S");
                CloseWindow("ok");
            }
            else{
                parent.showMsg(data.errMsg || "保存失败", "W");
            }
        },
        error:function(jqXHR, textStatus, errorThrown)
        {
            console.log(jqXHR.responseText);
            nui.unmask();
            parent.showMsg("网络出错", "W");
        }
    });
}

function CloseWindow(action) {
    if (window.CloseOwnerWindow)
        return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel() {
    CloseWindow("cancel");
}
function valid(e){
	var contactorTel=document.getElementsByName('contactorTel')[0].value;
	var reg=/1[3,4,5,6,8,9]\d{9}$/;
	if(!reg.test(contactorTel)){
		e.errorText="请输入正确的手机号";
		e.isValid=false;
	}
}
		