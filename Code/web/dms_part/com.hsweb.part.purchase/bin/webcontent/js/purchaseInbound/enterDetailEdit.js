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
    if(data.storeId)
    {
        nui.mask({
            html:'数据加载中...'
        });
        var storeId = data.storeId;
        getLocationListByStoreId(storeId,function(data)
        {
            nui.unmask();
            var locationList = data.locationList;
            var storeLocationId = nui.get("storeLocationId");
            storeLocationId.setData(locationList);
        });

    }
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
    unitPrice:"单价"
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
    data.storeLocation = nui.get("storeLocationId").getText();
    resultData.enterDetail = data;
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
