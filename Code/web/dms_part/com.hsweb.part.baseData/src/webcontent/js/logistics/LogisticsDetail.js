var baseUrl = apiPath + partApi + "/";
var basicInfoForm = null;

var requiredField = {
    code: "物流公司代码",
    fullName: "物流公司名称"
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
var saveUrl = baseUrl + "com.hsapi.part.baseDataCrud.crud.saveSupplier.biz.ext";
function onOk() {
    var data = basicInfoForm.getData();

    for (var key in requiredField) {
        if (!data[key] || data[key].trim().length == 0) {
            nui.alert(requiredField[key] + "不能为空");
            return;
        }
    }
    data.isSupplier = 1;
    data.guestType = "01020204";
    nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '保存中...'
    });
    nui.ajax({
        url:saveUrl,
        type:"post",
        data:JSON.stringify({
            supplier:data,
            token:token
        }),
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
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
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
		
		