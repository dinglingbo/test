/**
 * Created by Administrator on 2018/2/7.
 */


var list = [];
var currentIndex = -1;
var basicInfoForm = null;
$(document).ready(function()
{
    basicInfoForm = new nui.Form("#basicInfoForm");
});
function setData(data)
{
    basicInfoForm = new nui.Form("#basicInfoForm");
    list = data.list;
    var material = data.material;
    basicInfoForm.setData(material);
}
var resultData = {};
function getData(){
    return resultData;
}
function prevItem()
{
    if(currentIndex>0)
    {
        currentIndex--;
        basicInfoForm.setData(list[currentIndex]);
    }
}
function nextItem()
{
    if(currentIndex<list.length-1)
    {
        currentIndex++;
        basicInfoForm.setData(list[currentIndex]);
    }
}
var requiredField = {
    partCode:"零件编码",
    partName:"零件名称"
};
function onOk()
{
    var material = basicInfoForm.getData();
    for(var key in requiredField)
    {
        if(!material[key] || material[key].trim().length==0)
        {
            nui.alert(requiredField[key]+"不能为空");
            return;
        }
    }
    resultData.material = material;
    if(currentIndex>=0)
    {
        var currItem = list[currentIndex];
        for(var key in material)
        {
            if(typeof material[key] != "function")
            {
                currItem[key] = material[key];
            }
        }
        resultData.material = currItem;
    }
    CloseWindow("ok");
}
function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}
