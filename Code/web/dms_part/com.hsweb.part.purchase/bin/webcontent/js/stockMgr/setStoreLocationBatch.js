/**
 * Created by Administrator on 2018/3/7.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var basicInfoForm = null;
$(document).ready(function(v)
{
    //console.log("xxx");
    basicInfoForm = new nui.Form("#basicInfoForm");

});

function setData(data)
{
    if(data.storehouseList)
    {
        var storehouseList = data.storehouseList;
        nui.get("storeId").setData(storehouseList);
    }
}
function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}
var saveUrl = baseUrl + "com.hsapi.part.purchase.crud.setStoreLocationBatch.biz.ext";
function onOk()
{
    var data = basicInfoForm.getData();
    if(!data.partCodeList)
    {
        nui.alert("配件编码不能为空");
        return;
    }
    if(!data.storeLocation)
    {
        nui.alert("仓位不能为空");
        return;
    }
    var tmpList = data.partCodeList.split("\n");
    data.partCodeList = tmpList;
    data.token = token;
    nui.mask({
        html:'保存中...'
    });
    nui.ajax({
        url:saveUrl,
        type:"post",
        data:JSON.stringify(data),
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