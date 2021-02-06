var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var dataform1 = null;
var requiredField = {
};

$(document).ready(function () {
    dataform1 = new nui.Form("#dataform1");
    nui.get('carFactoryName').focus();
    document.onkeyup = function(event) {
        var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下
        

        if ((keyCode == 27)) { // ESC
            CloseWindow('cancle');
        }

    }
});
function setData(data) {
    if (!dataform1) {
        dataform1 = new nui.Form("#dataform1");
    }
    data = data || {};
    if( data.model)
    {
        var model = data.model;
        dataform1.setData(model);
    }
}
var saveUrl = baseUrl+"com.hsapi.repair.baseData.brand.saveModel.biz.ext";
function saveData() {
    var data = dataform1.getData();
    console.log(data);
    for (var key in requiredField) {
        if (!data[key] || data[key].trim().length == 0) {
            nui.alert(requiredField[key] + "不能为空");
            return;
        }
    }
    nui.mask({
        html: '保存中..'
    });
    doPost({
        url:saveUrl,
        data:{
            model:data
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
function onOk() {
    saveData();
}
function CloseWindow(action) {

    if (window.CloseOwnerWindow)
        return window.CloseOwnerWindow(action);
    else window.close();
}

function onCancel() {
    CloseWindow("cancel");
}