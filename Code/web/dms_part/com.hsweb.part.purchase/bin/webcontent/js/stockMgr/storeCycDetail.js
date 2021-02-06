/**
 * Created by Administrator on 2018/3/7.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var basicInfoForm = null;
$(document).ready(function(v)
{
    //console.log("xxx");
	basicInfoForm = new nui.Form("#basicInfoForm");



    var daySellValume = nui.get("daySellValume");
    daySellValume.on("valuechanged",calculateStoreLimit);
    var safeCyc = nui.get("safeCyc");
    safeCyc.on("valuechanged",calculateStoreLimit);
    var orderCyc = nui.get("orderCyc");
    orderCyc.on("valuechanged",calculateStoreLimit);
    var arriveCyc = nui.get("arriveCyc");
    arriveCyc.on("valuechanged",calculateStoreLimit);
});

function setData(data)
{
    if(data.storehouseList)
    {
        var storehouseList = data.storehouseList;
        nui.get("storeId").setData(storehouseList);
    }
    if(data.storeCyc)
    {
        basicInfoForm.setData(data.storeCyc);
    }
}
function calculateStoreLimit()
{
    var daySellValume = nui.get("daySellValume").getValue();
    var safeCyc = nui.get("safeCyc").getValue();
    var orderCyc = nui.get("orderCyc").getValue();
    var arriveCyc = nui.get("arriveCyc").getValue();

    var stockUpLimit = daySellValume * (safeCyc+orderCyc+arriveCyc);
    var stockUpLimitEl = nui.get("stockUpLimit");
    stockUpLimitEl.setValue(stockUpLimit);
    var stockDownLimit = daySellValume * (safeCyc+orderCyc);
    var stockDownLimitEl = nui.get("stockDownLimit");
    stockDownLimitEl.setValue(stockDownLimit);
}
function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}
var saveUrl = baseUrl + "com.hsapi.part.purchase.crud.saveCycStore.biz.ext";
function onOk()
{
    var data = basicInfoForm.getData();
    nui.mask({
        html:'保存中...'
    });
    nui.ajax({
        url:saveUrl,
        type:"post",
        data:JSON.stringify({
            storeCyc:data,
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