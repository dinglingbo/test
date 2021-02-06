/**
 * Created by Administrator on 2018/1/24.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var basicInfoForm = null;
$(document).ready(function(v)
{
    basicInfoForm = new nui.Form("#basicInfoForm");
    nui.get('code').focus();
   
});
function setInitData(data)
{ 
    if(!basicInfoForm)
    {
        basicInfoForm = new nui.Form("#basicInfoForm")
    }
    data = data||{};
    var brand = data.brand;
    basicInfoForm.setData(brand);
}

var requiredField = {
    code:"品牌编码",
    name:"品牌名称"
};

var saveUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.savePartBrand.biz.ext";
function onOk()
{
    var data = basicInfoForm.getData();
    
    for(var key in requiredField)
    {
        if(!data[key] || data[key].trim().length==0)
        {
            parent.showMsg(requiredField[key]+"不能为空","W");
            return;
        }
    }
    data.name = data.name.toLocaleUpperCase();
    nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '保存中...'
    });
    nui.ajax({
        url:saveUrl,
        type:"post",
        data:JSON.stringify({
            brand:data,
            token:token
        }),
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                parent.showMsg("保存成功","S");
                CloseWindow("ok");
            }
            else{
                parent.showMsg(data.errMsg||"保存失败","E");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
        	nui.unmask();
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