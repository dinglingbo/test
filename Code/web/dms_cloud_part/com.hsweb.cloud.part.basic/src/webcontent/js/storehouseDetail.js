/**
 * Created by Administrator on 2018/1/24.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var basicInfoForm = null;
$(document).ready(function(v)
{
    basicInfoForm = new nui.Form("#basicInfoForm");
    nui.get('name').focus();
    
    document.onkeyup = function(event) {
        var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下

        if ((keyCode == 27)) { // ESC
            CloseWindow('cancle');
        }

    }
});
var requiredField = {
//    chargeMan:"仓库管理员",
    name:"仓库名称",
//    chargeTel:"管理员电话"
};
var saveUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.saveStorehouse.biz.ext";
function onOk()
{
    var data = basicInfoForm.getData();       
    console.log(data);
    for(var key in requiredField)
    {
        if(!data[key] || data[key].trim().length==0)
        {
            parent.parent.showMsg(requiredField[key]+"不能为空","W");
            return;
        }
    }
//    var reg=/^[1](3|4|5|7|8)\d{9}$/;
//    if(data.chargeTel.length!=11 ||!reg.test(data.chargeTel) ){
//    	parent.parent.showMsg("请输入正确的手机号码");
//    	return;
//    }

    basicInfoForm.validate();

    if (basicInfoForm.isValid() == false)
    {
        var errorTexts = basicInfoForm.getErrorTexts();
        parent.parent.showMsg(errorTexts,"W");
        return;
    }
 

    nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '保存中...'
    });
    nui.ajax({
        url:saveUrl,
        type:"post",
        data:JSON.stringify({
            storehouse:data,
            token:token
        }),
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                parent.parent.showMsg("保存成功","S");
                CloseWindow("ok");
            }
            else{
                parent.parent.showMsg(data.errMsg||"保存失败","W");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}

function CloseWindow(action) {
    //if (action == "close" && form.isChanged()) {
    //    if (confirm("数据被修改了，是否先保存？")) {
    //        return false;
    //    }
    //}
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}

function setData(data)
{
    data = data||{};
    if(data.storehouse)
    {
        var storehouse = data.storehouse;
        basicInfoForm.setData(storehouse);
    }
}