var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var basicInfoForm = null;

var requiredField = {
    code: "保险公司代码",
    fullName: "保险公司名称"
};

$(document).ready(function () {
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
            nui.alert(requiredField[key] + "不能为空");
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
                nui.alert("保存成功");
                CloseWindow("ok");
            }
            else{
                nui.alert(data.errMsg||"保存失败");
            }
        },
        error:function(jqXHR, textStatus, errorThrown)
        {
            console.log(jqXHR.responseText);
            nui.unmask();
            nui.alert("网络出错");
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
		
		