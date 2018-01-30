/**
 * Created by Administrator on 2018/1/24.
 */

var basicInfoForm = null;
function init()
{
    basicInfoForm = new nui.Form("#basicInfoForm");
}

function setData(data)
{
    init();
    console.log(data);
    data = data||{};
    var part = data.part;
    if(part)
    {
        basicInfoForm.setData(part);
    }
}
var resultData = {};
var callback = null;
function getData(){
    return resultData;
}

var requiredField = {
    enterQty:"数量",
    noTaxUnitPrice:"单价"
};
function onOk()
{
    var data = basicInfoForm.getData();
    console.log(data);
    //return;
    for(var key in requiredField)
    {
        if(!data[key] || data[key].toString().trim().length==0)
        {
            nui.alert(requiredField[key]+"不能为空");
            return;
        }
    }
    resultData.enterDetail = data;
    CloseWindow("ok");
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
