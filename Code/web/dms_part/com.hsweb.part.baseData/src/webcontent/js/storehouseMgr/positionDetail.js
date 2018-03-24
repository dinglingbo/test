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
	startIndex:"仓位流水起始号"
};
var saveUrl = baseUrl+"com.hsapi.part.baseDataCrud.crud.addStorehouseLocations.biz.ext";
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
    var start = parseInt(data.startIndex);
    var end = parseInt(data.endIndex);
    var storeLocations = [];
    for(var i=start;i<=end;i++)
    {
        storeLocations.push({
            storeId:data.storeId,
            firstChar:data.firstChar,
            numId:i,
            name:data.firstChar+"-"+i,
            isDisabled:0
        });
    }
    console.log(storeLocations);
    //return;
    nui.mask({
        html:'保存中...'
    });
    nui.ajax({
        url:saveUrl,
        type:"post",
        data:JSON.stringify({
            storeLocations:storeLocations,
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

function onStartIndexChanged()
{
    var value = nui.get("firstChar").getValue()+ "-" + nui.get("startIndex").getValue();
    nui.get("startName").setValue(value);
    console.log(value);
}
function onEndIndexChanged(){
    var value = nui.get("firstChar").getValue()+ "-" + nui.get("endIndex").getValue();
    nui.get("endName").setValue(value);
}
function onFirstCharChanged(){
    var value = "";
    if(nui.get("startIndex").getValue())
    {
        value = nui.get("firstChar").getValue()+ "-" + nui.get("startIndex").getValue();
        nui.get("startName").setValue(value);
    }
    if(nui.get("endIndex").getValue())
    {
        value = nui.get("firstChar").getValue()+ "-" + nui.get("endIndex").getValue();
        nui.get("endName").setValue(value);
    }

}

function setData(data)
{
    if(data.storehouseList)
    {
        var storehouseList = data.storehouseList;
        nui.get("storeId").setData(storehouseList);
    }
    if(data.storehouse)
    {
        basicInfoForm.setData({
            storeId:data.storehouse.id
        });
    }
}