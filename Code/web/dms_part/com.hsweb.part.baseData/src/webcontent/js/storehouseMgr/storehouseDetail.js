/**
 * Created by Administrator on 2018/1/24.
 */
var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var basicInfoForm = null;
$(document).ready(function(v)
{
    basicInfoForm = new nui.Form("#basicInfoForm")
});
var requiredField = {
    adminName:"仓库管理员",
    name:"仓库名称",
    adminPhone:"管理员电话",
    level:"仓库级别"
};
var saveUrl = baseUrl + "com.hsapi.part.baseDataCrud.crud.saveStorehouse.biz.ext";
function onOk()
{
    var data = basicInfoForm.getData();
    console.log(data);
    for(var key in requiredField)
    {
        if(!data[key] || data[key].trim().length==0)
        {
            nui.alert(requiredField[key]+"不能为空");
            return;
        }
    }
    basicInfoForm.validate();
    if (basicInfoForm.isValid() == false)
    {
        var errorTexts = basicInfoForm.getErrorTexts();
        nui.alert(errorTexts);
        return;
    }
    nui.mask({
        html:'保存中...'
    });
    nui.ajax({
        url:saveUrl,
        type:"post",
        data:JSON.stringify({
            storehouse:data
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
    if(data.storehouseList)
    {
        var storehouseList = data.storehouseList;
        nui.get("parentId").setData(storehouseList);
    }
}